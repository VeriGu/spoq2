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
    typedef std::pair<SpecNode *, path_t> PropagationNode;

    void rec_analyze_used_fields(Project* proj, SpecNode* node, std::set<field_t> &fields);
    /* Calculate cone of influence */
    void analyze_cone_of_influence(Project *proj, string fname, Definition *def);
    void analyze_invariant_fields(Project *proj, SpecNode *inv, string name);

		bool check_inv_by_path(Project *proj, Definition *def, SpecNode *inv);

}