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
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
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
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
  (oracle a!5))))))_call| (List_Event) List_Event)
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
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!5)))
(let ((a!7 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!5))))
  (repl a!7))))))))_call| (List_Event Shared) Option_Shared)
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
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!5)))
(let ((a!7 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!5))))
  (oracle a!7))))))))_call| (List_Event) List_Event)
(declare-fun memcpy_ns_read_spec.0_call (Ptr Ptr Int RData) Option_Tuple_bool_RData)
(declare-fun v_0.2442045 () Int)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
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
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!4
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
(let ((a!9 (elem_1 (value_Tuple_bool_RData
                     (memcpy_ns_read_spec.0_call
                       a!1
                       (mkPtr "granule_data" 0)
                       4096
                       a!8)))))
  (repl a!9)))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
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
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!4
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
(let ((a!9 (elem_1 (value_Tuple_bool_RData
                     (memcpy_ns_read_spec.0_call
                       a!1
                       (mkPtr "granule_data" 0)
                       4096
                       a!8)))))
  (oracle a!9)))))))))_call| (List_Event) List_Event)
(declare-fun memset_spec.0_call (Ptr Int Int RData) Option_Tuple_Ptr_RData)
(declare-fun v_0.2442381 () Int)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
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
(let ((a!7 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!5
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
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (repl (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!10))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
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
(let ((a!7 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!5
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
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (oracle (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!10))))))))))))_call| (List_Event) List_Event)
(declare-fun granule_unlock_spec.0_call (Ptr RData) Option_RData)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!5)))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!5))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
  (repl (value_RData a!11)))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!5)))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!5))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
  (oracle (value_RData a!11)))))))))))_call| (List_Event) List_Event)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!4))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!5))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          (elem_1 a!5)))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
(let ((a!12 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!11)))))
  (repl a!12)))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!4))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!5))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          (elem_1 a!5)))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
(let ((a!12 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!11)))))
  (oracle a!12)))))))))))_call| (List_Event) List_Event)
(declare-fun pack_struct_return_code_para.0_call (Int) Int)
(declare-fun make_return_code_para.0_call (Int) Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!4))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!5))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          (elem_1 a!5)))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
(let ((a!12 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!12)))
  (repl (value_RData a!13)))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!4))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!5))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          (elem_1 a!5)))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
(let ((a!12 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!12)))
  (oracle (value_RData a!13)))))))))))))_call| (List_Event) List_Event)
(declare-fun v_0.2445853 () Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2445853)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
      (a!37 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2445853)))
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
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!4
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
(let ((a!15 (g_heap (globals (share (value_RData a!14)))))
      (a!16 (g_debug_exits (globals (share (value_RData a!14)))))
      (a!17 (g_vmid_count (globals (share (value_RData a!14)))))
      (a!18 (g_vmid_lock (globals (share (value_RData a!14)))))
      (a!19 (g_vmids (globals (share (value_RData a!14)))))
      (a!20 (g_nr_lrs (globals (share (value_RData a!14)))))
      (a!21 (g_nr_aprs (globals (share (value_RData a!14)))))
      (a!22 (g_max_vintid (globals (share (value_RData a!14)))))
      (a!23 (g_pri_res0_mask (globals (share (value_RData a!14)))))
      (a!24 (g_default_gicstate (globals (share (value_RData a!14)))))
      (a!25 (g_status_handler (globals (share (value_RData a!14)))))
      (a!26 (g_rmm_trap_list (globals (share (value_RData a!14)))))
      (a!27 (g_tt_l3_buffer (globals (share (value_RData a!14)))))
      (a!28 (g_tt_l2_mem0_0 (globals (share (value_RData a!14)))))
      (a!29 (g_tt_l2_mem0_1 (globals (share (value_RData a!14)))))
      (a!30 (g_tt_l2_mem1_0 (globals (share (value_RData a!14)))))
      (a!31 (g_tt_l2_mem1_1 (globals (share (value_RData a!14)))))
      (a!32 (g_tt_l2_mem1_2 (globals (share (value_RData a!14)))))
      (a!33 (g_tt_l2_mem1_3 (globals (share (value_RData a!14)))))
      (a!34 (g_tt_l1_upper (globals (share (value_RData a!14)))))
      (a!35 (g_mbedtls_mem_buf (globals (share (value_RData a!14)))))
      (a!36 (g_granules (globals (share (value_RData a!14)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!14)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!14)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!14)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!14)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!14)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!14)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!14)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!14)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!14))))))
(let ((a!38 (store a!36
                   a!37
                   (mks_granule (e_lock (select a!36 a!37))
                                1
                                (e_ref (select a!36 a!37))))))
(let ((a!48 (mkShared (gpt (share (value_RData a!14)))
                      (granule_data (share (value_RData a!14)))
                      (mkGLOBALS a!15
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
                                 a!35
                                 a!38
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46
                                 a!47))))
(let ((a!49 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!14))
                       (oracle (value_RData a!14))
                       (repl (value_RData a!14))
                       (priv (value_RData a!14))
                       a!48
                       (stack (value_RData a!14))
                       (halt (value_RData a!14))))))
  (repl (value_RData a!49)))))))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2445853)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
      (a!37 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2445853)))
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
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!4
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
(let ((a!15 (g_heap (globals (share (value_RData a!14)))))
      (a!16 (g_debug_exits (globals (share (value_RData a!14)))))
      (a!17 (g_vmid_count (globals (share (value_RData a!14)))))
      (a!18 (g_vmid_lock (globals (share (value_RData a!14)))))
      (a!19 (g_vmids (globals (share (value_RData a!14)))))
      (a!20 (g_nr_lrs (globals (share (value_RData a!14)))))
      (a!21 (g_nr_aprs (globals (share (value_RData a!14)))))
      (a!22 (g_max_vintid (globals (share (value_RData a!14)))))
      (a!23 (g_pri_res0_mask (globals (share (value_RData a!14)))))
      (a!24 (g_default_gicstate (globals (share (value_RData a!14)))))
      (a!25 (g_status_handler (globals (share (value_RData a!14)))))
      (a!26 (g_rmm_trap_list (globals (share (value_RData a!14)))))
      (a!27 (g_tt_l3_buffer (globals (share (value_RData a!14)))))
      (a!28 (g_tt_l2_mem0_0 (globals (share (value_RData a!14)))))
      (a!29 (g_tt_l2_mem0_1 (globals (share (value_RData a!14)))))
      (a!30 (g_tt_l2_mem1_0 (globals (share (value_RData a!14)))))
      (a!31 (g_tt_l2_mem1_1 (globals (share (value_RData a!14)))))
      (a!32 (g_tt_l2_mem1_2 (globals (share (value_RData a!14)))))
      (a!33 (g_tt_l2_mem1_3 (globals (share (value_RData a!14)))))
      (a!34 (g_tt_l1_upper (globals (share (value_RData a!14)))))
      (a!35 (g_mbedtls_mem_buf (globals (share (value_RData a!14)))))
      (a!36 (g_granules (globals (share (value_RData a!14)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!14)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!14)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!14)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!14)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!14)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!14)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!14)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!14)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!14))))))
(let ((a!38 (store a!36
                   a!37
                   (mks_granule (e_lock (select a!36 a!37))
                                1
                                (e_ref (select a!36 a!37))))))
(let ((a!48 (mkShared (gpt (share (value_RData a!14)))
                      (granule_data (share (value_RData a!14)))
                      (mkGLOBALS a!15
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
                                 a!35
                                 a!38
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46
                                 a!47))))
(let ((a!49 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!14))
                       (oracle (value_RData a!14))
                       (repl (value_RData a!14))
                       (priv (value_RData a!14))
                       a!48
                       (stack (value_RData a!14))
                       (halt (value_RData a!14))))))
  (oracle (value_RData a!49)))))))))))))))))_call| (List_Event) List_Event)
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
 (= ?x5228 5))))))))))))))))))))))))))
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
 (let ((?x29595 (share ?x4559)))
 (let ((?x5308 (granule_data ?x29595)))
 (let ((?x4530 (select ?x5308 ?x1318)))
 (let ((?x5504 (g_granule_state ?x4530)))
 (= ?x5504 3)))))))))))))))))))))))))
(assert
 (let ((?x1089 (test_PA.0_call v_1.0)))
 (let ((?x17296 (meta_granule_offset ?x1089)))
 (let (($x1371 (>= ?x17296 0)))
 (let ((?x1311 (mod ?x17296 4096)))
 (let (($x1370 (= ?x1311 0)))
 (and $x1370 $x1371)))))))
(assert
 (forall ((gidx.2441674 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x4932 (share ?x5393)))
 (let ((?x5395 (globals ?x4932)))
 (let ((?x5402 (g_granules ?x5395)))
 (let ((?x5516 (e_state_s_granule (select ?x5402 gidx.2441674))))
 (let (($x5641 (= ?x5516 6)))
 (let (($x21368 (= ?x5516 0)))
 (=> (not (select (gpt ?x4932) gidx.2441674)) (or $x21368 $x5641)))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2441709 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2441709))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x4932 (share ?x5393)))
 (let ((?x5509 (gpt ?x4932)))
 (select ?x5509 ?x1047)))))))))))))))))))))))))))
 )
(assert
 (let (($x4984 (forall ((gidx.2441897 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x4932 (share ?x5393)))
 (let ((?x5436 (log ?x5393)))
 (let ((?x5539 (|(let ((a!1 (mkPtr "granules"
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
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
  (oracle a!5))))))_call| ?x5436)))
 (let ((?x5179 (|(let ((a!1 (mkPtr "granules"
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
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
  (repl a!5))))))_call| ?x5539 ?x4932)))
 (let ((?x5243 (value_Shared ?x5179)))
 (let ((?x5545 (globals ?x5243)))
 (let ((?x4597 (g_granules ?x5545)))
 (let ((?x5552 (e_state_s_granule (select ?x4597 gidx.2441897))))
 (let (($x5523 (= ?x5552 0)))
 (let (($x5488 (= ?x5552 6)))
 (let ((?x1437 (gpt ?x5243)))
 (let (($x4875 (select ?x1437 gidx.2441897)))
 (or $x4875 $x5488 $x5523))))))))))))))))))))))))))))))))))))
 ))
 (let (($x5724 (forall ((gidx.2441880 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x4932 (share ?x5393)))
 (let ((?x5395 (globals ?x4932)))
 (let ((?x5402 (g_granules ?x5395)))
 (let ((?x5516 (e_state_s_granule (select ?x5402 gidx.2441880))))
 (let (($x21368 (= ?x5516 0)))
 (let (($x5641 (= ?x5516 6)))
 (let ((?x5509 (gpt ?x4932)))
 (let (($x5619 (select ?x5509 gidx.2441880)))
 (or $x5619 $x5641 $x21368))))))))))))))))))))))))))))))))
 ))
 (or (not $x5724) $x4984))))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x4777 (e_3 ?x5675)))
 (let ((?x4839 (* 8 ?x4777)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x5589 (poffset ?x5433)))
 (let ((?x5676 (+ ?x5589 ?x4839)))
 (let ((?x5700 (div ?x5676 4096)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x4932 (share ?x5393)))
 (let ((?x5395 (globals ?x4932)))
 (let ((?x5402 (g_granules ?x5395)))
 (let ((?x5665 (select ?x5402 ?x5700)))
 (let ((?x5301 (e_state_s_granule ?x5665)))
 (= ?x5301 5))))))))))))))))))))))))))))))))))))
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
 (let ((?x29595 (share ?x4559)))
 (let ((?x5308 (granule_data ?x29595)))
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x4932 (share ?x5393)))
 (let ((?x54684 (granule_data ?x4932)))
 (= ?x54684 ?x5308))))))))))))))))))))))))))))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x54651 (e_1 ?x5675)))
 (= ?x54651 3)))))))))))))))))))))))))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x4777 (e_3 ?x5675)))
 (let ((?x4839 (* 8 ?x4777)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x5589 (poffset ?x5433)))
 (let ((?x5676 (+ ?x5589 ?x4839)))
 (let ((?x5811 (mkPtr "granule_data" ?x5676)))
 (let ((?x5711 (abs_tte_read.0_call ?x5811 ?x5393)))
 (let ((?x5422 (meta_mem_attr ?x5711)))
 (let (($x5647 (= ?x5422 0)))
 (let ((?x5244 (meta_ripas ?x5711)))
 (let (($x5058 (= ?x5244 0)))
 (let ((?x5466 (meta_desc_type ?x5711)))
 (let (($x4923 (= ?x5466 0)))
 (and $x4923 $x5058 $x5647))))))))))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2442010 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x54883 (share ?x4990)))
 (let ((?x5646 (globals ?x54883)))
 (let ((?x5851 (g_granules ?x5646)))
 (let ((?x4403 (e_state_s_granule (select ?x5851 gidx.2442010))))
 (let (($x5580 (= ?x4403 6)))
 (let (($x5562 (= ?x4403 0)))
 (=> (not (select (gpt ?x54883) gidx.2442010)) (or $x5562 $x5580)))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2442045 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2442045))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x54883 (share ?x4990)))
 (let ((?x46967 (gpt ?x54883)))
 (select ?x46967 ?x1047)))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x5429 (forall ((gidx.2442233 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x54883 (share ?x4990)))
 (let ((?x38365 (log ?x4990)))
 (let ((?x5044 (|(let ((a!1 (mkPtr "granules"
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
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!5)))
(let ((a!7 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!5))))
  (oracle a!7))))))))_call| ?x38365)))
 (let ((?x5528 (|(let ((a!1 (mkPtr "granules"
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
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!5)))
(let ((a!7 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!5))))
  (repl a!7))))))))_call| ?x5044 ?x54883)))
 (let ((?x5577 (value_Shared ?x5528)))
 (let ((?x5870 (globals ?x5577)))
 (let ((?x47003 (g_granules ?x5870)))
 (let ((?x5772 (e_state_s_granule (select ?x47003 gidx.2442233))))
 (let (($x5725 (= ?x5772 0)))
 (let ((?x38975 (gpt ?x5577)))
 (let (($x5691 (select ?x38975 gidx.2442233)))
 (let (($x5313 (= ?x5772 6)))
 (or $x5313 $x5691 $x5725))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x5464 (forall ((gidx.2442216 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x54883 (share ?x4990)))
 (let ((?x5646 (globals ?x54883)))
 (let ((?x5851 (g_granules ?x5646)))
 (let ((?x4403 (e_state_s_granule (select ?x5851 gidx.2442216))))
 (let (($x5580 (= ?x4403 6)))
 (let (($x5562 (= ?x4403 0)))
 (let ((?x46967 (gpt ?x54883)))
 (let (($x4961 (select ?x46967 gidx.2442216)))
 (or $x4961 $x5562 $x5580))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x5464) $x5429))))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x46330 (div ?x38937 4096)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x54883 (share ?x4990)))
 (let ((?x5646 (globals ?x54883)))
 (let ((?x5851 (g_granules ?x5646)))
 (let ((?x47029 (select ?x5851 ?x46330)))
 (let ((?x5778 (e_state_s_granule ?x47029)))
 (= ?x5778 2))))))))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2442346 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x62858 (share ?x46953)))
 (let ((?x5564 (globals ?x62858)))
 (let ((?x4820 (g_granules ?x5564)))
 (let ((?x5793 (e_state_s_granule (select ?x4820 gidx.2442346))))
 (let (($x6030 (= ?x5793 6)))
 (let (($x5999 (= ?x5793 0)))
 (=> (not (select (gpt ?x62858) gidx.2442346)) (or $x5999 $x6030)))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2442381 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2442381))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x62858 (share ?x46953)))
 (let ((?x5636 (gpt ?x62858)))
 (select ?x5636 ?x1047)))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x47019 (forall ((gidx.2442569 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x62858 (share ?x46953)))
 (let ((?x33255 (log ?x46953)))
 (let ((?x5318 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
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
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!4
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
(let ((a!9 (elem_1 (value_Tuple_bool_RData
                     (memcpy_ns_read_spec.0_call
                       a!1
                       (mkPtr "granule_data" 0)
                       4096
                       a!8)))))
  (oracle a!9)))))))))_call| ?x33255)))
 (let ((?x13941 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
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
(let ((a!6 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!4
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
(let ((a!9 (elem_1 (value_Tuple_bool_RData
                     (memcpy_ns_read_spec.0_call
                       a!1
                       (mkPtr "granule_data" 0)
                       4096
                       a!8)))))
  (repl a!9)))))))))_call| ?x5318 ?x62858)))
 (let ((?x4889 (value_Shared ?x13941)))
 (let ((?x5719 (gpt ?x4889)))
 (let (($x46941 (select ?x5719 gidx.2442569)))
 (let ((?x47108 (e_state_s_granule (select (g_granules (globals ?x4889)) gidx.2442569))))
 (let (($x5862 (= ?x47108 6)))
 (let (($x5805 (= ?x47108 0)))
 (or $x5805 $x5862 $x46941))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x39110 (forall ((gidx.2442552 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x62858 (share ?x46953)))
 (let ((?x5564 (globals ?x62858)))
 (let ((?x4820 (g_granules ?x5564)))
 (let ((?x5793 (e_state_s_granule (select ?x4820 gidx.2442552))))
 (let (($x6030 (= ?x5793 6)))
 (let (($x5999 (= ?x5793 0)))
 (let ((?x5636 (gpt ?x62858)))
 (let (($x5984 (select ?x5636 gidx.2442552)))
 (or $x5984 $x5999 $x6030))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x39110) $x47019))))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let (($x5877 (elem_0 ?x5225)))
 (not $x5877))))))))))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2444082 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x79556 (share ?x63546)))
 (let ((?x6771 (globals ?x79556)))
 (let ((?x45849 (g_granules ?x6771)))
 (let ((?x5843 (e_state_s_granule (select ?x45849 gidx.2444082))))
 (let (($x5794 (= ?x5843 6)))
 (let (($x6215 (= ?x5843 0)))
 (=> (not (select (gpt ?x79556) gidx.2444082)) (or $x6215 $x5794))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2444117 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2444117))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x79556 (share ?x63546)))
 (let ((?x6797 (gpt ?x79556)))
 (select ?x6797 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x6388 (forall ((gidx.2444305 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x79556 (share ?x63546)))
 (let ((?x6293 (log ?x63546)))
 (let ((?x6609 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
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
(let ((a!7 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!5
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
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (oracle (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!10))))))))))))_call| ?x6293)))
 (let ((?x6054 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
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
(let ((a!7 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!5
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
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (repl (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!10))))))))))))_call| ?x6609 ?x79556)))
 (let ((?x1865 (value_Shared ?x6054)))
 (let ((?x6533 (globals ?x1865)))
 (let ((?x5806 (g_granules ?x6533)))
 (let ((?x5795 (e_state_s_granule (select ?x5806 gidx.2444305))))
 (let (($x6294 (= ?x5795 0)))
 (let (($x6194 (= ?x5795 6)))
 (let ((?x48173 (gpt ?x1865)))
 (let (($x5349 (select ?x48173 gidx.2444305)))
 (or $x5349 $x6194 $x6294)))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x6121 (forall ((gidx.2444288 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x79556 (share ?x63546)))
 (let ((?x6797 (gpt ?x79556)))
 (let (($x39720 (select ?x6797 gidx.2444288)))
 (let ((?x5843 (e_state_s_granule (select (g_granules (globals ?x79556)) gidx.2444288))))
 (let (($x6215 (= ?x5843 0)))
 (let (($x5794 (= ?x5843 6)))
 (or $x5794 $x6215 $x39720)))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x6121) $x6388))))
(assert
 (forall ((gidx.2444418 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x95216 (share ?x6150)))
 (let ((?x6199 (globals ?x95216)))
 (let ((?x5918 (g_granules ?x6199)))
 (let ((?x6530 (e_state_s_granule (select ?x5918 gidx.2444418))))
 (let (($x63037 (= ?x6530 6)))
 (let (($x39690 (= ?x6530 0)))
 (=> (not (select (gpt ?x95216) gidx.2444418)) (or $x39690 $x63037))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2444453 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2444453))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x95216 (share ?x6150)))
 (let ((?x6505 (gpt ?x95216)))
 (select ?x6505 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x48318 (forall ((gidx.2444641 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x95216 (share ?x6150)))
 (let ((?x47983 (log ?x6150)))
 (let ((?x53859 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!5)))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!5))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
  (oracle (value_RData a!11)))))))))))_call| ?x47983)))
 (let ((?x39839 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!3
                       0
                       64
                       v_2.0
                       3
                       a!4)))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             a!5)))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!5))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
  (repl (value_RData a!11)))))))))))_call| ?x53859 ?x95216)))
 (let ((?x39391 (value_Shared ?x39839)))
 (let ((?x6397 (globals ?x39391)))
 (let ((?x6592 (g_granules ?x6397)))
 (let ((?x5867 (e_state_s_granule (select ?x6592 gidx.2444641))))
 (let (($x47595 (= ?x5867 0)))
 (let (($x39633 (= ?x5867 6)))
 (let ((?x5145 (gpt ?x39391)))
 (let (($x6529 (select ?x5145 gidx.2444641)))
 (or $x6529 $x39633 $x47595)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x6458 (forall ((gidx.2444624 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x95216 (share ?x6150)))
 (let ((?x6199 (globals ?x95216)))
 (let ((?x5918 (g_granules ?x6199)))
 (let ((?x6530 (e_state_s_granule (select ?x5918 gidx.2444624))))
 (let (($x63037 (= ?x6530 6)))
 (let ((?x6505 (gpt ?x95216)))
 (let (($x39940 (select ?x6505 gidx.2444624)))
 (let (($x39690 (= ?x6530 0)))
 (or $x39690 $x39940 $x63037)))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x6458) $x48318))))
(assert
 (forall ((gidx.2444754 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x103049 (share ?x63663)))
 (let ((?x47516 (globals ?x103049)))
 (let ((?x40102 (g_granules ?x47516)))
 (let ((?x6799 (e_state_s_granule (select ?x40102 gidx.2444754))))
 (let (($x6444 (= ?x6799 6)))
 (let (($x6784 (= ?x6799 0)))
 (=> (not (select (gpt ?x103049) gidx.2444754)) (or $x6784 $x6444))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2444789 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2444789))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x103049 (share ?x63663)))
 (let ((?x48261 (gpt ?x103049)))
 (select ?x48261 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x6785 (forall ((gidx.2444977 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x103049 (share ?x63663)))
 (let ((?x39531 (log ?x63663)))
 (let ((?x5758 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!4))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!5))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          (elem_1 a!5)))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
(let ((a!12 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!11)))))
  (oracle a!12)))))))))))_call| ?x39531)))
 (let ((?x79837 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!4))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!5))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          (elem_1 a!5)))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
(let ((a!12 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!11)))))
  (repl a!12)))))))))))_call| ?x5758 ?x103049)))
 (let ((?x79695 (value_Shared ?x79837)))
 (let ((?x6156 (globals ?x79695)))
 (let ((?x5499 (g_granules ?x6156)))
 (let ((?x6479 (e_state_s_granule (select ?x5499 gidx.2444977))))
 (let (($x47703 (= ?x6479 6)))
 (let (($x39419 (= ?x6479 0)))
 (let ((?x6550 (gpt ?x79695)))
 (let (($x5437 (select ?x6550 gidx.2444977)))
 (or $x5437 $x39419 $x47703)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x6306 (forall ((gidx.2444960 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x103049 (share ?x63663)))
 (let ((?x47516 (globals ?x103049)))
 (let ((?x40102 (g_granules ?x47516)))
 (let ((?x6799 (e_state_s_granule (select ?x40102 gidx.2444960))))
 (let (($x6784 (= ?x6799 0)))
 (let (($x6444 (= ?x6799 6)))
 (let ((?x48261 (gpt ?x103049)))
 (let (($x6134 (select ?x48261 gidx.2444960)))
 (or $x6134 $x6444 $x6784)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x6306) $x6785))))
(assert
 (let ((?x73347 (make_return_code_para.0_call 1)))
 (let ((?x26393 (pack_struct_return_code_para.0_call ?x73347)))
 (let (($x2640 (= ?x26393 0)))
 (not $x2640)))))
(assert
 (forall ((gidx.2445818 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x86683 (granule_unlock_spec.0_call ?x1244 ?x63663)))
 (let ((?x5284 (value_RData ?x86683)))
 (let ((?x110901 (share ?x5284)))
 (let ((?x64040 (globals ?x110901)))
 (let ((?x48392 (g_granules ?x64040)))
 (let ((?x7022 (e_state_s_granule (select ?x48392 gidx.2445818))))
 (let (($x7005 (= ?x7022 6)))
 (let (($x47470 (= ?x7022 0)))
 (let ((?x79923 (gpt ?x110901)))
 (let (($x6548 (select ?x79923 gidx.2445818)))
 (let (($x5697 (not $x6548)))
 (=> $x5697 (or $x47470 $x7005)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2445853 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2445853))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x86683 (granule_unlock_spec.0_call ?x1244 ?x63663)))
 (let ((?x5284 (value_RData ?x86683)))
 (let ((?x110901 (share ?x5284)))
 (let ((?x79923 (gpt ?x110901)))
 (select ?x79923 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x79696 (forall ((gidx.2446041 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x86683 (granule_unlock_spec.0_call ?x1244 ?x63663)))
 (let ((?x5284 (value_RData ?x86683)))
 (let ((?x110901 (share ?x5284)))
 (let ((?x6297 (log ?x5284)))
 (let ((?x7031 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!4))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!5))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          (elem_1 a!5)))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
(let ((a!12 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!12)))
  (oracle (value_RData a!13)))))))))))))_call| ?x6297)))
 (let ((?x6970 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045))))))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData (spinlock_acquire_spec.0_call a!1 st.0)))))
(let ((a!3 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (value_RData a!2))))
(let ((a!4 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!3) (poffset a!3))
                          (value_RData a!2)))))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!3
               0
               64
               v_2.0
               3
               a!4))))
(let ((a!6 (rec_to_rd_para.0_call
             (mkPtr "granule_data" (meta_granule_offset (test_PA.0_call v_1.0)))
             (elem_1 a!5))))
(let ((a!9 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          (elem_1 a!5)))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
(let ((a!11 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!10))))))
(let ((a!12 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!12)))
  (repl (value_RData a!13)))))))))))))_call| ?x7031 ?x110901)))
 (let ((?x6427 (value_Shared ?x6970)))
 (let ((?x6935 (globals ?x6427)))
 (let ((?x6572 (g_granules ?x6935)))
 (let ((?x6428 (e_state_s_granule (select ?x6572 gidx.2446041))))
 (let (($x7009 (= ?x6428 0)))
 (let ((?x6893 (gpt ?x6427)))
 (let (($x6302 (select ?x6893 gidx.2446041)))
 (let (($x6002 (= ?x6428 6)))
 (or $x6002 $x6302 $x7009)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x6878 (forall ((gidx.2446024 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x86683 (granule_unlock_spec.0_call ?x1244 ?x63663)))
 (let ((?x5284 (value_RData ?x86683)))
 (let ((?x110901 (share ?x5284)))
 (let ((?x64040 (globals ?x110901)))
 (let ((?x48392 (g_granules ?x64040)))
 (let ((?x7022 (e_state_s_granule (select ?x48392 gidx.2446024))))
 (let (($x47470 (= ?x7022 0)))
 (let (($x7005 (= ?x7022 6)))
 (let ((?x79923 (gpt ?x110901)))
 (let (($x6548 (select ?x79923 gidx.2446024)))
 (or $x6548 $x7005 $x47470)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x6878) $x79696))))
(assert
 (let ((?x7355 (test_Z_PTE.0_call v_0.2445853)))
 (let ((?x7282 (meta_PA ?x7355)))
 (let ((?x7220 (meta_granule_offset ?x7282)))
 (let (($x6516 (>= ?x7220 0)))
 (let ((?x6961 (mod ?x7220 4096)))
 (let (($x6882 (= ?x6961 0)))
 (and $x6882 $x6516))))))))
(assert
 (forall ((gidx.2446154 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x86683 (granule_unlock_spec.0_call ?x1244 ?x63663)))
 (let ((?x5284 (value_RData ?x86683)))
 (let (($x6666 (halt ?x5284)))
 (let ((?x6864 (stack ?x5284)))
 (let ((?x110901 (share ?x5284)))
 (let ((?x64040 (globals ?x110901)))
 (let ((?x6868 (g_realm_attest_private_key ?x64040)))
 (let ((?x6733 (g_get_realm_identity_identity ?x64040)))
 (let ((?x48308 (g_rmm_platform_token ?x64040)))
 (let ((?x40398 (g_platform_token_buf ?x64040)))
 (let ((?x38917 (g_rmm_attest_public_key_hash_len ?x64040)))
 (let ((?x6718 (g_rmm_attest_public_key_hash ?x64040)))
 (let ((?x6818 (g_rmm_attest_public_key_len ?x64040)))
 (let ((?x6883 (g_rmm_attest_public_key ?x64040)))
 (let ((?x6744 (g_rmm_attest_signing_key ?x64040)))
 (let ((?x7355 (test_Z_PTE.0_call v_0.2445853)))
 (let ((?x7282 (meta_PA ?x7355)))
 (let ((?x7220 (meta_granule_offset ?x7282)))
 (let ((?x7377 (div ?x7220 4096)))
 (let ((?x48392 (g_granules ?x64040)))
 (let ((?x6255 (select ?x48392 ?x7377)))
 (let ((?x47980 (mks_granule (e_lock ?x6255) 1 (e_ref ?x6255))))
 (let ((?x7634 (store ?x48392 ?x7377 ?x47980)))
 (let ((?x47057 (g_mbedtls_mem_buf ?x64040)))
 (let ((?x40404 (g_tt_l1_upper ?x64040)))
 (let ((?x7086 (g_tt_l2_mem1_3 ?x64040)))
 (let ((?x22346 (g_tt_l2_mem1_2 ?x64040)))
 (let ((?x6837 (g_tt_l2_mem1_1 ?x64040)))
 (let ((?x6499 (g_tt_l2_mem1_0 ?x64040)))
 (let ((?x6618 (g_tt_l2_mem0_1 ?x64040)))
 (let ((?x7092 (g_tt_l2_mem0_0 ?x64040)))
 (let ((?x6323 (g_tt_l3_buffer ?x64040)))
 (let ((?x6344 (g_rmm_trap_list ?x64040)))
 (let ((?x64228 (g_status_handler ?x64040)))
 (let ((?x7140 (g_default_gicstate ?x64040)))
 (let ((?x6589 (g_pri_res0_mask ?x64040)))
 (let ((?x48566 (g_max_vintid ?x64040)))
 (let ((?x44554 (g_nr_aprs ?x64040)))
 (let ((?x40566 (g_nr_lrs ?x64040)))
 (let ((?x48590 (g_vmids ?x64040)))
 (let ((?x39778 (g_vmid_lock ?x64040)))
 (let ((?x48445 (g_vmid_count ?x64040)))
 (let ((?x48518 (g_debug_exits ?x64040)))
 (let ((?x48611 (g_heap ?x64040)))
 (let ((?x48868 (mkGLOBALS ?x48611 ?x48518 ?x48445 ?x39778 ?x48590 ?x40566 ?x44554 ?x48566 ?x6589 ?x7140 ?x64228 ?x6344 ?x6323 ?x7092 ?x6618 ?x6499 ?x6837 ?x22346 ?x7086 ?x40404 ?x47057 ?x7634 ?x6744 ?x6883 ?x6818 ?x6718 ?x38917 ?x40398 ?x48308 ?x6733 ?x6868)))
 (let ((?x31217 (granule_data ?x110901)))
 (let ((?x79923 (gpt ?x110901)))
 (let ((?x7004 (priv ?x5284)))
 (let ((?x7032 (repl ?x5284)))
 (let ((?x7000 (oracle ?x5284)))
 (let ((?x6297 (log ?x5284)))
 (let ((?x6859 (mkRData ?x6297 ?x7000 ?x7032 ?x7004 (mkShared ?x79923 ?x31217 ?x48868) ?x6864 $x6666)))
 (let ((?x119237 (mkPtr "granules" ?x7220)))
 (let ((?x6980 (granule_unlock_spec.0_call ?x119237 ?x6859)))
 (let ((?x48852 (value_RData ?x6980)))
 (let ((?x119392 (share ?x48852)))
 (let ((?x6703 (globals ?x119392)))
 (let ((?x7025 (g_granules ?x6703)))
 (let ((?x49059 (e_state_s_granule (select ?x7025 gidx.2446154))))
 (let (($x7472 (= ?x49059 6)))
 (let (($x64583 (= ?x49059 0)))
 (=> (not (select (gpt ?x119392) gidx.2446154)) (or $x64583 $x7472)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2446189 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2446189))) 4096)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x86683 (granule_unlock_spec.0_call ?x1244 ?x63663)))
 (let ((?x5284 (value_RData ?x86683)))
 (let (($x6666 (halt ?x5284)))
 (let ((?x6864 (stack ?x5284)))
 (let ((?x110901 (share ?x5284)))
 (let ((?x64040 (globals ?x110901)))
 (let ((?x6868 (g_realm_attest_private_key ?x64040)))
 (let ((?x6733 (g_get_realm_identity_identity ?x64040)))
 (let ((?x48308 (g_rmm_platform_token ?x64040)))
 (let ((?x40398 (g_platform_token_buf ?x64040)))
 (let ((?x38917 (g_rmm_attest_public_key_hash_len ?x64040)))
 (let ((?x6718 (g_rmm_attest_public_key_hash ?x64040)))
 (let ((?x6818 (g_rmm_attest_public_key_len ?x64040)))
 (let ((?x6883 (g_rmm_attest_public_key ?x64040)))
 (let ((?x6744 (g_rmm_attest_signing_key ?x64040)))
 (let ((?x7355 (test_Z_PTE.0_call v_0.2445853)))
 (let ((?x7282 (meta_PA ?x7355)))
 (let ((?x7220 (meta_granule_offset ?x7282)))
 (let ((?x7377 (div ?x7220 4096)))
 (let ((?x48392 (g_granules ?x64040)))
 (let ((?x6255 (select ?x48392 ?x7377)))
 (let ((?x47980 (mks_granule (e_lock ?x6255) 1 (e_ref ?x6255))))
 (let ((?x7634 (store ?x48392 ?x7377 ?x47980)))
 (let ((?x47057 (g_mbedtls_mem_buf ?x64040)))
 (let ((?x40404 (g_tt_l1_upper ?x64040)))
 (let ((?x7086 (g_tt_l2_mem1_3 ?x64040)))
 (let ((?x22346 (g_tt_l2_mem1_2 ?x64040)))
 (let ((?x6837 (g_tt_l2_mem1_1 ?x64040)))
 (let ((?x6499 (g_tt_l2_mem1_0 ?x64040)))
 (let ((?x6618 (g_tt_l2_mem0_1 ?x64040)))
 (let ((?x7092 (g_tt_l2_mem0_0 ?x64040)))
 (let ((?x6323 (g_tt_l3_buffer ?x64040)))
 (let ((?x6344 (g_rmm_trap_list ?x64040)))
 (let ((?x64228 (g_status_handler ?x64040)))
 (let ((?x7140 (g_default_gicstate ?x64040)))
 (let ((?x6589 (g_pri_res0_mask ?x64040)))
 (let ((?x48566 (g_max_vintid ?x64040)))
 (let ((?x44554 (g_nr_aprs ?x64040)))
 (let ((?x40566 (g_nr_lrs ?x64040)))
 (let ((?x48590 (g_vmids ?x64040)))
 (let ((?x39778 (g_vmid_lock ?x64040)))
 (let ((?x48445 (g_vmid_count ?x64040)))
 (let ((?x48518 (g_debug_exits ?x64040)))
 (let ((?x48611 (g_heap ?x64040)))
 (let ((?x48868 (mkGLOBALS ?x48611 ?x48518 ?x48445 ?x39778 ?x48590 ?x40566 ?x44554 ?x48566 ?x6589 ?x7140 ?x64228 ?x6344 ?x6323 ?x7092 ?x6618 ?x6499 ?x6837 ?x22346 ?x7086 ?x40404 ?x47057 ?x7634 ?x6744 ?x6883 ?x6818 ?x6718 ?x38917 ?x40398 ?x48308 ?x6733 ?x6868)))
 (let ((?x31217 (granule_data ?x110901)))
 (let ((?x79923 (gpt ?x110901)))
 (let ((?x7004 (priv ?x5284)))
 (let ((?x7032 (repl ?x5284)))
 (let ((?x7000 (oracle ?x5284)))
 (let ((?x6297 (log ?x5284)))
 (let ((?x6859 (mkRData ?x6297 ?x7000 ?x7032 ?x7004 (mkShared ?x79923 ?x31217 ?x48868) ?x6864 $x6666)))
 (let ((?x119237 (mkPtr "granules" ?x7220)))
 (let ((?x6980 (granule_unlock_spec.0_call ?x119237 ?x6859)))
 (let ((?x48852 (value_RData ?x6980)))
 (let ((?x119392 (share ?x48852)))
 (let ((?x7310 (gpt ?x119392)))
 (select ?x7310 ?x1047)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x7163 (forall ((gidx.2446377 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x86683 (granule_unlock_spec.0_call ?x1244 ?x63663)))
 (let ((?x5284 (value_RData ?x86683)))
 (let (($x6666 (halt ?x5284)))
 (let ((?x6864 (stack ?x5284)))
 (let ((?x110901 (share ?x5284)))
 (let ((?x64040 (globals ?x110901)))
 (let ((?x6868 (g_realm_attest_private_key ?x64040)))
 (let ((?x6733 (g_get_realm_identity_identity ?x64040)))
 (let ((?x48308 (g_rmm_platform_token ?x64040)))
 (let ((?x40398 (g_platform_token_buf ?x64040)))
 (let ((?x38917 (g_rmm_attest_public_key_hash_len ?x64040)))
 (let ((?x6718 (g_rmm_attest_public_key_hash ?x64040)))
 (let ((?x6818 (g_rmm_attest_public_key_len ?x64040)))
 (let ((?x6883 (g_rmm_attest_public_key ?x64040)))
 (let ((?x6744 (g_rmm_attest_signing_key ?x64040)))
 (let ((?x7355 (test_Z_PTE.0_call v_0.2445853)))
 (let ((?x7282 (meta_PA ?x7355)))
 (let ((?x7220 (meta_granule_offset ?x7282)))
 (let ((?x7377 (div ?x7220 4096)))
 (let ((?x48392 (g_granules ?x64040)))
 (let ((?x6255 (select ?x48392 ?x7377)))
 (let ((?x47980 (mks_granule (e_lock ?x6255) 1 (e_ref ?x6255))))
 (let ((?x7634 (store ?x48392 ?x7377 ?x47980)))
 (let ((?x47057 (g_mbedtls_mem_buf ?x64040)))
 (let ((?x40404 (g_tt_l1_upper ?x64040)))
 (let ((?x7086 (g_tt_l2_mem1_3 ?x64040)))
 (let ((?x22346 (g_tt_l2_mem1_2 ?x64040)))
 (let ((?x6837 (g_tt_l2_mem1_1 ?x64040)))
 (let ((?x6499 (g_tt_l2_mem1_0 ?x64040)))
 (let ((?x6618 (g_tt_l2_mem0_1 ?x64040)))
 (let ((?x7092 (g_tt_l2_mem0_0 ?x64040)))
 (let ((?x6323 (g_tt_l3_buffer ?x64040)))
 (let ((?x6344 (g_rmm_trap_list ?x64040)))
 (let ((?x64228 (g_status_handler ?x64040)))
 (let ((?x7140 (g_default_gicstate ?x64040)))
 (let ((?x6589 (g_pri_res0_mask ?x64040)))
 (let ((?x48566 (g_max_vintid ?x64040)))
 (let ((?x44554 (g_nr_aprs ?x64040)))
 (let ((?x40566 (g_nr_lrs ?x64040)))
 (let ((?x48590 (g_vmids ?x64040)))
 (let ((?x39778 (g_vmid_lock ?x64040)))
 (let ((?x48445 (g_vmid_count ?x64040)))
 (let ((?x48518 (g_debug_exits ?x64040)))
 (let ((?x48611 (g_heap ?x64040)))
 (let ((?x48868 (mkGLOBALS ?x48611 ?x48518 ?x48445 ?x39778 ?x48590 ?x40566 ?x44554 ?x48566 ?x6589 ?x7140 ?x64228 ?x6344 ?x6323 ?x7092 ?x6618 ?x6499 ?x6837 ?x22346 ?x7086 ?x40404 ?x47057 ?x7634 ?x6744 ?x6883 ?x6818 ?x6718 ?x38917 ?x40398 ?x48308 ?x6733 ?x6868)))
 (let ((?x31217 (granule_data ?x110901)))
 (let ((?x79923 (gpt ?x110901)))
 (let ((?x7004 (priv ?x5284)))
 (let ((?x7032 (repl ?x5284)))
 (let ((?x7000 (oracle ?x5284)))
 (let ((?x6297 (log ?x5284)))
 (let ((?x6859 (mkRData ?x6297 ?x7000 ?x7032 ?x7004 (mkShared ?x79923 ?x31217 ?x48868) ?x6864 $x6666)))
 (let ((?x119237 (mkPtr "granules" ?x7220)))
 (let ((?x6980 (granule_unlock_spec.0_call ?x119237 ?x6859)))
 (let ((?x48852 (value_RData ?x6980)))
 (let ((?x119392 (share ?x48852)))
 (let ((?x6612 (log ?x48852)))
 (let ((?x88157 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2445853)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
      (a!37 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2445853)))
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
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!4
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
(let ((a!15 (g_heap (globals (share (value_RData a!14)))))
      (a!16 (g_debug_exits (globals (share (value_RData a!14)))))
      (a!17 (g_vmid_count (globals (share (value_RData a!14)))))
      (a!18 (g_vmid_lock (globals (share (value_RData a!14)))))
      (a!19 (g_vmids (globals (share (value_RData a!14)))))
      (a!20 (g_nr_lrs (globals (share (value_RData a!14)))))
      (a!21 (g_nr_aprs (globals (share (value_RData a!14)))))
      (a!22 (g_max_vintid (globals (share (value_RData a!14)))))
      (a!23 (g_pri_res0_mask (globals (share (value_RData a!14)))))
      (a!24 (g_default_gicstate (globals (share (value_RData a!14)))))
      (a!25 (g_status_handler (globals (share (value_RData a!14)))))
      (a!26 (g_rmm_trap_list (globals (share (value_RData a!14)))))
      (a!27 (g_tt_l3_buffer (globals (share (value_RData a!14)))))
      (a!28 (g_tt_l2_mem0_0 (globals (share (value_RData a!14)))))
      (a!29 (g_tt_l2_mem0_1 (globals (share (value_RData a!14)))))
      (a!30 (g_tt_l2_mem1_0 (globals (share (value_RData a!14)))))
      (a!31 (g_tt_l2_mem1_1 (globals (share (value_RData a!14)))))
      (a!32 (g_tt_l2_mem1_2 (globals (share (value_RData a!14)))))
      (a!33 (g_tt_l2_mem1_3 (globals (share (value_RData a!14)))))
      (a!34 (g_tt_l1_upper (globals (share (value_RData a!14)))))
      (a!35 (g_mbedtls_mem_buf (globals (share (value_RData a!14)))))
      (a!36 (g_granules (globals (share (value_RData a!14)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!14)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!14)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!14)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!14)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!14)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!14)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!14)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!14)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!14))))))
(let ((a!38 (store a!36
                   a!37
                   (mks_granule (e_lock (select a!36 a!37))
                                1
                                (e_ref (select a!36 a!37))))))
(let ((a!48 (mkShared (gpt (share (value_RData a!14)))
                      (granule_data (share (value_RData a!14)))
                      (mkGLOBALS a!15
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
                                 a!35
                                 a!38
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46
                                 a!47))))
(let ((a!49 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!14))
                       (oracle (value_RData a!14))
                       (repl (value_RData a!14))
                       (priv (value_RData a!14))
                       a!48
                       (stack (value_RData a!14))
                       (halt (value_RData a!14))))))
  (oracle (value_RData a!49)))))))))))))))))_call| ?x6612)))
 (let ((?x7502 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2445853)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442381)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2442045)))))
      (a!37 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2445853)))
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
(let ((a!6 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!4
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
(let ((a!15 (g_heap (globals (share (value_RData a!14)))))
      (a!16 (g_debug_exits (globals (share (value_RData a!14)))))
      (a!17 (g_vmid_count (globals (share (value_RData a!14)))))
      (a!18 (g_vmid_lock (globals (share (value_RData a!14)))))
      (a!19 (g_vmids (globals (share (value_RData a!14)))))
      (a!20 (g_nr_lrs (globals (share (value_RData a!14)))))
      (a!21 (g_nr_aprs (globals (share (value_RData a!14)))))
      (a!22 (g_max_vintid (globals (share (value_RData a!14)))))
      (a!23 (g_pri_res0_mask (globals (share (value_RData a!14)))))
      (a!24 (g_default_gicstate (globals (share (value_RData a!14)))))
      (a!25 (g_status_handler (globals (share (value_RData a!14)))))
      (a!26 (g_rmm_trap_list (globals (share (value_RData a!14)))))
      (a!27 (g_tt_l3_buffer (globals (share (value_RData a!14)))))
      (a!28 (g_tt_l2_mem0_0 (globals (share (value_RData a!14)))))
      (a!29 (g_tt_l2_mem0_1 (globals (share (value_RData a!14)))))
      (a!30 (g_tt_l2_mem1_0 (globals (share (value_RData a!14)))))
      (a!31 (g_tt_l2_mem1_1 (globals (share (value_RData a!14)))))
      (a!32 (g_tt_l2_mem1_2 (globals (share (value_RData a!14)))))
      (a!33 (g_tt_l2_mem1_3 (globals (share (value_RData a!14)))))
      (a!34 (g_tt_l1_upper (globals (share (value_RData a!14)))))
      (a!35 (g_mbedtls_mem_buf (globals (share (value_RData a!14)))))
      (a!36 (g_granules (globals (share (value_RData a!14)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!14)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!14)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!14)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!14)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!14)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!14)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!14)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!14)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!14))))))
(let ((a!38 (store a!36
                   a!37
                   (mks_granule (e_lock (select a!36 a!37))
                                1
                                (e_ref (select a!36 a!37))))))
(let ((a!48 (mkShared (gpt (share (value_RData a!14)))
                      (granule_data (share (value_RData a!14)))
                      (mkGLOBALS a!15
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
                                 a!35
                                 a!38
                                 a!39
                                 a!40
                                 a!41
                                 a!42
                                 a!43
                                 a!44
                                 a!45
                                 a!46
                                 a!47))))
(let ((a!49 (granule_unlock_spec.0_call
              a!1
              (mkRData (log (value_RData a!14))
                       (oracle (value_RData a!14))
                       (repl (value_RData a!14))
                       (priv (value_RData a!14))
                       a!48
                       (stack (value_RData a!14))
                       (halt (value_RData a!14))))))
  (repl (value_RData a!49)))))))))))))))))_call| ?x88157 ?x119392)))
 (let ((?x6750 (value_Shared ?x7502)))
 (let ((?x6562 (globals ?x6750)))
 (let ((?x6795 (g_granules ?x6562)))
 (let ((?x87921 (e_state_s_granule (select ?x6795 gidx.2446377))))
 (let (($x79849 (= ?x87921 6)))
 (let (($x6680 (= ?x87921 0)))
 (let ((?x48963 (gpt ?x6750)))
 (let (($x6633 (select ?x48963 gidx.2446377)))
 (or $x6633 $x6680 $x79849))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x7341 (forall ((gidx.2446360 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x86683 (granule_unlock_spec.0_call ?x1244 ?x63663)))
 (let ((?x5284 (value_RData ?x86683)))
 (let (($x6666 (halt ?x5284)))
 (let ((?x6864 (stack ?x5284)))
 (let ((?x110901 (share ?x5284)))
 (let ((?x64040 (globals ?x110901)))
 (let ((?x6868 (g_realm_attest_private_key ?x64040)))
 (let ((?x6733 (g_get_realm_identity_identity ?x64040)))
 (let ((?x48308 (g_rmm_platform_token ?x64040)))
 (let ((?x40398 (g_platform_token_buf ?x64040)))
 (let ((?x38917 (g_rmm_attest_public_key_hash_len ?x64040)))
 (let ((?x6718 (g_rmm_attest_public_key_hash ?x64040)))
 (let ((?x6818 (g_rmm_attest_public_key_len ?x64040)))
 (let ((?x6883 (g_rmm_attest_public_key ?x64040)))
 (let ((?x6744 (g_rmm_attest_signing_key ?x64040)))
 (let ((?x7355 (test_Z_PTE.0_call v_0.2445853)))
 (let ((?x7282 (meta_PA ?x7355)))
 (let ((?x7220 (meta_granule_offset ?x7282)))
 (let ((?x7377 (div ?x7220 4096)))
 (let ((?x48392 (g_granules ?x64040)))
 (let ((?x6255 (select ?x48392 ?x7377)))
 (let ((?x47980 (mks_granule (e_lock ?x6255) 1 (e_ref ?x6255))))
 (let ((?x7634 (store ?x48392 ?x7377 ?x47980)))
 (let ((?x47057 (g_mbedtls_mem_buf ?x64040)))
 (let ((?x40404 (g_tt_l1_upper ?x64040)))
 (let ((?x7086 (g_tt_l2_mem1_3 ?x64040)))
 (let ((?x22346 (g_tt_l2_mem1_2 ?x64040)))
 (let ((?x6837 (g_tt_l2_mem1_1 ?x64040)))
 (let ((?x6499 (g_tt_l2_mem1_0 ?x64040)))
 (let ((?x6618 (g_tt_l2_mem0_1 ?x64040)))
 (let ((?x7092 (g_tt_l2_mem0_0 ?x64040)))
 (let ((?x6323 (g_tt_l3_buffer ?x64040)))
 (let ((?x6344 (g_rmm_trap_list ?x64040)))
 (let ((?x64228 (g_status_handler ?x64040)))
 (let ((?x7140 (g_default_gicstate ?x64040)))
 (let ((?x6589 (g_pri_res0_mask ?x64040)))
 (let ((?x48566 (g_max_vintid ?x64040)))
 (let ((?x44554 (g_nr_aprs ?x64040)))
 (let ((?x40566 (g_nr_lrs ?x64040)))
 (let ((?x48590 (g_vmids ?x64040)))
 (let ((?x39778 (g_vmid_lock ?x64040)))
 (let ((?x48445 (g_vmid_count ?x64040)))
 (let ((?x48518 (g_debug_exits ?x64040)))
 (let ((?x48611 (g_heap ?x64040)))
 (let ((?x48868 (mkGLOBALS ?x48611 ?x48518 ?x48445 ?x39778 ?x48590 ?x40566 ?x44554 ?x48566 ?x6589 ?x7140 ?x64228 ?x6344 ?x6323 ?x7092 ?x6618 ?x6499 ?x6837 ?x22346 ?x7086 ?x40404 ?x47057 ?x7634 ?x6744 ?x6883 ?x6818 ?x6718 ?x38917 ?x40398 ?x48308 ?x6733 ?x6868)))
 (let ((?x31217 (granule_data ?x110901)))
 (let ((?x79923 (gpt ?x110901)))
 (let ((?x7004 (priv ?x5284)))
 (let ((?x7032 (repl ?x5284)))
 (let ((?x7000 (oracle ?x5284)))
 (let ((?x6297 (log ?x5284)))
 (let ((?x6859 (mkRData ?x6297 ?x7000 ?x7032 ?x7004 (mkShared ?x79923 ?x31217 ?x48868) ?x6864 $x6666)))
 (let ((?x119237 (mkPtr "granules" ?x7220)))
 (let ((?x6980 (granule_unlock_spec.0_call ?x119237 ?x6859)))
 (let ((?x48852 (value_RData ?x6980)))
 (let ((?x119392 (share ?x48852)))
 (let ((?x7310 (gpt ?x119392)))
 (let (($x87722 (select ?x7310 gidx.2446360)))
 (let ((?x49059 (e_state_s_granule (select (g_granules (globals ?x119392)) gidx.2446360))))
 (let (($x64583 (= ?x49059 0)))
 (let (($x7472 (= ?x49059 6)))
 (or $x7472 $x64583 $x87722))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x7341) $x7163))))
(assert
 (let (($x7182 (forall ((gidx.2446436 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x845 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x5245 (rtt_walk_lock_unlock_spec_abs.0_call ?x845 ?x5237 0 64 v_2.0 3 ?x4559)))
 (let ((?x5113 (value_Tuple_abs_ret_rtt_RData ?x5245)))
 (let ((?x5393 (elem_1 ?x5113)))
 (let ((?x5637 (rec_to_rd_para.0_call ?x5343 ?x5393)))
 (let ((?x38937 (poffset ?x5637)))
 (let ((?x38872 (pbase ?x5637)))
 (let ((?x5624 (mkPtr ?x38872 ?x38937)))
 (let ((?x1466 (spinlock_acquire_spec.0_call ?x5624 ?x5393)))
 (let ((?x4990 (value_RData ?x1466)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x5847 (test_Z_PTE.0_call v_0.2442045)))
 (let ((?x39173 (meta_PA ?x5847)))
 (let ((?x5353 (meta_granule_offset ?x39173)))
 (let ((?x29388 (mkPtr "granule_data" ?x5353)))
 (let ((?x5548 (memcpy_ns_read_spec.0_call ?x29388 ?x1721 4096 ?x4990)))
 (let ((?x5225 (value_Tuple_bool_RData ?x5548)))
 (let ((?x46953 (elem_1 ?x5225)))
 (let ((?x5801 (test_Z_PTE.0_call v_0.2442381)))
 (let ((?x46891 (meta_PA ?x5801)))
 (let ((?x5894 (meta_granule_offset ?x46891)))
 (let ((?x114757 (mkPtr "granule_data" ?x5894)))
 (let ((?x40065 (memset_spec.0_call ?x114757 0 4096 ?x46953)))
 (let ((?x55902 (value_Tuple_Ptr_RData ?x40065)))
 (let ((?x63546 (elem_1 ?x55902)))
 (let ((?x6561 (granule_unlock_spec.0_call ?x5637 ?x63546)))
 (let ((?x6150 (value_RData ?x6561)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x40165 (granule_unlock_spec.0_call ?x5433 ?x6150)))
 (let ((?x63663 (value_RData ?x40165)))
 (let ((?x86683 (granule_unlock_spec.0_call ?x1244 ?x63663)))
 (let ((?x5284 (value_RData ?x86683)))
 (let (($x6666 (halt ?x5284)))
 (let ((?x6864 (stack ?x5284)))
 (let ((?x110901 (share ?x5284)))
 (let ((?x64040 (globals ?x110901)))
 (let ((?x6868 (g_realm_attest_private_key ?x64040)))
 (let ((?x6733 (g_get_realm_identity_identity ?x64040)))
 (let ((?x48308 (g_rmm_platform_token ?x64040)))
 (let ((?x40398 (g_platform_token_buf ?x64040)))
 (let ((?x38917 (g_rmm_attest_public_key_hash_len ?x64040)))
 (let ((?x6718 (g_rmm_attest_public_key_hash ?x64040)))
 (let ((?x6818 (g_rmm_attest_public_key_len ?x64040)))
 (let ((?x6883 (g_rmm_attest_public_key ?x64040)))
 (let ((?x6744 (g_rmm_attest_signing_key ?x64040)))
 (let ((?x7355 (test_Z_PTE.0_call v_0.2445853)))
 (let ((?x7282 (meta_PA ?x7355)))
 (let ((?x7220 (meta_granule_offset ?x7282)))
 (let ((?x7377 (div ?x7220 4096)))
 (let ((?x48392 (g_granules ?x64040)))
 (let ((?x6255 (select ?x48392 ?x7377)))
 (let ((?x47980 (mks_granule (e_lock ?x6255) 1 (e_ref ?x6255))))
 (let ((?x7634 (store ?x48392 ?x7377 ?x47980)))
 (let ((?x47057 (g_mbedtls_mem_buf ?x64040)))
 (let ((?x40404 (g_tt_l1_upper ?x64040)))
 (let ((?x7086 (g_tt_l2_mem1_3 ?x64040)))
 (let ((?x22346 (g_tt_l2_mem1_2 ?x64040)))
 (let ((?x6837 (g_tt_l2_mem1_1 ?x64040)))
 (let ((?x6499 (g_tt_l2_mem1_0 ?x64040)))
 (let ((?x6618 (g_tt_l2_mem0_1 ?x64040)))
 (let ((?x7092 (g_tt_l2_mem0_0 ?x64040)))
 (let ((?x6323 (g_tt_l3_buffer ?x64040)))
 (let ((?x6344 (g_rmm_trap_list ?x64040)))
 (let ((?x64228 (g_status_handler ?x64040)))
 (let ((?x7140 (g_default_gicstate ?x64040)))
 (let ((?x6589 (g_pri_res0_mask ?x64040)))
 (let ((?x48566 (g_max_vintid ?x64040)))
 (let ((?x44554 (g_nr_aprs ?x64040)))
 (let ((?x40566 (g_nr_lrs ?x64040)))
 (let ((?x48590 (g_vmids ?x64040)))
 (let ((?x39778 (g_vmid_lock ?x64040)))
 (let ((?x48445 (g_vmid_count ?x64040)))
 (let ((?x48518 (g_debug_exits ?x64040)))
 (let ((?x48611 (g_heap ?x64040)))
 (let ((?x48868 (mkGLOBALS ?x48611 ?x48518 ?x48445 ?x39778 ?x48590 ?x40566 ?x44554 ?x48566 ?x6589 ?x7140 ?x64228 ?x6344 ?x6323 ?x7092 ?x6618 ?x6499 ?x6837 ?x22346 ?x7086 ?x40404 ?x47057 ?x7634 ?x6744 ?x6883 ?x6818 ?x6718 ?x38917 ?x40398 ?x48308 ?x6733 ?x6868)))
 (let ((?x31217 (granule_data ?x110901)))
 (let ((?x79923 (gpt ?x110901)))
 (let ((?x7004 (priv ?x5284)))
 (let ((?x7032 (repl ?x5284)))
 (let ((?x7000 (oracle ?x5284)))
 (let ((?x6297 (log ?x5284)))
 (let ((?x6859 (mkRData ?x6297 ?x7000 ?x7032 ?x7004 (mkShared ?x79923 ?x31217 ?x48868) ?x6864 $x6666)))
 (let ((?x119237 (mkPtr "granules" ?x7220)))
 (let ((?x6980 (granule_unlock_spec.0_call ?x119237 ?x6859)))
 (let ((?x48852 (value_RData ?x6980)))
 (let ((?x119392 (share ?x48852)))
 (let ((?x6703 (globals ?x119392)))
 (let ((?x7025 (g_granules ?x6703)))
 (let ((?x49059 (e_state_s_granule (select ?x7025 gidx.2446436))))
 (let (($x7472 (= ?x49059 6)))
 (let (($x64583 (= ?x49059 0)))
 (=> (not (select (gpt ?x119392) gidx.2446436)) (or $x64583 $x7472)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (not $x7182)))
(check-sat)
