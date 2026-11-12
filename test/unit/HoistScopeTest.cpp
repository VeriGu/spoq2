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

/// hoist_match_root on `match (if c then a else b) with ps`: the root becomes
/// the If, each branch a match with ps, and the free variables are unchanged.
TEST(HoistMatchRoot, MatchOfIfBecomesIfOfMatches) {
    auto proj = parse_case("match_of_if",
        "  match (if ((d.(poffset)) =? 0) then (load_RData (8) d st) else None) with\n"
        "  | None => None\n"
        "  | (Some x) => (Some (x, st))\n"
        "  end");
    auto def = proj->defs.find("match_of_if");
    ASSERT_NE(def, proj->defs.end()) << "the case did not parse";
    auto spec = std::move(def->second->body());
    auto const before = free_names(*proj, spec.get());

    bool changed = false;
    std::tie(spec, changed) = proj->rules.hoist_match_root(std::move(spec));
    ASSERT_TRUE(changed) << std::string(*spec);
    auto const iff = instance_of(spec.get(), If);
    ASSERT_NE(iff, nullptr) << std::string(*spec);
    EXPECT_EQ(free_names(*proj, spec.get()), before) << std::string(*spec);
}

/// hoist_match_root on `match (match e with q => b) with ps`: ps moves under
/// q.  An arm of ps uses the parameter `st`, which q also binds; the result
/// must still use the parameter.
TEST(HoistMatchRoot, MatchOfMatchKeepsFreeUsesUnderAPatternBinder) {
    auto proj = parse_case("match_of_match",
        "  match (match (store_RData (8) d (0) st) with\n"
        "         | None => None\n"
        "         | (Some st) => (load_RData (8) d st)\n"
        "         end) with\n"
        "  | None => None\n"
        "  | (Some x) => (Some (x, st))\n"
        "  end");
    auto def = proj->defs.find("match_of_match");
    ASSERT_NE(def, proj->defs.end()) << "the case did not parse";
    auto spec = std::move(def->second->body());
    auto const before = free_names(*proj, spec.get());

    bool changed = false;
    std::tie(spec, changed) = proj->rules.hoist_match_root(std::move(spec));
    ASSERT_TRUE(changed) << std::string(*spec);
    auto const outer = instance_of(spec.get(), Match);
    ASSERT_NE(outer, nullptr) << std::string(*spec);
    EXPECT_EQ(free_names(*proj, spec.get()), before) << std::string(*spec);
    // The moved arms' free names, other than their own binders, must not be
    // bound by the outer pattern they now sit under.
    for (auto &pm : *outer->match_list) {
        auto const binders = free_names(*proj, pm->pattern.get());
        auto const inner = instance_of(pm->body.get(), Match);
        if (!inner) continue;
        for (auto &arm : *inner->match_list) {
            auto const own = free_names(*proj, arm->pattern.get());
            for (auto const &n : free_names(*proj, arm->body.get()))
                EXPECT_TRUE(own.count(n) || !binders.count(n))
                    << "'" << n << "' captured by " << std::string(*pm->pattern) << ":\n" << std::string(*spec);
        }
    }
}

/// A match whose scrutinee is neither a Match nor an If is returned unchanged.
TEST(HoistMatchRoot, OtherRootIsUnchanged) {
    auto proj = parse_case("plain_match",
        "  match (load_RData (8) d st) with\n"
        "  | None => None\n"
        "  | (Some x) => (Some (x, st))\n"
        "  end");
    auto def = proj->defs.find("plain_match");
    ASSERT_NE(def, proj->defs.end()) << "the case did not parse";
    auto spec = std::move(def->second->body());
    auto const text = std::string(*spec);

    bool changed = true;
    std::tie(spec, changed) = proj->rules.hoist_match_root(std::move(spec));
    EXPECT_FALSE(changed);
    EXPECT_EQ(std::string(*spec), text);
}

/// hoist_match_from_branch on an if whose condition is a match: the branches
/// move under the condition's arms.  The then-branch returns the parameter
/// `st`, which the `Some st` arm also binds; the result must still return it.
TEST(HoistScope, IfOfMatchDoesNotCaptureAFreeName) {
    auto proj = parse_case("if_of_match_capture",
        "  if (match (store_RData (8) d (0) st) with\n"
        "      | None => false\n"
        "      | (Some st) => true\n"
        "      end)\n"
        "  then (Some (0, st))\n"
        "  else None");
    auto def = proj->defs.find("if_of_match_capture");
    ASSERT_NE(def, proj->defs.end()) << "the case did not parse";
    auto spec = std::move(def->second->body());

    bool changed = false;
    std::tie(spec, changed) = proj->rules.hoist_match_from_branch(std::move(spec));
    ASSERT_TRUE(changed) << std::string(*spec);
    auto const m = instance_of(spec.get(), Match);
    ASSERT_NE(m, nullptr) << std::string(*spec);
    EXPECT_EQ(std::string(*m->match_list->front()->pattern), "None") << std::string(*spec);
    auto const some_arm = m->match_list->back().get();
    EXPECT_FALSE(free_names(*proj, some_arm->pattern.get()).count("st"))
        << "the Some arm still binds st:\n" << std::string(*spec);
    EXPECT_TRUE(free_names(*proj, some_arm->body.get()).count("st")) << std::string(*spec);
}

/// hoist_match_from_branch on the match-of-match of
/// MatchOfMatchKeepsFreeUsesUnderAPatternBinder.
TEST(HoistScope, MatchOfMatchDoesNotCaptureAFreeName) {
    auto proj = parse_case("match_of_match_capture",
        "  match (match (store_RData (8) d (0) st) with\n"
        "         | None => None\n"
        "         | (Some st) => (load_RData (8) d st)\n"
        "         end) with\n"
        "  | None => None\n"
        "  | (Some x) => (Some (x, st))\n"
        "  end");
    auto def = proj->defs.find("match_of_match_capture");
    ASSERT_NE(def, proj->defs.end()) << "the case did not parse";
    auto spec = std::move(def->second->body());

    bool changed = false;
    std::tie(spec, changed) = proj->rules.hoist_match_from_branch(std::move(spec));
    ASSERT_TRUE(changed) << std::string(*spec);
    auto const m = instance_of(spec.get(), Match);
    ASSERT_NE(m, nullptr) << std::string(*spec);
    EXPECT_EQ(std::string(*m->match_list->front()->pattern), "None") << std::string(*spec);
    auto const some_arm = m->match_list->back().get();
    EXPECT_FALSE(free_names(*proj, some_arm->pattern.get()).count("st"))
        << "the Some arm still binds st:\n" << std::string(*spec);
    EXPECT_TRUE(free_names(*proj, some_arm->body.get()).count("st")) << std::string(*spec);
}
