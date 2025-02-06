#pragma once

#include <nodes.h>
#include <values.h>
#include <utils.h>
#include <shortcuts.h>
#include <project.h>
#include <cassert>
#include <utility>
#include <rules.h>
#include <z3_rules.h>

namespace autov {
    // State field is composed of a list of accessed fields
    // leaf field: field_t[n-1] 
    typedef std::vector<std::string> field_t;
    typedef std::vector<int> path_t;
    typedef std::pair<SpecNode *, path_t> path_node_t;

    bool is_invariant_defs(Project *proj, string const &name);
    bool is_lemma_defs(Project *proj, const string &name);
    void rec_analyze_used_fields(Project* proj, SpecNode* node, std::set<field_t> &fields);
    /* Calculate cone of influence */
    std::set<string> analyze_cone_of_influence(Project *proj, Definition *def, SpecNode *inv);

    void spec_prover(Project *proj, Definition *def);
}