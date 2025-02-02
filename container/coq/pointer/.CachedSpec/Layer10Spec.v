Definition restore_sysreg_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
  rely (
    ((((v_0.(pbase)) = ("stack_s_ns_state")) /\ (((v_0.(poffset)) = (0)))) \/
      (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)))));
  rely (
    ((((v_0.(pbase)) = ("stack_s_ns_state")) /\ (((v_0.(poffset)) = (0)))) \/
      (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (288)))))));
  if ((v_0.(pbase)) =s ("stack_s_ns_state"))
  then (
    (Some (((((((((((((((((((((((((((((((((((st.[priv].[pcpu_regs].[pcpu_actlr_el1] :< ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_actlr_el1))).[priv].[pcpu_regs].[pcpu_afsr0_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_afsr0_el1))).[priv].[pcpu_regs].[pcpu_afsr1_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_afsr1_el1))).[priv].[pcpu_regs].[pcpu_amair_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_amair_el1))).[priv].[pcpu_regs].[pcpu_cntkctl_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_cntkctl_el1))).[priv].[pcpu_regs].[pcpu_cntp_ctl_el02] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_cntp_ctl_el0))).[priv].[pcpu_regs].[pcpu_cntp_cval_el02] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_cntp_cval_el0))).[priv].[pcpu_regs].[pcpu_cntv_ctl_el02] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_cntv_ctl_el0))).[priv].[pcpu_regs].[pcpu_cntv_cval_el02] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_cntv_cval_el0))).[priv].[pcpu_regs].[pcpu_cntvoff_el2] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_cntvoff_el2))).[priv].[pcpu_regs].[pcpu_contextidr_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_contextidr_el1))).[priv].[pcpu_regs].[pcpu_cpacr_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_cpacr_el1))).[priv].[pcpu_regs].[pcpu_csselr_el1] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_csselr_el1))).[priv].[pcpu_regs].[pcpu_disr_el1] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_disr_el1))).[priv].[pcpu_regs].[pcpu_elr_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_elr_el1))).[priv].[pcpu_regs].[pcpu_esr_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_esr_el1))).[priv].[pcpu_regs].[pcpu_far_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_far_el1))).[priv].[pcpu_regs].[pcpu_mair_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_mair_el1))).[priv].[pcpu_regs].[pcpu_mdccint_el1] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_mdccint_el1))).[priv].[pcpu_regs].[pcpu_mdscr_el1] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_mdscr_el1))).[priv].[pcpu_regs].[pcpu_par_el1] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_par_el1))).[priv].[pcpu_regs].[pcpu_pmcr_el0] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_pmcr_el0))).[priv].[pcpu_regs].[pcpu_pmuserenr_el0] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_pmuserenr_el0))).[priv].[pcpu_regs].[pcpu_sctlr_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_sctlr_el1))).[priv].[pcpu_regs].[pcpu_sp_el0] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_sp_el0))).[priv].[pcpu_regs].[pcpu_sp_el1] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_sp_el1))).[priv].[pcpu_regs].[pcpu_spsr_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_spsr_el1))).[priv].[pcpu_regs].[pcpu_tcr_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_tcr_el1))).[priv].[pcpu_regs].[pcpu_tpidr_el0] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_tpidr_el0))).[priv].[pcpu_regs].[pcpu_tpidr_el1] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_tpidr_el1))).[priv].[pcpu_regs].[pcpu_tpidrro_el0] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_tpidrro_el0))).[priv].[pcpu_regs].[pcpu_ttbr0_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_ttbr0_el1))).[priv].[pcpu_regs].[pcpu_ttbr1_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_ttbr1_el1))).[priv].[pcpu_regs].[pcpu_vbar_el12] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_vbar_el1_s_sysreg_state))).[priv].[pcpu_regs].[pcpu_vmpidr_el2] :<
      ((((st.(stack)).(stack_s_ns_state)).(e_sysregs_s_ns_state)).(e_vmpidr_el2)))))
  else (
    (Some (((((((((((((((((((((((((((((((((((st.[priv].[pcpu_regs].[pcpu_actlr_el1] :< ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (80)) / (4096))).(g_rec)).(e_sysregs)).(e_actlr_el1))).[priv].[pcpu_regs].[pcpu_afsr0_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (136)) / (4096))).(g_rec)).(e_sysregs)).(e_afsr0_el1))).[priv].[pcpu_regs].[pcpu_afsr1_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (144)) / (4096))).(g_rec)).(e_sysregs)).(e_afsr1_el1))).[priv].[pcpu_regs].[pcpu_amair_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (192)) / (4096))).(g_rec)).(e_sysregs)).(e_amair_el1))).[priv].[pcpu_regs].[pcpu_cntkctl_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (200)) / (4096))).(g_rec)).(e_sysregs)).(e_cntkctl_el1))).[priv].[pcpu_regs].[pcpu_cntp_ctl_el02] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (264)) / (4096))).(g_rec)).(e_sysregs)).(e_cntp_ctl_el0))).[priv].[pcpu_regs].[pcpu_cntp_cval_el02] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (272)) / (4096))).(g_rec)).(e_sysregs)).(e_cntp_cval_el0))).[priv].[pcpu_regs].[pcpu_cntv_ctl_el02] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (280)) / (4096))).(g_rec)).(e_sysregs)).(e_cntv_ctl_el0))).[priv].[pcpu_regs].[pcpu_cntv_cval_el02] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (288)) / (4096))).(g_rec)).(e_sysregs)).(e_cntv_cval_el0))).[priv].[pcpu_regs].[pcpu_cntvoff_el2] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (256)) / (4096))).(g_rec)).(e_sysregs)).(e_cntvoff_el2))).[priv].[pcpu_regs].[pcpu_contextidr_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (176)) / (4096))).(g_rec)).(e_sysregs)).(e_contextidr_el1))).[priv].[pcpu_regs].[pcpu_cpacr_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (88)) / (4096))).(g_rec)).(e_sysregs)).(e_cpacr_el1))).[priv].[pcpu_regs].[pcpu_csselr_el1] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (64)) / (4096))).(g_rec)).(e_sysregs)).(e_csselr_el1))).[priv].[pcpu_regs].[pcpu_disr_el1] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (232)) / (4096))).(g_rec)).(e_sysregs)).(e_disr_el1))).[priv].[pcpu_regs].[pcpu_elr_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rec)).(e_sysregs)).(e_elr_el1))).[priv].[pcpu_regs].[pcpu_esr_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (128)) / (4096))).(g_rec)).(e_sysregs)).(e_esr_el1))).[priv].[pcpu_regs].[pcpu_far_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (152)) / (4096))).(g_rec)).(e_sysregs)).(e_far_el1))).[priv].[pcpu_regs].[pcpu_mair_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (160)) / (4096))).(g_rec)).(e_sysregs)).(e_mair_el1))).[priv].[pcpu_regs].[pcpu_mdccint_el1] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (224)) / (4096))).(g_rec)).(e_sysregs)).(e_mdccint_el1))).[priv].[pcpu_regs].[pcpu_mdscr_el1] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (216)) / (4096))).(g_rec)).(e_sysregs)).(e_mdscr_el1))).[priv].[pcpu_regs].[pcpu_par_el1] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (208)) / (4096))).(g_rec)).(e_sysregs)).(e_par_el1))).[priv].[pcpu_regs].[pcpu_pmcr_el0] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (32)) / (4096))).(g_rec)).(e_sysregs)).(e_pmcr_el0))).[priv].[pcpu_regs].[pcpu_pmuserenr_el0] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (40)) / (4096))).(g_rec)).(e_sysregs)).(e_pmuserenr_el0))).[priv].[pcpu_regs].[pcpu_sctlr_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (72)) / (4096))).(g_rec)).(e_sysregs)).(e_sctlr_el1))).[priv].[pcpu_regs].[pcpu_sp_el0] :<
      ((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_rec)).(e_sysregs)).(e_sp_el0))).[priv].[pcpu_regs].[pcpu_sp_el1] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (8)) / (4096))).(g_rec)).(e_sysregs)).(e_sp_el1))).[priv].[pcpu_regs].[pcpu_spsr_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (24)) / (4096))).(g_rec)).(e_sysregs)).(e_spsr_el1))).[priv].[pcpu_regs].[pcpu_tcr_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (120)) / (4096))).(g_rec)).(e_sysregs)).(e_tcr_el1))).[priv].[pcpu_regs].[pcpu_tpidr_el0] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (56)) / (4096))).(g_rec)).(e_sysregs)).(e_tpidr_el0))).[priv].[pcpu_regs].[pcpu_tpidr_el1] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (184)) / (4096))).(g_rec)).(e_sysregs)).(e_tpidr_el1))).[priv].[pcpu_regs].[pcpu_tpidrro_el0] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (48)) / (4096))).(g_rec)).(e_sysregs)).(e_tpidrro_el0))).[priv].[pcpu_regs].[pcpu_ttbr0_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (104)) / (4096))).(g_rec)).(e_sysregs)).(e_ttbr0_el1))).[priv].[pcpu_regs].[pcpu_ttbr1_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (112)) / (4096))).(g_rec)).(e_sysregs)).(e_ttbr1_el1))).[priv].[pcpu_regs].[pcpu_vbar_el12] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (168)) / (4096))).(g_rec)).(e_sysregs)).(e_vbar_el1_s_sysreg_state))).[priv].[pcpu_regs].[pcpu_vmpidr_el2] :<
      ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (512)) / (4096))).(g_rec)).(e_sysregs)).(e_vmpidr_el2))))).

Definition get_rd_state_locked_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
  rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
  (Some ((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_rd)).(e_state_s_rd)), st)).

