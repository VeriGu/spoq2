/* Unit tests for SpecRules::rule_move_match_out_when:
 *
 *     when x == (match s with p_i => e_i); body
 *       ->  match s with p_i => (when x == e_i; body)
 *
 * The rule builds one copy of the outer `when` per inner arm.  The copies must
 * not include the inner match itself, whose arms are moved into the result as
 * the loop goes: with three or more inner arms, a copy made after the first
 * move reads a moved-from arm.  libmodbus's modbus_reply reached this with a
 * StackVal match over several constructors and segfaulted in
 * PatternMatch::deep_copy_down.
 */

#include <gtest/gtest.h>

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

std::unique_ptr<SpecNode> parse(Project &p, const std::string &text) {
    auto node = std::unique_ptr<SpecNode>(parser::parseExpr(&p, text));
    EXPECT_TRUE(node) << "failed to parse: " << text;
    return node;
}

/// Whitespace-collapsed, so expectations can be written on one line.
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

/// `when x == (match s with <arms>); Some (x + 1)` with [n] integer arms.
std::string when_over_match(int n) {
    std::string arms;
    for (int i = 0; i + 1 < n; i++)
        arms += " | " + std::to_string(i) + " => (Some " + std::to_string(10 + i) + ")";
    arms += " | _ => None";
    return "when x == ((match s with" + arms + " end)); (Some (x + 1))";
}

size_t count(const std::string &hay, const std::string &needle) {
    size_t n = 0;
    for (size_t i = hay.find(needle); i != std::string::npos; i = hay.find(needle, i + 1)) n++;
    return n;
}

}  // namespace

// Two inner arms: the only copy of the outer `when` is taken before any arm
// is moved, so this shape always worked.
TEST(MatchOutWhen, TwoInnerArms) {
    Project proj;
    auto [spec, changed] = proj.rules.rule_move_match_out_when(parse(proj, when_over_match(2)), false);
    ASSERT_TRUE(changed);
    auto const out = flat(std::string(*spec));
    EXPECT_EQ(count(out, "when x =="), 2u) << out;
    EXPECT_EQ(out.find("match (s) with"), 0u) << out;
}

// Three and more inner arms: every arm gets its own `when`, and none reads a
// moved-from arm.  Before the fix this segfaulted at the second arm.
TEST(MatchOutWhen, ThreeOrMoreInnerArms) {
    for (int n : {3, 5}) {
        Project proj;
        auto [spec, changed] = proj.rules.rule_move_match_out_when(parse(proj, when_over_match(n)), false);
        ASSERT_TRUE(changed) << n;
        auto const out = flat(std::string(*spec));
        EXPECT_EQ(count(out, "when x =="), size_t(n)) << out;
        EXPECT_EQ(out.find("match (s) with"), 0u) << out;
        // Each inner arm's value reaches its own copy of the continuation.
        for (int i = 0; i + 1 < n; i++)
            EXPECT_NE(out.find("(Some " + std::to_string(10 + i) + ")"), std::string::npos) << out;
    }
}

/* SpecRules::rule_move_when_out_when, the associativity of `when`:
 *
 *     when x == (when y == a; b); c  ->  when y == a; when x == b; c
 *
 * Its guard tested the inner `when`'s Some arm for the None constructor, so it
 * never fired; a chain of `rely`s and `when`s inside a `when` then came apart
 * one step per transformation iteration. */

/// [text] parsed, with the outermost node typed `option Z`: parseExpr infers no
/// types, and the rule applies to an option-valued `when` only.
std::unique_ptr<SpecNode> parse_option(Project &p, const std::string &text) {
    auto node = parse(p, text);
    node->type = std::make_shared<Option>(Int::INT);
    return node;
}

TEST(MoveWhenOutWhen, FlattensANestedWhen) {
    Project proj;
    auto [spec, changed] = proj.rules.rule_move_when_out_when(
        parse_option(proj, "when x == ((when y == (s); (Some (y + 1)))); (Some (x + 2))"), false);
    ASSERT_TRUE(changed) << std::string(*spec);
    EXPECT_EQ(flat(std::string(*spec)), flat("when y == (s); when x == ((Some (y + (1)))); (Some (x + (2)))"))
        << std::string(*spec);
}

/// The continuation names a y bound outside; moving it under the inner `when`,
/// which binds y, would capture it.
TEST(MoveWhenOutWhen, KeepsANestedWhenThatWouldCapture) {
    Project proj;
    auto [spec, changed] = proj.rules.rule_move_when_out_when(
        parse_option(proj, "when x == ((when y == (s); (Some (y + 1)))); (Some (x + y))"), false);
    EXPECT_FALSE(changed) << std::string(*spec);
}

/* The case budget: rule_move_match_out_when copies the continuation once per
 * inner arm after the first, and declines when the copies would pass
 * SPOQ_CASE_BUDGET leaves (4096 by default). */

/// A balanced sum of [n] copies of x: the depth stays logarithmic, so the
/// parser's recursion does too.
std::string balanced_sum(int n) {
    if (n <= 1) return "x";
    return "(" + balanced_sum(n / 2) + " + " + balanced_sum(n - n / 2) + ")";
}

/// `when x == (match s with | 0 => Some 10 | _ => None); Some (x + ... + x)`
/// with [terms] leaves in the continuation.
std::string when_over_match_with(int terms) {
    return "when x == ((match s with | 0 => (Some 10) | _ => None end)); (Some " + balanced_sum(terms) + ")";
}

TEST(MatchOutWhenBudget, SmallContinuationIsMoved) {
    Project proj;
    auto [spec, changed] = proj.rules.rule_move_match_out_when(parse(proj, when_over_match_with(10)), false);
    EXPECT_TRUE(changed) << std::string(*spec);
}

TEST(MatchOutWhenBudget, ContinuationOverTheBudgetIsKept) {
    Project proj;
    auto [spec, changed] = proj.rules.rule_move_match_out_when(parse(proj, when_over_match_with(5000)), false);
    EXPECT_FALSE(changed);
}
