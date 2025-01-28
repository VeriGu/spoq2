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

static unsigned long get_mono_lens_id() {
    return mono_lens_id++;
}

SpecNode *rec_apply(SpecNode *spec, std::function<SpecNode*(SpecNode*)> f, bool apply_anno);

using rule_ret_t = std::pair<SpecNode *, bool>;
SpecNode *eliminiate_ambiguity(Project *proj, SpecNode *spec, std::set<string> &prev_symbols, bool &changed);
rule_ret_t rule_unfold_specs(Project *proj, SpecNode *spec);

rule_ret_t rule_simple_record_get_set(Project *proj, SpecNode *spec);
rule_ret_t rule_keep_fields_of_interest(Project *proj, SpecNode *spec, string fname);
rule_ret_t rule_simplify_lens(Project *proj, SpecNode *spec);
rule_ret_t rule_move_if_out_match(Project *proj, SpecNode *spec);
rule_ret_t rule_move_if_out_expr(Project *proj, SpecNode *spec);
rule_ret_t rule_move_match_out_expr(Project *proj, SpecNode *spec);
rule_ret_t rule_move_rely_out_when(Project *proj, SpecNode *spec);
rule_ret_t rule_move_when_out_when(Project *proj, SpecNode *spec);
rule_ret_t rule_eliminate_if(Project *proj, SpecNode *spec);
rule_ret_t rule_eliminate_let(Project *proj, SpecNode *spec);
rule_ret_t rule_eliminate_match_simple(Project *proj, SpecNode *spec);
rule_ret_t rule_subst_match_src_with_content(Project *proj, SpecNode *spec);
rule_ret_t rule_simple_builtin_functions(Project* proj, SpecNode *spec);
rule_ret_t rule_eliminate_when(Project *proj, SpecNode *spec);
rule_ret_t rule_simplify_expr(Project *proj, SpecNode *spec);
std::pair<bool, std::pair<string,string>> rule_conditional_spec(Project* proj, Definition *spec, vector<Definition*>* low_specs);
rule_ret_t replace_spec_name(Project *proj, SpecNode *spec, unordered_map<string, string> &name_map);

bool spec_is_pure(Project *proj, SpecNode *spec, bool &has_if);
bool spec_needs_state(Project *proj, SpecNode *spec);
void spec_remove_state(Project *proj, SpecNode *spec);

void get_vars_from_pattern(Project *proj, SpecNode *pattern, std::set<string> &vars);
} // namespace autov