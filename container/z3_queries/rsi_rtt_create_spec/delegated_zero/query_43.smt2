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
 (declare-datatypes ((Tuple_bool_Z_RData 0)) (((mkTuple_bool_Z_RData (elem_0 Bool) (elem_1 Int) (elem_2 RData)))))
 (declare-datatypes ((Option_Tuple_bool_Z_RData 0)) (((Some_Tuple_bool_Z_RData (value_Tuple_bool_Z_RData Tuple_bool_Z_RData)) (None_Tuple_bool_Z_RData))))
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
(declare-fun granule_unlock_spec.0_call (Ptr RData) Option_RData)
(declare-fun pack_struct_return_code_para.0_call (Int) Int)
(declare-fun make_return_code_para.0_call (Int) Int)
(declare-fun abs_tte_read.0_call (Ptr RData) abs_PTE_t)
(declare-fun test_PTE_Z.0_call (abs_PTE_t) Int)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!6 (exists ((__return___0.363915 Bool)
                    (__retval___0.363915 Int)
                    (st_5.363915 RData))
             (! (let ((a!1 (exists ((__return___0.363881 Bool)
                                    (__retval___0.363881 Int)
                                    (st_5.363881 RData))
                             (! (let ((a!1 (exists ((st_6.363870 RData))
                                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                             (mkPtr "granules"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_1_Zptr.0)))
                                                             st.0)))
                                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                                             (mkPtr "granule_data"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_1_Zptr.0)))
                                                             (value_RData a!1))))
                                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                          (mkPtr (pbase a!2)
                                                                                 (poffset a!2))
                                                                          (value_RData a!1)))))
                                                (let ((a!4 (spinlock_acquire_spec.0_call
                                                             (mkPtr "granules"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_0_Zptr.0)))
                                                             a!3)))
                                                (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                             (rtt_walk_lock_unlock_spec_abs.0_call
                                                               (mkPtr "stack_s_rtt_walk"
                                                                      0)
                                                               a!2
                                                               0
                                                               64
                                                               v_2.0
                                                               v_3.0
                                                               (value_RData a!4)))))
                                                  (= (Some_RData st_6.363870)
                                                     (granule_unlock_spec.0_call
                                                       (e_2 (elem_0 a!5))
                                                       (elem_1 a!5))))))))
                                                :weight 0)))
                                      (a!3 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (and a!1
                                                (exists ((st_7.363866 RData))
                                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_1_Zptr.0)))
                                                                  st.0)))
                                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                  (mkPtr "granule_data"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_1_Zptr.0)))
                                                                  (value_RData a!1))))
                                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                               (mkPtr (pbase a!2)
                                                                                      (poffset a!2))
                                                                               (value_RData a!1)))))
                                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_0_Zptr.0)))
                                                                  a!3)))
                                                     (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                  (rtt_walk_lock_unlock_spec_abs.0_call
                                                                    (mkPtr "stack_s_rtt_walk"
                                                                           0)
                                                                    a!2
                                                                    0
                                                                    64
                                                                    v_2.0
                                                                    v_3.0
                                                                    (value_RData a!4)))))
                                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                               (e_2 (elem_0 a!5))
                                                                               (elem_1 a!5)))))
                                                     (let ((a!7 (granule_unlock_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_0_Zptr.0)))
                                                                  a!6)))
                                                       (= (Some_RData st_7.363866)
                                                          a!7))))))))
                                                     :weight 0))))
                                      (a!4 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!3))))
                                (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!4)
                                                                 (poffset a!4))
                                                          (value_RData a!3)))))
                                (let ((a!6 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
                                             a!5)))
                                (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                             (rtt_walk_lock_unlock_spec_abs.0_call
                                               (mkPtr "stack_s_rtt_walk" 0)
                                               a!4
                                               0
                                               64
                                               v_2.0
                                               v_3.0
                                               (value_RData a!6)))))
                                (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                          (e_2 (elem_0 a!7))
                                                          (elem_1 a!7)))))
                                (let ((a!9 (granule_unlock_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
                                             a!8)))
                                (let ((a!10 (Some_Tuple_bool_Z_RData
                                              (mkTuple_bool_Z_RData
                                                true
                                                (pack_struct_return_code_para.0_call
                                                  (make_return_code_para.0_call
                                                    9))
                                                (value_RData a!9)))))
                                  (= (Some_Tuple_bool_Z_RData
                                       (mkTuple_bool_Z_RData
                                         __return___0.363881
                                         __retval___0.363881
                                         st_5.363881))
                                     (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                                :weight 0)))
                      (a!2 (exists ((st_6.363870 RData))
                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!1))))
                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!2)
                                                                 (poffset a!2))
                                                          (value_RData a!1)))))
                                (let ((a!4 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
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
                                  (= (Some_RData st_6.363870)
                                     (granule_unlock_spec.0_call
                                       (e_2 (elem_0 a!5))
                                       (elem_1 a!5))))))))
                                :weight 0)))
                      (a!4 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!3 (and a!2
                                (exists ((st_7.363866 RData))
                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  st.0)))
                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                  (mkPtr "granule_data"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  (value_RData a!1))))
                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                               (mkPtr (pbase a!2)
                                                                      (poffset a!2))
                                                               (value_RData a!1)))))
                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
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
                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                               (e_2 (elem_0 a!5))
                                                               (elem_1 a!5)))))
                                     (let ((a!7 (granule_unlock_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
                                                  a!6)))
                                       (= (Some_RData st_7.363866) a!7))))))))
                                     :weight 0))))
                      (a!5 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!4))))
                (let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!5) (poffset a!5))
                                          (value_RData a!4)))))
                (let ((a!7 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!6)))
                (let ((a!8 (value_Tuple_abs_ret_rtt_RData
                             (rtt_walk_lock_unlock_spec_abs.0_call
                               (mkPtr "stack_s_rtt_walk" 0)
                               a!5
                               0
                               64
                               v_2.0
                               v_3.0
                               (value_RData a!7)))))
                (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                          (e_2 (elem_0 a!8))
                                          (elem_1 a!8)))))
                (let ((a!10 (granule_unlock_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_0_Zptr.0)))
                              a!9)))
                (let ((a!11 (Some_Tuple_bool_Z_RData
                              (mkTuple_bool_Z_RData
                                true
                                (pack_struct_return_code_para.0_call
                                  (make_return_code_para.0_call 9))
                                (value_RData a!10)))))
                (let ((a!12 (mkTuple_bool_Z_RData
                              (elem_0 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData)))
                              (elem_1 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData)))
                              (elem_2 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData))))))
                  (= (Some_Tuple_bool_Z_RData
                       (mkTuple_bool_Z_RData
                         __return___0.363915
                         __retval___0.363915
                         st_5.363915))
                     (ite a!1
                          (Some_Tuple_bool_Z_RData a!12)
                          None_Tuple_bool_Z_RData)))))))))))
                :weight 0)))
      (a!7 (exists ((__return___0.363881 Bool)
                    (__retval___0.363881 Int)
                    (st_5.363881 RData))
             (! (let ((a!1 (exists ((st_6.363870 RData))
                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!1))))
                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!2)
                                                                 (poffset a!2))
                                                          (value_RData a!1)))))
                                (let ((a!4 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
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
                                  (= (Some_RData st_6.363870)
                                     (granule_unlock_spec.0_call
                                       (e_2 (elem_0 a!5))
                                       (elem_1 a!5))))))))
                                :weight 0)))
                      (a!3 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!2 (and a!1
                                (exists ((st_7.363866 RData))
                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  st.0)))
                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                  (mkPtr "granule_data"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  (value_RData a!1))))
                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                               (mkPtr (pbase a!2)
                                                                      (poffset a!2))
                                                               (value_RData a!1)))))
                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
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
                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                               (e_2 (elem_0 a!5))
                                                               (elem_1 a!5)))))
                                     (let ((a!7 (granule_unlock_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
                                                  a!6)))
                                       (= (Some_RData st_7.363866) a!7))))))))
                                     :weight 0))))
                      (a!4 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!3))))
                (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!4) (poffset a!4))
                                          (value_RData a!3)))))
                (let ((a!6 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!5)))
                (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                             (rtt_walk_lock_unlock_spec_abs.0_call
                               (mkPtr "stack_s_rtt_walk" 0)
                               a!4
                               0
                               64
                               v_2.0
                               v_3.0
                               (value_RData a!6)))))
                (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                          (e_2 (elem_0 a!7))
                                          (elem_1 a!7)))))
                (let ((a!9 (granule_unlock_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!8)))
                (let ((a!10 (Some_Tuple_bool_Z_RData
                              (mkTuple_bool_Z_RData
                                true
                                (pack_struct_return_code_para.0_call
                                  (make_return_code_para.0_call 9))
                                (value_RData a!9)))))
                  (= (Some_Tuple_bool_Z_RData
                       (mkTuple_bool_Z_RData
                         __return___0.363881
                         __retval___0.363881
                         st_5.363881))
                     (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                :weight 0)))
      (a!8 (exists ((st_6.363870 RData))
             (! (let ((a!1 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!2 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!1))))
                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!2) (poffset a!2))
                                          (value_RData a!1)))))
                (let ((a!4 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
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
                  (= (Some_RData st_6.363870)
                     (granule_unlock_spec.0_call
                       (e_2 (elem_0 a!5))
                       (elem_1 a!5))))))))
                :weight 0)))
      (a!17 (exists ((st_7.363910 RData))
              (! (let ((a!1 (spinlock_acquire_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_1_Zptr.0)))
                              st.0))
                       (a!6 (exists ((__return___0.363881 Bool)
                                     (__retval___0.363881 Int)
                                     (st_5.363881 RData))
                              (! (let ((a!1 (exists ((st_6.363870 RData))
                                              (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                              (mkPtr "granules"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_1_Zptr.0)))
                                                              st.0)))
                                                 (let ((a!2 (rec_to_ttbr1_para.0_call
                                                              (mkPtr "granule_data"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_1_Zptr.0)))
                                                              (value_RData a!1))))
                                                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                           (mkPtr (pbase a!2)
                                                                                  (poffset a!2))
                                                                           (value_RData a!1)))))
                                                 (let ((a!4 (spinlock_acquire_spec.0_call
                                                              (mkPtr "granules"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_0_Zptr.0)))
                                                              a!3)))
                                                 (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                              (rtt_walk_lock_unlock_spec_abs.0_call
                                                                (mkPtr "stack_s_rtt_walk"
                                                                       0)
                                                                a!2
                                                                0
                                                                64
                                                                v_2.0
                                                                v_3.0
                                                                (value_RData a!4)))))
                                                   (= (Some_RData st_6.363870)
                                                      (granule_unlock_spec.0_call
                                                        (e_2 (elem_0 a!5))
                                                        (elem_1 a!5))))))))
                                                 :weight 0)))
                                       (a!3 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              st.0)))
                                 (let ((a!2 (and a!1
                                                 (exists ((st_7.363866 RData))
                                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   st.0)))
                                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                   (mkPtr "granule_data"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   (value_RData a!1))))
                                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                (mkPtr (pbase a!2)
                                                                                       (poffset a!2))
                                                                                (value_RData a!1)))))
                                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!3)))
                                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                                     (mkPtr "stack_s_rtt_walk"
                                                                            0)
                                                                     a!2
                                                                     0
                                                                     64
                                                                     v_2.0
                                                                     v_3.0
                                                                     (value_RData a!4)))))
                                                      (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                                (e_2 (elem_0 a!5))
                                                                                (elem_1 a!5)))))
                                                      (let ((a!7 (granule_unlock_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!6)))
                                                        (= (Some_RData st_7.363866)
                                                           a!7))))))))
                                                      :weight 0))))
                                       (a!4 (rec_to_ttbr1_para.0_call
                                              (mkPtr "granule_data"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              (value_RData a!3))))
                                 (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                           (mkPtr (pbase a!4)
                                                                  (poffset a!4))
                                                           (value_RData a!3)))))
                                 (let ((a!6 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
                                              a!5)))
                                 (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                              (rtt_walk_lock_unlock_spec_abs.0_call
                                                (mkPtr "stack_s_rtt_walk" 0)
                                                a!4
                                                0
                                                64
                                                v_2.0
                                                v_3.0
                                                (value_RData a!6)))))
                                 (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                           (e_2 (elem_0 a!7))
                                                           (elem_1 a!7)))))
                                 (let ((a!9 (granule_unlock_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
                                              a!8)))
                                 (let ((a!10 (Some_Tuple_bool_Z_RData
                                               (mkTuple_bool_Z_RData
                                                 true
                                                 (pack_struct_return_code_para.0_call
                                                   (make_return_code_para.0_call
                                                     9))
                                                 (value_RData a!9)))))
                                   (= (Some_Tuple_bool_Z_RData
                                        (mkTuple_bool_Z_RData
                                          __return___0.363881
                                          __retval___0.363881
                                          st_5.363881))
                                      (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                                 :weight 0)))
                       (a!7 (exists ((st_6.363870 RData))
                              (! (let ((a!1 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              st.0)))
                                 (let ((a!2 (rec_to_ttbr1_para.0_call
                                              (mkPtr "granule_data"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              (value_RData a!1))))
                                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                           (mkPtr (pbase a!2)
                                                                  (poffset a!2))
                                                           (value_RData a!1)))))
                                 (let ((a!4 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
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
                                   (= (Some_RData st_6.363870)
                                      (granule_unlock_spec.0_call
                                        (e_2 (elem_0 a!5))
                                        (elem_1 a!5))))))))
                                 :weight 0))))
                 (let ((a!2 (rec_to_ttbr1_para.0_call
                              (mkPtr "granule_data"
                                     (meta_granule_offset
                                       (test_PA.0_call v_1_Zptr.0)))
                              (value_RData a!1)))
                       (a!8 (and a!7
                                 (exists ((st_7.363866 RData))
                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!1))))
                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!2)
                                                                       (poffset a!2))
                                                                (value_RData a!1)))))
                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!3)))
                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!2
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!4)))))
                                      (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                (e_2 (elem_0 a!5))
                                                                (elem_1 a!5)))))
                                      (let ((a!7 (granule_unlock_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!6)))
                                        (= (Some_RData st_7.363866) a!7))))))))
                                      :weight 0)))))
                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                           (mkPtr (pbase a!2) (poffset a!2))
                                           (value_RData a!1)))))
                 (let ((a!4 (spinlock_acquire_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_0_Zptr.0)))
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
                 (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                           (e_2 (elem_0 a!5))
                                           (elem_1 a!5)))))
                 (let ((a!10 (granule_unlock_spec.0_call
                               (mkPtr "granules"
                                      (meta_granule_offset
                                        (test_PA.0_call v_0_Zptr.0)))
                               a!9)))
                 (let ((a!11 (Some_Tuple_bool_Z_RData
                               (mkTuple_bool_Z_RData
                                 true
                                 (pack_struct_return_code_para.0_call
                                   (make_return_code_para.0_call 9))
                                 (value_RData a!10)))))
                 (let ((a!12 (mkTuple_bool_Z_RData
                               (elem_0 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData)))
                               (elem_1 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData)))
                               (elem_2 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData))))))
                 (let ((a!13 (elem_2 (value_Tuple_bool_Z_RData
                                       (ite a!6
                                            (Some_Tuple_bool_Z_RData a!12)
                                            None_Tuple_bool_Z_RData)))))
                   (= (Some_RData st_7.363910)
                      (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!13))))))))))))
                 :weight 0)))
      (a!29 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1)))
      (a!9 (and a!8
                (exists ((st_7.363866 RData))
                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_1_Zptr.0)))
                                  st.0)))
                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                  (mkPtr "granule_data"
                                         (meta_granule_offset
                                           (test_PA.0_call v_1_Zptr.0)))
                                  (value_RData a!1))))
                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                               (mkPtr (pbase a!2) (poffset a!2))
                                               (value_RData a!1)))))
                     (let ((a!4 (spinlock_acquire_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_0_Zptr.0)))
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
                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                               (e_2 (elem_0 a!5))
                                               (elem_1 a!5)))))
                     (let ((a!7 (granule_unlock_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_0_Zptr.0)))
                                  a!6)))
                       (= (Some_RData st_7.363866) a!7))))))))
                     :weight 0))))
      (a!18 (and a!17
                 (exists ((st_8.363906 RData))
                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                   (mkPtr "granules"
                                          (meta_granule_offset
                                            (test_PA.0_call v_1_Zptr.0)))
                                   st.0))
                            (a!6 (exists ((__return___0.363881 Bool)
                                          (__retval___0.363881 Int)
                                          (st_5.363881 RData))
                                   (! (let ((a!1 (exists ((st_6.363870 RData))
                                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   st.0)))
                                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                   (mkPtr "granule_data"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   (value_RData a!1))))
                                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                (mkPtr (pbase a!2)
                                                                                       (poffset a!2))
                                                                                (value_RData a!1)))))
                                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!3)))
                                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                                     (mkPtr "stack_s_rtt_walk"
                                                                            0)
                                                                     a!2
                                                                     0
                                                                     64
                                                                     v_2.0
                                                                     v_3.0
                                                                     (value_RData a!4)))))
                                                        (= (Some_RData st_6.363870)
                                                           (granule_unlock_spec.0_call
                                                             (e_2 (elem_0 a!5))
                                                             (elem_1 a!5))))))))
                                                      :weight 0)))
                                            (a!3 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (and a!1
                                                      (exists ((st_7.363866 RData))
                                                        (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                                        st.0)))
                                                           (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                        (mkPtr "granule_data"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                                        (value_RData a!1))))
                                                           (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                     (mkPtr (pbase a!2)
                                                                                            (poffset a!2))
                                                                                     (value_RData a!1)))))
                                                           (let ((a!4 (spinlock_acquire_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                                        a!3)))
                                                           (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                        (rtt_walk_lock_unlock_spec_abs.0_call
                                                                          (mkPtr "stack_s_rtt_walk"
                                                                                 0)
                                                                          a!2
                                                                          0
                                                                          64
                                                                          v_2.0
                                                                          v_3.0
                                                                          (value_RData a!4)))))
                                                           (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                                     (e_2 (elem_0 a!5))
                                                                                     (elem_1 a!5)))))
                                                           (let ((a!7 (granule_unlock_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                                        a!6)))
                                                             (= (Some_RData st_7.363866)
                                                                a!7))))))))
                                                           :weight 0))))
                                            (a!4 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!3))))
                                      (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!4)
                                                                       (poffset a!4))
                                                                (value_RData a!3)))))
                                      (let ((a!6 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!5)))
                                      (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!4
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!6)))))
                                      (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                                (e_2 (elem_0 a!7))
                                                                (elem_1 a!7)))))
                                      (let ((a!9 (granule_unlock_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!8)))
                                      (let ((a!10 (Some_Tuple_bool_Z_RData
                                                    (mkTuple_bool_Z_RData
                                                      true
                                                      (pack_struct_return_code_para.0_call
                                                        (make_return_code_para.0_call
                                                          9))
                                                      (value_RData a!9)))))
                                        (= (Some_Tuple_bool_Z_RData
                                             (mkTuple_bool_Z_RData
                                               __return___0.363881
                                               __retval___0.363881
                                               st_5.363881))
                                           (ite a!2
                                                a!10
                                                None_Tuple_bool_Z_RData))))))))))
                                      :weight 0)))
                            (a!7 (exists ((st_6.363870 RData))
                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!1))))
                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!2)
                                                                       (poffset a!2))
                                                                (value_RData a!1)))))
                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!3)))
                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!2
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!4)))))
                                        (= (Some_RData st_6.363870)
                                           (granule_unlock_spec.0_call
                                             (e_2 (elem_0 a!5))
                                             (elem_1 a!5))))))))
                                      :weight 0))))
                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                   (mkPtr "granule_data"
                                          (meta_granule_offset
                                            (test_PA.0_call v_1_Zptr.0)))
                                   (value_RData a!1)))
                            (a!8 (and a!7
                                      (exists ((st_7.363866 RData))
                                        (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                        st.0)))
                                           (let ((a!2 (rec_to_ttbr1_para.0_call
                                                        (mkPtr "granule_data"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                        (value_RData a!1))))
                                           (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                     (mkPtr (pbase a!2)
                                                                            (poffset a!2))
                                                                     (value_RData a!1)))))
                                           (let ((a!4 (spinlock_acquire_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                        a!3)))
                                           (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                        (rtt_walk_lock_unlock_spec_abs.0_call
                                                          (mkPtr "stack_s_rtt_walk"
                                                                 0)
                                                          a!2
                                                          0
                                                          64
                                                          v_2.0
                                                          v_3.0
                                                          (value_RData a!4)))))
                                           (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                     (e_2 (elem_0 a!5))
                                                                     (elem_1 a!5)))))
                                           (let ((a!7 (granule_unlock_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                        a!6)))
                                             (= (Some_RData st_7.363866) a!7))))))))
                                           :weight 0)))))
                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                (mkPtr (pbase a!2)
                                                       (poffset a!2))
                                                (value_RData a!1)))))
                      (let ((a!4 (spinlock_acquire_spec.0_call
                                   (mkPtr "granules"
                                          (meta_granule_offset
                                            (test_PA.0_call v_0_Zptr.0)))
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
                      (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                                (e_2 (elem_0 a!5))
                                                (elem_1 a!5)))))
                      (let ((a!10 (granule_unlock_spec.0_call
                                    (mkPtr "granules"
                                           (meta_granule_offset
                                             (test_PA.0_call v_0_Zptr.0)))
                                    a!9)))
                      (let ((a!11 (Some_Tuple_bool_Z_RData
                                    (mkTuple_bool_Z_RData
                                      true
                                      (pack_struct_return_code_para.0_call
                                        (make_return_code_para.0_call 9))
                                      (value_RData a!10)))))
                      (let ((a!12 (mkTuple_bool_Z_RData
                                    (elem_0 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData)))
                                    (elem_1 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData)))
                                    (elem_2 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData))))))
                      (let ((a!13 (elem_2 (value_Tuple_bool_Z_RData
                                            (ite a!6
                                                 (Some_Tuple_bool_Z_RData a!12)
                                                 None_Tuple_bool_Z_RData)))))
                      (let ((a!14 (value_RData (granule_unlock_spec.0_call
                                                 (e_2 (elem_0 a!5))
                                                 a!13))))
                      (let ((a!15 (granule_unlock_spec.0_call
                                    (mkPtr "granules"
                                           (meta_granule_offset
                                             (test_PA.0_call v_0_Zptr.0)))
                                    a!14)))
                        (= (Some_RData st_8.363906) a!15)))))))))))))
                      :weight 0)))))
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
(let ((a!10 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (elem_1 a!5))))
      (a!25 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5))))))
(let ((a!11 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              a!10)))
(let ((a!12 (Some_Tuple_bool_Z_RData
              (mkTuple_bool_Z_RData
                true
                (pack_struct_return_code_para.0_call
                  (make_return_code_para.0_call 9))
                (value_RData a!11)))))
(let ((a!13 (mkTuple_bool_Z_RData
              (elem_0 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData)))
              (elem_1 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData)))
              (elem_2 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData))))))
(let ((a!14 (elem_0 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData))))
      (a!15 (elem_1 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData))))
      (a!16 (elem_2 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData)))))
(let ((a!19 (value_RData (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!16))))
(let ((a!20 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              a!19)))
(let ((a!21 (Some_Tuple_bool_Z_RData
              (mkTuple_bool_Z_RData
                true
                (pack_struct_return_code_para.0_call
                  (make_return_code_para.0_call 8))
                (value_RData a!20)))))
(let ((a!22 (ite a!6
                 (ite a!14
                      (Some_Tuple_bool_Z_RData
                        (mkTuple_bool_Z_RData true a!15 a!16))
                      (ite a!18 a!21 None_Tuple_bool_Z_RData))
                 None_Tuple_bool_Z_RData)))
(let ((a!23 (gpt (share (elem_2 (value_Tuple_bool_Z_RData a!22)))))
      (a!24 (granule_data (share (elem_2 (value_Tuple_bool_Z_RData a!22)))))
      (a!28 (globals (share (elem_2 (value_Tuple_bool_Z_RData a!22))))))
(let ((a!26 (store (g_norm (select a!24 (div a!25 4096)))
                   (mod a!25 4096)
                   (test_PTE_Z.0_call
                     (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!30 (mks_granule (e_lock (select (g_granules a!28) a!29))
                         5
                         (e_ref (select (g_granules a!28) a!29)))))
(let ((a!27 (mkr_granule_data (gd_g_idx (select a!24 (div a!25 4096)))
                              (g_granule_state (select a!24 (div a!25 4096)))
                              a!26
                              (g_rd (select a!24 (div a!25 4096)))
                              (g_rec (select a!24 (div a!25 4096))))))
(let ((a!31 (mkShared a!23
                      (store a!24 (div a!25 4096) a!27)
                      (mkGLOBALS (g_heap a!28)
                                 (g_debug_exits a!28)
                                 (g_vmid_count a!28)
                                 (g_vmid_lock a!28)
                                 (g_vmids a!28)
                                 (g_nr_lrs a!28)
                                 (g_nr_aprs a!28)
                                 (g_max_vintid a!28)
                                 (g_pri_res0_mask a!28)
                                 (g_default_gicstate a!28)
                                 (g_status_handler a!28)
                                 (g_rmm_trap_list a!28)
                                 (g_tt_l3_buffer a!28)
                                 (g_tt_l2_mem0_0 a!28)
                                 (g_tt_l2_mem0_1 a!28)
                                 (g_tt_l2_mem1_0 a!28)
                                 (g_tt_l2_mem1_1 a!28)
                                 (g_tt_l2_mem1_2 a!28)
                                 (g_tt_l2_mem1_3 a!28)
                                 (g_tt_l1_upper a!28)
                                 (g_mbedtls_mem_buf a!28)
                                 (store (g_granules a!28) a!29 a!30)
                                 (g_rmm_attest_signing_key a!28)
                                 (g_rmm_attest_public_key a!28)
                                 (g_rmm_attest_public_key_len a!28)
                                 (g_rmm_attest_public_key_hash a!28)
                                 (g_rmm_attest_public_key_hash_len a!28)
                                 (g_platform_token_buf a!28)
                                 (g_rmm_platform_token a!28)
                                 (g_get_realm_identity_identity a!28)
                                 (g_realm_attest_private_key a!28)))))
(let ((a!32 (mkRData (log (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (oracle (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (repl (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (priv (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     a!31
                     (stack (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (halt (elem_2 (value_Tuple_bool_Z_RData a!22))))))
(let ((a!33 (value_RData (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!32))))
  (repl a!33)))))))))))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!6 (exists ((__return___0.363915 Bool)
                    (__retval___0.363915 Int)
                    (st_5.363915 RData))
             (! (let ((a!1 (exists ((__return___0.363881 Bool)
                                    (__retval___0.363881 Int)
                                    (st_5.363881 RData))
                             (! (let ((a!1 (exists ((st_6.363870 RData))
                                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                             (mkPtr "granules"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_1_Zptr.0)))
                                                             st.0)))
                                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                                             (mkPtr "granule_data"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_1_Zptr.0)))
                                                             (value_RData a!1))))
                                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                          (mkPtr (pbase a!2)
                                                                                 (poffset a!2))
                                                                          (value_RData a!1)))))
                                                (let ((a!4 (spinlock_acquire_spec.0_call
                                                             (mkPtr "granules"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_0_Zptr.0)))
                                                             a!3)))
                                                (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                             (rtt_walk_lock_unlock_spec_abs.0_call
                                                               (mkPtr "stack_s_rtt_walk"
                                                                      0)
                                                               a!2
                                                               0
                                                               64
                                                               v_2.0
                                                               v_3.0
                                                               (value_RData a!4)))))
                                                  (= (Some_RData st_6.363870)
                                                     (granule_unlock_spec.0_call
                                                       (e_2 (elem_0 a!5))
                                                       (elem_1 a!5))))))))
                                                :weight 0)))
                                      (a!3 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (and a!1
                                                (exists ((st_7.363866 RData))
                                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_1_Zptr.0)))
                                                                  st.0)))
                                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                  (mkPtr "granule_data"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_1_Zptr.0)))
                                                                  (value_RData a!1))))
                                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                               (mkPtr (pbase a!2)
                                                                                      (poffset a!2))
                                                                               (value_RData a!1)))))
                                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_0_Zptr.0)))
                                                                  a!3)))
                                                     (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                  (rtt_walk_lock_unlock_spec_abs.0_call
                                                                    (mkPtr "stack_s_rtt_walk"
                                                                           0)
                                                                    a!2
                                                                    0
                                                                    64
                                                                    v_2.0
                                                                    v_3.0
                                                                    (value_RData a!4)))))
                                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                               (e_2 (elem_0 a!5))
                                                                               (elem_1 a!5)))))
                                                     (let ((a!7 (granule_unlock_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_0_Zptr.0)))
                                                                  a!6)))
                                                       (= (Some_RData st_7.363866)
                                                          a!7))))))))
                                                     :weight 0))))
                                      (a!4 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!3))))
                                (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!4)
                                                                 (poffset a!4))
                                                          (value_RData a!3)))))
                                (let ((a!6 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
                                             a!5)))
                                (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                             (rtt_walk_lock_unlock_spec_abs.0_call
                                               (mkPtr "stack_s_rtt_walk" 0)
                                               a!4
                                               0
                                               64
                                               v_2.0
                                               v_3.0
                                               (value_RData a!6)))))
                                (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                          (e_2 (elem_0 a!7))
                                                          (elem_1 a!7)))))
                                (let ((a!9 (granule_unlock_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
                                             a!8)))
                                (let ((a!10 (Some_Tuple_bool_Z_RData
                                              (mkTuple_bool_Z_RData
                                                true
                                                (pack_struct_return_code_para.0_call
                                                  (make_return_code_para.0_call
                                                    9))
                                                (value_RData a!9)))))
                                  (= (Some_Tuple_bool_Z_RData
                                       (mkTuple_bool_Z_RData
                                         __return___0.363881
                                         __retval___0.363881
                                         st_5.363881))
                                     (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                                :weight 0)))
                      (a!2 (exists ((st_6.363870 RData))
                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!1))))
                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!2)
                                                                 (poffset a!2))
                                                          (value_RData a!1)))))
                                (let ((a!4 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
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
                                  (= (Some_RData st_6.363870)
                                     (granule_unlock_spec.0_call
                                       (e_2 (elem_0 a!5))
                                       (elem_1 a!5))))))))
                                :weight 0)))
                      (a!4 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!3 (and a!2
                                (exists ((st_7.363866 RData))
                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  st.0)))
                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                  (mkPtr "granule_data"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  (value_RData a!1))))
                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                               (mkPtr (pbase a!2)
                                                                      (poffset a!2))
                                                               (value_RData a!1)))))
                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
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
                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                               (e_2 (elem_0 a!5))
                                                               (elem_1 a!5)))))
                                     (let ((a!7 (granule_unlock_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
                                                  a!6)))
                                       (= (Some_RData st_7.363866) a!7))))))))
                                     :weight 0))))
                      (a!5 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!4))))
                (let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!5) (poffset a!5))
                                          (value_RData a!4)))))
                (let ((a!7 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!6)))
                (let ((a!8 (value_Tuple_abs_ret_rtt_RData
                             (rtt_walk_lock_unlock_spec_abs.0_call
                               (mkPtr "stack_s_rtt_walk" 0)
                               a!5
                               0
                               64
                               v_2.0
                               v_3.0
                               (value_RData a!7)))))
                (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                          (e_2 (elem_0 a!8))
                                          (elem_1 a!8)))))
                (let ((a!10 (granule_unlock_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_0_Zptr.0)))
                              a!9)))
                (let ((a!11 (Some_Tuple_bool_Z_RData
                              (mkTuple_bool_Z_RData
                                true
                                (pack_struct_return_code_para.0_call
                                  (make_return_code_para.0_call 9))
                                (value_RData a!10)))))
                (let ((a!12 (mkTuple_bool_Z_RData
                              (elem_0 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData)))
                              (elem_1 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData)))
                              (elem_2 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData))))))
                  (= (Some_Tuple_bool_Z_RData
                       (mkTuple_bool_Z_RData
                         __return___0.363915
                         __retval___0.363915
                         st_5.363915))
                     (ite a!1
                          (Some_Tuple_bool_Z_RData a!12)
                          None_Tuple_bool_Z_RData)))))))))))
                :weight 0)))
      (a!7 (exists ((__return___0.363881 Bool)
                    (__retval___0.363881 Int)
                    (st_5.363881 RData))
             (! (let ((a!1 (exists ((st_6.363870 RData))
                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!1))))
                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!2)
                                                                 (poffset a!2))
                                                          (value_RData a!1)))))
                                (let ((a!4 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
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
                                  (= (Some_RData st_6.363870)
                                     (granule_unlock_spec.0_call
                                       (e_2 (elem_0 a!5))
                                       (elem_1 a!5))))))))
                                :weight 0)))
                      (a!3 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!2 (and a!1
                                (exists ((st_7.363866 RData))
                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  st.0)))
                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                  (mkPtr "granule_data"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  (value_RData a!1))))
                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                               (mkPtr (pbase a!2)
                                                                      (poffset a!2))
                                                               (value_RData a!1)))))
                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
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
                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                               (e_2 (elem_0 a!5))
                                                               (elem_1 a!5)))))
                                     (let ((a!7 (granule_unlock_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
                                                  a!6)))
                                       (= (Some_RData st_7.363866) a!7))))))))
                                     :weight 0))))
                      (a!4 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!3))))
                (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!4) (poffset a!4))
                                          (value_RData a!3)))))
                (let ((a!6 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!5)))
                (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                             (rtt_walk_lock_unlock_spec_abs.0_call
                               (mkPtr "stack_s_rtt_walk" 0)
                               a!4
                               0
                               64
                               v_2.0
                               v_3.0
                               (value_RData a!6)))))
                (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                          (e_2 (elem_0 a!7))
                                          (elem_1 a!7)))))
                (let ((a!9 (granule_unlock_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!8)))
                (let ((a!10 (Some_Tuple_bool_Z_RData
                              (mkTuple_bool_Z_RData
                                true
                                (pack_struct_return_code_para.0_call
                                  (make_return_code_para.0_call 9))
                                (value_RData a!9)))))
                  (= (Some_Tuple_bool_Z_RData
                       (mkTuple_bool_Z_RData
                         __return___0.363881
                         __retval___0.363881
                         st_5.363881))
                     (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                :weight 0)))
      (a!8 (exists ((st_6.363870 RData))
             (! (let ((a!1 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!2 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!1))))
                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!2) (poffset a!2))
                                          (value_RData a!1)))))
                (let ((a!4 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
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
                  (= (Some_RData st_6.363870)
                     (granule_unlock_spec.0_call
                       (e_2 (elem_0 a!5))
                       (elem_1 a!5))))))))
                :weight 0)))
      (a!17 (exists ((st_7.363910 RData))
              (! (let ((a!1 (spinlock_acquire_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_1_Zptr.0)))
                              st.0))
                       (a!6 (exists ((__return___0.363881 Bool)
                                     (__retval___0.363881 Int)
                                     (st_5.363881 RData))
                              (! (let ((a!1 (exists ((st_6.363870 RData))
                                              (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                              (mkPtr "granules"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_1_Zptr.0)))
                                                              st.0)))
                                                 (let ((a!2 (rec_to_ttbr1_para.0_call
                                                              (mkPtr "granule_data"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_1_Zptr.0)))
                                                              (value_RData a!1))))
                                                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                           (mkPtr (pbase a!2)
                                                                                  (poffset a!2))
                                                                           (value_RData a!1)))))
                                                 (let ((a!4 (spinlock_acquire_spec.0_call
                                                              (mkPtr "granules"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_0_Zptr.0)))
                                                              a!3)))
                                                 (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                              (rtt_walk_lock_unlock_spec_abs.0_call
                                                                (mkPtr "stack_s_rtt_walk"
                                                                       0)
                                                                a!2
                                                                0
                                                                64
                                                                v_2.0
                                                                v_3.0
                                                                (value_RData a!4)))))
                                                   (= (Some_RData st_6.363870)
                                                      (granule_unlock_spec.0_call
                                                        (e_2 (elem_0 a!5))
                                                        (elem_1 a!5))))))))
                                                 :weight 0)))
                                       (a!3 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              st.0)))
                                 (let ((a!2 (and a!1
                                                 (exists ((st_7.363866 RData))
                                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   st.0)))
                                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                   (mkPtr "granule_data"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   (value_RData a!1))))
                                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                (mkPtr (pbase a!2)
                                                                                       (poffset a!2))
                                                                                (value_RData a!1)))))
                                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!3)))
                                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                                     (mkPtr "stack_s_rtt_walk"
                                                                            0)
                                                                     a!2
                                                                     0
                                                                     64
                                                                     v_2.0
                                                                     v_3.0
                                                                     (value_RData a!4)))))
                                                      (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                                (e_2 (elem_0 a!5))
                                                                                (elem_1 a!5)))))
                                                      (let ((a!7 (granule_unlock_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!6)))
                                                        (= (Some_RData st_7.363866)
                                                           a!7))))))))
                                                      :weight 0))))
                                       (a!4 (rec_to_ttbr1_para.0_call
                                              (mkPtr "granule_data"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              (value_RData a!3))))
                                 (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                           (mkPtr (pbase a!4)
                                                                  (poffset a!4))
                                                           (value_RData a!3)))))
                                 (let ((a!6 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
                                              a!5)))
                                 (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                              (rtt_walk_lock_unlock_spec_abs.0_call
                                                (mkPtr "stack_s_rtt_walk" 0)
                                                a!4
                                                0
                                                64
                                                v_2.0
                                                v_3.0
                                                (value_RData a!6)))))
                                 (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                           (e_2 (elem_0 a!7))
                                                           (elem_1 a!7)))))
                                 (let ((a!9 (granule_unlock_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
                                              a!8)))
                                 (let ((a!10 (Some_Tuple_bool_Z_RData
                                               (mkTuple_bool_Z_RData
                                                 true
                                                 (pack_struct_return_code_para.0_call
                                                   (make_return_code_para.0_call
                                                     9))
                                                 (value_RData a!9)))))
                                   (= (Some_Tuple_bool_Z_RData
                                        (mkTuple_bool_Z_RData
                                          __return___0.363881
                                          __retval___0.363881
                                          st_5.363881))
                                      (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                                 :weight 0)))
                       (a!7 (exists ((st_6.363870 RData))
                              (! (let ((a!1 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              st.0)))
                                 (let ((a!2 (rec_to_ttbr1_para.0_call
                                              (mkPtr "granule_data"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              (value_RData a!1))))
                                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                           (mkPtr (pbase a!2)
                                                                  (poffset a!2))
                                                           (value_RData a!1)))))
                                 (let ((a!4 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
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
                                   (= (Some_RData st_6.363870)
                                      (granule_unlock_spec.0_call
                                        (e_2 (elem_0 a!5))
                                        (elem_1 a!5))))))))
                                 :weight 0))))
                 (let ((a!2 (rec_to_ttbr1_para.0_call
                              (mkPtr "granule_data"
                                     (meta_granule_offset
                                       (test_PA.0_call v_1_Zptr.0)))
                              (value_RData a!1)))
                       (a!8 (and a!7
                                 (exists ((st_7.363866 RData))
                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!1))))
                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!2)
                                                                       (poffset a!2))
                                                                (value_RData a!1)))))
                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!3)))
                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!2
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!4)))))
                                      (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                (e_2 (elem_0 a!5))
                                                                (elem_1 a!5)))))
                                      (let ((a!7 (granule_unlock_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!6)))
                                        (= (Some_RData st_7.363866) a!7))))))))
                                      :weight 0)))))
                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                           (mkPtr (pbase a!2) (poffset a!2))
                                           (value_RData a!1)))))
                 (let ((a!4 (spinlock_acquire_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_0_Zptr.0)))
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
                 (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                           (e_2 (elem_0 a!5))
                                           (elem_1 a!5)))))
                 (let ((a!10 (granule_unlock_spec.0_call
                               (mkPtr "granules"
                                      (meta_granule_offset
                                        (test_PA.0_call v_0_Zptr.0)))
                               a!9)))
                 (let ((a!11 (Some_Tuple_bool_Z_RData
                               (mkTuple_bool_Z_RData
                                 true
                                 (pack_struct_return_code_para.0_call
                                   (make_return_code_para.0_call 9))
                                 (value_RData a!10)))))
                 (let ((a!12 (mkTuple_bool_Z_RData
                               (elem_0 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData)))
                               (elem_1 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData)))
                               (elem_2 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData))))))
                 (let ((a!13 (elem_2 (value_Tuple_bool_Z_RData
                                       (ite a!6
                                            (Some_Tuple_bool_Z_RData a!12)
                                            None_Tuple_bool_Z_RData)))))
                   (= (Some_RData st_7.363910)
                      (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!13))))))))))))
                 :weight 0)))
      (a!29 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1)))
      (a!9 (and a!8
                (exists ((st_7.363866 RData))
                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_1_Zptr.0)))
                                  st.0)))
                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                  (mkPtr "granule_data"
                                         (meta_granule_offset
                                           (test_PA.0_call v_1_Zptr.0)))
                                  (value_RData a!1))))
                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                               (mkPtr (pbase a!2) (poffset a!2))
                                               (value_RData a!1)))))
                     (let ((a!4 (spinlock_acquire_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_0_Zptr.0)))
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
                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                               (e_2 (elem_0 a!5))
                                               (elem_1 a!5)))))
                     (let ((a!7 (granule_unlock_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_0_Zptr.0)))
                                  a!6)))
                       (= (Some_RData st_7.363866) a!7))))))))
                     :weight 0))))
      (a!18 (and a!17
                 (exists ((st_8.363906 RData))
                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                   (mkPtr "granules"
                                          (meta_granule_offset
                                            (test_PA.0_call v_1_Zptr.0)))
                                   st.0))
                            (a!6 (exists ((__return___0.363881 Bool)
                                          (__retval___0.363881 Int)
                                          (st_5.363881 RData))
                                   (! (let ((a!1 (exists ((st_6.363870 RData))
                                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   st.0)))
                                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                   (mkPtr "granule_data"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   (value_RData a!1))))
                                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                (mkPtr (pbase a!2)
                                                                                       (poffset a!2))
                                                                                (value_RData a!1)))))
                                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!3)))
                                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                                     (mkPtr "stack_s_rtt_walk"
                                                                            0)
                                                                     a!2
                                                                     0
                                                                     64
                                                                     v_2.0
                                                                     v_3.0
                                                                     (value_RData a!4)))))
                                                        (= (Some_RData st_6.363870)
                                                           (granule_unlock_spec.0_call
                                                             (e_2 (elem_0 a!5))
                                                             (elem_1 a!5))))))))
                                                      :weight 0)))
                                            (a!3 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (and a!1
                                                      (exists ((st_7.363866 RData))
                                                        (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                                        st.0)))
                                                           (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                        (mkPtr "granule_data"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                                        (value_RData a!1))))
                                                           (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                     (mkPtr (pbase a!2)
                                                                                            (poffset a!2))
                                                                                     (value_RData a!1)))))
                                                           (let ((a!4 (spinlock_acquire_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                                        a!3)))
                                                           (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                        (rtt_walk_lock_unlock_spec_abs.0_call
                                                                          (mkPtr "stack_s_rtt_walk"
                                                                                 0)
                                                                          a!2
                                                                          0
                                                                          64
                                                                          v_2.0
                                                                          v_3.0
                                                                          (value_RData a!4)))))
                                                           (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                                     (e_2 (elem_0 a!5))
                                                                                     (elem_1 a!5)))))
                                                           (let ((a!7 (granule_unlock_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                                        a!6)))
                                                             (= (Some_RData st_7.363866)
                                                                a!7))))))))
                                                           :weight 0))))
                                            (a!4 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!3))))
                                      (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!4)
                                                                       (poffset a!4))
                                                                (value_RData a!3)))))
                                      (let ((a!6 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!5)))
                                      (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!4
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!6)))))
                                      (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                                (e_2 (elem_0 a!7))
                                                                (elem_1 a!7)))))
                                      (let ((a!9 (granule_unlock_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!8)))
                                      (let ((a!10 (Some_Tuple_bool_Z_RData
                                                    (mkTuple_bool_Z_RData
                                                      true
                                                      (pack_struct_return_code_para.0_call
                                                        (make_return_code_para.0_call
                                                          9))
                                                      (value_RData a!9)))))
                                        (= (Some_Tuple_bool_Z_RData
                                             (mkTuple_bool_Z_RData
                                               __return___0.363881
                                               __retval___0.363881
                                               st_5.363881))
                                           (ite a!2
                                                a!10
                                                None_Tuple_bool_Z_RData))))))))))
                                      :weight 0)))
                            (a!7 (exists ((st_6.363870 RData))
                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!1))))
                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!2)
                                                                       (poffset a!2))
                                                                (value_RData a!1)))))
                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!3)))
                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!2
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!4)))))
                                        (= (Some_RData st_6.363870)
                                           (granule_unlock_spec.0_call
                                             (e_2 (elem_0 a!5))
                                             (elem_1 a!5))))))))
                                      :weight 0))))
                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                   (mkPtr "granule_data"
                                          (meta_granule_offset
                                            (test_PA.0_call v_1_Zptr.0)))
                                   (value_RData a!1)))
                            (a!8 (and a!7
                                      (exists ((st_7.363866 RData))
                                        (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                        st.0)))
                                           (let ((a!2 (rec_to_ttbr1_para.0_call
                                                        (mkPtr "granule_data"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                        (value_RData a!1))))
                                           (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                     (mkPtr (pbase a!2)
                                                                            (poffset a!2))
                                                                     (value_RData a!1)))))
                                           (let ((a!4 (spinlock_acquire_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                        a!3)))
                                           (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                        (rtt_walk_lock_unlock_spec_abs.0_call
                                                          (mkPtr "stack_s_rtt_walk"
                                                                 0)
                                                          a!2
                                                          0
                                                          64
                                                          v_2.0
                                                          v_3.0
                                                          (value_RData a!4)))))
                                           (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                     (e_2 (elem_0 a!5))
                                                                     (elem_1 a!5)))))
                                           (let ((a!7 (granule_unlock_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                        a!6)))
                                             (= (Some_RData st_7.363866) a!7))))))))
                                           :weight 0)))))
                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                (mkPtr (pbase a!2)
                                                       (poffset a!2))
                                                (value_RData a!1)))))
                      (let ((a!4 (spinlock_acquire_spec.0_call
                                   (mkPtr "granules"
                                          (meta_granule_offset
                                            (test_PA.0_call v_0_Zptr.0)))
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
                      (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                                (e_2 (elem_0 a!5))
                                                (elem_1 a!5)))))
                      (let ((a!10 (granule_unlock_spec.0_call
                                    (mkPtr "granules"
                                           (meta_granule_offset
                                             (test_PA.0_call v_0_Zptr.0)))
                                    a!9)))
                      (let ((a!11 (Some_Tuple_bool_Z_RData
                                    (mkTuple_bool_Z_RData
                                      true
                                      (pack_struct_return_code_para.0_call
                                        (make_return_code_para.0_call 9))
                                      (value_RData a!10)))))
                      (let ((a!12 (mkTuple_bool_Z_RData
                                    (elem_0 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData)))
                                    (elem_1 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData)))
                                    (elem_2 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData))))))
                      (let ((a!13 (elem_2 (value_Tuple_bool_Z_RData
                                            (ite a!6
                                                 (Some_Tuple_bool_Z_RData a!12)
                                                 None_Tuple_bool_Z_RData)))))
                      (let ((a!14 (value_RData (granule_unlock_spec.0_call
                                                 (e_2 (elem_0 a!5))
                                                 a!13))))
                      (let ((a!15 (granule_unlock_spec.0_call
                                    (mkPtr "granules"
                                           (meta_granule_offset
                                             (test_PA.0_call v_0_Zptr.0)))
                                    a!14)))
                        (= (Some_RData st_8.363906) a!15)))))))))))))
                      :weight 0)))))
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
(let ((a!10 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (elem_1 a!5))))
      (a!25 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5))))))
(let ((a!11 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              a!10)))
(let ((a!12 (Some_Tuple_bool_Z_RData
              (mkTuple_bool_Z_RData
                true
                (pack_struct_return_code_para.0_call
                  (make_return_code_para.0_call 9))
                (value_RData a!11)))))
(let ((a!13 (mkTuple_bool_Z_RData
              (elem_0 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData)))
              (elem_1 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData)))
              (elem_2 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData))))))
(let ((a!14 (elem_0 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData))))
      (a!15 (elem_1 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData))))
      (a!16 (elem_2 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData)))))
(let ((a!19 (value_RData (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!16))))
(let ((a!20 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              a!19)))
(let ((a!21 (Some_Tuple_bool_Z_RData
              (mkTuple_bool_Z_RData
                true
                (pack_struct_return_code_para.0_call
                  (make_return_code_para.0_call 8))
                (value_RData a!20)))))
(let ((a!22 (ite a!6
                 (ite a!14
                      (Some_Tuple_bool_Z_RData
                        (mkTuple_bool_Z_RData true a!15 a!16))
                      (ite a!18 a!21 None_Tuple_bool_Z_RData))
                 None_Tuple_bool_Z_RData)))
(let ((a!23 (gpt (share (elem_2 (value_Tuple_bool_Z_RData a!22)))))
      (a!24 (granule_data (share (elem_2 (value_Tuple_bool_Z_RData a!22)))))
      (a!28 (globals (share (elem_2 (value_Tuple_bool_Z_RData a!22))))))
(let ((a!26 (store (g_norm (select a!24 (div a!25 4096)))
                   (mod a!25 4096)
                   (test_PTE_Z.0_call
                     (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!30 (mks_granule (e_lock (select (g_granules a!28) a!29))
                         5
                         (e_ref (select (g_granules a!28) a!29)))))
(let ((a!27 (mkr_granule_data (gd_g_idx (select a!24 (div a!25 4096)))
                              (g_granule_state (select a!24 (div a!25 4096)))
                              a!26
                              (g_rd (select a!24 (div a!25 4096)))
                              (g_rec (select a!24 (div a!25 4096))))))
(let ((a!31 (mkShared a!23
                      (store a!24 (div a!25 4096) a!27)
                      (mkGLOBALS (g_heap a!28)
                                 (g_debug_exits a!28)
                                 (g_vmid_count a!28)
                                 (g_vmid_lock a!28)
                                 (g_vmids a!28)
                                 (g_nr_lrs a!28)
                                 (g_nr_aprs a!28)
                                 (g_max_vintid a!28)
                                 (g_pri_res0_mask a!28)
                                 (g_default_gicstate a!28)
                                 (g_status_handler a!28)
                                 (g_rmm_trap_list a!28)
                                 (g_tt_l3_buffer a!28)
                                 (g_tt_l2_mem0_0 a!28)
                                 (g_tt_l2_mem0_1 a!28)
                                 (g_tt_l2_mem1_0 a!28)
                                 (g_tt_l2_mem1_1 a!28)
                                 (g_tt_l2_mem1_2 a!28)
                                 (g_tt_l2_mem1_3 a!28)
                                 (g_tt_l1_upper a!28)
                                 (g_mbedtls_mem_buf a!28)
                                 (store (g_granules a!28) a!29 a!30)
                                 (g_rmm_attest_signing_key a!28)
                                 (g_rmm_attest_public_key a!28)
                                 (g_rmm_attest_public_key_len a!28)
                                 (g_rmm_attest_public_key_hash a!28)
                                 (g_rmm_attest_public_key_hash_len a!28)
                                 (g_platform_token_buf a!28)
                                 (g_rmm_platform_token a!28)
                                 (g_get_realm_identity_identity a!28)
                                 (g_realm_attest_private_key a!28)))))
(let ((a!32 (mkRData (log (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (oracle (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (repl (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (priv (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     a!31
                     (stack (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (halt (elem_2 (value_Tuple_bool_Z_RData a!22))))))
(let ((a!33 (value_RData (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!32))))
  (oracle a!33)))))))))))))))))))))_call| (List_Event) List_Event)
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
 (let ((?x3654 (+ ?x59406 ?x1469)))
 (let (($x3620 (= ?x3654 (- 1))))
 (not $x3620)))))))))))))))))))))))))))
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
 (let ((?x3654 (+ ?x59406 ?x1469)))
 (= ?x3654 0))))))))))))))))))))))))))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x5684 (value_RData ?x4883)))
 (let ((?x4911 (make_return_code_para.0_call 8)))
 (let ((?x5525 (pack_struct_return_code_para.0_call ?x4911)))
 (let ((?x5648 (mkTuple_bool_Z_RData true ?x5525 ?x5684)))
 (let ((?x5504 (Some_Tuple_bool_Z_RData ?x5648)))
 (let (($x49228 (exists ((st_8.363906 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x736 (Some_RData st_8.363906)))
 (= ?x736 ?x4883))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3164 (exists ((st_7.363910 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x736 (Some_RData st_7.363910)))
 (= ?x736 ?x49044))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5524 (elem_1 ?x4789)))
 (let ((?x61229 (mkTuple_bool_Z_RData true ?x5524 ?x5748)))
 (let ((?x48959 (Some_Tuple_bool_Z_RData ?x61229)))
 (let (($x4403 (elem_0 ?x4789)))
 (let ((?x41356 (ite $x4403 ?x48959 (ite (and $x3164 $x49228) ?x5504 None_Tuple_bool_Z_RData))))
 (let (($x4889 (exists ((__return___0.363915 Bool) (__retval___0.363915 Int) (st_5.363915 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363915 __retval___0.363915 st_5.363915)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5627))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x4972 (value_Tuple_bool_Z_RData (ite $x4889 ?x41356 None_Tuple_bool_Z_RData))))
 (let (($x5235 (elem_0 ?x4972)))
 (not $x5235))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x5684 (value_RData ?x4883)))
 (let ((?x4911 (make_return_code_para.0_call 8)))
 (let ((?x5525 (pack_struct_return_code_para.0_call ?x4911)))
 (let ((?x5648 (mkTuple_bool_Z_RData true ?x5525 ?x5684)))
 (let ((?x5504 (Some_Tuple_bool_Z_RData ?x5648)))
 (let (($x49228 (exists ((st_8.363906 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x736 (Some_RData st_8.363906)))
 (= ?x736 ?x4883))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3164 (exists ((st_7.363910 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x736 (Some_RData st_7.363910)))
 (= ?x736 ?x49044))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5524 (elem_1 ?x4789)))
 (let ((?x61229 (mkTuple_bool_Z_RData true ?x5524 ?x5748)))
 (let ((?x48959 (Some_Tuple_bool_Z_RData ?x61229)))
 (let (($x4403 (elem_0 ?x4789)))
 (let ((?x41356 (ite $x4403 ?x48959 (ite (and $x3164 $x49228) ?x5504 None_Tuple_bool_Z_RData))))
 (let (($x4889 (exists ((__return___0.363915 Bool) (__retval___0.363915 Int) (st_5.363915 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363915 __retval___0.363915 st_5.363915)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5627))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x4972 (value_Tuple_bool_Z_RData (ite $x4889 ?x41356 None_Tuple_bool_Z_RData))))
 (let ((?x5023 (elem_2 ?x4972)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x355108 (abs_tte_read.0_call ?x3793 ?x5023)))
 (let ((?x5110 (meta_ripas ?x355108)))
 (let (($x5883 (= ?x5110 0)))
 (let ((?x5843 (meta_desc_type ?x355108)))
 (let (($x5825 (= ?x5843 0)))
 (let (($x5762 (and $x5825 $x5883)))
 (not $x5762)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x5684 (value_RData ?x4883)))
 (let ((?x4911 (make_return_code_para.0_call 8)))
 (let ((?x5525 (pack_struct_return_code_para.0_call ?x4911)))
 (let ((?x5648 (mkTuple_bool_Z_RData true ?x5525 ?x5684)))
 (let ((?x5504 (Some_Tuple_bool_Z_RData ?x5648)))
 (let (($x49228 (exists ((st_8.363906 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x736 (Some_RData st_8.363906)))
 (= ?x736 ?x4883))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3164 (exists ((st_7.363910 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x736 (Some_RData st_7.363910)))
 (= ?x736 ?x49044))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5524 (elem_1 ?x4789)))
 (let ((?x61229 (mkTuple_bool_Z_RData true ?x5524 ?x5748)))
 (let ((?x48959 (Some_Tuple_bool_Z_RData ?x61229)))
 (let (($x4403 (elem_0 ?x4789)))
 (let ((?x41356 (ite $x4403 ?x48959 (ite (and $x3164 $x49228) ?x5504 None_Tuple_bool_Z_RData))))
 (let (($x4889 (exists ((__return___0.363915 Bool) (__retval___0.363915 Int) (st_5.363915 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363915 __retval___0.363915 st_5.363915)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5627))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x4972 (value_Tuple_bool_Z_RData (ite $x4889 ?x41356 None_Tuple_bool_Z_RData))))
 (let ((?x5023 (elem_2 ?x4972)))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3793 (mkPtr "granule_data" ?x3590)))
 (let ((?x355108 (abs_tte_read.0_call ?x3793 ?x5023)))
 (let ((?x5843 (meta_desc_type ?x355108)))
 (let (($x391869 (= ?x5843 3)))
 (not $x391869))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x57321 (mod ?x991 4096)))
 (= ?x57321 0)))))
(assert
 (forall ((gidx.375738 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x5684 (value_RData ?x4883)))
 (let ((?x4911 (make_return_code_para.0_call 8)))
 (let ((?x5525 (pack_struct_return_code_para.0_call ?x4911)))
 (let ((?x5648 (mkTuple_bool_Z_RData true ?x5525 ?x5684)))
 (let ((?x5504 (Some_Tuple_bool_Z_RData ?x5648)))
 (let (($x49228 (exists ((st_8.363906 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x736 (Some_RData st_8.363906)))
 (= ?x736 ?x4883))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3164 (exists ((st_7.363910 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x736 (Some_RData st_7.363910)))
 (= ?x736 ?x49044))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5524 (elem_1 ?x4789)))
 (let ((?x61229 (mkTuple_bool_Z_RData true ?x5524 ?x5748)))
 (let ((?x48959 (Some_Tuple_bool_Z_RData ?x61229)))
 (let (($x4403 (elem_0 ?x4789)))
 (let ((?x41356 (ite $x4403 ?x48959 (ite (and $x3164 $x49228) ?x5504 None_Tuple_bool_Z_RData))))
 (let (($x4889 (exists ((__return___0.363915 Bool) (__retval___0.363915 Int) (st_5.363915 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363915 __retval___0.363915 st_5.363915)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5627))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x4972 (value_Tuple_bool_Z_RData (ite $x4889 ?x41356 None_Tuple_bool_Z_RData))))
 (let ((?x5023 (elem_2 ?x4972)))
 (let (($x8334 (halt ?x5023)))
 (let ((?x8455 (stack ?x5023)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x5391 (share ?x5023)))
 (let ((?x23293 (globals ?x5391)))
 (let ((?x41501 (g_granules ?x23293)))
 (let ((?x6869 (select ?x41501 ?x28222)))
 (let ((?x8426 (mks_granule (e_lock ?x6869) 5 (e_ref ?x6869))))
 (let ((?x8288 (store ?x41501 ?x28222 ?x8426)))
 (let ((?x8438 (mkGLOBALS (g_heap ?x23293) (g_debug_exits ?x23293) (g_vmid_count ?x23293) (g_vmid_lock ?x23293) (g_vmids ?x23293) (g_nr_lrs ?x23293) (g_nr_aprs ?x23293) (g_max_vintid ?x23293) (g_pri_res0_mask ?x23293) (g_default_gicstate ?x23293) (g_status_handler ?x23293) (g_rmm_trap_list ?x23293) (g_tt_l3_buffer ?x23293) (g_tt_l2_mem0_0 ?x23293) (g_tt_l2_mem0_1 ?x23293) (g_tt_l2_mem1_0 ?x23293) (g_tt_l2_mem1_1 ?x23293) (g_tt_l2_mem1_2 ?x23293) (g_tt_l2_mem1_3 ?x23293) (g_tt_l1_upper ?x23293) (g_mbedtls_mem_buf ?x23293) ?x8288 (g_rmm_attest_signing_key ?x23293) (g_rmm_attest_public_key ?x23293) (g_rmm_attest_public_key_len ?x23293) (g_rmm_attest_public_key_hash ?x23293) (g_rmm_attest_public_key_hash_len ?x23293) (g_platform_token_buf ?x23293) (g_rmm_platform_token ?x23293) (g_get_realm_identity_identity ?x23293) (g_realm_attest_private_key ?x23293))))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x4671 (granule_data ?x5391)))
 (let ((?x8365 (select ?x4671 ?x3316)))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x8204 (g_norm ?x8365)))
 (let ((?x44395 (store ?x8204 ?x4176 ?x35861)))
 (let ((?x8720 (mkr_granule_data (gd_g_idx ?x8365) (g_granule_state ?x8365) ?x44395 (g_rd ?x8365) (g_rec ?x8365))))
 (let ((?x5692 (store ?x4671 ?x3316 ?x8720)))
 (let ((?x8319 (gpt ?x5391)))
 (let ((?x8200 (priv ?x5023)))
 (let ((?x8068 (repl ?x5023)))
 (let ((?x52221 (oracle ?x5023)))
 (let ((?x7365 (log ?x5023)))
 (let ((?x8753 (granule_unlock_spec.0_call ?x3644 (mkRData ?x7365 ?x52221 ?x8068 ?x8200 (mkShared ?x8319 ?x5692 ?x8438) ?x8455 $x8334))))
 (let ((?x52250 (value_RData ?x8753)))
 (let ((?x1173018 (share ?x52250)))
 (let ((?x8077 (granule_data ?x1173018)))
 (let (($x8254 (= (g_norm (select ?x8077 gidx.375738)) zero_granule_data)))
 (let (($x8101 (= (e_state_s_granule (select (g_granules (globals ?x1173018)) gidx.375738)) 1)))
 (=> $x8101 $x8254))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.375773 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.375773))) 4096)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x5684 (value_RData ?x4883)))
 (let ((?x4911 (make_return_code_para.0_call 8)))
 (let ((?x5525 (pack_struct_return_code_para.0_call ?x4911)))
 (let ((?x5648 (mkTuple_bool_Z_RData true ?x5525 ?x5684)))
 (let ((?x5504 (Some_Tuple_bool_Z_RData ?x5648)))
 (let (($x49228 (exists ((st_8.363906 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x736 (Some_RData st_8.363906)))
 (= ?x736 ?x4883))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3164 (exists ((st_7.363910 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x736 (Some_RData st_7.363910)))
 (= ?x736 ?x49044))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5524 (elem_1 ?x4789)))
 (let ((?x61229 (mkTuple_bool_Z_RData true ?x5524 ?x5748)))
 (let ((?x48959 (Some_Tuple_bool_Z_RData ?x61229)))
 (let (($x4403 (elem_0 ?x4789)))
 (let ((?x41356 (ite $x4403 ?x48959 (ite (and $x3164 $x49228) ?x5504 None_Tuple_bool_Z_RData))))
 (let (($x4889 (exists ((__return___0.363915 Bool) (__retval___0.363915 Int) (st_5.363915 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363915 __retval___0.363915 st_5.363915)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5627))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x4972 (value_Tuple_bool_Z_RData (ite $x4889 ?x41356 None_Tuple_bool_Z_RData))))
 (let ((?x5023 (elem_2 ?x4972)))
 (let (($x8334 (halt ?x5023)))
 (let ((?x8455 (stack ?x5023)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x5391 (share ?x5023)))
 (let ((?x23293 (globals ?x5391)))
 (let ((?x41501 (g_granules ?x23293)))
 (let ((?x6869 (select ?x41501 ?x28222)))
 (let ((?x8426 (mks_granule (e_lock ?x6869) 5 (e_ref ?x6869))))
 (let ((?x8288 (store ?x41501 ?x28222 ?x8426)))
 (let ((?x8438 (mkGLOBALS (g_heap ?x23293) (g_debug_exits ?x23293) (g_vmid_count ?x23293) (g_vmid_lock ?x23293) (g_vmids ?x23293) (g_nr_lrs ?x23293) (g_nr_aprs ?x23293) (g_max_vintid ?x23293) (g_pri_res0_mask ?x23293) (g_default_gicstate ?x23293) (g_status_handler ?x23293) (g_rmm_trap_list ?x23293) (g_tt_l3_buffer ?x23293) (g_tt_l2_mem0_0 ?x23293) (g_tt_l2_mem0_1 ?x23293) (g_tt_l2_mem1_0 ?x23293) (g_tt_l2_mem1_1 ?x23293) (g_tt_l2_mem1_2 ?x23293) (g_tt_l2_mem1_3 ?x23293) (g_tt_l1_upper ?x23293) (g_mbedtls_mem_buf ?x23293) ?x8288 (g_rmm_attest_signing_key ?x23293) (g_rmm_attest_public_key ?x23293) (g_rmm_attest_public_key_len ?x23293) (g_rmm_attest_public_key_hash ?x23293) (g_rmm_attest_public_key_hash_len ?x23293) (g_platform_token_buf ?x23293) (g_rmm_platform_token ?x23293) (g_get_realm_identity_identity ?x23293) (g_realm_attest_private_key ?x23293))))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x4671 (granule_data ?x5391)))
 (let ((?x8365 (select ?x4671 ?x3316)))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x8204 (g_norm ?x8365)))
 (let ((?x44395 (store ?x8204 ?x4176 ?x35861)))
 (let ((?x8720 (mkr_granule_data (gd_g_idx ?x8365) (g_granule_state ?x8365) ?x44395 (g_rd ?x8365) (g_rec ?x8365))))
 (let ((?x5692 (store ?x4671 ?x3316 ?x8720)))
 (let ((?x8319 (gpt ?x5391)))
 (let ((?x8200 (priv ?x5023)))
 (let ((?x8068 (repl ?x5023)))
 (let ((?x52221 (oracle ?x5023)))
 (let ((?x7365 (log ?x5023)))
 (let ((?x8753 (granule_unlock_spec.0_call ?x3644 (mkRData ?x7365 ?x52221 ?x8068 ?x8200 (mkShared ?x8319 ?x5692 ?x8438) ?x8455 $x8334))))
 (let ((?x52250 (value_RData ?x8753)))
 (let ((?x1173018 (share ?x52250)))
 (let ((?x43620 (gpt ?x1173018)))
 (select ?x43620 ?x1632)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x7829 (forall ((gidx.375909 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x5684 (value_RData ?x4883)))
 (let ((?x4911 (make_return_code_para.0_call 8)))
 (let ((?x5525 (pack_struct_return_code_para.0_call ?x4911)))
 (let ((?x5648 (mkTuple_bool_Z_RData true ?x5525 ?x5684)))
 (let ((?x5504 (Some_Tuple_bool_Z_RData ?x5648)))
 (let (($x49228 (exists ((st_8.363906 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x736 (Some_RData st_8.363906)))
 (= ?x736 ?x4883))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3164 (exists ((st_7.363910 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x736 (Some_RData st_7.363910)))
 (= ?x736 ?x49044))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5524 (elem_1 ?x4789)))
 (let ((?x61229 (mkTuple_bool_Z_RData true ?x5524 ?x5748)))
 (let ((?x48959 (Some_Tuple_bool_Z_RData ?x61229)))
 (let (($x4403 (elem_0 ?x4789)))
 (let ((?x41356 (ite $x4403 ?x48959 (ite (and $x3164 $x49228) ?x5504 None_Tuple_bool_Z_RData))))
 (let (($x4889 (exists ((__return___0.363915 Bool) (__retval___0.363915 Int) (st_5.363915 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363915 __retval___0.363915 st_5.363915)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5627))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x4972 (value_Tuple_bool_Z_RData (ite $x4889 ?x41356 None_Tuple_bool_Z_RData))))
 (let ((?x5023 (elem_2 ?x4972)))
 (let (($x8334 (halt ?x5023)))
 (let ((?x8455 (stack ?x5023)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x5391 (share ?x5023)))
 (let ((?x23293 (globals ?x5391)))
 (let ((?x41501 (g_granules ?x23293)))
 (let ((?x6869 (select ?x41501 ?x28222)))
 (let ((?x8426 (mks_granule (e_lock ?x6869) 5 (e_ref ?x6869))))
 (let ((?x8288 (store ?x41501 ?x28222 ?x8426)))
 (let ((?x8438 (mkGLOBALS (g_heap ?x23293) (g_debug_exits ?x23293) (g_vmid_count ?x23293) (g_vmid_lock ?x23293) (g_vmids ?x23293) (g_nr_lrs ?x23293) (g_nr_aprs ?x23293) (g_max_vintid ?x23293) (g_pri_res0_mask ?x23293) (g_default_gicstate ?x23293) (g_status_handler ?x23293) (g_rmm_trap_list ?x23293) (g_tt_l3_buffer ?x23293) (g_tt_l2_mem0_0 ?x23293) (g_tt_l2_mem0_1 ?x23293) (g_tt_l2_mem1_0 ?x23293) (g_tt_l2_mem1_1 ?x23293) (g_tt_l2_mem1_2 ?x23293) (g_tt_l2_mem1_3 ?x23293) (g_tt_l1_upper ?x23293) (g_mbedtls_mem_buf ?x23293) ?x8288 (g_rmm_attest_signing_key ?x23293) (g_rmm_attest_public_key ?x23293) (g_rmm_attest_public_key_len ?x23293) (g_rmm_attest_public_key_hash ?x23293) (g_rmm_attest_public_key_hash_len ?x23293) (g_platform_token_buf ?x23293) (g_rmm_platform_token ?x23293) (g_get_realm_identity_identity ?x23293) (g_realm_attest_private_key ?x23293))))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x4671 (granule_data ?x5391)))
 (let ((?x8365 (select ?x4671 ?x3316)))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x8204 (g_norm ?x8365)))
 (let ((?x44395 (store ?x8204 ?x4176 ?x35861)))
 (let ((?x8720 (mkr_granule_data (gd_g_idx ?x8365) (g_granule_state ?x8365) ?x44395 (g_rd ?x8365) (g_rec ?x8365))))
 (let ((?x5692 (store ?x4671 ?x3316 ?x8720)))
 (let ((?x8319 (gpt ?x5391)))
 (let ((?x8200 (priv ?x5023)))
 (let ((?x8068 (repl ?x5023)))
 (let ((?x52221 (oracle ?x5023)))
 (let ((?x7365 (log ?x5023)))
 (let ((?x8753 (granule_unlock_spec.0_call ?x3644 (mkRData ?x7365 ?x52221 ?x8068 ?x8200 (mkShared ?x8319 ?x5692 ?x8438) ?x8455 $x8334))))
 (let ((?x52250 (value_RData ?x8753)))
 (let ((?x1173018 (share ?x52250)))
 (let ((?x8051 (log ?x52250)))
 (let ((?x51764 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!6 (exists ((__return___0.363915 Bool)
                    (__retval___0.363915 Int)
                    (st_5.363915 RData))
             (! (let ((a!1 (exists ((__return___0.363881 Bool)
                                    (__retval___0.363881 Int)
                                    (st_5.363881 RData))
                             (! (let ((a!1 (exists ((st_6.363870 RData))
                                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                             (mkPtr "granules"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_1_Zptr.0)))
                                                             st.0)))
                                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                                             (mkPtr "granule_data"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_1_Zptr.0)))
                                                             (value_RData a!1))))
                                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                          (mkPtr (pbase a!2)
                                                                                 (poffset a!2))
                                                                          (value_RData a!1)))))
                                                (let ((a!4 (spinlock_acquire_spec.0_call
                                                             (mkPtr "granules"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_0_Zptr.0)))
                                                             a!3)))
                                                (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                             (rtt_walk_lock_unlock_spec_abs.0_call
                                                               (mkPtr "stack_s_rtt_walk"
                                                                      0)
                                                               a!2
                                                               0
                                                               64
                                                               v_2.0
                                                               v_3.0
                                                               (value_RData a!4)))))
                                                  (= (Some_RData st_6.363870)
                                                     (granule_unlock_spec.0_call
                                                       (e_2 (elem_0 a!5))
                                                       (elem_1 a!5))))))))
                                                :weight 0)))
                                      (a!3 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (and a!1
                                                (exists ((st_7.363866 RData))
                                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_1_Zptr.0)))
                                                                  st.0)))
                                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                  (mkPtr "granule_data"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_1_Zptr.0)))
                                                                  (value_RData a!1))))
                                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                               (mkPtr (pbase a!2)
                                                                                      (poffset a!2))
                                                                               (value_RData a!1)))))
                                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_0_Zptr.0)))
                                                                  a!3)))
                                                     (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                  (rtt_walk_lock_unlock_spec_abs.0_call
                                                                    (mkPtr "stack_s_rtt_walk"
                                                                           0)
                                                                    a!2
                                                                    0
                                                                    64
                                                                    v_2.0
                                                                    v_3.0
                                                                    (value_RData a!4)))))
                                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                               (e_2 (elem_0 a!5))
                                                                               (elem_1 a!5)))))
                                                     (let ((a!7 (granule_unlock_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_0_Zptr.0)))
                                                                  a!6)))
                                                       (= (Some_RData st_7.363866)
                                                          a!7))))))))
                                                     :weight 0))))
                                      (a!4 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!3))))
                                (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!4)
                                                                 (poffset a!4))
                                                          (value_RData a!3)))))
                                (let ((a!6 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
                                             a!5)))
                                (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                             (rtt_walk_lock_unlock_spec_abs.0_call
                                               (mkPtr "stack_s_rtt_walk" 0)
                                               a!4
                                               0
                                               64
                                               v_2.0
                                               v_3.0
                                               (value_RData a!6)))))
                                (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                          (e_2 (elem_0 a!7))
                                                          (elem_1 a!7)))))
                                (let ((a!9 (granule_unlock_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
                                             a!8)))
                                (let ((a!10 (Some_Tuple_bool_Z_RData
                                              (mkTuple_bool_Z_RData
                                                true
                                                (pack_struct_return_code_para.0_call
                                                  (make_return_code_para.0_call
                                                    9))
                                                (value_RData a!9)))))
                                  (= (Some_Tuple_bool_Z_RData
                                       (mkTuple_bool_Z_RData
                                         __return___0.363881
                                         __retval___0.363881
                                         st_5.363881))
                                     (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                                :weight 0)))
                      (a!2 (exists ((st_6.363870 RData))
                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!1))))
                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!2)
                                                                 (poffset a!2))
                                                          (value_RData a!1)))))
                                (let ((a!4 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
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
                                  (= (Some_RData st_6.363870)
                                     (granule_unlock_spec.0_call
                                       (e_2 (elem_0 a!5))
                                       (elem_1 a!5))))))))
                                :weight 0)))
                      (a!4 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!3 (and a!2
                                (exists ((st_7.363866 RData))
                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  st.0)))
                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                  (mkPtr "granule_data"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  (value_RData a!1))))
                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                               (mkPtr (pbase a!2)
                                                                      (poffset a!2))
                                                               (value_RData a!1)))))
                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
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
                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                               (e_2 (elem_0 a!5))
                                                               (elem_1 a!5)))))
                                     (let ((a!7 (granule_unlock_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
                                                  a!6)))
                                       (= (Some_RData st_7.363866) a!7))))))))
                                     :weight 0))))
                      (a!5 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!4))))
                (let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!5) (poffset a!5))
                                          (value_RData a!4)))))
                (let ((a!7 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!6)))
                (let ((a!8 (value_Tuple_abs_ret_rtt_RData
                             (rtt_walk_lock_unlock_spec_abs.0_call
                               (mkPtr "stack_s_rtt_walk" 0)
                               a!5
                               0
                               64
                               v_2.0
                               v_3.0
                               (value_RData a!7)))))
                (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                          (e_2 (elem_0 a!8))
                                          (elem_1 a!8)))))
                (let ((a!10 (granule_unlock_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_0_Zptr.0)))
                              a!9)))
                (let ((a!11 (Some_Tuple_bool_Z_RData
                              (mkTuple_bool_Z_RData
                                true
                                (pack_struct_return_code_para.0_call
                                  (make_return_code_para.0_call 9))
                                (value_RData a!10)))))
                (let ((a!12 (mkTuple_bool_Z_RData
                              (elem_0 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData)))
                              (elem_1 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData)))
                              (elem_2 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData))))))
                  (= (Some_Tuple_bool_Z_RData
                       (mkTuple_bool_Z_RData
                         __return___0.363915
                         __retval___0.363915
                         st_5.363915))
                     (ite a!1
                          (Some_Tuple_bool_Z_RData a!12)
                          None_Tuple_bool_Z_RData)))))))))))
                :weight 0)))
      (a!7 (exists ((__return___0.363881 Bool)
                    (__retval___0.363881 Int)
                    (st_5.363881 RData))
             (! (let ((a!1 (exists ((st_6.363870 RData))
                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!1))))
                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!2)
                                                                 (poffset a!2))
                                                          (value_RData a!1)))))
                                (let ((a!4 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
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
                                  (= (Some_RData st_6.363870)
                                     (granule_unlock_spec.0_call
                                       (e_2 (elem_0 a!5))
                                       (elem_1 a!5))))))))
                                :weight 0)))
                      (a!3 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!2 (and a!1
                                (exists ((st_7.363866 RData))
                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  st.0)))
                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                  (mkPtr "granule_data"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  (value_RData a!1))))
                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                               (mkPtr (pbase a!2)
                                                                      (poffset a!2))
                                                               (value_RData a!1)))))
                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
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
                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                               (e_2 (elem_0 a!5))
                                                               (elem_1 a!5)))))
                                     (let ((a!7 (granule_unlock_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
                                                  a!6)))
                                       (= (Some_RData st_7.363866) a!7))))))))
                                     :weight 0))))
                      (a!4 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!3))))
                (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!4) (poffset a!4))
                                          (value_RData a!3)))))
                (let ((a!6 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!5)))
                (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                             (rtt_walk_lock_unlock_spec_abs.0_call
                               (mkPtr "stack_s_rtt_walk" 0)
                               a!4
                               0
                               64
                               v_2.0
                               v_3.0
                               (value_RData a!6)))))
                (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                          (e_2 (elem_0 a!7))
                                          (elem_1 a!7)))))
                (let ((a!9 (granule_unlock_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!8)))
                (let ((a!10 (Some_Tuple_bool_Z_RData
                              (mkTuple_bool_Z_RData
                                true
                                (pack_struct_return_code_para.0_call
                                  (make_return_code_para.0_call 9))
                                (value_RData a!9)))))
                  (= (Some_Tuple_bool_Z_RData
                       (mkTuple_bool_Z_RData
                         __return___0.363881
                         __retval___0.363881
                         st_5.363881))
                     (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                :weight 0)))
      (a!8 (exists ((st_6.363870 RData))
             (! (let ((a!1 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!2 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!1))))
                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!2) (poffset a!2))
                                          (value_RData a!1)))))
                (let ((a!4 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
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
                  (= (Some_RData st_6.363870)
                     (granule_unlock_spec.0_call
                       (e_2 (elem_0 a!5))
                       (elem_1 a!5))))))))
                :weight 0)))
      (a!17 (exists ((st_7.363910 RData))
              (! (let ((a!1 (spinlock_acquire_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_1_Zptr.0)))
                              st.0))
                       (a!6 (exists ((__return___0.363881 Bool)
                                     (__retval___0.363881 Int)
                                     (st_5.363881 RData))
                              (! (let ((a!1 (exists ((st_6.363870 RData))
                                              (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                              (mkPtr "granules"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_1_Zptr.0)))
                                                              st.0)))
                                                 (let ((a!2 (rec_to_ttbr1_para.0_call
                                                              (mkPtr "granule_data"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_1_Zptr.0)))
                                                              (value_RData a!1))))
                                                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                           (mkPtr (pbase a!2)
                                                                                  (poffset a!2))
                                                                           (value_RData a!1)))))
                                                 (let ((a!4 (spinlock_acquire_spec.0_call
                                                              (mkPtr "granules"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_0_Zptr.0)))
                                                              a!3)))
                                                 (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                              (rtt_walk_lock_unlock_spec_abs.0_call
                                                                (mkPtr "stack_s_rtt_walk"
                                                                       0)
                                                                a!2
                                                                0
                                                                64
                                                                v_2.0
                                                                v_3.0
                                                                (value_RData a!4)))))
                                                   (= (Some_RData st_6.363870)
                                                      (granule_unlock_spec.0_call
                                                        (e_2 (elem_0 a!5))
                                                        (elem_1 a!5))))))))
                                                 :weight 0)))
                                       (a!3 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              st.0)))
                                 (let ((a!2 (and a!1
                                                 (exists ((st_7.363866 RData))
                                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   st.0)))
                                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                   (mkPtr "granule_data"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   (value_RData a!1))))
                                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                (mkPtr (pbase a!2)
                                                                                       (poffset a!2))
                                                                                (value_RData a!1)))))
                                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!3)))
                                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                                     (mkPtr "stack_s_rtt_walk"
                                                                            0)
                                                                     a!2
                                                                     0
                                                                     64
                                                                     v_2.0
                                                                     v_3.0
                                                                     (value_RData a!4)))))
                                                      (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                                (e_2 (elem_0 a!5))
                                                                                (elem_1 a!5)))))
                                                      (let ((a!7 (granule_unlock_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!6)))
                                                        (= (Some_RData st_7.363866)
                                                           a!7))))))))
                                                      :weight 0))))
                                       (a!4 (rec_to_ttbr1_para.0_call
                                              (mkPtr "granule_data"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              (value_RData a!3))))
                                 (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                           (mkPtr (pbase a!4)
                                                                  (poffset a!4))
                                                           (value_RData a!3)))))
                                 (let ((a!6 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
                                              a!5)))
                                 (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                              (rtt_walk_lock_unlock_spec_abs.0_call
                                                (mkPtr "stack_s_rtt_walk" 0)
                                                a!4
                                                0
                                                64
                                                v_2.0
                                                v_3.0
                                                (value_RData a!6)))))
                                 (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                           (e_2 (elem_0 a!7))
                                                           (elem_1 a!7)))))
                                 (let ((a!9 (granule_unlock_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
                                              a!8)))
                                 (let ((a!10 (Some_Tuple_bool_Z_RData
                                               (mkTuple_bool_Z_RData
                                                 true
                                                 (pack_struct_return_code_para.0_call
                                                   (make_return_code_para.0_call
                                                     9))
                                                 (value_RData a!9)))))
                                   (= (Some_Tuple_bool_Z_RData
                                        (mkTuple_bool_Z_RData
                                          __return___0.363881
                                          __retval___0.363881
                                          st_5.363881))
                                      (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                                 :weight 0)))
                       (a!7 (exists ((st_6.363870 RData))
                              (! (let ((a!1 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              st.0)))
                                 (let ((a!2 (rec_to_ttbr1_para.0_call
                                              (mkPtr "granule_data"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              (value_RData a!1))))
                                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                           (mkPtr (pbase a!2)
                                                                  (poffset a!2))
                                                           (value_RData a!1)))))
                                 (let ((a!4 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
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
                                   (= (Some_RData st_6.363870)
                                      (granule_unlock_spec.0_call
                                        (e_2 (elem_0 a!5))
                                        (elem_1 a!5))))))))
                                 :weight 0))))
                 (let ((a!2 (rec_to_ttbr1_para.0_call
                              (mkPtr "granule_data"
                                     (meta_granule_offset
                                       (test_PA.0_call v_1_Zptr.0)))
                              (value_RData a!1)))
                       (a!8 (and a!7
                                 (exists ((st_7.363866 RData))
                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!1))))
                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!2)
                                                                       (poffset a!2))
                                                                (value_RData a!1)))))
                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!3)))
                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!2
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!4)))))
                                      (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                (e_2 (elem_0 a!5))
                                                                (elem_1 a!5)))))
                                      (let ((a!7 (granule_unlock_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!6)))
                                        (= (Some_RData st_7.363866) a!7))))))))
                                      :weight 0)))))
                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                           (mkPtr (pbase a!2) (poffset a!2))
                                           (value_RData a!1)))))
                 (let ((a!4 (spinlock_acquire_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_0_Zptr.0)))
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
                 (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                           (e_2 (elem_0 a!5))
                                           (elem_1 a!5)))))
                 (let ((a!10 (granule_unlock_spec.0_call
                               (mkPtr "granules"
                                      (meta_granule_offset
                                        (test_PA.0_call v_0_Zptr.0)))
                               a!9)))
                 (let ((a!11 (Some_Tuple_bool_Z_RData
                               (mkTuple_bool_Z_RData
                                 true
                                 (pack_struct_return_code_para.0_call
                                   (make_return_code_para.0_call 9))
                                 (value_RData a!10)))))
                 (let ((a!12 (mkTuple_bool_Z_RData
                               (elem_0 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData)))
                               (elem_1 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData)))
                               (elem_2 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData))))))
                 (let ((a!13 (elem_2 (value_Tuple_bool_Z_RData
                                       (ite a!6
                                            (Some_Tuple_bool_Z_RData a!12)
                                            None_Tuple_bool_Z_RData)))))
                   (= (Some_RData st_7.363910)
                      (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!13))))))))))))
                 :weight 0)))
      (a!29 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1)))
      (a!9 (and a!8
                (exists ((st_7.363866 RData))
                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_1_Zptr.0)))
                                  st.0)))
                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                  (mkPtr "granule_data"
                                         (meta_granule_offset
                                           (test_PA.0_call v_1_Zptr.0)))
                                  (value_RData a!1))))
                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                               (mkPtr (pbase a!2) (poffset a!2))
                                               (value_RData a!1)))))
                     (let ((a!4 (spinlock_acquire_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_0_Zptr.0)))
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
                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                               (e_2 (elem_0 a!5))
                                               (elem_1 a!5)))))
                     (let ((a!7 (granule_unlock_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_0_Zptr.0)))
                                  a!6)))
                       (= (Some_RData st_7.363866) a!7))))))))
                     :weight 0))))
      (a!18 (and a!17
                 (exists ((st_8.363906 RData))
                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                   (mkPtr "granules"
                                          (meta_granule_offset
                                            (test_PA.0_call v_1_Zptr.0)))
                                   st.0))
                            (a!6 (exists ((__return___0.363881 Bool)
                                          (__retval___0.363881 Int)
                                          (st_5.363881 RData))
                                   (! (let ((a!1 (exists ((st_6.363870 RData))
                                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   st.0)))
                                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                   (mkPtr "granule_data"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   (value_RData a!1))))
                                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                (mkPtr (pbase a!2)
                                                                                       (poffset a!2))
                                                                                (value_RData a!1)))))
                                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!3)))
                                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                                     (mkPtr "stack_s_rtt_walk"
                                                                            0)
                                                                     a!2
                                                                     0
                                                                     64
                                                                     v_2.0
                                                                     v_3.0
                                                                     (value_RData a!4)))))
                                                        (= (Some_RData st_6.363870)
                                                           (granule_unlock_spec.0_call
                                                             (e_2 (elem_0 a!5))
                                                             (elem_1 a!5))))))))
                                                      :weight 0)))
                                            (a!3 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (and a!1
                                                      (exists ((st_7.363866 RData))
                                                        (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                                        st.0)))
                                                           (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                        (mkPtr "granule_data"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                                        (value_RData a!1))))
                                                           (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                     (mkPtr (pbase a!2)
                                                                                            (poffset a!2))
                                                                                     (value_RData a!1)))))
                                                           (let ((a!4 (spinlock_acquire_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                                        a!3)))
                                                           (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                        (rtt_walk_lock_unlock_spec_abs.0_call
                                                                          (mkPtr "stack_s_rtt_walk"
                                                                                 0)
                                                                          a!2
                                                                          0
                                                                          64
                                                                          v_2.0
                                                                          v_3.0
                                                                          (value_RData a!4)))))
                                                           (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                                     (e_2 (elem_0 a!5))
                                                                                     (elem_1 a!5)))))
                                                           (let ((a!7 (granule_unlock_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                                        a!6)))
                                                             (= (Some_RData st_7.363866)
                                                                a!7))))))))
                                                           :weight 0))))
                                            (a!4 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!3))))
                                      (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!4)
                                                                       (poffset a!4))
                                                                (value_RData a!3)))))
                                      (let ((a!6 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!5)))
                                      (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!4
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!6)))))
                                      (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                                (e_2 (elem_0 a!7))
                                                                (elem_1 a!7)))))
                                      (let ((a!9 (granule_unlock_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!8)))
                                      (let ((a!10 (Some_Tuple_bool_Z_RData
                                                    (mkTuple_bool_Z_RData
                                                      true
                                                      (pack_struct_return_code_para.0_call
                                                        (make_return_code_para.0_call
                                                          9))
                                                      (value_RData a!9)))))
                                        (= (Some_Tuple_bool_Z_RData
                                             (mkTuple_bool_Z_RData
                                               __return___0.363881
                                               __retval___0.363881
                                               st_5.363881))
                                           (ite a!2
                                                a!10
                                                None_Tuple_bool_Z_RData))))))))))
                                      :weight 0)))
                            (a!7 (exists ((st_6.363870 RData))
                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!1))))
                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!2)
                                                                       (poffset a!2))
                                                                (value_RData a!1)))))
                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!3)))
                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!2
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!4)))))
                                        (= (Some_RData st_6.363870)
                                           (granule_unlock_spec.0_call
                                             (e_2 (elem_0 a!5))
                                             (elem_1 a!5))))))))
                                      :weight 0))))
                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                   (mkPtr "granule_data"
                                          (meta_granule_offset
                                            (test_PA.0_call v_1_Zptr.0)))
                                   (value_RData a!1)))
                            (a!8 (and a!7
                                      (exists ((st_7.363866 RData))
                                        (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                        st.0)))
                                           (let ((a!2 (rec_to_ttbr1_para.0_call
                                                        (mkPtr "granule_data"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                        (value_RData a!1))))
                                           (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                     (mkPtr (pbase a!2)
                                                                            (poffset a!2))
                                                                     (value_RData a!1)))))
                                           (let ((a!4 (spinlock_acquire_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                        a!3)))
                                           (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                        (rtt_walk_lock_unlock_spec_abs.0_call
                                                          (mkPtr "stack_s_rtt_walk"
                                                                 0)
                                                          a!2
                                                          0
                                                          64
                                                          v_2.0
                                                          v_3.0
                                                          (value_RData a!4)))))
                                           (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                     (e_2 (elem_0 a!5))
                                                                     (elem_1 a!5)))))
                                           (let ((a!7 (granule_unlock_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                        a!6)))
                                             (= (Some_RData st_7.363866) a!7))))))))
                                           :weight 0)))))
                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                (mkPtr (pbase a!2)
                                                       (poffset a!2))
                                                (value_RData a!1)))))
                      (let ((a!4 (spinlock_acquire_spec.0_call
                                   (mkPtr "granules"
                                          (meta_granule_offset
                                            (test_PA.0_call v_0_Zptr.0)))
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
                      (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                                (e_2 (elem_0 a!5))
                                                (elem_1 a!5)))))
                      (let ((a!10 (granule_unlock_spec.0_call
                                    (mkPtr "granules"
                                           (meta_granule_offset
                                             (test_PA.0_call v_0_Zptr.0)))
                                    a!9)))
                      (let ((a!11 (Some_Tuple_bool_Z_RData
                                    (mkTuple_bool_Z_RData
                                      true
                                      (pack_struct_return_code_para.0_call
                                        (make_return_code_para.0_call 9))
                                      (value_RData a!10)))))
                      (let ((a!12 (mkTuple_bool_Z_RData
                                    (elem_0 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData)))
                                    (elem_1 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData)))
                                    (elem_2 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData))))))
                      (let ((a!13 (elem_2 (value_Tuple_bool_Z_RData
                                            (ite a!6
                                                 (Some_Tuple_bool_Z_RData a!12)
                                                 None_Tuple_bool_Z_RData)))))
                      (let ((a!14 (value_RData (granule_unlock_spec.0_call
                                                 (e_2 (elem_0 a!5))
                                                 a!13))))
                      (let ((a!15 (granule_unlock_spec.0_call
                                    (mkPtr "granules"
                                           (meta_granule_offset
                                             (test_PA.0_call v_0_Zptr.0)))
                                    a!14)))
                        (= (Some_RData st_8.363906) a!15)))))))))))))
                      :weight 0)))))
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
(let ((a!10 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (elem_1 a!5))))
      (a!25 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5))))))
(let ((a!11 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              a!10)))
(let ((a!12 (Some_Tuple_bool_Z_RData
              (mkTuple_bool_Z_RData
                true
                (pack_struct_return_code_para.0_call
                  (make_return_code_para.0_call 9))
                (value_RData a!11)))))
(let ((a!13 (mkTuple_bool_Z_RData
              (elem_0 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData)))
              (elem_1 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData)))
              (elem_2 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData))))))
(let ((a!14 (elem_0 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData))))
      (a!15 (elem_1 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData))))
      (a!16 (elem_2 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData)))))
(let ((a!19 (value_RData (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!16))))
(let ((a!20 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              a!19)))
(let ((a!21 (Some_Tuple_bool_Z_RData
              (mkTuple_bool_Z_RData
                true
                (pack_struct_return_code_para.0_call
                  (make_return_code_para.0_call 8))
                (value_RData a!20)))))
(let ((a!22 (ite a!6
                 (ite a!14
                      (Some_Tuple_bool_Z_RData
                        (mkTuple_bool_Z_RData true a!15 a!16))
                      (ite a!18 a!21 None_Tuple_bool_Z_RData))
                 None_Tuple_bool_Z_RData)))
(let ((a!23 (gpt (share (elem_2 (value_Tuple_bool_Z_RData a!22)))))
      (a!24 (granule_data (share (elem_2 (value_Tuple_bool_Z_RData a!22)))))
      (a!28 (globals (share (elem_2 (value_Tuple_bool_Z_RData a!22))))))
(let ((a!26 (store (g_norm (select a!24 (div a!25 4096)))
                   (mod a!25 4096)
                   (test_PTE_Z.0_call
                     (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!30 (mks_granule (e_lock (select (g_granules a!28) a!29))
                         5
                         (e_ref (select (g_granules a!28) a!29)))))
(let ((a!27 (mkr_granule_data (gd_g_idx (select a!24 (div a!25 4096)))
                              (g_granule_state (select a!24 (div a!25 4096)))
                              a!26
                              (g_rd (select a!24 (div a!25 4096)))
                              (g_rec (select a!24 (div a!25 4096))))))
(let ((a!31 (mkShared a!23
                      (store a!24 (div a!25 4096) a!27)
                      (mkGLOBALS (g_heap a!28)
                                 (g_debug_exits a!28)
                                 (g_vmid_count a!28)
                                 (g_vmid_lock a!28)
                                 (g_vmids a!28)
                                 (g_nr_lrs a!28)
                                 (g_nr_aprs a!28)
                                 (g_max_vintid a!28)
                                 (g_pri_res0_mask a!28)
                                 (g_default_gicstate a!28)
                                 (g_status_handler a!28)
                                 (g_rmm_trap_list a!28)
                                 (g_tt_l3_buffer a!28)
                                 (g_tt_l2_mem0_0 a!28)
                                 (g_tt_l2_mem0_1 a!28)
                                 (g_tt_l2_mem1_0 a!28)
                                 (g_tt_l2_mem1_1 a!28)
                                 (g_tt_l2_mem1_2 a!28)
                                 (g_tt_l2_mem1_3 a!28)
                                 (g_tt_l1_upper a!28)
                                 (g_mbedtls_mem_buf a!28)
                                 (store (g_granules a!28) a!29 a!30)
                                 (g_rmm_attest_signing_key a!28)
                                 (g_rmm_attest_public_key a!28)
                                 (g_rmm_attest_public_key_len a!28)
                                 (g_rmm_attest_public_key_hash a!28)
                                 (g_rmm_attest_public_key_hash_len a!28)
                                 (g_platform_token_buf a!28)
                                 (g_rmm_platform_token a!28)
                                 (g_get_realm_identity_identity a!28)
                                 (g_realm_attest_private_key a!28)))))
(let ((a!32 (mkRData (log (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (oracle (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (repl (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (priv (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     a!31
                     (stack (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (halt (elem_2 (value_Tuple_bool_Z_RData a!22))))))
(let ((a!33 (value_RData (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!32))))
  (oracle a!33)))))))))))))))))))))_call| ?x8051)))
 (let ((?x51633 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!6 (exists ((__return___0.363915 Bool)
                    (__retval___0.363915 Int)
                    (st_5.363915 RData))
             (! (let ((a!1 (exists ((__return___0.363881 Bool)
                                    (__retval___0.363881 Int)
                                    (st_5.363881 RData))
                             (! (let ((a!1 (exists ((st_6.363870 RData))
                                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                             (mkPtr "granules"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_1_Zptr.0)))
                                                             st.0)))
                                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                                             (mkPtr "granule_data"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_1_Zptr.0)))
                                                             (value_RData a!1))))
                                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                          (mkPtr (pbase a!2)
                                                                                 (poffset a!2))
                                                                          (value_RData a!1)))))
                                                (let ((a!4 (spinlock_acquire_spec.0_call
                                                             (mkPtr "granules"
                                                                    (meta_granule_offset
                                                                      (test_PA.0_call v_0_Zptr.0)))
                                                             a!3)))
                                                (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                             (rtt_walk_lock_unlock_spec_abs.0_call
                                                               (mkPtr "stack_s_rtt_walk"
                                                                      0)
                                                               a!2
                                                               0
                                                               64
                                                               v_2.0
                                                               v_3.0
                                                               (value_RData a!4)))))
                                                  (= (Some_RData st_6.363870)
                                                     (granule_unlock_spec.0_call
                                                       (e_2 (elem_0 a!5))
                                                       (elem_1 a!5))))))))
                                                :weight 0)))
                                      (a!3 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (and a!1
                                                (exists ((st_7.363866 RData))
                                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_1_Zptr.0)))
                                                                  st.0)))
                                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                  (mkPtr "granule_data"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_1_Zptr.0)))
                                                                  (value_RData a!1))))
                                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                               (mkPtr (pbase a!2)
                                                                                      (poffset a!2))
                                                                               (value_RData a!1)))))
                                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_0_Zptr.0)))
                                                                  a!3)))
                                                     (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                  (rtt_walk_lock_unlock_spec_abs.0_call
                                                                    (mkPtr "stack_s_rtt_walk"
                                                                           0)
                                                                    a!2
                                                                    0
                                                                    64
                                                                    v_2.0
                                                                    v_3.0
                                                                    (value_RData a!4)))))
                                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                               (e_2 (elem_0 a!5))
                                                                               (elem_1 a!5)))))
                                                     (let ((a!7 (granule_unlock_spec.0_call
                                                                  (mkPtr "granules"
                                                                         (meta_granule_offset
                                                                           (test_PA.0_call v_0_Zptr.0)))
                                                                  a!6)))
                                                       (= (Some_RData st_7.363866)
                                                          a!7))))))))
                                                     :weight 0))))
                                      (a!4 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!3))))
                                (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!4)
                                                                 (poffset a!4))
                                                          (value_RData a!3)))))
                                (let ((a!6 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
                                             a!5)))
                                (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                             (rtt_walk_lock_unlock_spec_abs.0_call
                                               (mkPtr "stack_s_rtt_walk" 0)
                                               a!4
                                               0
                                               64
                                               v_2.0
                                               v_3.0
                                               (value_RData a!6)))))
                                (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                          (e_2 (elem_0 a!7))
                                                          (elem_1 a!7)))))
                                (let ((a!9 (granule_unlock_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
                                             a!8)))
                                (let ((a!10 (Some_Tuple_bool_Z_RData
                                              (mkTuple_bool_Z_RData
                                                true
                                                (pack_struct_return_code_para.0_call
                                                  (make_return_code_para.0_call
                                                    9))
                                                (value_RData a!9)))))
                                  (= (Some_Tuple_bool_Z_RData
                                       (mkTuple_bool_Z_RData
                                         __return___0.363881
                                         __retval___0.363881
                                         st_5.363881))
                                     (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                                :weight 0)))
                      (a!2 (exists ((st_6.363870 RData))
                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!1))))
                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!2)
                                                                 (poffset a!2))
                                                          (value_RData a!1)))))
                                (let ((a!4 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
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
                                  (= (Some_RData st_6.363870)
                                     (granule_unlock_spec.0_call
                                       (e_2 (elem_0 a!5))
                                       (elem_1 a!5))))))))
                                :weight 0)))
                      (a!4 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!3 (and a!2
                                (exists ((st_7.363866 RData))
                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  st.0)))
                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                  (mkPtr "granule_data"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  (value_RData a!1))))
                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                               (mkPtr (pbase a!2)
                                                                      (poffset a!2))
                                                               (value_RData a!1)))))
                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
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
                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                               (e_2 (elem_0 a!5))
                                                               (elem_1 a!5)))))
                                     (let ((a!7 (granule_unlock_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
                                                  a!6)))
                                       (= (Some_RData st_7.363866) a!7))))))))
                                     :weight 0))))
                      (a!5 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!4))))
                (let ((a!6 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!5) (poffset a!5))
                                          (value_RData a!4)))))
                (let ((a!7 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!6)))
                (let ((a!8 (value_Tuple_abs_ret_rtt_RData
                             (rtt_walk_lock_unlock_spec_abs.0_call
                               (mkPtr "stack_s_rtt_walk" 0)
                               a!5
                               0
                               64
                               v_2.0
                               v_3.0
                               (value_RData a!7)))))
                (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                          (e_2 (elem_0 a!8))
                                          (elem_1 a!8)))))
                (let ((a!10 (granule_unlock_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_0_Zptr.0)))
                              a!9)))
                (let ((a!11 (Some_Tuple_bool_Z_RData
                              (mkTuple_bool_Z_RData
                                true
                                (pack_struct_return_code_para.0_call
                                  (make_return_code_para.0_call 9))
                                (value_RData a!10)))))
                (let ((a!12 (mkTuple_bool_Z_RData
                              (elem_0 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData)))
                              (elem_1 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData)))
                              (elem_2 (value_Tuple_bool_Z_RData
                                        (ite a!3 a!11 None_Tuple_bool_Z_RData))))))
                  (= (Some_Tuple_bool_Z_RData
                       (mkTuple_bool_Z_RData
                         __return___0.363915
                         __retval___0.363915
                         st_5.363915))
                     (ite a!1
                          (Some_Tuple_bool_Z_RData a!12)
                          None_Tuple_bool_Z_RData)))))))))))
                :weight 0)))
      (a!7 (exists ((__return___0.363881 Bool)
                    (__retval___0.363881 Int)
                    (st_5.363881 RData))
             (! (let ((a!1 (exists ((st_6.363870 RData))
                             (! (let ((a!1 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             st.0)))
                                (let ((a!2 (rec_to_ttbr1_para.0_call
                                             (mkPtr "granule_data"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_1_Zptr.0)))
                                             (value_RData a!1))))
                                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                          (mkPtr (pbase a!2)
                                                                 (poffset a!2))
                                                          (value_RData a!1)))))
                                (let ((a!4 (spinlock_acquire_spec.0_call
                                             (mkPtr "granules"
                                                    (meta_granule_offset
                                                      (test_PA.0_call v_0_Zptr.0)))
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
                                  (= (Some_RData st_6.363870)
                                     (granule_unlock_spec.0_call
                                       (e_2 (elem_0 a!5))
                                       (elem_1 a!5))))))))
                                :weight 0)))
                      (a!3 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!2 (and a!1
                                (exists ((st_7.363866 RData))
                                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  st.0)))
                                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                                  (mkPtr "granule_data"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_1_Zptr.0)))
                                                  (value_RData a!1))))
                                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                               (mkPtr (pbase a!2)
                                                                      (poffset a!2))
                                                               (value_RData a!1)))))
                                     (let ((a!4 (spinlock_acquire_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
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
                                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                               (e_2 (elem_0 a!5))
                                                               (elem_1 a!5)))))
                                     (let ((a!7 (granule_unlock_spec.0_call
                                                  (mkPtr "granules"
                                                         (meta_granule_offset
                                                           (test_PA.0_call v_0_Zptr.0)))
                                                  a!6)))
                                       (= (Some_RData st_7.363866) a!7))))))))
                                     :weight 0))))
                      (a!4 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!3))))
                (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!4) (poffset a!4))
                                          (value_RData a!3)))))
                (let ((a!6 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!5)))
                (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                             (rtt_walk_lock_unlock_spec_abs.0_call
                               (mkPtr "stack_s_rtt_walk" 0)
                               a!4
                               0
                               64
                               v_2.0
                               v_3.0
                               (value_RData a!6)))))
                (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                          (e_2 (elem_0 a!7))
                                          (elem_1 a!7)))))
                (let ((a!9 (granule_unlock_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
                             a!8)))
                (let ((a!10 (Some_Tuple_bool_Z_RData
                              (mkTuple_bool_Z_RData
                                true
                                (pack_struct_return_code_para.0_call
                                  (make_return_code_para.0_call 9))
                                (value_RData a!9)))))
                  (= (Some_Tuple_bool_Z_RData
                       (mkTuple_bool_Z_RData
                         __return___0.363881
                         __retval___0.363881
                         st_5.363881))
                     (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                :weight 0)))
      (a!8 (exists ((st_6.363870 RData))
             (! (let ((a!1 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             st.0)))
                (let ((a!2 (rec_to_ttbr1_para.0_call
                             (mkPtr "granule_data"
                                    (meta_granule_offset
                                      (test_PA.0_call v_1_Zptr.0)))
                             (value_RData a!1))))
                (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                          (mkPtr (pbase a!2) (poffset a!2))
                                          (value_RData a!1)))))
                (let ((a!4 (spinlock_acquire_spec.0_call
                             (mkPtr "granules"
                                    (meta_granule_offset
                                      (test_PA.0_call v_0_Zptr.0)))
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
                  (= (Some_RData st_6.363870)
                     (granule_unlock_spec.0_call
                       (e_2 (elem_0 a!5))
                       (elem_1 a!5))))))))
                :weight 0)))
      (a!17 (exists ((st_7.363910 RData))
              (! (let ((a!1 (spinlock_acquire_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_1_Zptr.0)))
                              st.0))
                       (a!6 (exists ((__return___0.363881 Bool)
                                     (__retval___0.363881 Int)
                                     (st_5.363881 RData))
                              (! (let ((a!1 (exists ((st_6.363870 RData))
                                              (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                              (mkPtr "granules"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_1_Zptr.0)))
                                                              st.0)))
                                                 (let ((a!2 (rec_to_ttbr1_para.0_call
                                                              (mkPtr "granule_data"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_1_Zptr.0)))
                                                              (value_RData a!1))))
                                                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                           (mkPtr (pbase a!2)
                                                                                  (poffset a!2))
                                                                           (value_RData a!1)))))
                                                 (let ((a!4 (spinlock_acquire_spec.0_call
                                                              (mkPtr "granules"
                                                                     (meta_granule_offset
                                                                       (test_PA.0_call v_0_Zptr.0)))
                                                              a!3)))
                                                 (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                              (rtt_walk_lock_unlock_spec_abs.0_call
                                                                (mkPtr "stack_s_rtt_walk"
                                                                       0)
                                                                a!2
                                                                0
                                                                64
                                                                v_2.0
                                                                v_3.0
                                                                (value_RData a!4)))))
                                                   (= (Some_RData st_6.363870)
                                                      (granule_unlock_spec.0_call
                                                        (e_2 (elem_0 a!5))
                                                        (elem_1 a!5))))))))
                                                 :weight 0)))
                                       (a!3 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              st.0)))
                                 (let ((a!2 (and a!1
                                                 (exists ((st_7.363866 RData))
                                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   st.0)))
                                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                   (mkPtr "granule_data"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   (value_RData a!1))))
                                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                (mkPtr (pbase a!2)
                                                                                       (poffset a!2))
                                                                                (value_RData a!1)))))
                                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!3)))
                                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                                     (mkPtr "stack_s_rtt_walk"
                                                                            0)
                                                                     a!2
                                                                     0
                                                                     64
                                                                     v_2.0
                                                                     v_3.0
                                                                     (value_RData a!4)))))
                                                      (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                                (e_2 (elem_0 a!5))
                                                                                (elem_1 a!5)))))
                                                      (let ((a!7 (granule_unlock_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!6)))
                                                        (= (Some_RData st_7.363866)
                                                           a!7))))))))
                                                      :weight 0))))
                                       (a!4 (rec_to_ttbr1_para.0_call
                                              (mkPtr "granule_data"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              (value_RData a!3))))
                                 (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                           (mkPtr (pbase a!4)
                                                                  (poffset a!4))
                                                           (value_RData a!3)))))
                                 (let ((a!6 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
                                              a!5)))
                                 (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                              (rtt_walk_lock_unlock_spec_abs.0_call
                                                (mkPtr "stack_s_rtt_walk" 0)
                                                a!4
                                                0
                                                64
                                                v_2.0
                                                v_3.0
                                                (value_RData a!6)))))
                                 (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                           (e_2 (elem_0 a!7))
                                                           (elem_1 a!7)))))
                                 (let ((a!9 (granule_unlock_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
                                              a!8)))
                                 (let ((a!10 (Some_Tuple_bool_Z_RData
                                               (mkTuple_bool_Z_RData
                                                 true
                                                 (pack_struct_return_code_para.0_call
                                                   (make_return_code_para.0_call
                                                     9))
                                                 (value_RData a!9)))))
                                   (= (Some_Tuple_bool_Z_RData
                                        (mkTuple_bool_Z_RData
                                          __return___0.363881
                                          __retval___0.363881
                                          st_5.363881))
                                      (ite a!2 a!10 None_Tuple_bool_Z_RData))))))))))
                                 :weight 0)))
                       (a!7 (exists ((st_6.363870 RData))
                              (! (let ((a!1 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              st.0)))
                                 (let ((a!2 (rec_to_ttbr1_para.0_call
                                              (mkPtr "granule_data"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_1_Zptr.0)))
                                              (value_RData a!1))))
                                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                           (mkPtr (pbase a!2)
                                                                  (poffset a!2))
                                                           (value_RData a!1)))))
                                 (let ((a!4 (spinlock_acquire_spec.0_call
                                              (mkPtr "granules"
                                                     (meta_granule_offset
                                                       (test_PA.0_call v_0_Zptr.0)))
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
                                   (= (Some_RData st_6.363870)
                                      (granule_unlock_spec.0_call
                                        (e_2 (elem_0 a!5))
                                        (elem_1 a!5))))))))
                                 :weight 0))))
                 (let ((a!2 (rec_to_ttbr1_para.0_call
                              (mkPtr "granule_data"
                                     (meta_granule_offset
                                       (test_PA.0_call v_1_Zptr.0)))
                              (value_RData a!1)))
                       (a!8 (and a!7
                                 (exists ((st_7.363866 RData))
                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!1))))
                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!2)
                                                                       (poffset a!2))
                                                                (value_RData a!1)))))
                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!3)))
                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!2
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!4)))))
                                      (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                (e_2 (elem_0 a!5))
                                                                (elem_1 a!5)))))
                                      (let ((a!7 (granule_unlock_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!6)))
                                        (= (Some_RData st_7.363866) a!7))))))))
                                      :weight 0)))))
                 (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                           (mkPtr (pbase a!2) (poffset a!2))
                                           (value_RData a!1)))))
                 (let ((a!4 (spinlock_acquire_spec.0_call
                              (mkPtr "granules"
                                     (meta_granule_offset
                                       (test_PA.0_call v_0_Zptr.0)))
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
                 (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                           (e_2 (elem_0 a!5))
                                           (elem_1 a!5)))))
                 (let ((a!10 (granule_unlock_spec.0_call
                               (mkPtr "granules"
                                      (meta_granule_offset
                                        (test_PA.0_call v_0_Zptr.0)))
                               a!9)))
                 (let ((a!11 (Some_Tuple_bool_Z_RData
                               (mkTuple_bool_Z_RData
                                 true
                                 (pack_struct_return_code_para.0_call
                                   (make_return_code_para.0_call 9))
                                 (value_RData a!10)))))
                 (let ((a!12 (mkTuple_bool_Z_RData
                               (elem_0 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData)))
                               (elem_1 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData)))
                               (elem_2 (value_Tuple_bool_Z_RData
                                         (ite a!8 a!11 None_Tuple_bool_Z_RData))))))
                 (let ((a!13 (elem_2 (value_Tuple_bool_Z_RData
                                       (ite a!6
                                            (Some_Tuple_bool_Z_RData a!12)
                                            None_Tuple_bool_Z_RData)))))
                   (= (Some_RData st_7.363910)
                      (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!13))))))))))))
                 :weight 0)))
      (a!29 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (rec_to_ttbr1_para.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             (value_RData a!1)))
      (a!9 (and a!8
                (exists ((st_7.363866 RData))
                  (! (let ((a!1 (spinlock_acquire_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_1_Zptr.0)))
                                  st.0)))
                     (let ((a!2 (rec_to_ttbr1_para.0_call
                                  (mkPtr "granule_data"
                                         (meta_granule_offset
                                           (test_PA.0_call v_1_Zptr.0)))
                                  (value_RData a!1))))
                     (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                               (mkPtr (pbase a!2) (poffset a!2))
                                               (value_RData a!1)))))
                     (let ((a!4 (spinlock_acquire_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_0_Zptr.0)))
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
                     (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                               (e_2 (elem_0 a!5))
                                               (elem_1 a!5)))))
                     (let ((a!7 (granule_unlock_spec.0_call
                                  (mkPtr "granules"
                                         (meta_granule_offset
                                           (test_PA.0_call v_0_Zptr.0)))
                                  a!6)))
                       (= (Some_RData st_7.363866) a!7))))))))
                     :weight 0))))
      (a!18 (and a!17
                 (exists ((st_8.363906 RData))
                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                   (mkPtr "granules"
                                          (meta_granule_offset
                                            (test_PA.0_call v_1_Zptr.0)))
                                   st.0))
                            (a!6 (exists ((__return___0.363881 Bool)
                                          (__retval___0.363881 Int)
                                          (st_5.363881 RData))
                                   (! (let ((a!1 (exists ((st_6.363870 RData))
                                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   st.0)))
                                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                   (mkPtr "granule_data"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_1_Zptr.0)))
                                                                   (value_RData a!1))))
                                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                (mkPtr (pbase a!2)
                                                                                       (poffset a!2))
                                                                                (value_RData a!1)))))
                                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                                   (mkPtr "granules"
                                                                          (meta_granule_offset
                                                                            (test_PA.0_call v_0_Zptr.0)))
                                                                   a!3)))
                                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                                     (mkPtr "stack_s_rtt_walk"
                                                                            0)
                                                                     a!2
                                                                     0
                                                                     64
                                                                     v_2.0
                                                                     v_3.0
                                                                     (value_RData a!4)))))
                                                        (= (Some_RData st_6.363870)
                                                           (granule_unlock_spec.0_call
                                                             (e_2 (elem_0 a!5))
                                                             (elem_1 a!5))))))))
                                                      :weight 0)))
                                            (a!3 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (and a!1
                                                      (exists ((st_7.363866 RData))
                                                        (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                                        st.0)))
                                                           (let ((a!2 (rec_to_ttbr1_para.0_call
                                                                        (mkPtr "granule_data"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                                        (value_RData a!1))))
                                                           (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                                     (mkPtr (pbase a!2)
                                                                                            (poffset a!2))
                                                                                     (value_RData a!1)))))
                                                           (let ((a!4 (spinlock_acquire_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                                        a!3)))
                                                           (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                                        (rtt_walk_lock_unlock_spec_abs.0_call
                                                                          (mkPtr "stack_s_rtt_walk"
                                                                                 0)
                                                                          a!2
                                                                          0
                                                                          64
                                                                          v_2.0
                                                                          v_3.0
                                                                          (value_RData a!4)))))
                                                           (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                                     (e_2 (elem_0 a!5))
                                                                                     (elem_1 a!5)))))
                                                           (let ((a!7 (granule_unlock_spec.0_call
                                                                        (mkPtr "granules"
                                                                               (meta_granule_offset
                                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                                        a!6)))
                                                             (= (Some_RData st_7.363866)
                                                                a!7))))))))
                                                           :weight 0))))
                                            (a!4 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!3))))
                                      (let ((a!5 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!4)
                                                                       (poffset a!4))
                                                                (value_RData a!3)))))
                                      (let ((a!6 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!5)))
                                      (let ((a!7 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!4
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!6)))))
                                      (let ((a!8 (value_RData (granule_unlock_spec.0_call
                                                                (e_2 (elem_0 a!7))
                                                                (elem_1 a!7)))))
                                      (let ((a!9 (granule_unlock_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!8)))
                                      (let ((a!10 (Some_Tuple_bool_Z_RData
                                                    (mkTuple_bool_Z_RData
                                                      true
                                                      (pack_struct_return_code_para.0_call
                                                        (make_return_code_para.0_call
                                                          9))
                                                      (value_RData a!9)))))
                                        (= (Some_Tuple_bool_Z_RData
                                             (mkTuple_bool_Z_RData
                                               __return___0.363881
                                               __retval___0.363881
                                               st_5.363881))
                                           (ite a!2
                                                a!10
                                                None_Tuple_bool_Z_RData))))))))))
                                      :weight 0)))
                            (a!7 (exists ((st_6.363870 RData))
                                   (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   st.0)))
                                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                                   (mkPtr "granule_data"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_1_Zptr.0)))
                                                   (value_RData a!1))))
                                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                (mkPtr (pbase a!2)
                                                                       (poffset a!2))
                                                                (value_RData a!1)))))
                                      (let ((a!4 (spinlock_acquire_spec.0_call
                                                   (mkPtr "granules"
                                                          (meta_granule_offset
                                                            (test_PA.0_call v_0_Zptr.0)))
                                                   a!3)))
                                      (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                   (rtt_walk_lock_unlock_spec_abs.0_call
                                                     (mkPtr "stack_s_rtt_walk"
                                                            0)
                                                     a!2
                                                     0
                                                     64
                                                     v_2.0
                                                     v_3.0
                                                     (value_RData a!4)))))
                                        (= (Some_RData st_6.363870)
                                           (granule_unlock_spec.0_call
                                             (e_2 (elem_0 a!5))
                                             (elem_1 a!5))))))))
                                      :weight 0))))
                      (let ((a!2 (rec_to_ttbr1_para.0_call
                                   (mkPtr "granule_data"
                                          (meta_granule_offset
                                            (test_PA.0_call v_1_Zptr.0)))
                                   (value_RData a!1)))
                            (a!8 (and a!7
                                      (exists ((st_7.363866 RData))
                                        (! (let ((a!1 (spinlock_acquire_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                        st.0)))
                                           (let ((a!2 (rec_to_ttbr1_para.0_call
                                                        (mkPtr "granule_data"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_1_Zptr.0)))
                                                        (value_RData a!1))))
                                           (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                                     (mkPtr (pbase a!2)
                                                                            (poffset a!2))
                                                                     (value_RData a!1)))))
                                           (let ((a!4 (spinlock_acquire_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                        a!3)))
                                           (let ((a!5 (value_Tuple_abs_ret_rtt_RData
                                                        (rtt_walk_lock_unlock_spec_abs.0_call
                                                          (mkPtr "stack_s_rtt_walk"
                                                                 0)
                                                          a!2
                                                          0
                                                          64
                                                          v_2.0
                                                          v_3.0
                                                          (value_RData a!4)))))
                                           (let ((a!6 (value_RData (granule_unlock_spec.0_call
                                                                     (e_2 (elem_0 a!5))
                                                                     (elem_1 a!5)))))
                                           (let ((a!7 (granule_unlock_spec.0_call
                                                        (mkPtr "granules"
                                                               (meta_granule_offset
                                                                 (test_PA.0_call v_0_Zptr.0)))
                                                        a!6)))
                                             (= (Some_RData st_7.363866) a!7))))))))
                                           :weight 0)))))
                      (let ((a!3 (value_RData (spinlock_acquire_spec.0_call
                                                (mkPtr (pbase a!2)
                                                       (poffset a!2))
                                                (value_RData a!1)))))
                      (let ((a!4 (spinlock_acquire_spec.0_call
                                   (mkPtr "granules"
                                          (meta_granule_offset
                                            (test_PA.0_call v_0_Zptr.0)))
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
                      (let ((a!9 (value_RData (granule_unlock_spec.0_call
                                                (e_2 (elem_0 a!5))
                                                (elem_1 a!5)))))
                      (let ((a!10 (granule_unlock_spec.0_call
                                    (mkPtr "granules"
                                           (meta_granule_offset
                                             (test_PA.0_call v_0_Zptr.0)))
                                    a!9)))
                      (let ((a!11 (Some_Tuple_bool_Z_RData
                                    (mkTuple_bool_Z_RData
                                      true
                                      (pack_struct_return_code_para.0_call
                                        (make_return_code_para.0_call 9))
                                      (value_RData a!10)))))
                      (let ((a!12 (mkTuple_bool_Z_RData
                                    (elem_0 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData)))
                                    (elem_1 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData)))
                                    (elem_2 (value_Tuple_bool_Z_RData
                                              (ite a!8
                                                   a!11
                                                   None_Tuple_bool_Z_RData))))))
                      (let ((a!13 (elem_2 (value_Tuple_bool_Z_RData
                                            (ite a!6
                                                 (Some_Tuple_bool_Z_RData a!12)
                                                 None_Tuple_bool_Z_RData)))))
                      (let ((a!14 (value_RData (granule_unlock_spec.0_call
                                                 (e_2 (elem_0 a!5))
                                                 a!13))))
                      (let ((a!15 (granule_unlock_spec.0_call
                                    (mkPtr "granules"
                                           (meta_granule_offset
                                             (test_PA.0_call v_0_Zptr.0)))
                                    a!14)))
                        (= (Some_RData st_8.363906) a!15)))))))))))))
                      :weight 0)))))
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
(let ((a!10 (value_RData (granule_unlock_spec.0_call
                           (e_2 (elem_0 a!5))
                           (elem_1 a!5))))
      (a!25 (+ (poffset (e_2 (elem_0 a!5))) (* 8 (e_3 (elem_0 a!5))))))
(let ((a!11 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              a!10)))
(let ((a!12 (Some_Tuple_bool_Z_RData
              (mkTuple_bool_Z_RData
                true
                (pack_struct_return_code_para.0_call
                  (make_return_code_para.0_call 9))
                (value_RData a!11)))))
(let ((a!13 (mkTuple_bool_Z_RData
              (elem_0 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData)))
              (elem_1 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData)))
              (elem_2 (value_Tuple_bool_Z_RData
                        (ite a!9 a!12 None_Tuple_bool_Z_RData))))))
(let ((a!14 (elem_0 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData))))
      (a!15 (elem_1 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData))))
      (a!16 (elem_2 (value_Tuple_bool_Z_RData
                      (ite a!7
                           (Some_Tuple_bool_Z_RData a!13)
                           None_Tuple_bool_Z_RData)))))
(let ((a!19 (value_RData (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!16))))
(let ((a!20 (granule_unlock_spec.0_call
              (mkPtr "granules"
                     (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
              a!19)))
(let ((a!21 (Some_Tuple_bool_Z_RData
              (mkTuple_bool_Z_RData
                true
                (pack_struct_return_code_para.0_call
                  (make_return_code_para.0_call 8))
                (value_RData a!20)))))
(let ((a!22 (ite a!6
                 (ite a!14
                      (Some_Tuple_bool_Z_RData
                        (mkTuple_bool_Z_RData true a!15 a!16))
                      (ite a!18 a!21 None_Tuple_bool_Z_RData))
                 None_Tuple_bool_Z_RData)))
(let ((a!23 (gpt (share (elem_2 (value_Tuple_bool_Z_RData a!22)))))
      (a!24 (granule_data (share (elem_2 (value_Tuple_bool_Z_RData a!22)))))
      (a!28 (globals (share (elem_2 (value_Tuple_bool_Z_RData a!22))))))
(let ((a!26 (store (g_norm (select a!24 (div a!25 4096)))
                   (mod a!25 4096)
                   (test_PTE_Z.0_call
                     (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!30 (mks_granule (e_lock (select (g_granules a!28) a!29))
                         5
                         (e_ref (select (g_granules a!28) a!29)))))
(let ((a!27 (mkr_granule_data (gd_g_idx (select a!24 (div a!25 4096)))
                              (g_granule_state (select a!24 (div a!25 4096)))
                              a!26
                              (g_rd (select a!24 (div a!25 4096)))
                              (g_rec (select a!24 (div a!25 4096))))))
(let ((a!31 (mkShared a!23
                      (store a!24 (div a!25 4096) a!27)
                      (mkGLOBALS (g_heap a!28)
                                 (g_debug_exits a!28)
                                 (g_vmid_count a!28)
                                 (g_vmid_lock a!28)
                                 (g_vmids a!28)
                                 (g_nr_lrs a!28)
                                 (g_nr_aprs a!28)
                                 (g_max_vintid a!28)
                                 (g_pri_res0_mask a!28)
                                 (g_default_gicstate a!28)
                                 (g_status_handler a!28)
                                 (g_rmm_trap_list a!28)
                                 (g_tt_l3_buffer a!28)
                                 (g_tt_l2_mem0_0 a!28)
                                 (g_tt_l2_mem0_1 a!28)
                                 (g_tt_l2_mem1_0 a!28)
                                 (g_tt_l2_mem1_1 a!28)
                                 (g_tt_l2_mem1_2 a!28)
                                 (g_tt_l2_mem1_3 a!28)
                                 (g_tt_l1_upper a!28)
                                 (g_mbedtls_mem_buf a!28)
                                 (store (g_granules a!28) a!29 a!30)
                                 (g_rmm_attest_signing_key a!28)
                                 (g_rmm_attest_public_key a!28)
                                 (g_rmm_attest_public_key_len a!28)
                                 (g_rmm_attest_public_key_hash a!28)
                                 (g_rmm_attest_public_key_hash_len a!28)
                                 (g_platform_token_buf a!28)
                                 (g_rmm_platform_token a!28)
                                 (g_get_realm_identity_identity a!28)
                                 (g_realm_attest_private_key a!28)))))
(let ((a!32 (mkRData (log (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (oracle (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (repl (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (priv (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     a!31
                     (stack (elem_2 (value_Tuple_bool_Z_RData a!22)))
                     (halt (elem_2 (value_Tuple_bool_Z_RData a!22))))))
(let ((a!33 (value_RData (granule_unlock_spec.0_call (e_2 (elem_0 a!5)) a!32))))
  (repl a!33)))))))))))))))))))))_call| ?x51764 ?x1173018)))
 (let ((?x52714 (value_Shared ?x51633)))
 (let ((?x8567 (granule_data ?x52714)))
 (let (($x7042 (= (g_norm (select ?x8567 gidx.375909)) zero_granule_data)))
 (let (($x6759 (= (e_state_s_granule (select (g_granules (globals ?x52714)) gidx.375909)) 1)))
 (or (not $x6759) $x7042))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x44372 (forall ((gidx.375898 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x5684 (value_RData ?x4883)))
 (let ((?x4911 (make_return_code_para.0_call 8)))
 (let ((?x5525 (pack_struct_return_code_para.0_call ?x4911)))
 (let ((?x5648 (mkTuple_bool_Z_RData true ?x5525 ?x5684)))
 (let ((?x5504 (Some_Tuple_bool_Z_RData ?x5648)))
 (let (($x49228 (exists ((st_8.363906 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x736 (Some_RData st_8.363906)))
 (= ?x736 ?x4883))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3164 (exists ((st_7.363910 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x736 (Some_RData st_7.363910)))
 (= ?x736 ?x49044))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5524 (elem_1 ?x4789)))
 (let ((?x61229 (mkTuple_bool_Z_RData true ?x5524 ?x5748)))
 (let ((?x48959 (Some_Tuple_bool_Z_RData ?x61229)))
 (let (($x4403 (elem_0 ?x4789)))
 (let ((?x41356 (ite $x4403 ?x48959 (ite (and $x3164 $x49228) ?x5504 None_Tuple_bool_Z_RData))))
 (let (($x4889 (exists ((__return___0.363915 Bool) (__retval___0.363915 Int) (st_5.363915 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363915 __retval___0.363915 st_5.363915)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5627))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x4972 (value_Tuple_bool_Z_RData (ite $x4889 ?x41356 None_Tuple_bool_Z_RData))))
 (let ((?x5023 (elem_2 ?x4972)))
 (let (($x8334 (halt ?x5023)))
 (let ((?x8455 (stack ?x5023)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x5391 (share ?x5023)))
 (let ((?x23293 (globals ?x5391)))
 (let ((?x41501 (g_granules ?x23293)))
 (let ((?x6869 (select ?x41501 ?x28222)))
 (let ((?x8426 (mks_granule (e_lock ?x6869) 5 (e_ref ?x6869))))
 (let ((?x8288 (store ?x41501 ?x28222 ?x8426)))
 (let ((?x8438 (mkGLOBALS (g_heap ?x23293) (g_debug_exits ?x23293) (g_vmid_count ?x23293) (g_vmid_lock ?x23293) (g_vmids ?x23293) (g_nr_lrs ?x23293) (g_nr_aprs ?x23293) (g_max_vintid ?x23293) (g_pri_res0_mask ?x23293) (g_default_gicstate ?x23293) (g_status_handler ?x23293) (g_rmm_trap_list ?x23293) (g_tt_l3_buffer ?x23293) (g_tt_l2_mem0_0 ?x23293) (g_tt_l2_mem0_1 ?x23293) (g_tt_l2_mem1_0 ?x23293) (g_tt_l2_mem1_1 ?x23293) (g_tt_l2_mem1_2 ?x23293) (g_tt_l2_mem1_3 ?x23293) (g_tt_l1_upper ?x23293) (g_mbedtls_mem_buf ?x23293) ?x8288 (g_rmm_attest_signing_key ?x23293) (g_rmm_attest_public_key ?x23293) (g_rmm_attest_public_key_len ?x23293) (g_rmm_attest_public_key_hash ?x23293) (g_rmm_attest_public_key_hash_len ?x23293) (g_platform_token_buf ?x23293) (g_rmm_platform_token ?x23293) (g_get_realm_identity_identity ?x23293) (g_realm_attest_private_key ?x23293))))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x4671 (granule_data ?x5391)))
 (let ((?x8365 (select ?x4671 ?x3316)))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x8204 (g_norm ?x8365)))
 (let ((?x44395 (store ?x8204 ?x4176 ?x35861)))
 (let ((?x8720 (mkr_granule_data (gd_g_idx ?x8365) (g_granule_state ?x8365) ?x44395 (g_rd ?x8365) (g_rec ?x8365))))
 (let ((?x5692 (store ?x4671 ?x3316 ?x8720)))
 (let ((?x8319 (gpt ?x5391)))
 (let ((?x8200 (priv ?x5023)))
 (let ((?x8068 (repl ?x5023)))
 (let ((?x52221 (oracle ?x5023)))
 (let ((?x7365 (log ?x5023)))
 (let ((?x8753 (granule_unlock_spec.0_call ?x3644 (mkRData ?x7365 ?x52221 ?x8068 ?x8200 (mkShared ?x8319 ?x5692 ?x8438) ?x8455 $x8334))))
 (let ((?x52250 (value_RData ?x8753)))
 (let ((?x1173018 (share ?x52250)))
 (let ((?x8077 (granule_data ?x1173018)))
 (let (($x8254 (= (g_norm (select ?x8077 gidx.375898)) zero_granule_data)))
 (let (($x8101 (= (e_state_s_granule (select (g_granules (globals ?x1173018)) gidx.375898)) 1)))
 (or (not $x8101) $x8254))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x44372) $x7829))))
(assert
 (let (($x8224 (forall ((gidx.375949 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x5684 (value_RData ?x4883)))
 (let ((?x4911 (make_return_code_para.0_call 8)))
 (let ((?x5525 (pack_struct_return_code_para.0_call ?x4911)))
 (let ((?x5648 (mkTuple_bool_Z_RData true ?x5525 ?x5684)))
 (let ((?x5504 (Some_Tuple_bool_Z_RData ?x5648)))
 (let (($x49228 (exists ((st_8.363906 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x4992 (value_RData ?x49044)))
 (let ((?x4883 (granule_unlock_spec.0_call ?x992 ?x4992)))
 (let ((?x736 (Some_RData st_8.363906)))
 (= ?x736 ?x4883))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x3164 (exists ((st_7.363910 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x4789 (value_Tuple_bool_Z_RData ?x5627)))
 (let ((?x5748 (elem_2 ?x4789)))
 (let ((?x49044 (granule_unlock_spec.0_call ?x3644 ?x5748)))
 (let ((?x736 (Some_RData st_7.363910)))
 (= ?x736 ?x49044))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5524 (elem_1 ?x4789)))
 (let ((?x61229 (mkTuple_bool_Z_RData true ?x5524 ?x5748)))
 (let ((?x48959 (Some_Tuple_bool_Z_RData ?x61229)))
 (let (($x4403 (elem_0 ?x4789)))
 (let ((?x41356 (ite $x4403 ?x48959 (ite (and $x3164 $x49228) ?x5504 None_Tuple_bool_Z_RData))))
 (let (($x4889 (exists ((__return___0.363915 Bool) (__retval___0.363915 Int) (st_5.363915 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x5436 (value_Tuple_bool_Z_RData ?x5742)))
 (let ((?x4994 (elem_2 ?x5436)))
 (let ((?x4553 (elem_1 ?x5436)))
 (let (($x3726 (elem_0 ?x5436)))
 (let ((?x5568 (mkTuple_bool_Z_RData $x3726 ?x4553 ?x4994)))
 (let ((?x5731 (Some_Tuple_bool_Z_RData ?x5568)))
 (let (($x5638 (exists ((__return___0.363881 Bool) (__retval___0.363881 Int) (st_5.363881 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x4658 (value_RData ?x4362)))
 (let ((?x5079 (make_return_code_para.0_call 9)))
 (let ((?x1904 (pack_struct_return_code_para.0_call ?x5079)))
 (let ((?x4569 (mkTuple_bool_Z_RData true ?x1904 ?x4658)))
 (let ((?x4643 (Some_Tuple_bool_Z_RData ?x4569)))
 (let (($x5394 (exists ((st_7.363866 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x4630 (value_RData ?x4675)))
 (let ((?x4362 (granule_unlock_spec.0_call ?x992 ?x4630)))
 (let ((?x736 (Some_RData st_7.363866)))
 (= ?x736 ?x4362)))))))))))))))))))))))))))))
 ))
 (let (($x41293 (exists ((st_6.363870 RData) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let ((?x3644 (e_2 ?x3391)))
 (let ((?x4675 (granule_unlock_spec.0_call ?x3644 ?x3479)))
 (let ((?x736 (Some_RData st_6.363870)))
 (= ?x736 ?x4675)))))))))))))))))))))))))))
 ))
 (let ((?x5742 (ite (and $x41293 $x5394) ?x4643 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363881 __retval___0.363881 st_5.363881)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5742))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x5627 (ite $x5638 ?x5731 None_Tuple_bool_Z_RData)))
 (let ((?x1901 (mkTuple_bool_Z_RData __return___0.363915 __retval___0.363915 st_5.363915)))
 (let ((?x1896 (Some_Tuple_bool_Z_RData ?x1901)))
 (= ?x1896 ?x5627))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let ((?x4972 (value_Tuple_bool_Z_RData (ite $x4889 ?x41356 None_Tuple_bool_Z_RData))))
 (let ((?x5023 (elem_2 ?x4972)))
 (let (($x8334 (halt ?x5023)))
 (let ((?x8455 (stack ?x5023)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x5391 (share ?x5023)))
 (let ((?x23293 (globals ?x5391)))
 (let ((?x41501 (g_granules ?x23293)))
 (let ((?x6869 (select ?x41501 ?x28222)))
 (let ((?x8426 (mks_granule (e_lock ?x6869) 5 (e_ref ?x6869))))
 (let ((?x8288 (store ?x41501 ?x28222 ?x8426)))
 (let ((?x8438 (mkGLOBALS (g_heap ?x23293) (g_debug_exits ?x23293) (g_vmid_count ?x23293) (g_vmid_lock ?x23293) (g_vmids ?x23293) (g_nr_lrs ?x23293) (g_nr_aprs ?x23293) (g_max_vintid ?x23293) (g_pri_res0_mask ?x23293) (g_default_gicstate ?x23293) (g_status_handler ?x23293) (g_rmm_trap_list ?x23293) (g_tt_l3_buffer ?x23293) (g_tt_l2_mem0_0 ?x23293) (g_tt_l2_mem0_1 ?x23293) (g_tt_l2_mem1_0 ?x23293) (g_tt_l2_mem1_1 ?x23293) (g_tt_l2_mem1_2 ?x23293) (g_tt_l2_mem1_3 ?x23293) (g_tt_l1_upper ?x23293) (g_mbedtls_mem_buf ?x23293) ?x8288 (g_rmm_attest_signing_key ?x23293) (g_rmm_attest_public_key ?x23293) (g_rmm_attest_public_key_len ?x23293) (g_rmm_attest_public_key_hash ?x23293) (g_rmm_attest_public_key_hash_len ?x23293) (g_platform_token_buf ?x23293) (g_rmm_platform_token ?x23293) (g_get_realm_identity_identity ?x23293) (g_realm_attest_private_key ?x23293))))
 (let ((?x3669 (e_3 ?x3391)))
 (let ((?x3667 (* 8 ?x3669)))
 (let ((?x3662 (poffset ?x3644)))
 (let ((?x3590 (+ ?x3662 ?x3667)))
 (let ((?x3316 (div ?x3590 4096)))
 (let ((?x4671 (granule_data ?x5391)))
 (let ((?x8365 (select ?x4671 ?x3316)))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x4176 (mod ?x3590 4096)))
 (let ((?x8204 (g_norm ?x8365)))
 (let ((?x44395 (store ?x8204 ?x4176 ?x35861)))
 (let ((?x8720 (mkr_granule_data (gd_g_idx ?x8365) (g_granule_state ?x8365) ?x44395 (g_rd ?x8365) (g_rec ?x8365))))
 (let ((?x5692 (store ?x4671 ?x3316 ?x8720)))
 (let ((?x8319 (gpt ?x5391)))
 (let ((?x8200 (priv ?x5023)))
 (let ((?x8068 (repl ?x5023)))
 (let ((?x52221 (oracle ?x5023)))
 (let ((?x7365 (log ?x5023)))
 (let ((?x8753 (granule_unlock_spec.0_call ?x3644 (mkRData ?x7365 ?x52221 ?x8068 ?x8200 (mkShared ?x8319 ?x5692 ?x8438) ?x8455 $x8334))))
 (let ((?x52250 (value_RData ?x8753)))
 (let ((?x1173018 (share ?x52250)))
 (let ((?x8077 (granule_data ?x1173018)))
 (let (($x8254 (= (g_norm (select ?x8077 gidx.375949)) zero_granule_data)))
 (let (($x8101 (= (e_state_s_granule (select (g_granules (globals ?x1173018)) gidx.375949)) 1)))
 (=> $x8101 $x8254))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (not $x8224)))
(check-sat)
