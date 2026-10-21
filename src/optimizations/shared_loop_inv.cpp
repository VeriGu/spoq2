#include <shared_loop_inv.h>

#include <rules.h>
#include <symbolic.h>
#include <values.h>

#include <algorithm>
#include <chrono>
#include <cstdlib>
#include <functional>
#include <map>
#include <numeric>
#include <optional>
#include <set>
#include <sstream>

#include "log.h"

// Relational loop invariants by Houdini on the product of a vuln and a patch
// loop.  The candidate set is a finite powerset lattice ordered by inclusion;
// each round drops the candidates a path pair refutes, so the iteration
// descends to the greatest inductive subset.  Path pairs are enumerated with
// the branch conditions as assumptions, and the divergence predicates Q and U
// are drawn from the conditions of the pairs that fail lockstep.

namespace autov {

extern class UnfoldPolicy UNFOLD_POLICY;
extern unsigned long z3_checks, z3_state_sat[3];

namespace {

/// Milliseconds per solver check; SPOQ_SHARED_LOOP_INV_TIMEOUT overrides.
int sli_timeout() {
    static int const t = [] {
        auto const e = std::getenv("SPOQ_SHARED_LOOP_INV_TIMEOUT");
        return e ? std::atoi(e) : 1000;
    }();
    return t;
}
constexpr int SLI_MAX_ROUNDS = 64;
/// Callees with at most this many leaves are inlined into the loop bodies.
constexpr size_t SLI_INLINE_LEAVES = 8;
/// The same for the bodies with the memory accessors inlined, which inline
/// DelayUnfold callees too, in up to SLI_INLINE_ROUNDS rounds.
constexpr size_t SLI_FULL_INLINE_LEAVES = 64;
constexpr int SLI_INLINE_ROUNDS = 4;
/// Record fields are related to this depth below the state.
constexpr int SLI_FIELD_DEPTH = 3;
/// Coefficients c of the candidates y = c * x (mod 2^32).
constexpr int SLI_COEFFS[] = {2, -1};

bool enabled() {
    static bool const on = [] {
        auto const e = std::getenv("SPOQ_SHARED_LOOP_INV");
        return !(e && std::string(e) == "0");
    }();
    return on;
}

bool valid(const shared_ptr<ProveState> &s, const z3::expr &f) {
    z3::model ce(z3ctx);
    return z3_check_unsat(s, f, ce, nullptr, sli_timeout(), false) == Z3Result::True;
}

/// SPOQ_SHARED_LOOP_INV_LOG=1 logs each inference's arguments and time.
bool log_infer_calls() {
    static bool const on = [] {
        auto const e = std::getenv("SPOQ_SHARED_LOOP_INV_LOG");
        return e && std::string(e) == "1";
    }();
    return on;
}

/// Under SPOQ_SHARED_LOOP_INV_LOG=1, the time and solver checks of a phase.
struct Phase {
    string what;
    std::chrono::steady_clock::time_point t0 = std::chrono::steady_clock::now();
    unsigned long checks0 = checks();
    static unsigned long checks() { return z3_checks + z3_state_sat[0] + z3_state_sat[1] + z3_state_sat[2]; }
    void done(const string &detail = "") const {
        if (!log_infer_calls()) return;
        LOG_DEBUG << "Shared loop invariant phase " << what << ": "
                  << std::chrono::duration<double>(std::chrono::steady_clock::now() - t0).count() << " s, "
                  << checks() - checks0 << " solver checks" << (detail.empty() ? "" : ", " + detail);
    }
};

bool feasible(const shared_ptr<ProveState> &s) { return z3_verify_state_sat(s, nullptr, sli_timeout()) != Z3Result::False; }

/// Keeps the indices in [alive] whose formula f(i) is valid under [s].  A
/// counterexample to the conjunction refutes every conjunct it falsifies.
void prune(const shared_ptr<ProveState> &s, std::vector<int> &alive, const std::function<z3::expr(int)> &f) {
    while (!alive.empty()) {
        z3::expr_vector fs(z3ctx);
        for (int const i : alive) fs.push_back(f(i));
        z3::model ce(z3ctx);
        auto const r = z3_check_unsat(s, z3::mk_and(fs), ce, nullptr, sli_timeout(), false);
        if (r == Z3Result::True) return;
        std::vector<int> kept;
        if (r == Z3Result::Sat && ce.size() > 0)
            for (unsigned k = 0; k < fs.size(); k++)
                if (!ce.eval(fs[k], true).is_false()) kept.push_back(alive[k]);
        if (r != Z3Result::Sat || ce.size() == 0 || kept.size() == alive.size()) {
            kept.clear();
            for (unsigned k = 0; k < fs.size(); k++)
                if (valid(s, fs[k])) kept.push_back(alive[k]);
            alive = kept;
            return;
        }
        alive = kept;
    }
}

z3::expr as_bool(const z3::expr &e) { return e.is_bool() ? e : e != 0; }

bool same_sort(const z3::expr &a, const z3::expr &b) { return z3::eq(a.get_sort(), b.get_sort()); }

std::vector<int> indices(size_t n) {
    std::vector<int> out(n);
    std::iota(out.begin(), out.end(), 0);
    return out;
}

/// [a] mapped to [b] componentwise, for substitution.
struct Subst {
    z3::expr_vector from{z3ctx}, to{z3ctx};

    Subst &add(const z3::expr_vector &a, const z3::expr_vector &b) {
        for (unsigned i = 0; i < a.size(); i++) from.push_back(a[i]), to.push_back(b[i]);
        return *this;
    }
    z3::expr operator()(z3::expr f) const { return f.substitute(from, to); }
};

z3::expr_vector args_of(const z3::expr &call) {
    z3::expr_vector out(z3ctx);
    for (unsigned i = 0; i < call.num_args(); i++) out.push_back(call.arg(i));
    return out;
}

/// Whether some application in [e] satisfies [pred].
bool any_app(const z3::expr &e, const std::function<bool(const z3::expr &)> &pred) {
    std::set<unsigned> seen;
    std::vector<z3::expr> todo{e};
    while (!todo.empty()) {
        auto const t = todo.back();
        todo.pop_back();
        if (!seen.insert(t.id()).second || !t.is_app()) continue;
        if (pred(t)) return true;
        for (unsigned i = 0; i < t.num_args(); i++) todo.push_back(t.arg(i));
    }
    return false;
}

/// Whether [e] applies [f] anywhere.
bool mentions(const z3::expr &e, const z3::func_decl &f) {
    return any_app(e, [&](const z3::expr &t) { return t.decl().id() == f.id(); });
}

/// Whether [e] mentions one of [consts].
bool mentions_any(const z3::expr &e, const z3::expr_vector &consts) {
    std::set<unsigned> ids;
    for (auto const c : consts) ids.insert(c.decl().id());
    return any_app(e, [&](const z3::expr &t) { return t.num_args() == 0 && ids.count(t.decl().id()); });
}

/// A model value built from numerals, string literals and constructors only.
bool is_ground_value(const z3::expr &e) {
    if (e.is_numeral() || e.is_true() || e.is_false()) return true;
    if (!e.is_app()) return false;
    auto const k = e.decl().decl_kind();
    if (k != Z3_OP_DT_CONSTRUCTOR && !(e.is_string_value())) return false;
    for (unsigned i = 0; i < e.num_args(); i++)
        if (!is_ground_value(e.arg(i))) return false;
    return true;
}

void flatten_and(const z3::expr &e, std::vector<z3::expr> &out) {
    if (e.is_app() && e.decl().decl_kind() == Z3_OP_AND) {
        for (unsigned i = 0; i < e.num_args(); i++) flatten_and(e.arg(i), out);
    } else {
        out.push_back(e);
    }
}

/// y = c * x modulo 2^32, for integers of either encoding.
std::optional<z3::expr> congruent(const z3::expr &y, const z3::expr &x, int c) {
    if (y.is_int() && x.is_int()) return z3::mod(y - c * x, z3ctx.int_val((int64_t)1 << 32)) == 0;
    if (y.is_bv() && x.is_bv() && y.get_sort().bv_size() == x.get_sort().bv_size() && y.get_sort().bv_size() >= 32) {
        auto const d = y - x * z3ctx.bv_val(c, x.get_sort().bv_size());
        return d.extract(31, 0) == z3ctx.bv_val(0, 32);
    }
    return std::nullopt;
}

string short_expr(const z3::expr &e) {
    auto s = e.to_string();
    std::replace(s.begin(), s.end(), '\n', ' ');
    return s.size() > 300 ? s.substr(0, 300) + "..." : s;
}

/// Calls [f] on each child of [n] that is evaluated, so not on the patterns
/// of a Match.
void for_each_child(SpecNode *n, const std::function<void(SpecNode *)> &f) {
    if (auto e = instance_of(n, Expr)) {
        if (auto op = std::get_if<unique_ptr<SpecNode>>(&e->op)) f(op->get());
        if (e->elems)
            for (auto const &x : *e->elems) f(x.get());
    } else if (auto m = instance_of(n, Match)) {
        f(m->src.get());
        for (auto const &pm : *m->match_list) f(pm->body.get());
    } else if (auto i = instance_of(n, If)) {
        f(i->cond.get());
        f(i->then_body.get());
        f(i->else_body.get());
    } else if (auto r = instance_of(n, RelyAnno)) {
        f(r->prop.get());
        f(r->body.get());
    } else if (auto q = instance_of(n, ForallExists)) {
        f(q->body.get());
    }
}

/// Marks in [read] each argument of [loop] that [n] reads other than by
/// passing it to its own position in a recursive call.
void mark_reads(SpecNode *n, const Fixpoint *loop, std::vector<bool> &read) {
    if (!n) return;
    if (auto sym = instance_of(n, Symbol)) {
        for (size_t i = 0; i < loop->args->size(); i++)
            if (loop->args->at(i)->name == sym->text) read[i] = true;
        return;
    }
    auto const e = instance_of(n, Expr);
    if (e && op_eq(e->op, loop->name) && e->elems) {
        for (size_t k = 0; k < e->elems->size(); k++) {
            auto const sym = instance_of(e->elems->at(k).get(), Symbol);
            if (!(sym && k < loop->args->size() && sym->text == loop->args->at(k)->name))
                mark_reads(e->elems->at(k).get(), loop, read);
        }
        return;
    }
    for_each_child(n, [&](SpecNode *c) { mark_reads(c, loop, read); });
}

/// The string constants in [n].  Unlike the stack typing's, these include
/// those that are a plain Const of a string.
void collect_strings(SpecNode *n, std::set<string> &out) {
    if (!n) return;
    if (auto c = instance_of(n, Const))
        if (auto v = std::get_if<string>(&c->value)) out.insert(*v);
    for_each_child(n, [&](SpecNode *c) { collect_strings(c, out); });
}

/// The body of [c] if a call to it in [loop] is inlined, with the memory
/// accessors if [full]: a small, non-recursive definition other than a loop.
SpecNode *inlinable(Project *proj, const Fixpoint *loop, const string &c, bool full) {
    auto const it = proj->defs.find(c);
    if (it == proj->defs.end() || !it->second || c == loop->name || instance_of(it->second.get(), Fixpoint))
        return nullptr;
    // A body still to be derived is a generated function spec, not a helper;
    // reading it would transform it.
    if (it->second->finish_body) return nullptr;
    if ((!full && UNFOLD_POLICY.skip_list.count(c)) || !it->second->body()) return nullptr;
    size_t const limit = full ? SLI_FULL_INLINE_LEAVES : SLI_INLINE_LEAVES;
    auto *const body = it->second->body().get();
    if (body->count_leaves(limit + 1) > limit) return nullptr;
    std::set<string> inner;
    collect_called_defs(proj, body, inner);
    return inner.count(c) ? nullptr : body;
}

/// The string constants of [n] and of the bodies the memory-inlined body of
/// [loop] would take in, without inlining them.
void inlined_strings(Project *proj, const Fixpoint *loop, SpecNode *n, int depth, std::set<string> &out) {
    collect_strings(n, out);
    if (depth == SLI_INLINE_ROUNDS) return;
    std::set<string> callees;
    collect_called_defs(proj, n, callees);
    for (auto const &c : callees)
        if (auto *const body = inlinable(proj, loop, c, true)) inlined_strings(proj, loop, body, depth + 1, out);
}

/// [loop]'s body with each small, non-recursive callee inlined, so that
/// conditions such as `xorb_spec c true` are visible to the solver.  Loops stay
/// folded, and callees marked DelayUnfold unless [full].
unique_ptr<SpecNode> prepared_body(Project *proj, Fixpoint *loop, bool full) {
    auto body = loop->body()->deep_copy();
    // DelayUnfold callees are otherwise skipped by the unfolding itself.
    struct SkipGuard {
        bool saved = UNFOLD_POLICY.skip;
        ~SkipGuard() { UNFOLD_POLICY.skip = saved; }
    } const guard;
    if (full) UNFOLD_POLICY.skip = false;
    bool any = false;
    for (int round = 0; round < (full ? SLI_INLINE_ROUNDS : 1); round++) {
        std::set<string> callees;
        collect_called_defs(proj, body.get(), callees);
        bool changed_round = false;
        for (auto const &c : callees) {
            if (!inlinable(proj, loop, c, full)) continue;
            bool changed = false;
            std::tie(body, changed) = proj->rules.unfold_calls_to(std::move(body), c);
            changed_round |= changed;
        }
        any |= changed_round;
        if (!changed_round) break;
    }
    if (any) {
        std::set<string> known;
        for (auto const &a : *loop->args) known.insert(a->name);
        bool amb = false;
        body = proj->rules.eliminate_ambiguity(std::move(body), known, amb);
    }
    return body;
}

/// The tuples of the exits `Some (t_1, ..., t_k)` of the body [n].
void exit_tuples(SpecNode *n, std::vector<Expr *> &out) {
    if (auto m = instance_of(n, Match)) {
        for (auto const &pm : *m->match_list) exit_tuples(pm->body.get(), out);
    } else if (auto i = instance_of(n, If)) {
        exit_tuples(i->then_body.get(), out);
        exit_tuples(i->else_body.get(), out);
    } else if (auto r = instance_of(n, RelyAnno)) {
        exit_tuples(r->body.get(), out);
    } else if (auto e = instance_of(n, Expr); e && op_eq(e->op, Expr::Some) && e->elems && !e->elems->empty()) {
        if (auto t = instance_of(e->elems->at(0).get(), Expr); t && op_eq(t->op, Expr::Tuple) && t->elems) out.push_back(t);
    }
}

/// The last component other than the state that is an integer literal at
/// every exit of the body [n], which holds the exit code; -1 if none.
int code_slot(SpecNode *n, size_t arity) {
    std::vector<Expr *> exits;
    exit_tuples(n, exits);
    if (exits.empty()) return -1;
    for (int k = (int)arity - 2; k >= 0; k--)
        if (std::all_of(exits.begin(), exits.end(), [&](Expr *t) {
                return t->elems->size() == arity && instance_of(t->elems->at(k).get(), IntConst);
            }))
            return k;
    return -1;
}

/// Whether [n] binds [name] in a pattern.
bool binds(SpecNode *n, const string &name) {
    if (!n) return false;
    if (auto sym = instance_of(n, Symbol)) return sym->text == name;
    if (auto e = instance_of(n, Expr))
        if (e->elems)
            for (auto const &x : *e->elems)
                if (binds(x.get(), name)) return true;
    return false;
}

/// Whether the body [n] of [loop] may change the state: it rebinds the state
/// argument [st], or a path ends with another state.  A leaf's state is the
/// last argument of a recursive call, or the last component of an exit.
bool writes_state(SpecNode *n, const Fixpoint *loop, const string &st) {
    if (!n) return false;
    if (auto m = instance_of(n, Match)) {
        for (auto const &pm : *m->match_list)
            if (binds(pm->pattern.get(), st) || writes_state(pm->body.get(), loop, st)) return true;
        return false;
    }
    if (auto i = instance_of(n, If))
        return writes_state(i->then_body.get(), loop, st) || writes_state(i->else_body.get(), loop, st);
    if (auto r = instance_of(n, RelyAnno)) return writes_state(r->body.get(), loop, st);
    auto const is_st = [&](SpecNode *x) {
        auto const sym = instance_of(x, Symbol);
        return sym && sym->text == st;
    };
    if (auto e = instance_of(n, Expr)) {
        if (op_eq(e->op, loop->name)) return !e->elems || e->elems->empty() || !is_st(e->elems->back().get());
        if (op_eq(e->op, Expr::Some) && e->elems && !e->elems->empty()) {
            auto const t = instance_of(e->elems->at(0).get(), Expr);
            if (t && op_eq(t->op, Expr::Tuple) && t->elems && !t->elems->empty()) return !is_st(t->elems->back().get());
        }
        return false;
    }
    return false;
}

/// One loop of the pair: fresh values for its arguments and its result
/// components, and the result component that holds its exit code.
struct Side {
    Fixpoint *def = nullptr;
    /// The body with small callees inlined.
    std::shared_ptr<SpecNode> body;
    mutable std::shared_ptr<SpecNode> full_cache;
    Project *proj = nullptr;

    /// The body with the memory accessors inlined too, for relating parts of
    /// the states; built on first use.
    SpecNode *full() const {
        if (!full_cache) full_cache = prepared_body(proj, def, true);
        return full_cache.get();
    }
    /// The string constants of the memory-inlined body, which may key the stack.
    std::vector<string> strings;
    shared_ptr<Option> rettype;
    std::vector<shared_ptr<Arg>> args;
    std::vector<shared_ptr<SpecValue>> params;
    z3::expr_vector param_z3{z3ctx};
    z3::expr_vector res{z3ctx};
    std::optional<z3::func_decl> call;
    int code = -1;
    /// Arguments the body reads; the others are passed through unchanged.
    std::vector<bool> read;
    /// Whether the body may change the state.
    bool writes = false;

    z3::expr is_some(const z3::expr &t) const { return rettype->get_recognizer(rettype->some_name())(t); }
    z3::expr is_none(const z3::expr &t) const { return rettype->get_recognizer(rettype->none_name())(t); }

    z3::expr_vector components(const z3::expr &t) const {
        auto const opt = static_pointer_cast<IndValue>(rettype->from_z3_value(t));
        auto const tup = static_pointer_cast<StructValue>(opt->get("value"));
        z3::expr_vector out(z3ctx);
        for (unsigned i = 0; i < res.size(); i++) out.push_back(tup->get((int)i)->get_z3_value().simplify());
        return out;
    }

    shared_ptr<ProveState> fresh_state() const {
        auto const s = make_shared<ProveState>();
        for (size_t i = 0; i < args.size(); i++) (*s->vars)[args[i]->name] = params[i];
        return s;
    }

    /// A state over this loop's arguments sharing [from]'s path conditions.
    shared_ptr<ProveState> share(const shared_ptr<ProveState> &from) const {
        return make_shared<ProveState>(fresh_state()->vars, from->conds, from->inductions);
    }

    unsigned st() const { return args.size() - 1; }
};

struct Leaf {
    enum Kind { None, Cont, Exit } kind;
    shared_ptr<ProveState> state;
    z3::expr value;
    z3::expr_vector next;
};

/// The state of a walk over one body, or two in lockstep.  The two sides have
/// their own bindings and share the path condition.
struct Walk {
    shared_ptr<ProveState> v, p;  // p is null for one body

    shared_ptr<ProveState> &at(bool patch) { return patch ? p : v; }

    /// A copy for one branch: the path condition is the branch's own.
    Walk fork() const {
        auto conds = make_shared<vector<z3::expr>>(*v->conds);
        auto inductions = make_shared<vector<z3::expr>>(*v->inductions);
        auto const side = [&](const shared_ptr<ProveState> &s) -> shared_ptr<ProveState> {
            if (!s) return nullptr;
            auto vars = make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*s->vars);
            return make_shared<ProveState>(vars, conds, inductions);
        };
        return Walk{side(v), side(p)};
    }
};

using Child = std::function<bool(SpecNode *, const Walk &)>;
using AtLeaf = std::function<bool(const Leaf &, const Walk &)>;

/// One step of [side]'s body at [n], on the vuln or [patch] side of [w]: calls
/// [child] with each feasible successor and its walk, or [leaf] at a leaf.  A
/// branch that is cut keeps its condition negated on the other: an If's other
/// branch, and a Match's later arms.  A leaf calling the loop is a continuation
/// with the call's arguments, and a nested loop call gets its relational
/// postcondition.  False if the loop recurses other than in tail position.
bool step(Project *proj, const Side &side, SpecNode *n, const Walk &w, bool patch, const Child &child,
          const AtLeaf &leaf) {
    auto const state = patch ? w.p : w.v;
    if (auto r = instance_of(n, Rely)) {
        auto next = w.fork();
        next.at(patch)->conds->push_back(as_bool(z3_eval(proj, r->prop.get(), state)->get_z3_value()));
        if (!feasible(next.at(patch))) return true;
        return child(r->body.get(), next);
    }
    if (auto a = instance_of(n, Anno)) return child(a->body.get(), w);
    if (auto iff = instance_of(n, If)) {
        auto const c = as_bool(z3_eval(proj, iff->cond.get(), state)->get_z3_value());
        for (bool const b : {true, false}) {
            auto next = w.fork();
            next.at(patch)->conds->push_back(b ? c : !c);
            if (!feasible(next.at(patch))) continue;
            if (!child(b ? iff->then_body.get() : iff->else_body.get(), next)) return false;
        }
        return true;
    }
    if (auto m = instance_of(n, Match)) {
        auto const src = z3_eval(proj, m->src.get(), state);
        if (mentions(src->get_z3_value(), *side.call)) return false;
        auto base = w.fork();
        relate_loop_calls(proj, base.at(patch), src->get_z3_value());
        std::vector<z3::expr> earlier;
        for (auto const &pm : *m->match_list) {
            unordered_map<string, shared_ptr<SpecValue>> vars, assigns;
            auto const cond = match_arm_condition(proj, m, pm->pattern.get(), src, vars, assigns);
            auto next = base.fork();
            for (auto const &[k, v] : assigns) (*next.at(patch)->vars)[k] = v;
            for (auto const &e : earlier) next.at(patch)->conds->push_back(!e);
            next.at(patch)->conds->push_back(cond);
            earlier.push_back(cond);
            if (!feasible(next.at(patch))) continue;
            if (!child(pm->body.get(), next)) return false;
        }
        return true;
    }
    auto const v = z3_eval(proj, n, state)->get_z3_value().simplify();
    if (v.is_app() && v.decl().id() == side.call->id()) return leaf(Leaf{Leaf::Cont, state, v, args_of(v)}, w);
    if (mentions(v, *side.call)) return false;
    bool const none = v.is_app() && v.decl().name().str() == side.rettype->none_name();
    return leaf(Leaf{none ? Leaf::None : Leaf::Exit, state, v, z3::expr_vector(z3ctx)}, w);
}

/// The paths of one iteration of [side]'s body from [state].  False if the
/// loop recurses other than in tail position.
bool enumerate(Project *proj, const Side &side, SpecNode *n, const shared_ptr<ProveState> &state, std::vector<Leaf> &out) {
    std::function<bool(SpecNode *, const Walk &)> go = [&](SpecNode *node, const Walk &w) {
        return step(proj, side, node, w, false, go, [&](const Leaf &l, const Walk &) {
            out.push_back(l);
            return true;
        });
    };
    return go(n, Walk{state, nullptr});
}

std::optional<Side> make_side(Project *proj, const string &name) {
    auto const it = proj->defs.find(name);
    if (it == proj->defs.end() || !it->second) return std::nullopt;
    auto const fix = dynamic_cast<Fixpoint *>(it->second.get());
    if (!fix || !fix->body()) return std::nullopt;
    Side s;
    s.def = fix;
    s.rettype = dynamic_pointer_cast<Option>(fix->rettype);
    if (!s.rettype) return std::nullopt;
    auto const tup = dynamic_pointer_cast<Tuple>(s.rettype->elem_type);
    if (!tup || tup->types->size() != fix->args->size() || fix->args->empty()) return std::nullopt;
    for (auto const &a : *fix->args) {
        auto const v = a->type->declare("__sli_" + name + "_" + a->name, 0);
        s.args.push_back(a);
        s.params.push_back(v);
        s.param_z3.push_back(v->get_z3_value());
    }
    for (size_t i = 0; i < tup->types->size(); i++)
        s.res.push_back(tup->types->at(i)->declare("__sli_" + name + "_r" + std::to_string(i), 0)->get_z3_value());
    s.call = fix->absf()->z3_func;
    s.body = prepared_body(proj, fix, false);
    s.proj = proj;
    std::set<string> strings;
    inlined_strings(proj, fix, s.body.get(), 0, strings);
    s.strings.assign(strings.begin(), strings.end());
    s.read.assign(s.args.size(), false);
    mark_reads(s.body.get(), fix, s.read);
    s.writes = writes_state(s.body.get(), fix, s.args.back()->name);
    s.read.back() = true;
    s.code = code_slot(s.body.get(), s.res.size());
    return s;
}

/// y_j = c * x_i, an equality if c is 1 and a congruence modulo 2^32 otherwise.
/// With c = 0, another fact; [part] marks one about parts of the states, which
/// the equality of the states, marked [whole], implies.  [relates] marks one
/// that relates the two states.
struct Cand {
    z3::expr f;
    string desc;
    int xi, yj, c;
    bool part = false, whole = false, relates = false;
};

/// [idx] without the congruences implied by an equality in it, and without the
/// facts about parts of the states if it equates the states.
std::vector<int> reduced(const std::vector<Cand> &cands, const std::vector<int> &idx) {
    std::set<std::pair<int, int>> eqs;
    bool whole = false;
    for (int const i : idx) {
        if (cands[i].c == 1) eqs.emplace(cands[i].xi, cands[i].yj);
        whole |= cands[i].whole;
    }
    std::vector<int> out;
    for (int const i : idx) {
        if (whole && cands[i].part) continue;
        if (cands[i].c == 1 || cands[i].c == 0 || !eqs.count({cands[i].xi, cands[i].yj})) out.push_back(i);
    }
    return out;
}

/// What inference found for one entry candidate set.
struct Relation {
    std::vector<int> R;
    /// One per vuln exit code.  An exit pair related under E has the patch
    /// exit at [cp]; under Q the vuln has diverged and the patch is free.
    struct Group {
        std::optional<z3::expr> cv, cp;
        bool related = false;
        std::vector<Cand> E;
        std::optional<z3::expr> Q;
    };
    std::vector<Group> groups;
};

struct Pair {
    string vname, pname;
    Side v, p;
    std::vector<Cand> R, E;
    /// R candidates `x = v` for a ground value v at some call, by description.
    std::map<string, int> ground;
    std::map<std::pair<std::vector<int>, bool>, std::optional<Relation>> cache;
};

void add_candidates(std::vector<Cand> &out, const z3::expr_vector &xs, const z3::expr_vector &ys,
                    const std::vector<string> &xn, const std::vector<string> &yn, const std::vector<bool> &use_x,
                    const std::vector<bool> &use_y) {
    for (unsigned i = 0; i < xs.size(); i++) {
        if (!use_x[i]) continue;
        for (unsigned j = 0; j < ys.size(); j++) {
            if (!use_y[j]) continue;
            if (same_sort(xs[i], ys[j])) out.push_back(Cand{xs[i] == ys[j], yn[j] + "=" + xn[i], (int)i, (int)j, 1});
            for (int const c : SLI_COEFFS)
                if (auto f = congruent(ys[j], xs[i], c))
                    out.push_back(Cand{*f, yn[j] + " = " + std::to_string(c) + "*" + xn[i] + " (mod 2^32)", (int)i,
                                       (int)j, c});
        }
    }
}

bool is_string_sort(const z3::sort &s) { return Z3_is_string_sort(z3ctx, s); }

/// A key of a string-indexed array, and how the log shows it.
struct Key {
    z3::expr e;
    string desc;
};

/// The string-sorted fields of [e], which may key the stack: `p.(pbase)` of a
/// pointer.
void string_fields(const z3::expr &e, const string &name, std::vector<Key> &out) {
    auto s = e.get_sort();
    if (!s.is_datatype() || s.constructors().size() != 1) return;
    for (auto const acc : s.constructors()[0].accessors())
        if (is_string_sort(acc.range())) out.push_back(Key{acc(e), acc.name().str() + "(" + name + ")"});
}

/// Candidates relating parts of two values [x] and [y] of one record sort: each
/// field, to SLI_FIELD_DEPTH, and for an array field indexed by strings, a
/// frame: equal outside the [keys], and equal at each key.
void add_state_candidates(std::vector<Cand> &out, const z3::expr &x, const z3::expr &y, const string &xn,
                          const string &yn, const std::vector<Key> &keys, int depth = 0) {
    auto s = x.get_sort();
    if (s.is_array() && is_string_sort(s.array_domain())) {
        z3::expr rest = x;
        auto range = s.array_range();
        for (size_t k = 0; k < keys.size(); k++) {
            auto const &key = keys[k].e;
            auto const at = " @ " + keys[k].desc;
            rest = z3::store(rest, key, z3::select(y, key));
            out.push_back(
                Cand{z3::select(x, key) == z3::select(y, key), yn + at + "=" + xn + at, -1, -1, 0, true, false, true});
            // Each side: the entry is not a nullary constructor, such as None
            // for a stack slot that is not allocated.
            if (!range.is_datatype()) continue;
            auto const cs = range.constructors();
            auto const rs = range.recognizers();
            for (unsigned c = 0; c < cs.size(); c++) {
                if (cs[c].arity() != 0) continue;
                auto const nm = cs[c].name().str();
                out.push_back(Cand{!rs[c](z3::select(x, key)), xn + at + "<>" + nm, -1, -1, 0, true});
                out.push_back(Cand{!rs[c](z3::select(y, key)), yn + at + "<>" + nm, -1, -1, 0, true});
            }
        }
        out.push_back(Cand{rest == y, yn + "=" + xn + " outside the keys", -1, -1, 0, true, false, true});
        return;
    }
    if (depth >= SLI_FIELD_DEPTH || !s.is_datatype() || s.constructors().size() != 1) return;
    for (auto const acc : s.constructors()[0].accessors()) {
        auto const ax = acc(x), ay = acc(y);
        auto const f = acc.name().str();
        out.push_back(Cand{ax == ay, yn + "." + f + "=" + xn + "." + f, -1, -1, 0, true, false, true});
        add_state_candidates(out, ax, ay, xn + "." + f, yn + "." + f, keys, depth + 1);
    }
}

/// The stack keys for candidates over [xs] and [ys]: the string constants of
/// the two bodies and the string fields of the pointers in [xs] and [ys].
std::vector<Key> state_keys(const Side &v, const Side &p, const z3::expr_vector &xs, const z3::expr_vector &ys,
                            const string &xp, const string &yp) {
    std::vector<Key> keys;
    std::set<string> strings(v.strings.begin(), v.strings.end());
    strings.insert(p.strings.begin(), p.strings.end());
    for (auto const &str : strings) keys.push_back(Key{z3ctx.string_val(str), "\"" + str + "\""});
    for (unsigned i = 0; i + 1 < xs.size(); i++) string_fields(xs[i], xp + v.args[i]->name, keys);
    for (unsigned i = 0; i + 1 < ys.size(); i++) string_fields(ys[i], yp + p.args[i]->name + "'", keys);
    return keys;
}

Pair *get_pair(Project *proj, const string &vname, const string &pname) {
    // Never destroyed: it holds z3 terms, which must not outlive the context.
    static auto &pairs = *new std::map<std::pair<string, string>, std::unique_ptr<Pair>>();
    static std::set<std::pair<string, string>> failed;
    auto const key = std::make_pair(vname, pname);
    if (failed.count(key)) return nullptr;
    if (auto const it = pairs.find(key); it != pairs.end()) return it->second.get();
    auto v = make_side(proj, vname);
    auto p = make_side(proj, pname);
    if (!v || !p) {
        LOG_INFO << "No shared loop invariant " << pname << " ~ " << vname << ": a body is not a tail-recursive loop";
        failed.insert(key);
        return nullptr;
    }
    auto pair = std::make_unique<Pair>(Pair{vname, pname, std::move(*v), std::move(*p), {}, {}, {}});
    std::vector<string> xn, yn, rvn, rpn;
    for (auto const &a : pair->v.args) xn.push_back(a->name);
    for (auto const &a : pair->p.args) yn.push_back(a->name + "'");
    for (auto const &n : xn) rvn.push_back("r." + n);
    for (auto const &a : pair->p.args) rpn.push_back("r'." + a->name);
    add_candidates(pair->R, pair->v.param_z3, pair->p.param_z3, xn, yn, pair->v.read, pair->p.read);
    std::vector<bool> use_v(pair->v.res.size(), true), use_p(pair->p.res.size(), true);
    if (pair->v.code >= 0) use_v[pair->v.code] = false;
    if (pair->p.code >= 0) use_p[pair->p.code] = false;
    add_candidates(pair->E, pair->v.res, pair->p.res, rvn, rpn, use_v, use_p);
    auto const &V = pair->v;
    auto const &P = pair->p;
    for (auto *cands : {&pair->R, &pair->E})
        for (auto &c : *cands)
            if (c.c == 1 && c.xi == (int)V.st() && c.yj == (int)P.st()) c.whole = c.relates = true;
    if (same_sort(V.param_z3[V.st()], P.param_z3[P.st()])) {
        add_state_candidates(pair->R, V.param_z3[V.st()], P.param_z3[P.st()], "st", "st'",
                             state_keys(V, P, V.param_z3, P.param_z3, "", ""));
        add_state_candidates(pair->E, V.res[V.st()], P.res[P.st()], "r.st", "r'.st",
                             state_keys(V, P, V.res, P.res, "r.", "r."));
    }
    auto *const out = pair.get();
    pairs.emplace(key, std::move(pair));
    return out;
}

string describe(const std::vector<Cand> &cands, const std::vector<int> &idx) {
    std::ostringstream o;
    for (size_t k = 0; k < idx.size(); k++) o << (k ? ", " : "") << cands[idx[k]].desc;
    return o.str();
}

string describe(const std::vector<Cand> &cands) { return describe(cands, indices(cands.size())); }

struct PairLeaf {
    Leaf v, p;
};

/// The feasible pairs of paths of one iteration of [V]'s and [P]'s bodies from
/// [w].  The bodies are stepped in lockstep, the side with fewer steps first,
/// so a pair that cannot be taken together is cut where the paths part.  A
/// vuln path that ends in None needs no partner and ends the walk; a vuln exit
/// that may be Some is followed by the patch under that assumption.  Each
/// leaf's state is the pair's.  False if a loop recurses other than in tail
/// position.
bool enumerate_pairs(Project *proj, const Side &V, const Side &P, SpecNode *vbody, SpecNode *pbody, const Walk &w,
                     std::vector<PairLeaf> &out) {
    std::function<bool(SpecNode *, SpecNode *, const Walk &, int, int, const std::optional<Leaf> &,
                       const std::optional<Leaf> &)>
        go = [&](SpecNode *nv, SpecNode *np, const Walk &w, int kv, int kp, const std::optional<Leaf> &lv,
                 const std::optional<Leaf> &lp) -> bool {
        if (lv && lp) {
            auto v = *lv, p = *lp;
            v.state = w.v;
            p.state = w.p;
            out.push_back(PairLeaf{v, p});
            return true;
        }
        if (!lv && (lp || kv <= kp))
            return step(
                proj, V, nv, w, false,
                [&](SpecNode *c, const Walk &w2) { return go(c, np, w2, kv + 1, kp, lv, lp); },
                [&](const Leaf &l, const Walk &w2) {
                    if (l.kind == Leaf::None) return true;
                    if (l.kind == Leaf::Exit && valid(w2.v, V.is_none(l.value))) return true;
                    auto next = w2.fork();
                    if (l.kind == Leaf::Exit) next.v->conds->push_back(V.is_some(l.value));
                    return go(nullptr, np, next, kv, kp, l, lp);
                });
        return step(
            proj, P, np, w, true, [&](SpecNode *c, const Walk &w2) { return go(nv, c, w2, kv, kp + 1, lv, lp); },
            [&](const Leaf &l, const Walk &w2) { return go(nv, nullptr, w2, kv, kp, lv, l); });
    };
    return go(vbody, pbody, w, 0, 0, std::nullopt, std::nullopt);
}

/// [e] over the names of the arguments and results, for the log.
string show(const Pair &pr, z3::expr e) {
    z3::expr_vector from(z3ctx), to(z3ctx);
    auto const add = [&](const z3::expr &c, const string &n) {
        from.push_back(c);
        to.push_back(z3ctx.constant(n.c_str(), c.get_sort()));
    };
    for (unsigned i = 0; i < pr.v.args.size(); i++) {
        add(pr.v.param_z3[i], pr.v.args[i]->name);
        add(pr.v.res[i], "r." + pr.v.args[i]->name);
    }
    for (unsigned i = 0; i < pr.p.args.size(); i++) {
        add(pr.p.param_z3[i], pr.p.args[i]->name + "'");
        add(pr.p.res[i], "r'." + pr.p.args[i]->name);
    }
    return short_expr(e.substitute(from, to).simplify());
}

/// The theorem's premises for entry candidates [C0], or nothing if some path
/// pair is outside every case of the induction.
std::optional<Relation> infer(Project *proj, Pair &pr, const std::vector<int> &C0, bool full) {
    auto const &V = pr.v;
    auto const &P = pr.p;
    auto *const vbody = full ? V.full() : V.body.get();
    auto *const pbody = full ? P.full() : P.body.get();
    Relation rel;
    rel.R = C0;
    std::vector<PairLeaf> pairs;
    for (int round = 0;; round++) {
        if (round == SLI_MAX_ROUNDS) return std::nullopt;
        pairs.clear();
        auto const base = V.fresh_state();
        for (int const i : rel.R) base->conds->push_back(pr.R[i].f);
        Phase const penum{"round " + std::to_string(round) + " path pairs"};
        if (!enumerate_pairs(proj, V, P, vbody, pbody, Walk{base, P.share(base)}, pairs)) return std::nullopt;
        penum.done(std::to_string(pairs.size()) + " pairs, " + std::to_string(rel.R.size()) + " candidates");
        Phase const rprune{"round " + std::to_string(round) + " prune"};
        auto next = rel.R;
        for (auto const &pl : pairs) {
            if (pl.v.kind != Leaf::Cont || pl.p.kind != Leaf::Cont) continue;
            auto const at_next = Subst().add(V.param_z3, pl.v.next).add(P.param_z3, pl.p.next);
            prune(pl.p.state, next, [&](int i) { return at_next(pr.R[i].f); });
        }
        rprune.done(std::to_string(next.size()) + " candidates left");
        if (next == rel.R) break;
        rel.R = next;
    }
    rel.R = reduced(pr.R, rel.R);

    // Arguments passed unchanged to every next iteration.  Q and E may state
    // facts about them, which then hold of the arguments at the call.
    Phase const pstable{"stable arguments"};
    std::vector<int> stable_v, stable_p;
    for (unsigned j = 0; j < V.st(); j++) stable_v.push_back(j);
    for (unsigned j = 0; j < P.st(); j++) stable_p.push_back(j);
    for (auto const &pl : pairs)
        if (pl.v.kind == Leaf::Cont && pl.p.kind == Leaf::Cont) {
            prune(pl.p.state, stable_v, [&](int j) { return z3_eq(pl.v.next[j], V.param_z3[j]); });
            prune(pl.p.state, stable_p, [&](int j) { return z3_eq(pl.p.next[j], P.param_z3[j]); });
        }

    pstable.done();
    auto const code_of = [](const Side &s, const Leaf &l) -> std::optional<z3::expr> {
        if (s.code < 0 || l.kind != Leaf::Exit) return std::nullopt;
        auto const c = s.components(l.value)[s.code];
        if (c.is_numeral()) return c;
        return std::nullopt;
    };
    auto const key = [](const std::optional<z3::expr> &c) { return c ? c->get_decimal_string(0) : string("*"); };

    // A vuln exit on which the patch is unconstrained: [state] is the pair's,
    // or the vuln's alone for an exit reached under U.
    struct Div {
        Leaf v;
        shared_ptr<ProveState> state;
    };

    // Exit pairs by vuln code; the rest fail lockstep.
    std::map<string, std::vector<size_t>> exits;
    std::map<string, std::vector<Div>> diverged;
    std::vector<size_t> vuln_continues;
    for (size_t k = 0; k < pairs.size(); k++) {
        auto const &pl = pairs[k];
        if (pl.v.kind == Leaf::Exit && pl.p.kind == Leaf::Exit) exits[key(code_of(V, pl.v))].push_back(k);
        else if (pl.v.kind == Leaf::Exit) diverged[key(code_of(V, pl.v))].push_back(Div{pl.v, pl.p.state});
        else if (pl.p.kind != Leaf::Cont) {
            vuln_continues.push_back(k);
            LOG_DEBUG << "Shared loop invariant " << pr.pname << " ~ " << pr.vname
                      << ": the patch exits where the vuln continues, at " << short_expr(pl.p.value);
        }
    }

    // U: from the conditions of the pairs where only the patch exits, a vuln
    // invariant preserved by every vuln iteration.  The vuln exits reached
    // under U diverge.
    string u_desc;
    Phase const pu{"U"};
    if (!vuln_continues.empty()) {
        z3::expr_vector from(z3ctx), to(z3ctx);
        std::set<int> mapped;
        for (int const i : rel.R) {
            auto const &c = pr.R[i];
            if (c.c != 1 || mapped.count(c.yj)) continue;
            mapped.insert(c.yj);
            from.push_back(P.param_z3[c.yj]);
            to.push_back(V.param_z3[c.xi]);
        }
        std::vector<z3::expr> atoms;
        std::set<unsigned> seen;
        for (size_t const k : vuln_continues) {
            std::vector<z3::expr> conj;
            for (auto const &c : *pairs[k].p.state->conds) flatten_and(c, conj);
            for (auto c : conj) {
                auto const a = c.substitute(from, to).simplify();
                if (a.is_true() || a.is_false() || mentions_any(a, P.param_z3)) continue;
                if (seen.insert(a.id()).second) atoms.push_back(a);
            }
        }
        auto alive = indices(atoms.size());
        for (size_t const k : vuln_continues)
            prune(pairs[k].p.state, alive, [&](int i) { return atoms[i].substitute(V.param_z3, pairs[k].v.next); });
        std::vector<Leaf> uexits;
        for (int round = 0;; round++) {
            if (alive.empty() || round == SLI_MAX_ROUNDS) {
                LOG_INFO << "No shared loop invariant " << pr.pname << " ~ " << pr.vname
                         << (full ? " (memory inlined)" : "")
                         << ": the patch exits where the vuln continues, and no vuln invariant holds there";
                return std::nullopt;
            }
            auto const base = V.fresh_state();
            for (int const i : alive) base->conds->push_back(atoms[i]);
            std::vector<Leaf> vl;
            if (!enumerate(proj, V, vbody, base, vl)) return std::nullopt;
            uexits.clear();
            auto next = alive;
            for (auto const &l : vl) {
                if (l.kind == Leaf::Exit && !valid(l.state, V.is_none(l.value))) uexits.push_back(l);
                if (l.kind == Leaf::Cont)
                    prune(l.state, next, [&](int i) { return atoms[i].substitute(V.param_z3, l.next); });
            }
            if (next == alive) break;
            alive = next;
        }
        for (auto const &l : uexits) {
            auto const s = l.state->copy();
            s->conds->push_back(V.is_some(l.value));
            diverged[key(code_of(V, l))].push_back(Div{l, s});
        }
        std::ostringstream o;
        for (size_t k = 0; k < alive.size(); k++) o << (k ? " /\\ " : "") << show(pr, atoms[alive[k]]);
        u_desc = o.str();
    }

    pu.done(std::to_string(vuln_continues.size()) + " pairs where only the patch exits");
    Phase const pexits{"exits"};
    // Exit candidates: the pair's results, and results equal to stable
    // arguments.
    std::vector<Cand> ecands = pr.E;
    for (unsigned j = 0; j < P.res.size(); j++)
        for (int const k : stable_p)
            if ((int)j != P.code && same_sort(P.res[j], P.param_z3[k]))
                ecands.push_back(Cand{P.res[j] == P.param_z3[k], "r'." + P.args[j]->name + "=" + P.args[k]->name + "'", -1,
                                      -1, 0});
    for (unsigned j = 0; j < V.res.size(); j++)
        for (int const k : stable_v)
            if ((int)j != V.code && same_sort(V.res[j], V.param_z3[k]))
                ecands.push_back(Cand{V.res[j] == V.param_z3[k], "r." + V.args[j]->name + "=" + V.args[k]->name, -1,
                                      -1, 0});

    auto const E_at = [&](const PairLeaf &pl, int i) {
        return Subst().add(V.res, V.components(pl.v.value)).add(P.res, P.components(pl.p.value))(ecands[i].f);
    };
    auto const at_vuln = [&](const Leaf &l, z3::expr f) { return Subst().add(V.res, V.components(l.value))(f); };

    // Q for the diverged exits [ds]: the atoms over the vuln's result and the
    // stable patch arguments that hold on each.  Constants come from a model.
    auto const q_for = [&](const std::vector<Div> &ds) {
        std::vector<z3::expr> atoms;
        auto const &first = ds.front();
        z3::model ce(z3ctx);
        auto const comps = V.components(first.v.value);
        bool const has_model =
            z3_check_unsat(first.state, z3ctx.bool_val(false), ce, nullptr, sli_timeout(), false) == Z3Result::Sat;
        for (unsigned i = 0; i < V.st(); i++) {
            if ((int)i == V.code) continue;
            if (has_model) {
                auto const val = ce.eval(comps[i], true);
                if (is_ground_value(val)) atoms.push_back(V.res[i] == val);
            }
            for (unsigned j = i + 1; j < V.st(); j++)
                if ((int)j != V.code && same_sort(V.res[i], V.res[j])) atoms.push_back(V.res[i] == V.res[j]);
            for (int const k : stable_p)
                if (same_sort(V.res[i], P.param_z3[k])) atoms.push_back(V.res[i] == P.param_z3[k]);
        }
        auto alive = indices(atoms.size());
        for (auto const &d : ds) prune(d.state, alive, [&](int i) { return at_vuln(d.v, atoms[i]); });
        z3::expr_vector q(z3ctx);
        for (int const i : alive) q.push_back(atoms[i]);
        return z3::mk_and(q);
    };

    // Per vuln code, the patch code whose pairs are related; the others
    // diverge.  The choice maximizes the related pairs that Q excludes, so that
    // E constrains them, then the related pairs, then the related components.
    std::set<string> codes;
    for (auto const &[cv, ks] : exits) codes.insert(cv);
    for (auto const &[cv, ds] : diverged) codes.insert(cv);
    for (auto const &cv : codes) {
        auto base = diverged[cv];
        std::map<string, std::vector<size_t>> by_cp;
        for (size_t const k : exits[cv]) {
            auto const &pl = pairs[k];
            if (valid(pl.p.state, P.is_some(pl.p.value))) by_cp[key(code_of(P, pl.p))].push_back(k);
            else base.push_back(Div{pl.v, pl.p.state});
        }
        Relation::Group best;
        std::tuple<size_t, size_t, size_t> best_score{0, 0, 0};
        bool chosen = false;
        for (auto const &[cp, cks] : by_cp) {
            Relation::Group g;
            g.related = true;
            g.cp = code_of(P, pairs[cks.front()].p);
            // The parts of the results' states only if their equality fails.
            std::vector<int> alive, parts;
            for (int i = 0; i < (int)ecands.size(); i++) (ecands[i].part ? parts : alive).push_back(i);
            for (size_t const k : cks) prune(pairs[k].p.state, alive, [&](int i) { return E_at(pairs[k], i); });
            if (std::none_of(alive.begin(), alive.end(), [&](int i) { return ecands[i].whole; })) {
                for (size_t const k : cks) prune(pairs[k].p.state, parts, [&](int i) { return E_at(pairs[k], i); });
                alive.insert(alive.end(), parts.begin(), parts.end());
            }
            for (int const i : reduced(ecands, alive)) g.E.push_back(ecands[i]);
            auto div = base;
            for (auto const &[cp2, cks2] : by_cp)
                if (cp2 != cp)
                    for (size_t const k : cks2) div.push_back(Div{pairs[k].v, pairs[k].p.state});
            size_t excluded = cks.size();
            if (!div.empty()) {
                g.Q = q_for(div);
                excluded = 0;
                for (size_t const k : cks)
                    if (valid(pairs[k].p.state, !at_vuln(pairs[k].v, *g.Q))) excluded++;
            }
            std::tuple<size_t, size_t, size_t> const score{excluded, cks.size(), g.E.size()};
            if (!chosen || score > best_score) {
                best = g;
                best_score = score;
                chosen = true;
            }
        }
        if (!chosen && !base.empty()) best.Q = q_for(base);
        best.cv = !exits[cv].empty() ? code_of(V, pairs[exits[cv].front()].v) : code_of(V, base.front().v);
        rel.groups.push_back(best);
    }

    pexits.done(std::to_string(rel.groups.size()) + " exit codes");
    std::ostringstream o;
    o << "Shared loop invariant " << pr.pname << " ~ " << pr.vname << (full ? " (memory inlined)" : "") << ": R = {"
      << describe(pr.R, rel.R) << "}";
    for (auto const &g : rel.groups) {
        o << "; exit " << key(g.cv);
        if (g.related) o << " -> " << key(g.cp) << " {" << describe(g.E) << "}";
        if (g.Q) o << " diverged if " << show(pr, *g.Q);
    }
    if (!u_desc.empty()) o << "; where only the patch exits, the vuln continues under " << u_desc;
    LOG_INFO << o.str();
    return rel;
}

/// The vuln or patch loop a call applies, by name, and its counterpart prefix.
struct LoopName {
    string name;
    bool patch;
    string other_prefix;
};

std::optional<LoopName> loop_of(Project *proj, const z3::expr &t) {
    if (!t.is_app()) return std::nullopt;
    auto name = t.decl().name().str();
    static string const suffix = "_call";
    if (name.size() <= suffix.size() || name.compare(name.size() - suffix.size(), suffix.size(), suffix) != 0)
        return std::nullopt;
    name = name.substr(0, name.size() - suffix.size());
    auto const dot = name.rfind('.');
    if (dot == string::npos) return std::nullopt;
    name = name.substr(0, dot);
    for (bool const patch : {true, false}) {
        string const mark = patch ? "_patch_loop_" : "_vuln_loop_";
        auto const at = name.rfind(mark);
        if (at == string::npos) continue;
        auto const it = proj->defs.find(name);
        if (it == proj->defs.end() || !it->second || !instance_of(it->second.get(), Fixpoint)) return std::nullopt;
        if (it->second->absf()->z3_func.id() != t.decl().id()) return std::nullopt;
        return LoopName{name, patch, name.substr(0, at) + (patch ? "_vuln_loop_" : "_patch_loop_")};
    }
    return std::nullopt;
}

/// Calls in [roots] of loops whose name starts with [prefix].
void find_calls(Project *proj, const std::vector<z3::expr> &roots, const string &prefix,
                std::vector<std::pair<string, z3::expr>> &out) {
    std::set<unsigned> seen;
    std::vector<z3::expr> todo(roots.begin(), roots.end());
    while (!todo.empty()) {
        auto const t = todo.back();
        todo.pop_back();
        if (!seen.insert(t.id()).second || !t.is_app()) continue;
        if (auto const l = loop_of(proj, t); l && l->name.compare(0, prefix.size(), prefix) == 0)
            out.emplace_back(l->name, t);
        for (unsigned i = 0; i < t.num_args(); i++) todo.push_back(t.arg(i));
    }
}

/// The pairs whose inference is in progress.
std::set<std::pair<string, string>> active;

/// The theorem at vuln call [vc] and patch call [pc], or nothing.
std::optional<z3::expr> instantiate_uncached(Project *proj, const shared_ptr<ProveState> &state, const string &vname,
                                             const z3::expr &vc, const string &pname, const z3::expr &pc) {
    auto const key = std::make_pair(vname, pname);
    Phase const ppair{"pair " + pname + " ~ " + vname};
    auto *const pr = get_pair(proj, vname, pname);
    ppair.done();
    if (!pr) return std::nullopt;
    auto const &V = pr->v;
    auto const &P = pr->p;
    if (vc.num_args() != V.param_z3.size() || pc.num_args() != P.param_z3.size()) return std::nullopt;

    auto const at_call = Subst().add(V.param_z3, args_of(vc)).add(P.param_z3, args_of(pc));
    auto const &params = at_call.from;
    auto const &args = at_call.to;

    // Arguments with a ground value at this call.
    for (unsigned i = 0; i < params.size(); i++) {
        auto const side_v = i < V.param_z3.size();
        auto const k = side_v ? i : i - V.param_z3.size();
        auto const &side = side_v ? V : P;
        if (k == side.st() || !side.read[k]) continue;
        auto const a = args[i].simplify();
        if (!is_ground_value(a)) continue;
        auto const desc = side.args[k]->name + (side_v ? "" : "'") + "=" + short_expr(a);
        if (pr->ground.count(desc)) continue;
        pr->ground[desc] = pr->R.size();
        pr->R.push_back(Cand{params[i] == a, desc, -1, -1, 0});
    }

    auto C0 = indices(pr->R.size());
    Phase const pcall{"candidates at the call"};
    prune(state, C0, [&](int i) { return at_call(pr->R[i].f); });
    pcall.done(std::to_string(C0.size()) + " of " + std::to_string(pr->R.size()) + " hold");

    // Where a body writes the state, the loops run in lockstep only from
    // related states.
    if ((V.writes || P.writes) && std::none_of(C0.begin(), C0.end(), [&](int i) { return pr->R[i].relates; })) {
        LOG_INFO << "No shared loop invariant " << pname << " ~ " << vname
                 << ": the loops write the state, and no relation of the states holds at the call";
        return std::nullopt;
    }

    // With the memory accessors folded, a load or store is a function of the
    // whole state, so parts of the states are related only with them inlined.
    // That is the second attempt, when the first relates no whole states.
    auto const st_eq = std::find_if(pr->R.begin(), pr->R.end(), [&](const Cand &c) {
                           return c.c == 1 && c.xi == (int)V.st() && c.yj == (int)P.st();
                       }) - pr->R.begin();
    auto const attempt = [&](const std::vector<int> &C0, bool full) -> const std::optional<Relation> & {
        auto it = pr->cache.find({C0, full});
        if (it == pr->cache.end()) {
            std::ostringstream nested;
            for (auto const &[v, p] : active) nested << " in " << p << " ~ " << v;
            Phase const pinf{"inference of " + pname + " ~ " + vname + (full ? " (memory inlined)" : "") +
                             nested.str() + " from {" + describe(pr->R, C0) + "}"};
            active.insert(key);
            auto rel = infer(proj, *pr, C0, full);
            active.erase(key);
            pinf.done(rel ? "relation" : "none");
            it = pr->cache.emplace(std::make_pair(C0, full), std::move(rel)).first;
        }
        return it->second;
    };
    auto const equates = [&](const std::optional<Relation> &r) {
        return r && std::find(r->R.begin(), r->R.end(), (int)st_eq) != r->R.end();
    };
    // The parts of equal states are equal, so with the states equal at the
    // call, the inference first goes without the candidates on their parts.
    std::optional<Relation> const *found = nullptr;
    if (std::find(C0.begin(), C0.end(), (int)st_eq) != C0.end()) {
        std::vector<int> whole;
        for (int const i : C0)
            if (!pr->R[i].part) whole.push_back(i);
        if (whole.size() < C0.size()) {
            auto const &r = attempt(whole, false);
            if (equates(r)) found = &r;
        }
    }
    if (!found) {
        found = &attempt(C0, false);
        if (!equates(*found)) {
            // Inlining the accessors serves only to relate parts of the states.
            if (std::any_of(C0.begin(), C0.end(), [&](int i) { return pr->R[i].part && pr->R[i].relates; })) {
                auto const &second = attempt(C0, true);
                if (second) found = &second;
            }
        }
    }
    if (!*found) return std::nullopt;
    auto const &rel = **found;

    z3::expr_vector ent(z3ctx);
    for (int const i : rel.R) ent.push_back(at_call(pr->R[i].f));

    z3::expr post = z3ctx.bool_val(true);
    z3::expr some_code = z3ctx.bool_val(false);
    for (auto const &g : rel.groups) {
        auto const hyp = (V.code >= 0 && g.cv) ? (V.res[V.code] == *g.cv) : z3ctx.bool_val(true);
        z3::expr related = z3ctx.bool_val(false);
        if (g.related) {
            z3::expr_vector e(z3ctx);
            e.push_back(P.is_some(pc));
            if (P.code >= 0 && g.cp) e.push_back(P.res[P.code] == *g.cp);
            for (auto const &c : g.E) e.push_back(c.f);
            related = z3::mk_and(e);
        }
        post = post && z3::implies(hyp, (g.Q ? *g.Q : z3ctx.bool_val(false)) || related);
        some_code = some_code || hyp;
    }
    post = post && some_code;

    auto const at_results = Subst(at_call).add(V.res, V.components(vc)).add(P.res, P.components(pc));
    return z3::implies(z3::mk_and(ent) && V.is_some(vc), at_results(post));
}

/// The theorem at vuln call [vc] and patch call [pc], once per pair of calls.
/// It holds whichever candidates the first call's path left, so a later path
/// reuses it; a relation from that path's candidates could only be stronger.
std::optional<z3::expr> instantiate(Project *proj, const shared_ptr<ProveState> &state, const string &vname,
                                    const z3::expr &vc, const string &pname, const z3::expr &pc) {
    if (active.count({vname, pname})) return std::nullopt;
    struct Entry {
        z3::expr vc, pc;  // keep the ids of the key alive
        std::optional<z3::expr> instance;
    };
    // Never destroyed: it holds z3 terms, which must not outlive the context.
    static auto &memo = *new std::map<std::tuple<string, string, unsigned, unsigned>, Entry>();
    auto const key = std::make_tuple(vname, pname, vc.id(), pc.id());
    if (auto const it = memo.find(key); it != memo.end()) return it->second.instance;
    auto inst = instantiate_uncached(proj, state, vname, vc, pname, pc);
    memo.emplace(key, Entry{vc, pc, inst});
    return inst;
}

}  // namespace

void relate_loop_calls(Project *proj, const shared_ptr<ProveState> &state, const z3::expr &call) {
    if (!enabled()) return;
    auto const self = loop_of(proj, call);
    if (!self) return;
    std::vector<z3::expr> roots(state->conds->begin(), state->conds->end());
    roots.insert(roots.end(), state->inductions->begin(), state->inductions->end());
    std::vector<std::pair<string, z3::expr>> others;
    find_calls(proj, roots, self->other_prefix, others);
    LOG_DEBUG << "Shared loop invariant: call of " << self->name << ", " << others.size()
              << " counterpart calls on the path";
    std::set<unsigned> present;
    for (auto const &c : *state->conds) present.insert(c.id());
    for (auto const &[other, t] : others) {
        auto const inst = self->patch ? instantiate(proj, state, other, t, self->name, call)
                                      : instantiate(proj, state, self->name, call, other, t);
        if (!inst || present.count(inst->id())) continue;
        LOG_DEBUG << "Shared loop invariant instance: " << short_expr(*inst);
        state->conds->push_back(*inst);
        present.insert(inst->id());
    }
}

}  // namespace autov
