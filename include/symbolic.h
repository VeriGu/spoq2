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


    static std::set<std::string> verify_spec_names = {
        "smc_system_interface_version_spec",
        "smc_read_feature_register_spec",
        "smc_granule_delegate_spec",
        "smc_granule_undelegate_spec",
        "smc_realm_create_spec",
        "smc_realm_destroy_spec",
        "smc_rec_enter_spec",
        "smc_realm_activate_spec",
        "smc_rec_create_spec",
        "smc_rec_destroy_spec",
        "smc_data_create_spec",
        "rsi_data_create_unknown_s1_spec",
        "map_unmap_ns_s1_spec",
        "rsi_data_destroy_spec",
        "rsi_rtt_create_spec",
        "rsi_rtt_destroy_spec",
        "rsi_rtt_set_ripas_spec",
        "rsi_data_map_extra_spec",
        "rsi_set_ttbr0_spec",
        "rsi_data_set_attrs_spec",
        "handle_rsi_realm_extend_measurement_spec",
        "handle_rsi_realm_get_attest_token_spec",
        "smc_rtt_read_entry_spec",
        "smc_rc_rtt_read_entry_spec",
        "smc_rtt_fold_spec",
        "system_rsi_abi_version_spec",
    };

    // State field is composed of a list of accessed fields
    // leaf field: field_t[n-1] 
    typedef std::vector<std::string> field_t;
    typedef std::vector<int> path_t;
    typedef std::pair<SpecNode *, path_t> path_node_t;

    bool is_invariant_defs(Project *proj, string const &name);
    bool is_lemma_defs(Project *proj, const string &name);


    void spec_prover(Project *proj, Definition *def);
}