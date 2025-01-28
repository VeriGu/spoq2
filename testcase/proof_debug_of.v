Definition PROJ_NAME: string := "RMMProof.ProofDebugOF".
Definition PROJ_BASE: string := "./ProofDebugOF".
Hint CacheSpec.

(* Hint NoHighSpec true. *)
(* Hint OnlyTrans smc_rtt_fold.
Hint OnlyTrans smc_rtt_create.
Hint OnlyTrans smc_rtt_destroy.
Hint OnlyTrans smc_data_create.
Hint OnlyTrans smc_data_create_unknown.
Hint OnlyTrans smc_data_destroy.
Hint OnlyTrans data_create.
Hint OnlyTrans smc_rtt_set_ripas.
Hint OnlyTrans smc_rtt_create. *)
(* Hint OnlyTrans find_lock_granules. *)
(* Hint OnlyTrans init_common_sysregs. *)
(* Hint OnlyTrans smc_rtt_set_ripas.
Hint OnlyTrans smc_rtt_init_ripas.
Hint OnlyTrans smc_rtt_map_unprotected.
Hint OnlyTrans smc_rtt_unmap_unprotected.
Hint OnlyTrans smc_granule_delegate.
Hint OnlyTrans smc_granule_undelegate.
Hint OnlyTrans smc_realm_create.
Hint OnlyTrans smc_realm_destroy.
Hint OnlyTrans smc_realm_activate.
Hint OnlyTrans smc_rec_destroy.
Hint OnlyTrans smc_rec_create.
Hint OnlyTrans update_ripas.
Hint OnlyTrans arch_feat_get_pa_width.
Hint OnlyTrans smc_rtt_read_entry.
Hint OnlyTrans smc_rec_enter. *)

(* Hint OnlyTrans smc_realm_activate.
Hint CheckInv smc_realm_activate_spec. *)
(* Hint OnlyTrans smc_rec_destroy. *)
(* Hint CheckInv smc_rec_destroy_spec. *)
(* Hint OnlyTrans smc_granule_delegate. *)
(* Hint CheckInv smc_granule_delegate_spec. *)
(* Hint OnlyTrans smc_granule_undelegate. *)
(* Hint CheckInv smc_granule_undelegate_spec. *)

  (* ┌─────────┐                    *)
  (* │invalid  │                    *)
  (* │         │                    *)
  (* ├─────────┤                    *)
  (* │granules │ 0xfffffffffebe0000 *)
  (* │         │                    *)
  (* │         │                    *)
  (* ├─────────┤                    *)
  (* │STACK    │ 0xffffffffffbe0000 *)
  (* │         │                    *)
  (* │         │ 1024 pages         *)
  (* │         │                    *)
  (* ├─────────┤                    *)
  (* │SLOT_VIRT│ 0xfffffffffffe0000 *)
  (* │         │                    *)
  (* │         │ 31 pages           *)
  (* ├─────────┤                    *)
  (* │MAX_ERR  │ 0xfffffffffffff000 *)
  (* ├─────────┤                    *)
  (* │         │                    *)
  (* │INT_MAX  │                    *)
  (* └─────────┘                    *)

(* SLOT begins from 0xfffffffffffe0000, 31 pages *)
Definition SLOT_VIRT : Z := 18446744073709420544.
Definition STACK_VIRT : Z := 18446744073705226240.
(* Addresses above 0xfffffffffffff000 are invalid *)
Definition MAX_ERR : Z := 18446744073709547520.
(* struct granules begins from 0xfffffffffebe0000 *)
Definition GRANULES_BASE : Z := 18446744073688449024.

Definition ST_GRANULE_SIZE : Z:= 16.
Definition RMM_MAX_GRANULES : Z := 1048576.
Definition MAX_REC_AUX_GRANULES : Z := 16.
Definition GRANULE_SIZE : Z := 4096.


Definition SMC_RMM_GTSI_DELEGATE : Z := 3288334768.
Definition SMC_RMM_GTSI_UNDELEGATE : Z := 3288334769.


Definition SLOT_NS : Z := 0.
Definition SLOT_DELEGATED : Z := 1.
Definition SLOT_RD : Z := 2.
Definition SLOT_REC : Z := 3.
Definition SLOT_REC2 : Z := 4.
Definition SLOT_REC_TARGET : Z := 5.
Definition SLOT_REC_AUX0 : Z := 6.
Definition SLOT_RTT : Z := 22. (* SLOT_REC_AUX0 + MAX_REC_AUX_GRANULES. *)
Definition SLOT_RTT2 : Z := 23. (* SLOT_RTT + 1. *)
Definition SLOT_RSI_CALL : Z := 24. (* SLOT_RTT2 + 1. *)
Definition STACK_slot_ofs : Z := 25.
Definition STACK_g0 : Z := 73.
Definition STACK_g1 : Z := 74.

Definition non_slot : Z := 75.

Parameter zero_granule_data_normal : ZMap.t Z.


Definition int_is_granule (v: Z) : Prop :=
  (v > 0 /\ (v >= GRANULES_BASE) /\ (v < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)).

Parameter CPU_ID: Z.

Definition REALM_STATE_NEW : Z := 0.
Definition REALM_STATE_ACTIVE : Z := 1.
Definition REALM_STATE_SYSTEM_OFF : Z := 2.

Include "./st_rec.v".
Include "./st_pmu_state.v".
Include "./st_simd_state.v".
Include "./st_ns_simd_state.v".
Include "./st_rmi_rec_params.v".
Include "./st_rtt_walk.v".
Include "./st_s2_walk_result.v".
Include "./st_rmi_realm_params.v".
Include "./st_smc_result.v".
Include "./st_rmi_rec_run.v".

Record s_granule :=
  mks_granule {
      e_lock: option Z;
      e_state: Z;
      e_refcount: Z
    }.

Record s_realm_s2_context :=
 mks_realm_s2_context {
    e_rls2ctx_ipa_bits : Z;
    e_rls2ctx_s2_starting_level : Z;
    e_rls2ctx_num_root_rtts : Z;
    e_rls2ctx_g_rtt : Z;
    e_rls2ctx_vmid : Z
  }.

Record s_rd :=
  mks_rd {
    e_rd_rd_state : Z;
    e_rd_rec_count : Z;
    e_rd_s2_ctx : s_realm_s2_context;
    e_rd_num_rec_aux : Z;
    e_rd_algorithm : Z;
    e_rd_pmu_enabled : Z;
    e_rd_pmu_num_cnts : Z;
    e_rd_sve_enabled : Z;
    e_rd_sve_vq : Z;
    e_rd_measurement : Z;
    e_rd_rpv : ZMap.t Z
    }.

(*
 * aux_data can spawn over multiple pages. We don't have the flexibility to
 * arbitrarily split the data into mulitple GranuleDataNormal.
 * We instead put all the data of contiguous aux_data pages into the first
 * GranuleDataNormal and for the following pages, we record the index of the first
 * granule(not necessary?).
 *
 * aux_data is protected by the spinlock or refcount of its parent REC, so we
 * also need to record the index of its parent REC to check the locking state.
 *)
Record GranuleDataNormal :=
  mkGranuleDataNormal {
      gd_g_idx: Z;
      (* RD *)
      g_rd: s_rd;

      (* REC *)
      g_rec: s_rec;

      (* aux_data *)
      g_aux_pmu_state: s_pmu_state;
      g_aux_simd_state: s_simd_state;
      rec_gidx: Z;

      (* RTT/NS/Data *)
      (* XXX: ofs -> data *)
      g_norm: ZMap.t Z
    }.

Record s_s2_walk_result :=
 mks_s2_walk_result {
    e_walk_pa : Z;
    e_walk_rtt_level : Z;
    e_walk_ripas : Z;
    e_walk_destroyed : Z;
    e_walk_llt : Z
   }.

Definition load_s_granule (sz: Z) (ofs: Z) (st: s_granule) : option Z :=
  (* lock should not be directly accessed *)
  (* if (ofs =? 0) then st.(e_lock) else *)
  (* granule state must be lock protected *)
  if (ofs =? 4) then Some st.(e_state)
  else
    (* RD's refcount can be lock-free accessed, but must be atomic *)
    if (ofs =? 8) then Some (st.(e_refcount))
    else
      None.

(* this is lock-protected, we can annotate it with its lock object. Given s_granule g, its lock object is g.[e_lock]*)
Definition store_s_granule (sz: Z) (ofs: Z) (v: Z) (st: s_granule) : option s_granule :=
  if (ofs =? 0) then
    match st.(e_lock) with
    | None => Some (st.[e_lock] :< (Some v))
    | Some cid => None
    end
  else
    if (ofs =? 4) then
      match st.(e_lock) with
      | Some cid => Some (st.[e_state] :< v)
      | None => None
      end
    else
      if (ofs =? 8) then
        match (st.(e_lock)) with
        | Some cid => if v <? 0 then None else Some (st.[e_refcount] :< v)
        | None => None
        end
      else
        None.

Definition load_s_realm_s2_context (sz: Z) (ofs: Z) (st: s_realm_s2_context) : option Z :=
  if (ofs =? 0) then Some (st.(e_rls2ctx_ipa_bits)) else
  if (ofs =? 4) then Some (st.(e_rls2ctx_s2_starting_level)) else
  if (ofs =? 8) then Some (st.(e_rls2ctx_num_root_rtts)) else
  if (ofs =? 16) then
      rely (int_is_granule st.(e_rls2ctx_g_rtt));
      Some (st.(e_rls2ctx_g_rtt)) else
  if (ofs =? 24) then Some (st.(e_rls2ctx_vmid)) else
  None.

Definition store_s_realm_s2_context (sz: Z) (ofs: Z) (v: Z) (st: s_realm_s2_context) : option s_realm_s2_context :=
  if (ofs =? 0) then Some (st.[e_rls2ctx_ipa_bits] :< v) else
  if (ofs =? 4) then Some (st.[e_rls2ctx_s2_starting_level] :< v) else
  if (ofs =? 8) then Some (st.[e_rls2ctx_num_root_rtts] :< v) else
  if (ofs =? 16) then Some (st.[e_rls2ctx_g_rtt] :< v) else
  if (ofs =? 24) then Some (st.[e_rls2ctx_vmid] :< v) else
    None.

Definition load_s_rd (sz: Z) (ofs: Z) (st: s_rd) : option Z :=
  if (ofs =? 0) then Some (st.(e_rd_rd_state)) else
  if (ofs =? 8) then Some (st.(e_rd_rec_count)) else
  if (ofs >=? 16) && (ofs <? 48) then (
    let elem_ofs := ofs - 16 in
    load_s_realm_s2_context sz elem_ofs (st.(e_rd_s2_ctx))) else
  if (ofs =? 48) then Some (st.(e_rd_num_rec_aux)) else
  if (ofs =? 52) then Some (st.(e_rd_algorithm)) else
  if (ofs =? 56) then Some (st.(e_rd_pmu_enabled)) else
  if (ofs =? 60) then Some (st.(e_rd_pmu_num_cnts)) else
  if (ofs =? 64) then Some (st.(e_rd_sve_enabled)) else
  if (ofs =? 65) then Some (st.(e_rd_sve_vq)) else
  if (ofs >=? 66) && (ofs <? 386) then (
    let idx := (ofs - 66) / 64 in
    None (* Not support nested vector *)) else
  if (ofs >=? 386) && (ofs <? 450) then (
    let idx := (ofs - 386) / 1 in
    Some (st.(e_rd_rpv) @ idx)) else
  None.

Definition store_s_rd (sz: Z) (ofs: Z) (v: Z) (st: s_rd) : option s_rd :=
  if (ofs =? 0) then Some (st.[e_rd_rd_state] :< v) else
  if (ofs =? 8) then Some (st.[e_rd_rec_count] :< v) else
  if (ofs >=? 16) && (ofs <? 48) then (
    let elem_ofs := ofs - 16 in
    when ret == store_s_realm_s2_context sz elem_ofs v st.(e_rd_s2_ctx);
    Some (st.[e_rd_s2_ctx] :< ret)) else
  if (ofs =? 48) then Some (st.[e_rd_num_rec_aux] :< v) else
  if (ofs =? 52) then Some (st.[e_rd_algorithm] :< v) else
  if (ofs =? 56) then Some (st.[e_rd_pmu_enabled] :< v) else
  if (ofs =? 60) then Some (st.[e_rd_pmu_num_cnts] :< v) else
  if (ofs =? 64) then Some (st.[e_rd_sve_enabled] :< v) else
  if (ofs =? 65) then Some (st.[e_rd_sve_vq] :< v) else
  if (ofs >=? 66) && (ofs <? 386) then (
    let idx := (ofs - 66) / 64 in
    None (* Not support nested vector *)) else
  if (ofs >=? 386) && (ofs <? 450) then (
    let idx := (ofs - 386) / 1 in
    Some (st.[e_rd_rpv] :< (st.(e_rd_rpv) # idx == v))) else
  None.

Record s_granule_set :=
 mks_granule_set {
    e_gset_idx : Z;
    e_gset_addr : Z;
    e_gset_state : Z;
    e_gset_g : Z;
    e_gset_g_ret : Z
  }.

Definition load_s_granule_set (sz: Z) (ofs: Z) (st: s_granule_set) : option Z :=
  if (ofs =? 0) then Some (st.(e_gset_idx)) else
  if (ofs =? 8) then Some (st.(e_gset_addr)) else
  if (ofs =? 16) then Some (st.(e_gset_state)) else
  if (ofs =? 24) then Some (st.(e_gset_g)) else
  if (ofs =? 32) then Some (st.(e_gset_g_ret)) else
  None.

Definition store_s_granule_set (sz: Z) (ofs: Z) (v: Z) (st: s_granule_set) : option s_granule_set :=
  if (ofs =? 0) then Some (st.[e_gset_idx] :< v) else
  if (ofs =? 8) then Some (st.[e_gset_addr] :< v) else
  if (ofs =? 16) then Some (st.[e_gset_state] :< v) else
  if (ofs =? 24) then Some (st.[e_gset_g] :< v) else
  if (ofs =? 32) then Some (st.[e_gset_g_ret] :< v) else
  None.

Definition load_s_s2_walk_result (sz: Z) (ofs: Z) (st: s_s2_walk_result) : option Z :=
  if (ofs =? 0) then Some (st.(e_walk_pa)) else
  if (ofs =? 8) then Some (st.(e_walk_rtt_level)) else
  if (ofs =? 16) then Some (st.(e_walk_ripas)) else
  if (ofs =? 20) then Some (st.(e_walk_destroyed)) else
  if (ofs =? 24) then Some (st.(e_walk_llt)) else
  None.

Definition store_s_s2_walk_result (sz: Z) (ofs: Z) (v: Z) (st: s_s2_walk_result) : option s_s2_walk_result :=
  if (ofs =? 0) then Some (st.[e_walk_pa] :< v) else
  if (ofs =? 8) then Some (st.[e_walk_rtt_level] :< v) else
  if (ofs =? 16) then Some (st.[e_walk_ripas] :< v) else
  if (ofs =? 20) then Some (st.[e_walk_destroyed] :< v) else
  if (ofs =? 24) then Some (st.[e_walk_llt] :< v) else
  None.

(* When allocating memory from the stack, we need a way to specify which data slot *)
(* it points to. However, the current Ptr type definition only allows us to store *)
(* the base of a string and the offset to the base. As a workaround, we assume the *)
(* stack has a limited amount of memory aligned to the power of 2. Then we can *)
(* leverage the lower bits to store the actual offset and the higher bits to store *)
(* the slot number. *)
(* Parameter MaxStackOrder : Z. *)

(* Definition stack_ptr_extract_ofs (ofs: Z) : Z := ofs & (MaxStackOrder - 1). *)
(* Definition stack_ptr_extract_slot (ofs: Z) : Z := ofs >> MaxStackOrder. *)

Parameter MaxStackOrder : Z.

Definition stack_ptr_extract_ofs (ofs: Z) : Z := ofs mod MaxStackOrder.
Definition stack_ptr_extract_slot (ofs: Z) : Z := ofs / MaxStackOrder.

Definition s_granule_set_size : Z := 40.

Record s_xlat_llt_info :=
 mks_xlat_llt_info {
    llt_info_table : Z;
    llt_info_llt_base_va : Z;
    llt_info_level : Z
   }.

Definition load_s_xlat_llt_info (sz: Z) (ofs: Z) (st: s_xlat_llt_info) : option Z :=
  if (ofs =? 0) then Some (st.(llt_info_table)) else
  if (ofs =? 8) then Some (st.(llt_info_llt_base_va)) else
  if (ofs =? 16) then Some (st.(llt_info_level)) else
  None.

Definition store_s_xlat_llt_info (sz: Z) (ofs: Z) (v: Z) (st: s_xlat_llt_info) : option s_xlat_llt_info :=
  if (ofs =? 0) then Some (st.[llt_info_table] :< v) else
  if (ofs =? 8) then Some (st.[llt_info_llt_base_va] :< v) else
  if (ofs =? 16) then Some (st.[llt_info_level] :< v) else
  None.

Record StackData :=
  mkStackData {
      sd_data: Z;
      sd_size: Z
    }.

Record StackFrame :=
  mkStackFrame{
      sf_data: ZMap.t StackData;
      sf_sp: Z
    }.

Record PerCPURegs :=
  mkPerCPURegs {
      (* EL2 Regs *)
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

      (* EL12 Regs *)
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

      (* EL1 Regs *)
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

      (* EL0 Regs *)
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

      pcpu_dummy_regs: Z
  }.

Record GPRegs :=
  mkGPRegs {
      X0: Z;
      X1: Z;
      X2: Z;
      X3: Z;
      X4: Z;
      X5: Z;
      X6: Z;
      X7: Z;
      X8: Z;
      X9: Z;
      X10: Z;
      X11: Z;
      X12: Z;
      X13: Z;
      X14: Z;
      X15: Z;
      X16: Z;
      X17: Z;
      X18: Z;
      X19: Z;
      X20: Z;
      X21: Z;
      X22: Z;
      X23: Z;
      X24: Z;
      X25: Z;
      X26: Z;
      X27: Z;
      X28: Z;
      X29: Z;
      LR: Z
    }.

Record PerCPU :=
  mkPerCPU {
      (*
       *  The stack is modeled as a ZMap of ZMap, each of the outter ZMap
       * corrpesonds to the stack. frame of a function. When a function allocates
       * memory from the stack, a (inner) ZMap is "pushed" to the outter ZMap,
       * indexed by a separtely maintained "PC" of tyep Z, and "poped" when the
       * function returns.  Thus a function can access the caller's stack but not
       * vice versa, and the allocated memory is freed upon return.
       *
       * In RMM, most stack memory are used as temporary varible so we don't
       * really care about its semantics to the abstract state and thus naively
       * using a ZMap should suffice.
       *)
      pcpu_regs: PerCPURegs;
      pcpu_gpregs: GPRegs;

      pcpu_llt_info_cache: ZMap.t s_xlat_llt_info

    }.

Record Shared :=
  mkShared {
      glk: ZMap.t (option Z);
      gpt: ZMap.t bool; (* gidx -> PAS *)

      (* granule index is multiplex by both the index to the *)
      (* struct granule granules[] array and the internal index *)
      (* to the physical granules. The index is modeled as the PFN. *)

      (* slot -> granule index set by granule_map *)
      slots: ZMap.t Z;
      (* granule index -> struct granule, i.e. struct granule granules[] *)
      granules: ZMap.t s_granule;
      (* granule index -> physical granules storing the data *)
      granule_data: ZMap.t GranuleDataNormal;

      (* global varibles *)
      gv_g_sve_max_vq: Z;
      (* gv_g_ns_simd: s_ns_simd_state; *)
      gv_g_ns_simd: ZMap.t Z; (* Don't care about the abstraction. *)
      gv_g_cpu_simd_type: Z;
      gv_vmids: ZMap.t Z
    }.

Parameter empty_st: Z -> (Shared). (* initial state *)

Definition RMI_HASH_ALGO_SHA256 : Z := 0.
Definition RMI_HASH_ALGO_SHA512 : Z := 1.
Definition HASH_ALGO_SHA256: Z := RMI_HASH_ALGO_SHA256.
Definition HASH_ALGO_SHA512: Z := RMI_HASH_ALGO_SHA512.
Definition SHA256_SIZE: Z := 32.
Definition SHA512_SIZE: Z := 64.

Inductive ns_copy_type :=
| READ_REALM_PARAMS
| READ_REC_PARAMS
| READ_REC_RUN
| WRITE_REC_RUN (run: ZMap.t Z)
| READ_DATA (gidx: Z).

Inductive update_rec_list_type :=
| GET_RECL
| SET_RECL (gidx: Z)
| UNSET_RECL.

Inductive realm_trap_type :=
| WFX
| HVC
| SMC
| IDREG
| TIMER
| ICC
| DATA_ABORT
| INSTR_ABORT
| IRQ
| FIQ.

Inductive AtomicEvent :=
(* acqure lock of gidx with tag *)
| ACQ (gidx: Z)
(* release lock *)
| REL (gidx1: Z) (g': s_granule)
(* access Rec's refcount protected *)
| REC_REF (ref_gidx: Z) (ref_cnt: Z)
(* update realm or rec's refcount *)
| GET_GCNT (gidx3: Z)
| INC_GCNT (gidx4: Z)
| DEC_RD_GCNT (gidx5: Z)
| DEC_REC_GCNT (gidx6: Z) (g'1: s_granule)
(* access rec_list *)
| RECL (gidx7: Z) (idx8: Z) (t: update_rec_list_type)
(* update the gpt entry *)
| ACQ_GPT (gidx9: Z)
| REL_GPT (gidx10: Z) (secure: bool)
(* Higher Layer's RTT ops *)
| RTT_WALK (root_gidx: Z) (map_addr: Z) (level: Z)
| RTT_CREATE (root_gidx1: Z) (map_addr1: Z) (level1: Z) (rtt_addr: Z)
| RTT_DESTROY (root_gidx2: Z) (map_addr2: Z) (level2: Z)
(* read or write from a NS graunle *)
| COPY_NS (gidx11: Z) (t1: ns_copy_type)
(*
   Hypervisor & Realms' behavior
 *)
(* memory access from NS world, addr -> physical address *)
| NS_ACCESS_MEM (addr: Z) (val: Z)
| REALM_ACCESS_MEM (rd: Z) (rec: Z) (addr1: Z) (val1: Z)
| REALM_ACCESS_REG (rd1: Z) (rec1: Z) (reg: Z) (val2: Z)
| REALM_ACTIVATE (rd_gidx: Z)
| REALM_TRAP (rd2: Z) (rec2: Z) (trap_type: realm_trap_type).

Inductive Event :=
| EVT (cpuid: Z) (e: AtomicEvent).

Definition Log := list Event.

(* input: current log output: other CPUs' events *)
Definition Oracle := Log -> (Log).

Definition Replay := Log -> (Shared -> (option Shared)).

Parameter realm_trap_determ: Log -> (realm_trap_type).

Parameter rmi_realm_params : s_rmi_realm_params.
Parameter common_sysregs_init : s_common_sysreg_state.
Parameter sysregs_init : s_sysreg_state.
Parameter rec_regs_init : ZMap.t Z.
Parameter rec_pc_init : Z.
Parameter rec_pstate_init : Z.
Parameter rec_params_mpidr: Z.
Parameter empty_rec: s_rec.
Parameter empty_rd: s_rd.

Definition rtt_num_start : Z := 1.

Record STACK :=
  mkSTACK {
    stack_wi: s_rtt_walk;
    stack_g_tbls: ZMap.t Z;
    stack_gs0: s_granule_set;
    stack_gs1: s_granule_set;
    stack_gs_temp: s_granule_set;
    stack_g_tbl: Z;
    stack_g0: Z;
    stack_g1: Z;
    stack_s2_ctx: s_realm_s2_context;
    stack_ripas_ptr: Z;
    stack_ripas: Z;
    stack_rtt_level: Z;
    stack_walk_res: s_s2_walk_result;
    stack_s2tte: Z;
    stack_realm_params: s_rmi_realm_params;
    stack_rec_aux_granules: ZMap.t Z;
    stack_rec_params: s_rmi_rec_params;
    stack_smc_result: s_smc_result;
    stack_rmi_rec_run: s_rmi_rec_run
    }.

Record RData :=
  mkRData {
      log: list Event;
      oracle: Oracle;
      repl: Replay;

      share: Shared;
      priv: PerCPU;

      stack: STACK
    }.

Definition query_oracle (st: RData) : option RData :=
  let lo := (st.(oracle) (st.(log))) in
  when sh == st.(repl) lo (st.(share));
  Some ((st.[log] :< lo ++ st.(log)).[share] :< sh).

Parameter gic_virt_feature_0 : Z.
Parameter gic_virt_feature_1 : Z.
Parameter gic_virt_feature_2 : Z.
Parameter gic_virt_feature_3 : Z.
Parameter gic_virt_feature_4 : Z.

Definition REC_HEAP_SIZE : Z := 8192.
Definition REC_PMU_SIZE : Z := 8192.
Definition NS_SIMD_SIZE : Z := 8800.

(* States of a granule *)
Definition GRANULE_STATE_NS : Z := 0.
Definition GRANULE_STATE_UNDELEGATED : Z := GRANULE_STATE_NS.
Definition GRANULE_STATE_DELEGATED : Z := 1.
Definition GRANULE_STATE_RD : Z := 2.
Definition GRANULE_STATE_REC : Z := 3.
Definition GRANULE_STATE_REC_AUX : Z := 4.
Definition GRANULE_STATE_DATA : Z := 5.
Definition GRANULE_STATE_RTT : Z := 6.
Definition GRANULE_STATE_LAST : Z := GRANULE_STATE_RTT.


Definition int_is_g0 (v: Z) : Prop :=
  (v > 0 /\ (((v - STACK_VIRT) / GRANULE_SIZE + STACK_slot_ofs) = STACK_g0)).

Definition int_is_g1 (v: Z) : Prop :=
  (v > 0 /\ (((v - STACK_VIRT) / GRANULE_SIZE + STACK_slot_ofs) = STACK_g1)).

Parameter DEFAULT_RTT_VAL : Z.
Parameter DEFAULT_RTT2_VAL : Z.
Parameter DEFAULT_STACK_VAL : Z.
Parameter DEFAULT_LLT_INFO_CACHE : Z.

Definition rec_is_locked (st: RData) : Prop := ((st.(share).(granules) @ (st.(share).(slots) @ SLOT_REC)).(e_lock) = Some CPU_ID).
Definition rec_is_unlocked (st: RData) : Prop := ((st.(share).(granules) @ (st.(share).(slots) @ SLOT_REC)).(e_lock) = None).
Definition rec_aux_is_locked (st: RData) : Prop :=
  let g_idx := st.(share).(slots) @ SLOT_REC_AUX0 in
  let g_data := st.(share).(granule_data) @ g_idx in
  let parent_g_idx := g_data.(rec_gidx) in
  let parent_g_data := st.(share).(granule_data) @ parent_g_idx in
  let parent_g := st.(share).(granules) @ parent_g_idx in
  parent_g.(e_lock) = Some CPU_ID.
Definition rec_aux_is_unlocked (st: RData) : Prop :=
  let g_idx := st.(share).(slots) @ SLOT_REC_AUX0 in
  let g_data := st.(share).(granule_data) @ g_idx in
  let parent_g_idx := g_data.(rec_gidx) in
  let parent_g_data := st.(share).(granule_data) @ parent_g_idx in
  let parent_g := st.(share).(granules) @ parent_g_idx in
  parent_g.(e_lock) = None.
Definition rec_aux_refcount_zero (st: RData) : Prop :=
  let g_idx := st.(share).(slots) @ SLOT_REC_AUX0 in
  let g_data := st.(share).(granule_data) @ g_idx in
  let parent_g_idx := g_data.(rec_gidx) in
  let parent_g_data := st.(share).(granule_data) @ parent_g_idx in
  let parent_g := st.(share).(granules) @ parent_g_idx in
  parent_g.(e_refcount) = 0.
Definition rec_aux_refcount_one (st: RData) : Prop :=
  let g_idx := st.(share).(slots) @ SLOT_REC_AUX0 in
  let g_data := st.(share).(granule_data) @ g_idx in
  let parent_g_idx := g_data.(rec_gidx) in
  let parent_g_data := st.(share).(granule_data) @ parent_g_idx in
  let parent_g := st.(share).(granules) @ parent_g_idx in
  parent_g.(e_refcount) = 1.

Definition rec_has_rd (st: RData) : Prop := ((int_to_ptr ((st.(share).(granule_data) @ (st.(share).(slots) @ SLOT_REC)).(g_rec).(e_realm_info).(e_g_rd))).(pbase) = "granules").
Definition rec_no_rd (st: RData) : Prop := ((int_to_ptr ((st.(share).(granule_data) @ (st.(share).(slots) @ SLOT_REC)).(g_rec).(e_realm_info).(e_g_rd))).(pbase) = "null").
Definition rec_refcount_zero (st: RData) : Prop := ((st.(share).(granules) @ (st.(share).(slots) @ SLOT_REC)).(e_refcount) = 0).
Definition rec_refcount_one (st: RData) : Prop := ((st.(share).(granules) @ (st.(share).(slots) @ SLOT_REC)).(e_refcount) = 1).

Definition rd_is_locked (st: RData) : Prop := (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = Some CPU_ID).

Definition rec_field_accessible (rec_granule: s_granule) (locked: bool) (st: RData): bool :=
  if locked then rec_granule.(e_refcount) =? 0 else rec_granule.(e_refcount) =? 1.

Definition _rec_field_accessible (rec: s_rec) (ofs: Z) (rec_granule: s_granule) (locked: bool) (st: RData): bool :=
  let rec_g_rd := int_to_ptr rec.(e_realm_info).(e_g_rd) in
  if rec_g_rd.(pbase) =s "granules" then(
    let ofs := rec_g_rd.(poffset) in
    let idx := ofs / ST_GRANULE_SIZE in
    let g_data := st.(share).(granule_data) @ idx in
    let g := st.(share).(granules) @ idx in
    (* a REC has to be lock protected if its Realm is not activated *)
    if g.(e_state) <>? GRANULE_STATE_RD then
      locked else
    if g_data.(g_rd).(e_rd_rd_state) <>? REALM_STATE_ACTIVE then
      locked else
    (* set_ripas is locked protected whatsoever *)
    if (ofs >=? 848) && (ofs <? 880) then
      locked
    else
      (* If the Realm has already been activated, *)
      (* a REC has to be either ref- or lock-protected. *)
      (* Only ONE sync mechanism can be used at a time so it's still DRF. *)
      if g.(e_refcount) =? 1 then
        (* ref-protected fields should only be accessed w.o. a spinlock *)
        (!locked) else
      if g.(e_refcount) =? 0 then
        (* If a ref-protected field is accessed with 0 refcount, a lock must be hold *)
        locked
      else
        (* If refcount > 1, something also went wrong *)
        false)
  else locked. (* if no RD associate with the REC, it is initialization *)

(* XXX: think about this *)
Definition rd_field_accessible (rd: s_rd) (ofs: Z) (rd_granule: s_granule) (write: bool) (st: RData) : bool :=
  if write then
    match rd_granule.(e_lock) with
    | Some cid => true
    | None => false
    end
  else true.

Definition s_granule_field_accessible (g: s_granule) (ofs: Z) : bool :=
  (* granule_state can only be accessed with lock *)
  if ofs =? 4 then
    match g.(e_lock) with
    | Some cid => true
    | None => false
    end else
  (* XXX: refcount *)
  if ofs =? 8 then (
    (* XXX: refcount of an RD granule can be accessed w.o. a lock *)
    if g.(e_state) =? GRANULE_STATE_RD then
      true
    else
    (* otherwise, the refcount must be lock protected *)
      match g.(e_lock) with
      | Some cid => true
      | None => false
      end )
  (* lock should not be directly accessed *)
  else false.

Parameter sysreg_handlers_base : Z.

Definition load_RData (sz: Z) (p: Ptr) (st: RData) : (option (Z * RData)) :=
  if (p.(pbase) =s "sysreg_handlers") then (
    Some (sysreg_handlers_base, st)
    ) else
  if (p.(pbase) =s "gic_virt_feature_0") then Some (gic_virt_feature_0, st) else
  if (p.(pbase) =s "gic_virt_feature_1") then Some (gic_virt_feature_1, st) else
  if (p.(pbase) =s "gic_virt_feature_2") then Some (gic_virt_feature_2, st) else
  if (p.(pbase) =s "gic_virt_feature_3") then Some (gic_virt_feature_3, st) else
  if (p.(pbase) =s "gic_virt_feature_4") then Some (gic_virt_feature_4, st) else
  if p.(pbase) =s "granules" then (
      let ofs := p.(poffset) in
      let idx := ofs / ST_GRANULE_SIZE in
      let ofs := ofs mod ST_GRANULE_SIZE in
      when ret == load_s_granule sz ofs (ZMap.get st.(share).(granules) idx);
      Some (ret, st)
      ) else
  if p.(pbase) =s "slot_rd" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RD in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      when ret == load_s_rd sz ofs g_data.(g_rd);
      Some (ret, st)
    ) else
  if p.(pbase) =s "slot_rec" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      when ret == load_s_rec sz ofs g_data.(g_rec);
      Some (ret, st)
    ) else
  if p.(pbase) =s "slot_rec2" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC2 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      when ret == load_s_rec sz ofs g_data.(g_rec);
      Some (ret, st)
    ) else
  if p.(pbase) =s "slot_rtt" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RTT in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      match g.(e_lock) with
      | Some cid => Some (g_data.(g_norm) @ ofs, st)
      | None => None
      end ) else
  if p.(pbase) =s "slot_rtt2" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RTT2 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      match g.(e_lock) with
      | Some cid => Some (g_data.(g_norm) @ ofs, st)
      | None => None
      end ) else
  if p.(pbase) =s "slot_rsi_call" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RSI_CALL in
      let g_data := st.(share).(granule_data) @ g_idx in
      Some (g_data.(g_norm) @ ofs, st)) else
  if p.(pbase) =s "slot_delegated" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_DELEGATED in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      match g.(e_lock) with
      | Some cid => Some (g_data.(g_norm) @ ofs, st)
      | None => None
      end ) else
  if p.(pbase) =s "slot_rec_aux0" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC_AUX0 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let parent_g_idx := g_data.(rec_gidx) in
      let parent_g_data := st.(share).(granule_data) @ parent_g_idx in
      let parent_g := st.(share).(granules) @ parent_g_idx in
      (* Attestation HEAP *)
      if (0 <=? ofs) && (ofs <? REC_HEAP_SIZE) then Some (0, st) else
      (* struct pmu_state *)
      if (REC_HEAP_SIZE <=? ofs) && (ofs <? REC_HEAP_SIZE + REC_PMU_SIZE) then
        when ret == load_s_pmu_state sz (ofs - REC_HEAP_SIZE) g_data.(g_aux_pmu_state);
        Some (ret, st) else
      if (REC_HEAP_SIZE + REC_PMU_SIZE <=? ofs) then
        when ret == load_s_simd_state sz (ofs - REC_HEAP_SIZE - REC_PMU_SIZE) g_data.(g_aux_simd_state);
        Some (ret, st)
      else None
    ) else
  if p.(pbase) =s "bad_stack" then (
      let ofs := p.(poffset) in
      Some (DEFAULT_STACK_VAL, st) ) else
  (* new stack Definition begins *)
  if p.(pbase) =s "stack_wi" then (
      when ret == load_s_rtt_walk sz p.(poffset) st.(stack).(stack_wi);
      Some (ret, st)) else
  if p.(pbase) =s "stack_g_tbls" then (
      let idx := p.(poffset) / 8 in
      let ptr := st.(stack).(stack_g_tbls) @ idx in
      rely (int_is_granule ptr);
      Some (ptr, st)) else
  if p.(pbase) =s "stack_rec_aux_granules" then (
      let idx := p.(poffset) / 8 in
      let ptr := st.(stack).(stack_rec_aux_granules) @ idx in
      rely (int_is_granule ptr);
      Some (ptr, st)) else
  if p.(pbase) =s "stack_gs" then (
      let idx := p.(poffset) / 40 in
      let ofs := p.(poffset) mod 40 in
      if (idx =? 0) then (
        when ret == load_s_granule_set sz ofs (st.(stack).(stack_gs0));
        if (ofs =? 24) then
          rely (int_is_granule ret);
          Some (ret, st)
        else if (ofs =? 32) then
          rely (int_is_g0 ret);
          Some (ret, st)
        else Some (ret, st)
        )
      else (
        when ret == load_s_granule_set sz ofs (st.(stack).(stack_gs1));
        if (ofs =? 24) then
          rely (int_is_granule ret);
          Some (ret, st)
        else if (ofs =? 32) then
          rely (int_is_g1 ret);
          Some (ret, st)
        else Some (ret, st)
        )
    ) else
  if p.(pbase) =s "stack_gs_temp" then (
     when ret == load_s_granule_set sz p.(poffset) (st.(stack).(stack_gs_temp));
     if (p.(poffset) =? 24) then
       rely (int_is_granule ret);
       Some (ret, st)
     else
       Some (ret, st)
  ) else
  if p.(pbase) =s "stack_g0" then (
      rely (int_is_granule st.(stack).(stack_g0));
      Some (st.(stack).(stack_g0), st)
  ) else
  if p.(pbase) =s "stack_g1" then (
      rely (int_is_granule st.(stack).(stack_g1));
      Some (st.(stack).(stack_g1), st)
  ) else
  if p.(pbase) =s "stack_s2_ctx" then (
      when ret == load_s_realm_s2_context sz p.(poffset) st.(stack).(stack_s2_ctx);
      Some (ret, st)
    ) else
  if p.(pbase) =s "stack_ripas_ptr" then (
      Some (st.(stack).(stack_ripas_ptr), st)
    ) else
  if p.(pbase) =s "stack_ripas" then (
      Some (st.(stack).(stack_ripas), st)
  ) else
  if p.(pbase) =s "stack_rtt_level" then (
      Some (st.(stack).(stack_rtt_level), st)
  ) else
  if p.(pbase) =s "stack_walk_res" then (
      when ret == load_s_s2_walk_result sz p.(poffset) st.(stack).(stack_walk_res);
      Some (ret, st)
    ) else
  if p.(pbase) =s "stack_s2tte" then (
      Some (st.(stack).(stack_s2tte), st)
    ) else
  if p.(pbase) =s "stack_realm_params" then (
      when ret == load_s_rmi_realm_params sz p.(poffset) st.(stack).(stack_realm_params);
      Some (ret, st)
    ) else
  if p.(pbase) =s "stack_rec_params" then (
      when ret == load_s_rmi_rec_params sz p.(poffset) st.(stack).(stack_rec_params);
      Some (ret, st)
      ) else
  if p.(pbase) =s "stack_smc_result" then (
      when ret == load_s_smc_result sz p.(poffset) st.(stack).(stack_smc_result);
      Some (ret, st)
    ) else
  if p.(pbase) =s "stack_rmi_rec_run" then (
      when ret == load_s_rmi_rec_run sz p.(poffset) st.(stack).(stack_rmi_rec_run);
      Some (ret, st)
  ) else
  (* new stack Definition ends *)
  (* Global variables *)
  if p.(pbase) =s "__const_arch_feat_get_pa_width_pa_range_bits_arr" then (
      let ofs := p.(poffset) in
      if ofs =? 0 then Some (32, st) else
      if ofs =? 4 then Some (36, st) else
      if ofs =? 8 then Some (40, st) else
      if ofs =? 12 then Some (42, st) else
      if ofs =? 16 then Some (44, st) else
      if ofs =? 20 then Some (48, st) else
      if ofs =? 24 then Some (52, st) else
        None ) else
  if p.(pbase) =s "g_sve_max_vq" then (let ofs := p.(poffset) in Some (st.(share).(gv_g_sve_max_vq), st)) else
  if p.(pbase) =s "g_ns_simd" then
    (* let ofs := p.(poffset) in *)
    (* when ret == load_s_ns_simd_state sz ofs st.(share).(gv_g_ns_simd); *)
    (* Some (ret, st) else *)
    let ofs := p.(poffset) in
    let ret := st.(share).(gv_g_ns_simd) @ ofs in
    Some (ret, st) else
  if p.(pbase) =s "g_cpu_simd_type" then
      let ofs := p.(poffset) in
      Some (st.(share).(gv_g_cpu_simd_type), st) else
  if p.(pbase) =s "llt_info_cache" then
      let ofs := p.(poffset) in
      let cpuidx := ofs / 24 in
      let elem_ofs := ofs mod 24 in
      let cache_entry := st.(priv).(pcpu_llt_info_cache) @ cpuidx in
      when ret == load_s_xlat_llt_info sz elem_ofs cache_entry;
      Some (ret, st) else
  if p.(pbase) =s "sl0_val" then (
      let ofs := p.(poffset) in
      if ofs =? 0 then Some (0, st) else
      if ofs =? 8 then Some (64, st) else
      if ofs =? 16 then Some (128, st) else
      if ofs =? 24 then Some (192, st) else None) else
  if p.(pbase) =s "vmids" then (
      rely (((p.(poffset)) mod 8) = 0);
      let idx := p.(poffset) / 8 in
      Some (st.(share).(gv_vmids) @ idx, st))
  else None.

Definition store_RData (sz: Z) (p: Ptr) (v: Z) (st: RData) : option RData :=
  if p.(pbase) =s "granules" then (
      let ofs := p.(poffset) in
      let idx := ofs / ST_GRANULE_SIZE in
      let elem_ofs := ofs mod ST_GRANULE_SIZE in
      when ret == store_s_granule sz elem_ofs v (ZMap.get st.(share).(granules) idx);
      let new_granules := ZMap.set st.(share).(granules) idx ret in
      if (elem_ofs =? 8) && ((ZMap.get st.(share).(granules) idx).(e_state) =? GRANULE_STATE_REC) then
         let st := st.[log] :< ((EVT CPU_ID (REC_REF idx v)) :: st.(log)) in
         Some (st.[share].[granules] :< new_granules)
      else
        Some (st.[share].[granules] :< new_granules))
  else
  if p.(pbase) =s "slot_rd" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RD in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      when new_rd == store_s_rd sz ofs v g_data.(g_rd);
      let new_gdata := (g_data.[g_rd] :< new_rd) in
      Some (st.[share].[granule_data] :< (st.(share).(granule_data) # g_idx == new_gdata))
    ) else
  if p.(pbase) =s "slot_rec" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      when new_rec == store_s_rec sz ofs v g_data.(g_rec);
      let new_gdata := (g_data.[g_rec] :< new_rec) in
      Some (st.[share].[granule_data] :< st.(share).(granule_data) # g_idx == new_gdata)
    ) else
  if p.(pbase) =s "slot_rec2" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC2 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      when new_rec == store_s_rec sz ofs v g_data.(g_rec);
      let new_gdata := (g_data.[g_rec] :< new_rec) in
      Some (st.[share].[granule_data] :< (st.(share).(granule_data) # g_idx == new_gdata))
    ) else
  if p.(pbase) =s "slot_rtt" then let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RTT in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      match g.(e_lock) with
      | Some cid =>
          Some (st.[share].[granule_data] :< ((st.(share).(granule_data)) # g_idx == (g_data.[g_norm] :< (g_data.(g_norm) # ofs == v))))
      | None => None
      end else
  if p.(pbase) =s "slot_rec_aux0" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC_AUX0 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let parent_g_idx := g_data.(rec_gidx) in
      let parent_g_data := st.(share).(granule_data) @ parent_g_idx in
      let parent_g := st.(share).(granules) @ parent_g_idx in
      (* Attestation HEAP *)
      if (0 <=? ofs) && (ofs <? REC_HEAP_SIZE) then Some st else
      (* struct pmu_state *)
      if (REC_HEAP_SIZE <=? ofs) && (ofs <? REC_HEAP_SIZE + REC_PMU_SIZE) then
        when new_pmu_state == store_s_pmu_state sz (ofs - REC_HEAP_SIZE) v g_data.(g_aux_pmu_state);
        let new_gdata := (g_data.[g_aux_pmu_state] :< new_pmu_state) in
        Some (st.[share].[granule_data] :< (st.(share).(granule_data) # g_idx == new_gdata))
      else
        if (REC_HEAP_SIZE + REC_PMU_SIZE <=? ofs) then
          when new_simd_state == store_s_simd_state sz (ofs - REC_HEAP_SIZE - REC_PMU_SIZE) v g_data.(g_aux_simd_state);
          let new_gdata := (g_data.[g_aux_simd_state] :< new_simd_state) in
          Some (st.[share].[granule_data] :< (st.(share).(granule_data) # g_idx == new_gdata))
        else None) else
  if p.(pbase) =s "slot_rtt2" then let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RTT2 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      match g.(e_lock) with
      | Some cid =>
          Some (st.[share].[granule_data] :< ((st.(share).(granule_data)) # g_idx == (g_data.[g_norm] :< (g_data.(g_norm) # ofs == v))))
      | None => None
      end else
  if p.(pbase) =s "slot_rsi_call" then let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RSI_CALL in
      let g_data := st.(share).(granule_data) @ g_idx in
      Some st
      else
  if p.(pbase) =s "slot_delegated" then let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_DELEGATED in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      match g.(e_lock) with
      | Some cid =>
          Some (st.[share].[granule_data] :< ((st.(share).(granule_data)) # g_idx == (g_data.[g_norm] :< (g_data.(g_norm) # ofs == v))))
      | None => None
      end else
  if p.(pbase) =s "bad_stack" then let ofs := p.(poffset) in
      Some st else
  (* new stack definition begins *)
  if p.(pbase) =s "stack_wi" then (
      when new_wi == store_s_rtt_walk sz p.(poffset) v st.(stack).(stack_wi);
      Some (st.[stack].[stack_wi] :< new_wi)) else
  if p.(pbase) =s "stack_g_tbls" then (
      let idx := p.(poffset) / 8 in
      let new_ptr := st.(stack).(stack_g_tbls) # idx == v in
      Some (st.[stack].[stack_g_tbls] :< new_ptr)) else
  if p.(pbase) =s "stack_rec_aux_granules" then (
      let idx := p.(poffset) / 8 in
      let new_ptr := st.(stack).(stack_rec_aux_granules) # idx == v in
      Some (st.[stack].[stack_rec_aux_granules] :< new_ptr)) else
  if p.(pbase) =s "stack_gs" then (
      let idx := p.(poffset) / 40 in
      let ofs := p.(poffset) mod 40 in
      if (idx =? 0) then (
        when new_gs == store_s_granule_set sz ofs v (st.(stack).(stack_gs0));
        Some (st.[stack].[stack_gs0] :< new_gs)
        ) else (
        when new_gs == store_s_granule_set sz ofs v (st.(stack).(stack_gs1));
        Some (st.[stack].[stack_gs1] :< new_gs)
        )
    ) else
   if p.(pbase) =s "stack_gs_temp" then (
     when new_gs == store_s_granule_set sz p.(poffset) v (st.(stack).(stack_gs_temp));
     Some (st.[stack].[stack_gs_temp] :< new_gs)
   ) else
   if p.(pbase) =s "stack_g0" then (
       Some (st.[stack].[stack_g0] :< v)
     ) else
   if p.(pbase) =s "stack_g1" then (
       Some (st.[stack].[stack_g1] :< v)
     ) else
   if p.(pbase) =s "stack_s2_ctx" then (
     when new_s2_ctx == store_s_realm_s2_context sz p.(poffset) v (st.(stack).(stack_s2_ctx));
     Some (st.[stack].[stack_s2_ctx] :< new_s2_ctx)
   ) else
   if p.(pbase) =s "stack_ripas_ptr" then (
     Some (st.[stack].[stack_ripas_ptr] :< v)
     ) else
   if p.(pbase) =s "stack_ripas" then (
     Some (st.[stack].[stack_ripas] :< v)
   ) else
   if p.(pbase) =s "stack_rtt_level" then (
     Some (st.[stack].[stack_rtt_level] :< v)
   ) else
   if p.(pbase) =s "stack_walk_res" then (
     when new_walk_res == store_s_s2_walk_result sz p.(poffset) v (st.(stack).(stack_walk_res));
     Some (st.[stack].[stack_walk_res] :< new_walk_res)
   ) else
   if p.(pbase) =s "stack_s2tte" then (
       Some (st.[stack].[stack_s2tte] :< v)
     ) else
  if p.(pbase) =s "stack_smc_result" then (
     when new_smc_res == store_s_smc_result sz p.(poffset) v (st.(stack).(stack_smc_result));
     Some (st.[stack].[stack_smc_result] :< new_smc_res)
    ) else
  if p.(pbase) =s "stack_rmi_rec_run" then (
     when new_rec_run == store_s_rmi_rec_run sz p.(poffset) v (st.(stack).(stack_rmi_rec_run));
     Some (st.[stack].[stack_rmi_rec_run] :< new_rec_run)
  ) else
  (* new stack definition ends *)
  (* Global variables *)
  if p.(pbase) =s "g_sve_max_vq" then let ofs := p.(poffset) in Some (st.[share].[gv_g_sve_max_vq] :< v) else
  if p.(pbase) =s "g_ns_simd" then
    (* let ofs := p.(poffset) in *)
    (* when ret == store_s_ns_simd_state sz ofs v st.(share).(gv_g_ns_simd); *)
    (* Some (st.[share].[gv_g_ns_simd] :< ret) else *)
    let ofs := p.(poffset) in
    let ret := ((st.(share).(gv_g_ns_simd)) # ofs == v) in
    Some (st.[share].[gv_g_ns_simd] :< ret) else
  if p.(pbase) =s "g_cpu_simd_type" then let ofs := p.(poffset) in
      Some (st.[share].[gv_g_cpu_simd_type] :< v) else
  if p.(pbase) =s "llt_info_cache" then let ofs := p.(poffset) in Some st else
  if p.(pbase) =s "vmids" then
      let idx := p.(poffset) / 8 in
      rely (((p.(poffset)) mod 8) = 0);
      Some (st.[share].[gv_vmids] :< (st.(share).(gv_vmids) # idx == v))
  else
    None.

Definition alloc_stack (fname: string) (sz: Z) (ofs: Z) (st: RData) : option (Ptr * RData) :=
  if fname =s "find_lock_two_granules" then Some ((mkPtr "stack_gs" 0), st) else
  if fname =s "do_host_call" then Some ((mkPtr "stack_walk_res" 0), st) else
  if fname =s "sort_granules" then Some ((mkPtr "stack_gs_temp" 0), st) else
  if fname =s "rtt_walk_lock_unlock" then Some ((mkPtr "stack_g_tbls" 0), st) else
  if fname =s "map_unmap_ns" then (
      if (sz =? 24) then (Some ((mkPtr "stack_wi" 0), st)) else (Some ((mkPtr "stack_s2_ctx" 0), st))
  ) else
    Some ((mkPtr "bad_stack" 0), st).

Definition free_stack (fname: string) (init_st: RData) (st: RData) : option RData := Some st.

Definition new_frame (fname: string) (st: RData) : option RData :=
  Some st.

Definition base_to_slot (b: string) : Z :=
  if b =s "slot_ns" then SLOT_NS else
  if b =s "slot_delegated" then  SLOT_DELEGATED else
  if b =s "slot_rd" then  SLOT_RD else
  if b =s "slot_rec" then  SLOT_REC else
  if b =s "slot_rec2" then  SLOT_REC2 else
  if b =s "slot_rec_target" then  SLOT_REC_TARGET else
  if b =s "slot_rec_aux0" then  SLOT_REC_AUX0 else
  if b =s "slot_rtt" then  SLOT_RTT else
  if b =s "slot_rtt2" then  SLOT_RTT2 else
  if b =s "slot_rsi_call" then  SLOT_RSI_CALL else
  if b =s "stack_g0" then (STACK_g0) else
  if b =s "stack_g1" then (STACK_g1) else
  non_slot.

Definition ptr_to_int (p: Ptr) : Z :=
  let slot := (base_to_slot p.(pbase)) in
  if (slot =? non_slot) then (
    if (p.(pbase) =s "status") then (MAX_ERR + p.(poffset))
    else if (p.(pbase) =s "granules") then (GRANULES_BASE + p.(poffset))
    else if (p.(pbase) =s "null") then 0
    else (-1) )
  else (
    if slot <=? 24 then (SLOT_VIRT + slot * GRANULE_SIZE + p.(poffset))
    else (STACK_VIRT + (slot - STACK_slot_ofs) * GRANULE_SIZE + p.(poffset))).

Definition slot_to_ptr (slot: Z) (val: Z) : Ptr :=
  let ofs := (val - SLOT_VIRT) mod GRANULE_SIZE in
  if slot =? SLOT_NS then (mkPtr "slot_ns" ofs) else
  if slot =? SLOT_DELEGATED then (mkPtr "slot_delegated" ofs) else
  if slot =? SLOT_RD then (mkPtr "slot_rd" ofs) else
  if slot =? SLOT_REC then (mkPtr "slot_rec" ofs) else
  if slot =? SLOT_REC2 then (mkPtr "slot_rec2" ofs) else
  if slot =? SLOT_REC_TARGET then (mkPtr "slot_rec_target" ofs) else
  if (slot >=? SLOT_REC_AUX0) && (slot <? SLOT_REC_AUX0 + MAX_REC_AUX_GRANULES) then (mkPtr "slot_rec_aux0" ((val - SLOT_VIRT) mod (GRANULE_SIZE * MAX_REC_AUX_GRANULES))) else
  if slot =? SLOT_RTT then (mkPtr "slot_rtt" ofs) else
  if slot =? SLOT_RTT2 then (mkPtr "slot_rtt2" ofs) else
  if slot =? SLOT_RSI_CALL then (mkPtr "slot_rsi_call" ofs) else
    (mkPtr "null" 0).

Definition stack_to_ptr (slot: Z) (val: Z) : Ptr :=
  let ofs := (val - STACK_VIRT) mod GRANULE_SIZE in
  if slot =? STACK_g0 then (mkPtr "stack_g0" ofs) else
  if slot =? STACK_g1 then (mkPtr "stack_g1" ofs) else
    (mkPtr "null" 0).

Definition int_to_ptr (v: Z) : Ptr :=
  if v >? 0 then (
      if (v >=? MAX_ERR) then (mkPtr "status" (v - MAX_ERR))
      else if (v >=? SLOT_VIRT) then slot_to_ptr ((v - SLOT_VIRT) / GRANULE_SIZE) v
      else if (v >=? STACK_VIRT) then stack_to_ptr (((v - STACK_VIRT) / GRANULE_SIZE) + STACK_slot_ofs) v
      else if (v >=? GRANULES_BASE) then  (mkPtr "granules" (v - GRANULES_BASE))
      else (mkPtr "null" 0)
  ) else
      (mkPtr "null" 0).

Definition ptr_eqb (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 =? ptr_to_int p2.

Definition ptr_ltb (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 <? ptr_to_int p2.

Definition ptr_gtb (p1: Ptr) (p2: Ptr) : bool :=
  if (p2.(pbase) =s "status") then
    (if ((p1.(pbase) <>s "status")) then false
    else p1.(poffset) >? p2.(poffset))
  else ptr_to_int p1 >? ptr_to_int p2 .

Parameter lens : Z -> (RData -> (RData)).

Section Bottom.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PRIMS: list string :=
    "spinlock_acquire" ::
      "spinlock_release" ::
      (* memcpy *)
      "llvm_memcpy_p0i8_p0i8_i64" ::
      "llvm_memset_p0i8_i64" ::
      "memcpy_ns_read" ::
      "memcpy_ns_write" ::
      "memset" ::
      "memcpy" ::
      (* assert *)
      "__assert_fail" ::
      (* xlat *)
      "xlat_unmap_memory_page" ::
      "xlat_map_memory_page_with_attrs" ::
      "find_xlat_last_table" ::
      "xlat_arch_setup_mmu_cfg" ::
      "xlat_ctx_init" ::
      "xlat_get_llt_from_va" ::
      "xlat_get_tte_ptr" ::
      "xlat_read_tte" ::
      (* iasm related *)
      "read_tpidr_el2" ::
      "iasm_4" ::
      "iasm_10" ::
      "iasm_155" ::
      "iasm_154" ::
      "tlbivae2is" ::
      "tlbiipas2e1is" ::
      "tlbivmalle1is" ::
      "read_vttbr_el2" ::
      "write_vttbr_el2" ::
      "isb" ::
      "write_cnthctl_el2" ::
      "read_pmcr_el0" ::
      "write_mdcr_el2" ::
      "write_vpidr_el2" ::
      "read_mdcr_el2" ::
      "read_sctlr_el2" ::
      "read_elr_el2" ::
      "read_zcr_el2" ::
      "write_zcr_el2" ::
      "read_cptr_el2" ::
      "write_elr_el2" ::
      "write_cptr_el2" ::
      "write_far_el12" ::
      "read_midr_el1" ::
      "write_esr_el12" ::
      "write_spsr_el12" ::
      "write_elr_el12" ::
      "read_vbar_el12" ::
      "read_spsr_el2" ::
      "write_spsr_el2" ::
      "read_esr_el2" ::
      "read_far_el2" ::
      "read_hpfar_el2" ::
      "read_isr_el1" ::
      "write_vsesr_el2" ::
      "write_hcr_el2" ::
      "read_id_aa64mmfr0_el1" ::
      "read_id_aa64dfr0_el1" ::
      "read_id_aa64dfr1_el1" ::
      "read_id_aa64pfr0_el1" ::
      "read_id_aa64pfr1_el1" ::
      "monitor_call" ::
      "monitor_call_with_res" ::
      "run_realm" ::
      "read_pmevtyper12_el0" ::
      "read_pmevtyper0_el0" ::
      "read_pmevcntr0_el0" ::
      "read_pmevtyper1_el0" ::
      "read_pmevcntr1_el0" ::
      "read_pmevtyper2_el0" ::
      "read_pmevcntr2_el0" ::
      "read_pmevtyper3_el0" ::
      "read_pmevcntr3_el0" ::
      "read_pmevtyper4_el0" ::
      "read_pmevcntr4_el0" ::
      "read_pmevtyper5_el0" ::
      "read_pmevcntr5_el0" ::
      "read_pmevtyper6_el0" ::
      "read_pmevcntr6_el0" ::
      "read_pmevtyper7_el0" ::
      "read_pmevcntr7_el0" ::
      "read_pmevtyper8_el0" ::
      "read_pmevcntr8_el0" ::
      "read_pmevtyper9_el0" ::
      "read_pmevcntr9_el0" ::
      "read_pmevtyper10_el0" ::
      "read_pmevcntr10_el0" ::
      "read_pmevtyper11_el0" ::
      "read_pmevcntr11_el0" ::
      "read_pmccfiltr_el0" ::
      "read_pmccntr_el0" ::
      "read_pmcntenset_el0" ::
      "read_pmcntenclr_el0" ::
      "read_pmintenset_el1" ::
      "read_pmintenclr_el1" ::
      "read_pmovsset_el0" ::
      "read_pmovsclr_el0" ::
      "read_pmselr_el0" ::
      "read_pmuserenr_el0" ::
      "read_pmxevcntr_el0" ::
      "read_pmxevtyper_el0" ::
      "read_pmevcntr30_el0" ::
      "read_pmevtyper30_el0" ::
      "read_pmevcntr29_el0" ::
      "read_pmevtyper29_el0" ::
      "read_pmevcntr28_el0" ::
      "read_pmevtyper28_el0" ::
      "read_pmevcntr27_el0" ::
      "read_pmevtyper27_el0" ::
      "read_pmevcntr26_el0" ::
      "read_pmevtyper26_el0" ::
      "read_pmevcntr25_el0" ::
      "read_pmevtyper25_el0" ::
      "read_pmevcntr24_el0" ::
      "read_pmevtyper24_el0" ::
      "read_pmevcntr23_el0" ::
      "read_pmevtyper23_el0" ::
      "read_pmevcntr22_el0" ::
      "read_pmevtyper22_el0" ::
      "read_pmevcntr21_el0" ::
      "read_pmevtyper21_el0" ::
      "read_pmevcntr20_el0" ::
      "read_pmevtyper20_el0" ::
      "read_pmevcntr19_el0" ::
      "read_pmevtyper19_el0" ::
      "read_pmevcntr18_el0" ::
      "read_pmevtyper18_el0" ::
      "read_pmevcntr17_el0" ::
      "read_pmevtyper17_el0" ::
      "read_pmevcntr16_el0" ::
      "read_pmevtyper16_el0" ::
      "read_pmevcntr15_el0" ::
      "read_pmevtyper15_el0" ::
      "read_pmevcntr14_el0" ::
      "read_pmevtyper14_el0" ::
      "read_pmevcntr13_el0" ::
      "read_pmevtyper13_el0" ::
      "read_pmevcntr12_el0" ::
      "write_ich_hcr_el2" ::
      "write_icc_sre_el2" ::
      "read_ich_misr_el2" ::
      "read_ich_hcr_el2" ::
      "read_ich_vmcr_el2" ::
      "read_ich_lr15_el2" ::
      "read_cntv_cval_el02" ::
      "read_cntv_ctl_el02" ::
      "read_cntp_cval_el02" ::
      "read_cntp_ctl_el02" ::
      "read_cntvoff_el2" ::
      "read_cntpoff_el2" ::
      "read_disr_el1" ::
      "read_mdccint_el1" ::
      "read_mdscr_el1" ::
      "read_par_el1" ::
      "read_cntkctl_el12" ::
      "read_amair_el12" ::
      "read_tpidr_el1" ::
      "read_contextidr_el12" ::
      "read_mair_el12" ::
      "read_far_el12" ::
      "read_afsr1_el12" ::
      "read_afsr0_el12" ::
      "read_esr_el12" ::
      "read_tcr_el12" ::
      "read_ttbr1_el12" ::
      "read_ttbr0_el12" ::
      "read_cpacr_el12" ::
      "read_actlr_el1" ::
      "read_sctlr_el12" ::
      "read_csselr_el1" ::
      "read_tpidr_el0" ::
      "read_tpidrro_el0" ::
      "read_spsr_el12" ::
      "read_elr_el12" ::
      "read_sp_el1" ::
      "read_sp_el0" ::
      "write_pmevtyper12_el0" ::
      "write_pmevtyper0_el0" ::
      "write_pmevcntr0_el0" ::
      "write_pmevtyper1_el0" ::
      "write_pmevcntr1_el0" ::
      "write_pmevtyper2_el0" ::
      "write_pmevcntr2_el0" ::
      "write_pmevtyper3_el0" ::
      "write_pmevcntr3_el0" ::
      "write_pmevtyper4_el0" ::
      "write_pmevcntr4_el0" ::
      "write_pmevtyper5_el0" ::
      "write_pmevcntr5_el0" ::
      "write_pmevtyper6_el0" ::
      "write_pmevcntr6_el0" ::
      "write_pmevtyper7_el0" ::
      "write_pmevcntr7_el0" ::
      "write_pmevtyper8_el0" ::
      "write_pmevcntr8_el0" ::
      "write_pmevtyper9_el0" ::
      "write_pmevcntr9_el0" ::
      "write_pmevtyper10_el0" ::
      "write_pmevcntr10_el0" ::
      "write_pmevtyper11_el0" ::
      "write_pmevcntr11_el0" ::
      "write_pmccfiltr_el0" ::
      "write_pmccntr_el0" ::
      "write_pmcntenset_el0" ::
      "write_pmcntenclr_el0" ::
      "write_pmintenset_el1" ::
      "write_pmintenclr_el1" ::
      "write_pmovsset_el0" ::
      "write_pmovsclr_el0" ::
      "write_pmselr_el0" ::
      "write_pmuserenr_el0" ::
      "write_pmxevcntr_el0" ::
      "write_pmxevtyper_el0" ::
      "write_pmevcntr30_el0" ::
      "write_pmevtyper30_el0" ::
      "write_pmevcntr29_el0" ::
      "write_pmevtyper29_el0" ::
      "write_pmevcntr28_el0" ::
      "write_pmevtyper28_el0" ::
      "write_pmevcntr27_el0" ::
      "write_pmevtyper27_el0" ::
      "write_pmevcntr26_el0" ::
      "write_pmevtyper26_el0" ::
      "write_pmevcntr25_el0" ::
      "write_pmevtyper25_el0" ::
      "write_pmevcntr24_el0" ::
      "write_pmevtyper24_el0" ::
      "write_pmevcntr23_el0" ::
      "write_pmevtyper23_el0" ::
      "write_pmevcntr22_el0" ::
      "write_pmevtyper22_el0" ::
      "write_pmevcntr21_el0" ::
      "write_pmevtyper21_el0" ::
      "write_pmevcntr20_el0" ::
      "write_pmevtyper20_el0" ::
      "write_pmevcntr19_el0" ::
      "write_pmevtyper19_el0" ::
      "write_pmevcntr18_el0" ::
      "write_pmevtyper18_el0" ::
      "write_pmevcntr17_el0" ::
      "write_pmevtyper17_el0" ::
      "write_pmevcntr16_el0" ::
      "write_pmevtyper16_el0" ::
      "write_pmevcntr15_el0" ::
      "write_pmevtyper15_el0" ::
      "write_pmevcntr14_el0" ::
      "write_pmevtyper14_el0" ::
      "write_pmevcntr13_el0" ::
      "write_pmevtyper13_el0" ::
      "write_pmevcntr12_el0" ::
      "write_cntv_ctl_el02" ::
      "write_cntv_cval_el02" ::
      "write_cntp_ctl_el02" ::
      "write_cntp_cval_el02" ::
      "write_cntvoff_el2" ::
      "write_cntpoff_el2" ::
      "write_vmpidr_el2" ::
      "write_disr_el1" ::
      "write_mdccint_el1" ::
      "write_mdscr_el1" ::
      "write_par_el1" ::
      "write_cntkctl_el12" ::
      "write_amair_el12" ::
      "write_tpidr_el1" ::
      "write_contextidr_el12" ::
      "write_vbar_el12" ::
      "write_mair_el12" ::
      "write_afsr1_el12" ::
      "write_afsr0_el12" ::
      "write_tcr_el12" ::
      "write_ttbr1_el12" ::
      "write_ttbr0_el12" ::
      "write_cpacr_el12" ::
      "write_actlr_el1" ::
      "write_sctlr_el12" ::
      "write_csselr_el1" ::
      "write_tpidr_el0" ::
      "write_tpidrro_el0" ::
      "write_pmcr_el0" ::
      "write_sp_el1" ::
      "write_sp_el0" ::
      "read_icc_sre_el2" ::
      "read_icc_hppir1_el1" ::
      "read_cnthctl_el2" ::
      "write_ich_vmcr_el2" ::
      "write_vtcr_el2" ::
      (* atomic *)
      "atomic_load_add_release_64" ::
      "atomic_add_64" ::
      "__sca_read64_acquire" ::
      "__sca_read64" ::
      "__sca_write64" ::
      "__sca_write64_release" ::
      "atomic_bit_set_acquire_release_64" ::
      "atomic_bit_clear_release_64" ::
      (* Measurement *)
      "measurement_get_size" ::
      "measurement_hash_compute" ::
      "measurement_extend" ::
      (* FPU *)
      "fpu_save_state" ::
      "fpu_restore_state" ::
      "sve_save_p_ffr_state" ::
      "sve_save_zcr_fpu_state" ::
      "sve_save_z_state" ::
      "sve_restore_ffr_p_state" ::
      "sve_restore_zcr_fpu_state" ::
      "sve_restore_z_state" ::
      (* tcose *)
      "t_cose_sign1_encode_signature" ::
      (* QCBORE *)
      "QCBOREncode_CloseMap" ::
      "QCBOREncode_Finish" ::
      "QCBOREncode_AddBytesToMapN" ::
      "QCBOREncode_AddTag" ::
      "QCBOREncode_Init" ::
      (* attestation *)
      "attest_get_platform_token" ::
      "attest_cca_token_create" ::
      "attest_realm_token_sign" ::
      "attest_realm_token_create" ::
      "attestation_heap_reinit_pe" ::
      "attestation_heap_ctx_assign_pe" ::
      "attestation_heap_ctx_init" ::
      "attestation_heap_ctx_unassign_pe" ::
      "get_rpv" ::
      "attest_token_continue_write_state" ::
      "attest_token_continue_sign_state" ::
      (* "handle_rsi_attest_token_init" :: *)
      "handle_rsi_extend_measurement" ::
      "handle_rsi_read_measurement" ::
      "handle_rsi_attest_token_continue" ::
      (* GIC *)
      "read_lrs" ::
      "read_aprs" ::
      "write_aprs" ::
      "write_lrs" ::
      (* Log *)
      "rmi_log_on_exit" ::
      "report_unexpected" ::
      "fatal_abort" ::
      (* tmp *)
      "simd_init" ::
      (* "find_lock_rd_granules" ::  *)(* Nested loop *)
      (* "__table_maps_block" :: *) (* Loop w. funptr *)
      (* "__table_is_uniform_block" :: *) (* Loop w. funptr *)
      (* "handle_realm_rsi" :: *)
      "complete_rsi_host_call" :: (* Array in the arg *)
      (* "handle_realm_exit" :: *)
      "complete_host_call" :: (* Array in the arg *)
      "handle_realm_trap" ::
      (* Callsite of Measurement functions, tmp put into TCB *)
      "ripas_granule_measure" ::
      "data_granule_measure" ::
      "rec_params_measure" ::
      "realm_params_measure" ::
      (* Abstract memory *)
      "plat_granule_addr_to_idx" ::
      "plat_granule_idx_to_addr" ::
      "stage2_tlbi_ipa" ::
      "status_ptr" ::
      "ptr_status" ::
      "ptr_is_err" ::
      "table_entry_to_phys" ::
      "rec_run_loop" ::
      nil.

  Definition status_ptr_spec (v_status: Z) (st: RData) : (option (Ptr * RData)) :=
    Some ((mkPtr "status" (v_status)), st).

  Definition ptr_status_spec (v_ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    if (v_ptr.(pbase) =s "status") then Some (v_ptr.(poffset), st) else Some (0, st).

  Definition ptr_is_err_spec (v_ptr: Ptr) (st: RData) : (option (bool * RData)) :=
    if (v_ptr.(pbase) =s "status") then Some (true, st) else Some (false, st).

  Definition table_entry_to_phys_spec (v_entry1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((v_entry1 & 281474976710655), st)).

  Definition ptr_eqb (p1: Ptr) (p2: Ptr) : bool :=
    (p1.(pbase) =s p2.(pbase)) && (p1.(poffset) =? p2.(poffset)).
  Definition ptr_lt (p1: Ptr) (p2: Ptr) : bool :=
    p1.(poffset) <? p2.(poffset).
  Definition ptr_gt (p1: Ptr) (p2: Ptr) : bool :=
    p1.(poffset) >? p2.(poffset).

  Definition spinlock_acquire_spec (lock: Ptr) (st: RData) : option RData :=
    if lock.(pbase) =s "granules" then
      let ofs := lock.(poffset) in
      let gidx_l := ofs / ST_GRANULE_SIZE in
      when st1 == query_oracle st;
      let g := (st1.(share).(granules) @ gidx_l) in
      match g.(e_lock) with
      | None =>
          let e := EVT CPU_ID (ACQ gidx_l) in
          let new_granules := st1.(share).(granules) # gidx_l == (g.[e_lock] :< (Some CPU_ID)) in
          let new_st := st1.[share].[granules] :< new_granules in
          rely ((st.(share).(granules) @ gidx_l).(e_state) = g.(e_state));
          Some (new_st.[log] :< (e :: new_st.(log)))
      | Some cid => None
      end
    else None.

  Definition spinlock_release_spec (lock: Ptr) (st: RData) : option RData :=
    if lock.(pbase) =s "granules" then
      let ofs := lock.(poffset) in
      let gidx_l := ofs / ST_GRANULE_SIZE in
      let g := (st.(share).(granules) @ gidx_l) in
      match g.(e_lock) with
      | Some cid =>
          let e := EVT CPU_ID (REL gidx_l g) in
          let new_granules := (st.(share).(granules)) # gidx_l == (g.[e_lock] :< None) in
          let new_st := st.[share].[granules] :< new_granules in
          Some (new_st.[log] :< (e :: new_st.(log)))
      | None => None
      end
    else None.
    (* if lock.(pbase) =s "granules" then *)
    (*   let gidx_l := lock.(poffset) in *)
    (*   rely (forall (gidx_l: Z), (st.(share).(glk) @ gidx_l = (Some CPU_ID))); *)
    (*   let e := EVT CPU_ID (REL_GPT gidx_l (st.(share).(gpt) @ gidx_l)) in *)
    (*   Some (st.[log] :< (e :: st.(log)).[share].[glk] :< (st.(share).(glk) # gidx_l == None)) *)
    (* else None. *)

  Definition __assert_fail_spec (st: RData) : option RData := None.

  (* Hint NoUnfold stack_ptr_extract_ofs. *)
  (* Hint NoUnfold stack_ptr_extract_slot. *)
  (* memcpy *)
  Definition llvm_memcpy_p0i8_p0i8_i64_spec (v_dest: Ptr) (v_src: Ptr) (sz: Z) (is_volatile: bool) (st: RData) : option RData :=
    if (sz =? 24) then (
        when v0, st == load_RData 8 v_src st;
        when v1, st == load_RData 8 (ptr_offset v_src 8) st;
        when v2, st == load_RData 8 (ptr_offset v_src 16) st;
        when st == store_RData 8 v_dest v0 st;
        when st == store_RData 8 (ptr_offset v_dest 8) v1 st;
        when st == store_RData 8 (ptr_offset v_dest 16) v2 st;
        Some st
    ) else if (sz =? 32) then (
      if ((v_dest.(pbase) =s "stack_s2_ctx") && (v_src.(pbase) =s "slot_rd")) then
        Some (st.[stack].[stack_s2_ctx] :< ((st.(share).(granule_data) @ ((st.(share).(slots)) @ SLOT_RD) ).(g_rd).(e_rd_s2_ctx)))
      else None
    ) else if (sz =? 40) then (
        when v0, st == load_RData 8 v_src st;
        when v1, st == load_RData 8 (ptr_offset v_src 8) st;
        when v2, st == load_RData 8 (ptr_offset v_src 16) st;
        when v3, st == load_RData 8 (ptr_offset v_src 24) st;
        when v4, st == load_RData 8 (ptr_offset v_src 32) st;
        when st == store_RData 8 v_dest v0 st;
        when st == store_RData 8 (ptr_offset v_dest 8) v1 st;
        when st == store_RData 8 (ptr_offset v_dest 16) v2 st;
        when st == store_RData 8 (ptr_offset v_dest 24) v3 st;
        when st == store_RData 8 (ptr_offset v_dest 32) v4 st;
        Some st) else None.

  (* Parameter llvm_memset_p0i8_i64_spec_state_oracle : Ptr -> (Z -> (Z -> (bool -> (RData -> (option RData))))). *)
  Definition llvm_memset_p0i8_i64_spec (v_0: Ptr) (arg1: Z) (arg2: Z) (arg3: bool) (st: RData) : option RData :=
    if (v_0.(pbase) =s "stack_g_tbls") then Some (st.[stack].[stack_g_tbls] :< (ZMap.init 0)) else Some st.
    (* llvm_memset_p0i8_i64_spec_state_oracle v_0 arg1 arg2 arg3 st. *)

  Parameter memcpy_ns_read_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).
  Definition memcpy_ns_read_spec (v_dest: Ptr) (v_src: Ptr) (v_conv: Z) (st: RData) : option (bool * RData) :=
    rely (v_src.(pbase) = "slot_ns");
    memcpy_ns_read_spec_state_oracle v_dest v_src v_conv st.
    (* if v_dest.(pbase) =s "stack" then ( *)
    (*   let ofs := v_dest.(poffset) in *)
    (*   if v_src.(pbase) =s "slot_ns" then *)
    (*     let ofs := v_src.(poffset) in *)
    (*     when st == memcpy_ns_read_spec_state_oracle st; *)
    (*     Some (true, st) *)
    (*   else None *)
    (*   ) *)
    (* else *)
    (*   if v_dest.(pbase) =s "slot_delegated" then *)
    (*     when st == memcpy_ns_read_spec_state_oracle st; *)
    (*     Some (true, st) *)
    (*   else None. *)

  Parameter memcpy_ns_write_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).
  Definition memcpy_ns_write_spec (v_dest: Ptr) (v_3: Ptr) (v_conv: Z) (st: RData) : option (bool * RData) :=
    memcpy_ns_write_spec_state_oracle v_dest v_3 v_conv st.

  Definition memset_spec (v_s: Ptr) (c: Z) (n: Z) (st: RData) : option (Ptr * RData) :=
    let g_idx := 
    (if ((v_s.(pbase) =s "slot_delegated")) then
      Some (st.(share).(slots) @ SLOT_DELEGATED)
    else if ((v_s.(pbase) =s "slot_rtt2")) then
      Some (st.(share).(slots) @ SLOT_RTT2)
    else if ((v_s.(pbase) =s "slot_rec")) then
      Some (st.(share).(slots) @ SLOT_REC)
    else if ((v_s.(pbase) =s "slot_rd")) then
      Some (st.(share).(slots) @ SLOT_RD) else None) in
    match g_idx with
    | None => Some (v_s, st)
    | Some idx =>
      let g_data := st.(share).(granule_data) @ idx in
      let g := st.(share).(granules) @ idx in
        match g.(e_lock) with
        | Some cid =>
            Some (v_s, st.[share].[granule_data] :<
                    (st.(share).(granule_data) # idx == (((g_data.[g_rec] :< empty_rec).[g_norm] :< zero_granule_data_normal).[g_rd] :< empty_rd)))
        | None => None
        end.
    end.

  Definition memcpy_spec (v_dst: Ptr) (v_src: Ptr) (v_len: Z) (st: RData) : option (Ptr * RData) := Some (v_dst, st).
  (* xlat *)
  Definition xlat_unmap_memory_page_spec (v_table: Ptr) (v_va: Z) (st: RData) : option (Z * RData) := Some (0, st).
  (* Definition xlat_unmap_memory_page_spec (v_table: Ptr) (v_va: Z) (st: RData) : option (Z * RData) := *)
  (*   let v_ptr := int_to_ptr v_va in *)
  (*   if (v_ptr.(pbase) =s "slot_ns") then *)
  (*     Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_NS == (-1)))) *)
  (*   else if (v_ptr.(pbase) =s "slot_delegated") then *)
  (*     Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_DELEGATED == (-1)))) *)
  (*   else if (v_ptr.(pbase) =s "slot_rd") then *)
  (*     Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RD == (-1)))) *)
  (*   else if (v_ptr.(pbase) =s "slot_rec") then *)
  (*     Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC == (-1)))) *)
  (*   else if (v_ptr.(pbase) =s "slot_rec2") then *)
  (*     Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC2 == (-1)))) *)
  (*   else if (v_ptr.(pbase) =s "slot_rec_target") then *)
  (*     Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC_TARGET == (-1)))) *)
  (*   else if (v_ptr.(pbase) =s "slot_rec_aux0") then *)
  (*     Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC_AUX0 == (-1)))) *)
  (*   else if (v_ptr.(pbase) =s "slot_rtt") then *)
  (*     Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RTT == (-1)))) *)
  (*   else if (v_ptr.(pbase) =s "slot_rtt2") then *)
  (*     Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RTT2 == (-1)))) *)
  (*   else if (v_ptr.(pbase) =s "slot_rsi_call") then *)
  (*     Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RSI_CALL == (-1)))) *)
  (*   else None. *)

  Definition xlat_map_memory_page_with_attrs_spec (v_table: Ptr) (v_va: Z) (v_pa: Z) (v_attrs: Z) (st: RData) : option (Z * RData) :=
    let v_ptr := int_to_ptr v_va in
    let gidx := v_pa / GRANULE_SIZE in
    if (v_ptr.(pbase) =s "slot_ns") then
      Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_NS == gidx)))
    else if (v_ptr.(pbase) =s "slot_delegated") then
      Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_DELEGATED == gidx)))
    else if (v_ptr.(pbase) =s "slot_rd") then
      Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RD == gidx)))
    else if (v_ptr.(pbase) =s "slot_rec") then
      Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC == gidx)))
    else if (v_ptr.(pbase) =s "slot_rec2") then
      Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC2 == gidx)))
    else if (v_ptr.(pbase) =s "slot_rec_target") then
      Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC_TARGET == gidx)))
    else if (v_ptr.(pbase) =s "slot_rec_aux0") then
      Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC_AUX0 == gidx)))
    else if (v_ptr.(pbase) =s "slot_rtt") then
      Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RTT == gidx)))
    else if (v_ptr.(pbase) =s "slot_rtt2") then
      Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RTT2 == gidx)))
    else if (v_ptr.(pbase) =s "slot_rsi_call") then
      Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RSI_CALL == gidx)))
    else None.

  Parameter fxlt_ret_succ: Ptr.
  Definition find_xlat_last_table_spec (va: Z) (ctx: Ptr) (out_level: Ptr) (tt_base_va: Ptr) (st: RData) : option (Ptr * RData) := Some (fxlt_ret_succ, st).
  Definition xlat_arch_setup_mmu_cfg_spec (ctx: Ptr) (st: RData) : option (Z * RData) := Some (0, st).
  Definition xlat_ctx_init_spec (ctx: Ptr) (cfg: Ptr) (tbls_ctx: Ptr) (tables_ptr: Ptr) (ntables: Z) (st: RData) : option (Z * RData) := Some (0, st).
  Definition xlat_get_llt_from_va_spec (llt: Ptr) (ctx: Ptr) (va: Z) (st: RData) :option (Z * RData) := Some (0, st).
  Parameter xgtp_ret_succ: Ptr.
  Definition xlat_get_tte_ptr_spec (v_llt: Ptr) (v_va: Z) (st: RData) : option (Ptr * RData) := Some (xgtp_ret_succ, st).
  Parameter xrt_ret_succ: Z.
  Definition xlat_read_tte_spec (v_entry1: Ptr) (st: RData) : option (Z * RData) := Some (xrt_ret_succ, st).
  (* iasm related *)
  Definition iasm_4_spec (st: RData) : option RData := Some st.
  (* Called by tlbiipas2e1is *)
  Definition iasm_154_spec (v_v: Z) (st: RData) : option RData := Some st.
  (* Called by tlbivae2is *)
  Definition iasm_155_spec (v_v: Z) (st: RData) : option RData := Some st.
  Definition read_tpidr_el2_spec (st: RData) : option (Z * RData) := Some (CPU_ID, st).
  (* Empty function... *)
  Definition iasm_10_spec (st: RData) : option RData := Some st.
  Definition tlbivae2is_spec (v_shr: Z) (st: RData) : option RData := Some st.
  Definition tlbiipas2e1is_spec (v_shr: Z) (st: RData) : option RData := Some st.
  Definition tlbivmalle1is_spec (st: RData) : option RData := Some st.
  Definition read_vttbr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_vttbr_el2), st).
  Definition write_vttbr_el2_spec (vttbr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_vttbr_el2] :< vttbr).

  Definition read_zcr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_zcr_el2), st).
  Definition write_zcr_el2_spec (zcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_zcr_el2] :< zcr).

  Definition read_elr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_elr_el2), st).
  Definition write_elr_el2_spec (elr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_elr_el2] :< elr).

  Definition read_cptr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_cptr_el2), st).
  Definition write_cptr_el2_spec (cptr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_cptr_el2] :< cptr).

  Definition isb_spec (st: RData) : option RData := Some st.

  Definition read_cnthctl_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_cnthctl_el2), st).
  Definition write_cnthctl_el2_spec (v: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_cnthctl_el2] :< v).

  Definition read_pmcr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmcr_el0), st).
  Definition write_pmcr_el0_spec (pmcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmcr_el0] :< pmcr).

  Definition read_mdcr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_mdcr_el2), st).
  Definition write_mdcr_el2_spec (v: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_mdcr_el2] :< v).

  Definition write_vpidr_el2_spec (v: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_vpidr_el2] :< v).

  Definition read_sctlr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_sctlr_el2), st).

  Definition read_midr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_midr_el1), st).

  Definition read_esr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_esr_el12), st).
  Definition write_esr_el12_spec (esr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_esr_el12] :< esr).

  Definition read_esr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_esr_el2), st).

  Definition read_spsr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_spsr_el2), st).
  Definition write_spsr_el2_spec (spsr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_spsr_el2] :< spsr).

  Definition read_spsr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_spsr_el12), st).
  Definition write_spsr_el12_spec (spsr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_spsr_el12] :< spsr).

  Definition read_elr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_elr_el12), st).
  Definition write_elr_el12_spec (elr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_elr_el12] :< elr).

  Definition read_vbar_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_vbar_el12), st).
  Definition write_vbar_el12_spec (vbar: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_vbar_el12] :< vbar).

  Definition read_hpfar_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_hpfar_el2), st).

  Definition read_far_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_far_el12), st).
  Definition write_far_el12_spec (far: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_far_el12] :< far).

  Definition read_far_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_far_el2), st).

  Definition read_isr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_isr_el1), st).

  Definition write_vsesr_el2_spec (vsesr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_vsesr_el2] :< vsesr).

  Definition write_hcr_el2_spec (hcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_hcr_el2] :< hcr).

  Definition read_id_aa64mmfr1_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_id_aa64mmfr1_el1), st).
  Definition read_id_aa64mmfr0_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_id_aa64mmfr0_el1), st).
  Definition read_id_aa64dfr0_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_id_aa64dfr0_el1), st).
  Definition read_id_aa64dfr1_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_id_aa64dfr1_el1), st).
  Definition read_id_aa64pfr0_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_id_aa64pfr0_el1), st).
  Definition read_id_aa64pfr1_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_id_aa64pfr1_el1), st).


  Parameter monitor_call_state_oracle : Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (RData -> (option (Z * RData))))))))).
  Definition monitor_call_spec (id: Z) (arg0: Z) (arg1: Z) (arg2: Z) (arg3: Z) (arg4: Z) (arg5: Z) (st: RData) : option (Z * RData) :=
    if id =? SMC_RMM_GTSI_DELEGATE then
      let gidx := arg0 / GRANULE_SIZE in
      rely ((st.(share).(granules) @ gidx).(e_lock) = Some CPU_ID);
      let st := st.[share].[gpt] :< (st.(share).(gpt) # gidx == true) in
      Some (0, st)
    else if id =? SMC_RMM_GTSI_UNDELEGATE then
      let gidx := arg0 / GRANULE_SIZE in
      rely ((st.(share).(granules) @ gidx).(e_lock) = Some CPU_ID);
      let st := st.[share].[gpt] :< (st.(share).(gpt) # gidx == false) in
      Some (0, st)
    else
      None.

  Definition monitor_call_with_res_spec (id: Z) (arg0: Z) (arg1: Z) (arg2: Z) (arg3: Z) (arg4: Z) (arg5: Z) (res: Ptr) (st: RData) : option RData :=
    when ret, st == (monitor_call_state_oracle id arg0 arg1 arg2 arg3 arg4 arg5 st);
    store_RData 8 res ret st.

  Definition run_realm_spec (regs: Ptr) (st: RData) : option (Z * RData) := Some (0, st).

  Definition read_pmevtyper0_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper0_el0), st).
  Definition read_pmevtyper1_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper1_el0), st).
  Definition read_pmevtyper2_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper2_el0), st).
  Definition read_pmevtyper3_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper3_el0), st).
  Definition read_pmevtyper4_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper4_el0), st).
  Definition read_pmevtyper5_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper5_el0), st).
  Definition read_pmevtyper6_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper6_el0), st).
  Definition read_pmevtyper7_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper7_el0), st).
  Definition read_pmevtyper8_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper8_el0), st).
  Definition read_pmevtyper9_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper9_el0), st).
  Definition read_pmevtyper10_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper10_el0), st).
  Definition read_pmevtyper11_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper11_el0), st).
  Definition read_pmevtyper12_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper12_el0), st).
  Definition read_pmevtyper13_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper13_el0), st).
  Definition read_pmevtyper14_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper14_el0), st).
  Definition read_pmevtyper15_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper15_el0), st).
  Definition read_pmevtyper16_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper16_el0), st).
  Definition read_pmevtyper17_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper17_el0), st).
  Definition read_pmevtyper18_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper18_el0), st).
  Definition read_pmevtyper19_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper19_el0), st).
  Definition read_pmevtyper20_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper20_el0), st).
  Definition read_pmevtyper21_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper21_el0), st).
  Definition read_pmevtyper22_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper22_el0), st).
  Definition read_pmevtyper23_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper23_el0), st).
  Definition read_pmevtyper24_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper24_el0), st).
  Definition read_pmevtyper25_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper25_el0), st).
  Definition read_pmevtyper26_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper26_el0), st).
  Definition read_pmevtyper27_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper27_el0), st).
  Definition read_pmevtyper28_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper28_el0), st).
  Definition read_pmevtyper29_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper29_el0), st).
  Definition read_pmevtyper30_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevtyper30_el0), st).

  Definition read_pmevcntr0_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr0_el0), st).
  Definition read_pmevcntr1_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr1_el0), st).
  Definition read_pmevcntr2_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr2_el0), st).
  Definition read_pmevcntr3_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr3_el0), st).
  Definition read_pmevcntr4_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr4_el0), st).
  Definition read_pmevcntr5_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr5_el0), st).
  Definition read_pmevcntr6_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr6_el0), st).
  Definition read_pmevcntr7_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr7_el0), st).
  Definition read_pmevcntr8_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr8_el0), st).
  Definition read_pmevcntr9_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr9_el0), st).
  Definition read_pmevcntr10_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr10_el0), st).
  Definition read_pmevcntr11_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr11_el0), st).
  Definition read_pmevcntr12_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr12_el0), st).
  Definition read_pmevcntr13_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr13_el0), st).
  Definition read_pmevcntr14_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr14_el0), st).
  Definition read_pmevcntr15_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr15_el0), st).
  Definition read_pmevcntr16_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr16_el0), st).
  Definition read_pmevcntr17_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr17_el0), st).
  Definition read_pmevcntr18_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr18_el0), st).
  Definition read_pmevcntr19_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr19_el0), st).
  Definition read_pmevcntr20_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr20_el0), st).
  Definition read_pmevcntr21_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr21_el0), st).
  Definition read_pmevcntr22_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr22_el0), st).
  Definition read_pmevcntr23_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr23_el0), st).
  Definition read_pmevcntr24_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr24_el0), st).
  Definition read_pmevcntr25_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr25_el0), st).
  Definition read_pmevcntr26_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr26_el0), st).
  Definition read_pmevcntr27_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr27_el0), st).
  Definition read_pmevcntr28_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr28_el0), st).
  Definition read_pmevcntr29_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr29_el0), st).
  Definition read_pmevcntr30_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmevcntr30_el0), st).

  Definition read_pmccfiltr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmccfiltr_el0), st).
  Definition write_pmccfiltr_el0_spec (pmccfiltr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmccfiltr_el0] :< pmccfiltr).

  Definition read_pmccntr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmccntr_el0), st).
  Definition write_pmccntr_el0_spec (pmccntr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmccntr_el0] :< pmccntr).

  Definition read_pmcntenset_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmcntenset_el0), st).
  Definition write_pmcntenset_el0_spec (pmcntenset: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmcntenset_el0] :< pmcntenset).

  Definition read_pmcntenclr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmcntenclr_el0), st).
  Definition write_pmcntenclr_el0_spec (pmcntenclr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmcntenclr_el0] :< pmcntenclr).

  Definition read_amair_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_amair_el12), st).
  Definition write_amair_el12_spec (amair: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_amair_el12] :< amair).

  Definition read_cntkctl_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_cntkctl_el12), st).
  Definition write_cntkctl_el12_spec (cntkctl: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_cntkctl_el12] :< cntkctl).

  Definition read_cntp_ctl_el02_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_cntp_ctl_el02), st).
  Definition write_cntp_ctl_el02_spec (cntp_ctl: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_cntp_ctl_el02] :< cntp_ctl).

  Definition read_cntp_cval_el02_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_cntp_cval_el02), st).
  Definition write_cntp_cval_el02_spec (cntp_cval: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_cntp_cval_el02] :< cntp_cval).

  Definition read_cntpoff_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_cntpoff_el2), st).
  Definition write_cntpoff_el2_spec (cntpoff: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_cntpoff_el2] :< cntpoff).

  Definition read_cntv_ctl_el02_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_cntv_ctl_el02), st).
  Definition write_cntv_ctl_el02_spec (cntv_ctl: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_cntv_ctl_el02] :< cntv_ctl).

  Definition read_cntv_cval_el02_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_cntv_cval_el02), st).
  Definition write_cntv_cval_el02_spec (cntv_cval: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_cntv_cval_el02] :< cntv_cval).

  Definition read_cntvoff_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_cntvoff_el2), st).
  Definition write_cntvoff_el2_spec (cntvoff: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_cntvoff_el2] :< cntvoff).

  Definition read_contextidr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_contextidr_el12), st).
  Definition write_contextidr_el12_spec (contextidr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_contextidr_el12] :< contextidr).

  Definition read_disr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_disr_el1), st).
  Definition write_disr_el1_spec (disr: Z) (st: RData) : option RData := None.

  Definition read_ich_hcr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_ich_hcr_el2), st).
  Definition write_ich_hcr_el2_spec (ich_hcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_ich_hcr_el2] :< ich_hcr).

  Definition read_ich_lr15_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_ich_lr15_el2), st).
  Definition read_ich_misr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_ich_misr_el2), st).
  Definition read_ich_vmcr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_ich_vmcr_el2), st).

  Definition read_mair_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_mair_el12), st).
  Definition write_mair_el12_spec (mair: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_mair_el12] :< mair).

  Definition read_mdccint_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_mdccint_el1), st).
  Definition write_mdccint_el1_spec (mdccint: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_mdccint_el1] :< mdccint).

  Definition read_mdscr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_mdscr_el1), st).
  Definition write_mdscr_el1_spec (mdscr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_mdscr_el1] :< mdscr).

  Definition read_par_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_par_el1), st).
  Definition write_par_el1_spec (par: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_par_el1] :< par).

  Definition read_pmintenclr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmintenclr_el1), st).
  Definition write_pmintenclr_el1_spec (pmintenclr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmintenclr_el1] :< pmintenclr).

  Definition read_pmintenset_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmintenset_el1), st).
  Definition write_pmintenset_el1_spec (pmintenset: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmintenset_el1] :< pmintenset).

  Definition read_pmovsclr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmovsclr_el0), st).
  Definition write_pmovsclr_el0_spec (pmovsclr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmovsclr_el0] :< pmovsclr).

  Definition read_pmovsset_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmovsset_el0), st).
  Definition write_pmovsset_el0_spec (pmovsset: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmovsset_el0] :< pmovsset).

  Definition read_pmselr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmselr_el0), st).
  Definition write_pmselr_el0_spec (pmselr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmselr_el0] :< pmselr).

  Definition write_vmpidr_el2_spec (vmpidr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_vmpidr_el2] :< vmpidr).

  Definition read_pmuserenr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmuserenr_el0), st).
  Definition write_pmuserenr_el0_spec (pmuserenr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmuserenr_el0] :< pmuserenr).

  Definition read_pmxevcntr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmxevcntr_el0), st).
  Definition write_pmxevcntr_el0_spec (pmxevcntr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmxevcntr_el0] :< pmxevcntr).

  Definition read_pmxevtyper_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_pmxevtyper_el0), st).
  Definition write_pmxevtyper_el0_spec (pmxevtyper: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmxevtyper_el0] :< pmxevtyper).

  Definition read_tpidr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_tpidr_el1), st).
  Definition write_tpidr_el1_spec (tpidr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_tpidr_el1] :< tpidr).

  Definition read_afsr1_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_afsr1_el12), st).
  Definition write_afsr1_el12_spec (afsr1: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_afsr1_el12] :< afsr1).

  Definition read_afsr0_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_afsr0_el12), st).
  Definition write_afsr0_el12_spec (afsr0: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_afsr0_el12] :< afsr0).

  Definition read_tcr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_tcr_el12), st).
  Definition write_tcr_el12_spec (tcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_tcr_el12] :< tcr).

  Definition read_ttbr1_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_ttbr1_el12), st).
  Definition write_ttbr1_el12_spec (ttbr1: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_ttbr1_el12] :< ttbr1).

  Definition read_ttbr0_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_ttbr0_el12), st).
  Definition write_ttbr0_el12_spec (ttbr0: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_ttbr0_el12] :< ttbr0).

  Definition read_cpacr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_cpacr_el12), st).
  Definition write_cpacr_el12_spec (cpacr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_cpacr_el12] :< cpacr).

  Definition read_sctlr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_sctlr_el12), st).
  Definition write_sctlr_el12_spec (sctlr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_sctlr_el12] :< sctlr).

  Definition read_csselr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_csselr_el1), st).
  Definition write_csselr_el1_spec (csselr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_csselr_el1] :< csselr).

  Definition read_actlr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_actlr_el1), st).
  Definition write_actlr_el1_spec (actlr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_actlr_el1] :< actlr).

  Definition read_sp_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_sp_el1), st).
  Definition write_sp_el1_spec (sp: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_sp_el1] :< sp).

  Definition read_tpidr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_tpidr_el0), st).
  Definition write_tpidr_el0_spec (tpidr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_tpidr_el0] :< tpidr).

  Definition read_tpidrro_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_tpidrro_el0), st).
  Definition write_tpidrro_el0_spec (tpidrro: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_tpidrro_el0] :< tpidrro).

  Definition read_sp_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_sp_el0), st).
  Definition write_sp_el0_spec (sp: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_sp_el0] :< sp).

  Definition write_pmevcntr0_el0_spec (pmevcntr0: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr0_el0] :< pmevcntr0).
  Definition write_pmevcntr1_el0_spec (pmevcntr1: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr1_el0] :< pmevcntr1).
  Definition write_pmevcntr2_el0_spec (pmevcntr2: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr2_el0] :< pmevcntr2).
  Definition write_pmevcntr3_el0_spec (pmevcntr3: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr3_el0] :< pmevcntr3).
  Definition write_pmevcntr4_el0_spec (pmevcntr4: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr4_el0] :< pmevcntr4).
  Definition write_pmevcntr5_el0_spec (pmevcntr5: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr5_el0] :< pmevcntr5).
  Definition write_pmevcntr6_el0_spec (pmevcntr6: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr6_el0] :< pmevcntr6).
  Definition write_pmevcntr7_el0_spec (pmevcntr7: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr7_el0] :< pmevcntr7).
  Definition write_pmevcntr8_el0_spec (pmevcntr8: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr8_el0] :< pmevcntr8).
  Definition write_pmevcntr9_el0_spec (pmevcntr9: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr9_el0] :< pmevcntr9).
  Definition write_pmevcntr10_el0_spec (pmevcntr10: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr10_el0] :< pmevcntr10).
  Definition write_pmevcntr11_el0_spec (pmevcntr11: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr11_el0] :< pmevcntr11).
  Definition write_pmevcntr12_el0_spec (pmevcntr12: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr12_el0] :< pmevcntr12).
  Definition write_pmevcntr13_el0_spec (pmevcntr13: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr13_el0] :< pmevcntr13).
  Definition write_pmevcntr14_el0_spec (pmevcntr14: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr14_el0] :< pmevcntr14).
  Definition write_pmevcntr15_el0_spec (pmevcntr15: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr15_el0] :< pmevcntr15).
  Definition write_pmevcntr16_el0_spec (pmevcntr16: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr16_el0] :< pmevcntr16).
  Definition write_pmevcntr17_el0_spec (pmevcntr17: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr17_el0] :< pmevcntr17).
  Definition write_pmevcntr18_el0_spec (pmevcntr18: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr18_el0] :< pmevcntr18).
  Definition write_pmevcntr19_el0_spec (pmevcntr19: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr19_el0] :< pmevcntr19).
  Definition write_pmevcntr20_el0_spec (pmevcntr20: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr20_el0] :< pmevcntr20).
  Definition write_pmevcntr21_el0_spec (pmevcntr21: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr21_el0] :< pmevcntr21).
  Definition write_pmevcntr22_el0_spec (pmevcntr22: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr22_el0] :< pmevcntr22).
  Definition write_pmevcntr23_el0_spec (pmevcntr23: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr23_el0] :< pmevcntr23).
  Definition write_pmevcntr24_el0_spec (pmevcntr24: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr24_el0] :< pmevcntr24).
  Definition write_pmevcntr25_el0_spec (pmevcntr25: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr25_el0] :< pmevcntr25).
  Definition write_pmevcntr26_el0_spec (pmevcntr26: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr26_el0] :< pmevcntr26).
  Definition write_pmevcntr27_el0_spec (pmevcntr27: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr27_el0] :< pmevcntr27).
  Definition write_pmevcntr28_el0_spec (pmevcntr28: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr28_el0] :< pmevcntr28).
  Definition write_pmevcntr29_el0_spec (pmevcntr29: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr29_el0] :< pmevcntr29).
  Definition write_pmevcntr30_el0_spec (pmevcntr30: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevcntr30_el0] :< pmevcntr30).

  Definition write_pmevtyper0_el0_spec (pmevtyper0: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper0_el0] :< pmevtyper0).
  Definition write_pmevtyper1_el0_spec (pmevtyper1: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper1_el0] :< pmevtyper1).
  Definition write_pmevtyper2_el0_spec (pmevtyper2: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper2_el0] :< pmevtyper2).
  Definition write_pmevtyper3_el0_spec (pmevtyper3: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper3_el0] :< pmevtyper3).
  Definition write_pmevtyper4_el0_spec (pmevtyper4: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper4_el0] :< pmevtyper4).
  Definition write_pmevtyper5_el0_spec (pmevtyper5: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper5_el0] :< pmevtyper5).
  Definition write_pmevtyper6_el0_spec (pmevtyper6: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper6_el0] :< pmevtyper6).
  Definition write_pmevtyper7_el0_spec (pmevtyper7: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper7_el0] :< pmevtyper7).
  Definition write_pmevtyper8_el0_spec (pmevtyper8: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper8_el0] :< pmevtyper8).
  Definition write_pmevtyper9_el0_spec (pmevtyper9: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper9_el0] :< pmevtyper9).
  Definition write_pmevtyper10_el0_spec (pmevtyper10: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper10_el0] :< pmevtyper10).
  Definition write_pmevtyper11_el0_spec (pmevtyper11: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper11_el0] :< pmevtyper11).
  Definition write_pmevtyper12_el0_spec (pmevtyper12: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper12_el0] :< pmevtyper12).
  Definition write_pmevtyper13_el0_spec (pmevtyper13: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper13_el0] :< pmevtyper13).
  Definition write_pmevtyper14_el0_spec (pmevtyper14: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper14_el0] :< pmevtyper14).
  Definition write_pmevtyper15_el0_spec (pmevtyper15: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper15_el0] :< pmevtyper15).
  Definition write_pmevtyper16_el0_spec (pmevtyper16: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper16_el0] :< pmevtyper16).
  Definition write_pmevtyper17_el0_spec (pmevtyper17: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper17_el0] :< pmevtyper17).
  Definition write_pmevtyper18_el0_spec (pmevtyper18: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper18_el0] :< pmevtyper18).
  Definition write_pmevtyper19_el0_spec (pmevtyper19: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper19_el0] :< pmevtyper19).
  Definition write_pmevtyper20_el0_spec (pmevtyper20: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper20_el0] :< pmevtyper20).
  Definition write_pmevtyper21_el0_spec (pmevtyper21: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper21_el0] :< pmevtyper21).
  Definition write_pmevtyper22_el0_spec (pmevtyper22: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper22_el0] :< pmevtyper22).
  Definition write_pmevtyper23_el0_spec (pmevtyper23: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper23_el0] :< pmevtyper23).
  Definition write_pmevtyper24_el0_spec (pmevtyper24: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper24_el0] :< pmevtyper24).
  Definition write_pmevtyper25_el0_spec (pmevtyper25: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper25_el0] :< pmevtyper25).
  Definition write_pmevtyper26_el0_spec (pmevtyper26: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper26_el0] :< pmevtyper26).
  Definition write_pmevtyper27_el0_spec (pmevtyper27: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper27_el0] :< pmevtyper27).
  Definition write_pmevtyper28_el0_spec (pmevtyper28: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper28_el0] :< pmevtyper28).
  Definition write_pmevtyper29_el0_spec (pmevtyper29: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper29_el0] :< pmevtyper29).
  Definition write_pmevtyper30_el0_spec (pmevtyper30: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_pmevtyper30_el0] :< pmevtyper30).

  Definition read_icc_sre_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_icc_sre_el2), st).
  Definition write_icc_sre_el2_spec (v: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_icc_sre_el2] :< v).

  Definition read_icc_hppir1_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_regs).(pcpu_icc_hppir1_el1), st).

  Definition write_ich_vmcr_el2_spec (ich_vmcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_ich_vmcr_el2] :< ich_vmcr).

  Definition write_vtcr_el2_spec (vtcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_regs].[pcpu_vtcr_el2] :< vtcr).
  (* atomic *)
  (* TODO: relaxed memory *)
  Definition atomic_load_add_release_64_spec (loc: Ptr) (val: Z) (st: RData) : option (Z * RData) :=
    when v, st == load_RData 64 loc st;
    when st == store_RData 64 loc (v + val) st;
    Some (v + val, st).

  Definition atomic_add_64_spec (loc: Ptr) (val: Z) (st: RData) : option RData :=
    when v, st == load_RData 64 loc st;
    when st == store_RData 64 loc (v + val) st;
    Some st.

  Definition __sca_read64_acquire_spec (ptr: Ptr) (st: RData) : option (Z * RData) := load_RData 64 ptr st.

  Definition __sca_read64_spec (ptr: Ptr) (st: RData) : option (Z * RData) := load_RData 64 ptr st.

  Definition __sca_write64_spec (ptr: Ptr) (val: Z) (st: RData) : option RData := store_RData 64 ptr val st.

  Definition __sca_write64_release_spec (v_state1: Ptr) (v_state: Z) (st: RData) : option RData := store_RData 64 v_state1 v_state st.

  Definition atomic_bit_set_acquire_release_64_spec (loc: Ptr) (bit: Z) (st: RData) : option (bool * RData) :=
    when v, st == load_RData 64 loc st;
    when st == store_RData 64 loc  (Z.setbit v bit) st;
    Some (Z.testbit v bit, st).

  Definition atomic_bit_clear_release_64_spec (loc: Ptr) (bit: Z) (st: RData) : option RData :=
    when v, st == load_RData 64 loc st;
    when st == store_RData 64 loc  (Z.clearbit v bit) st;
    Some st.

  (* Measurement *)
  Definition measurement_get_size_spec (v_algo: Z) (st: RData) : option (Z * RData) :=
    if v_algo =? HASH_ALGO_SHA256 then
      Some (SHA256_SIZE, st)
    else if v_algo =? HASH_ALGO_SHA512 then
      Some (SHA512_SIZE, st)
    else
      None.

  Definition measurement_hash_compute_spec (v_hash_algo: Z) (v_data: Ptr) (v_size: Z) (v_out: Ptr) (st: RData) : option RData := Some st.
  Definition measurement_extend_spec (v_hash_algo: Z) (v_current_measurement: Ptr) (v_extend_measurement: Ptr) (v_extend_measurement_size: Z) (v_out: Ptr) (st: RData) : option RData := Some st.
  (* FPU *)
  Definition fpu_save_state_spec (v_0: Ptr) (st: RData) : option RData := Some st.
  Definition fpu_restore_state_spec (v_0: Ptr) (st: RData) : option RData := Some st.
  Definition sve_save_p_ffr_state_spec (v_0: Ptr) (st: RData) : option RData := Some st.
  Definition sve_save_zcr_fpu_state_spec (v_0: Ptr) (st: RData) : option RData := Some st.
  Definition sve_save_z_state_spec (v_0: Ptr) (st: RData) : option RData := Some st.
  Definition sve_restore_ffr_p_state_spec (v_0: Ptr) (st: RData) : option RData := Some st.
  Definition sve_restore_zcr_fpu_state_spec (v_0: Ptr) (st: RData) : option RData := Some st.
  Definition sve_restore_z_state_spec (v_0: Ptr) (st: RData) : option RData := Some st.
  (* tcose *)
  Definition t_cose_sign1_encode_signature_spec (v_me: Ptr) (v_cbor_encode_ctx: Ptr) (st: RData) : option (Z * RData) := Some (0, st).
  Definition QCBOREncode_Finish_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : option (Z * RData) := Some (0, st).
  (* QCBORE *)
  Definition QCBOREncode_AddBytesToMapN_spec (v_buf: Ptr) (st: RData) : option (Z * RData) := Some (0, st).
  Definition QCBOREncode_CloseMap_spec (v_pMe: Ptr) (st: RData) : option RData := Some st.
  Definition QCBOREncode_AddTag_spec (v_0: Ptr) (v_1: Z) (st: RData) : option RData := Some st.
  Definition QCBOREncode_Init_spec (v_0: Ptr) (v_1: list Z) (st: RData) : option RData := Some st.
  (* attestation *)
  Definition attest_get_platform_token_spec (v_buf: Ptr) (st: RData) : option (Z * RData) := Some (0, st).
  Definition attest_cca_token_create_spec (v_me: Ptr) (v_completed_token: Ptr) (st: RData) : option (Z * RData) := Some (0, st).
  Definition attest_realm_token_sign_spec (v_me: Ptr) (v_completed_token: Ptr) (st: RData) : option (Z * RData) := Some (0, st).
  Definition save_input_parameters_spec (v_rec: Ptr) (st: RData) : option RData := Some st.
  Definition attest_realm_token_create_spec  (v_algo: Z) (v_measurement: Ptr) (v_num_measurement: Z) (v_prv: Ptr) (v_ctx: Ptr) (v_realm_token_buf: Ptr) (st: RData) : option (Z * RData) := Some (0, st).
  Definition attestation_heap_reinit_pe_spec (v_buf: Ptr) (v_buf_size: Z) (st: RData) : option (Z * RData) := Some (0, st).
  Definition attestation_heap_ctx_assign_pe_spec (v_ctx: Ptr) (st: RData) : option (Z * RData) := Some (0, st).
  Definition attestation_heap_ctx_init_spec (v_buf: Ptr) (v_buf_size: Z) (st: RData) : option (Z * RData) := Some (0, st).
  Definition attestation_heap_ctx_unassign_pe_spec (st: RData) : option (Z * RData) := Some (0, st).
  Definition attest_token_continue_write_state_spec (v_rec: Ptr) (v_res: Ptr) (st: RData) : (option RData) := Some st.
  Definition attest_token_continue_sign_state_spec (v_rec: Ptr) (v_res: Ptr) (st: RData) : (option RData) := Some st.
  Definition get_rpv_spec (v_rd: Ptr) (v_claim: Ptr) (st: RData) : (option RData) := Some st.
  Parameter verify_input_parameters_consistency_spec_oracle : Ptr-> (RData -> (bool)).
  Definition verify_input_parameters_consistency_spec (v_rec: Ptr) (st: RData) : (option (bool * RData)) :=
    Some (verify_input_parameters_consistency_spec_oracle v_rec st, st).
  (* Parameter handle_rsi_attest_token_init_spec_oralce: RData -> (option (Z * RData)). *)
  (* Definition handle_rsi_attest_token_init_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) := handle_rsi_attest_token_init_spec_oralce st. *)
  Parameter handle_rsi_read_measurement_spec_oralce: RData -> (option (Z * RData)).
  Definition handle_rsi_read_measurement_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) := handle_rsi_read_measurement_spec_oralce st.
  Parameter handle_rsi_extend_measurement_spec_oralce: RData -> (option (Z * RData)).
  Definition handle_rsi_extend_measurement_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) := handle_rsi_extend_measurement_spec_oralce st.
  Parameter handle_rsi_attest_token_continue_spec_oralce: RData -> (option RData).
  Definition handle_rsi_attest_token_continue_spec (v_rec: Ptr) (v_res: Ptr) (st: RData) : (option RData) := handle_rsi_attest_token_continue_spec_oralce st.
  (* GIC, too large *)
  (* Parameter read_lrs_spec : (Ptr -> (RData -> option RData)). *)
  Definition read_lrs_spec (v_gicstate: Ptr) (st: RData) : option RData := Some st.
  Definition read_aprs_spec (v_gicstate: Ptr) (st: RData) : option RData := Some st.
  Definition write_aprs_spec (v_gicstate: Ptr) (st: RData) : option RData := Some st.
  Definition write_lrs_spec (v_gicstate: Ptr) (st: RData) : option RData := Some st.
  (* Log and abort *)
  Definition rmi_log_on_exit_spec (v_handler_id: Z) (v_args: Ptr) (v_ret: Ptr) (st: RData) : option RData := Some st.
  Definition report_unexpected_spec (st: RData) : option RData := None.
  Definition fatal_abort_spec (st: RData) : option RData := None.
  (* tmp *)
  Definition simd_init_spec (st: RData) : option RData := Some st.
  (* Definition find_lock_rd_granules_spec (v_rd_addr: Z) (v_g_rd: Ptr) (v_4: Z) (v_5: Z) (v_g_rtt_base: Ptr) (st: RData) : option (bool * RData) := Some (true, st). *)
  (* Definition __table_maps_block_spec (v_table: Ptr) (v_level: Z) (v_s2tte_is_x: Ptr) (st: RData) : option (bool * RData) := Some (true, st). *)
  (* Definition __table_is_uniform_block_spec (v_table: Ptr) (v_level: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : option (bool * RData) := Some (true, st). *)
  (* Definition handle_realm_rsi_spec (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : option (bool * RData) := None. *)
  Definition complete_rsi_host_call_spec (v_rec: Ptr) (v_rec_entry: Ptr) (st: RData) : option ((list Z) * RData) := Some ((1 :: 0 :: nil), st).
  (* Definition handle_realm_exit_spec (v_rec: Ptr) (v_rec_exit: Ptr) (v_exception: Z) (st: RData) : option (bool * RData) := None. *)
  Definition complete_host_call_spec (v_rec: Ptr) (v_rec_run: Ptr) (st: RData) : option (bool * RData) := Some (true, st).
  Definition handle_realm_trap_spec (v_regs: Ptr) (st: RData) : option (Z * RData) := Some (0, st).

  (* Callsite of Measurement functions, tmp put into TCB *)
  Definition ripas_granule_measure_spec (v_rd: Ptr) (v_ipa: Z) (v_level: Z) (st: RData) : (option RData) := Some st.
  Definition data_granule_measure_spec (v_rd: Ptr) (v_data: Ptr) (v_ipa: Z) (v_flags: Z) (st: RData) : (option RData) := Some st.
  Definition rec_params_measure_spec (v_rd: Ptr) (v_rec_params: Ptr) (st: RData) : (option RData) := Some st.
  Definition realm_params_measure_spec (v_rd: Ptr) (v_realm_params: Ptr) (st: RData) : (option RData) := Some st.
  (* Abstract memory *)
  (* Takes an PA of a granule and returns the index in the struct granules array. *)
  Definition plat_granule_addr_to_idx_spec (pa: Z) (st: RData) : (option (Z * RData)) := Some (pa / GRANULE_SIZE, st).
  (* Takes an index in the struct granules array and returns the aligned granule PA. *)
  Definition plat_granule_idx_to_addr_spec (idx: Z) (st: RData) : (option (Z * RData)) := Some (idx * GRANULE_SIZE, st).
  Definition stage2_tlbi_ipa_spec (v_s2_ctx: Ptr) (v_ipa: Z) (v_size: Z) (st: RData) : (option RData) := Some st.

  Definition rec_run_loop_spec (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : (option RData) := Some st.

End Bottom.

Section MakeReturnCode.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "make_return_code" ::
      "pack_struct_return_code" ::
      nil.
End MakeReturnCode.

Section Helpers.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "my_cpuid" ::
      (* "status_ptr" :: *)
      "__granule_refcount_dec" ::
      "__granule_put" ::
      "__granule_get" ::
      "pack_return_code" ::
      "realm_rtt_starting_level" ::
      "realm_ipa_bits" ::
      "s2_addr_to_idx" ::
      "s2_sl_addr_to_idx" ::
      "entry_is_table" ::
      "__tte_read" ::
      "__tte_write" ::
      "__granule_refcount_inc" ::
      "mpidr_is_valid" ::
      (* "ptr_status" :: *)
      (* "ptr_is_err" :: *)
      "s2_inconsistent_sl" ::
      "s2_num_root_rtts" ::
      "requested_ipa_bits" ::
      "addr_is_contained" ::
      "psci_reset_rec" ::
      "advance_pc" ::
      "calc_vector_entry" ::
      "rec_is_simd_allowed" ::
      "rec_simd_type" ::
      "esr_is_write" ::
      "rec_ipa_size" ::
      "esr_sas" ::
      "esr_srt" ::
      "fsc_is_external_abort" ::
      "calc_esr_idabort" ::
      "get_sysreg_write_value" ::
      "save_input_parameters" ::
      "is_valid_vintid" ::
      "esr_sign_extend" ::
      "esr_sixty_four" ::
      "is_el2_data_abort_gpf" ::
      "sve_config_vq" ::
      nil.
  (* "granule_refcount_read_relaxed" :: *)
  (* "system_abort" :: *)
  (* "is_ns_slot" :: *)
  (* "is_realm_slot" :: *)
  (* "get_rpv" :: *)

  Hint Unfold __tte_read_spec'.

  Hint InitRely status_ptr (v_status >= 0 /\ GRANULES_BASE > 0).
  Hint InitRely __granule_refcount_dec (v_g.(pbase) = "granules" /\ ((v_g.(poffset) + 8) mod ST_GRANULE_SIZE = 8)).
  Hint InitRely __granule_refcount_inc (v_g.(pbase) = "granules" /\ ((v_g.(poffset) + 8) mod ST_GRANULE_SIZE = 8)).
  Hint InitRely __granule_get (v_g.(pbase) = "granules" /\ ((v_g.(poffset) + 8) mod ST_GRANULE_SIZE = 8)).
  Hint InitRely __granule_put (v_g.(pbase) = "granules"  /\ ((v_g.(poffset) + 8) mod ST_GRANULE_SIZE = 8)).
  (* Hint InitRely realm_rtt_starting_level (v_rd.(pbase) = "slot_rd" /\ v_rd.(poffset) = 20). *)
  (* Hint InitRely realm_ipa_bits (v_rd.(pbase) = "slot_rd" /\ v_rd.(poffset) = 16). *)
  Hint InitRely realm_rtt_starting_level (v_rd.(pbase) = "slot_rd" /\ v_rd.(poffset) = 0).
  Hint InitRely realm_ipa_bits (v_rd.(pbase) = "slot_rd" /\ v_rd.(poffset) = 0).
  Hint InitRely __tte_read (v_ttep.(pbase) = "slot_rtt" \/ v_ttep.(pbase) = "slot_rtt2").
  Hint InitRely __tte_write (v_ttep.(pbase) = "slot_rtt" \/ v_ttep.(pbase) = "slot_rtt2").
  Hint InitRely ptr_status (v_ptr.(pbase) = "status" \/ v_ptr.(pbase) = "null").
  Hint InitRely requested_ipa_bits (v_p.(pbase) = "stack_realm_params").
  (* Hint InitRely psci_reset_rec (v_rec.(pbase) = "slot_rec" /\ (v_rec.(poffset) = 280 \/ v_rec.(poffset) = 352)). *)
  (* Hint InitRely rec_is_simd_allowed (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 1120). *)
  (* Hint InitRely rec_simd_type (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 920). *)
  (* Hint InitRely rec_ipa_size (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 880). *)
  (* Hint InitRely get_sysreg_write_value (v_rec.(pbase) = "slot_rec" /\ (v_rec.(poffset) >= 24 /\ v_rec.(poffset) < 272)). *)
  (* Hint NoUnfold rec_field_accessible. *)
  (* Hint NoUnfold rd_field_accessible. *)
  Hint InitRely psci_reset_rec (v_rec.(pbase) = "slot_rec2" /\ v_rec.(poffset) = 0).
  Hint InitRely rec_is_simd_allowed (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).
  Hint InitRely rec_simd_type (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).
  Hint InitRely rec_ipa_size (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).
  Hint InitRely get_sysreg_write_value (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).

  Hint InitRely rec_is_simd_allowed (rec_is_unlocked st).
  Hint InitRely rec_is_simd_allowed (rec_refcount_one st).

  Hint InitRely rec_simd_type (rec_is_unlocked st).
  Hint InitRely rec_simd_type (rec_refcount_one st).
  (* Generated specs copied here to save time *)
  Hint Unfold status_ptr_spec'.
  Hint Unfold ptr_is_err_spec'.

End Helpers.

Section InjectAbort.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "realm_inject_undef_abort" ::
      "inject_sync_idabort" ::
      "inject_serror" ::
      "inject_sync_idabort_rec" ::
      nil.
  Hint InitRely inject_serror (v_rec.(pbase) = "slot_rec").
  Hint InitRely inject_serror (v_rec.(poffset) = 0).
  Hint InitRely inject_sync_idabort_rec (v_rec.(pbase) = "slot_rec").
  Hint InitRely inject_sync_idabort_rec (v_rec.(poffset) = 0).
  (* Hint InitRely inject_sync_idabort_rec (rec_is_unlocked st). *)
  (* Hint InitRely inject_sync_idabort_rec (rec_refcount_one st). *)
End InjectAbort.

Section CheckFeature.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
    "is_feat_vmid16_present" ::
      "arch_feat_get_pa_width" ::
      "is_feat_lpa2_4k_present" ::
      (* "read_pmu_version" :: *)
      "is_feat_sve_present" ::
      "access_len" ::
      nil.

End CheckFeature.

Section SIMDState.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
      "simd_save_state" ::
      "simd_restore_state" ::
      "simd_disable" ::
      "simd_enable" ::
      nil.

  Hint InitRely simd_save_state ((v_simd.(pbase) = "slot_rec_aux0") /\ (REC_HEAP_SIZE + REC_PMU_SIZE = v_simd.(poffset))).
  Hint InitRely simd_restore_state ((v_simd.(pbase) = "slot_rec_aux0") /\ (REC_HEAP_SIZE + REC_PMU_SIZE = v_simd.(poffset))).
End SIMDState.

Section SIMD.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
    "simd_sve_get_max_vq" ::
      "simd_save_ns_state" ::
      "rec_simd_enable_restore" ::
      "simd_state_init" ::
      nil.
  Hint InitRely rec_simd_enable_restore (v_rec.(pbase) = "slot_rec").
  Hint InitRely simd_state_init (v_simd.(pbase) = "slot_rec_aux0" /\ (REC_HEAP_SIZE + REC_PMU_SIZE = v_simd.(poffset))).
End SIMD.

Section RDState.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
    "get_rd_state_locked" ::
      "get_rd_state_unlocked" ::
      "set_rd_state" ::
      "get_rd_rec_count_locked" ::
      "get_rd_rec_count_unlocked" ::
      "set_rd_rec_count" ::
      nil.

  Hint InitRely get_rd_state_locked (v_rd.(pbase) = "slot_rd" /\ v_rd.(poffset) = 0).
  Hint InitRely get_rd_state_unlocked (v_rd.(pbase) = "slot_rd" /\ v_rd.(poffset) = 0).
  Hint InitRely set_rd_state (v_rd.(pbase) = "slot_rd" /\ v_rd.(poffset) = 0).
  Hint InitRely get_rd_rec_count_locked (v_rd.(pbase) = "slot_rd" /\ v_rd.(poffset) = 0).
  Hint InitRely get_rd_rec_count_unlocked (v_rd.(pbase) = "slot_rd" /\ v_rd.(poffset) = 0).
  Hint InitRely set_rd_rec_count (v_rd.(pbase) = "slot_rd" /\ v_rd.(poffset) = 0).


End RDState.

Section GranuleState.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PRIMS: list string :=
    (* XXX: think about the acquire/release semantics *)
    "atomic_granule_put_release" ::
      "atomic_granule_put" ::
      "atomic_granule_get" ::
      "granule_get_state" ::
      "granule_refcount_read_acquire" ::
      "granule_set_state" ::
      "granule_from_idx" ::
      (* XXX: Move this to Bottom *)
      (* "plat_granule_addr_to_cidx" :: *)
      (* "__granule_assert_unlocked_invariants" :: *)
      nil.

  Hint InitRely atomic_granule_put_release (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely atomic_granule_put (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely atomic_granule_get (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely granule_get_state (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely granule_refcount_read_acquire (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely granule_set_state (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).


End GranuleState.

Section FindGranule.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "granule_lock_on_state_match" ::
      "find_granule" ::
      "sort_granules" ::
      "addr_to_granule" ::
      nil.

  Hint InitRely granule_lock_on_state_match (v_g.(pbase) = "granules").
  Hint InitRely granule_lock_on_state_match ((v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely granule_lock_on_state_match (((((st.(share).(granules)) @ (v_g.(poffset) / (ST_GRANULE_SIZE))).(e_state)) - v_expected_state) = 0).
  Hint InitRely sort_granules (v_granules.(pbase) = "stack_gs").

  Definition sort_granules_spec (v_granules: Ptr) (v_n: Z) (st: RData) : (option RData) := Some st.
    (* let addr0 := st.(stack).(stack_gs0).(e_addr) in *)
    (* let addr1 := st.(stack).(stack_gs1).(e_addr) in *)
    (* if (addr0 <? addr1) then Some st *)
    (* else ( *)
    (*   let gs0 := st.(stack).(stack_gs0) in *)
    (*   let gs1 := st.(stack).(stack_gs1) in *)
    (*   Some ((st.[stack].[stack_gs0] :< gs1).[stack].[stack_gs1] :< gs0)). *)


  Hint Unfold find_granule_spec'.
End FindGranule.

Section GranuleLock.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "granule_lock" ::
      "granule_unlock" ::
      "find_lock_granule" ::
      nil.

  (* Hint InitRely granule_lock ((st.(share).(granules) @ (v_g.(poffset) / ST_GRANULE_SIZE)).(e_state) = v_expected_state). *)
End GranuleLock.

Section GranuleInfo.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "get_cached_llt_info" ::
      "slot_to_va" ::
      "granule_unlock_transition" ::
      "find_lock_granules" ::
      "find_lock_rd_granules" ::
      nil.
  Definition find_lock_granules_loop197_rank (v_granules: Ptr) (v_i_241: Z) : Z :=
    2 - v_i_241.
  Definition find_lock_granules_loop0_rank (v_granules: Ptr) (v_i_143: Z) : Z :=
    2 - v_i_143.
  Hint InitRely find_lock_granules_loop0 (v_granules.(pbase) = "stack_gs").
  Hint InitRely find_lock_granules_loop0 (v_granules.(poffset) = 0).
  Hint InitRely find_lock_granules_loop197 (v_granules.(pbase) = "stack_gs").
  Hint InitRely find_lock_granules_loop197 (v_granules.(poffset) = 0).

  Hint InitRely find_lock_granules (v_granules.(pbase) = "stack_gs").
  Hint InitRely find_lock_granules (v_granules.(poffset) = 0).

  Hint NoTrans find_lock_granules_loop197.
  Hint NoTrans find_lock_granules_loop0.
  Hint NoTrans find_lock_granules_spec.
  
  Loop_inv find_lock_granules_loop197 
  (
  (v_i_241 >= 0) /\
  (1 - v_i_241 >= 0) /\
  (v_i_241 = 0 -> st = st_old) /\
  ((v_i_241 = 1 /\ __break__ = false) -> st = (st_old).[stack].[stack_g0] :< (st_old).(stack).(stack_gs0).(e_gset_g)) /\ 
  ((v_i_241 = 1 /\ __break__ = true) -> st = (((st_old).[stack].[stack_g0] :< (st_old).(stack).(stack_gs0).(e_gset_g)).[stack].[stack_g1] :< (st_old).(stack).(stack_gs1).(e_gset_g)))
  ).

  Fixpoint find_lock_granules_loop197 (_N_: nat) (__break__: bool) (v_granules: Ptr) (v_i_241: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_granules, v_i_241, st))
  | (S _N__0) =>
    match ((find_lock_granules_loop197 _N__0 __break__ v_granules v_i_241 st)) with
    | (Some (__break___0, v_granules_0, v_i_242, st_0)) =>
      if __break___0
      then (Some (true, v_granules_0, v_i_242, st_0))
      else (
        rely (((v_granules_0.(poffset)) = (0)));
        rely (((v_granules_0.(pbase)) = ("stack_gs")));
        if ((((v_granules_0.(poffset)) + (((40 * (v_i_242)) + (24)))) / (40)) =? (0))
        then (
          rely (
            ((((((st_0.(stack)).(stack_gs0)).(e_gset_g)) > (0)) /\ ((((((st_0.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_0.(stack)).(stack_gs0)).(e_gset_g)) - (18446744073705226240)) < (0)))));
          rely ((((((st_0.(stack)).(stack_gs0)).(e_gset_g_ret)) > (0)) /\ ((((- 48) + ((((((st_0.(stack)).(stack_gs0)).(e_gset_g_ret)) - (STACK_VIRT)) / (GRANULE_SIZE)))) = (0)))));
          (Some (false, v_granules_0, (v_i_242 + (1)), (st_0.[stack].[stack_g0] :< (((st_0.(stack)).(stack_gs0)).(e_gset_g))))))
        else (
          rely (
            ((((((st_0.(stack)).(stack_gs1)).(e_gset_g)) > (0)) /\ ((((((st_0.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_0.(stack)).(stack_gs1)).(e_gset_g)) - (18446744073705226240)) < (0)))));
          rely ((((((st_0.(stack)).(stack_gs1)).(e_gset_g_ret)) > (0)) /\ ((((- 49) + ((((((st_0.(stack)).(stack_gs1)).(e_gset_g_ret)) - (STACK_VIRT)) / (GRANULE_SIZE)))) = (0)))));
          if ((v_i_242 + (1)) <>? (2))
          then (Some (false, v_granules_0, (v_i_242 + (1)), (st_0.[stack].[stack_g1] :< (((st_0.(stack)).(stack_gs1)).(e_gset_g)))))
          else (Some (true, v_granules_0, v_i_242, (st_0.[stack].[stack_g1] :< (((st_0.(stack)).(stack_gs1)).(e_gset_g)))))))
    | None => None
    end
  end.

  (* Hint InitRely find_lock_rd_granules (v_p_g_rd.(pbase) = "stack_g0"). *)
  (* Hint InitRely find_lock_rd_granules (v_p_g_rtt_base.(pbase) = "stack_g1"). *)
  Definition find_lock_rd_granules_spec_low (v_rd_addr: Z) (v_p_g_rd: Ptr) (v_rtt_base_addr: Z) (v_num_rtts: Z) (v_p_g_rtt_base: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (v_p_g_rd.(pbase) = "stack_g0");
    rely (v_p_g_rtt_base.(pbase) = "stack_g1");
    when v_g_rd, st_0 == find_lock_granule_spec v_rd_addr GRANULE_STATE_DELEGATED st;
    if (v_g_rd.(pbase) =s "null") then
      Some (false, st)
    else (
      when v_g_rtt_base, st_1 == find_lock_granule_spec v_rtt_base_addr GRANULE_STATE_DELEGATED st_0;
      if (v_g_rtt_base.(pbase) =s "null") then (
          when st_2 == granule_unlock_spec v_g_rd st_1;
          Some (false, st_2)
      ) else (
          when st_2 == store_RData 8 v_p_g_rd (ptr_to_int v_g_rd) st_1;
          when st_3 == store_RData 8 v_p_g_rtt_base (ptr_to_int v_g_rtt_base) st_2;
          Some (true, st_3)
      )).

End GranuleInfo.

Section LockGranules.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_PRIMS: list string :=
    "find_lock_unused_granule" ::
      "find_lock_two_granules" ::
      nil.
  Hint NoTrans find_lock_two_granules_spec.

  Hint NoUnfold find_lock_two_granules_spec.
  Hint InitRely find_lock_two_granules (v_g1.(pbase) = "stack_g0").
  Hint InitRely find_lock_two_granules (v_g1.(poffset) = 0).
  Hint InitRely find_lock_two_granules (v_g2.(pbase) = "stack_g1").
  Hint InitRely find_lock_two_granules (v_g2.(poffset) = 0).

End LockGranules.

Section MmapInternal.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "granule_addr" ::
      "buffer_unmap_internal" ::
      "buffer_map_internal" ::
      nil.

  (* Hint InitRely buffer_unmap_internal (((v_buf).(pbase) = "slot_rd") \/ *)
  (*                                        ((v_buf).(pbase) = "slot_ns") \/ *)
  (*                                        ((v_buf).(pbase) = "slot_delegated") \/ *)
  (*                                        ((v_buf).(pbase) = "slot_rec") \/ *)
  (*                                        ((v_buf).(pbase) = "slot_rec2") \/ *)
  (*                                        ((v_buf).(pbase) = "slot_rec_target") \/ *)
  (*                                        ((v_buf).(pbase) = "slot_rec_aux0") \/ *)
  (*                                        ((v_buf).(pbase) = "slot_rtt") \/ *)
  (*                                        ((v_buf).(pbase) = "slot_rtt2") \/ *)
  (*                                        ((v_buf).(pbase) = "slot_rsi_call") \/ *)
  (*                                        ((v_buf).(pbase) = "slot_ns")). *)
  (* Hint InitRely buffer_unmap_internal (v_buf.(poffset) = 0). *)

  Hint InitRely buffer_map_internal (v_slot >= 0).
  Hint InitRely buffer_map_internal (v_slot <= 24).
  Hint InitRely granule_addr (v_g.(pbase) = "granules").
  Hint InitRely granule_addr ((v_g.(poffset) mod ST_GRANULE_SIZE) = 0).

End MmapInternal.

Section Mmap.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "ns_granule_map" ::
      "ns_buffer_unmap" ::
      "buffer_unmap" ::
      "granule_map" ::
      nil.

  Hint InitRely ns_granule_map (v_slot = SLOT_NS).
  Hint InitRely ns_buffer_unmap (v_buf.(pbase) = "slot_ns").

End Mmap.

Section MemRW.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "ns_buffer_read" ::
      "ns_buffer_write" ::
      "granule_memzero" ::
      "granule_memzero_mapped" ::
      nil.
  Hint InitRely ns_buffer_read (v_slot = SLOT_NS).
  Hint InitRely ns_buffer_read (v_ns_gr.(pbase) = "granules").
  Hint InitRely ns_buffer_read ((v_ns_gr.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely ns_buffer_read (v_offset = 0).
  Hint InitRely ns_buffer_write (v_slot = SLOT_NS).
  Hint InitRely ns_buffer_write (v_ns_gr.(pbase) = "granules").
  Hint InitRely ns_buffer_write ((v_ns_gr.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely ns_buffer_write (v_offset = 0).

  Hint InitRely granule_memzero_mapped (v_buf.(pbase) = "slot_rtt2" \/ v_buf.(pbase) = "slot_rec").
End MemRW.

Section InvalidatePages.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "invalidate_page" ::
      "invalidate_pages_in_block" ::
      "invalidate_block"  ::
      nil.


End InvalidatePages.

Section S2TTEDesc.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "addr_level_mask" ::
      "s2tte_check" ::
      "s2tte_has_hipas" ::
      "__table_get_entry" ::
      nil.
  Hint InitRely __table_get_entry (v_g_tbl.(pbase) = "granules").
  Hint InitRely __table_get_entry ((v_g_tbl.(poffset) mod ST_GRANULE_SIZE) = 0).

End S2TTEDesc.

Section S2TTEState.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "s2tte_is_assigned" ::
      "s2tte_is_unassigned" ::
      "s2tte_is_valid" ::
      "s2tte_is_valid_ns" ::
      "s2tte_is_table" ::
      "s2tte_is_destroyed" ::
      "host_ns_s2tte" ::
      "host_ns_s2tte_is_valid" ::
      (* "table_entry_to_phys" :: *)
      "addr_is_level_aligned" ::
      nil.
End S2TTEState.

Section S2TTEPA.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "s2tte_pa_table" ::
      "s2tte_pa" ::
      "s2tte_map_size" ::
      "s2tte_create_assigned_empty" ::
      "s2tte_create_ripas" ::
      (* "slot_to_descriptor" :: *)
      (* "__table_get_entry" :: *)
      nil.

  Hint Unfold s2tte_create_ripas_spec'.
End S2TTEPA.

Section S2TTEOps.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "update_ripas" ::
      "s2tte_create_unassigned" ::
      "realm_ipa_size" ::
      "__find_next_level_idx" ::
      "s2_walk_result_match_ripas" ::
      "rec_par_size" ::
      nil.

  Hint InitRely update_ripas (v_s2tte.(pbase) = "stack_s2tte").
  Hint InitRely s2_walk_result_match_ripas (v_res.(pbase) = "stack_walk_res").
  Hint InitRely s2_walk_result_match_ripas (v_res.(poffset) = 0).
  Hint NoUnfold update_ripas_spec.

End S2TTEOps.

Section RealmInfo.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "realm_par_size" ::
      "realm_vtcr" ::
      "max_ipa_size" ::
      "addr_in_rec_par" ::
      nil.
End RealmInfo.

Section RecInfo.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "mpidr_to_rec_idx" ::
      "access_mask" ::
      "region_is_contained" ::
      "rd_map_read_rec_count" ::
      nil.

  Include "./RecInfoSpec.v".
End RecInfo.

Section InitRegs.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "init_rec_sysregs" ::
      "init_common_sysregs" ::
      nil.

  Hint NoUnfold rec_field_accessible.
  (* Hint NoUnfold rd_field_accessible. *)
  Hint InitRely init_rec_sysregs (v_rec.(pbase) = "slot_rec").
  Hint InitRely init_rec_sysregs (v_rec.(poffset) = 0).
  Hint InitRely init_rec_sysregs (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = Some CPU_ID).
  (* Hint InitRely init_rec_sysregs ((int_to_ptr (st.(share).(granule_data) @ (st.(share).(slots) @ SLOT_REC)).(g_rec).(e_realm_info).(e_g_rd)) = (mkPtr "NULL" 0)). *)

  Hint InitRely init_common_sysregs (v_rec.(pbase) = "slot_rec").
  Hint InitRely init_common_sysregs (v_rec.(poffset) = 0).
  Hint InitRely init_common_sysregs (v_rd.(pbase) = "slot_rd").
  Hint InitRely init_common_sysregs (v_rd.(poffset) = 0).


 Definition init_rec_sysregs_spec (v_rec: Ptr) (v_mpidr: Z) (st: RData) : (option RData) :=
    rely (((v_rec.(pbase)) = ("slot_rec")));
    rely (((v_rec.(poffset)) = (0)));
    let ofs := (v_rec.(poffset)) in
    let g_idx := (((st.(share)).(slots)) @ SLOT_REC) in
    let g_data := (((st.(share)).(granule_data)) @ g_idx) in
    let g := (((st.(share)).(granules)) @ g_idx) in
    when cid == ((g.(e_lock)));
    let new_gdata := (g_data.[g_rec].[e_sysregs] :< sysregs_init) in
    (Some (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == new_gdata))).

Definition init_common_sysregs_spec (v_rec: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
    rely (((v_rec.(pbase)) = ("slot_rec")));
    rely (((v_rec.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    rely (((v_rd.(poffset)) = (0)));
    let ofs := (v_rec.(poffset)) in
    let g_idx := (((st.(share)).(slots)) @ SLOT_REC) in
    let g_data := (((st.(share)).(granule_data)) @ g_idx) in
    let g := (((st.(share)).(granules)) @ g_idx) in
    when cid == ((g.(e_lock)));
    let new_gdata := (g_data.[g_rec].[e_common_sysregs] :< common_sysregs_init) in
    (Some (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == new_gdata))).

End InitRegs.

Section InitRec.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "gic_cpu_state_init" ::
      "init_rec_regs" ::
      "free_rec_aux_granules" ::
      nil.

  Definition free_rec_aux_granules_loop176_rank (v_indvars_iv: Z) (v_rec_aux: Ptr) (v_scrub: bool) (v_wide_trip_count: Z) : Z :=
    0.

  Definition free_rec_aux_granules_spec (v_rec_aux: Ptr) (v_cnt: Z) (v_scrub: bool) (st: RData) : (option RData) :=
    (Some st).

  Definition gic_cpu_state_init_spec (v_gicstate: Ptr) (st: RData) : (option RData) :=
    rely (((v_gicstate.(poffset)) = (584)));
    rely (((v_gicstate.(pbase)) = ("slot_rec")));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)));
    (Some (lens 193 st)).

  Definition init_rec_regs_spec (v_rec: Ptr) (v_rec_params: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
    rely (((v_rec.(pbase)) = ("slot_rec")));
    rely (((v_rec.(poffset)) = (0)));
    rely (((v_rec_params.(pbase)) = ("stack_realm_params")));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)));
    let g_rec := ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)) in
    rely (((v_rd.(pbase)) = ("slot_rd")));
    rely (((v_rd.(poffset)) = (0)));
    (Some (lens 219 st)).

  Fixpoint free_rec_aux_granules_loop176 (_N_: nat) (__break__: bool) (v_indvars_iv: Z) (v_rec_aux: Ptr) (v_scrub: bool) (v_wide_trip_count: Z) (st: RData) : (option (bool * Z * Ptr * bool * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_indvars_iv, v_rec_aux, v_scrub, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((free_rec_aux_granules_loop176 _N__0 __break__ v_indvars_iv v_rec_aux v_scrub v_wide_trip_count st)) with
      | (Some (__break___0, v_indvars_iv_0, v_rec_aux_0, v_scrub_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_indvars_iv_0, v_rec_aux_0, v_scrub_0, v_wide_trip_count_0, st_0))
        else (
          when v_0_tmp, st_1 == ((load_RData 8 (ptr_offset v_rec_aux_0 ((8 * (v_indvars_iv_0)) + (0))) st_0));
          when st_2 == ((granule_lock_spec (int_to_ptr v_0_tmp) 4 st_1));
          if v_scrub_0
          then (
            when st_3 == ((granule_memzero_spec (int_to_ptr v_0_tmp) (v_indvars_iv_0 + (6)) st_2));
            when st_5 == ((granule_unlock_transition_spec (int_to_ptr v_0_tmp) 1 st_3));
            if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
            then (Some (false, (v_indvars_iv_0 + (1)), v_rec_aux_0, true, v_wide_trip_count_0, st_5))
            else (Some (true, v_indvars_iv_0, v_rec_aux_0, true, v_wide_trip_count_0, st_5)))
          else (
            when st_4 == ((granule_unlock_transition_spec (int_to_ptr v_0_tmp) 1 st_2));
            if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
            then (Some (false, (v_indvars_iv_0 + (1)), v_rec_aux_0, false, v_wide_trip_count_0, st_4))
            else (Some (true, v_indvars_iv_0, v_rec_aux_0, false, v_wide_trip_count_0, st_4))))
      | None => None
      end
    end.

End InitRec.

Section ValidateAddr.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "validate_map_addr" ::
      "addr_in_par" ::
      nil.
  Hint InitRely validate_map_addr (v_rd.(pbase) = "slot_rd").
  Hint InitRely validate_map_addr (v_rd.(poffset) = 0).
  Hint InitRely validate_map_addr (rd_is_locked st).
  Hint InitRely addr_in_par (v_rd.(pbase) = "slot_rd").
  Hint InitRely addr_in_par (v_rd.(poffset) = 0).
  Hint InitRely addr_in_par (rd_is_locked st).


  Definition validate_map_addr_spec (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    rely ((rd_is_locked st));
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    when v_call, st_0 == ((realm_ipa_size_spec v_rd st));
    if ((v_call - (v_map_addr)) >? (0))
    then (
      when v_call1, st_1 == ((addr_is_level_aligned_spec v_map_addr v_level st_0));
      if v_call1
      then (Some (true, st_1))
      else (Some (false, st_1)))
    else (Some (false, st_0)).

  Definition addr_in_par_spec (v_rd: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
    rely ((rd_is_locked st));
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    when v_call, st_0 == ((realm_par_size_spec v_rd st));
    (Some (((v_call - (v_addr)) >? (0)), st_0)).
End ValidateAddr.

Section ValidateTable.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "validate_data_create_unknown" ::
      "validate_rtt_entry_cmds" ::
      "validate_rtt_map_cmds" ::
      "validate_rtt_structure_cmds" ::
      "s2tte_create_valid_ns" ::
      nil.
  Hint InitRely validate_data_create_unknown (v_rd.(pbase) = "slot_rd").
  Hint InitRely validate_data_create_unknown (v_rd.(poffset) = 0).

  Hint InitRely validate_rtt_entry_cmds (v_rd.(pbase) = "slot_rd").
  Hint InitRely validate_rtt_entry_cmds (v_rd.(poffset) = 0).

  Hint InitRely validate_rtt_map_cmds (v_rd.(pbase) = "slot_rd").
  Hint InitRely validate_rtt_map_cmds (v_rd.(poffset) = 0).

  Hint InitRely validate_rtt_structure_cmds (v_rd.(pbase) = "slot_rd").
  Hint InitRely validate_rtt_structure_cmds (v_rd.(poffset) = 0).

  Hint Unfold s2tte_create_valid_ns_spec'.
End ValidateTable.

Section TableAux.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "__find_lock_next_level" ::
      "validate_data_create" ::
      nil.
End TableAux.

Section TableWalk.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_PRIMS: list string :=
    "rtt_walk_lock_unlock" ::
      nil.
  Hint InitRely rtt_walk_lock_unlock (v_g_root.(pbase) = "granules").
  Hint InitRely rtt_walk_lock_unlock (v_wi.(pbase) = "stack_wi").
  Hint InitRely rtt_walk_lock_unlock (v_wi.(poffset) = 0).
  Hint InitRely rtt_walk_lock_unlock (v_start_level >= 0).
  Hint InitRely rtt_walk_lock_unlock (v_start_level < 4).
  (* Need fill in: *)
  Definition rtt_walk_lock_unlock_loop370_rank (v_g_tbls: Ptr) (v_indvars_iv: Z) (v_level: Z) (v_map_addr: Z) (v_wi: Ptr) : Z :=
    v_level.

  Hint NoTrans rtt_walk_lock_unlock_loop370.
  Hint NoTrans rtt_walk_lock_unlock_spec.

  Hint NoUnfold rtt_walk_lock_unlock_spec.

  Hint InitRely rtt_walk_lock_unlock_loop370 (v_g_tbls.(pbase) = "stack_g_tbls").
  Hint InitRely rtt_walk_lock_unlock_loop370 (v_g_tbls.(poffset) = 0).
  Hint InitRely rtt_walk_lock_unlock_loop370 (v_wi.(pbase) = "stack_wi").
  Hint InitRely rtt_walk_lock_unlock_loop370 (v_wi.(poffset) = 0).

End TableWalk.

Section S2TTCreate.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_PRIMS : list string :=
    "map_unmap_ns" ::
      "s2tte_create_table" ::
      "s2tte_get_ripas" ::
      "s2tte_create_valid" ::
      nil.

  (* Hint NoTrans map_unmap_ns_spec. *)
  (* Include "S2TTCreateSpec.v". *)
  Include "S2TTCreateLow.v".
  (* Include "ProofRTT/.CachedSpec/S2TTCreateSpec.v". *)
End S2TTCreate.

Section TableBlock.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_PRIMS : list string :=
    "__table_maps_block" ::
      "__table_is_uniform_block" ::
      nil.

  Hint AddDep __table_maps_block s2tte_is_assigned.
  Hint AddDep __table_maps_block s2tte_is_valid.
  Hint AddDep __table_maps_block s2tte_is_valid_ns.

  Hint AddDep __table_is_uniform_block s2tte_is_unassigned.
  Hint AddDep __table_is_uniform_block s2tte_is_destroyed.
  (* Need fill in: *)
  Definition __table_maps_block_funptr_wrap849 (func_ptr: Ptr) (arg0: Z) (arg1: Z) (st: RData) : (option (bool * RData)) :=
    if func_ptr.(pbase) =s "s2tte_is_assigned" then s2tte_is_assigned_spec arg0 arg1 st
    else if func_ptr.(pbase) =s "s2tte_is_valid" then s2tte_is_valid_spec arg0 arg1 st
    else if func_ptr.(pbase) =s "s2tte_is_valid_ns" then s2tte_is_valid_ns_spec arg0 arg1 st else None.

  (* Need fill in: *)
  Definition __table_maps_block_loop840_rank (v_call: Z) (v_call3: Z) (v_i_015: Z) (v_level: Z) (v_table: Ptr) (v_s2tte_is_x: Ptr): Z :=
    512 - v_i_015.
  (* Need fill in: *)
  Definition __table_maps_block_funptr_wrap835 (func_ptr: Ptr) (arg0: Z) (arg1: Z) (st: RData) : (option (bool * RData)) :=
    if func_ptr.(pbase) =s "s2tte_is_assigned" then s2tte_is_assigned_spec arg0 arg1 st
    else if func_ptr.(pbase) =s "s2tte_is_valid" then s2tte_is_valid_spec arg0 arg1 st
    else if func_ptr.(pbase) =s "s2tte_is_valid_ns" then s2tte_is_valid_ns_spec arg0 arg1 st else None.

  Hint InitRely __table_maps_block ((v_s2tte_is_x.(pbase) = "s2tte_is_assigned") \/
                                      (v_s2tte_is_x.(pbase) = "s2tte_is_valid") \/
                                      (v_s2tte_is_x.(pbase) = "s2tte_is_valid_ns")).
  Hint InitRely __table_maps_block (v_s2tte_is_x.(poffset) = 0).

  Hint InitRely __table_maps_block (v_table.(pbase) = "slot_rtt2").
  Hint InitRely __table_maps_block_loop840 ((v_s2tte_is_x.(pbase) = "s2tte_is_assigned") \/
                                      (v_s2tte_is_x.(pbase) = "s2tte_is_valid") \/
                                      (v_s2tte_is_x.(pbase) = "s2tte_is_valid_ns")).
  Hint InitRely __table_maps_block_loop840 (v_table.(pbase) = "slot_rtt22").
  Hint InitRely __table_maps_block_loop840 (v_s2tte_is_x.(poffset) = 0).

  (* Need fill in: *)
  Definition __table_is_uniform_block_funptr_wrap788 (func_ptr: Ptr) (arg0: Z) (st: RData) : (option (bool * RData)) :=
    if func_ptr.(pbase) =s "s2tte_is_unassigned" then s2tte_is_unassigned_spec arg0 st
    else if func_ptr.(pbase) =s "s2tte_is_destroyed" then s2tte_is_destroyed_spec arg0 st
    else None.
  (* Need fill in: *)
  Definition __table_is_uniform_block_loop777_rank (v_cmp_not: bool) (v_indvars_iv: Z) (v_ripas_0: Z) (v_ripas_ptr: Ptr) (v_table: Ptr) (v_s2tte_is_x: Ptr) : Z :=
    512 - v_indvars_iv.
  (* Need fill in: *)
  Definition __table_is_uniform_block_funptr_wrap777 (func_ptr: Ptr) (arg0: Z) (st: RData) : (option (bool * RData)) :=
    if func_ptr.(pbase) =s "s2tte_is_unassigned" then s2tte_is_unassigned_spec arg0 st
    else if func_ptr.(pbase) =s "s2tte_is_destroyed" then s2tte_is_destroyed_spec arg0 st
         else None.
  Hint InitRely __table_is_uniform_block ((v_s2tte_is_x.(pbase) = "s2tte_is_unassigned") \/
                                            (v_s2tte_is_x.(pbase) = "s2tte_is_destroyed")).
  Hint InitRely __table_is_uniform_block (v_table.(pbase) = "slot_rtt2").
  Hint InitRely __table_is_uniform_block (v_s2tte_is_x.(poffset) = 0).

  Hint InitRely __table_is_uniform_block_loop777 ((v_s2tte_is_x.(pbase) = "s2tte_is_unassigned") \/
                                              (v_s2tte_is_x.(pbase) = "s2tte_is_destroyed")).
  Hint InitRely __table_is_uniform_block_loop777 (v_table.(pbase) = "slot_rtt2").
  Hint InitRely __table_is_uniform_block_loop777 (v_s2tte_is_x.(poffset) = 0).
  Hint InitRely __table_is_uniform_block_loop777 (v_ripas_ptr.(pbase) = "smc_rtt_fold_stack").

  Hint NoTrans __table_maps_block_spec.
  Hint NoTrans __table_maps_block_loop840.

  Hint NoTrans __table_is_uniform_block_spec.
  Hint NoTrans __table_is_uniform_block_loop777.

  Hint NoUnfold __table_maps_block_spec.
  Hint NoUnfold __table_is_uniform_block_spec.

  (* Include "ProofRTT/.CachedSpec/TableBlockSpec.v". *)
End TableBlock.

Section RTTFold.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_PRIMS : list string :=
    "table_is_destroyed_block" ::
      "table_is_unassigned_block" ::
      "table_maps_assigned_block" ::
      "table_maps_valid_block" ::
      "table_maps_valid_ns_block" ::
      nil.

  (* Include "ProofRTT/.CachedSpec/RTTFoldSpec.v". *)
End RTTFold.

Section S2TTInit.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_PRIMS : list string :=
    "s2tt_init_valid_ns" ::
      "s2tt_init_valid" ::
      "s2tt_init_assigned_empty" ::
      "s2tt_init_destroyed" ::
      "s2tt_init_unassigned" ::
      "realm_ipa_get_ripas" ::
      "realm_ipa_to_pa" ::
      nil.

  Hint InitRely realm_ipa_get_ripas (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0 /\
                                       v_ripas_ptr.(pbase) = "stack_ripas_ptr" /\
                                       v_rtt_level.(pbase) = "stack_rtt_level").
  Hint InitRely realm_ipa_to_pa (v_rd.(pbase) = "slot_rd").
  Hint InitRely realm_ipa_to_pa (v_s2_walk.(pbase) = "stack_s2_walk").
  Hint InitRely realm_ipa_to_pa (v_s2_walk.(poffset) = 0).

  Hint NoUnfold realm_ipa_to_pa_spec.
  Hint NoUnfold realm_ipa_get_ripas_spec.
  (* Hint NoTrans realm_ipa_get_ripas_spec. *)
  Hint NoTrans realm_ipa_to_pa_spec.
 (* Need fill in: *)
  Definition s2tt_init_valid_ns_loop738_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
    512 - v_indvars_iv.
  Hint InitRely s2tt_init_valid_ns (v_s2tt.(pbase) = "slot_delegated").
  Hint InitRely s2tt_init_valid_ns_loop738 (v_s2tt.(pbase) = "slot_delegated").

  (* Need fill in: *)
  Definition s2tt_init_valid_loop719_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
    512 - v_indvars_iv.
  Hint InitRely s2tt_init_valid (v_s2tt.(pbase) = "slot_delegated").
  Hint InitRely s2tt_init_valid_loop719 (v_s2tt.(pbase) = "slot_delegated").

  (* Need fill in: *)
  Definition s2tt_init_assigned_empty_loop700_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
    512 - v_indvars_iv.
  Hint InitRely s2tt_init_assigned_empty (v_s2tt.(pbase) = "slot_delegated").
  Hint InitRely s2tt_init_assigned_empty_loop700 (v_s2tt.(pbase) = "slot_delegated").

  (* Need fill in: *)
  Definition s2tt_init_destroyed_loop0_rank (v_index: Z) (v_s2tt: Ptr) : Z :=
    256 - v_index/2.
  Hint InitRely s2tt_init_destroyed (v_s2tt.(pbase) = "slot_delegated").
  Hint InitRely s2tt_init_destroyed_loop0 (v_s2tt.(pbase) = "slot_delegated").

  (* Need fill in: *)
  Definition s2tt_init_unassigned_loop0_rank (v_call: Z) (v_index: Z) (v_s2tt: Ptr) : Z :=
    256 - v_index/2.
  Hint InitRely s2tt_init_unassigned (v_s2tt.(pbase) = "slot_delegated").
  Hint InitRely s2tt_init_unassigned_loop0 (v_s2tt.(pbase) = "slot_delegated").

  Hint NoUnfold s2tt_init_valid_ns_spec.
  Hint NoUnfold s2tt_init_valid_spec.
  Hint NoUnfold s2tt_init_assigned_empty_spec.
  Hint NoUnfold s2tt_init_destroyed_spec.
  Hint NoUnfold s2tt_init_unassigned_spec.

  Include "S2TTInitLow.v".
  (* Include "ProofRTT/.CachedSpec/S2TTInitSpec.v". *)
End S2TTInit.

Section GetFeatureReg.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
    "get_feature_register_0" ::
      nil.
End GetFeatureReg.

Section ValidateFeatureReg.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
    "validate_feature_register_0" ::
      nil.

  Hint NoTrans validate_feature_register_0_spec.
End ValidateFeatureReg.

Section RealmCreate.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
    "vmid_reserve" ::
      "vmid_free" ::
      "validate_ipa_bits_and_sl" ::
      "validate_feature_register" ::
      "free_sl_rtts" ::
      "total_root_rtt_refcount" ::
      nil.
  (* Need fill in: *)
  Definition free_sl_rtts_loop193_rank (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
    0.
  (* Need fill in: *)
  Definition total_root_rtt_refcount_loop348_rank (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_refcount_08: Z) (v_wide_trip_count: Z) : Z :=
    0.

  Hint NoTrans validate_feature_register_spec.
End RealmCreate.

Section RealmParams.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
    "get_realm_params" ::
      "validate_realm_params" ::
      nil.

  Hint InitRely validate_realm_params (v_p.(pbase) = "stack_realm_params").
  Hint InitRely validate_realm_params (v_p.(poffset) = 0).

  Definition validate_realm_params_spec (v_p: Ptr) (st: RData) : option (bool * RData) := Some (true, st).
  Definition get_realm_params_spec (v_realm_params: Ptr) (v_realm_params_addr: Z) (st: RData) : (option (bool * RData)) :=
    Some (true, st.[stack].[stack_realm_params] :< rmi_realm_params).
End RealmParams.

Section EL3IFC.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
    "rmm_el3_ifc_gtsi_delegate" ::
      "rmm_el3_ifc_gtsi_undelegate" ::
      nil.
End EL3IFC.

Section ExceptionOps.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_PRIMS : list string :=
    (* "ipa_is_empty" :: *)
    (*   "access_in_rec_par" :: *)
    (*   "fixup_aarch32_data_abort" :: *)
    (*   "get_dabt_write_value" :: *)
    (*   "handle_sync_external_abort" :: *)
    (*   "emulate_sysreg_access_ns" :: *)
    (*   "handle_rsi_ipa_state_get" :: *)
      (* "psci_rsi" :: *)
      "data_create" ::
      nil.

  Hint InitRely data_create (v_g_src.(pbase) = "granules" \/ v_g_src.(pbase) = "null").
  Hint NoUnfold data_create_0.
  Hint NoUnfold data_create_1.
  Hint NoUnfold data_create_2.
  Hint NoUnfold data_create_3.
  Hint NoUnfold data_create_4.
  Hint NoUnfold data_create_5.
  Hint NoUnfold data_create_6.
  Hint NoUnfold data_create_7.
  Hint NoUnfold data_create_8.
  (* Hint NoTrans data_create_spec. *)

  (* Hint NoTrans handle_rsi_ipa_state_get_spec_mid. *)
  (* Hint NoTrans data_create_spec_mid. *)

  Include "ExceptionOpsLow2.v".

End ExceptionOps.

Section RecEnterPrep.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
    "map_rec_aux" ::
      "unmap_rec_aux" ::
      "init_aux_data" ::
      "activate_events" ::
      "rec_simd_state_init" ::
      "simd_restore_ns_state" ::
      "save_realm_state" ::
      "restore_realm_state" ::
      "restore_ns_state" ::
      "save_ns_state" ::
      "check_pending_timers" ::
      "report_timer_state_to_ns" ::
      "rec_simd_save_disable" ::
      "handle_realm_exit" ::
      nil.
  (* Need fill in: *)
  Definition map_rec_aux_loop52_rank (v_i_06: Z) (v_num_aux: Z) (v_rec_aux_07: Ptr) (v_rec_aux_pages: Ptr) : Z :=
    0.
  (* Need fill in: *)
  Definition unmap_rec_aux_loop66_rank (v_i_04: Z) (v_num_aux: Z) (v_rec_aux: Ptr) : Z :=
    0.
  (* Need fill in: *)
  (* XXX *)
  Definition check_pending_timers_loop39_rank (v_cmp: bool) (v_cmp8: bool) (v_cnthctl_el2: Ptr) (v_rec: Ptr) : Z :=
    0.
End RecEnterPrep.

Section RecEnterHandler.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS : list string :=
    "complete_sysreg_emulation" ::
      "complete_mmio_emulation" ::
      "complete_set_ripas" ::
      "complete_sea_insertion" ::
      "gic_validate_state" ::
      "gic_copy_state_from_ns" ::
      "gic_copy_state_to_ns" ::
      "reset_last_run_info" ::
      (* "rec_run_loop" :: *)
      nil.

  Hint InitRely complete_mmio_emulation (v_rec.(pbase) = "slot_rec").
  Hint InitRely complete_mmio_emulation (v_rec.(poffset) = 0).
  Hint InitRely complete_mmio_emulation (v_rec_entry.(pbase) = "stack_rmi_rec_run").
  Hint InitRely complete_mmio_emulation (v_rec_entry.(poffset) = 0).

  (* Hint NoTrans complete_sysreg_emulation_spec. *)
  Hint InitRely complete_sysreg_emulation (v_rec.(pbase) = "slot_rec").
  Hint InitRely complete_sysreg_emulation (v_rec.(poffset) = 0).
  Hint InitRely complete_sysreg_emulation (v_rec_entry.(pbase) = "stack_rmi_rec_run").
  Hint InitRely complete_sysreg_emulation (v_rec_entry.(pbase) = "stack_rmi_rec_run").
  Hint InitRely complete_sysreg_emulation (v_rec_entry.(poffset) = 0).

  (* Hint NoTrans complete_set_ripas_spec. *)
  Hint InitRely complete_set_ripas (v_rec.(pbase) = "slot_rec").
  Hint InitRely complete_set_ripas (v_rec.(poffset) = 0).

  (* Hint NoTrans complete_sea_insertion_spec. *)
  Hint InitRely complete_sea_insertion (v_rec.(pbase) = "slot_rec").
  Hint InitRely complete_sea_insertion (v_rec.(poffset) = 0).
  Hint InitRely complete_sea_insertion (v_rec_entry.(pbase) = "stack_rmi_rec_run").
  Hint InitRely complete_sea_insertion (v_rec_entry.(poffset) = 0).

  (* Hint NoTrans gic_validate_state_spec. *)
  Hint InitRely gic_validate_state (v_gicstate.(pbase) = "slot_rec").
  Hint InitRely gic_validate_state (v_gicstate.(poffset) = 584).

  (* Hint NoTrans gic_validate_state_loop207. *)
  Hint InitRely gic_validate_state_loop207 (v_gicstate.(pbase) = "slot_rec").
  Hint InitRely gic_validate_state_loop207 (v_gicstate.(poffset) = 584).

  (* Hint NoTrans gic_validate_state_loop183. *)
  Hint InitRely gic_validate_state_loop183 (v_gicstate.(pbase) = "slot_rec").
  Hint InitRely gic_validate_state_loop183 (v_gicstate.(poffset) = 584).

  (* Hint NoTrans gic_copy_state_from_ns_spec. *)
  Hint InitRely gic_copy_state_from_ns (v_gicstate.(pbase) = "slot_rec").
  Hint InitRely gic_copy_state_from_ns (v_gicstate.(poffset) = 584).
  Hint InitRely gic_copy_state_from_ns (v_rec_entry.(pbase) = "stack_rmi_rec_run").
  Hint InitRely gic_copy_state_from_ns (v_rec_entry.(poffset) = 0).

  (* Hint NoTrans gic_copy_state_from_ns_loop136. *)
  Hint InitRely gic_copy_state_from_ns_loop136 (v_gicstate.(pbase) = "slot_rec").
  Hint InitRely gic_copy_state_from_ns_loop136 (v_gicstate.(poffset) = 584).
  Hint InitRely gic_copy_state_from_ns_loop136 (v_rec_entry.(pbase) = "stack_rmi_rec_run").
  Hint InitRely gic_copy_state_from_ns_loop136 (v_rec_entry.(poffset) = 0).

  (* Hint NoTrans gic_copy_state_to_ns_spec. *)
  Hint InitRely gic_copy_state_to_ns (v_gicstate.(pbase) = "slot_rec").
  Hint InitRely gic_copy_state_to_ns (v_gicstate.(poffset) = 584).
  Hint InitRely gic_copy_state_to_ns (v_rec_exit.(pbase) = "stack_rmi_rec_run").
  Hint InitRely gic_copy_state_to_ns (v_rec_exit.(poffset) = 2048).

  (* Hint NoTrans gic_copy_state_to_ns_loop151. *)
  Hint InitRely gic_copy_state_to_ns_loop151 (v_gicstate.(pbase) = "slot_rec").
  Hint InitRely gic_copy_state_to_ns_loop151 (v_gicstate.(poffset) = 584).
  Hint InitRely gic_copy_state_to_ns_loop151 (v_rec_exit.(pbase) = "stack_rmi_rec_run").
  Hint InitRely gic_copy_state_to_ns_loop151 (v_rec_exit.(poffset) = 2048).

  (* Hint NoTrans reset_last_run_info_spec. *)
  Hint InitRely reset_last_run_info (v_rec.(pbase) = "slot_rec").
  Hint InitRely reset_last_run_info (v_rec.(poffset) = 0).

  (* Need fill in: *)
  Definition gic_validate_state_loop207_rank (v_2: Z) (v_and: Z) (v_gicstate: Ptr) (v_j_015: Z) : Z :=
    0.
  (* Need fill in: *)
  Definition gic_validate_state_loop183_rank (v_0: Z) (v_1: Z) (v_2: Z) (v_gicstate: Ptr) (v_i_016: Z) : Z :=
    0.
  (* Need fill in: *)
  Definition gic_copy_state_from_ns_loop136_rank (v_gicstate: Ptr) (v_indvars_iv: Z) (v_rec_entry: Ptr) : Z :=
    0.
  (* Need fill in: *)
  Definition gic_copy_state_to_ns_loop151_rank (v_gicstate: Ptr) (v_indvars_iv: Z) (v_rec_exit: Ptr) : Z :=
    0.
  (* Need fill in: *)
  Definition rec_run_loop_loop352_rank (v_arrayidx33: Ptr) (v_rec: Ptr) (v_rec_exit: Ptr) : Z :=
    0.
  Definition rec_run_loop_loop378_rank (v_arrayidx33: Ptr) (v_rec: Ptr) (v_rec_exit: Ptr) : Z :=
    0.
End RecEnterHandler.

Section SMCHandler.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./rmm.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_PRIMS : list string :=
    "smc_granule_delegate" ::
      "smc_granule_undelegate" ::
    "smc_rtt_create" ::
      "smc_rtt_destroy" ::
    (*   "smc_version" :: *)
      "smc_realm_activate" ::
      "smc_rtt_map_unprotected" ::
      "smc_rtt_unmap_unprotected" ::
      "smc_data_create" ::
      "smc_data_create_unknown" ::
      "smc_rtt_set_ripas" ::
      "smc_rtt_fold" ::
      "smc_data_destroy" ::
      "smc_rtt_init_ripas" ::
      "smc_realm_create" ::
      "smc_rec_create" ::
      "smc_rec_destroy" ::
      "smc_realm_destroy" ::
      "smc_rtt_read_entry" ::
      "smc_rec_enter" ::
        nil.

  Hint NoUnfold smc_rtt_create_0.
  Hint NoUnfold smc_rtt_create_1.
  Hint NoUnfold smc_rtt_create_2.
  Hint NoUnfold smc_rtt_create_3.
  Hint NoUnfold smc_rtt_create_4.
  Hint NoUnfold smc_rtt_create_5.
  (* Hint NoUnfold smc_rtt_create_6. *)

  Hint NoUnfold smc_rtt_destroy_1.
  Hint NoUnfold smc_rtt_destroy_2.
  Hint NoUnfold smc_rtt_destroy_3.

  Hint NoUnfold smc_rtt_set_ripas_1.
  Hint NoUnfold smc_rtt_set_ripas_2.
  Hint NoUnfold smc_rtt_set_ripas_3.
  Hint NoUnfold smc_rtt_set_ripas_4.
  Hint NoUnfold smc_rtt_set_ripas_5.

  Hint NoUnfold smc_rtt_fold_1.
  Hint NoUnfold smc_rtt_fold_2.
  Hint NoUnfold smc_rtt_fold_3.
  Hint NoUnfold smc_rtt_fold_4.
  Hint NoUnfold smc_rtt_fold_5.
  Hint NoUnfold smc_rtt_fold_6.
  Hint NoUnfold smc_rtt_fold_7.
  Hint NoUnfold smc_rtt_fold_8.

  (* Hint NoTrans smc_realm_create_spec. *)
  Hint NoTrans smc_realm_create_loop335.

  Definition smc_realm_create_loop335_rank (v_37: Ptr) (v_indvars_iv: Z) (v_rtt_num_start: Ptr) : Z :=
      0.
  (* Include "SMCHandlerSpec.v". *)
  Definition smc_rec_create_loop222_rank (v_indvars_iv: Z) (v_rec_aux_granules: Ptr) (v_rec_params: Ptr) (v_wide_trip_count: Z) : Z :=
      0.

  Hint NoTrans smc_realm_create_loop335.
  (* Hint NoTrans smc_rec_create_loop222. *)
  (* Hint NoTrans smc_rec_create_spec. *)

  Hint InitRely smc_rec_create_loop222 (v_rec_aux_granules.(pbase) = "stack_rec_aux_granules").
  Hint InitRely smc_rec_create_loop222 (v_rec_aux_granules.(poffset) = 0).
  Hint InitRely smc_rec_create_loop222 (v_rec_params.(pbase) = "stack_rec_params").
  Hint InitRely smc_rec_create_loop222 (v_rec_params.(poffset) = 0).

  Hint InitRely smc_rtt_read_entry (v_ret.(pbase) = "stack_smc_result").
  Hint InitRely smc_rtt_read_entry (v_ret.(poffset) = 0).

 Definition smc_realm_activate_spec (v_rd_addr: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_rd_addr & (4095)) =? (0))
    then (
      if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
        rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) = (0)));
        (* when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share)))); *)
        match ((((st.(share).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock))) with
        | None =>
          (* rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - ((((sh.(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)))) = (0))); *)
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          if (((((st.(share).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_rd_state)) =? (0))
          then (
            (Some (
              0  ,
              ((st.[log] :<
                ((EVT CPU_ID (REL (v_rd_addr / (GRANULE_SIZE)) (((st.(share).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ (v_rd_addr / (GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                (((st.(share).[granule_data] :<
                  ((st.(share).(granule_data)) #
                    (v_rd_addr / (GRANULE_SIZE)) ==
                    (((st.(share).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).[g_rd] :< ((((st.(share).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).[e_rd_rd_state] :< 1)))).[granules] :<
                  ((st.(share).(granules)) # (v_rd_addr / (GRANULE_SIZE)) == (((st.(share).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).[e_lock] :< None))).[slots] :<
                  ((st.(share).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE)))))
            )))
          else (
            (Some (
              2  ,
              ((st.[log] :<
                ((EVT CPU_ID (REL (v_rd_addr / (GRANULE_SIZE)) (((st.(share).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ (v_rd_addr / (GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                ((st.(share).[granules] :< ((st.(share).(granules)) # (v_rd_addr / (GRANULE_SIZE)) == (((st.(share).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).[e_lock] :< None))).[slots] :<
                  ((st.(share).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE)))))
            )))
        | (Some cid) => None
        end))
    else (Some (1, st)).

  (* Hint NoTrans smc_rec_enter_spec. *)
  Include "SMCHandlerSpecLow2.v".
  (* Definition smc_rtt_create_spec_low (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_create" st));
    (* when v_g_rd, st_1 == ((alloc_stack "smc_rtt_create" 8 8 st_0)); *)
    (* when v_g_tbl, st_2 == ((alloc_stack "smc_rtt_create" 8 8 st_1)); *)
    (* when v_wi, st_3 == ((alloc_stack "smc_rtt_create" 24 8 st_2)); *)
    (* when v_s2_ctx, st_4 == ((alloc_stack "smc_rtt_create" 32 8 st_3)); *)
    let v_g_rd := (mkPtr "stack_g1" 0) in
    let v_g_tbl := (mkPtr "stack_g0" 0) in
    let v_wi := (mkPtr "stack_wi" 0) in
    let v_s2_ctx := (mkPtr "stack_s2_ctx" 0) in
    let st_4 := st_0 in
    when v_call_18, st_5 == ((find_lock_two_granules_spec v_rtt_addr 1 v_g_tbl v_rd_addr 2 v_g_rd st_4));
    if v_call_18
    then (
      when v_0_tmp, st_6 == ((load_RData 8 v_g_rd st_5));
      when v_call1_1, st_26 == ((granule_map_spec (int_to_ptr v_0_tmp) 2 st_6));
      when v_call2_17, st_27 == ((validate_rtt_structure_cmds_spec v_map_addr v_ulevel v_call1_1 st_26));
      if v_call2_17
      then (
        when v_5_tmp, st_28 == ((load_RData 8 (ptr_offset v_call1_1 32) st_27));
        when v_call6, st_29 == ((realm_rtt_starting_level_spec v_call1_1 st_28));
        when v_call7, st_30 == ((realm_ipa_bits_spec v_call1_1 st_29));
        when st_31 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1_1 16) 32 false st_30));
        when st_32 == ((buffer_unmap_spec v_call1_1 st_31));
        when st_34 == ((granule_lock_spec (int_to_ptr v_5_tmp) 6 st_32));
        when v_7_tmp, st_35 == ((load_RData 8 v_g_rd st_34));
        when st_36 == ((granule_unlock_spec (int_to_ptr v_7_tmp) st_35));
        when st_37 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_5_tmp) v_call6 v_call7 v_map_addr (v_ulevel + ((- 1))) v_wi st_36));
        when v_27, st_38 == ((load_RData 8 (ptr_offset v_wi 16) st_37));
        if ((v_27 - ((v_ulevel + ((- 1))))) =? (0))
        then (
          when v_9_tmp, st_39 == ((load_RData 8 (ptr_offset v_wi 0) st_38));
          when v_call14, st_40 == ((granule_map_spec (int_to_ptr v_9_tmp) 22 st_39));
          when v_28, st_41 == ((load_RData 8 (ptr_offset v_wi 8) st_40));
          when v_call15, st_42 == ((__tte_read_spec (ptr_offset v_call14 (8 * (v_28))) st_41));
          when v_12_tmp, st_43 == ((load_RData 8 v_g_tbl st_42));
          when v_call16, st_49 == ((granule_map_spec (int_to_ptr v_12_tmp) 1 st_43));
          when v_call17_18, st_50 == ((s2tte_is_unassigned_spec v_call15 st_49));
          if v_call17_18
          then (
            when v_call19, st_51 == ((s2tte_get_ripas_spec v_call15 st_50));
            when st_52 == ((s2tt_init_unassigned_spec v_call16 v_call19 st_51));
            when v_14_tmp, st_53 == ((load_RData 8 (ptr_offset v_wi 0) st_52));
            when st_54 == ((__granule_get_spec (int_to_ptr v_14_tmp) st_53));
            when v_21_tmp, st_55 == ((load_RData 8 v_g_tbl st_54));
            when st_65 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_55));
            when v_call63, st_66 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_65));
            when v_29, st_67 == ((load_RData 8 (ptr_offset v_wi 8) st_66));
            when st_69 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_29))) v_call63 st_67));
            when st_71 == ((buffer_unmap_spec v_call16 st_69));
            when st_74 == ((buffer_unmap_spec v_call14 st_71));
            when v_23_tmp, st_75 == ((load_RData 8 (ptr_offset v_wi 0) st_74));
            when st_82 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_75));
            when v_24_tmp, st_83 == ((load_RData 8 v_g_tbl st_82));
            when st_84 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_83));
            when st_86 == ((free_stack "smc_rtt_create" st_0 st_84));
            (Some (0, st_86)))
          else (
            when v_call21_17, st_51 == ((s2tte_is_destroyed_spec v_call15 st_50));
            if v_call21_17
            then (
              when st_52 == ((s2tt_init_destroyed_spec v_call16 st_51));
              when v_15_tmp, st_53 == ((load_RData 8 (ptr_offset v_wi 0) st_52));
              when st_54 == ((__granule_get_spec (int_to_ptr v_15_tmp) st_53));
              when v_21_tmp, st_65 == ((load_RData 8 v_g_tbl st_54));
              when st_66 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_65));
              when v_call63, st_67 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_66));
              when v_29, st_69 == ((load_RData 8 (ptr_offset v_wi 8) st_67));
              when st_71 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_29))) v_call63 st_69));
              when st_74 == ((buffer_unmap_spec v_call16 st_71));
              when st_75 == ((buffer_unmap_spec v_call14 st_74));
              when v_23_tmp, st_82 == ((load_RData 8 (ptr_offset v_wi 0) st_75));
              when st_83 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_82));
              when v_24_tmp, st_84 == ((load_RData 8 v_g_tbl st_83));
              when st_86 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_84));
              when st_89 == ((free_stack "smc_rtt_create" st_0 st_86));
              (Some (0, st_89)))
            else (
              when v_call26_16, st_52 == ((s2tte_is_assigned_spec v_call15 (v_ulevel + ((- 1))) st_51));
              if v_call26_16
              then (
                when v_call29, st_53 == ((s2tte_pa_spec v_call15 (v_ulevel + ((- 1))) st_52));
                when st_54 == ((s2tt_init_assigned_empty_spec v_call16 v_call29 v_ulevel st_53));
                when v_16_tmp, st_55 == ((load_RData 8 v_g_tbl st_54));
                when st_65 == ((__granule_refcount_inc_spec (int_to_ptr v_16_tmp) 512 st_55));
                when v_21_tmp, st_66 == ((load_RData 8 v_g_tbl st_65));
                when st_67 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_66));
                when v_call63, st_69 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_67));
                when v_29, st_71 == ((load_RData 8 (ptr_offset v_wi 8) st_69));
                when st_74 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_29))) v_call63 st_71));
                when st_75 == ((buffer_unmap_spec v_call16 st_74));
                when st_82 == ((buffer_unmap_spec v_call14 st_75));
                when v_23_tmp, st_83 == ((load_RData 8 (ptr_offset v_wi 0) st_82));
                when st_84 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_83));
                when v_24_tmp, st_86 == ((load_RData 8 v_g_tbl st_84));
                when st_87 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_86));
                when st_89 == ((free_stack "smc_rtt_create" st_0 st_87));
                (Some (0, st_89)))
              else (
                when v_call32_15, st_53 == ((s2tte_is_valid_spec v_call15 (v_ulevel + ((- 1))) st_52));
                if v_call32_15
                then (
                  when v_29, st_54 == ((load_RData 8 (ptr_offset v_wi 8) st_53));
                  when st_55 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_29))) 0 st_54));
                  when st_56 == ((invalidate_block_spec v_s2_ctx v_map_addr st_55));
                  when v_call38, st_65 == ((s2tte_pa_spec v_call15 (v_ulevel + ((- 1))) st_56));
                  when st_66 == ((s2tt_init_valid_spec v_call16 v_call38 v_ulevel st_65));
                  when v_18_tmp, st_67 == ((load_RData 8 v_g_tbl st_66));
                  when st_69 == ((__granule_refcount_inc_spec (int_to_ptr v_18_tmp) 512 st_67));
                  when v_21_tmp, st_71 == ((load_RData 8 v_g_tbl st_69));
                  when st_74 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_71));
                  when v_call63, st_75 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_74));
                  when v_30, st_82 == ((load_RData 8 (ptr_offset v_wi 8) st_75));
                  when st_83 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_30))) v_call63 st_82));
                  when st_84 == ((buffer_unmap_spec v_call16 st_83));
                  when st_86 == ((buffer_unmap_spec v_call14 st_84));
                  when v_23_tmp, st_87 == ((load_RData 8 (ptr_offset v_wi 0) st_86));
                  when st_89 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_87));
                  when v_24_tmp, st_90 == ((load_RData 8 v_g_tbl st_89));
                  when st_91 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_90));
                  when st_95 == ((free_stack "smc_rtt_create" st_0 st_91));
                  (Some (0, st_95)))
                else (
                  when v_call41_14, st_54 == ((s2tte_is_valid_ns_spec v_call15 (v_ulevel + ((- 1))) st_53));
                  if v_call41_14
                  then (
                    when v_29, st_55 == ((load_RData 8 (ptr_offset v_wi 8) st_54));
                    when st_56 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_29))) 0 st_55));
                    when st_65 == ((invalidate_block_spec v_s2_ctx v_map_addr st_56));
                    when v_call47, st_66 == ((s2tte_pa_spec v_call15 (v_ulevel + ((- 1))) st_65));
                    when st_67 == ((s2tt_init_valid_ns_spec v_call16 v_call47 v_ulevel st_66));
                    when v_20_tmp, st_69 == ((load_RData 8 v_g_tbl st_67));
                    when st_71 == ((__granule_refcount_inc_spec (int_to_ptr v_20_tmp) 512 st_69));
                    when v_21_tmp, st_74 == ((load_RData 8 v_g_tbl st_71));
                    when st_75 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_74));
                    when v_call63, st_82 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_75));
                    when v_30, st_83 == ((load_RData 8 (ptr_offset v_wi 8) st_82));
                    when st_84 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_30))) v_call63 st_83));
                    when st_86 == ((buffer_unmap_spec v_call16 st_84));
                    when st_87 == ((buffer_unmap_spec v_call14 st_86));
                    when v_23_tmp, st_89 == ((load_RData 8 (ptr_offset v_wi 0) st_87));
                    when st_90 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_89));
                    when v_24_tmp, st_91 == ((load_RData 8 v_g_tbl st_90));
                    when st_95 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_91));
                    when st_97 == ((free_stack "smc_rtt_create" st_0 st_95));
                    (Some (0, st_97)))
                  else (
                    when v_call50_13, st_55 == ((s2tte_is_table_spec v_call15 (v_ulevel + ((- 1))) st_54));
                    if v_call50_13
                    then (
                      when v_call54_4, st_56 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_55));
                      when st_65 == ((buffer_unmap_spec v_call16 st_56));
                      when st_66 == ((buffer_unmap_spec v_call14 st_65));
                      when v_23_tmp, st_67 == ((load_RData 8 (ptr_offset v_wi 0) st_66));
                      when st_69 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_67));
                      when v_24_tmp, st_71 == ((load_RData 8 v_g_tbl st_69));
                      when st_74 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_71));
                      when st_82 == ((free_stack "smc_rtt_create" st_0 st_74));
                      (Some (v_call54_4, st_82)))
                    else (
                      when v_21_tmp, st_65 == ((load_RData 8 v_g_tbl st_55));
                      when st_66 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_65));
                      when v_call63, st_67 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_66));
                      when v_29, st_69 == ((load_RData 8 (ptr_offset v_wi 8) st_67));
                      when st_71 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_29))) v_call63 st_69));
                      when st_74 == ((buffer_unmap_spec v_call16 st_71));
                      when st_75 == ((buffer_unmap_spec v_call14 st_74));
                      when v_23_tmp, st_82 == ((load_RData 8 (ptr_offset v_wi 0) st_75));
                      when st_83 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_82));
                      when v_24_tmp, st_84 == ((load_RData 8 v_g_tbl st_83));
                      when st_86 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_84));
                      when st_89 == ((free_stack "smc_rtt_create" st_0 st_86));
                      (Some (0, st_89)))))))))
        else (
          when v_call12_11, st_39 == ((pack_return_code_spec 4 v_27 st_38));
          when v_23_tmp, st_40 == ((load_RData 8 (ptr_offset v_wi 0) st_39));
          when st_41 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_40));
          when v_24_tmp, st_42 == ((load_RData 8 v_g_tbl st_41));
          when st_43 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_42));
          when st_49 == ((free_stack "smc_rtt_create" st_0 st_43));
          (Some (v_call12_11, st_49))))
      else (
        when st_28 == ((buffer_unmap_spec v_call1_1 st_27));
        when v_2_tmp, st_29 == ((load_RData 8 v_g_rd st_28));
        when st_30 == ((granule_unlock_spec (int_to_ptr v_2_tmp) st_29));
        when v_3_tmp, st_31 == ((load_RData 8 v_g_tbl st_30));
        when st_32 == ((granule_unlock_spec (int_to_ptr v_3_tmp) st_31));
        when st_34 == ((free_stack "smc_rtt_create" st_0 st_32));
        (Some (1, st_34))))
    else (
      when st_26 == ((free_stack "smc_rtt_create" st_0 st_5));
      (Some (1, st_26))). *)

  (* Conditional Spec *)
  (* Rely projection *)
  Definition smc_rec_destroy_spec (v_rec_addr: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_rec_addr & (4095)) =? (0))
    then (
      if ((v_rec_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_rec_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rec_addr / (GRANULE_SIZE)) < (1048576)))));
        rely (((((((st.(share)).(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) - (3)) = (0)));
        when sh == (Some (st.(share)));
        match ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock))) with
        | None =>
          rely (
            ((((((st.(share)).(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) -
              ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)))) =
              (0)));
          if ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_refcount)) =? (0))
          then (
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            rely (
              ((((((((sh.(granule_data)) @
                (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) >
                (0)) /\
                ((((((((sh.(granule_data)) @
                  (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                  (GRANULES_BASE)) >=
                  (0)))) /\
                ((((((((sh.(granule_data)) @
                  (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                  ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) <
                  (0)))));
            rely (
              (("granules" = ("granules")) /\
                (((((((((sh.(granule_data)) @
                  (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                  (GRANULES_BASE)) mod
                  (ST_GRANULE_SIZE)) =
                  (0)))));
            when cid == (
                ((((sh.(granules)) #
                  ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                  ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1)) @
                  ((((((((sh.(granule_data)) @
                    (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                    (GRANULES_BASE)) /
                    (ST_GRANULE_SIZE)) +
                    ((8 / (ST_GRANULE_SIZE))))).(e_lock)));
            if (
              ((((((sh.(granules)) #
                ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1)) @
                ((((((((sh.(granule_data)) @
                  (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                  (GRANULES_BASE)) /
                  (ST_GRANULE_SIZE)) +
                  ((8 / (ST_GRANULE_SIZE))))).(e_refcount)) +
                ((- 1))) <?
                (0)))
            then None
            else (
              if (
                ((((((((((sh.(granule_data)) @
                  (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                  (GRANULES_BASE)) +
                  (8)) mod
                  (ST_GRANULE_SIZE)) =?
                  (8)) &&
                  ((((((sh.(granules)) @
                    ((((((((sh.(granule_data)) @
                      (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                      (GRANULES_BASE)) /
                      (ST_GRANULE_SIZE)) +
                      ((8 / (ST_GRANULE_SIZE))))).(e_state)) -
                    (GRANULE_STATE_REC)) =?
                    (0)))))
              then (
                (Some (
                  0  ,
                  ((st.[log] :<
                    ((EVT
                      CPU_ID
                      (REC_REF
                        ((((((((sh.(granule_data)) @
                          (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                          (GRANULES_BASE)) /
                          (ST_GRANULE_SIZE)) +
                          ((8 / (ST_GRANULE_SIZE))))
                        ((((sh.(granules)) @
                          ((((((((sh.(granule_data)) @
                            (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                            (GRANULES_BASE)) /
                            (ST_GRANULE_SIZE)) +
                            ((8 / (ST_GRANULE_SIZE))))).(e_refcount)) +
                          ((- 1))))) ::
                      (((EVT
                        CPU_ID
                        (REL
                          ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                          ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)).[e_state] :< 1))) ::
                        (((EVT CPU_ID (ACQ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))).[share] :<
                    (((sh.[granule_data] :<
                      ((sh.(granule_data)) #
                        (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC) ==
                        ((((sh.(granule_data)) @
                          (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).[g_norm] :<
                          zero_granule_data_normal).[g_rec] :<
                          empty_rec))).[granules] :<
                      (((sh.(granules)) #
                        ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                        ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1)) #
                        ((((((((sh.(granule_data)) @
                          (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                          (GRANULES_BASE)) /
                          (ST_GRANULE_SIZE)) +
                          ((8 / (ST_GRANULE_SIZE)))) ==
                        (((sh.(granules)) @
                          ((((((((sh.(granule_data)) @
                            (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                            (GRANULES_BASE)) /
                            (ST_GRANULE_SIZE)) +
                            ((8 / (ST_GRANULE_SIZE))))).[e_refcount] :<
                          ((((sh.(granules)) @
                            ((((((((sh.(granule_data)) @
                              (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                              (GRANULES_BASE)) /
                              (ST_GRANULE_SIZE)) +
                              ((8 / (ST_GRANULE_SIZE))))).(e_refcount)) +
                            ((- 1)))))).[slots] :<
                      ((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE)))))
                )))
              else (
                (Some (
                  0  ,
                  ((st.[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                        ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)).[e_state] :< 1))) ::
                      (((EVT CPU_ID (ACQ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                    (((sh.[granule_data] :<
                      ((sh.(granule_data)) #
                        (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC) ==
                        ((((sh.(granule_data)) @
                          (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).[g_norm] :<
                          zero_granule_data_normal).[g_rec] :<
                          empty_rec))).[granules] :<
                      (((sh.(granules)) #
                        ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                        ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1)) #
                        ((((((((sh.(granule_data)) @
                          (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                          (GRANULES_BASE)) /
                          (ST_GRANULE_SIZE)) +
                          ((8 / (ST_GRANULE_SIZE)))) ==
                        (((sh.(granules)) @
                          ((((((((sh.(granule_data)) @
                            (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                            (GRANULES_BASE)) /
                            (ST_GRANULE_SIZE)) +
                            ((8 / (ST_GRANULE_SIZE))))).[e_refcount] :<
                          ((((sh.(granules)) @
                            ((((((((sh.(granule_data)) @
                              (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                              (GRANULES_BASE)) /
                              (ST_GRANULE_SIZE)) +
                              ((8 / (ST_GRANULE_SIZE))))).(e_refcount)) +
                            ((- 1)))))).[slots] :<
                      ((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE)))))
                )))))
          else (
            (Some (
              5  ,
              ((st.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                    (((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                (sh.[granules] :<
                  ((sh.(granules)) #
                    ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                    (((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None))))
            )))
        | (Some cid) => None
        end))
    else (Some (1, st)).

Definition smc_granule_delegate_spec (v_addr: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_addr & (4095)) =? (0))
    then (
      if ((v_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
        rely ((((((st.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) = (0)));
        when sh == (Some st.(share));
        match ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock))) with
        | None =>
          rely (
            ((((((st.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) -
              ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)))) =
              (0)));
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          (Some (
            0  ,
            ((st.[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                  ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)).[e_state] :< 1))) ::
                (((EVT CPU_ID (ACQ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
              ((((sh.[gpt] :< ((sh.(gpt)) # (v_addr / (GRANULE_SIZE)) == true)).[granule_data] :<
                ((sh.(granule_data)) #
                  (((sh.(slots)) # SLOT_DELEGATED == (((((GRANULES_BASE + ((16 * ((v_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_DELEGATED) ==
                  (((((sh.(granule_data)) @
                    (((sh.(slots)) # SLOT_DELEGATED == (((((GRANULES_BASE + ((16 * ((v_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_DELEGATED)).[g_norm] :<
                    zero_granule_data_normal).[g_rd] :<
                    empty_rd).[g_rec] :<
                    empty_rec))).[granules] :<
                ((sh.(granules)) #
                  ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                  ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1))).[slots] :<
                ((sh.(slots)) # SLOT_DELEGATED == (((((GRANULES_BASE + ((16 * ((v_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE)))))
          ))
        | (Some cid) => None
        end))
    else (Some (1, st)).

Definition smc_granule_undelegate_spec (v_addr: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_addr & (4095)) =? (0))
    then (
      if ((v_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
        rely (((((((st.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) - (1)) = (0)));
        when sh == Some (st.(share));
        match ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock))) with
        | None =>
          rely (
            ((((((st.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) -
              ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)))) =
              (0)));
          (Some (
            0  ,
            ((st.[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                  ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)).[e_state] :< 0))) ::
                (((EVT CPU_ID (ACQ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
              ((sh.[gpt] :< ((sh.(gpt)) # (v_addr / (GRANULE_SIZE)) == false)).[granules] :<
                ((sh.(granules)) #
                  ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                  ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 0))))
          ))
        | (Some cid) => None
        end))
    else (Some (1, st)).
End SMCHandler.


  Definition walk_one_step (sh: Shared) (lvl: Z) (gfn: Z) (rtt_idx: Z) : Z :=
    let offs := gfn_to_rtt_offs gfn lvl in
      (sh.(granule_data) @ rtt_idx).(g_norm) @ offs.

  Fixpoint walk_rtt_level (n: nat) (sh: Shared) (lvl: Z) (rd: Z) (gfn: Z) (pte: Z) : : nat -> (Shared -> (Z -> (Z -> (Z -> (Z -> ((Z * Z))))))) :=
    match n with
    | O => (lvl, pte)
    | S n' =>
        match walk_rtt_level n' sh lvl rd gfn pte with
        | (lvl', pte') =>
            let rtt_idx' := pte_to_gidx pte' in
            if ((sh.(granules) @ rtt_idx').(e_state) =? GRANULE_STATE_RTT) then
              let pte'' := walk_one_step sh lvl' gfn rtt_idx' in
              (lvl' + 1, pte'')
            else
              (lvl', pte')
        end
      end.
Parameter gfn_to_rtt_offs: Z -> (Z -> (Z)).
Parameter gfn_to_pte_offs: Z -> (Z -> (Z)).
Parameter ADDR_MASK: Z.
Parameter PTE_IS_VALID: Z -> (bool).
Parameter PTE_IS_TABLE: Z -> (bool).
Parameter gidx_to_table_pte : Z -> (Z).
Parameter pte_to_gidx: Z -> (Z).
Parameter PTE_PERM: Z -> (Z).


Definition rd_rtt (sh: Shared) (rd: Z) : Z := (sh.(granule_data) @ rd).(g_rd).(e_rd_s2_ctx).(e_rls2ctx_g_rtt).

Definition walk_star (sh: Shared) (rd: Z) (gfn: Z) (rtt_idx: Z) : Prop :=
  exists (lvl: Z) (pte: Z) (N: nat),
    (walk_rtt_level N sh 0 rd gfn (gidx_to_table_pte (rd_rtt sh rd)) = (lvl, pte)
     /\ rtt_idx = pte_to_gidx pte).

Definition walk_reverse (sh: Shared) : Prop :=
  exists (rev: Z -> ((Z * Z))),
  (forall (rd: Z) (gfn: Z) (rtt_idx: Z)
         (Hwalk: walk_star sh rd gfn rtt_idx)
         (Hrtt: (sh.(granules) @ rtt_idx).(e_state) = GRANULE_STATE_RTT),
      (forall (par_idx: Z) (ofs: Z), (rev rtt_idx = (par_idx, ofs) ->
                      ((rtt_idx = rd_rtt sh rd -> par_idx = rd /\ ofs = 0)
                       /\ (rtt_idx <> rd_rtt sh rd ->
                           ((sh.(granules) @ par_idx).(e_state) = GRANULE_STATE_RTT
                            /\ pte_to_gidx ((sh.(granule_data) @ par_idx).(g_norm) @ ofs) = rtt_idx)))))).

Definition pte_table_equiv (pte: Z) (table: ZMap.t Z) : Prop :=
  PTE_IS_TABLE pte = false /\
    forall (idx: Z),
      (if pte_to_gidx pte =? 0 then
        pte_to_gidx (table @ idx) = 0
      else
        PTE_PERM pte = PTE_PERM (table @ idx) /\  pte_to_gidx (table @ idx) = pte_to_gidx pte + idx).

Definition rd_rtt_reverse (sh: Shared) : Prop :=
  exists (rev: Z -> (Z)),
  (forall (rd: Z) (rtt_idx: Z) (Hrtt: rd_rtt sh rd = rtt_idx), (rev rtt_idx = rd)).



(* Invariant gpt_false_ns :=
  forall (gidx: Z), (st.(share).(gpt) @ gidx = false -> (st.(share).(granules) @ gidx).(e_state) = GRANULE_STATE_NS). *)

(* Parameter zero_granule: GranuleDataNormal. *)


(*trigger: granules, granules_data update *)

Invariant delegated_zero :=
  forall (gidx: Z),
    (((st.(share).(granules) @ gidx).(e_state) = GRANULE_STATE_DELEGATED) ->
    ((st.(share).(granule_data) @ gidx).(g_rec) = empty_rec) /\
     (st.(share).(granule_data) @ gidx).(g_norm) = zero_granule_data_normal).

(* Observation: *)
(* the quantifier variables should be annotated with bounds *)
(*triggers : granules update *)
(* Invariant rtt_map_data  :=
  forall (rd_gidx: Z) (ipa_gidx: Z) (data_gidx: Z),
    (st.(share).(granules) @ rd_gidx).(e_state) = GRANULE_STATE_RD ->
         walk_rtt sh rd_gidx ipa_gidx = Some data_gidx ->
    ((st.(share).(granules) @ data_gidx).(e_state) = GRANULE_STATE_DATA). *)


(* triggers: granules update *)
(* Invariant rec_rd_prop  :=
  forall (gidx: Z),
    ((st.(share).(granules) @ gidx).(e_state) = GRANULE_STATE_REC ->
     ((st).(share).(granules) @ ((st).(share).(granule_data) @ gidx).(g_rec).(e_realm_info).(e_g_rd)).(e_state) = GRANULE_STATE_RD). *)

