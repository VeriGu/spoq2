; 
(set-info :status unknown)
(declare-datatypes ((u_anon_3 0)) (((mku_anon_3 (e_u_anon_3_0 Int)))))
 (declare-datatypes ((Option_Z 0)) (((Some_Z (value_Z Int)) (None_Z))))
 (declare-datatypes ((s_spinlock_t 0)) (((mks_spinlock_t (e_val Option_Z)))))
 (declare-datatypes ((s_granule 0)) (((mks_granule (e_lock s_spinlock_t) (e_state_s_granule Int) (e_ref u_anon_3)))))
 (declare-datatypes ((s_gic_cpu_state 0)) (((mks_gic_cpu_state (e_ich_ap0r (Array Int Int)) (e_ich_ap1r (Array Int Int)) (e_ich_vmcr Int) (e_ich_hcr Int) (e_ich_lr (Array Int Int)) (e_ich_misr Int)))))
 (declare-datatypes ((s_s1tt 0)) (((mks_s1tt (e_s1tte (Array Int Int))))))
 (declare-datatypes ((s_q_useful_buf 0)) (((mks_q_useful_buf (e_ptr Int) (e_len_s_q_useful_buf Int)))))
 (declare-datatypes ((s_buffer_alloc_ctx 0)) (((mks_buffer_alloc_ctx (e_buf Int) (e_len Int) (e_first Int) (e_first_free Int) (e_verify Int)))))
 (declare-datatypes ((s_rmm_trap_element 0)) (((mks_rmm_trap_element (e_aborted_pc Int) (e_new_pc Int)))))
 (declare-datatypes ((GLOBALS 0)) (((mkGLOBALS (g_heap (Array Int s_buffer_alloc_ctx)) (g_debug_exits Int) (g_vmid_count Int) (g_vmid_lock s_spinlock_t) (g_vmids (Array Int Int)) (g_nr_lrs Int) (g_nr_aprs Int) (g_max_vintid Int) (g_pri_res0_mask Int) (g_default_gicstate s_gic_cpu_state) (g_status_handler (Array Int Int)) (g_rmm_trap_list (Array Int s_rmm_trap_element)) (g_tt_l3_buffer s_s1tt) (g_tt_l2_mem0_0 s_s1tt) (g_tt_l2_mem0_1 s_s1tt) (g_tt_l2_mem1_0 s_s1tt) (g_tt_l2_mem1_1 s_s1tt) (g_tt_l2_mem1_2 s_s1tt) (g_tt_l2_mem1_3 s_s1tt) (g_tt_l1_upper (Array Int Int)) (g_mbedtls_mem_buf (Array Int Int)) (g_granules (Array Int s_granule)) (g_rmm_attest_signing_key Int) (g_rmm_attest_public_key (Array Int Int)) (g_rmm_attest_public_key_len Int) (g_rmm_attest_public_key_hash (Array Int Int)) (g_rmm_attest_public_key_hash_len Int) (g_platform_token_buf (Array Int Int)) (g_rmm_platform_token s_q_useful_buf) (g_get_realm_identity_identity (Array Int Int)) (g_realm_attest_private_key (Array Int Int))))))
 (declare-datatypes ((s_anon_1_2 0)) (((mks_anon_1_2 (e_s_anon_1_2_0 Int) (e_s_anon_1_2_1 Int) (e_s_anon_1_2_2 Int) (e_g_rd_s_realm_info Int)))))
 (declare-datatypes ((s_fpu_state 0)) (((mks_fpu_state (e_q (Array Int Int)) (e_fpsr Int) (e_fpcr Int) (e_used Int)))))
 (declare-datatypes ((s_anon_0 0)) (((mks_anon_0 (e_s_anon_0_0 Int) (e_s_anon_0_1 Int) (e_s_anon_0_2 Int)))))
 (declare-datatypes ((s_sysreg_state 0)) (((mks_sysreg_state (e_sp_el0 Int) (e_sp_el1 Int) (e_elr_el1 Int) (e_spsr_el2 Int) (e_spsr_el1 Int) (e_pmcr_el0 Int) (e_pmuserenr_el0 Int) (e_tpidrro_el0 Int) (e_tpidr_el0 Int) (e_csselr_el1 Int) (e_sctlr_el1 Int) (e_actlr_el1 Int) (e_cpacr_el1 Int) (e_zcr_el1 Int) (e_ttbr0_el1 Int) (e_ttbr1_el1 Int) (e_tcr_el1 Int) (e_esr_el1 Int) (e_afsr0_el1 Int) (e_afsr1_el1 Int) (e_far_el1 Int) (e_mair_el1 Int) (e_vbar_el1_s_sysreg_state Int) (e_contextidr_el1 Int) (e_tpidr_el1 Int) (e_amair_el1 Int) (e_cntkctl_el1 Int) (e_par_el1 Int) (e_mdscr_el1 Int) (e_mdccint_el1 Int) (e_disr_el1 Int) (e_mpam0_el1 Int) (e_cnthctl_el2 Int) (e_cntvoff_el2 Int) (e_cntp_ctl_el0 Int) (e_cntp_cval_el0 Int) (e_cntv_ctl_el0 Int) (e_cntv_cval_el0 Int) (e_gicstate s_gic_cpu_state) (e_vmpidr_el2 Int) (e_hcr_el2 Int) (e_cptr_el2 Int) (e_tcr_el2 Int) (e_sctlr_el2 Int)))))
 (declare-datatypes ((s_anon_1 0)) (((mks_anon_1 (e_s_anon_1_0 Int) (e_s_anon_1_1 Int) (e_s_anon_1_2 Int) (e_s_anon_1_3 Int)))))
 (declare-datatypes ((s_common_sysreg_state 0)) (((mks_common_sysreg_state (e_vttbr_el2 Int) (e_vtcr_el2 Int) (e_hcr_el2_common_flags Int)))))
 (declare-datatypes ((s_realm_s1_context 0)) (((mks_realm_s1_context (e_g_ttbr0 Int) (e_g_ttbr1 Int)))))
 (declare-datatypes ((s_anon_3 0)) (((mks_anon_3 (e_s_anon_3_0 Int)))))
 (declare-datatypes ((s_rec 0)) (((mks_rec (e_g_rec Int) (e_rec_idx Int) (e_runnable Int) (e_regs (Array Int Int)) (e_pc_s_rec Int) (e_pstate Int) (e_sysregs s_sysreg_state) (e_common_sysregs s_common_sysreg_state) (e_set_ripas s_anon_1) (e_dispose_info s_anon_0) (e_realm_info s_anon_1_2) (e_last_run_info u_anon_3) (e_fpu s_fpu_state) (e_ns Int) (e_psci_info s_anon_3) (e_is_pico_s_rec Int) (e_initialized Int) (e_s1_ctx s_realm_s1_context)))))
 (declare-datatypes ((s_mbedtls_sha256_context 0)) (((mks_mbedtls_sha256_context (e_total (Array Int Int)) (e_state (Array Int Int)) (e_buffer (Array Int Int)) (e_is224 Int)))))
 (declare-datatypes ((s_measurement_ctx 0)) (((mks_measurement_ctx (e_c s_mbedtls_sha256_context) (e_measurement_algo_s_measurement_ctx Int)))))
 (declare-datatypes ((s_realm_s2_context 0)) (((mks_realm_s2_context (e_ipa_bits Int) (e_s2_starting_level Int) (e_num_root_rtts Int) (e_g_rtt Int) (e_vmid Int)))))
 (declare-datatypes ((u_anon 0)) (((mku_anon (e_u_anon_0 (Array Int Int))))))
 (declare-datatypes ((s_measurement 0)) (((mks_measurement (e_0 u_anon)))))
 (declare-datatypes ((s_rd 0)) (((mks_rd (e_state_s_rd Int) (e_rec_count Int) (e_s2_ctx s_realm_s2_context) (e_par_base_s_rd Int) (e_par_size_s_rd Int) (e_par_end Int) (e_ctx s_measurement_ctx) (e_measurement (Array Int s_measurement)) (e_is_rc_s_rd Int)))))
 (declare-datatypes ((r_granule_data 0)) (((mkr_granule_data (gd_g_idx Int) (g_granule_state Int) (g_norm (Array Int Int)) (g_rd s_rd) (g_rec s_rec)))))
 (declare-datatypes ((Shared 0)) (((mkShared (gpt (Array Int Bool)) (granule_data (Array Int r_granule_data)) (globals GLOBALS)))))
 (declare-sort |Func_list Event_List_Event| 0)
 (declare-sort |Func_list Event_Shared_Option_Shared| 0)
 (declare-datatypes ((s_rec_params 0)) (((mks_rec_params (e_gprs_s_rec_params (Array Int Int)) (e_pc Int) (e_flags Int) (e_is_pico Int) (e_rtt Int) (e_vbar_el1 Int)))))
 (declare-datatypes ((s_rec_entry 0)) (((mks_rec_entry (e_gprs (Array Int Int)) (e_is_emulated_mmio Int) (e_emulated_read_val Int) (e_dispose_response Int) (e_gicv3_lrs (Array Int Int)) (e_gicv3_hcr Int) (e_trap_wfi Int) (e_trap_wfe Int)))))
 (declare-datatypes ((s_granule_set 0)) (((mks_granule_set (e_idx Int) (e_addr Int) (e_state_s_granule_set Int) (e_g Int) (e_g_ret Int)))))
 (declare-datatypes ((s_smc_result 0)) (((mks_smc_result (e_x0 Int) (e_x1 Int) (e_x2 Int) (e_x3 Int)))))
 (declare-datatypes ((s_rec_exit 0)) (((mks_rec_exit (e_exit_reason Int) (e_esr Int) (e_far Int) (e_hpfar Int) (e_emulated_write_val Int) (e_gprs_s_rec_exit (Array Int Int)) (e_target_rec Int) (e_disposed_addr Int) (e_disposed_size Int) (e_gicv3_vmcr Int) (e_gicv3_misr Int) (e_timer_info s_smc_result) (e_gicv3_lrs_s_rec_exit (Array Int Int)) (e_gicv3_hcr_s_rec_exit Int)))))
 (declare-datatypes ((s_attest_result 0)) (((mks_attest_result (e_return_to_realm Int) (e_rtt_level Int) (e_smc_result s_smc_result)))))
 (declare-datatypes ((s_realm_params 0)) (((mks_realm_params (e_par_base Int) (e_par_size Int) (e_rtt_addr Int) (e_measurement_algo Int) (e_realm_feat_0 Int) (e_s2_starting_level_s_realm_params Int) (e_num_s2_sl_rtts Int) (e_vmid_s_realm_params Int) (e_is_rc Int)))))
 (declare-datatypes ((s_anon_5 0)) (((mks_anon_5 (e_s_anon_5_0 Int) (e_s_anon_5_1 Int) (e_s_anon_5_2 Int) (e_s_anon_5_3 Int)))))
 (declare-datatypes ((s_psci_result 0)) (((mks_psci_result (e_hvc_forward s_anon_5) (e_smc_result_s_psci_result s_smc_result)))))
 (declare-datatypes ((s_ns_state 0)) (((mks_ns_state (e_sysregs_s_ns_state s_sysreg_state) (e_sp_el0_s_ns_state Int) (e_icc_sre_el2 Int) (e_fpu_s_ns_state s_fpu_state)))))
 (declare-datatypes ((s_anon 0)) (((mks_anon (e_s_anon_0 Int) (e_s_anon_1 Int) (e_s_anon_2 Int)))))
 (declare-datatypes ((s___QCBORTrackNesting 0)) (((mks___QCBORTrackNesting (e_pArrays (Array Int s_anon)) (e_pCurrentNesting Int)))))
 (declare-datatypes ((s_useful_out_buf 0)) (((mks_useful_out_buf (e_UB s_q_useful_buf) (e_data_len Int) (e_magic Int) (e_err Int)))))
 (declare-datatypes ((s__QCBOREncodeContext 0)) (((mks__QCBOREncodeContext (e_OutBuf s_useful_out_buf) (e_uError Int) (e_nesting s___QCBORTrackNesting)))))
 (declare-datatypes ((u_anon_0 0)) (((mku_anon_0 (e_u_anon_0_0 Int)))))
 (declare-datatypes ((s_t_cose_key 0)) (((mks_t_cose_key (e_crypto_lib Int) (e_k u_anon_0)))))
 (declare-datatypes ((s_t_cose_sign1_sign_ctx 0)) (((mks_t_cose_sign1_sign_ctx (e_protected_parameters s_q_useful_buf) (e_cose_algorithm_id Int) (e_signing_key s_t_cose_key) (e_option_flags Int) (e_kid s_q_useful_buf) (e_content_type_uint Int) (e_content_type_tstr Int)))))
 (declare-datatypes ((s_attest_token_encode_ctx 0)) (((mks_attest_token_encode_ctx (e_cbor_enc_ctx s__QCBOREncodeContext) (e_opt_flags Int) (e_key_select Int) (e_signer_ctx s_t_cose_sign1_sign_ctx)))))
 (declare-datatypes ((s_rtt_walk 0)) (((mks_rtt_walk (e_g_llt Int) (e_index_s_rtt_walk Int) (e_last_level Int)))))
 (declare-datatypes ((s_psa_key_policy_s 0)) (((mks_psa_key_policy_s (e_usage Int) (e_alg Int) (e_alg2 Int)))))
 (declare-datatypes ((s_psa_core_key_attributes_t 0)) (((mks_psa_core_key_attributes_t (e_type_s_psa_core_key_attributes_t Int) (e_bits Int) (e_lifetime Int) (e_id Int) (e_policy s_psa_key_policy_s) (e_flags_s_psa_core_key_attributes_t Int)))))
 (declare-datatypes ((s_psa_key_attributes_s 0)) (((mks_psa_key_attributes_s (e_core s_psa_core_key_attributes_t) (e_domain_parameters Int) (e_domain_parameters_size Int)))))
 (declare-datatypes ((STACK 0)) (((mkSTACK (stack_type_1 Int) (stack_type_2 Int) (stack_type_3 Int) (stack_type_3__1 Int) (stack_s_smc_result s_smc_result) (stack_s_smc_result__1 s_smc_result) (stack_s_rmm_trap_element s_rmm_trap_element) (stack_s_rec_exit s_rec_exit) (stack_type_4 Int) (stack_type_4__1 Int) (stack_s_ns_state s_ns_state) (stack_s_q_useful_buf s_q_useful_buf) (stack_s_q_useful_buf__1 s_q_useful_buf) (stack_s_q_useful_buf__2 s_q_useful_buf) (stack_s_q_useful_buf__3 s_q_useful_buf) (stack_s_attest_token_encode_ctx s_attest_token_encode_ctx) (stack_s_rtt_walk s_rtt_walk) (stack_s_rtt_walk__1 s_rtt_walk) (stack_s_psci_result s_psci_result) (stack_s_attest_result s_attest_result) (stack_s_rec_entry s_rec_entry) (stack_s_realm_s2_context s_realm_s2_context) (stack_s_rec_params s_rec_params) (stack_s_realm_params s_realm_params) (stack_s_psa_key_attributes_s s_psa_key_attributes_s) (stack_type_5 (Array Int Int)) (stack_type_6 (Array Int s_granule_set)) (stack_type_7 (Array Int Int)) (stack_type_8 (Array Int Int))))))
 (declare-datatypes ((ns_copy_type 0)) (((READ_REALM_PARAMS) (READ_REC_PARAMS) (READ_REC_RUN) (WRITE_REC_RUN (run (Array Int Int))) (READ_DATA (gidx Int)))))
 (declare-datatypes ((realm_trap_type 0)) (((WFX) (HVC) (SMC) (IDREG) (TIMER) (ICC) (DATA_ABORT) (INSTR_ABORT) (IRQ) (FIQ))))
 (declare-datatypes ((update_rec_list_type 0)) (((GET_RECL) (SET_RECL (gidx Int)) (UNSET_RECL))))
 (declare-datatypes ((AtomicEvent 0)) (((ACQ (gidx Int)) (REL (gidx1 Int) (gn s_granule)) (REC_REF (ref_gidx Int) (ref_cnt Int)) (GET_GCNT (gidx3 Int)) (INC_GCNT (gidx4 Int)) (DEC_RD_GCNT (gidx5 Int)) (DEC_REC_GCNT (gidx6 Int) (gn_1 s_granule)) (RECL (gidx7 Int) (idx8 Int) (t update_rec_list_type)) (ACQ_GPT (gidx9 Int)) (REL_GPT (gidx10 Int) (secure Bool)) (RTT_WALK (root_gidx Int) (map_addr Int) (level Int)) (RTT_CREATE (root_gidx1 Int) (map_addr1 Int) (level1 Int) (rtt_addr Int)) (RTT_DESTROY (root_gidx2 Int) (map_addr2 Int) (level2 Int)) (COPY_NS (gidx11 Int) (t1 ns_copy_type)) (NS_ACCESS_MEM (addr Int) (val Int)) (REALM_ACCESS_MEM (rd Int) (rec Int) (addr1 Int) (val1 Int)) (REALM_ACCESS_REG (rd1 Int) (rec1 Int) (reg Int) (val2 Int)) (REALM_ACTIVATE (rd_gidx Int)) (REALM_TRAP (rd2 Int) (rec2 Int) (trap_type realm_trap_type)))))
 (declare-datatypes ((Event 0)) (((EVT (cpuid Int) (e AtomicEvent)))))
 (declare-datatypes ((List_Event 0)) (((cons_Event (head_Event Event) (tail_Event List_Event)) (nil_Event))))
 (declare-datatypes ((PerCPURegs 0)) (((mkPerCPURegs (pcpu_vttbr_el2 Int) (pcpu_zcr_el2 Int) (pcpu_cnthctl_el2 Int) (pcpu_elr_el2 Int) (pcpu_cptr_el2 Int) (pcpu_mdcr_el2 Int) (pcpu_vpidr_el2 Int) (pcpu_sctlr_el2 Int) (pcpu_esr_el2 Int) (pcpu_spsr_el2 Int) (pcpu_hpfar_el2 Int) (pcpu_far_el2 Int) (pcpu_vsesr_el2 Int) (pcpu_hcr_el2 Int) (pcpu_cntvoff_el2 Int) (pcpu_vmpidr_el2 Int) (pcpu_vtcr_el2 Int) (pcpu_ich_hcr_el2 Int) (pcpu_ich_misr_el2 Int) (pcpu_ich_vmcr_el2 Int) (pcpu_ich_ap0r3_el2 Int) (pcpu_ich_ap0r2_el2 Int) (pcpu_ich_ap0r1_el2 Int) (pcpu_ich_ap0r0_el2 Int) (pcpu_ich_ap1r3_el2 Int) (pcpu_ich_ap1r2_el2 Int) (pcpu_ich_ap1r1_el2 Int) (pcpu_ich_ap1r0_el2 Int) (pcpu_ich_ir0 Int) (pcpu_ich_ir1 Int) (pcpu_ich_ir2 Int) (pcpu_ich_ir3 Int) (pcpu_ich_ir4 Int) (pcpu_ich_ir5 Int) (pcpu_ich_ir6 Int) (pcpu_ich_ir7 Int) (pcpu_ich_ir8 Int) (pcpu_ich_ir9 Int) (pcpu_ich_lr0_el2 Int) (pcpu_ich_lr1_el2 Int) (pcpu_ich_lr2_el2 Int) (pcpu_ich_lr3_el2 Int) (pcpu_ich_lr4_el2 Int) (pcpu_ich_lr5_el2 Int) (pcpu_ich_lr6_el2 Int) (pcpu_ich_lr7_el2 Int) (pcpu_ich_lr8_el2 Int) (pcpu_ich_lr9_el2 Int) (pcpu_ich_lr10_el2 Int) (pcpu_ich_lr11_el2 Int) (pcpu_ich_lr12_el2 Int) (pcpu_ich_lr13_el2 Int) (pcpu_ich_lr14_el2 Int) (pcpu_ich_lr15_el2 Int) (pcpu_icc_sre_el2 Int) (pcpu_esr_el12 Int) (pcpu_spsr_el12 Int) (pcpu_elr_el12 Int) (pcpu_vbar_el12 Int) (pcpu_far_el12 Int) (pcpu_amair_el12 Int) (pcpu_cntkctl_el12 Int) (pcpu_cntp_ctl_el02 Int) (pcpu_cntp_cval_el02 Int) (pcpu_cntpoff_el2 Int) (pcpu_cntv_ctl_el02 Int) (pcpu_cntv_cval_el02 Int) (pcpu_contextidr_el12 Int) (pcpu_mair_el12 Int) (pcpu_afsr1_el12 Int) (pcpu_afsr0_el12 Int) (pcpu_tcr_el12 Int) (pcpu_ttbr1_el12 Int) (pcpu_ttbr0_el12 Int) (pcpu_cpacr_el12 Int) (pcpu_sctlr_el12 Int) (pcpu_midr_el1 Int) (pcpu_isr_el1 Int) (pcpu_id_aa64mmfr0_el1 Int) (pcpu_id_aa64mmfr1_el1 Int) (pcpu_id_aa64dfr0_el1 Int) (pcpu_id_aa64dfr1_el1 Int) (pcpu_id_aa64pfr0_el1 Int) (pcpu_id_aa64pfr1_el1 Int) (pcpu_disr_el1 Int) (pcpu_mdccint_el1 Int) (pcpu_mdscr_el1 Int) (pcpu_par_el1 Int) (pcpu_tpidr_el1 Int) (pcpu_actlr_el1 Int) (pcpu_csselr_el1 Int) (pcpu_sp_el1 Int) (pcpu_pmintenset_el1 Int) (pcpu_pmintenclr_el1 Int) (pcpu_icc_hppir1_el1 Int) (pcpu_pmcr_el0 Int) (pcpu_pmevtyper0_el0 Int) (pcpu_pmevtyper1_el0 Int) (pcpu_pmevtyper2_el0 Int) (pcpu_pmevtyper3_el0 Int) (pcpu_pmevtyper4_el0 Int) (pcpu_pmevtyper5_el0 Int) (pcpu_pmevtyper6_el0 Int) (pcpu_pmevtyper7_el0 Int) (pcpu_pmevtyper8_el0 Int) (pcpu_pmevtyper9_el0 Int) (pcpu_pmevtyper10_el0 Int) (pcpu_pmevtyper11_el0 Int) (pcpu_pmevtyper12_el0 Int) (pcpu_pmevtyper13_el0 Int) (pcpu_pmevtyper14_el0 Int) (pcpu_pmevtyper15_el0 Int) (pcpu_pmevtyper16_el0 Int) (pcpu_pmevtyper17_el0 Int) (pcpu_pmevtyper18_el0 Int) (pcpu_pmevtyper19_el0 Int) (pcpu_pmevtyper20_el0 Int) (pcpu_pmevtyper21_el0 Int) (pcpu_pmevtyper22_el0 Int) (pcpu_pmevtyper23_el0 Int) (pcpu_pmevtyper24_el0 Int) (pcpu_pmevtyper25_el0 Int) (pcpu_pmevtyper26_el0 Int) (pcpu_pmevtyper27_el0 Int) (pcpu_pmevtyper28_el0 Int) (pcpu_pmevtyper29_el0 Int) (pcpu_pmevtyper30_el0 Int) (pcpu_pmevcntr0_el0 Int) (pcpu_pmevcntr1_el0 Int) (pcpu_pmevcntr2_el0 Int) (pcpu_pmevcntr3_el0 Int) (pcpu_pmevcntr4_el0 Int) (pcpu_pmevcntr5_el0 Int) (pcpu_pmevcntr6_el0 Int) (pcpu_pmevcntr7_el0 Int) (pcpu_pmevcntr8_el0 Int) (pcpu_pmevcntr9_el0 Int) (pcpu_pmevcntr10_el0 Int) (pcpu_pmevcntr11_el0 Int) (pcpu_pmevcntr12_el0 Int) (pcpu_pmevcntr13_el0 Int) (pcpu_pmevcntr14_el0 Int) (pcpu_pmevcntr15_el0 Int) (pcpu_pmevcntr16_el0 Int) (pcpu_pmevcntr17_el0 Int) (pcpu_pmevcntr18_el0 Int) (pcpu_pmevcntr19_el0 Int) (pcpu_pmevcntr20_el0 Int) (pcpu_pmevcntr21_el0 Int) (pcpu_pmevcntr22_el0 Int) (pcpu_pmevcntr23_el0 Int) (pcpu_pmevcntr24_el0 Int) (pcpu_pmevcntr25_el0 Int) (pcpu_pmevcntr26_el0 Int) (pcpu_pmevcntr27_el0 Int) (pcpu_pmevcntr28_el0 Int) (pcpu_pmevcntr29_el0 Int) (pcpu_pmevcntr30_el0 Int) (pcpu_pmccfiltr_el0 Int) (pcpu_pmccntr_el0 Int) (pcpu_pmcntenset_el0 Int) (pcpu_pmcntenclr_el0 Int) (pcpu_pmovsclr_el0 Int) (pcpu_pmovsset_el0 Int) (pcpu_pmselr_el0 Int) (pcpu_pmuserenr_el0 Int) (pcpu_pmxevcntr_el0 Int) (pcpu_pmxevtyper_el0 Int) (pcpu_tpidr_el0 Int) (pcpu_tpidrro_el0 Int) (pcpu_sp_el0 Int) (pcpu_cntfrq_el0 Int) (pcpu_dummy_regs Int)))))
 (declare-datatypes ((GPRegs 0)) (((mkGPRegs (X0 Int) (X1 Int) (X2 Int) (X3 Int) (X4 Int) (X5 Int) (X6 Int) (X7 Int) (X8 Int) (X9 Int) (X10 Int) (X11 Int) (X12 Int) (X13 Int) (X14 Int) (X15 Int) (X16 Int) (X17 Int) (X18 Int) (X19 Int) (X20 Int) (X21 Int) (X22 Int) (X23 Int) (X24 Int) (X25 Int) (X26 Int) (X27 Int) (X28 Int) (X29 Int) (LR Int)))))
 (declare-datatypes ((PerCPU 0)) (((mkPerCPU (pcpu_regs PerCPURegs) (pcpu_gpregs GPRegs)))))
 (declare-datatypes ((RData 0)) (((mkRData (log List_Event) (oracle |Func_list Event_List_Event|) (repl |Func_list Event_Shared_Option_Shared|) (priv PerCPU) (share Shared) (stack STACK) (halt Bool)))))
 (declare-datatypes ((Option_Shared 0)) (((Some_Shared (value_Shared Shared)) (None_Shared))))
 (declare-datatypes ((abs_PA_t 0)) (((mkabs_PA_t (meta_granule_offset Int)))))
 (declare-datatypes ((abs_PTE_t 0)) (((mkabs_PTE_t (meta_PA abs_PA_t) (meta_desc_type Int) (meta_ripas Int) (meta_mem_attr Int)))))
 (declare-datatypes ((Option_RData 0)) (((Some_RData (value_RData RData)) (None_RData))))
 (declare-datatypes ((Ptr 0)) (((mkPtr (pbase String) (poffset Int)))))
 (declare-datatypes ((abs_ret_rtt 0)) (((mkabs_ret_rtt (e_1 Int) (e_2 Ptr) (e_3 Int)))))
 (declare-datatypes ((Tuple_abs_ret_rtt_RData 0)) (((mkTuple_abs_ret_rtt_RData (elem_0 abs_ret_rtt) (elem_1 RData)))))
 (declare-datatypes ((Option_Tuple_abs_ret_rtt_RData 0)) (((Some_Tuple_abs_ret_rtt_RData (value_Tuple_abs_ret_rtt_RData Tuple_abs_ret_rtt_RData)) (None_Tuple_abs_ret_rtt_RData))))
 (declare-datatypes ((Tuple_bool_RData 0)) (((mkTuple_bool_RData (elem_0 Bool) (elem_1 RData)))))
 (declare-datatypes ((Option_Tuple_bool_RData 0)) (((Some_Tuple_bool_RData (value_Tuple_bool_RData Tuple_bool_RData)) (None_Tuple_bool_RData))))
 (declare-datatypes ((Tuple_Ptr_RData 0)) (((mkTuple_Ptr_RData (elem_0 Ptr) (elem_1 RData)))))
 (declare-datatypes ((Option_Tuple_Ptr_RData 0)) (((Some_Tuple_Ptr_RData (value_Tuple_Ptr_RData Tuple_Ptr_RData)) (None_Tuple_Ptr_RData))))
 (declare-fun st.0 () RData)
(declare-fun |(repl st.0)_call| (List_Event Shared) Option_Shared)
(declare-fun |(oracle st.0)_call| (List_Event) List_Event)
(declare-fun test_Z_PTE.0_call (Int) abs_PTE_t)
(declare-fun check_rcsm_mask_para.0_call (abs_PA_t) Bool)
(declare-fun test_PA.0_call (Int) abs_PA_t)
(declare-fun v_1.0 () Int)
(declare-fun v_0.96777 () Int)
(declare-fun spinlock_acquire_spec.0_call (Ptr RData) Option_RData)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
  (repl (value_RData (spinlock_acquire_spec.0_call a!1 st.0))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
  (oracle (value_RData (spinlock_acquire_spec.0_call a!1 st.0))))_call| (List_Event) List_Event)
(declare-fun v_0.2440701 () Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
  (repl (value_RData a!2))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
  (oracle (value_RData a!2))))_call| (List_Event) List_Event)
(declare-fun rec_to_ttbr1_para.0_call (Ptr RData) Ptr)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
  (repl a!4)))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
  (oracle a!4)))))_call| (List_Event) List_Event)
(declare-fun spinlock_release_spec.0_call (Ptr RData) Option_RData)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
  (repl a!5))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
  (oracle a!5))))))_call| (List_Event) List_Event)
(declare-fun rtt_walk_lock_unlock_spec_abs.0_call (Ptr Ptr Int Int Int Int RData) Option_Tuple_abs_ret_rtt_RData)
(declare-fun v_2.0 () Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
  (repl a!6)))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
  (oracle a!6)))))))_call| (List_Event) List_Event)
(declare-fun abs_tte_read.0_call (Ptr RData) abs_PTE_t)
(declare-fun rec_to_rd_para.0_call (Ptr RData) Ptr)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!6)))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!7) (poffset a!7))
                          a!6))))
  (repl a!8)))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!6)))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!7) (poffset a!7))
                          a!6))))
  (oracle a!8)))))))))_call| (List_Event) List_Event)
(declare-fun memcpy_ns_read_spec.0_call (Ptr Ptr Int RData) Option_Tuple_bool_RData)
(declare-fun v_0.2455373 () Int)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!3))))
(let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          (value_RData a!3)))))
(let ((a!6 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          a!5))))
(let ((a!7 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!4
                       0
                       64
                       v_2.0
                       3
                       a!6)))))
(let ((a!8 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!7)))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!8) (poffset a!8))
                          a!7))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!1
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (repl a!10))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!3))))
(let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          (value_RData a!3)))))
(let ((a!6 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          a!5))))
(let ((a!7 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!4
                       0
                       64
                       v_2.0
                       3
                       a!6)))))
(let ((a!8 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!7)))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!8) (poffset a!8))
                          a!7))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!1
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (oracle a!10))))))))))_call| (List_Event) List_Event)
(declare-fun memset_spec.0_call (Ptr Int Int RData) Option_Tuple_Ptr_RData)
(declare-fun v_0.2455709 () Int)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!3 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!3 st.0)))))
(let ((a!5 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!4))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!5) (poffset a!5))
                          (value_RData a!4)))))
(let ((a!7 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!5) (poffset a!5))
                          a!6))))
(let ((a!8 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!5
                       0
                       64
                       v_2.0
                       3
                       a!7)))))
(let ((a!9 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!8)))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!9) (poffset a!9))
                           a!8))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
  (repl (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!11)))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!3 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!3 st.0)))))
(let ((a!5 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!4))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!5) (poffset a!5))
                          (value_RData a!4)))))
(let ((a!7 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!5) (poffset a!5))
                          a!6))))
(let ((a!8 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!5
                       0
                       64
                       v_2.0
                       3
                       a!7)))))
(let ((a!9 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!8)))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!9) (poffset a!9))
                           a!8))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
  (oracle (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!11)))))))))))))_call| (List_Event) List_Event)
(declare-fun granule_unlock_spec.0_call (Ptr RData) Option_RData)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!6)))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           a!6))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
  (repl (value_RData a!12))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!6)))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           a!6))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
  (oracle (value_RData a!12))))))))))))_call| (List_Event) List_Event)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!5))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!6))))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           (elem_1 a!6)))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
                           (value_RData a!12)))))
  (repl a!13))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!5))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!6))))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           (elem_1 a!6)))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
                           (value_RData a!12)))))
  (oracle a!13))))))))))))_call| (List_Event) List_Event)
(declare-fun pack_struct_return_code_para.0_call (Int) Int)
(declare-fun make_return_code_para.0_call (Int) Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!5))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!6))))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           (elem_1 a!6)))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
                           (value_RData a!12)))))
(let ((a!14 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!13)))
  (repl (value_RData a!14))))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!5))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!6))))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           (elem_1 a!6)))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
                           (value_RData a!12)))))
(let ((a!14 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!13)))
  (oracle (value_RData a!14))))))))))))))_call| (List_Event) List_Event)
(declare-fun v_0.2458453 () Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2458453)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!10 (mkPtr "granule_data"
                   (meta_granule_offset
                     (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!38 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2458453)))
                 4096)))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!3))))
(let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          (value_RData a!3)))))
(let ((a!6 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          a!5))))
(let ((a!7 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!4
               0
               64
               v_2.0
               3
               a!6))))
(let ((a!8 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!7))))
(let ((a!11 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!8) (poffset a!8))
                           (elem_1 a!7)))))
(let ((a!12 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!10
                        (mkPtr "granule_data" 0)
                        4096
                        a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              a!8
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!9 0 4096 a!12))))))
(let ((a!14 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!7))
                           (value_RData a!13)))))
(let ((a!15 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!14)))
(let ((a!16 (g_heap (globals (share (value_RData a!15)))))
      (a!17 (g_debug_exits (globals (share (value_RData a!15)))))
      (a!18 (g_vmid_count (globals (share (value_RData a!15)))))
      (a!19 (g_vmid_lock (globals (share (value_RData a!15)))))
      (a!20 (g_vmids (globals (share (value_RData a!15)))))
      (a!21 (g_nr_lrs (globals (share (value_RData a!15)))))
      (a!22 (g_nr_aprs (globals (share (value_RData a!15)))))
      (a!23 (g_max_vintid (globals (share (value_RData a!15)))))
      (a!24 (g_pri_res0_mask (globals (share (value_RData a!15)))))
      (a!25 (g_default_gicstate (globals (share (value_RData a!15)))))
      (a!26 (g_status_handler (globals (share (value_RData a!15)))))
      (a!27 (g_rmm_trap_list (globals (share (value_RData a!15)))))
      (a!28 (g_tt_l3_buffer (globals (share (value_RData a!15)))))
      (a!29 (g_tt_l2_mem0_0 (globals (share (value_RData a!15)))))
      (a!30 (g_tt_l2_mem0_1 (globals (share (value_RData a!15)))))
      (a!31 (g_tt_l2_mem1_0 (globals (share (value_RData a!15)))))
      (a!32 (g_tt_l2_mem1_1 (globals (share (value_RData a!15)))))
      (a!33 (g_tt_l2_mem1_2 (globals (share (value_RData a!15)))))
      (a!34 (g_tt_l2_mem1_3 (globals (share (value_RData a!15)))))
      (a!35 (g_tt_l1_upper (globals (share (value_RData a!15)))))
      (a!36 (g_mbedtls_mem_buf (globals (share (value_RData a!15)))))
      (a!37 (g_granules (globals (share (value_RData a!15)))))
      (a!40 (g_rmm_attest_signing_key (globals (share (value_RData a!15)))))
      (a!41 (g_rmm_attest_public_key (globals (share (value_RData a!15)))))
      (a!42 (g_rmm_attest_public_key_len (globals (share (value_RData a!15)))))
      (a!43 (g_rmm_attest_public_key_hash (globals (share (value_RData a!15)))))
      (a!44 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!15)))))
      (a!45 (g_platform_token_buf (globals (share (value_RData a!15)))))
      (a!46 (g_rmm_platform_token (globals (share (value_RData a!15)))))
      (a!47 (g_get_realm_identity_identity (globals (share (value_RData a!15)))))
      (a!48 (g_realm_attest_private_key (globals (share (value_RData a!15))))))
(let ((a!39 (store a!37
                   a!38
                   (mks_granule (e_lock (select a!37 a!38))
                                4
                                (e_ref (select a!37 a!38))))))
(let ((a!49 (mkShared (gpt (share (value_RData a!15)))
                      (granule_data (share (value_RData a!15)))
                      (mkGLOBALS a!16
                                 a!17
                                 a!18
                                 a!19
                                 a!20
                                 a!21
                                 a!22
                                 a!23
                                 a!24
                                 a!25
                                 a!26
                                 a!27
                                 a!28
                                 a!29
                                 a!30
                                 a!31
                                 a!32
                                 a!33
                                 a!34
                                 a!35
                                 a!36
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46
                                 a!47
                                 a!48))))
(let ((a!50 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!15))
                       (oracle (value_RData a!15))
                       (repl (value_RData a!15))
                       (priv (value_RData a!15))
                       a!49
                       (stack (value_RData a!15))
                       (halt (value_RData a!15))))))
  (repl (value_RData a!50))))))))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2458453)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!10 (mkPtr "granule_data"
                   (meta_granule_offset
                     (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!38 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2458453)))
                 4096)))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!3))))
(let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          (value_RData a!3)))))
(let ((a!6 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          a!5))))
(let ((a!7 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!4
               0
               64
               v_2.0
               3
               a!6))))
(let ((a!8 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!7))))
(let ((a!11 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!8) (poffset a!8))
                           (elem_1 a!7)))))
(let ((a!12 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!10
                        (mkPtr "granule_data" 0)
                        4096
                        a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              a!8
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!9 0 4096 a!12))))))
(let ((a!14 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!7))
                           (value_RData a!13)))))
(let ((a!15 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!14)))
(let ((a!16 (g_heap (globals (share (value_RData a!15)))))
      (a!17 (g_debug_exits (globals (share (value_RData a!15)))))
      (a!18 (g_vmid_count (globals (share (value_RData a!15)))))
      (a!19 (g_vmid_lock (globals (share (value_RData a!15)))))
      (a!20 (g_vmids (globals (share (value_RData a!15)))))
      (a!21 (g_nr_lrs (globals (share (value_RData a!15)))))
      (a!22 (g_nr_aprs (globals (share (value_RData a!15)))))
      (a!23 (g_max_vintid (globals (share (value_RData a!15)))))
      (a!24 (g_pri_res0_mask (globals (share (value_RData a!15)))))
      (a!25 (g_default_gicstate (globals (share (value_RData a!15)))))
      (a!26 (g_status_handler (globals (share (value_RData a!15)))))
      (a!27 (g_rmm_trap_list (globals (share (value_RData a!15)))))
      (a!28 (g_tt_l3_buffer (globals (share (value_RData a!15)))))
      (a!29 (g_tt_l2_mem0_0 (globals (share (value_RData a!15)))))
      (a!30 (g_tt_l2_mem0_1 (globals (share (value_RData a!15)))))
      (a!31 (g_tt_l2_mem1_0 (globals (share (value_RData a!15)))))
      (a!32 (g_tt_l2_mem1_1 (globals (share (value_RData a!15)))))
      (a!33 (g_tt_l2_mem1_2 (globals (share (value_RData a!15)))))
      (a!34 (g_tt_l2_mem1_3 (globals (share (value_RData a!15)))))
      (a!35 (g_tt_l1_upper (globals (share (value_RData a!15)))))
      (a!36 (g_mbedtls_mem_buf (globals (share (value_RData a!15)))))
      (a!37 (g_granules (globals (share (value_RData a!15)))))
      (a!40 (g_rmm_attest_signing_key (globals (share (value_RData a!15)))))
      (a!41 (g_rmm_attest_public_key (globals (share (value_RData a!15)))))
      (a!42 (g_rmm_attest_public_key_len (globals (share (value_RData a!15)))))
      (a!43 (g_rmm_attest_public_key_hash (globals (share (value_RData a!15)))))
      (a!44 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!15)))))
      (a!45 (g_platform_token_buf (globals (share (value_RData a!15)))))
      (a!46 (g_rmm_platform_token (globals (share (value_RData a!15)))))
      (a!47 (g_get_realm_identity_identity (globals (share (value_RData a!15)))))
      (a!48 (g_realm_attest_private_key (globals (share (value_RData a!15))))))
(let ((a!39 (store a!37
                   a!38
                   (mks_granule (e_lock (select a!37 a!38))
                                4
                                (e_ref (select a!37 a!38))))))
(let ((a!49 (mkShared (gpt (share (value_RData a!15)))
                      (granule_data (share (value_RData a!15)))
                      (mkGLOBALS a!16
                                 a!17
                                 a!18
                                 a!19
                                 a!20
                                 a!21
                                 a!22
                                 a!23
                                 a!24
                                 a!25
                                 a!26
                                 a!27
                                 a!28
                                 a!29
                                 a!30
                                 a!31
                                 a!32
                                 a!33
                                 a!34
                                 a!35
                                 a!36
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46
                                 a!47
                                 a!48))))
(let ((a!50 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!15))
                       (oracle (value_RData a!15))
                       (repl (value_RData a!15))
                       (priv (value_RData a!15))
                       a!49
                       (stack (value_RData a!15))
                       (halt (value_RData a!15))))))
  (oracle (value_RData a!50))))))))))))))))))_call| (List_Event) List_Event)
(assert
 (forall ((gidx.89076 Int) )(let ((?x12 (share st.0)))
 (let ((?x19 (globals ?x12)))
 (let ((?x21 (g_granules ?x19)))
 (let ((?x59 (select ?x21 gidx.89076)))
 (let ((?x60 (e_state_s_granule ?x59)))
 (let (($x61 (= ?x60 6)))
 (let (($x62 (= ?x60 0)))
 (=> (not (select (gpt ?x12) gidx.89076)) (or $x62 $x61))))))))))
 )
(assert
 (let (($x1045 (forall ((gidx.96366 Int) )(let ((?x12 (share st.0)))
 (let ((?x7 (log st.0)))
 (let ((?x10 (|(oracle st.0)_call| ?x7)))
 (let ((?x15 (|(repl st.0)_call| ?x10 ?x12)))
 (let ((?x17 (value_Shared ?x15)))
 (let ((?x87 (gpt ?x17)))
 (let (($x102 (select ?x87 gidx.96366)))
 (let ((?x52 (globals ?x17)))
 (let ((?x53 (g_granules ?x52)))
 (let ((?x96 (select ?x53 gidx.96366)))
 (let ((?x98 (e_state_s_granule ?x96)))
 (let (($x100 (= ?x98 0)))
 (let (($x99 (= ?x98 6)))
 (or $x99 $x100 $x102)))))))))))))))
 ))
 (let (($x1121 (forall ((gidx.96349 Int) )(let ((?x12 (share st.0)))
 (let ((?x48 (gpt ?x12)))
 (let (($x64 (select ?x48 gidx.96349)))
 (let ((?x19 (globals ?x12)))
 (let ((?x21 (g_granules ?x19)))
 (let ((?x59 (select ?x21 gidx.96349)))
 (let ((?x60 (e_state_s_granule ?x59)))
 (let (($x62 (= ?x60 0)))
 (let (($x61 (= ?x60 6)))
 (or $x61 $x62 $x64)))))))))))
 ))
 (or (not $x1121) $x1045))))
(assert
 (forall ((v_0.96777 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))) 4096)))
 (let ((?x12 (share st.0)))
 (let ((?x48 (gpt ?x12)))
 (select ?x48 ?x1047)))))
 )
(assert
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let (($x1001 (check_rcsm_mask_para.0_call ?x1089)))
 (not $x1001))))
(assert
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x4934 (* (- 1) ?x17296)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1186 (+ ?x2607 ?x4934)))
 (let (($x29327 (= ?x1186 0)))
 (not $x29327))))))))))
(assert
 (forall ((gidx.2440666 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x9158 (share ?x1125)))
 (let ((?x1151 (globals ?x9158)))
 (let ((?x1113 (g_granules ?x1151)))
 (let ((?x1143 (e_state_s_granule (select ?x1113 gidx.2440666))))
 (let (($x1149 (= ?x1143 6)))
 (let (($x1181 (= ?x1143 0)))
 (=> (not (select (gpt ?x9158) gidx.2440666)) (or $x1181 $x1149)))))))))))))))
 )
(assert
 (forall ((v_0.2440701 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2440701))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x9158 (share ?x1125)))
 (let ((?x1150 (gpt ?x9158)))
 (select ?x1150 ?x1047)))))))))))
 )
(assert
 (let (($x5204 (forall ((gidx.2440889 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x9158 (share ?x1125)))
 (let ((?x1156 (log ?x1125)))
 (let ((?x1166 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
  (oracle (value_RData (spinlock_acquire_spec.0_call a!1 st.0))))_call| ?x1156)))
 (let ((?x1164 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
  (repl (value_RData (spinlock_acquire_spec.0_call a!1 st.0))))_call| ?x1166 ?x9158)))
 (let ((?x1182 (value_Shared ?x1164)))
 (let ((?x1200 (gpt ?x1182)))
 (let (($x1217 (select ?x1200 gidx.2440889)))
 (let ((?x1139 (e_state_s_granule (select (g_granules (globals ?x1182)) gidx.2440889))))
 (let (($x1159 (= ?x1139 6)))
 (let (($x1137 (= ?x1139 0)))
 (or $x1137 $x1159 $x1217))))))))))))))))))
 ))
 (let (($x5190 (forall ((gidx.2440872 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x9158 (share ?x1125)))
 (let ((?x1151 (globals ?x9158)))
 (let ((?x1113 (g_granules ?x1151)))
 (let ((?x1143 (e_state_s_granule (select ?x1113 gidx.2440872))))
 (let (($x1181 (= ?x1143 0)))
 (let ((?x1150 (gpt ?x9158)))
 (let (($x1179 (select ?x1150 gidx.2440872)))
 (let (($x1149 (= ?x1143 6)))
 (or $x1149 $x1179 $x1181))))))))))))))))
 ))
 (or (not $x5190) $x5204))))
(assert
 (let ((?x5251 (test_Z_PTE.0_call v_0.2440701)))
 (let ((?x4895 (meta_PA ?x5251)))
 (let ((?x5084 (meta_granule_offset ?x4895)))
 (let ((?x5126 (div ?x5084 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x9158 (share ?x1125)))
 (let ((?x1151 (globals ?x9158)))
 (let ((?x1113 (g_granules ?x1151)))
 (let ((?x5052 (select ?x1113 ?x5126)))
 (let ((?x5215 (e_state_s_granule ?x5052)))
 (= ?x5215 1)))))))))))))))))
(assert
 (forall ((gidx.2441002 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x17364 (share ?x1212)))
 (let ((?x1274 (globals ?x17364)))
 (let ((?x1259 (g_granules ?x1274)))
 (let ((?x1298 (e_state_s_granule (select ?x1259 gidx.2441002))))
 (let (($x1268 (= ?x1298 6)))
 (let (($x1291 (= ?x1298 0)))
 (=> (not (select (gpt ?x17364) gidx.2441002)) (or $x1291 $x1268))))))))))))))))))))
 )
(assert
 (forall ((v_0.2441037 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2441037))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x17364 (share ?x1212)))
 (let ((?x1230 (gpt ?x17364)))
 (select ?x1230 ?x1047))))))))))))))))
 )
(assert
 (let (($x5323 (forall ((gidx.2441225 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x17364 (share ?x1212)))
 (let ((?x1314 (log ?x1212)))
 (let ((?x1320 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
  (oracle (value_RData a!2))))_call| ?x1314)))
 (let ((?x1247 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
  (repl (value_RData a!2))))_call| ?x1320 ?x17364)))
 (let ((?x1317 (value_Shared ?x1247)))
 (let ((?x1342 (gpt ?x1317)))
 (let (($x1359 (select ?x1342 gidx.2441225)))
 (let ((?x1355 (e_state_s_granule (select (g_granules (globals ?x1317)) gidx.2441225))))
 (let (($x1357 (= ?x1355 0)))
 (let (($x1356 (= ?x1355 6)))
 (or $x1356 $x1357 $x1359)))))))))))))))))))))))
 ))
 (let (($x5287 (forall ((gidx.2441208 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x17364 (share ?x1212)))
 (let ((?x1230 (gpt ?x17364)))
 (let (($x1306 (select ?x1230 gidx.2441208)))
 (let ((?x1298 (e_state_s_granule (select (g_granules (globals ?x17364)) gidx.2441208))))
 (let (($x1291 (= ?x1298 0)))
 (let (($x1268 (= ?x1298 6)))
 (or $x1268 $x1291 $x1306)))))))))))))))))))
 ))
 (or (not $x5287) $x5323))))
(assert
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1318 (div ?x17296 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x17364 (share ?x1212)))
 (let ((?x1274 (globals ?x17364)))
 (let ((?x1259 (g_granules ?x1274)))
 (let ((?x1290 (select ?x1259 ?x1318)))
 (let ((?x1313 (e_state_s_granule ?x1290)))
 (= ?x1313 3)))))))))))))))))))
(assert
 (forall ((gidx.2441338 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x29595 (share ?x4559)))
 (let ((?x5413 (globals ?x29595)))
 (let ((?x5262 (g_granules ?x5413)))
 (let ((?x4710 (e_state_s_granule (select ?x5262 gidx.2441338))))
 (let (($x5355 (= ?x4710 6)))
 (let (($x5240 (= ?x4710 0)))
 (=> (not (select (gpt ?x29595) gidx.2441338)) (or $x5240 $x5355)))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2441373 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2441373))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x29595 (share ?x4559)))
 (let ((?x5246 (gpt ?x29595)))
 (select ?x5246 ?x1047)))))))))))))))))))))))
 )
(assert
 (let (($x5358 (forall ((gidx.2441561 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x29595 (share ?x4559)))
 (let ((?x5311 (log ?x4559)))
 (let ((?x5234 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
  (oracle a!4)))))_call| ?x5311)))
 (let ((?x5247 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
  (repl a!4)))))_call| ?x5234 ?x29595)))
 (let ((?x5279 (value_Shared ?x5247)))
 (let ((?x5255 (globals ?x5279)))
 (let ((?x5277 (g_granules ?x5255)))
 (let ((?x5369 (e_state_s_granule (select ?x5277 gidx.2441561))))
 (let (($x5458 (= ?x5369 0)))
 (let (($x5359 (= ?x5369 6)))
 (let ((?x5461 (gpt ?x5279)))
 (let (($x4632 (select ?x5461 gidx.2441561)))
 (or $x4632 $x5359 $x5458))))))))))))))))))))))))))))))))
 ))
 (let (($x4996 (forall ((gidx.2441544 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x29595 (share ?x4559)))
 (let ((?x5246 (gpt ?x29595)))
 (let (($x5427 (select ?x5246 gidx.2441544)))
 (let ((?x4710 (e_state_s_granule (select (g_granules (globals ?x29595)) gidx.2441544))))
 (let (($x5355 (= ?x4710 6)))
 (let (($x5240 (= ?x4710 0)))
 (or $x5240 $x5355 $x5427))))))))))))))))))))))))))
 ))
 (or (not $x4996) $x5358))))
(assert
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5294 (div ?x4760 4096)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x29595 (share ?x4559)))
 (let ((?x5413 (globals ?x29595)))
 (let ((?x5262 (g_granules ?x5413)))
 (let ((?x4601 (select ?x5262 ?x5294)))
 (let ((?x5228 (e_state_s_granule ?x4601)))
 (let (($x5299 (= ?x5228 5)))
 (not $x5299)))))))))))))))))))))))))))
(assert
 (forall ((gidx.2454666 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x42432 (share ?x5713)))
 (let ((?x9574 (globals ?x42432)))
 (let ((?x9487 (g_granules ?x9574)))
 (let ((?x10151 (e_state_s_granule (select ?x9487 gidx.2454666))))
 (let (($x10211 (= ?x10151 6)))
 (let (($x9623 (= ?x10151 0)))
 (=> (not (select (gpt ?x42432) gidx.2454666)) (or $x9623 $x10211)))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2454701 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2454701))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x42432 (share ?x5713)))
 (let ((?x43672 (gpt ?x42432)))
 (select ?x43672 ?x1047)))))))))))))))))))))))))
 )
(assert
 (let (($x7982 (forall ((gidx.2454889 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x42432 (share ?x5713)))
 (let ((?x8305 (log ?x5713)))
 (let ((?x9444 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
  (oracle a!5))))))_call| ?x8305)))
 (let ((?x10090 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
  (repl a!5))))))_call| ?x9444 ?x42432)))
 (let ((?x8757 (value_Shared ?x10090)))
 (let ((?x8685 (globals ?x8757)))
 (let ((?x9376 (g_granules ?x8685)))
 (let ((?x10036 (e_state_s_granule (select ?x9376 gidx.2454889))))
 (let (($x51540 (= ?x10036 6)))
 (let (($x9937 (= ?x10036 0)))
 (let ((?x9813 (gpt ?x8757)))
 (let (($x6051 (select ?x9813 gidx.2454889)))
 (or $x6051 $x9937 $x51540))))))))))))))))))))))))))))))))))
 ))
 (let (($x9542 (forall ((gidx.2454872 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x42432 (share ?x5713)))
 (let ((?x9574 (globals ?x42432)))
 (let ((?x9487 (g_granules ?x9574)))
 (let ((?x10151 (e_state_s_granule (select ?x9487 gidx.2454872))))
 (let (($x10211 (= ?x10151 6)))
 (let (($x9623 (= ?x10151 0)))
 (let ((?x43672 (gpt ?x42432)))
 (let (($x8278 (select ?x43672 gidx.2454872)))
 (or $x8278 $x9623 $x10211))))))))))))))))))))))))))))))
 ))
 (or (not $x9542) $x7982))))
(assert
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1318 (div ?x17296 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x42432 (share ?x5713)))
 (let ((?x9452 (granule_data ?x42432)))
 (let ((?x10121 (select ?x9452 ?x1318)))
 (let ((?x10041 (g_granule_state ?x10121)))
 (= ?x10041 3)))))))))))))))))))))))))))
(assert
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let (($x1371 (>= ?x17296 0)))
 (let ((?x1311 (mod ?x17296 4096)))
 (let (($x1370 (= ?x1311 0)))
 (and $x1370 $x1371)))))))
(assert
 (forall ((gidx.2455002 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x9907 (share ?x9613)))
 (let ((?x9616 (globals ?x9907)))
 (let ((?x9694 (g_granules ?x9616)))
 (let ((?x33122 (e_state_s_granule (select ?x9694 gidx.2455002))))
 (let (($x43312 (= ?x33122 6)))
 (let (($x9486 (= ?x33122 0)))
 (=> (not (select (gpt ?x9907) gidx.2455002)) (or $x9486 $x43312)))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2455037 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2455037))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x9907 (share ?x9613)))
 (let ((?x9915 (gpt ?x9907)))
 (select ?x9915 ?x1047)))))))))))))))))))))))))))))
 )
(assert
 (let (($x9930 (forall ((gidx.2455225 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x9907 (share ?x9613)))
 (let ((?x9419 (log ?x9613)))
 (let ((?x9658 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
  (oracle a!6)))))))_call| ?x9419)))
 (let ((?x9258 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
  (repl a!6)))))))_call| ?x9658 ?x9907)))
 (let ((?x44242 (value_Shared ?x9258)))
 (let ((?x29970 (globals ?x44242)))
 (let ((?x10138 (g_granules ?x29970)))
 (let ((?x10294 (e_state_s_granule (select ?x10138 gidx.2455225))))
 (let (($x52386 (= ?x10294 0)))
 (let (($x9404 (= ?x10294 6)))
 (let ((?x9871 (gpt ?x44242)))
 (let (($x9340 (select ?x9871 gidx.2455225)))
 (or $x9340 $x9404 $x52386))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x9905 (forall ((gidx.2455208 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x9907 (share ?x9613)))
 (let ((?x9616 (globals ?x9907)))
 (let ((?x9694 (g_granules ?x9616)))
 (let ((?x33122 (e_state_s_granule (select ?x9694 gidx.2455208))))
 (let (($x43312 (= ?x33122 6)))
 (let (($x9486 (= ?x33122 0)))
 (let ((?x9915 (gpt ?x9907)))
 (let (($x8768 (select ?x9915 gidx.2455208)))
 (or $x8768 $x9486 $x43312))))))))))))))))))))))))))))))))))
 ))
 (or (not $x9905) $x9930))))
(assert
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x7979 (e_3 ?x26171)))
 (let ((?x9557 (* 8 ?x7979)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9655 (poffset ?x10187)))
 (let ((?x9904 (+ ?x9655 ?x9557)))
 (let ((?x10219 (div ?x9904 4096)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x9907 (share ?x9613)))
 (let ((?x9616 (globals ?x9907)))
 (let ((?x9694 (g_granules ?x9616)))
 (let ((?x43902 (select ?x9694 ?x10219)))
 (let ((?x10158 (e_state_s_granule ?x43902)))
 (= ?x10158 5))))))))))))))))))))))))))))))))))))))
(assert
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x42432 (share ?x5713)))
 (let ((?x9452 (granule_data ?x42432)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x9907 (share ?x9613)))
 (let ((?x64918 (granule_data ?x9907)))
 (= ?x64918 ?x9452))))))))))))))))))))))))))))))
(assert
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x68939 (e_1 ?x26171)))
 (= ?x68939 3)))))))))))))))))))))))))))
(assert
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x7979 (e_3 ?x26171)))
 (let ((?x9557 (* 8 ?x7979)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9655 (poffset ?x10187)))
 (let ((?x9904 (+ ?x9655 ?x9557)))
 (let ((?x9875 (mkPtr "granule_data" ?x9904)))
 (let ((?x9842 (abs_tte_read.0_call ?x9875 ?x9613)))
 (let ((?x7800 (meta_mem_attr ?x9842)))
 (let (($x9572 (= ?x7800 0)))
 (let ((?x51292 (meta_ripas ?x9842)))
 (let (($x31671 (= ?x51292 0)))
 (let ((?x9654 (meta_desc_type ?x9842)))
 (let (($x9774 (= ?x9654 0)))
 (and $x9774 $x31671 $x9572))))))))))))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2455338 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x69090 (share ?x9587)))
 (let ((?x10273 (globals ?x69090)))
 (let ((?x10196 (g_granules ?x10273)))
 (let ((?x10075 (e_state_s_granule (select ?x10196 gidx.2455338))))
 (let (($x9914 (= ?x10075 6)))
 (let (($x10051 (= ?x10075 0)))
 (=> (not (select (gpt ?x69090) gidx.2455338)) (or $x10051 $x9914)))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2455373 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2455373))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x69090 (share ?x9587)))
 (let ((?x10423 (gpt ?x69090)))
 (select ?x10423 ?x1047)))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x9581 (forall ((gidx.2455561 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x69090 (share ?x9587)))
 (let ((?x9708 (log ?x9587)))
 (let ((?x8383 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!6)))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!7) (poffset a!7))
                          a!6))))
  (oracle a!8)))))))))_call| ?x9708)))
 (let ((?x9637 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!6)))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!7) (poffset a!7))
                          a!6))))
  (repl a!8)))))))))_call| ?x8383 ?x69090)))
 (let ((?x10210 (value_Shared ?x9637)))
 (let ((?x10292 (gpt ?x10210)))
 (let (($x9880 (select ?x10292 gidx.2455561)))
 (let ((?x57048 (e_state_s_granule (select (g_granules (globals ?x10210)) gidx.2455561))))
 (let (($x9684 (= ?x57048 0)))
 (let (($x9347 (= ?x57048 6)))
 (or $x9347 $x9684 $x9880))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x9417 (forall ((gidx.2455544 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x69090 (share ?x9587)))
 (let ((?x10423 (gpt ?x69090)))
 (let (($x10193 (select ?x10423 gidx.2455544)))
 (let ((?x10075 (e_state_s_granule (select (g_granules (globals ?x69090)) gidx.2455544))))
 (let (($x10051 (= ?x10075 0)))
 (let (($x9914 (= ?x10075 6)))
 (or $x9914 $x10051 $x10193))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x9417) $x9581))))
(assert
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x9463 (div ?x33961 4096)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x69090 (share ?x9587)))
 (let ((?x10273 (globals ?x69090)))
 (let ((?x10196 (g_granules ?x10273)))
 (let ((?x10307 (select ?x10196 ?x9463)))
 (let ((?x33174 (e_state_s_granule ?x10307)))
 (= ?x33174 2))))))))))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2455674 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x77249 (share ?x9374)))
 (let ((?x10400 (globals ?x77249)))
 (let ((?x10098 (g_granules ?x10400)))
 (let ((?x10468 (e_state_s_granule (select ?x10098 gidx.2455674))))
 (let (($x10025 (= ?x10468 6)))
 (let (($x10220 (= ?x10468 0)))
 (=> (not (select (gpt ?x77249) gidx.2455674)) (or $x10220 $x10025)))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2455709 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2455709))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x77249 (share ?x9374)))
 (let ((?x10558 (gpt ?x77249)))
 (select ?x10558 ?x1047)))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x60791 (forall ((gidx.2455897 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x77249 (share ?x9374)))
 (let ((?x9482 (log ?x9374)))
 (let ((?x9701 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!3))))
(let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          (value_RData a!3)))))
(let ((a!6 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          a!5))))
(let ((a!7 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!4
                       0
                       64
                       v_2.0
                       3
                       a!6)))))
(let ((a!8 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!7)))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!8) (poffset a!8))
                          a!7))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!1
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (oracle a!10))))))))))_call| ?x9482)))
 (let ((?x9097 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!3))))
(let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          (value_RData a!3)))))
(let ((a!6 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          a!5))))
(let ((a!7 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!4
                       0
                       64
                       v_2.0
                       3
                       a!6)))))
(let ((a!8 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!7)))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!8) (poffset a!8))
                          a!7))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!1
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (repl a!10))))))))))_call| ?x9701 ?x77249)))
 (let ((?x10371 (value_Shared ?x9097)))
 (let ((?x8634 (gpt ?x10371)))
 (let (($x10339 (select ?x8634 gidx.2455897)))
 (let ((?x9136 (e_state_s_granule (select (g_granules (globals ?x10371)) gidx.2455897))))
 (let (($x9974 (= ?x9136 0)))
 (let (($x8778 (= ?x9136 6)))
 (or $x8778 $x9974 $x10339))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x10399 (forall ((gidx.2455880 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x77249 (share ?x9374)))
 (let ((?x10558 (gpt ?x77249)))
 (let (($x10685 (select ?x10558 gidx.2455880)))
 (let ((?x10468 (e_state_s_granule (select (g_granules (globals ?x77249)) gidx.2455880))))
 (let (($x10220 (= ?x10468 0)))
 (let (($x10025 (= ?x10468 6)))
 (or $x10025 $x10220 $x10685))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x10399) $x60791))))
(assert
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let (($x52586 (elem_0 ?x10383)))
 (not $x52586))))))))))))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2457410 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x93837 (share ?x11568)))
 (let ((?x61782 (globals ?x93837)))
 (let ((?x10778 (g_granules ?x61782)))
 (let ((?x9164 (e_state_s_granule (select ?x10778 gidx.2457410))))
 (let (($x57860 (= ?x9164 6)))
 (let (($x52954 (= ?x9164 0)))
 (=> (not (select (gpt ?x93837) gidx.2457410)) (or $x52954 $x57860))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2457445 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2457445))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x93837 (share ?x11568)))
 (let ((?x60140 (gpt ?x93837)))
 (select ?x60140 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x11561 (forall ((gidx.2457633 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x93837 (share ?x11568)))
 (let ((?x10669 (log ?x11568)))
 (let ((?x11239 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!3 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!3 st.0)))))
(let ((a!5 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!4))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!5) (poffset a!5))
                          (value_RData a!4)))))
(let ((a!7 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!5) (poffset a!5))
                          a!6))))
(let ((a!8 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!5
                       0
                       64
                       v_2.0
                       3
                       a!7)))))
(let ((a!9 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!8)))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!9) (poffset a!9))
                           a!8))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
  (oracle (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!11)))))))))))))_call| ?x10669)))
 (let ((?x9365 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!3 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!3 st.0)))))
(let ((a!5 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!4))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!5) (poffset a!5))
                          (value_RData a!4)))))
(let ((a!7 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!5) (poffset a!5))
                          a!6))))
(let ((a!8 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!5
                       0
                       64
                       v_2.0
                       3
                       a!7)))))
(let ((a!9 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!8)))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!9) (poffset a!9))
                           a!8))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
  (repl (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!11)))))))))))))_call| ?x11239 ?x93837)))
 (let ((?x11509 (value_Shared ?x9365)))
 (let ((?x11014 (globals ?x11509)))
 (let ((?x10368 (g_granules ?x11014)))
 (let ((?x11444 (e_state_s_granule (select ?x10368 gidx.2457633))))
 (let (($x61458 (= ?x11444 0)))
 (let (($x10229 (= ?x11444 6)))
 (let ((?x61719 (gpt ?x11509)))
 (let (($x9578 (select ?x61719 gidx.2457633)))
 (or $x9578 $x10229 $x61458)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x11158 (forall ((gidx.2457616 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x93837 (share ?x11568)))
 (let ((?x61782 (globals ?x93837)))
 (let ((?x10778 (g_granules ?x61782)))
 (let ((?x9164 (e_state_s_granule (select ?x10778 gidx.2457616))))
 (let (($x57860 (= ?x9164 6)))
 (let (($x52954 (= ?x9164 0)))
 (let ((?x60140 (gpt ?x93837)))
 (let (($x11542 (select ?x60140 gidx.2457616)))
 (or $x11542 $x52954 $x57860)))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x11158) $x11561))))
(assert
 (forall ((gidx.2457746 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x109534 (share ?x10599)))
 (let ((?x19507 (globals ?x109534)))
 (let ((?x10944 (g_granules ?x19507)))
 (let ((?x70239 (e_state_s_granule (select ?x10944 gidx.2457746))))
 (let (($x58319 (= ?x70239 6)))
 (let (($x11238 (= ?x70239 0)))
 (=> (not (select (gpt ?x109534) gidx.2457746)) (or $x11238 $x58319))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2457781 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2457781))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x109534 (share ?x10599)))
 (let ((?x33544 (gpt ?x109534)))
 (select ?x33544 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x11039 (forall ((gidx.2457969 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x109534 (share ?x10599)))
 (let ((?x11402 (log ?x10599)))
 (let ((?x10108 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!6)))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           a!6))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
  (oracle (value_RData a!12))))))))))))_call| ?x11402)))
 (let ((?x11439 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!5)))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!6)))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           a!6))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
  (repl (value_RData a!12))))))))))))_call| ?x10108 ?x109534)))
 (let ((?x25824 (value_Shared ?x11439)))
 (let ((?x10089 (gpt ?x25824)))
 (let (($x11232 (select ?x10089 gidx.2457969)))
 (let ((?x54011 (e_state_s_granule (select (g_granules (globals ?x25824)) gidx.2457969))))
 (let (($x10789 (= ?x54011 6)))
 (let (($x10707 (= ?x54011 0)))
 (or $x10707 $x10789 $x11232)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x62096 (forall ((gidx.2457952 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x109534 (share ?x10599)))
 (let ((?x33544 (gpt ?x109534)))
 (let (($x61886 (select ?x33544 gidx.2457952)))
 (let ((?x70239 (e_state_s_granule (select (g_granules (globals ?x109534)) gidx.2457952))))
 (let (($x58319 (= ?x70239 6)))
 (let (($x11238 (= ?x70239 0)))
 (or $x11238 $x58319 $x61886)))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x62096) $x11039))))
(assert
 (forall ((gidx.2458082 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x117347 (share ?x53652)))
 (let ((?x93994 (globals ?x117347)))
 (let ((?x62121 (g_granules ?x93994)))
 (let ((?x10828 (e_state_s_granule (select ?x62121 gidx.2458082))))
 (let (($x10710 (= ?x10828 6)))
 (let (($x10531 (= ?x10828 0)))
 (=> (not (select (gpt ?x117347) gidx.2458082)) (or $x10531 $x10710))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2458117 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2458117))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x117347 (share ?x53652)))
 (let ((?x101639 (gpt ?x117347)))
 (select ?x101639 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x11615 (forall ((gidx.2458305 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x117347 (share ?x53652)))
 (let ((?x54219 (log ?x53652)))
 (let ((?x11270 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!5))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!6))))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           (elem_1 a!6)))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
                           (value_RData a!12)))))
  (oracle a!13))))))))))))_call| ?x54219)))
 (let ((?x10526 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!5))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!6))))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           (elem_1 a!6)))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
                           (value_RData a!12)))))
  (repl a!13))))))))))))_call| ?x11270 ?x117347)))
 (let ((?x10842 (value_Shared ?x10526)))
 (let ((?x11025 (gpt ?x10842)))
 (let (($x10977 (select ?x11025 gidx.2458305)))
 (let ((?x11230 (e_state_s_granule (select (g_granules (globals ?x10842)) gidx.2458305))))
 (let (($x10608 (= ?x11230 0)))
 (let (($x10305 (= ?x11230 6)))
 (or $x10305 $x10608 $x10977)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x10173 (forall ((gidx.2458288 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x117347 (share ?x53652)))
 (let ((?x101639 (gpt ?x117347)))
 (let (($x11736 (select ?x101639 gidx.2458288)))
 (let ((?x10828 (e_state_s_granule (select (g_granules (globals ?x117347)) gidx.2458288))))
 (let (($x10710 (= ?x10828 6)))
 (let (($x10531 (= ?x10828 0)))
 (or $x10531 $x10710 $x11736)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x10173) $x11615))))
(assert
 (let ((?x73347 (make_return_code_para.0_call 1)))
 (let ((?x26393 (pack_struct_return_code_para.0_call ?x73347)))
 (= ?x26393 0))))
(assert
 (forall ((gidx.2458418 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x53849 (granule_unlock_spec.0_call ?x1244 ?x53652)))
 (let ((?x11224 (value_RData ?x53849)))
 (let ((?x125259 (share ?x11224)))
 (let ((?x62452 (globals ?x125259)))
 (let ((?x93524 (g_granules ?x62452)))
 (let ((?x11271 (e_state_s_granule (select ?x93524 gidx.2458418))))
 (let (($x11480 (= ?x11271 6)))
 (let (($x27828 (= ?x11271 0)))
 (let ((?x62034 (gpt ?x125259)))
 (let (($x11630 (select ?x62034 gidx.2458418)))
 (let (($x11491 (not $x11630)))
 (=> $x11491 (or $x27828 $x11480)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2458453 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2458453))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x53849 (granule_unlock_spec.0_call ?x1244 ?x53652)))
 (let ((?x11224 (value_RData ?x53849)))
 (let ((?x125259 (share ?x11224)))
 (let ((?x62034 (gpt ?x125259)))
 (select ?x62034 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x36261 (forall ((gidx.2458641 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x53849 (granule_unlock_spec.0_call ?x1244 ?x53652)))
 (let ((?x11224 (value_RData ?x53849)))
 (let ((?x125259 (share ?x11224)))
 (let ((?x10801 (log ?x11224)))
 (let ((?x10873 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!5))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!6))))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           (elem_1 a!6)))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
                           (value_RData a!12)))))
(let ((a!14 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!13)))
  (oracle (value_RData a!14))))))))))))))_call| ?x10801)))
 (let ((?x11553 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455373))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          a!4))))
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!5))))
(let ((a!7 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!6))))
(let ((a!10 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           (elem_1 a!6)))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
                           (value_RData a!12)))))
(let ((a!14 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!13)))
  (repl (value_RData a!14))))))))))))))_call| ?x10873 ?x125259)))
 (let ((?x9338 (value_Shared ?x11553)))
 (let ((?x11831 (globals ?x9338)))
 (let ((?x11878 (g_granules ?x11831)))
 (let ((?x19000 (e_state_s_granule (select ?x11878 gidx.2458641))))
 (let (($x101481 (= ?x19000 6)))
 (let (($x11841 (= ?x19000 0)))
 (let ((?x10752 (gpt ?x9338)))
 (let (($x11582 (select ?x10752 gidx.2458641)))
 (or $x11582 $x11841 $x101481)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x9821 (forall ((gidx.2458624 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x53849 (granule_unlock_spec.0_call ?x1244 ?x53652)))
 (let ((?x11224 (value_RData ?x53849)))
 (let ((?x125259 (share ?x11224)))
 (let ((?x62452 (globals ?x125259)))
 (let ((?x93524 (g_granules ?x62452)))
 (let ((?x11271 (e_state_s_granule (select ?x93524 gidx.2458624))))
 (let (($x27828 (= ?x11271 0)))
 (let ((?x62034 (gpt ?x125259)))
 (let (($x11630 (select ?x62034 gidx.2458624)))
 (let (($x11480 (= ?x11271 6)))
 (or $x11480 $x11630 $x27828)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x9821) $x36261))))
(assert
 (let ((?x27271 (test_Z_PTE.0_call v_0.2458453)))
 (let ((?x11710 (meta_PA ?x27271)))
 (let ((?x11573 (meta_granule_offset ?x11710)))
 (let (($x10776 (>= ?x11573 0)))
 (let ((?x10654 (mod ?x11573 4096)))
 (let (($x10397 (= ?x10654 0)))
 (and $x10397 $x10776))))))))
(assert
 (forall ((gidx.2458754 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x53849 (granule_unlock_spec.0_call ?x1244 ?x53652)))
 (let ((?x11224 (value_RData ?x53849)))
 (let ((?x27271 (test_Z_PTE.0_call v_0.2458453)))
 (let ((?x11710 (meta_PA ?x27271)))
 (let ((?x11573 (meta_granule_offset ?x11710)))
 (let ((?x52482 (div ?x11573 4096)))
 (let ((?x125259 (share ?x11224)))
 (let ((?x62452 (globals ?x125259)))
 (let ((?x93524 (g_granules ?x62452)))
 (let ((?x11953 (select ?x93524 ?x52482)))
 (let ((?x10320 (mks_granule (e_lock ?x11953) 4 (e_ref ?x11953))))
 (let ((?x11848 (store ?x93524 ?x52482 ?x10320)))
 (let ((?x11431 (mkGLOBALS (g_heap ?x62452) (g_debug_exits ?x62452) (g_vmid_count ?x62452) (g_vmid_lock ?x62452) (g_vmids ?x62452) (g_nr_lrs ?x62452) (g_nr_aprs ?x62452) (g_max_vintid ?x62452) (g_pri_res0_mask ?x62452) (g_default_gicstate ?x62452) (g_status_handler ?x62452) (g_rmm_trap_list ?x62452) (g_tt_l3_buffer ?x62452) (g_tt_l2_mem0_0 ?x62452) (g_tt_l2_mem0_1 ?x62452) (g_tt_l2_mem1_0 ?x62452) (g_tt_l2_mem1_1 ?x62452) (g_tt_l2_mem1_2 ?x62452) (g_tt_l2_mem1_3 ?x62452) (g_tt_l1_upper ?x62452) (g_mbedtls_mem_buf ?x62452) ?x11848 (g_rmm_attest_signing_key ?x62452) (g_rmm_attest_public_key ?x62452) (g_rmm_attest_public_key_len ?x62452) (g_rmm_attest_public_key_hash ?x62452) (g_rmm_attest_public_key_hash_len ?x62452) (g_platform_token_buf ?x62452) (g_rmm_platform_token ?x62452) (g_get_realm_identity_identity ?x62452) (g_realm_attest_private_key ?x62452))))
 (let ((?x62034 (gpt ?x125259)))
 (let ((?x11450 (repl ?x11224)))
 (let ((?x10370 (oracle ?x11224)))
 (let ((?x10801 (log ?x11224)))
 (let ((?x72738 (mkRData ?x10801 ?x10370 ?x11450 (priv ?x11224) (mkShared ?x62034 (granule_data ?x125259) ?x11431) (stack ?x11224) (halt ?x11224))))
 (let ((?x133199 (mkPtr "granules" ?x11573)))
 (let ((?x11892 (granule_unlock_spec.0_call ?x133199 ?x72738)))
 (let ((?x9229 (value_RData ?x11892)))
 (let ((?x133318 (share ?x9229)))
 (let ((?x11077 (globals ?x133318)))
 (let ((?x11177 (g_granules ?x11077)))
 (let ((?x11317 (e_state_s_granule (select ?x11177 gidx.2458754))))
 (let (($x7847 (= ?x11317 6)))
 (let (($x11818 (= ?x11317 0)))
 (=> (not (select (gpt ?x133318) gidx.2458754)) (or $x11818 $x7847)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2458789 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2458789))) 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x53849 (granule_unlock_spec.0_call ?x1244 ?x53652)))
 (let ((?x11224 (value_RData ?x53849)))
 (let ((?x27271 (test_Z_PTE.0_call v_0.2458453)))
 (let ((?x11710 (meta_PA ?x27271)))
 (let ((?x11573 (meta_granule_offset ?x11710)))
 (let ((?x52482 (div ?x11573 4096)))
 (let ((?x125259 (share ?x11224)))
 (let ((?x62452 (globals ?x125259)))
 (let ((?x93524 (g_granules ?x62452)))
 (let ((?x11953 (select ?x93524 ?x52482)))
 (let ((?x10320 (mks_granule (e_lock ?x11953) 4 (e_ref ?x11953))))
 (let ((?x11848 (store ?x93524 ?x52482 ?x10320)))
 (let ((?x11431 (mkGLOBALS (g_heap ?x62452) (g_debug_exits ?x62452) (g_vmid_count ?x62452) (g_vmid_lock ?x62452) (g_vmids ?x62452) (g_nr_lrs ?x62452) (g_nr_aprs ?x62452) (g_max_vintid ?x62452) (g_pri_res0_mask ?x62452) (g_default_gicstate ?x62452) (g_status_handler ?x62452) (g_rmm_trap_list ?x62452) (g_tt_l3_buffer ?x62452) (g_tt_l2_mem0_0 ?x62452) (g_tt_l2_mem0_1 ?x62452) (g_tt_l2_mem1_0 ?x62452) (g_tt_l2_mem1_1 ?x62452) (g_tt_l2_mem1_2 ?x62452) (g_tt_l2_mem1_3 ?x62452) (g_tt_l1_upper ?x62452) (g_mbedtls_mem_buf ?x62452) ?x11848 (g_rmm_attest_signing_key ?x62452) (g_rmm_attest_public_key ?x62452) (g_rmm_attest_public_key_len ?x62452) (g_rmm_attest_public_key_hash ?x62452) (g_rmm_attest_public_key_hash_len ?x62452) (g_platform_token_buf ?x62452) (g_rmm_platform_token ?x62452) (g_get_realm_identity_identity ?x62452) (g_realm_attest_private_key ?x62452))))
 (let ((?x62034 (gpt ?x125259)))
 (let ((?x11450 (repl ?x11224)))
 (let ((?x10370 (oracle ?x11224)))
 (let ((?x10801 (log ?x11224)))
 (let ((?x72738 (mkRData ?x10801 ?x10370 ?x11450 (priv ?x11224) (mkShared ?x62034 (granule_data ?x125259) ?x11431) (stack ?x11224) (halt ?x11224))))
 (let ((?x133199 (mkPtr "granules" ?x11573)))
 (let ((?x11892 (granule_unlock_spec.0_call ?x133199 ?x72738)))
 (let ((?x9229 (value_RData ?x11892)))
 (let ((?x133318 (share ?x9229)))
 (let ((?x11085 (gpt ?x133318)))
 (select ?x11085 ?x1047)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x10841 (forall ((gidx.2458977 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x53849 (granule_unlock_spec.0_call ?x1244 ?x53652)))
 (let ((?x11224 (value_RData ?x53849)))
 (let ((?x27271 (test_Z_PTE.0_call v_0.2458453)))
 (let ((?x11710 (meta_PA ?x27271)))
 (let ((?x11573 (meta_granule_offset ?x11710)))
 (let ((?x52482 (div ?x11573 4096)))
 (let ((?x125259 (share ?x11224)))
 (let ((?x62452 (globals ?x125259)))
 (let ((?x93524 (g_granules ?x62452)))
 (let ((?x11953 (select ?x93524 ?x52482)))
 (let ((?x10320 (mks_granule (e_lock ?x11953) 4 (e_ref ?x11953))))
 (let ((?x11848 (store ?x93524 ?x52482 ?x10320)))
 (let ((?x11431 (mkGLOBALS (g_heap ?x62452) (g_debug_exits ?x62452) (g_vmid_count ?x62452) (g_vmid_lock ?x62452) (g_vmids ?x62452) (g_nr_lrs ?x62452) (g_nr_aprs ?x62452) (g_max_vintid ?x62452) (g_pri_res0_mask ?x62452) (g_default_gicstate ?x62452) (g_status_handler ?x62452) (g_rmm_trap_list ?x62452) (g_tt_l3_buffer ?x62452) (g_tt_l2_mem0_0 ?x62452) (g_tt_l2_mem0_1 ?x62452) (g_tt_l2_mem1_0 ?x62452) (g_tt_l2_mem1_1 ?x62452) (g_tt_l2_mem1_2 ?x62452) (g_tt_l2_mem1_3 ?x62452) (g_tt_l1_upper ?x62452) (g_mbedtls_mem_buf ?x62452) ?x11848 (g_rmm_attest_signing_key ?x62452) (g_rmm_attest_public_key ?x62452) (g_rmm_attest_public_key_len ?x62452) (g_rmm_attest_public_key_hash ?x62452) (g_rmm_attest_public_key_hash_len ?x62452) (g_platform_token_buf ?x62452) (g_rmm_platform_token ?x62452) (g_get_realm_identity_identity ?x62452) (g_realm_attest_private_key ?x62452))))
 (let ((?x62034 (gpt ?x125259)))
 (let ((?x11450 (repl ?x11224)))
 (let ((?x10370 (oracle ?x11224)))
 (let ((?x10801 (log ?x11224)))
 (let ((?x72738 (mkRData ?x10801 ?x10370 ?x11450 (priv ?x11224) (mkShared ?x62034 (granule_data ?x125259) ?x11431) (stack ?x11224) (halt ?x11224))))
 (let ((?x133199 (mkPtr "granules" ?x11573)))
 (let ((?x11892 (granule_unlock_spec.0_call ?x133199 ?x72738)))
 (let ((?x9229 (value_RData ?x11892)))
 (let ((?x133318 (share ?x9229)))
 (let ((?x11038 (log ?x9229)))
 (let ((?x10502 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2458453)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!10 (mkPtr "granule_data"
                   (meta_granule_offset
                     (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!38 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2458453)))
                 4096)))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!3))))
(let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          (value_RData a!3)))))
(let ((a!6 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          a!5))))
(let ((a!7 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!4
               0
               64
               v_2.0
               3
               a!6))))
(let ((a!8 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!7))))
(let ((a!11 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!8) (poffset a!8))
                           (elem_1 a!7)))))
(let ((a!12 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!10
                        (mkPtr "granule_data" 0)
                        4096
                        a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              a!8
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!9 0 4096 a!12))))))
(let ((a!14 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!7))
                           (value_RData a!13)))))
(let ((a!15 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!14)))
(let ((a!16 (g_heap (globals (share (value_RData a!15)))))
      (a!17 (g_debug_exits (globals (share (value_RData a!15)))))
      (a!18 (g_vmid_count (globals (share (value_RData a!15)))))
      (a!19 (g_vmid_lock (globals (share (value_RData a!15)))))
      (a!20 (g_vmids (globals (share (value_RData a!15)))))
      (a!21 (g_nr_lrs (globals (share (value_RData a!15)))))
      (a!22 (g_nr_aprs (globals (share (value_RData a!15)))))
      (a!23 (g_max_vintid (globals (share (value_RData a!15)))))
      (a!24 (g_pri_res0_mask (globals (share (value_RData a!15)))))
      (a!25 (g_default_gicstate (globals (share (value_RData a!15)))))
      (a!26 (g_status_handler (globals (share (value_RData a!15)))))
      (a!27 (g_rmm_trap_list (globals (share (value_RData a!15)))))
      (a!28 (g_tt_l3_buffer (globals (share (value_RData a!15)))))
      (a!29 (g_tt_l2_mem0_0 (globals (share (value_RData a!15)))))
      (a!30 (g_tt_l2_mem0_1 (globals (share (value_RData a!15)))))
      (a!31 (g_tt_l2_mem1_0 (globals (share (value_RData a!15)))))
      (a!32 (g_tt_l2_mem1_1 (globals (share (value_RData a!15)))))
      (a!33 (g_tt_l2_mem1_2 (globals (share (value_RData a!15)))))
      (a!34 (g_tt_l2_mem1_3 (globals (share (value_RData a!15)))))
      (a!35 (g_tt_l1_upper (globals (share (value_RData a!15)))))
      (a!36 (g_mbedtls_mem_buf (globals (share (value_RData a!15)))))
      (a!37 (g_granules (globals (share (value_RData a!15)))))
      (a!40 (g_rmm_attest_signing_key (globals (share (value_RData a!15)))))
      (a!41 (g_rmm_attest_public_key (globals (share (value_RData a!15)))))
      (a!42 (g_rmm_attest_public_key_len (globals (share (value_RData a!15)))))
      (a!43 (g_rmm_attest_public_key_hash (globals (share (value_RData a!15)))))
      (a!44 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!15)))))
      (a!45 (g_platform_token_buf (globals (share (value_RData a!15)))))
      (a!46 (g_rmm_platform_token (globals (share (value_RData a!15)))))
      (a!47 (g_get_realm_identity_identity (globals (share (value_RData a!15)))))
      (a!48 (g_realm_attest_private_key (globals (share (value_RData a!15))))))
(let ((a!39 (store a!37
                   a!38
                   (mks_granule (e_lock (select a!37 a!38))
                                4
                                (e_ref (select a!37 a!38))))))
(let ((a!49 (mkShared (gpt (share (value_RData a!15)))
                      (granule_data (share (value_RData a!15)))
                      (mkGLOBALS a!16
                                 a!17
                                 a!18
                                 a!19
                                 a!20
                                 a!21
                                 a!22
                                 a!23
                                 a!24
                                 a!25
                                 a!26
                                 a!27
                                 a!28
                                 a!29
                                 a!30
                                 a!31
                                 a!32
                                 a!33
                                 a!34
                                 a!35
                                 a!36
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46
                                 a!47
                                 a!48))))
(let ((a!50 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!15))
                       (oracle (value_RData a!15))
                       (repl (value_RData a!15))
                       (priv (value_RData a!15))
                       a!49
                       (stack (value_RData a!15))
                       (halt (value_RData a!15))))))
  (oracle (value_RData a!50))))))))))))))))))_call| ?x11038)))
 (let ((?x61928 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2458453)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2455709)))))
      (a!10 (mkPtr "granule_data"
                   (meta_granule_offset
                     (meta_PA (test_Z_PTE.0_call v_0.2455373)))))
      (a!38 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2458453)))
                 4096)))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!3))))
(let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          (value_RData a!3)))))
(let ((a!6 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!4) (poffset a!4))
                          a!5))))
(let ((a!7 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!4
               0
               64
               v_2.0
               3
               a!6))))
(let ((a!8 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!7))))
(let ((a!11 (value_RData (spinlock_acquire_spec.0_call
                           (mkPtr (pbase a!8) (poffset a!8))
                           (elem_1 a!7)))))
(let ((a!12 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!10
                        (mkPtr "granule_data" 0)
                        4096
                        a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              a!8
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!9 0 4096 a!12))))))
(let ((a!14 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!7))
                           (value_RData a!13)))))
(let ((a!15 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!14)))
(let ((a!16 (g_heap (globals (share (value_RData a!15)))))
      (a!17 (g_debug_exits (globals (share (value_RData a!15)))))
      (a!18 (g_vmid_count (globals (share (value_RData a!15)))))
      (a!19 (g_vmid_lock (globals (share (value_RData a!15)))))
      (a!20 (g_vmids (globals (share (value_RData a!15)))))
      (a!21 (g_nr_lrs (globals (share (value_RData a!15)))))
      (a!22 (g_nr_aprs (globals (share (value_RData a!15)))))
      (a!23 (g_max_vintid (globals (share (value_RData a!15)))))
      (a!24 (g_pri_res0_mask (globals (share (value_RData a!15)))))
      (a!25 (g_default_gicstate (globals (share (value_RData a!15)))))
      (a!26 (g_status_handler (globals (share (value_RData a!15)))))
      (a!27 (g_rmm_trap_list (globals (share (value_RData a!15)))))
      (a!28 (g_tt_l3_buffer (globals (share (value_RData a!15)))))
      (a!29 (g_tt_l2_mem0_0 (globals (share (value_RData a!15)))))
      (a!30 (g_tt_l2_mem0_1 (globals (share (value_RData a!15)))))
      (a!31 (g_tt_l2_mem1_0 (globals (share (value_RData a!15)))))
      (a!32 (g_tt_l2_mem1_1 (globals (share (value_RData a!15)))))
      (a!33 (g_tt_l2_mem1_2 (globals (share (value_RData a!15)))))
      (a!34 (g_tt_l2_mem1_3 (globals (share (value_RData a!15)))))
      (a!35 (g_tt_l1_upper (globals (share (value_RData a!15)))))
      (a!36 (g_mbedtls_mem_buf (globals (share (value_RData a!15)))))
      (a!37 (g_granules (globals (share (value_RData a!15)))))
      (a!40 (g_rmm_attest_signing_key (globals (share (value_RData a!15)))))
      (a!41 (g_rmm_attest_public_key (globals (share (value_RData a!15)))))
      (a!42 (g_rmm_attest_public_key_len (globals (share (value_RData a!15)))))
      (a!43 (g_rmm_attest_public_key_hash (globals (share (value_RData a!15)))))
      (a!44 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!15)))))
      (a!45 (g_platform_token_buf (globals (share (value_RData a!15)))))
      (a!46 (g_rmm_platform_token (globals (share (value_RData a!15)))))
      (a!47 (g_get_realm_identity_identity (globals (share (value_RData a!15)))))
      (a!48 (g_realm_attest_private_key (globals (share (value_RData a!15))))))
(let ((a!39 (store a!37
                   a!38
                   (mks_granule (e_lock (select a!37 a!38))
                                4
                                (e_ref (select a!37 a!38))))))
(let ((a!49 (mkShared (gpt (share (value_RData a!15)))
                      (granule_data (share (value_RData a!15)))
                      (mkGLOBALS a!16
                                 a!17
                                 a!18
                                 a!19
                                 a!20
                                 a!21
                                 a!22
                                 a!23
                                 a!24
                                 a!25
                                 a!26
                                 a!27
                                 a!28
                                 a!29
                                 a!30
                                 a!31
                                 a!32
                                 a!33
                                 a!34
                                 a!35
                                 a!36
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46
                                 a!47
                                 a!48))))
(let ((a!50 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!15))
                       (oracle (value_RData a!15))
                       (repl (value_RData a!15))
                       (priv (value_RData a!15))
                       a!49
                       (stack (value_RData a!15))
                       (halt (value_RData a!15))))))
  (repl (value_RData a!50))))))))))))))))))_call| ?x10502 ?x133318)))
 (let ((?x10855 (value_Shared ?x61928)))
 (let ((?x35915 (gpt ?x10855)))
 (let (($x11511 (select ?x35915 gidx.2458977)))
 (let ((?x11410 (e_state_s_granule (select (g_granules (globals ?x10855)) gidx.2458977))))
 (let (($x10962 (= ?x11410 0)))
 (let (($x10011 (= ?x11410 6)))
 (or $x10011 $x10962 $x11511))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x11888 (forall ((gidx.2458960 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x53849 (granule_unlock_spec.0_call ?x1244 ?x53652)))
 (let ((?x11224 (value_RData ?x53849)))
 (let ((?x27271 (test_Z_PTE.0_call v_0.2458453)))
 (let ((?x11710 (meta_PA ?x27271)))
 (let ((?x11573 (meta_granule_offset ?x11710)))
 (let ((?x52482 (div ?x11573 4096)))
 (let ((?x125259 (share ?x11224)))
 (let ((?x62452 (globals ?x125259)))
 (let ((?x93524 (g_granules ?x62452)))
 (let ((?x11953 (select ?x93524 ?x52482)))
 (let ((?x10320 (mks_granule (e_lock ?x11953) 4 (e_ref ?x11953))))
 (let ((?x11848 (store ?x93524 ?x52482 ?x10320)))
 (let ((?x11431 (mkGLOBALS (g_heap ?x62452) (g_debug_exits ?x62452) (g_vmid_count ?x62452) (g_vmid_lock ?x62452) (g_vmids ?x62452) (g_nr_lrs ?x62452) (g_nr_aprs ?x62452) (g_max_vintid ?x62452) (g_pri_res0_mask ?x62452) (g_default_gicstate ?x62452) (g_status_handler ?x62452) (g_rmm_trap_list ?x62452) (g_tt_l3_buffer ?x62452) (g_tt_l2_mem0_0 ?x62452) (g_tt_l2_mem0_1 ?x62452) (g_tt_l2_mem1_0 ?x62452) (g_tt_l2_mem1_1 ?x62452) (g_tt_l2_mem1_2 ?x62452) (g_tt_l2_mem1_3 ?x62452) (g_tt_l1_upper ?x62452) (g_mbedtls_mem_buf ?x62452) ?x11848 (g_rmm_attest_signing_key ?x62452) (g_rmm_attest_public_key ?x62452) (g_rmm_attest_public_key_len ?x62452) (g_rmm_attest_public_key_hash ?x62452) (g_rmm_attest_public_key_hash_len ?x62452) (g_platform_token_buf ?x62452) (g_rmm_platform_token ?x62452) (g_get_realm_identity_identity ?x62452) (g_realm_attest_private_key ?x62452))))
 (let ((?x62034 (gpt ?x125259)))
 (let ((?x11450 (repl ?x11224)))
 (let ((?x10370 (oracle ?x11224)))
 (let ((?x10801 (log ?x11224)))
 (let ((?x72738 (mkRData ?x10801 ?x10370 ?x11450 (priv ?x11224) (mkShared ?x62034 (granule_data ?x125259) ?x11431) (stack ?x11224) (halt ?x11224))))
 (let ((?x133199 (mkPtr "granules" ?x11573)))
 (let ((?x11892 (granule_unlock_spec.0_call ?x133199 ?x72738)))
 (let ((?x9229 (value_RData ?x11892)))
 (let ((?x133318 (share ?x9229)))
 (let ((?x11077 (globals ?x133318)))
 (let ((?x11177 (g_granules ?x11077)))
 (let ((?x11317 (e_state_s_granule (select ?x11177 gidx.2458960))))
 (let (($x11818 (= ?x11317 0)))
 (let ((?x11085 (gpt ?x133318)))
 (let (($x9297 (select ?x11085 gidx.2458960)))
 (let (($x7847 (= ?x11317 6)))
 (or $x7847 $x9297 $x11818))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x11888) $x10841))))
(assert
 (let (($x9114 (forall ((gidx.2459036 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let ((?x1244 (mkPtr "granules" ?x17296)))
 (let ((?x1210 (spinlock_acquire_spec.0_call ?x1244 ?x1125)))
 (let ((?x1212 (value_RData ?x1210)))
 (let ((?x5343 (mkPtr "granule_data" ?x17296)))
 (let ((?x5237 (rec_to_ttbr1_para.0_call ?x5343 ?x1212)))
 (let ((?x4760 (poffset ?x5237)))
 (let ((?x5206 (pbase ?x5237)))
 (let ((?x5335 (mkPtr ?x5206 ?x4760)))
 (let ((?x5202 (spinlock_acquire_spec.0_call ?x5335 ?x1212)))
 (let ((?x4559 (value_RData ?x5202)))
 (let ((?x88344 (spinlock_release_spec.0_call ?x5335 ?x4559)))
 (let ((?x5713 (value_RData ?x88344)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x88401 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x5713)))
 (let ((?x34511 (value_Tuple_abs_ret_rtt_RData ?x88401)))
 (let ((?x9613 (elem_1 ?x34511)))
 (let ((?x10416 (rec_to_rd_para.0_call ?x5343 ?x9613)))
 (let ((?x33961 (poffset ?x10416)))
 (let ((?x34298 (pbase ?x10416)))
 (let ((?x10369 (mkPtr ?x34298 ?x33961)))
 (let ((?x60121 (spinlock_acquire_spec.0_call ?x10369 ?x9613)))
 (let ((?x9587 (value_RData ?x60121)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x10506 (test_Z_PTE.0_call v_0.2455373)))
 (let ((?x60813 (meta_PA ?x10506)))
 (let ((?x10551 (meta_granule_offset ?x60813)))
 (let ((?x9889 (mkPtr "granule_data" ?x10551)))
 (let ((?x8748 (memcpy_ns_read_spec.0_call ?x9889 ?x1721 4096 ?x9587)))
 (let ((?x10383 (value_Tuple_bool_RData ?x8748)))
 (let ((?x9374 (elem_1 ?x10383)))
 (let ((?x60942 (test_Z_PTE.0_call v_0.2455709)))
 (let ((?x52732 (meta_PA ?x60942)))
 (let ((?x8694 (meta_granule_offset ?x52732)))
 (let ((?x129137 (mkPtr "granule_data" ?x8694)))
 (let ((?x11218 (memset_spec.0_call ?x129137 0 4096 ?x9374)))
 (let ((?x11018 (value_Tuple_Ptr_RData ?x11218)))
 (let ((?x11568 (elem_1 ?x11018)))
 (let ((?x11398 (granule_unlock_spec.0_call ?x10416 ?x11568)))
 (let ((?x10599 (value_RData ?x11398)))
 (let ((?x26171 (elem_0 ?x34511)))
 (let ((?x10187 (e_2 ?x26171)))
 (let ((?x9716 (granule_unlock_spec.0_call ?x10187 ?x10599)))
 (let ((?x53652 (value_RData ?x9716)))
 (let ((?x53849 (granule_unlock_spec.0_call ?x1244 ?x53652)))
 (let ((?x11224 (value_RData ?x53849)))
 (let ((?x27271 (test_Z_PTE.0_call v_0.2458453)))
 (let ((?x11710 (meta_PA ?x27271)))
 (let ((?x11573 (meta_granule_offset ?x11710)))
 (let ((?x52482 (div ?x11573 4096)))
 (let ((?x125259 (share ?x11224)))
 (let ((?x62452 (globals ?x125259)))
 (let ((?x93524 (g_granules ?x62452)))
 (let ((?x11953 (select ?x93524 ?x52482)))
 (let ((?x10320 (mks_granule (e_lock ?x11953) 4 (e_ref ?x11953))))
 (let ((?x11848 (store ?x93524 ?x52482 ?x10320)))
 (let ((?x11431 (mkGLOBALS (g_heap ?x62452) (g_debug_exits ?x62452) (g_vmid_count ?x62452) (g_vmid_lock ?x62452) (g_vmids ?x62452) (g_nr_lrs ?x62452) (g_nr_aprs ?x62452) (g_max_vintid ?x62452) (g_pri_res0_mask ?x62452) (g_default_gicstate ?x62452) (g_status_handler ?x62452) (g_rmm_trap_list ?x62452) (g_tt_l3_buffer ?x62452) (g_tt_l2_mem0_0 ?x62452) (g_tt_l2_mem0_1 ?x62452) (g_tt_l2_mem1_0 ?x62452) (g_tt_l2_mem1_1 ?x62452) (g_tt_l2_mem1_2 ?x62452) (g_tt_l2_mem1_3 ?x62452) (g_tt_l1_upper ?x62452) (g_mbedtls_mem_buf ?x62452) ?x11848 (g_rmm_attest_signing_key ?x62452) (g_rmm_attest_public_key ?x62452) (g_rmm_attest_public_key_len ?x62452) (g_rmm_attest_public_key_hash ?x62452) (g_rmm_attest_public_key_hash_len ?x62452) (g_platform_token_buf ?x62452) (g_rmm_platform_token ?x62452) (g_get_realm_identity_identity ?x62452) (g_realm_attest_private_key ?x62452))))
 (let ((?x62034 (gpt ?x125259)))
 (let ((?x11450 (repl ?x11224)))
 (let ((?x10370 (oracle ?x11224)))
 (let ((?x10801 (log ?x11224)))
 (let ((?x72738 (mkRData ?x10801 ?x10370 ?x11450 (priv ?x11224) (mkShared ?x62034 (granule_data ?x125259) ?x11431) (stack ?x11224) (halt ?x11224))))
 (let ((?x133199 (mkPtr "granules" ?x11573)))
 (let ((?x11892 (granule_unlock_spec.0_call ?x133199 ?x72738)))
 (let ((?x9229 (value_RData ?x11892)))
 (let ((?x133318 (share ?x9229)))
 (let ((?x11077 (globals ?x133318)))
 (let ((?x11177 (g_granules ?x11077)))
 (let ((?x11317 (e_state_s_granule (select ?x11177 gidx.2459036))))
 (let (($x7847 (= ?x11317 6)))
 (let (($x11818 (= ?x11317 0)))
 (=> (not (select (gpt ?x133318) gidx.2459036)) (or $x11818 $x7847)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (not $x9114)))
(check-sat)
