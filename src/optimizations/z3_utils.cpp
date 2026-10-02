#include <fstream>
#include <filesystem>
#include <nodes.h>
#include <any>
#include <shortcuts.h>
#include <variant>
#include <unordered_set>
#include <log.h>
#include <boost/range/algorithm/set_algorithm.hpp>
#include <project.h>
#include <algorithm>
#include <boost/functional/hash.hpp>
#include <nodes.h>
#include <values.h>
#include <z3_rules.h>
#include <utils.h>
#include <rules.h>
#include <chrono>
#include <bit>
#include "z3_pcache.hpp"
#include <profile.h>
#include <cmd.h>
#include <symbolic.h>

#include <parser.h>
#include <type_inference.h>

#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <signal.h>
#include <thread>
#include <cstdlib>


namespace autov
{

using autov::Bool;
using autov::BoolConst;
using autov::Expr;
using autov::Function;
using autov::Int;
using autov::IntConst;
using autov::SpecType;
using autov::StringConst;
using autov::Struct;

using std::set;
using std::sort;

z3::solver Z3Solver = z3::solver(z3ctx);
z3::params Z3Params = z3::params(z3ctx);


// #define Z3_PCACHE
#ifdef Z3_PCACHE
SMTHashMapCache pcache("smt_cache.txt");
inline z3::check_result cache_to_check_result(int l) {
    if (l == 1) return z3::sat;
    else if (l == 0) return z3::unsat;
    return z3::unknown;
}
z3::check_result z3_pcache_check() {
    auto stmt = Z3Solver.to_smt2();
    auto p = pcache.get(stmt);
    if(p.first != -1) return cache_to_check_result(p.first);
    auto res = Z3Solver.check();
    pcache.put(stmt, res);
    return res;
}

z3::check_result z3_pcache_check(z3::expr_vector const &assumptions) {
    auto stmt = Z3Solver.to_smt2();
    unsigned n = assumptions.size();
    for (unsigned i = 0; i < n; i++) {
        stmt = stmt + "[" + assumptions[i].to_string() + "]";
    }
    auto p = pcache.get(stmt);
    if(p.first != -1) return cache_to_check_result(p.first);
    auto res = Z3Solver.check(assumptions);
    pcache.put(stmt, res);
    return res;
}
#endif

Z3ResultCache Z3Cache;

Z3ResultCache::Query Z3ResultCache::query(Kind kind, const EvalState &state, const z3::expr *goal, int timeout) {
    Query q;
    // Sorted within each group, which asserts its formulas as a set; the
    // groups are separated, since a formula means one thing as a condition
    // and another as an induction.
    auto const add_group = [&](const vector<z3::expr> &group) {
        auto const first = q.ids.size();
        for (auto const &e : group) {
            q.ids.push_back(e.id());
            q.formulas.push_back(e);
        }
        std::sort(q.ids.begin() + first, q.ids.end());
        q.ids.push_back(UINT_MAX);
    };
    add_group(*state.conds);
    if (auto const prover = dynamic_cast<const ProveState *>(&state)) add_group(*prover->inductions);
    if (goal) {
        q.ids.push_back(goal->id());
        q.formulas.push_back(*goal);
    }
    q.ids.push_back(UINT_MAX);
    q.ids.push_back(static_cast<unsigned>(timeout));
    q.ids.push_back(static_cast<unsigned>(kind));
    return q;
}

std::optional<Z3Result> Z3ResultCache::find(const Query &q) const {
    auto const it = entries.find(q.ids);
    if (it == entries.end()) return std::nullopt;
    return it->second.first;
}

unsigned long z3_unknowns = 0;
unsigned long z3_retries = 0, z3_retries_decided = 0;
unsigned long z3_checks = 0;
unsigned long z3_cache_hits = 0;
unsigned long z3_state_cache_hits = 0;
unsigned long z3_race_solves = 0;
unsigned long z3_state_sat[3] = {0, 0, 0};  // unsat, sat, unknown
std::chrono::duration<double> z3_accumulative_time = std::chrono::duration<double>::zero();

/// Per-check timeout multiplied by SPOQ_Z3_TIMEOUT_SCALE.  The default is 3
/// under bitvector sorts, whose checks cost several times their integer
/// counterparts, and 1 otherwise.
static int scaled_timeout(int timeout) {
    static const double scale = std::getenv("SPOQ_Z3_TIMEOUT_SCALE") ? std::atof(std::getenv("SPOQ_Z3_TIMEOUT_SCALE"))
                                : z3_bv_sorts_enabled()                ? 3.0
                                                                       : 1.0;
    return static_cast<int>(timeout * scale);
}

z3::check_result z3_solver_answer(const std::string &out) {
    auto const end = out.find_last_not_of(" \t\r\n");
    if (end == std::string::npos) return z3::unknown;
    auto const begin = out.find_last_of('\n', end) == std::string::npos ? 0 : out.find_last_of('\n', end) + 1;
    auto const line = out.substr(begin, end + 1 - begin);
    if (line == "unsat") return z3::unsat;
    if (line == "sat") return z3::sat;
    return z3::unknown;
}

/// Whether an in-process check that returns unknown is retried with the retry
/// tactic.  On by default with integer sorts, where it was measured; off with
/// bitvector sorts, whose solver is already the qfaufbv tactic.
/// SPOQ_Z3_RETRY=0 or 1 overrides.
static bool retry_enabled() {
    static const bool on = [] {
        if (const char *e = std::getenv("SPOQ_Z3_RETRY")) return std::string(e) != "0";
        return !z3_bv_sorts_enabled();
    }();
    return on;
}

/// Preprocessing that eliminates the equalities binding spoq's expanded terms,
/// then the SMT core without relevancy propagation.  On the 8,834 queries of
/// an openjpeg run, at 500 ms, it decides 226 that the default strategy does
/// not and loses 33 that it does, so it runs after the default returns unknown,
/// or beside it under --race.
static const char *const retry_tactic_text =
    "(then simplify propagate-values solve-eqs elim-uncnstr (using-params smt :relevancy 0))";

/** Race Z3 processes on one query file and take the first definite answer:
 *  the default strategy; the legacy arithmetic solver (smt.arith.solver=2),
 *  which decides nonlinear integer queries on which the default solver reports
 *  incomplete (theory arithmetic) -- on png001, 29 of 30 sampled such queries
 *  within 30 s, 27 of them within 0.12 s; under bitvector sorts the qfaufbv
 *  tactic, which decides unsat checks over uninterpreted functions with
 *  bitvector arguments that the default strategy times out on; and the retry
 *  tactic when a retry file is given.
 *
 * Out of process on purpose: a child that blows through its -t: budget can still
 * be killed from here, which an in-process solver.check() on this thread cannot.
 * Now it works well on z3 4.13.4 and 4.12.5.
 */
static z3::check_result z3_race_file(const std::string &file, int timeout_ms,
                                     const std::string &retry_file = "") {
    std::string const z3_cli = "z3";
    std::string const z3_timeout = "-t:" + std::to_string(timeout_ms);
    std::vector<std::string> cmds = {
        z3_cli + " " + z3_timeout + " " + file,
        z3_cli + " " + z3_timeout + " smt.arith.solver=2 " + file
    };
    if (z3_bv_sorts_enabled())
        cmds.push_back(z3_cli + " " + z3_timeout + " tactic.default_tactic=qfaufbv " + file);
    if (!retry_file.empty())
        cmds.push_back(z3_cli + " " + z3_timeout + " " + retry_file);
    size_t const n = cmds.size();

    std::vector<pid_t> pids(n);
    std::vector<std::array<int,2>> pipes(n);
    for (size_t i = 0; i < n; ++i) {
        if (pipe(pipes[i].data()) == -1) {
            perror("pipe");
            for (size_t j = 0; j < i; ++j) {
                kill(pids[j], SIGKILL);
                waitpid(pids[j], nullptr, 0);
                close(pipes[j][0]);
            }
            return z3::unknown;
        }
        if ((pids[i] = fork()) == 0) {
            // child: redirect stdout+stderr -> pipe
            close(pipes[i][0]);
            dup2(pipes[i][1], STDOUT_FILENO);
            dup2(pipes[i][1], STDERR_FILENO);
            close(pipes[i][1]);
            execlp("sh", "sh", "-c", cmds[i].c_str(), (char*)nullptr);
            _exit(EXIT_FAILURE);
        }
        close(pipes[i][1]);
    }

    std::vector<std::string> outputs(n);
    std::vector<bool> done(n, false);
    size_t finished = 0;

    // Kill and reap every child still running.
    auto const stop_rest = [&]() {
        for (size_t i = 0; i < n; ++i) {
            if (done[i]) continue;
            kill(pids[i], SIGKILL);
            waitpid(pids[i], nullptr, 0);
            close(pipes[i][0]);
        }
    };

    auto const start     = std::chrono::steady_clock::now();
    auto const wall_limit = std::chrono::seconds(130);

    // main poll loop
    while (finished < n) {
        for (size_t i = 0; i < n; ++i) {
            if (done[i]) continue;

            int status = 0;
            pid_t const r = waitpid(pids[i], &status, WNOHANG);
            if (r == 0) {
                // still running
            } else if (r < 0) {
                // error or child gone
                done[i] = true;
                ++finished;
                close(pipes[i][0]);
            } else {
                // child i exited -> read its output
                done[i] = true;
                ++finished;
                char buf[256];
                while (true) {
                    ssize_t const len = read(pipes[i][0], buf, sizeof(buf));
                    if (len <= 0) break;
                    outputs[i].append(buf, len);
                }
                close(pipes[i][0]);

                // shortcut on "unsat"
                if (z3_solver_answer(outputs[i]) == z3::unsat) {
                    stop_rest();
                    return z3::unsat;
                }
            }
        }

        if (finished < n &&
            std::chrono::steady_clock::now() - start > wall_limit) {
            stop_rest();
            return z3::unknown;
        }
        std::this_thread::sleep_for(std::chrono::milliseconds(20));
    }

    // final decision: any unsat, else any sat.
    for (auto  const&out : outputs) {
        if (z3_solver_answer(out) == z3::unsat)
            return z3::unsat;
    }
    for (auto  const&out : outputs) {
        if (z3_solver_answer(out) == z3::sat)
            return z3::sat;
    }

    return z3::unknown;
}

/** Solve one query out of process, racing Z3 processes.  The query text must
 *  already end in a check-sat form; it is written to a scratch file because the
 *  children take a path, not a string. */
static z3::check_result z3_race_solve(const std::string &query, int timeout_ms) {
    z3_race_solves++;
    auto const file = std::filesystem::temp_directory_path() /
                ("spoq-race-" + std::to_string(::getpid()) + ".smt2");
    { std::ofstream ofs(file); ofs << query; }
    // The same query under the retry tactic, raced alongside.  Neither
    // strategy decides every query the other does, and racing costs CPU rather
    // than wall time, so it runs in both sort modes.
    std::filesystem::path retry_file;
    auto const at = query.rfind("(check-sat)");
    if (at != std::string::npos) {
        retry_file = std::filesystem::temp_directory_path() /
                     ("spoq-race-" + std::to_string(::getpid()) + ".retry.smt2");
        std::ofstream ofs(retry_file);
        ofs << query.substr(0, at) << "(check-sat-using " << retry_tactic_text << ")"
            << query.substr(at + std::string("(check-sat)").size());
    }
    auto const result = z3_race_file(file.string(), timeout_ms, retry_file.string());
    std::error_code ec;
    std::filesystem::remove(file, ec);
    if (!retry_file.empty()) std::filesystem::remove(retry_file, ec);
    return result;
}

/** Ask whether [query], which asserts !cond, is unsat, out of process. */
static Z3Result z3_race_check(const std::string &query, bool count_unknown) {
    switch (z3_race_solve(query, scaled_timeout(OPTS.race_timeout))) {
        case z3::unsat: return Z3Result::True;
        case z3::sat:   return Z3Result::Sat;
        default:
            if (count_unknown) ++z3_unknowns;
            return Z3Result::Unknown;
    }
}

/// The solver for one check.  Under bitvector sorts it is the `qfaufbv`
/// tactic: its preprocessing -- ite elimination, ackermannization,
/// bit-blasting -- decides a matched callee body in milliseconds where the
/// default strategy times out.  SPOQ_Z3_TACTIC names another tactic, a
/// comma-separated list of tactics applied in sequence, or "default" for the
/// plain solver.
static z3::tactic make_tactic(const std::string &names) {
    std::optional<z3::tactic> t;
    std::istringstream in(names);
    for (std::string name; std::getline(in, name, ',');) {
        z3::tactic const next(z3ctx, name.c_str());
        t = t ? *t & next : next;
    }
    if (!t) throw std::runtime_error("SPOQ_Z3_TACTIC names no tactic");
    return *t;
}

static z3::solver make_solver() {
    // SPOQ_Z3_PARAMS: space-separated key=value pairs set as global Z3 parameters.
    static const bool params_set = [] {
        if (const char *e = std::getenv("SPOQ_Z3_PARAMS")) {
            std::istringstream in(e);
            for (std::string kv; in >> kv;) {
                auto const eq = kv.find('=');
                if (eq != std::string::npos) z3::set_param(kv.substr(0, eq).c_str(), kv.substr(eq + 1).c_str());
            }
        }
        return true;
    }();
    (void)params_set;
    static const char *chosen = std::getenv("SPOQ_Z3_TACTIC");
    static const std::string tactic = chosen && *chosen ? chosen : z3_bv_sorts_enabled() ? "qfaufbv" : "default";
    if (tactic != "default") return make_tactic(tactic).mk_solver();
    return z3::solver(z3ctx);
}

static z3::solver make_retry_solver() {
    z3::params p(z3ctx);
    p.set("relevancy", 0u);
    auto const t = make_tactic("simplify,propagate-values,solve-eqs,elim-uncnstr") &
                   z3::with(z3::tactic(z3ctx, "smt"), p);
    return t.mk_solver();
}

/// [solver]'s answer under [assumptions]; if it is unknown, the retry tactic's
/// answer on the same assertions with the assumptions asserted.  [model], if
/// given, receives the model of whichever solver answered sat.
static z3::check_result check_retrying(z3::solver &solver, const z3::expr_vector &assumptions,
                                       z3::model *model = nullptr) {
    auto const res = assumptions.empty() ? solver.check() : solver.check(assumptions);
    if (res == z3::sat && model) *model = solver.get_model();
    if (res != z3::unknown || !retry_enabled()) return res;
    ++z3_retries;
    z3::solver retry = make_retry_solver();
    retry.set(Z3Params);
    for (auto const c : solver.assertions()) retry.add(c);
    for (auto const a : assumptions) retry.add(a);
    auto const again = retry.check();
    if (again != z3::unknown) ++z3_retries_decided;
    if (again == z3::sat && model) *model = retry.get_model();
    return again;
}

static z3::check_result check_retrying(z3::solver &solver, z3::model *model = nullptr) {
    return check_retrying(solver, z3::expr_vector(z3ctx), model);
}


/* -- int_to_ptr on the global address range ----------------------------------
 *
 * extractpointers lays the modelled globals out from MIN to MAX_GLOBAL: each
 * block has a base constant, ptr_to_int maps a pointer into block n at offset
 * k to BASE_n + k, and global_to_ptr is the inverse on that range.  int_to_ptr
 * is uninterpreted, so without this a pointer to a global stored to memory and
 * loaded back is an arbitrary pointer.  The table is read from the project's
 * global_to_ptr, whose arms are `if (v >=? BASE) then (mkPtr "name" (v - BASE))`
 * behind a first test against MAX_GLOBAL.  Values outside the range -- 0 and
 * -1 among them, which have axioms of their own -- stay uninterpreted.
 */
namespace {
struct GlobalAddressTable {
    long max = 0;
    std::vector<std::pair<long, std::string>> blocks;  // base, pbase; ascending
};

/// The value of a definition whose body is an integer literal.
std::optional<long> int_def_value(Project *proj, SpecNode *n) {
    auto const sym = dynamic_cast<Symbol *>(n);
    if (!sym) return std::nullopt;
    auto const it = proj->defs.find(sym->text);
    if (it == proj->defs.end()) return std::nullopt;
    auto const c = dynamic_cast<IntConst *>(it->second->body().get());
    if (!c) return std::nullopt;
    return (long)c->get_value();
}

const GlobalAddressTable &global_address_table(Project *proj) {
    static std::map<Project *, GlobalAddressTable> tables;
    auto const found = tables.find(proj);
    if (found != tables.end()) return found->second;
    auto &t = tables[proj];
    auto const it = proj->defs.find("global_to_ptr");
    if (it == proj->defs.end()) return t;
    for (SpecNode *n = it->second->body().get(); auto i = dynamic_cast<If *>(n); n = i->else_body.get()) {
        auto const cond = dynamic_cast<Expr *>(i->cond.get());
        auto const then = dynamic_cast<Expr *>(i->then_body.get());
        if (!cond || !then || cond->elems->size() != 2 || !op_eq(cond->op, Expr::binops::BGE)) continue;
        auto const bound = int_def_value(proj, cond->elems->at(1).get());
        auto const name = then->elems->empty() ? nullptr : dynamic_cast<StringConst *>(then->elems->at(0).get());
        if (!bound || !name) continue;
        auto const pbase = std::get<string>(name->value);
        if (pbase == "null") t.max = *bound;
        else t.blocks.emplace_back(*bound, pbase);
    }
    std::sort(t.blocks.begin(), t.blocks.end());
    if (t.max == 0) t.blocks.clear();
    return t;
}
}  // namespace

shared_ptr<SpecValue> int_to_ptr_value(Project *proj, vector<shared_ptr<SpecValue>> &elems) {
    auto const opaque = static_pointer_cast<FuncValue>(autov::int_to_ptr())->call(elems);
    if (!proj || elems.size() != 1) return opaque;
    auto const &table = global_address_table(proj);
    if (table.blocks.empty()) return opaque;
    // In int_to_ptr's own domain, as the opaque call converts it: under
    // bitvector sorts a Z literal becomes the bitvector it denotes.
    auto const v = coerce_to_sort(elems[0]->get_z3_value(), Int::size_t_int()->get_z3_type(), "int_to_ptr");
    if (!v.is_int() && !v.is_bv()) return opaque;
    auto const num = [&](long x) { return v.is_bv() ? z3ctx.bv_val((int64_t)x, v.get_sort().bv_size()) : z3ctx.int_val((int64_t)x); };
    auto const ge = [&](long x) { return v.is_bv() ? z3::sge(v, num(x)) : v >= num(x); };
    z3::expr chosen = opaque->get_z3_value();
    for (auto const &[base, pbase] : table.blocks) {
        vector<shared_ptr<SpecValue>> fields{make_shared<StringValue>(z3ctx.string_val(pbase)),
                                             make_shared<IntValue>(v - num(base))};
        chosen = z3::ite(ge(base), Struct::Ptr->construct(fields)->get_z3_value(), chosen);
    }
    return Struct::Ptr->from_z3_value(z3::ite(!ge(table.max), chosen, opaque->get_z3_value()));
}

/* -- stack typing ------------------------------------------------------------
 *
 * Each stack slot is present and holds the StackVal constructor of its
 * declared type.  Sound for every real execution: the frame layout is fixed by
 * the allocas, store_stack rebuilds only the constructor it finds, and callees
 * reach the stack only through store_stack.  States built by a store inherit
 * the fact from their base, so it is stated only for leaf states -- declared
 * ones and those an opaque callee returns.  The slot-to-constructor map is read
 * from load_stack, whose arm for each constructor relies on exactly the slots
 * of that type.  Off unless SPOQ_STACK_TYPING=1: on libmodbus it prunes
 * nothing, since the arms it rules out are catch-all `None` arms, which
 * simple_match_by_z3 keeps anyway.  See docs/stack_assumptions.md.
 */
static std::vector<std::pair<std::string, std::string>> g_slot_constructor;

/// String constants anywhere below [n].
static void collect_strings(SpecNode *n, std::set<std::string> &out) {
    if (!n) return;
    if (auto c = dynamic_cast<StringConst *>(n)) { out.insert(std::get<string>(c->value)); return; }
    if (auto e = dynamic_cast<Expr *>(n)) {
        for (auto const &x : *e->elems) collect_strings(x.get(), out);
    } else if (auto m = dynamic_cast<Match *>(n)) {
        collect_strings(m->src.get(), out);
        for (auto const &pm : *m->match_list) collect_strings(pm->body.get(), out);
    } else if (auto r = dynamic_cast<RelyAnno *>(n)) {
        collect_strings(r->prop.get(), out);
        collect_strings(r->body.get(), out);
    } else if (auto i = dynamic_cast<If *>(n)) {
        collect_strings(i->cond.get(), out);
        collect_strings(i->then_body.get(), out);
        collect_strings(i->else_body.get(), out);
    }
}

/// The constructor arms of load_stack's match on the slot's value.
static void collect_slot_types(SpecNode *n, std::map<std::string, std::set<std::string>> &slots_of) {
    if (auto m = dynamic_cast<Match *>(n)) {
        for (auto const &pm : *m->match_list) {
            auto pat = dynamic_cast<Expr *>(pm->pattern.get());
            auto ctor = pat ? std::get_if<string>(&pat->op) : nullptr;
            if (ctor && pat->elems->size() == 1) {
                std::set<std::string> names;
                collect_strings(pm->body.get(), names);
                slots_of[*ctor].insert(names.begin(), names.end());
            } else {
                collect_slot_types(pm->body.get(), slots_of);
            }
        }
    } else if (auto r = dynamic_cast<RelyAnno *>(n)) {
        collect_slot_types(r->body.get(), slots_of);
    }
}

void init_stack_typing(Project *proj) {
    static bool done = false;
    if (done) return;
    done = true;
    const char *e = std::getenv("SPOQ_STACK_TYPING");
    if (!e || std::string(e) != "1") return;
    auto const it = proj->defs.find("load_stack");
    if (it == proj->defs.end() || !it->second->body()) return;
    std::map<std::string, std::set<std::string>> slots_of;
    collect_slot_types(it->second->body().get(), slots_of);
    std::map<std::string, std::string> ctor_of;
    std::set<std::string> ambiguous;
    for (auto const &[ctor, slots] : slots_of)
        for (auto const &s : slots)
            if (!ctor_of.emplace(s, ctor).second) ambiguous.insert(s);
    for (auto const &[s, ctor] : ctor_of)
        if (!ambiguous.count(s)) g_slot_constructor.emplace_back(s, ctor);
    LOG_DEBUG << "[stack typing] " << g_slot_constructor.size() << " typed slot(s)";
}

/// The index of [s]'s constructor or accessor whose name satisfies [pred].
template <class Pred>
static int find_constructor(const z3::sort &s, Pred pred) {
    unsigned const n = Z3_get_datatype_sort_num_constructors(z3ctx, s);
    for (unsigned i = 0; i < n; i++)
        if (pred(z3::func_decl(z3ctx, Z3_get_datatype_sort_constructor(z3ctx, s, i)).name().str())) return int(i);
    return -1;
}

/// For each leaf state term in [s]'s assertions (and [goal]), asserts that
/// every typed slot of its stack is present with its declared constructor.
static void add_stack_typing_facts(z3::solver &s, const z3::expr *goal = nullptr) {
    if (g_slot_constructor.empty()) return;
    std::unordered_set<unsigned> seen, leaves_seen;
    std::vector<z3::expr> todo, leaves;
    for (auto const a : s.assertions()) todo.push_back(a);
    if (goal) todo.push_back(*goal);
    auto const is_state = [](const z3::sort &srt) {
        if (!srt.is_datatype() || Z3_get_datatype_sort_num_constructors(z3ctx, srt) != 1) return false;
        z3::func_decl const mk(z3ctx, Z3_get_datatype_sort_constructor(z3ctx, srt, 0));
        for (unsigned j = 0; j < mk.arity(); j++)
            if (z3::func_decl(z3ctx, Z3_get_datatype_sort_constructor_accessor(z3ctx, srt, 0, j)).name().str() == "stack")
                return true;
        return false;
    };
    // Slot names the query mentions: a fact about any other slot is never
    // used, and every fact enlarges the query.
    std::set<std::string> mentioned;
    while (!todo.empty()) {
        auto const t = todo.back();
        todo.pop_back();
        if (!t.is_app() || !seen.insert(t.id()).second) continue;
        if (t.is_string_value()) mentioned.insert(t.get_string());
        auto const kind = t.decl().decl_kind();
        if (is_state(t.get_sort()) && kind != Z3_OP_DT_CONSTRUCTOR && kind != Z3_OP_ITE &&
            leaves_seen.insert(t.id()).second)
            leaves.push_back(t);
        for (unsigned i = 0; i < t.num_args(); i++) todo.push_back(t.arg(i));
    }
    for (auto const &st : leaves) {
        auto const srt = st.get_sort();
        z3::func_decl const mk(z3ctx, Z3_get_datatype_sort_constructor(z3ctx, srt, 0));
        int stack_at = -1;
        for (unsigned j = 0; j < mk.arity(); j++)
            if (z3::func_decl(z3ctx, Z3_get_datatype_sort_constructor_accessor(z3ctx, srt, 0, j)).name().str() == "stack")
                stack_at = int(j);
        auto const stack = z3::func_decl(z3ctx, Z3_get_datatype_sort_constructor_accessor(z3ctx, srt, 0, stack_at))(st);
        auto const opt = stack.get_sort().array_range();
        int const some_at = find_constructor(opt, [](const std::string &n) { return n.rfind("Some", 0) == 0; });
        if (some_at < 0) continue;
        z3::func_decl const is_some(z3ctx, Z3_get_datatype_sort_recognizer(z3ctx, opt, some_at));
        z3::func_decl const value(z3ctx, Z3_get_datatype_sort_constructor_accessor(z3ctx, opt, some_at, 0));
        auto const val_sort = value.range();
        for (auto const &[slot, ctor] : g_slot_constructor) {
            if (!mentioned.count(slot)) continue;
            int const c = find_constructor(val_sort, [&](const std::string &n) { return n == ctor; });
            if (c < 0) continue;
            z3::func_decl const is_ctor(z3ctx, Z3_get_datatype_sort_recognizer(z3ctx, val_sort, c));
            auto const v = z3::select(stack, z3ctx.string_val(slot));
            s.add(is_some(v) && is_ctor(value(v)));
        }
    }
}


/// Under bitvector sorts, asserts `args(a) = args(b) -> a = b` for each pair of
/// applications of one uninterpreted function with a bitvector argument whose
/// bitvector arguments are syntactically identical, so the antecedent equates
/// only non-bitvector arguments such as program states: a callee applied to the
/// same scalars at two states.  Z3's bitvector theory reports an argument
/// equality to congruence closure only once every bit of both arguments is
/// assigned, and explains it by those bits; the lemma gives the search a
/// word-level literal to decide and learn on.  Pairs that differ in a bitvector
/// argument are left out: on lua002 they add work without a net gain.  The
/// lemmas are valid, so they do not change any verdict.  `goal` names a formula
/// checked as an assumption rather than asserted.  SPOQ_BV_CONGRUENCE=0 disables.
static void add_congruence_lemmas(z3::solver &s, const z3::expr *goal = nullptr) {
    static const bool enabled = [] {
        const char *e = std::getenv("SPOQ_BV_CONGRUENCE");
        return z3_bv_sorts_enabled() && !(e && std::string(e) == "0");
    }();
    if (!enabled) return;
    // Bounds the quadratic number of lemmas per function.
    constexpr size_t max_apps = 64;

    std::map<unsigned, std::vector<z3::expr>> apps;
    std::unordered_set<unsigned> seen;
    std::vector<z3::expr> todo;
    for (auto const a : s.assertions()) todo.push_back(a);
    if (goal) todo.push_back(*goal);
    while (!todo.empty()) {
        z3::expr const e = todo.back();
        todo.pop_back();
        // Quantifier bodies are not entered: their applications may mention bound variables.
        if (!e.is_app() || !seen.insert(e.id()).second) continue;
        for (unsigned i = 0; i < e.num_args(); ++i) todo.push_back(e.arg(i));
        z3::func_decl const f = e.decl();
        if (f.decl_kind() != Z3_OP_UNINTERPRETED || f.arity() == 0) continue;
        bool bv_arg = false;
        for (unsigned i = 0; i < f.arity(); ++i) bv_arg |= f.domain(i).is_bv();
        auto &v = apps[f.id()];
        if (bv_arg && v.size() < max_apps) v.push_back(e);
    }
    for (auto const &[_, v] : apps) {
        for (size_t i = 0; i < v.size(); ++i) {
            for (size_t j = i + 1; j < v.size(); ++j) {
                z3::expr_vector eqs(z3ctx);
                bool bv_differs = false;
                for (unsigned k = 0; k < v[i].num_args(); ++k) {
                    if (z3::eq(v[i].arg(k), v[j].arg(k))) continue;
                    bv_differs |= v[i].arg(k).is_bv();
                    eqs.push_back(v[i].arg(k) == v[j].arg(k));
                }
                if (!bv_differs) s.add(z3::implies(z3::mk_and(eqs), v[i] == v[j]));
            }
        }
    }
}

/// Ground instances of the rounding-up division facts ceil_fact and wrap_fact,
/// proved in openjpeg_queries/CeilWrap.v, for each quotient of the form
/// ((M - 1 + b + a) mod M) / (b mod M) with M a positive numeral: the
/// translation of an unsigned (a + b - 1) / b, including a = b written 2 * b.
/// With x = a mod M, y = b mod M:
///   y > 0, x + y - 1 < M   the quotient is x / y + (x mod y <> 0)
///   y > 0, x + y - 1 >= M  the numerator wrapped and the quotient is 0
/// Z3 decides relations between the two forms only with these instances; a
/// quantified form is never instantiated.  Integer sorts; SPOQ_DIV_LEMMAS=0
/// disables.
static void add_rounding_division_lemmas(z3::solver &s, const z3::expr *goal = nullptr) {
    static const bool enabled = [] {
        const char *e = std::getenv("SPOQ_DIV_LEMMAS");
        return !(e && std::string(e) == "0");
    }();
    if (!enabled) return;
    constexpr size_t max_lemmas = 64;

    auto const is_mod_by_numeral = [](const z3::expr &e) {
        return e.is_app() && e.decl().decl_kind() == Z3_OP_MOD && e.arg(1).is_numeral();
    };
    std::unordered_set<unsigned> seen;
    std::vector<z3::expr> todo;
    for (auto const a : s.assertions()) todo.push_back(a);
    if (goal) todo.push_back(*goal);
    size_t added = 0;
    while (!todo.empty() && added < max_lemmas) {
        z3::expr const e = todo.back();
        todo.pop_back();
        if (!e.is_app() || !seen.insert(e.id()).second) continue;
        for (unsigned i = 0; i < e.num_args(); ++i) todo.push_back(e.arg(i));
        if (e.decl().decl_kind() != Z3_OP_IDIV) continue;
        z3::expr const num = e.arg(0), den = e.arg(1);
        if (!is_mod_by_numeral(num) || !is_mod_by_numeral(den) || !z3::eq(num.arg(1), den.arg(1))) continue;
        z3::expr const M = num.arg(1), sum = num.arg(0), b = den.arg(0);
        if (!(M > 0).simplify().is_true()) continue;
        // The summands, through nested additions.  The simplifier writes b + b
        // as 2 * b, so a doubled term counts as two summands.
        auto const doubled = [](const z3::expr &t) -> std::optional<z3::expr> {
            if (!t.is_app() || t.decl().decl_kind() != Z3_OP_MUL || t.num_args() != 2) return std::nullopt;
            int64_t k = 0;
            for (unsigned i = 0; i < 2; ++i)
                if (t.arg(i).is_numeral_i64(k) && k == 2) return t.arg(1 - i);
            return std::nullopt;
        };
        std::vector<z3::expr> terms, open{sum};
        while (!open.empty() && terms.size() <= 3) {
            z3::expr const t = open.back();
            open.pop_back();
            if (t.is_app() && t.decl().decl_kind() == Z3_OP_ADD) {
                for (unsigned i = 0; i < t.num_args(); ++i) open.push_back(t.arg(i));
            } else if (auto const half = doubled(t)) {
                terms.push_back(*half);
                terms.push_back(*half);
            } else {
                terms.push_back(t);
            }
        }
        if (!open.empty() || terms.size() != 3) continue;
        z3::expr const m1 = (M - 1).simplify();
        // The summands other than M - 1 and b; exactly one is left, a.
        std::vector<z3::expr> rest;
        bool have_m1 = false, have_b = false;
        for (auto const &t : terms) {
            if (!have_m1 && z3::eq(t, m1)) have_m1 = true;
            else if (!have_b && z3::eq(t, b)) have_b = true;
            else rest.push_back(t);
        }
        if (!have_m1 || !have_b || rest.size() != 1) continue;
        z3::expr const x = z3::mod(rest[0], M), y = den;
        z3::expr const room = x + y - 1;
        z3::expr const carry = z3::ite(z3::mod(x, y) == 0, z3ctx.int_val(0), z3ctx.int_val(1));
        s.add(z3::implies(y > 0 && room < M, num == room && e == x / y + carry));
        s.add(z3::implies(y > 0 && room >= M, num == room - M && e == 0));
        ++added;
    }
}

/// Every lemma kind, for one check.
static void add_lemmas(z3::solver &s, const z3::expr *goal = nullptr) {
    add_congruence_lemmas(s, goal);
    add_rounding_division_lemmas(s, goal);
}

/// SPOQ_SLOW_QUERY_DIR, if set, receives every check that took at least
/// SPOQ_SLOW_QUERY_MS (default 200) as an .smt2 with its result and time.
static bool slow_query_wanted(std::chrono::duration<double> elapsed) {
    static const char *dir = std::getenv("SPOQ_SLOW_QUERY_DIR");
    static const double ms = std::getenv("SPOQ_SLOW_QUERY_MS") ? std::atof(std::getenv("SPOQ_SLOW_QUERY_MS")) : 200.0;
    return dir && elapsed.count() * 1000.0 >= ms;
}
static void dump_slow_query(std::chrono::duration<double> elapsed, const std::string &what, int timeout,
                            const std::string &query) {
    static const char *dir = std::getenv("SPOQ_SLOW_QUERY_DIR");
    static unsigned id = 0;
    std::filesystem::create_directories(dir);
    std::ofstream out(std::string(dir) + "/slow_" + std::to_string(id++) + ".smt2");
    out << "; " << elapsed.count() * 1000.0 << " ms, " << what << ", timeout " << timeout << " ms\n" << query;
}
static std::string to_string(z3::check_result r) {
    return r == z3::sat ? "sat" : r == z3::unsat ? "unsat" : "unknown";
}

/** specialized z3 checker for automated proof
 *  1. only check !cond if UNSAT (True) or not
 *  2. automatically dump queries
 *  3. use local solver, which significantly speedup path-by-path verification
  */
Z3Result z3_verify(const shared_ptr<ProveState>& state, const z3::expr& cond, QueryInfo *qinfo, int timeout) {
    auto const start = std::chrono::high_resolution_clock::now();
    z3::solver solve = make_solver();
    timeout = scaled_timeout(timeout);
    Z3Params.set("timeout", (unsigned int)timeout);
    solve.set(Z3Params);
    for (auto  const&c : *state->conds) {
        solve.add(c);
    }
    for (auto  const&ind : *state->inductions) {
        solve.add(ind);
    }

    solve.add(!cond);
    add_lemmas(solve);
    add_stack_typing_facts(solve);
    auto const not_res = check_retrying(solve);
    if (qinfo)
        qinfo->dump(solve.to_smt2());

    auto const end = std::chrono::high_resolution_clock::now();
    auto const elapsed = std::chrono::duration_cast<std::chrono::duration<double>>(end - start);
    z3_accumulative_time += elapsed;
    if (slow_query_wanted(elapsed))
        dump_slow_query(elapsed, "z3_verify not cond: " + to_string(not_res), timeout, solve.to_smt2());

    // std::cout << "-----------------Z3_verify-----------------" << std::endl;
    // std::cout << "z3 check cond: " << cond << ", hash: " << cond.hash() << std::endl;
    // for (auto &c : *state->conds) {
    //     std::cout << "z3 check state conds: " << c << std::endl;
    // }
    // std::cout << "z3 check not_res: " << not_res << std::endl;
    // std::cout << "-----------------Z3_verify-----------------" << std::endl;
    if (not_res == z3::unsat) {
        return Z3Result::True;
    } else if (not_res == z3::sat) {
        return Z3Result::False;
    } else {
        return Z3Result::Unknown;
    }
}

/**
 * z3_verify without cond:
 *  used for check the satisfiability of current symbolic path
 * Usage:
 * 1. Check None-path for drf invariant
 * 2. Check deterministic path for simulation
 * */
Z3Result z3_verify_state_sat(const shared_ptr<ProveState>& state, QueryInfo *qinfo, int timeout) {
    auto const start = std::chrono::high_resolution_clock::now();
    z3::solver solve = make_solver();

    timeout = scaled_timeout(timeout);
    Z3Params.set("timeout", (unsigned int)timeout);
    solve.set(Z3Params);

    for (auto  const&c : *state->conds) {
        solve.add(c);
    }
    for (auto  const&ind : *state->inductions) {
        solve.add(ind);
    }
    add_lemmas(solve);
    add_stack_typing_facts(solve);
    // Under --race the query goes to external Z3 processes instead of running on
    // this thread, so a solver that overruns its budget can still be killed.
    // Unlike z3_check there is no assumption here -- the state is asserted and
    // checked outright -- so the serialised query asks exactly the same question
    // and the verdict below is unchanged by which path produced it.
    std::string query;
    if (qinfo || OPTS.race) query = solve.to_smt2();
    if (qinfo) qinfo->dump(query);
    auto const res = OPTS.race ? z3_race_solve(query, timeout) : check_retrying(solve);
    auto const end = std::chrono::high_resolution_clock::now();
    z3_accumulative_time += std::chrono::duration_cast<std::chrono::duration<double>>(end - start);
    z3_state_sat[res == z3::unsat ? 0 : res == z3::sat ? 1 : 2]++;

    // std::cout << "-----------------Z3_verify_state_sat-----------------" << std::endl;
    // for (auto &c : *state->conds) {
    //     std::cout << "z3 check state conds: " << c << std::endl;
    // }
    // std::cout << "z3 check res: " << res << std::endl;
    // std::cout << "-----------------Z3_verify_state_sat-----------------" << std::endl;
    if (res == z3::sat) {
        return Z3Result::True;
    } else if (res == z3::unsat) {
        return Z3Result::False;
    } else {
        return Z3Result::Unknown;
    }
}
Z3Result z3_verify_state_sat(const shared_ptr<EvalState>& state, QueryInfo *qinfo, int timeout) {
    // Decided answers are cached; Unknown is not, so a later call can still
    // decide the state.
    auto const cache_query = Z3ResultCache::query(Z3ResultCache::Kind::VerifyState, *state, nullptr, timeout);
    if (auto const hit = Z3Cache.find(cache_query)) {
        z3_state_cache_hits++;
        return *hit;
    }
    auto const start = std::chrono::high_resolution_clock::now();
    z3::solver solve = make_solver();

    timeout = scaled_timeout(timeout);
    Z3Params.set("timeout", (unsigned int)timeout);
    solve.set(Z3Params);

    for (auto  const&c : *state->conds) {
        solve.add(c);
    }
    add_lemmas(solve);
    add_stack_typing_facts(solve);

    // Under --race the query goes to external Z3 processes instead of running on
    // this thread, so a solver that overruns its budget can still be killed.
    // Unlike z3_check there is no assumption here -- the state is asserted and
    // checked outright -- so the serialised query asks exactly the same question
    // and the verdict below is unchanged by which path produced it.
    std::string query;
    if (qinfo || OPTS.race) query = solve.to_smt2();
    if (qinfo) qinfo->dump(query);
    auto const res = OPTS.race ? z3_race_solve(query, timeout) : check_retrying(solve);
    auto const end = std::chrono::high_resolution_clock::now();
    z3_accumulative_time += std::chrono::duration_cast<std::chrono::duration<double>>(end - start);
    z3_state_sat[res == z3::unsat ? 0 : res == z3::sat ? 1 : 2]++;

    // std::cout << "-----------------Z3_verify_state_sat-----------------" << std::endl;
    // for (auto &c : *state->conds) {
    //     std::cout << "z3 check state conds: " << c << std::endl;
    // }
    // std::cout << "z3 check res: " << res << std::endl;
    // std::cout << "-----------------Z3_verify_state_sat-----------------" << std::endl;
    if (res == z3::sat) {
        Z3Cache.insert(cache_query, Z3Result::True);
        return Z3Result::True;
    } else if (res == z3::unsat) {
        Z3Cache.insert(cache_query, Z3Result::False);
        return Z3Result::False;
    } else {
        return Z3Result::Unknown;
    }
}
// Defautl value of timeout is 50
Z3Result z3_check(const shared_ptr<EvalState>& state, const z3::expr& cond, QueryInfo *qinfo, int timeout) {
    auto const start = std::chrono::high_resolution_clock::now();
    auto const cache_query = Z3ResultCache::query(Z3ResultCache::Kind::Check, *state, &cond, timeout);
    z3_checks++;
    if (auto const hit = Z3Cache.find(cache_query)) {
        z3_cache_hits++;
        return *hit;
    }

    timeout = scaled_timeout(timeout);
    Z3Params.set("timeout", (unsigned int)timeout);
    z3::solver solver = make_solver();
    solver.set(Z3Params);
    for (auto  const&c : *state->conds) {
        solver.add(c);
    }
    if (auto prover = instance_of(state.get(), ProveState)) {
        for (auto  const&ind : *prover->inductions) {
            solver.add(ind);
        }
    }
    add_lemmas(solver, &cond);
    add_stack_typing_facts(solver, &cond);
    // cond is checked as an assumption, so it is not one of the solver's asserted
    // formulas and to_smt2() would write the context without the goal.  Rebuild it
    // on a throwaway solver, recording the goal behind a marker constant so a
    // reader can reproduce the real call with check-sat-assuming -- asserting it
    // instead routes through a different Z3 engine and can behave completely
    // differently.  push()/pop() on the real solver would cause that same switch.
    // SPOQ_CURRENT_QUERY, if set, names one file every query is overwritten into,
    // so a hang leaves behind the query that caused it; most callers pass
    // qinfo = nullptr, so otherwise nothing about that query is recorded at all.
    static const char *current_query = std::getenv("SPOQ_CURRENT_QUERY");
    auto serialize = [&](const z3::expr &goal) {
        z3::solver dumper(z3ctx);
        for (auto const c : solver.assertions()) dumper.add(c);
        dumper.add(goal);
        auto query = dumper.to_smt2();
        return query;
    };
    auto record = [&](const std::string &query) {
        if (current_query)
            std::ofstream(current_query) << "; timeout=" << timeout << "ms\n" << query;
        if (qinfo) qinfo->dump(query);
    };
    // Under --race the query is solved by external Z3 processes.
    auto const check = [&](const z3::expr &goal, z3::expr_vector &assumptions) {
        if (!qinfo && !current_query && !OPTS.race) return check_retrying(solver, assumptions);
        auto const query = serialize(goal);
        record(query);
        if (!OPTS.race) return check_retrying(solver, assumptions);
        return z3_race_solve(query, timeout);
    };

#ifdef Z3_PCACHE
    // solver.push();
    solver.add(cond);
    auto res = z3_pcache_check();
    // solver.pop();
#else
    // solver.add(cond);
    z3::expr_vector cond_vec(z3ctx);
    cond_vec.push_back(cond);
    auto const res = check(cond, cond_vec);
#endif
    z3::expr_vector not_cond_vec(z3ctx);
    not_cond_vec.push_back(!cond);
#ifdef Z3_PCACHE
    auto not_res = z3_pcache_check(not_cond_vec);
#else
    auto const not_res = check(!cond, not_cond_vec);
#endif

    auto const end = std::chrono::high_resolution_clock::now();
    auto const elapsed = std::chrono::duration_cast<std::chrono::duration<double>>(end - start);
    z3_accumulative_time += elapsed;
    if (slow_query_wanted(elapsed))
        dump_slow_query(elapsed, "z3_check cond: " + to_string(res) + ", not cond: " + to_string(not_res), timeout,
                        serialize(cond));

    if (not_res == z3::unsat) {
        if (res == z3::unsat) {
            Z3Cache.insert(cache_query, Z3Result::False);
            return Z3Result::False;
        }
        return Z3Result::True;
    } else if (res == z3::unsat) {
        Z3Cache.insert(cache_query, Z3Result::False);
        return Z3Result::False;
    } else if(res == z3::sat && not_res == z3::sat){
        Z3Cache.insert(cache_query, Z3Result::Sat);
        return Z3Result::Sat;
    } else if(res == z3::unknown && not_res == z3::unknown){
        Z3Cache.insert(cache_query, Z3Result::Unknown);
        z3_unknowns++;
        return Z3Result::Unknown;
    } else if(res == z3::sat && not_res == z3::unknown){
        Z3Cache.insert(cache_query, Z3Result::Sat);
        return Z3Result::Sat;
    } else {
        return Z3Result::Unknown;
    }
}

Z3Result z3_check(const shared_ptr<EvalState>& state, int timeout) {
    auto const start = std::chrono::high_resolution_clock::now();
    auto const cache_query = Z3ResultCache::query(Z3ResultCache::Kind::CheckState, *state, nullptr, timeout);
    z3_checks++;
    if (auto const hit = Z3Cache.find(cache_query)) {
        z3_cache_hits++;
        return *hit;
    }


    timeout = scaled_timeout(timeout);
    Z3Params.set("timeout", (unsigned int)timeout);
    z3::solver solver = make_solver();
    solver.set(Z3Params);


    for (auto  const&c : *state->conds) {
        solver.add(c);
    }

    if (auto prover = instance_of(state.get(), ProveState)) {
        for (auto  const&ind : *prover->inductions) {
            solver.add(ind);
        }
    }
    add_lemmas(solver);
    add_stack_typing_facts(solver);


#ifdef Z3_PCACHE
    auto res = z3_pcache_check();
#else
    auto const res = check_retrying(solver);
#endif

    auto const end = std::chrono::high_resolution_clock::now();
    auto const elapsed = std::chrono::duration_cast<std::chrono::duration<double>>(end - start);
    z3_accumulative_time += elapsed;
    if (slow_query_wanted(elapsed))
        dump_slow_query(elapsed, "z3_check state: " + to_string(res), timeout, solver.to_smt2());

    // std::cout << "-----------------Z3-----------------" << std::endl;
    // for (auto &c : *state->conds) {
    //     std::cout << "z3 check state conds: " << c << std::endl;
    // }
    // std::cout << "-----------------Z3-----------------" << std::endl;

    if (res == z3::unsat) {
        Z3Cache.insert(cache_query, Z3Result::False);
        return Z3Result::False;
    } else if(res == z3::unknown) {
        Z3Cache.insert(cache_query, Z3Result::Unknown);
        z3_unknowns++;
        return Z3Result::Unknown;
    } else if(res == z3::sat) {
        Z3Cache.insert(cache_query, Z3Result::Sat);
        return Z3Result::Sat;
    } else {
        assert(false);
    }
}

//only check unsat for !@cond, return True if unsat, SAT if sat.
//will not return False since will not check invalidity.
//@model will get assigned to the return model.
Z3Result z3_check_unsat(const shared_ptr<ProveState>& state, const z3::expr& cond, z3::model& ce, QueryInfo *qinfo, int timeout,
                        bool count_unknown) {
    auto const start = std::chrono::high_resolution_clock::now();
    // Sat is not cached: it comes with the counterexample in [ce].
    auto const cache_query = Z3ResultCache::query(Z3ResultCache::Kind::CheckUnsat, *state, &cond, timeout);
    if (auto const hit = Z3Cache.find(cache_query)) {
        z3_cache_hits++;
        return *hit;
    }

    z3_checks++;

    timeout = scaled_timeout(timeout);
    Z3Params.set("timeout", (unsigned int)timeout);

    z3::solver solver = make_solver();
    solver.set(Z3Params);


    for (auto  const&c : *state->conds) {
        solver.add(c);
    }

    for (auto  const&ind : *state->inductions) {
        solver.add(ind);
    }

    solver.add(!cond);
    add_lemmas(solver);
    add_stack_typing_facts(solver);
    // auto not_res = solver.check();
    auto not_res = z3::unknown;
    std::string query;
    if (qinfo || OPTS.race) query = solver.to_smt2();
    if (qinfo) qinfo->dump(query);

    if (OPTS.race) {
        auto const raced = z3_race_check(query, count_unknown);
        if (raced != Z3Result::Sat) Z3Cache.insert(cache_query, raced);
        return raced;
    } else {
        not_res = check_retrying(solver, &ce);
    }

    auto const end = std::chrono::high_resolution_clock::now();
    auto const elapsed = std::chrono::duration_cast<std::chrono::duration<double>>(end - start);
    z3_accumulative_time += elapsed;
    if (slow_query_wanted(elapsed))
        dump_slow_query(elapsed, "z3_check_unsat not cond: " + to_string(not_res), timeout,
                        query.empty() ? solver.to_smt2() : query);

    // std::clog << "-----------------Z3_check_unsat-----------------" << std::endl;
    // std::clog << "hash: " << hash << std::endl;
    // std::clog << "z3 check cond: " << cond << ", hash: " << cond.hash() << std::endl;
    // for (auto &c : *state->conds) {
    //     std::clog << "z3 check state conds: " << c << std::endl;
    // }
    // std::clog << "z3 check not_res: " << not_res << std::endl;
    // std::clog << "-----------------Z3_check_unsat-----------------" << std::endl;

    if (not_res == z3::unsat) {
        Z3Cache.insert(cache_query, Z3Result::True);
        return Z3Result::True;
    } else if (not_res == z3::sat) {
        // check_retrying stored the counterexample in ce.
        return Z3Result::Sat;
    } else {
        Z3Cache.insert(cache_query, Z3Result::Unknown);
        if (count_unknown) z3_unknowns++;
        return Z3Result::Unknown;
    }
}


namespace {

/// Whether `exists <binders>. pattern = src` says anything the recognizer for
/// the pattern's outermost constructor does not already say.
///
/// It does not, when every position the pattern leaves open is a distinct fresh
/// name.  A free datatype's recognizer asserts that the scrutinee *is* that
/// constructor applied to its own accessors, and those accessors are then the
/// only values the equality admits -- so the equality holds by construction and
/// the quantifier has nothing to look for.
///
/// A constant, a constructor below the root, or a name used twice does pin
/// something; the caller states that on the accessors rather than under a
/// quantifier.  A tuple is transparent at any depth: a struct has one
/// constructor, so it constrains nothing on its own.
bool pattern_is_transparent(Project *proj, SpecNode *pat, std::set<string> &seen, bool root) {
    if (auto sym = instance_of(pat, Symbol)) {
        // A nullary constructor constrains the scrutinee wherever it appears:
        // the caller emits a recognizer only for an Expr pattern, so nothing
        // else asserts it.
        if (proj->is_ind_constr(sym->text)) return false;
        return seen.insert(sym->text).second;
    }
    if (is_instance(pat, Const)) return false;
    auto expr = instance_of(pat, Expr);
    if (!expr) return false;

    bool const is_tuple = op_eq(expr->op, Expr::Tuple);
    // Anything else here is a constructor of a type with alternatives, so it
    // needs a recognizer, and the caller emits one only at the root.
    if (!is_tuple && !root) return false;
    for (auto const &elem : *expr->elems)
        if (!pattern_is_transparent(proj, elem.get(), seen, false)) return false;
    return true;
}

}  // namespace

shared_ptr<SpecValue> resolve_pattern(Project* proj, SpecNode* val, SpecNode* pat, const shared_ptr<SpecValue>& src,
                                      unordered_map<string, shared_ptr<SpecValue>> &vars,
                                      unordered_map<string, shared_ptr<SpecValue>> &assigns)
{
    auto const typ = src->get_type();
    if (auto sym = instance_of(pat, Symbol)) {
        if (proj->is_ind_constr(sym->text)) {
            return static_pointer_cast<Inductive>(typ)->construct(sym->text, {});
        } else {
            vars[sym->text] = typ->declare(sym->text, val->nid);
            assigns[sym->text] = src;
            return vars[sym->text];
        }
    } else if (auto con = instance_of(pat, Const)) {
        if (auto intc = std::get_if<unsigned long>(&con->value)) {
            auto icon = instance_of(val, IntConst);
            return make_shared<IntValue>(*intc, icon->is_signed());
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            return make_shared<BoolValue>(*boolc);
        } else if (auto strc = std::get_if<string>(&con->value)) {
            return make_shared<StringValue>(*strc);
        }
    } else if (auto expr = instance_of(pat, Expr)) {
        if (op_eq(expr->op, Expr::Some)) {
            auto const v = resolve_pattern(proj, val, expr->elems->at(0).get(), static_pointer_cast<IndValue>(src)->get("value"), vars, assigns);
            return static_pointer_cast<Inductive>(typ)->construct("Some", {v});
        } else if (op_eq(expr->op, Expr::Tuple)) {
            vector<shared_ptr<SpecValue>> elems;
            for (int i = 0; i < expr->elems->size(); i++)
            {
                elems.push_back(resolve_pattern(proj, val, expr->elems->at(i).get(), static_pointer_cast<StructValue>(src)->get(i), vars, assigns));
            }
            return static_pointer_cast<Struct>(typ)->construct(elems);
        } else if (op_eq(expr->op, Expr::CONCAT)) {
            auto const head = resolve_pattern(proj, val, expr->elems->at(0).get(), static_pointer_cast<IndValue>(src)->get("head"), vars, assigns);
            auto const tail = resolve_pattern(proj, val, expr->elems->at(1).get(), static_pointer_cast<IndValue>(src)->get("tail"), vars, assigns);
            return static_pointer_cast<Inductive>(typ)->construct("cons", {head, tail});
        } else if (op_eq(expr->op, Expr::None)) {
            auto const t = dynamic_pointer_cast<Inductive>(src->get_type());

            return t->construct("None", {});
        } else if (std::holds_alternative<string>(expr->op)) {
            auto const op = std::get<string>(expr->op);
            auto const sym = proj->symbols.find(op);
            vector<shared_ptr<SpecValue>> args;

            if (sym != proj->symbols.end() && sym->second.kind == SymbolKind::IndConstructor) {
                auto const ind_typ = static_pointer_cast<Inductive>(typ);

                for (int i = 0; i < ind_typ->constr.at(op)->size(); i++) {
                    auto  const&arg = ind_typ->constr.at(op)->at(i);
                    args.push_back(resolve_pattern(proj, val, expr->elems->at(i).get(),
                                                   static_pointer_cast<IndValue>(src)->get(arg->name), vars, assigns));
                }

                return ind_typ->construct(op, args);
            }
        } else {
            throw std::runtime_error("Unknown pattern(" + std::to_string(__LINE__) + "): " + string(*pat));
        }
    }

    throw std::runtime_error("Unknown pattern(" + std::to_string(__LINE__) + "): " + string(*pat));
}

/// The condition under which a match arm is taken, without quantifiers.
///
/// Fills [vars] with the pattern's binders and [assigns] with the accessor term
/// each one stands for, as resolve_pattern does; the caller substitutes the
/// latter into the arm body.
///
/// Where the pattern pins something, the equality is stated on those accessors.
/// That is the existential instantiated at its witness, and it loses nothing:
/// in a free datatype the witness is unique, so the quantified and instantiated
/// forms are equivalent.
z3::expr match_arm_condition(Project *proj, SpecNode *val, SpecNode *pattern,
                             const shared_ptr<SpecValue> &src,
                             unordered_map<string, shared_ptr<SpecValue>> &vars,
                             unordered_map<string, shared_ptr<SpecValue>> &assigns) {
    auto const pat = resolve_pattern(proj, val, pattern, src, vars, assigns);

    z3::expr cond = z3ctx.bool_val(true);
    bool has_recognizer = false;
    if (auto const ind_ty = dynamic_pointer_cast<Inductive>(src->get_type())) {
        if (auto constr = dynamic_cast<Expr *>(pattern)) {
            string constr_name;
            if (std::holds_alternative<string>(constr->op)) {
                constr_name = std::get<string>(constr->op);
            } else if (auto const op = std::get_if<Expr::ops>(&constr->op)) {
                // Some and None do not reach the symbol table as names.
                auto const option_ty = dynamic_pointer_cast<Option>(ind_ty);
                assert(option_ty);
                if (*op == Expr::ops::Some) constr_name = option_ty->some_name();
                else if (*op == Expr::ops::None) constr_name = option_ty->none_name();
            }
            if (!constr_name.empty()) {
                cond = ind_ty->get_recognizer(constr_name)(src->get_z3_value());
                has_recognizer = true;
            }
        }
    }

    std::set<string> seen;
    if (pattern_is_transparent(proj, pattern, seen, /*root=*/true) && has_recognizer)
        return cond;

    // Rebuild the pattern over the accessors rather than the fresh binders.
    z3::expr_vector from(z3ctx), to(z3ctx);
    for (auto const &[name, var] : vars) {
        auto const witness = assigns.find(name);
        if (witness == assigns.end()) continue;
        from.push_back(var->get_z3_value());
        to.push_back(witness->second->get_z3_value());
    }
    auto const eq = pat->get_z3_value().substitute(from, to) == src->get_z3_value();
    return has_recognizer ? (cond && eq) : eq;
}


//inv have only free variable st.
//state in inv and body can only be "st".
//forall v1,v2,... vk st, inv(st) /\ prim_body(v1,v2,...st) = Some (v1',v2'..st') -> inv(st')
// bool check_invariant(Project* proj, Definition* prim, SpecNode* inv) {
//     auto body = prim->body.get();
//     auto args = prim->args.get();

//     auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
//     auto conds = std::make_shared<vector<z3::expr>>();

//     for (auto arg : *args) {
//         (*var)[arg->name] = arg->type->declare(arg->name, 0); //current
//     }

//     //body have to be Some.
//     auto eqelems = new vector<unique_ptr<SpecNode>>();
//     eqelems->push_back(body->deep_copy());
//     auto varelems = new vector<unique_ptr<SpecNode>>();
//     auto rettype = instance_of(prim->rettype.get(), Option);
//     auto rettupletype = instance_of(rettype->elem_type.get(), Tuple);
//     auto tmpname = "__tmp__";
//     int i = 0;
//     for(auto elemtype : *rettupletype->types) {
//         if(i != rettupletype->types->size() - 1) {
//             (*var)[tmpname + i] = elemtype->declare(tmpname + i, 0); //after
//             varelems->push_back(unique_ptr<SpecNode>(new Symbol(tmpname + i, elemtype)));
//         } else {
//             (*var)["st'"] = elemtype->declare("st'", 0); //after
//             varelems->push_back(unique_ptr<SpecNode>(new Symbol("st'", elemtype)));
//         }
//         i++;
//     }
//     auto tupletype = instance_of(body->type.get(), Option)->elem_type;

//     auto tuple = new Expr(Expr::ops::Tuple, unique_ptr<vector<unique_ptr<SpecNode>>>(varelems), tupletype);
//     auto someelems = new vector<unique_ptr<SpecNode>>();
//     someelems->push_back(unique_ptr<SpecNode>(tuple));

//     eqelems->push_back(unique_ptr<SpecNode>(new Expr(Expr::ops::Some, unique_ptr<vector<unique_ptr<SpecNode>>>(someelems), body->type)));
//     auto equa = new Expr(Expr::binops::EQUAL, unique_ptr<vector<unique_ptr<SpecNode>>>(eqelems));

//     //the body and the inv share the same free variables.
//     auto state = make_shared<EvalState>(
//         make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var),
//         make_shared<vector<z3::expr>>(*conds));
//     //the state will be added loop conditions
//     auto body_val = z3_eval(proj, equa, state, true);

//     // for(auto cond : *state->conds) {
//     //     LOG_DEBUG << "cond" << cond;
//     // }

//     LOG_DEBUG << "Printing the Invariant: " << string(*inv);
//     auto inv_before_val = z3_eval(proj, inv, make_shared<EvalState>(
//         make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var),
//         make_shared<vector<z3::expr>>(*conds)));


//     //substitute the st to st' in inv.
//     SpecNode* after_inv = inv;
//     bool succ = false;
//     auto new_st = new Symbol("st'");
//     after_inv = subst(after_inv, "st", new Symbol("st'"), succ);
//     delete new_st; //since new_st is caller freed.
//     LOG_DEBUG << "Printing the Invariant After: " << string(*after_inv);

//     auto inv_after_val = z3_eval(proj, after_inv, make_shared<EvalState>(

//         make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var),
//         make_shared<vector<z3::expr>>(*conds)));


//     auto vc = z3::implies(body_val->get_z3_value() && inv_before_val->get_z3_value(), inv_after_val->get_z3_value());
//     LOG_DEBUG << "Verification Condition: " << vc;

//     z3::model model(z3ctx);
//     auto res = z3_check_unsat(state, vc, model, 20000);
//     if(res == Z3Result::Unknown) {
//         LOG_DEBUG << "solver return unknown when checking invariant for " << prim->name;
//     } else if(res == Z3Result::Sat) {
//         LOG_DEBUG << "solver return sat when checking invariant for " << prim->name;
//         LOG_DEBUG << model;
//     }
//     return res == Z3Result::True;
// }


//check the loop invariant is inductive or not
//the loop should be self-contained and have no function calls.
//inv(st) /\ N = 0 /\ st' = base_case(st) -> inv(st') //actually this step is always true, not necessary to check
//inv(st) /\ N > 0 /\ st' = loop_body(st) -> inv(st')
bool check_loop_inv(Project* proj, Definition *loop) {
    assert(proj->loop_invs.find(loop->name) != proj->loop_invs.end());
    std::vector<unique_ptr<SpecNode>>& invs = proj->loop_invs[loop->name];
    assert(instance_of(loop, Fixpoint));
    auto body = loop->body().get();
    auto args = loop->args.get();
    auto m = instance_of(body, Match);

    unique_ptr<SpecNode> inv = make_unique<BoolConst>(true);
    for(auto &in : invs) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(std::move(inv));
        elems->push_back(in->deep_copy());
        inv = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
    }

    //get the loop body
    auto base_case = m->match_list->at(0)->body.get();
    auto induct_body = m->match_list->back()->body.get();
    auto m2 = instance_of(induct_body, Match);

    auto loop_pattern = m2->match_list->at(0)->pattern.get();
    auto some_pat = instance_of(loop_pattern, Expr);
    auto tuple_pat = instance_of(some_pat->elems->at(0).get(), Expr);
    assert(op_eq(tuple_pat->op, Expr::ops::Tuple));

    auto loop_body = m2->match_list->at(0)->body->deep_copy();
    //subst the loop body with correct arguments
    for(int i = 0; i < tuple_pat->elems->size(); i++) {
        auto sym = instance_of(tuple_pat->elems->at(i).get(), Symbol);
        bool succ;
        auto const newsym = make_unique<Symbol>(args->at(i+1)->name, sym->type);
        loop_body = subst(std::move(loop_body), sym->text, newsym.get(), succ);
    }

    auto const var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    auto const conds = std::make_shared<vector<z3::expr>>();
    auto const _N_ = Int::INT->declare(loop->args->at(0)->name, 0);
    //declare loop arguments
    auto const known = make_shared<unordered_map<string, shared_ptr<SpecType>>>();

    for (auto const &arg : *args) {
        if (arg->name != "_N_") {
            (*var)[arg->name] = arg->type->declare(arg->name, 0); //current
            (*known)[arg->name] = arg->type;
        }
        if(arg->name == "st") {
            //(*var)[arg->name] = arg->type->declare(arg->name, 0); //current
            (*var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0); //initial
            (*known)[arg->name + "_old"] = arg->type;
        }
    }
    type_inference::infer_type(*proj, inv.get(), known, Bool::BOOL);
    //evaluate_inv_before
    auto const inval_before = z3_eval(proj, inv.get(), make_shared<EvalState>(var, conds));
    //evaluate_loop_body
    auto const loop_body_val = z3_eval(proj, loop_body.get(), make_shared<EvalState>(
        make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var),
        std::make_shared<vector<z3::expr>>(*conds)));

    //evaluate base case
    auto const base_case_val = z3_eval(proj, base_case, make_shared<EvalState>(
        make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var),
        std::make_shared<vector<z3::expr>>(*conds)));

    auto const rettype = loop->body()->type;
    auto ret = instance_of(rettype.get(), Option);
    auto const elems_type = ret->elem_type;
    auto tuple_type = instance_of(elems_type.get(), Tuple);
    auto const tuple_elem_type = tuple_type->types;

    auto tuple_elems = make_unique<vector<unique_ptr<SpecNode>>>();
    for(int i = 1; i < args->size();i++) {
        tuple_elems->push_back(make_unique<Symbol>(args->at(i)->name + "'", tuple_elem_type->at(i-1)));
    }
    auto body_expr = new Expr(Expr::Tuple, std::move(tuple_elems), elems_type);
    auto option_elem = make_unique<vector<unique_ptr<SpecNode>>>();
    option_elem->push_back(unique_ptr<SpecNode>(body_expr));
    auto full_expr = new Expr(Expr::Some, std::move(option_elem), rettype);
    // LOG_DEBUG << "expr:" << string(*full_expr);

    auto const full_val_var = make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var);


    for (auto const &arg : *args) {
        (*full_val_var)[arg->name + "'"] = arg->type->declare(arg->name + "'", 0);
    }

    auto const full_val = z3_eval(proj, full_expr,
    make_shared<EvalState>(
        full_val_var,
        make_shared<vector<z3::expr>>(*conds)));

    auto after_inv = inv->deep_copy();
    //subst the loop body with correct arguments
    auto const after_var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    for (auto const &arg : *args) {
        if (arg->name != "_N_") {
            (*after_var)[arg->name + "'"] = arg->type->declare(arg->name + "'", 0); //initial
        }
        if(arg->name == "st") {
            //(*after_var)[arg->name + "'"] = arg->type->declare(arg->name + "'", 0);
            (*after_var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0);
        }
    }

    for(auto const &arg : *loop->args) {
        auto const sym = make_unique<Symbol>(arg->name + "'", arg->type);
        bool succ;
        after_inv = subst(std::move(after_inv), arg->name, sym.get(), succ);
    }
    //evaluate inv after
    auto const inv_after = z3_eval(proj, after_inv.get(), make_shared<EvalState>(
        after_var,
        make_shared<vector<z3::expr>>(*conds)));


    //final expression, inv(a,b,c...) /\ spec(a,b,c) = a',b'c' => inv(a',b',c').
    //TODO: termination proof: ranking function(a,b,c) decreases every iteratiton.

    //auto n_invariant = Int::INT->declare("_N_",0)->get_z3_value() == (Int::INT->declare("_N_'",0)->get_z3_value() + 1);
    //auto n_invariant_base = Int::INT->declare("_N_",0)->get_z3_value() == (Int::INT->declare("_N_'",0)->get_z3_value());
    //auto n_eq0 = (_N_->get_z3_value() == 0);
    //auto n_gt0 = (_N_->get_z3_value() > 0);
    //auto vc_base = z3::implies(inval_before->get_z3_value() && n_eq0 && z3_eq(full_val->get_z3_value(), base_case_val->get_z3_value()) && n_invariant_base, inv_after->get_z3_value());
    auto vc_induct = z3::implies(inval_before->get_z3_value() && z3_eq(full_val->get_z3_value(), loop_body_val->get_z3_value()), inv_after->get_z3_value());
    //LOG_DEBUG << "base_case query: " << vc_base;
    LOG_DEBUG << "inductive case query:" << vc_induct;

    Z3Params.set("timeout", (unsigned int)500000);
    Z3Solver.set(Z3Params);
   //Z3Solver.push();
    // Z3Solver.add(!vc_base);
    // auto res = Z3Solver.check();
    // Z3Solver.pop();
    // if(res == z3::sat || res == z3::unknown) {
    //     LOG_DEBUG << "base case not able to decide: " << res;
    //     return false;
    // }

    Z3Solver.push();
    Z3Solver.add(!vc_induct);
    auto const res = Z3Solver.check();
    if(res == z3::sat || res == z3::unknown) {
        if(res == z3::sat) {
            auto model = Z3Solver.get_model();
            LOG_DEBUG << model;
        }
        Z3Solver.pop();
        LOG_DEBUG << "inductive not able to decide: " << res;
        return false;
    }
    Z3Solver.pop();
    return res == z3::unsat;
}

//extract useful patterns in invariants to be triggers that when encountered, will instantiate the invariant.
//the quantifiers are integers in RMM.
//forall i, (st...granules @ i).(a) = b.
void extract_patterns_field(SpecNode* spec, set<string>& fields, set<string>& quantifiers) {
    if(auto expr = instance_of(spec, Expr)) {
        if(op_eq(expr->op, Expr::ops::GET)) {
            auto zmap = expr->elems->at(0).get();
            if(auto zmapexpr = instance_of(zmap, Expr)) {
                auto rec = instance_of(zmapexpr->elems->at(0).get(), Expr);
                auto index = instance_of(zmapexpr->elems->back().get(), Symbol);
                //the indices are quantified
                if(quantifiers.find(index->text) != quantifiers.end()) {
                    if(op_eq(zmapexpr->op, Expr::RecordGet)) {
                        //st.(a).(b) @ i
                        auto fieldnode = rec->elems->back().get();
                        auto fieldsym = instance_of(fieldnode, Symbol);
                        fields.insert(fieldsym->text);
                    } else if(op_eq(rec->op, Expr::RecordSet)) {
                        //(st.[a].[b] <: c) @ i
                        auto fieldnode = (rec->elems->end() - 1)->get();
                        auto fieldsym = instance_of(fieldnode, Symbol);
                        fields.insert(fieldsym->text);
                    }
                }
            }
            extract_patterns_field(expr->elems->at(0).get(), fields, quantifiers);
        } else {
            for(auto  const&elem : *expr->elems) {
                extract_patterns_field(elem.get(), fields, quantifiers);
            }
        }
    } else if(auto expr = instance_of(spec, If)) {
        extract_patterns_field(expr->cond.get(), fields, quantifiers);
        extract_patterns_field(expr->then_body.get(), fields, quantifiers);
        extract_patterns_field(expr->else_body.get(), fields, quantifiers);
    } else if(auto expr = instance_of(spec, RelyAnno)) {
        extract_patterns_field(expr->prop.get(), fields, quantifiers);
        extract_patterns_field(expr->body.get(), fields, quantifiers);
    } else if(auto expr = instance_of(spec, Match)) {
        extract_patterns_field(expr->src.get(), fields, quantifiers);
        for(auto &pm : *expr->match_list) {
            extract_patterns_field(pm->body.get(), fields, quantifiers);
        }
    } else if(auto expr = instance_of(spec, Symbol)) {
        //do nothing
    }
}

void pattern_matching(SpecNode const* pattern, SpecNode const* spec) {

}



//forall st st', inv st /\ query_oracle st = Some st' -> inv st'.
unique_ptr<SpecNode> formulate_preserved_function(Project* proj, string fname) {
    auto const proved_inv = proj->verified_invariants;
    unique_ptr<SpecNode> conjoined = proj->sys_invs[proj->verifying_invariant]->deep_copy();
    for(auto const &string: proved_inv) {
        auto inv = proj->sys_invs[string].get();
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
        elems->push_back(std::move(conjoined));
        elems->push_back(inv->deep_copy());
        conjoined = make_unique<Expr>(Expr::AND, std::move(elems));
    }
    auto inv = std::move(conjoined);
    auto before_inv = inv->deep_copy();
    auto st_after = make_unique<Symbol>("st'", proj->layers[0]->abs_data);
    bool succ;
    auto after_inv = subst(std::move(inv), "st", st_after.get(), succ);
    auto arg_elems = make_unique<vector<unique_ptr<SpecNode>>>();
    auto quantified = make_unique<vector<shared_ptr<Arg>>>();
    //z3::expr_vector args(z3ctx);
    for(auto const &arg: *proj->defs[fname]->args) {
        //args.push_back(arg->type->declare(arg->name, 0)->get_z3_value());
        quantified->push_back(arg);
        arg_elems->push_back(make_unique<Symbol>(arg->name, arg->type));
        if(arg->name == "st") {
            //args.push_back(arg->type->declare(arg->name + "'", 0)->get_z3_value());
            quantified->push_back(make_shared<Arg>("st'",st_after->type));
        }
    }

    auto eqelems = make_unique<vector<unique_ptr<SpecNode>>>();
    auto lhsbody = new Expr(fname, std::move(arg_elems));
    eqelems->push_back(unique_ptr<SpecNode>(lhsbody));
    SpecNode* equa;
    auto someelems = new vector<unique_ptr<SpecNode>>();
    auto ret = instance_of(proj->defs[fname]->rettype.get(), Option);
    if(auto elem_type = instance_of(ret->elem_type.get(), Tuple)) {
       auto tmpname = "__tmp__";
       int i = 0;
       auto varelems = make_unique<vector<unique_ptr<SpecNode>>>();
       for(auto const &elemtype : *elem_type->types) {
            if(i != elem_type->types->size() - 1) {
                //(*var)[tmpname + i] = elemtype->declare(tmpname + i, 0); //after
                varelems->push_back(unique_ptr<SpecNode>(new Symbol(tmpname + i, elemtype)));
            } else {
                //(*var)["st'"] = elemtype->declare("st'", 0); //after
                varelems->push_back(unique_ptr<SpecNode>(new Symbol("st'", elemtype)));
            }
            i++;
       }
        auto const tupletype = instance_of(proj->defs[fname]->rettype.get(), Option)->elem_type;

        auto tuple = new Expr(Expr::ops::Tuple, std::move(varelems), tupletype);

        someelems->push_back(unique_ptr<SpecNode>(tuple));
    } else {
        someelems->push_back(make_unique<Symbol>("st'", st_after->type));
    }
    eqelems->push_back(unique_ptr<SpecNode>(new Expr(Expr::ops::Some, unique_ptr<vector<unique_ptr<SpecNode>>>(someelems), proj->defs[fname]->rettype)));
    equa = new Expr(Expr::binops::EQUAL, std::move(eqelems), Bool::BOOL);

    auto exprelems = make_unique<vector<unique_ptr<SpecNode>>>();
    exprelems->push_back(std::move(before_inv));
    exprelems->push_back(unique_ptr<SpecNode>(equa));
    auto expr = new Expr(Expr::binops::AND, std::move(exprelems), Bool::BOOL);

    auto implieselems = make_unique<vector<unique_ptr<SpecNode>>>();
    implieselems->push_back(unique_ptr<SpecNode>(expr));
    implieselems->push_back(std::move(after_inv));

    auto implies = new Expr(Expr::binops::IMPLIES, std::move(implieselems), Bool::BOOL);
    auto forall = new Forall(std::move(quantified), unique_ptr<SpecNode>(implies));

    LOG_DEBUG << "formulate_preserved_function" << string(*forall);
    return unique_ptr<SpecNode>(forall);
}

//post(t1,t2,t3,t4,st')
unique_ptr<SpecNode> formulate_post_condition(Project* proj, const string& fname, vector<unique_ptr<SpecNode>>* args) {
    auto def = proj->defs[fname].get();
    auto &postconds = proj->cmds.PostCond[fname];
    unique_ptr<SpecNode> aggrepost = make_unique<BoolConst>(true);
	for(auto &inv : postconds) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(std::move(aggrepost));
        elems->push_back(inv->deep_copy());
        aggrepost = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
	}
    auto const known = make_shared<unordered_map<string, shared_ptr<SpecType>>>();
    auto rettype = instance_of(def->rettype.get(), Option);

    if(auto rettupletype = instance_of(rettype->elem_type.get(), Tuple)) {
        string tmpname = "_ret_";
        int i = 0;
        vector<string> names;
        vector<unique_ptr<SpecNode>> nodes;
        for(auto const &elemtype : *rettupletype->types) {
            if(i != rettupletype->types->size() - 1) {
                (*known)[tmpname + std::to_string(i)] = elemtype;
                //(*var)[tmpname + i] = elemtype->declare(tmpname + i, 0); //after
                //tupleelems->push_back(unique_ptr<SpecNode>(new Symbol(fname + tmpname + std::to_string(i), elemtype)));
                names.push_back(tmpname + std::to_string(i));
                nodes.push_back(make_unique<Symbol>(fname + tmpname + std::to_string(i), elemtype));
            } else {
                (*known)["st"] = elemtype;
                //(*var)["st'"] = elemtype->declare("st'", 0); //after
                names.push_back("st");
                nodes.push_back(make_unique<Symbol>(fname + "_st_new_", elemtype));
                //tupleelems->push_back(unique_ptr<SpecNode>(new Symbol(fname + "_st_new_", elemtype)));
            }
            i++;
        }
        for(int i = 0; i < def->args->size(); i++) {
            if(i + 1 == def->args->size()) {
                (*known)["st_old"] = proj->layers[0]->abs_data;
                names.push_back("st_old");
                nodes.push_back(args->at(i)->deep_copy());
            } else {
                (*known)[def->args->at(i)->name] = def->args->at(i)->type;
                names.push_back(def->args->at(i)->name);
                nodes.push_back(args->at(i)->deep_copy());
            }
        }
        type_inference::infer_type(*proj, aggrepost.get(), known, Bool::BOOL);
        aggrepost = subst_v2(proj, std::move(aggrepost), &names, &nodes);
    } else if(rettype->elem_type == proj->layers[0]->abs_data) {
        vector<string> names;
        vector<unique_ptr<SpecNode>> nodes;

        for(int i = 0; i < def->args->size(); i++) {
            if(i + 1 == def->args->size()) {
                (*known)["st_old"] = proj->layers[0]->abs_data;
                names.push_back("st_old");
                nodes.push_back(args->at(i)->deep_copy());
            } else {
                (*known)[def->args->at(i)->name] = def->args->at(i)->type;
                names.push_back(def->args->at(i)->name);
                nodes.push_back(args->at(i)->deep_copy());
            }
        }

        names.push_back("st");
        (*known)["st"] = proj->layers[0]->abs_data;

        type_inference::infer_type(*proj, aggrepost.get(), known, Bool::BOOL);
        nodes.push_back(make_unique<Symbol>(fname + "_st_new_", proj->layers[0]->abs_data));
        aggrepost = subst_v2(proj, std::move(aggrepost), &names, &nodes);
    }
    return aggrepost;
}

//formulate loop invariant post condition
//forall v1' v2'....loop_spec(n, v1....vk,st) = Some (v1',v2',v3'....vk',st') -> loop_cond /\ invariant(v1',v2',....vk'，st',st)
unique_ptr<SpecNode> formulate_loop_invariant(Project* proj, string fname, vector<unique_ptr<SpecNode>>* args) {
    auto &invs = proj->loop_invs[fname];
    auto def = proj->defs[fname].get();
    assert(instance_of(def, Fixpoint));
    unique_ptr<vector<shared_ptr<Arg>>> vars = make_unique<vector<shared_ptr<Arg>>>();

    int i = 0;
    for(auto const &arg : *def->args) {
        vars->push_back(make_shared<Arg>(def->name + "_" + arg->name + "_new", arg->type));
    }


    auto lhselems = make_unique<vector<unique_ptr<SpecNode>>>();
    for(auto &arg: *args) {
        lhselems->push_back(arg->deep_copy());
    }


    auto lhsbody = new Expr(fname, std::move(lhselems));

    auto rhselems = make_unique<vector<unique_ptr<SpecNode>>>();
    auto tupleelems = make_unique<vector<unique_ptr<SpecNode>>>();
    i = 0;
    auto const known = make_shared<unordered_map<string, shared_ptr<SpecType>>>();
    for(auto const &arg: *def->args) {
        tupleelems->push_back(make_unique<Symbol>(def->name + "_" + arg->name + "_new", arg->type));
        (*known)[arg->name] = arg->type;
        if(arg->name == "st") {
            (*known)[arg->name + "_old"] = arg->type;
        }
        i++;
    }

    auto rhstuple = new Expr(Expr::ops::Tuple, std::move(tupleelems), instance_of(def->body()->type.get(), Option)->elem_type);
    rhselems->push_back(unique_ptr<SpecNode>(rhstuple));
    auto rhsbody = new Expr(Expr::ops::Some, std::move(rhselems), def->body()->type);

    auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
    elems->push_back(unique_ptr<SpecNode>(lhsbody));
    elems->push_back(unique_ptr<SpecNode>(rhsbody));
    // auto eqbody = new Expr(Expr::binops::EQUAL, std::move(elems), Bool::BOOL);


    unique_ptr<SpecNode> aggreinv = make_unique<BoolConst>(true);
    for(auto &inv : invs) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(std::move(aggreinv));
        elems->push_back(inv->deep_copy());
        aggreinv = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
    }

    type_inference::infer_type(*proj, aggreinv.get(), known, Bool::BOOL);

    i = 0;
    vector<string> names;
    vector<unique_ptr<SpecNode>> nodes;
    for(auto const &arg : *def->args) {
        auto sym = make_unique<Symbol>(def->name + "_" + arg->name + "_new", arg->type);
        // bool succ;
        names.push_back(arg->name);
        nodes.push_back(std::move(sym));

        names.push_back(arg->name + "_old");
        nodes.push_back(args->at(i)->deep_copy());
        i++;
    }

    aggreinv = subst_v2(proj, std::move(aggreinv), &names, &nodes);

    //auto loop_cond = autov::parser::parseExpr(proj,def->name + "_" + "__break__' = true");
    //loop_cond->type = Bool::BOOL;
    // auto andelems = new vector<unique_ptr<SpecNode>>();
    // andelems->push_back(std::move(aggreinv));
    // andelems->push_back(unique_ptr<SpecNode>(loop_cond));
    // auto loop_condAndInv = new Expr(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(andelems), Bool::BOOL);

    // auto bodyelems = new vector<unique_ptr<SpecNode>>();
    // bodyelems->push_back(unique_ptr<SpecNode>(eqbody));
    // bodyelems->push_back(std::move(aggreinv));
    // auto expr = new Expr(Expr::binops::IMPLIES, unique_ptr<vector<unique_ptr<SpecNode>>>(bodyelems), Bool::BOOL);


    return aggreinv;
}


//state is path conditions relate to current value, state will be copied when going into if and rely
//vcs is global conditions instantiated to assume post conditions of loops.
void symbolic(Project* proj, SpecNode* val, const shared_ptr<EvalState>& state, vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>>& states) {
    //std::cout << "z3_eval: " << string(*val) << std::endl;


    if (auto sym = instance_of(val, Symbol)) {
        if (sym->text != "None" && sym->text != "nil" && state->vars->find(sym->text) != state->vars->end()) {
            states.push_back(std::make_pair(state->vars->at(sym->text), state));
        } else if (proj->defs.find(sym->text) != proj->defs.end()) {
            auto df = proj->defs[sym->text].get();
            assert(df->args->size() == 0);
            if (auto c = instance_of(df->body().get(), Const)) {
                return states.push_back(std::make_pair(z3_eval(proj, c, state), state));
            }
        } else if (proj->decls.find(sym->text) != proj->decls.end()) {
            auto decl = proj->decls[sym->text].get();
            assert(!dynamic_pointer_cast<Function>(decl->type));
            states.push_back(std::make_pair(decl->absf(), state));
        } else if (proj->is_ind_constr(sym->text)) {
            states.push_back(std::make_pair(static_pointer_cast<Inductive>(sym->get_type())->construct(sym->text, {}), state));
        } else if (proj->symbols.find(sym->text) != proj->symbols.end() &&
                   proj->symbols[sym->text].kind == SymbolKind::StructElem) {
            states.push_back(std::make_pair(make_shared<StringValue>(sym->text), state));
        } else {
            throw std::runtime_error("Unknown symbol: " + sym->text);
        }
    } else if (auto con = instance_of(val, Const)) {
        if (auto intc = std::get_if<unsigned long>(&con->value)) {
            auto icon = instance_of(val, IntConst);
            auto const v = make_shared<IntValue>(*intc, icon->is_signed());
            states.push_back(std::make_pair(v, state));
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            states.push_back(std::make_pair(make_shared<BoolValue>(*boolc), state));
        } else if (auto strc = std::get_if<string>(&con->value)) {
            states.push_back(std::make_pair(make_shared<StringValue>(*strc), state));
        }
    } else if (auto expr = instance_of(val, Expr)) {
        vector<shared_ptr<SpecValue>> elems;

        for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
            elems.push_back(z3_eval(proj, e->get(), state));
        }

        if (op_eq(expr->op, Expr::None))
            states.push_back(std::make_pair((static_pointer_cast<Inductive>(val->get_type())->construct("None", {})),state));
        else if (op_eq(expr->op, Expr::binops::ADD)){
            if (is_int_type(expr->type)){
                states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->add(static_pointer_cast<IntValue>(elems[1])), state));
            }else if (is_int_zmap_type(expr->type)){
                // find the definition of the zmap_z_add function
                // use func->call to generate the right z3 expr
                auto const func = proj->defs.find("zmap_z_add");
                auto const absf = func->second->absf();
                states.push_back(std::make_pair(absf->call(elems), state));
            }
        }
        else if (op_eq(expr->op, Expr::binops::MINUS)) {
            if (expr->elems->size() == 2)
                states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->sub(static_pointer_cast<IntValue>(elems[1])), state));
            else
                states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->neg(), state));
        }
        else if (op_eq(expr->op, Expr::binops::MULT))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->mul(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::DIV)){
            auto const num = static_pointer_cast<IntValue>(elems[0]);
            auto const den = static_pointer_cast<IntValue>(elems[1]);
            states.push_back(std::make_pair(num->div(den), state));
        } else if (op_eq(expr->op, Expr::binops::MOD))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->mod(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::LSHIFT))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->shiftl(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::RSHIFT))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->shiftr(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::BITAND))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->land(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::BITOR))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->lor(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, "Z.lxor"))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->lxor(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, "Z.quot"))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->quot(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, "Z.rem"))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->rem(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, "Z.lnot"))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->lnot(), state));
        else if (op_eq(expr->op, "Z.testbit"))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->testbit(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, "Z.setbit"))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->setbit(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, "Z.clearbit"))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->clearbit(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, "Z.xorb"))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->xorb(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::EQUAL))
            states.push_back(std::make_pair(Prop::PROP->from_z3_value(z3_eq(elems[0]->get_z3_value(), elems[1]->get_z3_value()).simplify()), state));
        else if (op_eq(expr->op, Expr::binops::BEQ))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->eq(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::SEQ))
            states.push_back(std::make_pair(static_pointer_cast<StringValue>(elems[0])->eq(static_pointer_cast<StringValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::NOT_EQUAL))
            states.push_back(std::make_pair(Prop::PROP->from_z3_value(z3_ne(elems[0]->get_z3_value(), elems[1]->get_z3_value())), state));
        else if (op_eq(expr->op, Expr::binops::BNE))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->ne(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::SNE))
            states.push_back(std::make_pair(static_pointer_cast<StringValue>(elems[0])->ne(static_pointer_cast<StringValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::GT) || op_eq(expr->op, Expr::binops::BGT))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->gt(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::GTE) || op_eq(expr->op, Expr::binops::BGE))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->ge(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::LT) || op_eq(expr->op, Expr::binops::BLT))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->lt(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::LTE) || op_eq(expr->op, Expr::binops::BLE))
            states.push_back(std::make_pair(static_pointer_cast<IntValue>(elems[0])->le(static_pointer_cast<IntValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::ops::NOT) || op_eq(expr->op, Expr::ops::BNOT))
            states.push_back(std::make_pair(static_pointer_cast<BoolValue>(elems[0])->negb(), state));
        else if (op_eq(expr->op, Expr::binops::AND) || op_eq(expr->op, Expr::binops::BAND))
            states.push_back(std::make_pair(static_pointer_cast<BoolValue>(elems[0])->andb(static_pointer_cast<BoolValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::OR) || op_eq(expr->op, Expr::binops::BOR))
            states.push_back(std::make_pair(static_pointer_cast<BoolValue>(elems[0])->orb(static_pointer_cast<BoolValue>(elems[1])), state));
        else if (op_eq(expr->op, "xorb"))
            states.push_back(std::make_pair(static_pointer_cast<BoolValue>(elems[0])->xorb(static_pointer_cast<BoolValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::binops::IMPLIES))
            states.push_back(std::make_pair(static_pointer_cast<BoolValue>(elems[0])->implies(static_pointer_cast<BoolValue>(elems[1])), state));
        else if (op_eq(expr->op, Expr::GET)) {
            if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {

                if (op_eq(e->op, Expr::SET)) {
                    auto const z3_res = z3_check(state, z3_eq(z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value(), elems[1]->get_z3_value()));
                    if (z3_res == Z3Result::True) {
                        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> const retstates;
                        symbolic(proj, e->elems->at(2).get(), state, states);
                    } else if (z3_res == Z3Result::False) {
                        auto const map_val = z3_eval(proj, e->elems->at(0).get(), state);
                        if(auto const zmv = dynamic_pointer_cast<ZMapValue>(map_val)){
                            states.push_back(std::make_pair(zmv->get(static_pointer_cast<IntValue>(elems[1])), state));
                        } else if(auto const smv = dynamic_pointer_cast<SMapValue>(map_val)){
                            states.push_back(std::make_pair(smv->get(static_pointer_cast<StringValue>(elems[1])), state));
                        }
                    }
                }
            }
            //std::cout << "expr: " << string(*expr) << std::endl;
            auto const map_val = elems[0];
            if(auto const zmv = dynamic_pointer_cast<ZMapValue>(map_val)){
                states.push_back(std::make_pair(zmv->get(static_pointer_cast<IntValue>(elems[1])), state));
            } else if(auto const smv = dynamic_pointer_cast<SMapValue>(map_val)){
                states.push_back(std::make_pair(smv->get(static_pointer_cast<StringValue>(elems[1])), state));
            }
        } else if (op_eq(expr->op, Expr::SET)) {
            if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                if (op_eq(e->op, Expr::SET)) {
                    auto const z3_res = z3_check(state, z3_eq(z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value(), elems[1]->get_z3_value()));
                    if (z3_res == Z3Result::True) {
                        elems[0] = z3_eval(proj, e->elems->at(0).get(), state);
                    }
                }
            }
            auto const map_val = elems[0];
            if(auto const zmv = dynamic_pointer_cast<ZMapValue>(map_val)){
                states.push_back(std::make_pair(zmv->set(static_pointer_cast<IntValue>(elems[1]), elems[2]), state));
            } else if(auto const smv = dynamic_pointer_cast<SMapValue>(map_val)){
                states.push_back(std::make_pair(smv->set(static_pointer_cast<StringValue>(elems[1]), elems[2]), state));
            }

        } else if (op_eq(expr->op, Expr::RecordGet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            for (int i = 1; i < expr->elems->size(); i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            states.push_back(std::make_pair(elems.back(), state));
        } else if (op_eq(expr->op, Expr::RecordSet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            // expr.elem[n-1]: value

            // First read-off all the old fields, except the one to be updated
            for (int i = 1; i < expr->elems->size() - 2; i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            // Update the field
            elems[expr->elems->size() - 2] = elems.back();
            // Then update the record
            for (int i = expr->elems->size() - 2; i > 0; i--) {
                elems[i - 1] = static_pointer_cast<StructValue>(elems[i - 1])->set(static_cast<Symbol *>(expr->elems->at(i).get())->text, elems[i]);
            }

            states.push_back(std::make_pair(elems[0], state));
        } else if (op_eq(expr->op, Expr::binops::APPEND)) {
            // elem[0]: new element
            // elem[1]: old list
            auto const list = static_pointer_cast<ListValue>(elems[1]);
            auto const new_list = list->append(elems[0]);

            states.push_back(std::make_pair(new_list, state));
        } else if (op_eq(expr->op, Expr::binops::CONCAT)) {
            auto const list1 = static_pointer_cast<ListValue>(elems[0]);
            auto const new_list = list1->concat(static_pointer_cast<SpecValue>(elems[1]));

            states.push_back(std::make_pair(new_list, state));
        } else if (op_eq(expr->op, Expr::ops::Some))
            states.push_back(std::make_pair(static_pointer_cast<Option>(val->get_type())->construct("Some", {elems[0]}), state));
        else if (op_eq(expr->op,Expr::ops::Tuple)) {
            states.push_back(std::make_pair(static_pointer_cast<Tuple>(val->get_type())->construct(elems), state));
        }
        else if (op_eq(expr->op, "prop"))
            states.push_back(std::make_pair(elems[0], state));
        else if (auto const reduced = width_reduction(expr->op, elems))
            states.push_back(std::make_pair(make_shared<IntValue>(reduced->simplify()), state));
        else if (op_eq(expr->op,"ptr_to_int"))
            states.push_back(std::make_pair(static_pointer_cast<FuncValue>(autov::ptr_to_int())->call(elems), state));
        else if (op_eq(expr->op,"int_to_ptr"))
            states.push_back(std::make_pair(int_to_ptr_value(proj, elems), state));
        else if (op_eq(expr->op, "z_to_nat"))
            states.push_back(std::make_pair(static_pointer_cast<FuncValue>(autov::z_to_nat())->call(elems), state));
        else if (op_eq(expr->op,"zmap_init") || op_eq(expr->op, "ZMap.init"))
            states.push_back(std::make_pair(val->get_type()->from_z3_value(z3::const_array(static_pointer_cast<ZMap>(val->get_type())->key_sort(), elems[0]->get_z3_value())), state));
        else if (std::holds_alternative<string>(expr->op)) {
            auto const sym = std::get<string>(expr->op);
            auto const info = proj->symbols[sym];
            if (info.kind == SymbolKind::StructConstr) {
                states.push_back(std::make_pair(static_pointer_cast<Struct>(val->get_type())->construct(elems), state));
            } else if (info.kind == SymbolKind::IndConstructor) {
                states.push_back(std::make_pair(static_pointer_cast<Inductive>(val->get_type())->construct(sym, elems), state));
            } else if (info.kind == SymbolKind::Def) {
                auto df = proj->defs[sym].get();
                if(auto loop = instance_of(df, Fixpoint)) {
                    if(proj->loop_invs.find(df->name) != proj->loop_invs.end()) {
                        auto& invs = proj->loop_invs[df->name];
                        //auto preconds = proj->cmds.InitRely[df->name];
                        auto const var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
                        auto const conds = std::make_shared<vector<z3::expr>>();
                        //declare loop arguments
                        for (auto const &arg : *loop->args) {
                            if (arg->name != "_N_") {
                                (*var)[arg->name] = arg->type->declare(loop->name + "_" + arg->name, 0); //current
                                (*var)[arg->name + "_old"] = arg->type->declare(loop->name + "_" + arg->name + "_old", 0); //initial
                            }
                        }

                        //ret_x == f(a,b,c,d)
                        //ret_x[0] = ret_x_0, ret_x[1] = ret_x_1....
                        //inv[a/ret_x_1,.....] = true
                        auto const func_call = df->absf()->call(elems);
                        auto const ret = func_call->get_type()->declare("ret", val->nid);

                        //ret_x = f(a,b,c,d)
                        auto const eqformula = z3_eq(ret->get_z3_value(), func_call->get_z3_value());

                        // auto some = instance_of(ret.get(), IndValue);

                        //ret_tuple
                        // auto rettuple = instance_of(some->get("value").get(), StructValue);

                        // auto rettype = loop->rettype;
                        // auto rettypesome = instance_of(rettype.get(), Option);
                        // auto tupletype = instance_of(rettypesome->elem_type.get(), Tuple);

                        //after checks, we should assume that inv is hold after loop. i.e
                        //assume _N_ == 0 and I (postcond)
                        auto const after_var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
                        auto const after_conds = std::make_shared<vector<z3::expr>>();

                        ///aggregate all the invs together into one conjunctives
                        SpecNode* aggreinv = new BoolConst(true);
                        for(auto &inv : invs) {
                            auto elems = new vector<unique_ptr<SpecNode>>();
                            elems->push_back(unique_ptr<SpecNode>(aggreinv));
                            elems->push_back(inv->deep_copy());
                            aggreinv = new Expr(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
                        }

                        unique_ptr<SpecNode> before_inv = aggreinv->deep_copy();
                        //subst invariant inv[ret_x[0]/a' ret_x[1]/b' ret_x[2]/c' ret_x[3]/d']
                        for(auto const &arg : *loop->args) {
                            if (arg->name != "_N_") {
                                auto const sym = make_unique<Symbol>(loop->name + "_" + arg->name, arg->type);
                                bool succ;
                                before_inv = subst(std::move(before_inv), arg->name, sym.get(), succ);
                            }
                        }
                        auto vc = z3ctx.bool_val(true);
                        auto const invval = z3_eval(proj, before_inv.get(), make_shared<EvalState>(var, conds));
                        int const i = 0;
                        for(auto const &arg : *loop->args) {
                            auto name = arg->name;
                            //instantiate variable to each element
                            auto const z3_eq_expr = elems.at(i)->get_z3_value() == (*var)[name]->get_z3_value();
                            vc = vc && z3_eq_expr;
                        }
                        vc = vc && (*var)["st_old"]->get_z3_value() == elems.back()->get_z3_value();
                        auto const res = z3_check(state, vc && invval->get_z3_value(),nullptr, 200);
                        if(res == Z3Result::False || res == Z3Result::Unknown || res == Z3Result::Sat) {
                            LOG_ERROR << "Precondition can't infer loop invariant";
                            return;
                        }

                        states.push_back(std::make_pair(func_call, state));
                    } else {
                        LOG_ERROR << "no loop invariant specified";
                    }
                } else {
                    states.push_back(std::make_pair(df->absf()->call(elems), state));
                }
            } else if (info.kind == SymbolKind::Decl) {
                auto df = proj->decls[sym].get();
                auto const absf = static_pointer_cast<FuncValue>(df->absf());
                states.push_back(std::make_pair(absf->call(elems), state));
            } else {
                std::cout << "expr: " << string(*expr) << std::endl;
                throw std::runtime_error("Unknown symbol: " + sym);
            }
        } else if (std::holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
            auto const op = z3_eval(proj, std::get<unique_ptr<SpecNode>>(expr->op).get(), state);
            if (auto const func = dynamic_pointer_cast<FuncValue>(op))
                states.push_back(std::make_pair(func->call(elems), state));
        } else {
            throw std::runtime_error("Unknown expression: " + string(*expr));
        }

    } else if (auto match = instance_of(val, Match)) {
        auto const src = z3_eval(proj, match->src.get(), state);
        shared_ptr<SpecValue> match_val = nullptr;
        for (auto pm = match->match_list->rbegin(); pm != match->match_list->rend(); pm++) {
            unordered_map<string, shared_ptr<SpecValue>> vars;
            unordered_map<string, shared_ptr<SpecValue>> assigns;
            auto const cond =
                match_arm_condition(proj, val, (*pm)->pattern.get(), src, vars, assigns);
            auto const z3_res = z3_check(state, cond);
            if (z3_res == Z3Result::False) {
                continue;
            }
            //new state, v1 = val1, v2 = val2,...., body
            auto const new_state = state->copy();
            for (auto v = assigns.begin(); v != assigns.end(); v++) {
                new_state->vars->emplace(v->first, v->second);
            }
            // new_state->conds->push_back(cond);
            if (match_val == nullptr) {
                match_val = z3_eval(proj, (*pm)->body.get(), new_state);
            } else {
                auto const then_val = z3_eval(proj, (*pm)->body.get(), new_state);
                /** Optimization: instantiate Exists:
                 *      Original: (vars: v = src), if ((Exists v' (v' = src)) then Prop(v') else True)
                 *      --> v is the evidence of (Exists...)
                 *      --> (Exists v' (v' = src)) == True
                 *      --> Instantiate v' by v
                 *  * It's always sufficient to jsut have Prop(v) for proof!
                 */
                if (match_val->get_z3_value().is_true()) {
                    match_val = then_val;
                } else {
                    match_val = match_val->get_type()->from_z3_value(z3::ite(cond, then_val->get_z3_value(), match_val->get_z3_value()));
                }
            }
        }
        if (match_val == nullptr) {
            auto const opt = static_pointer_cast<Option>(val->get_type());
            return states.push_back(std::make_pair(opt->construct("None", {}), state));
        } else {
            return states.push_back(std::make_pair(match_val, state));
        }
    } else if (auto rely = instance_of(val, Rely)) {
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> condret;
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
        symbolic(proj, rely->prop.get(), state, condret);
        for(auto const &condstate : condret) {
            auto const cond = condstate.first;
            auto const condst = condstate.second;
            auto const res = z3_check(condst, cond->get_z3_value());
            if (res == Z3Result::Unknown || res == Z3Result::Sat) {
                auto const true_state = state->copy();
                true_state->conds->push_back(cond->get_z3_value());
                symbolic(proj, rely->body.get(), true_state, retstates);
                auto const false_state = state->copy();
                false_state->conds->push_back(!cond->get_z3_value());

                auto const none = static_pointer_cast<Option>(val->get_type())->construct("None", {});
                retstates.push_back(std::make_pair(none, false_state));
            } else if (res == Z3Result::True) {
                auto const true_state = state->copy();
                true_state->conds->push_back(cond->get_z3_value());
                symbolic(proj, rely->body.get(), true_state, retstates);
            } else {
                auto const none = static_pointer_cast<Option>(val->get_type())->construct("None", {});
                auto const false_state = state->copy();
                false_state->conds->push_back(!cond->get_z3_value());
                retstates.push_back(std::make_pair(none, false_state));
            }
        }
        for(auto const &s: retstates) {
            states.push_back(s);
        }
    } else if (auto iff = instance_of(val, If)) {
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> condret;
        symbolic(proj, iff->cond.get(), state, condret);
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
        for(auto const &condstate : condret) {
            auto const cond = condstate.first;
            auto const condst = condstate.second;
            auto const res = z3_check(condst, cond->get_z3_value());
            if (res == Z3Result::Unknown || res == Z3Result::Sat)
            {
                auto const true_state = state->copy();
                true_state->conds->push_back(cond->get_z3_value());
                symbolic(proj, iff->then_body.get(), true_state, retstates);
                auto const false_state = state->copy();
                false_state->conds->push_back(!cond->get_z3_value());
                symbolic(proj, iff->else_body.get(), false_state, retstates);
            }
            else if (res == Z3Result::True)
            {
                auto const true_state = state->copy();
                true_state->conds->push_back(cond->get_z3_value());
                //vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
                symbolic(proj, iff->then_body.get(), true_state, retstates);
            }
            else
            {
                //vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
                auto const false_state = state->copy();
                false_state->conds->push_back(!cond->get_z3_value());
                symbolic(proj, iff->else_body.get(), false_state, retstates);
            }
        }
        for(auto const &s: retstates) {
            states.push_back(s);
        }
    } else if (auto forall = instance_of(val, Forall)) {
        z3::expr_vector vars(z3ctx);
        for (auto v = forall->vars->begin(); v != forall->vars->end(); v++)
        {
            auto const var = (*v)->type->declare((*v)->name, val->nid);
            state->vars->emplace((*v)->name, var);
            vars.push_back(var->get_z3_value());
        }
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
        symbolic(proj, forall->body.get(), state, retstates);
        for(auto const &retstate: retstates) {
            auto const st = retstate.second;
            auto const body = retstate.first;
            states.push_back(std::make_pair((make_shared<BoolValue>(z3::forall(vars, body->value))),st));
        }
    } else if (auto exsts = instance_of(val, Exists)) {
        z3::expr_vector vars(z3ctx);
        for (auto v = exsts->vars->begin(); v != exsts->vars->end(); v++)
        {
            auto const var = (*v)->type->declare((*v)->name, val->nid);
            state->vars->emplace((*v)->name, var);
            vars.push_back(var->get_z3_value());
        }
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;

        symbolic(proj, exsts->body.get(), state, retstates);
        for(auto const &retstate: retstates) {
            auto const st = retstate.second;
            auto const body = retstate.first;
            states.push_back(std::make_pair(make_shared<BoolValue>(z3::exists(vars, body->value)), state));
        }
    } else {
        throw std::runtime_error("Unknown node type: " + string(*val));
    }


}

z3::func_decl formulate_rec_function(Project* proj, Fixpoint* fixpoint) {
    z3::sort_vector sorts(z3ctx);
    z3::expr_vector args(z3ctx);
    // int i = 0;
    auto const n = z3ctx.int_const("_N_");
    for(auto const &arg: *fixpoint->args) {
        sorts.push_back(arg->type->get_z3_type());
        args.push_back(arg->type->declare(arg->name, 0)->get_z3_value());
    }

    auto rec_fun = z3ctx.recfun(fixpoint->name.c_str(), sorts, fixpoint->rettype->get_z3_type());
    auto body = instance_of(fixpoint->body().get(), Match);
    //auto basecase = body->match_list->at(0)->body.get();
    shared_ptr<unordered_map<string, shared_ptr<SpecValue>>> const vars;
    shared_ptr<vector<z3::expr>> const conds;
    auto const state = make_shared<EvalState>(vars, conds);
    set<string> used_fix;
    auto const val = z3_eval(proj, body, state, false, true, used_fix);
    //auto inductcase = body->match_list->at(1)->body.get();
    //need to extract the case
    z3ctx.recdef(rec_fun, args, val->get_z3_value());
    return rec_fun;
}

z3::expr formulate_function(Project* proj, Definition* def) {
    z3::expr_vector args(z3ctx);
    auto const vars = make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    auto const conds = make_shared<vector<z3::expr>>();

    for(auto const &arg: *def->args) {
        //sorts.push_back(arg->type->get_z3_type());
        args.push_back(arg->type->declare(arg->name, 0)->get_z3_value());
        (*vars)[arg->name] = arg->type->declare(arg->name, 0);
    }
    auto body = def->body().get();

    //add known variables
    auto const state = make_shared<EvalState>(vars, conds);
    set<string> used_fix;
    auto const val = z3_eval(proj, body, state, false, true, used_fix);
    return z3::lambda(args, val->get_z3_value());
}
//needs to find a way to distinguish when to split state using symbolic and when not by directly using ite node of z3.
//ite is like a state merging.

shared_ptr<SpecValue> z3_eval(Project* proj, SpecNode* val, const shared_ptr<EvalState>& state, bool check_loop) {
    shared_ptr<SpecValue> result;

    if (auto sym = instance_of(val, Symbol)) {
        if (sym->text != "None" && sym->text != "nil" && state->vars->find(sym->text) != state->vars->end()) {
            result = state->vars->at(sym->text);
        } else if (proj->defs.find(sym->text) != proj->defs.end()) {
            auto df = proj->defs[sym->text].get();
            assert(df->args->size() == 0);
            if (auto c = instance_of(df->body().get(), Const)) {
                result = z3_eval(proj, c, state, check_loop);
            } else {
                result = df->absf()->call({});
            }
        } else if (proj->decls.find(sym->text) != proj->decls.end()) {
            auto decl = proj->decls[sym->text].get();
            assert(!dynamic_pointer_cast<Function>(decl->type));
            result = decl->absf();
        } else if (proj->is_ind_constr(sym->text)) {
            result = static_pointer_cast<Inductive>(sym->get_type())->construct(sym->text, {});
        } else if (proj->symbols.find(sym->text) != proj->symbols.end() &&
                   proj->symbols[sym->text].kind == SymbolKind::StructElem) {
            result = make_shared<StringValue>(sym->text);
        } else {
            throw std::runtime_error("Unknown symbol: " + sym->text);
        }
    } else if (auto con = instance_of(val, Const)) {
        if (auto intc = std::get_if<unsigned long>(&con->value)) {
            auto icon = instance_of(val, IntConst);
            if (icon->is_signed()) {
                long const v = std::get<unsigned long>(icon->value);
                result = make_shared<IntValue>(v, icon->is_signed());
            } else {
                unsigned long const v = std::get<unsigned long>(icon->value);
                result = make_shared<IntValue>(v, icon->is_signed());
            }
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            result = make_shared<BoolValue>(*boolc);
        } else if (auto strc = std::get_if<string>(&con->value)) {
            result = make_shared<StringValue>(*strc);
        } else if (std::get_if<double>(&con->value)) {
            // Unreachable: the front end turns a floating point literal into a
            // Symbol naming a declared constant, and the .main.v parser builds
            // no double Const at all.  It used to be given an uninterpreted
            // integer here while the emitted Coq printed the decimal, so the
            // spec and the solver disagreed about the same literal.  Loud
            // rather than silent if one ever arrives again.
            throw std::runtime_error("a floating point Const reached z3_eval: "
                                     "float literals should be declared constants");
        }
    } else if (auto expr = instance_of(val, Expr)) {
        vector<shared_ptr<SpecValue>> elems;

        // XXX: this is a hack to handle List.empty which takes a type as an argument
        if (!op_eq(expr->op, "List.empty")) {
            for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
                elems.push_back(z3_eval(proj, e->get(), state,  check_loop));
            }
        }

        if (op_eq(expr->op, Expr::None)){
            result = static_pointer_cast<Inductive>(val->get_type())->construct("None", {});
        }
        else if (op_eq(expr->op, Expr::binops::ADD) ){

            if (is_int_type(expr->type)) {
                result = static_pointer_cast<IntValue>(elems[0])->add(static_pointer_cast<IntValue>(elems[1]));
            } else if (is_int_zmap_type(expr->type)){
                // find the definition of the zmap_z_add function
                // use func->call to generate the right z3 expr
                auto const func = proj->defs.find("zmap_z_add");
                auto const absf = func->second->absf();
                result = absf->call(elems);
            }
        }
        else if (op_eq(expr->op, Expr::binops::MINUS)) {
            if (expr->elems->size() == 2)
                result = static_pointer_cast<IntValue>(elems[0])->sub(static_pointer_cast<IntValue>(elems[1]));
            else
                result = static_pointer_cast<IntValue>(elems[0])->neg();
        }
        else if (op_eq(expr->op, Expr::binops::MULT))
            result = static_pointer_cast<IntValue>(elems[0])->mul(static_pointer_cast<IntValue>(elems[1]));
        else if (op_eq(expr->op, Expr::binops::DIV))
            result = static_pointer_cast<IntValue>(elems[0])->div(static_pointer_cast<IntValue>(elems[1]));
        else if (op_eq(expr->op, Expr::binops::MOD))
            result = static_pointer_cast<IntValue>(elems[0])->mod(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::LSHIFT))
            result = static_pointer_cast<IntValue>(elems[0])->shiftl(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::RSHIFT))
            result = static_pointer_cast<IntValue>(elems[0])->shiftr(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::BITAND))
            result = static_pointer_cast<IntValue>(elems[0])->land(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::BITOR))
            result = static_pointer_cast<IntValue>(elems[0])->lor(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, "Z.lxor"))
            result = static_pointer_cast<IntValue>(elems[0])->lxor(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, "Z.quot"))
            result = static_pointer_cast<IntValue>(elems[0])->quot(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, "Z.rem"))
            result = static_pointer_cast<IntValue>(elems[0])->rem(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, "Z.lnot"))
            result = static_pointer_cast<IntValue>(elems[0])->lnot();
        else if(op_eq(expr->op, "Z.testbit"))
            result = static_pointer_cast<IntValue>(elems[0])->testbit(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, "Z.setbit"))
            result = static_pointer_cast<IntValue>(elems[0])->setbit(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, "Z.clearbit"))
            result = static_pointer_cast<IntValue>(elems[0])->clearbit(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, "Z.xorb"))
            result = static_pointer_cast<IntValue>(elems[0])->xorb(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::EQUAL))
            result = Prop::PROP->from_z3_value(z3_eq(elems[0]->get_z3_value(), elems[1]->get_z3_value()).simplify());
        else if(op_eq(expr->op, Expr::binops::BEQ))
            result = static_pointer_cast<IntValue>(elems[0])->eq(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::SEQ))
            result = static_pointer_cast<StringValue>(elems[0])->eq(static_pointer_cast<StringValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::NOT_EQUAL))
            result = Prop::PROP->from_z3_value(z3_ne(elems[0]->get_z3_value(), elems[1]->get_z3_value()));
        else if(op_eq(expr->op, Expr::binops::BNE))
            result = static_pointer_cast<IntValue>(elems[0])->ne(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::SNE))
            result = static_pointer_cast<StringValue>(elems[0])->ne(static_pointer_cast<StringValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::GT) || op_eq(expr->op, Expr::binops::BGT))
            result = static_pointer_cast<IntValue>(elems[0])->gt(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::GTE) || op_eq(expr->op, Expr::binops::BGE))
            result = static_pointer_cast<IntValue>(elems[0])->ge(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::LT) || op_eq(expr->op, Expr::binops::BLT))
            result = static_pointer_cast<IntValue>(elems[0])->lt(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::binops::LTE) || op_eq(expr->op, Expr::binops::BLE))
            result = static_pointer_cast<IntValue>(elems[0])->le(static_pointer_cast<IntValue>(elems[1]));
        else if(op_eq(expr->op, Expr::ops::NOT) || op_eq(expr->op, Expr::ops::BNOT))
            result = static_pointer_cast<BoolValue>(elems[0])->negb();
        else if(op_eq(expr->op, Expr::binops::AND) || op_eq(expr->op, Expr::binops::BAND)){
            auto left = static_pointer_cast<BoolValue>(elems[0]);
            auto right = static_pointer_cast<BoolValue>(elems[1]);
            if(auto const iv = dynamic_pointer_cast<IntValue>(elems[0])){
                auto const zero_const = make_shared<IntValue>(0ul);
                left = iv->ne(zero_const);
            }
            if(auto const iv = dynamic_pointer_cast<IntValue>(elems[1])){
                auto const zero_const = make_shared<IntValue>(0ul);
                right = iv->ne(zero_const);
            }
            result = left->andb(right);
        } else if (op_eq(expr->op, Expr::binops::OR) || op_eq(expr->op, Expr::binops::BOR)){
            auto left = static_pointer_cast<BoolValue>(elems[0]);
            auto right = static_pointer_cast<BoolValue>(elems[1]);
            if(auto const iv = dynamic_pointer_cast<IntValue>(elems[0])){
                auto const zero_const = make_shared<IntValue>(0ul);
                left = iv->ne(zero_const);
            }
            if(auto const iv = dynamic_pointer_cast<IntValue>(elems[1])){
                auto const zero_const = make_shared<IntValue>(0ul);
                right = iv->ne(zero_const);
            }
            result = left->orb(right);
        } else if (op_eq(expr->op, "xorb"))
            result = static_pointer_cast<BoolValue>(elems[0])->xorb(static_pointer_cast<BoolValue>(elems[1]));
        else if (op_eq(expr->op, Expr::binops::IMPLIES))
            result = static_pointer_cast<BoolValue>(elems[0])->implies(static_pointer_cast<BoolValue>(elems[1]));
        else if (op_eq(expr->op, Expr::GET)) {
            if(auto const zmv = dynamic_pointer_cast<ZMapValue>(elems[0])){
                result = zmv->get(static_pointer_cast<IntValue>(elems[1]));
            } else if(auto const smv = dynamic_pointer_cast<SMapValue>(elems[0])){
                result = smv->get(static_pointer_cast<StringValue>(elems[1]));
            } else { throw new std::runtime_error("Unknown map type."); }
        } else if (op_eq(expr->op, Expr::SET)) {
            if(auto const zmv = dynamic_pointer_cast<ZMapValue>(elems[0])){
                result = zmv->set(static_pointer_cast<IntValue>(elems[1]), elems[2]);
            } else if(auto const smv = dynamic_pointer_cast<SMapValue>(elems[0])){
                result = smv->set(static_pointer_cast<StringValue>(elems[1]), elems[2]);
            } else { throw new std::runtime_error("Unknown map type."); }
        } else if (op_eq(expr->op, Expr::RecordGet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            for (int i = 1; i < expr->elems->size(); i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            result = elems.back();
        } else if (op_eq(expr->op, Expr::RecordSet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            // expr.elem[n-1]: value

            // First read-off all the old fields, except the one to be updated
            for (int i = 1; i < expr->elems->size() - 2; i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            // Update the field
            elems[expr->elems->size() - 2] = elems.back();
            // Then update the record
            for (int i = expr->elems->size() - 2; i > 0; i--) {
                elems[i - 1] = static_pointer_cast<StructValue>(elems[i - 1])->set(static_cast<Symbol *>(expr->elems->at(i).get())->text, elems[i]);
            }

            result = elems[0];
        } else if (op_eq(expr->op, Expr::binops::APPEND)) {
            auto const list = static_pointer_cast<ListValue>(elems[1]);
            auto const new_list = list->append(static_pointer_cast<SpecValue>(elems[0]));

            result = new_list;
        } else if (op_eq(expr->op, Expr::binops::CONCAT)) {
            auto const list1 = static_pointer_cast<ListValue>(elems[0]);
            auto const new_list = list1->concat(static_pointer_cast<ListValue>(elems[1]));

            result = new_list;
        } else if (op_eq(expr->op, Expr::ops::Some))
            result = static_pointer_cast<Option>(val->get_type())->construct("Some", {elems[0]});
        else if (op_eq(expr->op,Expr::ops::Tuple)) {
            result = static_pointer_cast<Tuple>(val->get_type())->construct(elems);
        } else if (op_eq(expr->op, "prop"))
            result = elems[0];
        else if (auto const reduced = width_reduction(expr->op, elems))
            result = make_shared<IntValue>(reduced->simplify());
        else if (op_eq(expr->op,"ptr_to_int"))
            result = static_pointer_cast<FuncValue>(autov::ptr_to_int())->call(elems);
        else if (op_eq(expr->op,"int_to_ptr"))
            result = int_to_ptr_value(proj, elems);
        else if (op_eq(expr->op, "z_to_nat"))
            result = static_pointer_cast<FuncValue>(autov::z_to_nat())->call(elems);
        else if (op_eq(expr->op,"zmap_init") || op_eq(expr->op, "ZMap.init"))
            result = val->get_type()->from_z3_value(z3::const_array(static_pointer_cast<ZMap>(val->get_type())->key_sort(), elems[0]->get_z3_value()));
        else if (op_eq(expr->op, "List.is_empty"))
            result = static_pointer_cast<ListValue>(elems[0])->is_empty();
        else if (op_eq(expr->op, "List.empty"))
            result = ListValue::empty(val->get_type());
        else if (op_eq(expr->op, "List.eq"))
            result = static_pointer_cast<ListValue>(elems[0])->eq(static_pointer_cast<ListValue>(elems[1]));
        else if (std::holds_alternative<string>(expr->op)) {
            auto const sym = std::get<string>(expr->op);
            auto const info = proj->symbols[sym];
            if (info.kind == SymbolKind::StructConstr) {
                auto const struct_t = proj->structs[info.info];
                result = struct_t->construct(elems);
            } else if (info.kind == SymbolKind::IndConstructor) {
                result = static_pointer_cast<Inductive>(val->get_type())->construct(sym, elems);
            } else if (info.kind == SymbolKind::Def) {
                auto df = proj->defs[sym].get();
                // LOG_DEBUG << string(*val);
                result = df->absf()->call(elems);
            } else if (info.kind == SymbolKind::Decl) {
                if(sym != "lens_v") {
                    auto df = proj->decls[sym].get();
                    auto const absf = static_pointer_cast<FuncValue>(df->absf());
                    result = absf->call(elems);
                } else {
                    auto id = static_cast<IntConst*>(expr->elems->at(0).get());
                    unsigned long const idi = std::get<unsigned long>(id->value);
                    // auto arg_types = make_shared<vector<shared_ptr<SpecType>>>();
                    // //arg_types->push_back(expr->elems->at(0)->get_type());

                    // auto lens_type = make_shared<Function>(expr->type, arg_types);
                    // auto lens_v = make_unique<Declaration>("lens_v_" + std::to_string(idi), lens_type);
                    result = expr->type->declare("lens_v_" + std::to_string(idi), 0);
                }
            } else {
                std::cerr << "expr: " << string(*expr) << std::endl;
                // auto typ = elems[0].get()->typ;
                // auto typc = dynamic_cast<Struct*>(typ.get());
                throw UndefinedSpecException(sym);
            }
        } else if (std::holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
            auto const op = z3_eval(proj, std::get<unique_ptr<SpecNode>>(expr->op).get(), state,  check_loop);
            if (auto const func = dynamic_pointer_cast<FuncValue>(op))
                result = func->call(elems);
        } else {
            throw std::runtime_error("Unknown expression: " + string(*expr));

        }

    } else if (auto match = instance_of(val, Match)) {
        auto const src = z3_eval(proj, match->src.get(), state,  check_loop);
        shared_ptr<SpecValue> match_val = nullptr;
        for (auto pm = match->match_list->rbegin(); pm != match->match_list->rend(); pm++) {
            unordered_map<string, shared_ptr<SpecValue>> vars;
            unordered_map<string, shared_ptr<SpecValue>> assigns;
            auto const cond =
                match_arm_condition(proj, val, (*pm)->pattern.get(), src, vars, assigns);

            if (!OPTS.__OPT_ON_MATCH) {
                // LOG_INFO << "[PROFILE]" << "z3_eval: z3_check: match stands: " << string(*val);
                PROFILE_START(match_eval_check);
                PROFILE_START(eval_check);
                auto const z3_res = Z3Result::Unknown;
                // auto z3_res = z3_check(state, cond);
                PROFILE_END(eval_check);
                PROFILE_END(match_eval_check);
                if (z3_res == Z3Result::False) {
                    // profile_log_eval_match_solved(string(*(match->src.get())));
                    continue;
                } else if (z3_res == Z3Result::True) {
                    // profile_log_eval_match_solved(string(*(match->src.get())));
                } else {
                    // profile_log_eval_match_unsolved(string(*(match->src.get())));
                }
            }
            auto const new_state = state->copy();
            for (auto v = assigns.begin(); v != assigns.end(); v++) {
                (*new_state->vars)[v->first] = v->second;
            }

            if (match_val == nullptr) {
                // LOG_DEBUG << "match body:" << string(*(*pm)->body);
                match_val = z3_eval(proj, (*pm)->body.get(), new_state,  check_loop);
                if(match_val->get_z3_value().get_sort().is_bool()) {
                    match_val = make_shared<SpecValue>(match_val->typ, match_val->get_z3_value() && cond);
                }
            } else {
                auto const then_val = z3_eval(proj, (*pm)->body.get(), new_state,  check_loop);
                /** Optimization: instantiate Exists:
                 *      Original: (vars: v = src), if ((Exists v' (v' = src)) then Prop(v') else True)
                 *      --> v is the evidence of (Exists...)
                 *      --> (Exists v' (v' = src)) == True
                 *      --> Instantiate v' by v
                 *  * It's always sufficient to jsut have Prop(v) for proof!
                 */
                if (match_val->get_z3_value().is_true()) {
                    if(then_val->get_z3_value().get_sort().is_bool()) {
                        match_val = make_shared<SpecValue>(then_val->typ, then_val->get_z3_value() && cond);
                    } else {
                        match_val = then_val;
                    }
                } else {
                    match_val = match_val->get_type()->from_z3_value(z3::ite(cond, then_val->get_z3_value(), match_val->get_z3_value()));
                }
            }

        }
        if (match_val == nullptr) {
            auto const opt = static_pointer_cast<Option>(val->get_type());
            result = opt->construct("None", {});
        } else {
            result = match_val;
        }
    } else if (auto rely = instance_of(val, Rely)) {
        auto const cond = z3_eval(proj, rely->prop.get(), state,  check_loop);
        auto const res = Z3Result::Unknown;
        // auto res = z3_check(state, cond->get_z3_value());
        if (res == Z3Result::Unknown || res == Z3Result::Sat) {
            //LOG_DEBUG << "rely body:" << string(*rely->body);
            auto const body = z3_eval(proj, rely->body.get(), state,  check_loop);
            auto const none = static_pointer_cast<Option>(val->get_type())->construct("None", {});

            auto const z3_val = z3::ite(cond->get_z3_value(), body->get_z3_value(), none->get_z3_value());
            result = rely->get_type()->from_z3_value(z3_val.simplify());
        } else if (res == Z3Result::True) {
            result = z3_eval(proj, rely->body.get(), state,  check_loop);
        } else {
            // profile_log_eval_rely_solved(string(*rely->prop.get()));
            result = static_pointer_cast<Option>(val->get_type())->construct("None", {});
        }
    }
    else if (auto iff = instance_of(val, If))
    {
        // LOG_DEBUG << "z3_eval " << random_code << ": " << string(*val) << std::endl;
        // LOG_DEBUG << "z3_eval ty " << random_code << ": " << val->type->name << std::endl;

        auto const c = z3_eval(proj, iff->cond.get(), state,  check_loop);
        PROFILE_START(if_eval_check);
        PROFILE_START(eval_check);
        // LOG_DEBUG << "In z3_eval, checking if cond.";
        if(!c){
            LOG_DEBUG << "In z3_eval, if cond is nullptr!!!.";
            assert(false);
        }
        // auto res = z3_check(state, c->get_z3_value());
        auto const res = Z3Result::Unknown;
        // LOG_DEBUG << "In z3_eval, checked if cond. ";
        PROFILE_END(eval_check);
        PROFILE_END(if_eval_check);
        if (res == Z3Result::Unknown || res == Z3Result::Sat)
        {
            // profile_log_eval_if_unsolved(string(*iff->cond.get()));
            auto const true_state = state->copy();
            true_state->conds->push_back(c->get_z3_value());
        // LOG_DEBUG << "In z3_eval, evaluating then body.";
            auto const True = z3_eval(proj, iff->then_body.get(), true_state,  check_loop);
            auto const false_state = state->copy();
            false_state->conds->push_back(!c->get_z3_value());
        // LOG_DEBUG << "In z3_eval, evaluating else body.";
            auto const False = z3_eval(proj, iff->else_body.get(), false_state,  check_loop);
            auto const z3_val = z3::ite(c->get_z3_value(), True->get_z3_value(), False->get_z3_value());
            result = iff->get_type()->from_z3_value(z3_val.simplify());
        }
        else if (res == Z3Result::True)
        {
            // profile_log_eval_if_solved(string(*iff->cond.get()));
            state->conds->push_back(c->get_z3_value());
            result = z3_eval(proj, iff->then_body.get(), state,  check_loop);
        }
        else
        {
            // profile_log_eval_if_solved(string(*iff->cond.get()));
            state->conds->push_back(!c->get_z3_value());
            result = z3_eval(proj, iff->else_body.get(), state,  check_loop);
        }
        // LOG_DEBUG << "z3_eval done " << random_code;

    }
    else if (auto forall = instance_of(val, Forall))
    {
        z3::expr_vector vars(z3ctx);
        std::vector<z3::expr> hypos;
        auto const new_state = state->copy();
        for (auto v = forall->vars->begin(); v != forall->vars->end(); v++)
        {
            if ((*v)->type) {
                auto const var = (*v)->type->declare((*v)->name, val->nid);
                (*new_state->vars)[(*v)->name] = var;
                vars.push_back(var->get_z3_value());
            } else {
                // bounded variable v is prop, push into state
                auto const prop = z3_eval(proj, (*v)->expr.get(), new_state, check_loop);
                hypos.push_back(prop->get_z3_value());
            }
        }
        /** bounded variables may have a newer nid over cached z3 values, so we need to clear cached value first  */
        auto const body = z3_eval(proj, forall->body.get(), new_state, check_loop);
        auto p = body->get_z3_value();

        for (const auto &h : hypos) {
            p = z3::implies(h, p);
        }
        result = make_shared<BoolValue>(z3::forall(vars, p));
        // return make_shared<BoolValue>(z3::forall(vars, body->value));
    }
    else if (auto exsts = instance_of(val, Exists))
    {
        z3::expr_vector vars(z3ctx);
        auto const new_state = state->copy();
        for (auto v = exsts->vars->begin(); v != exsts->vars->end(); v++)
        {
            auto const var = (*v)->type->declare((*v)->name, val->nid);
            (*new_state->vars)[(*v)->name] = var;
            vars.push_back(var->get_z3_value());
        }
        auto const body = z3_eval(proj, exsts->body.get(), new_state, check_loop);
        result = make_shared<BoolValue>(z3::exists(vars, body->value));
    }else {
    throw std::runtime_error("Unknown node type: " + string(*val));
    }
    return result;
}

shared_ptr<SpecValue> z3_eval(Project* proj, SpecNode* val, const shared_ptr<EvalState>& state, bool check_loop, bool unfold, set<string>& used_fixpoint) {
    // std::cout << "z3_eval: " << string(*val) << std::endl;


    if (auto sym = instance_of(val, Symbol)) {
        if (sym->text != "None" && sym->text != "nil" && state->vars->find(sym->text) != state->vars->end()) {
            return state->vars->at(sym->text);
        } else if (proj->defs.find(sym->text) != proj->defs.end()) {
            auto df = proj->defs[sym->text].get();
            assert(df->args->size() == 0);
            if (auto c = instance_of(df->body().get(), Const)) {
                return z3_eval(proj, c, state, check_loop, unfold, used_fixpoint);
            } else {
                return df->absf()->call({});
            }
        } else if (proj->decls.find(sym->text) != proj->decls.end()) {
            auto decl = proj->decls[sym->text].get();
            assert(!dynamic_pointer_cast<Function>(decl->type));
            return decl->absf();
        } else if (proj->is_ind_constr(sym->text)) {
            return static_pointer_cast<Inductive>(sym->get_type())->construct(sym->text, {});
        } else if (proj->symbols.find(sym->text) != proj->symbols.end() &&
                   proj->symbols[sym->text].kind == SymbolKind::StructElem) {
            return make_shared<StringValue>(sym->text);
        } else {
            throw std::runtime_error("Unknown symbol: " + sym->text);
        }
    } else if (auto con = instance_of(val, Const)) {
        if (auto intc = std::get_if<unsigned long>(&con->value)) {
            auto icon = instance_of(val, IntConst);
            return make_shared<IntValue>(*intc, icon->is_signed());
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            return make_shared<BoolValue>(*boolc);
        } else if (auto strc = std::get_if<string>(&con->value)) {
            return make_shared<StringValue>(*strc);
        }
    } else if (auto expr = instance_of(val, Expr)) {
        vector<shared_ptr<SpecValue>> elems;
        // LOG_DEBUG << "evaluating expr: " << string(*val);
        // XXX: this is a hack to handle List.empty which takes a type as an argument
        if (!op_eq(expr->op, "List.empty")) {
            for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
                elems.push_back(z3_eval(proj, e->get(), state,  check_loop, unfold, used_fixpoint));
            }
        }

        if (op_eq(expr->op, Expr::None))
            return static_pointer_cast<Inductive>(val->get_type())->construct("None", {});
        if (op_eq(expr->op, Expr::binops::ADD)){
            if (is_int_type(expr->type)) {
                return static_pointer_cast<IntValue>(elems[0])->add(static_pointer_cast<IntValue>(elems[1]));
            } else if (is_int_zmap_type(expr->type)){
                // find the definition of the zmap_z_add function
                // use func->call to generate the right z3 expr
                auto const func = proj->defs.find("zmap_z_add");
                auto const absf = func->second->absf();
                return absf->call(elems);
            }
        }
        if (op_eq(expr->op, Expr::binops::MINUS)) {
            if (expr->elems->size() == 2)
                return static_pointer_cast<IntValue>(elems[0])->sub(static_pointer_cast<IntValue>(elems[1]));
            else
                return static_pointer_cast<IntValue>(elems[0])->neg();
        }
        if (op_eq(expr->op, Expr::binops::MULT))
            return static_pointer_cast<IntValue>(elems[0])->mul(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::DIV))
            return static_pointer_cast<IntValue>(elems[0])->div(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::MOD))
            return static_pointer_cast<IntValue>(elems[0])->mod(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::LSHIFT))
            return static_pointer_cast<IntValue>(elems[0])->shiftl(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::RSHIFT))
            return static_pointer_cast<IntValue>(elems[0])->shiftr(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::BITAND))
            return static_pointer_cast<IntValue>(elems[0])->land(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::BITOR))
            return static_pointer_cast<IntValue>(elems[0])->lor(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, "Z.lxor"))
            return static_pointer_cast<IntValue>(elems[0])->lxor(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, "Z.quot"))
            return static_pointer_cast<IntValue>(elems[0])->quot(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, "Z.rem"))
            return static_pointer_cast<IntValue>(elems[0])->rem(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, "Z.lnot"))
            return static_pointer_cast<IntValue>(elems[0])->lnot();
        if (op_eq(expr->op, "Z.testbit"))
            return static_pointer_cast<IntValue>(elems[0])->testbit(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, "Z.setbit"))
            return static_pointer_cast<IntValue>(elems[0])->setbit(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, "Z.clearbit"))
            return static_pointer_cast<IntValue>(elems[0])->clearbit(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, "Z.xorb"))
            return static_pointer_cast<IntValue>(elems[0])->xorb(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::EQUAL))
            return Prop::PROP->from_z3_value(z3_eq(elems[0]->get_z3_value(), elems[1]->get_z3_value()).simplify());
        if (op_eq(expr->op, Expr::binops::BEQ))
            return static_pointer_cast<IntValue>(elems[0])->eq(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::SEQ))
            return static_pointer_cast<StringValue>(elems[0])->eq(static_pointer_cast<StringValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::NOT_EQUAL))
            return Prop::PROP->from_z3_value(z3_ne(elems[0]->get_z3_value(), elems[1]->get_z3_value()));
        if (op_eq(expr->op, Expr::binops::BNE))
            return static_pointer_cast<IntValue>(elems[0])->ne(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::SNE))
            return static_pointer_cast<StringValue>(elems[0])->ne(static_pointer_cast<StringValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::GT) || op_eq(expr->op, Expr::binops::BGT))
            return static_pointer_cast<IntValue>(elems[0])->gt(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::GTE) || op_eq(expr->op, Expr::binops::BGE))
            return static_pointer_cast<IntValue>(elems[0])->ge(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::LT) || op_eq(expr->op, Expr::binops::BLT))
            return static_pointer_cast<IntValue>(elems[0])->lt(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::LTE) || op_eq(expr->op, Expr::binops::BLE))
            return static_pointer_cast<IntValue>(elems[0])->le(static_pointer_cast<IntValue>(elems[1]));
        if (op_eq(expr->op, Expr::ops::NOT) || op_eq(expr->op, Expr::ops::BNOT))
            return static_pointer_cast<BoolValue>(elems[0])->negb();
        if (op_eq(expr->op, Expr::binops::AND) || op_eq(expr->op, Expr::binops::BAND))
            return static_pointer_cast<BoolValue>(elems[0])->andb(static_pointer_cast<BoolValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::OR) || op_eq(expr->op, Expr::binops::BOR))
            return static_pointer_cast<BoolValue>(elems[0])->orb(static_pointer_cast<BoolValue>(elems[1]));
        if (op_eq(expr->op, "xorb"))
            return static_pointer_cast<BoolValue>(elems[0])->xorb(static_pointer_cast<BoolValue>(elems[1]));
        if (op_eq(expr->op, Expr::binops::IMPLIES))
            return static_pointer_cast<BoolValue>(elems[0])->implies(static_pointer_cast<BoolValue>(elems[1]));
        else if (op_eq(expr->op, Expr::GET)) {
            auto const map_val = elems[0];
            if(auto const zmv = dynamic_pointer_cast<ZMapValue>(map_val)) {
                return zmv->get(static_pointer_cast<IntValue>(elems[1]));
            } else if(auto const smv = dynamic_pointer_cast<SMapValue>(map_val)){
                return smv->get(static_pointer_cast<StringValue>(elems[1]));
            }
        } else if (op_eq(expr->op, Expr::SET)) {
            auto const map_val = elems[0];
            if(auto const zmv = dynamic_pointer_cast<ZMapValue>(map_val)) {
                return zmv->set(static_pointer_cast<IntValue>(elems[1]), elems[2]);
            } else if(auto const smv = dynamic_pointer_cast<SMapValue>(map_val)){
                return smv->set(static_pointer_cast<StringValue>(elems[1]), elems[2]);
            }
        } else if (op_eq(expr->op, Expr::RecordGet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            for (int i = 1; i < expr->elems->size(); i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            return elems.back();
        } else if (op_eq(expr->op, Expr::RecordSet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            // expr.elem[n-1]: value

            // First read-off all the old fields, except the one to be updated
            for (int i = 1; i < expr->elems->size() - 2; i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            // Update the field
            elems[expr->elems->size() - 2] = elems.back();
            // Then update the record
            for (int i = expr->elems->size() - 2; i > 0; i--) {
                elems[i - 1] = static_pointer_cast<StructValue>(elems[i - 1])->set(static_cast<Symbol *>(expr->elems->at(i).get())->text, elems[i]);
            }

            return elems[0];
        } else if (op_eq(expr->op, Expr::binops::APPEND)) {
            auto const list = static_pointer_cast<ListValue>(elems[1]);
            auto const new_list = list->append(static_pointer_cast<SpecValue>(elems[0]));

            return new_list;
        } else if (op_eq(expr->op, Expr::binops::CONCAT)) {
            auto const list1 = static_pointer_cast<ListValue>(elems[0]);
            auto const new_list = list1->concat(static_pointer_cast<ListValue>(elems[1]));

            return new_list;
        } else if (op_eq(expr->op, Expr::ops::Some))
            return static_pointer_cast<Option>(val->get_type())->construct("Some", {elems[0]});
        else if (op_eq(expr->op,Expr::ops::Tuple)) {
            return static_pointer_cast<Tuple>(val->get_type())->construct(elems);
        }
        else if (op_eq(expr->op, "prop"))
            return elems[0];
        else if (auto const reduced = width_reduction(expr->op, elems))
            return make_shared<IntValue>(reduced->simplify());
        else if (op_eq(expr->op,"ptr_to_int"))
            return static_pointer_cast<FuncValue>(autov::ptr_to_int())->call(elems);
        else if (op_eq(expr->op,"int_to_ptr"))
            return int_to_ptr_value(proj, elems);
        else if (op_eq(expr->op, "z_to_nat"))
            return static_pointer_cast<FuncValue>(autov::z_to_nat())->call(elems);
        else if (op_eq(expr->op,"zmap_init") || op_eq(expr->op, "ZMap.init"))
            return val->get_type()->from_z3_value(z3::const_array(static_pointer_cast<ZMap>(val->get_type())->key_sort(), elems[0]->get_z3_value()));
        else if (op_eq(expr->op, "List.is_empty"))
            return static_pointer_cast<ListValue>(elems[0])->is_empty();
        else if (op_eq(expr->op, "List.empty"))
            return ListValue::empty(val->get_type());
        else if (op_eq(expr->op, "List.eq"))
            return static_pointer_cast<ListValue>(elems[0])->eq(static_pointer_cast<ListValue>(elems[1]));
        else if (std::holds_alternative<string>(expr->op)) {
            auto const sym = std::get<string>(expr->op);
            auto const info = proj->symbols[sym];
            if (info.kind == SymbolKind::StructConstr) {
                return static_pointer_cast<Struct>(val->get_type())->construct(elems);
            } else if (info.kind == SymbolKind::IndConstructor) {
                return static_pointer_cast<Inductive>(val->get_type())->construct(sym, elems);
            } else if (info.kind == SymbolKind::Def) {
                auto df = proj->defs[sym].get();
                if(auto loop = instance_of(df, Fixpoint)) {
                    return df->absf()->call(elems);
                } else {
                    // if(unfold && proj->cmds.NoUnfold.find(df->name) == proj->cmds.NoUnfold.end()) {
                    //     z3::expr func = formulate_function(proj, df);
                    //     auto arg_list = make_shared<vector<shared_ptr<SpecType>>>();

                    //     for (auto it = df->args->begin(); it != df->args->end(); it++) {
                    //         arg_list->push_back((*it)->type);
                    //     }

                    //     z3::expr_vector z3_args(z3ctx);
                    //     for (const auto &arg : elems) {
                    //         z3_args.push_back(arg->get_z3_value());
                    //     }
                    //     auto app = func[z3_args];

                    //     return df->rettype->from_z3_value(app);
                    // }
                    return df->absf()->call(elems);
                }
            } else if (info.kind == SymbolKind::Decl) {
                if(sym != "lens_v") {
                    auto df = proj->decls[sym].get();
                    auto const absf = static_pointer_cast<FuncValue>(df->absf());
                    return absf->call(elems);
                } else {
                    auto id = static_cast<IntConst*>(expr->elems->at(0).get());
                    unsigned long const idi = std::get<unsigned long>(id->value);
                    // auto arg_types = make_shared<vector<shared_ptr<SpecType>>>();
                    // //arg_types->push_back(expr->elems->at(0)->get_type());

                    // auto lens_type = make_shared<Function>(expr->type, arg_types);
                    // auto lens_v = make_unique<Declaration>("lens_v_" + std::to_string(idi), lens_type);
                    return expr->type->declare("lens_v_" + std::to_string(idi), 0);
                }
            } else {
                std::cout << "expr: " << string(*expr) << std::endl;
                throw UndefinedSpecException(sym);
            }
        } else if (std::holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
            auto const op = z3_eval(proj, std::get<unique_ptr<SpecNode>>(expr->op).get(), state,  check_loop, unfold, used_fixpoint);
            if (auto const func = dynamic_pointer_cast<FuncValue>(op))
                return func->call(elems);
        }

        throw std::runtime_error("Unknown expression: " + string(*expr));
    } else if (auto match = instance_of(val, Match)) {
        auto const src = z3_eval(proj, match->src.get(), state,  check_loop, unfold, used_fixpoint);
        shared_ptr<SpecValue> match_val = nullptr;
        for (auto pm = match->match_list->rbegin(); pm != match->match_list->rend(); pm++) {
            unordered_map<string, shared_ptr<SpecValue>> vars;
            unordered_map<string, shared_ptr<SpecValue>> assigns;
            auto const cond =
                match_arm_condition(proj, val, (*pm)->pattern.get(), src, vars, assigns);

            auto const z3_res = z3_check(state, cond);
            if (z3_res == Z3Result::False) {
                continue;
            }
            auto const new_state = state->copy();
            for (auto v = assigns.begin(); v != assigns.end(); v++) {
                (*new_state->vars)[v->first] = v->second;
            }
            // new_state->conds->push_back(cond);

            if (match_val == nullptr) {
                match_val = z3_eval(proj, (*pm)->body.get(), new_state,  check_loop, unfold, used_fixpoint);
            } else {
                auto const then_val = z3_eval(proj, (*pm)->body.get(), new_state,  check_loop, unfold, used_fixpoint);
                /** Optimization: instantiate Exists:
                 *      Original: (vars: v = src), if ((Exists v' (v' = src)) then Prop(v') else True)
                 *      --> v is the evidence of (Exists...)
                 *      --> (Exists v' (v' = src)) == True
                 *      --> Instantiate v' by v
                 *  * It's always sufficient to jsut have Prop(v) for proof!
                 */
                if (match_val->get_z3_value().is_true()) {
                    match_val = then_val;
                } else {
                    match_val = match_val->get_type()->from_z3_value(z3::ite(cond, then_val->get_z3_value(), match_val->get_z3_value()));
                }
            }
        }
        if (match_val == nullptr) {
            auto const opt = static_pointer_cast<Option>(val->get_type());
            return opt->construct("None", {});
        } else {
            return match_val;
        }
    } else if (auto rely = instance_of(val, Rely)) {
        auto const cond = z3_eval(proj, rely->prop.get(), state,  check_loop, unfold, used_fixpoint);
        auto const res = z3_check(state, cond->get_z3_value());
        static bool const trace_rely = std::getenv("SPOQ_TRACE_IF") != nullptr;
        if (trace_rely)
            LOG_DEBUG << "[z3_eval Rely] check=" << static_cast<int>(res) << " prop: " << string(*rely->prop).substr(0, 300);
        if (res == Z3Result::Unknown || res == Z3Result::Sat) {
            auto const new_state = state->copy();
            new_state->conds->push_back(cond->get_z3_value());
            auto const body = z3_eval(proj, rely->body.get(), new_state,  check_loop, unfold, used_fixpoint);
            auto const none = static_pointer_cast<Option>(val->get_type())->construct("None", {});

            auto const z3_val = z3::ite(cond->get_z3_value(), body->get_z3_value(), none->get_z3_value());
            return rely->get_type()->from_z3_value(z3_val.simplify());
        } else if (res == Z3Result::True) {
            return z3_eval(proj, rely->body.get(), state,  check_loop, unfold, used_fixpoint);
        } else {
            return static_pointer_cast<Option>(val->get_type())->construct("None", {});
        }
    }
    else if (auto iff = instance_of(val, If))
    {
        auto const c = z3_eval(proj, iff->cond.get(), state,  check_loop, unfold, used_fixpoint);
        auto const res = z3_check(state, c->get_z3_value());
        static bool const trace_if = std::getenv("SPOQ_TRACE_IF") != nullptr;
        if (trace_if)
            LOG_DEBUG << "[z3_eval If] check=" << static_cast<int>(res) << " cond: " << string(*iff->cond).substr(0, 300)
                      << "\n  z3: " << c->get_z3_value().to_string().substr(0, 300);
        if (res == Z3Result::Unknown || res == Z3Result::Sat)
        {
            auto const true_state = state->copy();
            true_state->conds->push_back(c->get_z3_value());
            auto const True = z3_eval(proj, iff->then_body.get(), true_state,  check_loop, unfold, used_fixpoint);
            auto const false_state = state->copy();
            false_state->conds->push_back(!c->get_z3_value());
            auto const False = z3_eval(proj, iff->else_body.get(), false_state,  check_loop, unfold, used_fixpoint);
            auto const z3_val = z3::ite(c->get_z3_value(), True->get_z3_value(), False->get_z3_value());
            return iff->get_type()->from_z3_value(z3_val.simplify());
        }
        else if (res == Z3Result::True)
        {
            state->conds->push_back(c->get_z3_value());
            return z3_eval(proj, iff->then_body.get(), state,  check_loop, unfold, used_fixpoint);
        }
        else
        {
            state->conds->push_back(!c->get_z3_value());
            return z3_eval(proj, iff->else_body.get(), state,  check_loop, unfold, used_fixpoint);
        }
    }
    else if (auto forall = instance_of(val, Forall))
    {
        z3::expr_vector vars(z3ctx);
        std::vector<z3::expr> hypos;
        auto const new_state = state->copy();
        for (auto v = forall->vars->begin(); v != forall->vars->end(); v++) {
            if ((*v)->type) {
                auto const var = (*v)->type->declare((*v)->name, val->nid);
                (*new_state->vars)[(*v)->name] = var;
                vars.push_back(var->get_z3_value());
            } else {
                // bounded variable v is prop, push into state
                auto const prop = z3_eval(proj, (*v)->expr.get(), new_state, check_loop, unfold, used_fixpoint);
                hypos.push_back(prop->get_z3_value());
            }
        }
        /** bounded variables may have a newer nid over cached z3 values, so we need to clear cached value first  */
        auto const body = z3_eval(proj, forall->body.get(), new_state, check_loop, unfold, used_fixpoint);
        auto p = body->get_z3_value();

        for (const auto &h : hypos) {
            p = z3::implies(h, p);
        }
        return make_shared<BoolValue>(z3::forall(vars, p));
    }
    else if (auto exsts = instance_of(val, Exists))
    {
        z3::expr_vector vars(z3ctx);
        auto const new_state = state->copy();
        for (auto v = exsts->vars->begin(); v != exsts->vars->end(); v++)
        {
            auto const var = (*v)->type->declare((*v)->name, val->nid);
            (*new_state->vars)[(*v)->name] = var;
            vars.push_back(var->get_z3_value());
        }
        auto const body = z3_eval(proj, exsts->body.get(), new_state,  check_loop, unfold, used_fixpoint);
        return make_shared<BoolValue>(z3::exists(vars, body->value));
    }

    throw std::runtime_error("Unknown node type: " + string(*val));

}
} // namespace autov
