; 
(set-info :status unknown)
(declare-datatypes ((s_anon_1_2 0)) (((mks_anon_1_2 (e_s_anon_1_2_0 Int) (e_s_anon_1_2_1 Int) (e_s_anon_1_2_2 Int) (e_g_rd_s_realm_info Int)))))
 (declare-datatypes ((s_fpu_state 0)) (((mks_fpu_state (e_q (Array Int Int)) (e_fpsr Int) (e_fpcr Int) (e_used Int)))))
 (declare-datatypes ((s_anon_0 0)) (((mks_anon_0 (e_s_anon_0_0 Int) (e_s_anon_0_1 Int) (e_s_anon_0_2 Int)))))
 (declare-datatypes ((s_gic_cpu_state 0)) (((mks_gic_cpu_state (e_ich_ap0r (Array Int Int)) (e_ich_ap1r (Array Int Int)) (e_ich_vmcr Int) (e_ich_hcr Int) (e_ich_lr (Array Int Int)) (e_ich_misr Int)))))
 (declare-datatypes ((s_sysreg_state 0)) (((mks_sysreg_state (e_sp_el0 Int) (e_sp_el1 Int) (e_elr_el1 Int) (e_spsr_el2 Int) (e_spsr_el1 Int) (e_pmcr_el0 Int) (e_pmuserenr_el0 Int) (e_tpidrro_el0 Int) (e_tpidr_el0 Int) (e_csselr_el1 Int) (e_sctlr_el1 Int) (e_actlr_el1 Int) (e_cpacr_el1 Int) (e_zcr_el1 Int) (e_ttbr0_el1 Int) (e_ttbr1_el1 Int) (e_tcr_el1 Int) (e_esr_el1 Int) (e_afsr0_el1 Int) (e_afsr1_el1 Int) (e_far_el1 Int) (e_mair_el1 Int) (e_vbar_el1_s_sysreg_state Int) (e_contextidr_el1 Int) (e_tpidr_el1 Int) (e_amair_el1 Int) (e_cntkctl_el1 Int) (e_par_el1 Int) (e_mdscr_el1 Int) (e_mdccint_el1 Int) (e_disr_el1 Int) (e_mpam0_el1 Int) (e_cnthctl_el2 Int) (e_cntvoff_el2 Int) (e_cntp_ctl_el0 Int) (e_cntp_cval_el0 Int) (e_cntv_ctl_el0 Int) (e_cntv_cval_el0 Int) (e_gicstate s_gic_cpu_state) (e_vmpidr_el2 Int) (e_hcr_el2 Int) (e_cptr_el2 Int) (e_tcr_el2 Int) (e_sctlr_el2 Int)))))
 (declare-datatypes ((s_anon_1 0)) (((mks_anon_1 (e_s_anon_1_0 Int) (e_s_anon_1_1 Int) (e_s_anon_1_2 Int) (e_s_anon_1_3 Int)))))
 (declare-datatypes ((s_common_sysreg_state 0)) (((mks_common_sysreg_state (e_vttbr_el2 Int) (e_vtcr_el2 Int) (e_hcr_el2_common_flags Int)))))
 (declare-datatypes ((s_realm_s1_context 0)) (((mks_realm_s1_context (e_g_ttbr0 Int) (e_g_ttbr1 Int)))))
 (declare-datatypes ((u_anon_3 0)) (((mku_anon_3 (e_u_anon_3_0 Int)))))
 (declare-datatypes ((s_anon_3 0)) (((mks_anon_3 (e_s_anon_3_0 Int)))))
 (declare-datatypes ((s_rec 0)) (((mks_rec (e_g_rec Int) (e_rec_idx Int) (e_runnable Int) (e_regs (Array Int Int)) (e_pc_s_rec Int) (e_pstate Int) (e_sysregs s_sysreg_state) (e_common_sysregs s_common_sysreg_state) (e_set_ripas s_anon_1) (e_dispose_info s_anon_0) (e_realm_info s_anon_1_2) (e_last_run_info u_anon_3) (e_fpu s_fpu_state) (e_ns Int) (e_psci_info s_anon_3) (e_is_pico_s_rec Int) (e_initialized Int) (e_s1_ctx s_realm_s1_context)))))
 (declare-datatypes ((s_mbedtls_sha256_context 0)) (((mks_mbedtls_sha256_context (e_total (Array Int Int)) (e_state (Array Int Int)) (e_buffer (Array Int Int)) (e_is224 Int)))))
 (declare-datatypes ((s_measurement_ctx 0)) (((mks_measurement_ctx (e_c s_mbedtls_sha256_context) (e_measurement_algo_s_measurement_ctx Int)))))
 (declare-datatypes ((s_realm_s2_context 0)) (((mks_realm_s2_context (e_ipa_bits Int) (e_s2_starting_level Int) (e_num_root_rtts Int) (e_g_rtt Int) (e_vmid Int)))))
 (declare-datatypes ((u_anon 0)) (((mku_anon (e_u_anon_0 (Array Int Int))))))
 (declare-datatypes ((s_measurement 0)) (((mks_measurement (e_0 u_anon)))))
 (declare-datatypes ((s_rd 0)) (((mks_rd (e_state_s_rd Int) (e_rec_count Int) (e_s2_ctx s_realm_s2_context) (e_par_base_s_rd Int) (e_par_size_s_rd Int) (e_par_end Int) (e_ctx s_measurement_ctx) (e_measurement (Array Int s_measurement)) (e_is_rc_s_rd Int)))))
 (declare-datatypes ((r_granule_data 0)) (((mkr_granule_data (gd_g_idx Int) (g_granule_state Int) (g_norm (Array Int Int)) (g_rd s_rd) (g_rec s_rec)))))
 (declare-datatypes ((Option_Z 0)) (((Some_Z (value_Z Int)) (None_Z))))
 (declare-datatypes ((s_spinlock_t 0)) (((mks_spinlock_t (e_val Option_Z)))))
 (declare-datatypes ((s_granule 0)) (((mks_granule (e_lock s_spinlock_t) (e_state_s_granule Int) (e_ref u_anon_3)))))
 (declare-datatypes ((s_s1tt 0)) (((mks_s1tt (e_s1tte (Array Int Int))))))
 (declare-datatypes ((s_q_useful_buf 0)) (((mks_q_useful_buf (e_ptr Int) (e_len_s_q_useful_buf Int)))))
 (declare-datatypes ((s_buffer_alloc_ctx 0)) (((mks_buffer_alloc_ctx (e_buf Int) (e_len Int) (e_first Int) (e_first_free Int) (e_verify Int)))))
 (declare-datatypes ((s_rmm_trap_element 0)) (((mks_rmm_trap_element (e_aborted_pc Int) (e_new_pc Int)))))
 (declare-datatypes ((GLOBALS 0)) (((mkGLOBALS (g_heap (Array Int s_buffer_alloc_ctx)) (g_debug_exits Int) (g_vmid_count Int) (g_vmid_lock s_spinlock_t) (g_vmids (Array Int Int)) (g_nr_lrs Int) (g_nr_aprs Int) (g_max_vintid Int) (g_pri_res0_mask Int) (g_default_gicstate s_gic_cpu_state) (g_status_handler (Array Int Int)) (g_rmm_trap_list (Array Int s_rmm_trap_element)) (g_tt_l3_buffer s_s1tt) (g_tt_l2_mem0_0 s_s1tt) (g_tt_l2_mem0_1 s_s1tt) (g_tt_l2_mem1_0 s_s1tt) (g_tt_l2_mem1_1 s_s1tt) (g_tt_l2_mem1_2 s_s1tt) (g_tt_l2_mem1_3 s_s1tt) (g_tt_l1_upper (Array Int Int)) (g_mbedtls_mem_buf (Array Int Int)) (g_granules (Array Int s_granule)) (g_rmm_attest_signing_key Int) (g_rmm_attest_public_key (Array Int Int)) (g_rmm_attest_public_key_len Int) (g_rmm_attest_public_key_hash (Array Int Int)) (g_rmm_attest_public_key_hash_len Int) (g_platform_token_buf (Array Int Int)) (g_rmm_platform_token s_q_useful_buf) (g_get_realm_identity_identity (Array Int Int)) (g_realm_attest_private_key (Array Int Int))))))
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
 (declare-fun zero_granule_data () (Array Int Int))
(declare-fun st.0 () RData)
(declare-fun |(repl st.0)_call| (List_Event Shared) Option_Shared)
(declare-fun |(oracle st.0)_call| (List_Event) List_Event)
(declare-fun test_Z_PTE.0_call (Int) abs_PTE_t)
(declare-fun check_rcsm_mask_para.0_call (abs_PA_t) Bool)
(declare-fun test_PA.0_call (Int) abs_PA_t)
(declare-fun v_1_Zptr.0 () Int)
(declare-fun spinlock_acquire_spec.0_call (Ptr RData) Option_RData)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
  (repl (value_RData a!1)))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
  (oracle (value_RData a!1)))_call| (List_Event) List_Event)
(declare-fun rec_to_ttbr1_para.0_call (Ptr RData) Ptr)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
  (repl a!3))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
  (oracle a!3))))_call| (List_Event) List_Event)
(declare-fun v_0_Zptr.0 () Int)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
  (repl (value_RData a!4))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
  (oracle (value_RData a!4))))))_call| (List_Event) List_Event)
(declare-fun rtt_walk_lock_unlock_spec_abs.0_call (Ptr Ptr Int Int Int Int RData) Option_Tuple_abs_ret_rtt_RData)
(declare-fun v_3.0 () Int)
(declare-fun v_2.0 () Int)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!2
                       0
                       64
                       v_2.0
                       v_3.0
                       (value_RData a!4))))))
  (repl a!5))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!2
                       0
                       64
                       v_2.0
                       v_3.0
                       (value_RData a!4))))))
  (oracle a!5))))))_call| (List_Event) List_Event)
(declare-fun abs_tte_read.0_call (Ptr RData) abs_PTE_t)
(declare-fun s2tt_init_unassigned_spec.0_call (Ptr Int RData) Option_RData)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
  (repl (value_RData a!7)))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
  (oracle (value_RData a!7)))))))))_call| (List_Event) List_Event)
(declare-fun granule_unlock_spec.0_call (Ptr RData) Option_RData)
(declare-fun test_PTE_Z.0_call (abs_PTE_t) Int)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
  (repl (value_RData a!50))))))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
  (oracle (value_RData a!50))))))))))))))))_call| (List_Event) List_Event)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
(let ((a!51 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              (value_RData a!50))))
  (repl (value_RData a!51)))))))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
(let ((a!51 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              (value_RData a!50))))
  (oracle (value_RData a!51)))))))))))))))))_call| (List_Event) List_Event)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
(let ((a!51 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              (value_RData a!50))))
(let ((a!52 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
              (value_RData a!51))))
  (repl (value_RData a!52))))))))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
(let ((a!51 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              (value_RData a!50))))
(let ((a!52 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
              (value_RData a!51))))
  (oracle (value_RData a!52))))))))))))))))))_call| (List_Event) List_Event)
(assert
 (forall ((gidx.102328 Int) )(let (($x59 (= (g_norm (select (granule_data (share st.0)) gidx.102328)) zero_granule_data)))
 (let (($x62 (= (e_state_s_granule (select (g_granules (globals (share st.0))) gidx.102328)) 1)))
 (=> $x62 $x59))))
 )
(assert
 (let (($x1636 (forall ((gidx.107382 Int) )(let ((?x12 (share st.0)))
 (let ((?x7 (log st.0)))
 (let ((?x10 (|(oracle st.0)_call| ?x7)))
 (let ((?x15 (|(repl st.0)_call| ?x10 ?x12)))
 (let ((?x17 (value_Shared ?x15)))
 (let ((?x53 (granule_data ?x17)))
 (let ((?x93 (select ?x53 gidx.107382)))
 (let (($x95 (= (g_norm ?x93) zero_granule_data)))
 (let (($x98 (= (e_state_s_granule (select (g_granules (globals ?x17)) gidx.107382)) 1)))
 (or (not $x98) $x95)))))))))))
 ))
 (let (($x867 (forall ((gidx.107371 Int) )(let (($x59 (= (g_norm (select (granule_data (share st.0)) gidx.107371)) zero_granule_data)))
 (let (($x62 (= (e_state_s_granule (select (g_granules (globals (share st.0))) gidx.107371)) 1)))
 (or (not $x62) $x59))))
 ))
 (or (not $x867) $x1636))))
(assert
 (forall ((v_0.107793 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.107793))) 4096)))
 (let ((?x12 (share st.0)))
 (let ((?x91 (gpt ?x12)))
 (select ?x91 ?x1632)))))
 )
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let (($x1595 (check_rcsm_mask_para.0_call ?x1597)))
 (not $x1595))))
(assert
 (forall ((gidx.369482 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x9777 (share ?x1634)))
 (let ((?x897 (granule_data ?x9777)))
 (let (($x918 (= (g_norm (select ?x897 gidx.369482)) zero_granule_data)))
 (let (($x913 (= (e_state_s_granule (select (g_granules (globals ?x9777)) gidx.369482)) 1)))
 (=> $x913 $x918)))))))))))
 )
(assert
 (forall ((v_0.369517 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.369517))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x9777 (share ?x1634)))
 (let ((?x894 (gpt ?x9777)))
 (select ?x894 ?x1632))))))))))
 )
(assert
 (let (($x3114 (forall ((gidx.369653 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x9777 (share ?x1634)))
 (let ((?x892 (log ?x1634)))
 (let ((?x1014 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
  (oracle (value_RData a!1)))_call| ?x892)))
 (let ((?x910 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
  (repl (value_RData a!1)))_call| ?x1014 ?x9777)))
 (let ((?x920 (value_Shared ?x910)))
 (let ((?x904 (granule_data ?x920)))
 (let (($x922 (= (g_norm (select ?x904 gidx.369653)) zero_granule_data)))
 (let (($x984 (= (e_state_s_granule (select (g_granules (globals ?x920)) gidx.369653)) 1)))
 (or (not $x984) $x922)))))))))))))))
 ))
 (let (($x3149 (forall ((gidx.369642 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x9777 (share ?x1634)))
 (let ((?x897 (granule_data ?x9777)))
 (let (($x918 (= (g_norm (select ?x897 gidx.369642)) zero_granule_data)))
 (let (($x913 (= (e_state_s_granule (select (g_granules (globals ?x9777)) gidx.369642)) 1)))
 (or (not $x913) $x918)))))))))))
 ))
 (or (not $x3149) $x3114))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x980 (div ?x1577 4096)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x9777 (share ?x1634)))
 (let ((?x979 (globals ?x9777)))
 (let ((?x901 (g_granules ?x979)))
 (let ((?x912 (select ?x901 ?x980)))
 (let ((?x978 (e_state_s_granule ?x912)))
 (= ?x978 3)))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let (($x1019 (>= ?x1577 0)))
 (let ((?x1022 (mod ?x1577 4096)))
 (let (($x998 (= ?x1022 0)))
 (and $x998 $x1019)))))))
(assert
 true)
(assert
 (forall ((gidx.369730 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x22258 (share ?x3425)))
 (let ((?x3413 (granule_data ?x22258)))
 (let (($x3321 (= (g_norm (select ?x3413 gidx.369730)) zero_granule_data)))
 (let (($x14724 (= (e_state_s_granule (select (g_granules (globals ?x22258)) gidx.369730)) 1)))
 (=> $x14724 $x3321))))))))))))))))))
 )
(assert
 (forall ((v_0.369765 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.369765))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x22258 (share ?x3425)))
 (let ((?x3319 (gpt ?x22258)))
 (select ?x3319 ?x1632)))))))))))))))))
 )
(assert
 (let (($x3476 (forall ((gidx.369901 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x22258 (share ?x3425)))
 (let ((?x3278 (log ?x3425)))
 (let ((?x3429 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
  (oracle a!3))))_call| ?x3278)))
 (let ((?x3382 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
  (repl a!3))))_call| ?x3429 ?x22258)))
 (let ((?x3397 (value_Shared ?x3382)))
 (let ((?x3324 (granule_data ?x3397)))
 (let (($x3198 (= (g_norm (select ?x3324 gidx.369901)) zero_granule_data)))
 (let (($x3483 (= (e_state_s_granule (select (g_granules (globals ?x3397)) gidx.369901)) 1)))
 (or (not $x3483) $x3198))))))))))))))))))))))
 ))
 (let (($x3288 (forall ((gidx.369890 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x22258 (share ?x3425)))
 (let ((?x3413 (granule_data ?x22258)))
 (let (($x3321 (= (g_norm (select ?x3413 gidx.369890)) zero_granule_data)))
 (let (($x14724 (= (e_state_s_granule (select (g_granules (globals ?x22258)) gidx.369890)) 1)))
 (or (not $x14724) $x3321))))))))))))))))))
 ))
 (or (not $x3288) $x3476))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3307 (div ?x3357 4096)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x22258 (share ?x3425)))
 (let ((?x37191 (globals ?x22258)))
 (let ((?x2961 (g_granules ?x37191)))
 (let ((?x3452 (select ?x2961 ?x3307)))
 (let ((?x2150 (e_state_s_granule ?x3452)))
 (= ?x2150 5))))))))))))))))))))
(assert
 (forall ((gidx.369978 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x31821 (share ?x3570)))
 (let ((?x3616 (granule_data ?x31821)))
 (let (($x3131 (= (g_norm (select ?x3616 gidx.369978)) zero_granule_data)))
 (let (($x3559 (= (e_state_s_granule (select (g_granules (globals ?x31821)) gidx.369978)) 1)))
 (=> $x3559 $x3131)))))))))))))))))))))))
 )
(assert
 (forall ((v_0.370013 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.370013))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x31821 (share ?x3570)))
 (let ((?x3139 (gpt ?x31821)))
 (select ?x3139 ?x1632))))))))))))))))))))))
 )
(assert
 (let (($x3580 (forall ((gidx.370149 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x31821 (share ?x3570)))
 (let ((?x3645 (log ?x3570)))
 (let ((?x3364 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
  (oracle (value_RData a!4))))))_call| ?x3645)))
 (let ((?x3408 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
  (repl (value_RData a!4))))))_call| ?x3364 ?x31821)))
 (let ((?x3619 (value_Shared ?x3408)))
 (let ((?x3646 (granule_data ?x3619)))
 (let (($x3618 (= (g_norm (select ?x3646 gidx.370149)) zero_granule_data)))
 (let (($x3540 (= (e_state_s_granule (select (g_granules (globals ?x3619)) gidx.370149)) 1)))
 (or (not $x3540) $x3618)))))))))))))))))))))))))))
 ))
 (let (($x3005 (forall ((gidx.370138 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x31821 (share ?x3570)))
 (let ((?x3616 (granule_data ?x31821)))
 (let (($x3131 (= (g_norm (select ?x3616 gidx.370138)) zero_granule_data)))
 (let (($x3559 (= (e_state_s_granule (select (g_granules (globals ?x31821)) gidx.370138)) 1)))
 (or (not $x3559) $x3131)))))))))))))))))))))))
 ))
 (or (not $x3005) $x3580))))
(assert
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x1120 (div ?x991 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x31821 (share ?x3570)))
 (let ((?x3628 (globals ?x31821)))
 (let ((?x3581 (g_granules ?x3628)))
 (let ((?x3212 (select ?x3581 ?x1120)))
 (let ((?x3625 (e_state_s_granule ?x3212)))
 (= ?x3625 1)))))))))))))))))))))))))
(assert
 (forall ((gidx.370226 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x41999 (share ?x3479)))
 (let ((?x3353 (granule_data ?x41999)))
 (let (($x3789 (= (g_norm (select ?x3353 gidx.370226)) zero_granule_data)))
 (let (($x3290 (= (e_state_s_granule (select (g_granules (globals ?x41999)) gidx.370226)) 1)))
 (=> $x3290 $x3789)))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.370261 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.370261))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x41999 (share ?x3479)))
 (let ((?x3771 (gpt ?x41999)))
 (select ?x3771 ?x1632))))))))))))))))))))))))))
 )
(assert
 (let (($x3688 (forall ((gidx.370397 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x41999 (share ?x3479)))
 (let ((?x3715 (log ?x3479)))
 (let ((?x3208 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!2
                       0
                       64
                       v_2.0
                       v_3.0
                       (value_RData a!4))))))
  (oracle a!5))))))_call| ?x3715)))
 (let ((?x3587 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (elem_1 (value_Tuple_abs_ret_rtt_RData
                     (rtt_walk_lock_unlock_spec_abs.0_call
                       (mkPtr "stack_s_rtt_walk" 0)
                       a!2
                       0
                       64
                       v_2.0
                       v_3.0
                       (value_RData a!4))))))
  (repl a!5))))))_call| ?x3208 ?x41999)))
 (let ((?x3471 (value_Shared ?x3587)))
 (let ((?x3797 (granule_data ?x3471)))
 (let (($x3681 (= (g_norm (select ?x3797 gidx.370397)) zero_granule_data)))
 (let (($x3684 (= (e_state_s_granule (select (g_granules (globals ?x3471)) gidx.370397)) 1)))
 (or (not $x3684) $x3681)))))))))))))))))))))))))))))))
 ))
 (let (($x2932 (forall ((gidx.370386 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x41999 (share ?x3479)))
 (let ((?x3353 (granule_data ?x41999)))
 (let (($x3789 (= (g_norm (select ?x3353 gidx.370386)) zero_granule_data)))
 (let (($x3290 (= (e_state_s_granule (select (g_granules (globals ?x41999)) gidx.370386)) 1)))
 (or (not $x3290) $x3789)))))))))))))))))))))))))))
 ))
 (or (not $x2932) $x3688))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x41999 (share ?x3479)))
 (let ((?x3612 (globals ?x41999)))
 (let ((?x3225 (g_granules ?x3612)))
 (let ((?x3795 (select ?x3225 ?x3316)))
 (let ((?x3486 (e_state_s_granule ?x3795)))
 (= ?x3486 5)))))))))))))))))))))))))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x58122 (pbase ?x3644)))
 (= ?x58122 "granules")))))))))))))))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x58953 (mod ?x3662 4096)))
 (= ?x58953 0))))))))))))))))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x59406 (e_1 ?x3391)))
 (let (($x3831 (>= ?x59406 0)))
 (let (($x55467 (<= ?x59406 3)))
 (and $x55467 $x3831))))))))))))))))))))))))))
(assert
 (let ((?x1469 (* (- 1) v_3.0)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x59406 (e_1 ?x3391)))
 (= (+ ?x59406 ?x1469) (- 1))))))))))))))))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let (($x3449 (= ?x3222 0)))
 (let ((?x3536 (meta_desc_type ?x3608)))
 (let (($x3656 (= ?x3536 0)))
 (and $x3656 $x3449)))))))))))))))))))))))))))))))))))
(assert
 (forall ((gidx.370474 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x39500 (granule_data ?x59389)))
 (let (($x38320 (= (g_norm (select ?x39500 gidx.370474)) zero_granule_data)))
 (let (($x3699 (= (e_state_s_granule (select (g_granules (globals ?x59389)) gidx.370474)) 1)))
 (=> $x3699 $x38320)))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.370509 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.370509))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x3897 (gpt ?x59389)))
 (select ?x3897 ?x1632))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x3753 (forall ((gidx.370645 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3663 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
  (oracle (value_RData a!7)))))))))_call| ?x38821)))
 (let ((?x4033 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
  (repl (value_RData a!7)))))))))_call| ?x3663 ?x59389)))
 (let ((?x4026 (value_Shared ?x4033)))
 (let ((?x3968 (granule_data ?x4026)))
 (let (($x4042 (= (g_norm (select ?x3968 gidx.370645)) zero_granule_data)))
 (let (($x3991 (= (e_state_s_granule (select (g_granules (globals ?x4026)) gidx.370645)) 1)))
 (or (not $x3991) $x4042)))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3953 (forall ((gidx.370634 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x39500 (granule_data ?x59389)))
 (let (($x38320 (= (g_norm (select ?x39500 gidx.370634)) zero_granule_data)))
 (let (($x3699 (= (e_state_s_granule (select (g_granules (globals ?x59389)) gidx.370634)) 1)))
 (or (not $x3699) $x38320)))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x3953) $x3753))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x3927 (select ?x38888 ?x3316)))
 (let ((?x3181 (e_state_s_granule ?x3927)))
 (= ?x3181 5)))))))))))))))))))))))))))))))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x68366 (mod ?x3507 4096)))
 (= ?x68366 8)))))))))))))))))))))))))))
(assert
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x57321 (mod ?x991 4096)))
 (= ?x57321 0)))))
(assert
 (forall ((gidx.370722 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x69597 (share ?x3777)))
 (let ((?x4048 (granule_data ?x69597)))
 (let (($x4205 (= (g_norm (select ?x4048 gidx.370722)) zero_granule_data)))
 (let (($x3498 (= (e_state_s_granule (select (g_granules (globals ?x69597)) gidx.370722)) 1)))
 (=> $x3498 $x4205))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.370757 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.370757))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x69597 (share ?x3777)))
 (let ((?x3817 (gpt ?x69597)))
 (select ?x3817 ?x1632)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x47612 (forall ((gidx.370893 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x69597 (share ?x3777)))
 (let ((?x3936 (log ?x3777)))
 (let ((?x3508 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
  (oracle (value_RData a!50))))))))))))))))_call| ?x3936)))
 (let ((?x69375 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
  (repl (value_RData a!50))))))))))))))))_call| ?x3508 ?x69597)))
 (let ((?x39707 (value_Shared ?x69375)))
 (let ((?x3860 (granule_data ?x39707)))
 (let (($x39835 (= (g_norm (select ?x3860 gidx.370893)) zero_granule_data)))
 (let (($x39818 (= (e_state_s_granule (select (g_granules (globals ?x39707)) gidx.370893)) 1)))
 (or (not $x39818) $x39835))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x47256 (forall ((gidx.370882 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x69597 (share ?x3777)))
 (let ((?x4048 (granule_data ?x69597)))
 (let (($x4205 (= (g_norm (select ?x4048 gidx.370882)) zero_granule_data)))
 (let (($x3498 (= (e_state_s_granule (select (g_granules (globals ?x69597)) gidx.370882)) 1)))
 (or (not $x3498) $x4205))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x47256) $x47612))))
(assert
 (forall ((gidx.370970 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x3352 (granule_unlock_spec.0_call ?x992 ?x3777)))
 (let ((?x4034 (value_RData ?x3352)))
 (let ((?x86109 (share ?x4034)))
 (let ((?x4384 (granule_data ?x86109)))
 (let (($x4382 (= (g_norm (select ?x4384 gidx.370970)) zero_granule_data)))
 (let (($x4329 (= (e_state_s_granule (select (g_granules (globals ?x86109)) gidx.370970)) 1)))
 (=> $x4329 $x4382))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.371005 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.371005))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x3352 (granule_unlock_spec.0_call ?x992 ?x3777)))
 (let ((?x4034 (value_RData ?x3352)))
 (let ((?x86109 (share ?x4034)))
 (let ((?x1995 (gpt ?x86109)))
 (select ?x1995 ?x1632)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x5047 (forall ((gidx.371141 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x3352 (granule_unlock_spec.0_call ?x992 ?x3777)))
 (let ((?x4034 (value_RData ?x3352)))
 (let ((?x86109 (share ?x4034)))
 (let ((?x3994 (log ?x4034)))
 (let ((?x3197 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
(let ((a!51 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              (value_RData a!50))))
  (oracle (value_RData a!51)))))))))))))))))_call| ?x3994)))
 (let ((?x3286 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
(let ((a!51 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              (value_RData a!50))))
  (repl (value_RData a!51)))))))))))))))))_call| ?x3197 ?x86109)))
 (let ((?x3291 (value_Shared ?x3286)))
 (let ((?x4357 (granule_data ?x3291)))
 (let (($x3744 (= (g_norm (select ?x4357 gidx.371141)) zero_granule_data)))
 (let (($x3672 (= (e_state_s_granule (select (g_granules (globals ?x3291)) gidx.371141)) 1)))
 (or (not $x3672) $x3744))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3959 (forall ((gidx.371130 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x3352 (granule_unlock_spec.0_call ?x992 ?x3777)))
 (let ((?x4034 (value_RData ?x3352)))
 (let ((?x86109 (share ?x4034)))
 (let ((?x4384 (granule_data ?x86109)))
 (let (($x4382 (= (g_norm (select ?x4384 gidx.371130)) zero_granule_data)))
 (let (($x4329 (= (e_state_s_granule (select (g_granules (globals ?x86109)) gidx.371130)) 1)))
 (or (not $x4329) $x4382))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x3959) $x5047))))
(assert
 (forall ((gidx.371218 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x3352 (granule_unlock_spec.0_call ?x992 ?x3777)))
 (let ((?x4034 (value_RData ?x3352)))
 (let ((?x4215 (granule_unlock_spec.0_call ?x1576 ?x4034)))
 (let ((?x4162 (value_RData ?x4215)))
 (let ((?x94885 (share ?x4162)))
 (let ((?x4501 (granule_data ?x94885)))
 (let (($x4578 (= (g_norm (select ?x4501 gidx.371218)) zero_granule_data)))
 (let (($x3853 (= (e_state_s_granule (select (g_granules (globals ?x94885)) gidx.371218)) 1)))
 (=> $x3853 $x4578))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.371253 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.371253))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x3352 (granule_unlock_spec.0_call ?x992 ?x3777)))
 (let ((?x4034 (value_RData ?x3352)))
 (let ((?x4215 (granule_unlock_spec.0_call ?x1576 ?x4034)))
 (let ((?x4162 (value_RData ?x4215)))
 (let ((?x94885 (share ?x4162)))
 (let ((?x4502 (gpt ?x94885)))
 (select ?x4502 ?x1632)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x3902 (forall ((gidx.371389 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x3352 (granule_unlock_spec.0_call ?x992 ?x3777)))
 (let ((?x4034 (value_RData ?x3352)))
 (let ((?x4215 (granule_unlock_spec.0_call ?x1576 ?x4034)))
 (let ((?x4162 (value_RData ?x4215)))
 (let ((?x94885 (share ?x4162)))
 (let ((?x4202 (log ?x4162)))
 (let ((?x3527 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
(let ((a!51 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              (value_RData a!50))))
(let ((a!52 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
              (value_RData a!51))))
  (oracle (value_RData a!52))))))))))))))))))_call| ?x4202)))
 (let ((?x4104 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!36 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                          (mkPtr (pbase a!2) (poffset a!2))
                          (value_RData a!1)))))
(let ((a!4 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!3)))
(let ((a!5 (value_Tuple_abs_ret_rtt_RData
             (rtt_walk_lock_unlock_spec_abs.0_call
               (mkPtr "stack_s_rtt_walk" 0)
               a!2
               0
               64
               v_2.0
               v_3.0
               (value_RData a!4)))))
(let ((a!6 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5)))))
      (a!33 (+ 8 (poffset (e_2 (elem_0 a!5))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (meta_ripas (abs_tte_read.0_call
                           (mkPtr "granule_data" a!6)
                           (elem_1 a!5)))
             (elem_1 a!5))))
(let ((a!8 (select (granule_data (share (value_RData a!7))) (div a!6 4096)))
      (a!11 (g_heap (globals (share (value_RData a!7)))))
      (a!12 (g_debug_exits (globals (share (value_RData a!7)))))
      (a!13 (g_vmid_count (globals (share (value_RData a!7)))))
      (a!14 (g_vmid_lock (globals (share (value_RData a!7)))))
      (a!15 (g_vmids (globals (share (value_RData a!7)))))
      (a!16 (g_nr_lrs (globals (share (value_RData a!7)))))
      (a!17 (g_nr_aprs (globals (share (value_RData a!7)))))
      (a!18 (g_max_vintid (globals (share (value_RData a!7)))))
      (a!19 (g_pri_res0_mask (globals (share (value_RData a!7)))))
      (a!20 (g_default_gicstate (globals (share (value_RData a!7)))))
      (a!21 (g_status_handler (globals (share (value_RData a!7)))))
      (a!22 (g_rmm_trap_list (globals (share (value_RData a!7)))))
      (a!23 (g_tt_l3_buffer (globals (share (value_RData a!7)))))
      (a!24 (g_tt_l2_mem0_0 (globals (share (value_RData a!7)))))
      (a!25 (g_tt_l2_mem0_1 (globals (share (value_RData a!7)))))
      (a!26 (g_tt_l2_mem1_0 (globals (share (value_RData a!7)))))
      (a!27 (g_tt_l2_mem1_1 (globals (share (value_RData a!7)))))
      (a!28 (g_tt_l2_mem1_2 (globals (share (value_RData a!7)))))
      (a!29 (g_tt_l2_mem1_3 (globals (share (value_RData a!7)))))
      (a!30 (g_tt_l1_upper (globals (share (value_RData a!7)))))
      (a!31 (g_mbedtls_mem_buf (globals (share (value_RData a!7)))))
      (a!32 (g_granules (globals (share (value_RData a!7)))))
      (a!39 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!40 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!44 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!45 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!46 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!47 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod a!6 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!34 (e_u_anon_3_0 (e_ref (select a!32 (div a!33 4096))))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div a!6 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!35 (mks_granule (e_lock (select a!32 (div a!33 4096)))
                         (e_state_s_granule (select a!32 (div a!33 4096)))
                         (mku_anon_3 (+ 1 a!34)))))
(let ((a!37 (e_lock (select (store a!32 (div a!33 4096) a!35) a!36)))
      (a!38 (e_ref (select (store a!32 (div a!33 4096) a!35) a!36))))
(let ((a!48 (mkGLOBALS a!11
                       a!12
                       a!13
                       a!14
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
                       (store (store a!32 (div a!33 4096) a!35)
                              a!36
                              (mks_granule a!37 5 a!38))
                       a!39
                       a!40
                       a!41
                       a!42
                       a!43
                       a!44
                       a!45
                       a!46
                       a!47)))
(let ((a!49 (mkShared (gpt (share (value_RData a!7))) a!10 a!48)))
(let ((a!50 (granule_unlock_spec.0_call
              (e_2 (elem_0 a!5))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
(let ((a!51 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              (value_RData a!50))))
(let ((a!52 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
              (value_RData a!51))))
  (repl (value_RData a!52))))))))))))))))))_call| ?x3527 ?x94885)))
 (let ((?x4623 (value_Shared ?x4104)))
 (let ((?x7475 (granule_data ?x4623)))
 (let (($x3444 (= (g_norm (select ?x7475 gidx.371389)) zero_granule_data)))
 (let (($x4220 (= (e_state_s_granule (select (g_granules (globals ?x4623)) gidx.371389)) 1)))
 (or (not $x4220) $x3444))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x4485 (forall ((gidx.371378 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x3352 (granule_unlock_spec.0_call ?x992 ?x3777)))
 (let ((?x4034 (value_RData ?x3352)))
 (let ((?x4215 (granule_unlock_spec.0_call ?x1576 ?x4034)))
 (let ((?x4162 (value_RData ?x4215)))
 (let ((?x94885 (share ?x4162)))
 (let ((?x4501 (granule_data ?x94885)))
 (let (($x4578 (= (g_norm (select ?x4501 gidx.371378)) zero_granule_data)))
 (let (($x3853 (= (e_state_s_granule (select (g_granules (globals ?x94885)) gidx.371378)) 1)))
 (or (not $x3853) $x4578))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x4485) $x3902))))
(assert
 (let (($x3589 (forall ((gidx.371430 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x3153 (mkPtr "granule_data" ?x1577)))
 (let ((?x3223 (rec_to_ttbr1_para.0_call ?x3153 ?x1634)))
 (let ((?x3357 (poffset ?x3223)))
 (let ((?x3156 (pbase ?x3223)))
 (let ((?x3378 (mkPtr ?x3156 ?x3357)))
 (let ((?x3092 (spinlock_acquire_spec.0_call ?x3378 ?x1634)))
 (let ((?x3425 (value_RData ?x3092)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x3287 (spinlock_acquire_spec.0_call ?x992 ?x3425)))
 (let ((?x3570 (value_RData ?x3287)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x3560 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x3223 0 64 v_2.0 v_3.0 ?x3570)))
 (let ((?x3585 (value_Tuple_abs_ret_rtt_RData ?x3560)))
 (let ((?x3479 (elem_1 ?x3585)))
 (let ((?x3391 (elem_0 ?x3585)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x3608 (abs_tte_read.0_call ?x3793 ?x3479)))
 (let ((?x3222 (meta_ripas ?x3608)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x3811 (s2tt_init_unassigned_spec.0_call ?x1388 ?x3222 ?x3479)))
 (let ((?x3660 (value_RData ?x3811)))
 (let (($x3931 (halt ?x3660)))
 (let ((?x3160 (stack ?x3660)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x3507 (+ 8 ?x3662)))
 (let ((?x4070 (div ?x3507 4096)))
 (let ((?x59389 (share ?x3660)))
 (let ((?x21737 (globals ?x59389)))
 (let ((?x38888 (g_granules ?x21737)))
 (let ((?x45392 (select ?x38888 ?x4070)))
 (let ((?x47574 (e_ref ?x45392)))
 (let ((?x46930 (e_u_anon_3_0 ?x47574)))
 (let ((?x39824 (+ 1 ?x46930)))
 (let ((?x3659 (mku_anon_3 ?x39824)))
 (let ((?x56007 (mks_granule (e_lock ?x45392) (e_state_s_granule ?x45392) ?x3659)))
 (let ((?x55908 (store ?x38888 ?x4070 ?x56007)))
 (let ((?x44192 (select ?x55908 ?x28222)))
 (let ((?x47084 (mks_granule (e_lock ?x44192) 5 (e_ref ?x44192))))
 (let ((?x47287 (store ?x55908 ?x28222 ?x47084)))
 (let ((?x4021 (mkGLOBALS (g_heap ?x21737) (g_debug_exits ?x21737) (g_vmid_count ?x21737) (g_vmid_lock ?x21737) (g_vmids ?x21737) (g_nr_lrs ?x21737) (g_nr_aprs ?x21737) (g_max_vintid ?x21737) (g_pri_res0_mask ?x21737) (g_default_gicstate ?x21737) (g_status_handler ?x21737) (g_rmm_trap_list ?x21737) (g_tt_l3_buffer ?x21737) (g_tt_l2_mem0_0 ?x21737) (g_tt_l2_mem0_1 ?x21737) (g_tt_l2_mem1_0 ?x21737) (g_tt_l2_mem1_1 ?x21737) (g_tt_l2_mem1_2 ?x21737) (g_tt_l2_mem1_3 ?x21737) (g_tt_l1_upper ?x21737) (g_mbedtls_mem_buf ?x21737) ?x47287 (g_rmm_attest_signing_key ?x21737) (g_rmm_attest_public_key ?x21737) (g_rmm_attest_public_key_len ?x21737) (g_rmm_attest_public_key_hash ?x21737) (g_rmm_attest_public_key_hash_len ?x21737) (g_platform_token_buf ?x21737) (g_rmm_platform_token ?x21737) (g_get_realm_identity_identity ?x21737) (g_realm_attest_private_key ?x21737))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x39500 (granule_data ?x59389)))
 (let ((?x3252 (select ?x39500 ?x3316)))
 (let ((?x3894 (g_norm ?x3252)))
 (let ((?x3790 (store ?x3894 ?x4176 ?x35861)))
 (let ((?x4137 (mkr_granule_data (gd_g_idx ?x3252) (g_granule_state ?x3252) ?x3790 (g_rd ?x3252) (g_rec ?x3252))))
 (let ((?x3895 (store ?x39500 ?x3316 ?x4137)))
 (let ((?x3897 (gpt ?x59389)))
 (let ((?x3899 (priv ?x3660)))
 (let ((?x3464 (repl ?x3660)))
 (let ((?x3791 (oracle ?x3660)))
 (let ((?x38821 (log ?x3660)))
 (let ((?x3103 (granule_unlock_spec.0_call ?x3644 (mkRData ?x38821 ?x3791 ?x3464 ?x3899 (mkShared ?x3897 ?x3895 ?x4021) ?x3160 $x3931))))
 (let ((?x3777 (value_RData ?x3103)))
 (let ((?x3352 (granule_unlock_spec.0_call ?x992 ?x3777)))
 (let ((?x4034 (value_RData ?x3352)))
 (let ((?x4215 (granule_unlock_spec.0_call ?x1576 ?x4034)))
 (let ((?x4162 (value_RData ?x4215)))
 (let ((?x94885 (share ?x4162)))
 (let ((?x4501 (granule_data ?x94885)))
 (let (($x4578 (= (g_norm (select ?x4501 gidx.371430)) zero_granule_data)))
 (let (($x3853 (= (e_state_s_granule (select (g_granules (globals ?x94885)) gidx.371430)) 1)))
 (=> $x3853 $x4578))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (not $x3589)))
(check-sat)
