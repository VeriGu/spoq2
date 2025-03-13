#pragma once

#include <nodes.h>
#include <values.h>
#include <utils.h>
#include <shortcuts.h>
#include <project.h>
#include <cassert>
#include <utility>
#include <rules.h>

namespace autov {
    /** elements in white list will be added into coi set initially */
    static std::set<string> coi_whitelist = {
        "g_norm",
    };

    /** elements in white list will be removed from coi set eventually  */
    static std::set<string> coi_blacklist = {
        "pbase", "poffset", "meta_PA", "meta_desc_type", "meta_granule_offset", "meta_mem_attr", "meta_ripas",
        "e_1", "e_2", "e_3", 
    };
    // State field is composed of a list of accessed fields
    // leaf field: field_t[n-1] 
    typedef std::vector<std::string> field_t;
    typedef std::vector<int> path_t;
    typedef std::pair<SpecNode *, path_t> path_node_t;

    /* Calculate cone of influence */
    std::set<string> analyze_cone_of_influence(Project *proj, Definition *def, SpecNode *inv);
}