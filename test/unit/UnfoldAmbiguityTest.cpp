/* Unit tests for SpecRules::rule_unfold_specs together with
 * SpecRules::eliminate_ambiguity.
 *
 * Unfolding a call rewrites
 *
 *     f(a_1, ..., a_n)   ->   let (x_1, ..., x_n) := (a_1, ..., a_n) in <body>
 *
 * where <body> is a verbatim deep_copy of f's body, binders and all.  The
 * actuals land in the `src` of that Match, outside the scope of the binders, so
 * the rewrite is already capture-avoiding on its own.
 *
 * What it is *not* is shadow-free: the copied body can bind a name that is
 * already live at the call site.  eliminate_ambiguity is the pass that repairs
 * that, and the contract it implements is narrower than "make every binder
 * unique" -- these cases pin which half is which:
 *
 *     sibling scopes    two unfoldings in disjoint subtrees may both bind `t`;
 *                       nothing is renamed  (SiblingScopesKeepTheirNames)
 *     shadowing         a copied binder over a live one is renamed
 *                       (ShadowedBinderIsRenamed)
 *
 * Any change to how rule_unfold_specs names the binders it copies in has to
 * keep both halves, and has to keep the renaming scheme, since the names reach
 * the emitted Coq.  RenamingSchemeIsSuffixCounter pins the scheme.
 *
 * The cost is the reason to touch this at all: eliminate_ambiguity re-derives
 * the in-scope set from scratch for the whole tree, calling free_vars per Match
 * and a full-subtree subst per rename.  ElimAmbiguityDominatesUnfolding and
 * ElimAmbiguityScaling record where that sits today, so a change that makes it
 * worse is visible rather than inferred.
 */

#include <gtest/gtest.h>

#include <chrono>
#include <set>
#include <string>
#include <vector>

#include "cmd.h"
#include "nodes.h"
#include "parser.h"
#include "project.h"
#include "rules.h"

/* main.cpp is not linked into this binary, so its globals live here instead. */
SpoqOption OPTS;

using namespace autov;

namespace {

/// Add `name(args) := body` to [p].  Everything is Int, which is all these
/// cases need: the question is binder names, not types.
void add_def(Project &p, const std::string &name, const std::vector<std::string> &argnames,
             const std::string &body) {
    auto args = std::make_unique<std::vector<std::shared_ptr<Arg>>>();
    for (const auto &a : argnames) args->push_back(std::make_shared<Arg>(a, Int::INT));
    auto parsed = std::unique_ptr<SpecNode>(parser::parseExpr(&p, body));
    p.add_definition(
        std::make_unique<Definition>(name, Int::INT, std::move(args), std::move(parsed)),
        std::make_shared<loc_t>("L", name, "low"));
}

std::unique_ptr<SpecNode> parse(Project &p, const std::string &text) {
    auto node = std::unique_ptr<SpecNode>(parser::parseExpr(&p, text));
    EXPECT_TRUE(node) << "failed to parse: " << text;
    return node;
}

/// Unfold every call in [text], then repair shadowing.  [changed_out], when
/// given, receives whether the repair renamed anything.
std::string unfold_then_repair(Project &p, const std::string &text, bool *changed_out = nullptr) {
    auto [spec, unfolded] = p.rules.rule_unfold_specs(parse(p, text), true);
    EXPECT_TRUE(unfolded) << "nothing was unfolded in: " << text;
    std::set<std::string> in_scope;
    bool changed = false;
    spec = p.rules.eliminate_ambiguity(std::move(spec), in_scope, changed);
    if (changed_out) *changed_out = changed;
    return std::string(*spec);
}

/// Whitespace-collapsed, so cases can be written on one line while the printer
/// stays free to lay specs out however it likes.
std::string flat(const std::string &s) {
    std::string out;
    for (char c : s) {
        if (std::isspace(static_cast<unsigned char>(c))) {
            if (!out.empty() && out.back() != ' ') out += ' ';
        } else {
            out += c;
        }
    }
    return out;
}

size_t count(const std::string &hay, const std::string &needle) {
    size_t n = 0;
    for (size_t i = hay.find(needle); i != std::string::npos; i = hay.find(needle, i + 1)) n++;
    return n;
}

/// N nested `let t`, each shadowing the last, each calling g -- whose body also
/// binds t.  Every level therefore needs a rename, which is the shape that made
/// this pass worth looking at.
std::string nested_shadowing(int n) {
    std::string s = "u";
    for (int i = n; i >= 1; i--)
        s = "let t := " + std::to_string(i) + " in ((g (t)) + (" + s + "))";
    return s;
}

/* -- what unfolding produces -------------------------------------------------- */

// A name free in the actuals counts as live too, even though the actuals sit
// in the `src` and are never in the body's scope.  The callee's `t` is renamed
// against the caller's `t` rather than shadowing it, which is what lets later
// rules substitute through a Match by name without tracking scope.
TEST(UnfoldAmbiguity, CalleeBinderIsRenamedAgainstTheActuals) {
    Project proj;
    add_def(proj, "g", {"a"}, "let t := (a + 1) in (t + t)");

    const std::string spec = flat(unfold_then_repair(proj, "g (t)"));
    EXPECT_EQ(spec, "let a := t in let t_2 := (a + (1)) in (t_2 + (t_2))") << spec;
}

// Two unfoldings of the same callee in disjoint subtrees both bind `a` and `t`.
// Neither shadows the other, so nothing is renamed -- the contract is about
// shadowing, not global uniqueness, and a change that renames here would churn
// every emitted spec for no reason.
TEST(UnfoldAmbiguity, SiblingScopesKeepTheirNames) {
    Project proj;
    add_def(proj, "g", {"a"}, "let t := (a + 1) in (t + t)");

    bool changed = true;
    const std::string spec = flat(unfold_then_repair(proj, "(g (u)) + (g (v))", &changed));
    EXPECT_FALSE(changed) << "sibling scopes were renamed:\n" << spec;
    EXPECT_EQ(count(spec, "let a :="), 2u) << spec;
    EXPECT_EQ(count(spec, "let t :="), 2u) << spec;
    EXPECT_EQ(count(spec, "t_0"), 0u) << "a sibling scope was renamed:\n" << spec;
}

// A copied binder over a live one is renamed, and only the callee's uses follow
// the new name -- the caller's `t` after the call still reads the caller's 5.
// Which pass does the renaming is not asserted here; see
// UnfoldingIntroducesNoShadowing.
TEST(UnfoldAmbiguity, ShadowedBinderIsRenamed) {
    Project proj;
    add_def(proj, "g", {"a"}, "let t := (a + 1) in (t + t)");

    const std::string spec = flat(unfold_then_repair(proj, "let t := 5 in ((g (t)) + t)"));
    EXPECT_EQ(spec, "let t := 5 in ((let a := t in let t_2 := (a + (1)) in (t_2 + (t_2))) + (t))")
        << spec;
}

// The scheme is a `_<n>` suffix on the root, with n sized from the scope rather
// than counted up from zero -- so a scope already holding t, t_0, t_1 does not
// cost three probes to get past.  An existing numeric suffix is replaced, not
// appended to, so repeated renaming cannot grow t_0_1_7.
//
// Pinned exactly because these names reach the emitted Coq: changing the scheme
// rewrites the text of every spec that has ever needed a rename.
TEST(UnfoldAmbiguity, RenamingSkipsPastTheLiveNames) {
    Project proj;
    add_def(proj, "g", {"a"}, "let t := (a + 1) in (t + t)");

    const std::string spec = flat(unfold_then_repair(
        proj, "let t := 1 in let t_0 := 2 in let t_1 := 3 in ((g (t)) + (t + (t_0 + t_1)))"));
    EXPECT_NE(spec.find("let t_4 :="), std::string::npos)
        << "expected the callee's t to clear the live t/t_0/t_1:\n" << spec;
    // Whatever the suffix, it must not collide with a name already live.
    for (const char *live : {"let t_0 := (a", "let t_1 := (a"})
        EXPECT_EQ(spec.find(live), std::string::npos)
            << "the callee reused a live name:\n" << spec;
}

// Renaming settles: a second repair pass has nothing left to do.  Anything that
// moves shadow repair into unfolding has to keep this, or the transformation
// loop it runs inside will never report convergence.
TEST(UnfoldAmbiguity, RepairIsIdempotent) {
    Project proj;
    add_def(proj, "g", {"a"}, "let t := (a + 1) in (t + t)");

    auto [spec, unfolded] = proj.rules.rule_unfold_specs(
        parse(proj, "let t := 5 in ((g (t)) + (let t := 6 in ((g (t)) + t)))"), true);
    ASSERT_TRUE(unfolded);

    std::set<std::string> in_scope;
    bool first = false;
    spec = proj.rules.eliminate_ambiguity(std::move(spec), in_scope, first);
    EXPECT_TRUE(first);
    const std::string once = std::string(*spec);

    // `changed` is an accumulator -- eliminate_ambiguity only ever ORs into it --
    // so it has to start false for the second pass to mean anything.
    std::set<std::string> again_scope;
    bool second = false;
    spec = proj.rules.eliminate_ambiguity(std::move(spec), again_scope, second);
    EXPECT_FALSE(second) << "a second repair pass still renamed something";
    EXPECT_EQ(std::string(*spec), once) << "repair is not idempotent";
}

// Unfolding renames as it copies, so it introduces no shadowing of its own and
// the repair pass finds nothing to do.  This is the property the renaming exists
// to buy: repair has to walk the whole enclosing term and substitute over a
// subtree per rename, which is where the cost below comes from.
//
// Only shadowing that unfolding would have introduced is covered.  A caller that
// already shadows itself still needs repair -- UnfoldingDoesNotRepairTheCaller.
TEST(UnfoldAmbiguity, UnfoldingIntroducesNoShadowing) {
    Project proj;
    add_def(proj, "g", {"a"}, "let t := (a + 1) in (t + t)");

    for (const std::string &input : {
             std::string("g (t)"),
             std::string("(g (u)) + (g (v))"),
             std::string("let t := 5 in ((g (t)) + t)"),
             std::string("let t := 5 in (let u := 6 in ((g (t)) + (g (u))))"),
         }) {
        auto [spec, unfolded] = proj.rules.rule_unfold_specs(parse(proj, input), true);
        ASSERT_TRUE(unfolded) << input;
        const std::string before = std::string(*spec);

        std::set<std::string> in_scope;
        bool changed = false;
        spec = proj.rules.eliminate_ambiguity(std::move(spec), in_scope, changed);
        EXPECT_FALSE(changed) << "repair still renamed something in:\n" << input;
        EXPECT_EQ(std::string(*spec), before) << "repair changed the spec for:\n" << input;
    }
}

// Shadowing the caller already had is not unfolding's to fix: `let t := 6`
// under `let t := 5` is ambiguous before anything is unfolded, and repair still
// renames it.  Pinned so the division of labour stays explicit.
TEST(UnfoldAmbiguity, UnfoldingDoesNotRepairTheCaller) {
    Project proj;
    add_def(proj, "g", {"a"}, "let t := (a + 1) in (t + t)");

    auto [spec, unfolded] = proj.rules.rule_unfold_specs(
        parse(proj, "let t := 5 in ((g (t)) + (let t := 6 in ((g (t)) + t)))"), true);
    ASSERT_TRUE(unfolded);

    std::set<std::string> in_scope;
    bool changed = false;
    spec = proj.rules.eliminate_ambiguity(std::move(spec), in_scope, changed);
    EXPECT_TRUE(changed) << "the caller's own shadowing was not repaired";
    EXPECT_NE(flat(std::string(*spec)).find("let t_1 := 6"), std::string::npos)
        << flat(std::string(*spec));
}

/* -- what it costs ------------------------------------------------------------ */

double millis_of(const std::function<void()> &f) {
    const auto start = std::chrono::steady_clock::now();
    f();
    return std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::steady_clock::now() -
                                                                 start)
               .count() /
           1000.0;
}

// Repair costs far more than the unfolding it repairs.  A loose bound, so it
// says something about the shape of the cost rather than about this machine:
// moving the work into unfolding should shrink this ratio, and nothing should
// make it grow.
TEST(UnfoldAmbiguity, ElimAmbiguityDominatesUnfolding) {
    Project proj;
    add_def(proj, "g", {"a"}, "let t := (a + 1) in (t + t)");
    auto call = parse(proj, nested_shadowing(64));

    std::unique_ptr<SpecNode> spec;
    const double unfold_ms = millis_of([&] {
        auto [out, unfolded] = proj.rules.rule_unfold_specs(std::move(call), true);
        ASSERT_TRUE(unfolded);
        spec = std::move(out);
    });

    std::set<std::string> in_scope;
    bool changed = false;
    const double repair_ms =
        millis_of([&] { spec = proj.rules.eliminate_ambiguity(std::move(spec), in_scope, changed); });
    EXPECT_TRUE(changed);

    EXPECT_LT(repair_ms, unfold_ms * 500)
        << "repair " << repair_ms << "ms vs unfold " << unfold_ms
        << "ms -- repair got dramatically more expensive relative to unfolding";
}

// Repair is superlinear in the size of the spec it walks: it recomputes
// free_vars per Match and substitutes over a whole subtree per rename.  Doubling
// the nesting must not cost more than ~8x, which fails long before it reaches
// the runaway seen on real inputs but passes with room at today's ~3x.
TEST(UnfoldAmbiguity, ElimAmbiguityScaling) {
    const auto repair_ms = [](int n) {
        Project proj;
        add_def(proj, "g", {"a"}, "let t := (a + 1) in (t + t)");
        auto [spec, unfolded] = proj.rules.rule_unfold_specs(
            std::unique_ptr<SpecNode>(parser::parseExpr(&proj, nested_shadowing(n))), true);
        EXPECT_TRUE(unfolded);
        std::set<std::string> in_scope;
        bool changed = false;
        std::unique_ptr<SpecNode> out = std::move(spec);
        return millis_of(
            [&] { out = proj.rules.eliminate_ambiguity(std::move(out), in_scope, changed); });
    };

    const double at32 = repair_ms(32);
    const double at64 = repair_ms(64);
    ASSERT_GT(at32, 0.0) << "timer resolution too coarse to compare";
    EXPECT_LT(at64, at32 * 8)
        << "repair went from " << at32 << "ms at 32 levels to " << at64
        << "ms at 64 -- growth got steeper than it already was";
}

}  // namespace
