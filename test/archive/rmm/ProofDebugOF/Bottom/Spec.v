Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter fxlt_ret_succ : Ptr.

Parameter xgtp_ret_succ : Ptr.

Parameter xrt_ret_succ : Z.

Parameter monitor_call_state_oracle : Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (RData -> (option (Z * RData))))))))).

Parameter verify_input_parameters_consistency_spec_oracle : Ptr -> (RData -> bool).

Parameter handle_rsi_read_measurement_spec_oralce : RData -> (option (Z * RData)).

Parameter handle_rsi_extend_measurement_spec_oralce : RData -> (option (Z * RData)).

Parameter handle_rsi_attest_token_continue_spec_oralce : RData -> (option RData).

Section Bottom_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition status_ptr_spec (v_status: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some ((mkPtr "status" v_status), st)).

  Definition ptr_status_spec (v_ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    if ((v_ptr.(pbase)) =s ("status"))
    then (Some ((v_ptr.(poffset)), st))
    else (Some (0, st)).

  Definition ptr_is_err_spec (v_ptr: Ptr) (st: RData) : (option (bool * RData)) :=
    if ((v_ptr.(pbase)) =s ("status"))
    then (Some (true, st))
    else (Some (false, st)).

  Definition table_entry_to_phys_spec (v_entry1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((v_entry1 & (281474976710655)), st)).

  Definition ptr_eqb (p1: Ptr) (p2: Ptr) : bool :=
    (((p1.(pbase)) =s ((p2.(pbase)))) && (((p1.(poffset)) =? ((p2.(poffset)))))).

  Definition ptr_lt (p1: Ptr) (p2: Ptr) : bool :=
    ((p1.(poffset)) <? ((p2.(poffset)))).

  Definition ptr_gt (p1: Ptr) (p2: Ptr) : bool :=
    ((p1.(poffset)) >? ((p2.(poffset)))).

  Definition spinlock_acquire_spec (lock: Ptr) (st: RData) : (option RData) :=
    if ((lock.(pbase)) =s ("granules"))
    then (
      let ofs := (lock.(poffset)) in
      let gidx_l := (ofs / (ST_GRANULE_SIZE)) in
      when st1 == ((query_oracle st));
      let g := (((st1.(share)).(granules)) @ gidx_l) in
      match ((g.(e_lock))) with
      | None =>
        let e := (EVT CPU_ID (ACQ gidx_l)) in
        let new_granules := (((st1.(share)).(granules)) # gidx_l == (g.[e_lock] :< (Some CPU_ID))) in
        let new_st := (st1.[share].[granules] :< new_granules) in
        rely ((((((st.(share)).(granules)) @ gidx_l).(e_state)) = ((g.(e_state)))));
        (Some (new_st.[log] :< (e :: ((new_st.(log))))))
      | (Some cid) => None
      end)
    else None.

  Definition spinlock_release_spec (lock: Ptr) (st: RData) : (option RData) :=
    if ((lock.(pbase)) =s ("granules"))
    then (
      let ofs := (lock.(poffset)) in
      let gidx_l := (ofs / (ST_GRANULE_SIZE)) in
      let g := (((st.(share)).(granules)) @ gidx_l) in
      when cid == ((g.(e_lock)));
      let e := (EVT CPU_ID (REL gidx_l g)) in
      let new_granules := (((st.(share)).(granules)) # gidx_l == (g.[e_lock] :< None)) in
      let new_st := (st.[share].[granules] :< new_granules) in
      (Some (new_st.[log] :< (e :: ((new_st.(log)))))))
    else None.

  Definition __assert_fail_spec (st: RData) : (option RData) :=
    None.

  Definition llvm_memcpy_p0i8_p0i8_i64_spec (v_dest: Ptr) (v_src: Ptr) (sz: Z) (is_volatile: bool) (st: RData) : (option RData) :=
    if (sz =? (24))
    then (
      when v0, st == ((load_RData 8 v_src st));
      when v1, st == ((load_RData 8 (ptr_offset v_src 8) st));
      when v2, st == ((load_RData 8 (ptr_offset v_src 16) st));
      when st == ((store_RData 8 v_dest v0 st));
      when st == ((store_RData 8 (ptr_offset v_dest 8) v1 st));
      when st == ((store_RData 8 (ptr_offset v_dest 16) v2 st));
      (Some st))
    else (
      if (sz =? (32))
      then (
        if (((v_dest.(pbase)) =s ("stack_s2_ctx")) && (((v_src.(pbase)) =s ("slot_rd"))))
        then (Some (st.[stack].[stack_s2_ctx] :< (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx))))
        else None)
      else (
        if (sz =? (40))
        then (
          when v0, st == ((load_RData 8 v_src st));
          when v1, st == ((load_RData 8 (ptr_offset v_src 8) st));
          when v2, st == ((load_RData 8 (ptr_offset v_src 16) st));
          when v3, st == ((load_RData 8 (ptr_offset v_src 24) st));
          when v4, st == ((load_RData 8 (ptr_offset v_src 32) st));
          when st == ((store_RData 8 v_dest v0 st));
          when st == ((store_RData 8 (ptr_offset v_dest 8) v1 st));
          when st == ((store_RData 8 (ptr_offset v_dest 16) v2 st));
          when st == ((store_RData 8 (ptr_offset v_dest 24) v3 st));
          when st == ((store_RData 8 (ptr_offset v_dest 32) v4 st));
          (Some st))
        else None)).

  Definition llvm_memset_p0i8_i64_spec (v_0: Ptr) (arg1: Z) (arg2: Z) (arg3: bool) (st: RData) : (option RData) :=
    if ((v_0.(pbase)) =s ("stack_g_tbls"))
    then (Some (st.[stack].[stack_g_tbls] :< (ZMap.init 0)))
    else (Some st).

  Definition memcpy_ns_read_spec (v_dest: Ptr) (v_src: Ptr) (v_conv: Z) (st: RData) : (option (bool * RData)) :=
    (Some (true, st)).

  Definition memcpy_ns_write_spec (v_dest: Ptr) (v_3: Ptr) (v_conv: Z) (st: RData) : (option (bool * RData)) :=
    (Some (true, st)).

  Definition memset_spec (v_s: Ptr) (c: Z) (n: Z) (st: RData) : (option (Ptr * RData)) :=
    let g_idx := (
        if ((v_s.(pbase)) =s ("slot_delegated"))
        then (Some (((st.(share)).(slots)) @ SLOT_DELEGATED))
        else (
          if ((v_s.(pbase)) =s ("slot_rtt2"))
          then (Some (((st.(share)).(slots)) @ SLOT_RTT2))
          else (
            if ((v_s.(pbase)) =s ("slot_rtt"))
            then (Some (((st.(share)).(slots)) @ SLOT_RTT))
            else (
              if ((v_s.(pbase)) =s ("slot_rec"))
              then (Some (((st.(share)).(slots)) @ SLOT_REC))
              else (
                if ((v_s.(pbase)) =s ("slot_rd"))
                then (Some (((st.(share)).(slots)) @ SLOT_RD))
                else None))))) in
    match (g_idx) with
    | None => (Some (v_s, st))
    | (Some idx) =>
      let g_data := (((st.(share)).(granule_data)) @ idx) in
      let g := (((st.(share)).(granules)) @ idx) in
      when cid == ((g.(e_lock)));
      (Some (
        v_s  ,
        (st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) # idx == (((g_data.[g_rec] :< empty_rec).[g_norm] :< zero_granule_data_normal).[g_rd] :< empty_rd)))
      ))
    end.

  Definition memcpy_spec (v_dst: Ptr) (v_src: Ptr) (v_len: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some (v_dst, st)).

  Definition xlat_unmap_memory_page_spec (v_table: Ptr) (v_va: Z) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition xlat_map_memory_page_with_attrs_spec (v_table: Ptr) (v_va: Z) (v_pa: Z) (v_attrs: Z) (st: RData) : (option (Z * RData)) :=
    let v_ptr := (int_to_ptr v_va) in
    let gidx := (v_pa / (GRANULE_SIZE)) in
    if ((v_ptr.(pbase)) =s ("slot_ns"))
    then (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == gidx))))
    else (
      if ((v_ptr.(pbase)) =s ("slot_delegated"))
      then (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_DELEGATED == gidx))))
      else (
        if ((v_ptr.(pbase)) =s ("slot_rd"))
        then (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == gidx))))
        else (
          if ((v_ptr.(pbase)) =s ("slot_rec"))
          then (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC == gidx))))
          else (
            if ((v_ptr.(pbase)) =s ("slot_rec2"))
            then (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC2 == gidx))))
            else (
              if ((v_ptr.(pbase)) =s ("slot_rec_target"))
              then (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_TARGET == gidx))))
              else (
                if ((v_ptr.(pbase)) =s ("slot_rec_aux0"))
                then (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_AUX0 == gidx))))
                else (
                  if ((v_ptr.(pbase)) =s ("slot_rtt"))
                  then (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == gidx))))
                  else (
                    if ((v_ptr.(pbase)) =s ("slot_rtt2"))
                    then (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT2 == gidx))))
                    else (
                      if ((v_ptr.(pbase)) =s ("slot_rsi_call"))
                      then (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RSI_CALL == gidx))))
                      else None))))))))).

  Definition find_xlat_last_table_spec (va: Z) (ctx: Ptr) (out_level: Ptr) (tt_base_va: Ptr) (st: RData) : (option (Ptr * RData)) :=
    (Some (fxlt_ret_succ, st)).

  Definition xlat_arch_setup_mmu_cfg_spec (ctx: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition xlat_ctx_init_spec (ctx: Ptr) (cfg: Ptr) (tbls_ctx: Ptr) (tables_ptr: Ptr) (ntables: Z) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition xlat_get_llt_from_va_spec (llt: Ptr) (ctx: Ptr) (va: Z) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition xlat_get_tte_ptr_spec (v_llt: Ptr) (v_va: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some (xgtp_ret_succ, st)).

  Definition xlat_read_tte_spec (v_entry1: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (xrt_ret_succ, st)).

  Definition iasm_4_spec (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_154_spec (v_v: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition iasm_155_spec (v_v: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition read_tpidr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some (CPU_ID, st)).

  Definition iasm_10_spec (st: RData) : (option RData) :=
    (Some st).

  Definition tlbivae2is_spec (v_shr: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition tlbiipas2e1is_spec (v_shr: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition tlbivmalle1is_spec (st: RData) : (option RData) :=
    (Some st).

  Definition read_vttbr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_vttbr_el2)), st)).

  Definition write_vttbr_el2_spec (vttbr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_vttbr_el2] :< vttbr)).

  Definition read_zcr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_zcr_el2)), st)).

  Definition write_zcr_el2_spec (zcr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_zcr_el2] :< zcr)).

  Definition read_elr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_elr_el2)), st)).

  Definition write_elr_el2_spec (elr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_elr_el2] :< elr)).

  Definition read_cptr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cptr_el2)), st)).

  Definition write_cptr_el2_spec (cptr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cptr_el2] :< cptr)).

  Definition isb_spec (st: RData) : (option RData) :=
    (Some st).

  Definition read_cnthctl_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cnthctl_el2)), st)).

  Definition write_cnthctl_el2_spec (v: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cnthctl_el2] :< v)).

  Definition read_pmcr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmcr_el0)), st)).

  Definition write_pmcr_el0_spec (pmcr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmcr_el0] :< pmcr)).

  Definition read_mdcr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_mdcr_el2)), st)).

  Definition write_mdcr_el2_spec (v: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_mdcr_el2] :< v)).

  Definition write_vpidr_el2_spec (v: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_vpidr_el2] :< v)).

  Definition read_sctlr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_sctlr_el2)), st)).

  Definition read_midr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_midr_el1)), st)).

  Definition read_esr_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_esr_el12)), st)).

  Definition write_esr_el12_spec (esr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_esr_el12] :< esr)).

  Definition read_esr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_esr_el2)), st)).

  Definition read_spsr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)), st)).

  Definition write_spsr_el2_spec (spsr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_spsr_el2] :< spsr)).

  Definition read_spsr_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_spsr_el12)), st)).

  Definition write_spsr_el12_spec (spsr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_spsr_el12] :< spsr)).

  Definition read_elr_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_elr_el12)), st)).

  Definition write_elr_el12_spec (elr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_elr_el12] :< elr)).

  Definition read_vbar_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_vbar_el12)), st)).

  Definition write_vbar_el12_spec (vbar: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_vbar_el12] :< vbar)).

  Definition read_hpfar_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)), st)).

  Definition read_far_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_far_el12)), st)).

  Definition write_far_el12_spec (far: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_far_el12] :< far)).

  Definition read_far_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_far_el2)), st)).

  Definition read_isr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_isr_el1)), st)).

  Definition write_vsesr_el2_spec (vsesr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_vsesr_el2] :< vsesr)).

  Definition write_hcr_el2_spec (hcr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_hcr_el2] :< hcr)).

  Definition read_id_aa64mmfr1_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)), st)).

  Definition read_id_aa64mmfr0_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)), st)).

  Definition read_id_aa64dfr0_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64dfr0_el1)), st)).

  Definition read_id_aa64dfr1_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64dfr1_el1)), st)).

  Definition read_id_aa64pfr0_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)), st)).

  Definition read_id_aa64pfr1_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr1_el1)), st)).

  Definition monitor_call_spec (id: Z) (arg0: Z) (arg1: Z) (arg2: Z) (arg3: Z) (arg4: Z) (arg5: Z) (st: RData) : (option (Z * RData)) :=
    if (id =? (SMC_RMM_GTSI_DELEGATE))
    then (
      let gidx := (arg0 / (GRANULE_SIZE)) in
      rely ((((((st.(share)).(granules)) @ gidx).(e_lock)) = ((Some CPU_ID))));
      let st := (st.[share].[gpt] :< (((st.(share)).(gpt)) # gidx == true)) in
      (Some (0, st)))
    else (
      if (id =? (SMC_RMM_GTSI_UNDELEGATE))
      then (
        let gidx := (arg0 / (GRANULE_SIZE)) in
        rely ((((((st.(share)).(granules)) @ gidx).(e_lock)) = ((Some CPU_ID))));
        let st := (st.[share].[gpt] :< (((st.(share)).(gpt)) # gidx == false)) in
        (Some (0, st)))
      else None).

  Definition monitor_call_with_res_spec (id: Z) (arg0: Z) (arg1: Z) (arg2: Z) (arg3: Z) (arg4: Z) (arg5: Z) (res: Ptr) (st: RData) : (option RData) :=
    when ret, st == ((monitor_call_state_oracle id arg0 arg1 arg2 arg3 arg4 arg5 st));
    (store_RData 8 res ret st).

  Definition run_realm_spec (regs: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition read_pmevtyper0_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper0_el0)), st)).

  Definition read_pmevtyper1_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper1_el0)), st)).

  Definition read_pmevtyper2_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper2_el0)), st)).

  Definition read_pmevtyper3_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper3_el0)), st)).

  Definition read_pmevtyper4_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper4_el0)), st)).

  Definition read_pmevtyper5_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper5_el0)), st)).

  Definition read_pmevtyper6_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper6_el0)), st)).

  Definition read_pmevtyper7_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper7_el0)), st)).

  Definition read_pmevtyper8_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper8_el0)), st)).

  Definition read_pmevtyper9_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper9_el0)), st)).

  Definition read_pmevtyper10_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper10_el0)), st)).

  Definition read_pmevtyper11_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper11_el0)), st)).

  Definition read_pmevtyper12_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper12_el0)), st)).

  Definition read_pmevtyper13_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper13_el0)), st)).

  Definition read_pmevtyper14_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper14_el0)), st)).

  Definition read_pmevtyper15_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper15_el0)), st)).

  Definition read_pmevtyper16_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper16_el0)), st)).

  Definition read_pmevtyper17_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper17_el0)), st)).

  Definition read_pmevtyper18_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper18_el0)), st)).

  Definition read_pmevtyper19_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper19_el0)), st)).

  Definition read_pmevtyper20_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper20_el0)), st)).

  Definition read_pmevtyper21_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper21_el0)), st)).

  Definition read_pmevtyper22_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper22_el0)), st)).

  Definition read_pmevtyper23_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper23_el0)), st)).

  Definition read_pmevtyper24_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper24_el0)), st)).

  Definition read_pmevtyper25_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper25_el0)), st)).

  Definition read_pmevtyper26_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper26_el0)), st)).

  Definition read_pmevtyper27_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper27_el0)), st)).

  Definition read_pmevtyper28_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper28_el0)), st)).

  Definition read_pmevtyper29_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper29_el0)), st)).

  Definition read_pmevtyper30_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevtyper30_el0)), st)).

  Definition read_pmevcntr0_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr0_el0)), st)).

  Definition read_pmevcntr1_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr1_el0)), st)).

  Definition read_pmevcntr2_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr2_el0)), st)).

  Definition read_pmevcntr3_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr3_el0)), st)).

  Definition read_pmevcntr4_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr4_el0)), st)).

  Definition read_pmevcntr5_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr5_el0)), st)).

  Definition read_pmevcntr6_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr6_el0)), st)).

  Definition read_pmevcntr7_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr7_el0)), st)).

  Definition read_pmevcntr8_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr8_el0)), st)).

  Definition read_pmevcntr9_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr9_el0)), st)).

  Definition read_pmevcntr10_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr10_el0)), st)).

  Definition read_pmevcntr11_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr11_el0)), st)).

  Definition read_pmevcntr12_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr12_el0)), st)).

  Definition read_pmevcntr13_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr13_el0)), st)).

  Definition read_pmevcntr14_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr14_el0)), st)).

  Definition read_pmevcntr15_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr15_el0)), st)).

  Definition read_pmevcntr16_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr16_el0)), st)).

  Definition read_pmevcntr17_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr17_el0)), st)).

  Definition read_pmevcntr18_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr18_el0)), st)).

  Definition read_pmevcntr19_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr19_el0)), st)).

  Definition read_pmevcntr20_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr20_el0)), st)).

  Definition read_pmevcntr21_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr21_el0)), st)).

  Definition read_pmevcntr22_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr22_el0)), st)).

  Definition read_pmevcntr23_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr23_el0)), st)).

  Definition read_pmevcntr24_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr24_el0)), st)).

  Definition read_pmevcntr25_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr25_el0)), st)).

  Definition read_pmevcntr26_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr26_el0)), st)).

  Definition read_pmevcntr27_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr27_el0)), st)).

  Definition read_pmevcntr28_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr28_el0)), st)).

  Definition read_pmevcntr29_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr29_el0)), st)).

  Definition read_pmevcntr30_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmevcntr30_el0)), st)).

  Definition read_pmccfiltr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmccfiltr_el0)), st)).

  Definition write_pmccfiltr_el0_spec (pmccfiltr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmccfiltr_el0] :< pmccfiltr)).

  Definition read_pmccntr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmccntr_el0)), st)).

  Definition write_pmccntr_el0_spec (pmccntr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmccntr_el0] :< pmccntr)).

  Definition read_pmcntenset_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmcntenset_el0)), st)).

  Definition write_pmcntenset_el0_spec (pmcntenset: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmcntenset_el0] :< pmcntenset)).

  Definition read_pmcntenclr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmcntenclr_el0)), st)).

  Definition write_pmcntenclr_el0_spec (pmcntenclr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmcntenclr_el0] :< pmcntenclr)).

  Definition read_amair_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_amair_el12)), st)).

  Definition write_amair_el12_spec (amair: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_amair_el12] :< amair)).

  Definition read_cntkctl_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntkctl_el12)), st)).

  Definition write_cntkctl_el12_spec (cntkctl: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntkctl_el12] :< cntkctl)).

  Definition read_cntp_ctl_el02_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntp_ctl_el02)), st)).

  Definition write_cntp_ctl_el02_spec (cntp_ctl: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntp_ctl_el02] :< cntp_ctl)).

  Definition read_cntp_cval_el02_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntp_cval_el02)), st)).

  Definition write_cntp_cval_el02_spec (cntp_cval: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntp_cval_el02] :< cntp_cval)).

  Definition read_cntpoff_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntpoff_el2)), st)).

  Definition write_cntpoff_el2_spec (cntpoff: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntpoff_el2] :< cntpoff)).

  Definition read_cntv_ctl_el02_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntv_ctl_el02)), st)).

  Definition write_cntv_ctl_el02_spec (cntv_ctl: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntv_ctl_el02] :< cntv_ctl)).

  Definition read_cntv_cval_el02_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntv_cval_el02)), st)).

  Definition write_cntv_cval_el02_spec (cntv_cval: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntv_cval_el02] :< cntv_cval)).

  Definition read_cntvoff_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cntvoff_el2)), st)).

  Definition write_cntvoff_el2_spec (cntvoff: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cntvoff_el2] :< cntvoff)).

  Definition read_contextidr_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_contextidr_el12)), st)).

  Definition write_contextidr_el12_spec (contextidr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_contextidr_el12] :< contextidr)).

  Definition read_disr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_disr_el1)), st)).

  Definition write_disr_el1_spec (disr: Z) (st: RData) : (option RData) :=
    None.

  Definition read_ich_hcr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_hcr_el2)), st)).

  Definition write_ich_hcr_el2_spec (ich_hcr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_hcr_el2] :< ich_hcr)).

  Definition read_ich_lr15_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_lr15_el2)), st)).

  Definition read_ich_misr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_misr_el2)), st)).

  Definition read_ich_vmcr_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ich_vmcr_el2)), st)).

  Definition read_mair_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_mair_el12)), st)).

  Definition write_mair_el12_spec (mair: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_mair_el12] :< mair)).

  Definition read_mdccint_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_mdccint_el1)), st)).

  Definition write_mdccint_el1_spec (mdccint: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_mdccint_el1] :< mdccint)).

  Definition read_mdscr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_mdscr_el1)), st)).

  Definition write_mdscr_el1_spec (mdscr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_mdscr_el1] :< mdscr)).

  Definition read_par_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_par_el1)), st)).

  Definition write_par_el1_spec (par: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_par_el1] :< par)).

  Definition read_pmintenclr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmintenclr_el1)), st)).

  Definition write_pmintenclr_el1_spec (pmintenclr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmintenclr_el1] :< pmintenclr)).

  Definition read_pmintenset_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmintenset_el1)), st)).

  Definition write_pmintenset_el1_spec (pmintenset: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmintenset_el1] :< pmintenset)).

  Definition read_pmovsclr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmovsclr_el0)), st)).

  Definition write_pmovsclr_el0_spec (pmovsclr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmovsclr_el0] :< pmovsclr)).

  Definition read_pmovsset_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmovsset_el0)), st)).

  Definition write_pmovsset_el0_spec (pmovsset: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmovsset_el0] :< pmovsset)).

  Definition read_pmselr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmselr_el0)), st)).

  Definition write_pmselr_el0_spec (pmselr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmselr_el0] :< pmselr)).

  Definition write_vmpidr_el2_spec (vmpidr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_vmpidr_el2] :< vmpidr)).

  Definition read_pmuserenr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmuserenr_el0)), st)).

  Definition write_pmuserenr_el0_spec (pmuserenr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmuserenr_el0] :< pmuserenr)).

  Definition read_pmxevcntr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmxevcntr_el0)), st)).

  Definition write_pmxevcntr_el0_spec (pmxevcntr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmxevcntr_el0] :< pmxevcntr)).

  Definition read_pmxevtyper_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_pmxevtyper_el0)), st)).

  Definition write_pmxevtyper_el0_spec (pmxevtyper: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmxevtyper_el0] :< pmxevtyper)).

  Definition read_tpidr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_tpidr_el1)), st)).

  Definition write_tpidr_el1_spec (tpidr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_tpidr_el1] :< tpidr)).

  Definition read_afsr1_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_afsr1_el12)), st)).

  Definition write_afsr1_el12_spec (afsr1: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_afsr1_el12] :< afsr1)).

  Definition read_afsr0_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_afsr0_el12)), st)).

  Definition write_afsr0_el12_spec (afsr0: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_afsr0_el12] :< afsr0)).

  Definition read_tcr_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_tcr_el12)), st)).

  Definition write_tcr_el12_spec (tcr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_tcr_el12] :< tcr)).

  Definition read_ttbr1_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ttbr1_el12)), st)).

  Definition write_ttbr1_el12_spec (ttbr1: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ttbr1_el12] :< ttbr1)).

  Definition read_ttbr0_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_ttbr0_el12)), st)).

  Definition write_ttbr0_el12_spec (ttbr0: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ttbr0_el12] :< ttbr0)).

  Definition read_cpacr_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_cpacr_el12)), st)).

  Definition write_cpacr_el12_spec (cpacr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_cpacr_el12] :< cpacr)).

  Definition read_sctlr_el12_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_sctlr_el12)), st)).

  Definition write_sctlr_el12_spec (sctlr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_sctlr_el12] :< sctlr)).

  Definition read_csselr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_csselr_el1)), st)).

  Definition write_csselr_el1_spec (csselr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_csselr_el1] :< csselr)).

  Definition read_actlr_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_actlr_el1)), st)).

  Definition write_actlr_el1_spec (actlr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_actlr_el1] :< actlr)).

  Definition read_sp_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_sp_el1)), st)).

  Definition write_sp_el1_spec (sp: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_sp_el1] :< sp)).

  Definition read_tpidr_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_tpidr_el0)), st)).

  Definition write_tpidr_el0_spec (tpidr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_tpidr_el0] :< tpidr)).

  Definition read_tpidrro_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_tpidrro_el0)), st)).

  Definition write_tpidrro_el0_spec (tpidrro: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_tpidrro_el0] :< tpidrro)).

  Definition read_sp_el0_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_sp_el0)), st)).

  Definition write_sp_el0_spec (sp: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_sp_el0] :< sp)).

  Definition write_pmevcntr0_el0_spec (pmevcntr0: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr0_el0] :< pmevcntr0)).

  Definition write_pmevcntr1_el0_spec (pmevcntr1: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr1_el0] :< pmevcntr1)).

  Definition write_pmevcntr2_el0_spec (pmevcntr2: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr2_el0] :< pmevcntr2)).

  Definition write_pmevcntr3_el0_spec (pmevcntr3: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr3_el0] :< pmevcntr3)).

  Definition write_pmevcntr4_el0_spec (pmevcntr4: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr4_el0] :< pmevcntr4)).

  Definition write_pmevcntr5_el0_spec (pmevcntr5: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr5_el0] :< pmevcntr5)).

  Definition write_pmevcntr6_el0_spec (pmevcntr6: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr6_el0] :< pmevcntr6)).

  Definition write_pmevcntr7_el0_spec (pmevcntr7: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr7_el0] :< pmevcntr7)).

  Definition write_pmevcntr8_el0_spec (pmevcntr8: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr8_el0] :< pmevcntr8)).

  Definition write_pmevcntr9_el0_spec (pmevcntr9: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr9_el0] :< pmevcntr9)).

  Definition write_pmevcntr10_el0_spec (pmevcntr10: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr10_el0] :< pmevcntr10)).

  Definition write_pmevcntr11_el0_spec (pmevcntr11: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr11_el0] :< pmevcntr11)).

  Definition write_pmevcntr12_el0_spec (pmevcntr12: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr12_el0] :< pmevcntr12)).

  Definition write_pmevcntr13_el0_spec (pmevcntr13: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr13_el0] :< pmevcntr13)).

  Definition write_pmevcntr14_el0_spec (pmevcntr14: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr14_el0] :< pmevcntr14)).

  Definition write_pmevcntr15_el0_spec (pmevcntr15: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr15_el0] :< pmevcntr15)).

  Definition write_pmevcntr16_el0_spec (pmevcntr16: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr16_el0] :< pmevcntr16)).

  Definition write_pmevcntr17_el0_spec (pmevcntr17: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr17_el0] :< pmevcntr17)).

  Definition write_pmevcntr18_el0_spec (pmevcntr18: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr18_el0] :< pmevcntr18)).

  Definition write_pmevcntr19_el0_spec (pmevcntr19: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr19_el0] :< pmevcntr19)).

  Definition write_pmevcntr20_el0_spec (pmevcntr20: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr20_el0] :< pmevcntr20)).

  Definition write_pmevcntr21_el0_spec (pmevcntr21: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr21_el0] :< pmevcntr21)).

  Definition write_pmevcntr22_el0_spec (pmevcntr22: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr22_el0] :< pmevcntr22)).

  Definition write_pmevcntr23_el0_spec (pmevcntr23: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr23_el0] :< pmevcntr23)).

  Definition write_pmevcntr24_el0_spec (pmevcntr24: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr24_el0] :< pmevcntr24)).

  Definition write_pmevcntr25_el0_spec (pmevcntr25: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr25_el0] :< pmevcntr25)).

  Definition write_pmevcntr26_el0_spec (pmevcntr26: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr26_el0] :< pmevcntr26)).

  Definition write_pmevcntr27_el0_spec (pmevcntr27: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr27_el0] :< pmevcntr27)).

  Definition write_pmevcntr28_el0_spec (pmevcntr28: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr28_el0] :< pmevcntr28)).

  Definition write_pmevcntr29_el0_spec (pmevcntr29: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr29_el0] :< pmevcntr29)).

  Definition write_pmevcntr30_el0_spec (pmevcntr30: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr30_el0] :< pmevcntr30)).

  Definition write_pmevtyper0_el0_spec (pmevtyper0: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper0_el0] :< pmevtyper0)).

  Definition write_pmevtyper1_el0_spec (pmevtyper1: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper1_el0] :< pmevtyper1)).

  Definition write_pmevtyper2_el0_spec (pmevtyper2: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper2_el0] :< pmevtyper2)).

  Definition write_pmevtyper3_el0_spec (pmevtyper3: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper3_el0] :< pmevtyper3)).

  Definition write_pmevtyper4_el0_spec (pmevtyper4: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper4_el0] :< pmevtyper4)).

  Definition write_pmevtyper5_el0_spec (pmevtyper5: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper5_el0] :< pmevtyper5)).

  Definition write_pmevtyper6_el0_spec (pmevtyper6: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper6_el0] :< pmevtyper6)).

  Definition write_pmevtyper7_el0_spec (pmevtyper7: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper7_el0] :< pmevtyper7)).

  Definition write_pmevtyper8_el0_spec (pmevtyper8: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper8_el0] :< pmevtyper8)).

  Definition write_pmevtyper9_el0_spec (pmevtyper9: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper9_el0] :< pmevtyper9)).

  Definition write_pmevtyper10_el0_spec (pmevtyper10: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper10_el0] :< pmevtyper10)).

  Definition write_pmevtyper11_el0_spec (pmevtyper11: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper11_el0] :< pmevtyper11)).

  Definition write_pmevtyper12_el0_spec (pmevtyper12: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper12_el0] :< pmevtyper12)).

  Definition write_pmevtyper13_el0_spec (pmevtyper13: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper13_el0] :< pmevtyper13)).

  Definition write_pmevtyper14_el0_spec (pmevtyper14: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper14_el0] :< pmevtyper14)).

  Definition write_pmevtyper15_el0_spec (pmevtyper15: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper15_el0] :< pmevtyper15)).

  Definition write_pmevtyper16_el0_spec (pmevtyper16: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper16_el0] :< pmevtyper16)).

  Definition write_pmevtyper17_el0_spec (pmevtyper17: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper17_el0] :< pmevtyper17)).

  Definition write_pmevtyper18_el0_spec (pmevtyper18: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper18_el0] :< pmevtyper18)).

  Definition write_pmevtyper19_el0_spec (pmevtyper19: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper19_el0] :< pmevtyper19)).

  Definition write_pmevtyper20_el0_spec (pmevtyper20: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper20_el0] :< pmevtyper20)).

  Definition write_pmevtyper21_el0_spec (pmevtyper21: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper21_el0] :< pmevtyper21)).

  Definition write_pmevtyper22_el0_spec (pmevtyper22: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper22_el0] :< pmevtyper22)).

  Definition write_pmevtyper23_el0_spec (pmevtyper23: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper23_el0] :< pmevtyper23)).

  Definition write_pmevtyper24_el0_spec (pmevtyper24: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper24_el0] :< pmevtyper24)).

  Definition write_pmevtyper25_el0_spec (pmevtyper25: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper25_el0] :< pmevtyper25)).

  Definition write_pmevtyper26_el0_spec (pmevtyper26: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper26_el0] :< pmevtyper26)).

  Definition write_pmevtyper27_el0_spec (pmevtyper27: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper27_el0] :< pmevtyper27)).

  Definition write_pmevtyper28_el0_spec (pmevtyper28: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper28_el0] :< pmevtyper28)).

  Definition write_pmevtyper29_el0_spec (pmevtyper29: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper29_el0] :< pmevtyper29)).

  Definition write_pmevtyper30_el0_spec (pmevtyper30: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper30_el0] :< pmevtyper30)).

  Definition read_icc_sre_el2_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_icc_sre_el2)), st)).

  Definition write_icc_sre_el2_spec (v: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_icc_sre_el2] :< v)).

  Definition read_icc_hppir1_el1_spec (st: RData) : (option (Z * RData)) :=
    (Some ((((st.(priv)).(pcpu_regs)).(pcpu_icc_hppir1_el1)), st)).

  Definition write_ich_vmcr_el2_spec (ich_vmcr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_ich_vmcr_el2] :< ich_vmcr)).

  Definition write_vtcr_el2_spec (vtcr: Z) (st: RData) : (option RData) :=
    (Some (st.[priv].[pcpu_regs].[pcpu_vtcr_el2] :< vtcr)).

  Definition atomic_load_add_release_64_spec (loc: Ptr) (val: Z) (st: RData) : (option (Z * RData)) :=
    when v, st == ((load_RData 64 loc st));
    when st == ((store_RData 64 loc (v + (val)) st));
    (Some ((v + (val)), st)).

  Definition atomic_add_64_spec (loc: Ptr) (val: Z) (st: RData) : (option RData) :=
    when v, st == ((load_RData 64 loc st));
    when st == ((store_RData 64 loc (v + (val)) st));
    (Some st).

  Definition __sca_read64_acquire_spec (ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    (load_RData 64 ptr st).

  Definition __sca_read64_spec (ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    (load_RData 64 ptr st).

  Definition __sca_write64_spec (ptr: Ptr) (val: Z) (st: RData) : (option RData) :=
    (store_RData 64 ptr val st).

  Definition __sca_write64_release_spec (v_state1: Ptr) (v_state: Z) (st: RData) : (option RData) :=
    (store_RData 64 v_state1 v_state st).

  Definition atomic_bit_set_acquire_release_64_spec (loc: Ptr) (bit: Z) (st: RData) : (option (bool * RData)) :=
    when v, st == ((load_RData 64 loc st));
    when st == ((store_RData 64 loc (Z.setbit v bit) st));
    (Some ((Z.testbit v bit), st)).

  Definition atomic_bit_clear_release_64_spec (loc: Ptr) (bit: Z) (st: RData) : (option RData) :=
    when v, st == ((load_RData 64 loc st));
    when st == ((store_RData 64 loc (Z.clearbit v bit) st));
    (Some st).

  Definition measurement_get_size_spec (v_algo: Z) (st: RData) : (option (Z * RData)) :=
    if (v_algo =? (HASH_ALGO_SHA256))
    then (Some (SHA256_SIZE, st))
    else (
      if (v_algo =? (HASH_ALGO_SHA512))
      then (Some (SHA512_SIZE, st))
      else None).

  Definition measurement_hash_compute_spec (v_hash_algo: Z) (v_data: Ptr) (v_size: Z) (v_out: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition measurement_extend_spec (v_hash_algo: Z) (v_current_measurement: Ptr) (v_extend_measurement: Ptr) (v_extend_measurement_size: Z) (v_out: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition fpu_save_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition fpu_restore_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition sve_save_p_ffr_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition sve_save_zcr_fpu_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition sve_save_z_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition sve_restore_ffr_p_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition sve_restore_zcr_fpu_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition sve_restore_z_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition t_cose_sign1_encode_signature_spec (v_me: Ptr) (v_cbor_encode_ctx: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition QCBOREncode_Finish_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition QCBOREncode_AddBytesToMapN_spec (v_buf: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition QCBOREncode_CloseMap_spec (v_pMe: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition QCBOREncode_AddTag_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition QCBOREncode_Init_spec (v_0: Ptr) (v_1: list Z) (st: RData) : (option RData) :=
    (Some st).

  Definition attest_get_platform_token_spec (v_buf: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition attest_cca_token_create_spec (v_me: Ptr) (v_completed_token: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition attest_realm_token_sign_spec (v_me: Ptr) (v_completed_token: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition save_input_parameters_spec (v_rec: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition attest_realm_token_create_spec (v_algo: Z) (v_measurement: Ptr) (v_num_measurement: Z) (v_prv: Ptr) (v_ctx: Ptr) (v_realm_token_buf: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition attestation_heap_reinit_pe_spec (v_buf: Ptr) (v_buf_size: Z) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition attestation_heap_ctx_assign_pe_spec (v_ctx: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition attestation_heap_ctx_init_spec (v_buf: Ptr) (v_buf_size: Z) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition attestation_heap_ctx_unassign_pe_spec (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition attest_token_continue_write_state_spec (v_rec: Ptr) (v_res: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition attest_token_continue_sign_state_spec (v_rec: Ptr) (v_res: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition get_rpv_spec (v_rd: Ptr) (v_claim: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition verify_input_parameters_consistency_spec (v_rec: Ptr) (st: RData) : (option (bool * RData)) :=
    (Some ((verify_input_parameters_consistency_spec_oracle v_rec st), st)).

  Definition handle_rsi_read_measurement_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
    (handle_rsi_read_measurement_spec_oralce st).

  Definition handle_rsi_extend_measurement_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
    (handle_rsi_extend_measurement_spec_oralce st).

  Definition handle_rsi_attest_token_continue_spec (v_rec: Ptr) (v_res: Ptr) (st: RData) : (option RData) :=
    (handle_rsi_attest_token_continue_spec_oralce st).

  Definition read_lrs_spec (v_gicstate: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition read_aprs_spec (v_gicstate: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition write_aprs_spec (v_gicstate: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition write_lrs_spec (v_gicstate: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition rmi_log_on_exit_spec (v_handler_id: Z) (v_args: Ptr) (v_ret: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition report_unexpected_spec (st: RData) : (option RData) :=
    None.

  Definition fatal_abort_spec (st: RData) : (option RData) :=
    None.

  Definition simd_init_spec (st: RData) : (option RData) :=
    (Some st).

  Definition complete_rsi_host_call_spec (v_rec: Ptr) (v_rec_entry: Ptr) (st: RData) : (option (list Z * RData)) :=
    (Some ((1 :: ((0 :: (nil)))), st)).

  Definition complete_host_call_spec (v_rec: Ptr) (v_rec_run: Ptr) (st: RData) : (option (bool * RData)) :=
    (Some (true, st)).

  Definition handle_realm_trap_spec (v_regs: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition ripas_granule_measure_spec (v_rd: Ptr) (v_ipa: Z) (v_level: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition data_granule_measure_spec (v_rd: Ptr) (v_data: Ptr) (v_ipa: Z) (v_flags: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition rec_params_measure_spec (v_rd: Ptr) (v_rec_params: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition realm_params_measure_spec (v_rd: Ptr) (v_realm_params: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition plat_granule_addr_to_idx_spec (pa: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((pa / (GRANULE_SIZE)), st)).

  Definition plat_granule_idx_to_addr_spec (idx: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((idx * (GRANULE_SIZE)), st)).

  Definition stage2_tlbi_ipa_spec (v_s2_ctx: Ptr) (v_ipa: Z) (v_size: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition rec_run_loop_spec (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : (option RData) :=
    (Some st).

End Bottom_Spec.

#[global] Hint Unfold status_ptr_spec: spec.
#[global] Hint Unfold ptr_status_spec: spec.
#[global] Hint Unfold ptr_is_err_spec: spec.
#[global] Hint Unfold table_entry_to_phys_spec: spec.
#[global] Hint Unfold ptr_eqb: spec.
#[global] Hint Unfold ptr_lt: spec.
#[global] Hint Unfold ptr_gt: spec.
#[global] Hint Unfold spinlock_acquire_spec: spec.
#[global] Hint Unfold spinlock_release_spec: spec.
#[global] Hint Unfold __assert_fail_spec: spec.
#[global] Hint Unfold llvm_memcpy_p0i8_p0i8_i64_spec: spec.
#[global] Hint Unfold llvm_memset_p0i8_i64_spec: spec.
#[global] Hint Unfold memcpy_ns_read_spec: spec.
#[global] Hint Unfold memcpy_ns_write_spec: spec.
#[global] Hint Unfold memset_spec: spec.
#[global] Hint Unfold memcpy_spec: spec.
#[global] Hint Unfold xlat_unmap_memory_page_spec: spec.
#[global] Hint Unfold xlat_map_memory_page_with_attrs_spec: spec.
#[global] Hint Unfold find_xlat_last_table_spec: spec.
#[global] Hint Unfold xlat_arch_setup_mmu_cfg_spec: spec.
#[global] Hint Unfold xlat_ctx_init_spec: spec.
#[global] Hint Unfold xlat_get_llt_from_va_spec: spec.
#[global] Hint Unfold xlat_get_tte_ptr_spec: spec.
#[global] Hint Unfold xlat_read_tte_spec: spec.
#[global] Hint Unfold iasm_4_spec: spec.
#[global] Hint Unfold iasm_154_spec: spec.
#[global] Hint Unfold iasm_155_spec: spec.
#[global] Hint Unfold read_tpidr_el2_spec: spec.
#[global] Hint Unfold iasm_10_spec: spec.
#[global] Hint Unfold tlbivae2is_spec: spec.
#[global] Hint Unfold tlbiipas2e1is_spec: spec.
#[global] Hint Unfold tlbivmalle1is_spec: spec.
#[global] Hint Unfold read_vttbr_el2_spec: spec.
#[global] Hint Unfold write_vttbr_el2_spec: spec.
#[global] Hint Unfold read_zcr_el2_spec: spec.
#[global] Hint Unfold write_zcr_el2_spec: spec.
#[global] Hint Unfold read_elr_el2_spec: spec.
#[global] Hint Unfold write_elr_el2_spec: spec.
#[global] Hint Unfold read_cptr_el2_spec: spec.
#[global] Hint Unfold write_cptr_el2_spec: spec.
#[global] Hint Unfold isb_spec: spec.
#[global] Hint Unfold read_cnthctl_el2_spec: spec.
#[global] Hint Unfold write_cnthctl_el2_spec: spec.
#[global] Hint Unfold read_pmcr_el0_spec: spec.
#[global] Hint Unfold write_pmcr_el0_spec: spec.
#[global] Hint Unfold read_mdcr_el2_spec: spec.
#[global] Hint Unfold write_mdcr_el2_spec: spec.
#[global] Hint Unfold write_vpidr_el2_spec: spec.
#[global] Hint Unfold read_sctlr_el2_spec: spec.
#[global] Hint Unfold read_midr_el1_spec: spec.
#[global] Hint Unfold read_esr_el12_spec: spec.
#[global] Hint Unfold write_esr_el12_spec: spec.
#[global] Hint Unfold read_esr_el2_spec: spec.
#[global] Hint Unfold read_spsr_el2_spec: spec.
#[global] Hint Unfold write_spsr_el2_spec: spec.
#[global] Hint Unfold read_spsr_el12_spec: spec.
#[global] Hint Unfold write_spsr_el12_spec: spec.
#[global] Hint Unfold read_elr_el12_spec: spec.
#[global] Hint Unfold write_elr_el12_spec: spec.
#[global] Hint Unfold read_vbar_el12_spec: spec.
#[global] Hint Unfold write_vbar_el12_spec: spec.
#[global] Hint Unfold read_hpfar_el2_spec: spec.
#[global] Hint Unfold read_far_el12_spec: spec.
#[global] Hint Unfold write_far_el12_spec: spec.
#[global] Hint Unfold read_far_el2_spec: spec.
#[global] Hint Unfold read_isr_el1_spec: spec.
#[global] Hint Unfold write_vsesr_el2_spec: spec.
#[global] Hint Unfold write_hcr_el2_spec: spec.
#[global] Hint Unfold read_id_aa64mmfr1_el1_spec: spec.
#[global] Hint Unfold read_id_aa64mmfr0_el1_spec: spec.
#[global] Hint Unfold read_id_aa64dfr0_el1_spec: spec.
#[global] Hint Unfold read_id_aa64dfr1_el1_spec: spec.
#[global] Hint Unfold read_id_aa64pfr0_el1_spec: spec.
#[global] Hint Unfold read_id_aa64pfr1_el1_spec: spec.
#[global] Hint Unfold monitor_call_spec: spec.
#[global] Hint Unfold monitor_call_with_res_spec: spec.
#[global] Hint Unfold run_realm_spec: spec.
#[global] Hint Unfold read_pmevtyper0_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper1_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper2_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper3_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper4_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper5_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper6_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper7_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper8_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper9_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper10_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper11_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper12_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper13_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper14_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper15_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper16_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper17_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper18_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper19_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper20_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper21_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper22_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper23_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper24_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper25_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper26_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper27_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper28_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper29_el0_spec: spec.
#[global] Hint Unfold read_pmevtyper30_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr0_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr1_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr2_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr3_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr4_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr5_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr6_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr7_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr8_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr9_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr10_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr11_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr12_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr13_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr14_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr15_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr16_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr17_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr18_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr19_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr20_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr21_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr22_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr23_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr24_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr25_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr26_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr27_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr28_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr29_el0_spec: spec.
#[global] Hint Unfold read_pmevcntr30_el0_spec: spec.
#[global] Hint Unfold read_pmccfiltr_el0_spec: spec.
#[global] Hint Unfold write_pmccfiltr_el0_spec: spec.
#[global] Hint Unfold read_pmccntr_el0_spec: spec.
#[global] Hint Unfold write_pmccntr_el0_spec: spec.
#[global] Hint Unfold read_pmcntenset_el0_spec: spec.
#[global] Hint Unfold write_pmcntenset_el0_spec: spec.
#[global] Hint Unfold read_pmcntenclr_el0_spec: spec.
#[global] Hint Unfold write_pmcntenclr_el0_spec: spec.
#[global] Hint Unfold read_amair_el12_spec: spec.
#[global] Hint Unfold write_amair_el12_spec: spec.
#[global] Hint Unfold read_cntkctl_el12_spec: spec.
#[global] Hint Unfold write_cntkctl_el12_spec: spec.
#[global] Hint Unfold read_cntp_ctl_el02_spec: spec.
#[global] Hint Unfold write_cntp_ctl_el02_spec: spec.
#[global] Hint Unfold read_cntp_cval_el02_spec: spec.
#[global] Hint Unfold write_cntp_cval_el02_spec: spec.
#[global] Hint Unfold read_cntpoff_el2_spec: spec.
#[global] Hint Unfold write_cntpoff_el2_spec: spec.
#[global] Hint Unfold read_cntv_ctl_el02_spec: spec.
#[global] Hint Unfold write_cntv_ctl_el02_spec: spec.
#[global] Hint Unfold read_cntv_cval_el02_spec: spec.
#[global] Hint Unfold write_cntv_cval_el02_spec: spec.
#[global] Hint Unfold read_cntvoff_el2_spec: spec.
#[global] Hint Unfold write_cntvoff_el2_spec: spec.
#[global] Hint Unfold read_contextidr_el12_spec: spec.
#[global] Hint Unfold write_contextidr_el12_spec: spec.
#[global] Hint Unfold read_disr_el1_spec: spec.
#[global] Hint Unfold write_disr_el1_spec: spec.
#[global] Hint Unfold read_ich_hcr_el2_spec: spec.
#[global] Hint Unfold write_ich_hcr_el2_spec: spec.
#[global] Hint Unfold read_ich_lr15_el2_spec: spec.
#[global] Hint Unfold read_ich_misr_el2_spec: spec.
#[global] Hint Unfold read_ich_vmcr_el2_spec: spec.
#[global] Hint Unfold read_mair_el12_spec: spec.
#[global] Hint Unfold write_mair_el12_spec: spec.
#[global] Hint Unfold read_mdccint_el1_spec: spec.
#[global] Hint Unfold write_mdccint_el1_spec: spec.
#[global] Hint Unfold read_mdscr_el1_spec: spec.
#[global] Hint Unfold write_mdscr_el1_spec: spec.
#[global] Hint Unfold read_par_el1_spec: spec.
#[global] Hint Unfold write_par_el1_spec: spec.
#[global] Hint Unfold read_pmintenclr_el1_spec: spec.
#[global] Hint Unfold write_pmintenclr_el1_spec: spec.
#[global] Hint Unfold read_pmintenset_el1_spec: spec.
#[global] Hint Unfold write_pmintenset_el1_spec: spec.
#[global] Hint Unfold read_pmovsclr_el0_spec: spec.
#[global] Hint Unfold write_pmovsclr_el0_spec: spec.
#[global] Hint Unfold read_pmovsset_el0_spec: spec.
#[global] Hint Unfold write_pmovsset_el0_spec: spec.
#[global] Hint Unfold read_pmselr_el0_spec: spec.
#[global] Hint Unfold write_pmselr_el0_spec: spec.
#[global] Hint Unfold write_vmpidr_el2_spec: spec.
#[global] Hint Unfold read_pmuserenr_el0_spec: spec.
#[global] Hint Unfold write_pmuserenr_el0_spec: spec.
#[global] Hint Unfold read_pmxevcntr_el0_spec: spec.
#[global] Hint Unfold write_pmxevcntr_el0_spec: spec.
#[global] Hint Unfold read_pmxevtyper_el0_spec: spec.
#[global] Hint Unfold write_pmxevtyper_el0_spec: spec.
#[global] Hint Unfold read_tpidr_el1_spec: spec.
#[global] Hint Unfold write_tpidr_el1_spec: spec.
#[global] Hint Unfold read_afsr1_el12_spec: spec.
#[global] Hint Unfold write_afsr1_el12_spec: spec.
#[global] Hint Unfold read_afsr0_el12_spec: spec.
#[global] Hint Unfold write_afsr0_el12_spec: spec.
#[global] Hint Unfold read_tcr_el12_spec: spec.
#[global] Hint Unfold write_tcr_el12_spec: spec.
#[global] Hint Unfold read_ttbr1_el12_spec: spec.
#[global] Hint Unfold write_ttbr1_el12_spec: spec.
#[global] Hint Unfold read_ttbr0_el12_spec: spec.
#[global] Hint Unfold write_ttbr0_el12_spec: spec.
#[global] Hint Unfold read_cpacr_el12_spec: spec.
#[global] Hint Unfold write_cpacr_el12_spec: spec.
#[global] Hint Unfold read_sctlr_el12_spec: spec.
#[global] Hint Unfold write_sctlr_el12_spec: spec.
#[global] Hint Unfold read_csselr_el1_spec: spec.
#[global] Hint Unfold write_csselr_el1_spec: spec.
#[global] Hint Unfold read_actlr_el1_spec: spec.
#[global] Hint Unfold write_actlr_el1_spec: spec.
#[global] Hint Unfold read_sp_el1_spec: spec.
#[global] Hint Unfold write_sp_el1_spec: spec.
#[global] Hint Unfold read_tpidr_el0_spec: spec.
#[global] Hint Unfold write_tpidr_el0_spec: spec.
#[global] Hint Unfold read_tpidrro_el0_spec: spec.
#[global] Hint Unfold write_tpidrro_el0_spec: spec.
#[global] Hint Unfold read_sp_el0_spec: spec.
#[global] Hint Unfold write_sp_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr0_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr1_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr2_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr3_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr4_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr5_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr6_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr7_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr8_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr9_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr10_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr11_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr12_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr13_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr14_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr15_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr16_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr17_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr18_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr19_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr20_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr21_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr22_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr23_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr24_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr25_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr26_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr27_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr28_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr29_el0_spec: spec.
#[global] Hint Unfold write_pmevcntr30_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper0_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper1_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper2_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper3_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper4_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper5_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper6_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper7_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper8_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper9_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper10_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper11_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper12_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper13_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper14_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper15_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper16_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper17_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper18_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper19_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper20_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper21_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper22_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper23_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper24_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper25_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper26_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper27_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper28_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper29_el0_spec: spec.
#[global] Hint Unfold write_pmevtyper30_el0_spec: spec.
#[global] Hint Unfold read_icc_sre_el2_spec: spec.
#[global] Hint Unfold write_icc_sre_el2_spec: spec.
#[global] Hint Unfold read_icc_hppir1_el1_spec: spec.
#[global] Hint Unfold write_ich_vmcr_el2_spec: spec.
#[global] Hint Unfold write_vtcr_el2_spec: spec.
#[global] Hint Unfold atomic_load_add_release_64_spec: spec.
#[global] Hint Unfold atomic_add_64_spec: spec.
#[global] Hint Unfold __sca_read64_acquire_spec: spec.
#[global] Hint Unfold __sca_read64_spec: spec.
#[global] Hint Unfold __sca_write64_spec: spec.
#[global] Hint Unfold __sca_write64_release_spec: spec.
#[global] Hint Unfold atomic_bit_set_acquire_release_64_spec: spec.
#[global] Hint Unfold atomic_bit_clear_release_64_spec: spec.
#[global] Hint Unfold measurement_get_size_spec: spec.
#[global] Hint Unfold measurement_hash_compute_spec: spec.
#[global] Hint Unfold measurement_extend_spec: spec.
#[global] Hint Unfold fpu_save_state_spec: spec.
#[global] Hint Unfold fpu_restore_state_spec: spec.
#[global] Hint Unfold sve_save_p_ffr_state_spec: spec.
#[global] Hint Unfold sve_save_zcr_fpu_state_spec: spec.
#[global] Hint Unfold sve_save_z_state_spec: spec.
#[global] Hint Unfold sve_restore_ffr_p_state_spec: spec.
#[global] Hint Unfold sve_restore_zcr_fpu_state_spec: spec.
#[global] Hint Unfold sve_restore_z_state_spec: spec.
#[global] Hint Unfold t_cose_sign1_encode_signature_spec: spec.
#[global] Hint Unfold QCBOREncode_Finish_spec: spec.
#[global] Hint Unfold QCBOREncode_AddBytesToMapN_spec: spec.
#[global] Hint Unfold QCBOREncode_CloseMap_spec: spec.
#[global] Hint Unfold QCBOREncode_AddTag_spec: spec.
#[global] Hint Unfold QCBOREncode_Init_spec: spec.
#[global] Hint Unfold attest_get_platform_token_spec: spec.
#[global] Hint Unfold attest_cca_token_create_spec: spec.
#[global] Hint Unfold attest_realm_token_sign_spec: spec.
#[global] Hint Unfold save_input_parameters_spec: spec.
#[global] Hint Unfold attest_realm_token_create_spec: spec.
#[global] Hint Unfold attestation_heap_reinit_pe_spec: spec.
#[global] Hint Unfold attestation_heap_ctx_assign_pe_spec: spec.
#[global] Hint Unfold attestation_heap_ctx_init_spec: spec.
#[global] Hint Unfold attestation_heap_ctx_unassign_pe_spec: spec.
#[global] Hint Unfold attest_token_continue_write_state_spec: spec.
#[global] Hint Unfold attest_token_continue_sign_state_spec: spec.
#[global] Hint Unfold get_rpv_spec: spec.
#[global] Hint Unfold verify_input_parameters_consistency_spec: spec.
#[global] Hint Unfold handle_rsi_read_measurement_spec: spec.
#[global] Hint Unfold handle_rsi_extend_measurement_spec: spec.
#[global] Hint Unfold handle_rsi_attest_token_continue_spec: spec.
#[global] Hint Unfold read_lrs_spec: spec.
#[global] Hint Unfold read_aprs_spec: spec.
#[global] Hint Unfold write_aprs_spec: spec.
#[global] Hint Unfold write_lrs_spec: spec.
#[global] Hint Unfold rmi_log_on_exit_spec: spec.
#[global] Hint Unfold report_unexpected_spec: spec.
#[global] Hint Unfold fatal_abort_spec: spec.
#[global] Hint Unfold simd_init_spec: spec.
#[global] Hint Unfold complete_rsi_host_call_spec: spec.
#[global] Hint Unfold complete_host_call_spec: spec.
#[global] Hint Unfold handle_realm_trap_spec: spec.
#[global] Hint Unfold ripas_granule_measure_spec: spec.
#[global] Hint Unfold data_granule_measure_spec: spec.
#[global] Hint Unfold rec_params_measure_spec: spec.
#[global] Hint Unfold realm_params_measure_spec: spec.
#[global] Hint Unfold plat_granule_addr_to_idx_spec: spec.
#[global] Hint Unfold plat_granule_idx_to_addr_spec: spec.
#[global] Hint Unfold stage2_tlbi_ipa_spec: spec.
#[global] Hint Unfold rec_run_loop_spec: spec.
