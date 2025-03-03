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
std::unique_ptr<SpecNode> subst(std::unique_ptr<SpecNode> spec,const std::string& name,SpecNode* value,bool &succ);
bool spec_is_pure(Project *proj, SpecNode *spec, bool &has_if);
bool spec_needs_state(Project *proj, SpecNode *spec);
void spec_remove_state(Project *proj, SpecNode *spec);
std::unique_ptr<SpecNode> subst_v2(Project* proj, std::unique_ptr<SpecNode> spec, std::string name, SpecNode* value);
std::unique_ptr<SpecNode> subst_v2(Project* proj, std::unique_ptr<SpecNode> spec, vector<std::string>* names, vector<SpecNode*>* values);
unique_ptr<SpecNode> partial_eval(Project* proj, unique_ptr<SpecNode> spec, int level, shared_ptr<EvalState> state, std::set<string>& used_symbols, bool unfold = false);
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
    rule_move_if_out_match,
    rule_move_if_out_expr,
    rule_move_match_out_expr,
    rule_unfold_specs, 
    rule_simplify_expr,
    rule_simple_by_z3,
};

/** FIXME:
 * rule_simplify_lens
 */
using rule_ret_t = std::pair<std::unique_ptr<SpecNode>, bool>;

class SpecRules {
private:
    Project *proj;
    std::unique_ptr<SpecNode> rec_apply(std::unique_ptr<SpecNode> spec,
                                              const std::function<std::unique_ptr<SpecNode>(std::unique_ptr<SpecNode>)>& f,
                                              bool apply_anno);
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

    rule_ret_t rule_simplify_expr(std::unique_ptr<SpecNode> spec, bool rec);
    rule_ret_t rule_simple_by_z3(std::unique_ptr<SpecNode> spec, std::shared_ptr<EvalState> state);
    rule_ret_t rule_keep_fields_of_interest(std::unique_ptr<SpecNode> spec);
    rule_ret_t rule_simplify_lens(std::unique_ptr<SpecNode> spec);

    rule_ret_t replace_spec_name(std::unique_ptr<SpecNode> spec, std::unordered_map<std::string, std::string>& name_map);

    std::unique_ptr<SpecNode> eliminate_ambiguity(std::unique_ptr<SpecNode> spec, std::set<std::string>& prev_symbols, bool& changed);
    std::unique_ptr<SpecNode> instantiate_prop(std::unique_ptr<SpecNode> spec, std::unique_ptr<SpecNode> instance_st, const std::string& st = "st");
};

using rule_t = std::function<rule_ret_t(std::unique_ptr<SpecNode>)>;

} // namespace autov