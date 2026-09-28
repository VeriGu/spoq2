/* hoist_match_from_branch must not unbind a name when it renames a binder.
 *
 * The if-of-match case moves the branches under the arms of the condition's
 * match, and renames binders in them that would shadow a live name.  Only the
 * occurrences such a binder binds are renamed.  A branch can both use the live
 * name and rebind it; the free use must keep its name:
 *
 *     match s with Some x =>
 *       if (match t with Some y => y =? 0 | None => false)
 *       then Some (x + (match u with Some x => x | None => 0), st)
 *       else None
 *
 *   ->  ... Some y => if (y =? 0)
 *                     then Some (x + (match u with Some x_1 => x_1 ...), st) ...
 *
 * Reduced from openjpeg cve-2024-56827 (opj_j2k_add_tlmarker_vuln_spec), where
 * renaming the free use as well left `bytemap_42` unbound and the next
 * iteration aborted with "Unknown symbol: bytemap_42".
 */

#include <gtest/gtest.h>

#include <fstream>
#include <set>
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

constexpr const char *kMainV = SPOQ_DEMAND_DIR "/hidden_ub_unfold_not_triggered_fail.main.v";

std::string read_file(const std::string &path) {
    std::ifstream in(path);
    EXPECT_TRUE(in) << "cannot open " << path;
    std::stringstream ss;
    ss << in.rdbuf();
    return ss.str();
}

std::unique_ptr<Project> parse_case(const std::string &name, const std::string &body) {
    auto const tmp = std::string("/tmp/") + name + "_hoist_scope_fixture.v";
    {
        std::ofstream out(tmp);
        out << read_file(kMainV) << "\n\nDefinition " << name
            << " (d: Ptr) (st: RData) : (option ((Z) * RData)) :=\n"
            << body << ".\n";
    }
    auto proj = std::make_unique<Project>();
    parser::parse(proj.get(), tmp);
    return proj;
}

std::set<std::string> free_names(Project &proj, SpecNode *spec) {
    std::set<std::string> fv;
    free_vars(&proj, spec, fv);
    return fv;
}

}  // namespace

/// The then-branch uses the outer `x` and rebinds `x` in a nested match.
/// After the hoist the branch's free variables must be what they were.
TEST(HoistScope, IfOfMatchKeepsFreeUsesOfARenamedBinder) {
    auto proj = parse_case("rebind_in_branch",
        "  match (load_RData (8) d st) with\n"
        "  | None => None\n"
        "  | (Some x) =>\n"
        "    if (match (load_RData (8) d st) with\n"
        "        | None => false\n"
        "        | (Some y) => (y =? 0)\n"
        "        end)\n"
        "    then (Some ((x + (match (load_RData (8) d st) with\n"
        "                      | None => 0\n"
        "                      | (Some x) => x\n"
        "                      end)), st))\n"
        "    else None\n"
        "  end");
    auto def = proj->defs.find("rebind_in_branch");
    ASSERT_NE(def, proj->defs.end()) << "the case did not parse";
    auto spec = std::move(def->second->body());
    auto const before = free_names(*proj, spec.get());

    bool changed = false;
    std::tie(spec, changed) = proj->rules.hoist_match_from_branch(std::move(spec));
    ASSERT_TRUE(changed) << "the if-of-match rewrite did not fire: " << std::string(*spec);
    EXPECT_EQ(free_names(*proj, spec.get()), before) << std::string(*spec);
}
