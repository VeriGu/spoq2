Require Import CommonDeps.
Require Import DataTypes.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter zero_granule_data_normal : (ZMap.t Z).

Parameter CPU_ID : Z.

Parameter MaxStackOrder : Z.

Parameter empty_st : Z -> Shared.

Parameter realm_trap_determ : list Event -> realm_trap_type.

Parameter rmi_realm_params : s_rmi_realm_params.

Parameter common_sysregs_init : s_common_sysreg_state.

Parameter sysregs_init : s_sysreg_state.

Parameter rec_regs_init : (ZMap.t Z).

Parameter rec_pc_init : Z.

Parameter rec_pstate_init : Z.

Parameter rec_params_mpidr : Z.

Parameter empty_rec : s_rec.

Parameter empty_rd : s_rd.

Parameter gic_virt_feature_0 : Z.

Parameter gic_virt_feature_1 : Z.

Parameter gic_virt_feature_2 : Z.

Parameter gic_virt_feature_3 : Z.

Parameter gic_virt_feature_4 : Z.

Parameter DEFAULT_RTT_VAL : Z.

Parameter DEFAULT_RTT2_VAL : Z.

Parameter DEFAULT_STACK_VAL : Z.

Parameter DEFAULT_LLT_INFO_CACHE : Z.

Parameter sysreg_handlers_base : Z.

Parameter lens : Z -> (RData -> RData).

Section GlobalDefs.

  Context `{int_ptr: IntPtrCast}.

  Definition ptr_offset (_ptr: Ptr) (_offs: Z) : Ptr :=
    (mkPtr (_ptr.(pbase)) ((_ptr.(poffset)) + (_offs))).

  Definition bool_to_int (_b: bool) : Z :=
    if _b
    then 1
    else 0.

  Definition SLOT_VIRT  : Z :=
    18446744073709420544.

  Definition STACK_VIRT  : Z :=
    18446744073705226240.

  Definition MAX_ERR  : Z :=
    18446744073709547520.

  Definition GRANULES_BASE  : Z :=
    18446744073688449024.

  Definition ST_GRANULE_SIZE  : Z :=
    16.

  Definition RMM_MAX_GRANULES  : Z :=
    1048576.

  Definition MAX_REC_AUX_GRANULES  : Z :=
    16.

  Definition GRANULE_SIZE  : Z :=
    4096.

  Definition SMC_RMM_GTSI_DELEGATE  : Z :=
    3288334768.

  Definition SMC_RMM_GTSI_UNDELEGATE  : Z :=
    3288334769.

  Definition SLOT_NS  : Z :=
    0.

  Definition SLOT_DELEGATED  : Z :=
    1.

  Definition SLOT_RD  : Z :=
    2.

  Definition SLOT_REC  : Z :=
    3.

  Definition SLOT_REC2  : Z :=
    4.

  Definition SLOT_REC_TARGET  : Z :=
    5.

  Definition SLOT_REC_AUX0  : Z :=
    6.

  Definition SLOT_RTT  : Z :=
    22.

  Definition SLOT_RTT2  : Z :=
    23.

  Definition SLOT_RSI_CALL  : Z :=
    24.

  Definition STACK_slot_ofs  : Z :=
    25.

  Definition STACK_attest_setup_platform_token  : Z :=
    25.

  Definition STACK_smc_psci_complete  : Z :=
    26.

  Definition STACK_find_lock_two_granules  : Z :=
    27.

  Definition STACK_attest_token_continue_write_state  : Z :=
    28.

  Definition STACK_rmm_log  : Z :=
    29.

  Definition STACK_attest_realm_token_create  : Z :=
    30.

  Definition STACK_smc_rec_enter  : Z :=
    31.

  Definition STACK_do_host_call  : Z :=
    32.

  Definition STACK_attest_rnd_prng_init  : Z :=
    33.

  Definition STACK_plat_setup  : Z :=
    34.

  Definition STACK_attest_token_encode_start  : Z :=
    35.

  Definition STACK_smc_data_destroy  : Z :=
    36.

  Definition STACK_xlat_get_llt_from_va  : Z :=
    37.

  Definition STACK_smc_rec_create  : Z :=
    38.

  Definition STACK_measurement_extend_sha512  : Z :=
    39.

  Definition STACK_data_granule_measure  : Z :=
    40.

  Definition STACK_sort_granules  : Z :=
    41.

  Definition STACK_measurement_extend_sha256  : Z :=
    42.

  Definition STACK_realm_ipa_to_pa  : Z :=
    43.

  Definition STACK_attest_realm_token_sign  : Z :=
    44.

  Definition STACK_rmm_el3_ifc_get_platform_token  : Z :=
    45.

  Definition STACK_attest_init_realm_attestation_key  : Z :=
    46.

  Definition STACK_plat_cmn_setup  : Z :=
    47.

  Definition STACK_complete_rsi_host_call  : Z :=
    48.

  Definition STACK_handle_realm_rsi  : Z :=
    49.

  Definition STACK_smc_rtt_set_ripas  : Z :=
    50.

  Definition STACK_rtt_walk_lock_unlock  : Z :=
    51.

  Definition STACK_smc_rtt_destroy  : Z :=
    52.

  Definition STACK_map_unmap_ns  : Z :=
    53.

  Definition STACK_handle_rsi_attest_token_init  : Z :=
    54.

  Definition STACK_realm_params_measure  : Z :=
    55.

  Definition STACK_handle_rsi_ipa_state_get  : Z :=
    56.

  Definition STACK_realm_ipa_get_ripas  : Z :=
    57.

  Definition STACK_smc_rtt_fold  : Z :=
    58.

  Definition STACK_smc_rtt_create  : Z :=
    59.

  Definition STACK_rsi_log_on_exit  : Z :=
    60.

  Definition STACK_attest_cca_token_create  : Z :=
    61.

  Definition STACK_rec_params_measure  : Z :=
    62.

  Definition STACK_handle_ns_smc  : Z :=
    63.

  Definition STACK_rmm_el3_ifc_get_realm_attest_key  : Z :=
    64.

  Definition STACK_handle_rsi_realm_config  : Z :=
    65.

  Definition STACK_smc_rtt_init_ripas  : Z :=
    66.

  Definition STACK_smc_rtt_read_entry  : Z :=
    67.

  Definition STACK_handle_data_abort  : Z :=
    68.

  Definition STACK_data_create  : Z :=
    69.

  Definition STACK_smc_realm_create  : Z :=
    70.

  Definition STACK_ripas_granule_measure  : Z :=
    71.

  Definition STACK_ipa_is_empty  : Z :=
    72.

  Definition STACK_g0  : Z :=
    73.

  Definition STACK_g1  : Z :=
    74.

  Definition non_slot  : Z :=
    75.

  Definition int_is_granule (v: Z) : Prop :=
    (((v > (0)) /\ ((v >= (GRANULES_BASE)))) /\ ((v < ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))))).

  Definition REALM_STATE_NEW  : Z :=
    0.

  Definition REALM_STATE_ACTIVE  : Z :=
    1.

  Definition REALM_STATE_SYSTEM_OFF  : Z :=
    2.

  Definition load_s_gic_cpu_state (sz: Z) (ofs: Z) (st: s_gic_cpu_state) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some ((st.(e_ich_ap0r_el2)) @ idx)))
    else (
      if ((ofs >=? (32)) && ((ofs <? (64))))
      then (
        let idx := ((ofs - (32)) / (8)) in
        (Some ((st.(e_ich_ap1r_el2)) @ idx)))
      else (
        if (ofs =? (64))
        then (Some (st.(e_ich_vmcr_el2)))
        else (
          if (ofs =? (72))
          then (Some (st.(e_ich_hcr_el2)))
          else (
            if ((ofs >=? (80)) && ((ofs <? (208))))
            then (
              let idx := ((ofs - (80)) / (8)) in
              (Some ((st.(e_ich_lr_el2)) @ idx)))
            else (
              if (ofs =? (208))
              then (Some (st.(e_ich_misr_el2)))
              else None))))).

  Definition store_s_gic_cpu_state (sz: Z) (ofs: Z) (v: Z) (st: s_gic_cpu_state) : (option s_gic_cpu_state) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some (st.[e_ich_ap0r_el2] :< ((st.(e_ich_ap0r_el2)) # idx == v))))
    else (
      if ((ofs >=? (32)) && ((ofs <? (64))))
      then (
        let idx := ((ofs - (32)) / (8)) in
        (Some (st.[e_ich_ap1r_el2] :< ((st.(e_ich_ap1r_el2)) # idx == v))))
      else (
        if (ofs =? (64))
        then (Some (st.[e_ich_vmcr_el2] :< v))
        else (
          if (ofs =? (72))
          then (Some (st.[e_ich_hcr_el2] :< v))
          else (
            if ((ofs >=? (80)) && ((ofs <? (208))))
            then (
              let idx := ((ofs - (80)) / (8)) in
              (Some (st.[e_ich_lr_el2] :< ((st.(e_ich_lr_el2)) # idx == v))))
            else (
              if (ofs =? (208))
              then (Some (st.[e_ich_misr_el2] :< v))
              else None))))).

  Definition load_s_sysreg_state (sz: Z) (ofs: Z) (st: s_sysreg_state) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_sysreg_sp_el0)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_sysreg_sp_el1)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_sysreg_elr_el1)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_sysreg_spsr_el1)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_sysreg_pmcr_el0)))
            else (
              if (ofs =? (40))
              then (Some (st.(e_sysreg_tpidrro_el0)))
              else (
                if (ofs =? (48))
                then (Some (st.(e_sysreg_tpidr_el0)))
                else (
                  if (ofs =? (56))
                  then (Some (st.(e_sysreg_csselr_el1)))
                  else (
                    if (ofs =? (64))
                    then (Some (st.(e_sysreg_sctlr_el1)))
                    else (
                      if (ofs =? (72))
                      then (Some (st.(e_sysreg_actlr_el1)))
                      else (
                        if (ofs =? (80))
                        then (Some (st.(e_sysreg_cpacr_el1)))
                        else (
                          if (ofs =? (88))
                          then (Some (st.(e_sysreg_zcr_el1)))
                          else (
                            if (ofs =? (96))
                            then (Some (st.(e_sysreg_ttbr0_el1)))
                            else (
                              if (ofs =? (104))
                              then (Some (st.(e_sysreg_ttbr1_el1)))
                              else (
                                if (ofs =? (112))
                                then (Some (st.(e_sysreg_tcr_el1)))
                                else (
                                  if (ofs =? (120))
                                  then (Some (st.(e_sysreg_esr_el1)))
                                  else (
                                    if (ofs =? (128))
                                    then (Some (st.(e_sysreg_afsr0_el1)))
                                    else (
                                      if (ofs =? (136))
                                      then (Some (st.(e_sysreg_afsr1_el1)))
                                      else (
                                        if (ofs =? (144))
                                        then (Some (st.(e_sysreg_far_el1)))
                                        else (
                                          if (ofs =? (152))
                                          then (Some (st.(e_sysreg_mair_el1)))
                                          else (
                                            if (ofs =? (160))
                                            then (Some (st.(e_sysreg_vbar_el1)))
                                            else (
                                              if (ofs =? (168))
                                              then (Some (st.(e_sysreg_contextidr_el1)))
                                              else (
                                                if (ofs =? (176))
                                                then (Some (st.(e_sysreg_tpidr_el1)))
                                                else (
                                                  if (ofs =? (184))
                                                  then (Some (st.(e_sysreg_amair_el1)))
                                                  else (
                                                    if (ofs =? (192))
                                                    then (Some (st.(e_sysreg_cntkctl_el1)))
                                                    else (
                                                      if (ofs =? (200))
                                                      then (Some (st.(e_sysreg_par_el1)))
                                                      else (
                                                        if (ofs =? (208))
                                                        then (Some (st.(e_sysreg_mdscr_el1)))
                                                        else (
                                                          if (ofs =? (216))
                                                          then (Some (st.(e_sysreg_mdccint_el1)))
                                                          else (
                                                            if (ofs =? (224))
                                                            then (Some (st.(e_sysreg_disr_el1)))
                                                            else (
                                                              if (ofs =? (232))
                                                              then (Some (st.(e_sysreg_mpam0_el1)))
                                                              else (
                                                                if (ofs =? (240))
                                                                then (Some (st.(e_sysreg_cnthctl_el2)))
                                                                else (
                                                                  if (ofs =? (248))
                                                                  then (Some (st.(e_sysreg_cntvoff_el2)))
                                                                  else (
                                                                    if (ofs =? (256))
                                                                    then (Some (st.(e_sysreg_cntpoff_el2)))
                                                                    else (
                                                                      if (ofs =? (264))
                                                                      then (Some (st.(e_sysreg_cntp_ctl_el0)))
                                                                      else (
                                                                        if (ofs =? (272))
                                                                        then (Some (st.(e_sysreg_cntp_cval_el0)))
                                                                        else (
                                                                          if (ofs =? (280))
                                                                          then (Some (st.(e_sysreg_cntv_ctl_el0)))
                                                                          else (
                                                                            if (ofs =? (288))
                                                                            then (Some (st.(e_sysreg_cntv_cval_el0)))
                                                                            else (
                                                                              if ((ofs >=? (296)) && ((ofs <? (512))))
                                                                              then (
                                                                                let elem_ofs := (ofs - (296)) in
                                                                                (load_s_gic_cpu_state sz elem_ofs (st.(e_sysreg_gicstate))))
                                                                              else (
                                                                                if (ofs =? (512))
                                                                                then (Some (st.(e_sysreg_vmpidr_el2)))
                                                                                else (
                                                                                  if (ofs =? (520))
                                                                                  then (Some (st.(e_sysreg_hcr_el2)))
                                                                                  else None))))))))))))))))))))))))))))))))))))))).

  Definition store_s_sysreg_state (sz: Z) (ofs: Z) (v: Z) (st: s_sysreg_state) : (option s_sysreg_state) :=
    if (ofs =? (0))
    then (Some (st.[e_sysreg_sp_el0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_sysreg_sp_el1] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_sysreg_elr_el1] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_sysreg_spsr_el1] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_sysreg_pmcr_el0] :< v))
            else (
              if (ofs =? (40))
              then (Some (st.[e_sysreg_tpidrro_el0] :< v))
              else (
                if (ofs =? (48))
                then (Some (st.[e_sysreg_tpidr_el0] :< v))
                else (
                  if (ofs =? (56))
                  then (Some (st.[e_sysreg_csselr_el1] :< v))
                  else (
                    if (ofs =? (64))
                    then (Some (st.[e_sysreg_sctlr_el1] :< v))
                    else (
                      if (ofs =? (72))
                      then (Some (st.[e_sysreg_actlr_el1] :< v))
                      else (
                        if (ofs =? (80))
                        then (Some (st.[e_sysreg_cpacr_el1] :< v))
                        else (
                          if (ofs =? (88))
                          then (Some (st.[e_sysreg_zcr_el1] :< v))
                          else (
                            if (ofs =? (96))
                            then (Some (st.[e_sysreg_ttbr0_el1] :< v))
                            else (
                              if (ofs =? (104))
                              then (Some (st.[e_sysreg_ttbr1_el1] :< v))
                              else (
                                if (ofs =? (112))
                                then (Some (st.[e_sysreg_tcr_el1] :< v))
                                else (
                                  if (ofs =? (120))
                                  then (Some (st.[e_sysreg_esr_el1] :< v))
                                  else (
                                    if (ofs =? (128))
                                    then (Some (st.[e_sysreg_afsr0_el1] :< v))
                                    else (
                                      if (ofs =? (136))
                                      then (Some (st.[e_sysreg_afsr1_el1] :< v))
                                      else (
                                        if (ofs =? (144))
                                        then (Some (st.[e_sysreg_far_el1] :< v))
                                        else (
                                          if (ofs =? (152))
                                          then (Some (st.[e_sysreg_mair_el1] :< v))
                                          else (
                                            if (ofs =? (160))
                                            then (Some (st.[e_sysreg_vbar_el1] :< v))
                                            else (
                                              if (ofs =? (168))
                                              then (Some (st.[e_sysreg_contextidr_el1] :< v))
                                              else (
                                                if (ofs =? (176))
                                                then (Some (st.[e_sysreg_tpidr_el1] :< v))
                                                else (
                                                  if (ofs =? (184))
                                                  then (Some (st.[e_sysreg_amair_el1] :< v))
                                                  else (
                                                    if (ofs =? (192))
                                                    then (Some (st.[e_sysreg_cntkctl_el1] :< v))
                                                    else (
                                                      if (ofs =? (200))
                                                      then (Some (st.[e_sysreg_par_el1] :< v))
                                                      else (
                                                        if (ofs =? (208))
                                                        then (Some (st.[e_sysreg_mdscr_el1] :< v))
                                                        else (
                                                          if (ofs =? (216))
                                                          then (Some (st.[e_sysreg_mdccint_el1] :< v))
                                                          else (
                                                            if (ofs =? (224))
                                                            then (Some (st.[e_sysreg_disr_el1] :< v))
                                                            else (
                                                              if (ofs =? (232))
                                                              then (Some (st.[e_sysreg_mpam0_el1] :< v))
                                                              else (
                                                                if (ofs =? (240))
                                                                then (Some (st.[e_sysreg_cnthctl_el2] :< v))
                                                                else (
                                                                  if (ofs =? (248))
                                                                  then (Some (st.[e_sysreg_cntvoff_el2] :< v))
                                                                  else (
                                                                    if (ofs =? (256))
                                                                    then (Some (st.[e_sysreg_cntpoff_el2] :< v))
                                                                    else (
                                                                      if (ofs =? (264))
                                                                      then (Some (st.[e_sysreg_cntp_ctl_el0] :< v))
                                                                      else (
                                                                        if (ofs =? (272))
                                                                        then (Some (st.[e_sysreg_cntp_cval_el0] :< v))
                                                                        else (
                                                                          if (ofs =? (280))
                                                                          then (Some (st.[e_sysreg_cntv_ctl_el0] :< v))
                                                                          else (
                                                                            if (ofs =? (288))
                                                                            then (Some (st.[e_sysreg_cntv_cval_el0] :< v))
                                                                            else (
                                                                              if ((ofs >=? (296)) && ((ofs <? (512))))
                                                                              then (
                                                                                let elem_ofs := (ofs - (296)) in
                                                                                when ret == ((store_s_gic_cpu_state sz elem_ofs v (st.(e_sysreg_gicstate))));
                                                                                (Some (st.[e_sysreg_gicstate] :< ret)))
                                                                              else (
                                                                                if (ofs =? (512))
                                                                                then (Some (st.[e_sysreg_vmpidr_el2] :< v))
                                                                                else (
                                                                                  if (ofs =? (520))
                                                                                  then (Some (st.[e_sysreg_hcr_el2] :< v))
                                                                                  else None))))))))))))))))))))))))))))))))))))))).

  Definition load_s_common_sysreg_state (sz: Z) (ofs: Z) (st: s_common_sysreg_state) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_common_vttbr_el2)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_common_vtcr_el2)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_common_hcr_el2)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_common_mdcr_el2)))
          else None))).

  Definition store_s_common_sysreg_state (sz: Z) (ofs: Z) (v: Z) (st: s_common_sysreg_state) : (option s_common_sysreg_state) :=
    if (ofs =? (0))
    then (Some (st.[e_common_vttbr_el2] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_common_vtcr_el2] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_common_hcr_el2] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_common_mdcr_el2] :< v))
          else None))).

  Definition load_s_set_ripas (sz: Z) (ofs: Z) (st: s_set_ripas) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_start)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_end)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_addr)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_ripas)))
          else None))).

  Definition store_s_set_ripas (sz: Z) (ofs: Z) (v: Z) (st: s_set_ripas) : (option s_set_ripas) :=
    if (ofs =? (0))
    then (Some (st.[e_start] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_end] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_addr] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_ripas] :< v))
          else None))).

  Definition load_s_realm_info (sz: Z) (ofs: Z) (st: s_realm_info) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_ipa_bits)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_s2_starting_level)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_g_rtt)))
        else (
          if (ofs =? (24))
          then (
            rely ((int_is_granule (st.(e_g_rd))));
            (Some (st.(e_g_rd))))
          else (
            if (ofs =? (32))
            then (Some (st.(e_pmu_enabled)))
            else (
              if (ofs =? (36))
              then (Some (st.(e_pmu_num_cnts)))
              else (
                if (ofs =? (40))
                then (Some (st.(e_sve_enabled)))
                else (
                  if (ofs =? (41))
                  then (Some (st.(e_sve_vq)))
                  else None))))))).

  Definition store_s_realm_info (sz: Z) (ofs: Z) (v: Z) (st: s_realm_info) : (option s_realm_info) :=
    if (ofs =? (0))
    then (Some (st.[e_ipa_bits] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_s2_starting_level] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_g_rtt] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_g_rd] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_pmu_enabled] :< v))
            else (
              if (ofs =? (36))
              then (Some (st.[e_pmu_num_cnts] :< v))
              else (
                if (ofs =? (40))
                then (Some (st.[e_sve_enabled] :< v))
                else (
                  if (ofs =? (41))
                  then (Some (st.[e_sve_vq] :< v))
                  else None))))))).

  Definition load_s_last_run_info (sz: Z) (ofs: Z) (st: s_last_run_info) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_esr)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_hpfar)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_far)))
        else None)).

  Definition store_s_last_run_info (sz: Z) (ofs: Z) (v: Z) (st: s_last_run_info) : (option s_last_run_info) :=
    if (ofs =? (0))
    then (Some (st.[e_esr] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_hpfar] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_far] :< v))
        else None)).

  Definition load_s_psci_info (sz: Z) (ofs: Z) (st: s_psci_info) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_pending)))
    else None.

  Definition store_s_psci_info (sz: Z) (ofs: Z) (v: Z) (st: s_psci_info) : (option s_psci_info) :=
    if (ofs =? (0))
    then (Some (st.[e_pending] :< v))
    else None.

  Definition load_s_rec_simd_state (sz: Z) (ofs: Z) (st: s_rec_simd_state) : (option Z) :=
    if (ofs =? (0))
    then (
      let ret := (st.(e_simd)) in
      rely ((ret < (MAX_ERR)));
      rely ((ret >= (SLOT_VIRT)));
      let slot := ((ret - (SLOT_VIRT)) / (GRANULE_SIZE)) in
      rely ((slot >= (SLOT_REC_AUX0)));
      rely ((slot < ((SLOT_REC_AUX0 + (MAX_REC_AUX_GRANULES)))));
      (Some ret))
    else (
      if (ofs =? (8))
      then (Some (st.(e_simd_allowed)))
      else (
        if (ofs =? (9))
        then (Some (st.(e_init_done)))
        else None)).

  Definition store_s_rec_simd_state (sz: Z) (ofs: Z) (v: Z) (st: s_rec_simd_state) : (option s_rec_simd_state) :=
    if (ofs =? (0))
    then (Some (st.[e_simd] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_simd_allowed] :< v))
      else (
        if (ofs =? (9))
        then (Some (st.[e_init_done] :< v))
        else None)).

  Definition load_s_rec_aux_data (sz: Z) (ofs: Z) (st: s_rec_aux_data) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_attest_heap_buf)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_pmu)))
      else (
        if ((ofs >=? (16)) && ((ofs <? (32))))
        then (
          let elem_ofs := (ofs - (16)) in
          (load_s_rec_simd_state sz elem_ofs (st.(e_rec_simd))))
        else None)).

  Definition store_s_rec_aux_data (sz: Z) (ofs: Z) (v: Z) (st: s_rec_aux_data) : (option s_rec_aux_data) :=
    if (ofs =? (0))
    then (Some (st.[e_attest_heap_buf] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_pmu] :< v))
      else (
        if ((ofs >=? (16)) && ((ofs <? (32))))
        then (
          let elem_ofs := (ofs - (16)) in
          when ret == ((store_s_rec_simd_state sz elem_ofs v (st.(e_rec_simd))));
          (Some (st.[e_rec_simd] :< ret)))
        else None)).

  Definition load_s_buffer_alloc_ctx (sz: Z) (ofs: Z) (st: s_buffer_alloc_ctx) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_buf)))
    else (
      if (ofs =? (8))
      then (Some (st.(e__len)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_first)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_first_free)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_verify)))
            else None)))).

  Definition store_s_buffer_alloc_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_buffer_alloc_ctx) : (option s_buffer_alloc_ctx) :=
    if (ofs =? (0))
    then (Some (st.[e_buf] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e__len] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_first] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_first_free] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_verify] :< v))
            else None)))).

  Definition load_s_alloc_info (sz: Z) (ofs: Z) (st: s_alloc_info) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (40))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_buffer_alloc_ctx sz elem_ofs (st.(e__ctx))))
    else (
      if (ofs =? (40))
      then (Some (st.(e_ctx_initialised)))
      else None).

  Definition store_s_alloc_info (sz: Z) (ofs: Z) (v: Z) (st: s_alloc_info) : (option s_alloc_info) :=
    if ((ofs >=? (0)) && ((ofs <? (40))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_buffer_alloc_ctx sz elem_ofs v (st.(e__ctx))));
      (Some (st.[e__ctx] :< ret)))
    else (
      if (ofs =? (40))
      then (Some (st.[e_ctx_initialised] :< v))
      else None).

  Definition load_s_serror_info (sz: Z) (ofs: Z) (st: s_serror_info) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_vsesr_el2)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_inject)))
      else None).

  Definition store_s_serror_info (sz: Z) (ofs: Z) (v: Z) (st: s_serror_info) : (option s_serror_info) :=
    if (ofs =? (0))
    then (Some (st.[e_vsesr_el2] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_inject] :< v))
      else None).

  Definition load_s_rec (sz: Z) (ofs: Z) (st: s_rec) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_g_rec)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_rec_idx)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_runnable)))
        else (
          if ((ofs >=? (24)) && ((ofs <? (272))))
          then (
            let idx := ((ofs - (24)) / (8)) in
            (Some ((st.(e_regs)) @ idx)))
          else (
            if (ofs =? (272))
            then (Some (st.(e_pc)))
            else (
              if (ofs =? (280))
              then (Some (st.(e_pstate)))
              else (
                if ((ofs >=? (288)) && ((ofs <? (816))))
                then (
                  let elem_ofs := (ofs - (288)) in
                  (load_s_sysreg_state sz elem_ofs (st.(e_sysregs))))
                else (
                  if ((ofs >=? (816)) && ((ofs <? (848))))
                  then (
                    let elem_ofs := (ofs - (816)) in
                    (load_s_common_sysreg_state sz elem_ofs (st.(e_common_sysregs))))
                  else (
                    if ((ofs >=? (848)) && ((ofs <? (880))))
                    then (
                      let elem_ofs := (ofs - (848)) in
                      (load_s_set_ripas sz elem_ofs (st.(e_set_ripas))))
                    else (
                      if ((ofs >=? (880)) && ((ofs <? (928))))
                      then (
                        let elem_ofs := (ofs - (880)) in
                        (load_s_realm_info sz elem_ofs (st.(e_realm_info))))
                      else (
                        if ((ofs >=? (928)) && ((ofs <? (952))))
                        then (
                          let elem_ofs := (ofs - (928)) in
                          (load_s_last_run_info sz elem_ofs (st.(e_last_run_info))))
                        else (
                          if (ofs =? (952))
                          then (Some (st.(e_ns)))
                          else (
                            if ((ofs >=? (960)) && ((ofs <? (961))))
                            then (
                              let elem_ofs := (ofs - (960)) in
                              (load_s_psci_info sz elem_ofs (st.(e_psci_info))))
                            else (
                              if (ofs =? (964))
                              then (Some (st.(e_num_rec_aux)))
                              else (
                                if ((ofs >=? (968)) && ((ofs <? (1096))))
                                then (
                                  let idx := ((ofs - (968)) / (8)) in
                                  (Some ((st.(e_g_aux)) @ idx)))
                                else (
                                  if ((ofs >=? (1096)) && ((ofs <? (1128))))
                                  then (
                                    let elem_ofs := (ofs - (1096)) in
                                    (load_s_rec_aux_data sz elem_ofs (st.(e_aux_data))))
                                  else (
                                    if ((ofs >=? (3200)) && ((ofs <? (3248))))
                                    then (
                                      let elem_ofs := (ofs - (3200)) in
                                      (load_s_alloc_info sz elem_ofs (st.(e_alloc_info))))
                                    else (
                                      if ((ofs >=? (3248)) && ((ofs <? (3264))))
                                      then (
                                        let elem_ofs := (ofs - (3248)) in
                                        (load_s_serror_info sz elem_ofs (st.(e_serror_info))))
                                      else (
                                        if (ofs =? (3264))
                                        then (Some (st.(e_host_call)))
                                        else None)))))))))))))))))).

  Definition store_s_rec (sz: Z) (ofs: Z) (v: Z) (st: s_rec) : (option s_rec) :=
    if (ofs =? (0))
    then (Some (st.[e_g_rec] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_rec_idx] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_runnable] :< v))
        else (
          if ((ofs >=? (24)) && ((ofs <? (272))))
          then (
            let idx := ((ofs - (24)) / (8)) in
            (Some (st.[e_regs] :< ((st.(e_regs)) # idx == v))))
          else (
            if (ofs =? (272))
            then (Some (st.[e_pc] :< v))
            else (
              if (ofs =? (280))
              then (Some (st.[e_pstate] :< v))
              else (
                if ((ofs >=? (288)) && ((ofs <? (816))))
                then (
                  let elem_ofs := (ofs - (288)) in
                  when ret == ((store_s_sysreg_state sz elem_ofs v (st.(e_sysregs))));
                  (Some (st.[e_sysregs] :< ret)))
                else (
                  if ((ofs >=? (816)) && ((ofs <? (848))))
                  then (
                    let elem_ofs := (ofs - (816)) in
                    when ret == ((store_s_common_sysreg_state sz elem_ofs v (st.(e_common_sysregs))));
                    (Some (st.[e_common_sysregs] :< ret)))
                  else (
                    if ((ofs >=? (848)) && ((ofs <? (880))))
                    then (
                      let elem_ofs := (ofs - (848)) in
                      when ret == ((store_s_set_ripas sz elem_ofs v (st.(e_set_ripas))));
                      (Some (st.[e_set_ripas] :< ret)))
                    else (
                      if ((ofs >=? (880)) && ((ofs <? (928))))
                      then (
                        let elem_ofs := (ofs - (880)) in
                        when ret == ((store_s_realm_info sz elem_ofs v (st.(e_realm_info))));
                        (Some (st.[e_realm_info] :< ret)))
                      else (
                        if ((ofs >=? (928)) && ((ofs <? (952))))
                        then (
                          let elem_ofs := (ofs - (928)) in
                          when ret == ((store_s_last_run_info sz elem_ofs v (st.(e_last_run_info))));
                          (Some (st.[e_last_run_info] :< ret)))
                        else (
                          if (ofs =? (952))
                          then (Some (st.[e_ns] :< v))
                          else (
                            if ((ofs >=? (960)) && ((ofs <? (961))))
                            then (
                              let elem_ofs := (ofs - (960)) in
                              when ret == ((store_s_psci_info sz elem_ofs v (st.(e_psci_info))));
                              (Some (st.[e_psci_info] :< ret)))
                            else (
                              if (ofs =? (964))
                              then (Some (st.[e_num_rec_aux] :< v))
                              else (
                                if ((ofs >=? (968)) && ((ofs <? (1096))))
                                then (
                                  let idx := ((ofs - (968)) / (8)) in
                                  (Some (st.[e_g_aux] :< ((st.(e_g_aux)) # idx == v))))
                                else (
                                  if ((ofs >=? (1096)) && ((ofs <? (1128))))
                                  then (
                                    let elem_ofs := (ofs - (1096)) in
                                    when ret == ((store_s_rec_aux_data sz elem_ofs v (st.(e_aux_data))));
                                    (Some (st.[e_aux_data] :< ret)))
                                  else (
                                    if ((ofs >=? (3200)) && ((ofs <? (3248))))
                                    then (
                                      let elem_ofs := (ofs - (3200)) in
                                      when ret == ((store_s_alloc_info sz elem_ofs v (st.(e_alloc_info))));
                                      (Some (st.[e_alloc_info] :< ret)))
                                    else (
                                      if ((ofs >=? (3248)) && ((ofs <? (3264))))
                                      then (
                                        let elem_ofs := (ofs - (3248)) in
                                        when ret == ((store_s_serror_info sz elem_ofs v (st.(e_serror_info))));
                                        (Some (st.[e_serror_info] :< ret)))
                                      else (
                                        if (ofs =? (3264))
                                        then (Some (st.[e_host_call] :< v))
                                        else None)))))))))))))))))).

  Definition load_s_pmev_regs (sz: Z) (ofs: Z) (st: s_pmev_regs) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_pmevcntr_el0)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_pmevtyper_el0)))
      else None).

  Definition store_s_pmev_regs (sz: Z) (ofs: Z) (v: Z) (st: s_pmev_regs) : (option s_pmev_regs) :=
    if (ofs =? (0))
    then (Some (st.[e_pmevcntr_el0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_pmevtyper_el0] :< v))
      else None).

  Definition load_s_pmu_state (sz: Z) (ofs: Z) (st: s_pmu_state) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_pmccfiltr_el0)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_pmccntr_el0)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_pmcntenset_el0)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_pmcntenclr_el0)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_pmintenset_el1)))
            else (
              if (ofs =? (40))
              then (Some (st.(e_pmintenclr_el1)))
              else (
                if (ofs =? (48))
                then (Some (st.(e_pmovsset_el0)))
                else (
                  if (ofs =? (56))
                  then (Some (st.(e_pmovsclr_el0)))
                  else (
                    if (ofs =? (64))
                    then (Some (st.(e_pmselr_el0)))
                    else (
                      if (ofs =? (72))
                      then (Some (st.(e_pmuserenr_el0)))
                      else (
                        if (ofs =? (80))
                        then (Some (st.(e_pmxevcntr_el0)))
                        else (
                          if (ofs =? (88))
                          then (Some (st.(e_pmxevtyper_el0)))
                          else (
                            if ((ofs >=? (96)) && ((ofs <? (592))))
                            then (
                              let idx := ((ofs - (96)) / (16)) in
                              let elem_ofs := ((ofs - (96)) mod (16)) in
                              (load_s_pmev_regs sz elem_ofs ((st.(e_pmev_regs)) @ idx)))
                            else None)))))))))))).

  Definition store_s_pmu_state (sz: Z) (ofs: Z) (v: Z) (st: s_pmu_state) : (option s_pmu_state) :=
    if (ofs =? (0))
    then (Some (st.[e_pmccfiltr_el0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_pmccntr_el0] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_pmcntenset_el0] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_pmcntenclr_el0] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_pmintenset_el1] :< v))
            else (
              if (ofs =? (40))
              then (Some (st.[e_pmintenclr_el1] :< v))
              else (
                if (ofs =? (48))
                then (Some (st.[e_pmovsset_el0] :< v))
                else (
                  if (ofs =? (56))
                  then (Some (st.[e_pmovsclr_el0] :< v))
                  else (
                    if (ofs =? (64))
                    then (Some (st.[e_pmselr_el0] :< v))
                    else (
                      if (ofs =? (72))
                      then (Some (st.[e_pmuserenr_el0] :< v))
                      else (
                        if (ofs =? (80))
                        then (Some (st.[e_pmxevcntr_el0] :< v))
                        else (
                          if (ofs =? (88))
                          then (Some (st.[e_pmxevtyper_el0] :< v))
                          else (
                            if ((ofs >=? (96)) && ((ofs <? (592))))
                            then (
                              let idx := ((ofs - (96)) / (16)) in
                              let elem_ofs := ((ofs - (96)) mod (16)) in
                              when ret == ((store_s_pmev_regs sz elem_ofs v ((st.(e_pmev_regs)) @ idx)));
                              (Some (st.[e_pmev_regs] :< ((st.(e_pmev_regs)) # idx == ret))))
                            else None)))))))))))).

  Definition load_s_fpu_state (sz: Z) (ofs: Z) (st: s_fpu_state) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (512))))
    then (
      let idx := ((ofs - (0)) / (16)) in
      (Some ((st.(e_q)) @ idx)))
    else (
      if (ofs =? (512))
      then (Some (st.(e_fpsr)))
      else (
        if (ofs =? (520))
        then (Some (st.(e_fpcr)))
        else None)).

  Definition store_s_fpu_state (sz: Z) (ofs: Z) (v: Z) (st: s_fpu_state) : (option s_fpu_state) :=
    if ((ofs >=? (0)) && ((ofs <? (512))))
    then (
      let idx := ((ofs - (0)) / (16)) in
      (Some (st.[e_q] :< ((st.(e_q)) # idx == v))))
    else (
      if (ofs =? (512))
      then (Some (st.[e_fpsr] :< v))
      else (
        if (ofs =? (520))
        then (Some (st.[e_fpcr] :< v))
        else None)).

  Definition load_u_anon_6 (sz: Z) (ofs: Z) (st: u_anon_6) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (528))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_fpu_state sz elem_ofs (st.(e_fpu))))
    else (
      if ((ofs >=? (528)) && ((ofs <? (8768))))
      then (
        let idx := ((ofs - (528)) / (1)) in
        (Some ((st.(e_padding0)) @ idx)))
      else None).

  Definition store_u_anon_6 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_6) : (option u_anon_6) :=
    if ((ofs >=? (0)) && ((ofs <? (528))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_fpu_state sz elem_ofs v (st.(e_fpu))));
      (Some (st.[e_fpu] :< ret)))
    else (
      if ((ofs >=? (528)) && ((ofs <? (8768))))
      then (
        let idx := ((ofs - (528)) / (1)) in
        (Some (st.[e_padding0] :< ((st.(e_padding0)) # idx == v))))
      else None).

  Definition load_u_anon_7 (sz: Z) (ofs: Z) (st: u_anon_7) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_union_anon_7_0)))
    else (
      if ((ofs >=? (1)) && ((ofs <? (249))))
      then (
        let idx := ((ofs - (1)) / (1)) in
        (Some ((st.(e_union_anon_7_1)) @ idx)))
      else None).
  Definition store_u_anon_7 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_7) : (option u_anon_7) :=
    if (ofs =? (0))
    then (Some (st.[e_union_anon_7_0] :< v))
    else (
      if ((ofs >=? (1)) && ((ofs <? (249))))
      then (
        let idx := ((ofs - (1)) / (1)) in
        (Some (st.[e_union_anon_7_1] :< ((st.(e_union_anon_7_1)) # idx == v))))
      else None).

  Definition load_s_simd_state (sz: Z) (ofs: Z) (st: s_simd_state) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (8768))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_u_anon_6 sz elem_ofs (st.(e_t))))
    else (
      if (ofs =? (8768))
      then (Some (st.(e_simd_type)))
      else None).

  Definition store_s_simd_state (sz: Z) (ofs: Z) (v: Z) (st: s_simd_state) : (option s_simd_state) :=
    if ((ofs >=? (0)) && ((ofs <? (8768))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_u_anon_6 sz elem_ofs v (st.(e_t))));
      (Some (st.[e_t] :< ret)))
    else (
      if (ofs =? (8768))
      then (Some (st.[e_simd_type] :< v))
      else None).

  Definition load_s_ns_simd_state (sz: Z) (ofs: Z) (st: s_ns_simd_state) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (8784))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_simd_state sz elem_ofs (st.(e_ns_simd))))
    else (
      if (ofs =? (8784))
      then (Some (st.(e_ns_zcr_el2)))
      else (
        if (ofs =? (8792))
        then (Some (st.(e_ns_saved)))
        else None)).

  Definition store_s_ns_simd_state (sz: Z) (ofs: Z) (v: Z) (st: s_ns_simd_state) : (option s_ns_simd_state) :=
    if ((ofs >=? (0)) && ((ofs <? (8784))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_simd_state sz elem_ofs v (st.(e_ns_simd))));
      (Some (st.[e_ns_simd] :< ret)))
    else (
      if (ofs =? (8784))
      then (Some (st.[e_ns_zcr_el2] :< v))
      else (
        if (ofs =? (8792))
        then (Some (st.[e_ns_saved] :< v))
        else None)).

  Definition load_u_anon_10 (sz: Z) (ofs: Z) (st: u_anon_10) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (64))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some ((st.(e_union_anon_10_0)) @ idx)))
    else (
      if ((ofs >=? (1)) && ((ofs <? (1217))))
      then (
        let idx := ((ofs - (1)) / (1)) in
        (Some ((st.(e_union_anon_10_1)) @ idx)))
      else None).

  Definition store_u_anon_10 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_10) : (option u_anon_10) :=
    if ((ofs >=? (0)) && ((ofs <? (64))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some (st.[e_union_anon_10_0] :< ((st.(e_union_anon_10_0)) # idx == v))))
    else (
      if ((ofs >=? (1)) && ((ofs <? (1217))))
      then (
        let idx := ((ofs - (1)) / (1)) in
        (Some (st.[e_union_anon_10_1] :< ((st.(e_union_anon_10_1)) # idx == v))))
      else None).

  Definition load_s_anon_14 (sz: Z) (ofs: Z) (st: s_anon_14) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_num_aux)))
    else (
      if ((ofs >=? (8)) && ((ofs <? (136))))
      then (
        let idx := ((ofs - (8)) / (8)) in
        (Some ((st.(e_aux)) @ idx)))
      else None).

  Definition store_s_anon_14 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_14) : (option s_anon_14) :=
    if (ofs =? (0))
    then (Some (st.[e_num_aux] :< v))
    else (
      if ((ofs >=? (8)) && ((ofs <? (136))))
      then (
        let idx := ((ofs - (8)) / (8)) in
        (Some (st.[e_aux] :< ((st.(e_aux)) # idx == v))))
      else None).

  Definition load_u_anon_11_154 (sz: Z) (ofs: Z) (st: u_anon_11_154) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (136))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_anon_14 sz elem_ofs (st.(e_union_anon_11_154_0))))
    else (
      if ((ofs >=? (1)) && ((ofs <? (1913))))
      then (
        let idx := ((ofs - (1)) / (1)) in
        (Some ((st.(e_union_anon_11_154_1)) @ idx)))
      else None).

  Definition store_u_anon_11_154 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_11_154) : (option u_anon_11_154) :=
    if ((ofs >=? (0)) && ((ofs <? (136))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_anon_14 sz elem_ofs v (st.(e_union_anon_11_154_0))));
      (Some (st.[e_union_anon_11_154_0] :< ret)))
    else (
      if ((ofs >=? (1)) && ((ofs <? (1913))))
      then (
        let idx := ((ofs - (1)) / (1)) in
        (Some (st.[e_union_anon_11_154_1] :< ((st.(e_union_anon_11_154_1)) # idx == v))))
      else None).

  Definition load_s_rmi_rec_params (sz: Z) (ofs: Z) (st: s_rmi_rec_params) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (256))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_u_anon_7 sz elem_ofs (st.(e_rmi_rec_params_0))))
    else (
      if ((ofs >=? (256)) && ((ofs <? (512))))
      then (
        let elem_ofs := (ofs - (256)) in
        (load_u_anon_7 sz elem_ofs (st.(e_rmi_rec_params_1))))
      else (
        if ((ofs >=? (512)) && ((ofs <? (768))))
        then (
          let elem_ofs := (ofs - (512)) in
          (load_u_anon_7 sz elem_ofs (st.(e_rmi_rec_params_2))))
        else (
          if ((ofs >=? (768)) && ((ofs <? (2048))))
          then (
            let elem_ofs := (ofs - (768)) in
            (load_u_anon_10 sz elem_ofs (st.(e_rmi_rec_params_3))))
          else (
            if ((ofs >=? (2048)) && ((ofs <? (4096))))
            then (
              let elem_ofs := (ofs - (2048)) in
              (load_u_anon_11_154 sz elem_ofs (st.(e_rmi_rec_params_4))))
            else None)))).

  Definition store_s_rmi_rec_params (sz: Z) (ofs: Z) (v: Z) (st: s_rmi_rec_params) : (option s_rmi_rec_params) :=
    if ((ofs >=? (0)) && ((ofs <? (256))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_u_anon_7 sz elem_ofs v (st.(e_rmi_rec_params_0))));
      (Some (st.[e_rmi_rec_params_0] :< ret)))
    else (
      if ((ofs >=? (256)) && ((ofs <? (512))))
      then (
        let elem_ofs := (ofs - (256)) in
        when ret == ((store_u_anon_7 sz elem_ofs v (st.(e_rmi_rec_params_1))));
        (Some (st.[e_rmi_rec_params_1] :< ret)))
      else (
        if ((ofs >=? (512)) && ((ofs <? (768))))
        then (
          let elem_ofs := (ofs - (512)) in
          when ret == ((store_u_anon_7 sz elem_ofs v (st.(e_rmi_rec_params_2))));
          (Some (st.[e_rmi_rec_params_2] :< ret)))
        else (
          if ((ofs >=? (768)) && ((ofs <? (2048))))
          then (
            let elem_ofs := (ofs - (768)) in
            when ret == ((store_u_anon_10 sz elem_ofs v (st.(e_rmi_rec_params_3))));
            (Some (st.[e_rmi_rec_params_3] :< ret)))
          else (
            if ((ofs >=? (2048)) && ((ofs <? (4096))))
            then (
              let elem_ofs := (ofs - (2048)) in
              when ret == ((store_u_anon_11_154 sz elem_ofs v (st.(e_rmi_rec_params_4))));
              (Some (st.[e_rmi_rec_params_4] :< ret)))
            else None)))).

  Definition load_s_rtt_walk (sz: Z) (ofs: Z) (st: s_rtt_walk) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_g_llt)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_index)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_last_level)))
        else None)).

  Definition store_s_rtt_walk (sz: Z) (ofs: Z) (v: Z) (st: s_rtt_walk) : (option s_rtt_walk) :=
    if (ofs =? (0))
    then (Some (st.[e_g_llt] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_index] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_last_level] :< v))
        else None)).

  Definition load_u_anon_0_95 (sz: Z) (ofs: Z) (st: u_anon_0_95) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (768))))
    then (
      let idx := ((ofs - (0)) / (1)) in
      (Some ((st.(e_union_anon_0_95_0)) @ idx)))
    else None.

  Definition store_u_anon_0_95 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_0_95) : (option u_anon_0_95) :=
    if ((ofs >=? (0)) && ((ofs <? (768))))
    then (
      let idx := ((ofs - (0)) / (1)) in
      (Some (st.[e_union_anon_0_95_0] :< ((st.(e_union_anon_0_95_0)) # idx == v))))
    else None.

  Definition load_u_anon_1_96 (sz: Z) (ofs: Z) (st: u_anon_1_96) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (1024))))
    then (
      let idx := ((ofs - (0)) / (1)) in
      (Some ((st.(e_union_anon_1_96_0)) @ idx)))
    else None.

  Definition store_u_anon_1_96 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_1_96) : (option u_anon_1_96) :=
    if ((ofs >=? (0)) && ((ofs <? (1024))))
    then (
      let idx := ((ofs - (0)) / (1)) in
      (Some (st.[e_union_anon_1_96_0] :< ((st.(e_union_anon_1_96_0)) # idx == v))))
    else None.

  Definition load_s_anon_97 (sz: Z) (ofs: Z) (st: s_anon_97) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_vmid)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_rtt_base)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_rtt_level_start)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_rtt_num_start)))
          else None))).

  Definition store_s_anon_97 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_97) : (option s_anon_97) :=
    if (ofs =? (0))
    then (Some (st.[e_vmid] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_rtt_base] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_rtt_level_start] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_rtt_num_start] :< v))
          else None))).

  Definition load_u_anon_2_98 (sz: Z) (ofs: Z) (st: u_anon_2_98) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_anon_97 sz elem_ofs (st.(e_union_anon_2_98_0))))
    else (
      if ((ofs >=? (1)) && ((ofs <? (2017))))
      then (
        let idx := ((ofs - (1)) / (1)) in
        (Some ((st.(e_union_anon_2_98_1)) @ idx)))
      else None).

  Definition store_u_anon_2_98 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_2_98) : (option u_anon_2_98) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_anon_97 sz elem_ofs v (st.(e_union_anon_2_98_0))));
      (Some (st.[e_union_anon_2_98_0] :< ret)))
    else (
      if ((ofs >=? (1)) && ((ofs <? (2017))))
      then (
        let idx := ((ofs - (1)) / (1)) in
        (Some (st.[e_union_anon_2_98_1] :< ((st.(e_union_anon_2_98_1)) # idx == v))))
      else None).

  Definition load_s_rmi_realm_params (sz: Z) (ofs: Z) (st: s_rmi_realm_params) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (256))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_u_anon_7 sz elem_ofs (st.(e_rmi_realm_params_0))))
    else (
      if ((ofs >=? (256)) && ((ofs <? (1024))))
      then (
        let elem_ofs := (ofs - (256)) in
        (load_u_anon_0_95 sz elem_ofs (st.(e_rmi_realm_params_1))))
      else (
        if ((ofs >=? (1024)) && ((ofs <? (2048))))
        then (
          let elem_ofs := (ofs - (1024)) in
          (load_u_anon_1_96 sz elem_ofs (st.(e_rmi_realm_params_2))))
        else (
          if ((ofs >=? (2048)) && ((ofs <? (4096))))
          then (
            let elem_ofs := (ofs - (2048)) in
            (load_u_anon_2_98 sz elem_ofs (st.(e_rmi_realm_params_3))))
          else None))).

  Definition store_s_rmi_realm_params (sz: Z) (ofs: Z) (v: Z) (st: s_rmi_realm_params) : (option s_rmi_realm_params) :=
    if ((ofs >=? (0)) && ((ofs <? (256))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_u_anon_7 sz elem_ofs v (st.(e_rmi_realm_params_0))));
      (Some (st.[e_rmi_realm_params_0] :< ret)))
    else (
      if ((ofs >=? (256)) && ((ofs <? (1024))))
      then (
        let elem_ofs := (ofs - (256)) in
        when ret == ((store_u_anon_0_95 sz elem_ofs v (st.(e_rmi_realm_params_1))));
        (Some (st.[e_rmi_realm_params_1] :< ret)))
      else (
        if ((ofs >=? (1024)) && ((ofs <? (2048))))
        then (
          let elem_ofs := (ofs - (1024)) in
          when ret == ((store_u_anon_1_96 sz elem_ofs v (st.(e_rmi_realm_params_2))));
          (Some (st.[e_rmi_realm_params_2] :< ret)))
        else (
          if ((ofs >=? (2048)) && ((ofs <? (4096))))
          then (
            let elem_ofs := (ofs - (2048)) in
            when ret == ((store_u_anon_2_98 sz elem_ofs v (st.(e_rmi_realm_params_3))));
            (Some (st.[e_rmi_realm_params_3] :< ret)))
          else None))).

  Definition load_s_granule (sz: Z) (ofs: Z) (st: s_granule) : (option Z) :=
    if (ofs =? (4))
    then (Some (st.(e_state)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_refcount)))
      else None).

  Definition store_s_granule (sz: Z) (ofs: Z) (v: Z) (st: s_granule) : (option s_granule) :=
    if (ofs =? (0))
    then (
      match ((st.(e_lock))) with
      | None => (Some (st.[e_lock] :< (Some v)))
      | (Some cid) => None
      end)
    else (
      if (ofs =? (4))
      then (
        when cid == ((st.(e_lock)));
        (Some (st.[e_state] :< v)))
      else (
        if (ofs =? (8))
        then (
          when cid == ((st.(e_lock)));
          if (v <? (0))
          then None
          else (Some (st.[e_refcount] :< v)))
        else None)).

  Definition load_s_realm_s2_context (sz: Z) (ofs: Z) (st: s_realm_s2_context) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_rls2ctx_ipa_bits)))
    else (
      if (ofs =? (4))
      then (Some (st.(e_rls2ctx_s2_starting_level)))
      else (
        if (ofs =? (8))
        then (Some (st.(e_rls2ctx_num_root_rtts)))
        else (
          if (ofs =? (16))
          then (Some (st.(e_rls2ctx_g_rtt)))
          else (
            if (ofs =? (24))
            then (Some (st.(e_rls2ctx_vmid)))
            else None)))).

  Definition store_s_realm_s2_context (sz: Z) (ofs: Z) (v: Z) (st: s_realm_s2_context) : (option s_realm_s2_context) :=
    if (ofs =? (0))
    then (Some (st.[e_rls2ctx_ipa_bits] :< v))
    else (
      if (ofs =? (4))
      then (Some (st.[e_rls2ctx_s2_starting_level] :< v))
      else (
        if (ofs =? (8))
        then (Some (st.[e_rls2ctx_num_root_rtts] :< v))
        else (
          if (ofs =? (16))
          then (Some (st.[e_rls2ctx_g_rtt] :< v))
          else (
            if (ofs =? (24))
            then (Some (st.[e_rls2ctx_vmid] :< v))
            else None)))).

  Definition load_s_rd (sz: Z) (ofs: Z) (st: s_rd) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_rd_rd_state)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_rd_rec_count)))
      else (
        if ((ofs >=? (16)) && ((ofs <? (48))))
        then (
          let elem_ofs := (ofs - (16)) in
          (load_s_realm_s2_context sz elem_ofs (st.(e_rd_s2_ctx))))
        else (
          if (ofs =? (48))
          then (Some (st.(e_rd_num_rec_aux)))
          else (
            if (ofs =? (52))
            then (Some (st.(e_rd_algorithm)))
            else (
              if (ofs =? (56))
              then (Some (st.(e_rd_pmu_enabled)))
              else (
                if (ofs =? (60))
                then (Some (st.(e_rd_pmu_num_cnts)))
                else (
                  if (ofs =? (64))
                  then (Some (st.(e_rd_sve_enabled)))
                  else (
                    if (ofs =? (65))
                    then (Some (st.(e_rd_sve_vq)))
                    else (
                      if ((ofs >=? (66)) && ((ofs <? (386))))
                      then (
                        let idx := ((ofs - (66)) / (64)) in
                        None)
                      else (
                        if ((ofs >=? (386)) && ((ofs <? (450))))
                        then (
                          let idx := ((ofs - (386)) / (1)) in
                          (Some ((st.(e_rd_rpv)) @ idx)))
                        else None)))))))))).

  Definition store_s_rd (sz: Z) (ofs: Z) (v: Z) (st: s_rd) : (option s_rd) :=
    if (ofs =? (0))
    then (Some (st.[e_rd_rd_state] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_rd_rec_count] :< v))
      else (
        if ((ofs >=? (16)) && ((ofs <? (48))))
        then (
          let elem_ofs := (ofs - (16)) in
          when ret == ((store_s_realm_s2_context sz elem_ofs v (st.(e_rd_s2_ctx))));
          (Some (st.[e_rd_s2_ctx] :< ret)))
        else (
          if (ofs =? (48))
          then (Some (st.[e_rd_num_rec_aux] :< v))
          else (
            if (ofs =? (52))
            then (Some (st.[e_rd_algorithm] :< v))
            else (
              if (ofs =? (56))
              then (Some (st.[e_rd_pmu_enabled] :< v))
              else (
                if (ofs =? (60))
                then (Some (st.[e_rd_pmu_num_cnts] :< v))
                else (
                  if (ofs =? (64))
                  then (Some (st.[e_rd_sve_enabled] :< v))
                  else (
                    if (ofs =? (65))
                    then (Some (st.[e_rd_sve_vq] :< v))
                    else (
                      if ((ofs >=? (66)) && ((ofs <? (386))))
                      then (
                        let idx := ((ofs - (66)) / (64)) in
                        None)
                      else (
                        if ((ofs >=? (386)) && ((ofs <? (450))))
                        then (
                          let idx := ((ofs - (386)) / (1)) in
                          (Some (st.[e_rd_rpv] :< ((st.(e_rd_rpv)) # idx == v))))
                        else None)))))))))).

  Definition load_s_granule_set (sz: Z) (ofs: Z) (st: s_granule_set) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_gset_idx)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_gset_addr)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_gset_state)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_gset_g)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_gset_g_ret)))
            else None)))).

  Definition store_s_granule_set (sz: Z) (ofs: Z) (v: Z) (st: s_granule_set) : (option s_granule_set) :=
    if (ofs =? (0))
    then (Some (st.[e_gset_idx] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_gset_addr] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_gset_state] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_gset_g] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_gset_g_ret] :< v))
            else None)))).

  Definition store_s_s2_walk_result (sz: Z) (ofs: Z) (v: Z) (st: s_s2_walk_result) : (option s_s2_walk_result) :=
    if (ofs =? (0))
    then (Some (st.[e_walk_pa] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_walk_rtt_level] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_walk_ripas] :< v))
        else (
          if (ofs =? (20))
          then (Some (st.[e_walk_destroyed] :< v))
          else (
            if (ofs =? (24))
            then (Some (st.[e_walk_llt] :< v))
            else None)))).

  Definition load_s_s2_walk_result (sz: Z) (ofs: Z) (st: s_s2_walk_result) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_walk_pa)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_walk_rtt_level)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_walk_ripas)))
        else (
          if (ofs =? (20))
          then (Some (st.(e_walk_destroyed)))
          else (
            if (ofs =? (24))
            then (Some (st.(e_walk_llt)))
            else None)))).

  Definition stack_ptr_extract_ofs (ofs: Z) : Z :=
    (ofs mod (MaxStackOrder)).

  Definition stack_ptr_extract_slot (ofs: Z) : Z :=
    (ofs / (MaxStackOrder)).

  Definition s_granule_set_size  : Z :=
    40.

  Definition load_s_xlat_llt_info (sz: Z) (ofs: Z) (st: s_xlat_llt_info) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(llt_info_table)))
    else (
      if (ofs =? (8))
      then (Some (st.(llt_info_llt_base_va)))
      else (
        if (ofs =? (16))
        then (Some (st.(llt_info_level)))
        else None)).

  Definition store_s_xlat_llt_info (sz: Z) (ofs: Z) (v: Z) (st: s_xlat_llt_info) : (option s_xlat_llt_info) :=
    if (ofs =? (0))
    then (Some (st.[llt_info_table] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[llt_info_llt_base_va] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[llt_info_level] :< v))
        else None)).

  Definition RMI_HASH_ALGO_SHA256  : Z :=
    0.

  Definition RMI_HASH_ALGO_SHA512  : Z :=
    1.

  Definition HASH_ALGO_SHA256  : Z :=
    RMI_HASH_ALGO_SHA256.

  Definition HASH_ALGO_SHA512  : Z :=
    RMI_HASH_ALGO_SHA512.

  Definition SHA256_SIZE  : Z :=
    32.

  Definition SHA512_SIZE  : Z :=
    64.

  Definition query_oracle (st: RData) : (option RData) :=
    let lo := ((st.(oracle)) (st.(log))) in
    when sh == (((st.(repl)) lo (st.(share))));
    (Some ((st.[log] :< (lo ++ ((st.(log))))).[share] :< sh)).

  Definition REC_HEAP_SIZE  : Z :=
    8192.

  Definition REC_PMU_SIZE  : Z :=
    8192.

  Definition NS_SIMD_SIZE  : Z :=
    8800.

  Definition GRANULE_STATE_NS  : Z :=
    0.

  Definition GRANULE_STATE_UNDELEGATED  : Z :=
    GRANULE_STATE_NS.

  Definition GRANULE_STATE_DELEGATED  : Z :=
    1.

  Definition GRANULE_STATE_RD  : Z :=
    2.

  Definition GRANULE_STATE_REC  : Z :=
    3.

  Definition GRANULE_STATE_REC_AUX  : Z :=
    4.

  Definition GRANULE_STATE_DATA  : Z :=
    5.

  Definition GRANULE_STATE_RTT  : Z :=
    6.

  Definition GRANULE_STATE_LAST  : Z :=
    GRANULE_STATE_RTT.

  Definition int_is_g0 (v: Z) : Prop :=
    ((v > (0)) /\ (((((v - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) = (STACK_g0)))).

  Definition int_is_g1 (v: Z) : Prop :=
    ((v > (0)) /\ (((((v - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) = (STACK_g1)))).

  Definition rec_is_locked (st: RData) : Prop :=
    (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))).

  Definition rec_is_unlocked (st: RData) : Prop :=
    (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)).

  Definition rec_aux_is_locked (st: RData) : Prop :=
    let g_idx := (((st.(share)).(slots)) @ SLOT_REC_AUX0) in
    let g_data := (((st.(share)).(granule_data)) @ g_idx) in
    let parent_g_idx := (g_data.(rec_gidx)) in
    let parent_g_data := (((st.(share)).(granule_data)) @ parent_g_idx) in
    let parent_g := (((st.(share)).(granules)) @ parent_g_idx) in
    ((parent_g.(e_lock)) = ((Some CPU_ID))).

  Definition rec_aux_is_unlocked (st: RData) : Prop :=
    let g_idx := (((st.(share)).(slots)) @ SLOT_REC_AUX0) in
    let g_data := (((st.(share)).(granule_data)) @ g_idx) in
    let parent_g_idx := (g_data.(rec_gidx)) in
    let parent_g_data := (((st.(share)).(granule_data)) @ parent_g_idx) in
    let parent_g := (((st.(share)).(granules)) @ parent_g_idx) in
    ((parent_g.(e_lock)) = (None)).

  Definition rec_aux_refcount_zero (st: RData) : Prop :=
    let g_idx := (((st.(share)).(slots)) @ SLOT_REC_AUX0) in
    let g_data := (((st.(share)).(granule_data)) @ g_idx) in
    let parent_g_idx := (g_data.(rec_gidx)) in
    let parent_g_data := (((st.(share)).(granule_data)) @ parent_g_idx) in
    let parent_g := (((st.(share)).(granules)) @ parent_g_idx) in
    ((parent_g.(e_refcount)) = (0)).

  Definition rec_aux_refcount_one (st: RData) : Prop :=
    let g_idx := (((st.(share)).(slots)) @ SLOT_REC_AUX0) in
    let g_data := (((st.(share)).(granule_data)) @ g_idx) in
    let parent_g_idx := (g_data.(rec_gidx)) in
    let parent_g_data := (((st.(share)).(granule_data)) @ parent_g_idx) in
    let parent_g := (((st.(share)).(granules)) @ parent_g_idx) in
    ((parent_g.(e_refcount)) = (1)).

  Definition rec_has_rd (st: RData) : Prop :=
    (((int_to_ptr ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd))).(pbase)) = ("granules")).

  Definition rec_no_rd (st: RData) : Prop :=
    (((int_to_ptr ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd))).(pbase)) = ("null")).

  Definition rec_refcount_zero (st: RData) : Prop :=
    (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (0)).

  Definition rec_refcount_one (st: RData) : Prop :=
    (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)).

  Definition rd_is_locked (st: RData) : Prop :=
    (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))).

  Definition rec_field_accessible (rec_granule: s_granule) (locked: bool) (st: RData) : bool :=
    if locked
    then ((rec_granule.(e_refcount)) =? (0))
    else ((rec_granule.(e_refcount)) =? (1)).

  Definition _rec_field_accessible (rec: s_rec) (ofs: Z) (rec_granule: s_granule) (locked: bool) (st: RData) : bool :=
    let rec_g_rd := (int_to_ptr ((rec.(e_realm_info)).(e_g_rd))) in
    if ((rec_g_rd.(pbase)) =s ("granules"))
    then (
      let ofs := (rec_g_rd.(poffset)) in
      let idx := (ofs / (ST_GRANULE_SIZE)) in
      let g_data := (((st.(share)).(granule_data)) @ idx) in
      let g := (((st.(share)).(granules)) @ idx) in
      if ((g.(e_state)) <>? (GRANULE_STATE_RD))
      then locked
      else (
        if (((g_data.(g_rd)).(e_rd_rd_state)) <>? (REALM_STATE_ACTIVE))
        then locked
        else (
          if ((ofs >=? (848)) && ((ofs <? (880))))
          then locked
          else (
            if ((g.(e_refcount)) =? (1))
            then (! locked)
            else (
              if ((g.(e_refcount)) =? (0))
              then locked
              else false)))))
    else locked.

  Definition rd_field_accessible (rd: s_rd) (ofs: Z) (rd_granule: s_granule) (write: bool) (st: RData) : bool :=
    if write
    then (
      match ((rd_granule.(e_lock))) with
      | (Some cid) => true
      | None => false
      end)
    else true.

  Definition s_granule_field_accessible (g: s_granule) (ofs: Z) : bool :=
    if (ofs =? (4))
    then (
      match ((g.(e_lock))) with
      | (Some cid) => true
      | None => false
      end)
    else (
      if (ofs =? (8))
      then (
        if ((g.(e_state)) =? (GRANULE_STATE_RD))
        then true
        else (
          match ((g.(e_lock))) with
          | (Some cid) => true
          | None => false
          end))
      else false).

  Definition load_RData (sz: Z) (p: Ptr) (st: RData) : (option (Z * RData)) :=
    if ((p.(pbase)) =s ("sysreg_handlers"))
    then (Some (sysreg_handlers_base, st))
    else (
      if ((p.(pbase)) =s ("gic_virt_feature_0"))
      then (Some (gic_virt_feature_0, st))
      else (
        if ((p.(pbase)) =s ("gic_virt_feature_1"))
        then (Some (gic_virt_feature_1, st))
        else (
          if ((p.(pbase)) =s ("gic_virt_feature_2"))
          then (Some (gic_virt_feature_2, st))
          else (
            if ((p.(pbase)) =s ("gic_virt_feature_3"))
            then (Some (gic_virt_feature_3, st))
            else (
              if ((p.(pbase)) =s ("gic_virt_feature_4"))
              then (Some (gic_virt_feature_4, st))
              else (
                if ((p.(pbase)) =s ("granules"))
                then (
                  let ofs := (p.(poffset)) in
                  let idx := (ofs / (ST_GRANULE_SIZE)) in
                  let ofs := (ofs mod (ST_GRANULE_SIZE)) in
                  if (s_granule_field_accessible (((st.(share)).(granules)) @ idx) ofs)
                  then (
                    when ret == ((load_s_granule sz ofs (((st.(share)).(granules)) @ idx)));
                    (Some (ret, st)))
                  else None)
                else (
                  if ((p.(pbase)) =s ("slot_rd"))
                  then (
                    let ofs := (p.(poffset)) in
                    let g_idx := (((st.(share)).(slots)) @ SLOT_RD) in
                    let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                    let g := (((st.(share)).(granules)) @ g_idx) in
                    if (rd_field_accessible (g_data.(g_rd)) ofs g false st)
                    then (
                      when cid == ((g.(e_lock)));
                      when ret == ((load_s_rd sz ofs (g_data.(g_rd))));
                      (Some (ret, st)))
                    else None)
                  else (
                    if ((p.(pbase)) =s ("slot_rec"))
                    then (
                      let ofs := (p.(poffset)) in
                      let g_idx := (((st.(share)).(slots)) @ SLOT_REC) in
                      let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                      let g := (((st.(share)).(granules)) @ g_idx) in
                      let locked := (
                          match ((g.(e_lock))) with
                          | (Some cid) => true
                          | None => false
                          end) in
                      if (rec_field_accessible g locked st)
                      then (
                        when ret == ((load_s_rec sz ofs (g_data.(g_rec))));
                        (Some (ret, st)))
                      else None)
                    else (
                      if ((p.(pbase)) =s ("slot_rec2"))
                      then (
                        let ofs := (p.(poffset)) in
                        let g_idx := (((st.(share)).(slots)) @ SLOT_REC2) in
                        let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                        let g := (((st.(share)).(granules)) @ g_idx) in
                        let locked := (
                            match ((g.(e_lock))) with
                            | (Some cid) => true
                            | None => false
                            end) in
                        if (rec_field_accessible g locked st)
                        then (
                          when ret == ((load_s_rec sz ofs (g_data.(g_rec))));
                          (Some (ret, st)))
                        else None)
                      else (
                        if ((p.(pbase)) =s ("slot_rtt"))
                        then (
                          let ofs := (p.(poffset)) in
                          let g_idx := (((st.(share)).(slots)) @ SLOT_RTT) in
                          let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                          let g := (((st.(share)).(granules)) @ g_idx) in
                          when cid == ((g.(e_lock)));
                          (Some (((g_data.(g_norm)) @ ofs), st)))
                        else (
                          if ((p.(pbase)) =s ("slot_rtt2"))
                          then (
                            let ofs := (p.(poffset)) in
                            let g_idx := (((st.(share)).(slots)) @ SLOT_RTT2) in
                            let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                            let g := (((st.(share)).(granules)) @ g_idx) in
                            when cid == ((g.(e_lock)));
                            (Some (((g_data.(g_norm)) @ ofs), st)))
                          else (
                            if ((p.(pbase)) =s ("slot_rsi_call"))
                            then (
                              let ofs := (p.(poffset)) in
                              let g_idx := (((st.(share)).(slots)) @ SLOT_RSI_CALL) in
                              let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                              (Some (((g_data.(g_norm)) @ ofs), st)))
                            else (
                              if ((p.(pbase)) =s ("slot_delegated"))
                              then (
                                let ofs := (p.(poffset)) in
                                let g_idx := (((st.(share)).(slots)) @ SLOT_DELEGATED) in
                                let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                                let g := (((st.(share)).(granules)) @ g_idx) in
                                when cid == ((g.(e_lock)));
                                (Some (((g_data.(g_norm)) @ ofs), st)))
                              else (
                                if ((p.(pbase)) =s ("slot_rec_aux0"))
                                then (
                                  let ofs := (p.(poffset)) in
                                  let g_idx := (((st.(share)).(slots)) @ SLOT_REC_AUX0) in
                                  let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                                  let parent_g_idx := (g_data.(rec_gidx)) in
                                  let parent_g_data := (((st.(share)).(granule_data)) @ parent_g_idx) in
                                  let parent_g := (((st.(share)).(granules)) @ parent_g_idx) in
                                  let locked := (
                                      match ((parent_g.(e_lock))) with
                                      | (Some cid) => true
                                      | None => false
                                      end) in
                                  if (rec_field_accessible parent_g locked st)
                                  then (
                                    if ((0 <=? (ofs)) && ((ofs <? (REC_HEAP_SIZE))))
                                    then (Some (0, st))
                                    else (
                                      if ((REC_HEAP_SIZE <=? (ofs)) && ((ofs <? ((REC_HEAP_SIZE + (REC_PMU_SIZE))))))
                                      then (
                                        when ret == ((load_s_pmu_state sz (ofs - (REC_HEAP_SIZE)) (g_data.(g_aux_pmu_state))));
                                        (Some (ret, st)))
                                      else (
                                        if ((REC_HEAP_SIZE + (REC_PMU_SIZE)) <=? (ofs))
                                        then (
                                          when ret == ((load_s_simd_state sz ((ofs - (REC_HEAP_SIZE)) - (REC_PMU_SIZE)) (g_data.(g_aux_simd_state))));
                                          (Some (ret, st)))
                                        else None)))
                                  else None)
                                else (
                                  if ((p.(pbase)) =s ("bad_stack"))
                                  then (
                                    let ofs := (p.(poffset)) in
                                    (Some (DEFAULT_STACK_VAL, st)))
                                  else (
                                    if ((p.(pbase)) =s ("stack"))
                                    then (
                                      let ofs := (p.(poffset)) in
                                      let slot_nr := (stack_ptr_extract_slot ofs) in
                                      let slot_ofs := (stack_ptr_extract_ofs ofs) in
                                      rely ((((((((st.(priv)).(pcpu_stack)) @ slot_nr).(sf_data)) @ slot_ofs).(sd_size)) = (sz)));
                                      (Some (((((((st.(priv)).(pcpu_stack)) @ slot_nr).(sf_data)) @ slot_ofs).(sd_data)), st)))
                                    else (
                                      if ((p.(pbase)) =s ("stack_wi"))
                                      then (
                                        when ret == ((load_s_rtt_walk sz (p.(poffset)) ((st.(stack)).(stack_wi))));
                                        (Some (ret, st)))
                                      else (
                                        if ((p.(pbase)) =s ("stack_g_tbls"))
                                        then (
                                          let idx := ((p.(poffset)) / (8)) in
                                          let ptr := (((st.(stack)).(stack_g_tbls)) @ idx) in
                                          rely ((int_is_granule ptr));
                                          (Some (ptr, st)))
                                        else (
                                          if ((p.(pbase)) =s ("stack_gs"))
                                          then (
                                            let idx := ((p.(poffset)) / (40)) in
                                            let ofs := ((p.(poffset)) mod (40)) in
                                            if (idx =? (0))
                                            then (
                                              when ret == ((load_s_granule_set sz ofs ((st.(stack)).(stack_gs0))));
                                              if (ofs =? (24))
                                              then (
                                                rely ((int_is_granule ret));
                                                (Some (ret, st)))
                                              else (
                                                if (ofs =? (32))
                                                then (
                                                  rely ((int_is_g0 ret));
                                                  (Some (ret, st)))
                                                else (Some (ret, st))))
                                            else (
                                              when ret == ((load_s_granule_set sz ofs ((st.(stack)).(stack_gs1))));
                                              if (ofs =? (24))
                                              then (
                                                rely ((int_is_granule ret));
                                                (Some (ret, st)))
                                              else (
                                                if (ofs =? (32))
                                                then (
                                                  rely ((int_is_g1 ret));
                                                  (Some (ret, st)))
                                                else (Some (ret, st)))))
                                          else (
                                            if ((p.(pbase)) =s ("stack_gs_temp"))
                                            then (
                                              when ret == ((load_s_granule_set sz (p.(poffset)) ((st.(stack)).(stack_gs_temp))));
                                              if ((p.(poffset)) =? (24))
                                              then (
                                                rely ((int_is_granule ret));
                                                (Some (ret, st)))
                                              else (Some (ret, st)))
                                            else (
                                              if ((p.(pbase)) =s ("stack_g0"))
                                              then (
                                                rely ((int_is_granule ((st.(stack)).(stack_g0))));
                                                (Some (((st.(stack)).(stack_g0)), st)))
                                              else (
                                                if ((p.(pbase)) =s ("stack_g1"))
                                                then (
                                                  rely ((int_is_granule ((st.(stack)).(stack_g1))));
                                                  (Some (((st.(stack)).(stack_g1)), st)))
                                                else (
                                                  if ((p.(pbase)) =s ("stack_s2_ctx"))
                                                  then (
                                                    when ret == ((load_s_realm_s2_context sz (p.(poffset)) ((st.(stack)).(stack_s2_ctx))));
                                                    (Some (ret, st)))
                                                  else (
                                                    if ((p.(pbase)) =s ("stack_ripas_ptr"))
                                                    then (Some (((st.(stack)).(stack_ripas_ptr)), st))
                                                    else (
                                                      if ((p.(pbase)) =s ("stack_ripas"))
                                                      then (Some (((st.(stack)).(stack_ripas)), st))
                                                      else (
                                                        if ((p.(pbase)) =s ("stack_rtt_level"))
                                                        then (Some (((st.(stack)).(stack_rtt_level)), st))
                                                        else (
                                                          if ((p.(pbase)) =s ("stack_walk_res"))
                                                          then (
                                                            when ret == ((load_s_s2_walk_result sz (p.(poffset)) ((st.(stack)).(stack_walk_res))));
                                                            (Some (ret, st)))
                                                          else (
                                                            if ((p.(pbase)) =s ("stack_s2tte"))
                                                            then (Some (((st.(stack)).(stack_s2tte)), st))
                                                            else (
                                                              if ((p.(pbase)) =s ("stack_realm_params"))
                                                              then (
                                                                when ret == ((load_s_rmi_realm_params sz (p.(poffset)) ((st.(stack)).(stack_realm_params))));
                                                                (Some (ret, st)))
                                                              else (
                                                                if ((p.(pbase)) =s ("__const_arch_feat_get_pa_width_pa_range_bits_arr"))
                                                                then (
                                                                  let ofs := (p.(poffset)) in
                                                                  if (ofs =? (0))
                                                                  then (Some (32, st))
                                                                  else (
                                                                    if (ofs =? (4))
                                                                    then (Some (36, st))
                                                                    else (
                                                                      if (ofs =? (8))
                                                                      then (Some (40, st))
                                                                      else (
                                                                        if (ofs =? (12))
                                                                        then (Some (42, st))
                                                                        else (
                                                                          if (ofs =? (16))
                                                                          then (Some (44, st))
                                                                          else (
                                                                            if (ofs =? (20))
                                                                            then (Some (48, st))
                                                                            else (
                                                                              if (ofs =? (24))
                                                                              then (Some (52, st))
                                                                              else None)))))))
                                                                else (
                                                                  if ((p.(pbase)) =s ("g_sve_max_vq"))
                                                                  then (
                                                                    let ofs := (p.(poffset)) in
                                                                    (Some (((st.(share)).(gv_g_sve_max_vq)), st)))
                                                                  else (
                                                                    if ((p.(pbase)) =s ("g_ns_simd"))
                                                                    then (
                                                                      let ofs := (p.(poffset)) in
                                                                      let ret := (((st.(share)).(gv_g_ns_simd)) @ ofs) in
                                                                      (Some (ret, st)))
                                                                    else (
                                                                      if ((p.(pbase)) =s ("g_cpu_simd_type"))
                                                                      then (
                                                                        let ofs := (p.(poffset)) in
                                                                        (Some (((st.(share)).(gv_g_cpu_simd_type)), st)))
                                                                      else (
                                                                        if ((p.(pbase)) =s ("llt_info_cache"))
                                                                        then (
                                                                          let ofs := (p.(poffset)) in
                                                                          let cpuidx := (ofs / (24)) in
                                                                          let elem_ofs := (ofs mod (24)) in
                                                                          let cache_entry := (((st.(priv)).(pcpu_llt_info_cache)) @ cpuidx) in
                                                                          when ret == ((load_s_xlat_llt_info sz elem_ofs cache_entry));
                                                                          (Some (ret, st)))
                                                                        else (
                                                                          if ((p.(pbase)) =s ("sl0_val"))
                                                                          then (
                                                                            let ofs := (p.(poffset)) in
                                                                            if (ofs =? (0))
                                                                            then (Some (0, st))
                                                                            else (
                                                                              if (ofs =? (8))
                                                                              then (Some (64, st))
                                                                              else (
                                                                                if (ofs =? (16))
                                                                                then (Some (128, st))
                                                                                else (
                                                                                  if (ofs =? (24))
                                                                                  then (Some (192, st))
                                                                                  else None))))
                                                                          else (
                                                                            if ((p.(pbase)) =s ("vmids"))
                                                                            then (
                                                                              rely ((((p.(poffset)) mod (8)) = (0)));
                                                                              let idx := ((p.(poffset)) / (8)) in
                                                                              (Some ((((st.(share)).(gv_vmids)) @ idx), st)))
                                                                            else None)))))))))))))))))))))))))))))))))))).

  Definition store_RData (sz: Z) (p: Ptr) (v: Z) (st: RData) : (option RData) :=
    if ((p.(pbase)) =s ("granules"))
    then (
      let ofs := (p.(poffset)) in
      let idx := (ofs / (ST_GRANULE_SIZE)) in
      let elem_ofs := (ofs mod (ST_GRANULE_SIZE)) in
      if (s_granule_field_accessible (((st.(share)).(granules)) @ idx) elem_ofs)
      then (
        when ret == ((store_s_granule sz elem_ofs v (((st.(share)).(granules)) @ idx)));
        let new_granules := (((st.(share)).(granules)) # idx == ret) in
        if ((elem_ofs =? (8)) && ((((((st.(share)).(granules)) @ idx).(e_state)) =? (GRANULE_STATE_REC))))
        then (
          let st := (st.[log] :< ((EVT CPU_ID (REC_REF idx v)) :: ((st.(log))))) in
          (Some (st.[share].[granules] :< new_granules)))
        else (Some (st.[share].[granules] :< new_granules)))
      else None)
    else (
      if ((p.(pbase)) =s ("slot_rd"))
      then (
        let ofs := (p.(poffset)) in
        let g_idx := (((st.(share)).(slots)) @ SLOT_RD) in
        let g_data := (((st.(share)).(granule_data)) @ g_idx) in
        let g := (((st.(share)).(granules)) @ g_idx) in
        if (rd_field_accessible (g_data.(g_rd)) ofs g true st)
        then (
          when cid == ((g.(e_lock)));
          when new_rd == ((store_s_rd sz ofs v (g_data.(g_rd))));
          let new_gdata := (g_data.[g_rd] :< new_rd) in
          (Some (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == new_gdata))))
        else None)
      else (
        if ((p.(pbase)) =s ("slot_rec"))
        then (
          let ofs := (p.(poffset)) in
          let g_idx := (((st.(share)).(slots)) @ SLOT_REC) in
          let g_data := (((st.(share)).(granule_data)) @ g_idx) in
          let g := (((st.(share)).(granules)) @ g_idx) in
          let locked := (
              match ((g.(e_lock))) with
              | (Some cid) => true
              | None => false
              end) in
          if (rec_field_accessible g locked st)
          then (
            when new_rec == ((store_s_rec sz ofs v (g_data.(g_rec))));
            let new_gdata := (g_data.[g_rec] :< new_rec) in
            (Some (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == new_gdata))))
          else None)
        else (
          if ((p.(pbase)) =s ("slot_rec2"))
          then (
            let ofs := (p.(poffset)) in
            let g_idx := (((st.(share)).(slots)) @ SLOT_REC2) in
            let g_data := (((st.(share)).(granule_data)) @ g_idx) in
            let g := (((st.(share)).(granules)) @ g_idx) in
            let locked := (
                match ((g.(e_lock))) with
                | (Some cid) => true
                | None => false
                end) in
            if (rec_field_accessible g locked st)
            then (
              when new_rec == ((store_s_rec sz ofs v (g_data.(g_rec))));
              let new_gdata := (g_data.[g_rec] :< new_rec) in
              (Some (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == new_gdata))))
            else None)
          else (
            if ((p.(pbase)) =s ("slot_rtt"))
            then (
              let ofs := (p.(poffset)) in
              let g_idx := (((st.(share)).(slots)) @ SLOT_RTT) in
              let g_data := (((st.(share)).(granule_data)) @ g_idx) in
              let g := (((st.(share)).(granules)) @ g_idx) in
              when cid == ((g.(e_lock)));
              (Some (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == (g_data.[g_norm] :< ((g_data.(g_norm)) # ofs == v))))))
            else (
              if ((p.(pbase)) =s ("slot_rec_aux0"))
              then (
                let ofs := (p.(poffset)) in
                let g_idx := (((st.(share)).(slots)) @ SLOT_REC_AUX0) in
                let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                let parent_g_idx := (g_data.(rec_gidx)) in
                let parent_g_data := (((st.(share)).(granule_data)) @ parent_g_idx) in
                let parent_g := (((st.(share)).(granules)) @ parent_g_idx) in
                let locked := (
                    match ((parent_g.(e_lock))) with
                    | (Some cid) => true
                    | None => false
                    end) in
                if (rec_field_accessible parent_g locked st)
                then (
                  if ((0 <=? (ofs)) && ((ofs <? (REC_HEAP_SIZE))))
                  then (Some st)
                  else (
                    if ((REC_HEAP_SIZE <=? (ofs)) && ((ofs <? ((REC_HEAP_SIZE + (REC_PMU_SIZE))))))
                    then (
                      when new_pmu_state == ((store_s_pmu_state sz (ofs - (REC_HEAP_SIZE)) v (g_data.(g_aux_pmu_state))));
                      let new_gdata := (g_data.[g_aux_pmu_state] :< new_pmu_state) in
                      (Some (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == new_gdata))))
                    else (
                      if ((REC_HEAP_SIZE + (REC_PMU_SIZE)) <=? (ofs))
                      then (
                        when new_simd_state == ((store_s_simd_state sz ((ofs - (REC_HEAP_SIZE)) - (REC_PMU_SIZE)) v (g_data.(g_aux_simd_state))));
                        let new_gdata := (g_data.[g_aux_simd_state] :< new_simd_state) in
                        (Some (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == new_gdata))))
                      else None)))
                else None)
              else (
                if ((p.(pbase)) =s ("slot_rtt2"))
                then (
                  let ofs := (p.(poffset)) in
                  let g_idx := (((st.(share)).(slots)) @ SLOT_RTT2) in
                  let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                  let g := (((st.(share)).(granules)) @ g_idx) in
                  when cid == ((g.(e_lock)));
                  (Some (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == (g_data.[g_norm] :< ((g_data.(g_norm)) # ofs == v))))))
                else (
                  if ((p.(pbase)) =s ("slot_rsi_call"))
                  then (
                    let ofs := (p.(poffset)) in
                    let g_idx := (((st.(share)).(slots)) @ SLOT_RSI_CALL) in
                    let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                    (Some st))
                  else (
                    if ((p.(pbase)) =s ("slot_delegated"))
                    then (
                      let ofs := (p.(poffset)) in
                      let g_idx := (((st.(share)).(slots)) @ SLOT_DELEGATED) in
                      let g_data := (((st.(share)).(granule_data)) @ g_idx) in
                      let g := (((st.(share)).(granules)) @ g_idx) in
                      when cid == ((g.(e_lock)));
                      (Some (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == (g_data.[g_norm] :< ((g_data.(g_norm)) # ofs == v))))))
                    else (
                      if ((p.(pbase)) =s ("bad_stack"))
                      then (
                        let ofs := (p.(poffset)) in
                        (Some st))
                      else (
                        if ((p.(pbase)) =s ("stack"))
                        then (
                          let ofs := (p.(poffset)) in
                          let slot_nr := (stack_ptr_extract_slot ofs) in
                          let slot_ofs := (stack_ptr_extract_ofs ofs) in
                          let ret := (
                              (st.[priv].[pcpu_stack] :<
                                (((st.(priv)).(pcpu_stack)) #
                                  slot_nr ==
                                  ((((st.(priv)).(pcpu_stack)) @ slot_nr).[sf_data] :< (((((st.(priv)).(pcpu_stack)) @ slot_nr).(sf_data)) # slot_ofs == (mkStackData v sz)))))) in
                          (Some ret))
                        else (
                          if ((p.(pbase)) =s ("stack_wi"))
                          then (
                            when new_wi == ((store_s_rtt_walk sz (p.(poffset)) v ((st.(stack)).(stack_wi))));
                            (Some (st.[stack].[stack_wi] :< new_wi)))
                          else (
                            if ((p.(pbase)) =s ("stack_g_tbls"))
                            then (
                              let idx := ((p.(poffset)) / (8)) in
                              let new_ptr := (((st.(stack)).(stack_g_tbls)) # idx == v) in
                              (Some (st.[stack].[stack_g_tbls] :< new_ptr)))
                            else (
                              if ((p.(pbase)) =s ("stack_gs"))
                              then (
                                let idx := ((p.(poffset)) / (40)) in
                                let ofs := ((p.(poffset)) mod (40)) in
                                if (idx =? (0))
                                then (
                                  when new_gs == ((store_s_granule_set sz ofs v ((st.(stack)).(stack_gs0))));
                                  (Some (st.[stack].[stack_gs0] :< new_gs)))
                                else (
                                  when new_gs == ((store_s_granule_set sz ofs v ((st.(stack)).(stack_gs1))));
                                  (Some (st.[stack].[stack_gs1] :< new_gs))))
                              else (
                                if ((p.(pbase)) =s ("stack_gs_temp"))
                                then (
                                  when new_gs == ((store_s_granule_set sz (p.(poffset)) v ((st.(stack)).(stack_gs_temp))));
                                  (Some (st.[stack].[stack_gs_temp] :< new_gs)))
                                else (
                                  if ((p.(pbase)) =s ("stack_g0"))
                                  then (Some (st.[stack].[stack_g0] :< v))
                                  else (
                                    if ((p.(pbase)) =s ("stack_g1"))
                                    then (Some (st.[stack].[stack_g1] :< v))
                                    else (
                                      if ((p.(pbase)) =s ("stack_s2_ctx"))
                                      then (
                                        when new_s2_ctx == ((store_s_realm_s2_context sz (p.(poffset)) v ((st.(stack)).(stack_s2_ctx))));
                                        (Some (st.[stack].[stack_s2_ctx] :< new_s2_ctx)))
                                      else (
                                        if ((p.(pbase)) =s ("stack_ripas_ptr"))
                                        then (Some (st.[stack].[stack_ripas_ptr] :< v))
                                        else (
                                          if ((p.(pbase)) =s ("stack_ripas"))
                                          then (Some (st.[stack].[stack_ripas] :< v))
                                          else (
                                            if ((p.(pbase)) =s ("stack_rtt_level"))
                                            then (Some (st.[stack].[stack_rtt_level] :< v))
                                            else (
                                              if ((p.(pbase)) =s ("stack_walk_res"))
                                              then (
                                                when new_walk_res == ((store_s_s2_walk_result sz (p.(poffset)) v ((st.(stack)).(stack_walk_res))));
                                                (Some (st.[stack].[stack_walk_res] :< new_walk_res)))
                                              else (
                                                if ((p.(pbase)) =s ("stack_s2tte"))
                                                then (Some (st.[stack].[stack_s2tte] :< v))
                                                else (
                                                  if ((p.(pbase)) =s ("g_sve_max_vq"))
                                                  then (
                                                    let ofs := (p.(poffset)) in
                                                    (Some (st.[share].[gv_g_sve_max_vq] :< v)))
                                                  else (
                                                    if ((p.(pbase)) =s ("g_ns_simd"))
                                                    then (
                                                      let ofs := (p.(poffset)) in
                                                      let ret := (((st.(share)).(gv_g_ns_simd)) # ofs == v) in
                                                      (Some (st.[share].[gv_g_ns_simd] :< ret)))
                                                    else (
                                                      if ((p.(pbase)) =s ("g_cpu_simd_type"))
                                                      then (
                                                        let ofs := (p.(poffset)) in
                                                        (Some (st.[share].[gv_g_cpu_simd_type] :< v)))
                                                      else (
                                                        if ((p.(pbase)) =s ("llt_info_cache"))
                                                        then (
                                                          let ofs := (p.(poffset)) in
                                                          (Some st))
                                                        else (
                                                          if ((p.(pbase)) =s ("vmids"))
                                                          then (
                                                            let idx := ((p.(poffset)) / (8)) in
                                                            rely ((((p.(poffset)) mod (8)) = (0)));
                                                            (Some (st.[share].[gv_vmids] :< (((st.(share)).(gv_vmids)) # idx == v))))
                                                          else None))))))))))))))))))))))))))).

  Definition alloc_stack (fname: string) (sz: Z) (ofs: Z) (st: RData) : (option (Ptr * RData)) :=
    if (fname =s ("find_lock_two_granules"))
    then (Some ((mkPtr "stack_gs" 0), st))
    else (
      if (fname =s ("do_host_call"))
      then (Some ((mkPtr "stack_walk_res" 0), st))
      else (
        if (fname =s ("sort_granules"))
        then (Some ((mkPtr "stack_gs_temp" 0), st))
        else (
          if (fname =s ("rtt_walk_lock_unlock"))
          then (Some ((mkPtr "stack_g_tbls" 0), st))
          else (
            if (fname =s ("map_unmap_ns"))
            then (
              if (sz =? (24))
              then (Some ((mkPtr "stack_wi" 0), st))
              else (Some ((mkPtr "stack_s2_ctx" 0), st)))
            else (Some ((mkPtr "bad_stack" 0), st)))))).

  Definition free_stack (fname: string) (init_st: RData) (st: RData) : (option RData) :=
    (Some st).

  Definition new_frame (fname: string) (st: RData) : (option RData) :=
    (Some st).

  Definition base_to_slot (b: string) : Z :=
    if (b =s ("slot_ns"))
    then SLOT_NS
    else (
      if (b =s ("slot_delegated"))
      then SLOT_DELEGATED
      else (
        if (b =s ("slot_rd"))
        then SLOT_RD
        else (
          if (b =s ("slot_rec"))
          then SLOT_REC
          else (
            if (b =s ("slot_rec2"))
            then SLOT_REC2
            else (
              if (b =s ("slot_rec_target"))
              then SLOT_REC_TARGET
              else (
                if (b =s ("slot_rec_aux0"))
                then SLOT_REC_AUX0
                else (
                  if (b =s ("slot_rtt"))
                  then SLOT_RTT
                  else (
                    if (b =s ("slot_rtt2"))
                    then SLOT_RTT2
                    else (
                      if (b =s ("slot_rsi_call"))
                      then SLOT_RSI_CALL
                      else (
                        if (b =s ("attest_setup_platform_token_stack"))
                        then STACK_attest_setup_platform_token
                        else (
                          if (b =s ("smc_psci_complete_stack"))
                          then STACK_smc_psci_complete
                          else (
                            if (b =s ("find_lock_two_granules_stack"))
                            then STACK_find_lock_two_granules
                            else (
                              if (b =s ("attest_token_continue_write_state_stack"))
                              then STACK_attest_token_continue_write_state
                              else (
                                if (b =s ("rmm_log_stack"))
                                then STACK_rmm_log
                                else (
                                  if (b =s ("attest_realm_token_create_stack"))
                                  then STACK_attest_realm_token_create
                                  else (
                                    if (b =s ("smc_rec_enter_stack"))
                                    then STACK_smc_rec_enter
                                    else (
                                      if (b =s ("do_host_call_stack"))
                                      then STACK_do_host_call
                                      else (
                                        if (b =s ("attest_rnd_prng_init_stack"))
                                        then STACK_attest_rnd_prng_init
                                        else (
                                          if (b =s ("plat_setup_stack"))
                                          then STACK_plat_setup
                                          else (
                                            if (b =s ("attest_token_encode_start_stack"))
                                            then STACK_attest_token_encode_start
                                            else (
                                              if (b =s ("smc_data_destroy_stack"))
                                              then STACK_smc_data_destroy
                                              else (
                                                if (b =s ("xlat_get_llt_from_va_stack"))
                                                then STACK_xlat_get_llt_from_va
                                                else (
                                                  if (b =s ("smc_rec_create_stack"))
                                                  then STACK_smc_rec_create
                                                  else (
                                                    if (b =s ("measurement_extend_sha512_stack"))
                                                    then STACK_measurement_extend_sha512
                                                    else (
                                                      if (b =s ("data_granule_measure_stack"))
                                                      then STACK_data_granule_measure
                                                      else (
                                                        if (b =s ("sort_granules_stack"))
                                                        then STACK_sort_granules
                                                        else (
                                                          if (b =s ("measurement_extend_sha256_stack"))
                                                          then STACK_measurement_extend_sha256
                                                          else (
                                                            if (b =s ("realm_ipa_to_pa_stack"))
                                                            then STACK_realm_ipa_to_pa
                                                            else (
                                                              if (b =s ("attest_realm_token_sign_stack"))
                                                              then STACK_attest_realm_token_sign
                                                              else (
                                                                if (b =s ("rmm_el3_ifc_get_platform_token_stack"))
                                                                then STACK_rmm_el3_ifc_get_platform_token
                                                                else (
                                                                  if (b =s ("attest_init_realm_attestation_key_stack"))
                                                                  then STACK_attest_init_realm_attestation_key
                                                                  else (
                                                                    if (b =s ("plat_cmn_setup_stack"))
                                                                    then STACK_plat_cmn_setup
                                                                    else (
                                                                      if (b =s ("complete_rsi_host_call_stack"))
                                                                      then STACK_complete_rsi_host_call
                                                                      else (
                                                                        if (b =s ("handle_realm_rsi_stack"))
                                                                        then STACK_handle_realm_rsi
                                                                        else (
                                                                          if (b =s ("smc_rtt_set_ripas_stack"))
                                                                          then STACK_smc_rtt_set_ripas
                                                                          else (
                                                                            if (b =s ("rtt_walk_lock_unlock_stack"))
                                                                            then STACK_rtt_walk_lock_unlock
                                                                            else (
                                                                              if (b =s ("smc_rtt_destroy_stack"))
                                                                              then STACK_smc_rtt_destroy
                                                                              else (
                                                                                if (b =s ("map_unmap_ns_stack"))
                                                                                then STACK_map_unmap_ns
                                                                                else (
                                                                                  if (b =s ("handle_rsi_attest_token_init_stack"))
                                                                                  then STACK_handle_rsi_attest_token_init
                                                                                  else (
                                                                                    if (b =s ("realm_params_measure_stack"))
                                                                                    then STACK_realm_params_measure
                                                                                    else (
                                                                                      if (b =s ("handle_rsi_ipa_state_get_stack"))
                                                                                      then STACK_handle_rsi_ipa_state_get
                                                                                      else (
                                                                                        if (b =s ("realm_ipa_get_ripas_stack"))
                                                                                        then STACK_realm_ipa_get_ripas
                                                                                        else (
                                                                                          if (b =s ("smc_rtt_fold_stack"))
                                                                                          then STACK_smc_rtt_fold
                                                                                          else (
                                                                                            if (b =s ("smc_rtt_create_stack"))
                                                                                            then STACK_smc_rtt_create
                                                                                            else (
                                                                                              if (b =s ("rsi_log_on_exit_stack"))
                                                                                              then STACK_rsi_log_on_exit
                                                                                              else (
                                                                                                if (b =s ("attest_cca_token_create_stack"))
                                                                                                then STACK_attest_cca_token_create
                                                                                                else (
                                                                                                  if (b =s ("rec_params_measure_stack"))
                                                                                                  then STACK_rec_params_measure
                                                                                                  else (
                                                                                                    if (b =s ("handle_ns_smc_stack"))
                                                                                                    then STACK_handle_ns_smc
                                                                                                    else (
                                                                                                      if (b =s ("rmm_el3_ifc_get_realm_attest_key_stack"))
                                                                                                      then STACK_rmm_el3_ifc_get_realm_attest_key
                                                                                                      else (
                                                                                                        if (b =s ("handle_rsi_realm_config_stack"))
                                                                                                        then STACK_handle_rsi_realm_config
                                                                                                        else (
                                                                                                          if (b =s ("smc_rtt_init_ripas_stack"))
                                                                                                          then STACK_smc_rtt_init_ripas
                                                                                                          else (
                                                                                                            if (b =s ("smc_rtt_read_entry_stack"))
                                                                                                            then STACK_smc_rtt_read_entry
                                                                                                            else (
                                                                                                              if (b =s ("handle_data_abort_stack"))
                                                                                                              then STACK_handle_data_abort
                                                                                                              else (
                                                                                                                if (b =s ("data_create_stack"))
                                                                                                                then STACK_data_create
                                                                                                                else (
                                                                                                                  if (b =s ("smc_realm_create_stack"))
                                                                                                                  then STACK_smc_realm_create
                                                                                                                  else (
                                                                                                                    if (b =s ("ripas_granule_measure_stack"))
                                                                                                                    then STACK_ripas_granule_measure
                                                                                                                    else (
                                                                                                                      if (b =s ("ipa_is_empty_stack"))
                                                                                                                      then STACK_ipa_is_empty
                                                                                                                      else (
                                                                                                                        if (b =s ("stack_g0"))
                                                                                                                        then STACK_g0
                                                                                                                        else (
                                                                                                                          if (b =s ("stack_g1"))
                                                                                                                          then STACK_g1
                                                                                                                          else non_slot))))))))))))))))))))))))))))))))))))))))))))))))))))))))))).

  Definition ptr_to_int (p: Ptr) : Z :=
    let slot := (base_to_slot (p.(pbase))) in
    if (slot =? (non_slot))
    then (
      if ((p.(pbase)) =s ("status"))
      then (MAX_ERR + ((p.(poffset))))
      else (
        if ((p.(pbase)) =s ("granules"))
        then (GRANULES_BASE + ((p.(poffset))))
        else (
          if ((p.(pbase)) =s ("null"))
          then 0
          else (- 1))))
    else (
      if (slot <=? (24))
      then ((SLOT_VIRT + ((slot * (GRANULE_SIZE)))) + ((p.(poffset))))
      else ((STACK_VIRT + (((slot - (STACK_slot_ofs)) * (GRANULE_SIZE)))) + ((p.(poffset))))).

  Definition slot_to_ptr (slot: Z) (val: Z) : Ptr :=
    let ofs := ((val - (SLOT_VIRT)) mod (GRANULE_SIZE)) in
    if (slot =? (SLOT_NS))
    then (mkPtr "slot_ns" ofs)
    else (
      if (slot =? (SLOT_DELEGATED))
      then (mkPtr "slot_delegated" ofs)
      else (
        if (slot =? (SLOT_RD))
        then (mkPtr "slot_rd" ofs)
        else (
          if (slot =? (SLOT_REC))
          then (mkPtr "slot_rec" ofs)
          else (
            if (slot =? (SLOT_REC2))
            then (mkPtr "slot_rec2" ofs)
            else (
              if (slot =? (SLOT_REC_TARGET))
              then (mkPtr "slot_rec_target" ofs)
              else (
                if ((slot >=? (SLOT_REC_AUX0)) && ((slot <? ((SLOT_REC_AUX0 + (MAX_REC_AUX_GRANULES))))))
                then (mkPtr "slot_rec_aux0" ((val - (SLOT_VIRT)) mod ((GRANULE_SIZE * (MAX_REC_AUX_GRANULES)))))
                else (
                  if (slot =? (SLOT_RTT))
                  then (mkPtr "slot_rtt" ofs)
                  else (
                    if (slot =? (SLOT_RTT2))
                    then (mkPtr "slot_rtt2" ofs)
                    else (
                      if (slot =? (SLOT_RSI_CALL))
                      then (mkPtr "slot_rsi_call" ofs)
                      else (mkPtr "null" 0)))))))))).

  Definition stack_to_ptr (slot: Z) (val: Z) : Ptr :=
    let ofs := ((val - (STACK_VIRT)) mod (GRANULE_SIZE)) in
    if (slot =? (STACK_g0))
    then (mkPtr "stack_g0" ofs)
    else (
      if (slot =? (STACK_g1))
      then (mkPtr "stack_g1" ofs)
      else (mkPtr "null" 0)).

  Definition int_to_ptr (v: Z) : Ptr :=
    if (v >? (0))
    then (
      if (v >=? (MAX_ERR))
      then (mkPtr "status" (v - (MAX_ERR)))
      else (
        if (v >=? (SLOT_VIRT))
        then (slot_to_ptr ((v - (SLOT_VIRT)) / (GRANULE_SIZE)) v)
        else (
          if (v >=? (STACK_VIRT))
          then (stack_to_ptr (((v - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) v)
          else (
            if (v >=? (GRANULES_BASE))
            then (mkPtr "granules" (v - (GRANULES_BASE)))
            else (mkPtr "null" 0)))))
    else (mkPtr "null" 0).

  Definition ptr_ltb (p1: Ptr) (p2: Ptr) : bool :=
    ((ptr_to_int p1) <? ((ptr_to_int p2))).

  Definition ptr_gtb (p1: Ptr) (p2: Ptr) : bool :=
    if ((p2.(pbase)) =s ("status"))
    then (
      if ((p1.(pbase)) <>s ("status"))
      then false
      else ((p1.(poffset)) >? ((p2.(poffset)))))
    else ((ptr_to_int p1) >? ((ptr_to_int p2))).

End GlobalDefs.

#[global] Hint Unfold ptr_offset: spec.
#[global] Hint Unfold bool_to_int: spec.
#[global] Hint Unfold SLOT_VIRT: spec.
#[global] Hint Unfold STACK_VIRT: spec.
#[global] Hint Unfold MAX_ERR: spec.
#[global] Hint Unfold GRANULES_BASE: spec.
#[global] Hint Unfold ST_GRANULE_SIZE: spec.
#[global] Hint Unfold RMM_MAX_GRANULES: spec.
#[global] Hint Unfold MAX_REC_AUX_GRANULES: spec.
#[global] Hint Unfold GRANULE_SIZE: spec.
#[global] Hint Unfold SMC_RMM_GTSI_DELEGATE: spec.
#[global] Hint Unfold SMC_RMM_GTSI_UNDELEGATE: spec.
#[global] Hint Unfold SLOT_NS: spec.
#[global] Hint Unfold SLOT_DELEGATED: spec.
#[global] Hint Unfold SLOT_RD: spec.
#[global] Hint Unfold SLOT_REC: spec.
#[global] Hint Unfold SLOT_REC2: spec.
#[global] Hint Unfold SLOT_REC_TARGET: spec.
#[global] Hint Unfold SLOT_REC_AUX0: spec.
#[global] Hint Unfold SLOT_RTT: spec.
#[global] Hint Unfold SLOT_RTT2: spec.
#[global] Hint Unfold SLOT_RSI_CALL: spec.
#[global] Hint Unfold STACK_slot_ofs: spec.
#[global] Hint Unfold STACK_attest_setup_platform_token: spec.
#[global] Hint Unfold STACK_smc_psci_complete: spec.
#[global] Hint Unfold STACK_find_lock_two_granules: spec.
#[global] Hint Unfold STACK_attest_token_continue_write_state: spec.
#[global] Hint Unfold STACK_rmm_log: spec.
#[global] Hint Unfold STACK_attest_realm_token_create: spec.
#[global] Hint Unfold STACK_smc_rec_enter: spec.
#[global] Hint Unfold STACK_do_host_call: spec.
#[global] Hint Unfold STACK_attest_rnd_prng_init: spec.
#[global] Hint Unfold STACK_plat_setup: spec.
#[global] Hint Unfold STACK_attest_token_encode_start: spec.
#[global] Hint Unfold STACK_smc_data_destroy: spec.
#[global] Hint Unfold STACK_xlat_get_llt_from_va: spec.
#[global] Hint Unfold STACK_smc_rec_create: spec.
#[global] Hint Unfold STACK_measurement_extend_sha512: spec.
#[global] Hint Unfold STACK_data_granule_measure: spec.
#[global] Hint Unfold STACK_sort_granules: spec.
#[global] Hint Unfold STACK_measurement_extend_sha256: spec.
#[global] Hint Unfold STACK_realm_ipa_to_pa: spec.
#[global] Hint Unfold STACK_attest_realm_token_sign: spec.
#[global] Hint Unfold STACK_rmm_el3_ifc_get_platform_token: spec.
#[global] Hint Unfold STACK_attest_init_realm_attestation_key: spec.
#[global] Hint Unfold STACK_plat_cmn_setup: spec.
#[global] Hint Unfold STACK_complete_rsi_host_call: spec.
#[global] Hint Unfold STACK_handle_realm_rsi: spec.
#[global] Hint Unfold STACK_smc_rtt_set_ripas: spec.
#[global] Hint Unfold STACK_rtt_walk_lock_unlock: spec.
#[global] Hint Unfold STACK_smc_rtt_destroy: spec.
#[global] Hint Unfold STACK_map_unmap_ns: spec.
#[global] Hint Unfold STACK_handle_rsi_attest_token_init: spec.
#[global] Hint Unfold STACK_realm_params_measure: spec.
#[global] Hint Unfold STACK_handle_rsi_ipa_state_get: spec.
#[global] Hint Unfold STACK_realm_ipa_get_ripas: spec.
#[global] Hint Unfold STACK_smc_rtt_fold: spec.
#[global] Hint Unfold STACK_smc_rtt_create: spec.
#[global] Hint Unfold STACK_rsi_log_on_exit: spec.
#[global] Hint Unfold STACK_attest_cca_token_create: spec.
#[global] Hint Unfold STACK_rec_params_measure: spec.
#[global] Hint Unfold STACK_handle_ns_smc: spec.
#[global] Hint Unfold STACK_rmm_el3_ifc_get_realm_attest_key: spec.
#[global] Hint Unfold STACK_handle_rsi_realm_config: spec.
#[global] Hint Unfold STACK_smc_rtt_init_ripas: spec.
#[global] Hint Unfold STACK_smc_rtt_read_entry: spec.
#[global] Hint Unfold STACK_handle_data_abort: spec.
#[global] Hint Unfold STACK_data_create: spec.
#[global] Hint Unfold STACK_smc_realm_create: spec.
#[global] Hint Unfold STACK_ripas_granule_measure: spec.
#[global] Hint Unfold STACK_ipa_is_empty: spec.
#[global] Hint Unfold STACK_g0: spec.
#[global] Hint Unfold STACK_g1: spec.
#[global] Hint Unfold non_slot: spec.
#[global] Hint Unfold int_is_granule: spec.
#[global] Hint Unfold REALM_STATE_NEW: spec.
#[global] Hint Unfold REALM_STATE_ACTIVE: spec.
#[global] Hint Unfold REALM_STATE_SYSTEM_OFF: spec.
#[global] Hint Unfold load_s_gic_cpu_state: spec.
#[global] Hint Unfold store_s_gic_cpu_state: spec.
#[global] Hint Unfold load_s_sysreg_state: spec.
#[global] Hint Unfold store_s_sysreg_state: spec.
#[global] Hint Unfold load_s_common_sysreg_state: spec.
#[global] Hint Unfold store_s_common_sysreg_state: spec.
#[global] Hint Unfold load_s_set_ripas: spec.
#[global] Hint Unfold store_s_set_ripas: spec.
#[global] Hint Unfold load_s_realm_info: spec.
#[global] Hint Unfold store_s_realm_info: spec.
#[global] Hint Unfold load_s_last_run_info: spec.
#[global] Hint Unfold store_s_last_run_info: spec.
#[global] Hint Unfold load_s_psci_info: spec.
#[global] Hint Unfold store_s_psci_info: spec.
#[global] Hint Unfold load_s_rec_simd_state: spec.
#[global] Hint Unfold store_s_rec_simd_state: spec.
#[global] Hint Unfold load_s_rec_aux_data: spec.
#[global] Hint Unfold store_s_rec_aux_data: spec.
#[global] Hint Unfold load_s_buffer_alloc_ctx: spec.
#[global] Hint Unfold store_s_buffer_alloc_ctx: spec.
#[global] Hint Unfold load_s_alloc_info: spec.
#[global] Hint Unfold store_s_alloc_info: spec.
#[global] Hint Unfold load_s_serror_info: spec.
#[global] Hint Unfold store_s_serror_info: spec.
#[global] Hint Unfold load_s_rec: spec.
#[global] Hint Unfold store_s_rec: spec.
#[global] Hint Unfold load_s_pmev_regs: spec.
#[global] Hint Unfold store_s_pmev_regs: spec.
#[global] Hint Unfold load_s_pmu_state: spec.
#[global] Hint Unfold store_s_pmu_state: spec.
#[global] Hint Unfold load_s_fpu_state: spec.
#[global] Hint Unfold store_s_fpu_state: spec.
#[global] Hint Unfold load_u_anon_6: spec.
#[global] Hint Unfold store_u_anon_6: spec.
#[global] Hint Unfold load_s_simd_state: spec.
#[global] Hint Unfold store_s_simd_state: spec.
#[global] Hint Unfold load_s_ns_simd_state: spec.
#[global] Hint Unfold store_s_ns_simd_state: spec.
#[global] Hint Unfold load_u_anon_10: spec.
#[global] Hint Unfold store_u_anon_10: spec.
#[global] Hint Unfold load_s_anon_14: spec.
#[global] Hint Unfold store_s_anon_14: spec.
#[global] Hint Unfold load_u_anon_11_154: spec.
#[global] Hint Unfold store_u_anon_11_154: spec.
#[global] Hint Unfold load_s_rmi_rec_params: spec.
#[global] Hint Unfold store_s_rmi_rec_params: spec.
#[global] Hint Unfold load_s_rtt_walk: spec.
#[global] Hint Unfold store_s_rtt_walk: spec.
#[global] Hint Unfold store_u_anon_7: spec.
#[global] Hint Unfold load_u_anon_0_95: spec.
#[global] Hint Unfold load_u_anon_7: spec.
#[global] Hint Unfold store_u_anon_0_95: spec.
#[global] Hint Unfold load_u_anon_1_96: spec.
#[global] Hint Unfold store_u_anon_1_96: spec.
#[global] Hint Unfold load_s_anon_97: spec.
#[global] Hint Unfold store_s_anon_97: spec.
#[global] Hint Unfold load_u_anon_2_98: spec.
#[global] Hint Unfold store_u_anon_2_98: spec.
#[global] Hint Unfold load_s_rmi_realm_params: spec.
#[global] Hint Unfold store_s_rmi_realm_params: spec.
#[global] Hint Unfold load_s_granule: spec.
#[global] Hint Unfold store_s_granule: spec.
#[global] Hint Unfold load_s_realm_s2_context: spec.
#[global] Hint Unfold store_s_realm_s2_context: spec.
#[global] Hint Unfold load_s_rd: spec.
#[global] Hint Unfold store_s_rd: spec.
#[global] Hint Unfold load_s_granule_set: spec.
#[global] Hint Unfold store_s_granule_set: spec.
#[global] Hint Unfold store_s_s2_walk_result: spec.
#[global] Hint Unfold load_s_s2_walk_result: spec.
#[global] Hint Unfold stack_ptr_extract_ofs: spec.
#[global] Hint Unfold stack_ptr_extract_slot: spec.
#[global] Hint Unfold s_granule_set_size: spec.
#[global] Hint Unfold load_s_xlat_llt_info: spec.
#[global] Hint Unfold store_s_xlat_llt_info: spec.
#[global] Hint Unfold RMI_HASH_ALGO_SHA256: spec.
#[global] Hint Unfold RMI_HASH_ALGO_SHA512: spec.
#[global] Hint Unfold HASH_ALGO_SHA256: spec.
#[global] Hint Unfold HASH_ALGO_SHA512: spec.
#[global] Hint Unfold SHA256_SIZE: spec.
#[global] Hint Unfold SHA512_SIZE: spec.
#[global] Hint Unfold query_oracle: spec.
#[global] Hint Unfold REC_HEAP_SIZE: spec.
#[global] Hint Unfold REC_PMU_SIZE: spec.
#[global] Hint Unfold NS_SIMD_SIZE: spec.
#[global] Hint Unfold GRANULE_STATE_NS: spec.
#[global] Hint Unfold GRANULE_STATE_UNDELEGATED: spec.
#[global] Hint Unfold GRANULE_STATE_DELEGATED: spec.
#[global] Hint Unfold GRANULE_STATE_RD: spec.
#[global] Hint Unfold GRANULE_STATE_REC: spec.
#[global] Hint Unfold GRANULE_STATE_REC_AUX: spec.
#[global] Hint Unfold GRANULE_STATE_DATA: spec.
#[global] Hint Unfold GRANULE_STATE_RTT: spec.
#[global] Hint Unfold GRANULE_STATE_LAST: spec.
#[global] Hint Unfold int_is_g0: spec.
#[global] Hint Unfold int_is_g1: spec.
#[global] Hint Unfold rec_is_locked: spec.
#[global] Hint Unfold rec_is_unlocked: spec.
#[global] Hint Unfold rec_aux_is_locked: spec.
#[global] Hint Unfold rec_aux_is_unlocked: spec.
#[global] Hint Unfold rec_aux_refcount_zero: spec.
#[global] Hint Unfold rec_aux_refcount_one: spec.
#[global] Hint Unfold rec_has_rd: spec.
#[global] Hint Unfold rec_no_rd: spec.
#[global] Hint Unfold rec_refcount_zero: spec.
#[global] Hint Unfold rec_refcount_one: spec.
#[global] Hint Unfold rd_is_locked: spec.
Opaque rec_field_accessible.
#[global] Hint Unfold _rec_field_accessible: spec.
#[global] Hint Unfold rd_field_accessible: spec.
#[global] Hint Unfold s_granule_field_accessible: spec.
#[global] Hint Unfold load_RData: spec.
#[global] Hint Unfold store_RData: spec.
#[global] Hint Unfold alloc_stack: spec.
#[global] Hint Unfold free_stack: spec.
#[global] Hint Unfold new_frame: spec.
#[global] Hint Unfold base_to_slot: spec.
#[global] Hint Unfold ptr_to_int: spec.
#[global] Hint Unfold slot_to_ptr: spec.
#[global] Hint Unfold stack_to_ptr: spec.
#[global] Hint Unfold int_to_ptr: spec.
#[global] Hint Unfold ptr_ltb: spec.
#[global] Hint Unfold ptr_gtb: spec.
