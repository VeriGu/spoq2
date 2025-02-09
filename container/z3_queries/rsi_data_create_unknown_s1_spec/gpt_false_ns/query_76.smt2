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
(let ((a!8 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!7))))
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
(let ((a!8 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!7))))
  (oracle a!8)))))))))_call| (List_Event) List_Event)
(declare-fun memcpy_ns_read_spec.0_call (Ptr Ptr Int RData) Option_Tuple_bool_RData)
(declare-fun v_0.2446581 () Int)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
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
(let ((a!9 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!7) (poffset a!7))
                          a!8))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!1
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (repl a!10))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
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
(let ((a!9 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!7) (poffset a!7))
                          a!8))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!1
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (oracle a!10))))))))))_call| (List_Event) List_Event)
(declare-fun memset_spec.0_call (Ptr Int Int RData) Option_Tuple_Ptr_RData)
(declare-fun v_0.2446917 () Int)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!8) (poffset a!8))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
  (repl (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!11)))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!8) (poffset a!8))
                           a!9))))
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
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
  (repl (value_RData a!12))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
  (oracle (value_RData a!12))))))))))))_call| (List_Event) List_Event)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!12)))))
  (repl a!13))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!12)))))
  (oracle a!13))))))))))))_call| (List_Event) List_Event)
(declare-fun pack_struct_return_code_para.0_call (Int) Int)
(declare-fun make_return_code_para.0_call (Int) Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!12)))))
(let ((a!14 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!13)))
  (repl (value_RData a!14))))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!12)))))
(let ((a!14 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!13)))
  (oracle (value_RData a!14))))))))))))))_call| (List_Event) List_Event)
(declare-fun v_0.2449661 () Int)
(declare-fun |(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2449661)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
      (a!38 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2449661)))
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
(let ((a!11 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           a!10))))
(let ((a!12 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!12))))))
(let ((a!14 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
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
                    (meta_PA (test_Z_PTE.0_call v_0.2449661)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
      (a!38 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2449661)))
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
(let ((a!11 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           a!10))))
(let ((a!12 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!12))))))
(let ((a!14 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
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
 (let (($x5746 (= ?x5778 2)))
 (not $x5746)))))))))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2446546 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x64410 (share ?x5595)))
 (let ((?x7223 (globals ?x64410)))
 (let ((?x7090 (g_granules ?x7223)))
 (let ((?x7176 (e_state_s_granule (select ?x7090 gidx.2446546))))
 (let (($x7429 (= ?x7176 6)))
 (let (($x49061 (= ?x7176 0)))
 (=> (not (select (gpt ?x64410) gidx.2446546)) (or $x49061 $x7429)))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2446581 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2446581))) 4096)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x64410 (share ?x5595)))
 (let ((?x7173 (gpt ?x64410)))
 (select ?x7173 ?x1047)))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x6991 (forall ((gidx.2446769 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x64410 (share ?x5595)))
 (let ((?x39725 (log ?x5595)))
 (let ((?x49082 (|(let ((a!1 (mkPtr "granules"
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
(let ((a!8 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!7))))
  (oracle a!8)))))))))_call| ?x39725)))
 (let ((?x6648 (|(let ((a!1 (mkPtr "granules"
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
(let ((a!8 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!6) (poffset a!6))
                          a!7))))
  (repl a!8)))))))))_call| ?x49082 ?x64410)))
 (let ((?x56476 (value_Shared ?x6648)))
 (let ((?x40988 (globals ?x56476)))
 (let ((?x7480 (g_granules ?x40988)))
 (let ((?x6006 (e_state_s_granule (select ?x7480 gidx.2446769))))
 (let (($x7680 (= ?x6006 0)))
 (let (($x6848 (= ?x6006 6)))
 (let ((?x40797 (gpt ?x56476)))
 (let (($x6192 (select ?x40797 gidx.2446769)))
 (or $x6192 $x6848 $x7680))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x6886 (forall ((gidx.2446752 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x64410 (share ?x5595)))
 (let ((?x7223 (globals ?x64410)))
 (let ((?x7090 (g_granules ?x7223)))
 (let ((?x7176 (e_state_s_granule (select ?x7090 gidx.2446752))))
 (let (($x49061 (= ?x7176 0)))
 (let (($x7429 (= ?x7176 6)))
 (let ((?x7173 (gpt ?x64410)))
 (let (($x6776 (select ?x7173 gidx.2446752)))
 (or $x6776 $x7429 $x49061))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x6886) $x6991))))
(assert
 (forall ((gidx.2446882 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x72957 (share ?x14589)))
 (let ((?x6833 (globals ?x72957)))
 (let ((?x6624 (g_granules ?x6833)))
 (let ((?x6737 (e_state_s_granule (select ?x6624 gidx.2446882))))
 (let (($x6366 (= ?x6737 6)))
 (let (($x6377 (= ?x6737 0)))
 (=> (not (select (gpt ?x72957) gidx.2446882)) (or $x6377 $x6366)))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2446917 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2446917))) 4096)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x72957 (share ?x14589)))
 (let ((?x64767 (gpt ?x72957)))
 (select ?x64767 ?x1047)))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x7622 (forall ((gidx.2447105 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x72957 (share ?x14589)))
 (let ((?x47856 (log ?x14589)))
 (let ((?x49051 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
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
(let ((a!9 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!7) (poffset a!7))
                          a!8))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!1
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (oracle a!10))))))))))_call| ?x47856)))
 (let ((?x40783 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
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
(let ((a!9 (value_RData (spinlock_release_spec.0_call
                          (mkPtr (pbase a!7) (poffset a!7))
                          a!8))))
(let ((a!10 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!1
                        (mkPtr "granule_data" 0)
                        4096
                        a!9)))))
  (repl a!10))))))))))_call| ?x49051 ?x72957)))
 (let ((?x41056 (value_Shared ?x40783)))
 (let ((?x7127 (gpt ?x41056)))
 (let (($x7641 (select ?x7127 gidx.2447105)))
 (let ((?x6311 (e_state_s_granule (select (g_granules (globals ?x41056)) gidx.2447105))))
 (let (($x7515 (= ?x6311 0)))
 (let (($x7392 (= ?x6311 6)))
 (or $x7392 $x7515 $x7641))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x7239 (forall ((gidx.2447088 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x72957 (share ?x14589)))
 (let ((?x64767 (gpt ?x72957)))
 (let (($x40808 (select ?x64767 gidx.2447088)))
 (let ((?x6737 (e_state_s_granule (select (g_granules (globals ?x72957)) gidx.2447088))))
 (let (($x6377 (= ?x6737 0)))
 (let (($x6366 (= ?x6737 6)))
 (or $x6366 $x6377 $x40808))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x7239) $x7622))))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let (($x7062 (elem_0 ?x31106)))
 (not $x7062))))))))))))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.2448618 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x89664 (share ?x7331)))
 (let ((?x50090 (globals ?x89664)))
 (let ((?x7962 (g_granules ?x50090)))
 (let ((?x8212 (e_state_s_granule (select ?x7962 gidx.2448618))))
 (let (($x7258 (= ?x8212 6)))
 (let (($x6544 (= ?x8212 0)))
 (=> (not (select (gpt ?x89664) gidx.2448618)) (or $x6544 $x7258))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2448653 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2448653))) 4096)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x89664 (share ?x7331)))
 (let ((?x8010 (gpt ?x89664)))
 (select ?x8010 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x49032 (forall ((gidx.2448841 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x89664 (share ?x7331)))
 (let ((?x8250 (log ?x7331)))
 (let ((?x8156 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!8) (poffset a!8))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
  (oracle (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!11)))))))))))))_call| ?x8250)))
 (let ((?x8478 (|(let ((a!1 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!2 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!8) (poffset a!8))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!2
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
  (repl (elem_1 (value_Tuple_Ptr_RData (memset_spec.0_call a!1 0 4096 a!11)))))))))))))_call| ?x8156 ?x89664)))
 (let ((?x6304 (value_Shared ?x8478)))
 (let ((?x7370 (globals ?x6304)))
 (let ((?x57139 (g_granules ?x7370)))
 (let ((?x7797 (e_state_s_granule (select ?x57139 gidx.2448841))))
 (let (($x48561 (= ?x7797 6)))
 (let ((?x7335 (gpt ?x6304)))
 (let (($x7780 (select ?x7335 gidx.2448841)))
 (let (($x7206 (= ?x7797 0)))
 (or $x7206 $x7780 $x48561)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x73138 (forall ((gidx.2448824 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x89664 (share ?x7331)))
 (let ((?x8010 (gpt ?x89664)))
 (let (($x8529 (select ?x8010 gidx.2448824)))
 (let ((?x8212 (e_state_s_granule (select (g_granules (globals ?x89664)) gidx.2448824))))
 (let (($x7258 (= ?x8212 6)))
 (let (($x6544 (= ?x8212 0)))
 (or $x6544 $x7258 $x8529)))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x73138) $x49032))))
(assert
 (forall ((gidx.2448954 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x105289 (share ?x8315)))
 (let ((?x20440 (globals ?x105289)))
 (let ((?x49609 (g_granules ?x20440)))
 (let ((?x57803 (e_state_s_granule (select ?x49609 gidx.2448954))))
 (let (($x49656 (= ?x57803 6)))
 (let (($x7787 (= ?x57803 0)))
 (=> (not (select (gpt ?x105289) gidx.2448954)) (or $x7787 $x49656))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2448989 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2448989))) 4096)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x105289 (share ?x8315)))
 (let ((?x32672 (gpt ?x105289)))
 (select ?x32672 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x50481 (forall ((gidx.2449177 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x105289 (share ?x8315)))
 (let ((?x8325 (log ?x8315)))
 (let ((?x7888 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
  (oracle (value_RData a!12))))))))))))_call| ?x8325)))
 (let ((?x7764 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
  (repl (value_RData a!12))))))))))))_call| ?x7888 ?x105289)))
 (let ((?x41363 (value_Shared ?x7764)))
 (let ((?x7179 (globals ?x41363)))
 (let ((?x8092 (g_granules ?x7179)))
 (let ((?x22991 (e_state_s_granule (select ?x8092 gidx.2449177))))
 (let (($x8349 (= ?x22991 0)))
 (let (($x7970 (= ?x22991 6)))
 (let ((?x49193 (gpt ?x41363)))
 (let (($x6459 (select ?x49193 gidx.2449177)))
 (or $x6459 $x7970 $x8349)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x7564 (forall ((gidx.2449160 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x105289 (share ?x8315)))
 (let ((?x20440 (globals ?x105289)))
 (let ((?x49609 (g_granules ?x20440)))
 (let ((?x57803 (e_state_s_granule (select ?x49609 gidx.2449160))))
 (let (($x49656 (= ?x57803 6)))
 (let ((?x32672 (gpt ?x105289)))
 (let (($x8172 (select ?x32672 gidx.2449160)))
 (let (($x7787 (= ?x57803 0)))
 (or $x7787 $x8172 $x49656)))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x7564) $x50481))))
(assert
 (forall ((gidx.2449290 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x113187 (share ?x8023)))
 (let ((?x97336 (globals ?x113187)))
 (let ((?x89551 (g_granules ?x97336)))
 (let ((?x8485 (e_state_s_granule (select ?x89551 gidx.2449290))))
 (let (($x8657 (= ?x8485 6)))
 (let (($x8370 (= ?x8485 0)))
 (=> (not (select (gpt ?x113187) gidx.2449290)) (or $x8370 $x8657))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2449325 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2449325))) 4096)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x113187 (share ?x8023)))
 (let ((?x81106 (gpt ?x113187)))
 (select ?x81106 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x41437 (forall ((gidx.2449513 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x113187 (share ?x8023)))
 (let ((?x8117 (log ?x8023)))
 (let ((?x7169 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!12)))))
  (oracle a!13))))))))))))_call| ?x8117)))
 (let ((?x41990 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!12)))))
  (repl a!13))))))))))))_call| ?x7169 ?x113187)))
 (let ((?x42293 (value_Shared ?x41990)))
 (let ((?x49388 (globals ?x42293)))
 (let ((?x41551 (g_granules ?x49388)))
 (let ((?x7372 (e_state_s_granule (select ?x41551 gidx.2449513))))
 (let (($x50238 (= ?x7372 0)))
 (let ((?x8380 (gpt ?x42293)))
 (let (($x24360 (select ?x8380 gidx.2449513)))
 (let (($x7921 (= ?x7372 6)))
 (or $x7921 $x24360 $x50238)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x7661 (forall ((gidx.2449496 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x113187 (share ?x8023)))
 (let ((?x97336 (globals ?x113187)))
 (let ((?x89551 (g_granules ?x97336)))
 (let ((?x8485 (e_state_s_granule (select ?x89551 gidx.2449496))))
 (let (($x8657 (= ?x8485 6)))
 (let (($x8370 (= ?x8485 0)))
 (let ((?x81106 (gpt ?x113187)))
 (let (($x7183 (select ?x81106 gidx.2449496)))
 (or $x7183 $x8370 $x8657)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x7661) $x41437))))
(assert
 (let ((?x73347 (make_return_code_para.0_call 1)))
 (let ((?x26393 (pack_struct_return_code_para.0_call ?x73347)))
 (= ?x26393 0))))
(assert
 (forall ((gidx.2449626 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x41555 (granule_unlock_spec.0_call ?x1244 ?x8023)))
 (let ((?x8358 (value_RData ?x41555)))
 (let ((?x121039 (share ?x8358)))
 (let ((?x49674 (globals ?x121039)))
 (let ((?x49933 (g_granules ?x49674)))
 (let ((?x7863 (e_state_s_granule (select ?x49933 gidx.2449626))))
 (let (($x8785 (= ?x7863 6)))
 (let (($x8482 (= ?x7863 0)))
 (let ((?x50757 (gpt ?x121039)))
 (let (($x8607 (select ?x50757 gidx.2449626)))
 (let (($x8308 (not $x8607)))
 (=> $x8308 (or $x8482 $x8785)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2449661 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2449661))) 4096)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x41555 (granule_unlock_spec.0_call ?x1244 ?x8023)))
 (let ((?x8358 (value_RData ?x41555)))
 (let ((?x121039 (share ?x8358)))
 (let ((?x50757 (gpt ?x121039)))
 (select ?x50757 ?x1047))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x41016 (forall ((gidx.2449849 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x41555 (granule_unlock_spec.0_call ?x1244 ?x8023)))
 (let ((?x8358 (value_RData ?x41555)))
 (let ((?x121039 (share ?x8358)))
 (let ((?x8404 (log ?x8358)))
 (let ((?x7610 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!12)))))
(let ((a!14 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!13)))
  (oracle (value_RData a!14))))))))))))))_call| ?x8404)))
 (let ((?x8051 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!7 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581))))))
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
(let ((a!10 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!6) (poffset a!6))
                           a!9))))
(let ((a!11 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!8
                        (mkPtr "granule_data" 0)
                        4096
                        a!10)))))
(let ((a!12 (granule_unlock_spec.0_call
              a!6
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!7 0 4096 a!11))))))
(let ((a!13 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (value_RData a!12)))))
(let ((a!14 (granule_unlock_spec.0_call
              (mkPtr "granules" (meta_granule_offset (test_PA.0_call v_1.0)))
              a!13)))
  (repl (value_RData a!14))))))))))))))_call| ?x7610 ?x121039)))
 (let ((?x7889 (value_Shared ?x8051)))
 (let ((?x7585 (globals ?x7889)))
 (let ((?x8718 (g_granules ?x7585)))
 (let ((?x8359 (e_state_s_granule (select ?x8718 gidx.2449849))))
 (let (($x50015 (= ?x8359 6)))
 (let (($x8549 (= ?x8359 0)))
 (let ((?x8648 (gpt ?x7889)))
 (let (($x7226 (select ?x8648 gidx.2449849)))
 (or $x7226 $x8549 $x50015)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x7145 (forall ((gidx.2449832 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x41555 (granule_unlock_spec.0_call ?x1244 ?x8023)))
 (let ((?x8358 (value_RData ?x41555)))
 (let ((?x121039 (share ?x8358)))
 (let ((?x49674 (globals ?x121039)))
 (let ((?x49933 (g_granules ?x49674)))
 (let ((?x7863 (e_state_s_granule (select ?x49933 gidx.2449832))))
 (let (($x8785 (= ?x7863 6)))
 (let ((?x50757 (gpt ?x121039)))
 (let (($x8607 (select ?x50757 gidx.2449832)))
 (let (($x8482 (= ?x7863 0)))
 (or $x8482 $x8607 $x8785)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x7145) $x41016))))
(assert
 (let ((?x7892 (test_Z_PTE.0_call v_0.2449661)))
 (let ((?x8069 (meta_PA ?x7892)))
 (let ((?x41586 (meta_granule_offset ?x8069)))
 (let (($x8235 (>= ?x41586 0)))
 (let ((?x8115 (mod ?x41586 4096)))
 (let (($x7785 (= ?x8115 0)))
 (and $x7785 $x8235))))))))
(assert
 (forall ((gidx.2449962 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x41555 (granule_unlock_spec.0_call ?x1244 ?x8023)))
 (let ((?x8358 (value_RData ?x41555)))
 (let ((?x7892 (test_Z_PTE.0_call v_0.2449661)))
 (let ((?x8069 (meta_PA ?x7892)))
 (let ((?x41586 (meta_granule_offset ?x8069)))
 (let ((?x8082 (div ?x41586 4096)))
 (let ((?x121039 (share ?x8358)))
 (let ((?x49674 (globals ?x121039)))
 (let ((?x49933 (g_granules ?x49674)))
 (let ((?x8464 (select ?x49933 ?x8082)))
 (let ((?x8162 (mks_granule (e_lock ?x8464) 4 (e_ref ?x8464))))
 (let ((?x8708 (store ?x49933 ?x8082 ?x8162)))
 (let ((?x8585 (mkGLOBALS (g_heap ?x49674) (g_debug_exits ?x49674) (g_vmid_count ?x49674) (g_vmid_lock ?x49674) (g_vmids ?x49674) (g_nr_lrs ?x49674) (g_nr_aprs ?x49674) (g_max_vintid ?x49674) (g_pri_res0_mask ?x49674) (g_default_gicstate ?x49674) (g_status_handler ?x49674) (g_rmm_trap_list ?x49674) (g_tt_l3_buffer ?x49674) (g_tt_l2_mem0_0 ?x49674) (g_tt_l2_mem0_1 ?x49674) (g_tt_l2_mem1_0 ?x49674) (g_tt_l2_mem1_1 ?x49674) (g_tt_l2_mem1_2 ?x49674) (g_tt_l2_mem1_3 ?x49674) (g_tt_l1_upper ?x49674) (g_mbedtls_mem_buf ?x49674) ?x8708 (g_rmm_attest_signing_key ?x49674) (g_rmm_attest_public_key ?x49674) (g_rmm_attest_public_key_len ?x49674) (g_rmm_attest_public_key_hash ?x49674) (g_rmm_attest_public_key_hash_len ?x49674) (g_platform_token_buf ?x49674) (g_rmm_platform_token ?x49674) (g_get_realm_identity_identity ?x49674) (g_realm_attest_private_key ?x49674))))
 (let ((?x50757 (gpt ?x121039)))
 (let ((?x7702 (repl ?x8358)))
 (let ((?x8344 (oracle ?x8358)))
 (let ((?x8404 (log ?x8358)))
 (let ((?x7253 (mkRData ?x8404 ?x8344 ?x7702 (priv ?x8358) (mkShared ?x50757 (granule_data ?x121039) ?x8585) (stack ?x8358) (halt ?x8358))))
 (let ((?x129045 (mkPtr "granules" ?x41586)))
 (let ((?x49475 (granule_unlock_spec.0_call ?x129045 ?x7253)))
 (let ((?x7279 (value_RData ?x49475)))
 (let ((?x129138 (share ?x7279)))
 (let ((?x8173 (globals ?x129138)))
 (let ((?x7912 (g_granules ?x8173)))
 (let ((?x8730 (e_state_s_granule (select ?x7912 gidx.2449962))))
 (let (($x8174 (= ?x8730 6)))
 (let (($x8497 (= ?x8730 0)))
 (=> (not (select (gpt ?x129138) gidx.2449962)) (or $x8497 $x8174)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.2449997 Int) )(let ((?x1047 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2449997))) 4096)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x41555 (granule_unlock_spec.0_call ?x1244 ?x8023)))
 (let ((?x8358 (value_RData ?x41555)))
 (let ((?x7892 (test_Z_PTE.0_call v_0.2449661)))
 (let ((?x8069 (meta_PA ?x7892)))
 (let ((?x41586 (meta_granule_offset ?x8069)))
 (let ((?x8082 (div ?x41586 4096)))
 (let ((?x121039 (share ?x8358)))
 (let ((?x49674 (globals ?x121039)))
 (let ((?x49933 (g_granules ?x49674)))
 (let ((?x8464 (select ?x49933 ?x8082)))
 (let ((?x8162 (mks_granule (e_lock ?x8464) 4 (e_ref ?x8464))))
 (let ((?x8708 (store ?x49933 ?x8082 ?x8162)))
 (let ((?x8585 (mkGLOBALS (g_heap ?x49674) (g_debug_exits ?x49674) (g_vmid_count ?x49674) (g_vmid_lock ?x49674) (g_vmids ?x49674) (g_nr_lrs ?x49674) (g_nr_aprs ?x49674) (g_max_vintid ?x49674) (g_pri_res0_mask ?x49674) (g_default_gicstate ?x49674) (g_status_handler ?x49674) (g_rmm_trap_list ?x49674) (g_tt_l3_buffer ?x49674) (g_tt_l2_mem0_0 ?x49674) (g_tt_l2_mem0_1 ?x49674) (g_tt_l2_mem1_0 ?x49674) (g_tt_l2_mem1_1 ?x49674) (g_tt_l2_mem1_2 ?x49674) (g_tt_l2_mem1_3 ?x49674) (g_tt_l1_upper ?x49674) (g_mbedtls_mem_buf ?x49674) ?x8708 (g_rmm_attest_signing_key ?x49674) (g_rmm_attest_public_key ?x49674) (g_rmm_attest_public_key_len ?x49674) (g_rmm_attest_public_key_hash ?x49674) (g_rmm_attest_public_key_hash_len ?x49674) (g_platform_token_buf ?x49674) (g_rmm_platform_token ?x49674) (g_get_realm_identity_identity ?x49674) (g_realm_attest_private_key ?x49674))))
 (let ((?x50757 (gpt ?x121039)))
 (let ((?x7702 (repl ?x8358)))
 (let ((?x8344 (oracle ?x8358)))
 (let ((?x8404 (log ?x8358)))
 (let ((?x7253 (mkRData ?x8404 ?x8344 ?x7702 (priv ?x8358) (mkShared ?x50757 (granule_data ?x121039) ?x8585) (stack ?x8358) (halt ?x8358))))
 (let ((?x129045 (mkPtr "granules" ?x41586)))
 (let ((?x49475 (granule_unlock_spec.0_call ?x129045 ?x7253)))
 (let ((?x7279 (value_RData ?x49475)))
 (let ((?x129138 (share ?x7279)))
 (let ((?x8221 (gpt ?x129138)))
 (select ?x8221 ?x1047)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x7397 (forall ((gidx.2450185 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x41555 (granule_unlock_spec.0_call ?x1244 ?x8023)))
 (let ((?x8358 (value_RData ?x41555)))
 (let ((?x7892 (test_Z_PTE.0_call v_0.2449661)))
 (let ((?x8069 (meta_PA ?x7892)))
 (let ((?x41586 (meta_granule_offset ?x8069)))
 (let ((?x8082 (div ?x41586 4096)))
 (let ((?x121039 (share ?x8358)))
 (let ((?x49674 (globals ?x121039)))
 (let ((?x49933 (g_granules ?x49674)))
 (let ((?x8464 (select ?x49933 ?x8082)))
 (let ((?x8162 (mks_granule (e_lock ?x8464) 4 (e_ref ?x8464))))
 (let ((?x8708 (store ?x49933 ?x8082 ?x8162)))
 (let ((?x8585 (mkGLOBALS (g_heap ?x49674) (g_debug_exits ?x49674) (g_vmid_count ?x49674) (g_vmid_lock ?x49674) (g_vmids ?x49674) (g_nr_lrs ?x49674) (g_nr_aprs ?x49674) (g_max_vintid ?x49674) (g_pri_res0_mask ?x49674) (g_default_gicstate ?x49674) (g_status_handler ?x49674) (g_rmm_trap_list ?x49674) (g_tt_l3_buffer ?x49674) (g_tt_l2_mem0_0 ?x49674) (g_tt_l2_mem0_1 ?x49674) (g_tt_l2_mem1_0 ?x49674) (g_tt_l2_mem1_1 ?x49674) (g_tt_l2_mem1_2 ?x49674) (g_tt_l2_mem1_3 ?x49674) (g_tt_l1_upper ?x49674) (g_mbedtls_mem_buf ?x49674) ?x8708 (g_rmm_attest_signing_key ?x49674) (g_rmm_attest_public_key ?x49674) (g_rmm_attest_public_key_len ?x49674) (g_rmm_attest_public_key_hash ?x49674) (g_rmm_attest_public_key_hash_len ?x49674) (g_platform_token_buf ?x49674) (g_rmm_platform_token ?x49674) (g_get_realm_identity_identity ?x49674) (g_realm_attest_private_key ?x49674))))
 (let ((?x50757 (gpt ?x121039)))
 (let ((?x7702 (repl ?x8358)))
 (let ((?x8344 (oracle ?x8358)))
 (let ((?x8404 (log ?x8358)))
 (let ((?x7253 (mkRData ?x8404 ?x8344 ?x7702 (priv ?x8358) (mkShared ?x50757 (granule_data ?x121039) ?x8585) (stack ?x8358) (halt ?x8358))))
 (let ((?x129045 (mkPtr "granules" ?x41586)))
 (let ((?x49475 (granule_unlock_spec.0_call ?x129045 ?x7253)))
 (let ((?x7279 (value_RData ?x49475)))
 (let ((?x129138 (share ?x7279)))
 (let ((?x8584 (log ?x7279)))
 (let ((?x8397 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2449661)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
      (a!38 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2449661)))
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
(let ((a!11 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           a!10))))
(let ((a!12 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!12))))))
(let ((a!14 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
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
  (oracle (value_RData a!50))))))))))))))))))_call| ?x8584)))
 (let ((?x8962 (|(let ((a!1 (mkPtr "granules"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2449661)))))
      (a!2 (mkPtr "granules"
                  (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.96777)))))
      (a!8 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446917)))))
      (a!9 (mkPtr "granule_data"
                  (meta_granule_offset
                    (meta_PA (test_Z_PTE.0_call v_0.2446581)))))
      (a!38 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.2449661)))
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
(let ((a!11 (value_RData (spinlock_release_spec.0_call
                           (mkPtr (pbase a!7) (poffset a!7))
                           a!10))))
(let ((a!12 (elem_1 (value_Tuple_bool_RData
                      (memcpy_ns_read_spec.0_call
                        a!9
                        (mkPtr "granule_data" 0)
                        4096
                        a!11)))))
(let ((a!13 (granule_unlock_spec.0_call
              a!7
              (elem_1 (value_Tuple_Ptr_RData
                        (memset_spec.0_call a!8 0 4096 a!12))))))
(let ((a!14 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!6))
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
  (repl (value_RData a!50))))))))))))))))))_call| ?x8397 ?x129138)))
 (let ((?x50107 (value_Shared ?x8962)))
 (let ((?x4700 (globals ?x50107)))
 (let ((?x7725 (g_granules ?x4700)))
 (let ((?x7403 (e_state_s_granule (select ?x7725 gidx.2450185))))
 (let (($x49488 (= ?x7403 0)))
 (let ((?x42540 (gpt ?x50107)))
 (let (($x48952 (select ?x42540 gidx.2450185)))
 (let (($x8061 (= ?x7403 6)))
 (or $x8061 $x48952 $x49488))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x8581 (forall ((gidx.2450168 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x41555 (granule_unlock_spec.0_call ?x1244 ?x8023)))
 (let ((?x8358 (value_RData ?x41555)))
 (let ((?x7892 (test_Z_PTE.0_call v_0.2449661)))
 (let ((?x8069 (meta_PA ?x7892)))
 (let ((?x41586 (meta_granule_offset ?x8069)))
 (let ((?x8082 (div ?x41586 4096)))
 (let ((?x121039 (share ?x8358)))
 (let ((?x49674 (globals ?x121039)))
 (let ((?x49933 (g_granules ?x49674)))
 (let ((?x8464 (select ?x49933 ?x8082)))
 (let ((?x8162 (mks_granule (e_lock ?x8464) 4 (e_ref ?x8464))))
 (let ((?x8708 (store ?x49933 ?x8082 ?x8162)))
 (let ((?x8585 (mkGLOBALS (g_heap ?x49674) (g_debug_exits ?x49674) (g_vmid_count ?x49674) (g_vmid_lock ?x49674) (g_vmids ?x49674) (g_nr_lrs ?x49674) (g_nr_aprs ?x49674) (g_max_vintid ?x49674) (g_pri_res0_mask ?x49674) (g_default_gicstate ?x49674) (g_status_handler ?x49674) (g_rmm_trap_list ?x49674) (g_tt_l3_buffer ?x49674) (g_tt_l2_mem0_0 ?x49674) (g_tt_l2_mem0_1 ?x49674) (g_tt_l2_mem1_0 ?x49674) (g_tt_l2_mem1_1 ?x49674) (g_tt_l2_mem1_2 ?x49674) (g_tt_l2_mem1_3 ?x49674) (g_tt_l1_upper ?x49674) (g_mbedtls_mem_buf ?x49674) ?x8708 (g_rmm_attest_signing_key ?x49674) (g_rmm_attest_public_key ?x49674) (g_rmm_attest_public_key_len ?x49674) (g_rmm_attest_public_key_hash ?x49674) (g_rmm_attest_public_key_hash_len ?x49674) (g_platform_token_buf ?x49674) (g_rmm_platform_token ?x49674) (g_get_realm_identity_identity ?x49674) (g_realm_attest_private_key ?x49674))))
 (let ((?x50757 (gpt ?x121039)))
 (let ((?x7702 (repl ?x8358)))
 (let ((?x8344 (oracle ?x8358)))
 (let ((?x8404 (log ?x8358)))
 (let ((?x7253 (mkRData ?x8404 ?x8344 ?x7702 (priv ?x8358) (mkShared ?x50757 (granule_data ?x121039) ?x8585) (stack ?x8358) (halt ?x8358))))
 (let ((?x129045 (mkPtr "granules" ?x41586)))
 (let ((?x49475 (granule_unlock_spec.0_call ?x129045 ?x7253)))
 (let ((?x7279 (value_RData ?x49475)))
 (let ((?x129138 (share ?x7279)))
 (let ((?x8221 (gpt ?x129138)))
 (let (($x8506 (select ?x8221 gidx.2450168)))
 (let ((?x8730 (e_state_s_granule (select (g_granules (globals ?x129138)) gidx.2450168))))
 (let (($x8497 (= ?x8730 0)))
 (let (($x8174 (= ?x8730 6)))
 (or $x8174 $x8497 $x8506))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x8581) $x7397))))
(assert
 (let (($x8622 (forall ((gidx.2450244 Int) )(let ((?x4757 (test_Z_PTE.0_call v_0.96777)))
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
 (let ((?x131588 (spinlock_release_spec.0_call ?x5624 ?x4990)))
 (let ((?x5595 (value_RData ?x131588)))
 (let ((?x1721 (mkPtr "granule_data" 0)))
 (let ((?x31421 (test_Z_PTE.0_call v_0.2446581)))
 (let ((?x48948 (meta_PA ?x31421)))
 (let ((?x7189 (meta_granule_offset ?x48948)))
 (let ((?x6674 (mkPtr "granule_data" ?x7189)))
 (let ((?x6241 (memcpy_ns_read_spec.0_call ?x6674 ?x1721 4096 ?x5595)))
 (let ((?x31106 (value_Tuple_bool_RData ?x6241)))
 (let ((?x14589 (elem_1 ?x31106)))
 (let ((?x80556 (test_Z_PTE.0_call v_0.2446917)))
 (let ((?x6365 (meta_PA ?x80556)))
 (let ((?x80681 (meta_granule_offset ?x6365)))
 (let ((?x124874 (mkPtr "granule_data" ?x80681)))
 (let ((?x8249 (memset_spec.0_call ?x124874 0 4096 ?x14589)))
 (let ((?x8066 (value_Tuple_Ptr_RData ?x8249)))
 (let ((?x7331 (elem_1 ?x8066)))
 (let ((?x6330 (granule_unlock_spec.0_call ?x5637 ?x7331)))
 (let ((?x8315 (value_RData ?x6330)))
 (let ((?x5675 (elem_0 ?x5113)))
 (let ((?x5433 (e_2 ?x5675)))
 (let ((?x7008 (granule_unlock_spec.0_call ?x5433 ?x8315)))
 (let ((?x8023 (value_RData ?x7008)))
 (let ((?x41555 (granule_unlock_spec.0_call ?x1244 ?x8023)))
 (let ((?x8358 (value_RData ?x41555)))
 (let ((?x7892 (test_Z_PTE.0_call v_0.2449661)))
 (let ((?x8069 (meta_PA ?x7892)))
 (let ((?x41586 (meta_granule_offset ?x8069)))
 (let ((?x8082 (div ?x41586 4096)))
 (let ((?x121039 (share ?x8358)))
 (let ((?x49674 (globals ?x121039)))
 (let ((?x49933 (g_granules ?x49674)))
 (let ((?x8464 (select ?x49933 ?x8082)))
 (let ((?x8162 (mks_granule (e_lock ?x8464) 4 (e_ref ?x8464))))
 (let ((?x8708 (store ?x49933 ?x8082 ?x8162)))
 (let ((?x8585 (mkGLOBALS (g_heap ?x49674) (g_debug_exits ?x49674) (g_vmid_count ?x49674) (g_vmid_lock ?x49674) (g_vmids ?x49674) (g_nr_lrs ?x49674) (g_nr_aprs ?x49674) (g_max_vintid ?x49674) (g_pri_res0_mask ?x49674) (g_default_gicstate ?x49674) (g_status_handler ?x49674) (g_rmm_trap_list ?x49674) (g_tt_l3_buffer ?x49674) (g_tt_l2_mem0_0 ?x49674) (g_tt_l2_mem0_1 ?x49674) (g_tt_l2_mem1_0 ?x49674) (g_tt_l2_mem1_1 ?x49674) (g_tt_l2_mem1_2 ?x49674) (g_tt_l2_mem1_3 ?x49674) (g_tt_l1_upper ?x49674) (g_mbedtls_mem_buf ?x49674) ?x8708 (g_rmm_attest_signing_key ?x49674) (g_rmm_attest_public_key ?x49674) (g_rmm_attest_public_key_len ?x49674) (g_rmm_attest_public_key_hash ?x49674) (g_rmm_attest_public_key_hash_len ?x49674) (g_platform_token_buf ?x49674) (g_rmm_platform_token ?x49674) (g_get_realm_identity_identity ?x49674) (g_realm_attest_private_key ?x49674))))
 (let ((?x50757 (gpt ?x121039)))
 (let ((?x7702 (repl ?x8358)))
 (let ((?x8344 (oracle ?x8358)))
 (let ((?x8404 (log ?x8358)))
 (let ((?x7253 (mkRData ?x8404 ?x8344 ?x7702 (priv ?x8358) (mkShared ?x50757 (granule_data ?x121039) ?x8585) (stack ?x8358) (halt ?x8358))))
 (let ((?x129045 (mkPtr "granules" ?x41586)))
 (let ((?x49475 (granule_unlock_spec.0_call ?x129045 ?x7253)))
 (let ((?x7279 (value_RData ?x49475)))
 (let ((?x129138 (share ?x7279)))
 (let ((?x8173 (globals ?x129138)))
 (let ((?x7912 (g_granules ?x8173)))
 (let ((?x8730 (e_state_s_granule (select ?x7912 gidx.2450244))))
 (let (($x8174 (= ?x8730 6)))
 (let (($x8497 (= ?x8730 0)))
 (=> (not (select (gpt ?x129138) gidx.2450244)) (or $x8497 $x8174)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (not $x8622)))
(check-sat)
