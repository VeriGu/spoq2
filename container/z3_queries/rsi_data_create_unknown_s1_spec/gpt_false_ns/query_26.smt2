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
(declare-fun spinlock_acquire_spec.0_call (Ptr RData) Option_RData)
(declare-fun v_0.96777 () Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
  (repl (value_RData (spinlock_acquire_spec.0_call a!1 st.0))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
  (oracle (value_RData (spinlock_acquire_spec.0_call a!1 st.0))))_call| (List_Event) List_Event)
(declare-fun v_0.2429557 () Int)
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
(declare-fun rtt_walk_lock_unlock_spec_abs.0_call (Ptr Ptr Int Int Int Int RData) Option_Tuple_abs_ret_rtt_RData)
(declare-fun v_2.0 () Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
  (repl (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
  (oracle (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))_call| (List_Event) List_Event)
(declare-fun abs_tte_read.0_call (Ptr RData) abs_PTE_t)
(declare-fun rec_to_rd_para.0_call (Ptr RData) Ptr)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!4 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!4 a!5)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
  (repl a!6))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!4 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!4 a!5)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
  (oracle a!6))))))_call| (List_Event) List_Event)
(declare-fun spinlock_release_spec.0_call (Ptr RData) Option_RData)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!4 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!4 a!5)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
  (repl (value_RData (spinlock_release_spec.0_call (mkPtr a!4 a!5) a!6))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!4 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!4 a!5)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
  (oracle (value_RData (spinlock_release_spec.0_call (mkPtr a!4 a!5) a!6))))))))_call| (List_Event) List_Event)
(declare-fun memcpy_ns_read_spec.0_call (Ptr Ptr Int RData) Option_Tuple_bool_RData)
(declare-fun v_0.2434093 () Int)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!3))))
(let ((a!5 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))))
      (a!6 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!7 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!5 a!6)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!8 (memcpy_ns_read_spec.0_call
             a!1
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!5 a!6) a!7)))))
  (repl (elem_1 (value_Tuple_bool_RData a!8)))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!3))))
(let ((a!5 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))))
      (a!6 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!7 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!5 a!6)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!8 (memcpy_ns_read_spec.0_call
             a!1
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!5 a!6) a!7)))))
  (oracle (elem_1 (value_Tuple_bool_RData a!8)))))))))_call| (List_Event) List_Event)
(declare-fun memset_spec.0_call (Ptr Int Int RData) Option_Tuple_Ptr_RData)
(declare-fun v_0.2434429 () Int)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!3 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!3 st.0)))))
(let ((a!5 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!4))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!5)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!5))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!5))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!2
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!1
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
  (repl (elem_1 a!10)))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!3 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!3 st.0)))))
(let ((a!5 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!4))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!5)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!5))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!5))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!2
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!1
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
  (oracle (elem_1 a!10)))))))))_call| (List_Event) List_Event)
(declare-fun granule_unlock_spec.0_call (Ptr RData) Option_RData)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!4 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!5
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!4
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
(let ((a!11 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))
              (elem_1 a!10))))
  (repl (value_RData a!11))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!4 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!5
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!4
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
(let ((a!11 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))
              (elem_1 a!10))))
  (oracle (value_RData a!11))))))))))_call| (List_Event) List_Event)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!4 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!5
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!4
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
(let ((a!11 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))
              (elem_1 a!10))))
(let ((a!12 (granule_unlock_spec.0_call
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))
              (value_RData a!11))))
  (repl (value_RData a!12)))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!4 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!5
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!4
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
(let ((a!11 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))
              (elem_1 a!10))))
(let ((a!12 (granule_unlock_spec.0_call
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))
              (value_RData a!11))))
  (oracle (value_RData a!12)))))))))))_call| (List_Event) List_Event)
(declare-fun pack_struct_return_code_para.0_call (Int) Int)
(declare-fun make_return_code_para.0_call (Int) Int)
(declare-fun v_0.2436501 () Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2436501)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!6 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!36 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2436501)))
                 4096)))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!3))))
(let ((a!7 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))))
      (a!8 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!7 a!8)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!10 (memcpy_ns_read_spec.0_call
              a!6
              (mkPtr "granule_data" 0)
              4096
              (value_RData (spinlock_release_spec.0_call (mkPtr a!7 a!8) a!9)))))
(let ((a!11 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!5
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!10))))))
(let ((a!12 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))
              (elem_1 a!11))))
(let ((a!13 (granule_unlock_spec.0_call
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!4)))
              (value_RData a!12))))
(let ((a!14 (g_heap (globals (share (value_RData a!13)))))
      (a!15 (g_debug_exits (globals (share (value_RData a!13)))))
      (a!16 (g_vmid_count (globals (share (value_RData a!13)))))
      (a!17 (g_vmid_lock (globals (share (value_RData a!13)))))
      (a!18 (g_vmids (globals (share (value_RData a!13)))))
      (a!19 (g_nr_lrs (globals (share (value_RData a!13)))))
      (a!20 (g_nr_aprs (globals (share (value_RData a!13)))))
      (a!21 (g_max_vintid (globals (share (value_RData a!13)))))
      (a!22 (g_pri_res0_mask (globals (share (value_RData a!13)))))
      (a!23 (g_default_gicstate (globals (share (value_RData a!13)))))
      (a!24 (g_status_handler (globals (share (value_RData a!13)))))
      (a!25 (g_rmm_trap_list (globals (share (value_RData a!13)))))
      (a!26 (g_tt_l3_buffer (globals (share (value_RData a!13)))))
      (a!27 (g_tt_l2_mem0_0 (globals (share (value_RData a!13)))))
      (a!28 (g_tt_l2_mem0_1 (globals (share (value_RData a!13)))))
      (a!29 (g_tt_l2_mem1_0 (globals (share (value_RData a!13)))))
      (a!30 (g_tt_l2_mem1_1 (globals (share (value_RData a!13)))))
      (a!31 (g_tt_l2_mem1_2 (globals (share (value_RData a!13)))))
      (a!32 (g_tt_l2_mem1_3 (globals (share (value_RData a!13)))))
      (a!33 (g_tt_l1_upper (globals (share (value_RData a!13)))))
      (a!34 (g_mbedtls_mem_buf (globals (share (value_RData a!13)))))
      (a!35 (g_granules (globals (share (value_RData a!13)))))
      (a!38 (g_rmm_attest_signing_key (globals (share (value_RData a!13)))))
      (a!39 (g_rmm_attest_public_key (globals (share (value_RData a!13)))))
      (a!40 (g_rmm_attest_public_key_len (globals (share (value_RData a!13)))))
      (a!41 (g_rmm_attest_public_key_hash (globals (share (value_RData a!13)))))
      (a!42 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!13)))))
      (a!43 (g_platform_token_buf (globals (share (value_RData a!13)))))
      (a!44 (g_rmm_platform_token (globals (share (value_RData a!13)))))
      (a!45 (g_get_realm_identity_identity (globals (share (value_RData a!13)))))
      (a!46 (g_realm_attest_private_key (globals (share (value_RData a!13))))))
(let ((a!37 (store a!35
                   a!36
                   (mks_granule (e_lock (select a!35 a!36))
                                4
                                (e_ref (select a!35 a!36))))))
(let ((a!47 (mkShared (gpt (share (value_RData a!13)))
                      (granule_data (share (value_RData a!13)))
                      (mkGLOBALS a!14
                                 a!15
                                 a!16
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
                                 a!37
                                 a!38
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46))))
(let ((a!48 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!13))
                       (oracle (value_RData a!13))
                       (repl (value_RData a!13))
                       (priv (value_RData a!13))
                       a!47
                       (stack (value_RData a!13))
                       (halt (value_RData a!13))))))
  (repl (value_RData a!48)))))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2436501)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!6 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!36 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2436501)))
                 4096)))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!3))))
(let ((a!7 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))))
      (a!8 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!7 a!8)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!10 (memcpy_ns_read_spec.0_call
              a!6
              (mkPtr "granule_data" 0)
              4096
              (value_RData (spinlock_release_spec.0_call (mkPtr a!7 a!8) a!9)))))
(let ((a!11 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!5
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!10))))))
(let ((a!12 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))
              (elem_1 a!11))))
(let ((a!13 (granule_unlock_spec.0_call
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!4)))
              (value_RData a!12))))
(let ((a!14 (g_heap (globals (share (value_RData a!13)))))
      (a!15 (g_debug_exits (globals (share (value_RData a!13)))))
      (a!16 (g_vmid_count (globals (share (value_RData a!13)))))
      (a!17 (g_vmid_lock (globals (share (value_RData a!13)))))
      (a!18 (g_vmids (globals (share (value_RData a!13)))))
      (a!19 (g_nr_lrs (globals (share (value_RData a!13)))))
      (a!20 (g_nr_aprs (globals (share (value_RData a!13)))))
      (a!21 (g_max_vintid (globals (share (value_RData a!13)))))
      (a!22 (g_pri_res0_mask (globals (share (value_RData a!13)))))
      (a!23 (g_default_gicstate (globals (share (value_RData a!13)))))
      (a!24 (g_status_handler (globals (share (value_RData a!13)))))
      (a!25 (g_rmm_trap_list (globals (share (value_RData a!13)))))
      (a!26 (g_tt_l3_buffer (globals (share (value_RData a!13)))))
      (a!27 (g_tt_l2_mem0_0 (globals (share (value_RData a!13)))))
      (a!28 (g_tt_l2_mem0_1 (globals (share (value_RData a!13)))))
      (a!29 (g_tt_l2_mem1_0 (globals (share (value_RData a!13)))))
      (a!30 (g_tt_l2_mem1_1 (globals (share (value_RData a!13)))))
      (a!31 (g_tt_l2_mem1_2 (globals (share (value_RData a!13)))))
      (a!32 (g_tt_l2_mem1_3 (globals (share (value_RData a!13)))))
      (a!33 (g_tt_l1_upper (globals (share (value_RData a!13)))))
      (a!34 (g_mbedtls_mem_buf (globals (share (value_RData a!13)))))
      (a!35 (g_granules (globals (share (value_RData a!13)))))
      (a!38 (g_rmm_attest_signing_key (globals (share (value_RData a!13)))))
      (a!39 (g_rmm_attest_public_key (globals (share (value_RData a!13)))))
      (a!40 (g_rmm_attest_public_key_len (globals (share (value_RData a!13)))))
      (a!41 (g_rmm_attest_public_key_hash (globals (share (value_RData a!13)))))
      (a!42 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!13)))))
      (a!43 (g_platform_token_buf (globals (share (value_RData a!13)))))
      (a!44 (g_rmm_platform_token (globals (share (value_RData a!13)))))
      (a!45 (g_get_realm_identity_identity (globals (share (value_RData a!13)))))
      (a!46 (g_realm_attest_private_key (globals (share (value_RData a!13))))))
(let ((a!37 (store a!35
                   a!36
                   (mks_granule (e_lock (select a!35 a!36))
                                4
                                (e_ref (select a!35 a!36))))))
(let ((a!47 (mkShared (gpt (share (value_RData a!13)))
                      (granule_data (share (value_RData a!13)))
                      (mkGLOBALS a!14
                                 a!15
                                 a!16
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
                                 a!37
                                 a!38
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46))))
(let ((a!48 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!13))
                       (oracle (value_RData a!13))
                       (repl (value_RData a!13))
                       (priv (value_RData a!13))
                       a!47
                       (stack (value_RData a!13))
                       (halt (value_RData a!13))))))
  (oracle (value_RData a!48)))))))))))))))_call| (List_Event) List_Event)
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
 (check_rcsm_mask_para.0_call ?x1089)))
(assert
 (forall ((gidx.2429522 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x9158 (share ?x1125)))
 (let ((?x1151 (globals ?x9158)))
 (let ((?x1113 (g_granules ?x1151)))
 (let ((?x1143 (e_state_s_granule (select ?x1113 gidx.2429522))))
 (let (($x1149 (= ?x1143 6)))
 (let (($x1181 (= ?x1143 0)))
 (=> (not (select (gpt ?x9158) gidx.2429522)) (or $x1181 $x1149)))))))))))))))
 )
(assert
 (forall ((v_0.2429557 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2429557))) 4096)))
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
 (let (($x1224 (forall ((gidx.2429745 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let (($x1217 (select ?x1200 gidx.2429745)))
 (let ((?x1139 (e_state_s_granule (select (g_granules (globals ?x1182)) gidx.2429745))))
 (let (($x1159 (= ?x1139 6)))
 (let (($x1137 (= ?x1139 0)))
 (or $x1137 $x1159 $x1217))))))))))))))))))
 ))
 (let (($x1222 (forall ((gidx.2429728 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x9158 (share ?x1125)))
 (let ((?x1151 (globals ?x9158)))
 (let ((?x1113 (g_granules ?x1151)))
 (let ((?x1143 (e_state_s_granule (select ?x1113 gidx.2429728))))
 (let (($x1181 (= ?x1143 0)))
 (let ((?x1150 (gpt ?x9158)))
 (let (($x1179 (select ?x1150 gidx.2429728)))
 (let (($x1149 (= ?x1143 6)))
 (or $x1149 $x1179 $x1181))))))))))))))))
 ))
 (or (not $x1222) $x1224))))
(assert
 (let ((?x1175 (test_Z_PTE.0_call v_0.2429557)))
 (let ((?x1141 (meta_PA ?x1175)))
 (let ((?x1163 (meta_granule_offset ?x1141)))
 (let ((?x1162 (div ?x1163 4096)))
 (let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
 (let ((?x3748 (meta_PA ?x4757)))
 (let ((?x2607 (meta_granule_offset ?x3748)))
 (let ((?x1109 (mkPtr "granules" ?x2607)))
 (let ((?x1076 (spinlock_acquire_spec.0_call ?x1109 st.0)))
 (let ((?x1125 (value_RData ?x1076)))
 (let ((?x9158 (share ?x1125)))
 (let ((?x1151 (globals ?x9158)))
 (let ((?x1113 (g_granules ?x1151)))
 (let ((?x1183 (select ?x1113 ?x1162)))
 (let ((?x1184 (e_state_s_granule ?x1183)))
 (= ?x1184 1)))))))))))))))))
(assert
 (let ((?x1175 (test_Z_PTE.0_call v_0.2429557)))
 (let ((?x1141 (meta_PA ?x1175)))
 (let ((?x1163 (meta_granule_offset ?x1141)))
 (let (($x1227 (>= ?x1163 0)))
 (let ((?x1188 (mod ?x1163 4096)))
 (let (($x1173 (= ?x1188 0)))
 (and $x1173 $x1227))))))))
(assert
 (forall ((gidx.2429858 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x1298 (e_state_s_granule (select ?x1259 gidx.2429858))))
 (let (($x1268 (= ?x1298 6)))
 (let (($x1291 (= ?x1298 0)))
 (=> (not (select (gpt ?x17364) gidx.2429858)) (or $x1291 $x1268))))))))))))))))))))
 )
(assert
 (forall ((v_0.2429893 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2429893))) 4096)))
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
 (let (($x1366 (forall ((gidx.2430081 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let (($x1359 (select ?x1342 gidx.2430081)))
 (let ((?x1355 (e_state_s_granule (select (g_granules (globals ?x1317)) gidx.2430081))))
 (let (($x1357 (= ?x1355 0)))
 (let (($x1356 (= ?x1355 6)))
 (or $x1356 $x1357 $x1359)))))))))))))))))))))))
 ))
 (let (($x1364 (forall ((gidx.2430064 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let (($x1306 (select ?x1230 gidx.2430064)))
 (let ((?x1298 (e_state_s_granule (select (g_granules (globals ?x17364)) gidx.2430064))))
 (let (($x1291 (= ?x1298 0)))
 (let (($x1268 (= ?x1298 6)))
 (or $x1268 $x1291 $x1306)))))))))))))))))))
 ))
 (or (not $x1364) $x1366))))
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
 (= ?x1313 5)))))))))))))))))))
(assert
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let (($x1371 (>= ?x17296 0)))
 (let ((?x1311 (mod ?x17296 4096)))
 (let (($x1370 (= ?x1311 0)))
 (and $x1370 $x1371)))))))
(assert
 (forall ((gidx.2430194 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x25258 (share ?x1423)))
 (let ((?x1480 (globals ?x25258)))
 (let ((?x1492 (g_granules ?x1480)))
 (let ((?x1493 (e_state_s_granule (select ?x1492 gidx.2430194))))
 (let (($x1515 (= ?x1493 6)))
 (let (($x1516 (= ?x1493 0)))
 (=> (not (select (gpt ?x25258) gidx.2430194)) (or $x1516 $x1515))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2430229 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2430229))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x25258 (share ?x1423)))
 (let ((?x1376 (gpt ?x25258)))
 (select ?x1376 ?x1047))))))))))))))))))))
 )
(assert
 (let (($x1511 (forall ((gidx.2430417 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x25258 (share ?x1423)))
 (let ((?x1458 (log ?x1423)))
 (let ((?x1373 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
  (oracle (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))_call| ?x1458)))
 (let ((?x1296 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
  (repl (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))_call| ?x1373 ?x25258)))
 (let ((?x1481 (value_Shared ?x1296)))
 (let ((?x1436 (gpt ?x1481)))
 (let (($x1526 (select ?x1436 gidx.2430417)))
 (let ((?x1387 (e_state_s_granule (select (g_granules (globals ?x1481)) gidx.2430417))))
 (let (($x1519 (= ?x1387 0)))
 (let (($x1483 (= ?x1387 6)))
 (or $x1483 $x1519 $x1526)))))))))))))))))))))))))))
 ))
 (let (($x1503 (forall ((gidx.2430400 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x25258 (share ?x1423)))
 (let ((?x1480 (globals ?x25258)))
 (let ((?x1492 (g_granules ?x1480)))
 (let ((?x1493 (e_state_s_granule (select ?x1492 gidx.2430400))))
 (let (($x1516 (= ?x1493 0)))
 (let (($x1515 (= ?x1493 6)))
 (let ((?x1376 (gpt ?x25258)))
 (let (($x1509 (select ?x1376 gidx.2430400)))
 (or $x1509 $x1515 $x1516)))))))))))))))))))))))))
 ))
 (or (not $x1503) $x1511))))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1500 (e_3 ?x1427)))
 (let ((?x1478 (* 8 ?x1500)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x1393 (poffset ?x1380)))
 (let ((?x1477 (+ ?x1393 ?x1478)))
 (let ((?x1388 (div ?x1477 4096)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x25258 (share ?x1423)))
 (let ((?x1480 (globals ?x25258)))
 (let ((?x1492 (g_granules ?x1480)))
 (let ((?x1147 (select ?x1492 ?x1388)))
 (let ((?x1536 (e_state_s_granule ?x1147)))
 (= ?x1536 5)))))))))))))))))))))))))))))
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
 (let ((?x17364 (share ?x1212)))
 (let ((?x1635 (granule_data ?x17364)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x25258 (share ?x1423)))
 (let ((?x41051 (granule_data ?x25258)))
 (= ?x41051 ?x1635)))))))))))))))))))))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x41145 (e_1 ?x1427)))
 (= ?x41145 3))))))))))))))))))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1500 (e_3 ?x1427)))
 (let ((?x1478 (* 8 ?x1500)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x1393 (poffset ?x1380)))
 (let ((?x1477 (+ ?x1393 ?x1478)))
 (let ((?x1550 (mkPtr "granule_data" ?x1477)))
 (let ((?x1553 (abs_tte_read.0_call ?x1550 ?x1423)))
 (let ((?x33227 (meta_mem_attr ?x1553)))
 (let (($x25501 (= ?x33227 0)))
 (let ((?x1615 (meta_ripas ?x1553)))
 (let (($x1613 (= ?x1615 0)))
 (let ((?x1611 (meta_desc_type ?x1553)))
 (let (($x1549 (= ?x1611 0)))
 (and $x1549 $x1613 $x25501)))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2430530 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x41218 (share ?x33226)))
 (let ((?x33257 (globals ?x41218)))
 (let ((?x33265 (g_granules ?x33257)))
 (let ((?x1572 (e_state_s_granule (select ?x33265 gidx.2430530))))
 (let (($x1594 (= ?x1572 6)))
 (let (($x1599 (= ?x1572 0)))
 (=> (not (select (gpt ?x41218) gidx.2430530)) (or $x1599 $x1594)))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2430565 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2430565))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x41218 (share ?x33226)))
 (let ((?x33259 (gpt ?x41218)))
 (select ?x33259 ?x1047)))))))))))))))))))))))))))
 )
(assert
 (let (($x1514 (forall ((gidx.2430753 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x41218 (share ?x33226)))
 (let ((?x1618 (log ?x33226)))
 (let ((?x1696 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!4 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!4 a!5)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
  (oracle a!6))))))_call| ?x1618)))
 (let ((?x678 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!4 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!4 a!5)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
  (repl a!6))))))_call| ?x1696 ?x41218)))
 (let ((?x1680 (value_Shared ?x678)))
 (let ((?x1694 (gpt ?x1680)))
 (let (($x25496 (select ?x1694 gidx.2430753)))
 (let ((?x2661 (e_state_s_granule (select (g_granules (globals ?x1680)) gidx.2430753))))
 (let (($x25492 (= ?x2661 6)))
 (let (($x1548 (= ?x2661 0)))
 (or $x1548 $x25492 $x25496))))))))))))))))))))))))))))))))))
 ))
 (let (($x1640 (forall ((gidx.2430736 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x41218 (share ?x33226)))
 (let ((?x33259 (gpt ?x41218)))
 (let (($x1622 (select ?x33259 gidx.2430736)))
 (let ((?x1572 (e_state_s_granule (select (g_granules (globals ?x41218)) gidx.2430736))))
 (let (($x1599 (= ?x1572 0)))
 (let (($x1594 (= ?x1572 6)))
 (or $x1594 $x1599 $x1622))))))))))))))))))))))))))))))
 ))
 (or (not $x1640) $x1514))))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x1579 (div ?x25458 4096)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x41218 (share ?x33226)))
 (let ((?x33257 (globals ?x41218)))
 (let ((?x33265 (g_granules ?x33257)))
 (let ((?x1482 (select ?x33265 ?x1579)))
 (let ((?x1629 (e_state_s_granule ?x1482)))
 (let (($x33222 (= ?x1629 2)))
 (not $x33222)))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2434058 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x50715 (share ?x1741)))
 (let ((?x3065 (globals ?x50715)))
 (let ((?x2940 (g_granules ?x3065)))
 (let ((?x26877 (e_state_s_granule (select ?x2940 gidx.2434058))))
 (let (($x2028 (= ?x26877 6)))
 (let (($x2720 (= ?x26877 0)))
 (=> (not (select (gpt ?x50715) gidx.2434058)) (or $x2720 $x2028)))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2434093 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2434093))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x50715 (share ?x1741)))
 (let ((?x3159 (gpt ?x50715)))
 (select ?x3159 ?x1047)))))))))))))))))))))))))))))
 )
(assert
 (let (($x3158 (forall ((gidx.2434281 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x50715 (share ?x1741)))
 (let ((?x3130 (log ?x1741)))
 (let ((?x26661 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!4 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!4 a!5)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
  (oracle (value_RData (spinlock_release_spec.0_call (mkPtr a!4 a!5) a!6))))))))_call| ?x3130)))
 (let ((?x2797 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!4 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!4 a!5)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
  (repl (value_RData (spinlock_release_spec.0_call (mkPtr a!4 a!5) a!6))))))))_call| ?x26661 ?x50715)))
 (let ((?x2895 (value_Shared ?x2797)))
 (let ((?x3185 (globals ?x2895)))
 (let ((?x27040 (g_granules ?x3185)))
 (let ((?x26579 (e_state_s_granule (select ?x27040 gidx.2434281))))
 (let (($x34544 (= ?x26579 0)))
 (let (($x3005 (= ?x26579 6)))
 (let ((?x2480 (gpt ?x2895)))
 (let (($x2915 (select ?x2480 gidx.2434281)))
 (or $x2915 $x3005 $x34544))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3080 (forall ((gidx.2434264 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x50715 (share ?x1741)))
 (let ((?x3159 (gpt ?x50715)))
 (let (($x2812 (select ?x3159 gidx.2434264)))
 (let ((?x26877 (e_state_s_granule (select (g_granules (globals ?x50715)) gidx.2434264))))
 (let (($x2720 (= ?x26877 0)))
 (let (($x2028 (= ?x26877 6)))
 (or $x2028 $x2720 $x2812))))))))))))))))))))))))))))))))
 ))
 (or (not $x3080) $x3158))))
(assert
 (forall ((gidx.2434394 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x58573 (share ?x3117)))
 (let ((?x3115 (globals ?x58573)))
 (let ((?x2961 (g_granules ?x3115)))
 (let ((?x3092 (e_state_s_granule (select ?x2961 gidx.2434394))))
 (let (($x66177 (= ?x3092 6)))
 (let (($x2831 (= ?x3092 0)))
 (=> (not (select (gpt ?x58573) gidx.2434394)) (or $x2831 $x66177)))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2434429 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2434429))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x58573 (share ?x3117)))
 (let ((?x2624 (gpt ?x58573)))
 (select ?x2624 ?x1047)))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x2934 (forall ((gidx.2434617 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x58573 (share ?x3117)))
 (let ((?x27005 (log ?x3117)))
 (let ((?x26949 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!3))))
(let ((a!5 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))))
      (a!6 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!7 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!5 a!6)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!8 (memcpy_ns_read_spec.0_call
             a!1
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!5 a!6) a!7)))))
  (oracle (elem_1 (value_Tuple_bool_RData a!8)))))))))_call| ?x27005)))
 (let ((?x10954 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!3))))
(let ((a!5 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))))
      (a!6 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!7 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!5 a!6)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!8 (memcpy_ns_read_spec.0_call
             a!1
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!5 a!6) a!7)))))
  (repl (elem_1 (value_Tuple_bool_RData a!8)))))))))_call| ?x26949 ?x58573)))
 (let ((?x3226 (value_Shared ?x10954)))
 (let ((?x34909 (globals ?x3226)))
 (let ((?x34861 (g_granules ?x34909)))
 (let ((?x3102 (e_state_s_granule (select ?x34861 gidx.2434617))))
 (let (($x42415 (= ?x3102 0)))
 (let ((?x3007 (gpt ?x3226)))
 (let (($x3107 (select ?x3007 gidx.2434617)))
 (let (($x2485 (= ?x3102 6)))
 (or $x2485 $x3107 $x42415))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x34036 (forall ((gidx.2434600 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x58573 (share ?x3117)))
 (let ((?x3115 (globals ?x58573)))
 (let ((?x2961 (g_granules ?x3115)))
 (let ((?x3092 (e_state_s_granule (select ?x2961 gidx.2434600))))
 (let (($x66177 (= ?x3092 6)))
 (let ((?x2624 (gpt ?x58573)))
 (let (($x2943 (select ?x2624 gidx.2434600)))
 (let (($x2831 (= ?x3092 0)))
 (or $x2831 $x2943 $x66177))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x34036) $x2934))))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let (($x3114 (elem_0 ?x2617)))
 (not $x3114))))))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2435794 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x75078 (share ?x27784)))
 (let ((?x2459 (globals ?x75078)))
 (let ((?x3619 (g_granules ?x2459)))
 (let ((?x3397 (e_state_s_granule (select ?x3619 gidx.2435794))))
 (let (($x3473 (= ?x3397 6)))
 (let (($x3445 (= ?x3397 0)))
 (=> (not (select (gpt ?x75078) gidx.2435794)) (or $x3445 $x3473))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2435829 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2435829))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x75078 (share ?x27784)))
 (let ((?x3918 (gpt ?x75078)))
 (select ?x3918 ?x1047))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x73502 (forall ((gidx.2436017 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x75078 (share ?x27784)))
 (let ((?x3548 (log ?x27784)))
 (let ((?x2858 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!3 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!3 st.0)))))
(let ((a!5 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!4))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!5)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!5))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!5))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!2
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!1
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
  (oracle (elem_1 a!10)))))))))_call| ?x3548)))
 (let ((?x3549 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!3 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777))))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!3 st.0)))))
(let ((a!5 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!4))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!5)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!5))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!5))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!2
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!1
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
  (repl (elem_1 a!10)))))))))_call| ?x2858 ?x75078)))
 (let ((?x3775 (value_Shared ?x3549)))
 (let ((?x3854 (globals ?x3775)))
 (let ((?x3982 (g_granules ?x3854)))
 (let ((?x3123 (e_state_s_granule (select ?x3982 gidx.2436017))))
 (let (($x74122 (= ?x3123 0)))
 (let (($x27186 (= ?x3123 6)))
 (let ((?x3945 (gpt ?x3775)))
 (let (($x3496 (select ?x3945 gidx.2436017)))
 (or $x3496 $x27186 $x74122)))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x7487 (forall ((gidx.2436000 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x75078 (share ?x27784)))
 (let ((?x3918 (gpt ?x75078)))
 (let (($x27460 (select ?x3918 gidx.2436000)))
 (let ((?x3397 (e_state_s_granule (select (g_granules (globals ?x75078)) gidx.2436000))))
 (let (($x3473 (= ?x3397 6)))
 (let (($x3445 (= ?x3397 0)))
 (or $x3445 $x3473 $x27460)))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x7487) $x73502))))
(assert
 (forall ((gidx.2436130 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x90483 (share ?x3895)))
 (let ((?x3516 (globals ?x90483)))
 (let ((?x1973 (g_granules ?x3516)))
 (let ((?x3836 (e_state_s_granule (select ?x1973 gidx.2436130))))
 (let (($x3979 (= ?x3836 6)))
 (let (($x3168 (= ?x3836 0)))
 (=> (not (select (gpt ?x90483) gidx.2436130)) (or $x3168 $x3979))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2436165 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2436165))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x90483 (share ?x3895)))
 (let ((?x3004 (gpt ?x90483)))
 (select ?x3004 ?x1047))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x3225 (forall ((gidx.2436353 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x90483 (share ?x3895)))
 (let ((?x3980 (log ?x3895)))
 (let ((?x35942 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!4 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!5
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!4
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
(let ((a!11 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))
              (elem_1 a!10))))
  (oracle (value_RData a!11))))))))))_call| ?x3980)))
 (let ((?x35822 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!4 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!5
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!4
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
(let ((a!11 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))
              (elem_1 a!10))))
  (repl (value_RData a!11))))))))))_call| ?x35942 ?x90483)))
 (let ((?x35798 (value_Shared ?x35822)))
 (let ((?x3405 (globals ?x35798)))
 (let ((?x35420 (g_granules ?x3405)))
 (let ((?x3609 (e_state_s_granule (select ?x35420 gidx.2436353))))
 (let (($x3818 (= ?x3609 0)))
 (let (($x3592 (= ?x3609 6)))
 (let ((?x3317 (gpt ?x35798)))
 (let (($x3396 (select ?x3317 gidx.2436353)))
 (or $x3396 $x3592 $x3818)))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x43835 (forall ((gidx.2436336 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x90483 (share ?x3895)))
 (let ((?x3516 (globals ?x90483)))
 (let ((?x1973 (g_granules ?x3516)))
 (let ((?x3836 (e_state_s_granule (select ?x1973 gidx.2436336))))
 (let (($x3979 (= ?x3836 6)))
 (let (($x3168 (= ?x3836 0)))
 (let ((?x3004 (gpt ?x90483)))
 (let (($x2336 (select ?x3004 gidx.2436336)))
 (or $x2336 $x3168 $x3979)))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x43835) $x3225))))
(assert
 (forall ((gidx.2436466 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x27627 (granule_unlock_spec.0_call ?x1380 ?x3895)))
 (let ((?x33660 (value_RData ?x27627)))
 (let ((?x98382 (share ?x33660)))
 (let ((?x43886 (globals ?x98382)))
 (let ((?x36162 (g_granules ?x43886)))
 (let ((?x4140 (e_state_s_granule (select ?x36162 gidx.2436466))))
 (let (($x3996 (= ?x4140 6)))
 (let (($x35604 (= ?x4140 0)))
 (let ((?x59572 (gpt ?x98382)))
 (let (($x3488 (select ?x59572 gidx.2436466)))
 (let (($x3957 (not $x3488)))
 (=> $x3957 (or $x35604 $x3996)))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2436501 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2436501))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x27627 (granule_unlock_spec.0_call ?x1380 ?x3895)))
 (let ((?x33660 (value_RData ?x27627)))
 (let ((?x98382 (share ?x33660)))
 (let ((?x59572 (gpt ?x98382)))
 (select ?x59572 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x4210 (forall ((gidx.2436689 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x27627 (granule_unlock_spec.0_call ?x1380 ?x3895)))
 (let ((?x33660 (value_RData ?x27627)))
 (let ((?x98382 (share ?x33660)))
 (let ((?x4042 (log ?x33660)))
 (let ((?x4068 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!4 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!5
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!4
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
(let ((a!11 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))
              (elem_1 a!10))))
(let ((a!12 (granule_unlock_spec.0_call
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))
              (value_RData a!11))))
  (oracle (value_RData a!12)))))))))))_call| ?x4042)))
 (let ((?x4145 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!4 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!2))))
(let ((a!6 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!7 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!8 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!6 a!7)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!9 (memcpy_ns_read_spec.0_call
             a!5
             (mkPtr "granule_data" 0)
             4096
             (value_RData (spinlock_release_spec.0_call (mkPtr a!6 a!7) a!8)))))
(let ((a!10 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!4
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!9))))))
(let ((a!11 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))
              (elem_1 a!10))))
(let ((a!12 (granule_unlock_spec.0_call
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))
              (value_RData a!11))))
  (repl (value_RData a!12)))))))))))_call| ?x4068 ?x98382)))
 (let ((?x4030 (value_Shared ?x4145)))
 (let ((?x3697 (gpt ?x4030)))
 (let (($x43833 (select ?x3697 gidx.2436689)))
 (let ((?x35889 (e_state_s_granule (select (g_granules (globals ?x4030)) gidx.2436689))))
 (let (($x3826 (= ?x35889 6)))
 (let (($x3561 (= ?x35889 0)))
 (or $x3561 $x3826 $x43833)))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x4083 (forall ((gidx.2436672 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x27627 (granule_unlock_spec.0_call ?x1380 ?x3895)))
 (let ((?x33660 (value_RData ?x27627)))
 (let ((?x98382 (share ?x33660)))
 (let ((?x43886 (globals ?x98382)))
 (let ((?x36162 (g_granules ?x43886)))
 (let ((?x4140 (e_state_s_granule (select ?x36162 gidx.2436672))))
 (let (($x35604 (= ?x4140 0)))
 (let (($x3996 (= ?x4140 6)))
 (let ((?x59572 (gpt ?x98382)))
 (let (($x3488 (select ?x59572 gidx.2436672)))
 (or $x3488 $x3996 $x35604)))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x4083) $x4210))))
(assert
 (let ((?x73347 (make_return_code_para.0_call 1)))
 (let ((?x26393 (pack_struct_return_code_para.0_call ?x73347)))
 (= ?x26393 0))))
(assert
 (forall ((gidx.2436802 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x27627 (granule_unlock_spec.0_call ?x1380 ?x3895)))
 (let ((?x33660 (value_RData ?x27627)))
 (let ((?x3244 (test_Z_PTE.0_call v_0.2436501)))
 (let ((?x3984 (meta_PA ?x3244)))
 (let ((?x3271 (meta_granule_offset ?x3984)))
 (let ((?x4048 (div ?x3271 4096)))
 (let ((?x98382 (share ?x33660)))
 (let ((?x43886 (globals ?x98382)))
 (let ((?x36162 (g_granules ?x43886)))
 (let ((?x3883 (select ?x36162 ?x4048)))
 (let ((?x27931 (mks_granule (e_lock ?x3883) 4 (e_ref ?x3883))))
 (let ((?x3812 (store ?x36162 ?x4048 ?x27931)))
 (let ((?x3844 (mkGLOBALS (g_heap ?x43886) (g_debug_exits ?x43886) (g_vmid_count ?x43886) (g_vmid_lock ?x43886) (g_vmids ?x43886) (g_nr_lrs ?x43886) (g_nr_aprs ?x43886) (g_max_vintid ?x43886) (g_pri_res0_mask ?x43886) (g_default_gicstate ?x43886) (g_status_handler ?x43886) (g_rmm_trap_list ?x43886) (g_tt_l3_buffer ?x43886) (g_tt_l2_mem0_0 ?x43886) (g_tt_l2_mem0_1 ?x43886) (g_tt_l2_mem1_0 ?x43886) (g_tt_l2_mem1_1 ?x43886) (g_tt_l2_mem1_2 ?x43886) (g_tt_l2_mem1_3 ?x43886) (g_tt_l1_upper ?x43886) (g_mbedtls_mem_buf ?x43886) ?x3812 (g_rmm_attest_signing_key ?x43886) (g_rmm_attest_public_key ?x43886) (g_rmm_attest_public_key_len ?x43886) (g_rmm_attest_public_key_hash ?x43886) (g_rmm_attest_public_key_hash_len ?x43886) (g_platform_token_buf ?x43886) (g_rmm_platform_token ?x43886) (g_get_realm_identity_identity ?x43886) (g_realm_attest_private_key ?x43886))))
 (let ((?x59572 (gpt ?x98382)))
 (let ((?x3695 (repl ?x33660)))
 (let ((?x3691 (oracle ?x33660)))
 (let ((?x4042 (log ?x33660)))
 (let ((?x3596 (mkRData ?x4042 ?x3691 ?x3695 (priv ?x33660) (mkShared ?x59572 (granule_data ?x98382) ?x3844) (stack ?x33660) (halt ?x33660))))
 (let ((?x4054 (mkPtr "granules" ?x3271)))
 (let ((?x3972 (granule_unlock_spec.0_call ?x4054 ?x3596)))
 (let ((?x73976 (value_RData ?x3972)))
 (let ((?x106338 (share ?x73976)))
 (let ((?x4073 (globals ?x106338)))
 (let ((?x3466 (g_granules ?x4073)))
 (let ((?x4237 (e_state_s_granule (select ?x3466 gidx.2436802))))
 (let (($x4295 (= ?x4237 6)))
 (let (($x4019 (= ?x4237 0)))
 (=> (not (select (gpt ?x106338) gidx.2436802)) (or $x4019 $x4295)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2436837 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2436837))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x27627 (granule_unlock_spec.0_call ?x1380 ?x3895)))
 (let ((?x33660 (value_RData ?x27627)))
 (let ((?x3244 (test_Z_PTE.0_call v_0.2436501)))
 (let ((?x3984 (meta_PA ?x3244)))
 (let ((?x3271 (meta_granule_offset ?x3984)))
 (let ((?x4048 (div ?x3271 4096)))
 (let ((?x98382 (share ?x33660)))
 (let ((?x43886 (globals ?x98382)))
 (let ((?x36162 (g_granules ?x43886)))
 (let ((?x3883 (select ?x36162 ?x4048)))
 (let ((?x27931 (mks_granule (e_lock ?x3883) 4 (e_ref ?x3883))))
 (let ((?x3812 (store ?x36162 ?x4048 ?x27931)))
 (let ((?x3844 (mkGLOBALS (g_heap ?x43886) (g_debug_exits ?x43886) (g_vmid_count ?x43886) (g_vmid_lock ?x43886) (g_vmids ?x43886) (g_nr_lrs ?x43886) (g_nr_aprs ?x43886) (g_max_vintid ?x43886) (g_pri_res0_mask ?x43886) (g_default_gicstate ?x43886) (g_status_handler ?x43886) (g_rmm_trap_list ?x43886) (g_tt_l3_buffer ?x43886) (g_tt_l2_mem0_0 ?x43886) (g_tt_l2_mem0_1 ?x43886) (g_tt_l2_mem1_0 ?x43886) (g_tt_l2_mem1_1 ?x43886) (g_tt_l2_mem1_2 ?x43886) (g_tt_l2_mem1_3 ?x43886) (g_tt_l1_upper ?x43886) (g_mbedtls_mem_buf ?x43886) ?x3812 (g_rmm_attest_signing_key ?x43886) (g_rmm_attest_public_key ?x43886) (g_rmm_attest_public_key_len ?x43886) (g_rmm_attest_public_key_hash ?x43886) (g_rmm_attest_public_key_hash_len ?x43886) (g_platform_token_buf ?x43886) (g_rmm_platform_token ?x43886) (g_get_realm_identity_identity ?x43886) (g_realm_attest_private_key ?x43886))))
 (let ((?x59572 (gpt ?x98382)))
 (let ((?x3695 (repl ?x33660)))
 (let ((?x3691 (oracle ?x33660)))
 (let ((?x4042 (log ?x33660)))
 (let ((?x3596 (mkRData ?x4042 ?x3691 ?x3695 (priv ?x33660) (mkShared ?x59572 (granule_data ?x98382) ?x3844) (stack ?x33660) (halt ?x33660))))
 (let ((?x4054 (mkPtr "granules" ?x3271)))
 (let ((?x3972 (granule_unlock_spec.0_call ?x4054 ?x3596)))
 (let ((?x73976 (value_RData ?x3972)))
 (let ((?x106338 (share ?x73976)))
 (let ((?x4118 (gpt ?x106338)))
 (select ?x4118 ?x1047)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x75342 (forall ((gidx.2437025 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x27627 (granule_unlock_spec.0_call ?x1380 ?x3895)))
 (let ((?x33660 (value_RData ?x27627)))
 (let ((?x3244 (test_Z_PTE.0_call v_0.2436501)))
 (let ((?x3984 (meta_PA ?x3244)))
 (let ((?x3271 (meta_granule_offset ?x3984)))
 (let ((?x4048 (div ?x3271 4096)))
 (let ((?x98382 (share ?x33660)))
 (let ((?x43886 (globals ?x98382)))
 (let ((?x36162 (g_granules ?x43886)))
 (let ((?x3883 (select ?x36162 ?x4048)))
 (let ((?x27931 (mks_granule (e_lock ?x3883) 4 (e_ref ?x3883))))
 (let ((?x3812 (store ?x36162 ?x4048 ?x27931)))
 (let ((?x3844 (mkGLOBALS (g_heap ?x43886) (g_debug_exits ?x43886) (g_vmid_count ?x43886) (g_vmid_lock ?x43886) (g_vmids ?x43886) (g_nr_lrs ?x43886) (g_nr_aprs ?x43886) (g_max_vintid ?x43886) (g_pri_res0_mask ?x43886) (g_default_gicstate ?x43886) (g_status_handler ?x43886) (g_rmm_trap_list ?x43886) (g_tt_l3_buffer ?x43886) (g_tt_l2_mem0_0 ?x43886) (g_tt_l2_mem0_1 ?x43886) (g_tt_l2_mem1_0 ?x43886) (g_tt_l2_mem1_1 ?x43886) (g_tt_l2_mem1_2 ?x43886) (g_tt_l2_mem1_3 ?x43886) (g_tt_l1_upper ?x43886) (g_mbedtls_mem_buf ?x43886) ?x3812 (g_rmm_attest_signing_key ?x43886) (g_rmm_attest_public_key ?x43886) (g_rmm_attest_public_key_len ?x43886) (g_rmm_attest_public_key_hash ?x43886) (g_rmm_attest_public_key_hash_len ?x43886) (g_platform_token_buf ?x43886) (g_rmm_platform_token ?x43886) (g_get_realm_identity_identity ?x43886) (g_realm_attest_private_key ?x43886))))
 (let ((?x59572 (gpt ?x98382)))
 (let ((?x3695 (repl ?x33660)))
 (let ((?x3691 (oracle ?x33660)))
 (let ((?x4042 (log ?x33660)))
 (let ((?x3596 (mkRData ?x4042 ?x3691 ?x3695 (priv ?x33660) (mkShared ?x59572 (granule_data ?x98382) ?x3844) (stack ?x33660) (halt ?x33660))))
 (let ((?x4054 (mkPtr "granules" ?x3271)))
 (let ((?x3972 (granule_unlock_spec.0_call ?x4054 ?x3596)))
 (let ((?x73976 (value_RData ?x3972)))
 (let ((?x106338 (share ?x73976)))
 (let ((?x3821 (log ?x73976)))
 (let ((?x4007 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2436501)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!6 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!36 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2436501)))
                 4096)))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!3))))
(let ((a!7 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))))
      (a!8 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!7 a!8)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!10 (memcpy_ns_read_spec.0_call
              a!6
              (mkPtr "granule_data" 0)
              4096
              (value_RData (spinlock_release_spec.0_call (mkPtr a!7 a!8) a!9)))))
(let ((a!11 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!5
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!10))))))
(let ((a!12 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))
              (elem_1 a!11))))
(let ((a!13 (granule_unlock_spec.0_call
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!4)))
              (value_RData a!12))))
(let ((a!14 (g_heap (globals (share (value_RData a!13)))))
      (a!15 (g_debug_exits (globals (share (value_RData a!13)))))
      (a!16 (g_vmid_count (globals (share (value_RData a!13)))))
      (a!17 (g_vmid_lock (globals (share (value_RData a!13)))))
      (a!18 (g_vmids (globals (share (value_RData a!13)))))
      (a!19 (g_nr_lrs (globals (share (value_RData a!13)))))
      (a!20 (g_nr_aprs (globals (share (value_RData a!13)))))
      (a!21 (g_max_vintid (globals (share (value_RData a!13)))))
      (a!22 (g_pri_res0_mask (globals (share (value_RData a!13)))))
      (a!23 (g_default_gicstate (globals (share (value_RData a!13)))))
      (a!24 (g_status_handler (globals (share (value_RData a!13)))))
      (a!25 (g_rmm_trap_list (globals (share (value_RData a!13)))))
      (a!26 (g_tt_l3_buffer (globals (share (value_RData a!13)))))
      (a!27 (g_tt_l2_mem0_0 (globals (share (value_RData a!13)))))
      (a!28 (g_tt_l2_mem0_1 (globals (share (value_RData a!13)))))
      (a!29 (g_tt_l2_mem1_0 (globals (share (value_RData a!13)))))
      (a!30 (g_tt_l2_mem1_1 (globals (share (value_RData a!13)))))
      (a!31 (g_tt_l2_mem1_2 (globals (share (value_RData a!13)))))
      (a!32 (g_tt_l2_mem1_3 (globals (share (value_RData a!13)))))
      (a!33 (g_tt_l1_upper (globals (share (value_RData a!13)))))
      (a!34 (g_mbedtls_mem_buf (globals (share (value_RData a!13)))))
      (a!35 (g_granules (globals (share (value_RData a!13)))))
      (a!38 (g_rmm_attest_signing_key (globals (share (value_RData a!13)))))
      (a!39 (g_rmm_attest_public_key (globals (share (value_RData a!13)))))
      (a!40 (g_rmm_attest_public_key_len (globals (share (value_RData a!13)))))
      (a!41 (g_rmm_attest_public_key_hash (globals (share (value_RData a!13)))))
      (a!42 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!13)))))
      (a!43 (g_platform_token_buf (globals (share (value_RData a!13)))))
      (a!44 (g_rmm_platform_token (globals (share (value_RData a!13)))))
      (a!45 (g_get_realm_identity_identity (globals (share (value_RData a!13)))))
      (a!46 (g_realm_attest_private_key (globals (share (value_RData a!13))))))
(let ((a!37 (store a!35
                   a!36
                   (mks_granule (e_lock (select a!35 a!36))
                                4
                                (e_ref (select a!35 a!36))))))
(let ((a!47 (mkShared (gpt (share (value_RData a!13)))
                      (granule_data (share (value_RData a!13)))
                      (mkGLOBALS a!14
                                 a!15
                                 a!16
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
                                 a!37
                                 a!38
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46))))
(let ((a!48 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!13))
                       (oracle (value_RData a!13))
                       (repl (value_RData a!13))
                       (priv (value_RData a!13))
                       a!47
                       (stack (value_RData a!13))
                       (halt (value_RData a!13))))))
  (oracle (value_RData a!48)))))))))))))))_call| ?x3821)))
 (let ((?x75151 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2436501)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!5 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434429)))))
      (a!6 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2434093)))))
      (a!36 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2436501)))
                 4096)))
(let ((a!3 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!2 st.0)))))
(let ((a!4 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             0
             64
             v_2.0
             3
             (value_RData a!3))))
(let ((a!7 (pbase (rec_to_rd_para.0_call
                    (mkPtr "null" 0)
                    (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))))
      (a!8 (poffset (rec_to_rd_para.0_call
                      (mkPtr "null" 0)
                      (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr a!7 a!8)
                          (elem_1 (value_Tuple_abs_ret_rtt_RData a!4))))))
(let ((a!10 (memcpy_ns_read_spec.0_call
              a!6
              (mkPtr "granule_data" 0)
              4096
              (value_RData (spinlock_release_spec.0_call (mkPtr a!7 a!8) a!9)))))
(let ((a!11 (value_Tuple_Ptr_RData
              (memset_spec.0_call
                a!5
                0
                4096
                (elem_1 (value_Tuple_bool_RData a!10))))))
(let ((a!12 (granule_unlock_spec.0_call
              (rec_to_rd_para.0_call
                (mkPtr "null" 0)
                (elem_1 (value_Tuple_abs_ret_rtt_RData a!4)))
              (elem_1 a!11))))
(let ((a!13 (granule_unlock_spec.0_call
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!4)))
              (value_RData a!12))))
(let ((a!14 (g_heap (globals (share (value_RData a!13)))))
      (a!15 (g_debug_exits (globals (share (value_RData a!13)))))
      (a!16 (g_vmid_count (globals (share (value_RData a!13)))))
      (a!17 (g_vmid_lock (globals (share (value_RData a!13)))))
      (a!18 (g_vmids (globals (share (value_RData a!13)))))
      (a!19 (g_nr_lrs (globals (share (value_RData a!13)))))
      (a!20 (g_nr_aprs (globals (share (value_RData a!13)))))
      (a!21 (g_max_vintid (globals (share (value_RData a!13)))))
      (a!22 (g_pri_res0_mask (globals (share (value_RData a!13)))))
      (a!23 (g_default_gicstate (globals (share (value_RData a!13)))))
      (a!24 (g_status_handler (globals (share (value_RData a!13)))))
      (a!25 (g_rmm_trap_list (globals (share (value_RData a!13)))))
      (a!26 (g_tt_l3_buffer (globals (share (value_RData a!13)))))
      (a!27 (g_tt_l2_mem0_0 (globals (share (value_RData a!13)))))
      (a!28 (g_tt_l2_mem0_1 (globals (share (value_RData a!13)))))
      (a!29 (g_tt_l2_mem1_0 (globals (share (value_RData a!13)))))
      (a!30 (g_tt_l2_mem1_1 (globals (share (value_RData a!13)))))
      (a!31 (g_tt_l2_mem1_2 (globals (share (value_RData a!13)))))
      (a!32 (g_tt_l2_mem1_3 (globals (share (value_RData a!13)))))
      (a!33 (g_tt_l1_upper (globals (share (value_RData a!13)))))
      (a!34 (g_mbedtls_mem_buf (globals (share (value_RData a!13)))))
      (a!35 (g_granules (globals (share (value_RData a!13)))))
      (a!38 (g_rmm_attest_signing_key (globals (share (value_RData a!13)))))
      (a!39 (g_rmm_attest_public_key (globals (share (value_RData a!13)))))
      (a!40 (g_rmm_attest_public_key_len (globals (share (value_RData a!13)))))
      (a!41 (g_rmm_attest_public_key_hash (globals (share (value_RData a!13)))))
      (a!42 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!13)))))
      (a!43 (g_platform_token_buf (globals (share (value_RData a!13)))))
      (a!44 (g_rmm_platform_token (globals (share (value_RData a!13)))))
      (a!45 (g_get_realm_identity_identity (globals (share (value_RData a!13)))))
      (a!46 (g_realm_attest_private_key (globals (share (value_RData a!13))))))
(let ((a!37 (store a!35
                   a!36
                   (mks_granule (e_lock (select a!35 a!36))
                                4
                                (e_ref (select a!35 a!36))))))
(let ((a!47 (mkShared (gpt (share (value_RData a!13)))
                      (granule_data (share (value_RData a!13)))
                      (mkGLOBALS a!14
                                 a!15
                                 a!16
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
                                 a!37
                                 a!38
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46))))
(let ((a!48 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!13))
                       (oracle (value_RData a!13))
                       (repl (value_RData a!13))
                       (priv (value_RData a!13))
                       a!47
                       (stack (value_RData a!13))
                       (halt (value_RData a!13))))))
  (repl (value_RData a!48)))))))))))))))_call| ?x4007 ?x106338)))
 (let ((?x3807 (value_Shared ?x75151)))
 (let ((?x4133 (gpt ?x3807)))
 (let (($x82684 (select ?x4133 gidx.2437025)))
 (let ((?x35738 (e_state_s_granule (select (g_granules (globals ?x3807)) gidx.2437025))))
 (let (($x27954 (= ?x35738 0)))
 (let (($x27950 (= ?x35738 6)))
 (or $x27950 $x27954 $x82684))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x82875 (forall ((gidx.2437008 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x27627 (granule_unlock_spec.0_call ?x1380 ?x3895)))
 (let ((?x33660 (value_RData ?x27627)))
 (let ((?x3244 (test_Z_PTE.0_call v_0.2436501)))
 (let ((?x3984 (meta_PA ?x3244)))
 (let ((?x3271 (meta_granule_offset ?x3984)))
 (let ((?x4048 (div ?x3271 4096)))
 (let ((?x98382 (share ?x33660)))
 (let ((?x43886 (globals ?x98382)))
 (let ((?x36162 (g_granules ?x43886)))
 (let ((?x3883 (select ?x36162 ?x4048)))
 (let ((?x27931 (mks_granule (e_lock ?x3883) 4 (e_ref ?x3883))))
 (let ((?x3812 (store ?x36162 ?x4048 ?x27931)))
 (let ((?x3844 (mkGLOBALS (g_heap ?x43886) (g_debug_exits ?x43886) (g_vmid_count ?x43886) (g_vmid_lock ?x43886) (g_vmids ?x43886) (g_nr_lrs ?x43886) (g_nr_aprs ?x43886) (g_max_vintid ?x43886) (g_pri_res0_mask ?x43886) (g_default_gicstate ?x43886) (g_status_handler ?x43886) (g_rmm_trap_list ?x43886) (g_tt_l3_buffer ?x43886) (g_tt_l2_mem0_0 ?x43886) (g_tt_l2_mem0_1 ?x43886) (g_tt_l2_mem1_0 ?x43886) (g_tt_l2_mem1_1 ?x43886) (g_tt_l2_mem1_2 ?x43886) (g_tt_l2_mem1_3 ?x43886) (g_tt_l1_upper ?x43886) (g_mbedtls_mem_buf ?x43886) ?x3812 (g_rmm_attest_signing_key ?x43886) (g_rmm_attest_public_key ?x43886) (g_rmm_attest_public_key_len ?x43886) (g_rmm_attest_public_key_hash ?x43886) (g_rmm_attest_public_key_hash_len ?x43886) (g_platform_token_buf ?x43886) (g_rmm_platform_token ?x43886) (g_get_realm_identity_identity ?x43886) (g_realm_attest_private_key ?x43886))))
 (let ((?x59572 (gpt ?x98382)))
 (let ((?x3695 (repl ?x33660)))
 (let ((?x3691 (oracle ?x33660)))
 (let ((?x4042 (log ?x33660)))
 (let ((?x3596 (mkRData ?x4042 ?x3691 ?x3695 (priv ?x33660) (mkShared ?x59572 (granule_data ?x98382) ?x3844) (stack ?x33660) (halt ?x33660))))
 (let ((?x4054 (mkPtr "granules" ?x3271)))
 (let ((?x3972 (granule_unlock_spec.0_call ?x4054 ?x3596)))
 (let ((?x73976 (value_RData ?x3972)))
 (let ((?x106338 (share ?x73976)))
 (let ((?x4073 (globals ?x106338)))
 (let ((?x3466 (g_granules ?x4073)))
 (let ((?x4237 (e_state_s_granule (select ?x3466 gidx.2437008))))
 (let (($x4295 (= ?x4237 6)))
 (let ((?x4118 (gpt ?x106338)))
 (let (($x4045 (select ?x4118 gidx.2437008)))
 (let (($x4019 (= ?x4237 0)))
 (or $x4019 $x4045 $x4295))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x82875) $x75342))))
(assert
 (let (($x43885 (forall ((gidx.2437084 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1440 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x1244 0 64 v_2.0 3 ?x1212)))
 (let ((?x1426 (value_Tuple_abs_ret_rtt_RData ?x1440)))
 (let ((?x1423 (elem_1 ?x1426)))
 (let ((?x424 (mkPtr "null" 0)))
 (let ((?x1709 (rec_to_rd_para.0_call ?x424 ?x1423)))
 (let ((?x25458 (poffset ?x1709)))
 (let ((?x2659 (pbase ?x1709)))
 (let ((?x1632 (mkPtr ?x2659 ?x25458)))
 (let ((?x1619 (spinlock_acquire_spec.0_call ?x1632 ?x1423)))
 (let ((?x33226 (value_RData ?x1619)))
 (let ((?x109293 (spinlock_release_spec.0_call ?x1632 ?x33226)))
 (let ((?x1741 (value_RData ?x109293)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x3081 (test_Z_PTE.0_call v_0.2434093)))
 (let ((?x26906 (meta_PA ?x3081)))
 (let ((?x3193 (meta_granule_offset ?x26906)))
 (let ((?x34966 (mkPtr "granule_data" ?x3193)))
 (let ((?x2823 (memcpy_ns_read_spec.0_call ?x34966 ?x1721 4096 ?x1741)))
 (let ((?x2617 (value_Tuple_bool_RData ?x2823)))
 (let ((?x3117 (elem_1 ?x2617)))
 (let ((?x34842 (test_Z_PTE.0_call v_0.2434429)))
 (let ((?x3239 (meta_PA ?x34842)))
 (let ((?x1719 (meta_granule_offset ?x3239)))
 (let ((?x102291 (mkPtr "granule_data" ?x1719)))
 (let ((?x35782 (memset_spec.0_call ?x102291 0 4096 ?x3117)))
 (let ((?x3054 (value_Tuple_Ptr_RData ?x35782)))
 (let ((?x27784 (elem_1 ?x3054)))
 (let ((?x3679 (granule_unlock_spec.0_call ?x1709 ?x27784)))
 (let ((?x3895 (value_RData ?x3679)))
 (let ((?x1427 (elem_0 ?x1426)))
 (let ((?x1380 (e_2 ?x1427)))
 (let ((?x27627 (granule_unlock_spec.0_call ?x1380 ?x3895)))
 (let ((?x33660 (value_RData ?x27627)))
 (let ((?x3244 (test_Z_PTE.0_call v_0.2436501)))
 (let ((?x3984 (meta_PA ?x3244)))
 (let ((?x3271 (meta_granule_offset ?x3984)))
 (let ((?x4048 (div ?x3271 4096)))
 (let ((?x98382 (share ?x33660)))
 (let ((?x43886 (globals ?x98382)))
 (let ((?x36162 (g_granules ?x43886)))
 (let ((?x3883 (select ?x36162 ?x4048)))
 (let ((?x27931 (mks_granule (e_lock ?x3883) 4 (e_ref ?x3883))))
 (let ((?x3812 (store ?x36162 ?x4048 ?x27931)))
 (let ((?x3844 (mkGLOBALS (g_heap ?x43886) (g_debug_exits ?x43886) (g_vmid_count ?x43886) (g_vmid_lock ?x43886) (g_vmids ?x43886) (g_nr_lrs ?x43886) (g_nr_aprs ?x43886) (g_max_vintid ?x43886) (g_pri_res0_mask ?x43886) (g_default_gicstate ?x43886) (g_status_handler ?x43886) (g_rmm_trap_list ?x43886) (g_tt_l3_buffer ?x43886) (g_tt_l2_mem0_0 ?x43886) (g_tt_l2_mem0_1 ?x43886) (g_tt_l2_mem1_0 ?x43886) (g_tt_l2_mem1_1 ?x43886) (g_tt_l2_mem1_2 ?x43886) (g_tt_l2_mem1_3 ?x43886) (g_tt_l1_upper ?x43886) (g_mbedtls_mem_buf ?x43886) ?x3812 (g_rmm_attest_signing_key ?x43886) (g_rmm_attest_public_key ?x43886) (g_rmm_attest_public_key_len ?x43886) (g_rmm_attest_public_key_hash ?x43886) (g_rmm_attest_public_key_hash_len ?x43886) (g_platform_token_buf ?x43886) (g_rmm_platform_token ?x43886) (g_get_realm_identity_identity ?x43886) (g_realm_attest_private_key ?x43886))))
 (let ((?x59572 (gpt ?x98382)))
 (let ((?x3695 (repl ?x33660)))
 (let ((?x3691 (oracle ?x33660)))
 (let ((?x4042 (log ?x33660)))
 (let ((?x3596 (mkRData ?x4042 ?x3691 ?x3695 (priv ?x33660) (mkShared ?x59572 (granule_data ?x98382) ?x3844) (stack ?x33660) (halt ?x33660))))
 (let ((?x4054 (mkPtr "granules" ?x3271)))
 (let ((?x3972 (granule_unlock_spec.0_call ?x4054 ?x3596)))
 (let ((?x73976 (value_RData ?x3972)))
 (let ((?x106338 (share ?x73976)))
 (let ((?x4073 (globals ?x106338)))
 (let ((?x3466 (g_granules ?x4073)))
 (let ((?x4237 (e_state_s_granule (select ?x3466 gidx.2437084))))
 (let (($x4295 (= ?x4237 6)))
 (let (($x4019 (= ?x4237 0)))
 (=> (not (select (gpt ?x106338) gidx.2437084)) (or $x4019 $x4295)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (not $x43885)))
(check-sat)
