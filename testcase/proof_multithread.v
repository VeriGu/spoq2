Definition PROJ_NAME: string := "RMMProof.ProofGenStack".
Definition PROJ_BASE: string := "./ProofGenStack".
Hint CacheSpec.

Parameter CPU_ID: Z.

Definition REALM_STATE_NEW : Z := 0.
Definition REALM_STATE_ACTIVE : Z := 1.
Definition REALM_STATE_SYSTEM_OFF : Z := 2.

Include "./st_rec.v".
Include "./st_pmu_state.v".
Include "./st_simd_state.v".
Include "./st_ns_simd_state.v".
Include "./st_rmi_rec_params.v".

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
  if (ofs =? 16) then Some (st.(e_rls2ctx_g_rtt)) else
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
      pcpu_stack: ZMap.t StackFrame;
      pcpu_sc: Z; (* Abstract Stack Counter, points to the next stack frame *)
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

      pcpu_dummy_regs: Z;

      pcpu_llt_info_cache: ZMap.t s_xlat_llt_info

    }.

Record Shared :=
  mkShared {
      glk: ZMap.t (option Z);
      gpt: ZMap.t bool;

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
      gv_g_ns_simd: s_ns_simd_state;
      gv_g_cpu_simd_type: Z
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
| REC_REFP (gidx2: Z)
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

Record STACK :=
  mkSTACK {
      FindGranule_stack: ZMap.t Z;
      LockGranules_stack: ZMap.t Z;
      smc_rtt_set_ripas_stack: ZMap.t Z;
      handle_rsi_realm_config_stack: ZMap.t Z;
      do_host_call_stack: ZMap.t Z;
      attest_token_continue_write_state_stack: ZMap.t Z;
      smc_rec_create_stack: ZMap.t Z
    }.

Record stack_ptrs :=
  mkstack_ptrs {
      smc_rtt_set_ripas_sp: Z;
      smc_rtt_set_ripas_sp: Z;
      handle_rsi_realm_config_sp: Z;
      do_host_call_sp: Z;
      attest_token_continue_write_state_sp: Z;
      smc_rec_create_sp: Z
    }.

Record RData :=
  mkRData {
      log: list Event;
      oracle: Oracle;
      repl: Replay;

      share: Shared;
      priv: PerCPU;

      stack: STACK;
      func_sp: stack_ptrs
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

(* States of a granule *)
Definition GRANULE_STATE_NS : Z := 0.
Definition GRANULE_STATE_UNDELEGATED : Z := GRANULE_STATE_NS.
Definition GRANULE_STATE_DELEAGATE : Z := 1.
Definition GRANULE_STATE_RD : Z := 2.
Definition GRANULE_STATE_REC : Z := 3.
Definition GRANULE_STATE_REC_AUX : Z := 4.
Definition GRANULE_STATE_DATA : Z := 5.
Definition GRANULE_STATE_RTT : Z := 6.
Definition GRANULE_STATE_LAST : Z := GRANULE_STATE_RTT.

(* SLOT begins from here *)
Definition SLOT_VIRT : Z := 18446744073709420544.
Parameter GRANULES_BASE : Z.
Definition ST_GRANULE_SIZE : Z:= 16.
Definition RMM_MAX_GRANULES : Z := 1048576.
Definition MAX_REC_AUX_GRANULES : Z := 16.
Definition GRANULE_SIZE : Z := 4096.

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
Definition rec_no_rd (st: RData) : Prop := ((int_to_ptr ((st.(share).(granule_data) @ (st.(share).(slots) @ SLOT_REC)).(g_rec).(e_realm_info).(e_g_rd))).(pbase) = "NULL").
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
    | _ => false
    end
  else true.

Definition s_granule_field_accessible (g: s_granule) (ofs: Z) : bool :=
  (* granule_state can only be accessed with lock *)
  if ofs =? 4 then
    match g.(e_lock) with
    | Some cid => true
    | _ => false
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
      | _ => false
      end )
  (* lock should not be directly accessed *)
  else false.

Definition load_RData (sz: Z) (p: Ptr) (st: RData) : (option (Z * RData)) :=
  if (p.(pbase) =s "gic_virt_feature_0") then Some (gic_virt_feature_0, st) else
  if (p.(pbase) =s "gic_virt_feature_1") then Some (gic_virt_feature_1, st) else
  if (p.(pbase) =s "gic_virt_feature_2") then Some (gic_virt_feature_2, st) else
  if (p.(pbase) =s "gic_virt_feature_3") then Some (gic_virt_feature_3, st) else
  if (p.(pbase) =s "gic_virt_feature_4") then Some (gic_virt_feature_4, st) else
  if p.(pbase) =s "granules" then
      let ofs := p.(poffset) in
      let idx := ofs / ST_GRANULE_SIZE in
      let ofs := ofs mod ST_GRANULE_SIZE in
      rely (s_granule_field_accessible (ZMap.get st.(share).(granules) idx) ofs = true);
      when ret == load_s_granule sz ofs (ZMap.get st.(share).(granules) idx);
      Some (ret, st) else
  if p.(pbase) =s "slot_rd" then
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RD in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      rely (rd_field_accessible g_data.(g_rd) ofs g false st = true);
      match g.(e_lock) with
      | Some cid =>
          when ret == load_s_rd sz ofs g_data.(g_rd);
          Some (ret, st)
      | _ => None
      end else
  if p.(pbase) =s "slot_rec" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      (* XXX: REC can be ref-protected *)
      let locked := match g.(e_lock) with
                    | Some cid => true
                    | None => false
                    end in
      rely (rec_field_accessible g locked st = true);
      let st :=
        ( if (!locked) then st.[log] :< ((EVT CPU_ID (REC_REFP g_idx)) :: st.(log)) else st)
      in
      when ret == load_s_rec sz ofs g_data.(g_rec);
      Some (ret, st)
    ) else
  if p.(pbase) =s "slot_rec2" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC2 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      (* XXX: REC can be ref-protected *)
      let locked := match g.(e_lock) with
                    | Some cid => true
                    | None => false
                    end in
      rely (rec_field_accessible g locked st = true);
      let st :=
        (if (!locked) then st.[log] :< ((EVT CPU_ID (REC_REFP g_idx)) :: st.(log)) else st )
      in
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
  if p.(pbase) =s "slot_rec_aux0" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC_AUX0 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let parent_g_idx := g_data.(rec_gidx) in
      let parent_g_data := st.(share).(granule_data) @ parent_g_idx in
      let parent_g := st.(share).(granules) @ parent_g_idx in
      let locked := match parent_g.(e_lock) with
                    | Some cid => true
                    | None => false
                    end in
      (*
       * @ofs here is the the offset to struct rec, but the data have the same
       * protection level of rec->aux_data. So we pass the offset to
       * rec->aux_data instead.
       *)
      rely (rec_field_accessible parent_g locked st = true);
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
  if p.(pbase) =s "stack" then (
      let ofs := p.(poffset) in
      let slot_nr := stack_ptr_extract_slot ofs in
      let slot_ofs := stack_ptr_extract_ofs ofs in
      rely (((st.(priv).(pcpu_stack) @ slot_nr).(sf_data) @ slot_ofs).(sd_size) = sz);
      Some (((st.(priv).(pcpu_stack) @ slot_nr).(sf_data) @ slot_ofs).(sd_data), st) ) else
  if p.(pbase) =s "FindGranule_stack" then Some ((st.(stack).(FindGranule_stack) @ p.(poffset)), st) else
  if p.(pbase) =s "LockGranules_stack" then Some ((st.(stack).(LockGranules_stack) @ p.(poffset)), st) else
  if p.(pbase) =s "smc_rtt_set_ripas_stack" then Some ((st.(stack).(smc_rtt_set_ripas_stack) @ p.(poffset)), st) else
  if p.(pbase) =s "handle_rsi_realm_config_stack" then Some ((st.(stack).(handle_rsi_realm_config_stack) @ p.(poffset)), st) else
  if p.(pbase) =s "do_host_call_stack" then Some ((st.(stack).(do_host_call_stack) @ p.(poffset)), st) else
  if p.(pbase) =s "attest_token_continue_write_state_stack" then Some ((st.(stack).(attest_token_continue_write_state_stack) @ p.(poffset)), st) else
  if p.(pbase) =s "smc_rec_create_stack" then Some ((st.(stack).(smc_rec_create_stack) @ p.(poffset)), st) else
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
      let ofs := p.(poffset) in
      when ret == load_s_ns_simd_state sz ofs st.(share).(gv_g_ns_simd);
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
  None.

Definition store_RData (sz: Z) (p: Ptr) (v: Z) (st: RData) : option RData :=
  if p.(pbase) =s "granules" then let ofs := p.(poffset) in
      let idx := ofs / ST_GRANULE_SIZE in
      let elem_ofs := ofs mod ST_GRANULE_SIZE in
      rely (s_granule_field_accessible (ZMap.get st.(share).(granules) idx) ofs = true);
      when ret == store_s_granule sz elem_ofs v (ZMap.get st.(share).(granules) idx);
      let new_granules := ZMap.set st.(share).(granules) idx ret in
      Some (st.[share].[granules] :< new_granules) else
  if p.(pbase) =s "slot_rd" then let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RD in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      rely (rd_field_accessible g_data.(g_rd) ofs g true st = true);
      match g.(e_lock) with
      | Some cid =>
          when new_rd == store_s_rd sz ofs v g_data.(g_rd);
          let new_gdata := (g_data.[g_rd] :< new_rd) in
          (* let new_slots := (st.(share).(slots) # SLOT_RD == new_gdata) in *)
          (* Some (st.[share].[slots] :< new_slots) *)
          Some (st.[share].[granule_data] :< (st.(share).(granule_data) # g_idx == new_gdata))
      | None => None
      end else
  if p.(pbase) =s "slot_rec" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      (* XXX: REC can be ref-protected *)
      let locked := match g.(e_lock) with
                    | Some cid => true
                    | None => false
                    end in
      rely (rec_field_accessible g locked st = true);
      let st :=
        if (!locked) then st.[log] :< ((EVT CPU_ID (REC_REFP g_idx)) :: st.(log)) else st in
      when new_rec == store_s_rec sz ofs v g_data.(g_rec);
      let new_gdata := (g_data.[g_rec] :< new_rec) in
      (* let new_slots := (st.(share).(slots) # SLOT_REC == new_gdata) in *)
      Some (st.[share].[granule_data] :< st.(share).(granule_data) # g_idx == new_gdata)
    ) else
  if p.(pbase) =s "slot_rec2" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC2 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      (* XXX: REC can be ref-protected *)
      let locked := match g.(e_lock) with
                    | Some cid => true
                    | None => false
                    end in
      rely (rec_field_accessible g locked st = true);
      let st :=
        if (!locked) then st.[log] :< ((EVT CPU_ID (REC_REFP g_idx)) :: st.(log)) else st in
      when new_rec == store_s_rec sz ofs v g_data.(g_rec);
      let new_gdata := (g_data.[g_rec] :< new_rec) in
      (* let new_slots := (st.(share).(slots) # SLOT_REC2 == new_gdata) in *)
      Some (st.[share].[granule_data] :< (st.(share).(granule_data) # g_idx == new_gdata))
    ) else
  if p.(pbase) =s "slot_rtt" then let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RTT in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      match g.(e_lock) with
      | Some cid =>
          Some st
      | None => None
      end else
  if p.(pbase) =s "slot_rec_aux0" then (
      let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_REC_AUX0 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let parent_g_idx := g_data.(rec_gidx) in
      let parent_g_data := st.(share).(granule_data) @ parent_g_idx in
      let parent_g := st.(share).(granules) @ parent_g_idx in
      let locked := match parent_g.(e_lock) with
                    | Some cid => true
                    | None => false
                    end in
      (*
       * @ofs here is the the offset to struct rec, but the data have the same
       * protection level of rec->aux_data. So we pass the offset to
       * rec->aux_data instead.
       *)
      rely (rec_field_accessible parent_g locked st = true);
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
        else None
    ) else
  if p.(pbase) =s "slot_rtt2" then let ofs := p.(poffset) in
      let g_idx := st.(share).(slots) @ SLOT_RTT2 in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      match g.(e_lock) with
      | Some cid => Some st
      | None => None
      end else
  if p.(pbase) =s "bad_stack" then let ofs := p.(poffset) in
      Some st else
  if p.(pbase) =s "stack" then (let ofs := p.(poffset) in
      let slot_nr := stack_ptr_extract_slot ofs in
      let slot_ofs := stack_ptr_extract_ofs ofs in
      let ret := st.[priv].[pcpu_stack] :<
                   (st.(priv).(pcpu_stack) # slot_nr ==
                      ((st.(priv).(pcpu_stack) @ slot_nr).[sf_data] :<
                         ((st.(priv).(pcpu_stack) @ slot_nr).(sf_data) # slot_ofs ==
                            (mkStackData v sz)))) in
      Some ret
      (* if ((st.(priv).(pcpu_stack) @ slot_nr).(sf_data) @ slot_ofs).(sd_size) =? 0 then *)
      (*   Some ret *)
      (* else *)
      (*   rely (((st.(priv).(pcpu_stack) @ slot_nr).(sf_data) @ slot_ofs).(sd_size) = sz); *)
                               (*   Some ret *)) else
  if p.(pbase) =s "FindGranule_stack" then (
      Some (st.[stack].[FindGranule_stack] :< (st.(stack).(FindGranule_stack) # (p.(poffset)) == v))
    ) else
  if p.(pbase) =s "LockGranules_stack" then (
      Some (st.[stack].[LockGranules_stack] :< (st.(stack).(LockGranules_stack) # (p.(poffset)) == v))
    ) else
  if p.(pbase) =s "smc_rtt_set_ripas_sp_stack" then
    Some (st.[stack].[smc_rtt_set_ripas_stack] :< (st.(stack).(smc_rtt_set_ripas_stack) # (p.(poffset)) == v)) else
  if p.(pbase) =s "handle_rsi_realm_config_stack" then
    Some (st.[stack].[handle_rsi_realm_config_stack] :< (st.(stack).(handle_rsi_realm_config_stack) # (p.(poffset)) == v)) else
  if p.(pbase) =s "do_host_call_stack" then
    Some (st.[stack].[do_host_call_stack] :< (st.(stack).(do_host_call_stack) # (p.(poffset)) == v)) else
  if p.(pbase) =s "attest_token_continue_write_state_stack" then
    Some (st.[stack].[attest_token_continue_write_state_stack] :< (st.(stack).(attest_token_continue_write_state_stack) # (p.(poffset)) == v)) else
  if p.(pbase) =s "smc_rec_create_stack" then
    Some (st.[stack].[smc_rec_create_stack] :< (st.(stack).(smc_rec_create_stack) # (p.(poffset)) == v)) else
  (* Global variables *)
  if p.(pbase) =s "g_sve_max_vq" then let ofs := p.(poffset) in Some (st.[share].[gv_g_sve_max_vq] :< v) else
  if p.(pbase) =s "g_ns_simd" then let ofs := p.(poffset) in
      when ret == store_s_ns_simd_state sz ofs v st.(share).(gv_g_ns_simd);
      Some (st.[share].[gv_g_ns_simd] :< ret) else
  if p.(pbase) =s "g_cpu_simd_type" then let ofs := p.(poffset) in
      Some (st.[share].[gv_g_cpu_simd_type] :< v) else
  if p.(pbase) =s "llt_info_cache" then let ofs := p.(poffset) in Some st else
  None.

Definition alloc_stack (fname: string) (sz: Z) (ofs: Z) (st: RData) : option (Ptr * RData) :=
  if fname =s "sort_granules" then Some ((mkPtr "FindGranule_stack" 0), st) else
  if fname =s "find_lock_two_granules" then Some ((mkPtr "LockGranules_stack" 0), st) else
  if fname =s "smc_rtt_set_ripas" then
    Some ((mkPtr "smc_rtt_set_ripas_stack" (st.(func_sp).(smc_rtt_set_ripas_sp))),
        (st.[func_sp].[smc_rtt_set_ripas_sp] :< (st.(func_sp).(smc_rtt_set_ripas_sp) + sz))) else
  if fname =s "handle_rsi_realm_config" then
    Some ((mkPtr "handle_rsi_realm_config_stack" (st.(func_sp).(handle_rsi_realm_config_sp))),
        (st.[func_sp].[handle_rsi_realm_config_sp] :< (st.(func_sp).(handle_rsi_realm_config_sp) + sz))) else
  if fname =s "do_host_call" then
    Some ((mkPtr "do_host_call_stack" (st.(func_sp).(do_host_call_sp))),
        (st.[func_sp].[do_host_call_sp] :< (st.(func_sp).(do_host_call_sp) + sz))) else
  if fname =s "attest_token_continue_write_state" then
    Some ((mkPtr "attest_token_continue_write_state_stack" (st.(func_sp).(attest_token_continue_write_state_sp))),
        (st.[func_sp].[attest_token_continue_write_state_sp] :< (st.(func_sp).(attest_token_continue_write_state_sp) + sz))) else
  if fname =s "smc_rec_create" then
    Some ((mkPtr "smc_rec_create_stack" (st.(func_sp).(smc_rec_create_sp))),
        (st.[func_sp].[smc_rec_create_sp] :< (st.(func_sp).(smc_rec_create_sp) + sz))) else
  Some ((mkPtr "bad_stack" 0), st).

Definition free_stack (fname: string) (init_st: RData)(st: RData) : option RData :=
  if fname =s "sort_granules" then
    Some (st.[stack].[FindGranule_stack] :< (init_st.(stack).(FindGranule_stack))) else
  if fname =s "find_lock_two_granules" then
    Some (st.[stack].[LockGranules_stack] :< (init_st.(stack).(LockGranules_stack))) else
  if fname =s "smc_rtt_set_ripas_sp" then
    Some (st.[stack].[smc_rtt_set_ripas_stack] :< (init_st.(stack).(smc_rtt_set_ripas_stack))) else
  if fname =s "handle_rsi_realm_config" then
      Some (st.[stack].[handle_rsi_realm_config_stack] :< (init_st.(stack).(handle_rsi_realm_config_stack))) else
  if fname =s "do_host_call" then
    Some (st.[stack].[do_host_call_stack] :< (init_st.(stack).(do_host_call_stack))) else
  if fname =s "attest_token_continue_write_state" then
    Some (st.[stack].[attest_token_continue_write_state_stack] :< (init_st.(stack).(attest_token_continue_write_state_stack))) else
  if fname =s "smc_rec_create" then
    Some (st.[stack].[smc_rec_create_stack] :< (init_st.(stack).(smc_rec_create_stack))) else
    Some st.

Definition new_frame (fname: string) (st: RData) : option RData := Some st.

Definition base_to_slot (b: string) : option Z :=
  if b =s "slot_ns" then Some SLOT_NS else
  if b =s "slot_delegated" then Some SLOT_DELEGATED else
  if b =s "slot_rd" then Some SLOT_RD else
  if b =s "slot_rec" then Some SLOT_REC else
  if b =s "slot_rec2" then Some SLOT_REC2 else
  if b =s "slot_rec_target" then Some SLOT_REC_TARGET else
  if b =s "slot_rec_aux0" then Some SLOT_REC_AUX0 else
  if b =s "slot_rtt" then Some SLOT_RTT else
  if b =s "slot_rtt2" then Some SLOT_RTT2 else
  if b =s "slot_rsi_call" then Some SLOT_RSI_CALL
  else None.

Definition ptr_to_int (p: Ptr) : Z :=
  match base_to_slot p.(pbase) with
  | Some slot => SLOT_VIRT + slot * GRANULE_SIZE + p.(poffset)
  | None =>
      match (p.(pbase), p.(poffset)) with
      | ("status", ofs) =>
          if ofs <? 0 then (-ofs) else 0
      | ("granules", ofs) => GRANULES_BASE + ofs
      | _ => 0
      end
  end.

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
  (mkPtr "NULL" 0).

Definition int_to_ptr (v: Z) : Ptr :=
  if v >? 0 then (
      (if (v >? GRANULES_BASE) && (v <? GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE) then
        (mkPtr "granules" (v - GRANULES_BASE))
      else (
          let slot := (v - SLOT_VIRT) / GRANULE_SIZE in
          (* let ofs := (v - SLOT_VIRT) mod GRANULE_SIZE in *)
          slot_to_ptr slot v
        ))
    ) else
  if v <? 0 then (mkPtr "status" (-v)) else (mkPtr "NULL" 0).

Definition ptr_eqb (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 =? ptr_to_int p2.

Definition ptr_ltb (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 <? ptr_to_int p2.

Definition ptr_gtb (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 >? ptr_to_int p2.

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
      "find_lock_rd_granules" :: (* Nested loop *)
      "__table_maps_block" :: (* Loop w. funptr *)
      "__table_is_uniform_block" :: (* Loop w. funptr *)
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
      nil.

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
      when st == query_oracle st;
      (* BUG: Spoq cannot correctly handle the naming conflict here. *)
      (* rely (forall (gidx_l: Z), (st.(share).(glk) @ gidx_l = None)); *)
      let g := (st.(share).(granules) @ gidx_l) in
      match g.(e_lock) with
      | None =>
          let e := EVT CPU_ID (ACQ gidx_l) in
          let new_granules := st.(share).(granules) # gidx_l == (g.[e_lock] :< (Some CPU_ID)) in
          let new_st := st.[share].[granules] :< new_granules in
          Some (new_st.[log] :< (e :: new_st.(log)))
      | Some cid => None
      end
    else None.
    (* if lock.(pbase) =s "granules" then *)
    (*   let gidx_l := lock.(poffset) in *)
    (*   when st == query_oracle st; *)
    (*   let e := EVT CPU_ID (ACQ_GPT gidx_l) in *)
    (*   rely (forall (gidx_l: Z), (st.(share).(glk) @ gidx_l = None)); *)
    (*   Some (st.[log] :< (e :: st.(log)).[share].[glk] :< (st.(share).(glk) # gidx_l == (Some CPU_ID))) *)
    (* else None. *)

  Definition spinlock_release_spec (lock: Ptr) (st: RData) : option RData :=
    if lock.(pbase) =s "granules" then
      let ofs := lock.(poffset) in
      let gidx_l := ofs / ST_GRANULE_SIZE in
      let g := (st.(share).(granules) @ gidx_l) in
      (* rely (forall (gidx_l: Z), (st.(share).(glk) @ gidx_l = (Some CPU_ID))); *)
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
    if (v_dest.(pbase) =s "FindGranule_stack") && (v_src.(pbase) =s "LockGranules_stack") then
      let _src_0 := (st.(stack).(LockGranules_stack) @ (v_src.(poffset))) in
      let _src_1 := (st.(stack).(LockGranules_stack) @ (v_src.(poffset) + 8)) in
      let _src_2 := (st.(stack).(LockGranules_stack) @ (v_src.(poffset) + 16)) in
      let _dest_0 := (st.(stack).(FindGranule_stack) # 0 == _src_0) in
      let _dest_1 := (_dest_0 # 8 == _src_1) in
      let _dest_2 := (_dest_1 # 16 == _src_2) in
      Some (st.[stack].[FindGranule_stack] :< _dest_2)
    else
      Some st.

  Definition __llvm_memcpy_p0i8_p0i8_i64_spec (v_dest: Ptr) (v_src: Ptr) (sz: Z) (is_volatile: bool) (st: RData) : option RData :=
    if (v_dest.(pbase) =s "stack") && (v_src.(pbase) =s "stack") then (
      let dest_slot_nr := stack_ptr_extract_slot v_dest.(poffset) in
      let dest_slot_ofs := stack_ptr_extract_ofs v_dest.(poffset) in
      let src_slot_nr := stack_ptr_extract_slot v_src.(poffset) in
      let src_slot_ofs := stack_ptr_extract_ofs v_src.(poffset) in
      (* XXX: Let's use some stupid hacking... *)
      if sz =? 24 then (
        (* sort_granules: tmp = granules[i] *)
        (* sort_granules: granules[j] = temp *)
        (* data type: struct granule *)
        let _src_0 := ((st.(priv).(pcpu_stack) @ src_slot_nr).(sf_data) @ src_slot_ofs) in
        let _src_1 := ((st.(priv).(pcpu_stack) @ src_slot_nr).(sf_data) @ (src_slot_ofs + 8)) in
        let _src_2 := ((st.(priv).(pcpu_stack) @ src_slot_nr).(sf_data) @ (src_slot_ofs + 16)) in
        let _dest_0 := (st.(priv).(pcpu_stack) @ src_slot_nr).(sf_data) # dest_slot_ofs == _src_0 in
        let _dest_1 := (_dest_0 # (dest_slot_ofs + 8) == _src_1) in
        let _dest_2 := (_dest_1 # (dest_slot_ofs + 16) == _src_2) in
        Some (st.[priv].[pcpu_stack] :<
                (st.(priv).(pcpu_stack) # dest_slot_nr ==
                   ((st.(priv).(pcpu_stack) @ dest_slot_nr).[sf_data] :< _dest_2)))) else (
      if sz =? 40 then (
        (* sort_granules: granules[j] = granules[j - 1] *)
        (* data type: struct granule_set *)
        (* let _src_0 := (st.(priv).(pcpu_stack) @ src_slot_nr).(sf_data) @ src_slot_ofs in *)
        (* let _src_1 := (st.(priv).(pcpu_stack) @ src_slot_nr).(sf_data) @ (src_slot_ofs + 8) in *)
        (* let _src_2 := (st.(priv).(pcpu_stack) @ src_slot_nr).(sf_data) @ (src_slot_ofs + 16) in *)
        (* let _src_3 := (st.(priv).(pcpu_stack) @ src_slot_nr).(sf_data) @ (src_slot_ofs + 24) in *)
        (* let _src_4 := (st.(priv).(pcpu_stack) @ src_slot_nr).(sf_data) @ (src_slot_ofs + 32) in *)
        (* let _dest_0 := (st.(priv).(pcpu_stack) @ src_slot_nr).(sf_data) # dest_slot_ofs == _src_0 in *)
        (* let _dest_1 := (_dest_0 # (dest_slot_ofs + 8) == _src_1) in *)
        (* let _dest_2 := (_dest_1 # (dest_slot_ofs + 16) == _src_2) in *)
        (* let _dest_3 := (_dest_2 # (dest_slot_ofs + 16) == _src_3) in *)
        (* let _dest_4 := (_dest_3 # (dest_slot_ofs + 16) == _src_4) in *)
        (* Some (st.[priv].[pcpu_stack] :< *)
        (*         (st.(priv).(pcpu_stack) # dest_slot_nr == *)
        (*            ((st.(priv).(pcpu_stack) @ dest_slot_nr).[sf_data] :< _dest_4))) *) Some st)
      else None ))
    else None.
  Definition llvm_memset_p0i8_i64_spec (v_0: Ptr) (arg1: Z) (arg2: Z) (arg3: bool) (st: RData) : option RData := Some st.
  Definition memcpy_ns_read_spec (v_dest: Ptr) (v_src: Ptr) (v_conv: Z) (st: RData) : option (bool * RData) :=
    if v_dest.(pbase) =s "stack" then (
      let ofs := v_dest.(poffset) in
      if v_src.(pbase) =s "slot_ns" then
        let ofs := v_src.(poffset) in
        Some (true, st)
      else None
      )
    else None.

  Definition memcpy_ns_write_spec (v_dest: Ptr) (v_3: Ptr) (v_conv: Z) (st: RData) : option (bool * RData) := Some (true, st).
  Definition memset_spec (v_s: Ptr) (c: Z) (n: Z) (st: RData) : option (Ptr * RData) := Some (v_s, st).
  Definition memcpy_spec (v_dst: Ptr) (v_src: Ptr) (v_len: Z) (st: RData) : option (Ptr * RData) := Some (v_dst, st).
  (* xlat *)
  Definition xlat_unmap_memory_page_spec (v_table: Ptr) (v_va: Z) (st: RData) : option (Z * RData) :=
    let v_ptr := int_to_ptr v_va in
    match (v_ptr.(pbase), v_ptr.(poffset)) with
    | ("slot_rd", ofs) => Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RD == (-1))))
    | ("slot_rec", ofs) => Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC == (-1))))
    | ("slot_rec2", ofs) => Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC2 == (-1))))
    | ("slot_rtt", ofs) => Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RTT == (-1))))
    | ("slot_rtt2", ofs) => Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RTT2 == (-1))))
    | ("slot_rec_aux0", ofs) => Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC_AUX0 == (-1))))
    | ("slot_ns", ofs) => Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_NS == (-1))))
    | _ => None
    end.

  Definition xlat_map_memory_page_with_attrs_spec (v_table: Ptr) (v_va: Z) (v_pa: Z) (v_attrs: Z) (st: RData) : option (Z * RData) :=
    let v_ptr := int_to_ptr v_va in
    let gidx := v_pa / GRANULE_SIZE in
    let g := st.(share).(granules) @ gidx in
    match (v_ptr.(pbase), v_ptr.(poffset)) with
    | ("slot_ns", ofs) =>
        (* if g.(e_state) =? GRANULE_STATE_NS then *)
          Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_NS == gidx)))
        (* else None *)
    | ("slot_rd", ofs) =>
        (* if g.(e_state) =? GRANULE_STATE_RD then *)
          Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RD == gidx)))
        (* else None *)
    | ("slot_rec", ofs) =>
        (* if g.(e_state) =? GRANULE_STATE_REC then *)
          Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC == gidx)))
        (* else None *)
    | ("slot_rec2", ofs) =>
        (* if g.(e_state) =? GRANULE_STATE_REC then *)
          Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC2 == gidx)))
        (* else None *)
    | ("slot_target", ofs) =>
        (* if g.(e_state) =? GRANULE_STATE_REC then *)
          Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC_TARGET == gidx)))
        (* else None *)
    | ("slot_rec_aux0", ofs) =>
        (* if g.(e_state) =? GRANULE_STATE_REC_AUX then *)
          Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_REC_AUX0 == gidx)))
        (* else None *)
    | ("slot_rtt", ofs) =>
        (* if g.(e_state) =? GRANULE_STATE_RTT then *)
          Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RTT == gidx)))
        (* else None *)
    | ("slot_rtt2", ofs) =>
        (* if g.(e_state) =? GRANULE_STATE_RTT then *)
          Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RTT2 == gidx)))
        (* else None *)
    | ("slot_rsi_call", ofs) =>
        (* if g.(e_state) =? GRANULE_STATE_DATA then *)
          Some (0, (st.[share].[slots] :< (st.(share).(slots) # SLOT_RSI_CALL == gidx)))
        (* else None *)
    | _ => None
    end.

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
  Definition read_vttbr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_vttbr_el2), st).
  Definition write_vttbr_el2_spec (vttbr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_vttbr_el2] :< vttbr).

  Definition read_zcr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_zcr_el2), st).
  Definition write_zcr_el2_spec (zcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_zcr_el2] :< zcr).

  Definition read_elr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_elr_el2), st).
  Definition write_elr_el2_spec (elr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_elr_el2] :< elr).

  Definition read_cptr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_cptr_el2), st).
  Definition write_cptr_el2_spec (cptr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_cptr_el2] :< cptr).

  Definition isb_spec (st: RData) : option RData := Some st.

  Definition read_cnthctl_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_cnthctl_el2), st).
  Definition write_cnthctl_el2_spec (v: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_cnthctl_el2] :< v).

  Definition read_pmcr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmcr_el0), st).
  Definition write_pmcr_el0_spec (pmcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmcr_el0] :< pmcr).

  Definition read_mdcr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_mdcr_el2), st).
  Definition write_mdcr_el2_spec (v: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_mdcr_el2] :< v).

  Definition write_vpidr_el2_spec (v: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_vpidr_el2] :< v).

  Definition read_sctlr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_sctlr_el2), st).

  Definition read_midr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_midr_el1), st).

  Definition read_esr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_esr_el12), st).
  Definition write_esr_el12_spec (esr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_esr_el12] :< esr).

  Definition read_esr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_esr_el2), st).

  Definition read_spsr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_spsr_el2), st).
  Definition write_spsr_el2_spec (spsr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_spsr_el2] :< spsr).

  Definition read_spsr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_spsr_el12), st).
  Definition write_spsr_el12_spec (spsr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_spsr_el12] :< spsr).

  Definition read_elr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_elr_el12), st).
  Definition write_elr_el12_spec (elr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_elr_el12] :< elr).

  Definition read_vbar_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_vbar_el12), st).
  Definition write_vbar_el12_spec (vbar: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_vbar_el12] :< vbar).

  Definition read_hpfar_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_hpfar_el2), st).

  Definition read_far_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_far_el12), st).
  Definition write_far_el12_spec (far: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_far_el12] :< far).

  Definition read_far_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_far_el2), st).

  Definition read_isr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_isr_el1), st).

  Definition write_vsesr_el2_spec (vsesr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_vsesr_el2] :< vsesr).

  Definition write_hcr_el2_spec (hcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_hcr_el2] :< hcr).

  Definition read_id_aa64mmfr1_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_id_aa64mmfr1_el1), st).
  Definition read_id_aa64mmfr0_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_id_aa64mmfr0_el1), st).
  Definition read_id_aa64dfr0_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_id_aa64dfr0_el1), st).
  Definition read_id_aa64dfr1_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_id_aa64dfr1_el1), st).
  Definition read_id_aa64pfr0_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_id_aa64pfr0_el1), st).
  Definition read_id_aa64pfr1_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_id_aa64pfr1_el1), st).

  Definition monitor_call_spec (id: Z) (arg0: Z) (arg1: Z) (arg2: Z) (arg3: Z) (arg4: Z) (arg5: Z) (st: RData) : option (Z * RData) := Some (0, st).
  Definition monitor_call_with_res_spec (id: Z) (arg0: Z) (arg1: Z) (arg2: Z) (arg3: Z) (arg4: Z) (arg5: Z) (res: Ptr) (st: RData) : option RData := Some st.

  Definition run_realm_spec (regs: Ptr) (st: RData) : option (Z * RData) := Some (0, st).

  Definition read_pmevtyper0_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper0_el0), st).
  Definition read_pmevtyper1_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper1_el0), st).
  Definition read_pmevtyper2_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper2_el0), st).
  Definition read_pmevtyper3_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper3_el0), st).
  Definition read_pmevtyper4_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper4_el0), st).
  Definition read_pmevtyper5_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper5_el0), st).
  Definition read_pmevtyper6_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper6_el0), st).
  Definition read_pmevtyper7_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper7_el0), st).
  Definition read_pmevtyper8_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper8_el0), st).
  Definition read_pmevtyper9_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper9_el0), st).
  Definition read_pmevtyper10_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper10_el0), st).
  Definition read_pmevtyper11_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper11_el0), st).
  Definition read_pmevtyper12_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper12_el0), st).
  Definition read_pmevtyper13_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper13_el0), st).
  Definition read_pmevtyper14_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper14_el0), st).
  Definition read_pmevtyper15_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper15_el0), st).
  Definition read_pmevtyper16_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper16_el0), st).
  Definition read_pmevtyper17_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper17_el0), st).
  Definition read_pmevtyper18_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper18_el0), st).
  Definition read_pmevtyper19_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper19_el0), st).
  Definition read_pmevtyper20_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper20_el0), st).
  Definition read_pmevtyper21_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper21_el0), st).
  Definition read_pmevtyper22_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper22_el0), st).
  Definition read_pmevtyper23_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper23_el0), st).
  Definition read_pmevtyper24_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper24_el0), st).
  Definition read_pmevtyper25_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper25_el0), st).
  Definition read_pmevtyper26_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper26_el0), st).
  Definition read_pmevtyper27_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper27_el0), st).
  Definition read_pmevtyper28_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper28_el0), st).
  Definition read_pmevtyper29_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper29_el0), st).
  Definition read_pmevtyper30_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevtyper30_el0), st).

  Definition read_pmevcntr0_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr0_el0), st).
  Definition read_pmevcntr1_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr1_el0), st).
  Definition read_pmevcntr2_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr2_el0), st).
  Definition read_pmevcntr3_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr3_el0), st).
  Definition read_pmevcntr4_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr4_el0), st).
  Definition read_pmevcntr5_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr5_el0), st).
  Definition read_pmevcntr6_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr6_el0), st).
  Definition read_pmevcntr7_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr7_el0), st).
  Definition read_pmevcntr8_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr8_el0), st).
  Definition read_pmevcntr9_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr9_el0), st).
  Definition read_pmevcntr10_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr10_el0), st).
  Definition read_pmevcntr11_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr11_el0), st).
  Definition read_pmevcntr12_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr12_el0), st).
  Definition read_pmevcntr13_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr13_el0), st).
  Definition read_pmevcntr14_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr14_el0), st).
  Definition read_pmevcntr15_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr15_el0), st).
  Definition read_pmevcntr16_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr16_el0), st).
  Definition read_pmevcntr17_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr17_el0), st).
  Definition read_pmevcntr18_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr18_el0), st).
  Definition read_pmevcntr19_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr19_el0), st).
  Definition read_pmevcntr20_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr20_el0), st).
  Definition read_pmevcntr21_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr21_el0), st).
  Definition read_pmevcntr22_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr22_el0), st).
  Definition read_pmevcntr23_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr23_el0), st).
  Definition read_pmevcntr24_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr24_el0), st).
  Definition read_pmevcntr25_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr25_el0), st).
  Definition read_pmevcntr26_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr26_el0), st).
  Definition read_pmevcntr27_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr27_el0), st).
  Definition read_pmevcntr28_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr28_el0), st).
  Definition read_pmevcntr29_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr29_el0), st).
  Definition read_pmevcntr30_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmevcntr30_el0), st).

  Definition read_pmccfiltr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmccfiltr_el0), st).
  Definition write_pmccfiltr_el0_spec (pmccfiltr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmccfiltr_el0] :< pmccfiltr).

  Definition read_pmccntr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmccntr_el0), st).
  Definition write_pmccntr_el0_spec (pmccntr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmccntr_el0] :< pmccntr).

  Definition read_pmcntenset_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmcntenset_el0), st).
  Definition write_pmcntenset_el0_spec (pmcntenset: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmcntenset_el0] :< pmcntenset).

  Definition read_pmcntenclr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmcntenclr_el0), st).
  Definition write_pmcntenclr_el0_spec (pmcntenclr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmcntenclr_el0] :< pmcntenclr).

  Definition read_amair_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_amair_el12), st).
  Definition write_amair_el12_spec (amair: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_amair_el12] :< amair).

  Definition read_cntkctl_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_cntkctl_el12), st).
  Definition write_cntkctl_el12_spec (cntkctl: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_cntkctl_el12] :< cntkctl).

  Definition read_cntp_ctl_el02_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_cntp_ctl_el02), st).
  Definition write_cntp_ctl_el02_spec (cntp_ctl: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_cntp_ctl_el02] :< cntp_ctl).

  Definition read_cntp_cval_el02_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_cntp_cval_el02), st).
  Definition write_cntp_cval_el02_spec (cntp_cval: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_cntp_cval_el02] :< cntp_cval).

  Definition read_cntpoff_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_cntpoff_el2), st).
  Definition write_cntpoff_el2_spec (cntpoff: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_cntpoff_el2] :< cntpoff).

  Definition read_cntv_ctl_el02_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_cntv_ctl_el02), st).
  Definition write_cntv_ctl_el02_spec (cntv_ctl: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_cntv_ctl_el02] :< cntv_ctl).

  Definition read_cntv_cval_el02_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_cntv_cval_el02), st).
  Definition write_cntv_cval_el02_spec (cntv_cval: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_cntv_cval_el02] :< cntv_cval).

  Definition read_cntvoff_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_cntvoff_el2), st).
  Definition write_cntvoff_el2_spec (cntvoff: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_cntvoff_el2] :< cntvoff).

  Definition read_contextidr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_contextidr_el12), st).
  Definition write_contextidr_el12_spec (contextidr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_contextidr_el12] :< contextidr).

  Definition read_disr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_disr_el1), st).
  Definition write_disr_el1_spec (disr: Z) (st: RData) : option RData := None.

  Definition read_ich_hcr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_ich_hcr_el2), st).
  Definition write_ich_hcr_el2_spec (ich_hcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_ich_hcr_el2] :< ich_hcr).

  Definition read_ich_lr15_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_ich_lr15_el2), st).
  Definition read_ich_misr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_ich_misr_el2), st).
  Definition read_ich_vmcr_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_ich_vmcr_el2), st).

  Definition read_mair_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_mair_el12), st).
  Definition write_mair_el12_spec (mair: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_mair_el12] :< mair).

  Definition read_mdccint_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_mdccint_el1), st).
  Definition write_mdccint_el1_spec (mdccint: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_mdccint_el1] :< mdccint).

  Definition read_mdscr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_mdscr_el1), st).
  Definition write_mdscr_el1_spec (mdscr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_mdscr_el1] :< mdscr).

  Definition read_par_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_par_el1), st).
  Definition write_par_el1_spec (par: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_par_el1] :< par).

  Definition read_pmintenclr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmintenclr_el1), st).
  Definition write_pmintenclr_el1_spec (pmintenclr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmintenclr_el1] :< pmintenclr).

  Definition read_pmintenset_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmintenset_el1), st).
  Definition write_pmintenset_el1_spec (pmintenset: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmintenset_el1] :< pmintenset).

  Definition read_pmovsclr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmovsclr_el0), st).
  Definition write_pmovsclr_el0_spec (pmovsclr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmovsclr_el0] :< pmovsclr).

  Definition read_pmovsset_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmovsset_el0), st).
  Definition write_pmovsset_el0_spec (pmovsset: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmovsset_el0] :< pmovsset).

  Definition read_pmselr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmselr_el0), st).
  Definition write_pmselr_el0_spec (pmselr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmselr_el0] :< pmselr).

  Definition write_vmpidr_el2_spec (vmpidr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_vmpidr_el2] :< vmpidr).

  Definition read_pmuserenr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmuserenr_el0), st).
  Definition write_pmuserenr_el0_spec (pmuserenr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmuserenr_el0] :< pmuserenr).

  Definition read_pmxevcntr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmxevcntr_el0), st).
  Definition write_pmxevcntr_el0_spec (pmxevcntr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmxevcntr_el0] :< pmxevcntr).

  Definition read_pmxevtyper_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_pmxevtyper_el0), st).
  Definition write_pmxevtyper_el0_spec (pmxevtyper: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmxevtyper_el0] :< pmxevtyper).

  Definition read_tpidr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_tpidr_el1), st).
  Definition write_tpidr_el1_spec (tpidr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_tpidr_el1] :< tpidr).

  Definition read_afsr1_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_afsr1_el12), st).
  Definition write_afsr1_el12_spec (afsr1: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_afsr1_el12] :< afsr1).

  Definition read_afsr0_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_afsr0_el12), st).
  Definition write_afsr0_el12_spec (afsr0: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_afsr0_el12] :< afsr0).

  Definition read_tcr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_tcr_el12), st).
  Definition write_tcr_el12_spec (tcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_tcr_el12] :< tcr).

  Definition read_ttbr1_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_ttbr1_el12), st).
  Definition write_ttbr1_el12_spec (ttbr1: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_ttbr1_el12] :< ttbr1).

  Definition read_ttbr0_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_ttbr0_el12), st).
  Definition write_ttbr0_el12_spec (ttbr0: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_ttbr0_el12] :< ttbr0).

  Definition read_cpacr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_cpacr_el12), st).
  Definition write_cpacr_el12_spec (cpacr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_cpacr_el12] :< cpacr).

  Definition read_sctlr_el12_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_sctlr_el12), st).
  Definition write_sctlr_el12_spec (sctlr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_sctlr_el12] :< sctlr).

  Definition read_csselr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_csselr_el1), st).
  Definition write_csselr_el1_spec (csselr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_csselr_el1] :< csselr).

  Definition read_actlr_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_actlr_el1), st).
  Definition write_actlr_el1_spec (actlr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_actlr_el1] :< actlr).

  Definition read_sp_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_sp_el1), st).
  Definition write_sp_el1_spec (sp: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_sp_el1] :< sp).

  Definition read_tpidr_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_tpidr_el0), st).
  Definition write_tpidr_el0_spec (tpidr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_tpidr_el0] :< tpidr).

  Definition read_tpidrro_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_tpidrro_el0), st).
  Definition write_tpidrro_el0_spec (tpidrro: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_tpidrro_el0] :< tpidrro).

  Definition read_sp_el0_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_sp_el0), st).
  Definition write_sp_el0_spec (sp: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_sp_el0] :< sp).

  Definition write_pmevcntr0_el0_spec (pmevcntr0: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr0_el0] :< pmevcntr0).
  Definition write_pmevcntr1_el0_spec (pmevcntr1: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr1_el0] :< pmevcntr1).
  Definition write_pmevcntr2_el0_spec (pmevcntr2: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr2_el0] :< pmevcntr2).
  Definition write_pmevcntr3_el0_spec (pmevcntr3: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr3_el0] :< pmevcntr3).
  Definition write_pmevcntr4_el0_spec (pmevcntr4: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr4_el0] :< pmevcntr4).
  Definition write_pmevcntr5_el0_spec (pmevcntr5: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr5_el0] :< pmevcntr5).
  Definition write_pmevcntr6_el0_spec (pmevcntr6: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr6_el0] :< pmevcntr6).
  Definition write_pmevcntr7_el0_spec (pmevcntr7: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr7_el0] :< pmevcntr7).
  Definition write_pmevcntr8_el0_spec (pmevcntr8: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr8_el0] :< pmevcntr8).
  Definition write_pmevcntr9_el0_spec (pmevcntr9: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr9_el0] :< pmevcntr9).
  Definition write_pmevcntr10_el0_spec (pmevcntr10: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr10_el0] :< pmevcntr10).
  Definition write_pmevcntr11_el0_spec (pmevcntr11: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr11_el0] :< pmevcntr11).
  Definition write_pmevcntr12_el0_spec (pmevcntr12: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr12_el0] :< pmevcntr12).
  Definition write_pmevcntr13_el0_spec (pmevcntr13: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr13_el0] :< pmevcntr13).
  Definition write_pmevcntr14_el0_spec (pmevcntr14: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr14_el0] :< pmevcntr14).
  Definition write_pmevcntr15_el0_spec (pmevcntr15: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr15_el0] :< pmevcntr15).
  Definition write_pmevcntr16_el0_spec (pmevcntr16: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr16_el0] :< pmevcntr16).
  Definition write_pmevcntr17_el0_spec (pmevcntr17: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr17_el0] :< pmevcntr17).
  Definition write_pmevcntr18_el0_spec (pmevcntr18: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr18_el0] :< pmevcntr18).
  Definition write_pmevcntr19_el0_spec (pmevcntr19: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr19_el0] :< pmevcntr19).
  Definition write_pmevcntr20_el0_spec (pmevcntr20: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr20_el0] :< pmevcntr20).
  Definition write_pmevcntr21_el0_spec (pmevcntr21: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr21_el0] :< pmevcntr21).
  Definition write_pmevcntr22_el0_spec (pmevcntr22: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr22_el0] :< pmevcntr22).
  Definition write_pmevcntr23_el0_spec (pmevcntr23: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr23_el0] :< pmevcntr23).
  Definition write_pmevcntr24_el0_spec (pmevcntr24: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr24_el0] :< pmevcntr24).
  Definition write_pmevcntr25_el0_spec (pmevcntr25: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr25_el0] :< pmevcntr25).
  Definition write_pmevcntr26_el0_spec (pmevcntr26: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr26_el0] :< pmevcntr26).
  Definition write_pmevcntr27_el0_spec (pmevcntr27: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr27_el0] :< pmevcntr27).
  Definition write_pmevcntr28_el0_spec (pmevcntr28: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr28_el0] :< pmevcntr28).
  Definition write_pmevcntr29_el0_spec (pmevcntr29: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr29_el0] :< pmevcntr29).
  Definition write_pmevcntr30_el0_spec (pmevcntr30: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevcntr30_el0] :< pmevcntr30).

  Definition write_pmevtyper0_el0_spec (pmevtyper0: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper0_el0] :< pmevtyper0).
  Definition write_pmevtyper1_el0_spec (pmevtyper1: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper1_el0] :< pmevtyper1).
  Definition write_pmevtyper2_el0_spec (pmevtyper2: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper2_el0] :< pmevtyper2).
  Definition write_pmevtyper3_el0_spec (pmevtyper3: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper3_el0] :< pmevtyper3).
  Definition write_pmevtyper4_el0_spec (pmevtyper4: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper4_el0] :< pmevtyper4).
  Definition write_pmevtyper5_el0_spec (pmevtyper5: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper5_el0] :< pmevtyper5).
  Definition write_pmevtyper6_el0_spec (pmevtyper6: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper6_el0] :< pmevtyper6).
  Definition write_pmevtyper7_el0_spec (pmevtyper7: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper7_el0] :< pmevtyper7).
  Definition write_pmevtyper8_el0_spec (pmevtyper8: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper8_el0] :< pmevtyper8).
  Definition write_pmevtyper9_el0_spec (pmevtyper9: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper9_el0] :< pmevtyper9).
  Definition write_pmevtyper10_el0_spec (pmevtyper10: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper10_el0] :< pmevtyper10).
  Definition write_pmevtyper11_el0_spec (pmevtyper11: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper11_el0] :< pmevtyper11).
  Definition write_pmevtyper12_el0_spec (pmevtyper12: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper12_el0] :< pmevtyper12).
  Definition write_pmevtyper13_el0_spec (pmevtyper13: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper13_el0] :< pmevtyper13).
  Definition write_pmevtyper14_el0_spec (pmevtyper14: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper14_el0] :< pmevtyper14).
  Definition write_pmevtyper15_el0_spec (pmevtyper15: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper15_el0] :< pmevtyper15).
  Definition write_pmevtyper16_el0_spec (pmevtyper16: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper16_el0] :< pmevtyper16).
  Definition write_pmevtyper17_el0_spec (pmevtyper17: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper17_el0] :< pmevtyper17).
  Definition write_pmevtyper18_el0_spec (pmevtyper18: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper18_el0] :< pmevtyper18).
  Definition write_pmevtyper19_el0_spec (pmevtyper19: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper19_el0] :< pmevtyper19).
  Definition write_pmevtyper20_el0_spec (pmevtyper20: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper20_el0] :< pmevtyper20).
  Definition write_pmevtyper21_el0_spec (pmevtyper21: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper21_el0] :< pmevtyper21).
  Definition write_pmevtyper22_el0_spec (pmevtyper22: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper22_el0] :< pmevtyper22).
  Definition write_pmevtyper23_el0_spec (pmevtyper23: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper23_el0] :< pmevtyper23).
  Definition write_pmevtyper24_el0_spec (pmevtyper24: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper24_el0] :< pmevtyper24).
  Definition write_pmevtyper25_el0_spec (pmevtyper25: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper25_el0] :< pmevtyper25).
  Definition write_pmevtyper26_el0_spec (pmevtyper26: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper26_el0] :< pmevtyper26).
  Definition write_pmevtyper27_el0_spec (pmevtyper27: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper27_el0] :< pmevtyper27).
  Definition write_pmevtyper28_el0_spec (pmevtyper28: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper28_el0] :< pmevtyper28).
  Definition write_pmevtyper29_el0_spec (pmevtyper29: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper29_el0] :< pmevtyper29).
  Definition write_pmevtyper30_el0_spec (pmevtyper30: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_pmevtyper30_el0] :< pmevtyper30).

  Definition read_icc_sre_el2_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_icc_sre_el2), st).
  Definition write_icc_sre_el2_spec (v: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_icc_sre_el2] :< v).

  Definition read_icc_hppir1_el1_spec (st: RData) : option (Z * RData) := Some (st.(priv).(pcpu_icc_hppir1_el1), st).

  Definition write_ich_vmcr_el2_spec (ich_vmcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_ich_vmcr_el2] :< ich_vmcr).

  Definition write_vtcr_el2_spec (vtcr: Z) (st: RData) : option RData := Some (st.[priv].[pcpu_vtcr_el2] :< vtcr).
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
  Definition get_rpv_spec (v_rd: Ptr) (v_claim: Ptr) (st: RData) : (option RData) := Some st.
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
  Definition find_lock_rd_granules_spec (v_rd_addr: Z) (v_g_rd: Ptr) (v_4: Z) (v_5: Z) (v_g_rtt_base: Ptr) (st: RData) : option (bool * RData) := Some (true, st).
  Definition __table_maps_block_spec (v_table: Ptr) (v_level: Z) (v_s2tte_is_x: Ptr) (st: RData) : option (bool * RData) := Some (true, st).
  Definition __table_is_uniform_block_spec (v_table: Ptr) (v_level: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : option (bool * RData) := Some (true, st).
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
      "status_ptr" ::
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
      "ptr_status" ::
      "ptr_is_err" ::
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
  Hint InitRely ptr_status (v_ptr.(pbase) = "status" \/ v_ptr.(pbase) = "NULL").
  Hint InitRely ptr_is_err (v_ptr.(pbase) = "status" \/ v_ptr.(pbase) = "NULL").
  Hint InitRely requested_ipa_bits (v_p.(pbase) = "stack").
  (* Hint InitRely psci_reset_rec (v_rec.(pbase) = "slot_rec" /\ (v_rec.(poffset) = 280 \/ v_rec.(poffset) = 352)). *)
  (* Hint InitRely rec_is_simd_allowed (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 1120). *)
  (* Hint InitRely rec_simd_type (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 920). *)
  (* Hint InitRely rec_ipa_size (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 880). *)
  (* Hint InitRely get_sysreg_write_value (v_rec.(pbase) = "slot_rec" /\ (v_rec.(poffset) >= 24 /\ v_rec.(poffset) < 272)). *)
  (* Hint NoUnfold rec_field_accessible. *)
  (* Hint NoUnfold rd_field_accessible. *)
  Hint InitRely psci_reset_rec (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).
  Hint InitRely rec_is_simd_allowed (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).
  Hint InitRely rec_simd_type (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).
  Hint InitRely rec_ipa_size (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).
  Hint InitRely get_sysreg_write_value (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).

  Hint InitRely rec_is_simd_allowed (rec_is_unlocked st).
  Hint InitRely rec_is_simd_allowed (rec_refcount_one st).

  Hint InitRely rec_simd_type (rec_is_unlocked st).
  Hint InitRely rec_simd_type (rec_refcount_one st).
  (* Generated specs copied here to save time *)
  Include "./HelpersSpec.v".
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
  Hint InitRely inject_serror (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).
  Hint InitRely inject_sync_idabort_rec (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0).
  Hint InitRely inject_sync_idabort_rec (rec_is_unlocked st).
  Hint InitRely inject_sync_idabort_rec (rec_refcount_one st).
  (* Hint NoUnfold int_to_ptr. *)
  Include "./InjectAbortSpec.v".
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

  Include "./CheckFeatureSpec.v".
End CheckFeature.

  (* Callsite of Measurement functions, tmp put into TCB *)
(* Section Measurement. *)
(*   Definition LAYER_DATA := RData. *)
(*   Definition LAYER_CODE : string := "./rmm.json". *)
(*   Definition LAYER_LOAD : string := "load_RData". *)
(*   Definition LAYER_STORE : string := "store_RData". *)
(*   Definition LAYER_ALLOC : string := "alloc_stack". *)
(*   Definition LAYER_FREE : string := "free_stack". *)
(*   Definition LAYER_PTR2INT : string := "ptr_to_int". *)
(*   Definition LAYER_INT2PTR : string := "int_to_ptr". *)
(*   Definition LAYER_PTR_EQB : string := "ptr_eqb". *)
(*   Definition LAYER_PTR_GTB : string := "ptr_gtb". *)
(*   Definition LAYER_PTR_LTB : string := "ptr_ltb". *)
(*   Definition LAYER_PRIMS : list string := *)
(*     "ripas_granule_measure" :: *)
(*       "data_granule_measure" :: *)
(*       "rec_params_measure" :: *)
(*       "realm_params_measure" :: *)
(*       nil. *)
(* End Measurement. *)

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

  Hint InitRely rec_save_state (rec_aux_is_unlocked st).
  Hint InitRely rec_save_state (rec_aux_refcount_one st).
  Hint InitRely rec_restore_state (rec_aux_is_unlocked st).
  Hint InitRely rec_restore_state (rec_aux_refcount_one st).

  Include "./SIMDStateSpec.v".
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
  Hint InitRely rec_simd_enable_restore (rec_is_unlocked st).
  Hint InitRely rec_simd_enable_restore (rec_refcount_one st).
  Hint InitRely rec_simd_enable_restore (rec_aux_is_unlocked st).
  Hint InitRely rec_simd_enable_restore (rec_aux_refcount_one st).
  Include "./SIMDSpec.v".
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
  Hint InitRely get_rd_state_locked (v_rd.(pbase) = "slot_rec" /\ v_rd.(poffset) = 0).
  Hint InitRely get_rd_state_unlocked (v_rd.(pbase) = "slot_rec" /\ v_rd.(poffset) = 0).
  Hint InitRely set_rd_state (v_rd.(pbase) = "slot_rec" /\ v_rd.(poffset) = 0).
  Hint InitRely get_rd_rec_count_locked (v_rd.(pbase) = "slot_rec" /\ v_rd.(poffset) = 0).
  Hint InitRely get_rd_rec_count_unlocked (v_rd.(pbase) = "slot_rec" /\ v_rd.(poffset) = 0).
  Hint InitRely set_rd_rec_count (v_rd.(pbase) = "slot_rec" /\ v_rd.(poffset) = 0).

  Include "./RDStateSpec.v".
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
      (* "plat_granule_addr_to_idx" :: *)
      (* "__granule_assert_unlocked_invariants" :: *)
      nil.

  Hint InitRely atomic_granule_put_release (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely atomic_granule_put (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely atomic_granule_get (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely granule_get_state (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely granule_refcount_read_acquire (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely granule_set_state (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Include "./GranuleStateSpec.v".
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

  Hint InitRely granule_lock_on_state_match (v_g.(pbase) = "granules" /\ (v_g.(poffset) mod ST_GRANULE_SIZE) = 0).
  Hint InitRely sort_granules (v_granules.(pbase) = "LockGranules_stack").

  Include "./FindGranuleSpec.v".
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

  Include "./GranuleLockSpec.v".
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
      (* "plat_granule_idx_to_addr" :: *)
      "slot_to_va" ::
      "granule_unlock_transition" ::
      "find_lock_granules" ::
      (* Problems, moved to Bottom *)
      (* "find_lock_rd_granules" :: *)
      nil.
  Definition find_lock_granules_loop197_rank (v_granules: Ptr) (v_i_241: Z) : Z :=
    2 - v_i_241.
  Definition find_lock_granules_loop0_rank (v_granules: Ptr) (v_i_143: Z) : Z :=
    2 - v_i_143.
  Hint InitRely find_lock_granules (v_granules.(pbase) = "LockGranules_stack").
  Hint NoUnfold find_lock_granules_loop0.
  Hint NoUnfold find_lock_granules_loop197.
  Hint NoTrans find_lock_granules_spec_mid.
  Hint NoUnfold find_lock_granules_spec_mid.
  Hint NoTrans find_lock_granules_loop197.
  Hint NoTrans find_lock_granules_loop0.
  Hint NoTrans find_lock_granules_loop197_mid.
  Hint NoTrans find_lock_granules_loop0_mid.

  Include "./GranuleInfoSpec.v".
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
  (* XXX: Ptr of Ptr *)
  (* Hint NoUnfold find_lock_granules. *)
  Hint NoTrans find_lock_two_granules_spec_mid.
  Hint NoUnfold find_lock_granules_spec.
  (* Hint InitRely find_lock_unused_granule (int_to_ptr (-1) = (mkPtr "status" 1)). *)
  Include "./LockGranulesSpec.v".
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
      "get_slot_buf_xlat_ctx" ::
      nil.
  (* XXX: manual modification needed to avoid non-exhausitive pattern matching. *)
  Hint InitRely buffer_unmap_internal ((v_buf.(pbase) =s "granules") = false).
  Hint InitRely buffer_unmap_internal ((v_buf.(pbase) =s "status") = false).
  Hint InitRely buffer_unmap_internal (v_buf.(poffset) = 0).
  Hint InitRely buffer_unmap_internal ((SLOT_VIRT - GRANULES_BASE) < 0).
  Hint InitRely buffer_unmap_internal ((SLOT_VIRT + GRANULE_SIZE - GRANULES_BASE) < 0).
  Hint InitRely buffer_unmap_internal ((SLOT_VIRT + 2 * GRANULE_SIZE - GRANULES_BASE) < 0).
  Hint InitRely buffer_unmap_internal ((SLOT_VIRT + 3 * GRANULE_SIZE - GRANULES_BASE) < 0).
  Hint InitRely buffer_unmap_internal ((SLOT_VIRT + 4 * GRANULE_SIZE - GRANULES_BASE) < 0).
  Hint InitRely buffer_unmap_internal ((SLOT_VIRT + 5 * GRANULE_SIZE - GRANULES_BASE) < 0).
  Hint InitRely buffer_unmap_internal ((SLOT_VIRT + 6 * GRANULE_SIZE - GRANULES_BASE) < 0).
  Hint InitRely buffer_unmap_internal ((SLOT_VIRT + 22 * GRANULE_SIZE - GRANULES_BASE) < 0).
  Hint InitRely buffer_unmap_internal ((SLOT_VIRT + 23 * GRANULE_SIZE - GRANULES_BASE) < 0).
  Hint InitRely buffer_unmap_internal ((SLOT_VIRT + 24 * GRANULE_SIZE - GRANULES_BASE) < 0).

  Hint InitRely buffer_map_internal (SLOT_VIRT < GRANULES_BASE).
  Hint InitRely buffer_map_internal (v_slot >= 0).
  Hint InitRely buffer_map_internal (v_slot <= 24).
  Hint InitRely granule_addr (v_g.(pbase) = "granules").
  Hint InitRely granule_addr ((v_g.(poffset) mod ST_GRANULE_SIZE) = 0).

  Include "MmapInternalSpec.v".
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

  Include "MmapSpec.v".
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
  Hint NoTrans granule_memzero_spec_mid.
  Hint NoTrans granule_memzero_mapped_spec_mid.
  Include "./MemRWSpec.v".
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
  Hint InitRely __table_get_entry (SLOT_VIRT + SLOT_RTT * GRANULE_SIZE - GRANULES_BASE < 0).
  Include "./S2TTEDescSpec.v".
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
      "table_entry_to_phys" ::
      "addr_is_level_aligned" ::
      nil.
  Include "./S2TTEStateSpec.v".
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

   Include "./S2TTEPASpec.v".
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

  (* stack variable *)
  Hint InitRely update_ripas (v_s2tte.(pbase) = "smc_rtt_set_ripas_stack").
  (* Hint InitRely update_ripas (v_s2tte.(poffset) = 56). *)

  Hint InitRely s2_walk_result_match_ripas (v_res.(pbase) = "handle_rsi_realm_config_stack" \/
                                              v_res.(pbase) = "do_host_call_stack" \/
                                              v_res.(pbase) = "attest_token_continue_write_state_stack").

  Include "./S2TTEOpsSpec.v".
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

  Include "./RealmInfoSpec.v".

  Definition realm_vtcr_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret == realm_vtcr_spec' v_rd st;
    Some (ret, st).
  Hint NoUnfold realm_vtcr_spec'.
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

  Hint InitRely init_rec_sysregs (v_rec.(pbase) = "slot_rec").
  Hint InitRely init_rec_sysregs (v_rec.(poffset) = 0).
  Hint InitRely init_rec_sysregs (rec_is_locked st).

  Hint InitRely init_common_sysregs (v_rec.(pbase) = "slot_rec").
  Hint InitRely init_common_sysregs (v_rec.(poffset) = 0).
  Hint InitRely init_common_sysregs (v_rd.(pbase) = "slot_rd").
  Hint InitRely init_common_sysregs (v_rd.(poffset) = 0).
  Hint InitRely init_common_sysregs (rec_is_locked st).
  Hint InitRely init_common_sysregs (rd_is_locked st).

  (* Include "./InitRegsSpec.v". *)
End InitRegs.

(* Section InitRec. *)
(*   Definition LAYER_DATA := RData. *)
(*   Definition LAYER_CODE : string := "./rmm.json". *)
(*   Definition LAYER_LOAD : string := "load_RData". *)
(*   Definition LAYER_STORE : string := "store_RData". *)
(*   Definition LAYER_PTR2INT : string := "ptr_to_int". *)
(*   Definition LAYER_INT2PTR : string := "int_to_ptr". *)
(*   Definition LAYER_PTR_EQB : string := "ptr_eqb". *)
(*   Definition LAYER_PTR_GTB : string := "ptr_gtb". *)
(*   Definition LAYER_PTR_LTB : string := "ptr_ltb". *)
(*   Definition LAYER_PRIMS: list string := *)
(*     "gic_cpu_state_init" :: *)
(*       "init_rec_regs" :: *)
(*       "free_rec_aux_granules" :: *)
(*       nil. *)
(*   (* Need fill in: *) *)
(*   Definition free_rec_aux_granules_loop176_rank (v_indvars_iv: Z) (v_rec_aux: Ptr) (v_scrub: bool) (v_wide_trip_count: Z) : Z := *)
(*     0. *)

(*   Hint InitRely gic_cpu_state_init (v_gicstate.(pbase) = "slot_rec"). *)
(*   Hint InitRely gic_cpu_state_init (v_gicstate.(poffset) = 584). *)
(*   Hint InitRely gic_cpu_state_init (rec_is_locked st). *)
(*   Hint InitRely init_rec_regs (v_rec.(pbase) = "slot_rec"). *)
(*   Hint InitRely init_rec_regs (v_rec.(poffset) = 0). *)
(*   Hint InitRely init_rec_regs (rec_is_locked st). *)
(*   Hint InitRely init_rec_regs (v_rec_params.(pbase) = "smc_rec_create_stack"). *)
(*   Hint InitRely init_rec_regs (v_rd.(pbase) = "slot_rd"). *)
(*   Hint InitRely init_rec_regs (rd_is_locked st). *)
(*   Hint InitRely init_rec_regs (v_rd.(poffset) = 0). *)

(*   Hint NoTrans free_rec_aux_granules_spec_mid. *)
(*   Hint NoTrans free_rec_aux_granules_loop176_mid. *)
(*   Hint NoUnfold free_rec_aux_granules_spec. *)
(*   Hint NoUnfold free_rec_aux_granules_spec_mid. *)
(*   (* Include "./InitRecSpec.v". *) *)
(* End InitRec. *)

(* Section ValidateAddr. *)
(*   Definition LAYER_DATA := RData. *)
(*   Definition LAYER_CODE : string := "./rmm.json". *)
(*   Definition LAYER_LOAD : string := "load_RData". *)
(*   Definition LAYER_STORE : string := "store_RData". *)
(*   Definition LAYER_PTR2INT : string := "ptr_to_int". *)
(*   Definition LAYER_INT2PTR : string := "int_to_ptr". *)
(*   Definition LAYER_PTR_EQB : string := "ptr_eqb". *)
(*   Definition LAYER_PTR_GTB : string := "ptr_gtb". *)
(*   Definition LAYER_PTR_LTB : string := "ptr_ltb". *)
(*   Definition LAYER_PRIMS: list string := *)
(*     "validate_map_addr" :: *)
(*       "addr_in_par" :: *)
(*       nil. *)
(*   Hint InitRely validate_map_addr (v_rd.(pbase) = "slot_rd"). *)
(*   Hint InitRely validate_map_addr (v_rd.(poffset) = 0). *)
(*   Hint InitRely validate_map_addr (rd_is_locked st). *)
(*   Hint InitRely addr_in_par (v_rd.(pbase) = "slot_rd"). *)
(*   Hint InitRely addr_in_par (v_rd.(poffset) = 0). *)
(*   Hint InitRely addr_in_par (rd_is_locked st). *)
(*   (* Include "./ValidateAddrSpec.v". *) *)
(* End ValidateAddr. *)

(* Section ValidateTable. *)
(*   Definition LAYER_DATA := RData. *)
(*   Definition LAYER_CODE : string := "./rmm.json". *)
(*   Definition LAYER_LOAD : string := "load_RData". *)
(*   Definition LAYER_STORE : string := "store_RData". *)
(*   Definition LAYER_PTR2INT : string := "ptr_to_int". *)
(*   Definition LAYER_INT2PTR : string := "int_to_ptr". *)
(*   Definition LAYER_PTR_EQB : string := "ptr_eqb". *)
(*   Definition LAYER_PTR_GTB : string := "ptr_gtb". *)
(*   Definition LAYER_PTR_LTB : string := "ptr_ltb". *)
(*   Definition LAYER_PRIMS: list string := *)
(*     "validate_data_create_unknown" :: *)
(*       "validate_rtt_entry_cmds" :: *)
(*       "validate_rtt_map_cmds" :: *)
(*       "validate_rtt_structure_cmds" :: *)
(*       "s2tte_create_valid_ns" :: *)
(*       nil. *)
(*   Hint InitRely validate_data_create_unknown (v_rd.(pbase) = "slot_rd"). *)
(*   Hint InitRely validate_data_create_unknown (v_rd.(poffset) = 0). *)

(*   Hint InitRely validate_rtt_entry_cmds (v_rd.(pbase) = "slot_rd"). *)
(*   Hint InitRely validate_rtt_entry_cmds (v_rd.(poffset) = 0). *)

(*   Hint InitRely validate_rtt_map_cmds (v_rd.(pbase) = "slot_rd"). *)
(*   Hint InitRely validate_rtt_map_cmds (v_rd.(poffset) = 0). *)

(*   Hint InitRely validate_rtt_structure_cmds (v_rd.(pbase) = "slot_rd"). *)
(*   Hint InitRely validate_rtt_structure_cmds (v_rd.(poffset) = 0). *)
(*   (* Include "ValidateTableSpec.v". *) *)
(* End ValidateTable. *)

(* Section TableAux. *)
(*   Definition LAYER_DATA := RData. *)
(*   Definition LAYER_CODE : string := "./rmm.json". *)
(*   Definition LAYER_LOAD : string := "load_RData". *)
(*   Definition LAYER_STORE : string := "store_RData". *)
(*   Definition LAYER_ALLOC : string := "alloc_stack". *)
(*   Definition LAYER_FREE : string := "free_stack". *)
(*   Definition LAYER_PTR2INT : string := "ptr_to_int". *)
(*   Definition LAYER_INT2PTR : string := "int_to_ptr". *)
(*   Definition LAYER_PTR_EQB : string := "ptr_eqb". *)
(*   Definition LAYER_PTR_GTB : string := "ptr_gtb". *)
(*   Definition LAYER_PTR_LTB : string := "ptr_ltb". *)
(*   Definition LAYER_PRIMS: list string := *)
(*     "__find_lock_next_level" :: *)
(*       "validate_data_create" :: *)
(*       nil. *)
(* End TableAux. *)

(* Section TableWalk. *)
(*   Definition LAYER_DATA := RData. *)
(*   Definition LAYER_CODE : string := "./rmm.json". *)
(*   Definition LAYER_LOAD : string := "load_RData". *)
(*   Definition LAYER_STORE : string := "store_RData". *)
(*   Definition LAYER_ALLOC : string := "alloc_stack". *)
(*   Definition LAYER_FREE : string := "free_stack". *)
(*   Definition LAYER_PTR2INT : string := "ptr_to_int". *)
(*   Definition LAYER_INT2PTR : string := "int_to_ptr". *)
(*   Definition LAYER_PTR_EQB : string := "ptr_eqb". *)
(*   Definition LAYER_PTR_GTB : string := "ptr_gtb". *)
(*   Definition LAYER_PTR_LTB : string := "ptr_ltb". *)
(*   Definition LAYER_PRIMS: list string := *)
(*     "rtt_walk_lock_unlock" :: *)
(*       nil. *)
(*   (* Need fill in: *) *)
(*   Definition rtt_walk_lock_unlock_loop370_rank (v_g_tbls: Ptr) (v_indvars_iv: Z) (v_level: Z) (v_map_addr: Z) (v_wi: Ptr) : Z := *)
(*     0. *)
(* End TableWalk. *)
