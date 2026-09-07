/* Unit tests for SpoqIRModule::llvm_ir_to_spoq_ir -- the LLVM-IR -> Spoq-IR
 * translation, exercised WITHOUT running control_flow_conversion_v2 first.
 *
 * Why skip the CFG pass:
 *   It is the slow and currently broken half of the front end (exponential
 *   block cloning -- see CfgConversionTest).  Running it first means every
 *   translation test inherits that cost and those failures, so a translation
 *   bug is invisible behind a CFG bug.  Skipping it makes these tests run in
 *   milliseconds and attributes any failure to the translator.
 *
 * How the skip works:
 *   llvm_ir_to_spoq_ir opens with
 *       if (!spoq_func.cfg_converted) return false;
 *   so the flag is set by hand here.  That is the whole bypass.
 *
 * WHAT THE BYPASS COSTS -- read before adding a case:
 *   The CFG pass is what populates SpoqLoopContext's `steps`/`jump` maps.
 *   Without it, SpoqLoopContext::step() returns true exactly once (the
 *   top-level pass, step_count == -1) and then stops, because `steps` is
 *   empty.  So translation walks the function once from the entry block with
 *   NO loop handling at all.
 *
 *   There is a second, sharper precondition, and it is asserted rather than
 *   documented in the translator:
 *       dfs_llvm_ir_to_spoq_inst_vec, SpoqIRTranslator.cpp:132
 *       "PHI node is not in the loop header or postheader"
 *   i.e. the input must be phi-free except at loop headers/postheaders.
 *   Removing join phis is exactly what control_flow_clone_and_split does -- it
 *   clones the diamond until the phi is gone -- which is also why that pass
 *   blows up exponentially.
 *
 *   So an in-scope case here is: no natural loops, and no phi at a join point.
 *   Straight-line code, branches whose arms return, and memory traffic all
 *   qualify.  The two boundary tests below pin what happens outside that, so
 *   the limits stay visible instead of becoming folklore.
 *
 * TWO STAGES ARE COVERED.  They fail very differently, so they are separate:
 *
 *   1. llvm_ir_to_spoq_ir   CFG walk -> flat spoq_inst_vec_t.
 *      Does NOT interpret instructions: dfs_llvm_ir_to_spoq_inst_vec packs
 *      every non-branch instruction as an opaque SpoqLLVMInst.  So this stage
 *      accepts anything the walk can reach, select included.
 *
 *   2. spoq_inst_to_spec    that vector -> SpecNode.
 *      This is where instructions are actually interpreted, via a dyn_cast
 *      chain.  An instruction with no arm in that chain falls through here,
 *      not in stage 1.
 *
 * Stage 2 needs a Project and a SpoqIRContext, which is why it is more setup
 * than stage 1.  make_minimal_project() below builds the smallest thing that
 * works: one Layer with an abs_data type, plus whatever StackMap entries the
 * fixture's allocas require (the alloca arm asserts on a missing entry).
 *
 * Doubles as an llvm-reduce oracle:
 *
 *     IrTranslationTest --translate <file.ll> <function>   (stage 1)
 *     IrTranslationTest --spec      <file.ll> <function>   (stages 1+2)
 *       exit 0  succeeded
 *       exit 2  returned false / produced no SpecNode
 *       exit 3  threw
 *       exit 4  could not parse / no such function
 *       exit 5  stage 1 produced no instructions
 */

#include <gtest/gtest.h>

#include <csignal>
#include <cstdlib>
#include <map>
#include <string>
#include <sys/wait.h>
#include <unistd.h>

#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"

#include "cmd.h"
#include "nodes.h"
#include "project.h"
#include "SpoqIR.h"
#include "SpoqIRModule.h"
#include "values.h"

/* main.cpp is not linked into this binary, so its globals live here instead. */
SpoqOption OPTS;

using namespace autov;

namespace {

/// Translation of a well-formed function is fast; anything slower than this is
/// a bug worth reporting rather than waiting on.
constexpr int kDeadlineSeconds = 60;

enum TranslateStatus {
    kTranslated = 0,
    kReturnedFalse = 2,
    kThrew = 3,
    kBadInput = 4,
    kNoInstructions = 5,
};

/// Translate [func_name] from [path], skipping control_flow_conversion_v2.
/// [out_count], when given, receives the number of top-level Spoq instructions.
TranslateStatus run_translation(const std::string &path, const std::string &func_name,
                                size_t *out_count = nullptr) {
    llvm::LLVMContext ctx;
    llvm::SMDiagnostic err;
    auto module = llvm::parseIRFile(path, err, ctx);
    if (!module) return kBadInput;

    auto *func = module->getFunction(func_name);
    if (!func || func->isDeclaration()) return kBadInput;

    SpoqFunction spoq_func;
    spoq_func.llvm_func = func;
    // The bypass: assert the precondition llvm_ir_to_spoq_ir checks, without
    // having run the pass that normally establishes it.
    spoq_func.cfg_converted = true;

    try {
        if (!SpoqIRModule::llvm_ir_to_spoq_ir(spoq_func)) return kReturnedFalse;
    } catch (const std::exception &e) {
        // Across a fork the exit code cannot carry the reason, so print it.
        llvm::errs() << "llvm_ir_to_spoq_ir threw: " << e.what() << "\n";
        return kThrew;
    }

    if (out_count) *out_count = spoq_func.spoq_insts.size();
    return spoq_func.spoq_insts.empty() ? kNoInstructions : kTranslated;
}

/// Smallest Project that spoq_inst_to_spec will accept.
///
/// It reads only a handful of things: one layer (for the abstract-state type
/// and the load/store operator names), cmds.StackMap (the alloca arm asserts if
/// a local has no entry), cmds.InitRely / cmds.PostEnsure (absent is fine), and
/// spoq_code.llvm_module (for printing unnamed values).  [stack_vars] maps a
/// mangled local name such as "v_slot" to the stack region it lives in.
std::unique_ptr<Project> make_minimal_project(
        std::unique_ptr<llvm::Module> module, const std::string &func_name,
        const std::map<std::string, std::string> &stack_vars) {
    auto proj = std::make_unique<Project>();

    auto layer = std::make_unique<Layer>("TestLayer");
    layer->abs_data = std::make_shared<SpecType>("RData");
    proj->layers.push_back(std::move(layer));

    for (const auto &[local, region] : stack_vars)
        proj->cmds.StackMap[func_name][local] = region;

    proj->spoq_code.llvm_module = std::move(module);
    return proj;
}

/// Stage 1 then stage 2.  [out_spec], when given, receives the printed SpecNode.
TranslateStatus run_to_spec(const std::string &path, const std::string &func_name,
                            const std::map<std::string, std::string> &stack_vars,
                            std::string *out_spec = nullptr) {
    llvm::LLVMContext ctx;
    llvm::SMDiagnostic err;
    auto module = llvm::parseIRFile(path, err, ctx);
    if (!module) return kBadInput;
    if (auto *f = module->getFunction(func_name); !f || f->isDeclaration()) return kBadInput;

    auto proj = make_minimal_project(std::move(module), func_name, stack_vars);
    auto *func = proj->spoq_code.llvm_module->getFunction(func_name);

    SpoqFunction &spoq_func = proj->spoq_code.spoq_funcs[func_name];
    spoq_func.llvm_func = func;
    spoq_func.cfg_converted = true;  // same bypass as stage 1

    try {
        if (!SpoqIRModule::llvm_ir_to_spoq_ir(spoq_func)) return kReturnedFalse;
        if (spoq_func.spoq_insts.empty()) return kNoInstructions;

        SpoqIRContext context(spoq_func, proj->layers[0], 0, proj->abs_config, proj->abs_layout);
        auto spec = proj->spoq_code.spoq_inst_to_spec(proj.get(), spoq_func.spoq_insts, 0, context);
        if (!spec) return kReturnedFalse;
        if (out_spec) *out_spec = std::string(*spec);
        return kTranslated;
    } catch (const std::exception &e) {
        llvm::errs() << "spoq_inst_to_spec threw: " << e.what() << "\n";
        return kThrew;
    }
}

struct Outcome {
    bool timed_out = false;
    bool crashed = false;
    int status = 0;
    size_t count = 0;
};

/// Run in a child: the translator can assert(), throw, or (via a malformed
/// walk) fail to terminate, none of which should take the suite down.
Outcome translate_with_deadline(const std::string &path, const std::string &func_name) {
    int pipefd[2];
    if (pipe(pipefd) != 0) return Outcome{false, true, 0, 0};

    const pid_t pid = fork();
    if (pid == 0) {
        close(pipefd[0]);
        size_t count = 0;
        const TranslateStatus st = run_translation(path, func_name, &count);
        ssize_t ignored = write(pipefd[1], &count, sizeof(count));
        (void)ignored;
        close(pipefd[1]);
        _exit(st);
    }
    close(pipefd[1]);

    Outcome out;
    for (int tick = 0; tick < kDeadlineSeconds * 10; tick++) {
        int status = 0;
        if (waitpid(pid, &status, WNOHANG) == pid) {
            if (WIFEXITED(status)) out.status = WEXITSTATUS(status);
            else out.crashed = true;
            size_t count = 0;
            if (read(pipefd[0], &count, sizeof(count)) == sizeof(count)) out.count = count;
            close(pipefd[0]);
            return out;
        }
        usleep(100000);
    }

    kill(pid, SIGKILL);
    waitpid(pid, nullptr, 0);
    close(pipefd[0]);
    out.timed_out = true;
    return out;
}

std::string data(const std::string &name) {
    return std::string(SPOQ_LL_DIR) + "/" + name;
}

/// Assert translation succeeds and yields at least one Spoq instruction.
void expect_translates(const std::string &file, const std::string &func_name) {
    const Outcome out = translate_with_deadline(data(file), func_name);
    ASSERT_FALSE(out.timed_out) << file << ": llvm_ir_to_spoq_ir did not terminate on '"
                                << func_name << "' within " << kDeadlineSeconds << "s";
    ASSERT_FALSE(out.crashed) << file << ": crashed translating '" << func_name << "'";
    ASSERT_NE(out.status, kBadInput) << file << ": could not parse, or no such function '"
                                     << func_name << "'";
    EXPECT_NE(out.status, kThrew) << file << ": threw translating '" << func_name << "'";
    EXPECT_NE(out.status, kReturnedFalse)
        << file << ": llvm_ir_to_spoq_ir returned false -- was cfg_converted set?";
    EXPECT_NE(out.status, kNoInstructions) << file << ": produced no Spoq instructions";
    EXPECT_EQ(out.status, kTranslated) << file << ": translating '" << func_name << "'";
}

/// Stage 2 in a child, with the printed SpecNode piped back (truncated).
Outcome spec_with_deadline(const std::string &path, const std::string &func_name,
                           const std::map<std::string, std::string> &stack_vars,
                           std::string *out_spec) {
    constexpr size_t kMaxSpec = 8192;
    int pipefd[2];
    if (pipe(pipefd) != 0) return Outcome{false, true, 0, 0};

    const pid_t pid = fork();
    if (pid == 0) {
        close(pipefd[0]);
        std::string spec;
        const TranslateStatus st = run_to_spec(path, func_name, stack_vars, &spec);
        spec.resize(std::min(spec.size(), kMaxSpec));
        ssize_t ignored = write(pipefd[1], spec.data(), spec.size());
        (void)ignored;
        close(pipefd[1]);
        _exit(st);
    }
    close(pipefd[1]);

    // Drain before reaping: a spec larger than the pipe buffer would otherwise
    // block the child in write() and look like a hang.
    std::string spec;
    char buf[4096];
    ssize_t n;
    while ((n = read(pipefd[0], buf, sizeof(buf))) > 0) spec.append(buf, n);
    close(pipefd[0]);

    Outcome out;
    int status = 0;
    waitpid(pid, &status, 0);
    if (WIFEXITED(status)) out.status = WEXITSTATUS(status);
    else out.crashed = true;
    if (out_spec) *out_spec = spec;
    return out;
}

/// Assert the fixture reaches a SpecNode, and hand it back for inspection.
void expect_spec(const std::string &file, const std::string &func_name,
                 const std::map<std::string, std::string> &stack_vars = {},
                 std::string *out_spec = nullptr) {
    std::string spec;
    const Outcome out = spec_with_deadline(data(file), func_name, stack_vars, &spec);
    ASSERT_FALSE(out.crashed) << file << ": crashed producing a SpecNode for '" << func_name
                              << "' (an unhandled instruction hits an assert here, not in stage 1)";
    ASSERT_NE(out.status, kBadInput) << file << ": could not parse, or no such function";
    EXPECT_NE(out.status, kThrew) << file << ": threw producing a SpecNode";
    EXPECT_EQ(out.status, kTranslated) << file << ": no SpecNode produced";
    EXPECT_FALSE(spec.empty()) << file << ": SpecNode printed empty";
    if (out_spec) *out_spec = spec;
}

/* -- straight-line and branching code: the translator's proper domain -------- */

TEST(IrTranslation, StraightLineTranslates) {
    expect_translates("translate_straightline.ll", "vuln");
}

// Branching is fine as long as no phi is left at a join point.
TEST(IrTranslation, IfElseTranslates) { expect_translates("translate_ifelse.ll", "vuln"); }

TEST(IrTranslation, MemoryOpsTranslate) { expect_translates("translate_memory.ll", "vuln"); }

/* -- select ------------------------------------------------------------------
 * Worth being precise about what these cover.  This stage does NOT interpret
 * instructions: dfs_llvm_ir_to_spoq_inst_vec pushes every non-branch
 * instruction into the vector as an opaque SpoqLLVMInst.  So a select passes
 * here whether or not anything downstream understands it, and these cases pin
 * that packing rather than any select semantics.
 *
 * Two things do care about select, neither of them here:
 *   - spoq_inst_to_spec (vector -> SpecNode) has no SelectInst arm at all;
 *     SelectInst appears nowhere in SpoqIRTranslator.cpp.
 *   - control_flow_eliminate_select (SpoqIRCFG.cpp:133) removes selects before
 *     that ever matters, by rewriting each into a diamond with a join phi.
 *
 * That rewrite is why these fixtures are interesting beyond packing: each
 * select becomes one diamond, and control_flow_clone_and_split clones diamonds
 * to remove their phis at 2^N cost.  ffm001_sws_init_context.ll holds 197
 * selects and ffm001_single_block_valuename.ll holds 51 in a single block,
 * which is what makes a one-block function take ~26s to hit the guard.
 */

TEST(IrTranslation, SelectTranslates) { expect_translates("translate_select.ll", "vuln"); }

TEST(IrTranslation, SelectChainTranslates) {
    expect_translates("translate_select_chain.ll", "vuln");
}

/* -- stage 2: LLVM instructions -> SpecNode ---------------------------------- */
// This is the stage that actually interprets instructions, so it is where an
// unsupported opcode shows up.  The assertions check the emitted SpecNode text,
// not just that something was produced -- otherwise a silently wrong
// translation would still pass.

TEST(IrTranslation, StraightLineProducesSpec) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_straightline.ll", "vuln", {}, &spec));
    EXPECT_NE(spec.find("let sum := (a + (b))"), std::string::npos) << spec;
    EXPECT_NE(spec.find("let masked := (shifted & (255))"), std::string::npos) << spec;
    // Returns the value paired with the unchanged state.
    EXPECT_NE(spec.find("(Some (masked, st))"), std::string::npos) << spec;
}

TEST(IrTranslation, IfElseProducesSpec) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_ifelse.ll", "vuln", {}, &spec));
    // The branch survives as an If in the spec, with both arms returning.
    EXPECT_NE(spec.find("if cmp"), std::string::npos) << spec;
    EXPECT_NE(spec.find("then"), std::string::npos) << spec;
    EXPECT_NE(spec.find("else"), std::string::npos) << spec;
}

TEST(IrTranslation, MemoryOpsProduceSpec) {
    // The alloca arm looks each local up in cmds.StackMap and asserts if it is
    // missing, so the regions have to be declared for the fixture's two allocas.
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_memory.ll", "vuln",
                                        {{"v_slot", "stack_type_1"}, {"v_arr", "stack_type_2"}},
                                        &spec));
    EXPECT_NE(spec.find("stack_type_1"), std::string::npos) << spec;
}

/* -- select translates directly, no CFG expansion ---------------------------- */
TEST(IrTranslation, SelectProducesSpec) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_select.ll", "vuln", {}, &spec));
    // select %cmp, 100, 200  ->  let sel := (if cmp then 100 else 200)
    EXPECT_NE(spec.find("let cmp := (x =? (50))"), std::string::npos) << spec;
    EXPECT_NE(spec.find("if cmp"), std::string::npos) << spec;
    EXPECT_NE(spec.find("then 100"), std::string::npos) << spec;
    EXPECT_NE(spec.find("else 200"), std::string::npos) << spec;
}

TEST(IrTranslation, SelectChainProducesSpec) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_select_chain.ll", "vuln", {}, &spec));
    // One If per `||` term, and nothing cloned: four selects stay four Ifs.
    size_t ifs = 0;
    for (size_t i = spec.find("if "); i != std::string::npos; i = spec.find("if ", i + 1)) ifs++;
    EXPECT_GE(ifs, 3u) << "expected one If per select term, got " << ifs << ":\n" << spec;
    EXPECT_EQ(spec.find("select"), std::string::npos)
        << "a select survived into the spec:\n" << spec;
}

/* -- the two documented limits of the bypass --------------------------------- */
// A diamond with a join phi: the translator asserts, because the CFG pass would
// have cloned the phi away first.  Pinned so the boundary is explicit.
TEST(IrTranslation, IfElseWithJoinPhiNeedsCfgPass) {
    const Outcome out = translate_with_deadline(data("translate_ifelse_joinphi.ll"), "vuln");
    ASSERT_FALSE(out.timed_out) << "join-phi input hung rather than failing cleanly";
    EXPECT_TRUE(out.crashed || out.status != kTranslated)
        << "a join phi unexpectedly translated without the CFG pass (count=" << out.count
        << "); if the translator now handles this, retire the test";
}

// A natural loop needs the preheader/postheader rewrite that
// control_flow_conversion_v2 performs.  Skipping it leaves the walk facing a
// back edge with no loop context.  This case exists so that limitation is
// asserted rather than folklore -- if translation ever starts coping with raw
// loops on its own, this is the test that will say so.
TEST(IrTranslation, LoopWithoutCfgPass) {
    const Outcome out = translate_with_deadline(data("nested_loop.ll"), "vuln");
    ASSERT_FALSE(out.timed_out) << "loop input made translation hang rather than fail cleanly";
    EXPECT_TRUE(out.crashed || out.status != kTranslated)
        << "a raw natural loop unexpectedly translated without the CFG pass "
           "(count=" << out.count << "); if that is now intended, retire this test";
}

}  // namespace

int main(int argc, char **argv) {
    // Oracle mode for llvm-reduce.  Before InitGoogleTest so flags do not clash.
    if (argc >= 4 && std::string(argv[1]) == "--spec") {
        std::string spec;
        const TranslateStatus st = run_to_spec(argv[2], argv[3], {}, &spec);
        llvm::errs() << spec << "\n";
        return st;
    }
    if (argc >= 4 && std::string(argv[1]) == "--translate") {
        size_t count = 0;
        const TranslateStatus st = run_translation(argv[2], argv[3], &count);
        llvm::errs() << "spoq_insts=" << count << "\n";
        return st;
    }
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
