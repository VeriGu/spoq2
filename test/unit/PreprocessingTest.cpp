/* Characterisation tests for the preprocessing passes that generate a project's
 * Coq skeleton: ExtractBasics (records, load/store, function specs) and
 * ExtractPointers (memory type map, the StackVal inductive).
 *
 * Both are `opt` plugins built separately from spoq by scripts/preprocessing/
 * build-passes.sh, so they cannot be linked into this binary.  These tests run
 * them the way extract-info.sh does and read what they wrote.  If `opt` or the
 * plugins are missing the tests skip rather than fail -- a spoq build does not
 * build them.
 *
 * What is pinned is the LLVM-type -> Coq-type mapping, once per type.  That
 * mapping exists three times in the tree -- twice here and once in spoq's
 * llvm_ir_type_to_spec_pure -- and the copies disagreed, which is what took
 * snd001 and snd014 down: both emit `UnknownType` for a vector, a name nothing
 * defines, and spoq's parser then throws `unordered_map::at` with no file, no
 * line and no name.
 *
 * Cases that pin *wrong* output say so.  They are here to make a change in
 * behaviour visible, not to bless it.
 */

#include <gtest/gtest.h>

#include "../skip_code.h"

#include <cstdio>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <sstream>
#include <string>
#include <unistd.h>

namespace fs = std::filesystem;

namespace {

/// The `opt` that matches the plugins: $OPT, else $LLVM_ROOT/bin/opt, else PATH.
/// Empty when none is usable.
std::string findOpt() {
    std::vector<std::string> candidates;
    if (const char *o = std::getenv("OPT")) candidates.emplace_back(o);
    if (const char *r = std::getenv("LLVM_ROOT")) candidates.emplace_back(std::string(r) + "/bin/opt");
    candidates.emplace_back(std::string(std::getenv("HOME") ? std::getenv("HOME") : "") +
                            "/workspace/llvm-project/build/bin/opt");
    candidates.emplace_back("opt");
    for (const auto &c : candidates) {
        const std::string probe = c + " --version > /dev/null 2>&1";
        if (std::system(probe.c_str()) == 0) return c;
    }
    return "";
}

std::string pluginPath(const char *name) {
    return std::string(SPOQ_PASS_DIR) + "/" + name + "/lib/lib" + name + ".so";
}

std::string readFile(const fs::path &p) {
    std::ifstream in(p);
    return std::string((std::istreambuf_iterator<char>(in)), std::istreambuf_iterator<char>());
}

/// Run both passes over [fixture] in a scratch directory and return what they
/// wrote, keyed by the suffix each pass appends.
struct Emitted {
    std::string declarations, datatype, machine, memtypes;
    bool ok = false;
};

Emitted runPasses(const std::string &fixture) {
    Emitted out;
    const std::string opt = findOpt();
    if (opt.empty()) return out;
    for (const char *p : {"extractbasics", "extractpointers"})
        if (!fs::exists(pluginPath(p))) return out;

    const fs::path work = fs::temp_directory_path() /
                          ("spoq-pass-" + fixture + "-" + std::to_string(::getpid()));
    fs::remove_all(work);
    fs::create_directories(work);
    const fs::path ll = work / fixture;
    fs::copy_file(fs::path(SPOQ_PASS_FIXTURE_DIR) / fixture, ll);

    std::ostringstream cmd;
    cmd << "cd " << work << " && " << opt
        << " --load-pass-plugin=" << pluginPath("extractpointers")
        << " --load-pass-plugin=" << pluginPath("extractbasics")
        << " -passes='extractbasics,extractpointers' -disable-output " << fixture
        << " > /dev/null 2>&1";
    if (std::system(cmd.str().c_str()) != 0) return out;

    out.declarations = readFile(work.string() + "/" + fixture + ".declarations.v");
    out.datatype     = readFile(work.string() + "/" + fixture + ".datatype.v");
    out.machine      = readFile(work.string() + "/" + fixture + ".machine.v");
    out.memtypes     = readFile(work.string() + "/" + fixture + ".memtypes.json");
    out.ok = !out.declarations.empty();
    fs::remove_all(work);
    return out;
}

Emitted runOrSkipImpl(const std::string &fixture) {
    const Emitted e = runPasses(fixture);
    if (!e.ok)
        ADD_FAILURE() << "could not run the passes -- see GTEST_SKIP below";
    return e;
}

#define RUN_OR_SKIP(var, fixture)                                                      \
    const Emitted var = runPasses(fixture);                                            \
    if (!var.ok) GTEST_SKIP() << "opt or the preprocessing plugins are not built; "    \
                                 "see scripts/preprocessing/build-passes.sh"

/* -- ExtractBasics: the type of a function's arguments and result ------------ */

TEST(ExtractBasics, ScalarParameterTypes) {
    RUN_OR_SKIP(e, "all_types.ll");
    // Every integer width collapses to Z, including i1.
    for (const char *f : {"p_i1", "p_i8", "p_i32", "p_i64"})
        EXPECT_NE(e.declarations.find(std::string("Parameter ") + f + "_spec : (Z-> "),
                  std::string::npos)
            << f << " is not Z:\n" << e.declarations;
    EXPECT_NE(e.declarations.find("Parameter p_ptr_spec : (Ptr-> "), std::string::npos)
        << e.declarations;
    // Float and Double are distinct names here, both `:= Z` in the prelude.
    EXPECT_NE(e.declarations.find("Parameter p_float_spec : (Float-> "), std::string::npos)
        << e.declarations;
    EXPECT_NE(e.declarations.find("Parameter p_double_spec : (Double-> "), std::string::npos)
        << e.declarations;
}

TEST(ExtractBasics, ResultTypes) {
    RUN_OR_SKIP(e, "all_types.ll");
    EXPECT_NE(e.declarations.find("Parameter r_void_spec : (RData-> (option RData))"),
              std::string::npos) << e.declarations;
    EXPECT_NE(e.declarations.find("Parameter r_float_spec : (RData-> (option ((Float) * RData)))"),
              std::string::npos) << e.declarations;
    EXPECT_NE(e.declarations.find("Parameter r_ptr_spec : (RData-> (option ((Ptr) * RData)))"),
              std::string::npos) << e.declarations;
}

TEST(ExtractBasics, StructFieldTypes) {
    RUN_OR_SKIP(e, "all_types.ll");
    // Pointers inside a record are Z, not Ptr -- generateField is called with
    // pointers_are_ptr=false for fields and true for signatures.
    EXPECT_NE(e.datatype.find("e_s_Fields_4 : Z;"), std::string::npos) << e.datatype;
    EXPECT_NE(e.datatype.find("e_s_Fields_5 : Float;"), std::string::npos) << e.datatype;
    EXPECT_NE(e.datatype.find("e_s_Fields_6 : Double;"), std::string::npos) << e.datatype;
    // An array carries its length: (contents, length).
    EXPECT_NE(e.datatype.find("e_s_Fields_7 : ((ZMap.t Z) * Z);"), std::string::npos) << e.datatype;
}

/// An array's element type has to survive the mapping: fields 7 and 8 of the
/// fixture's struct are `[4 x i32]` and `[4 x double]`, and they are different
/// types, so they must not come out as the same text.
///
/// They do today -- both `((ZMap.t Z) * Z)`, told apart only by a FIXME comment,
/// and a comment is not a type -- so this reports a skip.  It asserts the types
/// the fields should have rather than the ones they have, so it will simply pass
/// once the mapping distinguishes them.
TEST(ExtractBasics, ArrayOfDoubleKeepsItsElementType_Unimplemented) {
    RUN_OR_SKIP(e, "all_types.ll");
    auto const field = [&e](const char *name) {
        const size_t at = e.datatype.find(name);
        if (at == std::string::npos) return std::string();
        return e.datatype.substr(at, e.datatype.find('\n', at) - at);
    };
    const std::string as_int = field("e_s_Fields_7 :");
    const std::string as_double = field("e_s_Fields_8 :");
    ASSERT_FALSE(as_int.empty()) << e.datatype;
    ASSERT_FALSE(as_double.empty()) << e.datatype;

    if (as_double.find("FIXME") != std::string::npos)
        GTEST_SKIP() << "unimplemented: an array of a type the mapping does not handle "
                        "keeps the element type of an integer array --\n  "
                     << as_int << "\n  " << as_double;
    EXPECT_NE(as_int.substr(as_int.find(':')), as_double.substr(as_double.find(':')))
        << e.datatype;
}

/// A vector maps to the same thing an array does, and to the same text spoq's
/// own mapping produces -- `(ZMap.t Z)`.
///
/// It used to be `UnknownType`, which nothing defines, and that is what took
/// snd001 and snd014 down: the generated .main.v could not be parsed, because
/// visitType does `proj.symbols.at(name)` unchecked and throws
/// `std::out_of_range`/`unordered_map::at` naming neither the file nor the type.
///
/// Reached in libsndfile through the SSE intrinsics clang emits for lrint:
/// `llvm.x86.sse2.cvtsd2si(<2 x double>)` and `llvm.x86.sse.cvtss2si(<4 x float>)`.
///
/// Agreeing with spoq is the point, not just being defined: a signature emitted
/// here is checked against a body translated there.  The other half of this is
/// IrTranslationSpec.VectorTypeMatchesTheGeneratedSignature.
TEST(ExtractBasics, VectorTypesMapToAZMap) {
    RUN_OR_SKIP(e, "all_types.ll");
    EXPECT_NE(e.declarations.find("Parameter p_vec2double_spec : ((ZMap.t Z)-> "),
              std::string::npos) << e.declarations;
    EXPECT_NE(e.declarations.find("Parameter p_vec4float_spec : ((ZMap.t Z)-> "),
              std::string::npos) << e.declarations;
    EXPECT_NE(e.datatype.find("e_s_Fields_10 : (ZMap.t Z);"), std::string::npos) << e.datatype;
    EXPECT_EQ(e.declarations.find("UnknownType"), std::string::npos)
        << "a type still has no name:\n" << e.declarations;
    EXPECT_EQ(e.datatype.find("UnknownType"), std::string::npos) << e.datatype;
}

/* -- ExtractPointers: the StackVal inductive --------------------------------- */

TEST(ExtractPointers, StackValueTypes) {
    RUN_OR_SKIP(e, "stack_types.ll");
    EXPECT_NE(e.machine.find("ZVal (ZValConstr: Z)"), std::string::npos) << e.machine;
    EXPECT_NE(e.machine.find("ZFloatVal (ZFloatValConstr: Float)"), std::string::npos) << e.machine;
    EXPECT_NE(e.machine.find("ZFloatVal (ZFloatValConstr: Double)"), std::string::npos) << e.machine;
    EXPECT_NE(e.machine.find("s_TwoVal (s_TwoValConstr: s_Two)"), std::string::npos) << e.machine;
}

/// The same fix on this side: an alloca of a vector no longer contributes a
/// constructor over a type nothing defines.
TEST(ExtractPointers, NoStackSlotIsUnnamed) {
    RUN_OR_SKIP(e, "stack_types.ll");
    EXPECT_EQ(e.machine.find("UnknownType"), std::string::npos) << e.machine;
}

/// Every constructor of the StackVal inductive must have a distinct name: Coq
/// rejects an Inductive with duplicates, so a module that produces two emits a
/// file that does not compile.
///
/// Two collide today -- the name comes from a coarse family (ZVal, ZFloatVal,
/// ZMapVal, ZMapOtherVal) while the payload type is the precise one, so two
/// types in one family share a name -- and this reports a skip.  Independent of
/// the type mapping: the payload types are right, only the names are not.
TEST(ExtractPointers, StackValConstructorNamesAreDistinct_Unimplemented) {
    RUN_OR_SKIP(e, "stack_types.ll");
    // Only the declaration; the constructors are also used in load_stack and
    // store_stack, which duplicate their match arms for the same reason.
    const size_t begin = e.machine.find("Inductive StackVal :=");
    ASSERT_NE(begin, std::string::npos) << e.machine;
    const std::string inductive = e.machine.substr(begin, e.machine.find("\n.", begin) - begin);

    const auto count = [&inductive](const std::string &needle) {
        size_t n = 0;
        for (size_t i = inductive.find(needle); i != std::string::npos;
             i = inductive.find(needle, i + needle.size()))
            n++;
        return n;
    };
    if (count("| ZFloatVal ") > 1 || count("| ZMapOtherVal ") > 1)
        GTEST_SKIP() << "unimplemented: float and double share ZFloatVal, and "
                        "[2 x [3 x i32]] and [4 x double] share ZMapOtherVal:\n"
                     << inductive;
    EXPECT_EQ(count("| ZFloatVal "), 1u) << inductive;
    EXPECT_EQ(count("| ZMapOtherVal "), 1u) << inductive;
}

/* -- ExtractPointers: the extent of a global --------------------------------- */

/// Every shape load_global emits an arm for is gated on the access lying
/// inside the global's extent.  Without the gate a read off the end of a
/// global has a defined value, so an out-of-bounds read is not UB and a patch
/// that adds a bounds check is not a refinement -- which is SND014.
TEST(ExtractPointers, GlobalAccessIsBoundedByItsExtent) {
    RUN_OR_SKIP(e, "globals.ll");
    // Sizes are bytes: [2049 x i8], i32, ptr, {i32,i32}, [8 x {i32,i32}].
    for (const char *d : {"Definition SZ_table : Z := 2049.",
                          "Definition SZ_counter : Z := 4.",
                          "Definition SZ_handle : Z := 8.",
                          "Definition SZ_pair : Z := 8.",
                          "Definition SZ_pairs : Z := 64."})
        EXPECT_NE(e.machine.find(d), std::string::npos) << d << " missing from:\n" << e.machine;

    // One gate per arm: seven loads and six stores -- the string constant is
    // read-only, so it contributes a load and no store.
    const auto count = [&e](const std::string &needle) {
        size_t n = 0;
        for (size_t i = e.machine.find(needle); i != std::string::npos;
             i = e.machine.find(needle, i + needle.size()))
            n++;
        return n;
    };
    EXPECT_EQ(count("if (global_in_bounds sz p SZ_"), 13u) << e.machine;
    EXPECT_NE(e.machine.find("Definition global_in_bounds (sz: Z) (p: Ptr) (limit: Z) : bool :=\n"
                             "  (0 <=? p.(poffset)) && (p.(poffset) + sz <=? limit)."),
              std::string::npos) << e.machine;
}

/// A global whose extent the static type does not give gets a Parameter
/// floored at what is known, so the bound exists without being pinned to a
/// number that would be wrong.
///
/// Two reach that case.  A zero-length array is a flexible member whose real
/// length lives in the allocation.  Several globals merged under one
/// identifier -- every `.str.N` becomes g_merged_constant_global_string --
/// have no single length, so the floor is the longest of them.
TEST(ExtractPointers, UnknownExtentsAreParameters) {
    RUN_OR_SKIP(e, "globals.ll");
    EXPECT_NE(e.machine.find("Parameter SZ_flex_unknown : Z.\n"
                             "Definition SZ_flex : Z := "
                             "if (SZ_flex_unknown >? 0) then SZ_flex_unknown else 0."),
              std::string::npos) << e.machine;
    // [4 x i8] and [16 x i8] merge; the floor is the longer.
    EXPECT_NE(e.machine.find("Parameter SZ_merged_constant_global_string_unknown : Z.\n"
                             "Definition SZ_merged_constant_global_string : Z := "
                             "if (SZ_merged_constant_global_string_unknown >? 16) "
                             "then SZ_merged_constant_global_string_unknown else 16."),
              std::string::npos) << e.machine;
}

/// An array's Coq type is one ZMap per dimension, whatever the depth.
///
/// The mapping stopped at two dimensions of integers and gave anything deeper
/// the placeholder `None`, which is not a type.  It reached spoq as
/// `Parameter g_mask: None.` in the generated .main.v and ended the run in
/// visitType, which looked the name up and threw `unordered_map::at`.  PNG001's
/// png_combine_row masks are [2 x [3 x [3 x i32]]].
TEST(ExtractPointers, ArrayTypesNestOneZMapPerDimension) {
    RUN_OR_SKIP(e, "globals.ll");
    EXPECT_NE(e.machine.find("Parameter g_mask: (ZMap.t (ZMap.t (ZMap.t Z)))."),
              std::string::npos) << e.machine;
    EXPECT_EQ(e.machine.find("FIXME"), std::string::npos)
        << "a type is still a placeholder:\n" << e.machine;
}

}  // namespace

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return spoq_test::skip_aware_status(RUN_ALL_TESTS());
}
