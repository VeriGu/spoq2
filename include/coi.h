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
        "meta_af", "meta_PA",
        "meta_desc_type", "meta_granule_offset", "meta_mem_attr", "meta_ripas",
        "pbase", "poffset", 
    };

    /** elements in white list will be removed from coi set eventually  */
    static std::set<string> coi_blacklist = {
        "e_1", "e_2", "e_3", 
    };
    // State field is composed of a list of accessed fields
    // leaf field: field_t[n-1] 
    typedef std::vector<std::string> field_t;
    typedef std::vector<int> path_t;
    typedef std::pair<SpecNode *, path_t> path_node_t;

    void print_path(const path_t &p);
    /* Calculate cone of influence */
    std::set<field_t> analyze_cone_of_influence(Project *proj, Definition *def, 
                                                std::variant<SpecNode *, std::set<field_t>> coi_src,
                                                std::set<string> whitelist = {}, 
                                                std::set<string> blacklist = {});
    void analyze_invariant_fields(Project *proj, SpecNode *inv, std::set<field_t> &fields);
    void coi_reduction(Project *proj, Definition *def, SpecNode *inv);
    void mark_determ_branch(Project* proj, Definition* rel_def, Definition* spec_def);
}