Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Parameter zero_granule_data : ZMap.t Z.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter iasm_get_par_el1_oracle : RData -> Z.

Parameter memcpy_ns_buffer_read_byte_spec_state_oracle : Z -> (Z -> (Z -> (RData -> (option (bool * RData))))).

Parameter memcpy_ns_buffer_write_byte_spec_state_oracle : Z -> (Z -> (Z -> (RData -> (option (bool * RData))))).

Section Bottom_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition attest_get_platform_token_spec (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition __sca_read64_spec (ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    (load_RData 64 ptr st).

  Definition __sca_read64_acquire_spec (ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    (load_RData 64 ptr st).

  Definition __sca_write64_spec (ptr: Ptr) (val: Z) (st: RData) : (option RData) :=
    (store_RData 64 ptr val st).

  Definition __sca_write64_release_spec (v_state1: Ptr) (v_state: Z) (st: RData) : (option RData) :=
    (store_RData 64 v_state1 v_state st).

  Definition invalidate_block_spec (ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition pico_rec_enter_spec (rec: Ptr) (arg2: Z) (arg3: Z) (ent_ret: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition run_realm_spec (regs: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition rec_run_loop_spec (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition validate_gic_state_spec (v_0: Ptr) (st: RData) : (option (bool * RData)) :=
    (Some (true, st)).

  Definition ST_GRANULE_SIZE  : Z :=
    16.

  Definition atomic_load_add_release_64_spec (loc: Ptr) (val: Z) (st: RData) : (option (Z * RData)) :=
    rely (((loc.(pbase)) = ("granules")));
    rely (((loc.(poffset)) >= (0)));
    rely ((((loc.(poffset)) mod (ST_GRANULE_SIZE)) = (8)));
    when v, st == ((load_RData 64 loc st));
    when st == ((store_RData 64 loc (v + (val)) st));
    (Some ((v + (val)), st)).

  Definition iasm_33_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntfrq_el0)), st)).

  Definition iasm_get_cnthctl_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cnthctl_el2)), st)).

  Definition iasm_207_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_icc_sre_el2)), st)).

  Definition iasm_set_cnthctl_el2_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cnthctl_el2] :< val)).

  Definition iasm_145_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_icc_sre_el2] :< val)).

  Definition iasm_set_spsr_el2_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_spsr_el2] :< val)).

  Definition iasm_set_hcr_el2_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_hcr_el2] :< val)).

  Definition iasm_8_spec (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_9_spec (val: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_10_spec (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_12_isb_spec (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_12_spec (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_31_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)), st)).

  Definition iasm_35_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_vmcr_el2] :< val)).

  Definition iasm_36_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_hcr_el2] :< val)).

  Definition iasm_37_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_vmcr_el2)), st)).

  Definition iasm_38_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_hcr_el2)), st)).

  Definition iasm_39_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_misr_el2)), st)).

  Definition iasm_74_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)), st)).

  Definition iasm_81_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ttbr0_el12)), st)).

  Definition iasm_98_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_ap0r0_el2)), st)).

  Definition iasm_99_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_ap0r3_el2)), st)).

  Definition iasm_100_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_ap0r2_el2)), st)).

  Definition iasm_101_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_ap0r1_el2)), st)).

  Definition iasm_102_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_ap1r0_el2)), st)).

  Definition iasm_103_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_ap1r3_el2)), st)).

  Definition iasm_104_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_ap1r2_el2)), st)).

  Definition iasm_105_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_ap1r1_el2)), st)).

  Definition iasm_117_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr0_el2)), st)).

  Definition iasm_118_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr15_el2)), st)).

  Definition iasm_119_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr14_el2)), st)).

  Definition iasm_120_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr13_el2)), st)).

  Definition iasm_121_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr12_el2)), st)).

  Definition iasm_122_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr11_el2)), st)).

  Definition iasm_123_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr10_el2)), st)).

  Definition iasm_124_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr9_el2)), st)).

  Definition iasm_125_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr8_el2)), st)).

  Definition iasm_126_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr7_el2)), st)).

  Definition iasm_127_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr6_el2)), st)).

  Definition iasm_128_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr5_el2)), st)).

  Definition iasm_129_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr4_el2)), st)).

  Definition iasm_130_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr3_el2)), st)).

  Definition iasm_131_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr2_el2)), st)).

  Definition iasm_132_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr1_el2)), st)).

  Definition iasm_212_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_elr_el12)), st)).

  Definition iasm_213_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_spsr_el12)), st)).

  Definition iasm_258_spec (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_261_spec (val: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_264_spec (val: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_270_spec (val: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_277_spec (val: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_278_spec (val: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_281_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_ap0r0_el2] :< val)).

  Definition iasm_282_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_ap0r3_el2] :< val)).

  Definition iasm_283_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_ap0r2_el2] :< val)).

  Definition iasm_284_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_ap0r1_el2] :< val)).

  Definition iasm_285_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_ap1r0_el2] :< val)).

  Definition iasm_286_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_ap1r3_el2] :< val)).

  Definition iasm_287_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_ap1r2_el2] :< val)).

  Definition iasm_288_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_ap1r1_el2] :< val)).

  Definition iasm_289_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr0_el2] :< val)).

  Definition iasm_290_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr15_el2] :< val)).

  Definition iasm_291_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr14_el2] :< val)).

  Definition iasm_292_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr13_el2] :< val)).

  Definition iasm_293_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr12_el2] :< val)).

  Definition iasm_294_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr11_el2] :< val)).

  Definition iasm_295_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr10_el2] :< val)).

  Definition iasm_296_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr9_el2] :< val)).

  Definition iasm_297_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr8_el2] :< val)).

  Definition iasm_298_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr7_el2] :< val)).

  Definition iasm_299_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr6_el2] :< val)).

  Definition iasm_300_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr5_el2] :< val)).

  Definition iasm_301_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr4_el2] :< val)).

  Definition iasm_302_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr3_el2] :< val)).

  Definition iasm_303_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr2_el2] :< val)).

  Definition iasm_304_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_lr1_el2] :< val)).

  Definition iasm_set_vttbr_el2_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_vttbr_el2] :< val)).

  Definition iasm_get_vttbr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_vttbr_el2)), st)).

  Definition iasm_get_pmcr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmcr_el0)), st)).

  Definition iasm_get_pmuserenr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmuserenr_el0)), st)).

  Definition iasm_get_tpidrro_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_tpidrro_el0)), st)).

  Definition iasm_get_tpidr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_tpidr_el0)), st)).

  Definition iasm_get_csselr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_csselr_el1)), st)).

  Definition iasm_219_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_sctlr_el12)), st)).

  Definition iasm_get_actlr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_actlr_el1)), st)).

  Definition iasm_221_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cpacr_el12)), st)).

  Definition iasm_84_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ttbr1_el12)), st)).

  Definition iasm_224_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_tcr_el12)), st)).

  Definition iasm_225_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_esr_el12)), st)).

  Definition iasm_226_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_afsr0_el12)), st)).

  Definition iasm_227_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_afsr1_el12)), st)).

  Definition iasm_228_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_far_el12)), st)).

  Definition iasm_229_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_mair_el12)), st)).

  Definition iasm_230_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_vbar_el12)), st)).

  Definition iasm_231_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_contextidr_el12)), st)).

  Definition iasm_233_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_amair_el12)), st)).

  Definition iasm_get_tpidr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_tpidr_el1)), st)).

  Definition iasm_234_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntkctl_el12)), st)).

  Definition iasm_get_mdscr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_mdscr_el1)), st)).

  Definition iasm_get_mdccint_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_mdccint_el1)), st)).

  Definition iasm_get_disr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_disr_el1)), st)).

  Definition iasm_get_cntvoff_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntvoff_el2)), st)).

  Definition iasm_7_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntp_ctl_el02)), st)).

  Definition iasm_139_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntp_cval_el02)), st)).

  Definition iasm_6_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntv_ctl_el02)), st)).

  Definition iasm_136_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntv_cval_el02)), st)).

  Definition iasm_set_sp_el0_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_sp_el0] :< val)).

  Definition iasm_set_sp_el1_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_sp_el1] :< val)).

  Definition iasm_153_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_elr_el12] :< val)).

  Definition iasm_154_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_spsr_el12] :< val)).

  Definition iasm_set_pmcr_el0_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmcr_el0] :< val)).

  Definition iasm_set_pmuserenr_el0_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmuserenr_el0] :< val)).

  Definition iasm_set_tpidrro_el0_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_tpidrro_el0] :< val)).

  Definition iasm_set_tpidr_el0_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_tpidr_el0] :< val)).

  Definition iasm_set_csselr_el1_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_csselr_el1] :< val)).

  Definition iasm_75_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_sctlr_el12] :< val)).

  Definition iasm_set_actlr_el1_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_actlr_el1] :< val)).

  Definition iasm_162_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cpacr_el12] :< val)).

  Definition iasm_88_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ttbr1_el12] :< val)).

  Definition iasm_82_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ttbr0_el12] :< val)).

  Definition iasm_76_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_tcr_el12] :< val)).

  Definition iasm_166_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_esr_el12] :< val)).

  Definition iasm_167_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_afsr0_el12] :< val)).

  Definition iasm_168_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_afsr1_el12] :< val)).

  Definition iasm_169_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_far_el12] :< val)).

  Definition iasm_170_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_mair_el12] :< val)).

  Definition iasm_77_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_vbar_el12] :< val)).

  Definition iasm_172_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_contextidr_el12] :< val)).

  Definition iasm_set_tpidr_el1_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_tpidr_el1] :< val)).

  Definition iasm_174_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_amair_el12] :< val)).

  Definition iasm_175_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntkctl_el12] :< val)).

  Definition iasm_set_par_el1_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_par_el1] :< val)).

  Definition iasm_set_mdscr_el1_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_mdscr_el1] :< val)).

  Definition iasm_set_mdccint_el1_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_mdccint_el1] :< val)).

  Definition iasm_set_disr_el1_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_disr_el1] :< val)).

  Definition iasm_set_vmpidr_el2_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_vmpidr_el2] :< val)).

  Definition iasm_set_cntvoff_el2_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntvoff_el2] :< val)).

  Definition iasm_182_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntp_cval_el02] :< val)).

  Definition iasm_183_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntp_ctl_el02] :< val)).

  Definition iasm_184_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntv_cval_el02] :< val)).

  Definition iasm_185_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntv_ctl_el02] :< val)).

  Definition iasm_get_par_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((iasm_get_par_el1_oracle st), st)).

  Definition iasm_get_elr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_elr_el2)), st)).

  Definition iasm_set_elr_el2_spec (val: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_elr_el2] :< val)).

  Definition iasm_get_spsr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)), st)).

  Definition iasm_get_sp_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_sp_el0)), st)).

  Definition iasm_get_sp_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_sp_el1)), st)).

  Definition iasm_get_id_aa64mmfr0_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)), st)).

  Definition memcpy_spec (v_dst: Ptr) (v_src: Ptr) (v_len: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some (v_dst, st)).

  Definition memset_spec (v_s: Ptr) (c: Z) (n: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((((v_s.(pbase)) =s ("granule_data")) && ((c =? (0)))) && ((n =? (GRANULE_SIZE))))
    then (
      let g_idx := ((v_s.(poffset)) / (GRANULE_SIZE)) in
      let g_data := (((st.(share)).(granule_data)) @ g_idx) in
      (Some (v_s, (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == (g_data.[g_norm] :< zero_granule_data))))))
    else (Some (v_s, st)).

  Definition ns_buffer_read_byte_spec (src_pa: Z) (size: Z) (dst_pa: Z) (st: RData) : (option (bool * RData)) :=
    (memcpy_ns_buffer_read_byte_spec_state_oracle dst_pa src_pa size st).

  Definition ns_buffer_write_byte_spec (src_pa: Z) (size: Z) (dst_pa: Z) (st: RData) : (option (bool * RData)) :=
    (memcpy_ns_buffer_write_byte_spec_state_oracle dst_pa src_pa size st).

  Definition PA_TO_VA (pa: Z) : Z :=
    0.

  Definition llvm_memcpy_p0i8_p0i8_i64_spec (v_dest: Ptr) (v_src: Ptr) (sz: Z) (is_volatile: bool) (st: RData) : (option RData) :=
    (Some st).

End Bottom_Spec.

#[global] Hint Unfold attest_get_platform_token_spec: spec.
#[global] Hint Unfold __sca_read64_spec: spec.
#[global] Hint Unfold __sca_read64_acquire_spec: spec.
#[global] Hint Unfold __sca_write64_spec: spec.
#[global] Hint Unfold __sca_write64_release_spec: spec.
#[global] Hint Unfold invalidate_block_spec: spec.
#[global] Hint Unfold pico_rec_enter_spec: spec.
#[global] Hint Unfold run_realm_spec: spec.
#[global] Hint Unfold rec_run_loop_spec: spec.
#[global] Hint Unfold validate_gic_state_spec: spec.
#[global] Hint Unfold ST_GRANULE_SIZE: spec.
#[global] Hint Unfold atomic_load_add_release_64_spec: spec.
#[global] Hint Unfold iasm_33_spec: spec.
#[global] Hint Unfold iasm_get_cnthctl_el2_spec: spec.
#[global] Hint Unfold iasm_207_spec: spec.
#[global] Hint Unfold iasm_set_cnthctl_el2_spec: spec.
#[global] Hint Unfold iasm_145_spec: spec.
#[global] Hint Unfold iasm_set_spsr_el2_spec: spec.
#[global] Hint Unfold iasm_set_hcr_el2_spec: spec.
#[global] Hint Unfold iasm_8_spec: spec.
#[global] Hint Unfold iasm_9_spec: spec.
#[global] Hint Unfold iasm_10_spec: spec.
#[global] Hint Unfold iasm_12_isb_spec: spec.
#[global] Hint Unfold iasm_12_spec: spec.
#[global] Hint Unfold iasm_31_spec: spec.
#[global] Hint Unfold iasm_35_spec: spec.
#[global] Hint Unfold iasm_36_spec: spec.
#[global] Hint Unfold iasm_37_spec: spec.
#[global] Hint Unfold iasm_38_spec: spec.
#[global] Hint Unfold iasm_39_spec: spec.
#[global] Hint Unfold iasm_74_spec: spec.
#[global] Hint Unfold iasm_81_spec: spec.
#[global] Hint Unfold iasm_98_spec: spec.
#[global] Hint Unfold iasm_99_spec: spec.
#[global] Hint Unfold iasm_100_spec: spec.
#[global] Hint Unfold iasm_101_spec: spec.
#[global] Hint Unfold iasm_102_spec: spec.
#[global] Hint Unfold iasm_103_spec: spec.
#[global] Hint Unfold iasm_104_spec: spec.
#[global] Hint Unfold iasm_105_spec: spec.
#[global] Hint Unfold iasm_117_spec: spec.
#[global] Hint Unfold iasm_118_spec: spec.
#[global] Hint Unfold iasm_119_spec: spec.
#[global] Hint Unfold iasm_120_spec: spec.
#[global] Hint Unfold iasm_121_spec: spec.
#[global] Hint Unfold iasm_122_spec: spec.
#[global] Hint Unfold iasm_123_spec: spec.
#[global] Hint Unfold iasm_124_spec: spec.
#[global] Hint Unfold iasm_125_spec: spec.
#[global] Hint Unfold iasm_126_spec: spec.
#[global] Hint Unfold iasm_127_spec: spec.
#[global] Hint Unfold iasm_128_spec: spec.
#[global] Hint Unfold iasm_129_spec: spec.
#[global] Hint Unfold iasm_130_spec: spec.
#[global] Hint Unfold iasm_131_spec: spec.
#[global] Hint Unfold iasm_132_spec: spec.
#[global] Hint Unfold iasm_212_spec: spec.
#[global] Hint Unfold iasm_213_spec: spec.
#[global] Hint Unfold iasm_258_spec: spec.
#[global] Hint Unfold iasm_261_spec: spec.
#[global] Hint Unfold iasm_264_spec: spec.
#[global] Hint Unfold iasm_270_spec: spec.
#[global] Hint Unfold iasm_277_spec: spec.
#[global] Hint Unfold iasm_278_spec: spec.
#[global] Hint Unfold iasm_281_spec: spec.
#[global] Hint Unfold iasm_282_spec: spec.
#[global] Hint Unfold iasm_283_spec: spec.
#[global] Hint Unfold iasm_284_spec: spec.
#[global] Hint Unfold iasm_285_spec: spec.
#[global] Hint Unfold iasm_286_spec: spec.
#[global] Hint Unfold iasm_287_spec: spec.
#[global] Hint Unfold iasm_288_spec: spec.
#[global] Hint Unfold iasm_289_spec: spec.
#[global] Hint Unfold iasm_290_spec: spec.
#[global] Hint Unfold iasm_291_spec: spec.
#[global] Hint Unfold iasm_292_spec: spec.
#[global] Hint Unfold iasm_293_spec: spec.
#[global] Hint Unfold iasm_294_spec: spec.
#[global] Hint Unfold iasm_295_spec: spec.
#[global] Hint Unfold iasm_296_spec: spec.
#[global] Hint Unfold iasm_297_spec: spec.
#[global] Hint Unfold iasm_298_spec: spec.
#[global] Hint Unfold iasm_299_spec: spec.
#[global] Hint Unfold iasm_300_spec: spec.
#[global] Hint Unfold iasm_301_spec: spec.
#[global] Hint Unfold iasm_302_spec: spec.
#[global] Hint Unfold iasm_303_spec: spec.
#[global] Hint Unfold iasm_304_spec: spec.
#[global] Hint Unfold iasm_set_vttbr_el2_spec: spec.
#[global] Hint Unfold iasm_get_vttbr_el2_spec: spec.
#[global] Hint Unfold iasm_get_pmcr_el0_spec: spec.
#[global] Hint Unfold iasm_get_pmuserenr_el0_spec: spec.
#[global] Hint Unfold iasm_get_tpidrro_el0_spec: spec.
#[global] Hint Unfold iasm_get_tpidr_el0_spec: spec.
#[global] Hint Unfold iasm_get_csselr_el1_spec: spec.
#[global] Hint Unfold iasm_219_spec: spec.
#[global] Hint Unfold iasm_get_actlr_el1_spec: spec.
#[global] Hint Unfold iasm_221_spec: spec.
#[global] Hint Unfold iasm_84_spec: spec.
#[global] Hint Unfold iasm_224_spec: spec.
#[global] Hint Unfold iasm_225_spec: spec.
#[global] Hint Unfold iasm_226_spec: spec.
#[global] Hint Unfold iasm_227_spec: spec.
#[global] Hint Unfold iasm_228_spec: spec.
#[global] Hint Unfold iasm_229_spec: spec.
#[global] Hint Unfold iasm_230_spec: spec.
#[global] Hint Unfold iasm_231_spec: spec.
#[global] Hint Unfold iasm_233_spec: spec.
#[global] Hint Unfold iasm_get_tpidr_el1_spec: spec.
#[global] Hint Unfold iasm_234_spec: spec.
#[global] Hint Unfold iasm_get_mdscr_el1_spec: spec.
#[global] Hint Unfold iasm_get_mdccint_el1_spec: spec.
#[global] Hint Unfold iasm_get_disr_el1_spec: spec.
#[global] Hint Unfold iasm_get_cntvoff_el2_spec: spec.
#[global] Hint Unfold iasm_7_spec: spec.
#[global] Hint Unfold iasm_139_spec: spec.
#[global] Hint Unfold iasm_6_spec: spec.
#[global] Hint Unfold iasm_136_spec: spec.
#[global] Hint Unfold iasm_set_sp_el0_spec: spec.
#[global] Hint Unfold iasm_set_sp_el1_spec: spec.
#[global] Hint Unfold iasm_153_spec: spec.
#[global] Hint Unfold iasm_154_spec: spec.
#[global] Hint Unfold iasm_set_pmcr_el0_spec: spec.
#[global] Hint Unfold iasm_set_pmuserenr_el0_spec: spec.
#[global] Hint Unfold iasm_set_tpidrro_el0_spec: spec.
#[global] Hint Unfold iasm_set_tpidr_el0_spec: spec.
#[global] Hint Unfold iasm_set_csselr_el1_spec: spec.
#[global] Hint Unfold iasm_75_spec: spec.
#[global] Hint Unfold iasm_set_actlr_el1_spec: spec.
#[global] Hint Unfold iasm_162_spec: spec.
#[global] Hint Unfold iasm_88_spec: spec.
#[global] Hint Unfold iasm_82_spec: spec.
#[global] Hint Unfold iasm_76_spec: spec.
#[global] Hint Unfold iasm_166_spec: spec.
#[global] Hint Unfold iasm_167_spec: spec.
#[global] Hint Unfold iasm_168_spec: spec.
#[global] Hint Unfold iasm_169_spec: spec.
#[global] Hint Unfold iasm_170_spec: spec.
#[global] Hint Unfold iasm_77_spec: spec.
#[global] Hint Unfold iasm_172_spec: spec.
#[global] Hint Unfold iasm_set_tpidr_el1_spec: spec.
#[global] Hint Unfold iasm_174_spec: spec.
#[global] Hint Unfold iasm_175_spec: spec.
#[global] Hint Unfold iasm_set_par_el1_spec: spec.
#[global] Hint Unfold iasm_set_mdscr_el1_spec: spec.
#[global] Hint Unfold iasm_set_mdccint_el1_spec: spec.
#[global] Hint Unfold iasm_set_disr_el1_spec: spec.
#[global] Hint Unfold iasm_set_vmpidr_el2_spec: spec.
#[global] Hint Unfold iasm_set_cntvoff_el2_spec: spec.
#[global] Hint Unfold iasm_182_spec: spec.
#[global] Hint Unfold iasm_183_spec: spec.
#[global] Hint Unfold iasm_184_spec: spec.
#[global] Hint Unfold iasm_185_spec: spec.
#[global] Hint Unfold iasm_get_par_el1_spec: spec.
#[global] Hint Unfold iasm_get_elr_el2_spec: spec.
#[global] Hint Unfold iasm_set_elr_el2_spec: spec.
#[global] Hint Unfold iasm_get_spsr_el2_spec: spec.
#[global] Hint Unfold iasm_get_sp_el0_spec: spec.
#[global] Hint Unfold iasm_get_sp_el1_spec: spec.
#[global] Hint Unfold iasm_get_id_aa64mmfr0_el1_spec: spec.
#[global] Hint Unfold memcpy_spec: spec.
#[global] Hint Unfold memset_spec: spec.
#[global] Hint Unfold ns_buffer_read_byte_spec: spec.
#[global] Hint Unfold ns_buffer_write_byte_spec: spec.
Opaque PA_TO_VA.
#[global] Hint Unfold llvm_memcpy_p0i8_p0i8_i64_spec: spec.
