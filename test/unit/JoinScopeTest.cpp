/* rule_forward_join_slots must not move a value out of the scope it means.
 *
 * At `when S == E; body` the rule replaces a read `(S.(stack)) @ "slot"` in the
 * body with the value every Some result of E leaves in the slot.  A value is a
 * term, and names in it can refer to different binders at the result and at
 * the read: a binder inside E, a binder in the body, or the state name the
 * when itself binds.  Each case below gives the rule such a value and checks
 * that the read it must not replace is still there.
 *
 * In a full run eliminate_ambiguity renames most shadowing binders away before
 * the rule runs, so these cases call the rule directly on parsed specs.  The
 * end-to-end cases are test/stack_frame/join_scope_*.
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

/// A configuration with stack slots, `mk_spec : RData -> option (Ptr * RData)`,
/// `use_spec : int32 -> RData -> option RData` and `Parameter gq : Ptr`.
constexpr const char *kMainV = SPOQ_STACK_FRAME_DIR "/join_scope_global_name.main.v";

std::string read_file(const std::string &path) {
    std::ifstream in(path);
    EXPECT_TRUE(in) << "cannot open " << path;
    std::stringstream ss;
    ss << in.rdbuf();
    return ss.str();
}

/// [body] as the definition `join_case (c: int32) (d: int32) (st: RData)`, after one run
/// of rule_forward_join_slots.
std::string forward(const std::string &body, const std::string &prelude = "") {
    auto const tmp = std::string("/tmp/join_scope_fixture_") + std::to_string(::getpid()) + ".v";
    {
        std::ofstream out(tmp);
        out << read_file(kMainV) << "\n\n" << prelude << "\n\nDefinition join_case (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=\n"
            << body << ".\n";
    }
    Project proj;
    parser::parse(&proj, tmp);
    auto def = proj.defs.find("join_case");
    EXPECT_NE(def, proj.defs.end()) << "the case did not parse";
    if (def == proj.defs.end()) return "";
    auto spec = std::move(def->second->body());
    bool changed = false;
    std::tie(spec, changed) = proj.rules.rule_forward_join_slots(std::move(spec));
    return std::string(*spec);
}

bool contains(const std::string &s, const std::string &sub) { return s.find(sub) != std::string::npos; }

/// `match ((S.(stack)) @ slot) with ... PtrVal p => Some (p, R)`.
std::string read_ret(const std::string &s, const std::string &slot, const std::string &r) {
    return "  match (((" + s + ".(stack)) @ \"" + slot + "\")) with\n"
           "  | (Some sv) =>\n"
           "    match sv with\n"
           "    | (ZMapVal z) => None\n"
           "    | (ZVal z) => None\n"
           "    | (PtrVal p) => (Some (p, " + r + "))\n"
           "    end\n"
           "  | None => None\n"
           "  end";
}

/// A join whose two results both write `Some (PtrVal V)` to stack_type_2 over
/// [base]; the else result also writes stack_type_1.
std::string join_writing(const std::string &v, const std::string &base) {
    return "  when st_b == (\n"
           "    if (c =? 0)\n"
           "    then (Some (" + base + ".[stack] :< ((" + base + ".(stack)) # \"stack_type_2\" == (Some (PtrVal " + v + ")))))\n"
           "    else (Some (" + base + ".[stack] :< (((" + base + ".(stack)) # \"stack_type_2\" == (Some (PtrVal " + v + "))) # \"stack_type_1\" == (Some (ZVal 4))))));\n";
}

}  // namespace

/// Control: a value closed over the when's scope replaces the read.
TEST(JoinScope, ClosedValueIsForwarded) {
    auto const out = forward(join_writing("(mkPtr \"g\" 0)", "st") + read_ret("st_b", "stack_type_2", "st_b"));
    EXPECT_FALSE(contains(out, "@ \"stack_type_2\")")) << out;
}

/// Control: a result based on a state bound before the join, outside E, takes
/// the value that state's results agree on.
TEST(JoinScope, OuterBindingIsResolved) {
    auto const out = forward(
        "  when st_a == (\n"
        "    if (c =? 1)\n"
        "    then (Some (st.[stack] :< ((st.(stack)) # \"stack_type_2\" == (Some (PtrVal (mkPtr \"g\" 0))))))\n"
        "    else (Some (st.[stack] :< (((st.(stack)) # \"stack_type_2\" == (Some (PtrVal (mkPtr \"g\" 0)))) # \"stack_type_1\" == (Some (ZVal 5))))));\n"
        "  when st_b == (\n"
        "    if (c =? 0)\n"
        "    then (when st3 == ((use_spec 2 st_a)); (Some (st3.[stack] :< ((st3.(stack)) # \"stack_type_2\" == (Some (PtrVal (mkPtr \"g\" 0)))))))\n"
        "    else (Some (st_a.[stack] :< ((st_a.(stack)) # \"stack_type_1\" == (Some (ZVal 4))))));\n" +
        read_ret("st_b", "stack_type_2", "st_b"));
    EXPECT_FALSE(contains(out, "((st_b.(stack)) @ \"stack_type_2\")")) << out;
}

/// Each result writes PtrVal q for a q its arm binds, and an outer q is in
/// scope at the join.  Equal terms, different binders: not forwarded.
TEST(JoinScope, ArmLocalBindersWithTheOuterName) {
    auto const out = forward(
        "  when q, st0 == ((mk_spec st));\n"
        "  when st_b == (\n"
        "    if (c =? 0)\n"
        "    then (when q, st1 == ((mk_spec st0)); (Some (st1.[stack] :< ((st1.(stack)) # \"stack_type_2\" == (Some (PtrVal q))))))\n"
        "    else (when q, st1 == ((mk_spec st0)); (Some (st1.[stack] :< ((st1.(stack)) # \"stack_type_2\" == (Some (PtrVal q)))))));\n" +
        read_ret("st_b", "stack_type_2", "st_b"));
    EXPECT_TRUE(contains(out, "((st_b.(stack)) @ \"stack_type_2\")")) << out;
}

/// As above with `let`: each arm let-binds v, and an outer v is in scope.
TEST(JoinScope, ArmLocalLetsWithTheOuterName) {
    auto const out = forward(
        "  when v, st0 == ((mk_spec st));\n"
        "  when st_b == (\n"
        "    if (c =? 0)\n"
        "    then (when w, st1 == ((mk_spec st0)); let v := w in (Some (st1.[stack] :< ((st1.(stack)) # \"stack_type_2\" == (Some (PtrVal v))))))\n"
        "    else (when w, st1 == ((mk_spec st0)); let v := w in (Some (st1.[stack] :< ((st1.(stack)) # \"stack_type_2\" == (Some (PtrVal v)))))));\n" +
        read_ret("st_b", "stack_type_2", "st_b"));
    EXPECT_TRUE(contains(out, "((st_b.(stack)) @ \"stack_type_2\")")) << out;
}

/// The arm-local binder has the name of the global Parameter gq.  free_vars
/// does not report a global's name, so a check built on it would read the
/// value PtrVal gq as closed and forward it, naming the global.
TEST(JoinScope, ArmLocalBinderWithAGlobalName) {
    auto const out = forward(
        "  when st_b == (\n"
        "    if (c =? 0)\n"
        "    then (when gq, st1 == ((mk_spec st)); (Some (st1.[stack] :< ((st1.(stack)) # \"stack_type_2\" == (Some (PtrVal gq))))))\n"
        "    else (when gq, st1 == ((mk_spec st)); (Some (st1.[stack] :< ((st1.(stack)) # \"stack_type_2\" == (Some (PtrVal gq)))))));\n" +
        read_ret("st_b", "stack_type_2", "st_b"));
    EXPECT_TRUE(contains(out, "((st_b.(stack)) @ \"stack_type_2\")")) << out;
}

/// The value PtrVal q names the outer q, and the body rebinds q between two
/// reads.  The read before the rebinding is replaced; the one after is not.
TEST(JoinScope, BodyRebindsANameOfTheValue) {
    auto const out = forward(
        "  when q, st0 == ((mk_spec st));\n" + join_writing("q", "st0") +
        "  when sv0 == (((st_b.(stack)) @ \"stack_type_2\"));\n"
        "  when q, st9 == ((mk_spec st_b));\n" +
        read_ret("st_b", "stack_type_2", "st9"));
    EXPECT_TRUE(contains(out, "when sv0 == ((Some (PtrVal q)))")) << out;
    EXPECT_TRUE(contains(out, "((st_b.(stack)) @ \"stack_type_2\")")) << out;
}

/// An adjacent when rebinds st_b to an opaque call's result.  The read before
/// it is replaced; the read of the second st_b is not.
TEST(JoinScope, AdjacentWhenRebindsTheState) {
    auto const out = forward(join_writing("(mkPtr \"g\" 0)", "st") +
                             "  when sv0 == (((st_b.(stack)) @ \"stack_type_2\"));\n"
                             "  when st_b == ((use_spec 1 st_b));\n" +
                             read_ret("st_b", "stack_type_2", "st_b"));
    EXPECT_TRUE(contains(out, "when sv0 == ((Some (PtrVal (mkPtr \"g\" 0))))")) << out;
    EXPECT_TRUE(contains(out, "((st_b.(stack)) @ \"stack_type_2\")")) << out;
}

/// Both results are based on a state named s, but the then arm rebinds s.  The
/// reads `(s.(stack)) @ slot` they reduce to are equal terms of different
/// states: not forwarded.
TEST(JoinScope, ArmRebindsTheBaseStateName) {
    auto const out = forward(
        "  when s == ((use_spec 0 st));\n"
        "  when st_b == (\n"
        "    if (c =? 0)\n"
        "    then (when s == ((use_spec 1 s)); (Some (s.[stack] :< ((s.(stack)) # \"stack_type_1\" == (Some (ZVal 3))))))\n"
        "    else (Some (s.[stack] :< ((s.(stack)) # \"stack_type_1\" == (Some (ZVal 4))))));\n" +
        read_ret("st_b", "stack_type_2", "st_b"));
    EXPECT_TRUE(contains(out, "((st_b.(stack)) @ \"stack_type_2\")")) << out;
}

/// The results are based on an outer state that the when rebinds: st_b.  The
/// value for stack_type_2 is the outer st_b's stack_type_1, written back by
/// both results; in the body st_b is the new state, whose stack_type_1 the
/// results overwrite, so the value would change meaning there.
TEST(JoinScope, ValueNamesTheStateTheWhenBinds) {
    auto const out = forward(
        "  when st_b == ((use_spec 0 st));\n"
        "  when st_b == (\n"
        "    if (c =? 0)\n"
        "    then (Some (st_b.[stack] :< (((st_b.(stack)) # \"stack_type_1\" == (Some (ZVal 3))) # \"stack_type_2\" == ((st_b.(stack)) @ \"stack_type_1\"))))\n"
        "    else (Some (st_b.[stack] :< (((st_b.(stack)) # \"stack_type_1\" == (Some (ZVal 4))) # \"stack_type_2\" == ((st_b.(stack)) @ \"stack_type_1\")))));\n" +
        read_ret("st_b", "stack_type_2", "st_b"));
    EXPECT_TRUE(contains(out, "when sv == (((st_b.(stack)) @ \"stack_type_2\"))")) << out;
}

/* Facts on a symbolic key.  A store through a pointer q writes `# (q.(pbase))`,
 * which may be any slot; a rely or an If condition on q.(pbase) on the path
 * can decide that it is or is not the slot read.  st1 holds &g in
 * stack_type_2, and each case's join stores through q in one arm. */
namespace {

std::string with_st1(const std::string &rest) {
    return "  when q, st0 == ((mk_spec st));\n"
           "  let st1 := (st0.[stack] :< ((st0.(stack)) # \"stack_type_2\" == (Some (PtrVal (mkPtr \"g\" 0))))) in\n" +
           rest + read_ret("st_b", "stack_type_2", "st_b");
}

/// `Some (st1 with q.(pbase) := V)`.
std::string store_q(const std::string &v = "(Some (ZVal 1))") {
    return "(Some (st1.[stack] :< ((st1.(stack)) # (q.(pbase)) == " + v + ")))";
}

std::string join_of(const std::string &then_leaf, const std::string &else_leaf) {
    return "  when st_b == (if (c =? 0) then " + then_leaf + " else " + else_leaf + ");\n";
}

bool read_kept(const std::string &out) { return contains(out, "((st_b.(stack)) @ \"stack_type_2\")"); }

}  // namespace

/// Control: with no fact on q.(pbase), the store may be to the slot.
TEST(JoinScopeFacts, NoFactKeepsTheRead) {
    auto const out = forward(with_st1(join_of(store_q(), "(Some st1)")));
    EXPECT_TRUE(read_kept(out)) << out;
}

/// A rely before the join excludes the slot.
TEST(JoinScopeFacts, RelyExcludesTheSlot) {
    auto const out = forward(with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                                      join_of(store_q(), "(Some st1)")));
    EXPECT_FALSE(read_kept(out)) << out;
}

/// An If confining q.(pbase) to other slots, around the store.
TEST(JoinScopeFacts, IfConfinesTheKeyToOtherSlots) {
    auto const out = forward(with_st1(join_of(
        "(if (((q.(pbase)) =s \"stack_type_1\") \\/ ((q.(pbase)) =s \"stack_type_3\")) then " + store_q() +
            " else (Some st1))",
        "(Some st1)")));
    EXPECT_FALSE(read_kept(out)) << out;
}

/// `if (q.(pbase) =s slot)`: the then store writes the slot, with &g; the else
/// store writes another slot.  Every result leaves &g.
TEST(JoinScopeFacts, KeyDecidedBothWays) {
    auto const out = forward(with_st1(join_of(
        "(if ((q.(pbase)) =s \"stack_type_2\") then " + store_q("(Some (PtrVal (mkPtr \"g\" 0)))") + " else " +
            store_q() + ")",
        "(Some st1)")));
    EXPECT_FALSE(read_kept(out)) << out;
}

/// As KeyDecidedBothWays with the then store writing another value: the
/// results disagree.
TEST(JoinScopeFacts, KeyIsTheSlotWithAnotherValue) {
    auto const out = forward(with_st1(join_of(
        "(if ((q.(pbase)) =s \"stack_type_2\") then " + store_q("(Some (PtrVal (mkPtr \"h\" 0)))") + " else " +
            store_q() + ")",
        "(Some st1)")));
    EXPECT_TRUE(read_kept(out)) << out;
}

/// The rely is about the q bound before it; the store is through a q bound
/// after.  The same term names another pointer, so the fact does not apply.
TEST(JoinScopeFacts, FactAboutARebindingKey) {
    auto const out = forward(
        "  when q, st0 == ((mk_spec st));\n"
        "  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n"
        "  when q, st9 == ((mk_spec st0));\n"
        "  let st1 := (st9.[stack] :< ((st9.(stack)) # \"stack_type_2\" == (Some (PtrVal (mkPtr \"g\" 0))))) in\n" +
        join_of(store_q(), "(Some st1)") + read_ret("st_b", "stack_type_2", "st_b"));
    EXPECT_TRUE(read_kept(out)) << out;
}

/// The fact holds in the then arm of an inner If; the store is in its else arm.
TEST(JoinScopeFacts, FactInASiblingArm) {
    auto const out = forward(with_st1(join_of(
        "(if (d =? 0) then (rely (~ ((q.(pbase)) =s \"stack_type_2\")); (Some st1)) else " + store_q() + ")",
        "(Some st1)")));
    EXPECT_TRUE(read_kept(out)) << out;
}

/// `~ (a /\ b)` decides nothing about either equality.
TEST(JoinScopeFacts, NegatedConjunctionDecidesNothing) {
    auto const out = forward(with_st1(
        "  rely (~ (((q.(pbase)) =s \"stack_type_2\") /\\ ((q.(pbase)) =s \"stack_type_1\")));\n" +
        join_of(store_q(), "(Some st1)")));
    EXPECT_TRUE(read_kept(out)) << out;
}

/// In the else arm of `if (q.(pbase) =s "stack_type_1")` the key is only known
/// not to be stack_type_1, so a store there of another value may be to the slot.
TEST(JoinScopeFacts, ElseOfAnotherSlotDecidesNothing) {
    auto const out = forward(with_st1(join_of(
        "(if ((q.(pbase)) =s \"stack_type_1\") then (Some st1) else " + store_q("(Some (PtrVal (mkPtr \"h\" 0)))") +
            ")",
        "(Some st1)")));
    EXPECT_TRUE(read_kept(out)) << out;
}

/// The store binds the new stack map with a `when` and installs it after.
/// The slot's value is followed into the bound stack map's results.
TEST(JoinScopeFacts, StoreIntoABoundStackMap) {
    auto const out = forward(with_st1(
        "  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
        join_of("(when new_stack == (Some ((st1.(stack)) # (q.(pbase)) == (Some (ZVal 1)))); "
                "(Some (st1.[stack] :< new_stack)))",
                "(Some st1)")));
    EXPECT_FALSE(read_kept(out)) << out;
}

/// Control: as above without the rely.
TEST(JoinScopeFacts, StoreIntoABoundStackMapWithoutAFact) {
    auto const out = forward(with_st1(
        join_of("(when new_stack == (Some ((st1.(stack)) # (q.(pbase)) == (Some (ZVal 1)))); "
                "(Some (st1.[stack] :< new_stack)))",
                "(Some st1)")));
    EXPECT_TRUE(read_kept(out)) << out;
}

/* Pre-unfolding: a store still folded as a call to the memory model's
 * store_RData is read through its definition.  Its stack write is to the
 * store address's base, which the rely excludes, so the slot keeps &g. */

/// A folded store through q, under the rely, leaves the slot alone.
TEST(JoinScopePreUnfold, FoldedStoreUnderTheRely) {
    auto const out = forward(with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                                      join_of("(store_RData 4 q 1 st1)", "(Some st1)")));
    EXPECT_FALSE(read_kept(out)) << out;
}

/// The address is an offset from q: ptr_offset_inbounds keeps q's base or is
/// null, which the store rejects.  Read from the definitions.
TEST(JoinScopePreUnfold, FoldedStoreAtAnOffset) {
    auto const out = forward(with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                                      join_of("(store_RData 1 (ptr_offset_inbounds q 4 st1) 0 st1)", "(Some st1)")));
    EXPECT_FALSE(read_kept(out)) << out;
}

/// Control: without the rely the folded store may be to the slot.
TEST(JoinScopePreUnfold, FoldedStoreWithoutTheRely) {
    auto const out = forward(with_st1(join_of("(store_RData 4 q 1 st1)", "(Some st1)")));
    EXPECT_TRUE(read_kept(out)) << out;
}

/// Failsafe: what a folded call does is read from its definition, not
/// assumed.  A store whose definition writes the slot is read as writing it.
TEST(JoinScopePreUnfold, DefinitionThatWritesTheSlot) {
    auto const prelude =
        "Definition store_slot_too (sz: intSizeT) (p: Ptr) (v: int64) (st: RData) : option RData :=\n"
        "  match (store_RData sz p v st) with\n"
        "  | Some st2 => Some (st2.[stack] :< ((st2.(stack)) # \"stack_type_2\" == (Some (ZVal v))))\n"
        "  | None => None\n"
        "  end.";
    auto const out = forward(with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                                      join_of("(store_slot_too 4 q 1 st1)", "(Some st1)")),
                             prelude);
    EXPECT_TRUE(read_kept(out)) << out;
}

/// Failsafe: a pointer function whose definition changes the base.  The
/// store is through a pointer whose base is the slot's, whatever q is.
TEST(JoinScopePreUnfold, PointerDefinitionThatChangesTheBase) {
    auto const prelude =
        "Definition to_slot (p: Ptr) : Ptr := (mkPtr \"stack_type_2\" (p.(poffset))).";
    auto const out = forward(with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                                      join_of("(store_RData_ptr 8 (to_slot q) (mkPtr \"h\" 0) st1)", "(Some st1)")),
                             prelude);
    EXPECT_TRUE(read_kept(out)) << out;
}

/// A definition hinted NoUnfold is not read, so its call decides nothing.
TEST(JoinScopePreUnfold, NoUnfoldIsNotRead) {
    auto const prelude =
        "Definition keep_store (sz: intSizeT) (p: Ptr) (v: int64) (st: RData) : option RData :=\n"
        "  store_RData sz p v st.\n"
        "Hint NoUnfold keep_store.";
    auto const out = forward(with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                                      join_of("(keep_store 4 q 1 st1)", "(Some st1)")),
                             prelude);
    EXPECT_TRUE(read_kept(out)) << out;
}

/// The state passed to the folded store is named new_heap, a name
/// store_RData's body binds.  The copy's binders are renamed apart from the
/// arguments, so the argument is not captured.
TEST(JoinScopePreUnfold, ArgumentNamedLikeABinderOfTheBody) {
    auto const out = forward(
        "  when q, st0 == ((mk_spec st));\n"
        "  let new_heap := (st0.[stack] :< ((st0.(stack)) # \"stack_type_2\" == (Some (PtrVal (mkPtr \"g\" 0))))) in\n"
        "  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
        join_of("(store_RData 4 q 1 new_heap)", "(Some new_heap)") + read_ret("st_b", "stack_type_2", "st_b"));
    EXPECT_FALSE(read_kept(out)) << out;
}

/// The address is q or the slot itself, by a branch of its definition: one
/// alternative is excluded by the rely, the other is the slot.  Undecided.
TEST(JoinScopePreUnfold, AlternativesThatDisagree) {
    auto const prelude =
        "Definition maybe_slot (k: int32) (p: Ptr) : Ptr := if (k =? 7) then p else (mkPtr \"stack_type_2\" 0).";
    auto const out = forward(with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                                      join_of("(store_RData 8 (maybe_slot d q) 1 st1)", "(Some st1)")),
                             prelude);
    EXPECT_TRUE(read_kept(out)) << out;
}

/* Facts about an opaque state.  A call's post-state from an oracle has no
 * structure; what the path assumes of its stack -- the frame a spec
 * synthesized from memory attributes states as a rely -- gives the slot's
 * value. */
namespace {

constexpr const char *kOpaquePost = "Parameter opaque_post : (Ptr-> (RData-> (RData))).";

/// `rely ((opaque_post q S).(stack) = M)`.
std::string stack_fact(const std::string &s, const std::string &m) {
    return "  rely (((opaque_post q " + s + ").(stack)) = " + m + ");\n";
}

}  // namespace

/// The fact states the post-state's stack as st1's with a write through q,
/// which the rely on q excludes from the slot.
TEST(JoinScopeOpaque, StackFactAboutThePostState) {
    auto const out = forward(with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                                      stack_fact("st1", "((st1.(stack)) # (q.(pbase)) == (Some (ZVal 1)))") +
                                      join_of("(Some (opaque_post q st1))", "(Some st1)")),
                             kOpaquePost);
    EXPECT_FALSE(read_kept(out)) << out;
}

/// Control: no fact about the post-state's stack.
TEST(JoinScopeOpaque, NoStackFact) {
    auto const out = forward(with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                                      join_of("(Some (opaque_post q st1))", "(Some st1)")),
                             kOpaquePost);
    EXPECT_TRUE(read_kept(out)) << out;
}

/// Control: the fact is about another state term, opaque_post q st0.
TEST(JoinScopeOpaque, StackFactAboutAnotherTerm) {
    auto const out = forward(with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                                      stack_fact("st0", "((st1.(stack)) # (q.(pbase)) == (Some (ZVal 1)))") +
                                      join_of("(Some (opaque_post q st1))", "(Some st1)")),
                             kOpaquePost);
    EXPECT_TRUE(read_kept(out)) << out;
}

/// Control: the fact holds only in the then arm of an inner If; the result is
/// in the else arm.
TEST(JoinScopeOpaque, StackFactInASiblingArm) {
    auto const out = forward(
        with_st1("  rely (~ ((q.(pbase)) =s \"stack_type_2\"));\n" +
                 join_of("(if (d =? 0) then (" + stack_fact("st1", "(st1.(stack))") + " (Some st1)) else (Some (opaque_post q st1)))",
                         "(Some st1)")),
        kOpaquePost);
    EXPECT_TRUE(read_kept(out)) << out;
}

/// Control: the fact is about opaque_post q st1 for the q bound before it; the
/// result is for a q bound after, the same term naming another state.
TEST(JoinScopeOpaque, StackFactAboutARebindingTerm) {
    auto const out = forward(with_st1(stack_fact("st1", "(st1.(stack))") +
                                      "  when q, st9 == ((mk_spec st1));\n" +
                                      join_of("(Some (opaque_post q st1))", "(Some st1)")),
                             kOpaquePost);
    EXPECT_TRUE(read_kept(out)) << out;
}

/// Control: in the else arm of `if (post.(stack) = st1.(stack))` the equality
/// fails, so it says nothing of the post-state's slot.
TEST(JoinScopeOpaque, StackEqualityThatFails) {
    auto const out = forward(with_st1(join_of(
                                 "(if (((opaque_post q st1).(stack)) = (st1.(stack))) then (Some st1) else (Some (opaque_post q st1)))",
                                 "(Some st1)")),
                             kOpaquePost);
    EXPECT_TRUE(read_kept(out)) << out;
}

namespace {

/// Replaces each Symbol QUANT under [n] with a fresh copy of [with].
void replace_quant(std::unique_ptr<SpecNode> &n, const SpecNode &with) {
    if (!n) return;
    if (auto sym = dynamic_cast<Symbol *>(n.get()); sym && sym->text == "QUANT") {
        n = with.deep_copy();
        return;
    }
    if (auto m = dynamic_cast<Match *>(n.get())) {
        replace_quant(m->src, with);
        for (auto &pm : *m->match_list) replace_quant(pm->body, with);
    } else if (auto i = dynamic_cast<If *>(n.get())) {
        replace_quant(i->cond, with);
        replace_quant(i->then_body, with);
        replace_quant(i->else_body, with);
    } else if (auto r = dynamic_cast<RelyAnno *>(n.get())) {
        replace_quant(r->prop, with);
        replace_quant(r->body, with);
    } else if (auto e = dynamic_cast<Expr *>(n.get())) {
        if (e->elems)
            for (auto &x : *e->elems) replace_quant(x, with);
    }
}

}  // namespace

/// Each arm's value names its own q only under a quantifier, and an outer q is
/// in scope at the join.  The quantified names are names of the value, so it
/// is not forwarded.  The parser takes a quantifier only as a proposition, so
/// the condition is put in place of the symbol QUANT after parsing.
TEST(JoinScope, ArmLocalNameUnderAQuantifier) {
    std::string const v = "(Some (PtrVal (if QUANT then (mkPtr \"g\" 0) else (mkPtr \"h\" 0))))";
    auto const body =
        "  when q, st0 == ((mk_spec st));\n"
        "  when st_b == (\n"
        "    if (c =? 0)\n"
        "    then (when q, st1 == ((mk_spec st0)); (Some (st1.[stack] :< ((st1.(stack)) # \"stack_type_2\" == " + v + "))))\n"
        "    else (when q, st1 == ((mk_spec st0)); (Some (st1.[stack] :< ((st1.(stack)) # \"stack_type_2\" == " + v + ")))));\n" +
        read_ret("st_b", "stack_type_2", "st_b");
    auto const tmp = std::string("/tmp/join_scope_quant_") + std::to_string(::getpid()) + ".v";
    {
        std::ofstream out(tmp);
        out << read_file(kMainV) << "\n\nParameter QUANT : bool.\n"
            << "Definition join_case (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=\n" << body << ".\n";
    }
    Project proj;
    parser::parse(&proj, tmp);
    auto def = proj.defs.find("join_case");
    ASSERT_NE(def, proj.defs.end());
    auto spec = std::move(def->second->body());
    auto vars = std::make_unique<std::vector<std::shared_ptr<Arg>>>();
    vars->push_back(std::make_shared<Arg>("i", Int::INT));
    auto quant = std::make_unique<Forall>(std::move(vars),
                                          std::unique_ptr<SpecNode>(parser::parseExpr(&proj, "((q.(poffset)) > i)")));
    replace_quant(spec, *quant);
    bool changed = false;
    std::tie(spec, changed) = proj.rules.rule_forward_join_slots(std::move(spec));
    auto const out = std::string(*spec);
    EXPECT_TRUE(contains(out, "forall")) << out;
    EXPECT_TRUE(contains(out, "((st_b.(stack)) @ \"stack_type_2\")")) << out;
}
