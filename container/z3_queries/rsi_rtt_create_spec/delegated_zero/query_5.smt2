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
(declare-fun v_0_Zptr.0 () Int)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
  (repl (value_RData a!2))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
  (oracle (value_RData a!2))))_call| (List_Event) List_Event)
(declare-fun rtt_walk_lock_unlock_spec_abs.0_call (Ptr Ptr Int Int Int Int RData) Option_Tuple_abs_ret_rtt_RData)
(declare-fun v_3.0 () Int)
(declare-fun v_2.0 () Int)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
  (repl (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
  (oracle (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))_call| (List_Event) List_Event)
(declare-fun abs_tte_read.0_call (Ptr RData) abs_PTE_t)
(declare-fun s2tt_init_unassigned_spec.0_call (Ptr Int RData) Option_RData)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
(let ((a!4 (poffset (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (* 8 (e_3 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (meta_ripas (abs_tte_read.0_call
                         (mkPtr "granule_data" (+ a!4 a!5))
                         (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!6
             (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
  (repl (value_RData a!7))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
(let ((a!4 (poffset (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (* 8 (e_3 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (meta_ripas (abs_tte_read.0_call
                         (mkPtr "granule_data" (+ a!4 a!5))
                         (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!6
             (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
  (oracle (value_RData a!7))))))))_call| (List_Event) List_Event)
(declare-fun granule_unlock_spec.0_call (Ptr RData) Option_RData)
(declare-fun test_PTE_Z.0_call (abs_PTE_t) Int)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!37 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
(let ((a!4 (poffset (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (* 8 (e_3 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (meta_ripas (abs_tte_read.0_call
                         (mkPtr "granule_data" (+ a!4 a!5))
                         (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!6
             (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
(let ((a!8 (select (granule_data (share (value_RData a!7)))
                   (div (+ a!4 a!5) 4096)))
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
      (a!40 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!44 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!45 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!46 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!47 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!48 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod (+ a!4 a!5) 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!33 (e_lock (select a!32 (div (+ 8 a!4) 4096))))
      (a!34 (e_state_s_granule (select a!32 (div (+ 8 a!4) 4096))))
      (a!35 (e_ref (select a!32 (div (+ 8 a!4) 4096)))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div (+ a!4 a!5) 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!36 (mks_granule a!33 a!34 (mku_anon_3 (+ 1 (e_u_anon_3_0 a!35))))))
(let ((a!38 (select (store a!32 (div (+ 8 a!4) 4096) a!36) a!37)))
(let ((a!39 (store (store a!32 (div (+ 8 a!4) 4096) a!36)
                   a!37
                   (mks_granule (e_lock a!38) 5 (e_ref a!38)))))
(let ((a!49 (mkShared (gpt (share (value_RData a!7)))
                      a!10
                      (mkGLOBALS a!11
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
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
  (repl (value_RData a!50)))))))))))))))_call| (List_Event Shared) Option_Shared)
(declare-fun |(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!37 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
(let ((a!4 (poffset (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (* 8 (e_3 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (meta_ripas (abs_tte_read.0_call
                         (mkPtr "granule_data" (+ a!4 a!5))
                         (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!6
             (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
(let ((a!8 (select (granule_data (share (value_RData a!7)))
                   (div (+ a!4 a!5) 4096)))
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
      (a!40 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!44 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!45 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!46 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!47 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!48 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod (+ a!4 a!5) 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!33 (e_lock (select a!32 (div (+ 8 a!4) 4096))))
      (a!34 (e_state_s_granule (select a!32 (div (+ 8 a!4) 4096))))
      (a!35 (e_ref (select a!32 (div (+ 8 a!4) 4096)))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div (+ a!4 a!5) 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!36 (mks_granule a!33 a!34 (mku_anon_3 (+ 1 (e_u_anon_3_0 a!35))))))
(let ((a!38 (select (store a!32 (div (+ 8 a!4) 4096) a!36) a!37)))
(let ((a!39 (store (store a!32 (div (+ 8 a!4) 4096) a!36)
                   a!37
                   (mks_granule (e_lock a!38) 5 (e_ref a!38)))))
(let ((a!49 (mkShared (gpt (share (value_RData a!7)))
                      a!10
                      (mkGLOBALS a!11
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
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
  (oracle (value_RData a!50)))))))))))))))_call| (List_Event) List_Event)
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
 (check_rcsm_mask_para.0_call ?x1597)))
(assert
 (forall ((gidx.365744 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x9777 (share ?x1634)))
 (let ((?x897 (granule_data ?x9777)))
 (let (($x918 (= (g_norm (select ?x897 gidx.365744)) zero_granule_data)))
 (let (($x913 (= (e_state_s_granule (select (g_granules (globals ?x9777)) gidx.365744)) 1)))
 (=> $x913 $x918)))))))))))
 )
(assert
 (forall ((v_0.365779 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.365779))) 4096)))
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
 (let (($x1032 (forall ((gidx.365915 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
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
 (let (($x922 (= (g_norm (select ?x904 gidx.365915)) zero_granule_data)))
 (let (($x984 (= (e_state_s_granule (select (g_granules (globals ?x920)) gidx.365915)) 1)))
 (or (not $x984) $x922)))))))))))))))
 ))
 (let (($x1016 (forall ((gidx.365904 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x9777 (share ?x1634)))
 (let ((?x897 (granule_data ?x9777)))
 (let (($x918 (= (g_norm (select ?x897 gidx.365904)) zero_granule_data)))
 (let (($x913 (= (e_state_s_granule (select (g_granules (globals ?x9777)) gidx.365904)) 1)))
 (or (not $x913) $x918)))))))))))
 ))
 (or (not $x1016) $x1032))))
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
 (= ?x978 5)))))))))))))
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
 (forall ((gidx.365992 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x19888 (share ?x1050)))
 (let ((?x1122 (granule_data ?x19888)))
 (let (($x1055 (= (g_norm (select ?x1122 gidx.365992)) zero_granule_data)))
 (let (($x1152 (= (e_state_s_granule (select (g_granules (globals ?x19888)) gidx.365992)) 1)))
 (=> $x1152 $x1055))))))))))))))))
 )
(assert
 (forall ((v_0.366027 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.366027))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x19888 (share ?x1050)))
 (let ((?x1140 (gpt ?x19888)))
 (select ?x1140 ?x1632)))))))))))))))
 )
(assert
 (let (($x1180 (forall ((gidx.366163 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x19888 (share ?x1050)))
 (let ((?x1143 (log ?x1050)))
 (let ((?x1045 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
  (oracle (value_RData a!2))))_call| ?x1143)))
 (let ((?x1114 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
  (repl (value_RData a!2))))_call| ?x1045 ?x19888)))
 (let ((?x1151 (value_Shared ?x1114)))
 (let ((?x1160 (granule_data ?x1151)))
 (let (($x1169 (= (g_norm (select ?x1160 gidx.366163)) zero_granule_data)))
 (let (($x1172 (= (e_state_s_granule (select (g_granules (globals ?x1151)) gidx.366163)) 1)))
 (or (not $x1172) $x1169))))))))))))))))))))
 ))
 (let (($x1177 (forall ((gidx.366152 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x19888 (share ?x1050)))
 (let ((?x1122 (granule_data ?x19888)))
 (let (($x1055 (= (g_norm (select ?x1122 gidx.366152)) zero_granule_data)))
 (let (($x1152 (= (e_state_s_granule (select (g_granules (globals ?x19888)) gidx.366152)) 1)))
 (or (not $x1152) $x1055))))))))))))))))
 ))
 (or (not $x1177) $x1180))))
(assert
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x1120 (div ?x991 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x19888 (share ?x1050)))
 (let ((?x1036 (globals ?x19888)))
 (let ((?x1063 (g_granules ?x1036)))
 (let ((?x1129 (select ?x1063 ?x1120)))
 (let ((?x1135 (e_state_s_granule ?x1129)))
 (= ?x1135 1))))))))))))))))))
(assert
 (forall ((gidx.366240 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x29612 (share ?x1186)))
 (let ((?x1288 (granule_data ?x29612)))
 (let (($x1296 (= (g_norm (select ?x1288 gidx.366240)) zero_granule_data)))
 (let (($x1352 (= (e_state_s_granule (select (g_granules (globals ?x29612)) gidx.366240)) 1)))
 (=> $x1352 $x1296))))))))))))))))))))
 )
(assert
 (forall ((v_0.366275 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.366275))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x29612 (share ?x1186)))
 (let ((?x1328 (gpt ?x29612)))
 (select ?x1328 ?x1632)))))))))))))))))))
 )
(assert
 (let (($x1307 (forall ((gidx.366411 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x29612 (share ?x1186)))
 (let ((?x1200 (log ?x1186)))
 (let ((?x1268 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
  (oracle (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))_call| ?x1200)))
 (let ((?x1350 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
  (repl (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))_call| ?x1268 ?x29612)))
 (let ((?x863 (value_Shared ?x1350)))
 (let ((?x1320 (granule_data ?x863)))
 (let (($x1199 (= (g_norm (select ?x1320 gidx.366411)) zero_granule_data)))
 (let (($x1304 (= (e_state_s_granule (select (g_granules (globals ?x863)) gidx.366411)) 1)))
 (or (not $x1304) $x1199))))))))))))))))))))))))
 ))
 (let (($x1269 (forall ((gidx.366400 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x29612 (share ?x1186)))
 (let ((?x1288 (granule_data ?x29612)))
 (let (($x1296 (= (g_norm (select ?x1288 gidx.366400)) zero_granule_data)))
 (let (($x1352 (= (e_state_s_granule (select (g_granules (globals ?x29612)) gidx.366400)) 1)))
 (or (not $x1352) $x1296))))))))))))))))))))
 ))
 (or (not $x1269) $x1307))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1341 (div ?x1318 4096)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x29612 (share ?x1186)))
 (let ((?x1273 (globals ?x29612)))
 (let ((?x1274 (g_granules ?x1273)))
 (let ((?x1319 (select ?x1274 ?x1341)))
 (let ((?x1322 (e_state_s_granule ?x1319)))
 (= ?x1322 5))))))))))))))))))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x46151 (pbase ?x1204)))
 (= ?x46151 "granules"))))))))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x47309 (mod ?x1206 4096)))
 (= ?x47309 0)))))))))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x47375 (e_1 ?x1189)))
 (let (($x1465 (>= ?x47375 0)))
 (let (($x1455 (<= ?x47375 3)))
 (and $x1455 $x1465)))))))))))))))))))
(assert
 (let ((?x1469 (* (- 1) v_3.0)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x47375 (e_1 ?x1189)))
 (= (+ ?x47375 ?x1469) (- 1)))))))))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let (($x1347 (= ?x1348 0)))
 (let ((?x1458 (meta_desc_type ?x1363)))
 (let (($x1454 (= ?x1458 0)))
 (and $x1454 $x1347))))))))))))))))))))))))))))
(assert
 (forall ((gidx.366488 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x1525 (s2tt_init_unassigned_spec.0_call ?x1388 ?x1348 ?x1186)))
 (let ((?x1539 (value_RData ?x1525)))
 (let ((?x47450 (share ?x1539)))
 (let ((?x28038 (granule_data ?x47450)))
 (let (($x1100 (= (g_norm (select ?x28038 gidx.366488)) zero_granule_data)))
 (let (($x1601 (= (e_state_s_granule (select (g_granules (globals ?x47450)) gidx.366488)) 1)))
 (=> $x1601 $x1100))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.366523 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.366523))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x1525 (s2tt_init_unassigned_spec.0_call ?x1388 ?x1348 ?x1186)))
 (let ((?x1539 (value_RData ?x1525)))
 (let ((?x47450 (share ?x1539)))
 (let ((?x1391 (gpt ?x47450)))
 (select ?x1391 ?x1632)))))))))))))))))))))))))))))))
 )
(assert
 (let (($x1514 (forall ((gidx.366659 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x1525 (s2tt_init_unassigned_spec.0_call ?x1388 ?x1348 ?x1186)))
 (let ((?x1539 (value_RData ?x1525)))
 (let ((?x47450 (share ?x1539)))
 (let ((?x28036 (log ?x1539)))
 (let ((?x1640 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
(let ((a!4 (poffset (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (* 8 (e_3 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (meta_ripas (abs_tte_read.0_call
                         (mkPtr "granule_data" (+ a!4 a!5))
                         (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!6
             (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
  (oracle (value_RData a!7))))))))_call| ?x28036)))
 (let ((?x1571 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
(let ((a!4 (poffset (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (* 8 (e_3 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (meta_ripas (abs_tte_read.0_call
                         (mkPtr "granule_data" (+ a!4 a!5))
                         (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!6
             (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
  (repl (value_RData a!7))))))))_call| ?x1640 ?x47450)))
 (let ((?x1653 (value_Shared ?x1571)))
 (let ((?x1359 (granule_data ?x1653)))
 (let (($x1561 (= (g_norm (select ?x1359 gidx.366659)) zero_granule_data)))
 (let (($x1567 (= (e_state_s_granule (select (g_granules (globals ?x1653)) gidx.366659)) 1)))
 (or (not $x1567) $x1561))))))))))))))))))))))))))))))))))))
 ))
 (let (($x1602 (forall ((gidx.366648 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x1525 (s2tt_init_unassigned_spec.0_call ?x1388 ?x1348 ?x1186)))
 (let ((?x1539 (value_RData ?x1525)))
 (let ((?x47450 (share ?x1539)))
 (let ((?x28038 (granule_data ?x47450)))
 (let (($x1100 (= (g_norm (select ?x28038 gidx.366648)) zero_granule_data)))
 (let (($x1601 (= (e_state_s_granule (select (g_granules (globals ?x47450)) gidx.366648)) 1)))
 (or (not $x1601) $x1100))))))))))))))))))))))))))))))))
 ))
 (or (not $x1602) $x1514))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1341 (div ?x1318 4096)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x1525 (s2tt_init_unassigned_spec.0_call ?x1388 ?x1348 ?x1186)))
 (let ((?x1539 (value_RData ?x1525)))
 (let ((?x47450 (share ?x1539)))
 (let ((?x1618 (globals ?x47450)))
 (let ((?x28034 (g_granules ?x1618)))
 (let ((?x1654 (select ?x28034 ?x1341)))
 (let ((?x1656 (e_state_s_granule ?x1654)))
 (= ?x1656 5))))))))))))))))))))))))))))))))))
(assert
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1695 (+ 8 ?x1206)))
 (let ((?x56326 (mod ?x1695 4096)))
 (= ?x56326 8))))))))))))))))))))
(assert
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x57321 (mod ?x991 4096)))
 (= ?x57321 0)))))
(assert
 (forall ((gidx.366736 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x1525 (s2tt_init_unassigned_spec.0_call ?x1388 ?x1348 ?x1186)))
 (let ((?x1539 (value_RData ?x1525)))
 (let (($x28082 (halt ?x1539)))
 (let ((?x28093 (stack ?x1539)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x1695 (+ 8 ?x1206)))
 (let ((?x28224 (div ?x1695 4096)))
 (let ((?x47450 (share ?x1539)))
 (let ((?x1618 (globals ?x47450)))
 (let ((?x28034 (g_granules ?x1618)))
 (let ((?x28225 (select ?x28034 ?x28224)))
 (let ((?x35765 (e_ref ?x28225)))
 (let ((?x36032 (e_u_anon_3_0 ?x35765)))
 (let ((?x36021 (+ 1 ?x36032)))
 (let ((?x36020 (mku_anon_3 ?x36021)))
 (let ((?x28231 (mks_granule (e_lock ?x28225) (e_state_s_granule ?x28225) ?x36020)))
 (let ((?x28226 (store ?x28034 ?x28224 ?x28231)))
 (let ((?x28192 (select ?x28226 ?x28222)))
 (let ((?x4534 (mks_granule (e_lock ?x28192) 5 (e_ref ?x28192))))
 (let ((?x1677 (store ?x28226 ?x28222 ?x4534)))
 (let ((?x35865 (mkGLOBALS (g_heap ?x1618) (g_debug_exits ?x1618) (g_vmid_count ?x1618) (g_vmid_lock ?x1618) (g_vmids ?x1618) (g_nr_lrs ?x1618) (g_nr_aprs ?x1618) (g_max_vintid ?x1618) (g_pri_res0_mask ?x1618) (g_default_gicstate ?x1618) (g_status_handler ?x1618) (g_rmm_trap_list ?x1618) (g_tt_l3_buffer ?x1618) (g_tt_l2_mem0_0 ?x1618) (g_tt_l2_mem0_1 ?x1618) (g_tt_l2_mem1_0 ?x1618) (g_tt_l2_mem1_1 ?x1618) (g_tt_l2_mem1_2 ?x1618) (g_tt_l2_mem1_3 ?x1618) (g_tt_l1_upper ?x1618) (g_mbedtls_mem_buf ?x1618) ?x1677 (g_rmm_attest_signing_key ?x1618) (g_rmm_attest_public_key ?x1618) (g_rmm_attest_public_key_len ?x1618) (g_rmm_attest_public_key_hash ?x1618) (g_rmm_attest_public_key_hash_len ?x1618) (g_platform_token_buf ?x1618) (g_rmm_platform_token ?x1618) (g_get_realm_identity_identity ?x1618) (g_realm_attest_private_key ?x1618))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x1746 (mod ?x1318 4096)))
 (let ((?x1341 (div ?x1318 4096)))
 (let ((?x28038 (granule_data ?x47450)))
 (let ((?x1728 (select ?x28038 ?x1341)))
 (let ((?x1723 (g_norm ?x1728)))
 (let ((?x1264 (store ?x1723 ?x1746 ?x35861)))
 (let ((?x1520 (mkr_granule_data (gd_g_idx ?x1728) (g_granule_state ?x1728) ?x1264 (g_rd ?x1728) (g_rec ?x1728))))
 (let ((?x1604 (store ?x28038 ?x1341 ?x1520)))
 (let ((?x1391 (gpt ?x47450)))
 (let ((?x28092 (priv ?x1539)))
 (let ((?x1590 (repl ?x1539)))
 (let ((?x1658 (oracle ?x1539)))
 (let ((?x28036 (log ?x1539)))
 (let ((?x35868 (granule_unlock_spec.0_call ?x1204 (mkRData ?x28036 ?x1658 ?x1590 ?x28092 (mkShared ?x1391 ?x1604 ?x35865) ?x28093 $x28082))))
 (let ((?x4537 (value_RData ?x35868)))
 (let ((?x57518 (share ?x4537)))
 (let ((?x1841 (granule_data ?x57518)))
 (let (($x1795 (= (g_norm (select ?x1841 gidx.366736)) zero_granule_data)))
 (let (($x1831 (= (e_state_s_granule (select (g_granules (globals ?x57518)) gidx.366736)) 1)))
 (=> $x1831 $x1795)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (forall ((v_0.366771 Int) )(let ((?x1632 (div (meta_granule_offset (meta_PA (test_Z_PTE.0_call v_0.366771))) 4096)))
 (let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x1525 (s2tt_init_unassigned_spec.0_call ?x1388 ?x1348 ?x1186)))
 (let ((?x1539 (value_RData ?x1525)))
 (let (($x28082 (halt ?x1539)))
 (let ((?x28093 (stack ?x1539)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x1695 (+ 8 ?x1206)))
 (let ((?x28224 (div ?x1695 4096)))
 (let ((?x47450 (share ?x1539)))
 (let ((?x1618 (globals ?x47450)))
 (let ((?x28034 (g_granules ?x1618)))
 (let ((?x28225 (select ?x28034 ?x28224)))
 (let ((?x35765 (e_ref ?x28225)))
 (let ((?x36032 (e_u_anon_3_0 ?x35765)))
 (let ((?x36021 (+ 1 ?x36032)))
 (let ((?x36020 (mku_anon_3 ?x36021)))
 (let ((?x28231 (mks_granule (e_lock ?x28225) (e_state_s_granule ?x28225) ?x36020)))
 (let ((?x28226 (store ?x28034 ?x28224 ?x28231)))
 (let ((?x28192 (select ?x28226 ?x28222)))
 (let ((?x4534 (mks_granule (e_lock ?x28192) 5 (e_ref ?x28192))))
 (let ((?x1677 (store ?x28226 ?x28222 ?x4534)))
 (let ((?x35865 (mkGLOBALS (g_heap ?x1618) (g_debug_exits ?x1618) (g_vmid_count ?x1618) (g_vmid_lock ?x1618) (g_vmids ?x1618) (g_nr_lrs ?x1618) (g_nr_aprs ?x1618) (g_max_vintid ?x1618) (g_pri_res0_mask ?x1618) (g_default_gicstate ?x1618) (g_status_handler ?x1618) (g_rmm_trap_list ?x1618) (g_tt_l3_buffer ?x1618) (g_tt_l2_mem0_0 ?x1618) (g_tt_l2_mem0_1 ?x1618) (g_tt_l2_mem1_0 ?x1618) (g_tt_l2_mem1_1 ?x1618) (g_tt_l2_mem1_2 ?x1618) (g_tt_l2_mem1_3 ?x1618) (g_tt_l1_upper ?x1618) (g_mbedtls_mem_buf ?x1618) ?x1677 (g_rmm_attest_signing_key ?x1618) (g_rmm_attest_public_key ?x1618) (g_rmm_attest_public_key_len ?x1618) (g_rmm_attest_public_key_hash ?x1618) (g_rmm_attest_public_key_hash_len ?x1618) (g_platform_token_buf ?x1618) (g_rmm_platform_token ?x1618) (g_get_realm_identity_identity ?x1618) (g_realm_attest_private_key ?x1618))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x1746 (mod ?x1318 4096)))
 (let ((?x1341 (div ?x1318 4096)))
 (let ((?x28038 (granule_data ?x47450)))
 (let ((?x1728 (select ?x28038 ?x1341)))
 (let ((?x1723 (g_norm ?x1728)))
 (let ((?x1264 (store ?x1723 ?x1746 ?x35861)))
 (let ((?x1520 (mkr_granule_data (gd_g_idx ?x1728) (g_granule_state ?x1728) ?x1264 (g_rd ?x1728) (g_rec ?x1728))))
 (let ((?x1604 (store ?x28038 ?x1341 ?x1520)))
 (let ((?x1391 (gpt ?x47450)))
 (let ((?x28092 (priv ?x1539)))
 (let ((?x1590 (repl ?x1539)))
 (let ((?x1658 (oracle ?x1539)))
 (let ((?x28036 (log ?x1539)))
 (let ((?x35868 (granule_unlock_spec.0_call ?x1204 (mkRData ?x28036 ?x1658 ?x1590 ?x28092 (mkShared ?x1391 ?x1604 ?x35865) ?x28093 $x28082))))
 (let ((?x4537 (value_RData ?x35868)))
 (let ((?x57518 (share ?x4537)))
 (let ((?x1890 (gpt ?x57518)))
 (select ?x1890 ?x1632))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 )
(assert
 (let (($x28243 (forall ((gidx.366907 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x1525 (s2tt_init_unassigned_spec.0_call ?x1388 ?x1348 ?x1186)))
 (let ((?x1539 (value_RData ?x1525)))
 (let (($x28082 (halt ?x1539)))
 (let ((?x28093 (stack ?x1539)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x1695 (+ 8 ?x1206)))
 (let ((?x28224 (div ?x1695 4096)))
 (let ((?x47450 (share ?x1539)))
 (let ((?x1618 (globals ?x47450)))
 (let ((?x28034 (g_granules ?x1618)))
 (let ((?x28225 (select ?x28034 ?x28224)))
 (let ((?x35765 (e_ref ?x28225)))
 (let ((?x36032 (e_u_anon_3_0 ?x35765)))
 (let ((?x36021 (+ 1 ?x36032)))
 (let ((?x36020 (mku_anon_3 ?x36021)))
 (let ((?x28231 (mks_granule (e_lock ?x28225) (e_state_s_granule ?x28225) ?x36020)))
 (let ((?x28226 (store ?x28034 ?x28224 ?x28231)))
 (let ((?x28192 (select ?x28226 ?x28222)))
 (let ((?x4534 (mks_granule (e_lock ?x28192) 5 (e_ref ?x28192))))
 (let ((?x1677 (store ?x28226 ?x28222 ?x4534)))
 (let ((?x35865 (mkGLOBALS (g_heap ?x1618) (g_debug_exits ?x1618) (g_vmid_count ?x1618) (g_vmid_lock ?x1618) (g_vmids ?x1618) (g_nr_lrs ?x1618) (g_nr_aprs ?x1618) (g_max_vintid ?x1618) (g_pri_res0_mask ?x1618) (g_default_gicstate ?x1618) (g_status_handler ?x1618) (g_rmm_trap_list ?x1618) (g_tt_l3_buffer ?x1618) (g_tt_l2_mem0_0 ?x1618) (g_tt_l2_mem0_1 ?x1618) (g_tt_l2_mem1_0 ?x1618) (g_tt_l2_mem1_1 ?x1618) (g_tt_l2_mem1_2 ?x1618) (g_tt_l2_mem1_3 ?x1618) (g_tt_l1_upper ?x1618) (g_mbedtls_mem_buf ?x1618) ?x1677 (g_rmm_attest_signing_key ?x1618) (g_rmm_attest_public_key ?x1618) (g_rmm_attest_public_key_len ?x1618) (g_rmm_attest_public_key_hash ?x1618) (g_rmm_attest_public_key_hash_len ?x1618) (g_platform_token_buf ?x1618) (g_rmm_platform_token ?x1618) (g_get_realm_identity_identity ?x1618) (g_realm_attest_private_key ?x1618))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x1746 (mod ?x1318 4096)))
 (let ((?x1341 (div ?x1318 4096)))
 (let ((?x28038 (granule_data ?x47450)))
 (let ((?x1728 (select ?x28038 ?x1341)))
 (let ((?x1723 (g_norm ?x1728)))
 (let ((?x1264 (store ?x1723 ?x1746 ?x35861)))
 (let ((?x1520 (mkr_granule_data (gd_g_idx ?x1728) (g_granule_state ?x1728) ?x1264 (g_rd ?x1728) (g_rec ?x1728))))
 (let ((?x1604 (store ?x28038 ?x1341 ?x1520)))
 (let ((?x1391 (gpt ?x47450)))
 (let ((?x28092 (priv ?x1539)))
 (let ((?x1590 (repl ?x1539)))
 (let ((?x1658 (oracle ?x1539)))
 (let ((?x28036 (log ?x1539)))
 (let ((?x35868 (granule_unlock_spec.0_call ?x1204 (mkRData ?x28036 ?x1658 ?x1590 ?x28092 (mkShared ?x1391 ?x1604 ?x35865) ?x28093 $x28082))))
 (let ((?x4537 (value_RData ?x35868)))
 (let ((?x57518 (share ?x4537)))
 (let ((?x1889 (log ?x4537)))
 (let ((?x1775 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!37 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
(let ((a!4 (poffset (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (* 8 (e_3 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (meta_ripas (abs_tte_read.0_call
                         (mkPtr "granule_data" (+ a!4 a!5))
                         (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!6
             (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
(let ((a!8 (select (granule_data (share (value_RData a!7)))
                   (div (+ a!4 a!5) 4096)))
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
      (a!40 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!44 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!45 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!46 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!47 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!48 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod (+ a!4 a!5) 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!33 (e_lock (select a!32 (div (+ 8 a!4) 4096))))
      (a!34 (e_state_s_granule (select a!32 (div (+ 8 a!4) 4096))))
      (a!35 (e_ref (select a!32 (div (+ 8 a!4) 4096)))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div (+ a!4 a!5) 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!36 (mks_granule a!33 a!34 (mku_anon_3 (+ 1 (e_u_anon_3_0 a!35))))))
(let ((a!38 (select (store a!32 (div (+ 8 a!4) 4096) a!36) a!37)))
(let ((a!39 (store (store a!32 (div (+ 8 a!4) 4096) a!36)
                   a!37
                   (mks_granule (e_lock a!38) 5 (e_ref a!38)))))
(let ((a!49 (mkShared (gpt (share (value_RData a!7)))
                      a!10
                      (mkGLOBALS a!11
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
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
  (oracle (value_RData a!50)))))))))))))))_call| ?x1889)))
 (let ((?x1773 (|(let ((a!1 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             st.0))
      (a!37 (div (+ 4 (meta_granule_offset (test_PA.0_call v_0_Zptr.0))) 4096)))
(let ((a!2 (spinlock_acquire_spec.0_call
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             (value_RData a!1))))
(let ((a!3 (rtt_walk_lock_unlock_spec_abs.0_call
             (mkPtr "stack_s_rtt_walk" 0)
             (mkPtr "granules"
                    (meta_granule_offset (test_PA.0_call v_1_Zptr.0)))
             0
             64
             v_2.0
             v_3.0
             (value_RData a!2))))
(let ((a!4 (poffset (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))))
      (a!5 (* 8 (e_3 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!6 (meta_ripas (abs_tte_read.0_call
                         (mkPtr "granule_data" (+ a!4 a!5))
                         (elem_1 (value_Tuple_abs_ret_rtt_RData a!3))))))
(let ((a!7 (s2tt_init_unassigned_spec.0_call
             (mkPtr "granule_data"
                    (meta_granule_offset (test_PA.0_call v_0_Zptr.0)))
             a!6
             (elem_1 (value_Tuple_abs_ret_rtt_RData a!3)))))
(let ((a!8 (select (granule_data (share (value_RData a!7)))
                   (div (+ a!4 a!5) 4096)))
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
      (a!40 (g_rmm_attest_signing_key (globals (share (value_RData a!7)))))
      (a!41 (g_rmm_attest_public_key (globals (share (value_RData a!7)))))
      (a!42 (g_rmm_attest_public_key_len (globals (share (value_RData a!7)))))
      (a!43 (g_rmm_attest_public_key_hash (globals (share (value_RData a!7)))))
      (a!44 (g_rmm_attest_public_key_hash_len
              (globals (share (value_RData a!7)))))
      (a!45 (g_platform_token_buf (globals (share (value_RData a!7)))))
      (a!46 (g_rmm_platform_token (globals (share (value_RData a!7)))))
      (a!47 (g_get_realm_identity_identity (globals (share (value_RData a!7)))))
      (a!48 (g_realm_attest_private_key (globals (share (value_RData a!7))))))
(let ((a!9 (store (g_norm a!8)
                  (mod (+ a!4 a!5) 4096)
                  (test_PTE_Z.0_call
                    (mkabs_PTE_t (test_PA.0_call v_0_Zptr.0) 3 0 0))))
      (a!33 (e_lock (select a!32 (div (+ 8 a!4) 4096))))
      (a!34 (e_state_s_granule (select a!32 (div (+ 8 a!4) 4096))))
      (a!35 (e_ref (select a!32 (div (+ 8 a!4) 4096)))))
(let ((a!10 (store (granule_data (share (value_RData a!7)))
                   (div (+ a!4 a!5) 4096)
                   (mkr_granule_data (gd_g_idx a!8)
                                     (g_granule_state a!8)
                                     a!9
                                     (g_rd a!8)
                                     (g_rec a!8))))
      (a!36 (mks_granule a!33 a!34 (mku_anon_3 (+ 1 (e_u_anon_3_0 a!35))))))
(let ((a!38 (select (store a!32 (div (+ 8 a!4) 4096) a!36) a!37)))
(let ((a!39 (store (store a!32 (div (+ 8 a!4) 4096) a!36)
                   a!37
                   (mks_granule (e_lock a!38) 5 (e_ref a!38)))))
(let ((a!49 (mkShared (gpt (share (value_RData a!7)))
                      a!10
                      (mkGLOBALS a!11
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
              (e_2 (elem_0 (value_Tuple_abs_ret_rtt_RData a!3)))
              (mkRData (log (value_RData a!7))
                       (oracle (value_RData a!7))
                       (repl (value_RData a!7))
                       (priv (value_RData a!7))
                       a!49
                       (stack (value_RData a!7))
                       (halt (value_RData a!7))))))
  (repl (value_RData a!50)))))))))))))))_call| ?x1775 ?x57518)))
 (let ((?x1770 (value_Shared ?x1773)))
 (let ((?x1758 (granule_data ?x1770)))
 (let (($x35986 (= (g_norm (select ?x1758 gidx.366907)) zero_granule_data)))
 (let (($x36079 (= (e_state_s_granule (select (g_granules (globals ?x1770)) gidx.366907)) 1)))
 (or (not $x36079) $x35986)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (let (($x27436 (forall ((gidx.366896 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x1525 (s2tt_init_unassigned_spec.0_call ?x1388 ?x1348 ?x1186)))
 (let ((?x1539 (value_RData ?x1525)))
 (let (($x28082 (halt ?x1539)))
 (let ((?x28093 (stack ?x1539)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x1695 (+ 8 ?x1206)))
 (let ((?x28224 (div ?x1695 4096)))
 (let ((?x47450 (share ?x1539)))
 (let ((?x1618 (globals ?x47450)))
 (let ((?x28034 (g_granules ?x1618)))
 (let ((?x28225 (select ?x28034 ?x28224)))
 (let ((?x35765 (e_ref ?x28225)))
 (let ((?x36032 (e_u_anon_3_0 ?x35765)))
 (let ((?x36021 (+ 1 ?x36032)))
 (let ((?x36020 (mku_anon_3 ?x36021)))
 (let ((?x28231 (mks_granule (e_lock ?x28225) (e_state_s_granule ?x28225) ?x36020)))
 (let ((?x28226 (store ?x28034 ?x28224 ?x28231)))
 (let ((?x28192 (select ?x28226 ?x28222)))
 (let ((?x4534 (mks_granule (e_lock ?x28192) 5 (e_ref ?x28192))))
 (let ((?x1677 (store ?x28226 ?x28222 ?x4534)))
 (let ((?x35865 (mkGLOBALS (g_heap ?x1618) (g_debug_exits ?x1618) (g_vmid_count ?x1618) (g_vmid_lock ?x1618) (g_vmids ?x1618) (g_nr_lrs ?x1618) (g_nr_aprs ?x1618) (g_max_vintid ?x1618) (g_pri_res0_mask ?x1618) (g_default_gicstate ?x1618) (g_status_handler ?x1618) (g_rmm_trap_list ?x1618) (g_tt_l3_buffer ?x1618) (g_tt_l2_mem0_0 ?x1618) (g_tt_l2_mem0_1 ?x1618) (g_tt_l2_mem1_0 ?x1618) (g_tt_l2_mem1_1 ?x1618) (g_tt_l2_mem1_2 ?x1618) (g_tt_l2_mem1_3 ?x1618) (g_tt_l1_upper ?x1618) (g_mbedtls_mem_buf ?x1618) ?x1677 (g_rmm_attest_signing_key ?x1618) (g_rmm_attest_public_key ?x1618) (g_rmm_attest_public_key_len ?x1618) (g_rmm_attest_public_key_hash ?x1618) (g_rmm_attest_public_key_hash_len ?x1618) (g_platform_token_buf ?x1618) (g_rmm_platform_token ?x1618) (g_get_realm_identity_identity ?x1618) (g_realm_attest_private_key ?x1618))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x1746 (mod ?x1318 4096)))
 (let ((?x1341 (div ?x1318 4096)))
 (let ((?x28038 (granule_data ?x47450)))
 (let ((?x1728 (select ?x28038 ?x1341)))
 (let ((?x1723 (g_norm ?x1728)))
 (let ((?x1264 (store ?x1723 ?x1746 ?x35861)))
 (let ((?x1520 (mkr_granule_data (gd_g_idx ?x1728) (g_granule_state ?x1728) ?x1264 (g_rd ?x1728) (g_rec ?x1728))))
 (let ((?x1604 (store ?x28038 ?x1341 ?x1520)))
 (let ((?x1391 (gpt ?x47450)))
 (let ((?x28092 (priv ?x1539)))
 (let ((?x1590 (repl ?x1539)))
 (let ((?x1658 (oracle ?x1539)))
 (let ((?x28036 (log ?x1539)))
 (let ((?x35868 (granule_unlock_spec.0_call ?x1204 (mkRData ?x28036 ?x1658 ?x1590 ?x28092 (mkShared ?x1391 ?x1604 ?x35865) ?x28093 $x28082))))
 (let ((?x4537 (value_RData ?x35868)))
 (let ((?x57518 (share ?x4537)))
 (let ((?x1841 (granule_data ?x57518)))
 (let (($x1795 (= (g_norm (select ?x1841 gidx.366896)) zero_granule_data)))
 (let (($x1831 (= (e_state_s_granule (select (g_granules (globals ?x57518)) gidx.366896)) 1)))
 (or (not $x1831) $x1795)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (or (not $x27436) $x28243))))
(assert
 (let (($x1439 (forall ((gidx.366947 Int) )(let ((?x1597 (test_PA.0_call v_1_Zptr.0)))
 (let ((?x1577 (meta_granule_offset ?x1597)))
 (let ((?x1576 (mkPtr "granules" ?x1577)))
 (let ((?x1594 (spinlock_acquire_spec.0_call ?x1576 st.0)))
 (let ((?x1634 (value_RData ?x1594)))
 (let ((?x1062 (test_PA.0_call v_0_Zptr.0)))
 (let ((?x991 (meta_granule_offset ?x1062)))
 (let ((?x992 (mkPtr "granules" ?x991)))
 (let ((?x1048 (spinlock_acquire_spec.0_call ?x992 ?x1634)))
 (let ((?x1050 (value_RData ?x1048)))
 (let ((?x1124 (mkPtr "stack_s_rtt_walk" 0)))
 (let ((?x1184 (rtt_walk_lock_unlock_spec_abs.0_call ?x1124 ?x1576 0 64 v_2.0 v_3.0 ?x1050)))
 (let ((?x1188 (value_Tuple_abs_ret_rtt_RData ?x1184)))
 (let ((?x1186 (elem_1 ?x1188)))
 (let ((?x1189 (elem_0 ?x1188)))
 (let ((?x1209 (e_3 ?x1189)))
 (let ((?x1242 (* 8 ?x1209)))
 (let ((?x1204 (e_2 ?x1189)))
 (let ((?x1206 (poffset ?x1204)))
 (let ((?x1318 (+ ?x1206 ?x1242)))
 (let ((?x1378 (mkPtr "granule_data" ?x1318)))
 (let ((?x1363 (abs_tte_read.0_call ?x1378 ?x1186)))
 (let ((?x1348 (meta_ripas ?x1363)))
 (let ((?x1388 (mkPtr "granule_data" ?x991)))
 (let ((?x1525 (s2tt_init_unassigned_spec.0_call ?x1388 ?x1348 ?x1186)))
 (let ((?x1539 (value_RData ?x1525)))
 (let (($x28082 (halt ?x1539)))
 (let ((?x28093 (stack ?x1539)))
 (let ((?x28219 (+ 4 ?x991)))
 (let ((?x28222 (div ?x28219 4096)))
 (let ((?x1695 (+ 8 ?x1206)))
 (let ((?x28224 (div ?x1695 4096)))
 (let ((?x47450 (share ?x1539)))
 (let ((?x1618 (globals ?x47450)))
 (let ((?x28034 (g_granules ?x1618)))
 (let ((?x28225 (select ?x28034 ?x28224)))
 (let ((?x35765 (e_ref ?x28225)))
 (let ((?x36032 (e_u_anon_3_0 ?x35765)))
 (let ((?x36021 (+ 1 ?x36032)))
 (let ((?x36020 (mku_anon_3 ?x36021)))
 (let ((?x28231 (mks_granule (e_lock ?x28225) (e_state_s_granule ?x28225) ?x36020)))
 (let ((?x28226 (store ?x28034 ?x28224 ?x28231)))
 (let ((?x28192 (select ?x28226 ?x28222)))
 (let ((?x4534 (mks_granule (e_lock ?x28192) 5 (e_ref ?x28192))))
 (let ((?x1677 (store ?x28226 ?x28222 ?x4534)))
 (let ((?x35865 (mkGLOBALS (g_heap ?x1618) (g_debug_exits ?x1618) (g_vmid_count ?x1618) (g_vmid_lock ?x1618) (g_vmids ?x1618) (g_nr_lrs ?x1618) (g_nr_aprs ?x1618) (g_max_vintid ?x1618) (g_pri_res0_mask ?x1618) (g_default_gicstate ?x1618) (g_status_handler ?x1618) (g_rmm_trap_list ?x1618) (g_tt_l3_buffer ?x1618) (g_tt_l2_mem0_0 ?x1618) (g_tt_l2_mem0_1 ?x1618) (g_tt_l2_mem1_0 ?x1618) (g_tt_l2_mem1_1 ?x1618) (g_tt_l2_mem1_2 ?x1618) (g_tt_l2_mem1_3 ?x1618) (g_tt_l1_upper ?x1618) (g_mbedtls_mem_buf ?x1618) ?x1677 (g_rmm_attest_signing_key ?x1618) (g_rmm_attest_public_key ?x1618) (g_rmm_attest_public_key_len ?x1618) (g_rmm_attest_public_key_hash ?x1618) (g_rmm_attest_public_key_hash_len ?x1618) (g_platform_token_buf ?x1618) (g_rmm_platform_token ?x1618) (g_get_realm_identity_identity ?x1618) (g_realm_attest_private_key ?x1618))))
 (let ((?x1747 (mkabs_PTE_t ?x1062 3 0 0)))
 (let ((?x35861 (test_PTE_Z.0_call ?x1747)))
 (let ((?x1746 (mod ?x1318 4096)))
 (let ((?x1341 (div ?x1318 4096)))
 (let ((?x28038 (granule_data ?x47450)))
 (let ((?x1728 (select ?x28038 ?x1341)))
 (let ((?x1723 (g_norm ?x1728)))
 (let ((?x1264 (store ?x1723 ?x1746 ?x35861)))
 (let ((?x1520 (mkr_granule_data (gd_g_idx ?x1728) (g_granule_state ?x1728) ?x1264 (g_rd ?x1728) (g_rec ?x1728))))
 (let ((?x1604 (store ?x28038 ?x1341 ?x1520)))
 (let ((?x1391 (gpt ?x47450)))
 (let ((?x28092 (priv ?x1539)))
 (let ((?x1590 (repl ?x1539)))
 (let ((?x1658 (oracle ?x1539)))
 (let ((?x28036 (log ?x1539)))
 (let ((?x35868 (granule_unlock_spec.0_call ?x1204 (mkRData ?x28036 ?x1658 ?x1590 ?x28092 (mkShared ?x1391 ?x1604 ?x35865) ?x28093 $x28082))))
 (let ((?x4537 (value_RData ?x35868)))
 (let ((?x57518 (share ?x4537)))
 (let ((?x1841 (granule_data ?x57518)))
 (let (($x1795 (= (g_norm (select ?x1841 gidx.366947)) zero_granule_data)))
 (let (($x1831 (= (e_state_s_granule (select (g_granules (globals ?x57518)) gidx.366947)) 1)))
 (=> $x1831 $x1795)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
 ))
 (not $x1439)))
(check-sat)
