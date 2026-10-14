/* rule_reuse_lookups: a heap load looks its block up twice, in one heap state,
 * the second lookup inside the first one's `Some` arm, destructures the block
 * twice, and asserts its size bounds each time.  The rule reuses the first
 * lookup, destructuring and rely where the second means the same: the same term
 * with the same bindings, the first binder still visible.  Each case below
 * checks that a repetition is removed, or that one which only looks the same
 * is kept.
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

/// A configuration with a heap, `mk_spec : RData -> option (Ptr * RData)` and
/// `use_spec : int32 -> RData -> option RData`.
constexpr const char *kMainV = SPOQ_STACK_FRAME_DIR "/join_scope_global_name.main.v";

std::string read_file(const std::string &path) {
    std::ifstream in(path);
    EXPECT_TRUE(in) << "cannot open " << path;
    std::stringstream ss;
    ss << in.rdbuf();
    return ss.str();
}

/// [body] as `reuse_case (c: int32) (d: int32) (st: RData)`, after one run of
/// rule_reuse_lookups.
std::string reuse(const std::string &body) {
    auto const tmp = std::string("/tmp/reuse_lookups_fixture_") + std::to_string(::getpid()) + ".v";
    {
        std::ofstream out(tmp);
        out << read_file(kMainV)
            << "\n\nDefinition reuse_case (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=\n" << body
            << ".\n";
    }
    Project proj;
    parser::parse(&proj, tmp);
    auto def = proj.defs.find("reuse_case");
    EXPECT_NE(def, proj.defs.end()) << "the case did not parse";
    if (def == proj.defs.end()) return "";
    auto spec = std::move(def->second->body());
    bool changed = false;
    std::tie(spec, changed) = proj.rules.rule_reuse_lookups(std::move(spec));
    return std::string(*spec);
}

/// [body] parsed as `reuse_case`, in a project kept alive by [proj].
std::unique_ptr<SpecNode> parse_case(Project &proj, const std::string &body) {
    auto const tmp = std::string("/tmp/reuse_lookups_parse_") + std::to_string(::getpid()) + ".v";
    {
        std::ofstream out(tmp);
        out << read_file(kMainV)
            << "\n\nDefinition reuse_case (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=\n" << body
            << ".\n";
    }
    parser::parse(&proj, tmp);
    auto def = proj.defs.find("reuse_case");
    EXPECT_NE(def, proj.defs.end()) << "the case did not parse";
    return def == proj.defs.end() ? nullptr : std::move(def->second->body());
}

/// [body] after rule_reuse_lookups and then rule_eliminate_let, which inlines
/// the lets the reuse introduces: what each name stands for is then explicit.
std::string reuse_then_inline(const std::string &body) {
    Project proj;
    auto spec = parse_case(proj, body);
    if (!spec) return "";
    bool changed = false;
    std::tie(spec, changed) = proj.rules.rule_reuse_lookups(std::move(spec));
    std::tie(spec, changed) = proj.rules.rule_eliminate_let(std::move(spec), true);
    return std::string(*spec);
}

size_t count(const std::string &hay, const std::string &needle) {
    size_t n = 0;
    for (size_t i = hay.find(needle); i != std::string::npos; i = hay.find(needle, i + 1)) n++;
    return n;
}

/// `match (S.heap.blocks @ K) with None => None | Some B => REST end`.
std::string lookup(const std::string &state, const std::string &key, const std::string &binder,
                   const std::string &rest) {
    return "  match ((((" + state + ".(heap)).(blocks)) @ " + key + ")) with\n"
           "  | None => None\n"
           "  | (Some " + binder + ") =>\n" + rest + "\n  end";
}

constexpr const char *kDone = "  (Some ((mkPtr \"g\" 0), st))";

}  // namespace

/// The second lookup of block 7 in st, inside the first's Some arm, reuses it.
TEST(ReuseLookups, NestedLookupOfTheSameBlock) {
    auto const out = reuse(lookup("st", "7", "b1", lookup("st", "7", "b2", kDone)));
    EXPECT_EQ(count(out, "@ 7"), 1u) << out;
}

/// Control: the second lookup is in another heap state.
TEST(ReuseLookups, LookupInAnotherState) {
    auto const out =
        reuse(lookup("st", "7", "b1", "  when st2 == ((use_spec 1 st));\n" + lookup("st2", "7", "b2", kDone)));
    EXPECT_EQ(count(out, "@ 7"), 2u) << out;
}

/// Control: the key names q, rebound between the lookups; the same text names
/// another block.
TEST(ReuseLookups, KeyRebound) {
    auto const out = reuse("  when q, st0 == ((mk_spec st));\n" +
                           lookup("st", "(q.(poffset))", "b1",
                                  "  when q, st1 == ((mk_spec st));\n" + lookup("st", "(q.(poffset))", "b2", kDone)));
    EXPECT_EQ(count(out, "@ (q.(poffset))"), 2u) << out;
}

/// Control: the first binder is shadowed before the second lookup, so it does
/// not name the block there.
TEST(ReuseLookups, FirstBinderShadowed) {
    auto const out = reuse(lookup(
        "st", "7", "b1", "  when b1 == ((((st.(heap)).(blocks)) @ 8));\n" + lookup("st", "7", "b2", kDone)));
    EXPECT_EQ(count(out, "@ 7"), 2u) << out;
}

/// A second destructuring of the same block reuses the first's names.
TEST(ReuseLookups, RepeatedDestructuring) {
    auto const out = reuse(lookup("st", "7", "b1",
                                  "  let (bm1, sz1) := b1 in\n"
                                  "  let (bm2, sz2) := b1 in\n"
                                  "  rely ((sz2 > 0));\n" +
                                      std::string(kDone)));
    EXPECT_EQ(count(out, ":= b1"), 1u) << out;
}

/// A rely of a proposition that already holds on the path is dropped.
TEST(ReuseLookups, RepeatedRely) {
    auto const out = reuse("  rely ((c > 0));\n  rely ((c > 0));\n" + std::string(kDone));
    EXPECT_EQ(count(out, "rely"), 1u) << out;
}

/// Control: the rely names q, rebound between the two.
TEST(ReuseLookups, RelyAboutARebinding) {
    auto const out = reuse("  when q, st0 == ((mk_spec st));\n  rely (((q.(poffset)) > 0));\n"
                           "  when q, st1 == ((mk_spec st));\n  rely (((q.(poffset)) > 0));\n" +
                           std::string(kDone));
    EXPECT_EQ(count(out, "rely"), 2u) << out;
}

/// Control: the first rely is in a sibling arm.
TEST(ReuseLookups, RelyInASiblingArm) {
    auto const out2 = reuse("  if (d =? 0) then (rely ((c > 0)); " + std::string(kDone) + ") else (rely ((c > 0)); " +
                            std::string(kDone) + ")");
    EXPECT_EQ(count(out2, "rely"), 2u) << out2;
}

/// Control: in the else arm of `if (c > 0)` the proposition fails, so a rely
/// of it there is kept.
TEST(ReuseLookups, RelyOfAFailingCondition) {
    auto const out = reuse("  if (c > 0) then (" + std::string(kDone) + ") else (rely ((c > 0)); " +
                           std::string(kDone) + ")");
    EXPECT_EQ(count(out, "rely"), 1u) << out;
}

/// Control: sz1 is rebound between the destructurings, so the first's names
/// no longer name the block's parts.
TEST(ReuseLookups, DestructuringNamesRebound) {
    auto const out = reuse(lookup("st", "7", "b1",
                                  "  let (bm1, sz1) := b1 in\n"
                                  "  let sz1 := 3 in\n"
                                  "  let (bm2, sz2) := b1 in\n"
                                  "  rely ((sz2 > sz1));\n" +
                                      std::string(kDone)));
    EXPECT_EQ(count(out, ":= b1"), 2u) << out;
}

/* Bindings, not just counts. */

/// The inner destructuring swaps the names: its p is the outer q.  Either the
/// inner destructuring stays, or once the lets are inlined the rely reads the
/// outer q.
TEST(ReuseLookupsBindings, SwappedDestructuringNames) {
    auto const out = reuse_then_inline(lookup("st", "7", "b1",
                                              "  let (p, q) := b1 in\n"
                                              "  let (q, p) := b1 in\n"
                                              "  rely ((p > 0));\n" +
                                                  std::string(kDone)));
    bool const kept = count(out, ":= b1") == 2 && count(out, "rely ((p > (0)))") == 1;
    bool const reused = count(out, ":= b1") == 1 && count(out, "rely ((q > (0)))") == 1;
    EXPECT_TRUE(kept || reused) << out;
}

/// Overlapping names: the inner c is the outer b.  Either the inner
/// destructuring stays, or the rely reads the outer b and a.
TEST(ReuseLookupsBindings, OverlappingDestructuringNames) {
    auto const out = reuse_then_inline(lookup("st", "7", "b1",
                                              "  let (a, b) := b1 in\n"
                                              "  let (b, c) := b1 in\n"
                                              "  rely ((c > a));\n" +
                                                  std::string(kDone)));
    bool const kept = count(out, ":= b1") == 2 && count(out, "rely ((c > (a)))") == 1;
    bool const reused = count(out, ":= b1") == 1 && count(out, "rely ((b > (a)))") == 1;
    EXPECT_TRUE(kept || reused) << out;
}

/// `_` binds nothing: an arm `Some _` gives no name to reuse.
TEST(ReuseLookupsBindings, WildcardSomeArmIsNotABinder) {
    auto const out = reuse(lookup("st", "7", "_", lookup("st", "7", "b2", "  rely ((b2 = b2));\n" + std::string(kDone))));
    EXPECT_EQ(out.find(":= _"), std::string::npos) << out;
    EXPECT_EQ(count(out, "@ 7"), 2u) << out;
}

/// `_` in a destructuring binds nothing: its part gives no name to reuse.
TEST(ReuseLookupsBindings, WildcardTuplePartIsNotABinder) {
    auto const out = reuse(lookup("st", "7", "b1",
                                  "  let (_, s1) := b1 in\n"
                                  "  let (m2, s2) := b1 in\n"
                                  "  rely ((m2 = m2));\n" +
                                      std::string(kDone)));
    EXPECT_EQ(out.find(":= _"), std::string::npos) << out;
}

/// Control: the rely names q only under a quantifier, and q is rebound
/// between the two; they are different propositions.
TEST(ReuseLookupsBindings, QuantifiedRelyAboutARebinding) {
    auto const out = reuse("  when q, st0 == ((mk_spec st));\n  rely (forall (i: Z), ((q.(poffset)) > i));\n"
                           "  when q, st1 == ((mk_spec st));\n  rely (forall (i: Z), ((q.(poffset)) > i));\n" +
                           std::string(kDone));
    EXPECT_EQ(count(out, "rely"), 2u) << out;
}

/// The let built in place of a reused lookup keeps the lookup's alignment.
TEST(ReuseLookupsBindings, ReusedLookupKeepsAlignment) {
    Project proj;
    auto spec = parse_case(proj, lookup("st", "7", "b1", lookup("st", "7", "b2", kDone)));
    ASSERT_TRUE(spec);
    auto outer = dynamic_cast<Match *>(spec.get());
    ASSERT_TRUE(outer);
    SpecNode *inner = nullptr;
    for (auto &pm : *outer->match_list)
        if (dynamic_cast<Match *>(pm->body.get())) inner = pm->body.get();
    ASSERT_TRUE(inner);
    inner->align_idx = 42;
    bool changed = false;
    std::tie(spec, changed) = proj.rules.rule_reuse_lookups(std::move(spec));
    ASSERT_TRUE(changed);
    outer = dynamic_cast<Match *>(spec.get());
    ASSERT_TRUE(outer);
    int found = -1;
    for (auto &pm : *outer->match_list)
        if (auto let = dynamic_cast<Match *>(pm->body.get())) found = let->align_idx;
    EXPECT_EQ(found, 42) << std::string(*spec);
}

/// The lets built in place of a reused destructuring keep its alignment.
TEST(ReuseLookupsBindings, ReusedDestructuringKeepsAlignment) {
    Project proj;
    auto spec = parse_case(proj, lookup("st", "7", "b1",
                                        "  let (bm1, sz1) := b1 in\n"
                                        "  let (bm2, sz2) := b1 in\n"
                                        "  rely ((sz2 > 0));\n" +
                                            std::string(kDone)));
    ASSERT_TRUE(spec);
    // outer lookup -> Some arm -> first destructuring -> second destructuring.
    auto const some_arm_body = [](SpecNode *n) -> std::unique_ptr<SpecNode> * {
        auto m = dynamic_cast<Match *>(n);
        if (!m) return nullptr;
        for (auto &pm : *m->match_list)
            if (dynamic_cast<Match *>(pm->body.get())) return &pm->body;
        return nullptr;
    };
    auto first = some_arm_body(spec.get());
    ASSERT_TRUE(first);
    auto second = &(*dynamic_cast<Match *>(first->get())->match_list)[0]->body;
    ASSERT_TRUE(dynamic_cast<Match *>(second->get()));
    (*second)->align_idx = 7;
    bool changed = false;
    std::tie(spec, changed) = proj.rules.rule_reuse_lookups(std::move(spec));
    ASSERT_TRUE(changed);
    first = some_arm_body(spec.get());
    ASSERT_TRUE(first);
    auto const replaced = (*dynamic_cast<Match *>(first->get())->match_list)[0]->body.get();
    EXPECT_EQ(replaced->align_idx, 7) << std::string(*spec);
}

/// `(_, _)` binds nothing: neither destructuring gives names to reuse, and
/// the rule leaves both in place.
TEST(ReuseLookupsBindings, AllWildcardDestructuring) {
    auto const out = reuse(lookup("st", "7", "b1",
                                  "  let (_, _) := b1 in\n"
                                  "  let (_, _) := b1 in\n" +
                                      std::string(kDone)));
    EXPECT_EQ(count(out, ":= b1"), 2u) << out;
}

/// The frames a `(_, _)` destructuring records do not hide the bindings around
/// it: a nested lookup under it still reuses the outer one.
TEST(ReuseLookupsBindings, WildcardDestructuringKeepsOuterBindings) {
    auto const out = reuse(lookup("st", "7", "b1", "  let (_, _) := b1 in\n" + lookup("st", "7", "b2", kDone)));
    EXPECT_EQ(count(out, "@ 7"), 1u) << out;
}
