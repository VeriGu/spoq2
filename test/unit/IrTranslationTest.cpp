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

#include <cctype>
#include <csignal>
#include <cstdlib>
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
                                      std::string *out_spec, bool run_cfg = false) {
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

        SpoqIRContext context(spoq_func, proj->layers[0], 0, proj->abs_config, proj->abs_layout);
        auto spec = proj->spoq_code.spoq_inst_to_spec(proj.get(), spoq_func.spoq_insts, 0, context);
        if (!spec) return kReturnedFalse;
        if (out_spec) *out_spec = std::string(*spec);

        // The spec may name its own arguments and the state, and nothing else.
        // This is what check_well_typed asserts once a Definition exists; here
        // there is no Definition yet, so seed the same set by hand.
        std::set<std::string> free;
        free_vars(proj.get(), spec.get(), free);
        free.erase("st");
        for (auto const &arg : func->args()) free.erase(arg.getName().str());
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
                            std::string *out_spec = nullptr, bool run_cfg = false) {
    llvm::LLVMContext ctx;
    llvm::SMDiagnostic err;
    return run_to_spec_of_module(llvm::parseIRFile(path, err, ctx), func_name, stack_vars,
                                 out_spec, run_cfg);
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

/// Stage 2 in a child, with the printed SpecNode piped back (truncated).
Outcome spec_with_deadline(const std::string &path, const std::string &func_name,
                           const std::map<std::string, std::string> &stack_vars,
                           std::string *out_spec, bool run_cfg = false) {
    constexpr size_t kMaxSpec = 8192;
    int pipefd[2];
    if (pipe(pipefd) != 0) return Outcome{false, true, 0, 0};

    const pid_t pid = fork();
    if (pid == 0) {
        close(pipefd[0]);
        std::string spec;
        const TranslateStatus st = run_to_spec(path, func_name, stack_vars, &spec, run_cfg);
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
                 std::string *out_spec = nullptr, bool run_cfg = false) {
    std::string spec;
    const Outcome out = spec_with_deadline(data(file), func_name, stack_vars, &spec, run_cfg);
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

// Three predecessors: not a reconvergence of one If, so each phi is resolved
// against the edge the walk arrived on and emitted as its own `let`.  This is
// the path where sequential bindings really are sequential.
TEST(IrTranslation, MultiplePhisAtAThreeWayJoin) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(
        expect_spec("translate_multi_phi_three_preds.ll", "vuln", {}, &spec));

    // The spec is pretty-printed with per-depth indentation, and these three
    // bindings sit at three different depths, so compare with whitespace
    // collapsed rather than pinning the layout.
    std::string flat;
    for (char ch : spec) {
        if (std::isspace(static_cast<unsigned char>(ch))) {
            if (!flat.empty() && flat.back() != ' ') flat += ' ';
        } else {
            flat += ch;
        }
    }

    struct Edge { const char *u, *v, *w; };
    // %w crosses over: a1's second value, a2's first, a3's second.
    for (const Edge e : {Edge{"p", "q", "q"}, Edge{"r2", "s2", "r2"}, Edge{"r3", "s3", "s3"}}) {
        const std::string want = std::string("let u := ") + e.u + " in let v := " + e.v +
                                 " in let w := " + e.w + " in";
        EXPECT_NE(flat.find(want), std::string::npos)
            << "no path binds u/v/w as " << e.u << "/" << e.v << "/" << e.w
            << ", so a phi was resolved against the wrong edge:\n" << spec;
    }
    EXPECT_EQ(spec.find("phi"), std::string::npos) << "a phi survived:\n" << spec;
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

/* -- joins that merge a loop exit with a path that skipped the loop ---------- */

/// A join phi whose loop-side value is defined *inside* the loop body, rather
/// than being the header phi itself.
///
/// **This case currently fails.** Kept as the fix target.
///
/// `bind_loop_results` binds each header phi and pass-in value to its `_after`
/// name on the way out of the loop, which covers a join phi that takes the
/// carried value. It does not cover one that takes the backedge *source*: here
/// the phi takes `%add`, defined in the body, so the emitted spec ends
///
///     let baseline_08 := baseline_08_after in
///     let baseline_0_lcssa := add in
///
/// with nothing binding `add`. Running loops unrolled (`SPOQ_CFG_CLONE_JOINS=1`)
/// gives the skipping path its own copy and does not hit it.
///
/// This is the translation failure behind lua002 (`luaG_getfuncline`), where it
/// aborts the whole run in `check_well_typed` with `Unknown symbol: add`.
TEST(IrTranslationSpec, LoopExitJoinBindsBodyValue) {
    expect_spec("loop_exit_join_body_value.ll", "vuln", {}, nullptr, /*run_cfg=*/true);
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
/// **This case currently fails**: `%sum` is left free, exactly as `%add` is in
/// the single-exit case.
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

/// `sitofp i32 -> double` and back. The prelude defines `Float := Z`, so both
/// casts are no-ops on the spec side.
TEST(IrTranslationSpec, SitofpToDouble) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_sitofp_double.ll", "vuln", {}, &spec));
    EXPECT_NE(spec.find("let conv := n in"), std::string::npos) << spec;
    EXPECT_NE(spec.find("let back := conv in"), std::string::npos) << spec;
}

/// The same round trip through a 32-bit float. Float is one type in the spec
/// language -- a 64-bit FPA -- so the width does not reach the translation, and
/// this must come out identical to the double.
TEST(IrTranslationSpec, SitofpToFloat) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_sitofp_float.ll", "vuln", {}, &spec));
    EXPECT_NE(spec.find("let conv := n in"), std::string::npos) << spec;
    EXPECT_NE(spec.find("let back := conv in"), std::string::npos) << spec;
}

/// Arithmetic between the two casts, with a floating point literal.  Under
/// `Float := Z` this is integer arithmetic, and prints as such.
TEST(IrTranslationSpec, FloatArithmetic) {
    std::string spec;
    ASSERT_NO_FATAL_FAILURE(expect_spec("translate_float_arithmetic.ll", "vuln", {}, &spec));
    EXPECT_NE(spec.find("let mul := (conv * ("), std::string::npos) << spec;
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
