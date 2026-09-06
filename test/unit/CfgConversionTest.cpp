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
#include <string>
#include <sys/wait.h>
#include <unistd.h>

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
// ~228s to reach it.  A shorter deadline reports a hang where there is none --
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

/// Run the conversion in a child so a non-terminating traversal can be killed.
Outcome convert_with_deadline(const std::string &path, const std::string &func_name) {
    pid_t pid = fork();
    if (pid == 0) {
        _exit(run_conversion(path, func_name));
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

std::string data(const std::string &name) {
    return std::string(SPOQ_CFG_DIR) + "/" + name;
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
// Both cases below blow up the same way and die on the same guard
//   ("block size too large in fn vuln", repeats > 10000000).
// Neither actually hangs; they just take long enough (~228s and ~26s) that any
// ordinary timeout makes them look like they do.  They are kept as two cases
// because they cost very different amounts to run and stress different parts
// of the blowup -- the large one the traversal, the small one value naming.

// Real input: sws_init_context_vuln (254 blocks) from ffmpeg ffm001.
// ~228s to the guard, dominated by SpoqLoopContext::travel, which update_jump
// re-runs over the growing CFG after every clone.
TEST(CfgConversion, Ffm001SwsInitContextConverts) {
    expect_converts("ffm001_sws_init_context.ll", "vuln");
}

// Reduced input: a single basic block, ~26s to the same guard.  Reaches it
// ~9x faster, so it is the cheaper case to iterate against while fixing the
// blowup.  Degenerate module (llvm-reduce nulled the call targets).
TEST(CfgConversion, SingleBlockConverts) {
    expect_converts("ffm001_single_block_valuename.ll", "vuln");
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
