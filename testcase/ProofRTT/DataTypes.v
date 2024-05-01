Require Import CommonDeps.

Local Open Scope Z_scope.

Record s_gic_cpu_state :=
  mks_gic_cpu_state {
    e_ich_ap0r_el2: (ZMap.t Z);
    e_ich_ap1r_el2: (ZMap.t Z);
    e_ich_vmcr_el2: Z;
    e_ich_hcr_el2: Z;
    e_ich_lr_el2: (ZMap.t Z);
    e_ich_misr_el2: Z;
}.


Record s_sysreg_state :=
  mks_sysreg_state {
    e_sysreg_sp_el0: Z;
    e_sysreg_sp_el1: Z;
    e_sysreg_elr_el1: Z;
    e_sysreg_spsr_el1: Z;
    e_sysreg_pmcr_el0: Z;
    e_sysreg_tpidrro_el0: Z;
    e_sysreg_tpidr_el0: Z;
    e_sysreg_csselr_el1: Z;
    e_sysreg_sctlr_el1: Z;
    e_sysreg_actlr_el1: Z;
    e_sysreg_cpacr_el1: Z;
    e_sysreg_zcr_el1: Z;
    e_sysreg_ttbr0_el1: Z;
    e_sysreg_ttbr1_el1: Z;
    e_sysreg_tcr_el1: Z;
    e_sysreg_esr_el1: Z;
    e_sysreg_afsr0_el1: Z;
    e_sysreg_afsr1_el1: Z;
    e_sysreg_far_el1: Z;
    e_sysreg_mair_el1: Z;
    e_sysreg_vbar_el1: Z;
    e_sysreg_contextidr_el1: Z;
    e_sysreg_tpidr_el1: Z;
    e_sysreg_amair_el1: Z;
    e_sysreg_cntkctl_el1: Z;
    e_sysreg_par_el1: Z;
    e_sysreg_mdscr_el1: Z;
    e_sysreg_mdccint_el1: Z;
    e_sysreg_disr_el1: Z;
    e_sysreg_mpam0_el1: Z;
    e_sysreg_cnthctl_el2: Z;
    e_sysreg_cntvoff_el2: Z;
    e_sysreg_cntpoff_el2: Z;
    e_sysreg_cntp_ctl_el0: Z;
    e_sysreg_cntp_cval_el0: Z;
    e_sysreg_cntv_ctl_el0: Z;
    e_sysreg_cntv_cval_el0: Z;
    e_sysreg_gicstate: s_gic_cpu_state;
    e_sysreg_vmpidr_el2: Z;
    e_sysreg_hcr_el2: Z;
}.


Record s_common_sysreg_state :=
  mks_common_sysreg_state {
    e_common_vttbr_el2: Z;
    e_common_vtcr_el2: Z;
    e_common_hcr_el2: Z;
    e_common_mdcr_el2: Z;
}.


Record s_set_ripas :=
  mks_set_ripas {
    e_start: Z;
    e_end: Z;
    e_addr: Z;
    e_ripas: Z;
}.


Record s_realm_info :=
  mks_realm_info {
    e_ipa_bits: Z;
    e_s2_starting_level: Z;
    e_g_rtt: Z;
    e_g_rd: Z;
    e_pmu_enabled: Z;
    e_pmu_num_cnts: Z;
    e_sve_enabled: Z;
    e_sve_vq: Z;
}.


Record s_last_run_info :=
  mks_last_run_info {
    e_esr: Z;
    e_hpfar: Z;
    e_far: Z;
}.


Record s_psci_info :=
  mks_psci_info {
    e_pending: Z;
}.


Record s_rec_simd_state :=
  mks_rec_simd_state {
    e_simd: Z;
    e_simd_allowed: Z;
    e_init_done: Z;
}.


Record s_rec_aux_data :=
  mks_rec_aux_data {
    e_attest_heap_buf: Z;
    e_pmu: Z;
    e_rec_simd: s_rec_simd_state;
}.


Record s_buffer_alloc_ctx :=
  mks_buffer_alloc_ctx {
    e_buf: Z;
    e__len: Z;
    e_first: Z;
    e_first_free: Z;
    e_verify: Z;
}.


Record s_alloc_info :=
  mks_alloc_info {
    e__ctx: s_buffer_alloc_ctx;
    e_ctx_initialised: Z;
}.


Record s_serror_info :=
  mks_serror_info {
    e_vsesr_el2: Z;
    e_inject: Z;
}.


Record s_rec :=
  mks_rec {
    e_g_rec: Z;
    e_rec_idx: Z;
    e_runnable: Z;
    e_regs: (ZMap.t Z);
    e_pc: Z;
    e_pstate: Z;
    e_sysregs: s_sysreg_state;
    e_common_sysregs: s_common_sysreg_state;
    e_set_ripas: s_set_ripas;
    e_realm_info: s_realm_info;
    e_last_run_info: s_last_run_info;
    e_ns: Z;
    e_psci_info: s_psci_info;
    e_num_rec_aux: Z;
    e_g_aux: (ZMap.t Z);
    e_aux_data: s_rec_aux_data;
    e_alloc_info: s_alloc_info;
    e_serror_info: s_serror_info;
    e_host_call: Z;
}.


Record s_pmev_regs :=
  mks_pmev_regs {
    e_pmevcntr_el0: Z;
    e_pmevtyper_el0: Z;
}.


Record s_pmu_state :=
  mks_pmu_state {
    e_pmccfiltr_el0: Z;
    e_pmccntr_el0: Z;
    e_pmcntenset_el0: Z;
    e_pmcntenclr_el0: Z;
    e_pmintenset_el1: Z;
    e_pmintenclr_el1: Z;
    e_pmovsset_el0: Z;
    e_pmovsclr_el0: Z;
    e_pmselr_el0: Z;
    e_pmuserenr_el0: Z;
    e_pmxevcntr_el0: Z;
    e_pmxevtyper_el0: Z;
    e_pmev_regs: (ZMap.t s_pmev_regs);
}.


Record s_fpu_state :=
  mks_fpu_state {
    e_q: (ZMap.t Z);
    e_fpsr: Z;
    e_fpcr: Z;
}.


Record u_anon_6 :=
  mku_anon_6 {
    e_fpu: s_fpu_state;
    e_padding0: (ZMap.t Z);
}.


Record s_simd_state :=
  mks_simd_state {
    e_t: u_anon_6;
    e_simd_type: Z;
}.


Record s_ns_simd_state :=
  mks_ns_simd_state {
    e_ns_simd: s_simd_state;
    e_ns_zcr_el2: Z;
    e_ns_saved: Z;
}.


Record u_anon_7 :=
  mku_anon_7 {
    e_features_0: Z;
    e_rec_params_padding0: (ZMap.t Z);
}.


Record u_anon_10 :=
  mku_anon_10 {
    e_gprs: (ZMap.t Z);
    e__rec_params_padding0: (ZMap.t Z);
}.


Record s_anon_14 :=
  mks_anon_14 {
    e_num_aux: Z;
    e_aux: (ZMap.t Z);
}.


Record u_anon_11_154 :=
  mku_anon_11_154 {
    e__0: s_anon_14;
    e___rec_params_padding0: (ZMap.t Z);
}.


Record s_rmi_rec_params :=
  mks_rmi_rec_params {
    e_rmi_rec_params_0: u_anon_7;
    e_rmi_rec_params_1: u_anon_7;
    e_rmi_rec_params_2: u_anon_7;
    e_rmi_rec_params_3: u_anon_10;
    e_rmi_rec_params_4: u_anon_11_154;
}.


Record s_granule :=
  mks_granule {
    e_lock: (option Z);
    e_state: Z;
    e_refcount: Z;
}.


Record s_realm_s2_context :=
  mks_realm_s2_context {
    e_rls2ctx_ipa_bits: Z;
    e_rls2ctx_s2_starting_level: Z;
    e_rls2ctx_num_root_rtts: Z;
    e_rls2ctx_g_rtt: Z;
    e_rls2ctx_vmid: Z;
}.


Record s_rd :=
  mks_rd {
    e_rd_rd_state: Z;
    e_rd_rec_count: Z;
    e_rd_s2_ctx: s_realm_s2_context;
    e_rd_num_rec_aux: Z;
    e_rd_algorithm: Z;
    e_rd_pmu_enabled: Z;
    e_rd_pmu_num_cnts: Z;
    e_rd_sve_enabled: Z;
    e_rd_sve_vq: Z;
    e_rd_measurement: Z;
    e_rd_rpv: (ZMap.t Z);
}.


Record GranuleDataNormal :=
  mkGranuleDataNormal {
    gd_g_idx: Z;
    g_rd: s_rd;
    g_rec: s_rec;
    g_aux_pmu_state: s_pmu_state;
    g_aux_simd_state: s_simd_state;
    rec_gidx: Z;
    g_norm: (ZMap.t Z);
}.


Record s_s2_walk_result :=
  mks_s2_walk_result {
    e_walk_pa: Z;
    e_walk_rtt_level: Z;
    e_walk_ripas: Z;
    e_walk_destroyed: Z;
    e_walk_llt: Z;
}.


Record s_granule_set :=
  mks_granule_set {
    e_gset_idx: Z;
    e_gset_addr: Z;
    e_gset_state: Z;
    e_gset_g: Z;
    e_gset_g_ret: Z;
}.


Record s_xlat_llt_info :=
  mks_xlat_llt_info {
    llt_info_table: Z;
    llt_info_llt_base_va: Z;
    llt_info_level: Z;
}.


Record StackData :=
  mkStackData {
    sd_data: Z;
    sd_size: Z;
}.


Record StackFrame :=
  mkStackFrame {
    sf_data: (ZMap.t StackData);
    sf_sp: Z;
}.


Record PerCPURegs :=
  mkPerCPURegs {
    pcpu_vttbr_el2: Z;
    pcpu_zcr_el2: Z;
    pcpu_cnthctl_el2: Z;
    pcpu_elr_el2: Z;
    pcpu_cptr_el2: Z;
    pcpu_mdcr_el2: Z;
    pcpu_vpidr_el2: Z;
    pcpu_sctlr_el2: Z;
    pcpu_esr_el2: Z;
    pcpu_spsr_el2: Z;
    pcpu_hpfar_el2: Z;
    pcpu_far_el2: Z;
    pcpu_vsesr_el2: Z;
    pcpu_hcr_el2: Z;
    pcpu_cntvoff_el2: Z;
    pcpu_vmpidr_el2: Z;
    pcpu_vtcr_el2: Z;
    pcpu_ich_hcr_el2: Z;
    pcpu_ich_lr15_el2: Z;
    pcpu_ich_misr_el2: Z;
    pcpu_ich_vmcr_el2: Z;
    pcpu_icc_sre_el2: Z;
    pcpu_esr_el12: Z;
    pcpu_spsr_el12: Z;
    pcpu_elr_el12: Z;
    pcpu_vbar_el12: Z;
    pcpu_far_el12: Z;
    pcpu_amair_el12: Z;
    pcpu_cntkctl_el12: Z;
    pcpu_cntp_ctl_el02: Z;
    pcpu_cntp_cval_el02: Z;
    pcpu_cntpoff_el2: Z;
    pcpu_cntv_ctl_el02: Z;
    pcpu_cntv_cval_el02: Z;
    pcpu_contextidr_el12: Z;
    pcpu_mair_el12: Z;
    pcpu_afsr1_el12: Z;
    pcpu_afsr0_el12: Z;
    pcpu_tcr_el12: Z;
    pcpu_ttbr1_el12: Z;
    pcpu_ttbr0_el12: Z;
    pcpu_cpacr_el12: Z;
    pcpu_sctlr_el12: Z;
    pcpu_midr_el1: Z;
    pcpu_isr_el1: Z;
    pcpu_id_aa64mmfr0_el1: Z;
    pcpu_id_aa64mmfr1_el1: Z;
    pcpu_id_aa64dfr0_el1: Z;
    pcpu_id_aa64dfr1_el1: Z;
    pcpu_id_aa64pfr0_el1: Z;
    pcpu_id_aa64pfr1_el1: Z;
    pcpu_disr_el1: Z;
    pcpu_mdccint_el1: Z;
    pcpu_mdscr_el1: Z;
    pcpu_par_el1: Z;
    pcpu_tpidr_el1: Z;
    pcpu_actlr_el1: Z;
    pcpu_csselr_el1: Z;
    pcpu_sp_el1: Z;
    pcpu_pmintenset_el1: Z;
    pcpu_pmintenclr_el1: Z;
    pcpu_icc_hppir1_el1: Z;
    pcpu_pmcr_el0: Z;
    pcpu_pmevtyper0_el0: Z;
    pcpu_pmevtyper1_el0: Z;
    pcpu_pmevtyper2_el0: Z;
    pcpu_pmevtyper3_el0: Z;
    pcpu_pmevtyper4_el0: Z;
    pcpu_pmevtyper5_el0: Z;
    pcpu_pmevtyper6_el0: Z;
    pcpu_pmevtyper7_el0: Z;
    pcpu_pmevtyper8_el0: Z;
    pcpu_pmevtyper9_el0: Z;
    pcpu_pmevtyper10_el0: Z;
    pcpu_pmevtyper11_el0: Z;
    pcpu_pmevtyper12_el0: Z;
    pcpu_pmevtyper13_el0: Z;
    pcpu_pmevtyper14_el0: Z;
    pcpu_pmevtyper15_el0: Z;
    pcpu_pmevtyper16_el0: Z;
    pcpu_pmevtyper17_el0: Z;
    pcpu_pmevtyper18_el0: Z;
    pcpu_pmevtyper19_el0: Z;
    pcpu_pmevtyper20_el0: Z;
    pcpu_pmevtyper21_el0: Z;
    pcpu_pmevtyper22_el0: Z;
    pcpu_pmevtyper23_el0: Z;
    pcpu_pmevtyper24_el0: Z;
    pcpu_pmevtyper25_el0: Z;
    pcpu_pmevtyper26_el0: Z;
    pcpu_pmevtyper27_el0: Z;
    pcpu_pmevtyper28_el0: Z;
    pcpu_pmevtyper29_el0: Z;
    pcpu_pmevtyper30_el0: Z;
    pcpu_pmevcntr0_el0: Z;
    pcpu_pmevcntr1_el0: Z;
    pcpu_pmevcntr2_el0: Z;
    pcpu_pmevcntr3_el0: Z;
    pcpu_pmevcntr4_el0: Z;
    pcpu_pmevcntr5_el0: Z;
    pcpu_pmevcntr6_el0: Z;
    pcpu_pmevcntr7_el0: Z;
    pcpu_pmevcntr8_el0: Z;
    pcpu_pmevcntr9_el0: Z;
    pcpu_pmevcntr10_el0: Z;
    pcpu_pmevcntr11_el0: Z;
    pcpu_pmevcntr12_el0: Z;
    pcpu_pmevcntr13_el0: Z;
    pcpu_pmevcntr14_el0: Z;
    pcpu_pmevcntr15_el0: Z;
    pcpu_pmevcntr16_el0: Z;
    pcpu_pmevcntr17_el0: Z;
    pcpu_pmevcntr18_el0: Z;
    pcpu_pmevcntr19_el0: Z;
    pcpu_pmevcntr20_el0: Z;
    pcpu_pmevcntr21_el0: Z;
    pcpu_pmevcntr22_el0: Z;
    pcpu_pmevcntr23_el0: Z;
    pcpu_pmevcntr24_el0: Z;
    pcpu_pmevcntr25_el0: Z;
    pcpu_pmevcntr26_el0: Z;
    pcpu_pmevcntr27_el0: Z;
    pcpu_pmevcntr28_el0: Z;
    pcpu_pmevcntr29_el0: Z;
    pcpu_pmevcntr30_el0: Z;
    pcpu_pmccfiltr_el0: Z;
    pcpu_pmccntr_el0: Z;
    pcpu_pmcntenset_el0: Z;
    pcpu_pmcntenclr_el0: Z;
    pcpu_pmovsclr_el0: Z;
    pcpu_pmovsset_el0: Z;
    pcpu_pmselr_el0: Z;
    pcpu_pmuserenr_el0: Z;
    pcpu_pmxevcntr_el0: Z;
    pcpu_pmxevtyper_el0: Z;
    pcpu_tpidr_el0: Z;
    pcpu_tpidrro_el0: Z;
    pcpu_sp_el0: Z;
    pcpu_dummy_regs: Z;
}.


Record PerCPU :=
  mkPerCPU {
    pcpu_stack: (ZMap.t StackFrame);
    pcpu_sc: Z;
    pcpu_regs: PerCPURegs;
    pcpu_llt_info_cache: (ZMap.t s_xlat_llt_info);
}.


Record Shared :=
  mkShared {
    glk: (ZMap.t (option Z));
    gpt: (ZMap.t bool);
    slots: (ZMap.t Z);
    granules: (ZMap.t s_granule);
    granule_data: (ZMap.t GranuleDataNormal);
    gv_g_sve_max_vq: Z;
    gv_g_ns_simd: (ZMap.t Z);
    gv_g_cpu_simd_type: Z;
    gv_vmids: (ZMap.t Z);
}.


Inductive ns_copy_type: Type :=
 | READ_REALM_PARAMS 
 | READ_REC_PARAMS 
 | READ_REC_RUN 
 | WRITE_REC_RUN (run: (ZMap.t Z))
 | READ_DATA (gidx: Z).


Inductive update_rec_list_type: Type :=
 | GET_RECL 
 | SET_RECL (gidx: Z)
 | UNSET_RECL .


Inductive realm_trap_type: Type :=
 | WFX 
 | HVC 
 | SMC 
 | IDREG 
 | TIMER 
 | ICC 
 | DATA_ABORT 
 | INSTR_ABORT 
 | IRQ 
 | FIQ .


Inductive AtomicEvent: Type :=
 | ACQ (gidx: Z)
 | REL (gidx1: Z) (g': s_granule)
 | REC_REF (ref_gidx: Z) (ref_cnt: Z)
 | GET_GCNT (gidx3: Z)
 | INC_GCNT (gidx4: Z)
 | DEC_RD_GCNT (gidx5: Z)
 | DEC_REC_GCNT (gidx6: Z) (g'1: s_granule)
 | RECL (gidx7: Z) (idx8: Z) (t: update_rec_list_type)
 | ACQ_GPT (gidx9: Z)
 | REL_GPT (gidx10: Z) (secure: bool)
 | RTT_WALK (root_gidx: Z) (map_addr: Z) (level: Z)
 | RTT_CREATE (root_gidx1: Z) (map_addr1: Z) (level1: Z) (rtt_addr: Z)
 | RTT_DESTROY (root_gidx2: Z) (map_addr2: Z) (level2: Z)
 | COPY_NS (gidx11: Z) (t1: ns_copy_type)
 | NS_ACCESS_MEM (addr: Z) (val: Z)
 | REALM_ACCESS_MEM (rd: Z) (rec: Z) (addr1: Z) (val1: Z)
 | REALM_ACCESS_REG (rd1: Z) (rec1: Z) (reg: Z) (val2: Z)
 | REALM_ACTIVATE (rd_gidx: Z)
 | REALM_TRAP (rd2: Z) (rec2: Z) (trap_type: realm_trap_type).


Inductive Event: Type :=
 | EVT (cpuid: Z) (e: AtomicEvent).


Definition Log: Type :=list Event.

Definition Oracle: Type :=list Event -> list Event.

Definition Replay: Type :=list Event -> (Shared -> (option Shared)).

Record STACK :=
  mkSTACK {
    attest_setup_platform_token_stack: (ZMap.t Z);
    smc_psci_complete_stack: (ZMap.t Z);
    find_lock_two_granules_stack: (ZMap.t Z);
    attest_token_continue_write_state_stack: (ZMap.t Z);
    rmm_log_stack: (ZMap.t Z);
    attest_realm_token_create_stack: (ZMap.t Z);
    smc_rec_enter_stack: (ZMap.t Z);
    do_host_call_stack: (ZMap.t Z);
    attest_rnd_prng_init_stack: (ZMap.t Z);
    plat_setup_stack: (ZMap.t Z);
    attest_token_encode_start_stack: (ZMap.t Z);
    smc_data_destroy_stack: (ZMap.t Z);
    xlat_get_llt_from_va_stack: (ZMap.t Z);
    smc_rec_create_stack: (ZMap.t Z);
    measurement_extend_sha512_stack: (ZMap.t Z);
    data_granule_measure_stack: (ZMap.t Z);
    sort_granules_stack: (ZMap.t Z);
    measurement_extend_sha256_stack: (ZMap.t Z);
    realm_ipa_to_pa_stack: (ZMap.t Z);
    attest_realm_token_sign_stack: (ZMap.t Z);
    rmm_el3_ifc_get_platform_token_stack: (ZMap.t Z);
    attest_init_realm_attestation_key_stack: (ZMap.t Z);
    plat_cmn_setup_stack: (ZMap.t Z);
    complete_rsi_host_call_stack: (ZMap.t Z);
    handle_realm_rsi_stack: (ZMap.t Z);
    smc_rtt_set_ripas_stack: (ZMap.t Z);
    rtt_walk_lock_unlock_stack: (ZMap.t Z);
    smc_rtt_destroy_stack: (ZMap.t Z);
    map_unmap_ns_stack: (ZMap.t Z);
    handle_rsi_attest_token_init_stack: (ZMap.t Z);
    realm_params_measure_stack: (ZMap.t Z);
    handle_rsi_ipa_state_get_stack: (ZMap.t Z);
    realm_ipa_get_ripas_stack: (ZMap.t Z);
    smc_rtt_fold_stack: (ZMap.t Z);
    smc_rtt_create_stack: (ZMap.t Z);
    rsi_log_on_exit_stack: (ZMap.t Z);
    attest_cca_token_create_stack: (ZMap.t Z);
    rec_params_measure_stack: (ZMap.t Z);
    handle_ns_smc_stack: (ZMap.t Z);
    rmm_el3_ifc_get_realm_attest_key_stack: (ZMap.t Z);
    handle_rsi_realm_config_stack: (ZMap.t Z);
    smc_rtt_init_ripas_stack: (ZMap.t Z);
    smc_rtt_read_entry_stack: (ZMap.t Z);
    handle_data_abort_stack: (ZMap.t Z);
    data_create_stack: (ZMap.t Z);
    smc_realm_create_stack: (ZMap.t Z);
    ripas_granule_measure_stack: (ZMap.t Z);
    ipa_is_empty_stack: (ZMap.t Z);
}.


Record stack_ptrs :=
  mkstack_ptrs {
    attest_setup_platform_token_sp: Z;
    smc_psci_complete_sp: Z;
    attest_token_continue_write_state_sp: Z;
    rmm_log_sp: Z;
    attest_rnd_prng_init_sp: Z;
    smc_data_destroy_sp: Z;
    xlat_get_llt_from_va_sp: Z;
    smc_rec_create_sp: Z;
    attest_init_realm_attestation_key_sp: Z;
    handle_realm_rsi_sp: Z;
    smc_rtt_set_ripas_sp: Z;
    smc_rtt_destroy_sp: Z;
    map_unmap_ns_sp: Z;
    handle_rsi_attest_token_init_sp: Z;
    handle_rsi_ipa_state_get_sp: Z;
    smc_rtt_fold_sp: Z;
    smc_rtt_create_sp: Z;
    attest_cca_token_create_sp: Z;
    data_create_sp: Z;
    smc_realm_create_sp: Z;
}.


Record RData :=
  mkRData {
    log: list Event;
    oracle: list Event -> list Event;
    repl: list Event -> (Shared -> (option Shared));
    share: Shared;
    priv: PerCPU;
    stack: STACK;
    func_sp: stack_ptrs;
}.


Definition update_s_gic_cpu_state_e_ich_ap0r_el2(_a: s_gic_cpu_state) _b :=
  mks_gic_cpu_state _b (_a.(e_ich_ap1r_el2)) (_a.(e_ich_vmcr_el2)) (_a.(e_ich_hcr_el2)) (_a.(e_ich_lr_el2)) (_a.(e_ich_misr_el2)).
Notation "_a '.[e_ich_ap0r_el2]' ':<' _b" := (update_s_gic_cpu_state_e_ich_ap0r_el2 _a _b) (at level 1).

Definition update_s_gic_cpu_state_e_ich_ap1r_el2(_a: s_gic_cpu_state) _b :=
  mks_gic_cpu_state (_a.(e_ich_ap0r_el2)) _b (_a.(e_ich_vmcr_el2)) (_a.(e_ich_hcr_el2)) (_a.(e_ich_lr_el2)) (_a.(e_ich_misr_el2)).
Notation "_a '.[e_ich_ap1r_el2]' ':<' _b" := (update_s_gic_cpu_state_e_ich_ap1r_el2 _a _b) (at level 1).

Definition update_s_gic_cpu_state_e_ich_vmcr_el2(_a: s_gic_cpu_state) _b :=
  mks_gic_cpu_state (_a.(e_ich_ap0r_el2)) (_a.(e_ich_ap1r_el2)) _b (_a.(e_ich_hcr_el2)) (_a.(e_ich_lr_el2)) (_a.(e_ich_misr_el2)).
Notation "_a '.[e_ich_vmcr_el2]' ':<' _b" := (update_s_gic_cpu_state_e_ich_vmcr_el2 _a _b) (at level 1).

Definition update_s_gic_cpu_state_e_ich_hcr_el2(_a: s_gic_cpu_state) _b :=
  mks_gic_cpu_state (_a.(e_ich_ap0r_el2)) (_a.(e_ich_ap1r_el2)) (_a.(e_ich_vmcr_el2)) _b (_a.(e_ich_lr_el2)) (_a.(e_ich_misr_el2)).
Notation "_a '.[e_ich_hcr_el2]' ':<' _b" := (update_s_gic_cpu_state_e_ich_hcr_el2 _a _b) (at level 1).

Definition update_s_gic_cpu_state_e_ich_lr_el2(_a: s_gic_cpu_state) _b :=
  mks_gic_cpu_state (_a.(e_ich_ap0r_el2)) (_a.(e_ich_ap1r_el2)) (_a.(e_ich_vmcr_el2)) (_a.(e_ich_hcr_el2)) _b (_a.(e_ich_misr_el2)).
Notation "_a '.[e_ich_lr_el2]' ':<' _b" := (update_s_gic_cpu_state_e_ich_lr_el2 _a _b) (at level 1).

Definition update_s_gic_cpu_state_e_ich_misr_el2(_a: s_gic_cpu_state) _b :=
  mks_gic_cpu_state (_a.(e_ich_ap0r_el2)) (_a.(e_ich_ap1r_el2)) (_a.(e_ich_vmcr_el2)) (_a.(e_ich_hcr_el2)) (_a.(e_ich_lr_el2)) _b.
Notation "_a '.[e_ich_misr_el2]' ':<' _b" := (update_s_gic_cpu_state_e_ich_misr_el2 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_sp_el0(_a: s_sysreg_state) _b :=
  mks_sysreg_state _b (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_sp_el0]' ':<' _b" := (update_s_sysreg_state_e_sysreg_sp_el0 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_sp_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) _b (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_sp_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_sp_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_elr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) _b (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_elr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_elr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_spsr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) _b (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_spsr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_spsr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_pmcr_el0(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) _b (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_pmcr_el0]' ':<' _b" := (update_s_sysreg_state_e_sysreg_pmcr_el0 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_tpidrro_el0(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) _b (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_tpidrro_el0]' ':<' _b" := (update_s_sysreg_state_e_sysreg_tpidrro_el0 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_tpidr_el0(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) _b (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_tpidr_el0]' ':<' _b" := (update_s_sysreg_state_e_sysreg_tpidr_el0 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_csselr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) _b
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_csselr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_csselr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_sctlr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 _b (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_sctlr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_sctlr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_actlr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) _b (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_actlr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_actlr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_cpacr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) _b (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_cpacr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_cpacr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_zcr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) _b (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_zcr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_zcr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_ttbr0_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) _b (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_ttbr0_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_ttbr0_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_ttbr1_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) _b (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_ttbr1_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_ttbr1_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_tcr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) _b (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_tcr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_tcr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_esr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) _b
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_esr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_esr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_afsr0_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 _b (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_afsr0_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_afsr0_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_afsr1_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) _b (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_afsr1_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_afsr1_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_far_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) _b (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_far_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_far_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_mair_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) _b (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_mair_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_mair_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_vbar_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) _b (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_vbar_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_vbar_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_contextidr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) _b (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_contextidr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_contextidr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_tpidr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) _b (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_tpidr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_tpidr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_amair_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) _b
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_amair_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_amair_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_cntkctl_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 _b (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_cntkctl_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_cntkctl_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_par_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) _b (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_par_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_par_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_mdscr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) _b (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_mdscr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_mdscr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_mdccint_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) _b (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_mdccint_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_mdccint_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_disr_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) _b (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_disr_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_disr_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_mpam0_el1(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) _b (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_mpam0_el1]' ':<' _b" := (update_s_sysreg_state_e_sysreg_mpam0_el1 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_cnthctl_el2(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) _b (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_cnthctl_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_cnthctl_el2 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_cntvoff_el2(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) _b
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_cntvoff_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_cntvoff_el2 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_cntpoff_el2(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 _b (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_cntpoff_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_cntpoff_el2 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_cntp_ctl_el0(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) _b (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_cntp_ctl_el0]' ':<' _b" := (update_s_sysreg_state_e_sysreg_cntp_ctl_el0 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_cntp_cval_el0(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) _b (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_cntp_cval_el0]' ':<' _b" := (update_s_sysreg_state_e_sysreg_cntp_cval_el0 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_cntv_ctl_el0(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) _b (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_cntv_ctl_el0]' ':<' _b" := (update_s_sysreg_state_e_sysreg_cntv_ctl_el0 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_cntv_cval_el0(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) _b (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_cntv_cval_el0]' ':<' _b" := (update_s_sysreg_state_e_sysreg_cntv_cval_el0 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_gicstate(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) _b (_a.(e_sysreg_vmpidr_el2)) (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_gicstate]' ':<' _b" := (update_s_sysreg_state_e_sysreg_gicstate _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_vmpidr_el2(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) _b (_a.(e_sysreg_hcr_el2)).
Notation "_a '.[e_sysreg_vmpidr_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_vmpidr_el2 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_hcr_el2(_a: s_sysreg_state) _b :=
  mks_sysreg_state (_a.(e_sysreg_sp_el0)) (_a.(e_sysreg_sp_el1)) (_a.(e_sysreg_elr_el1)) (_a.(e_sysreg_spsr_el1)) (_a.(e_sysreg_pmcr_el0)) (_a.(e_sysreg_tpidrro_el0)) (_a.(e_sysreg_tpidr_el0)) (_a.(e_sysreg_csselr_el1))
 (_a.(e_sysreg_sctlr_el1)) (_a.(e_sysreg_actlr_el1)) (_a.(e_sysreg_cpacr_el1)) (_a.(e_sysreg_zcr_el1)) (_a.(e_sysreg_ttbr0_el1)) (_a.(e_sysreg_ttbr1_el1)) (_a.(e_sysreg_tcr_el1)) (_a.(e_sysreg_esr_el1))
 (_a.(e_sysreg_afsr0_el1)) (_a.(e_sysreg_afsr1_el1)) (_a.(e_sysreg_far_el1)) (_a.(e_sysreg_mair_el1)) (_a.(e_sysreg_vbar_el1)) (_a.(e_sysreg_contextidr_el1)) (_a.(e_sysreg_tpidr_el1)) (_a.(e_sysreg_amair_el1))
 (_a.(e_sysreg_cntkctl_el1)) (_a.(e_sysreg_par_el1)) (_a.(e_sysreg_mdscr_el1)) (_a.(e_sysreg_mdccint_el1)) (_a.(e_sysreg_disr_el1)) (_a.(e_sysreg_mpam0_el1)) (_a.(e_sysreg_cnthctl_el2)) (_a.(e_sysreg_cntvoff_el2))
 (_a.(e_sysreg_cntpoff_el2)) (_a.(e_sysreg_cntp_ctl_el0)) (_a.(e_sysreg_cntp_cval_el0)) (_a.(e_sysreg_cntv_ctl_el0)) (_a.(e_sysreg_cntv_cval_el0)) (_a.(e_sysreg_gicstate)) (_a.(e_sysreg_vmpidr_el2)) _b.
Notation "_a '.[e_sysreg_hcr_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_hcr_el2 _a _b) (at level 1).

Definition update_s_common_sysreg_state_e_common_vttbr_el2(_a: s_common_sysreg_state) _b :=
  mks_common_sysreg_state _b (_a.(e_common_vtcr_el2)) (_a.(e_common_hcr_el2)) (_a.(e_common_mdcr_el2)).
Notation "_a '.[e_common_vttbr_el2]' ':<' _b" := (update_s_common_sysreg_state_e_common_vttbr_el2 _a _b) (at level 1).

Definition update_s_common_sysreg_state_e_common_vtcr_el2(_a: s_common_sysreg_state) _b :=
  mks_common_sysreg_state (_a.(e_common_vttbr_el2)) _b (_a.(e_common_hcr_el2)) (_a.(e_common_mdcr_el2)).
Notation "_a '.[e_common_vtcr_el2]' ':<' _b" := (update_s_common_sysreg_state_e_common_vtcr_el2 _a _b) (at level 1).

Definition update_s_common_sysreg_state_e_common_hcr_el2(_a: s_common_sysreg_state) _b :=
  mks_common_sysreg_state (_a.(e_common_vttbr_el2)) (_a.(e_common_vtcr_el2)) _b (_a.(e_common_mdcr_el2)).
Notation "_a '.[e_common_hcr_el2]' ':<' _b" := (update_s_common_sysreg_state_e_common_hcr_el2 _a _b) (at level 1).

Definition update_s_common_sysreg_state_e_common_mdcr_el2(_a: s_common_sysreg_state) _b :=
  mks_common_sysreg_state (_a.(e_common_vttbr_el2)) (_a.(e_common_vtcr_el2)) (_a.(e_common_hcr_el2)) _b.
Notation "_a '.[e_common_mdcr_el2]' ':<' _b" := (update_s_common_sysreg_state_e_common_mdcr_el2 _a _b) (at level 1).

Definition update_s_set_ripas_e_start(_a: s_set_ripas) _b :=
  mks_set_ripas _b (_a.(e_end)) (_a.(e_addr)) (_a.(e_ripas)).
Notation "_a '.[e_start]' ':<' _b" := (update_s_set_ripas_e_start _a _b) (at level 1).

Definition update_s_set_ripas_e_end(_a: s_set_ripas) _b :=
  mks_set_ripas (_a.(e_start)) _b (_a.(e_addr)) (_a.(e_ripas)).
Notation "_a '.[e_end]' ':<' _b" := (update_s_set_ripas_e_end _a _b) (at level 1).

Definition update_s_set_ripas_e_addr(_a: s_set_ripas) _b :=
  mks_set_ripas (_a.(e_start)) (_a.(e_end)) _b (_a.(e_ripas)).
Notation "_a '.[e_addr]' ':<' _b" := (update_s_set_ripas_e_addr _a _b) (at level 1).

Definition update_s_set_ripas_e_ripas(_a: s_set_ripas) _b :=
  mks_set_ripas (_a.(e_start)) (_a.(e_end)) (_a.(e_addr)) _b.
Notation "_a '.[e_ripas]' ':<' _b" := (update_s_set_ripas_e_ripas _a _b) (at level 1).

Definition update_s_realm_info_e_ipa_bits(_a: s_realm_info) _b :=
  mks_realm_info _b (_a.(e_s2_starting_level)) (_a.(e_g_rtt)) (_a.(e_g_rd)) (_a.(e_pmu_enabled)) (_a.(e_pmu_num_cnts)) (_a.(e_sve_enabled)) (_a.(e_sve_vq)).
Notation "_a '.[e_ipa_bits]' ':<' _b" := (update_s_realm_info_e_ipa_bits _a _b) (at level 1).

Definition update_s_realm_info_e_s2_starting_level(_a: s_realm_info) _b :=
  mks_realm_info (_a.(e_ipa_bits)) _b (_a.(e_g_rtt)) (_a.(e_g_rd)) (_a.(e_pmu_enabled)) (_a.(e_pmu_num_cnts)) (_a.(e_sve_enabled)) (_a.(e_sve_vq)).
Notation "_a '.[e_s2_starting_level]' ':<' _b" := (update_s_realm_info_e_s2_starting_level _a _b) (at level 1).

Definition update_s_realm_info_e_g_rtt(_a: s_realm_info) _b :=
  mks_realm_info (_a.(e_ipa_bits)) (_a.(e_s2_starting_level)) _b (_a.(e_g_rd)) (_a.(e_pmu_enabled)) (_a.(e_pmu_num_cnts)) (_a.(e_sve_enabled)) (_a.(e_sve_vq)).
Notation "_a '.[e_g_rtt]' ':<' _b" := (update_s_realm_info_e_g_rtt _a _b) (at level 1).

Definition update_s_realm_info_e_g_rd(_a: s_realm_info) _b :=
  mks_realm_info (_a.(e_ipa_bits)) (_a.(e_s2_starting_level)) (_a.(e_g_rtt)) _b (_a.(e_pmu_enabled)) (_a.(e_pmu_num_cnts)) (_a.(e_sve_enabled)) (_a.(e_sve_vq)).
Notation "_a '.[e_g_rd]' ':<' _b" := (update_s_realm_info_e_g_rd _a _b) (at level 1).

Definition update_s_realm_info_e_pmu_enabled(_a: s_realm_info) _b :=
  mks_realm_info (_a.(e_ipa_bits)) (_a.(e_s2_starting_level)) (_a.(e_g_rtt)) (_a.(e_g_rd)) _b (_a.(e_pmu_num_cnts)) (_a.(e_sve_enabled)) (_a.(e_sve_vq)).
Notation "_a '.[e_pmu_enabled]' ':<' _b" := (update_s_realm_info_e_pmu_enabled _a _b) (at level 1).

Definition update_s_realm_info_e_pmu_num_cnts(_a: s_realm_info) _b :=
  mks_realm_info (_a.(e_ipa_bits)) (_a.(e_s2_starting_level)) (_a.(e_g_rtt)) (_a.(e_g_rd)) (_a.(e_pmu_enabled)) _b (_a.(e_sve_enabled)) (_a.(e_sve_vq)).
Notation "_a '.[e_pmu_num_cnts]' ':<' _b" := (update_s_realm_info_e_pmu_num_cnts _a _b) (at level 1).

Definition update_s_realm_info_e_sve_enabled(_a: s_realm_info) _b :=
  mks_realm_info (_a.(e_ipa_bits)) (_a.(e_s2_starting_level)) (_a.(e_g_rtt)) (_a.(e_g_rd)) (_a.(e_pmu_enabled)) (_a.(e_pmu_num_cnts)) _b (_a.(e_sve_vq)).
Notation "_a '.[e_sve_enabled]' ':<' _b" := (update_s_realm_info_e_sve_enabled _a _b) (at level 1).

Definition update_s_realm_info_e_sve_vq(_a: s_realm_info) _b :=
  mks_realm_info (_a.(e_ipa_bits)) (_a.(e_s2_starting_level)) (_a.(e_g_rtt)) (_a.(e_g_rd)) (_a.(e_pmu_enabled)) (_a.(e_pmu_num_cnts)) (_a.(e_sve_enabled)) _b.
Notation "_a '.[e_sve_vq]' ':<' _b" := (update_s_realm_info_e_sve_vq _a _b) (at level 1).

Definition update_s_last_run_info_e_esr(_a: s_last_run_info) _b :=
  mks_last_run_info _b (_a.(e_hpfar)) (_a.(e_far)).
Notation "_a '.[e_esr]' ':<' _b" := (update_s_last_run_info_e_esr _a _b) (at level 1).

Definition update_s_last_run_info_e_hpfar(_a: s_last_run_info) _b :=
  mks_last_run_info (_a.(e_esr)) _b (_a.(e_far)).
Notation "_a '.[e_hpfar]' ':<' _b" := (update_s_last_run_info_e_hpfar _a _b) (at level 1).

Definition update_s_last_run_info_e_far(_a: s_last_run_info) _b :=
  mks_last_run_info (_a.(e_esr)) (_a.(e_hpfar)) _b.
Notation "_a '.[e_far]' ':<' _b" := (update_s_last_run_info_e_far _a _b) (at level 1).

Definition update_s_psci_info_e_pending(_a: s_psci_info) _b :=
  mks_psci_info _b.
Notation "_a '.[e_pending]' ':<' _b" := (update_s_psci_info_e_pending _a _b) (at level 1).

Definition update_s_rec_simd_state_e_simd(_a: s_rec_simd_state) _b :=
  mks_rec_simd_state _b (_a.(e_simd_allowed)) (_a.(e_init_done)).
Notation "_a '.[e_simd]' ':<' _b" := (update_s_rec_simd_state_e_simd _a _b) (at level 1).

Definition update_s_rec_simd_state_e_simd_allowed(_a: s_rec_simd_state) _b :=
  mks_rec_simd_state (_a.(e_simd)) _b (_a.(e_init_done)).
Notation "_a '.[e_simd_allowed]' ':<' _b" := (update_s_rec_simd_state_e_simd_allowed _a _b) (at level 1).

Definition update_s_rec_simd_state_e_init_done(_a: s_rec_simd_state) _b :=
  mks_rec_simd_state (_a.(e_simd)) (_a.(e_simd_allowed)) _b.
Notation "_a '.[e_init_done]' ':<' _b" := (update_s_rec_simd_state_e_init_done _a _b) (at level 1).

Definition update_s_rec_aux_data_e_attest_heap_buf(_a: s_rec_aux_data) _b :=
  mks_rec_aux_data _b (_a.(e_pmu)) (_a.(e_rec_simd)).
Notation "_a '.[e_attest_heap_buf]' ':<' _b" := (update_s_rec_aux_data_e_attest_heap_buf _a _b) (at level 1).

Definition update_s_rec_aux_data_e_pmu(_a: s_rec_aux_data) _b :=
  mks_rec_aux_data (_a.(e_attest_heap_buf)) _b (_a.(e_rec_simd)).
Notation "_a '.[e_pmu]' ':<' _b" := (update_s_rec_aux_data_e_pmu _a _b) (at level 1).

Definition update_s_rec_aux_data_e_rec_simd(_a: s_rec_aux_data) _b :=
  mks_rec_aux_data (_a.(e_attest_heap_buf)) (_a.(e_pmu)) _b.
Notation "_a '.[e_rec_simd]' ':<' _b" := (update_s_rec_aux_data_e_rec_simd _a _b) (at level 1).

Definition update_s_buffer_alloc_ctx_e_buf(_a: s_buffer_alloc_ctx) _b :=
  mks_buffer_alloc_ctx _b (_a.(e__len)) (_a.(e_first)) (_a.(e_first_free)) (_a.(e_verify)).
Notation "_a '.[e_buf]' ':<' _b" := (update_s_buffer_alloc_ctx_e_buf _a _b) (at level 1).

Definition update_s_buffer_alloc_ctx_e__len(_a: s_buffer_alloc_ctx) _b :=
  mks_buffer_alloc_ctx (_a.(e_buf)) _b (_a.(e_first)) (_a.(e_first_free)) (_a.(e_verify)).
Notation "_a '.[e__len]' ':<' _b" := (update_s_buffer_alloc_ctx_e__len _a _b) (at level 1).

Definition update_s_buffer_alloc_ctx_e_first(_a: s_buffer_alloc_ctx) _b :=
  mks_buffer_alloc_ctx (_a.(e_buf)) (_a.(e__len)) _b (_a.(e_first_free)) (_a.(e_verify)).
Notation "_a '.[e_first]' ':<' _b" := (update_s_buffer_alloc_ctx_e_first _a _b) (at level 1).

Definition update_s_buffer_alloc_ctx_e_first_free(_a: s_buffer_alloc_ctx) _b :=
  mks_buffer_alloc_ctx (_a.(e_buf)) (_a.(e__len)) (_a.(e_first)) _b (_a.(e_verify)).
Notation "_a '.[e_first_free]' ':<' _b" := (update_s_buffer_alloc_ctx_e_first_free _a _b) (at level 1).

Definition update_s_buffer_alloc_ctx_e_verify(_a: s_buffer_alloc_ctx) _b :=
  mks_buffer_alloc_ctx (_a.(e_buf)) (_a.(e__len)) (_a.(e_first)) (_a.(e_first_free)) _b.
Notation "_a '.[e_verify]' ':<' _b" := (update_s_buffer_alloc_ctx_e_verify _a _b) (at level 1).

Definition update_s_alloc_info_e__ctx(_a: s_alloc_info) _b :=
  mks_alloc_info _b (_a.(e_ctx_initialised)).
Notation "_a '.[e__ctx]' ':<' _b" := (update_s_alloc_info_e__ctx _a _b) (at level 1).

Definition update_s_alloc_info_e_ctx_initialised(_a: s_alloc_info) _b :=
  mks_alloc_info (_a.(e__ctx)) _b.
Notation "_a '.[e_ctx_initialised]' ':<' _b" := (update_s_alloc_info_e_ctx_initialised _a _b) (at level 1).

Definition update_s_serror_info_e_vsesr_el2(_a: s_serror_info) _b :=
  mks_serror_info _b (_a.(e_inject)).
Notation "_a '.[e_vsesr_el2]' ':<' _b" := (update_s_serror_info_e_vsesr_el2 _a _b) (at level 1).

Definition update_s_serror_info_e_inject(_a: s_serror_info) _b :=
  mks_serror_info (_a.(e_vsesr_el2)) _b.
Notation "_a '.[e_inject]' ':<' _b" := (update_s_serror_info_e_inject _a _b) (at level 1).

Definition update_s_rec_e_g_rec(_a: s_rec) _b :=
  mks_rec _b (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_g_rec]' ':<' _b" := (update_s_rec_e_g_rec _a _b) (at level 1).

Definition update_s_rec_e_rec_idx(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) _b (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_rec_idx]' ':<' _b" := (update_s_rec_e_rec_idx _a _b) (at level 1).

Definition update_s_rec_e_runnable(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) _b (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_runnable]' ':<' _b" := (update_s_rec_e_runnable _a _b) (at level 1).

Definition update_s_rec_e_regs(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) _b (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_regs]' ':<' _b" := (update_s_rec_e_regs _a _b) (at level 1).

Definition update_s_rec_e_pc(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) _b (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_pc]' ':<' _b" := (update_s_rec_e_pc _a _b) (at level 1).

Definition update_s_rec_e_pstate(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) _b (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_pstate]' ':<' _b" := (update_s_rec_e_pstate _a _b) (at level 1).

Definition update_s_rec_e_sysregs(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) _b (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_sysregs]' ':<' _b" := (update_s_rec_e_sysregs _a _b) (at level 1).

Definition update_s_rec_e_common_sysregs(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) _b
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_common_sysregs]' ':<' _b" := (update_s_rec_e_common_sysregs _a _b) (at level 1).

Definition update_s_rec_e_set_ripas(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 _b (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_set_ripas]' ':<' _b" := (update_s_rec_e_set_ripas _a _b) (at level 1).

Definition update_s_rec_e_realm_info(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) _b (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_realm_info]' ':<' _b" := (update_s_rec_e_realm_info _a _b) (at level 1).

Definition update_s_rec_e_last_run_info(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) _b (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_last_run_info]' ':<' _b" := (update_s_rec_e_last_run_info _a _b) (at level 1).

Definition update_s_rec_e_ns(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) _b (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_ns]' ':<' _b" := (update_s_rec_e_ns _a _b) (at level 1).

Definition update_s_rec_e_psci_info(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) _b (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_psci_info]' ':<' _b" := (update_s_rec_e_psci_info _a _b) (at level 1).

Definition update_s_rec_e_num_rec_aux(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) _b (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_num_rec_aux]' ':<' _b" := (update_s_rec_e_num_rec_aux _a _b) (at level 1).

Definition update_s_rec_e_g_aux(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) _b (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_g_aux]' ':<' _b" := (update_s_rec_e_g_aux _a _b) (at level 1).

Definition update_s_rec_e_aux_data(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) _b
 (_a.(e_alloc_info)) (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_aux_data]' ':<' _b" := (update_s_rec_e_aux_data _a _b) (at level 1).

Definition update_s_rec_e_alloc_info(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 _b (_a.(e_serror_info)) (_a.(e_host_call)).
Notation "_a '.[e_alloc_info]' ':<' _b" := (update_s_rec_e_alloc_info _a _b) (at level 1).

Definition update_s_rec_e_serror_info(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) _b (_a.(e_host_call)).
Notation "_a '.[e_serror_info]' ':<' _b" := (update_s_rec_e_serror_info _a _b) (at level 1).

Definition update_s_rec_e_host_call(_a: s_rec) _b :=
  mks_rec (_a.(e_g_rec)) (_a.(e_rec_idx)) (_a.(e_runnable)) (_a.(e_regs)) (_a.(e_pc)) (_a.(e_pstate)) (_a.(e_sysregs)) (_a.(e_common_sysregs))
 (_a.(e_set_ripas)) (_a.(e_realm_info)) (_a.(e_last_run_info)) (_a.(e_ns)) (_a.(e_psci_info)) (_a.(e_num_rec_aux)) (_a.(e_g_aux)) (_a.(e_aux_data))
 (_a.(e_alloc_info)) (_a.(e_serror_info)) _b.
Notation "_a '.[e_host_call]' ':<' _b" := (update_s_rec_e_host_call _a _b) (at level 1).

Definition update_s_pmev_regs_e_pmevcntr_el0(_a: s_pmev_regs) _b :=
  mks_pmev_regs _b (_a.(e_pmevtyper_el0)).
Notation "_a '.[e_pmevcntr_el0]' ':<' _b" := (update_s_pmev_regs_e_pmevcntr_el0 _a _b) (at level 1).

Definition update_s_pmev_regs_e_pmevtyper_el0(_a: s_pmev_regs) _b :=
  mks_pmev_regs (_a.(e_pmevcntr_el0)) _b.
Notation "_a '.[e_pmevtyper_el0]' ':<' _b" := (update_s_pmev_regs_e_pmevtyper_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmccfiltr_el0(_a: s_pmu_state) _b :=
  mks_pmu_state _b (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmccfiltr_el0]' ':<' _b" := (update_s_pmu_state_e_pmccfiltr_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmccntr_el0(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) _b (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmccntr_el0]' ':<' _b" := (update_s_pmu_state_e_pmccntr_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmcntenset_el0(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) _b (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmcntenset_el0]' ':<' _b" := (update_s_pmu_state_e_pmcntenset_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmcntenclr_el0(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) _b (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmcntenclr_el0]' ':<' _b" := (update_s_pmu_state_e_pmcntenclr_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmintenset_el1(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) _b (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmintenset_el1]' ':<' _b" := (update_s_pmu_state_e_pmintenset_el1 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmintenclr_el1(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) _b (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmintenclr_el1]' ':<' _b" := (update_s_pmu_state_e_pmintenclr_el1 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmovsset_el0(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) _b (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmovsset_el0]' ':<' _b" := (update_s_pmu_state_e_pmovsset_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmovsclr_el0(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) _b
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmovsclr_el0]' ':<' _b" := (update_s_pmu_state_e_pmovsclr_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmselr_el0(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 _b (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmselr_el0]' ':<' _b" := (update_s_pmu_state_e_pmselr_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmuserenr_el0(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) _b (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmuserenr_el0]' ':<' _b" := (update_s_pmu_state_e_pmuserenr_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmxevcntr_el0(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) _b (_a.(e_pmxevtyper_el0)) (_a.(e_pmev_regs)).
Notation "_a '.[e_pmxevcntr_el0]' ':<' _b" := (update_s_pmu_state_e_pmxevcntr_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmxevtyper_el0(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) _b (_a.(e_pmev_regs)).
Notation "_a '.[e_pmxevtyper_el0]' ':<' _b" := (update_s_pmu_state_e_pmxevtyper_el0 _a _b) (at level 1).

Definition update_s_pmu_state_e_pmev_regs(_a: s_pmu_state) _b :=
  mks_pmu_state (_a.(e_pmccfiltr_el0)) (_a.(e_pmccntr_el0)) (_a.(e_pmcntenset_el0)) (_a.(e_pmcntenclr_el0)) (_a.(e_pmintenset_el1)) (_a.(e_pmintenclr_el1)) (_a.(e_pmovsset_el0)) (_a.(e_pmovsclr_el0))
 (_a.(e_pmselr_el0)) (_a.(e_pmuserenr_el0)) (_a.(e_pmxevcntr_el0)) (_a.(e_pmxevtyper_el0)) _b.
Notation "_a '.[e_pmev_regs]' ':<' _b" := (update_s_pmu_state_e_pmev_regs _a _b) (at level 1).

Definition update_s_fpu_state_e_q(_a: s_fpu_state) _b :=
  mks_fpu_state _b (_a.(e_fpsr)) (_a.(e_fpcr)).
Notation "_a '.[e_q]' ':<' _b" := (update_s_fpu_state_e_q _a _b) (at level 1).

Definition update_s_fpu_state_e_fpsr(_a: s_fpu_state) _b :=
  mks_fpu_state (_a.(e_q)) _b (_a.(e_fpcr)).
Notation "_a '.[e_fpsr]' ':<' _b" := (update_s_fpu_state_e_fpsr _a _b) (at level 1).

Definition update_s_fpu_state_e_fpcr(_a: s_fpu_state) _b :=
  mks_fpu_state (_a.(e_q)) (_a.(e_fpsr)) _b.
Notation "_a '.[e_fpcr]' ':<' _b" := (update_s_fpu_state_e_fpcr _a _b) (at level 1).

Definition update_u_anon_6_e_fpu(_a: u_anon_6) _b :=
  mku_anon_6 _b (_a.(e_padding0)).
Notation "_a '.[e_fpu]' ':<' _b" := (update_u_anon_6_e_fpu _a _b) (at level 1).

Definition update_u_anon_6_e_padding0(_a: u_anon_6) _b :=
  mku_anon_6 (_a.(e_fpu)) _b.
Notation "_a '.[e_padding0]' ':<' _b" := (update_u_anon_6_e_padding0 _a _b) (at level 1).

Definition update_s_simd_state_e_t(_a: s_simd_state) _b :=
  mks_simd_state _b (_a.(e_simd_type)).
Notation "_a '.[e_t]' ':<' _b" := (update_s_simd_state_e_t _a _b) (at level 1).

Definition update_s_simd_state_e_simd_type(_a: s_simd_state) _b :=
  mks_simd_state (_a.(e_t)) _b.
Notation "_a '.[e_simd_type]' ':<' _b" := (update_s_simd_state_e_simd_type _a _b) (at level 1).

Definition update_s_ns_simd_state_e_ns_simd(_a: s_ns_simd_state) _b :=
  mks_ns_simd_state _b (_a.(e_ns_zcr_el2)) (_a.(e_ns_saved)).
Notation "_a '.[e_ns_simd]' ':<' _b" := (update_s_ns_simd_state_e_ns_simd _a _b) (at level 1).

Definition update_s_ns_simd_state_e_ns_zcr_el2(_a: s_ns_simd_state) _b :=
  mks_ns_simd_state (_a.(e_ns_simd)) _b (_a.(e_ns_saved)).
Notation "_a '.[e_ns_zcr_el2]' ':<' _b" := (update_s_ns_simd_state_e_ns_zcr_el2 _a _b) (at level 1).

Definition update_s_ns_simd_state_e_ns_saved(_a: s_ns_simd_state) _b :=
  mks_ns_simd_state (_a.(e_ns_simd)) (_a.(e_ns_zcr_el2)) _b.
Notation "_a '.[e_ns_saved]' ':<' _b" := (update_s_ns_simd_state_e_ns_saved _a _b) (at level 1).

Definition update_u_anon_7_e_features_0(_a: u_anon_7) _b :=
  mku_anon_7 _b (_a.(e_rec_params_padding0)).
Notation "_a '.[e_features_0]' ':<' _b" := (update_u_anon_7_e_features_0 _a _b) (at level 1).

Definition update_u_anon_7_e_rec_params_padding0(_a: u_anon_7) _b :=
  mku_anon_7 (_a.(e_features_0)) _b.
Notation "_a '.[e_rec_params_padding0]' ':<' _b" := (update_u_anon_7_e_rec_params_padding0 _a _b) (at level 1).

Definition update_u_anon_10_e_gprs(_a: u_anon_10) _b :=
  mku_anon_10 _b (_a.(e__rec_params_padding0)).
Notation "_a '.[e_gprs]' ':<' _b" := (update_u_anon_10_e_gprs _a _b) (at level 1).

Definition update_u_anon_10_e__rec_params_padding0(_a: u_anon_10) _b :=
  mku_anon_10 (_a.(e_gprs)) _b.
Notation "_a '.[e__rec_params_padding0]' ':<' _b" := (update_u_anon_10_e__rec_params_padding0 _a _b) (at level 1).

Definition update_s_anon_14_e_num_aux(_a: s_anon_14) _b :=
  mks_anon_14 _b (_a.(e_aux)).
Notation "_a '.[e_num_aux]' ':<' _b" := (update_s_anon_14_e_num_aux _a _b) (at level 1).

Definition update_s_anon_14_e_aux(_a: s_anon_14) _b :=
  mks_anon_14 (_a.(e_num_aux)) _b.
Notation "_a '.[e_aux]' ':<' _b" := (update_s_anon_14_e_aux _a _b) (at level 1).

Definition update_u_anon_11_154_e__0(_a: u_anon_11_154) _b :=
  mku_anon_11_154 _b (_a.(e___rec_params_padding0)).
Notation "_a '.[e__0]' ':<' _b" := (update_u_anon_11_154_e__0 _a _b) (at level 1).

Definition update_u_anon_11_154_e___rec_params_padding0(_a: u_anon_11_154) _b :=
  mku_anon_11_154 (_a.(e__0)) _b.
Notation "_a '.[e___rec_params_padding0]' ':<' _b" := (update_u_anon_11_154_e___rec_params_padding0 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_0(_a: s_rmi_rec_params) _b :=
  mks_rmi_rec_params _b (_a.(e_rmi_rec_params_1)) (_a.(e_rmi_rec_params_2)) (_a.(e_rmi_rec_params_3)) (_a.(e_rmi_rec_params_4)).
Notation "_a '.[e_rmi_rec_params_0]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_0 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_1(_a: s_rmi_rec_params) _b :=
  mks_rmi_rec_params (_a.(e_rmi_rec_params_0)) _b (_a.(e_rmi_rec_params_2)) (_a.(e_rmi_rec_params_3)) (_a.(e_rmi_rec_params_4)).
Notation "_a '.[e_rmi_rec_params_1]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_1 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_2(_a: s_rmi_rec_params) _b :=
  mks_rmi_rec_params (_a.(e_rmi_rec_params_0)) (_a.(e_rmi_rec_params_1)) _b (_a.(e_rmi_rec_params_3)) (_a.(e_rmi_rec_params_4)).
Notation "_a '.[e_rmi_rec_params_2]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_2 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_3(_a: s_rmi_rec_params) _b :=
  mks_rmi_rec_params (_a.(e_rmi_rec_params_0)) (_a.(e_rmi_rec_params_1)) (_a.(e_rmi_rec_params_2)) _b (_a.(e_rmi_rec_params_4)).
Notation "_a '.[e_rmi_rec_params_3]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_3 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_4(_a: s_rmi_rec_params) _b :=
  mks_rmi_rec_params (_a.(e_rmi_rec_params_0)) (_a.(e_rmi_rec_params_1)) (_a.(e_rmi_rec_params_2)) (_a.(e_rmi_rec_params_3)) _b.
Notation "_a '.[e_rmi_rec_params_4]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_4 _a _b) (at level 1).

Definition update_s_granule_e_lock(_a: s_granule) _b :=
  mks_granule _b (_a.(e_state)) (_a.(e_refcount)).
Notation "_a '.[e_lock]' ':<' _b" := (update_s_granule_e_lock _a _b) (at level 1).

Definition update_s_granule_e_state(_a: s_granule) _b :=
  mks_granule (_a.(e_lock)) _b (_a.(e_refcount)).
Notation "_a '.[e_state]' ':<' _b" := (update_s_granule_e_state _a _b) (at level 1).

Definition update_s_granule_e_refcount(_a: s_granule) _b :=
  mks_granule (_a.(e_lock)) (_a.(e_state)) _b.
Notation "_a '.[e_refcount]' ':<' _b" := (update_s_granule_e_refcount _a _b) (at level 1).

Definition update_s_realm_s2_context_e_rls2ctx_ipa_bits(_a: s_realm_s2_context) _b :=
  mks_realm_s2_context _b (_a.(e_rls2ctx_s2_starting_level)) (_a.(e_rls2ctx_num_root_rtts)) (_a.(e_rls2ctx_g_rtt)) (_a.(e_rls2ctx_vmid)).
Notation "_a '.[e_rls2ctx_ipa_bits]' ':<' _b" := (update_s_realm_s2_context_e_rls2ctx_ipa_bits _a _b) (at level 1).

Definition update_s_realm_s2_context_e_rls2ctx_s2_starting_level(_a: s_realm_s2_context) _b :=
  mks_realm_s2_context (_a.(e_rls2ctx_ipa_bits)) _b (_a.(e_rls2ctx_num_root_rtts)) (_a.(e_rls2ctx_g_rtt)) (_a.(e_rls2ctx_vmid)).
Notation "_a '.[e_rls2ctx_s2_starting_level]' ':<' _b" := (update_s_realm_s2_context_e_rls2ctx_s2_starting_level _a _b) (at level 1).

Definition update_s_realm_s2_context_e_rls2ctx_num_root_rtts(_a: s_realm_s2_context) _b :=
  mks_realm_s2_context (_a.(e_rls2ctx_ipa_bits)) (_a.(e_rls2ctx_s2_starting_level)) _b (_a.(e_rls2ctx_g_rtt)) (_a.(e_rls2ctx_vmid)).
Notation "_a '.[e_rls2ctx_num_root_rtts]' ':<' _b" := (update_s_realm_s2_context_e_rls2ctx_num_root_rtts _a _b) (at level 1).

Definition update_s_realm_s2_context_e_rls2ctx_g_rtt(_a: s_realm_s2_context) _b :=
  mks_realm_s2_context (_a.(e_rls2ctx_ipa_bits)) (_a.(e_rls2ctx_s2_starting_level)) (_a.(e_rls2ctx_num_root_rtts)) _b (_a.(e_rls2ctx_vmid)).
Notation "_a '.[e_rls2ctx_g_rtt]' ':<' _b" := (update_s_realm_s2_context_e_rls2ctx_g_rtt _a _b) (at level 1).

Definition update_s_realm_s2_context_e_rls2ctx_vmid(_a: s_realm_s2_context) _b :=
  mks_realm_s2_context (_a.(e_rls2ctx_ipa_bits)) (_a.(e_rls2ctx_s2_starting_level)) (_a.(e_rls2ctx_num_root_rtts)) (_a.(e_rls2ctx_g_rtt)) _b.
Notation "_a '.[e_rls2ctx_vmid]' ':<' _b" := (update_s_realm_s2_context_e_rls2ctx_vmid _a _b) (at level 1).

Definition update_s_rd_e_rd_rd_state(_a: s_rd) _b :=
  mks_rd _b (_a.(e_rd_rec_count)) (_a.(e_rd_s2_ctx)) (_a.(e_rd_num_rec_aux)) (_a.(e_rd_algorithm)) (_a.(e_rd_pmu_enabled)) (_a.(e_rd_pmu_num_cnts)) (_a.(e_rd_sve_enabled))
 (_a.(e_rd_sve_vq)) (_a.(e_rd_measurement)) (_a.(e_rd_rpv)).
Notation "_a '.[e_rd_rd_state]' ':<' _b" := (update_s_rd_e_rd_rd_state _a _b) (at level 1).

Definition update_s_rd_e_rd_rec_count(_a: s_rd) _b :=
  mks_rd (_a.(e_rd_rd_state)) _b (_a.(e_rd_s2_ctx)) (_a.(e_rd_num_rec_aux)) (_a.(e_rd_algorithm)) (_a.(e_rd_pmu_enabled)) (_a.(e_rd_pmu_num_cnts)) (_a.(e_rd_sve_enabled))
 (_a.(e_rd_sve_vq)) (_a.(e_rd_measurement)) (_a.(e_rd_rpv)).
Notation "_a '.[e_rd_rec_count]' ':<' _b" := (update_s_rd_e_rd_rec_count _a _b) (at level 1).

Definition update_s_rd_e_rd_s2_ctx(_a: s_rd) _b :=
  mks_rd (_a.(e_rd_rd_state)) (_a.(e_rd_rec_count)) _b (_a.(e_rd_num_rec_aux)) (_a.(e_rd_algorithm)) (_a.(e_rd_pmu_enabled)) (_a.(e_rd_pmu_num_cnts)) (_a.(e_rd_sve_enabled))
 (_a.(e_rd_sve_vq)) (_a.(e_rd_measurement)) (_a.(e_rd_rpv)).
Notation "_a '.[e_rd_s2_ctx]' ':<' _b" := (update_s_rd_e_rd_s2_ctx _a _b) (at level 1).

Definition update_s_rd_e_rd_num_rec_aux(_a: s_rd) _b :=
  mks_rd (_a.(e_rd_rd_state)) (_a.(e_rd_rec_count)) (_a.(e_rd_s2_ctx)) _b (_a.(e_rd_algorithm)) (_a.(e_rd_pmu_enabled)) (_a.(e_rd_pmu_num_cnts)) (_a.(e_rd_sve_enabled))
 (_a.(e_rd_sve_vq)) (_a.(e_rd_measurement)) (_a.(e_rd_rpv)).
Notation "_a '.[e_rd_num_rec_aux]' ':<' _b" := (update_s_rd_e_rd_num_rec_aux _a _b) (at level 1).

Definition update_s_rd_e_rd_algorithm(_a: s_rd) _b :=
  mks_rd (_a.(e_rd_rd_state)) (_a.(e_rd_rec_count)) (_a.(e_rd_s2_ctx)) (_a.(e_rd_num_rec_aux)) _b (_a.(e_rd_pmu_enabled)) (_a.(e_rd_pmu_num_cnts)) (_a.(e_rd_sve_enabled))
 (_a.(e_rd_sve_vq)) (_a.(e_rd_measurement)) (_a.(e_rd_rpv)).
Notation "_a '.[e_rd_algorithm]' ':<' _b" := (update_s_rd_e_rd_algorithm _a _b) (at level 1).

Definition update_s_rd_e_rd_pmu_enabled(_a: s_rd) _b :=
  mks_rd (_a.(e_rd_rd_state)) (_a.(e_rd_rec_count)) (_a.(e_rd_s2_ctx)) (_a.(e_rd_num_rec_aux)) (_a.(e_rd_algorithm)) _b (_a.(e_rd_pmu_num_cnts)) (_a.(e_rd_sve_enabled))
 (_a.(e_rd_sve_vq)) (_a.(e_rd_measurement)) (_a.(e_rd_rpv)).
Notation "_a '.[e_rd_pmu_enabled]' ':<' _b" := (update_s_rd_e_rd_pmu_enabled _a _b) (at level 1).

Definition update_s_rd_e_rd_pmu_num_cnts(_a: s_rd) _b :=
  mks_rd (_a.(e_rd_rd_state)) (_a.(e_rd_rec_count)) (_a.(e_rd_s2_ctx)) (_a.(e_rd_num_rec_aux)) (_a.(e_rd_algorithm)) (_a.(e_rd_pmu_enabled)) _b (_a.(e_rd_sve_enabled))
 (_a.(e_rd_sve_vq)) (_a.(e_rd_measurement)) (_a.(e_rd_rpv)).
Notation "_a '.[e_rd_pmu_num_cnts]' ':<' _b" := (update_s_rd_e_rd_pmu_num_cnts _a _b) (at level 1).

Definition update_s_rd_e_rd_sve_enabled(_a: s_rd) _b :=
  mks_rd (_a.(e_rd_rd_state)) (_a.(e_rd_rec_count)) (_a.(e_rd_s2_ctx)) (_a.(e_rd_num_rec_aux)) (_a.(e_rd_algorithm)) (_a.(e_rd_pmu_enabled)) (_a.(e_rd_pmu_num_cnts)) _b
 (_a.(e_rd_sve_vq)) (_a.(e_rd_measurement)) (_a.(e_rd_rpv)).
Notation "_a '.[e_rd_sve_enabled]' ':<' _b" := (update_s_rd_e_rd_sve_enabled _a _b) (at level 1).

Definition update_s_rd_e_rd_sve_vq(_a: s_rd) _b :=
  mks_rd (_a.(e_rd_rd_state)) (_a.(e_rd_rec_count)) (_a.(e_rd_s2_ctx)) (_a.(e_rd_num_rec_aux)) (_a.(e_rd_algorithm)) (_a.(e_rd_pmu_enabled)) (_a.(e_rd_pmu_num_cnts)) (_a.(e_rd_sve_enabled))
 _b (_a.(e_rd_measurement)) (_a.(e_rd_rpv)).
Notation "_a '.[e_rd_sve_vq]' ':<' _b" := (update_s_rd_e_rd_sve_vq _a _b) (at level 1).

Definition update_s_rd_e_rd_measurement(_a: s_rd) _b :=
  mks_rd (_a.(e_rd_rd_state)) (_a.(e_rd_rec_count)) (_a.(e_rd_s2_ctx)) (_a.(e_rd_num_rec_aux)) (_a.(e_rd_algorithm)) (_a.(e_rd_pmu_enabled)) (_a.(e_rd_pmu_num_cnts)) (_a.(e_rd_sve_enabled))
 (_a.(e_rd_sve_vq)) _b (_a.(e_rd_rpv)).
Notation "_a '.[e_rd_measurement]' ':<' _b" := (update_s_rd_e_rd_measurement _a _b) (at level 1).

Definition update_s_rd_e_rd_rpv(_a: s_rd) _b :=
  mks_rd (_a.(e_rd_rd_state)) (_a.(e_rd_rec_count)) (_a.(e_rd_s2_ctx)) (_a.(e_rd_num_rec_aux)) (_a.(e_rd_algorithm)) (_a.(e_rd_pmu_enabled)) (_a.(e_rd_pmu_num_cnts)) (_a.(e_rd_sve_enabled))
 (_a.(e_rd_sve_vq)) (_a.(e_rd_measurement)) _b.
Notation "_a '.[e_rd_rpv]' ':<' _b" := (update_s_rd_e_rd_rpv _a _b) (at level 1).

Definition update_GranuleDataNormal_gd_g_idx(_a: GranuleDataNormal) _b :=
  mkGranuleDataNormal _b (_a.(g_rd)) (_a.(g_rec)) (_a.(g_aux_pmu_state)) (_a.(g_aux_simd_state)) (_a.(rec_gidx)) (_a.(g_norm)).
Notation "_a '.[gd_g_idx]' ':<' _b" := (update_GranuleDataNormal_gd_g_idx _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd(_a: GranuleDataNormal) _b :=
  mkGranuleDataNormal (_a.(gd_g_idx)) _b (_a.(g_rec)) (_a.(g_aux_pmu_state)) (_a.(g_aux_simd_state)) (_a.(rec_gidx)) (_a.(g_norm)).
Notation "_a '.[g_rd]' ':<' _b" := (update_GranuleDataNormal_g_rd _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec(_a: GranuleDataNormal) _b :=
  mkGranuleDataNormal (_a.(gd_g_idx)) (_a.(g_rd)) _b (_a.(g_aux_pmu_state)) (_a.(g_aux_simd_state)) (_a.(rec_gidx)) (_a.(g_norm)).
Notation "_a '.[g_rec]' ':<' _b" := (update_GranuleDataNormal_g_rec _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state(_a: GranuleDataNormal) _b :=
  mkGranuleDataNormal (_a.(gd_g_idx)) (_a.(g_rd)) (_a.(g_rec)) _b (_a.(g_aux_simd_state)) (_a.(rec_gidx)) (_a.(g_norm)).
Notation "_a '.[g_aux_pmu_state]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_simd_state(_a: GranuleDataNormal) _b :=
  mkGranuleDataNormal (_a.(gd_g_idx)) (_a.(g_rd)) (_a.(g_rec)) (_a.(g_aux_pmu_state)) _b (_a.(rec_gidx)) (_a.(g_norm)).
Notation "_a '.[g_aux_simd_state]' ':<' _b" := (update_GranuleDataNormal_g_aux_simd_state _a _b) (at level 1).

Definition update_GranuleDataNormal_rec_gidx(_a: GranuleDataNormal) _b :=
  mkGranuleDataNormal (_a.(gd_g_idx)) (_a.(g_rd)) (_a.(g_rec)) (_a.(g_aux_pmu_state)) (_a.(g_aux_simd_state)) _b (_a.(g_norm)).
Notation "_a '.[rec_gidx]' ':<' _b" := (update_GranuleDataNormal_rec_gidx _a _b) (at level 1).

Definition update_GranuleDataNormal_g_norm(_a: GranuleDataNormal) _b :=
  mkGranuleDataNormal (_a.(gd_g_idx)) (_a.(g_rd)) (_a.(g_rec)) (_a.(g_aux_pmu_state)) (_a.(g_aux_simd_state)) (_a.(rec_gidx)) _b.
Notation "_a '.[g_norm]' ':<' _b" := (update_GranuleDataNormal_g_norm _a _b) (at level 1).

Definition update_s_s2_walk_result_e_walk_pa(_a: s_s2_walk_result) _b :=
  mks_s2_walk_result _b (_a.(e_walk_rtt_level)) (_a.(e_walk_ripas)) (_a.(e_walk_destroyed)) (_a.(e_walk_llt)).
Notation "_a '.[e_walk_pa]' ':<' _b" := (update_s_s2_walk_result_e_walk_pa _a _b) (at level 1).

Definition update_s_s2_walk_result_e_walk_rtt_level(_a: s_s2_walk_result) _b :=
  mks_s2_walk_result (_a.(e_walk_pa)) _b (_a.(e_walk_ripas)) (_a.(e_walk_destroyed)) (_a.(e_walk_llt)).
Notation "_a '.[e_walk_rtt_level]' ':<' _b" := (update_s_s2_walk_result_e_walk_rtt_level _a _b) (at level 1).

Definition update_s_s2_walk_result_e_walk_ripas(_a: s_s2_walk_result) _b :=
  mks_s2_walk_result (_a.(e_walk_pa)) (_a.(e_walk_rtt_level)) _b (_a.(e_walk_destroyed)) (_a.(e_walk_llt)).
Notation "_a '.[e_walk_ripas]' ':<' _b" := (update_s_s2_walk_result_e_walk_ripas _a _b) (at level 1).

Definition update_s_s2_walk_result_e_walk_destroyed(_a: s_s2_walk_result) _b :=
  mks_s2_walk_result (_a.(e_walk_pa)) (_a.(e_walk_rtt_level)) (_a.(e_walk_ripas)) _b (_a.(e_walk_llt)).
Notation "_a '.[e_walk_destroyed]' ':<' _b" := (update_s_s2_walk_result_e_walk_destroyed _a _b) (at level 1).

Definition update_s_s2_walk_result_e_walk_llt(_a: s_s2_walk_result) _b :=
  mks_s2_walk_result (_a.(e_walk_pa)) (_a.(e_walk_rtt_level)) (_a.(e_walk_ripas)) (_a.(e_walk_destroyed)) _b.
Notation "_a '.[e_walk_llt]' ':<' _b" := (update_s_s2_walk_result_e_walk_llt _a _b) (at level 1).

Definition update_s_granule_set_e_gset_idx(_a: s_granule_set) _b :=
  mks_granule_set _b (_a.(e_gset_addr)) (_a.(e_gset_state)) (_a.(e_gset_g)) (_a.(e_gset_g_ret)).
Notation "_a '.[e_gset_idx]' ':<' _b" := (update_s_granule_set_e_gset_idx _a _b) (at level 1).

Definition update_s_granule_set_e_gset_addr(_a: s_granule_set) _b :=
  mks_granule_set (_a.(e_gset_idx)) _b (_a.(e_gset_state)) (_a.(e_gset_g)) (_a.(e_gset_g_ret)).
Notation "_a '.[e_gset_addr]' ':<' _b" := (update_s_granule_set_e_gset_addr _a _b) (at level 1).

Definition update_s_granule_set_e_gset_state(_a: s_granule_set) _b :=
  mks_granule_set (_a.(e_gset_idx)) (_a.(e_gset_addr)) _b (_a.(e_gset_g)) (_a.(e_gset_g_ret)).
Notation "_a '.[e_gset_state]' ':<' _b" := (update_s_granule_set_e_gset_state _a _b) (at level 1).

Definition update_s_granule_set_e_gset_g(_a: s_granule_set) _b :=
  mks_granule_set (_a.(e_gset_idx)) (_a.(e_gset_addr)) (_a.(e_gset_state)) _b (_a.(e_gset_g_ret)).
Notation "_a '.[e_gset_g]' ':<' _b" := (update_s_granule_set_e_gset_g _a _b) (at level 1).

Definition update_s_granule_set_e_gset_g_ret(_a: s_granule_set) _b :=
  mks_granule_set (_a.(e_gset_idx)) (_a.(e_gset_addr)) (_a.(e_gset_state)) (_a.(e_gset_g)) _b.
Notation "_a '.[e_gset_g_ret]' ':<' _b" := (update_s_granule_set_e_gset_g_ret _a _b) (at level 1).

Definition update_s_xlat_llt_info_llt_info_table(_a: s_xlat_llt_info) _b :=
  mks_xlat_llt_info _b (_a.(llt_info_llt_base_va)) (_a.(llt_info_level)).
Notation "_a '.[llt_info_table]' ':<' _b" := (update_s_xlat_llt_info_llt_info_table _a _b) (at level 1).

Definition update_s_xlat_llt_info_llt_info_llt_base_va(_a: s_xlat_llt_info) _b :=
  mks_xlat_llt_info (_a.(llt_info_table)) _b (_a.(llt_info_level)).
Notation "_a '.[llt_info_llt_base_va]' ':<' _b" := (update_s_xlat_llt_info_llt_info_llt_base_va _a _b) (at level 1).

Definition update_s_xlat_llt_info_llt_info_level(_a: s_xlat_llt_info) _b :=
  mks_xlat_llt_info (_a.(llt_info_table)) (_a.(llt_info_llt_base_va)) _b.
Notation "_a '.[llt_info_level]' ':<' _b" := (update_s_xlat_llt_info_llt_info_level _a _b) (at level 1).

Definition update_StackData_sd_data(_a: StackData) _b :=
  mkStackData _b (_a.(sd_size)).
Notation "_a '.[sd_data]' ':<' _b" := (update_StackData_sd_data _a _b) (at level 1).

Definition update_StackData_sd_size(_a: StackData) _b :=
  mkStackData (_a.(sd_data)) _b.
Notation "_a '.[sd_size]' ':<' _b" := (update_StackData_sd_size _a _b) (at level 1).

Definition update_StackFrame_sf_data(_a: StackFrame) _b :=
  mkStackFrame _b (_a.(sf_sp)).
Notation "_a '.[sf_data]' ':<' _b" := (update_StackFrame_sf_data _a _b) (at level 1).

Definition update_StackFrame_sf_sp(_a: StackFrame) _b :=
  mkStackFrame (_a.(sf_data)) _b.
Notation "_a '.[sf_sp]' ':<' _b" := (update_StackFrame_sf_sp _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_vttbr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs _b (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_vttbr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_vttbr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_zcr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) _b (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_zcr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_zcr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_cnthctl_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) _b (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_cnthctl_el2]' ':<' _b" := (update_PerCPURegs_pcpu_cnthctl_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_elr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) _b (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_elr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_elr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_cptr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) _b (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_cptr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_cptr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_mdcr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) _b (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_mdcr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_mdcr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_vpidr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) _b (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_vpidr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_vpidr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_sctlr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) _b
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_sctlr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_sctlr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_esr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 _b (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_esr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_esr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_spsr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) _b (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_spsr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_spsr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_hpfar_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) _b (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_hpfar_el2]' ':<' _b" := (update_PerCPURegs_pcpu_hpfar_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_far_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) _b (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_far_el2]' ':<' _b" := (update_PerCPURegs_pcpu_far_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_vsesr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) _b (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_vsesr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_vsesr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_hcr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) _b (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_hcr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_hcr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_cntvoff_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) _b (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_cntvoff_el2]' ':<' _b" := (update_PerCPURegs_pcpu_cntvoff_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_vmpidr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) _b
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_vmpidr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_vmpidr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_vtcr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 _b (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_vtcr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_vtcr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_ich_hcr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) _b (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_ich_hcr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_ich_hcr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_ich_lr15_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) _b (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_ich_lr15_el2]' ':<' _b" := (update_PerCPURegs_pcpu_ich_lr15_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_ich_misr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) _b (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_ich_misr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_ich_misr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_ich_vmcr_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) _b (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_ich_vmcr_el2]' ':<' _b" := (update_PerCPURegs_pcpu_ich_vmcr_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_icc_sre_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) _b (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_icc_sre_el2]' ':<' _b" := (update_PerCPURegs_pcpu_icc_sre_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_esr_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) _b (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_esr_el12]' ':<' _b" := (update_PerCPURegs_pcpu_esr_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_spsr_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) _b
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_spsr_el12]' ':<' _b" := (update_PerCPURegs_pcpu_spsr_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_elr_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 _b (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_elr_el12]' ':<' _b" := (update_PerCPURegs_pcpu_elr_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_vbar_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) _b (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_vbar_el12]' ':<' _b" := (update_PerCPURegs_pcpu_vbar_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_far_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) _b (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_far_el12]' ':<' _b" := (update_PerCPURegs_pcpu_far_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_amair_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) _b (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_amair_el12]' ':<' _b" := (update_PerCPURegs_pcpu_amair_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_cntkctl_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) _b (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_cntkctl_el12]' ':<' _b" := (update_PerCPURegs_pcpu_cntkctl_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_cntp_ctl_el02(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) _b (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_cntp_ctl_el02]' ':<' _b" := (update_PerCPURegs_pcpu_cntp_ctl_el02 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_cntp_cval_el02(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) _b (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_cntp_cval_el02]' ':<' _b" := (update_PerCPURegs_pcpu_cntp_cval_el02 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_cntpoff_el2(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) _b
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_cntpoff_el2]' ':<' _b" := (update_PerCPURegs_pcpu_cntpoff_el2 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_cntv_ctl_el02(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 _b (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_cntv_ctl_el02]' ':<' _b" := (update_PerCPURegs_pcpu_cntv_ctl_el02 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_cntv_cval_el02(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) _b (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_cntv_cval_el02]' ':<' _b" := (update_PerCPURegs_pcpu_cntv_cval_el02 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_contextidr_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) _b (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_contextidr_el12]' ':<' _b" := (update_PerCPURegs_pcpu_contextidr_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_mair_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) _b (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_mair_el12]' ':<' _b" := (update_PerCPURegs_pcpu_mair_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_afsr1_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) _b (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_afsr1_el12]' ':<' _b" := (update_PerCPURegs_pcpu_afsr1_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_afsr0_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) _b (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_afsr0_el12]' ':<' _b" := (update_PerCPURegs_pcpu_afsr0_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_tcr_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) _b (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_tcr_el12]' ':<' _b" := (update_PerCPURegs_pcpu_tcr_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_ttbr1_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) _b
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_ttbr1_el12]' ':<' _b" := (update_PerCPURegs_pcpu_ttbr1_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_ttbr0_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 _b (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_ttbr0_el12]' ':<' _b" := (update_PerCPURegs_pcpu_ttbr0_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_cpacr_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) _b (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_cpacr_el12]' ':<' _b" := (update_PerCPURegs_pcpu_cpacr_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_sctlr_el12(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) _b (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_sctlr_el12]' ':<' _b" := (update_PerCPURegs_pcpu_sctlr_el12 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_midr_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) _b (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_midr_el1]' ':<' _b" := (update_PerCPURegs_pcpu_midr_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_isr_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) _b (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_isr_el1]' ':<' _b" := (update_PerCPURegs_pcpu_isr_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_id_aa64mmfr0_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) _b (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_id_aa64mmfr0_el1]' ':<' _b" := (update_PerCPURegs_pcpu_id_aa64mmfr0_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_id_aa64mmfr1_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) _b (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_id_aa64mmfr1_el1]' ':<' _b" := (update_PerCPURegs_pcpu_id_aa64mmfr1_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_id_aa64dfr0_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) _b
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_id_aa64dfr0_el1]' ':<' _b" := (update_PerCPURegs_pcpu_id_aa64dfr0_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_id_aa64dfr1_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 _b (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_id_aa64dfr1_el1]' ':<' _b" := (update_PerCPURegs_pcpu_id_aa64dfr1_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_id_aa64pfr0_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) _b (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_id_aa64pfr0_el1]' ':<' _b" := (update_PerCPURegs_pcpu_id_aa64pfr0_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_id_aa64pfr1_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) _b (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_id_aa64pfr1_el1]' ':<' _b" := (update_PerCPURegs_pcpu_id_aa64pfr1_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_disr_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) _b (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_disr_el1]' ':<' _b" := (update_PerCPURegs_pcpu_disr_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_mdccint_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) _b (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_mdccint_el1]' ':<' _b" := (update_PerCPURegs_pcpu_mdccint_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_mdscr_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) _b (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_mdscr_el1]' ':<' _b" := (update_PerCPURegs_pcpu_mdscr_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_par_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) _b (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_par_el1]' ':<' _b" := (update_PerCPURegs_pcpu_par_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_tpidr_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) _b
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_tpidr_el1]' ':<' _b" := (update_PerCPURegs_pcpu_tpidr_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_actlr_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 _b (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_actlr_el1]' ':<' _b" := (update_PerCPURegs_pcpu_actlr_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_csselr_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) _b (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_csselr_el1]' ':<' _b" := (update_PerCPURegs_pcpu_csselr_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_sp_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) _b (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_sp_el1]' ':<' _b" := (update_PerCPURegs_pcpu_sp_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmintenset_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) _b (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmintenset_el1]' ':<' _b" := (update_PerCPURegs_pcpu_pmintenset_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmintenclr_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) _b (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmintenclr_el1]' ':<' _b" := (update_PerCPURegs_pcpu_pmintenclr_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_icc_hppir1_el1(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) _b (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_icc_hppir1_el1]' ':<' _b" := (update_PerCPURegs_pcpu_icc_hppir1_el1 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmcr_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) _b (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmcr_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmcr_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper0_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) _b
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper0_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper0_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper1_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 _b (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper1_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper1_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper2_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) _b (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper2_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper2_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper3_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) _b (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper3_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper3_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper4_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) _b (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper4_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper4_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper5_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) _b (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper5_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper5_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper6_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) _b (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper6_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper6_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper7_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) _b (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper7_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper7_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper8_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) _b
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper8_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper8_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper9_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 _b (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper9_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper9_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper10_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) _b (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper10_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper10_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper11_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) _b (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper11_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper11_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper12_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) _b (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper12_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper12_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper13_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) _b (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper13_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper13_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper14_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) _b (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper14_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper14_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper15_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) _b (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper15_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper15_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper16_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) _b
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper16_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper16_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper17_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 _b (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper17_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper17_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper18_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) _b (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper18_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper18_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper19_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) _b (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper19_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper19_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper20_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) _b (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper20_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper20_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper21_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) _b (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper21_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper21_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper22_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) _b (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper22_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper22_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper23_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) _b (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper23_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper23_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper24_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) _b
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper24_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper24_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper25_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 _b (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper25_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper25_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper26_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) _b (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper26_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper26_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper27_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) _b (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper27_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper27_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper28_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) _b (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper28_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper28_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper29_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) _b (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper29_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper29_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevtyper30_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) _b (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevtyper30_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevtyper30_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr0_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) _b (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr0_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr0_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr1_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) _b
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr1_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr1_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr2_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 _b (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr2_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr2_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr3_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) _b (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr3_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr3_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr4_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) _b (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr4_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr4_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr5_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) _b (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr5_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr5_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr6_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) _b (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr6_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr6_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr7_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) _b (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr7_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr7_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr8_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) _b (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr8_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr8_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr9_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) _b
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr9_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr9_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr10_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 _b (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr10_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr10_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr11_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) _b (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr11_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr11_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr12_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) _b (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr12_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr12_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr13_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) _b (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr13_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr13_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr14_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) _b (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr14_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr14_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr15_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) _b (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr15_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr15_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr16_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) _b (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr16_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr16_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr17_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) _b
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr17_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr17_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr18_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 _b (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr18_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr18_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr19_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) _b (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr19_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr19_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr20_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) _b (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr20_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr20_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr21_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) _b (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr21_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr21_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr22_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) _b (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr22_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr22_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr23_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) _b (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr23_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr23_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr24_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) _b (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr24_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr24_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr25_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) _b
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr25_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr25_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr26_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 _b (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr26_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr26_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr27_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) _b (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr27_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr27_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr28_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) _b (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr28_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr28_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr29_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) _b (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr29_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr29_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmevcntr30_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) _b (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmevcntr30_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmevcntr30_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmccfiltr_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) _b (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmccfiltr_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmccfiltr_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmccntr_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) _b (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmccntr_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmccntr_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmcntenset_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) _b
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmcntenset_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmcntenset_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmcntenclr_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 _b (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmcntenclr_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmcntenclr_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmovsclr_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) _b (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmovsclr_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmovsclr_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmovsset_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) _b (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmovsset_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmovsset_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmselr_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) _b (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmselr_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmselr_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmuserenr_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) _b (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmuserenr_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmuserenr_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmxevcntr_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) _b (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmxevcntr_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmxevcntr_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_pmxevtyper_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) _b (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_pmxevtyper_el0]' ':<' _b" := (update_PerCPURegs_pcpu_pmxevtyper_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_tpidr_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) _b
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_tpidr_el0]' ':<' _b" := (update_PerCPURegs_pcpu_tpidr_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_tpidrro_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 _b (_a.(pcpu_sp_el0)) (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_tpidrro_el0]' ':<' _b" := (update_PerCPURegs_pcpu_tpidrro_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_sp_el0(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) _b (_a.(pcpu_dummy_regs)).
Notation "_a '.[pcpu_sp_el0]' ':<' _b" := (update_PerCPURegs_pcpu_sp_el0 _a _b) (at level 1).

Definition update_PerCPURegs_pcpu_dummy_regs(_a: PerCPURegs) _b :=
  mkPerCPURegs (_a.(pcpu_vttbr_el2)) (_a.(pcpu_zcr_el2)) (_a.(pcpu_cnthctl_el2)) (_a.(pcpu_elr_el2)) (_a.(pcpu_cptr_el2)) (_a.(pcpu_mdcr_el2)) (_a.(pcpu_vpidr_el2)) (_a.(pcpu_sctlr_el2))
 (_a.(pcpu_esr_el2)) (_a.(pcpu_spsr_el2)) (_a.(pcpu_hpfar_el2)) (_a.(pcpu_far_el2)) (_a.(pcpu_vsesr_el2)) (_a.(pcpu_hcr_el2)) (_a.(pcpu_cntvoff_el2)) (_a.(pcpu_vmpidr_el2))
 (_a.(pcpu_vtcr_el2)) (_a.(pcpu_ich_hcr_el2)) (_a.(pcpu_ich_lr15_el2)) (_a.(pcpu_ich_misr_el2)) (_a.(pcpu_ich_vmcr_el2)) (_a.(pcpu_icc_sre_el2)) (_a.(pcpu_esr_el12)) (_a.(pcpu_spsr_el12))
 (_a.(pcpu_elr_el12)) (_a.(pcpu_vbar_el12)) (_a.(pcpu_far_el12)) (_a.(pcpu_amair_el12)) (_a.(pcpu_cntkctl_el12)) (_a.(pcpu_cntp_ctl_el02)) (_a.(pcpu_cntp_cval_el02)) (_a.(pcpu_cntpoff_el2))
 (_a.(pcpu_cntv_ctl_el02)) (_a.(pcpu_cntv_cval_el02)) (_a.(pcpu_contextidr_el12)) (_a.(pcpu_mair_el12)) (_a.(pcpu_afsr1_el12)) (_a.(pcpu_afsr0_el12)) (_a.(pcpu_tcr_el12)) (_a.(pcpu_ttbr1_el12))
 (_a.(pcpu_ttbr0_el12)) (_a.(pcpu_cpacr_el12)) (_a.(pcpu_sctlr_el12)) (_a.(pcpu_midr_el1)) (_a.(pcpu_isr_el1)) (_a.(pcpu_id_aa64mmfr0_el1)) (_a.(pcpu_id_aa64mmfr1_el1)) (_a.(pcpu_id_aa64dfr0_el1))
 (_a.(pcpu_id_aa64dfr1_el1)) (_a.(pcpu_id_aa64pfr0_el1)) (_a.(pcpu_id_aa64pfr1_el1)) (_a.(pcpu_disr_el1)) (_a.(pcpu_mdccint_el1)) (_a.(pcpu_mdscr_el1)) (_a.(pcpu_par_el1)) (_a.(pcpu_tpidr_el1))
 (_a.(pcpu_actlr_el1)) (_a.(pcpu_csselr_el1)) (_a.(pcpu_sp_el1)) (_a.(pcpu_pmintenset_el1)) (_a.(pcpu_pmintenclr_el1)) (_a.(pcpu_icc_hppir1_el1)) (_a.(pcpu_pmcr_el0)) (_a.(pcpu_pmevtyper0_el0))
 (_a.(pcpu_pmevtyper1_el0)) (_a.(pcpu_pmevtyper2_el0)) (_a.(pcpu_pmevtyper3_el0)) (_a.(pcpu_pmevtyper4_el0)) (_a.(pcpu_pmevtyper5_el0)) (_a.(pcpu_pmevtyper6_el0)) (_a.(pcpu_pmevtyper7_el0)) (_a.(pcpu_pmevtyper8_el0))
 (_a.(pcpu_pmevtyper9_el0)) (_a.(pcpu_pmevtyper10_el0)) (_a.(pcpu_pmevtyper11_el0)) (_a.(pcpu_pmevtyper12_el0)) (_a.(pcpu_pmevtyper13_el0)) (_a.(pcpu_pmevtyper14_el0)) (_a.(pcpu_pmevtyper15_el0)) (_a.(pcpu_pmevtyper16_el0))
 (_a.(pcpu_pmevtyper17_el0)) (_a.(pcpu_pmevtyper18_el0)) (_a.(pcpu_pmevtyper19_el0)) (_a.(pcpu_pmevtyper20_el0)) (_a.(pcpu_pmevtyper21_el0)) (_a.(pcpu_pmevtyper22_el0)) (_a.(pcpu_pmevtyper23_el0)) (_a.(pcpu_pmevtyper24_el0))
 (_a.(pcpu_pmevtyper25_el0)) (_a.(pcpu_pmevtyper26_el0)) (_a.(pcpu_pmevtyper27_el0)) (_a.(pcpu_pmevtyper28_el0)) (_a.(pcpu_pmevtyper29_el0)) (_a.(pcpu_pmevtyper30_el0)) (_a.(pcpu_pmevcntr0_el0)) (_a.(pcpu_pmevcntr1_el0))
 (_a.(pcpu_pmevcntr2_el0)) (_a.(pcpu_pmevcntr3_el0)) (_a.(pcpu_pmevcntr4_el0)) (_a.(pcpu_pmevcntr5_el0)) (_a.(pcpu_pmevcntr6_el0)) (_a.(pcpu_pmevcntr7_el0)) (_a.(pcpu_pmevcntr8_el0)) (_a.(pcpu_pmevcntr9_el0))
 (_a.(pcpu_pmevcntr10_el0)) (_a.(pcpu_pmevcntr11_el0)) (_a.(pcpu_pmevcntr12_el0)) (_a.(pcpu_pmevcntr13_el0)) (_a.(pcpu_pmevcntr14_el0)) (_a.(pcpu_pmevcntr15_el0)) (_a.(pcpu_pmevcntr16_el0)) (_a.(pcpu_pmevcntr17_el0))
 (_a.(pcpu_pmevcntr18_el0)) (_a.(pcpu_pmevcntr19_el0)) (_a.(pcpu_pmevcntr20_el0)) (_a.(pcpu_pmevcntr21_el0)) (_a.(pcpu_pmevcntr22_el0)) (_a.(pcpu_pmevcntr23_el0)) (_a.(pcpu_pmevcntr24_el0)) (_a.(pcpu_pmevcntr25_el0))
 (_a.(pcpu_pmevcntr26_el0)) (_a.(pcpu_pmevcntr27_el0)) (_a.(pcpu_pmevcntr28_el0)) (_a.(pcpu_pmevcntr29_el0)) (_a.(pcpu_pmevcntr30_el0)) (_a.(pcpu_pmccfiltr_el0)) (_a.(pcpu_pmccntr_el0)) (_a.(pcpu_pmcntenset_el0))
 (_a.(pcpu_pmcntenclr_el0)) (_a.(pcpu_pmovsclr_el0)) (_a.(pcpu_pmovsset_el0)) (_a.(pcpu_pmselr_el0)) (_a.(pcpu_pmuserenr_el0)) (_a.(pcpu_pmxevcntr_el0)) (_a.(pcpu_pmxevtyper_el0)) (_a.(pcpu_tpidr_el0))
 (_a.(pcpu_tpidrro_el0)) (_a.(pcpu_sp_el0)) _b.
Notation "_a '.[pcpu_dummy_regs]' ':<' _b" := (update_PerCPURegs_pcpu_dummy_regs _a _b) (at level 1).

Definition update_PerCPU_pcpu_stack(_a: PerCPU) _b :=
  mkPerCPU _b (_a.(pcpu_sc)) (_a.(pcpu_regs)) (_a.(pcpu_llt_info_cache)).
Notation "_a '.[pcpu_stack]' ':<' _b" := (update_PerCPU_pcpu_stack _a _b) (at level 1).

Definition update_PerCPU_pcpu_sc(_a: PerCPU) _b :=
  mkPerCPU (_a.(pcpu_stack)) _b (_a.(pcpu_regs)) (_a.(pcpu_llt_info_cache)).
Notation "_a '.[pcpu_sc]' ':<' _b" := (update_PerCPU_pcpu_sc _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs(_a: PerCPU) _b :=
  mkPerCPU (_a.(pcpu_stack)) (_a.(pcpu_sc)) _b (_a.(pcpu_llt_info_cache)).
Notation "_a '.[pcpu_regs]' ':<' _b" := (update_PerCPU_pcpu_regs _a _b) (at level 1).

Definition update_PerCPU_pcpu_llt_info_cache(_a: PerCPU) _b :=
  mkPerCPU (_a.(pcpu_stack)) (_a.(pcpu_sc)) (_a.(pcpu_regs)) _b.
Notation "_a '.[pcpu_llt_info_cache]' ':<' _b" := (update_PerCPU_pcpu_llt_info_cache _a _b) (at level 1).

Definition update_Shared_glk(_a: Shared) _b :=
  mkShared _b (_a.(gpt)) (_a.(slots)) (_a.(granules)) (_a.(granule_data)) (_a.(gv_g_sve_max_vq)) (_a.(gv_g_ns_simd)) (_a.(gv_g_cpu_simd_type))
 (_a.(gv_vmids)).
Notation "_a '.[glk]' ':<' _b" := (update_Shared_glk _a _b) (at level 1).

Definition update_Shared_gpt(_a: Shared) _b :=
  mkShared (_a.(glk)) _b (_a.(slots)) (_a.(granules)) (_a.(granule_data)) (_a.(gv_g_sve_max_vq)) (_a.(gv_g_ns_simd)) (_a.(gv_g_cpu_simd_type))
 (_a.(gv_vmids)).
Notation "_a '.[gpt]' ':<' _b" := (update_Shared_gpt _a _b) (at level 1).

Definition update_Shared_slots(_a: Shared) _b :=
  mkShared (_a.(glk)) (_a.(gpt)) _b (_a.(granules)) (_a.(granule_data)) (_a.(gv_g_sve_max_vq)) (_a.(gv_g_ns_simd)) (_a.(gv_g_cpu_simd_type))
 (_a.(gv_vmids)).
Notation "_a '.[slots]' ':<' _b" := (update_Shared_slots _a _b) (at level 1).

Definition update_Shared_granules(_a: Shared) _b :=
  mkShared (_a.(glk)) (_a.(gpt)) (_a.(slots)) _b (_a.(granule_data)) (_a.(gv_g_sve_max_vq)) (_a.(gv_g_ns_simd)) (_a.(gv_g_cpu_simd_type))
 (_a.(gv_vmids)).
Notation "_a '.[granules]' ':<' _b" := (update_Shared_granules _a _b) (at level 1).

Definition update_Shared_granule_data(_a: Shared) _b :=
  mkShared (_a.(glk)) (_a.(gpt)) (_a.(slots)) (_a.(granules)) _b (_a.(gv_g_sve_max_vq)) (_a.(gv_g_ns_simd)) (_a.(gv_g_cpu_simd_type))
 (_a.(gv_vmids)).
Notation "_a '.[granule_data]' ':<' _b" := (update_Shared_granule_data _a _b) (at level 1).

Definition update_Shared_gv_g_sve_max_vq(_a: Shared) _b :=
  mkShared (_a.(glk)) (_a.(gpt)) (_a.(slots)) (_a.(granules)) (_a.(granule_data)) _b (_a.(gv_g_ns_simd)) (_a.(gv_g_cpu_simd_type))
 (_a.(gv_vmids)).
Notation "_a '.[gv_g_sve_max_vq]' ':<' _b" := (update_Shared_gv_g_sve_max_vq _a _b) (at level 1).

Definition update_Shared_gv_g_ns_simd(_a: Shared) _b :=
  mkShared (_a.(glk)) (_a.(gpt)) (_a.(slots)) (_a.(granules)) (_a.(granule_data)) (_a.(gv_g_sve_max_vq)) _b (_a.(gv_g_cpu_simd_type))
 (_a.(gv_vmids)).
Notation "_a '.[gv_g_ns_simd]' ':<' _b" := (update_Shared_gv_g_ns_simd _a _b) (at level 1).

Definition update_Shared_gv_g_cpu_simd_type(_a: Shared) _b :=
  mkShared (_a.(glk)) (_a.(gpt)) (_a.(slots)) (_a.(granules)) (_a.(granule_data)) (_a.(gv_g_sve_max_vq)) (_a.(gv_g_ns_simd)) _b
 (_a.(gv_vmids)).
Notation "_a '.[gv_g_cpu_simd_type]' ':<' _b" := (update_Shared_gv_g_cpu_simd_type _a _b) (at level 1).

Definition update_Shared_gv_vmids(_a: Shared) _b :=
  mkShared (_a.(glk)) (_a.(gpt)) (_a.(slots)) (_a.(granules)) (_a.(granule_data)) (_a.(gv_g_sve_max_vq)) (_a.(gv_g_ns_simd)) (_a.(gv_g_cpu_simd_type))
 _b.
Notation "_a '.[gv_vmids]' ':<' _b" := (update_Shared_gv_vmids _a _b) (at level 1).

Definition update_STACK_attest_setup_platform_token_stack(_a: STACK) _b :=
  mkSTACK _b (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[attest_setup_platform_token_stack]' ':<' _b" := (update_STACK_attest_setup_platform_token_stack _a _b) (at level 1).

Definition update_STACK_smc_psci_complete_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) _b (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_psci_complete_stack]' ':<' _b" := (update_STACK_smc_psci_complete_stack _a _b) (at level 1).

Definition update_STACK_find_lock_two_granules_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) _b (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[find_lock_two_granules_stack]' ':<' _b" := (update_STACK_find_lock_two_granules_stack _a _b) (at level 1).

Definition update_STACK_attest_token_continue_write_state_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) _b (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[attest_token_continue_write_state_stack]' ':<' _b" := (update_STACK_attest_token_continue_write_state_stack _a _b) (at level 1).

Definition update_STACK_rmm_log_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) _b (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[rmm_log_stack]' ':<' _b" := (update_STACK_rmm_log_stack _a _b) (at level 1).

Definition update_STACK_attest_realm_token_create_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) _b (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[attest_realm_token_create_stack]' ':<' _b" := (update_STACK_attest_realm_token_create_stack _a _b) (at level 1).

Definition update_STACK_smc_rec_enter_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) _b (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_rec_enter_stack]' ':<' _b" := (update_STACK_smc_rec_enter_stack _a _b) (at level 1).

Definition update_STACK_do_host_call_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) _b
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[do_host_call_stack]' ':<' _b" := (update_STACK_do_host_call_stack _a _b) (at level 1).

Definition update_STACK_attest_rnd_prng_init_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 _b (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[attest_rnd_prng_init_stack]' ':<' _b" := (update_STACK_attest_rnd_prng_init_stack _a _b) (at level 1).

Definition update_STACK_plat_setup_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) _b (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[plat_setup_stack]' ':<' _b" := (update_STACK_plat_setup_stack _a _b) (at level 1).

Definition update_STACK_attest_token_encode_start_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) _b (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[attest_token_encode_start_stack]' ':<' _b" := (update_STACK_attest_token_encode_start_stack _a _b) (at level 1).

Definition update_STACK_smc_data_destroy_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) _b (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_data_destroy_stack]' ':<' _b" := (update_STACK_smc_data_destroy_stack _a _b) (at level 1).

Definition update_STACK_xlat_get_llt_from_va_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) _b (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[xlat_get_llt_from_va_stack]' ':<' _b" := (update_STACK_xlat_get_llt_from_va_stack _a _b) (at level 1).

Definition update_STACK_smc_rec_create_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) _b (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_rec_create_stack]' ':<' _b" := (update_STACK_smc_rec_create_stack _a _b) (at level 1).

Definition update_STACK_measurement_extend_sha512_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) _b (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[measurement_extend_sha512_stack]' ':<' _b" := (update_STACK_measurement_extend_sha512_stack _a _b) (at level 1).

Definition update_STACK_data_granule_measure_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) _b
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[data_granule_measure_stack]' ':<' _b" := (update_STACK_data_granule_measure_stack _a _b) (at level 1).

Definition update_STACK_sort_granules_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 _b (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[sort_granules_stack]' ':<' _b" := (update_STACK_sort_granules_stack _a _b) (at level 1).

Definition update_STACK_measurement_extend_sha256_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) _b (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[measurement_extend_sha256_stack]' ':<' _b" := (update_STACK_measurement_extend_sha256_stack _a _b) (at level 1).

Definition update_STACK_realm_ipa_to_pa_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) _b (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[realm_ipa_to_pa_stack]' ':<' _b" := (update_STACK_realm_ipa_to_pa_stack _a _b) (at level 1).

Definition update_STACK_attest_realm_token_sign_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) _b (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[attest_realm_token_sign_stack]' ':<' _b" := (update_STACK_attest_realm_token_sign_stack _a _b) (at level 1).

Definition update_STACK_rmm_el3_ifc_get_platform_token_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) _b (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[rmm_el3_ifc_get_platform_token_stack]' ':<' _b" := (update_STACK_rmm_el3_ifc_get_platform_token_stack _a _b) (at level 1).

Definition update_STACK_attest_init_realm_attestation_key_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) _b (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[attest_init_realm_attestation_key_stack]' ':<' _b" := (update_STACK_attest_init_realm_attestation_key_stack _a _b) (at level 1).

Definition update_STACK_plat_cmn_setup_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) _b (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[plat_cmn_setup_stack]' ':<' _b" := (update_STACK_plat_cmn_setup_stack _a _b) (at level 1).

Definition update_STACK_complete_rsi_host_call_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) _b
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[complete_rsi_host_call_stack]' ':<' _b" := (update_STACK_complete_rsi_host_call_stack _a _b) (at level 1).

Definition update_STACK_handle_realm_rsi_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 _b (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[handle_realm_rsi_stack]' ':<' _b" := (update_STACK_handle_realm_rsi_stack _a _b) (at level 1).

Definition update_STACK_smc_rtt_set_ripas_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) _b (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_rtt_set_ripas_stack]' ':<' _b" := (update_STACK_smc_rtt_set_ripas_stack _a _b) (at level 1).

Definition update_STACK_rtt_walk_lock_unlock_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) _b (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[rtt_walk_lock_unlock_stack]' ':<' _b" := (update_STACK_rtt_walk_lock_unlock_stack _a _b) (at level 1).

Definition update_STACK_smc_rtt_destroy_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) _b (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_rtt_destroy_stack]' ':<' _b" := (update_STACK_smc_rtt_destroy_stack _a _b) (at level 1).

Definition update_STACK_map_unmap_ns_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) _b (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[map_unmap_ns_stack]' ':<' _b" := (update_STACK_map_unmap_ns_stack _a _b) (at level 1).

Definition update_STACK_handle_rsi_attest_token_init_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) _b (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[handle_rsi_attest_token_init_stack]' ':<' _b" := (update_STACK_handle_rsi_attest_token_init_stack _a _b) (at level 1).

Definition update_STACK_realm_params_measure_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) _b (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[realm_params_measure_stack]' ':<' _b" := (update_STACK_realm_params_measure_stack _a _b) (at level 1).

Definition update_STACK_handle_rsi_ipa_state_get_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) _b
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[handle_rsi_ipa_state_get_stack]' ':<' _b" := (update_STACK_handle_rsi_ipa_state_get_stack _a _b) (at level 1).

Definition update_STACK_realm_ipa_get_ripas_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 _b (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[realm_ipa_get_ripas_stack]' ':<' _b" := (update_STACK_realm_ipa_get_ripas_stack _a _b) (at level 1).

Definition update_STACK_smc_rtt_fold_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) _b (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_rtt_fold_stack]' ':<' _b" := (update_STACK_smc_rtt_fold_stack _a _b) (at level 1).

Definition update_STACK_smc_rtt_create_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) _b (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_rtt_create_stack]' ':<' _b" := (update_STACK_smc_rtt_create_stack _a _b) (at level 1).

Definition update_STACK_rsi_log_on_exit_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) _b (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[rsi_log_on_exit_stack]' ':<' _b" := (update_STACK_rsi_log_on_exit_stack _a _b) (at level 1).

Definition update_STACK_attest_cca_token_create_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) _b (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[attest_cca_token_create_stack]' ':<' _b" := (update_STACK_attest_cca_token_create_stack _a _b) (at level 1).

Definition update_STACK_rec_params_measure_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) _b (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[rec_params_measure_stack]' ':<' _b" := (update_STACK_rec_params_measure_stack _a _b) (at level 1).

Definition update_STACK_handle_ns_smc_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) _b (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[handle_ns_smc_stack]' ':<' _b" := (update_STACK_handle_ns_smc_stack _a _b) (at level 1).

Definition update_STACK_rmm_el3_ifc_get_realm_attest_key_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) _b
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[rmm_el3_ifc_get_realm_attest_key_stack]' ':<' _b" := (update_STACK_rmm_el3_ifc_get_realm_attest_key_stack _a _b) (at level 1).

Definition update_STACK_handle_rsi_realm_config_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 _b (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[handle_rsi_realm_config_stack]' ':<' _b" := (update_STACK_handle_rsi_realm_config_stack _a _b) (at level 1).

Definition update_STACK_smc_rtt_init_ripas_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) _b (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_rtt_init_ripas_stack]' ':<' _b" := (update_STACK_smc_rtt_init_ripas_stack _a _b) (at level 1).

Definition update_STACK_smc_rtt_read_entry_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) _b (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_rtt_read_entry_stack]' ':<' _b" := (update_STACK_smc_rtt_read_entry_stack _a _b) (at level 1).

Definition update_STACK_handle_data_abort_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) _b (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[handle_data_abort_stack]' ':<' _b" := (update_STACK_handle_data_abort_stack _a _b) (at level 1).

Definition update_STACK_data_create_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) _b (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[data_create_stack]' ':<' _b" := (update_STACK_data_create_stack _a _b) (at level 1).

Definition update_STACK_smc_realm_create_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) _b (_a.(ripas_granule_measure_stack)) (_a.(ipa_is_empty_stack)).
Notation "_a '.[smc_realm_create_stack]' ':<' _b" := (update_STACK_smc_realm_create_stack _a _b) (at level 1).

Definition update_STACK_ripas_granule_measure_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) _b (_a.(ipa_is_empty_stack)).
Notation "_a '.[ripas_granule_measure_stack]' ':<' _b" := (update_STACK_ripas_granule_measure_stack _a _b) (at level 1).

Definition update_STACK_ipa_is_empty_stack(_a: STACK) _b :=
  mkSTACK (_a.(attest_setup_platform_token_stack)) (_a.(smc_psci_complete_stack)) (_a.(find_lock_two_granules_stack)) (_a.(attest_token_continue_write_state_stack)) (_a.(rmm_log_stack)) (_a.(attest_realm_token_create_stack)) (_a.(smc_rec_enter_stack)) (_a.(do_host_call_stack))
 (_a.(attest_rnd_prng_init_stack)) (_a.(plat_setup_stack)) (_a.(attest_token_encode_start_stack)) (_a.(smc_data_destroy_stack)) (_a.(xlat_get_llt_from_va_stack)) (_a.(smc_rec_create_stack)) (_a.(measurement_extend_sha512_stack)) (_a.(data_granule_measure_stack))
 (_a.(sort_granules_stack)) (_a.(measurement_extend_sha256_stack)) (_a.(realm_ipa_to_pa_stack)) (_a.(attest_realm_token_sign_stack)) (_a.(rmm_el3_ifc_get_platform_token_stack)) (_a.(attest_init_realm_attestation_key_stack)) (_a.(plat_cmn_setup_stack)) (_a.(complete_rsi_host_call_stack))
 (_a.(handle_realm_rsi_stack)) (_a.(smc_rtt_set_ripas_stack)) (_a.(rtt_walk_lock_unlock_stack)) (_a.(smc_rtt_destroy_stack)) (_a.(map_unmap_ns_stack)) (_a.(handle_rsi_attest_token_init_stack)) (_a.(realm_params_measure_stack)) (_a.(handle_rsi_ipa_state_get_stack))
 (_a.(realm_ipa_get_ripas_stack)) (_a.(smc_rtt_fold_stack)) (_a.(smc_rtt_create_stack)) (_a.(rsi_log_on_exit_stack)) (_a.(attest_cca_token_create_stack)) (_a.(rec_params_measure_stack)) (_a.(handle_ns_smc_stack)) (_a.(rmm_el3_ifc_get_realm_attest_key_stack))
 (_a.(handle_rsi_realm_config_stack)) (_a.(smc_rtt_init_ripas_stack)) (_a.(smc_rtt_read_entry_stack)) (_a.(handle_data_abort_stack)) (_a.(data_create_stack)) (_a.(smc_realm_create_stack)) (_a.(ripas_granule_measure_stack)) _b.
Notation "_a '.[ipa_is_empty_stack]' ':<' _b" := (update_STACK_ipa_is_empty_stack _a _b) (at level 1).

Definition update_stack_ptrs_attest_setup_platform_token_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs _b (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[attest_setup_platform_token_sp]' ':<' _b" := (update_stack_ptrs_attest_setup_platform_token_sp _a _b) (at level 1).

Definition update_stack_ptrs_smc_psci_complete_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) _b (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[smc_psci_complete_sp]' ':<' _b" := (update_stack_ptrs_smc_psci_complete_sp _a _b) (at level 1).

Definition update_stack_ptrs_attest_token_continue_write_state_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) _b (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[attest_token_continue_write_state_sp]' ':<' _b" := (update_stack_ptrs_attest_token_continue_write_state_sp _a _b) (at level 1).

Definition update_stack_ptrs_rmm_log_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) _b (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[rmm_log_sp]' ':<' _b" := (update_stack_ptrs_rmm_log_sp _a _b) (at level 1).

Definition update_stack_ptrs_attest_rnd_prng_init_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) _b (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[attest_rnd_prng_init_sp]' ':<' _b" := (update_stack_ptrs_attest_rnd_prng_init_sp _a _b) (at level 1).

Definition update_stack_ptrs_smc_data_destroy_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) _b (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[smc_data_destroy_sp]' ':<' _b" := (update_stack_ptrs_smc_data_destroy_sp _a _b) (at level 1).

Definition update_stack_ptrs_xlat_get_llt_from_va_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) _b (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[xlat_get_llt_from_va_sp]' ':<' _b" := (update_stack_ptrs_xlat_get_llt_from_va_sp _a _b) (at level 1).

Definition update_stack_ptrs_smc_rec_create_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) _b
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[smc_rec_create_sp]' ':<' _b" := (update_stack_ptrs_smc_rec_create_sp _a _b) (at level 1).

Definition update_stack_ptrs_attest_init_realm_attestation_key_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 _b (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[attest_init_realm_attestation_key_sp]' ':<' _b" := (update_stack_ptrs_attest_init_realm_attestation_key_sp _a _b) (at level 1).

Definition update_stack_ptrs_handle_realm_rsi_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) _b (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[handle_realm_rsi_sp]' ':<' _b" := (update_stack_ptrs_handle_realm_rsi_sp _a _b) (at level 1).

Definition update_stack_ptrs_smc_rtt_set_ripas_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) _b (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[smc_rtt_set_ripas_sp]' ':<' _b" := (update_stack_ptrs_smc_rtt_set_ripas_sp _a _b) (at level 1).

Definition update_stack_ptrs_smc_rtt_destroy_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) _b (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[smc_rtt_destroy_sp]' ':<' _b" := (update_stack_ptrs_smc_rtt_destroy_sp _a _b) (at level 1).

Definition update_stack_ptrs_map_unmap_ns_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) _b (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[map_unmap_ns_sp]' ':<' _b" := (update_stack_ptrs_map_unmap_ns_sp _a _b) (at level 1).

Definition update_stack_ptrs_handle_rsi_attest_token_init_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) _b (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[handle_rsi_attest_token_init_sp]' ':<' _b" := (update_stack_ptrs_handle_rsi_attest_token_init_sp _a _b) (at level 1).

Definition update_stack_ptrs_handle_rsi_ipa_state_get_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) _b (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[handle_rsi_ipa_state_get_sp]' ':<' _b" := (update_stack_ptrs_handle_rsi_ipa_state_get_sp _a _b) (at level 1).

Definition update_stack_ptrs_smc_rtt_fold_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) _b
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[smc_rtt_fold_sp]' ':<' _b" := (update_stack_ptrs_smc_rtt_fold_sp _a _b) (at level 1).

Definition update_stack_ptrs_smc_rtt_create_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 _b (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[smc_rtt_create_sp]' ':<' _b" := (update_stack_ptrs_smc_rtt_create_sp _a _b) (at level 1).

Definition update_stack_ptrs_attest_cca_token_create_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) _b (_a.(data_create_sp)) (_a.(smc_realm_create_sp)).
Notation "_a '.[attest_cca_token_create_sp]' ':<' _b" := (update_stack_ptrs_attest_cca_token_create_sp _a _b) (at level 1).

Definition update_stack_ptrs_data_create_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) _b (_a.(smc_realm_create_sp)).
Notation "_a '.[data_create_sp]' ':<' _b" := (update_stack_ptrs_data_create_sp _a _b) (at level 1).

Definition update_stack_ptrs_smc_realm_create_sp(_a: stack_ptrs) _b :=
  mkstack_ptrs (_a.(attest_setup_platform_token_sp)) (_a.(smc_psci_complete_sp)) (_a.(attest_token_continue_write_state_sp)) (_a.(rmm_log_sp)) (_a.(attest_rnd_prng_init_sp)) (_a.(smc_data_destroy_sp)) (_a.(xlat_get_llt_from_va_sp)) (_a.(smc_rec_create_sp))
 (_a.(attest_init_realm_attestation_key_sp)) (_a.(handle_realm_rsi_sp)) (_a.(smc_rtt_set_ripas_sp)) (_a.(smc_rtt_destroy_sp)) (_a.(map_unmap_ns_sp)) (_a.(handle_rsi_attest_token_init_sp)) (_a.(handle_rsi_ipa_state_get_sp)) (_a.(smc_rtt_fold_sp))
 (_a.(smc_rtt_create_sp)) (_a.(attest_cca_token_create_sp)) (_a.(data_create_sp)) _b.
Notation "_a '.[smc_realm_create_sp]' ':<' _b" := (update_stack_ptrs_smc_realm_create_sp _a _b) (at level 1).

Definition update_RData_log(_a: RData) _b :=
  mkRData _b (_a.(oracle)) (_a.(repl)) (_a.(share)) (_a.(priv)) (_a.(stack)) (_a.(func_sp)).
Notation "_a '.[log]' ':<' _b" := (update_RData_log _a _b) (at level 1).

Definition update_RData_oracle(_a: RData) _b :=
  mkRData (_a.(log)) _b (_a.(repl)) (_a.(share)) (_a.(priv)) (_a.(stack)) (_a.(func_sp)).
Notation "_a '.[oracle]' ':<' _b" := (update_RData_oracle _a _b) (at level 1).

Definition update_RData_repl(_a: RData) _b :=
  mkRData (_a.(log)) (_a.(oracle)) _b (_a.(share)) (_a.(priv)) (_a.(stack)) (_a.(func_sp)).
Notation "_a '.[repl]' ':<' _b" := (update_RData_repl _a _b) (at level 1).

Definition update_RData_share(_a: RData) _b :=
  mkRData (_a.(log)) (_a.(oracle)) (_a.(repl)) _b (_a.(priv)) (_a.(stack)) (_a.(func_sp)).
Notation "_a '.[share]' ':<' _b" := (update_RData_share _a _b) (at level 1).

Definition update_RData_priv(_a: RData) _b :=
  mkRData (_a.(log)) (_a.(oracle)) (_a.(repl)) (_a.(share)) _b (_a.(stack)) (_a.(func_sp)).
Notation "_a '.[priv]' ':<' _b" := (update_RData_priv _a _b) (at level 1).

Definition update_RData_stack(_a: RData) _b :=
  mkRData (_a.(log)) (_a.(oracle)) (_a.(repl)) (_a.(share)) (_a.(priv)) _b (_a.(func_sp)).
Notation "_a '.[stack]' ':<' _b" := (update_RData_stack _a _b) (at level 1).

Definition update_RData_func_sp(_a: RData) _b :=
  mkRData (_a.(log)) (_a.(oracle)) (_a.(repl)) (_a.(share)) (_a.(priv)) (_a.(stack)) _b.
Notation "_a '.[func_sp]' ':<' _b" := (update_RData_func_sp _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_gicstate_e_ich_ap0r_el2(_a: s_sysreg_state) _b :=
  update_s_sysreg_state_e_sysreg_gicstate _a ((_a.(e_sysreg_gicstate)).[e_ich_ap0r_el2] :< _b).
Notation "_a '.[e_sysreg_gicstate].[e_ich_ap0r_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_gicstate_e_ich_ap0r_el2 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_gicstate_e_ich_ap1r_el2(_a: s_sysreg_state) _b :=
  update_s_sysreg_state_e_sysreg_gicstate _a ((_a.(e_sysreg_gicstate)).[e_ich_ap1r_el2] :< _b).
Notation "_a '.[e_sysreg_gicstate].[e_ich_ap1r_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_gicstate_e_ich_ap1r_el2 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_gicstate_e_ich_vmcr_el2(_a: s_sysreg_state) _b :=
  update_s_sysreg_state_e_sysreg_gicstate _a ((_a.(e_sysreg_gicstate)).[e_ich_vmcr_el2] :< _b).
Notation "_a '.[e_sysreg_gicstate].[e_ich_vmcr_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_gicstate_e_ich_vmcr_el2 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_gicstate_e_ich_hcr_el2(_a: s_sysreg_state) _b :=
  update_s_sysreg_state_e_sysreg_gicstate _a ((_a.(e_sysreg_gicstate)).[e_ich_hcr_el2] :< _b).
Notation "_a '.[e_sysreg_gicstate].[e_ich_hcr_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_gicstate_e_ich_hcr_el2 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_gicstate_e_ich_lr_el2(_a: s_sysreg_state) _b :=
  update_s_sysreg_state_e_sysreg_gicstate _a ((_a.(e_sysreg_gicstate)).[e_ich_lr_el2] :< _b).
Notation "_a '.[e_sysreg_gicstate].[e_ich_lr_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_gicstate_e_ich_lr_el2 _a _b) (at level 1).

Definition update_s_sysreg_state_e_sysreg_gicstate_e_ich_misr_el2(_a: s_sysreg_state) _b :=
  update_s_sysreg_state_e_sysreg_gicstate _a ((_a.(e_sysreg_gicstate)).[e_ich_misr_el2] :< _b).
Notation "_a '.[e_sysreg_gicstate].[e_ich_misr_el2]' ':<' _b" := (update_s_sysreg_state_e_sysreg_gicstate_e_ich_misr_el2 _a _b) (at level 1).

Definition update_s_rec_aux_data_e_rec_simd_e_simd(_a: s_rec_aux_data) _b :=
  update_s_rec_aux_data_e_rec_simd _a ((_a.(e_rec_simd)).[e_simd] :< _b).
Notation "_a '.[e_rec_simd].[e_simd]' ':<' _b" := (update_s_rec_aux_data_e_rec_simd_e_simd _a _b) (at level 1).

Definition update_s_rec_aux_data_e_rec_simd_e_simd_allowed(_a: s_rec_aux_data) _b :=
  update_s_rec_aux_data_e_rec_simd _a ((_a.(e_rec_simd)).[e_simd_allowed] :< _b).
Notation "_a '.[e_rec_simd].[e_simd_allowed]' ':<' _b" := (update_s_rec_aux_data_e_rec_simd_e_simd_allowed _a _b) (at level 1).

Definition update_s_rec_aux_data_e_rec_simd_e_init_done(_a: s_rec_aux_data) _b :=
  update_s_rec_aux_data_e_rec_simd _a ((_a.(e_rec_simd)).[e_init_done] :< _b).
Notation "_a '.[e_rec_simd].[e_init_done]' ':<' _b" := (update_s_rec_aux_data_e_rec_simd_e_init_done _a _b) (at level 1).

Definition update_s_alloc_info_e__ctx_e_buf(_a: s_alloc_info) _b :=
  update_s_alloc_info_e__ctx _a ((_a.(e__ctx)).[e_buf] :< _b).
Notation "_a '.[e__ctx].[e_buf]' ':<' _b" := (update_s_alloc_info_e__ctx_e_buf _a _b) (at level 1).

Definition update_s_alloc_info_e__ctx_e__len(_a: s_alloc_info) _b :=
  update_s_alloc_info_e__ctx _a ((_a.(e__ctx)).[e__len] :< _b).
Notation "_a '.[e__ctx].[e__len]' ':<' _b" := (update_s_alloc_info_e__ctx_e__len _a _b) (at level 1).

Definition update_s_alloc_info_e__ctx_e_first(_a: s_alloc_info) _b :=
  update_s_alloc_info_e__ctx _a ((_a.(e__ctx)).[e_first] :< _b).
Notation "_a '.[e__ctx].[e_first]' ':<' _b" := (update_s_alloc_info_e__ctx_e_first _a _b) (at level 1).

Definition update_s_alloc_info_e__ctx_e_first_free(_a: s_alloc_info) _b :=
  update_s_alloc_info_e__ctx _a ((_a.(e__ctx)).[e_first_free] :< _b).
Notation "_a '.[e__ctx].[e_first_free]' ':<' _b" := (update_s_alloc_info_e__ctx_e_first_free _a _b) (at level 1).

Definition update_s_alloc_info_e__ctx_e_verify(_a: s_alloc_info) _b :=
  update_s_alloc_info_e__ctx _a ((_a.(e__ctx)).[e_verify] :< _b).
Notation "_a '.[e__ctx].[e_verify]' ':<' _b" := (update_s_alloc_info_e__ctx_e_verify _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_sp_el0(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_sp_el0] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_sp_el0]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_sp_el0 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_sp_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_sp_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_sp_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_sp_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_elr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_elr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_elr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_elr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_spsr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_spsr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_spsr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_spsr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_pmcr_el0(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_pmcr_el0] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_pmcr_el0]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_pmcr_el0 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_tpidrro_el0(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_tpidrro_el0] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_tpidrro_el0]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_tpidrro_el0 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_tpidr_el0(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_tpidr_el0] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_tpidr_el0]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_tpidr_el0 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_csselr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_csselr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_csselr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_csselr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_sctlr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_sctlr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_sctlr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_sctlr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_actlr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_actlr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_actlr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_actlr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_cpacr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_cpacr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_cpacr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_cpacr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_zcr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_zcr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_zcr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_zcr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_ttbr0_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_ttbr0_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_ttbr0_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_ttbr0_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_ttbr1_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_ttbr1_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_ttbr1_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_ttbr1_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_tcr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_tcr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_tcr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_tcr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_esr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_esr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_esr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_esr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_afsr0_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_afsr0_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_afsr0_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_afsr0_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_afsr1_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_afsr1_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_afsr1_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_afsr1_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_far_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_far_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_far_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_far_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_mair_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_mair_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_mair_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_mair_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_vbar_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_vbar_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_vbar_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_vbar_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_contextidr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_contextidr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_contextidr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_contextidr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_tpidr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_tpidr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_tpidr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_tpidr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_amair_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_amair_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_amair_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_amair_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_cntkctl_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_cntkctl_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_cntkctl_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_cntkctl_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_par_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_par_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_par_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_par_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_mdscr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_mdscr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_mdscr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_mdscr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_mdccint_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_mdccint_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_mdccint_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_mdccint_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_disr_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_disr_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_disr_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_disr_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_mpam0_el1(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_mpam0_el1] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_mpam0_el1]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_mpam0_el1 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_cnthctl_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_cnthctl_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_cnthctl_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_cnthctl_el2 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_cntvoff_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_cntvoff_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_cntvoff_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_cntvoff_el2 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_cntpoff_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_cntpoff_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_cntpoff_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_cntpoff_el2 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_cntp_ctl_el0(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_cntp_ctl_el0] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_cntp_ctl_el0]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_cntp_ctl_el0 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_cntp_cval_el0(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_cntp_cval_el0] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_cntp_cval_el0]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_cntp_cval_el0 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_cntv_ctl_el0(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_cntv_ctl_el0] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_cntv_ctl_el0]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_cntv_ctl_el0 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_cntv_cval_el0(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_cntv_cval_el0] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_cntv_cval_el0]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_cntv_cval_el0 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_gicstate(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_gicstate] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_gicstate]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_gicstate _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_ap0r_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(e_sysregs).(e_sysreg_gicstate)).[e_ich_ap0r_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_gicstate].[e_ich_ap0r_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_ap0r_el2 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_ap1r_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(e_sysregs).(e_sysreg_gicstate)).[e_ich_ap1r_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_gicstate].[e_ich_ap1r_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_ap1r_el2 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_vmcr_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(e_sysregs).(e_sysreg_gicstate)).[e_ich_vmcr_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_gicstate].[e_ich_vmcr_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_vmcr_el2 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_hcr_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(e_sysregs).(e_sysreg_gicstate)).[e_ich_hcr_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_gicstate].[e_ich_hcr_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_hcr_el2 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_lr_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(e_sysregs).(e_sysreg_gicstate)).[e_ich_lr_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_gicstate].[e_ich_lr_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_lr_el2 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_misr_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(e_sysregs).(e_sysreg_gicstate)).[e_ich_misr_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_gicstate].[e_ich_misr_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_gicstate_e_ich_misr_el2 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_vmpidr_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_vmpidr_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_vmpidr_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_vmpidr_el2 _a _b) (at level 1).

Definition update_s_rec_e_sysregs_e_sysreg_hcr_el2(_a: s_rec) _b :=
  update_s_rec_e_sysregs _a ((_a.(e_sysregs)).[e_sysreg_hcr_el2] :< _b).
Notation "_a '.[e_sysregs].[e_sysreg_hcr_el2]' ':<' _b" := (update_s_rec_e_sysregs_e_sysreg_hcr_el2 _a _b) (at level 1).

Definition update_s_rec_e_common_sysregs_e_common_vttbr_el2(_a: s_rec) _b :=
  update_s_rec_e_common_sysregs _a ((_a.(e_common_sysregs)).[e_common_vttbr_el2] :< _b).
Notation "_a '.[e_common_sysregs].[e_common_vttbr_el2]' ':<' _b" := (update_s_rec_e_common_sysregs_e_common_vttbr_el2 _a _b) (at level 1).

Definition update_s_rec_e_common_sysregs_e_common_vtcr_el2(_a: s_rec) _b :=
  update_s_rec_e_common_sysregs _a ((_a.(e_common_sysregs)).[e_common_vtcr_el2] :< _b).
Notation "_a '.[e_common_sysregs].[e_common_vtcr_el2]' ':<' _b" := (update_s_rec_e_common_sysregs_e_common_vtcr_el2 _a _b) (at level 1).

Definition update_s_rec_e_common_sysregs_e_common_hcr_el2(_a: s_rec) _b :=
  update_s_rec_e_common_sysregs _a ((_a.(e_common_sysregs)).[e_common_hcr_el2] :< _b).
Notation "_a '.[e_common_sysregs].[e_common_hcr_el2]' ':<' _b" := (update_s_rec_e_common_sysregs_e_common_hcr_el2 _a _b) (at level 1).

Definition update_s_rec_e_common_sysregs_e_common_mdcr_el2(_a: s_rec) _b :=
  update_s_rec_e_common_sysregs _a ((_a.(e_common_sysregs)).[e_common_mdcr_el2] :< _b).
Notation "_a '.[e_common_sysregs].[e_common_mdcr_el2]' ':<' _b" := (update_s_rec_e_common_sysregs_e_common_mdcr_el2 _a _b) (at level 1).

Definition update_s_rec_e_set_ripas_e_start(_a: s_rec) _b :=
  update_s_rec_e_set_ripas _a ((_a.(e_set_ripas)).[e_start] :< _b).
Notation "_a '.[e_set_ripas].[e_start]' ':<' _b" := (update_s_rec_e_set_ripas_e_start _a _b) (at level 1).

Definition update_s_rec_e_set_ripas_e_end(_a: s_rec) _b :=
  update_s_rec_e_set_ripas _a ((_a.(e_set_ripas)).[e_end] :< _b).
Notation "_a '.[e_set_ripas].[e_end]' ':<' _b" := (update_s_rec_e_set_ripas_e_end _a _b) (at level 1).

Definition update_s_rec_e_set_ripas_e_addr(_a: s_rec) _b :=
  update_s_rec_e_set_ripas _a ((_a.(e_set_ripas)).[e_addr] :< _b).
Notation "_a '.[e_set_ripas].[e_addr]' ':<' _b" := (update_s_rec_e_set_ripas_e_addr _a _b) (at level 1).

Definition update_s_rec_e_set_ripas_e_ripas(_a: s_rec) _b :=
  update_s_rec_e_set_ripas _a ((_a.(e_set_ripas)).[e_ripas] :< _b).
Notation "_a '.[e_set_ripas].[e_ripas]' ':<' _b" := (update_s_rec_e_set_ripas_e_ripas _a _b) (at level 1).

Definition update_s_rec_e_realm_info_e_ipa_bits(_a: s_rec) _b :=
  update_s_rec_e_realm_info _a ((_a.(e_realm_info)).[e_ipa_bits] :< _b).
Notation "_a '.[e_realm_info].[e_ipa_bits]' ':<' _b" := (update_s_rec_e_realm_info_e_ipa_bits _a _b) (at level 1).

Definition update_s_rec_e_realm_info_e_s2_starting_level(_a: s_rec) _b :=
  update_s_rec_e_realm_info _a ((_a.(e_realm_info)).[e_s2_starting_level] :< _b).
Notation "_a '.[e_realm_info].[e_s2_starting_level]' ':<' _b" := (update_s_rec_e_realm_info_e_s2_starting_level _a _b) (at level 1).

Definition update_s_rec_e_realm_info_e_g_rtt(_a: s_rec) _b :=
  update_s_rec_e_realm_info _a ((_a.(e_realm_info)).[e_g_rtt] :< _b).
Notation "_a '.[e_realm_info].[e_g_rtt]' ':<' _b" := (update_s_rec_e_realm_info_e_g_rtt _a _b) (at level 1).

Definition update_s_rec_e_realm_info_e_g_rd(_a: s_rec) _b :=
  update_s_rec_e_realm_info _a ((_a.(e_realm_info)).[e_g_rd] :< _b).
Notation "_a '.[e_realm_info].[e_g_rd]' ':<' _b" := (update_s_rec_e_realm_info_e_g_rd _a _b) (at level 1).

Definition update_s_rec_e_realm_info_e_pmu_enabled(_a: s_rec) _b :=
  update_s_rec_e_realm_info _a ((_a.(e_realm_info)).[e_pmu_enabled] :< _b).
Notation "_a '.[e_realm_info].[e_pmu_enabled]' ':<' _b" := (update_s_rec_e_realm_info_e_pmu_enabled _a _b) (at level 1).

Definition update_s_rec_e_realm_info_e_pmu_num_cnts(_a: s_rec) _b :=
  update_s_rec_e_realm_info _a ((_a.(e_realm_info)).[e_pmu_num_cnts] :< _b).
Notation "_a '.[e_realm_info].[e_pmu_num_cnts]' ':<' _b" := (update_s_rec_e_realm_info_e_pmu_num_cnts _a _b) (at level 1).

Definition update_s_rec_e_realm_info_e_sve_enabled(_a: s_rec) _b :=
  update_s_rec_e_realm_info _a ((_a.(e_realm_info)).[e_sve_enabled] :< _b).
Notation "_a '.[e_realm_info].[e_sve_enabled]' ':<' _b" := (update_s_rec_e_realm_info_e_sve_enabled _a _b) (at level 1).

Definition update_s_rec_e_realm_info_e_sve_vq(_a: s_rec) _b :=
  update_s_rec_e_realm_info _a ((_a.(e_realm_info)).[e_sve_vq] :< _b).
Notation "_a '.[e_realm_info].[e_sve_vq]' ':<' _b" := (update_s_rec_e_realm_info_e_sve_vq _a _b) (at level 1).

Definition update_s_rec_e_last_run_info_e_esr(_a: s_rec) _b :=
  update_s_rec_e_last_run_info _a ((_a.(e_last_run_info)).[e_esr] :< _b).
Notation "_a '.[e_last_run_info].[e_esr]' ':<' _b" := (update_s_rec_e_last_run_info_e_esr _a _b) (at level 1).

Definition update_s_rec_e_last_run_info_e_hpfar(_a: s_rec) _b :=
  update_s_rec_e_last_run_info _a ((_a.(e_last_run_info)).[e_hpfar] :< _b).
Notation "_a '.[e_last_run_info].[e_hpfar]' ':<' _b" := (update_s_rec_e_last_run_info_e_hpfar _a _b) (at level 1).

Definition update_s_rec_e_last_run_info_e_far(_a: s_rec) _b :=
  update_s_rec_e_last_run_info _a ((_a.(e_last_run_info)).[e_far] :< _b).
Notation "_a '.[e_last_run_info].[e_far]' ':<' _b" := (update_s_rec_e_last_run_info_e_far _a _b) (at level 1).

Definition update_s_rec_e_psci_info_e_pending(_a: s_rec) _b :=
  update_s_rec_e_psci_info _a ((_a.(e_psci_info)).[e_pending] :< _b).
Notation "_a '.[e_psci_info].[e_pending]' ':<' _b" := (update_s_rec_e_psci_info_e_pending _a _b) (at level 1).

Definition update_s_rec_e_aux_data_e_attest_heap_buf(_a: s_rec) _b :=
  update_s_rec_e_aux_data _a ((_a.(e_aux_data)).[e_attest_heap_buf] :< _b).
Notation "_a '.[e_aux_data].[e_attest_heap_buf]' ':<' _b" := (update_s_rec_e_aux_data_e_attest_heap_buf _a _b) (at level 1).

Definition update_s_rec_e_aux_data_e_pmu(_a: s_rec) _b :=
  update_s_rec_e_aux_data _a ((_a.(e_aux_data)).[e_pmu] :< _b).
Notation "_a '.[e_aux_data].[e_pmu]' ':<' _b" := (update_s_rec_e_aux_data_e_pmu _a _b) (at level 1).

Definition update_s_rec_e_aux_data_e_rec_simd(_a: s_rec) _b :=
  update_s_rec_e_aux_data _a ((_a.(e_aux_data)).[e_rec_simd] :< _b).
Notation "_a '.[e_aux_data].[e_rec_simd]' ':<' _b" := (update_s_rec_e_aux_data_e_rec_simd _a _b) (at level 1).

Definition update_s_rec_e_aux_data_e_rec_simd_e_simd(_a: s_rec) _b :=
  update_s_rec_e_aux_data_e_rec_simd _a ((_a.(e_aux_data).(e_rec_simd)).[e_simd] :< _b).
Notation "_a '.[e_aux_data].[e_rec_simd].[e_simd]' ':<' _b" := (update_s_rec_e_aux_data_e_rec_simd_e_simd _a _b) (at level 1).

Definition update_s_rec_e_aux_data_e_rec_simd_e_simd_allowed(_a: s_rec) _b :=
  update_s_rec_e_aux_data_e_rec_simd _a ((_a.(e_aux_data).(e_rec_simd)).[e_simd_allowed] :< _b).
Notation "_a '.[e_aux_data].[e_rec_simd].[e_simd_allowed]' ':<' _b" := (update_s_rec_e_aux_data_e_rec_simd_e_simd_allowed _a _b) (at level 1).

Definition update_s_rec_e_aux_data_e_rec_simd_e_init_done(_a: s_rec) _b :=
  update_s_rec_e_aux_data_e_rec_simd _a ((_a.(e_aux_data).(e_rec_simd)).[e_init_done] :< _b).
Notation "_a '.[e_aux_data].[e_rec_simd].[e_init_done]' ':<' _b" := (update_s_rec_e_aux_data_e_rec_simd_e_init_done _a _b) (at level 1).

Definition update_s_rec_e_alloc_info_e__ctx(_a: s_rec) _b :=
  update_s_rec_e_alloc_info _a ((_a.(e_alloc_info)).[e__ctx] :< _b).
Notation "_a '.[e_alloc_info].[e__ctx]' ':<' _b" := (update_s_rec_e_alloc_info_e__ctx _a _b) (at level 1).

Definition update_s_rec_e_alloc_info_e__ctx_e_buf(_a: s_rec) _b :=
  update_s_rec_e_alloc_info_e__ctx _a ((_a.(e_alloc_info).(e__ctx)).[e_buf] :< _b).
Notation "_a '.[e_alloc_info].[e__ctx].[e_buf]' ':<' _b" := (update_s_rec_e_alloc_info_e__ctx_e_buf _a _b) (at level 1).

Definition update_s_rec_e_alloc_info_e__ctx_e__len(_a: s_rec) _b :=
  update_s_rec_e_alloc_info_e__ctx _a ((_a.(e_alloc_info).(e__ctx)).[e__len] :< _b).
Notation "_a '.[e_alloc_info].[e__ctx].[e__len]' ':<' _b" := (update_s_rec_e_alloc_info_e__ctx_e__len _a _b) (at level 1).

Definition update_s_rec_e_alloc_info_e__ctx_e_first(_a: s_rec) _b :=
  update_s_rec_e_alloc_info_e__ctx _a ((_a.(e_alloc_info).(e__ctx)).[e_first] :< _b).
Notation "_a '.[e_alloc_info].[e__ctx].[e_first]' ':<' _b" := (update_s_rec_e_alloc_info_e__ctx_e_first _a _b) (at level 1).

Definition update_s_rec_e_alloc_info_e__ctx_e_first_free(_a: s_rec) _b :=
  update_s_rec_e_alloc_info_e__ctx _a ((_a.(e_alloc_info).(e__ctx)).[e_first_free] :< _b).
Notation "_a '.[e_alloc_info].[e__ctx].[e_first_free]' ':<' _b" := (update_s_rec_e_alloc_info_e__ctx_e_first_free _a _b) (at level 1).

Definition update_s_rec_e_alloc_info_e__ctx_e_verify(_a: s_rec) _b :=
  update_s_rec_e_alloc_info_e__ctx _a ((_a.(e_alloc_info).(e__ctx)).[e_verify] :< _b).
Notation "_a '.[e_alloc_info].[e__ctx].[e_verify]' ':<' _b" := (update_s_rec_e_alloc_info_e__ctx_e_verify _a _b) (at level 1).

Definition update_s_rec_e_alloc_info_e_ctx_initialised(_a: s_rec) _b :=
  update_s_rec_e_alloc_info _a ((_a.(e_alloc_info)).[e_ctx_initialised] :< _b).
Notation "_a '.[e_alloc_info].[e_ctx_initialised]' ':<' _b" := (update_s_rec_e_alloc_info_e_ctx_initialised _a _b) (at level 1).

Definition update_s_rec_e_serror_info_e_vsesr_el2(_a: s_rec) _b :=
  update_s_rec_e_serror_info _a ((_a.(e_serror_info)).[e_vsesr_el2] :< _b).
Notation "_a '.[e_serror_info].[e_vsesr_el2]' ':<' _b" := (update_s_rec_e_serror_info_e_vsesr_el2 _a _b) (at level 1).

Definition update_s_rec_e_serror_info_e_inject(_a: s_rec) _b :=
  update_s_rec_e_serror_info _a ((_a.(e_serror_info)).[e_inject] :< _b).
Notation "_a '.[e_serror_info].[e_inject]' ':<' _b" := (update_s_rec_e_serror_info_e_inject _a _b) (at level 1).

Definition update_u_anon_6_e_fpu_e_q(_a: u_anon_6) _b :=
  update_u_anon_6_e_fpu _a ((_a.(e_fpu)).[e_q] :< _b).
Notation "_a '.[e_fpu].[e_q]' ':<' _b" := (update_u_anon_6_e_fpu_e_q _a _b) (at level 1).

Definition update_u_anon_6_e_fpu_e_fpsr(_a: u_anon_6) _b :=
  update_u_anon_6_e_fpu _a ((_a.(e_fpu)).[e_fpsr] :< _b).
Notation "_a '.[e_fpu].[e_fpsr]' ':<' _b" := (update_u_anon_6_e_fpu_e_fpsr _a _b) (at level 1).

Definition update_u_anon_6_e_fpu_e_fpcr(_a: u_anon_6) _b :=
  update_u_anon_6_e_fpu _a ((_a.(e_fpu)).[e_fpcr] :< _b).
Notation "_a '.[e_fpu].[e_fpcr]' ':<' _b" := (update_u_anon_6_e_fpu_e_fpcr _a _b) (at level 1).

Definition update_s_simd_state_e_t_e_fpu(_a: s_simd_state) _b :=
  update_s_simd_state_e_t _a ((_a.(e_t)).[e_fpu] :< _b).
Notation "_a '.[e_t].[e_fpu]' ':<' _b" := (update_s_simd_state_e_t_e_fpu _a _b) (at level 1).

Definition update_s_simd_state_e_t_e_fpu_e_q(_a: s_simd_state) _b :=
  update_s_simd_state_e_t_e_fpu _a ((_a.(e_t).(e_fpu)).[e_q] :< _b).
Notation "_a '.[e_t].[e_fpu].[e_q]' ':<' _b" := (update_s_simd_state_e_t_e_fpu_e_q _a _b) (at level 1).

Definition update_s_simd_state_e_t_e_fpu_e_fpsr(_a: s_simd_state) _b :=
  update_s_simd_state_e_t_e_fpu _a ((_a.(e_t).(e_fpu)).[e_fpsr] :< _b).
Notation "_a '.[e_t].[e_fpu].[e_fpsr]' ':<' _b" := (update_s_simd_state_e_t_e_fpu_e_fpsr _a _b) (at level 1).

Definition update_s_simd_state_e_t_e_fpu_e_fpcr(_a: s_simd_state) _b :=
  update_s_simd_state_e_t_e_fpu _a ((_a.(e_t).(e_fpu)).[e_fpcr] :< _b).
Notation "_a '.[e_t].[e_fpu].[e_fpcr]' ':<' _b" := (update_s_simd_state_e_t_e_fpu_e_fpcr _a _b) (at level 1).

Definition update_s_simd_state_e_t_e_padding0(_a: s_simd_state) _b :=
  update_s_simd_state_e_t _a ((_a.(e_t)).[e_padding0] :< _b).
Notation "_a '.[e_t].[e_padding0]' ':<' _b" := (update_s_simd_state_e_t_e_padding0 _a _b) (at level 1).

Definition update_s_ns_simd_state_e_ns_simd_e_t(_a: s_ns_simd_state) _b :=
  update_s_ns_simd_state_e_ns_simd _a ((_a.(e_ns_simd)).[e_t] :< _b).
Notation "_a '.[e_ns_simd].[e_t]' ':<' _b" := (update_s_ns_simd_state_e_ns_simd_e_t _a _b) (at level 1).

Definition update_s_ns_simd_state_e_ns_simd_e_t_e_fpu(_a: s_ns_simd_state) _b :=
  update_s_ns_simd_state_e_ns_simd_e_t _a ((_a.(e_ns_simd).(e_t)).[e_fpu] :< _b).
Notation "_a '.[e_ns_simd].[e_t].[e_fpu]' ':<' _b" := (update_s_ns_simd_state_e_ns_simd_e_t_e_fpu _a _b) (at level 1).

Definition update_s_ns_simd_state_e_ns_simd_e_t_e_fpu_e_q(_a: s_ns_simd_state) _b :=
  update_s_ns_simd_state_e_ns_simd_e_t_e_fpu _a ((_a.(e_ns_simd).(e_t).(e_fpu)).[e_q] :< _b).
Notation "_a '.[e_ns_simd].[e_t].[e_fpu].[e_q]' ':<' _b" := (update_s_ns_simd_state_e_ns_simd_e_t_e_fpu_e_q _a _b) (at level 1).

Definition update_s_ns_simd_state_e_ns_simd_e_t_e_fpu_e_fpsr(_a: s_ns_simd_state) _b :=
  update_s_ns_simd_state_e_ns_simd_e_t_e_fpu _a ((_a.(e_ns_simd).(e_t).(e_fpu)).[e_fpsr] :< _b).
Notation "_a '.[e_ns_simd].[e_t].[e_fpu].[e_fpsr]' ':<' _b" := (update_s_ns_simd_state_e_ns_simd_e_t_e_fpu_e_fpsr _a _b) (at level 1).

Definition update_s_ns_simd_state_e_ns_simd_e_t_e_fpu_e_fpcr(_a: s_ns_simd_state) _b :=
  update_s_ns_simd_state_e_ns_simd_e_t_e_fpu _a ((_a.(e_ns_simd).(e_t).(e_fpu)).[e_fpcr] :< _b).
Notation "_a '.[e_ns_simd].[e_t].[e_fpu].[e_fpcr]' ':<' _b" := (update_s_ns_simd_state_e_ns_simd_e_t_e_fpu_e_fpcr _a _b) (at level 1).

Definition update_s_ns_simd_state_e_ns_simd_e_t_e_padding0(_a: s_ns_simd_state) _b :=
  update_s_ns_simd_state_e_ns_simd_e_t _a ((_a.(e_ns_simd).(e_t)).[e_padding0] :< _b).
Notation "_a '.[e_ns_simd].[e_t].[e_padding0]' ':<' _b" := (update_s_ns_simd_state_e_ns_simd_e_t_e_padding0 _a _b) (at level 1).

Definition update_s_ns_simd_state_e_ns_simd_e_simd_type(_a: s_ns_simd_state) _b :=
  update_s_ns_simd_state_e_ns_simd _a ((_a.(e_ns_simd)).[e_simd_type] :< _b).
Notation "_a '.[e_ns_simd].[e_simd_type]' ':<' _b" := (update_s_ns_simd_state_e_ns_simd_e_simd_type _a _b) (at level 1).

Definition update_u_anon_11_154_e__0_e_num_aux(_a: u_anon_11_154) _b :=
  update_u_anon_11_154_e__0 _a ((_a.(e__0)).[e_num_aux] :< _b).
Notation "_a '.[e__0].[e_num_aux]' ':<' _b" := (update_u_anon_11_154_e__0_e_num_aux _a _b) (at level 1).

Definition update_u_anon_11_154_e__0_e_aux(_a: u_anon_11_154) _b :=
  update_u_anon_11_154_e__0 _a ((_a.(e__0)).[e_aux] :< _b).
Notation "_a '.[e__0].[e_aux]' ':<' _b" := (update_u_anon_11_154_e__0_e_aux _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_0_e_features_0(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_0 _a ((_a.(e_rmi_rec_params_0)).[e_features_0] :< _b).
Notation "_a '.[e_rmi_rec_params_0].[e_features_0]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_0_e_features_0 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_0_e_rec_params_padding0(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_0 _a ((_a.(e_rmi_rec_params_0)).[e_rec_params_padding0] :< _b).
Notation "_a '.[e_rmi_rec_params_0].[e_rec_params_padding0]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_0_e_rec_params_padding0 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_1_e_features_0(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_1 _a ((_a.(e_rmi_rec_params_1)).[e_features_0] :< _b).
Notation "_a '.[e_rmi_rec_params_1].[e_features_0]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_1_e_features_0 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_1_e_rec_params_padding0(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_1 _a ((_a.(e_rmi_rec_params_1)).[e_rec_params_padding0] :< _b).
Notation "_a '.[e_rmi_rec_params_1].[e_rec_params_padding0]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_1_e_rec_params_padding0 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_2_e_features_0(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_2 _a ((_a.(e_rmi_rec_params_2)).[e_features_0] :< _b).
Notation "_a '.[e_rmi_rec_params_2].[e_features_0]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_2_e_features_0 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_2_e_rec_params_padding0(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_2 _a ((_a.(e_rmi_rec_params_2)).[e_rec_params_padding0] :< _b).
Notation "_a '.[e_rmi_rec_params_2].[e_rec_params_padding0]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_2_e_rec_params_padding0 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_3_e_gprs(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_3 _a ((_a.(e_rmi_rec_params_3)).[e_gprs] :< _b).
Notation "_a '.[e_rmi_rec_params_3].[e_gprs]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_3_e_gprs _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_3_e__rec_params_padding0(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_3 _a ((_a.(e_rmi_rec_params_3)).[e__rec_params_padding0] :< _b).
Notation "_a '.[e_rmi_rec_params_3].[e__rec_params_padding0]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_3_e__rec_params_padding0 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_4_e__0(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_4 _a ((_a.(e_rmi_rec_params_4)).[e__0] :< _b).
Notation "_a '.[e_rmi_rec_params_4].[e__0]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_4_e__0 _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_4_e__0_e_num_aux(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_4_e__0 _a ((_a.(e_rmi_rec_params_4).(e__0)).[e_num_aux] :< _b).
Notation "_a '.[e_rmi_rec_params_4].[e__0].[e_num_aux]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_4_e__0_e_num_aux _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_4_e__0_e_aux(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_4_e__0 _a ((_a.(e_rmi_rec_params_4).(e__0)).[e_aux] :< _b).
Notation "_a '.[e_rmi_rec_params_4].[e__0].[e_aux]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_4_e__0_e_aux _a _b) (at level 1).

Definition update_s_rmi_rec_params_e_rmi_rec_params_4_e___rec_params_padding0(_a: s_rmi_rec_params) _b :=
  update_s_rmi_rec_params_e_rmi_rec_params_4 _a ((_a.(e_rmi_rec_params_4)).[e___rec_params_padding0] :< _b).
Notation "_a '.[e_rmi_rec_params_4].[e___rec_params_padding0]' ':<' _b" := (update_s_rmi_rec_params_e_rmi_rec_params_4_e___rec_params_padding0 _a _b) (at level 1).

Definition update_s_rd_e_rd_s2_ctx_e_rls2ctx_ipa_bits(_a: s_rd) _b :=
  update_s_rd_e_rd_s2_ctx _a ((_a.(e_rd_s2_ctx)).[e_rls2ctx_ipa_bits] :< _b).
Notation "_a '.[e_rd_s2_ctx].[e_rls2ctx_ipa_bits]' ':<' _b" := (update_s_rd_e_rd_s2_ctx_e_rls2ctx_ipa_bits _a _b) (at level 1).

Definition update_s_rd_e_rd_s2_ctx_e_rls2ctx_s2_starting_level(_a: s_rd) _b :=
  update_s_rd_e_rd_s2_ctx _a ((_a.(e_rd_s2_ctx)).[e_rls2ctx_s2_starting_level] :< _b).
Notation "_a '.[e_rd_s2_ctx].[e_rls2ctx_s2_starting_level]' ':<' _b" := (update_s_rd_e_rd_s2_ctx_e_rls2ctx_s2_starting_level _a _b) (at level 1).

Definition update_s_rd_e_rd_s2_ctx_e_rls2ctx_num_root_rtts(_a: s_rd) _b :=
  update_s_rd_e_rd_s2_ctx _a ((_a.(e_rd_s2_ctx)).[e_rls2ctx_num_root_rtts] :< _b).
Notation "_a '.[e_rd_s2_ctx].[e_rls2ctx_num_root_rtts]' ':<' _b" := (update_s_rd_e_rd_s2_ctx_e_rls2ctx_num_root_rtts _a _b) (at level 1).

Definition update_s_rd_e_rd_s2_ctx_e_rls2ctx_g_rtt(_a: s_rd) _b :=
  update_s_rd_e_rd_s2_ctx _a ((_a.(e_rd_s2_ctx)).[e_rls2ctx_g_rtt] :< _b).
Notation "_a '.[e_rd_s2_ctx].[e_rls2ctx_g_rtt]' ':<' _b" := (update_s_rd_e_rd_s2_ctx_e_rls2ctx_g_rtt _a _b) (at level 1).

Definition update_s_rd_e_rd_s2_ctx_e_rls2ctx_vmid(_a: s_rd) _b :=
  update_s_rd_e_rd_s2_ctx _a ((_a.(e_rd_s2_ctx)).[e_rls2ctx_vmid] :< _b).
Notation "_a '.[e_rd_s2_ctx].[e_rls2ctx_vmid]' ':<' _b" := (update_s_rd_e_rd_s2_ctx_e_rls2ctx_vmid _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_rd_state(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_rd_state] :< _b).
Notation "_a '.[g_rd].[e_rd_rd_state]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_rd_state _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_rec_count(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_rec_count] :< _b).
Notation "_a '.[g_rd].[e_rd_rec_count]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_rec_count _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_s2_ctx(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_s2_ctx] :< _b).
Notation "_a '.[g_rd].[e_rd_s2_ctx]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_s2_ctx _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_s2_ctx_e_rls2ctx_ipa_bits(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd_e_rd_s2_ctx _a ((_a.(g_rd).(e_rd_s2_ctx)).[e_rls2ctx_ipa_bits] :< _b).
Notation "_a '.[g_rd].[e_rd_s2_ctx].[e_rls2ctx_ipa_bits]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_s2_ctx_e_rls2ctx_ipa_bits _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_s2_ctx_e_rls2ctx_s2_starting_level(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd_e_rd_s2_ctx _a ((_a.(g_rd).(e_rd_s2_ctx)).[e_rls2ctx_s2_starting_level] :< _b).
Notation "_a '.[g_rd].[e_rd_s2_ctx].[e_rls2ctx_s2_starting_level]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_s2_ctx_e_rls2ctx_s2_starting_level _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_s2_ctx_e_rls2ctx_num_root_rtts(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd_e_rd_s2_ctx _a ((_a.(g_rd).(e_rd_s2_ctx)).[e_rls2ctx_num_root_rtts] :< _b).
Notation "_a '.[g_rd].[e_rd_s2_ctx].[e_rls2ctx_num_root_rtts]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_s2_ctx_e_rls2ctx_num_root_rtts _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_s2_ctx_e_rls2ctx_g_rtt(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd_e_rd_s2_ctx _a ((_a.(g_rd).(e_rd_s2_ctx)).[e_rls2ctx_g_rtt] :< _b).
Notation "_a '.[g_rd].[e_rd_s2_ctx].[e_rls2ctx_g_rtt]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_s2_ctx_e_rls2ctx_g_rtt _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_s2_ctx_e_rls2ctx_vmid(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd_e_rd_s2_ctx _a ((_a.(g_rd).(e_rd_s2_ctx)).[e_rls2ctx_vmid] :< _b).
Notation "_a '.[g_rd].[e_rd_s2_ctx].[e_rls2ctx_vmid]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_s2_ctx_e_rls2ctx_vmid _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_num_rec_aux(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_num_rec_aux] :< _b).
Notation "_a '.[g_rd].[e_rd_num_rec_aux]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_num_rec_aux _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_algorithm(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_algorithm] :< _b).
Notation "_a '.[g_rd].[e_rd_algorithm]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_algorithm _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_pmu_enabled(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_pmu_enabled] :< _b).
Notation "_a '.[g_rd].[e_rd_pmu_enabled]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_pmu_enabled _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_pmu_num_cnts(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_pmu_num_cnts] :< _b).
Notation "_a '.[g_rd].[e_rd_pmu_num_cnts]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_pmu_num_cnts _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_sve_enabled(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_sve_enabled] :< _b).
Notation "_a '.[g_rd].[e_rd_sve_enabled]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_sve_enabled _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_sve_vq(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_sve_vq] :< _b).
Notation "_a '.[g_rd].[e_rd_sve_vq]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_sve_vq _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_measurement(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_measurement] :< _b).
Notation "_a '.[g_rd].[e_rd_measurement]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_measurement _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rd_e_rd_rpv(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rd _a ((_a.(g_rd)).[e_rd_rpv] :< _b).
Notation "_a '.[g_rd].[e_rd_rpv]' ':<' _b" := (update_GranuleDataNormal_g_rd_e_rd_rpv _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_g_rec(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_g_rec] :< _b).
Notation "_a '.[g_rec].[e_g_rec]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_g_rec _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_rec_idx(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_rec_idx] :< _b).
Notation "_a '.[g_rec].[e_rec_idx]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_rec_idx _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_runnable(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_runnable] :< _b).
Notation "_a '.[g_rec].[e_runnable]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_runnable _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_regs(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_regs] :< _b).
Notation "_a '.[g_rec].[e_regs]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_regs _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_pc(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_pc] :< _b).
Notation "_a '.[g_rec].[e_pc]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_pc _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_pstate(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_pstate] :< _b).
Notation "_a '.[g_rec].[e_pstate]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_pstate _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_sysregs] :< _b).
Notation "_a '.[g_rec].[e_sysregs]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_sp_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_sp_el0] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_sp_el0]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_sp_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_sp_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_sp_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_sp_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_sp_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_elr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_elr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_elr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_elr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_spsr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_spsr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_spsr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_spsr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_pmcr_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_pmcr_el0] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_pmcr_el0]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_pmcr_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_tpidrro_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_tpidrro_el0] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_tpidrro_el0]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_tpidrro_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_tpidr_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_tpidr_el0] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_tpidr_el0]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_tpidr_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_csselr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_csselr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_csselr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_csselr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_sctlr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_sctlr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_sctlr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_sctlr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_actlr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_actlr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_actlr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_actlr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cpacr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_cpacr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_cpacr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cpacr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_zcr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_zcr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_zcr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_zcr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_ttbr0_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_ttbr0_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_ttbr0_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_ttbr0_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_ttbr1_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_ttbr1_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_ttbr1_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_ttbr1_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_tcr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_tcr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_tcr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_tcr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_esr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_esr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_esr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_esr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_afsr0_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_afsr0_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_afsr0_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_afsr0_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_afsr1_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_afsr1_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_afsr1_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_afsr1_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_far_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_far_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_far_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_far_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_mair_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_mair_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_mair_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_mair_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_vbar_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_vbar_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_vbar_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_vbar_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_contextidr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_contextidr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_contextidr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_contextidr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_tpidr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_tpidr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_tpidr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_tpidr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_amair_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_amair_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_amair_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_amair_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntkctl_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_cntkctl_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_cntkctl_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntkctl_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_par_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_par_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_par_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_par_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_mdscr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_mdscr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_mdscr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_mdscr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_mdccint_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_mdccint_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_mdccint_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_mdccint_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_disr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_disr_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_disr_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_disr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_mpam0_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_mpam0_el1] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_mpam0_el1]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_mpam0_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cnthctl_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_cnthctl_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_cnthctl_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cnthctl_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntvoff_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_cntvoff_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_cntvoff_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntvoff_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntpoff_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_cntpoff_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_cntpoff_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntpoff_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntp_ctl_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_cntp_ctl_el0] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_cntp_ctl_el0]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntp_ctl_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntp_cval_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_cntp_cval_el0] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_cntp_cval_el0]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntp_cval_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntv_ctl_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_cntv_ctl_el0] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_cntv_ctl_el0]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntv_ctl_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntv_cval_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_cntv_cval_el0] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_cntv_cval_el0]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_cntv_cval_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_gicstate] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_gicstate]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_ap0r_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(g_rec).(e_sysregs).(e_sysreg_gicstate)).[e_ich_ap0r_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_gicstate].[e_ich_ap0r_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_ap0r_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_ap1r_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(g_rec).(e_sysregs).(e_sysreg_gicstate)).[e_ich_ap1r_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_gicstate].[e_ich_ap1r_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_ap1r_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_vmcr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(g_rec).(e_sysregs).(e_sysreg_gicstate)).[e_ich_vmcr_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_gicstate].[e_ich_vmcr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_vmcr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_hcr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(g_rec).(e_sysregs).(e_sysreg_gicstate)).[e_ich_hcr_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_gicstate].[e_ich_hcr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_hcr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_lr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(g_rec).(e_sysregs).(e_sysreg_gicstate)).[e_ich_lr_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_gicstate].[e_ich_lr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_lr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_misr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate _a ((_a.(g_rec).(e_sysregs).(e_sysreg_gicstate)).[e_ich_misr_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_gicstate].[e_ich_misr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_gicstate_e_ich_misr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_vmpidr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_vmpidr_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_vmpidr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_vmpidr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_hcr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_sysregs _a ((_a.(g_rec).(e_sysregs)).[e_sysreg_hcr_el2] :< _b).
Notation "_a '.[g_rec].[e_sysregs].[e_sysreg_hcr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_sysregs_e_sysreg_hcr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_common_sysregs(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_common_sysregs] :< _b).
Notation "_a '.[g_rec].[e_common_sysregs]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_common_sysregs _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_common_sysregs_e_common_vttbr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_common_sysregs _a ((_a.(g_rec).(e_common_sysregs)).[e_common_vttbr_el2] :< _b).
Notation "_a '.[g_rec].[e_common_sysregs].[e_common_vttbr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_common_sysregs_e_common_vttbr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_common_sysregs_e_common_vtcr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_common_sysregs _a ((_a.(g_rec).(e_common_sysregs)).[e_common_vtcr_el2] :< _b).
Notation "_a '.[g_rec].[e_common_sysregs].[e_common_vtcr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_common_sysregs_e_common_vtcr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_common_sysregs_e_common_hcr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_common_sysregs _a ((_a.(g_rec).(e_common_sysregs)).[e_common_hcr_el2] :< _b).
Notation "_a '.[g_rec].[e_common_sysregs].[e_common_hcr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_common_sysregs_e_common_hcr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_common_sysregs_e_common_mdcr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_common_sysregs _a ((_a.(g_rec).(e_common_sysregs)).[e_common_mdcr_el2] :< _b).
Notation "_a '.[g_rec].[e_common_sysregs].[e_common_mdcr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_common_sysregs_e_common_mdcr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_set_ripas(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_set_ripas] :< _b).
Notation "_a '.[g_rec].[e_set_ripas]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_set_ripas _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_set_ripas_e_start(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_set_ripas _a ((_a.(g_rec).(e_set_ripas)).[e_start] :< _b).
Notation "_a '.[g_rec].[e_set_ripas].[e_start]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_set_ripas_e_start _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_set_ripas_e_end(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_set_ripas _a ((_a.(g_rec).(e_set_ripas)).[e_end] :< _b).
Notation "_a '.[g_rec].[e_set_ripas].[e_end]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_set_ripas_e_end _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_set_ripas_e_addr(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_set_ripas _a ((_a.(g_rec).(e_set_ripas)).[e_addr] :< _b).
Notation "_a '.[g_rec].[e_set_ripas].[e_addr]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_set_ripas_e_addr _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_set_ripas_e_ripas(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_set_ripas _a ((_a.(g_rec).(e_set_ripas)).[e_ripas] :< _b).
Notation "_a '.[g_rec].[e_set_ripas].[e_ripas]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_set_ripas_e_ripas _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_realm_info(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_realm_info] :< _b).
Notation "_a '.[g_rec].[e_realm_info]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_realm_info _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_realm_info_e_ipa_bits(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_realm_info _a ((_a.(g_rec).(e_realm_info)).[e_ipa_bits] :< _b).
Notation "_a '.[g_rec].[e_realm_info].[e_ipa_bits]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_realm_info_e_ipa_bits _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_realm_info_e_s2_starting_level(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_realm_info _a ((_a.(g_rec).(e_realm_info)).[e_s2_starting_level] :< _b).
Notation "_a '.[g_rec].[e_realm_info].[e_s2_starting_level]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_realm_info_e_s2_starting_level _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_realm_info_e_g_rtt(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_realm_info _a ((_a.(g_rec).(e_realm_info)).[e_g_rtt] :< _b).
Notation "_a '.[g_rec].[e_realm_info].[e_g_rtt]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_realm_info_e_g_rtt _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_realm_info_e_g_rd(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_realm_info _a ((_a.(g_rec).(e_realm_info)).[e_g_rd] :< _b).
Notation "_a '.[g_rec].[e_realm_info].[e_g_rd]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_realm_info_e_g_rd _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_realm_info_e_pmu_enabled(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_realm_info _a ((_a.(g_rec).(e_realm_info)).[e_pmu_enabled] :< _b).
Notation "_a '.[g_rec].[e_realm_info].[e_pmu_enabled]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_realm_info_e_pmu_enabled _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_realm_info_e_pmu_num_cnts(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_realm_info _a ((_a.(g_rec).(e_realm_info)).[e_pmu_num_cnts] :< _b).
Notation "_a '.[g_rec].[e_realm_info].[e_pmu_num_cnts]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_realm_info_e_pmu_num_cnts _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_realm_info_e_sve_enabled(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_realm_info _a ((_a.(g_rec).(e_realm_info)).[e_sve_enabled] :< _b).
Notation "_a '.[g_rec].[e_realm_info].[e_sve_enabled]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_realm_info_e_sve_enabled _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_realm_info_e_sve_vq(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_realm_info _a ((_a.(g_rec).(e_realm_info)).[e_sve_vq] :< _b).
Notation "_a '.[g_rec].[e_realm_info].[e_sve_vq]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_realm_info_e_sve_vq _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_last_run_info(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_last_run_info] :< _b).
Notation "_a '.[g_rec].[e_last_run_info]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_last_run_info _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_last_run_info_e_esr(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_last_run_info _a ((_a.(g_rec).(e_last_run_info)).[e_esr] :< _b).
Notation "_a '.[g_rec].[e_last_run_info].[e_esr]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_last_run_info_e_esr _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_last_run_info_e_hpfar(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_last_run_info _a ((_a.(g_rec).(e_last_run_info)).[e_hpfar] :< _b).
Notation "_a '.[g_rec].[e_last_run_info].[e_hpfar]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_last_run_info_e_hpfar _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_last_run_info_e_far(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_last_run_info _a ((_a.(g_rec).(e_last_run_info)).[e_far] :< _b).
Notation "_a '.[g_rec].[e_last_run_info].[e_far]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_last_run_info_e_far _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_ns(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_ns] :< _b).
Notation "_a '.[g_rec].[e_ns]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_ns _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_psci_info(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_psci_info] :< _b).
Notation "_a '.[g_rec].[e_psci_info]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_psci_info _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_psci_info_e_pending(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_psci_info _a ((_a.(g_rec).(e_psci_info)).[e_pending] :< _b).
Notation "_a '.[g_rec].[e_psci_info].[e_pending]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_psci_info_e_pending _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_num_rec_aux(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_num_rec_aux] :< _b).
Notation "_a '.[g_rec].[e_num_rec_aux]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_num_rec_aux _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_g_aux(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_g_aux] :< _b).
Notation "_a '.[g_rec].[e_g_aux]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_g_aux _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_aux_data(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_aux_data] :< _b).
Notation "_a '.[g_rec].[e_aux_data]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_aux_data _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_aux_data_e_attest_heap_buf(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_aux_data _a ((_a.(g_rec).(e_aux_data)).[e_attest_heap_buf] :< _b).
Notation "_a '.[g_rec].[e_aux_data].[e_attest_heap_buf]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_aux_data_e_attest_heap_buf _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_aux_data_e_pmu(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_aux_data _a ((_a.(g_rec).(e_aux_data)).[e_pmu] :< _b).
Notation "_a '.[g_rec].[e_aux_data].[e_pmu]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_aux_data_e_pmu _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_aux_data _a ((_a.(g_rec).(e_aux_data)).[e_rec_simd] :< _b).
Notation "_a '.[g_rec].[e_aux_data].[e_rec_simd]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd_e_simd(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd _a ((_a.(g_rec).(e_aux_data).(e_rec_simd)).[e_simd] :< _b).
Notation "_a '.[g_rec].[e_aux_data].[e_rec_simd].[e_simd]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd_e_simd _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd_e_simd_allowed(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd _a ((_a.(g_rec).(e_aux_data).(e_rec_simd)).[e_simd_allowed] :< _b).
Notation "_a '.[g_rec].[e_aux_data].[e_rec_simd].[e_simd_allowed]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd_e_simd_allowed _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd_e_init_done(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd _a ((_a.(g_rec).(e_aux_data).(e_rec_simd)).[e_init_done] :< _b).
Notation "_a '.[g_rec].[e_aux_data].[e_rec_simd].[e_init_done]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_aux_data_e_rec_simd_e_init_done _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_alloc_info(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_alloc_info] :< _b).
Notation "_a '.[g_rec].[e_alloc_info]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_alloc_info _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_alloc_info _a ((_a.(g_rec).(e_alloc_info)).[e__ctx] :< _b).
Notation "_a '.[g_rec].[e_alloc_info].[e__ctx]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx_e_buf(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx _a ((_a.(g_rec).(e_alloc_info).(e__ctx)).[e_buf] :< _b).
Notation "_a '.[g_rec].[e_alloc_info].[e__ctx].[e_buf]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx_e_buf _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx_e__len(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx _a ((_a.(g_rec).(e_alloc_info).(e__ctx)).[e__len] :< _b).
Notation "_a '.[g_rec].[e_alloc_info].[e__ctx].[e__len]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx_e__len _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx_e_first(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx _a ((_a.(g_rec).(e_alloc_info).(e__ctx)).[e_first] :< _b).
Notation "_a '.[g_rec].[e_alloc_info].[e__ctx].[e_first]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx_e_first _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx_e_first_free(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx _a ((_a.(g_rec).(e_alloc_info).(e__ctx)).[e_first_free] :< _b).
Notation "_a '.[g_rec].[e_alloc_info].[e__ctx].[e_first_free]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx_e_first_free _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx_e_verify(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx _a ((_a.(g_rec).(e_alloc_info).(e__ctx)).[e_verify] :< _b).
Notation "_a '.[g_rec].[e_alloc_info].[e__ctx].[e_verify]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_alloc_info_e__ctx_e_verify _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_alloc_info_e_ctx_initialised(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_alloc_info _a ((_a.(g_rec).(e_alloc_info)).[e_ctx_initialised] :< _b).
Notation "_a '.[g_rec].[e_alloc_info].[e_ctx_initialised]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_alloc_info_e_ctx_initialised _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_serror_info(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_serror_info] :< _b).
Notation "_a '.[g_rec].[e_serror_info]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_serror_info _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_serror_info_e_vsesr_el2(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_serror_info _a ((_a.(g_rec).(e_serror_info)).[e_vsesr_el2] :< _b).
Notation "_a '.[g_rec].[e_serror_info].[e_vsesr_el2]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_serror_info_e_vsesr_el2 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_serror_info_e_inject(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec_e_serror_info _a ((_a.(g_rec).(e_serror_info)).[e_inject] :< _b).
Notation "_a '.[g_rec].[e_serror_info].[e_inject]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_serror_info_e_inject _a _b) (at level 1).

Definition update_GranuleDataNormal_g_rec_e_host_call(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_rec _a ((_a.(g_rec)).[e_host_call] :< _b).
Notation "_a '.[g_rec].[e_host_call]' ':<' _b" := (update_GranuleDataNormal_g_rec_e_host_call _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmccfiltr_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmccfiltr_el0] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmccfiltr_el0]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmccfiltr_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmccntr_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmccntr_el0] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmccntr_el0]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmccntr_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmcntenset_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmcntenset_el0] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmcntenset_el0]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmcntenset_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmcntenclr_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmcntenclr_el0] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmcntenclr_el0]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmcntenclr_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmintenset_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmintenset_el1] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmintenset_el1]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmintenset_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmintenclr_el1(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmintenclr_el1] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmintenclr_el1]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmintenclr_el1 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmovsset_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmovsset_el0] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmovsset_el0]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmovsset_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmovsclr_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmovsclr_el0] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmovsclr_el0]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmovsclr_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmselr_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmselr_el0] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmselr_el0]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmselr_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmuserenr_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmuserenr_el0] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmuserenr_el0]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmuserenr_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmxevcntr_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmxevcntr_el0] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmxevcntr_el0]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmxevcntr_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmxevtyper_el0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmxevtyper_el0] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmxevtyper_el0]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmxevtyper_el0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_pmu_state_e_pmev_regs(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_pmu_state _a ((_a.(g_aux_pmu_state)).[e_pmev_regs] :< _b).
Notation "_a '.[g_aux_pmu_state].[e_pmev_regs]' ':<' _b" := (update_GranuleDataNormal_g_aux_pmu_state_e_pmev_regs _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_simd_state_e_t(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_simd_state _a ((_a.(g_aux_simd_state)).[e_t] :< _b).
Notation "_a '.[g_aux_simd_state].[e_t]' ':<' _b" := (update_GranuleDataNormal_g_aux_simd_state_e_t _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_simd_state_e_t _a ((_a.(g_aux_simd_state).(e_t)).[e_fpu] :< _b).
Notation "_a '.[g_aux_simd_state].[e_t].[e_fpu]' ':<' _b" := (update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu_e_q(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu _a ((_a.(g_aux_simd_state).(e_t).(e_fpu)).[e_q] :< _b).
Notation "_a '.[g_aux_simd_state].[e_t].[e_fpu].[e_q]' ':<' _b" := (update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu_e_q _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu_e_fpsr(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu _a ((_a.(g_aux_simd_state).(e_t).(e_fpu)).[e_fpsr] :< _b).
Notation "_a '.[g_aux_simd_state].[e_t].[e_fpu].[e_fpsr]' ':<' _b" := (update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu_e_fpsr _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu_e_fpcr(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu _a ((_a.(g_aux_simd_state).(e_t).(e_fpu)).[e_fpcr] :< _b).
Notation "_a '.[g_aux_simd_state].[e_t].[e_fpu].[e_fpcr]' ':<' _b" := (update_GranuleDataNormal_g_aux_simd_state_e_t_e_fpu_e_fpcr _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_simd_state_e_t_e_padding0(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_simd_state_e_t _a ((_a.(g_aux_simd_state).(e_t)).[e_padding0] :< _b).
Notation "_a '.[g_aux_simd_state].[e_t].[e_padding0]' ':<' _b" := (update_GranuleDataNormal_g_aux_simd_state_e_t_e_padding0 _a _b) (at level 1).

Definition update_GranuleDataNormal_g_aux_simd_state_e_simd_type(_a: GranuleDataNormal) _b :=
  update_GranuleDataNormal_g_aux_simd_state _a ((_a.(g_aux_simd_state)).[e_simd_type] :< _b).
Notation "_a '.[g_aux_simd_state].[e_simd_type]' ':<' _b" := (update_GranuleDataNormal_g_aux_simd_state_e_simd_type _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_vttbr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_vttbr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_vttbr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_vttbr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_zcr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_zcr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_zcr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_zcr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_cnthctl_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_cnthctl_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_cnthctl_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_cnthctl_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_elr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_elr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_elr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_elr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_cptr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_cptr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_cptr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_cptr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_mdcr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_mdcr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_mdcr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_mdcr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_vpidr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_vpidr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_vpidr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_vpidr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_sctlr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_sctlr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_sctlr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_sctlr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_esr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_esr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_esr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_esr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_spsr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_spsr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_spsr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_spsr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_hpfar_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_hpfar_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_hpfar_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_hpfar_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_far_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_far_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_far_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_far_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_vsesr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_vsesr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_vsesr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_vsesr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_hcr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_hcr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_hcr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_hcr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_cntvoff_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_cntvoff_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_cntvoff_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_cntvoff_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_vmpidr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_vmpidr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_vmpidr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_vmpidr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_vtcr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_vtcr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_vtcr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_vtcr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_ich_hcr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_ich_hcr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_ich_hcr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_ich_hcr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_ich_lr15_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_ich_lr15_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_ich_lr15_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_ich_lr15_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_ich_misr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_ich_misr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_ich_misr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_ich_misr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_ich_vmcr_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_ich_vmcr_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_ich_vmcr_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_ich_vmcr_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_icc_sre_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_icc_sre_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_icc_sre_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_icc_sre_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_esr_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_esr_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_esr_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_esr_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_spsr_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_spsr_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_spsr_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_spsr_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_elr_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_elr_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_elr_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_elr_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_vbar_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_vbar_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_vbar_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_vbar_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_far_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_far_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_far_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_far_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_amair_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_amair_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_amair_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_amair_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_cntkctl_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_cntkctl_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_cntkctl_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_cntkctl_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_cntp_ctl_el02(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_cntp_ctl_el02] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_cntp_ctl_el02]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_cntp_ctl_el02 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_cntp_cval_el02(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_cntp_cval_el02] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_cntp_cval_el02]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_cntp_cval_el02 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_cntpoff_el2(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_cntpoff_el2] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_cntpoff_el2]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_cntpoff_el2 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_cntv_ctl_el02(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_cntv_ctl_el02] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_cntv_ctl_el02]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_cntv_ctl_el02 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_cntv_cval_el02(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_cntv_cval_el02] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_cntv_cval_el02]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_cntv_cval_el02 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_contextidr_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_contextidr_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_contextidr_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_contextidr_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_mair_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_mair_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_mair_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_mair_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_afsr1_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_afsr1_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_afsr1_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_afsr1_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_afsr0_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_afsr0_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_afsr0_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_afsr0_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_tcr_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_tcr_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_tcr_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_tcr_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_ttbr1_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_ttbr1_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_ttbr1_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_ttbr1_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_ttbr0_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_ttbr0_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_ttbr0_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_ttbr0_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_cpacr_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_cpacr_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_cpacr_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_cpacr_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_sctlr_el12(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_sctlr_el12] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_sctlr_el12]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_sctlr_el12 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_midr_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_midr_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_midr_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_midr_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_isr_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_isr_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_isr_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_isr_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_id_aa64mmfr0_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_id_aa64mmfr0_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_id_aa64mmfr0_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_id_aa64mmfr0_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_id_aa64mmfr1_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_id_aa64mmfr1_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_id_aa64mmfr1_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_id_aa64mmfr1_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_id_aa64dfr0_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_id_aa64dfr0_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_id_aa64dfr0_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_id_aa64dfr0_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_id_aa64dfr1_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_id_aa64dfr1_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_id_aa64dfr1_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_id_aa64dfr1_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_id_aa64pfr0_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_id_aa64pfr0_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_id_aa64pfr0_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_id_aa64pfr0_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_id_aa64pfr1_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_id_aa64pfr1_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_id_aa64pfr1_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_id_aa64pfr1_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_disr_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_disr_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_disr_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_disr_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_mdccint_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_mdccint_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_mdccint_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_mdccint_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_mdscr_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_mdscr_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_mdscr_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_mdscr_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_par_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_par_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_par_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_par_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_tpidr_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_tpidr_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_tpidr_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_tpidr_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_actlr_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_actlr_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_actlr_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_actlr_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_csselr_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_csselr_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_csselr_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_csselr_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_sp_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_sp_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_sp_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_sp_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmintenset_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmintenset_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmintenset_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmintenset_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmintenclr_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmintenclr_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmintenclr_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmintenclr_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_icc_hppir1_el1(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_icc_hppir1_el1] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_icc_hppir1_el1]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_icc_hppir1_el1 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmcr_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmcr_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmcr_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmcr_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper0_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper0_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper0_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper0_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper1_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper1_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper1_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper1_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper2_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper2_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper2_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper2_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper3_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper3_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper3_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper3_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper4_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper4_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper4_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper4_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper5_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper5_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper5_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper5_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper6_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper6_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper6_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper6_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper7_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper7_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper7_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper7_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper8_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper8_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper8_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper8_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper9_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper9_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper9_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper9_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper10_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper10_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper10_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper10_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper11_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper11_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper11_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper11_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper12_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper12_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper12_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper12_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper13_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper13_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper13_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper13_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper14_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper14_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper14_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper14_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper15_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper15_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper15_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper15_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper16_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper16_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper16_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper16_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper17_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper17_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper17_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper17_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper18_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper18_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper18_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper18_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper19_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper19_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper19_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper19_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper20_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper20_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper20_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper20_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper21_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper21_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper21_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper21_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper22_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper22_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper22_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper22_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper23_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper23_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper23_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper23_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper24_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper24_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper24_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper24_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper25_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper25_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper25_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper25_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper26_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper26_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper26_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper26_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper27_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper27_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper27_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper27_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper28_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper28_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper28_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper28_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper29_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper29_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper29_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper29_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevtyper30_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevtyper30_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevtyper30_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevtyper30_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr0_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr0_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr0_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr0_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr1_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr1_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr1_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr1_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr2_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr2_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr2_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr2_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr3_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr3_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr3_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr3_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr4_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr4_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr4_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr4_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr5_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr5_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr5_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr5_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr6_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr6_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr6_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr6_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr7_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr7_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr7_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr7_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr8_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr8_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr8_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr8_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr9_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr9_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr9_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr9_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr10_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr10_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr10_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr10_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr11_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr11_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr11_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr11_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr12_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr12_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr12_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr12_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr13_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr13_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr13_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr13_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr14_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr14_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr14_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr14_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr15_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr15_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr15_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr15_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr16_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr16_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr16_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr16_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr17_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr17_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr17_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr17_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr18_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr18_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr18_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr18_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr19_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr19_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr19_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr19_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr20_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr20_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr20_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr20_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr21_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr21_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr21_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr21_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr22_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr22_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr22_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr22_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr23_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr23_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr23_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr23_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr24_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr24_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr24_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr24_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr25_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr25_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr25_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr25_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr26_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr26_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr26_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr26_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr27_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr27_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr27_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr27_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr28_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr28_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr28_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr28_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr29_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr29_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr29_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr29_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmevcntr30_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmevcntr30_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmevcntr30_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmevcntr30_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmccfiltr_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmccfiltr_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmccfiltr_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmccfiltr_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmccntr_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmccntr_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmccntr_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmccntr_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmcntenset_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmcntenset_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmcntenset_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmcntenset_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmcntenclr_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmcntenclr_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmcntenclr_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmcntenclr_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmovsclr_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmovsclr_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmovsclr_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmovsclr_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmovsset_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmovsset_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmovsset_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmovsset_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmselr_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmselr_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmselr_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmselr_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmuserenr_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmuserenr_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmuserenr_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmuserenr_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmxevcntr_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmxevcntr_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmxevcntr_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmxevcntr_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_pmxevtyper_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_pmxevtyper_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_pmxevtyper_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_pmxevtyper_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_tpidr_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_tpidr_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_tpidr_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_tpidr_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_tpidrro_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_tpidrro_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_tpidrro_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_tpidrro_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_sp_el0(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_sp_el0] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_sp_el0]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_sp_el0 _a _b) (at level 1).

Definition update_PerCPU_pcpu_regs_pcpu_dummy_regs(_a: PerCPU) _b :=
  update_PerCPU_pcpu_regs _a ((_a.(pcpu_regs)).[pcpu_dummy_regs] :< _b).
Notation "_a '.[pcpu_regs].[pcpu_dummy_regs]' ':<' _b" := (update_PerCPU_pcpu_regs_pcpu_dummy_regs _a _b) (at level 1).

Definition update_RData_share_glk(_a: RData) _b :=
  update_RData_share _a ((_a.(share)).[glk] :< _b).
Notation "_a '.[share].[glk]' ':<' _b" := (update_RData_share_glk _a _b) (at level 1).

Definition update_RData_share_gpt(_a: RData) _b :=
  update_RData_share _a ((_a.(share)).[gpt] :< _b).
Notation "_a '.[share].[gpt]' ':<' _b" := (update_RData_share_gpt _a _b) (at level 1).

Definition update_RData_share_slots(_a: RData) _b :=
  update_RData_share _a ((_a.(share)).[slots] :< _b).
Notation "_a '.[share].[slots]' ':<' _b" := (update_RData_share_slots _a _b) (at level 1).

Definition update_RData_share_granules(_a: RData) _b :=
  update_RData_share _a ((_a.(share)).[granules] :< _b).
Notation "_a '.[share].[granules]' ':<' _b" := (update_RData_share_granules _a _b) (at level 1).

Definition update_RData_share_granule_data(_a: RData) _b :=
  update_RData_share _a ((_a.(share)).[granule_data] :< _b).
Notation "_a '.[share].[granule_data]' ':<' _b" := (update_RData_share_granule_data _a _b) (at level 1).

Definition update_RData_share_gv_g_sve_max_vq(_a: RData) _b :=
  update_RData_share _a ((_a.(share)).[gv_g_sve_max_vq] :< _b).
Notation "_a '.[share].[gv_g_sve_max_vq]' ':<' _b" := (update_RData_share_gv_g_sve_max_vq _a _b) (at level 1).

Definition update_RData_share_gv_g_ns_simd(_a: RData) _b :=
  update_RData_share _a ((_a.(share)).[gv_g_ns_simd] :< _b).
Notation "_a '.[share].[gv_g_ns_simd]' ':<' _b" := (update_RData_share_gv_g_ns_simd _a _b) (at level 1).

Definition update_RData_share_gv_g_cpu_simd_type(_a: RData) _b :=
  update_RData_share _a ((_a.(share)).[gv_g_cpu_simd_type] :< _b).
Notation "_a '.[share].[gv_g_cpu_simd_type]' ':<' _b" := (update_RData_share_gv_g_cpu_simd_type _a _b) (at level 1).

Definition update_RData_share_gv_vmids(_a: RData) _b :=
  update_RData_share _a ((_a.(share)).[gv_vmids] :< _b).
Notation "_a '.[share].[gv_vmids]' ':<' _b" := (update_RData_share_gv_vmids _a _b) (at level 1).

Definition update_RData_priv_pcpu_stack(_a: RData) _b :=
  update_RData_priv _a ((_a.(priv)).[pcpu_stack] :< _b).
Notation "_a '.[priv].[pcpu_stack]' ':<' _b" := (update_RData_priv_pcpu_stack _a _b) (at level 1).

Definition update_RData_priv_pcpu_sc(_a: RData) _b :=
  update_RData_priv _a ((_a.(priv)).[pcpu_sc] :< _b).
Notation "_a '.[priv].[pcpu_sc]' ':<' _b" := (update_RData_priv_pcpu_sc _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs(_a: RData) _b :=
  update_RData_priv _a ((_a.(priv)).[pcpu_regs] :< _b).
Notation "_a '.[priv].[pcpu_regs]' ':<' _b" := (update_RData_priv_pcpu_regs _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_vttbr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_vttbr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_vttbr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_vttbr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_zcr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_zcr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_zcr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_zcr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_cnthctl_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_cnthctl_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_cnthctl_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_cnthctl_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_elr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_elr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_elr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_elr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_cptr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_cptr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_cptr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_cptr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_mdcr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_mdcr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_mdcr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_mdcr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_vpidr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_vpidr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_vpidr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_vpidr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_sctlr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_sctlr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_sctlr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_sctlr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_esr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_esr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_esr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_esr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_spsr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_spsr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_spsr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_spsr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_hpfar_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_hpfar_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_hpfar_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_hpfar_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_far_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_far_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_far_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_far_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_vsesr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_vsesr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_vsesr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_vsesr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_hcr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_hcr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_hcr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_hcr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_cntvoff_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_cntvoff_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_cntvoff_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_cntvoff_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_vmpidr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_vmpidr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_vmpidr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_vmpidr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_vtcr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_vtcr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_vtcr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_vtcr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_ich_hcr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_ich_hcr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_ich_hcr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_ich_hcr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_ich_lr15_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_ich_lr15_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_ich_lr15_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_ich_lr15_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_ich_misr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_ich_misr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_ich_misr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_ich_misr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_ich_vmcr_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_ich_vmcr_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_ich_vmcr_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_ich_vmcr_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_icc_sre_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_icc_sre_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_icc_sre_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_icc_sre_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_esr_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_esr_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_esr_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_esr_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_spsr_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_spsr_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_spsr_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_spsr_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_elr_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_elr_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_elr_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_elr_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_vbar_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_vbar_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_vbar_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_vbar_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_far_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_far_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_far_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_far_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_amair_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_amair_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_amair_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_amair_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_cntkctl_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_cntkctl_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_cntkctl_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_cntkctl_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_cntp_ctl_el02(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_cntp_ctl_el02] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_cntp_ctl_el02]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_cntp_ctl_el02 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_cntp_cval_el02(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_cntp_cval_el02] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_cntp_cval_el02]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_cntp_cval_el02 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_cntpoff_el2(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_cntpoff_el2] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_cntpoff_el2]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_cntpoff_el2 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_cntv_ctl_el02(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_cntv_ctl_el02] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_cntv_ctl_el02]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_cntv_ctl_el02 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_cntv_cval_el02(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_cntv_cval_el02] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_cntv_cval_el02]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_cntv_cval_el02 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_contextidr_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_contextidr_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_contextidr_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_contextidr_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_mair_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_mair_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_mair_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_mair_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_afsr1_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_afsr1_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_afsr1_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_afsr1_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_afsr0_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_afsr0_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_afsr0_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_afsr0_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_tcr_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_tcr_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_tcr_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_tcr_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_ttbr1_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_ttbr1_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_ttbr1_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_ttbr1_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_ttbr0_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_ttbr0_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_ttbr0_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_ttbr0_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_cpacr_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_cpacr_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_cpacr_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_cpacr_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_sctlr_el12(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_sctlr_el12] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_sctlr_el12]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_sctlr_el12 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_midr_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_midr_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_midr_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_midr_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_isr_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_isr_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_isr_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_isr_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_id_aa64mmfr0_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_id_aa64mmfr0_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_id_aa64mmfr0_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_id_aa64mmfr0_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_id_aa64mmfr1_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_id_aa64mmfr1_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_id_aa64mmfr1_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_id_aa64mmfr1_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_id_aa64dfr0_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_id_aa64dfr0_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_id_aa64dfr0_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_id_aa64dfr0_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_id_aa64dfr1_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_id_aa64dfr1_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_id_aa64dfr1_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_id_aa64dfr1_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_id_aa64pfr0_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_id_aa64pfr0_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_id_aa64pfr0_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_id_aa64pfr0_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_id_aa64pfr1_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_id_aa64pfr1_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_id_aa64pfr1_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_id_aa64pfr1_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_disr_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_disr_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_disr_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_disr_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_mdccint_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_mdccint_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_mdccint_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_mdccint_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_mdscr_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_mdscr_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_mdscr_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_mdscr_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_par_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_par_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_par_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_par_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_tpidr_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_tpidr_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_tpidr_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_tpidr_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_actlr_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_actlr_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_actlr_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_actlr_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_csselr_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_csselr_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_csselr_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_csselr_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_sp_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_sp_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_sp_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_sp_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmintenset_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmintenset_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmintenset_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmintenset_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmintenclr_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmintenclr_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmintenclr_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmintenclr_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_icc_hppir1_el1(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_icc_hppir1_el1] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_icc_hppir1_el1]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_icc_hppir1_el1 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmcr_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmcr_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmcr_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmcr_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper0_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper0_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper0_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper0_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper1_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper1_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper1_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper1_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper2_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper2_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper2_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper2_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper3_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper3_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper3_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper3_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper4_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper4_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper4_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper4_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper5_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper5_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper5_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper5_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper6_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper6_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper6_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper6_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper7_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper7_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper7_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper7_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper8_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper8_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper8_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper8_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper9_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper9_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper9_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper9_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper10_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper10_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper10_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper10_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper11_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper11_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper11_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper11_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper12_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper12_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper12_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper12_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper13_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper13_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper13_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper13_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper14_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper14_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper14_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper14_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper15_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper15_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper15_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper15_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper16_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper16_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper16_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper16_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper17_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper17_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper17_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper17_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper18_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper18_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper18_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper18_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper19_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper19_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper19_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper19_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper20_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper20_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper20_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper20_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper21_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper21_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper21_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper21_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper22_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper22_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper22_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper22_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper23_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper23_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper23_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper23_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper24_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper24_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper24_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper24_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper25_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper25_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper25_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper25_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper26_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper26_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper26_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper26_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper27_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper27_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper27_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper27_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper28_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper28_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper28_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper28_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper29_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper29_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper29_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper29_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevtyper30_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevtyper30_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevtyper30_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevtyper30_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr0_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr0_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr0_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr0_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr1_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr1_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr1_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr1_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr2_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr2_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr2_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr2_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr3_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr3_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr3_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr3_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr4_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr4_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr4_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr4_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr5_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr5_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr5_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr5_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr6_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr6_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr6_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr6_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr7_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr7_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr7_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr7_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr8_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr8_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr8_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr8_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr9_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr9_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr9_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr9_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr10_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr10_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr10_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr10_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr11_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr11_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr11_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr11_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr12_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr12_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr12_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr12_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr13_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr13_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr13_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr13_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr14_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr14_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr14_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr14_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr15_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr15_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr15_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr15_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr16_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr16_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr16_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr16_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr17_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr17_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr17_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr17_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr18_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr18_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr18_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr18_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr19_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr19_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr19_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr19_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr20_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr20_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr20_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr20_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr21_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr21_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr21_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr21_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr22_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr22_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr22_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr22_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr23_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr23_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr23_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr23_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr24_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr24_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr24_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr24_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr25_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr25_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr25_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr25_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr26_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr26_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr26_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr26_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr27_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr27_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr27_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr27_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr28_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr28_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr28_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr28_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr29_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr29_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr29_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr29_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmevcntr30_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmevcntr30_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmevcntr30_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmevcntr30_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmccfiltr_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmccfiltr_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmccfiltr_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmccfiltr_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmccntr_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmccntr_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmccntr_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmccntr_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmcntenset_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmcntenset_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmcntenset_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmcntenset_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmcntenclr_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmcntenclr_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmcntenclr_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmcntenclr_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmovsclr_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmovsclr_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmovsclr_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmovsclr_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmovsset_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmovsset_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmovsset_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmovsset_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmselr_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmselr_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmselr_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmselr_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmuserenr_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmuserenr_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmuserenr_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmuserenr_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmxevcntr_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmxevcntr_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmxevcntr_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmxevcntr_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_pmxevtyper_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_pmxevtyper_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_pmxevtyper_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_pmxevtyper_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_tpidr_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_tpidr_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_tpidr_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_tpidr_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_tpidrro_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_tpidrro_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_tpidrro_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_tpidrro_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_sp_el0(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_sp_el0] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_sp_el0]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_sp_el0 _a _b) (at level 1).

Definition update_RData_priv_pcpu_regs_pcpu_dummy_regs(_a: RData) _b :=
  update_RData_priv_pcpu_regs _a ((_a.(priv).(pcpu_regs)).[pcpu_dummy_regs] :< _b).
Notation "_a '.[priv].[pcpu_regs].[pcpu_dummy_regs]' ':<' _b" := (update_RData_priv_pcpu_regs_pcpu_dummy_regs _a _b) (at level 1).

Definition update_RData_priv_pcpu_llt_info_cache(_a: RData) _b :=
  update_RData_priv _a ((_a.(priv)).[pcpu_llt_info_cache] :< _b).
Notation "_a '.[priv].[pcpu_llt_info_cache]' ':<' _b" := (update_RData_priv_pcpu_llt_info_cache _a _b) (at level 1).

Definition update_RData_stack_attest_setup_platform_token_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[attest_setup_platform_token_stack] :< _b).
Notation "_a '.[stack].[attest_setup_platform_token_stack]' ':<' _b" := (update_RData_stack_attest_setup_platform_token_stack _a _b) (at level 1).

Definition update_RData_stack_smc_psci_complete_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_psci_complete_stack] :< _b).
Notation "_a '.[stack].[smc_psci_complete_stack]' ':<' _b" := (update_RData_stack_smc_psci_complete_stack _a _b) (at level 1).

Definition update_RData_stack_find_lock_two_granules_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[find_lock_two_granules_stack] :< _b).
Notation "_a '.[stack].[find_lock_two_granules_stack]' ':<' _b" := (update_RData_stack_find_lock_two_granules_stack _a _b) (at level 1).

Definition update_RData_stack_attest_token_continue_write_state_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[attest_token_continue_write_state_stack] :< _b).
Notation "_a '.[stack].[attest_token_continue_write_state_stack]' ':<' _b" := (update_RData_stack_attest_token_continue_write_state_stack _a _b) (at level 1).

Definition update_RData_stack_rmm_log_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[rmm_log_stack] :< _b).
Notation "_a '.[stack].[rmm_log_stack]' ':<' _b" := (update_RData_stack_rmm_log_stack _a _b) (at level 1).

Definition update_RData_stack_attest_realm_token_create_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[attest_realm_token_create_stack] :< _b).
Notation "_a '.[stack].[attest_realm_token_create_stack]' ':<' _b" := (update_RData_stack_attest_realm_token_create_stack _a _b) (at level 1).

Definition update_RData_stack_smc_rec_enter_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_rec_enter_stack] :< _b).
Notation "_a '.[stack].[smc_rec_enter_stack]' ':<' _b" := (update_RData_stack_smc_rec_enter_stack _a _b) (at level 1).

Definition update_RData_stack_do_host_call_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[do_host_call_stack] :< _b).
Notation "_a '.[stack].[do_host_call_stack]' ':<' _b" := (update_RData_stack_do_host_call_stack _a _b) (at level 1).

Definition update_RData_stack_attest_rnd_prng_init_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[attest_rnd_prng_init_stack] :< _b).
Notation "_a '.[stack].[attest_rnd_prng_init_stack]' ':<' _b" := (update_RData_stack_attest_rnd_prng_init_stack _a _b) (at level 1).

Definition update_RData_stack_plat_setup_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[plat_setup_stack] :< _b).
Notation "_a '.[stack].[plat_setup_stack]' ':<' _b" := (update_RData_stack_plat_setup_stack _a _b) (at level 1).

Definition update_RData_stack_attest_token_encode_start_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[attest_token_encode_start_stack] :< _b).
Notation "_a '.[stack].[attest_token_encode_start_stack]' ':<' _b" := (update_RData_stack_attest_token_encode_start_stack _a _b) (at level 1).

Definition update_RData_stack_smc_data_destroy_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_data_destroy_stack] :< _b).
Notation "_a '.[stack].[smc_data_destroy_stack]' ':<' _b" := (update_RData_stack_smc_data_destroy_stack _a _b) (at level 1).

Definition update_RData_stack_xlat_get_llt_from_va_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[xlat_get_llt_from_va_stack] :< _b).
Notation "_a '.[stack].[xlat_get_llt_from_va_stack]' ':<' _b" := (update_RData_stack_xlat_get_llt_from_va_stack _a _b) (at level 1).

Definition update_RData_stack_smc_rec_create_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_rec_create_stack] :< _b).
Notation "_a '.[stack].[smc_rec_create_stack]' ':<' _b" := (update_RData_stack_smc_rec_create_stack _a _b) (at level 1).

Definition update_RData_stack_measurement_extend_sha512_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[measurement_extend_sha512_stack] :< _b).
Notation "_a '.[stack].[measurement_extend_sha512_stack]' ':<' _b" := (update_RData_stack_measurement_extend_sha512_stack _a _b) (at level 1).

Definition update_RData_stack_data_granule_measure_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[data_granule_measure_stack] :< _b).
Notation "_a '.[stack].[data_granule_measure_stack]' ':<' _b" := (update_RData_stack_data_granule_measure_stack _a _b) (at level 1).

Definition update_RData_stack_sort_granules_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[sort_granules_stack] :< _b).
Notation "_a '.[stack].[sort_granules_stack]' ':<' _b" := (update_RData_stack_sort_granules_stack _a _b) (at level 1).

Definition update_RData_stack_measurement_extend_sha256_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[measurement_extend_sha256_stack] :< _b).
Notation "_a '.[stack].[measurement_extend_sha256_stack]' ':<' _b" := (update_RData_stack_measurement_extend_sha256_stack _a _b) (at level 1).

Definition update_RData_stack_realm_ipa_to_pa_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[realm_ipa_to_pa_stack] :< _b).
Notation "_a '.[stack].[realm_ipa_to_pa_stack]' ':<' _b" := (update_RData_stack_realm_ipa_to_pa_stack _a _b) (at level 1).

Definition update_RData_stack_attest_realm_token_sign_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[attest_realm_token_sign_stack] :< _b).
Notation "_a '.[stack].[attest_realm_token_sign_stack]' ':<' _b" := (update_RData_stack_attest_realm_token_sign_stack _a _b) (at level 1).

Definition update_RData_stack_rmm_el3_ifc_get_platform_token_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[rmm_el3_ifc_get_platform_token_stack] :< _b).
Notation "_a '.[stack].[rmm_el3_ifc_get_platform_token_stack]' ':<' _b" := (update_RData_stack_rmm_el3_ifc_get_platform_token_stack _a _b) (at level 1).

Definition update_RData_stack_attest_init_realm_attestation_key_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[attest_init_realm_attestation_key_stack] :< _b).
Notation "_a '.[stack].[attest_init_realm_attestation_key_stack]' ':<' _b" := (update_RData_stack_attest_init_realm_attestation_key_stack _a _b) (at level 1).

Definition update_RData_stack_plat_cmn_setup_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[plat_cmn_setup_stack] :< _b).
Notation "_a '.[stack].[plat_cmn_setup_stack]' ':<' _b" := (update_RData_stack_plat_cmn_setup_stack _a _b) (at level 1).

Definition update_RData_stack_complete_rsi_host_call_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[complete_rsi_host_call_stack] :< _b).
Notation "_a '.[stack].[complete_rsi_host_call_stack]' ':<' _b" := (update_RData_stack_complete_rsi_host_call_stack _a _b) (at level 1).

Definition update_RData_stack_handle_realm_rsi_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[handle_realm_rsi_stack] :< _b).
Notation "_a '.[stack].[handle_realm_rsi_stack]' ':<' _b" := (update_RData_stack_handle_realm_rsi_stack _a _b) (at level 1).

Definition update_RData_stack_smc_rtt_set_ripas_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_rtt_set_ripas_stack] :< _b).
Notation "_a '.[stack].[smc_rtt_set_ripas_stack]' ':<' _b" := (update_RData_stack_smc_rtt_set_ripas_stack _a _b) (at level 1).

Definition update_RData_stack_rtt_walk_lock_unlock_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[rtt_walk_lock_unlock_stack] :< _b).
Notation "_a '.[stack].[rtt_walk_lock_unlock_stack]' ':<' _b" := (update_RData_stack_rtt_walk_lock_unlock_stack _a _b) (at level 1).

Definition update_RData_stack_smc_rtt_destroy_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_rtt_destroy_stack] :< _b).
Notation "_a '.[stack].[smc_rtt_destroy_stack]' ':<' _b" := (update_RData_stack_smc_rtt_destroy_stack _a _b) (at level 1).

Definition update_RData_stack_map_unmap_ns_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[map_unmap_ns_stack] :< _b).
Notation "_a '.[stack].[map_unmap_ns_stack]' ':<' _b" := (update_RData_stack_map_unmap_ns_stack _a _b) (at level 1).

Definition update_RData_stack_handle_rsi_attest_token_init_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[handle_rsi_attest_token_init_stack] :< _b).
Notation "_a '.[stack].[handle_rsi_attest_token_init_stack]' ':<' _b" := (update_RData_stack_handle_rsi_attest_token_init_stack _a _b) (at level 1).

Definition update_RData_stack_realm_params_measure_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[realm_params_measure_stack] :< _b).
Notation "_a '.[stack].[realm_params_measure_stack]' ':<' _b" := (update_RData_stack_realm_params_measure_stack _a _b) (at level 1).

Definition update_RData_stack_handle_rsi_ipa_state_get_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[handle_rsi_ipa_state_get_stack] :< _b).
Notation "_a '.[stack].[handle_rsi_ipa_state_get_stack]' ':<' _b" := (update_RData_stack_handle_rsi_ipa_state_get_stack _a _b) (at level 1).

Definition update_RData_stack_realm_ipa_get_ripas_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[realm_ipa_get_ripas_stack] :< _b).
Notation "_a '.[stack].[realm_ipa_get_ripas_stack]' ':<' _b" := (update_RData_stack_realm_ipa_get_ripas_stack _a _b) (at level 1).

Definition update_RData_stack_smc_rtt_fold_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_rtt_fold_stack] :< _b).
Notation "_a '.[stack].[smc_rtt_fold_stack]' ':<' _b" := (update_RData_stack_smc_rtt_fold_stack _a _b) (at level 1).

Definition update_RData_stack_smc_rtt_create_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_rtt_create_stack] :< _b).
Notation "_a '.[stack].[smc_rtt_create_stack]' ':<' _b" := (update_RData_stack_smc_rtt_create_stack _a _b) (at level 1).

Definition update_RData_stack_rsi_log_on_exit_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[rsi_log_on_exit_stack] :< _b).
Notation "_a '.[stack].[rsi_log_on_exit_stack]' ':<' _b" := (update_RData_stack_rsi_log_on_exit_stack _a _b) (at level 1).

Definition update_RData_stack_attest_cca_token_create_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[attest_cca_token_create_stack] :< _b).
Notation "_a '.[stack].[attest_cca_token_create_stack]' ':<' _b" := (update_RData_stack_attest_cca_token_create_stack _a _b) (at level 1).

Definition update_RData_stack_rec_params_measure_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[rec_params_measure_stack] :< _b).
Notation "_a '.[stack].[rec_params_measure_stack]' ':<' _b" := (update_RData_stack_rec_params_measure_stack _a _b) (at level 1).

Definition update_RData_stack_handle_ns_smc_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[handle_ns_smc_stack] :< _b).
Notation "_a '.[stack].[handle_ns_smc_stack]' ':<' _b" := (update_RData_stack_handle_ns_smc_stack _a _b) (at level 1).

Definition update_RData_stack_rmm_el3_ifc_get_realm_attest_key_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[rmm_el3_ifc_get_realm_attest_key_stack] :< _b).
Notation "_a '.[stack].[rmm_el3_ifc_get_realm_attest_key_stack]' ':<' _b" := (update_RData_stack_rmm_el3_ifc_get_realm_attest_key_stack _a _b) (at level 1).

Definition update_RData_stack_handle_rsi_realm_config_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[handle_rsi_realm_config_stack] :< _b).
Notation "_a '.[stack].[handle_rsi_realm_config_stack]' ':<' _b" := (update_RData_stack_handle_rsi_realm_config_stack _a _b) (at level 1).

Definition update_RData_stack_smc_rtt_init_ripas_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_rtt_init_ripas_stack] :< _b).
Notation "_a '.[stack].[smc_rtt_init_ripas_stack]' ':<' _b" := (update_RData_stack_smc_rtt_init_ripas_stack _a _b) (at level 1).

Definition update_RData_stack_smc_rtt_read_entry_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_rtt_read_entry_stack] :< _b).
Notation "_a '.[stack].[smc_rtt_read_entry_stack]' ':<' _b" := (update_RData_stack_smc_rtt_read_entry_stack _a _b) (at level 1).

Definition update_RData_stack_handle_data_abort_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[handle_data_abort_stack] :< _b).
Notation "_a '.[stack].[handle_data_abort_stack]' ':<' _b" := (update_RData_stack_handle_data_abort_stack _a _b) (at level 1).

Definition update_RData_stack_data_create_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[data_create_stack] :< _b).
Notation "_a '.[stack].[data_create_stack]' ':<' _b" := (update_RData_stack_data_create_stack _a _b) (at level 1).

Definition update_RData_stack_smc_realm_create_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[smc_realm_create_stack] :< _b).
Notation "_a '.[stack].[smc_realm_create_stack]' ':<' _b" := (update_RData_stack_smc_realm_create_stack _a _b) (at level 1).

Definition update_RData_stack_ripas_granule_measure_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[ripas_granule_measure_stack] :< _b).
Notation "_a '.[stack].[ripas_granule_measure_stack]' ':<' _b" := (update_RData_stack_ripas_granule_measure_stack _a _b) (at level 1).

Definition update_RData_stack_ipa_is_empty_stack(_a: RData) _b :=
  update_RData_stack _a ((_a.(stack)).[ipa_is_empty_stack] :< _b).
Notation "_a '.[stack].[ipa_is_empty_stack]' ':<' _b" := (update_RData_stack_ipa_is_empty_stack _a _b) (at level 1).

Definition update_RData_func_sp_attest_setup_platform_token_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[attest_setup_platform_token_sp] :< _b).
Notation "_a '.[func_sp].[attest_setup_platform_token_sp]' ':<' _b" := (update_RData_func_sp_attest_setup_platform_token_sp _a _b) (at level 1).

Definition update_RData_func_sp_smc_psci_complete_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[smc_psci_complete_sp] :< _b).
Notation "_a '.[func_sp].[smc_psci_complete_sp]' ':<' _b" := (update_RData_func_sp_smc_psci_complete_sp _a _b) (at level 1).

Definition update_RData_func_sp_attest_token_continue_write_state_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[attest_token_continue_write_state_sp] :< _b).
Notation "_a '.[func_sp].[attest_token_continue_write_state_sp]' ':<' _b" := (update_RData_func_sp_attest_token_continue_write_state_sp _a _b) (at level 1).

Definition update_RData_func_sp_rmm_log_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[rmm_log_sp] :< _b).
Notation "_a '.[func_sp].[rmm_log_sp]' ':<' _b" := (update_RData_func_sp_rmm_log_sp _a _b) (at level 1).

Definition update_RData_func_sp_attest_rnd_prng_init_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[attest_rnd_prng_init_sp] :< _b).
Notation "_a '.[func_sp].[attest_rnd_prng_init_sp]' ':<' _b" := (update_RData_func_sp_attest_rnd_prng_init_sp _a _b) (at level 1).

Definition update_RData_func_sp_smc_data_destroy_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[smc_data_destroy_sp] :< _b).
Notation "_a '.[func_sp].[smc_data_destroy_sp]' ':<' _b" := (update_RData_func_sp_smc_data_destroy_sp _a _b) (at level 1).

Definition update_RData_func_sp_xlat_get_llt_from_va_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[xlat_get_llt_from_va_sp] :< _b).
Notation "_a '.[func_sp].[xlat_get_llt_from_va_sp]' ':<' _b" := (update_RData_func_sp_xlat_get_llt_from_va_sp _a _b) (at level 1).

Definition update_RData_func_sp_smc_rec_create_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[smc_rec_create_sp] :< _b).
Notation "_a '.[func_sp].[smc_rec_create_sp]' ':<' _b" := (update_RData_func_sp_smc_rec_create_sp _a _b) (at level 1).

Definition update_RData_func_sp_attest_init_realm_attestation_key_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[attest_init_realm_attestation_key_sp] :< _b).
Notation "_a '.[func_sp].[attest_init_realm_attestation_key_sp]' ':<' _b" := (update_RData_func_sp_attest_init_realm_attestation_key_sp _a _b) (at level 1).

Definition update_RData_func_sp_handle_realm_rsi_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[handle_realm_rsi_sp] :< _b).
Notation "_a '.[func_sp].[handle_realm_rsi_sp]' ':<' _b" := (update_RData_func_sp_handle_realm_rsi_sp _a _b) (at level 1).

Definition update_RData_func_sp_smc_rtt_set_ripas_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[smc_rtt_set_ripas_sp] :< _b).
Notation "_a '.[func_sp].[smc_rtt_set_ripas_sp]' ':<' _b" := (update_RData_func_sp_smc_rtt_set_ripas_sp _a _b) (at level 1).

Definition update_RData_func_sp_smc_rtt_destroy_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[smc_rtt_destroy_sp] :< _b).
Notation "_a '.[func_sp].[smc_rtt_destroy_sp]' ':<' _b" := (update_RData_func_sp_smc_rtt_destroy_sp _a _b) (at level 1).

Definition update_RData_func_sp_map_unmap_ns_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[map_unmap_ns_sp] :< _b).
Notation "_a '.[func_sp].[map_unmap_ns_sp]' ':<' _b" := (update_RData_func_sp_map_unmap_ns_sp _a _b) (at level 1).

Definition update_RData_func_sp_handle_rsi_attest_token_init_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[handle_rsi_attest_token_init_sp] :< _b).
Notation "_a '.[func_sp].[handle_rsi_attest_token_init_sp]' ':<' _b" := (update_RData_func_sp_handle_rsi_attest_token_init_sp _a _b) (at level 1).

Definition update_RData_func_sp_handle_rsi_ipa_state_get_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[handle_rsi_ipa_state_get_sp] :< _b).
Notation "_a '.[func_sp].[handle_rsi_ipa_state_get_sp]' ':<' _b" := (update_RData_func_sp_handle_rsi_ipa_state_get_sp _a _b) (at level 1).

Definition update_RData_func_sp_smc_rtt_fold_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[smc_rtt_fold_sp] :< _b).
Notation "_a '.[func_sp].[smc_rtt_fold_sp]' ':<' _b" := (update_RData_func_sp_smc_rtt_fold_sp _a _b) (at level 1).

Definition update_RData_func_sp_smc_rtt_create_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[smc_rtt_create_sp] :< _b).
Notation "_a '.[func_sp].[smc_rtt_create_sp]' ':<' _b" := (update_RData_func_sp_smc_rtt_create_sp _a _b) (at level 1).

Definition update_RData_func_sp_attest_cca_token_create_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[attest_cca_token_create_sp] :< _b).
Notation "_a '.[func_sp].[attest_cca_token_create_sp]' ':<' _b" := (update_RData_func_sp_attest_cca_token_create_sp _a _b) (at level 1).

Definition update_RData_func_sp_data_create_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[data_create_sp] :< _b).
Notation "_a '.[func_sp].[data_create_sp]' ':<' _b" := (update_RData_func_sp_data_create_sp _a _b) (at level 1).

Definition update_RData_func_sp_smc_realm_create_sp(_a: RData) _b :=
  update_RData_func_sp _a ((_a.(func_sp)).[smc_realm_create_sp] :< _b).
Notation "_a '.[func_sp].[smc_realm_create_sp]' ':<' _b" := (update_RData_func_sp_smc_realm_create_sp _a _b) (at level 1).

