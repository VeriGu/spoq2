#include <shared_loop_inv.h>

#include <rules.h>
#include <symbolic.h>
#include <values.h>

#include <algorithm>
#include <cstdlib>
#include <functional>
#include <map>
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

/// Whether [e] applies [f] anywhere.
bool mentions(const z3::expr &e, const z3::func_decl &f) {
    std::set<unsigned> seen;
    std::vector<z3::expr> todo{e};
    while (!todo.empty()) {
        auto const t = todo.back();
        todo.pop_back();
        if (!seen.insert(t.id()).second || !t.is_app()) continue;
        if (t.decl().id() == f.id()) return true;
        for (unsigned i = 0; i < t.num_args(); i++) todo.push_back(t.arg(i));
    }
    return false;
}

/// Whether [e] mentions one of [consts].
bool mentions_any(const z3::expr &e, const z3::expr_vector &consts) {
    std::set<unsigned> ids;
    for (auto const c : consts) ids.insert(c.decl().id());
    std::set<unsigned> seen;
    std::vector<z3::expr> todo{e};
    while (!todo.empty()) {
        auto const t = todo.back();
        todo.pop_back();
        if (!seen.insert(t.id()).second || !t.is_app()) continue;
        if (t.num_args() == 0 && ids.count(t.decl().id())) return true;
        for (unsigned i = 0; i < t.num_args(); i++) todo.push_back(t.arg(i));
    }
    return false;
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

/// One loop of the pair: fresh values for its arguments and its result
/// components, and the result component that holds its exit code.
struct Side {
    Fixpoint *def = nullptr;
    /// The body with small callees inlined, and with the memory accessors
    /// inlined as well, for relating parts of the state.
    std::shared_ptr<SpecNode> body, full;
    /// The string constants of the full body, which may key the stack.
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

    /// A state over this loop's arguments with [from]'s path conditions.
    shared_ptr<ProveState> rebind(const shared_ptr<ProveState> &from) const {
        auto const s = fresh_state();
        *s->conds = *from->conds;
        *s->inductions = *from->inductions;
        return s;
    }

    unsigned st() const { return args.size() - 1; }
};

struct Leaf {
    enum Kind { None, Cont, Exit } kind;
    shared_ptr<ProveState> state;
    z3::expr value;
    z3::expr_vector next;
};

/// The paths of one iteration of [side]'s body from [state].  A leaf calling
/// the loop is a continuation with the call's arguments.  False if the loop
/// recurses other than in tail position.  With [hooks], nested loop calls get
/// their relational postconditions.
bool enumerate(Project *proj, const Side &side, SpecNode *n, const shared_ptr<ProveState> &state, std::vector<Leaf> &out,
               bool hooks) {
    if (auto r = instance_of(n, Rely)) {
        state->conds->push_back(as_bool(z3_eval(proj, r->prop.get(), state)->get_z3_value()));
        if (!feasible(state)) return true;
        return enumerate(proj, side, r->body.get(), state, out, hooks);
    }
    if (auto a = instance_of(n, Anno)) return enumerate(proj, side, a->body.get(), state, out, hooks);
    if (auto iff = instance_of(n, If)) {
        auto const c = as_bool(z3_eval(proj, iff->cond.get(), state)->get_z3_value());
        for (bool const b : {true, false}) {
            auto const s = state->copy();
            s->conds->push_back(b ? c : !c);
            if (!feasible(s)) continue;
            if (!enumerate(proj, side, b ? iff->then_body.get() : iff->else_body.get(), s, out, hooks)) return false;
        }
        return true;
    }
    if (auto m = instance_of(n, Match)) {
        auto const src = z3_eval(proj, m->src.get(), state);
        if (mentions(src->get_z3_value(), *side.call)) return false;
        if (hooks) relate_loop_calls(proj, state, src->get_z3_value());
        std::vector<z3::expr> earlier;
        for (auto const &pm : *m->match_list) {
            unordered_map<string, shared_ptr<SpecValue>> vars, assigns;
            auto const cond = match_arm_condition(proj, m, pm->pattern.get(), src, vars, assigns);
            auto const s = state->copy();
            for (auto const &[k, v] : assigns) (*s->vars)[k] = v;
            for (auto const &e : earlier) s->conds->push_back(!e);
            s->conds->push_back(cond);
            earlier.push_back(cond);
            if (!feasible(s)) continue;
            if (!enumerate(proj, side, pm->body.get(), s, out, hooks)) return false;
        }
        return true;
    }
    auto const v = z3_eval(proj, n, state)->get_z3_value().simplify();
    if (v.is_app() && v.decl().id() == side.call->id()) {
        z3::expr_vector next(z3ctx);
        for (unsigned i = 0; i < v.num_args(); i++) next.push_back(v.arg(i));
        out.push_back(Leaf{Leaf::Cont, state, v, next});
        return true;
    }
    if (mentions(v, *side.call)) return false;
    bool const none = v.is_app() && v.decl().name().str() == side.rettype->none_name();
    out.push_back(Leaf{none ? Leaf::None : Leaf::Exit, state, v, z3::expr_vector(z3ctx)});
    return true;
}

/// Marks in [read] each argument of [loop] that [n] reads other than by
/// passing it to its own position in a recursive call.
void mark_reads(SpecNode *n, const Fixpoint *loop, std::vector<bool> &read) {
    if (!n) return;
    if (auto sym = instance_of(n, Symbol)) {
        for (size_t i = 0; i < loop->args->size(); i++)
            if (loop->args->at(i)->name == sym->text) read[i] = true;
    } else if (auto e = instance_of(n, Expr)) {
        if (auto f = std::get_if<unique_ptr<SpecNode>>(&e->op)) mark_reads(f->get(), loop, read);
        bool const rec = op_eq(e->op, loop->name);
        if (e->elems)
            for (size_t k = 0; k < e->elems->size(); k++) {
                auto const sym = instance_of(e->elems->at(k).get(), Symbol);
                if (rec && sym && k < loop->args->size() && sym->text == loop->args->at(k)->name) continue;
                mark_reads(e->elems->at(k).get(), loop, read);
            }
    } else if (auto m = instance_of(n, Match)) {
        mark_reads(m->src.get(), loop, read);
        for (auto const &pm : *m->match_list) mark_reads(pm->body.get(), loop, read);
    } else if (auto i = instance_of(n, If)) {
        mark_reads(i->cond.get(), loop, read);
        mark_reads(i->then_body.get(), loop, read);
        mark_reads(i->else_body.get(), loop, read);
    } else if (auto r = instance_of(n, RelyAnno)) {
        mark_reads(r->prop.get(), loop, read);
        mark_reads(r->body.get(), loop, read);
    } else if (auto q = instance_of(n, ForallExists)) {
        mark_reads(q->body.get(), loop, read);
    }
}

void collect_callees(SpecNode *n, std::set<string> &out) {
    if (!n) return;
    if (auto e = instance_of(n, Expr)) {
        if (auto op = std::get_if<string>(&e->op)) out.insert(*op);
        if (auto f = std::get_if<unique_ptr<SpecNode>>(&e->op)) collect_callees(f->get(), out);
        if (e->elems)
            for (auto const &x : *e->elems) collect_callees(x.get(), out);
    } else if (auto m = instance_of(n, Match)) {
        collect_callees(m->src.get(), out);
        for (auto const &pm : *m->match_list) collect_callees(pm->body.get(), out);
    } else if (auto i = instance_of(n, If)) {
        collect_callees(i->cond.get(), out);
        collect_callees(i->then_body.get(), out);
        collect_callees(i->else_body.get(), out);
    } else if (auto r = instance_of(n, RelyAnno)) {
        collect_callees(r->prop.get(), out);
        collect_callees(r->body.get(), out);
    } else if (auto q = instance_of(n, ForallExists)) {
        collect_callees(q->body.get(), out);
    }
}

void collect_strings(SpecNode *n, std::set<string> &out) {
    if (!n) return;
    if (auto c = instance_of(n, Const)) {
        if (auto v = std::get_if<string>(&c->value)) out.insert(*v);
    }
    else if (auto e = instance_of(n, Expr)) {
        if (auto f = std::get_if<unique_ptr<SpecNode>>(&e->op)) collect_strings(f->get(), out);
        if (e->elems)
            for (auto const &x : *e->elems) collect_strings(x.get(), out);
    } else if (auto m = instance_of(n, Match)) {
        collect_strings(m->src.get(), out);
        for (auto const &pm : *m->match_list) collect_strings(pm->body.get(), out);
    } else if (auto i = instance_of(n, If)) {
        collect_strings(i->cond.get(), out);
        collect_strings(i->then_body.get(), out);
        collect_strings(i->else_body.get(), out);
    } else if (auto r = instance_of(n, RelyAnno)) {
        collect_strings(r->prop.get(), out);
        collect_strings(r->body.get(), out);
    } else if (auto q = instance_of(n, ForallExists)) {
        collect_strings(q->body.get(), out);
    }
}

/// [loop]'s body with each small, non-recursive callee inlined, so that
/// conditions such as `xorb_spec c true` are visible to the solver.  Loops stay
/// folded, and callees marked DelayUnfold unless [full].
unique_ptr<SpecNode> prepared_body(Project *proj, Fixpoint *loop, bool full) {
    auto body = loop->body()->deep_copy();
    size_t const limit = full ? SLI_FULL_INLINE_LEAVES : SLI_INLINE_LEAVES;
    // DelayUnfold callees are otherwise skipped by the unfolding itself.
    struct SkipGuard {
        bool saved = UNFOLD_POLICY.skip;
        ~SkipGuard() { UNFOLD_POLICY.skip = saved; }
    } const guard;
    if (full) UNFOLD_POLICY.skip = false;
    bool any = false;
    for (int round = 0; round < (full ? SLI_INLINE_ROUNDS : 1); round++) {
        std::set<string> callees;
        collect_callees(body.get(), callees);
        bool changed_round = false;
        for (auto const &c : callees) {
            auto const it = proj->defs.find(c);
            if (it == proj->defs.end() || !it->second || c == loop->name || instance_of(it->second.get(), Fixpoint))
                continue;
            if ((!full && UNFOLD_POLICY.skip_list.count(c)) || !it->second->body()) continue;
            if (it->second->body()->count_leaves(limit + 1) > limit) continue;
            std::set<string> inner;
            collect_callees(it->second->body().get(), inner);
            if (inner.count(c)) continue;
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
    s.full = prepared_body(proj, fix, true);
    std::set<string> strings;
    collect_strings(s.full.get(), strings);
    s.strings.assign(strings.begin(), strings.end());
    s.read.assign(s.args.size(), false);
    mark_reads(s.body.get(), fix, s.read);
    s.read.back() = true;

    // The exit code is the last component that is a numeral at every exit.
    std::vector<Leaf> leaves;
    if (!enumerate(proj, s, s.body.get(), s.fresh_state(), leaves, false)) return std::nullopt;
    std::vector<bool> numeral(s.res.size() - 1, true);
    bool any_exit = false;
    for (auto const &l : leaves) {
        if (l.kind != Leaf::Exit) continue;
        any_exit = true;
        auto const c = s.components(l.value);
        for (unsigned k = 0; k + 1 < s.res.size(); k++)
            if (!c[k].is_numeral()) numeral[k] = false;
    }
    if (any_exit)
        for (int k = (int)numeral.size() - 1; k >= 0; k--)
            if (numeral[k]) { s.code = k; break; }
    return s;
}

/// y_j = c * x_i, an equality if c is 1 and a congruence modulo 2^32 otherwise.
/// With c = 0, another fact; [part] marks one about parts of the states, which
/// the equality of the states, marked [whole], implies.
struct Cand {
    z3::expr f;
    string desc;
    int xi, yj, c;
    bool part = false, whole = false;
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

std::vector<Cand> reduced(const std::vector<Cand> &cands) {
    std::vector<int> all;
    for (int i = 0; i < (int)cands.size(); i++) all.push_back(i);
    std::vector<Cand> out;
    for (int const i : reduced(cands, all)) out.push_back(cands[i]);
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

string short_expr(const z3::expr &e);

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
            out.push_back(Cand{z3::select(x, key) == z3::select(y, key), yn + at + "=" + xn + at, -1, -1, 0, true});
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
        out.push_back(Cand{rest == y, yn + "=" + xn + " outside the keys", -1, -1, 0, true});
        return;
    }
    if (depth >= SLI_FIELD_DEPTH || !s.is_datatype() || s.constructors().size() != 1) return;
    for (auto const acc : s.constructors()[0].accessors()) {
        auto const ax = acc(x), ay = acc(y);
        auto const f = acc.name().str();
        out.push_back(Cand{ax == ay, yn + "." + f + "=" + xn + "." + f, -1, -1, 0, true});
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
            if (c.c == 1 && c.xi == (int)V.st() && c.yj == (int)P.st()) c.whole = true;
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

string describe(const std::vector<Cand> &cands) {
    std::ostringstream o;
    for (size_t k = 0; k < cands.size(); k++) o << (k ? ", " : "") << cands[k].desc;
    return o.str();
}

string short_expr(const z3::expr &e) {
    auto s = e.to_string();
    std::replace(s.begin(), s.end(), '\n', ' ');
    return s.size() > 300 ? s.substr(0, 300) + "..." : s;
}

struct PairLeaf {
    Leaf v, p;
};

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
    auto *const vbody = (full ? V.full : V.body).get();
    auto *const pbody = (full ? P.full : P.body).get();
    z3::expr_vector params(z3ctx);
    for (auto const e : V.param_z3) params.push_back(e);
    for (auto const e : P.param_z3) params.push_back(e);

    Relation rel;
    rel.R = C0;
    std::vector<PairLeaf> pairs;
    for (int round = 0;; round++) {
        if (round == SLI_MAX_ROUNDS) return std::nullopt;
        pairs.clear();
        auto const base = V.fresh_state();
        for (int const i : rel.R) base->conds->push_back(pr.R[i].f);
        std::vector<Leaf> vl;
        if (!enumerate(proj, V, vbody, base, vl, true)) return std::nullopt;
        for (auto const &lv : vl) {
            if (lv.kind == Leaf::None) continue;
            if (lv.kind == Leaf::Exit && valid(lv.state, V.is_none(lv.value))) continue;
            auto const ps = P.rebind(lv.state);
            if (lv.kind == Leaf::Exit) ps->conds->push_back(V.is_some(lv.value));
            std::vector<Leaf> pl;
            if (!enumerate(proj, P, pbody, ps, pl, true)) return std::nullopt;
            for (auto const &lp : pl) pairs.push_back(PairLeaf{lv, lp});
        }
        auto next = rel.R;
        for (auto const &pl : pairs) {
            if (pl.v.kind != Leaf::Cont || pl.p.kind != Leaf::Cont) continue;
            z3::expr_vector to(z3ctx);
            for (auto const e : pl.v.next) to.push_back(e);
            for (auto const e : pl.p.next) to.push_back(e);
            prune(pl.p.state, next, [&](int i) { return pr.R[i].f.substitute(params, to); });
        }
        if (next == rel.R) break;
        rel.R = next;
    }
    rel.R = reduced(pr.R, rel.R);

    // Arguments passed unchanged to every next iteration.  Q and E may state
    // facts about them, which then hold of the arguments at the call.
    std::vector<int> stable_v, stable_p;
    for (unsigned j = 0; j < V.st(); j++) stable_v.push_back(j);
    for (unsigned j = 0; j < P.st(); j++) stable_p.push_back(j);
    for (auto const &pl : pairs)
        if (pl.v.kind == Leaf::Cont && pl.p.kind == Leaf::Cont) {
            prune(pl.p.state, stable_v, [&](int j) { return z3_eq(pl.v.next[j], V.param_z3[j]); });
            prune(pl.p.state, stable_p, [&](int j) { return z3_eq(pl.p.next[j], P.param_z3[j]); });
        }

    auto const code_of = [](const Side &s, const Leaf &l) -> std::optional<z3::expr> {
        if (s.code < 0 || l.kind != Leaf::Exit) return std::nullopt;
        auto const c = s.components(l.value)[s.code];
        if (c.is_numeral()) return c;
        return std::nullopt;
    };
    auto const key = [](const std::optional<z3::expr> &c) { return c ? c->to_string() : string("*"); };

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
        std::vector<int> alive;
        for (int i = 0; i < (int)atoms.size(); i++) alive.push_back(i);
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
            if (!enumerate(proj, V, vbody, base, vl, true)) return std::nullopt;
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
        z3::expr_vector from(z3ctx), to(z3ctx);
        auto const cv = V.components(pl.v.value), cp = P.components(pl.p.value);
        for (unsigned k = 0; k < V.res.size(); k++) from.push_back(V.res[k]), to.push_back(cv[k]);
        for (unsigned k = 0; k < P.res.size(); k++) from.push_back(P.res[k]), to.push_back(cp[k]);
        return ecands[i].f.substitute(from, to);
    };

    auto const at_vuln = [&](const Leaf &l, z3::expr f) {
        z3::expr_vector to(z3ctx);
        for (auto const e : V.components(l.value)) to.push_back(e);
        return f.substitute(V.res, to);
    };

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
        std::vector<int> alive;
        for (int i = 0; i < (int)atoms.size(); i++) alive.push_back(i);
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
            std::vector<int> alive;
            for (int i = 0; i < (int)ecands.size(); i++) alive.push_back(i);
            for (size_t const k : cks) prune(pairs[k].p.state, alive, [&](int i) { return E_at(pairs[k], i); });
            for (int const i : alive) g.E.push_back(ecands[i]);
            g.E = reduced(g.E);
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

    auto const code_str = [](const std::optional<z3::expr> &c) { return c ? c->get_decimal_string(0) : string("*"); };
    std::ostringstream o;
    o << "Shared loop invariant " << pr.pname << " ~ " << pr.vname << (full ? " (memory inlined)" : "") << ": R = {"
      << describe(pr.R, rel.R) << "}";
    for (auto const &g : rel.groups) {
        o << "; exit " << code_str(g.cv);
        if (g.related) o << " -> " << code_str(g.cp) << " {" << describe(g.E) << "}";
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

/// The theorem at vuln call [vc] and patch call [pc], or nothing.
std::optional<z3::expr> instantiate(Project *proj, const shared_ptr<ProveState> &state, const string &vname,
                                    const z3::expr &vc, const string &pname, const z3::expr &pc) {
    static std::set<std::pair<string, string>> active;
    auto const key = std::make_pair(vname, pname);
    if (active.count(key)) return std::nullopt;
    auto *const pr = get_pair(proj, vname, pname);
    if (!pr) return std::nullopt;
    auto const &V = pr->v;
    auto const &P = pr->p;
    if (vc.num_args() != V.param_z3.size() || pc.num_args() != P.param_z3.size()) return std::nullopt;

    z3::expr_vector params(z3ctx), args(z3ctx);
    for (unsigned i = 0; i < V.param_z3.size(); i++) params.push_back(V.param_z3[i]), args.push_back(vc.arg(i));
    for (unsigned i = 0; i < P.param_z3.size(); i++) params.push_back(P.param_z3[i]), args.push_back(pc.arg(i));

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

    std::vector<int> C0;
    for (int i = 0; i < (int)pr->R.size(); i++) C0.push_back(i);
    prune(state, C0, [&](int i) { return pr->R[i].f.substitute(params, args); });
    if (C0.size() < pr->R.size())
        LOG_DEBUG << "Shared loop invariant " << pname << " ~ " << vname << ": " << pr->R.size() - C0.size()
                  << " of " << pr->R.size() << " candidates fail at the call";

    // With the memory accessors folded, a load or store is a function of the
    // whole state, so parts of the states are related only with them inlined.
    // That is the second attempt, when the first relates no whole states.
    auto const st_eq = std::find_if(pr->R.begin(), pr->R.end(), [&](const Cand &c) {
                           return c.c == 1 && c.xi == (int)V.st() && c.yj == (int)P.st();
                       }) - pr->R.begin();
    auto const attempt = [&](bool full) -> const std::optional<Relation> & {
        auto it = pr->cache.find({C0, full});
        if (it == pr->cache.end()) {
            active.insert(key);
            auto rel = infer(proj, *pr, C0, full);
            active.erase(key);
            it = pr->cache.emplace(std::make_pair(C0, full), std::move(rel)).first;
        }
        return it->second;
    };
    auto const *found = &attempt(false);
    if (!*found || std::find(found->value().R.begin(), found->value().R.end(), (int)st_eq) == found->value().R.end()) {
        auto const &second = attempt(true);
        if (second) found = &second;
    }
    if (!*found) return std::nullopt;
    auto const &rel = **found;

    z3::expr_vector ent(z3ctx);
    for (int const i : rel.R) ent.push_back(pr->R[i].f.substitute(params, args));

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

    z3::expr_vector from(z3ctx), to(z3ctx);
    auto const cv = V.components(vc), cp = P.components(pc);
    for (unsigned k = 0; k < V.res.size(); k++) from.push_back(V.res[k]), to.push_back(cv[k]);
    for (unsigned k = 0; k < P.res.size(); k++) from.push_back(P.res[k]), to.push_back(cp[k]);
    for (unsigned k = 0; k < V.param_z3.size(); k++) from.push_back(V.param_z3[k]), to.push_back(vc.arg(k));
    for (unsigned k = 0; k < P.param_z3.size(); k++) from.push_back(P.param_z3[k]), to.push_back(pc.arg(k));
    return z3::implies(z3::mk_and(ent) && V.is_some(vc), post.substitute(from, to));
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
