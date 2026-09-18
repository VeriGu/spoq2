/* Does rule_simple_by_z3 report a change it did not make?
 *
 * hidden_ub_unfold_not_triggered_fail spends ~222s re-transforming one spec
 * 300 times.  The spec stops changing at iteration 6 -- 295 of the 300
 * iterations receive the byte-identical term -- but the loop in
 * spec_transformer_v2 only checks for convergence under `if (!changed)`, and
 * rule_simple_by_z3 sets `changed` on 295 of them.
 *
 * entry_vuln_spec_fixpoint.spec is that term, lifted verbatim out of the run
 * (the per-iteration dump the SPOQ_LOG_FN hook writes).  Feeding it back in
 * isolates the question from everything upstream: given a term the rule cannot
 * improve, does it say so?
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
#include "z3_rules.h"

/* main.cpp is not linked into this binary, so its globals live here instead. */
SpoqOption OPTS;

using namespace autov;

/// rule_simple_by_z3 opens with `if (!force_simpl) return {spec, false}`, so
/// without this the rule is inert and every result below would be a false
/// negative.  spec_transformer_v2 sets it immediately before each call.
namespace autov { extern bool force_simpl; }

namespace {

std::string read_file(const std::string &path) {
    std::ifstream in(path);
    EXPECT_TRUE(in) << "cannot open " << path;
    std::stringstream ss;
    ss << in.rdbuf();
    return ss.str();
}

constexpr const char *kMainV = SPOQ_DEMAND_DIR "/hidden_ub_unfold_not_triggered_fail.main.v";

/// The state spec_transformer_v2 runs the rules against: every argument of the
/// definition declared as a symbolic value.  Without it z3_eval throws
/// "Unknown symbol" the moment the rule looks at the term.
std::shared_ptr<EvalState> state_for(Definition *def) {
    auto vars = std::make_shared<std::unordered_map<std::string, std::shared_ptr<SpecValue>>>();
    for (auto const &arg : *def->args) (*vars)[arg->name] = arg->type->declare(arg->name, 0);
    return std::make_shared<EvalState>(vars);
}

/// Parse [body] as the body of a definition, in the project the spec came from.
///
/// Not parseExpr: that parses an expression, and silently returns just the
/// condition when handed `if c then a else b`.  The spec is a definition body,
/// so it is appended to the project's own .v -- which supplies Ptr, RData, the
/// memory model and `spvn` -- and the whole file is parsed.
std::unique_ptr<Project> parse_as_definition(const std::string &body, const std::string &name) {
    auto const tmp = std::string("/tmp/") + name + "_fixture.v";
    {
        std::ofstream out(tmp);
        out << read_file(kMainV) << "\n\nDefinition " << name
            << " (d: Ptr) (st: RData) : (option (Z * RData)) :=\n"
            << body << ".\n";
    }
    auto proj = std::make_unique<Project>();
    parser::parse(proj.get(), tmp);
    return proj;
}

}  // namespace

/// Positive control.  A negative result from the fixed-point case only means
/// something if the rule is doing work in this harness at all -- a term whose
/// branch it can decide must come back changed.
TEST(Z3SimplifyFixpoint, ReportsAChangeWhenItSimplifies) {
    auto proj = parse_as_definition(std::getenv("CTRL") ? std::getenv("CTRL")
                                              : "if (1 >? (0))\nthen (Some (1, st))\nelse (Some (0, st))",
                            "control_spec");
    auto it = proj->defs.find("control_spec");
    ASSERT_NE(it, proj->defs.end()) << "the control definition did not parse";
    auto state = state_for(it->second.get());
    auto spec = std::move(it->second->body());

    const std::string before = std::string(*spec);
    autov::force_simpl = true;
    bool changed = false;
    std::tie(spec, changed) = proj->rules.rule_simple_by_z3(std::move(spec), std::move(state));
    const std::string after = std::string(*spec);
    GTEST_LOG_(INFO) << "before: " << before << "  after: " << after
                     << "  changed=" << (changed ? "true" : "false");
    EXPECT_TRUE(changed) << "the rule did not fire on a decidable branch, so this harness is "
                            "not exercising it and the fixed-point result below means nothing";
    EXPECT_NE(before, after);
}

TEST(Z3SimplifyFixpoint, ReportsNoChangeOnATermItCannotImprove) {
    auto const text = read_file(std::string(SPOQ_DEMAND_DIR) + "/entry_vuln_spec_fixpoint.spec");
    auto proj = parse_as_definition(text, "fixpoint_spec");
    auto it = proj->defs.find("fixpoint_spec");
    ASSERT_NE(it, proj->defs.end()) << "the fixed-point spec did not parse";
    auto state = state_for(it->second.get());
    auto spec = std::move(it->second->body());

    const std::string before = std::string(*spec);
    GTEST_LOG_(INFO) << "input " << text.size() << " bytes, parsed to " << before.size();

    autov::force_simpl = true;
    bool changed = false;
    std::tie(spec, changed) = proj->rules.rule_simple_by_z3(std::move(spec), std::move(state));
    const std::string after = std::string(*spec);
    GTEST_LOG_(INFO) << "changed=" << (changed ? "true" : "false") << "  term "
                     << (before == after ? "IDENTICAL" : "DIFFERENT") << " (" << before.size()
                     << " -> " << after.size() << " bytes)";

    if (before == after) {
        EXPECT_FALSE(changed)
            << "rule_simple_by_z3 returned an identical term but reported a change, which is "
               "what keeps spec_transformer_v2 iterating to max_iter on a converged spec";
    }
}

/// The smallest term captured from the run that exhibits the defect: a `when`
/// whose scrutinee is a ZMap lookup on a symbolic pointer.  Z3 cannot decide
/// either arm, so simple_match_by_z3 rebuilds the node unchanged -- and still
/// reports a change.  Six of these nested is what keeps entry_vuln_spec
/// iterating to max_iter.
TEST(Z3SimplifyFixpoint, UndecidableWhenReportsAChangeItDidNotMake) {
    auto const body =
        "when b_30 == ((((st.(heap)).(blocks)) @ (spvn (d.(pbase)))));\n"
        "rely ((((d.(poffset)) mod (16)) = (0)));\n"
        "if (\"result\" =s ((d.(pbase))))\n"
        "then (Some (((st.(globals)).(g_result)), st))\n"
        "else (\n"
        "  match ((((st.(heap)).(blocks)) @ (spvn (d.(pbase))))) with\n"
        "  | None => None\n"
        "  | (Some b_15) =>\n"
        "    let (bytemap_29, bk_sz_28) := b_15 in\n"
        "    (Some ((bytemap_29 @ (d.(poffset))), st))\n"
        "  end)";
    auto proj = parse_as_definition(body, "noop_spec");
    auto it = proj->defs.find("noop_spec");
    ASSERT_NE(it, proj->defs.end()) << "the case did not parse";
    auto state = state_for(it->second.get());
    auto spec = std::move(it->second->body());

    const std::string before = std::string(*spec);
    autov::force_simpl = true;
    bool changed = false;
    std::tie(spec, changed) = proj->rules.rule_simple_by_z3(std::move(spec), std::move(state));
    const std::string after = std::string(*spec);

    GTEST_LOG_(INFO) << "changed=" << (changed ? "true" : "false") << "  term "
                     << (before == after ? "IDENTICAL" : "DIFFERENT");
    EXPECT_FALSE(changed && before == after)
        << "reported a change without making one:\n" << before;
}

/// Iterating the rule has to reach a fixed point.  spec_transformer_v2 stops
/// only when nothing reports a change, so a rule that keeps reporting one --
/// whether or not it moves the term -- runs the transformer to max_iter.  This
/// bounds the same loop at unit-test scale.
TEST(Z3SimplifyFixpoint, IteratingReachesAFixedPoint) {
    auto const text = read_file(std::string(SPOQ_DEMAND_DIR) + "/entry_vuln_spec_fixpoint.spec");
    auto proj = parse_as_definition(text, "fixpoint_spec");
    auto it = proj->defs.find("fixpoint_spec");
    ASSERT_NE(it, proj->defs.end()) << "the fixed-point spec did not parse";
    auto *def = it->second.get();
    auto spec = std::move(def->body());

    autov::force_simpl = true;
    constexpr int kMaxRounds = 40;
    int round = 0;
    for (; round < kMaxRounds; round++) {
        auto const before = std::string(*spec);
        bool changed = false;
        std::tie(spec, changed) = proj->rules.rule_simple_by_z3(std::move(spec), state_for(def));
        ASSERT_TRUE(spec) << "round " << round << " emptied the spec";
        auto const after = std::string(*spec);
        GTEST_LOG_(INFO) << "round " << round << ": changed=" << (changed ? "true" : "false")
                         << "  " << before.size() << " -> " << after.size()
                         << (before == after ? "  (identical)" : "");
        if (!changed) break;
        EXPECT_NE(before, after) << "round " << round << " reported a change without making one";
    }
    EXPECT_LT(round, kMaxRounds) << "still reporting a change after " << kMaxRounds << " rounds";
}
