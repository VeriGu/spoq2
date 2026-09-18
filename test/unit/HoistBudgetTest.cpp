/* When hoist_match_from_branch distributes a match over a branch.
 *
 * The match-of-if and match-of-match cases run the rewrite only when both
 * conditions in hoist_is_worthwhile hold: some pattern matches a leaf of the
 * branch frontier, and the copies of the match's arms fit the leaf budget (400
 * by default, SPOQ_HOIST_BUDGET).  Each case below fixes one of them.
 *
 * Decidability is asked at the leaves rather than at the root of each branch
 * body, because that is where distribution puts the copies, and try_match on an
 * If has no constructor to compare.  Cost is charged to the arms rather than to
 * the whole match node, because the hoist releases the scrutinee before copying
 * and re-parents its branches.
 *
 * The first case is reduced from hidden_ub_nounfold_inner_load, where the node
 * measures 896 leaves with 891 of them in the scrutinee's conditions and arms
 * of 2 and 1.  Refusing it leaves the vuln spec's UB under an undischarged
 * match, and the refinement check reports UB in the patch that the spec does
 * not have.
 */

#include <gtest/gtest.h>

#include <fstream>
#include <sstream>
#include <string>

#include "cmd.h"
#include "nodes.h"
#include "parser.h"
#include "project.h"
#include "rules.h"

/* main.cpp is not linked into this binary, so its globals live here instead. */
SpoqOption OPTS;

using namespace autov;

namespace {

constexpr const char *kMainV = SPOQ_DEMAND_DIR "/hidden_ub_unfold_not_triggered_fail.main.v";

/* The default of hoist_budget(), which is in an anonymous namespace. */
constexpr size_t kDefaultBudget = 400;

std::string read_file(const std::string &path) {
    std::ifstream in(path);
    EXPECT_TRUE(in) << "cannot open " << path;
    std::stringstream ss;
    ss << in.rdbuf();
    return ss.str();
}

/// A conjunction of [n] comparisons, so leaves grow linearly in [n].
///
/// Nothing decides it: the offset is symbolic.  Its only role is to make the
/// scrutinee large without changing what the branch computes.
std::string wide_condition(int n) {
    std::string c = "(((d.(poffset)) >? (0)) /\\ (true))";
    for (int i = 1; i < n; i++)
        c = "(((d.(poffset)) >? (" + std::to_string(i) + ")) /\\ " + c + ")";
    return c;
}

/// A sum of [n] terms, to make a match arm large.
std::string wide_value(int n) {
    std::string v = "v_1";
    for (int i = 1; i < n; i++) v = "(" + v + " + (" + std::to_string(i) + "))";
    return v;
}

/// `if [cond] then [then_body] else [else_body]`, spliced in as a scrutinee.
std::string branch(const std::string &cond, const std::string &then_body,
                   const std::string &else_body) {
    return "if " + cond + "\n"
           "then " + then_body + "\n"
           "else " + else_body;
}

/// A branch whose leaves are a constructor and an opaque call.  Its root is an
/// If, so only a walk to the leaves finds the constructor.
std::string branch_to_none(const std::string &cond) {
    return "(if " + cond + " then None else (opaque_spec d st))";
}

/// A branch whose leaves are both opaque calls, so no pattern matches one.
std::string branch_opaque(const std::string &cond) {
    return "(if " + cond + " then (opaque_spec d st) else (opaque_spec d st))";
}

/// The project a case is built in: the .main.v, an opaque call for the branch
/// leaves, the scrutinee, and the match to splice it into.
///
/// Both definitions declare their return type, which is what types the bare
/// `None`s.  An If reached as a match scrutinee has no expected type, and
/// infer_type asserts on the two branches disagreeing, so the scrutinee is
/// parsed at the top of its own definition and moved into place afterwards.
std::unique_ptr<Project> parse_case(const std::string &scrutinee, const std::string &arm_value,
                                    const std::string &name) {
    auto const tmp = std::string("/tmp/") + name + "_hoist_fixture.v";
    {
        std::ofstream out(tmp);
        out << read_file(kMainV)
            << "\n\nDefinition opaque_spec (d: Ptr) (st: RData) : (option ((Z) * RData)) :=\n"
               "  match (load_RData (8) d st) with\n"
               "  | None => None\n"
               "  | (Some v_0) => (Some (v_0, st))\n"
               "  end.\n"
               "\nDefinition scrutinee (d: Ptr) (st: RData) : (option ((Z) * RData)) :=\n"
            << scrutinee << ".\n"
            << "\nDefinition " << name
            << " (d: Ptr) (st: RData) : (option ((Z) * RData)) :=\n"
               "  match (opaque_spec d st) with\n"
               "  | None => None\n"
               "  | (Some (v_1, st_2)) => (Some (" << arm_value << ", st_2))\n"
               "  end.\n";
    }
    auto proj = std::make_unique<Project>();
    parser::parse(proj.get(), tmp);
    return proj;
}

struct Case {
    std::unique_ptr<Project> proj;
    std::unique_ptr<SpecNode> spec;
    size_t total_leaves = 0, src_leaves = 0, arm_leaves = 0;
};

/// `match [scrutinee] with | None => .. | Some .. => [arm_value]`.
Case load(const std::string &scrutinee, const std::string &arm_value, const std::string &name) {
    Case c;
    c.proj = parse_case(scrutinee, arm_value, name);
    auto outer = c.proj->defs.find(name);
    auto src = c.proj->defs.find("scrutinee");
    EXPECT_NE(outer, c.proj->defs.end()) << "the match did not parse";
    EXPECT_NE(src, c.proj->defs.end()) << "the scrutinee did not parse";
    if (outer == c.proj->defs.end() || src == c.proj->defs.end()) return c;
    c.spec = std::move(outer->second->body());
    auto *m = instance_of(c.spec.get(), Match);
    EXPECT_NE(m, nullptr) << "the case is not a match: " << std::string(*c.spec);
    if (!m) return c;
    m->src = std::move(src->second->body());
    c.total_leaves = m->count_leaves();
    c.src_leaves = m->src->count_leaves();
    for (auto &pm : *m->match_list) c.arm_leaves += pm->count_leaves();
    return c;
}

/// Run the rule and report whether it distributed the match.
bool hoisted(Case &c) {
    auto const before = std::string(*c.spec);
    bool changed = false;
    std::tie(c.spec, changed) = c.proj->rules.hoist_match_from_branch(std::move(c.spec));
    auto const after = std::string(*c.spec);
    EXPECT_EQ(changed, before != after) << "reported a change it did not make, or the reverse";
    return instance_of(c.spec.get(), If) != nullptr;
}

}  // namespace

/// The scrutinee is what a spec's memory dispatch looks like: two branches on
/// large conditions, with `None` and a call at the leaves.  Nothing decides it
/// at the root of either branch, and its leaf count is well over the budget,
/// but the arms are six leaves and one of the leaves is `None`.
TEST(HoistBudget, HoistsWhenTheBranchLeavesDecideTheMatch) {
    auto c = load(branch("(((d.(poffset)) >? (0)) /\\ (true))", branch_to_none("true"),
                         branch_to_none(wide_condition(200))),
                  "v_1", "wide_branch");
    ASSERT_TRUE(c.spec);
    ASSERT_GT(c.src_leaves, kDefaultBudget) << "the scrutinee is small, so the case does not "
                                               "show that its size is not charged";
    ASSERT_LE(c.arm_leaves, kDefaultBudget) << "the arms are over budget, so a refusal would "
                                               "be the budget doing its job";
    EXPECT_TRUE(hoisted(c)) << "the match is still outermost: " << std::string(*c.spec);
}

/// The same shape, small enough that no quantity is near the budget.
TEST(HoistBudget, HoistsASmallMatchOverABranchWhoseLeavesDecideIt) {
    auto c = load(branch("(((d.(poffset)) >? (0)) /\\ (true))", branch_to_none("true"),
                         branch_to_none("(((d.(poffset)) >? (8)) /\\ (true))")),
                  "v_1", "small_branch");
    ASSERT_TRUE(c.spec);
    ASSERT_LT(c.total_leaves, kDefaultBudget);
    EXPECT_TRUE(hoisted(c)) << "the match is still outermost: " << std::string(*c.spec);
}

/// Every leaf is a call, so no copy of the match can be decided wherever
/// distribution puts it, and the rewrite would only copy the arms.
TEST(HoistBudget, RefusesWhenNoBranchLeafDecidesTheMatch) {
    auto c = load(branch("(((d.(poffset)) >? (0)) /\\ (true))", branch_opaque("true"),
                         branch_opaque("(((d.(poffset)) >? (8)) /\\ (true))")),
                  "v_1", "undecidable_branch");
    ASSERT_TRUE(c.spec);
    ASSERT_LT(c.total_leaves, kDefaultBudget) << "the case is over budget, so a refusal would "
                                                 "be the budget rather than the leaves";
    EXPECT_FALSE(hoisted(c)) << "distributed a match no leaf decides: " << std::string(*c.spec);
}

/// A leaf decides the match, but the arms are over the budget, and a hoist
/// copies them at every leaf whether or not the copy is discharged.
TEST(HoistBudget, RefusesWhenTheArmsExceedTheBudget) {
    auto c = load(branch("(((d.(poffset)) >? (0)) /\\ (true))", branch_to_none("true"),
                         branch_to_none("(((d.(poffset)) >? (8)) /\\ (true))")),
                  wide_value(450), "wide_arms");
    ASSERT_TRUE(c.spec);
    ASSERT_GT(c.arm_leaves, kDefaultBudget) << "the arms are under budget, so the case does "
                                               "not exercise the cost test";
    EXPECT_FALSE(hoisted(c)) << "copied arms of " << c.arm_leaves << " leaves against a budget "
                             << "of " << kDefaultBudget;
}
