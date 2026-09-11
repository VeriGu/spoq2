/* Unit tests for SpoqIRModule::control_flow_conversion_v2.
 *
 * The conversion is a static function over a single llvm::Function, so it can be
 * driven directly from an .ll file -- no project, no main.v, no solver.  That
 * matters for two reasons: these cases run in milliseconds instead of minutes,
 * and a failure points at the CFG pass rather than at anything downstream.
 *
 * Each case runs in a forked child with a deadline.  A traversal bug in this
 * pass shows up as non-termination, and a hung child would otherwise take the
 * whole suite with it; forking lets the parent kill it and report a normal
 * failure.  It also isolates the assert()s and exceptions the pass can raise.
 *
 * The binary doubles as an oracle for llvm-reduce:
 *
 *     CfgConversionTest --convert <file.ll> <function>
 *       exit 0  converted
 *       exit 2  reported failure (returned false)
 *       exit 3  threw
 *       exit 4  could not parse / no such function
 *     (a hang is observed by the caller's own `timeout`)
 */

#include <gtest/gtest.h>

#include <csignal>
#include <cstdlib>
#include <functional>
#include <string>
#include <sys/wait.h>
#include <unistd.h>

#include "llvm/AsmParser/Parser.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"

#include "cmd.h"
#include "SpoqIRModule.h"

/* main.cpp is not linked into this binary, so its globals live here instead. */
SpoqOption OPTS;

using namespace autov;

namespace {

// Long enough to outlast the exponential-cloning guard: the ffm001 case needs
// ~255s to reach it.  A shorter deadline reports a hang where there is none --
// which is exactly how these two cases were first mis-diagnosed.
constexpr int kDeadlineSeconds = 300;

enum ConvertStatus { kConverted = 0, kReportedFailure = 2, kThrew = 3, kBadInput = 4 };

/// Run the CFG conversion in this process and report how it ended.
ConvertStatus run_conversion(const std::string &path, const std::string &func_name) {
    llvm::LLVMContext ctx;
    llvm::SMDiagnostic err;
    auto module = llvm::parseIRFile(path, err, ctx);
    if (!module) return kBadInput;

    auto *func = module->getFunction(func_name);
    if (!func || func->isDeclaration()) return kBadInput;

    SpoqFunction spoq_func;
    spoq_func.llvm_func = func;
    try {
        return SpoqIRModule::control_flow_conversion_v2(func_name, spoq_func) ? kConverted
                                                                              : kReportedFailure;
    } catch (const std::exception &e) {
        // Surfaced on stderr so the parent's failure message names the reason;
        // the exit code alone cannot carry it across the fork.
        llvm::errs() << "control_flow_conversion_v2 threw: " << e.what() << "\n";
        return kThrew;
    }
}

struct Outcome {
    bool timed_out = false;
    bool crashed = false;
    int status = 0;
};

/// Run [body] in a child so a non-terminating traversal can be killed, and so
/// its assert()s and exceptions cannot take the suite with it.  The child's
/// return value becomes the exit status, which is why ConvertStatus is small.
Outcome run_with_deadline(const std::function<int()> &body) {
    pid_t pid = fork();
    if (pid == 0) {
        _exit(body());
    }

    for (int elapsed = 0; elapsed < kDeadlineSeconds * 10; elapsed++) {
        int status = 0;
        const pid_t done = waitpid(pid, &status, WNOHANG);
        if (done == pid) {
            Outcome out;
            if (WIFEXITED(status)) out.status = WEXITSTATUS(status);
            else out.crashed = true;
            return out;
        }
        usleep(100000);
    }

    kill(pid, SIGKILL);
    waitpid(pid, nullptr, 0);
    return Outcome{/*timed_out=*/true, /*crashed=*/false, /*status=*/0};
}

Outcome convert_with_deadline(const std::string &path, const std::string &func_name) {
    return run_with_deadline([&] { return run_conversion(path, func_name); });
}

std::string data(const std::string &name) {
    return std::string(SPOQ_LL_DIR) + "/" + name;
}

/// Assert the pass terminates and converts [func_name] in [file].
void expect_converts(const std::string &file, const std::string &func_name) {
    const Outcome out = convert_with_deadline(data(file), func_name);
    ASSERT_FALSE(out.timed_out) << file << ": control_flow_conversion_v2 did not terminate on '"
                                << func_name << "' within " << kDeadlineSeconds << "s";
    ASSERT_FALSE(out.crashed) << file << ": crashed converting '" << func_name << "'";
    ASSERT_NE(out.status, kBadInput) << file << ": could not parse, or no such function '"
                                     << func_name << "'";
    EXPECT_NE(out.status, kThrew) << file << ": threw converting '" << func_name << "'";
    EXPECT_EQ(out.status, kConverted) << file << ": reported failure converting '" << func_name << "'";
}

/* -- sanity: a plain nested loop must convert -------------------------------- */

TEST(CfgConversion, NestedLoopConverts) { expect_converts("nested_loop.ll", "vuln"); }

/* -- exponential block cloning in control_flow_clone_and_split --------------- */
// control_flow_clone_and_split removes a join phi by cloning the diamond that
// produced it, which duplicates everything downstream.  Its own comment gives
// the cost: 2^N blocks for N diamonds in sequence.  It does not hang -- it runs
// until the "block size too large in fn vuln" guard (repeats > 10000000) throws,
// which takes long enough that any ordinary timeout makes it look like a hang.
// That is how both cases below were first mis-diagnosed.
//
// STILL FAILING.  sws_init_context_vuln (254 blocks) from ffmpeg ffm001 reaches
// the guard in ~255s, dominated by SpoqLoopContext::travel, which update_jump
// re-runs over the growing CFG after every clone.  Its 197 selects no longer
// contribute (see SingleBlockConverts below); what remains is 91 blocks with two
// or more predecessors.  That is the quantity that matters -- require_split
// (SpoqIRModule.h:275) ends in `pred_size(bb) >= 2` and never looks at phis, so
// only 40 of those 91 carry one.  At 2^(N+2)-4 clone steps for N join points
// (see JoinScaling below) 91 of them is ~2^93 steps: no budget reaches it, and
// fixing it means splitting join points without duplicating what follows them.
TEST(CfgConversion, Ffm001SwsInitContextConverts) {
    expect_converts("ffm001_sws_init_context.ll", "vuln");
}

/* -- regression: selects must not be expanded into diamonds ------------------ */
// A single basic block, 51 selects, no phi nodes of its own -- so every diamond
// it used to produce came from a select.  It took ~26s to hit the same guard
// while control_flow_conversion_v2 still ran Phase 1
// (control_flow_eliminate_select), which rewrote each select into a diamond with
// a join phi.  Selects are now translated directly to an If node by
// spoq_inst_to_spec (SpoqIRTranslator.cpp), Phase 1 is no longer called, and no
// phi is introduced for anything to clone away: this converts in ~0.1s.
//
// It is kept as the cheap guard on that: a case with no phi sources other than
// selects fails here if select expansion ever comes back.  Degenerate module
// (llvm-reduce nulled the call targets), so it is only useful for the CFG pass.
TEST(CfgConversion, SingleBlockConverts) {
    expect_converts("ffm001_single_block_valuename.ll", "vuln");
}

/* -- how the cost scales with the number of join points ---------------------- */
//
// Two series over the same input, N diamonds in sequence:
//
//   ConvertsWithoutCloning         the default path, where a join costs nothing.
//   CloningCostIsTwoToTheNPlusTwo  SPOQ_CFG_CLONE_JOINS=1, where Phase 3b clones
//                                  each join and everything downstream of it.
//
// The cloning cost is not merely "exponential" but exactly
//
//     clone steps(N) = 2^(N+2) - 4
//
// for N sequential join points.  Measured, not derived: bisecting
// SPOQ_CFG_REPEAT_LIMIT for N = 1..18 gives 4, 12, 28, 60, 124, 252, 508, 1020,
// ... , 1048572, a ratio of 2.000 from N = 12 up.  The default budget of 10^7
// steps runs out from N = 22 on; N = 21 is the largest that converts that way,
// taking ~27s and 4.2GB.  sws_init_context_vuln has 91 join points, over budget
// by ~2^71, which no budget increase reaches.
//
// The cloning series runs under a lowered budget, so it costs a couple of
// seconds regardless of N -- the budget, not N, caps the work.  That shortcut
// is sound only because the cost of this particular input is known
// analytically.  A lowered budget is NOT a general test for the blowup:
// sws_setColorspaceDetails (48 blocks) genuinely converts and needs ~5*10^5
// steps, so a budget below that would call a healthy function broken.
//
// What counts is join points, not phi nodes: require_split
// (SpoqIRModule.h:275) ends in `pred_size(bb) >= 2` and never looks at phis.
// PhiNodesDoNotChangeTheCost pins that.

constexpr long kScalingBudget = 100000;

/// Clone steps control_flow_clone_and_split needs for [joins] sequential join
/// points.  Exact; see above.
constexpr long clone_steps_for(int joins) { return (1L << (joins + 2)) - 4; }

/// N diamonds in sequence, i.e. N join points.  Mirrors gen_join_chain.py.
std::string join_chain_ir(int joins, bool with_phis = false) {
    std::string ir = "define dso_local i32 @vuln(i32 %x) {\n"
                     "entry:\n"
                     "  %c0 = icmp eq i32 %x, 0\n"
                     "  br i1 %c0, label %t0, label %f0\n";
    for (int i = 0; i < joins; i++) {
        const std::string n = std::to_string(i);
        const std::string merge = (i + 1 < joins) ? "m" + std::to_string(i + 1) : "exit";
        ir += "t" + n + ":\n  br label %" + merge + "\n";
        ir += "f" + n + ":\n  br label %" + merge + "\n";
        if (i + 1 < joins) {
            const std::string m = std::to_string(i + 1);
            ir += "m" + m + ":\n";
            if (with_phis)
                ir += "  %p" + m + " = phi i32 [ " + n + ", %t" + n + " ], [ 1" + n +
                      ", %f" + n + " ]\n";
            ir += "  %c" + m + " = icmp eq i32 %x, " + m + "\n";
            ir += "  br i1 %c" + m + ", label %t" + m + ", label %f" + m + "\n";
        }
    }
    return ir + "exit:\n  ret i32 0\n}\n";
}

/// Convert [ir] under a lowered clone budget, optionally with join cloning
/// switched back on.  Both are set here rather than by the caller because the
/// pass caches them in function-local statics on first use -- they must be in
/// the environment before any conversion runs in this process, which the fork
/// guarantees.
ConvertStatus run_conversion_of_ir(const std::string &ir, long budget, bool clone_joins = false) {
    setenv("SPOQ_CFG_REPEAT_LIMIT", std::to_string(budget).c_str(), /*overwrite=*/1);
    if (clone_joins) setenv("SPOQ_CFG_CLONE_JOINS", "1", /*overwrite=*/1);
    else unsetenv("SPOQ_CFG_CLONE_JOINS");

    llvm::LLVMContext ctx;
    llvm::SMDiagnostic err;
    auto module = llvm::parseAssemblyString(ir, err, ctx);
    if (!module) return kBadInput;

    auto *func = module->getFunction("vuln");
    if (!func || func->isDeclaration()) return kBadInput;

    SpoqFunction spoq_func;
    spoq_func.llvm_func = func;
    try {
        return SpoqIRModule::control_flow_conversion_v2("vuln", spoq_func) ? kConverted
                                                                          : kReportedFailure;
    } catch (const std::exception &e) {
        llvm::errs() << "control_flow_conversion_v2 threw: " << e.what() << "\n";
        return kThrew;
    }
}

class JoinScaling : public testing::TestWithParam<int> {};

// N join points cost nothing, for every N.
//
// The budget is one clone step, which is what makes this sharp rather than just
// fast: cloning even a single join point calls control_flow_clone_and_split
// more than once and throws, so this cannot pass by merely being quicker.
TEST_P(JoinScaling, ConvertsWithoutCloning) {
    const int joins = GetParam();

    const Outcome out = run_with_deadline(
            [&] { return run_conversion_of_ir(join_chain_ir(joins), /*budget=*/1); });

    ASSERT_FALSE(out.timed_out) << joins << " join points: did not terminate";
    ASSERT_FALSE(out.crashed) << joins << " join points: crashed";
    ASSERT_NE(out.status, kBadInput) << joins << " join points: generated IR did not parse";
    EXPECT_EQ(out.status, kConverted)
            << joins << " join points did not convert within a one-step clone budget, so "
                        "something is cloning join points, which costs 2^(N+2)-4";
}

// Exactly 2^(N+2)-4 with cloning switched on.  Kept executable rather than
// written down, so the figure above cannot rot.
TEST_P(JoinScaling, CloningCostIsTwoToTheNPlusTwo) {
    const int joins = GetParam();
    const long steps = clone_steps_for(joins);
    const bool should_fit = steps <= kScalingBudget;

    const Outcome out = run_with_deadline([&] {
        return run_conversion_of_ir(join_chain_ir(joins), kScalingBudget, /*clone_joins=*/true);
    });

    ASSERT_FALSE(out.timed_out) << joins << " join points: did not terminate";
    ASSERT_FALSE(out.crashed) << joins << " join points: crashed";
    ASSERT_NE(out.status, kBadInput) << joins << " join points: generated IR did not parse";

    // The prediction is two-sided on purpose.  Asserting only that large N
    // blows up would still pass if the cost were 3^N or N!; requiring the
    // smaller cases to fit inside the budget is what pins the base to 2.
    if (should_fit) {
        EXPECT_EQ(out.status, kConverted)
                << joins << " join points should need " << steps << " clone steps, which fits in "
                << kScalingBudget << " -- exhausting the budget means the cost grew faster than "
                                     "2^(N+2)";
    } else {
        EXPECT_EQ(out.status, kThrew)
                << joins << " join points should need " << steps << " clone steps, over the "
                << kScalingBudget << " budget -- converting means cloning got cheaper than "
                                     "2^(N+2), or SPOQ_CFG_CLONE_JOINS no longer enables it";
    }
}

INSTANTIATE_TEST_SUITE_P(OneToThirty, JoinScaling, testing::Range(1, 31),
                         [](const testing::TestParamInfo<int> &i) {
                             return std::to_string(i.param) + "Joins";
                         });

// Phis are irrelevant to the cloning cost: the split is on predecessor count
// alone.  Checked at the budget boundary, where a change of even one clone step
// in either direction flips the verdict.
TEST(CfgConversion, PhiNodesDoNotChangeTheCost) {
    const int last_fitting = 14;  // steps(14) = 65532 <= 100000 < 131068 = steps(15)
    ASSERT_LE(clone_steps_for(last_fitting), kScalingBudget);
    ASSERT_GT(clone_steps_for(last_fitting + 1), kScalingBudget);

    for (const bool phis : {false, true}) {
        const Outcome fits = run_with_deadline([&] {
            return run_conversion_of_ir(join_chain_ir(last_fitting, phis), kScalingBudget,
                                        /*clone_joins=*/true);
        });
        const Outcome over = run_with_deadline([&] {
            return run_conversion_of_ir(join_chain_ir(last_fitting + 1, phis), kScalingBudget,
                                        /*clone_joins=*/true);
        });
        EXPECT_EQ(fits.status, kConverted) << "phis=" << phis << " changed the cost at N="
                                          << last_fitting;
        EXPECT_EQ(over.status, kThrew) << "phis=" << phis << " changed the cost at N="
                                       << last_fitting + 1;
    }
}

}  // namespace

int main(int argc, char **argv) {
    // Oracle mode for llvm-reduce: do the conversion in-process and report via
    // the exit code.  Kept before InitGoogleTest so the flags do not collide.
    if (argc >= 4 && std::string(argv[1]) == "--convert") {
        return run_conversion(argv[2], argv[3]);
    }
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
