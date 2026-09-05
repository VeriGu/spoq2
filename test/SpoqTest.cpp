/* GoogleTest driver for the spoq regression tests.
 *
 * A test case is three files sharing a stem, anywhere under the test tree:
 *
 *     <test>.ll             the module under analysis
 *     <test>.main.v         the spoq configuration, self-contained
 *     <test>.expected.json  the fields of spoq's result JSON that are pinned
 *
 * Each case is assembled in its own scratch directory -- the .ll is assembled
 * to the .bc that <test>.main.v's PROJ_BC_PATH names -- spoq is run there, and
 * the keys present in the expected file are compared against the result.  Keys
 * absent from the expected file (timings, leaf counts) are ignored, so only the
 * semantic verdict is pinned.
 *
 * Cases are discovered at run time and registered individually, so
 * `ctest`/`--gtest_filter` can select them and a new triple of files needs no
 * build-system change.  SPOQ_BINARY and SPOQ_TEST_DIR are baked in by CMake so
 * the tests always exercise the executable that was just built.
 */

#include <gtest/gtest.h>

#include <array>
#include <cstdio>
#include <filesystem>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

#include <boost/property_tree/json_parser.hpp>
#include <boost/property_tree/ptree.hpp>

#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FileSystem.h"

namespace fs = std::filesystem;

namespace {

/// Seconds any single spoq invocation is allowed to take.
constexpr int kTimeoutSeconds = 300;

/// Set SPOQ_TEST_KEEP=1 to keep every scratch directory, pass or fail.
bool keepScratchDirs() {
    static const bool keep = std::getenv("SPOQ_TEST_KEEP") != nullptr;
    return keep;
}

/// Kept directories, in completion order, for the end-of-run summary.
std::vector<std::pair<std::string, std::string>> &keptDirs() {
    static std::vector<std::pair<std::string, std::string>> dirs;
    return dirs;
}

/// Where the summary is also written, so the paths survive a harness that
/// captures stdout -- ctest hides the output of a *passing* test unless run with
/// -V, which is precisely when these paths are wanted.
std::string keptListPath() {
    const char *tmp = std::getenv("TMPDIR");
    return std::string(tmp ? tmp : "/tmp") + "/spoq-test-kept.txt";
}

struct TestCase {
    std::string stem;
    fs::path ll;
    fs::path main_v;
    fs::path expected;
};

std::vector<TestCase> discover() {
    std::vector<TestCase> cases;
    const fs::path root(SPOQ_TEST_DIR);
    if (!fs::exists(root)) return cases;

    for (const auto &entry : fs::recursive_directory_iterator(root)) {
        if (!entry.is_regular_file()) continue;
        const std::string name = entry.path().filename().string();
        const std::string suffix = ".expected.json";
        if (name.size() <= suffix.size() ||
            name.compare(name.size() - suffix.size(), suffix.size(), suffix) != 0)
            continue;

        TestCase tc;
        tc.stem = name.substr(0, name.size() - suffix.size());
        tc.expected = entry.path();
        tc.ll = entry.path().parent_path() / (tc.stem + ".ll");
        tc.main_v = entry.path().parent_path() / (tc.stem + ".main.v");
        if (fs::exists(tc.ll) && fs::exists(tc.main_v)) cases.push_back(std::move(tc));
    }

    std::sort(cases.begin(), cases.end(),
              [](const TestCase &a, const TestCase &b) { return a.stem < b.stem; });
    return cases;
}

/// Assemble [ll] to bitcode at [bc].  Done in process so the bitcode always
/// matches the LLVM spoq itself was linked against.
::testing::AssertionResult assemble(const fs::path &ll, const fs::path &bc) {
    llvm::LLVMContext ctx;
    llvm::SMDiagnostic err;
    auto module = llvm::parseIRFile(ll.string(), err, ctx);
    if (!module) {
        std::string msg;
        llvm::raw_string_ostream os(msg);
        err.print("SpoqTest", os);
        return ::testing::AssertionFailure() << "could not parse " << ll << ": " << msg;
    }

    std::error_code ec;
    llvm::raw_fd_ostream out(bc.string(), ec, llvm::sys::fs::OF_None);
    if (ec)
        return ::testing::AssertionFailure()
               << "could not open " << bc << ": " << ec.message();

    llvm::WriteBitcodeToFile(*module, out);
    out.flush();
    return ::testing::AssertionSuccess();
}

struct RunResult {
    int status = -1;
    std::string output;
};

RunResult run(const std::string &command) {
    RunResult result;
    FILE *pipe = popen(command.c_str(), "r");
    if (!pipe) return result;

    std::array<char, 4096> buffer{};
    while (std::fgets(buffer.data(), buffer.size(), pipe) != nullptr)
        result.output += buffer.data();

    const int status = pclose(pipe);
    result.status = (status == -1) ? -1 : (WIFEXITED(status) ? WEXITSTATUS(status) : 128);
    return result;
}

/// Read a flat JSON object into key -> textual value.  Everything is compared as
/// text, which is enough for the booleans and numbers these results contain and
/// keeps the two sides from disagreeing over formatting.
::testing::AssertionResult readJson(const fs::path &path, const std::string &text,
                                    boost::property_tree::ptree &out) {
    try {
        if (text.empty()) {
            boost::property_tree::read_json(path.string(), out);
        } else {
            std::istringstream in(text);
            boost::property_tree::read_json(in, out);
        }
    } catch (const std::exception &e) {
        return ::testing::AssertionFailure() << "could not parse JSON from "
                                             << (text.empty() ? path.string() : text)
                                             << ": " << e.what();
    }
    return ::testing::AssertionSuccess();
}

std::vector<std::string> splitSemi(const std::string &text) {
    std::vector<std::string> out;
    std::string item;
    std::istringstream in(text);
    while (std::getline(in, item, ';'))
        if (!item.empty()) out.push_back(item);
    return out;
}

/// The text of `Definition <name> ...` up to the next blank line, from whichever
/// generated Spec.v under [work] defines it (cached copies are skipped).
std::string findDefinitionBody(const fs::path &work, const std::string &name) {
    const std::string head = "Definition " + name + " ";
    for (const auto &entry : fs::recursive_directory_iterator(work)) {
        if (!entry.is_regular_file() || entry.path().filename() != "Spec.v") continue;
        if (entry.path().string().find(".CachedSpec") != std::string::npos) continue;
        std::ifstream in(entry.path());
        std::string line, body;
        bool inside = false;
        while (std::getline(in, line)) {
            if (!inside) {
                if (line.find(head) != std::string::npos) { inside = true; body = line + "\n"; }
            } else {
                if (line.find_first_not_of(" \t\r") == std::string::npos) return body;
                body += line + "\n";
            }
        }
        if (inside) return body;
    }
    return "";
}

void runCase(const TestCase &tc) {
    const fs::path work =
        fs::temp_directory_path() / ("spoq-test-" + tc.stem + "-" + std::to_string(::getpid()));
    fs::remove_all(work);
    fs::create_directories(work / "z3");

    struct Cleanup {
        fs::path dir;
        std::string stem;
        ~Cleanup() {
            if (!keepScratchDirs()) {
                fs::remove_all(dir);
                return;
            }
            // gtest-style tag, and on stdout with the rest of the run, so the
            // line is unambiguously attributed rather than looking like it
            // belongs to whichever test just finished.
            std::printf("[ KEPT     ] Spoq.%s -> %s\n", stem.c_str(), dir.c_str());
            std::fflush(stdout);
            keptDirs().emplace_back(stem, dir.string());
        }
    } cleanup{work, tc.stem};

    fs::copy_file(tc.main_v, work / (tc.stem + ".main.v"),
                  fs::copy_options::overwrite_existing);
    ASSERT_TRUE(assemble(tc.ll, work / (tc.stem + ".bc")));

    std::ostringstream cmd;
    cmd << "cd " << work << " && timeout " << kTimeoutSeconds << " " << SPOQ_BINARY << " "
        << tc.stem << ".main.v"
        << " --new-trans --llvm --no-profile --check-patch-refinement --check-pre-post"
        << " --query-path " << work / "z3" << "/ 2>" << work / "stderr.log";

    const RunResult run_result = run(cmd.str());
    if (run_result.status != 0) {
        std::string detail;
        std::ifstream log(work / "stderr.log");
        for (std::string line; std::getline(log, line);)
            if (line.find("what()") != std::string::npos ||
                line.find("[ERR]") != std::string::npos)
                detail = line;
        FAIL() << "spoq exited " << run_result.status
               << (run_result.status == 124 ? " (timed out)" : "")
               << (detail.empty() ? "" : "\n  " + detail);
    }

    std::istringstream out(run_result.output);
    std::string first_line;
    std::getline(out, first_line);
    ASSERT_FALSE(first_line.empty()) << "spoq produced no result JSON";

    boost::property_tree::ptree actual, expected;
    ASSERT_TRUE(readJson(tc.ll, first_line, actual));
    ASSERT_TRUE(readJson(tc.expected, "", expected));

    for (const auto &[key, value] : expected) {
        if (key.rfind("spec_v_", 0) == 0) continue;  // structural, checked below
        const auto found = actual.get_optional<std::string>(key);
        EXPECT_TRUE(found.has_value()) << "result has no key '" << key << "'";
        if (found) EXPECT_EQ(*found, value.get_value<std::string>()) << "for key '" << key << "'";
    }

    // Optional structural assertions against the generated Coq spec.  The result
    // JSON says whether a proof went through; it cannot say *how* the spec was
    // produced -- e.g. that a callee the proof did not need was left as a call
    // rather than unfolded.  Keys in .expected.json:
    //   spec_v_definition   the Definition whose body is inspected
    //   spec_v_contains     ';'-separated substrings that must appear in it
    //   spec_v_lacks        ';'-separated substrings that must not
    if (const auto def = expected.get_optional<std::string>("spec_v_definition")) {
        const std::string body = findDefinitionBody(work, *def);
        ASSERT_FALSE(body.empty()) << "no 'Definition " << *def << "' found in any generated Spec.v";
        for (const auto &s : splitSemi(expected.get<std::string>("spec_v_contains", "")))
            EXPECT_NE(body.find(s), std::string::npos)
                << "'" << s << "' missing from " << *def << ":\n" << body;
        for (const auto &s : splitSemi(expected.get<std::string>("spec_v_lacks", "")))
            EXPECT_EQ(body.find(s), std::string::npos)
                << "'" << s << "' unexpectedly present in " << *def << ":\n" << body;
    }
}

}  // namespace

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);

    const auto cases = discover();
    if (cases.empty()) {
        std::fprintf(stderr, "no test cases found under %s\n", SPOQ_TEST_DIR);
        return 1;
    }

    for (const auto &tc : cases) {
        ::testing::RegisterTest(
            "Spoq", tc.stem.c_str(), nullptr, nullptr, __FILE__, __LINE__,
            [tc]() -> ::testing::Test * {
                struct Case : public ::testing::Test {
                    TestCase tc;
                    explicit Case(TestCase tc) : tc(std::move(tc)) {}
                    void TestBody() override { runCase(tc); }
                };
                return new Case(tc);
            });
    }

    const int status = RUN_ALL_TESTS();

    if (keepScratchDirs() && !keptDirs().empty()) {
        std::printf("\n[ KEPT     ] %zu scratch director%s (SPOQ_TEST_KEEP is set):\n",
                    keptDirs().size(), keptDirs().size() == 1 ? "y" : "ies");
        for (const auto &[stem, dir] : keptDirs())
            std::printf("             %-28s %s\n", stem.c_str(), dir.c_str());

        const std::string list = keptListPath();
        if (std::ofstream out(list); out) {
            for (const auto &[stem, dir] : keptDirs()) out << stem << ' ' << dir << '\n';
            std::printf("             also listed in %s\n", list.c_str());
        }
        std::fflush(stdout);
    }

    return status;
}
