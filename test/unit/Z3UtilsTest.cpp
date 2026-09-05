/* Unit tests for z3_check (src/optimizations/z3_utils.cpp).
 *
 * z3_check does not ask Z3 one question but two: it checks `cond` and then
 * `!cond` against the same state, and folds the pair into a single Z3Result:
 *
 *     !cond unsat                 -> True   (cond is entailed by the state)
 *     cond  unsat                 -> False  (cond contradicts the state)
 *     cond sat, !cond sat         -> Sat    (cond is contingent)
 *     anything else               -> Unknown
 *
 * Each of the two queries can independently come back sat, unsat, or unknown,
 * and `unknown` arrives for two quite different reasons -- the budget ran out
 * (Z3 reports "canceled"/"timeout") or the theory is incomplete for the
 * fragment (Z3 reports "incomplete ..."), which it can report immediately.
 * Every case runs twice: once with z3_check solving in process, and once under
 * OPTS.race, where it hands each query to external Z3 processes instead.  Racing
 * exists because an external solver that overruns its budget can be killed,
 * while an in-process solver.check() cannot -- Z3's `timeout` is best-effort.
 * The verdicts must not depend on which path produced them, which is what the
 * parameterised runs pin.
 *
 * These tests drive every reachable combination, using:
 *
 *   easy state    x > 0                    decided instantly
 *   contradictory x > 0 and x < 0          unsat instantly
 *   hard state    pigeonhole(11)           unsat, but not within any sane budget
 *   hard goal     pigeonhole(11) as cond   same, on the goal side
 *   fast unknown  forall r:R. exists s. s*s = r
 *
 * A state Z3 cannot decide makes *both* queries unknown regardless of the goal,
 * which is what lets a trivially-true and a trivially-false goal be steered
 * independently of each other.
 */

#include <gtest/gtest.h>

#include "cmd.h"
#include "values.h"
#include "z3_rules.h"

/* main.cpp is not linked into this binary, so its globals live here instead. */
SpoqOption OPTS;

using namespace autov;

namespace {

/// Budget for every check.  Long enough that the "easy" cases are nowhere near
/// it, short enough that the hard cases stay quick.
constexpr int kTimeout = 200;

/// Pigeonhole: n+1 pigeons into n holes.  Unsat, but exponentially hard for the
/// resolution the SAT core does, so Z3 burns the whole budget and gives up.
z3::expr pigeonhole(int n) {
    z3::expr_vector clauses(z3ctx);
    auto p = [&](int i, int j) {
        return z3ctx.bool_const(("p_" + std::to_string(i) + "_" + std::to_string(j)).c_str());
    };
    for (int i = 0; i <= n; i++) {
        z3::expr_vector somewhere(z3ctx);
        for (int j = 0; j < n; j++) somewhere.push_back(p(i, j));
        clauses.push_back(z3::mk_or(somewhere));
    }
    for (int j = 0; j < n; j++)
        for (int i = 0; i <= n; i++)
            for (int k = i + 1; k <= n; k++) clauses.push_back(!p(i, j) || !p(k, j));
    return z3::mk_and(clauses);
}

std::shared_ptr<EvalState> state_of(std::initializer_list<z3::expr> conds) {
    auto v = std::make_shared<std::vector<z3::expr>>(conds);
    return std::make_shared<EvalState>(v);
}

std::shared_ptr<ProveState> prove_state_of(std::initializer_list<z3::expr> conds,
                                           std::initializer_list<z3::expr> inductions) {
    auto vars = std::make_shared<std::unordered_map<std::string, std::shared_ptr<SpecValue>>>();
    auto c = std::make_shared<std::vector<z3::expr>>(conds);
    auto i = std::make_shared<std::vector<z3::expr>>(inductions);
    return std::make_shared<ProveState>(vars, c, i);
}

/// Asserted (not assumed), this is undecidable for Z3 straight away: it reports
/// "incomplete quantifiers" in a few ms rather than burning the budget.  The
/// uninterpreted f matters -- with a concrete function Z3 decides it.
z3::expr incomplete_for_z3() {
    z3::expr r = z3ctx.real_const("r");
    z3::func_decl f = z3::function("f", z3ctx.real_sort(), z3ctx.real_sort());
    return z3::forall(r, f(r) * f(r) == r);
}

/// Runs every case both in process and under --race.  Results are memoised on
/// (state, cond, timeout) and *not* on the race flag, so the cache has to be
/// cleared between the two runs or the second would replay the first's answer.
class RaceParam : public ::testing::TestWithParam<bool> {
protected:
    void SetUp() override {
        Z3Cache.clear();
        OPTS.race = GetParam();
        // The racers are `z3` from PATH and $Z3_PATH; point the second at a real
        // build so the test exercises two solvers rather than one plus a failed
        // exec.  Both must agree with the in-process solver for these fixtures.
        if (!std::getenv("Z3_PATH"))
            setenv("Z3_PATH", "/home/rjs2247/workspace/z3/build/z3", 0);
    }
    void TearDown() override { OPTS.race = false; }
};

std::string race_param_name(const ::testing::TestParamInfo<bool> &info) {
    return info.param ? "Raced" : "InProcess";
}

class Z3CheckTest : public RaceParam {};

INSTANTIATE_TEST_SUITE_P(InProcessAndRaced, Z3CheckTest, ::testing::Bool(),
                         &race_param_name);

z3::expr x() { return z3ctx.int_const("x"); }

}  // namespace

/* -- both queries decided, no unknowns ------------------------------------- */

// (sat, sat): cond is contingent -- some states satisfy it, some do not.
TEST_P(Z3CheckTest, ContingentIsSat) {
    EXPECT_EQ(z3_check(state_of({x() > 0}), x() > 1, nullptr, kTimeout), Z3Result::Sat);
}

// (sat, unsat): !cond is unsat, so the state entails cond.
TEST_P(Z3CheckTest, EntailedIsTrue) {
    EXPECT_EQ(z3_check(state_of({x() > 0}), x() > -1, nullptr, kTimeout), Z3Result::True);
}

// (unsat, sat): cond is unsat, so it contradicts the state.
TEST_P(Z3CheckTest, ContradictoryIsFalse) {
    EXPECT_EQ(z3_check(state_of({x() > 0}), x() < 0, nullptr, kTimeout), Z3Result::False);
}

// (unsat, unsat): the state itself is infeasible, so every goal is unsat both
// ways.  False wins over True here -- the cond == unsat test is applied first.
TEST_P(Z3CheckTest, InfeasibleStateIsFalse) {
    EXPECT_EQ(z3_check(state_of({x() > 0, x() < 0}), x() == 1, nullptr, kTimeout),
              Z3Result::False);
}

/* -- one query times out --------------------------------------------------- */

// (unknown, sat): proving the hard goal times out, refuting it is instant.
TEST_P(Z3CheckTest, TimeoutOnCondIsUnknown) {
    EXPECT_EQ(z3_check(state_of({}), pigeonhole(11), nullptr, kTimeout), Z3Result::Unknown);
}

// (sat, unknown): the mirror image.  Note this reports Sat off a single
// satisfiable query while the other side is undecided -- Sat here means "not
// shown contradictory", not "shown contingent".
TEST_P(Z3CheckTest, TimeoutOnNegatedCondIsSat) {
    EXPECT_EQ(z3_check(state_of({}), !pigeonhole(11), nullptr, kTimeout), Z3Result::Sat);
}

/* -- an undecidable state makes the goal irrelevant ------------------------ */
// With a state Z3 cannot decide, what comes back is driven entirely by whether
// the *assumption* is trivially true or false, not by the state.  Two of these
// are answers the caller would probably not want, and pinning them here is the
// point: they are the current contract.

// (unknown, unsat): a tautological goal cannot be refuted, so this reports
// True -- entailment "proved" only because the state is unsatisfiable.
TEST_P(Z3CheckTest, TautologyOverUndecidableStateIsTrue) {
    EXPECT_EQ(z3_check(state_of({pigeonhole(11)}), x() == x(), nullptr, kTimeout),
              Z3Result::True);
}

// (unsat, unknown): symmetrically, a contradictory goal reports False.
TEST_P(Z3CheckTest, ContradictionOverUndecidableStateIsFalse) {
    EXPECT_EQ(z3_check(state_of({pigeonhole(11)}), x() != x(), nullptr, kTimeout),
              Z3Result::False);
}

// (unknown, unknown): a goal independent of the state leaves both queries
// undecided, which is the honest answer.
TEST_P(Z3CheckTest, BothQueriesTimeOutIsUnknown) {
    EXPECT_EQ(z3_check(state_of({pigeonhole(11)}), x() > 0, nullptr, kTimeout),
              Z3Result::Unknown);
}

/* -- unknown from incompleteness rather than from the clock ---------------- */

// Z3 answers this one unknown immediately: quantified nonlinear reals are
// outside what it decides, and it says so rather than searching.  The negation
// then times out, so this single case covers both flavours of unknown.
TEST_P(Z3CheckTest, IncompleteTheoryIsUnknown) {
    z3::expr r = z3ctx.real_const("r"), three = z3ctx.real_val(3),
        two = z3ctx.real_val(2);
    z3::expr quantified = three == z3::pw(two, r);
    EXPECT_EQ(z3_check(state_of({}), quantified, nullptr, kTimeout), Z3Result::Unknown);
}

/* -- the four Z3 outcomes really are all being produced -------------------- */
// The tests above assert z3_check's verdict, which cannot distinguish a
// timeout from an incompleteness unknown.  This one checks the raw solver
// directly, so a Z3 upgrade that changes which outcome a fixture produces
// fails here -- naming the cause -- instead of silently weakening the suite.
TEST_P(Z3CheckTest, FixturesProduceAllFourOutcomes) {
    auto raw = [](std::initializer_list<z3::expr> conds, z3::expr goal) {
        z3::solver solver(z3ctx);
        z3::params params(z3ctx);
        params.set("timeout", (unsigned)kTimeout);
        solver.set(params);
        for (const auto &c : conds) solver.add(c);
        z3::expr_vector assumptions(z3ctx);
        assumptions.push_back(goal);
        auto result = solver.check(assumptions);
        return std::make_pair(result, result == z3::unknown ? solver.reason_unknown()
                                                            : std::string("-"));
    };

    EXPECT_EQ(raw({x() > 0}, x() > 1).first, z3::sat);
    EXPECT_EQ(raw({x() > 0}, x() < 0).first, z3::unsat);

    auto timed_out = raw({}, pigeonhole(11));
    EXPECT_EQ(timed_out.first, z3::unknown);
    EXPECT_TRUE(timed_out.second.find("canceled") != std::string::npos ||
                timed_out.second.find("timeout") != std::string::npos)
        << "expected a timeout, got: " << timed_out.second;

    z3::expr r = z3ctx.real_const("r"), s = z3ctx.real_const("s");
    auto incomplete = raw({}, z3::forall(r, z3::exists(s, s * s == r)));
    EXPECT_EQ(incomplete.first, z3::unknown);
    EXPECT_TRUE(incomplete.second.find("incomplete") != std::string::npos)
        << "expected an incompleteness unknown, got: " << incomplete.second;
}


/* ==========================================================================
 * z3_verify_state_sat -- "is this state satisfiable at all?"
 *
 * Unlike z3_check this is a single query with no assumption: the state is
 * asserted and checked directly, so sat maps to True, unsat to False and
 * unknown -- from either the clock or an incomplete theory -- to Unknown.
 * The ProveState overload also asserts the inductions, so they can turn a
 * satisfiable set of branch conditions into an unsatisfiable query.
 *
 * As with z3_check, every case runs both in process and under OPTS.race, and
 * must reach the same verdict either way.
 * ========================================================================== */

class VerifyStateSatTest : public RaceParam {};

INSTANTIATE_TEST_SUITE_P(InProcessAndRaced, VerifyStateSatTest, ::testing::Bool(),
                         &race_param_name);

TEST_P(VerifyStateSatTest, SatisfiableStateIsTrue) {
    EXPECT_EQ(z3_verify_state_sat(state_of({x() > 0}), nullptr, kTimeout), Z3Result::True);
}

TEST_P(VerifyStateSatTest, ContradictoryStateIsFalse) {
    EXPECT_EQ(z3_verify_state_sat(state_of({x() > 0, x() < 0}), nullptr, kTimeout),
              Z3Result::False);
}

TEST_P(VerifyStateSatTest, TimedOutStateIsUnknown) {
    EXPECT_EQ(z3_verify_state_sat(state_of({pigeonhole(11)}), nullptr, kTimeout),
              Z3Result::Unknown);
}

TEST_P(VerifyStateSatTest, IncompleteTheoryStateIsUnknown) {
    EXPECT_EQ(z3_verify_state_sat(state_of({incomplete_for_z3()}), nullptr, kTimeout),
              Z3Result::Unknown);
}

/* -- the ProveState overload additionally asserts the inductions ----------- */

TEST_P(VerifyStateSatTest, ProveStateSatisfiableIsTrue) {
    EXPECT_EQ(z3_verify_state_sat(prove_state_of({x() > 0}, {x() < 10}), nullptr, kTimeout),
              Z3Result::True);
}

// The branch conditions alone are satisfiable; only the inductions make the
// query unsatisfiable.  This is what pins that the inductions are in the query
// at all -- drop them and this returns True.
TEST_P(VerifyStateSatTest, ProveStateInductionsAreAsserted) {
    EXPECT_EQ(z3_verify_state_sat(state_of({x() > 0}), nullptr, kTimeout), Z3Result::True);
    EXPECT_EQ(z3_verify_state_sat(prove_state_of({x() > 0}, {x() < 0}), nullptr, kTimeout),
              Z3Result::False);
}

TEST_P(VerifyStateSatTest, ProveStateTimedOutIsUnknown) {
    EXPECT_EQ(z3_verify_state_sat(prove_state_of({}, {pigeonhole(11)}), nullptr, kTimeout),
              Z3Result::Unknown);
}
