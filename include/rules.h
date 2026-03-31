#pragma once

#include <string>
#include <vector>
#include <utility>
#include <memory>
#include <nodes.h>
#include <log.h>
#include <values.h>
#include <utils.h>
namespace autov {
extern unsigned long mono_lens_id;
extern std::set<string> interest_list;
static unsigned long get_mono_lens_id() {
    return mono_lens_id++;
}
class EvalState;

#ifdef CONDITIONAL_SPEC
std::pair<bool, std::pair<string,string>> rule_conditional_spec(Project* proj, Definition *spec, vector<Definition*>* low_specs);
#endif
std::unique_ptr<SpecNode> subst(std::unique_ptr<SpecNode> spec,const std::string& name,SpecNode* value,bool &succ, SpecNode** last_place_substituted = nullptr);
bool spec_is_pure(Project *proj, SpecNode *spec, bool &has_if);
bool spec_needs_state(Project *proj, SpecNode *spec);
void spec_remove_state(Project *proj, SpecNode *spec);
std::unique_ptr<SpecNode> subst_v2(Project* proj, std::unique_ptr<SpecNode> spec, std::string name, unique_ptr<SpecNode> value);
std::unique_ptr<SpecNode> subst_v2(Project* proj, std::unique_ptr<SpecNode> spec, vector<std::string>* names, vector<unique_ptr<SpecNode>>* values);
unique_ptr<SpecNode> partial_eval(Project* proj, unique_ptr<SpecNode> spec, int level, shared_ptr<EvalState> state, std::set<string>& used_symbols, bool unfold = false);
void free_vars(Project* proj, SpecNode* spec, std::set<std::string>& free);
void free_vars_map(Project *proj, SpecNode *spec, std::set<string> &free, std::map<string, Symbol*> &map);
inline void set_interest_list(const std::set<string> &coi) {
    interest_list.clear();
    interest_list.insert(coi.begin(), coi.end());
}

enum class RuleID {
    rule_eliminate_let,
    rule_eliminate_when,
    rule_eliminate_if,
    rule_eliminate_match_simple,
    rule_subst_match_src_with_content,
    rule_simple_builtin_functions,
    rule_simple_record_get_set,
    rule_move_rely_out_when, 
    rule_move_when_out_when,
    rule_simple_const_bool,
    rule_move_if_out_match,
    rule_move_if_out_expr,
    rule_move_match_out_expr,
    rule_unfold_specs, 
    rule_simplify_expr,
    rule_simple_by_z3,
    rule_hoist_branch_out_of_when,
    rule_hoist_match_from_branch
};

/** FIXME:
 * rule_simplify_lens
 */
using rule_ret_t = std::pair<std::unique_ptr<SpecNode>, bool>;
using field_t = std::vector<std::string>;

class SpecRules {
private:
    Project *proj;
    std::unique_ptr<SpecNode> rec_apply(std::unique_ptr<SpecNode> spec,
                                              const std::function<std::unique_ptr<SpecNode>(std::unique_ptr<SpecNode>)>& f);
public: 
    using rule_t = std::function<rule_ret_t(std::unique_ptr<SpecNode>)>;
    struct SpecRule {
        RuleID id;
        std::function<rule_ret_t(std::unique_ptr<SpecNode>)> call;
    };
    std::vector<SpecRule> rules_group1;
    std::vector<SpecRule> rules_group2;
    SpecRules(Project *proj) : proj(proj),
        rules_group1 {
            { RuleID::rule_simplify_expr,           [this](auto spec) { return rule_simplify_expr(std::move(spec), true); } },
            { RuleID::rule_eliminate_when,          [this](auto spec) { return rule_eliminate_when(std::move(spec), true); } },
            { RuleID::rule_eliminate_if,            [this](auto spec) { return rule_eliminate_if(std::move(spec), true); } },
            { RuleID::rule_eliminate_match_simple,  [this](auto spec) { return rule_eliminate_match_simple(std::move(spec), true); } },
            { RuleID::rule_subst_match_src_with_content, [this](auto spec) { return rule_subst_match_src_with_content(std::move(spec), true); } },
            { RuleID::rule_simple_builtin_functions, [this](auto spec) { return rule_simple_builtin_functions(std::move(spec), true); } },
            { RuleID::rule_simple_record_get_set,   [this](auto spec) { return rule_simple_record_get_set(std::move(spec), true); } },
            { RuleID::rule_move_rely_out_when,      [this](auto spec) { return rule_move_rely_out_when(std::move(spec), true); } },
            { RuleID::rule_move_when_out_when,      [this](auto spec) { return rule_move_when_out_when(std::move(spec), true); } },
            //{ RuleID::rule_move_if_out_match,       [this](auto spec) { return rule_move_if_out_match(std::move(spec), true); } },
            // { RuleID::rule_hoist_branch_out_of_when,        [this](auto spec) { return hoist_branch_out_of_when(std::move(spec)); } },
            // { RuleID::rule_hoist_match_from_branch,        [this](auto spec) { return hoist_match_from_branch(std::move(spec)); } },
            { RuleID::rule_simple_const_bool,        [this](auto spec) { return simple_const_bool(std::move(spec)); } },
            { RuleID::rule_move_if_out_expr,        [this](auto spec) { return rule_move_if_out_expr(std::move(spec), true); } },
            { RuleID::rule_move_match_out_expr,     [this](auto spec) { return rule_move_match_out_expr(std::move(spec), true); } }
        },
        rules_group2 {
            //{ RuleID::rule_eliminate_let,          [this](auto spec) { return rule_eliminate_let(std::move(spec), true); } },
            { RuleID::rule_eliminate_match_simple, [this](auto spec) { return rule_eliminate_match_simple(std::move(spec), true); } },
            //{ RuleID::rule_move_if_out_expr,       [this](auto spec) { return rule_move_if_out_expr(std::move(spec), true); } },
            { RuleID::rule_simple_record_get_set,  [this](auto spec) { return rule_simple_record_get_set(std::move(spec), true); } },
            { RuleID::rule_eliminate_let,           [this](auto spec) { return rule_eliminate_let(std::move(spec), true); } },
        } {}

    rule_ret_t simple_rely_by_z3(std::unique_ptr<RelyAnno> spec, std::shared_ptr<EvalState> state);
    rule_ret_t simple_if_by_z3(std::unique_ptr<If> spec, std::shared_ptr<EvalState> state);
    rule_ret_t simple_match_by_z3(std::unique_ptr<Match> spec, std::shared_ptr<EvalState> state);
    rule_ret_t simple_expr_by_z3(std::unique_ptr<Expr> expr, std::shared_ptr<EvalState> state);

    // Rules as member functions
    rule_ret_t rule_eliminate_rely(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_eliminate_let(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_eliminate_when(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_eliminate_if(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_eliminate_match_simple(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_subst_match_src_with_content(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_simple_builtin_functions(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_simple_record_get_set(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_move_rely_out_when(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_move_when_out_when(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_move_if_out_match(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_move_if_out_expr(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_move_match_out_expr(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_unfold_specs(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_simplify_map_get_set(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_simplify_expr(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_simple_by_z3(std::unique_ptr<SpecNode> spec, std::shared_ptr<EvalState> state);
    rule_ret_t rule_keep_fields_of_interest(std::unique_ptr<SpecNode> spec);
    rule_ret_t rule_simplify_lens(std::unique_ptr<SpecNode> spec);
    rule_ret_t hoist_branch_out_of_when(std::unique_ptr<SpecNode> spec);
    rule_ret_t hoist_match_from_branch(std::unique_ptr<SpecNode> spec, bool rec=true);
    rule_ret_t collect_all_vars(std::unique_ptr<SpecNode> spec, std::set<string> &vars);
    rule_ret_t wrap_none_call_with_cond(Project *proj,
                                        std::unique_ptr<SpecNode> spec,
                                        std::string &func_name,
                                        std::unique_ptr<SpecNode> cond);
    rule_ret_t simple_const_bool(std::unique_ptr<SpecNode> spec);
    rule_ret_t replace_spec_name(std::unique_ptr<SpecNode> spec, std::unordered_map<std::string, std::string>& name_map);

    std::unique_ptr<SpecNode> eliminate_ambiguity(std::unique_ptr<SpecNode> spec, std::set<std::string>& prev_symbols, bool& changed);
    std::unique_ptr<SpecNode> instantiate_prop(std::unique_ptr<SpecNode> spec, std::unique_ptr<SpecNode> instance_st, const std::string& st = "st");
    std::unique_ptr<SpecNode> build_simulate_spec(std::unique_ptr<SpecNode> spec);
    rule_ret_t merge_branch(std::unique_ptr<SpecNode> spec);
    rule_ret_t hide_write(std::unique_ptr<SpecNode> spec, std::set<field_t> coi_fields, const std::set<std::pair<string, string>> &anc);
    bool enforce_no_div_by_zero(Definition* def);
};

using rule_t = std::function<rule_ret_t(std::unique_ptr<SpecNode>)>;

class UnfoldPolicy {
public:
    bool skip = false;
    std::set<string> skip_list;
    std::unordered_map<string, int> loop_unroll_count;

    std::string current_unfold = "";

    void set_skip(bool s) { skip = s; }
    bool is_skip(std::string fname) {
        if (!skip) return false;
        if (skip_list.find(fname) != skip_list.end()) {
            return true;
        }
        return false;
    }

    void clear_loop_unroll() { current_unfold = ""; }

    bool is_loop_unroll(std::string spec_name) { 
        return current_unfold == spec_name;
    }

    // For now, only depth = 1 loop unroll is supported.
    // F () { F }
    bool require_loop_unroll(std::string spec_name, std::unordered_map<string, int>& lut) {
        if (current_unfold.size() > 1) {
            LOG_DEBUG << "we expect current_unfold to be empty, but it is " << current_unfold << "\n";
            LOG_DEBUG << "this means we are in the middle of loop unroll, but we don't actually need to unfold this much time\n";
            current_unfold = "";
            LOG_DEBUG << "we skip loop unroll" << "\n";
            return false;
        }

        // if (spec_name.size() >= suffix.size() && spec_name.compare(spec_name.size() - suffix.size(), suffix.size(), suffix) == 0) {
            // auto fname = spec_name.substr(0, spec_name.size() - suffix.size());
        auto fname = spec_name;
        if (lut.find(fname) == lut.end()) return false;
        if (lut.at(fname) <= loop_unroll_count[fname]) return false;

        // TODO: do we need to put skip_list back?
        current_unfold = spec_name;
        loop_unroll_count[fname] += 1;
        return true;
        // }
        return false;
    }
};

} // namespace autov