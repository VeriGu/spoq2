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
 *     IrTranslationTest --spec-cfg  <file.ll> <function>   (the CFG pass first)
 *       exit 0  succeeded
 *       exit 2  returned false / produced no SpecNode
 *       exit 3  threw
 *       exit 4  could not parse / no such function
 *       exit 5  stage 1 produced no instructions
 */

#include <gtest/gtest.h>

#include "../skip_code.h"

#include <cctype>
#include <csignal>
#include <cstdlib>
#include <cstring>
#include <map>
#include <string>
#include <sys/wait.h>
#include <unistd.h>

#include <set>

#include <rules.h>

#include "llvm/AsmParser/Parser.h"
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
    kFreeVariable = 6,
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

/// Stage 1 then stage 2 over an already-parsed module.  [out_spec], when given,
/// receives the printed SpecNode.
TranslateStatus run_to_spec_of_module(std::unique_ptr<llvm::Module> module,
                                      const std::string &func_name,
                                      const std::map<std::string, std::string> &stack_vars,
                                      std::string *out_spec, bool run_cfg = false,
                                      std::string *out_defs = nullptr) {
    if (!module) return kBadInput;
    if (auto *f = module->getFunction(func_name); !f || f->isDeclaration()) return kBadInput;

    auto proj = make_minimal_project(std::move(module), func_name, stack_vars);
    auto *func = proj->spoq_code.llvm_module->getFunction(func_name);

    SpoqFunction &spoq_func = proj->spoq_code.spoq_funcs[func_name];
    spoq_func.llvm_func = func;
    // A loop needs the preheader/postheader rewrite, so those cases run the pass
    // for real rather than asserting its postcondition.
    if (run_cfg) {
        if (!SpoqIRModule::control_flow_conversion_v2(func_name, spoq_func)) return kReturnedFalse;
    } else {
        spoq_func.cfg_converted = true;  // same bypass as stage 1
    }

    if (std::getenv("SPOQ_DUMP_CFG")) func->print(llvm::errs());

    try {
        if (!SpoqIRModule::llvm_ir_to_spoq_ir(spoq_func)) return kReturnedFalse;
        if (spoq_func.spoq_insts.empty()) return kNoInstructions;

        SpoqIRContext context(spoq_func, proj->layers[0], 0, proj->abs_config, proj->abs_layout,
                              proj.get());
        auto spec = proj->spoq_code.spoq_inst_to_spec(proj.get(), spoq_func.spoq_insts, 0, context);
        if (!spec) return kReturnedFalse;
        if (out_spec) *out_spec = std::string(*spec);
        // What translating this function added to the project: the loop
        // Fixpoints, and every declaration it synthesised.  Neither is reachable
        // from the returned SpecNode, which names them but does not contain
        // them -- so a test reading only the spec cannot tell a loop built from
        // its body from one built from an empty vector, nor a name that was
        // declared from one that was merely used.
        if (out_defs) {
            for (auto const &[dn, d] : proj->defs)
                if (dn.rfind(func_name + "_", 0) == 0)
                    *out_defs += std::string(*d) + "\n";
            for (auto const &[dn, d] : proj->decls)
                *out_defs += std::string(*d) + "\n";
        }

        // The spec may name its own arguments and the state, and nothing else.
        // This is what check_well_typed asserts once a Definition exists; here
        // there is no Definition yet, so seed the same set by hand.
        std::set<std::string> free;
        free_vars(proj.get(), spec.get(), free);
        free.erase("st");
        // Erase the names the *translator* gives the arguments, not the ones
        // LLVM has: a dot is replaced, and an unnamed argument becomes `v_<n>`.
        // Comparing against getName() alone reports both kinds free.
        for (auto const &arg : func->args()) {
            if (!arg.getName().empty()) {
                free.erase(Shortcut::replace_dot(arg.getName().str()));
                continue;
            }
            std::string n;
            llvm::raw_string_ostream os(n);
            arg.printAsOperand(os, false, module.get());
            free.erase("v_" + Shortcut::replace_dot(n.substr(1)));
        }
        for (auto const &[name, _] : stack_vars) free.erase(name);
        if (!free.empty()) {
            for (auto const &n : free) llvm::errs() << "free: " << n << "\n";
            return kFreeVariable;
        }
        return kTranslated;
    } catch (const std::exception &e) {
        llvm::errs() << "spoq_inst_to_spec threw: " << e.what() << "\n";
        return kThrew;
    }
}

TranslateStatus run_to_spec(const std::string &path, const std::string &func_name,
                            const std::map<std::string, std::string> &stack_vars,
                            std::string *out_spec = nullptr, bool run_cfg = false,
                            std::string *out_defs = nullptr) {
    llvm::LLVMContext ctx;
    llvm::SMDiagnostic err;
    return run_to_spec_of_module(llvm::parseIRFile(path, err, ctx), func_name, stack_vars,
                                 out_spec, run_cfg, out_defs);
}

/// Same, from IR text -- for cases generated by the test rather than kept as a
/// fixture, where the size of the input is the thing being varied.
TranslateStatus run_to_spec_of_ir(const std::string &ir, const std::string &func_name,
                                  std::string *out_spec = nullptr) {
    llvm::LLVMContext ctx;
    llvm::SMDiagnostic err;
    return run_to_spec_of_module(llvm::parseAssemblyString(ir, err, ctx), func_name, {}, out_spec);
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

/// Separates the two payloads below; no SpecNode prints a control character.
constexpr const char *kDefsMarker = "\x01" "DEFS" "\x01";

/// Stage 2 in a child, with the printed SpecNode piped back (truncated), and
/// the definitions it created after [kDefsMarker] when [out_defs] is given.
Outcome spec_with_deadline(const std::string &path, const std::string &func_name,
                           const std::map<std::string, std::string> &stack_vars,
                           std::string *out_spec, bool run_cfg = false,
                           std::string *out_defs = nullptr) {
    constexpr size_t kMaxSpec = 8192;
    int pipefd[2];
    if (pipe(pipefd) != 0) return Outcome{false, true, 0, 0};

    const pid_t pid = fork();
    if (pid == 0) {
        close(pipefd[0]);
        std::string spec, defs;
        const TranslateStatus st =
            run_to_spec(path, func_name, stack_vars, &spec, run_cfg, out_defs ? &defs : nullptr);
        spec.resize(std::min(spec.size(), kMaxSpec));
        defs.resize(std::min(defs.size(), kMaxSpec));
        const std::string payload = spec + kDefsMarker + defs;
        ssize_t ignored = write(pipefd[1], payload.data(), payload.size());
        (void)ignored;
        close(pipefd[1]);
        _exit(st);
    }
    close(pipefd[1]);

    // Drain before reaping: a payload larger than the pipe buffer would
    // otherwise block the child in write() and look like a hang.
    std::string blob;
    char buf[4096];
    ssize_t n;
    while ((n = read(pipefd[0], buf, sizeof(buf))) > 0) blob.append(buf, n);
    close(pipefd[0]);

    Outcome out;
    int status = 0;
    waitpid(pid, &status, 0);
    if (WIFEXITED(status)) out.status = WEXITSTATUS(status);
    else out.crashed = true;

    // A child that died before writing leaves nothing to split.
    const size_t split = blob.find(kDefsMarker);
    if (out_spec) *out_spec = split == std::string::npos ? blob : blob.substr(0, split);
    if (out_defs && split != std::string::npos)
        *out_defs = blob.substr(split + std::strlen(kDefsMarker));
    return out;
}

/// Assert the fixture reaches a SpecNode, and hand it back for inspection.
void expect_spec(const std::string &file, const std::string &func_name,
                 const std::map<std::string, std::string> &stack_vars = {},
                 std::string *out_spec = nullptr, bool run_cfg = false,
                 std::string *out_defs = nullptr) {
    std::string spec;
    const Outcome out =
        spec_with_deadline(data(file), func_name, stack_vars, &spec, run_cfg, out_defs);
    ASSERT_FALSE(out.crashed) << file << ": crashed producing a SpecNode for '" << func_name
                              << "' -- an unhandled instruction or a failed type check asserts "
                                 "here, not in stage 1";
    ASSERT_NE(out.status, kBadInput) << file << ": could not parse, or no such function";
    EXPECT_NE(out.status, kThrew) << file << ": threw producing a SpecNode";
    EXPECT_NE(out.status, kFreeVariable)
        << file << ": the SpecNode references a name nothing binds (listed on stderr above)";
    EXPECT_EQ(out.status, kTranslated) << file << ": no SpecNode produced";
    EXPECT_FALSE(spec.empty()) << file << ": SpecNode printed empty";
    if (out_spec) *out_spec = spec;
}

/// Non-overlapping occurrences of [needle] in [hay].
size_t count_of(const std::string &hay, const std::string &needle) {
    size_t n = 0;
    for (size_t i = hay.find(needle); i != std::string::npos;
         i = hay.find(needle, i + needle.size()))
        n++;
    return n;
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
    // An arithmetic result is reduced to its width; a mask cannot leave one, so
    // it is not.
    EXPECT_NE(spec.find("let sum := (wrap32 (a + (b)))"), std::string::npos) << spec;
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

/* -- a reconverging if-else binds its join once ------------------------------- */
// When both arms of an If reconverge, they stop at the join and yield what it
// needs, and the If binds that:
//
//   when (r, st) == (if c then (Some (..., st)) else (Some (..., st))); <rest>
//
// so <rest> is emitted once.  The alternative -- a terminal If, with <rest> in
// both arms -- is what makes N joins in sequence cost 2^N.
TEST(IrTranslation, ReconvergingIfElseBindsJoinOnce) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_ifelse_joinphi.ll", "vuln", {}, &spec));

    // The join's phi and the state are bound together by a `when`.  The None
    // arm is not incidental: an arm can contain a `rely` -- a load, a store, a
    // division -- which makes it option-typed, so the bind has to propagate
    // None.
    EXPECT_NE(spec.find("when r, st =="), std::string::npos)
        << "the join is not bound by a when:\n" << spec;
    // Each arm yields its own value for the phi, paired with its own state.
    EXPECT_NE(spec.find("(Some (t, st))"), std::string::npos)
        << "then arm does not yield:\n" << spec;
    EXPECT_NE(spec.find("(Some (e, st))"), std::string::npos)
        << "else arm does not yield:\n" << spec;
    EXPECT_EQ(spec.find("phi"), std::string::npos) << "a phi survived into the spec:\n" << spec;

    // The point of the exercise: the continuation appears once.  If it appears
    // twice the arms are carrying it, which is the 2^N shape.
    size_t returns = 0;
    for (size_t i = spec.find("Some (r, st)"); i != std::string::npos;
         i = spec.find("Some (r, st)", i + 1))
        returns++;
    EXPECT_EQ(returns, 1u) << "the continuation was duplicated into both arms:\n" << spec;
}

/* -- several phis in one block ------------------------------------------------ */
// LLVM puts every phi at the top of its block and runs them simultaneously:
// each reads what its edge carried in, not what an earlier phi in the same
// block just produced.  The translator emits one binding per phi, in order, so
// these two cases pin that the sequencing is not observable.
//
// It is not, for a dominance reason rather than by luck: a phi's incoming value
// must dominate the terminator of the edge it arrives on, and nothing defined
// inside the join block dominates any predecessor of that block.  So no phi at
// a join can name a sibling phi, and there is no parallel copy to schedule.
// (Loop headers can have mutually referring phis; those become Fixpoint
// arguments instead, which is why they are not covered here.)
//
// Both fixtures cross their incoming values over, so resolving the wrong edge
// changes the arithmetic rather than producing something that merely still
// typechecks.

// Two predecessors: the join is recognised as a reconvergence, so all three
// phis are bound together, as one tuple, in front of the If.
TEST(IrTranslation, MultiplePhisAtAReconvergingJoin) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_multi_phi.ll", "vuln", {}, &spec));

    // a <- t1/e1, b <- t2/e2, mix <- t2/e1.  Each arm yields all three in phi
    // order, so the whole tuple pins every edge at once.
    EXPECT_NE(spec.find("(t1, t2, t2, st)"), std::string::npos)
        << "then arm does not carry (a, b, mix) for its edge:\n" << spec;
    EXPECT_NE(spec.find("(e1, e2, e1, st)"), std::string::npos)
        << "else arm does not carry (a, b, mix) for its edge:\n" << spec;
    EXPECT_NE(spec.find("(a, b, mix, st)"), std::string::npos)
        << "the three phis are not bound together:\n" << spec;
    EXPECT_EQ(spec.find("phi"), std::string::npos) << "a phi survived:\n" << spec;

    // Reconvergence means the code after the join is emitted once.
    size_t uses = 0;
    for (size_t i = spec.find("let s :="); i != std::string::npos; i = spec.find("let s :=", i + 1))
        uses++;
    EXPECT_EQ(uses, 1u) << "the continuation was duplicated:\n" << spec;
}

// Three predecessors, reached as nested Ifs.  The inner If reconverges at the
// same join as the outer one, so each path yields all three phis as a tuple and
// the continuation is emitted once -- the same contract as the two-way case,
// which is what computing the reconvergence point rather than matching a shape
// buys.  Each path's triple pins which edge every phi was resolved against.
TEST(IrTranslation, MultiplePhisAtAThreeWayJoin) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(
        expect_spec("translate_multi_phi_three_preds.ll", "vuln", {}, &spec));

    // %w crosses over: a1's second value, a2's first, a3's second.
    EXPECT_NE(spec.find("(Some (p, q, q, st))"), std::string::npos) << spec;
    EXPECT_NE(spec.find("(Some (r2, s2, r2, st))"), std::string::npos) << spec;
    EXPECT_NE(spec.find("(Some (r3, s3, s3, st))"), std::string::npos) << spec;
    EXPECT_NE(spec.find("(Some (u, v, w, st))"), std::string::npos)
        << "the three phis are not bound together:\n" << spec;
    EXPECT_EQ(spec.find("phi"), std::string::npos) << "a phi survived:\n" << spec;

    size_t uses = 0;
    for (size_t i = spec.find("let t :="); i != std::string::npos; i = spec.find("let t :=", i + 1))
        uses++;
    EXPECT_EQ(uses, 1u) << "the continuation was duplicated:\n" << spec;
}

// N reconverging diamonds in sequence must cost O(N), not O(2^N).  Asserted on
// the size of the emitted spec rather than on a clock, so it does not depend on
// how loaded the machine is: exponential growth fails this by orders of
// magnitude, and a constant-factor regression does not fail it at all.
TEST(IrTranslation, DiamondChainSpecGrowsLinearly) {
    const auto spec_size = [](int joins) -> size_t {
        std::string ir = "define dso_local i32 @vuln(i32 %x) {\nentry:\n"
                         "  %c0 = icmp eq i32 %x, 0\n"
                         "  br i1 %c0, label %t0, label %f0\n";
        for (int i = 0; i < joins; i++) {
            const std::string n = std::to_string(i);
            const std::string merge = (i + 1 < joins) ? "m" + std::to_string(i + 1) : "exit";
            ir += "t" + n + ":\n  br label %" + merge + "\n";
            ir += "f" + n + ":\n  br label %" + merge + "\n";
            if (i + 1 < joins) {
                const std::string m = std::to_string(i + 1);
                ir += "m" + m + ":\n  %p" + m + " = phi i32 [ " + n + ", %t" + n + " ], [ 1" + n +
                      ", %f" + n + " ]\n";
                ir += "  %c" + m + " = icmp eq i32 %x, " + m + "\n";
                ir += "  br i1 %c" + m + ", label %t" + m + ", label %f" + m + "\n";
            }
        }
        const std::string last = std::to_string(joins - 1);
        ir += "exit:\n  %pl = phi i32 [ 7, %t" + last + " ], [ 8, %f" + last + " ]\n"
              "  ret i32 %pl\n}\n";

        std::string spec;
        const TranslateStatus st = run_to_spec_of_ir(ir, "vuln", &spec);
        EXPECT_EQ(st, kTranslated) << joins << " diamonds did not translate";
        return spec.size();
    };

    const size_t at10 = spec_size(10);
    const size_t at40 = spec_size(40);
    ASSERT_GT(at10, 0u);

    // Linear would put at40 near 4x at10.  Allow generous slack for the fixed
    // preamble and for names getting longer, but nothing like 2^30.
    EXPECT_LT(at40, at10 * 8)
        << "spec grew faster than linearly in the number of joins: " << at10 << " bytes at 10, "
        << at40 << " at 40 -- the continuation is being duplicated again";
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
    if (argc >= 4 && (std::string(argv[1]) == "--spec" ||
                      std::string(argv[1]) == "--spec-cfg")) {
        std::string spec, defs;
        const bool run_cfg = std::string(argv[1]) == "--spec-cfg";
        // Give every alloca a stack slot of its own.  A real project gets these
        // from the StackMap the preprocessing passes emit; without them the
        // alloca arm asserts, which would stop this being usable as a reduction
        // oracle on a function lifted out of one.
        std::map<std::string, std::string> stack_vars;
        {
            llvm::LLVMContext ctx;
            llvm::SMDiagnostic err;
            if (auto m = llvm::parseIRFile(argv[2], err, ctx))
                if (auto *fn = m->getFunction(argv[3]))
                    for (auto &bb : *fn)
                        for (auto &inst : bb)
                            if (auto *a = llvm::dyn_cast<llvm::AllocaInst>(&inst)) {
                                std::string name = a->getName().str();
                                if (name.empty()) {
                                    llvm::raw_string_ostream os(name);
                                    a->printAsOperand(os, false, m.get());
                                    name.erase(0, 1);
                                }
                                name = "v_" + Shortcut::replace_dot(name);
                                stack_vars[name] = "stack_" + name;
                            }
        }
        const TranslateStatus st =
            run_to_spec(argv[2], argv[3], stack_vars, &spec, run_cfg, &defs);
        llvm::errs() << spec << "\n";
        if (!defs.empty()) llvm::errs() << "\n-- definitions --\n" << defs;
        return st;
    }
    if (argc >= 4 && std::string(argv[1]) == "--translate") {
        size_t count = 0;
        const TranslateStatus st = run_translation(argv[2], argv[3], &count);
        llvm::errs() << "spoq_insts=" << count << "\n";
        return st;
    }
    ::testing::InitGoogleTest(&argc, argv);
    return spoq_test::skip_aware_status(RUN_ALL_TESTS());
}

/* -- joins that merge a loop exit with a path that skipped the loop ---------- */

/// A join phi whose loop-side value is defined *inside* the loop body, rather
/// than being the header phi itself.
///
/// `bind_loop_results` has to bind the backedge *source*, not only the header
/// phi and the pass-in values: the join phi here takes `%add`, defined in the
/// body, and the spec used to end `let baseline_0_lcssa := add in` with nothing
/// binding `add`.
///
/// This was the translation failure behind lua002 (`luaG_getfuncline`), which
/// aborted in check_well_typed with `Unknown symbol: add`.  Passes now; the
/// fixture is the guard.
TEST(IrTranslationSpec, LoopExitJoinBindsBodyValue) {
    expect_spec("loop_exit_join_body_value.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// A value defined in an *inner* loop, escaping through a join that sits inside
/// the outer loop and is also reachable without entering the inner one.
///
/// `%v` cannot be an input to the outer loop -- it is defined strictly inside
/// it -- and used to be passed in all the same, so the outer loop's call site
/// named it before anything bound it.
///
/// The cause was an ordering dependence: pass_analysis needs a nested loop's
/// parent link to place a value defined inside it, and that link was only
/// recorded when the DFS happened to reach the nested preheader.  Here the join
/// is the *first* successor of the outer header, so the use came first, the
/// value looked top-level, and it was passed into every loop on the stack.
/// travel() now records the nesting during the walk that establishes it.
///
/// Reduced from initFilter (ffm001), which aborted the run with
/// `Unknown symbol: indvars_iv_next552_1`.  The cases above cover the
/// single-loop version of the same escape, which always worked; it took the
/// nesting plus the skip edge.
TEST(IrTranslationSpec, LoopInnerValueEscapesToOuterJoin) {
    expect_spec("loop_inner_value_escapes_to_outer_join.ll", "vuln", {}, nullptr,
                /*run_cfg=*/true);
}

/// A register named the same as a declared symbol is renamed.
///
/// clang calls the result of `fneg` `%fneg`, and the uninterpreted float
/// negation is declared under that name too, so the binding shadowed it and the
/// value was used where a Z -> Z function was expected.
TEST(IrTranslationSpec, ValueNamedLikeADeclarationIsRenamed) {
    std::string spec, defs;
    expect_spec("value_named_like_a_declaration.ll", "vuln", {}, &spec, /*run_cfg=*/false, &defs);
    EXPECT_NE(defs.find("Parameter fneg : Z -> Z."), std::string::npos) << defs;
    EXPECT_NE(spec.find("let v_fneg := (fneg x)"), std::string::npos)
        << "the binding still shadows the declaration:\n" << spec;
}

/// Signature stability. The header phi `%acc` takes its initial value from
/// `%init`, computed outside the loop, and `%acc` is itself what escapes.
/// header_phi supplies that initial value positionally at the call site, so it
/// must not also be routed through pass_in -- that would widen the return tuple
/// of every loop with a header phi, which is nearly all of them.
///
/// Passes today. The pinned text is the guard: if the loop's arity grows, this
/// is where it shows up.
TEST(IrTranslationSpec, LoopHeaderPhiInitialValueDoesNotWidenTheLoop) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(
        expect_spec("loop_exit_join_header_phi.ll", "vuln", {}, &spec, /*run_cfg=*/true));
    // The call site is the sharp test: were %init routed through pass_in it would
    // gain an argument here.  The return tuple is deliberately not pinned -- an
    // escaping header phi legitimately adds a pass_out slot, as
    // LoopHeaderPhiUsedAfterLoopTranslates shows.
    EXPECT_NE(spec.find("(vuln_loop_0_low n 0 init 0 st)"), std::string::npos)
        << "the initial value is no longer passed positionally:\n" << spec;
}

/// The same defect as LoopExitJoinBindsBodyValue, but with two loop exits, so
/// the postheader selector has to dispatch between them while the escaping
/// value is carried out alongside it.
///
/// Passes now, with `%sum` carried out alongside the selector.
TEST(IrTranslationSpec, LoopTwoExitsBindBodyValue) {
    expect_spec("loop_two_exits_body_value.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// A loop value defined on only one path through the body, escaping through a
/// join below two exits. `%v` dominates `exit.side` and not `exit.normal`.
///
/// Passes today, and not by the route the name suggests: `%v` never enters
/// pass_out at all. The exit path is emitted after the loop and `%v` is
/// recomputed there from the passed-out `%i`. It is pinned because it is the
/// case most likely to change once phi operands start populating pass_out --
/// `%v` would then be a pass_out value that does not dominate every exiting
/// block, which is what update_loop_break_return_list substitutes UndefValue
/// for, and that substitution is otherwise unexercised.
TEST(IrTranslationSpec, LoopExitValueOnOnePathTranslates) {
    expect_spec("loop_exit_value_partial_dominance.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// Two exits carrying *different* in-loop values to a common merge. `%a` is
/// defined in the header, `%b` in the latch, and the merge phi takes one from
/// each exit, so the exit selector alone cannot stand in for the value.
///
/// **This case currently fails**: both `%a` and `%b` are left free.
///
/// It is also the only fixture that reaches update_loop_break_return_list's
/// UndefValue substitution. Once the two become pass_out values, `%a` dominates
/// both exiting blocks but `%b` dominates only the latch, so the return list
/// built for the early exit has to stand something in for it.
TEST(IrTranslationSpec, LoopTwoExitsBindDistinctBodyValues) {
    expect_spec("loop_two_exits_distinct_values.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// A header phi used after the loop by an ordinary instruction.
///
/// The value comes out once, as `acc_after`. It also reaches
/// recursive_update_pass, which records it as a pass_out; add_header_phi drops
/// that copy, since the loop already returns it. Pinned because carrying the
/// same value out twice is invisible in the result -- the pass_out copy is
/// shadowed by bind_loop_results -- and shows up only as a wider signature.
TEST(IrTranslationSpec, LoopHeaderPhiUsedAfterLoopTranslates) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(
        expect_spec("loop_header_phi_used_after_loop.ll", "vuln", {}, &spec, /*run_cfg=*/true));
    EXPECT_NE(spec.find("(Some (n_after, i_after, acc_after, v_0, st))"), std::string::npos)
        << "the loop's carry-out changed shape:\n" << spec;
}

/// A value defined in the *inner* loop escaping past both loops. `%prod` has to
/// be carried out of the inner loop and then out of the outer one, which is the
/// recursive walk in recursive_update_pass rather than a single level.
///
/// **This case currently fails, and fails harder than the others**: rather than
/// leaving a free name in the emitted spec, it aborts in `check_well_typed` with
///
///     [ERR]: Unknown symbol: prod
///     Assertion `well_typed\' failed.
///
/// which is the lua002 failure exactly -- same assert, same file, one symbol
/// different. The nesting is what makes the difference: a Definition is built
/// for the inner loop and type-checked on the spot.
TEST(IrTranslationSpec, NestedLoopInnerValueEscapes) {
    expect_spec("nested_loop_inner_value_escapes.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// Two sequential loops at the same level, the second using a body value of the
/// first through an ordinary instruction.
///
/// Passes today, and shows the sideways path working: `%asum` is a pass_out of
/// the first loop and a pass_in of the second, bound by the first loop\'s pattern
/// and handed to the second positionally.
TEST(IrTranslationSpec, SiblingLoopsValueUsedDirectly) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("sibling_loops_value_used_directly.ll", "vuln", {},
                                        &spec, /*run_cfg=*/true));
    EXPECT_NE(spec.find("(Some (n_after, ai_after, aacc_after, asum, v_0, st))"),
              std::string::npos)
        << "the first loop no longer carries asum out:\n" << spec;
    EXPECT_NE(spec.find("(vuln_loop_1_low asum m 0 0 0 0 st)"), std::string::npos)
        << "the second loop no longer takes asum in:\n" << spec;
}

/// The same two loops, with the second taking the first\'s body value as the
/// initial value of its header phi -- the only use of `%asum` outside the first
/// loop.
///
/// **This case currently fails**: `%asum` is passed positionally at the second
/// loop\'s call site while nothing carries it out of the first, so it is free.
///
/// It is the case that rules out skipping header phis wholesale. A header phi\'s
/// backedge operand is the carried value and needs nothing, but its
/// preheader-edge operand is evaluated *outside* the loop and must be available
/// there -- which for a value defined in a sibling loop means being passed out
/// of that one.
TEST(IrTranslationSpec, SiblingLoopsValueViaHeaderPhi) {
    expect_spec("sibling_loops_value_via_header_phi.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// A value defined in the inner loop that escapes *only* through the outer
/// loop\'s backedge. `%prod` is the outer loop\'s carried value and nothing below
/// the outer loop mentions it, so the escape is a use outside the inner loop but
/// inside the outer one.
///
/// **This case currently fails**, aborting in `check_well_typed` with
/// `Unknown symbol: prod`.
///
/// It is the case that rules out skipping a header phi\'s backedge operand. For
/// an ordinary loop that operand is the carried value and needs nothing, but
/// here it is defined one level deeper, so it has to be carried out of the inner
/// loop first. NestedLoopInnerValueEscapes does not pin this: there the join
/// below both loops reaches `%prod` by another route.
TEST(IrTranslationSpec, NestedLoopInnerValueViaOuterBackedge) {
    expect_spec("nested_loop_inner_value_via_outer_backedge.ll", "vuln", {}, nullptr,
                /*run_cfg=*/true);
}

TEST(IrTranslationSpec, DiagProbe) {
    for (auto const *f : {"loop_exit_join_header_phi.ll",
                          "nested_loop_inner_value_via_outer_backedge.ll"}) {
        fprintf(stderr, "\n######### %s\n", f);
        std::string spec;
        expect_spec(f, "vuln", {}, &spec, /*run_cfg=*/true);
        fprintf(stderr, "SPEC:\n%s\n", spec.c_str());
    }
}

/* -- integer to floating point --------------------------------------------- */

/// `sitofp i32 -> double` and back.  Both casts are uninterpreted: a cast is
/// not the identity, and saying `conv = n` would be a claim about rounding --
/// false for any n a double cannot represent exactly.
TEST(IrTranslationSpec, SitofpToDouble) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_sitofp_double.ll", "vuln", {}, &spec));
    EXPECT_NE(spec.find("let conv := (sitofp n) in"), std::string::npos) << spec;
    EXPECT_NE(spec.find("let back := (fptosi conv) in"), std::string::npos) << spec;
}

/// The same round trip through a 32-bit float.  Float is one type in the spec
/// language, so the width does not reach the translation and this must come out
/// character for character identical to the double -- which is also what lets
/// vuln and patch relate when one was compiled with a different width.
TEST(IrTranslationSpec, SitofpToFloat) {
    std::string spec, double_spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_sitofp_float.ll", "vuln", {}, &spec));
    ASSERT_NO_FATAL_FAILURE(
        expect_spec("translate_sitofp_double.ll", "vuln", {}, &double_spec));
    EXPECT_EQ(spec, double_spec) << "width reached the spec:\n" << spec;
}

/// Arithmetic between the two casts, with a floating point literal.
TEST(IrTranslationSpec, FloatArithmetic) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_float_arithmetic.ll", "vuln", {}, &spec));
    EXPECT_NE(spec.find("let mul := (fmul conv float_lit_"), std::string::npos) << spec;
    // Not integer multiplication, which is what it used to print as.
    EXPECT_EQ(spec.find("conv * ("), std::string::npos) << spec;
}

/// Every arithmetic opcode, including `fneg`.
///
/// `fneg` is the one that could not be printed at all: it is an `Expr::unops`,
/// which is in the op variant but has no branch in `Expr::stream`, so printing
/// one fell through to `std::get<unique_ptr<SpecNode>>` on a variant holding a
/// `unops` and threw `bad_variant_access`.
TEST(IrTranslationSpec, FloatOpsAreUninterpreted) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_float_ops.ll", "vuln", {}, &spec));
    for (const char *op : {"(fadd a b)", "(fsub add b)", "(fmul sub a)", "(fdiv mul b)",
                           "(frem div a)", "(fneg rem)"})
        EXPECT_NE(spec.find(op), std::string::npos) << op << " missing from:\n" << spec;
}

/// Eight fcmp predicates.  Only `oeq` was mapped before -- 48 of the corpus's
/// 5686 float comparisons -- and the rest asserted.
///
/// Ordered and unordered differ only over NaN, so `olt` and `ult` must stay
/// different symbols; collapsing them would be the same claim the file already
/// makes for signed and unsigned integer comparison, and there is no reason to
/// repeat it where nothing is being modelled anyway.
TEST(IrTranslationSpec, FloatComparisonsAreUninterpreted) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_float_cmp.ll", "vuln", {}, &spec));
    for (const char *p : {"fcmp_oeq", "fcmp_olt", "fcmp_ole", "fcmp_ogt", "fcmp_oge",
                          "fcmp_one", "fcmp_ult", "fcmp_uno"})
        EXPECT_NE(spec.find(p), std::string::npos) << p << " missing from:\n" << spec;
}

/// Floating point intrinsics, which are the open-ended part: a dozen distinct
/// ones appear in the corpus, so they are recognised by their types rather than
/// by name.  The overload suffix is dropped, so `llvm.fabs.f64` and a
/// hypothetical `.f32` are one symbol.
TEST(IrTranslationSpec, FloatIntrinsicsAreUninterpreted) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_float_intrinsic.ll", "vuln", {}, &spec));
    EXPECT_NE(spec.find("let abs := (llvm_fabs a) in"), std::string::npos) << spec;
    // Three arguments, and the callee is not one of them.
    EXPECT_NE(spec.find("let fma := (llvm_fmuladd abs b a) in"), std::string::npos) << spec;
}

/// One literal used twice is one constant; a neighbouring double is not.
///
/// The name comes from the exact bits, so nothing rounds two distinct values
/// together -- which a printed decimal would do at the seventeenth digit.
TEST(IrTranslationSpec, FloatLiteralsShareOneConstant) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(
        expect_spec("translate_float_literal_shared.ll", "vuln", {}, &spec));
    EXPECT_EQ(count_of(spec, "float_lit_0x1p_1"), 2u)
        << "2.0 is not one constant across its uses:\n" << spec;
    EXPECT_NE(spec.find("float_lit_0x1_0000000000001p_1"), std::string::npos)
        << "the neighbouring double collided with 2.0:\n" << spec;
}

/// A floating point literal as an inline operand.
///
/// **This case currently fails.** Kept as the fix target, and as the record of
/// where the float model gives out. `FloatConst::to_string` prints the value in
/// full, so the operand comes out as `(4095.000000)`: not a term the spec
/// language has, `Float` being `Z`. ffm001 gets as far as
/// `Unknown expression: (indvars_iv / ((4095.000000)))`.
///
/// Rendering it as an integer would make this pass and would match what the
/// solver already does -- z3_eval truncates the same constant toward zero --
/// but it would also silently turn the 0.5 and 0.6 elsewhere in ffm001 into 0.
/// The disagreement is left visible rather than resolved by rounding.
TEST(IrTranslationSpec, FloatLiteralLocal) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(
        expect_spec("translate_float_literal_local.ll", "vuln", {}, &spec));
    EXPECT_EQ(spec.find("4095.000000"), std::string::npos)
        << "a float literal is still rendered as a decimal:\n" << spec;
}

/// A global initialised with a floating point literal, loaded in the body.
///
/// Passes, and shows the literal does not reach this translation at all: the
/// load yields an opaque Z and the initialiser belongs to the project\'s globals
/// model, not to the function\'s spec. Pinned so that stays true -- whatever
/// fixes the local case should not start inlining global initialisers here.
TEST(IrTranslationSpec, FloatLiteralGlobal) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(
        expect_spec("translate_float_literal_global.ll", "vuln", {}, &spec));
    EXPECT_NE(spec.find("when s == ((load_RData 8 (mkPtr \"scale\" 0) st))"), std::string::npos)
        << spec;
    EXPECT_EQ(spec.find("2.500000"), std::string::npos)
        << "the initialiser leaked into the body:\n" << spec;
}

/* -- a branch reconverging at a loop preheader ------------------------------ */

/// Two arms reconverging at a block that is the loop\'s preheader.
///
/// `usable_join` refuses a postheader, whose phis carry the loop\'s results, but
/// admits a preheader, whose phis are ordinary. Refusing both left each arm to
/// walk into the loop and emit it again, which asserted on the second arm --
/// what ffm015 (`decode_str`) and ffm021 (`nsv_parse_NSVs_header`) hit.
///
/// The loop appearing once, after the If, is the whole point of the fixture.
TEST(IrTranslationSpec, JoinAtLoopPreheader) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(
        expect_spec("join_two_preds_before_loop.ll", "vuln", {}, &spec, /*run_cfg=*/true));
    auto const first = spec.find("vuln_loop_0_low");
    ASSERT_NE(first, std::string::npos) << "the loop is gone entirely:\n" << spec;
    EXPECT_EQ(spec.find("vuln_loop_0_low", first + 1), std::string::npos)
        << "the loop is emitted more than once:\n" << spec;
}

/// The same with three arms, as ffm021 has.
///
/// **This case currently fails too**, identically. Arity is not what decides it:
/// a three-way join is declined for being neither a diamond nor a triangle, and
/// a two-way join at a preheader is declined for being a preheader. Pinned
/// separately because the two reach the same assert by different routes, and a
/// fix for one need not fix the other.
TEST(IrTranslationSpec, JoinThreePredsAtLoopPreheader) {
    expect_spec("join_three_preds_before_loop.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// The control: one block between the join and the loop header, so the join is
/// an ordinary join and the preheader is somewhere the arms never stop.
///
/// Passes, which is what places the defect on the join being a preheader rather
/// than on there being a loop below it at all.
TEST(IrTranslationSpec, JoinAboveLoopPreheaderTranslates) {
    expect_spec("join_then_loop_preheader.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// A chain of early exits converging on one join, with a loop below it.
///
/// **This case currently fails.** Kept as the fix target.
///
/// Reduced from `decode_unit_vuln` in ffm054, where a fully unrolled 16-way
/// search gives `while.end` seventeen predecessors and three seventeen-way phis.
/// A ladder is neither a diamond nor a triangle -- each rung\'s taken edge goes to
/// the next rung rather than to the join -- so no structural enumeration
/// recognises it, and no arm is a single block reaching the join.
///
/// Distinct from JoinAtLoopPreheader in what declines it: there the join *was*
/// the preheader, and admitting preheaders fixed it. Here the join has two
/// successors and is not a preheader, so only its shape is in the way. That is
/// also what separates it from JoinThreePredsAtLoopPreheader, which has both
/// problems at once.
TEST(IrTranslationSpec, UnrolledLadderBeforeLoop) {
    expect_spec("unrolled_ladder_before_loop.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/* -- switch ----------------------------------------------------------------- */
/*
 * A switch is lowered to a chain of equality tests before anything else runs,
 * so these all go through control_flow_conversion_v2 rather than the bypass the
 * rest of the file uses.  Without the pass the walk meets the SwitchInst itself,
 * which no arm of spoq_inst_to_spec handles.
 */

/// A switch reconverging at one join: three cases plus a default, four edges in.
///
/// The lowered chain is a ladder, the shape UnrolledLadderBeforeLoop pins, so
/// the outer test reconverges at the join and every inner one inherits that
/// stop -- each arm yields the join's phi values on its own edge, and the code
/// below the join is emitted once.
TEST(IrTranslationSpec, Switch) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_switch.ll", "vuln", {}, &spec,
                                        /*run_cfg=*/true));
    EXPECT_EQ(spec.find("switch"), std::string::npos) << "a switch survived:\n" << spec;
    size_t uses = 0;
    for (size_t i = spec.find("let s :="); i != std::string::npos; i = spec.find("let s :=", i + 1))
        uses++;
    EXPECT_EQ(uses, 1u) << "the continuation was emitted once per arm:\n" << spec;
}

/// The same switch with a loop below the join, which is the shape `decode_str`
/// has in ffm015.  The join is the loop's preheader once its phis are split
/// off, so the walk has to reach the preheader through the lowered chain and
/// register the loop exactly once.
TEST(IrTranslationSpec, SwitchBeforeLoop) {
    expect_spec("switch_before_loop.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// Two cases sharing a target, so the switch block reaches it along two edges
/// and a phi there names that block twice.  Lowering gives the two edges
/// different test blocks, and the two phi entries have to follow them apart.
TEST(IrTranslationSpec, SwitchSharedCaseTargets) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("switch_shared_case_targets.ll", "vuln", {}, &spec,
                                        /*run_cfg=*/true));
    // Both edges reach the shared arm, so its body appears twice -- but the
    // join below it is still reconverged at, so the code after is emitted once.
    size_t uses = 0;
    for (size_t i = spec.find("let s :="); i != std::string::npos; i = spec.find("let s :=", i + 1))
        uses++;
    EXPECT_EQ(uses, 1u) << "the continuation was duplicated:\n" << spec;
}

/// One case and a default: a single test, and no intermediate block to create.
TEST(IrTranslationSpec, SwitchSingleCase) {
    expect_spec("switch_degenerate.ll", "one_case", {}, nullptr, /*run_cfg=*/true);
}

/// An empty case list, which is an unconditional branch to the default.
TEST(IrTranslationSpec, SwitchNoCases) {
    expect_spec("switch_degenerate.ll", "no_cases", {}, nullptr, /*run_cfg=*/true);
}

/// A case whose target is the default's.  Its test cannot change where control
/// goes, so the case is dropped -- and the default then has one incoming edge
/// where it had two, which its phi has to be trimmed to match.
TEST(IrTranslationSpec, SwitchCaseTargetIsDefault) {
    expect_spec("switch_degenerate.ll", "case_is_default", {}, nullptr, /*run_cfg=*/true);
}

/// A switch inside a loop whose cases leave by two different exits.  Loop
/// normalisation redirects every exit edge to a single postheader, and asserts
/// both that an exiting block ends in a branch and that it has one outgoing
/// edge; an unlowered switch with two escaping cases fails both.
TEST(IrTranslationSpec, SwitchInLoopWithMultipleExits) {
    expect_spec("switch_in_loop_multi_exit.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// An exhaustive switch, whose default clang makes `unreachable`.  Nothing
/// post-dominates the switch block, so there is no reconvergence point and each
/// arm walks the code below the join for itself.
TEST(IrTranslationSpec, SwitchDefaultUnreachable) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("switch_default_unreachable.ll", "vuln", {}, &spec,
                                        /*run_cfg=*/true));
    // Pinned rather than desired: one copy of the continuation per reaching
    // arm.  Two cases is two copies, and an exhaustive switch over a wide enum
    // would be that many.
    size_t uses = 0;
    for (size_t i = spec.find("let s :="); i != std::string::npos; i = spec.find("let s :=", i + 1))
        uses++;
    EXPECT_EQ(uses, 2u) << spec;
}

/// Every arm returns, so there is no join at any level of the lowered chain and
/// each If is the last instruction in its arm.
TEST(IrTranslationSpec, SwitchArmsReturn) {
    expect_spec("switch_arms_return.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/* -- a loop entered on two paths -------------------------------------------- */

/// A loop preheader reached along two paths that no branch reconverges at.
///
/// **This case currently fails.** Kept as the fix target:
///
///     Assertion `!context.has_loop_inst_for_jump(block)' failed.
///
/// The walk enters the loop once per path, and a loop is registered by its
/// preheader, so the second entry finds the first already there.  More than an
/// over-strict assert: llvm_ir_to_spoq_ir fills one body vector per preheader,
/// so of the SpoqLoopInsts emitted only the last registered would have a body.
///
/// Reached through switches in ffm015 -- one case of an outer switch and two of
/// an inner one converge on the block above the preheader -- but nothing here
/// is switch-specific: plain branches reproduce it in seventeen lines.
TEST(IrTranslationSpec, LoopPreheaderOnTwoPaths) {
    expect_spec("loop_preheader_on_two_paths.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
}

/// The same shape with a value carried out of the loop and read below it.
///
/// **This case currently fails**, at the same assert. It exists because the
/// bare case above cannot tell a correct fix from a plausible one: its loop
/// returns nothing anyone reads, so simply deleting the assert produces a
/// closed, free-variable-clean spec whose top-level text is byte-identical to
/// the correct one. What differs is the definition -- built from whichever
/// SpoqLoopInst was registered last, which is empty for the one visited first:
///
///     Fixpoint vuln_loop_0_low (m: Z) (i: Z) (sum: Z) ... : (option (Z * Z * Z * Z * Z * RData)) :=
///       (Some st).
///
/// Body dropped, no recursive call, and ill-typed against its own return type.
/// So the assertions below read the emitted definition, not just the spec.
TEST(IrTranslationSpec, LoopPreheaderOnTwoPathsCarriesValueOut) {
    std::string spec, defs;
    ASSERT_NO_FATAL_FAILURE(expect_spec("loop_preheader_on_two_paths_value_out.ll", "vuln", {},
                                        &spec, /*run_cfg=*/true, &defs));

    // One call per path, both carrying the loop's result to the join.
    size_t calls = 0;
    for (size_t i = spec.find("vuln_loop_0_low"); i != std::string::npos;
         i = spec.find("vuln_loop_0_low", i + 1))
        calls++;
    EXPECT_EQ(calls, 2u) << "expected one call site per path:\n" << spec;

    size_t yields = 0;
    for (size_t i = spec.find("(Some (sum_next, st))"); i != std::string::npos;
         i = spec.find("(Some (sum_next, st))", i + 1))
        yields++;
    EXPECT_EQ(yields, 2u) << "a call site does not carry sum_next to the join:\n" << spec;

    // The definition is the part an empty body corrupts invisibly.  A Fixpoint
    // with no recursive call is not a loop.
    EXPECT_NE(defs.find("(vuln_loop_0_low"), std::string::npos)
        << "the Fixpoint has no recursive call -- its body was dropped:\n" << defs;
    EXPECT_NE(defs.find("sum_next := (wrap32 (sum + (i)))"), std::string::npos)
        << "the loop body is missing from the definition:\n" << defs;
}

/// A two-path preheader whose loop has two exits.
///
/// **This case currently fails**, at the same assert.  Adds the postheader's
/// exit selector: each call site has to destructure it and dispatch on it, and
/// the definition has to keep both exits.
TEST(IrTranslationSpec, LoopPreheaderOnTwoPathsMultiExit) {
    std::string spec, defs;
    ASSERT_NO_FATAL_FAILURE(expect_spec("loop_preheader_on_two_paths_multi_exit.ll", "vuln", {},
                                        &spec, /*run_cfg=*/true, &defs));
    EXPECT_EQ(count_of(spec, "vuln_loop_0_low"), 2u) << spec;
    EXPECT_EQ(count_of(spec, "v_0 =? (1)"), 2u)
        << "a call site does not dispatch on the exit selector:\n" << spec;
    EXPECT_NE(defs.find("big := (sum >? (100))"), std::string::npos)
        << "the early exit is missing from the definition:\n" << defs;
    EXPECT_NE(defs.find("(vuln_loop_0_low m i_next"), std::string::npos)
        << "the Fixpoint has no recursive call:\n" << defs;
}

/// Three paths into one preheader -- the arity ffm015 has.
///
/// **This case currently fails**, at the same assert.  Nothing in the fix is
/// meant to be arity-sensitive, but the loop's argument list and return list
/// are positional, so the two-path case cannot show that on its own.
TEST(IrTranslationSpec, LoopPreheaderOnThreePaths) {
    std::string spec, defs;
    ASSERT_NO_FATAL_FAILURE(expect_spec("loop_preheader_on_three_paths.ll", "vuln", {},
                                        &spec, /*run_cfg=*/true, &defs));
    EXPECT_EQ(count_of(spec, "vuln_loop_0_low"), 3u) << spec;
    EXPECT_EQ(count_of(spec, "(Some (sum_next, st))"), 3u)
        << "a call site does not carry sum_next to the join:\n" << spec;
    EXPECT_NE(defs.find("(vuln_loop_0_low m i_next"), std::string::npos)
        << "the Fixpoint has no recursive call:\n" << defs;
}

/// A two-path preheader one level down, inside another loop.
///
/// **This case currently fails**, at the same assert.  The duplication is
/// entirely inside the outer loop's definition -- the top-level spec enters the
/// outer loop once -- so every assertion here reads the definitions.  The inner
/// loop takes `acc` in from the outer header phi at both of its call sites.
TEST(IrTranslationSpec, LoopPreheaderOnTwoPathsNested) {
    std::string spec, defs;
    ASSERT_NO_FATAL_FAILURE(expect_spec("loop_preheader_on_two_paths_nested.ll", "vuln", {},
                                        &spec, /*run_cfg=*/true, &defs));
    EXPECT_EQ(count_of(spec, "vuln_loop_0_low"), 1u)
        << "the outer loop is entered on one path:\n" << spec;
    EXPECT_EQ(count_of(defs, "vuln_loop_1_low m 0 acc 0 0 st"), 2u)
        << "the inner loop is not called once per path with acc passed in:\n" << defs;
    EXPECT_NE(defs.find("(vuln_loop_0_low n m k_next"), std::string::npos)
        << "the outer Fixpoint has no recursive call:\n" << defs;
    EXPECT_NE(defs.find("(vuln_loop_1_low m i_next"), std::string::npos)
        << "the inner Fixpoint has no recursive call:\n" << defs;
}

/// Two independent loops, each entered on two paths.
///
/// **This case currently fails**, at the same assert.  Loop spec names are
/// handed out in first-touch order, so a duplicated entry that consumed a name
/// would renumber the second loop.
TEST(IrTranslationSpec, LoopPreheaderOnTwoPathsTwoLoops) {
    std::string spec, defs;
    ASSERT_NO_FATAL_FAILURE(expect_spec("loop_preheader_on_two_paths_two_loops.ll", "vuln", {},
                                        &spec, /*run_cfg=*/true, &defs));
    EXPECT_EQ(count_of(spec, "vuln_loop_0_low m 0 n 0 0 st"), 2u) << spec;
    EXPECT_EQ(count_of(spec, "vuln_loop_1_low m 0 r1 0 0 st"), 2u) << spec;
    EXPECT_NE(defs.find("(vuln_loop_0_low m i_next"), std::string::npos)
        << "the first Fixpoint has no recursive call:\n" << defs;
    EXPECT_NE(defs.find("(vuln_loop_1_low m j_next"), std::string::npos)
        << "the second Fixpoint has no recursive call:\n" << defs;
}

/* -- poison and undef vectors ------------------------------------------------ */

/// A vector built up from `poison`, which is what clang emits for `_mm_load_sd`
/// and its relatives.
///
/// **This case currently fails.** The poison operand becomes a symbol named
/// after the vector's width and nothing declares it, so the spec closes over a
/// name that does not exist:
///
///     let v0 := (poison_vector_2 # 0 == v_0) in
///
/// That is where snd014 now stops, after the vector type mapping was fixed:
///
///     [ERR]: Unknown symbol: poison_vector_2
///     Assertion `well_typed' failed.
///
/// A poison vector is an arbitrary value of its type, so the declaration spoq
/// should be making is the honest one -- the same treatment an indirect call's
/// spec and a float literal already get, rather than something a project has to
/// write out. `undef` takes the same path under `undef_vector_<n>`.
TEST(IrTranslationSpec, PoisonAndUndefVectorsAreDeclared) {
    std::string spec, defs;
    ASSERT_NO_FATAL_FAILURE(
        expect_spec("translate_poison_vector.ll", "vuln", {}, &spec, /*run_cfg=*/false, &defs));

    // The naming convention is what a declaration has to match.
    EXPECT_NE(spec.find("poison_vector_2"), std::string::npos) << spec;
    EXPECT_NE(spec.find("undef_vector_4"), std::string::npos) << spec;

    EXPECT_NE(defs.find("Parameter poison_vector_2 :"), std::string::npos)
        << "nothing declares the poison vector:\n" << defs;
    EXPECT_NE(defs.find("Parameter undef_vector_4 :"), std::string::npos)
        << "nothing declares the undef vector:\n" << defs;
}

/* -- agreement with the preprocessing passes --------------------------------- */

/// spoq and the preprocessing passes must name a type the same way, because a
/// `Parameter <fn>_spec` the passes emit is checked against a body spoq
/// translates.  They disagreed about vectors -- the passes said `UnknownType`,
/// which nothing defines -- and snd001 and snd014 died on it.
///
/// Both now go through the one traversal in include/llvm_coq_type.h, but they
/// build different things from it (a SpecType here, Coq text there), so the
/// agreement is a property to check rather than one the types enforce.  The
/// other half is ExtractBasics.VectorTypesMapToAZMap.
TEST(IrTranslationSpec, VectorTypeMatchesTheGeneratedSignature) {
    llvm::LLVMContext ctx;
    llvm::SMDiagnostic err;
    auto module = llvm::parseAssemblyString(
        "define <2 x double> @vuln(<2 x double> %v, <4 x float> %w, [4 x i32] %a) {\n"
        "entry:\n  ret <2 x double> %v\n}\n", err, ctx);
    ASSERT_TRUE(module) << "fixture did not parse";
    auto *f = module->getFunction("vuln");
    ASSERT_NE(f, nullptr);

    const auto coq = [](llvm::Type *t) {
        return std::string(*SpoqIRModule::llvm_ir_type_to_spec_pure(t));
    };
    EXPECT_EQ(coq(f->getArg(0)->getType()), "(ZMap.t Z)");
    EXPECT_EQ(coq(f->getArg(1)->getType()), "(ZMap.t Z)");
    // An array is the same shape: spoq drops the length that ExtractBasics
    // keeps in a record field, and the signature side agrees with spoq.
    EXPECT_EQ(coq(f->getArg(2)->getType()), "(ZMap.t Z)");
}

/// An integer's LLVM width reaches the spec type.
///
/// The LLVM type is the only place the width exists, so SpecTypeOf::integer
/// must carry it through.  Everything that reduces a value to its width reads
/// it from here -- wrapN, unsN, the range relies, the bitvector sorts -- so
/// this pins that it survives.  The Coq name is "Z" at every width.
TEST(IrTranslationSpec, IntegerTypesCarryTheirWidth) {
    llvm::LLVMContext ctx;
    llvm::SMDiagnostic err;
    auto module = llvm::parseAssemblyString(
        "define i32 @vuln(i8 %a, i32 %b, i64 %c, i1 %d) {\n"
        "entry:\n  ret i32 %b\n}\n", err, ctx);
    ASSERT_TRUE(module) << "fixture did not parse";
    auto *f = module->getFunction("vuln");
    ASSERT_NE(f, nullptr);

    const auto bits = [](llvm::Type *t) {
        auto const i = dynamic_pointer_cast<Int>(SpoqIRModule::llvm_ir_type_to_spec_pure(t));
        return i ? (int)i->bits : -1;
    };
    EXPECT_EQ(bits(f->getArg(0)->getType()), 8);
    EXPECT_EQ(bits(f->getArg(1)->getType()), 32);
    EXPECT_EQ(bits(f->getArg(2)->getType()), 64);
    // i1 is a Bool, not a one-bit Int.
    EXPECT_EQ(bits(f->getArg(3)->getType()), -1);
    EXPECT_EQ(std::string(*SpoqIRModule::llvm_ir_type_to_spec_pure(f->getArg(1)->getType())), "Z");
    // Interned, so a width costs no more to pass around than the singleton.
    EXPECT_EQ(Int::of_width(32), Int::of_width(32));
    EXPECT_EQ(Int::of_width(0), Int::INT);
}

/* -- calls through a function pointer --------------------------------------- */

/// An indirect call becomes a call to a spec named after the pointer, its
/// argument count and the calling function: `<ptr>_<argc>_fptr_<caller>_spec`,
/// applied to the pointer itself followed by the arguments and the state.
///
/// Translation succeeds. Nothing defines that spec, though -- it is a name the
/// project is expected to supply, as `ext_spec` is for an external declaration
/// -- so a full run stops at `unknown expr op`, which is where ffm054 now ends:
///
///     unknown expr op (v_37_5_fptr_decode_unit_vuln_spec v_37 gb1 rc2 ...)
///
/// The convention is pinned here because it is the interface a project has to
/// write against: change the shape of this name and every hand-written function
/// pointer spec stops matching, with no error until z3_eval.
TEST(IrTranslationSpec, FptrCallNamesThePointer) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_fptr_call.ll", "vuln", {}, &spec));
    EXPECT_NE(spec.find("(fp_1_fptr_vuln_spec fp n st)"), std::string::npos)
        << "the synthesised name or its arguments changed:\n" << spec;
}
