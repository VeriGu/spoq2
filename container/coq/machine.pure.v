  (* PHYSICAL MEMORY under N1SDP                 *)
  (* ┌─────────┐                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* ├─────────┤ 0x0000000004000000              *)
  (* │simple   │                                 *)
  (* │GLOBALS  │ page-aligned gloabl object      *)
  (* │         │ several (ideal, may be moved to RMM .data) *)
  (* ├─────────┤                                 *)
  (* │         │ MAX_GLOBAL                      *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* ├─────────┤ 0x0000000080000000              *)
  (* │MEM0     │ size: 2G                        *)
  (* ├─────────┤ 0x0000000100000000              *)
  (* │         │                                 *)
  (* ├─────────┤ 0x0000000103400000              *)
  (* │RMM_PHYS │                                 *)
  (* │         │ rmm code, data, page tables     *)
  (* │         │ global objects                  *)
  (* │         │ size: 0x3000000                 *)
  (* ;---------;                                 *)
  (* │* .text  │                                 *)
  (* ;---------;                                 *)
  (* │* rodata │                                 *)
  (* ;---------;                                 *)
  (* │* data   │ RMM page table                  *)
  (* │         │ IO                              *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* ;---------;                                 *)
  (* │* percpu │                                 *)
  (* │ (stack) │                                 *)
  (* ;---------;                                 *)
  (* │* bss    │                                 *)
  (* ;---------;                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* │         │ (end of RMM phys)               *)
  (* ├─────────┤ 0x0000000106400000              *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* ├─────────┤ 0x0000008080000000              *)
  (* │MEM1     │ size: 4G                        *)
  (* ├─────────┤ 0x0000008180000000              *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* ├─────────┤                                 *)
  (* │simple   │                                 *)
  (* │STACK    │ 0xFFFFFFFFFFBFF000              *)
  (* │         │                                 *)
  (* │         │ 1024 pages                      *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* │         │                                 *)
  (* ├─────────┤                                 *)
  (* │MAX_ERR  │ 0xfffffffffffff000              *)
  (* ├─────────┤                                 *)
  (* │         │                                 *)
  (* │INT_MAX  │                                 *)
  (* └─────────┘                                 *)

Definition MAX_ERR : Z := 18446744073709547520. (* TODO: check this value *)
(* TODO: more reasonable address value*)
Definition HEAP_BASE : Z := 67108864.
Definition DEBUG_EXITS_BASE : Z := 67112960.
Definition VMID_COUNT_BASE : Z := 67117056.
Definition VMID_LOCK_BASE : Z := 67121152.
Definition VMIDS_BASE : Z := 67125248.
Definition NR_LRS_BASE : Z := 67133440.
Definition NR_APRS_BASE : Z := 67137536.
Definition MAX_VINTID_BASE : Z := 67141632.
Definition NR_PRI_BITS_BASE : Z := 67145728.
Definition PRI_RES0_MASK_BASE : Z := 67149824.
Definition DEFAULT_GICSTATE_BASE : Z := 67153920.
Definition STATUS_HANDLER_BASE : Z := 67158016.
Definition RMM_TRAP_LIST_BASE : Z := 67162112.
Definition TT_L3_BUFFER_BASE : Z := 67166208.
Definition TT_L2_MEM0_0_BASE : Z := 67170304.
Definition TT_L2_MEM0_1_BASE : Z := 67174400.
Definition TT_L2_MEM1_0_BASE : Z := 67178496.
Definition TT_L2_MEM1_1_BASE : Z := 67182592.
Definition TT_L2_MEM1_2_BASE : Z := 67186688.
Definition TT_L2_MEM1_3_BASE : Z := 67190784.
Definition TT_L3_MEM0_BASE : Z := 67194880.
Definition TT_L3_MEM1_BASE : Z := 71389184.
Definition MBEDTLS_MEM_BUF_BASE : Z := 79777792.
Definition GRANULES_BASE : Z := 80171008.
Definition RMM_ATTEST_SIGNING_KEY_BASE : Z := 105336832.
Definition RMM_ATTEST_PUBLIC_KEY_BASE : Z := 105340928.
Definition RMM_ATTEST_PUBLIC_KEY_LEN_BASE : Z := 105345024.
Definition RMM_ATTEST_PUBLIC_KEY_HASH_BASE : Z := 105349120.
Definition RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE : Z := 105353216.
Definition PLATFORM_TOKEN_BUF_BASE : Z := 105357312.
Definition RMM_PLATFORM_TOKEN_BASE : Z := 105361408.
Definition RMM_REALM_TOKEN_BUFS_BASE : Z := 105365504.
Definition GET_REALM_IDENTITY_IDENTITY_BASE : Z := 105431040.
Definition REALM_ATTEST_PRIVATE_KEY_BASE : Z := 105435136.
Definition MAX_GLOBAL : Z := 105439232.

Record STACK :=
 mkSTACK {
    stack_type_1: Z;
    stack_type_2: Z;
    stack_type_3: Z;
    stack_type_3__1: Z;
    stack_s_smc_result: s_smc_result;
    stack_s_smc_result__1: s_smc_result;
    stack_s_rmm_trap_element: s_rmm_trap_element;
    stack_s_rec_exit: s_rec_exit;
    stack_type_4: Z;
    stack_type_4__1: Z;
    stack_s_ns_state: s_ns_state;
    stack_s_q_useful_buf: s_q_useful_buf;
    stack_s_q_useful_buf__1: s_q_useful_buf;
    stack_s_q_useful_buf__2: s_q_useful_buf;
    stack_s_q_useful_buf__3: s_q_useful_buf;
    stack_s_attest_token_encode_ctx: s_attest_token_encode_ctx;
    stack_s_rtt_walk: s_rtt_walk;
    stack_s_rtt_walk__1: s_rtt_walk;
    stack_s_psci_result: s_psci_result;
    stack_s_attest_result: s_attest_result;
    stack_s_rec_entry: s_rec_entry;
    stack_s_realm_s2_context: s_realm_s2_context;
    stack_s_rec_params: s_rec_params;
    stack_s_realm_params: s_realm_params;
    stack_s_psa_key_attributes_s: s_psa_key_attributes_s;
    stack_type_5: (ZMap.t Z);
    stack_type_6: (ZMap.t s_granule_set);
    stack_type_7: (ZMap.t Z);
    stack_type_8: (ZMap.t Z);
    }.


Record r_granule_data :=
  mkr_granule_data {
      (* the index of granule entry for the current phyical Granule*)
      gd_g_idx: Z;

      (* RTT/NS/Data *)
      (* NS, GRANULE_STATE_NS = 0 *)
      (* DELEGATED, GRANULE_STATE_DELEGATED = 1*)
      (* DATA, GRANULE_STATE_DATA = 4 *)
      (* RTT, GRANULE_STATE_RTT = 5 *)
      (* ANY, GRANULE_STATE_ANY = 6 : ANY is converted from NS with refcount extension*)
      (* XXX: offset -> data *)
      g_norm: ZMap.t Z;

      (* RD, GRANULE_STATE_RD = 2 *)
      g_rd: s_rd;

      (* REC, GRANULE_STATE_REC = 3 *)
      g_rec: s_rec

      (* luckily, we dont have rec-aux in this version *)
    }.

Record PerCPURegs := (* copied from proof_debug_of.v *)
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
      pcpu_regs: PerCPURegs;
      pcpu_gpregs: GPRegs
      (* no xlat required *)
    }.


Record GLOBALS :=
  mkGLOBALS {
      g_heap: (ZMap.t s_buffer_alloc_ctx);
      g_debug_exits: Z;
      g_vmid_count: Z;
      g_vmid_lock: s_spinlock_t;
      g_vmids: (ZMap.t Z);
      g_nr_lrs: Z;
      g_nr_aprs: Z;
      g_max_vintid: Z;
      g_pri_res0_mask: Z;
      g_default_gicstate: s_gic_cpu_state;
      g_status_handler: (ZMap.t Z);
      g_rmm_trap_list: (ZMap.t s_rmm_trap_element);
      g_tt_l3_buffer: s_s1tt;
      g_tt_l2_mem0_0: s_s1tt;
      g_tt_l2_mem0_1: s_s1tt;
      g_tt_l2_mem1_0: s_s1tt;
      g_tt_l2_mem1_1: s_s1tt;
      g_tt_l2_mem1_2: s_s1tt;
      g_tt_l2_mem1_3: s_s1tt;
      (* g_tt_l3_mem0: None; 2-dimensional array *)
      (* g_tt_l3_mem1: None; 2-dimensional array *)
      g_mbedtls_mem_buf: (ZMap.t Z);
      g_granules: (ZMap.t s_granule);
      g_rmm_attest_signing_key: Z;
      g_rmm_attest_public_key: (ZMap.t Z);
      g_rmm_attest_public_key_len: Z;
      g_rmm_attest_public_key_hash: (ZMap.t Z);
      g_rmm_attest_public_key_hash_len: Z;
      g_platform_token_buf: (ZMap.t Z);
      g_rmm_platform_token: s_q_useful_buf;
      (* g_rmm_realm_token_bufs: None; 2-dimensional array *)
      g_get_realm_identity_identity: (ZMap.t Z);
      g_realm_attest_private_key: (ZMap.t Z)
    }.


Record Shared :=
  mkShared {
      (* glk: ZMap.t (option Z); *)
      (* gpt: ZMap.t bool; gidx -> PAS *)

      granule_data: ZMap.t r_granule_data;

      globals: GLOBALS
      (* granules is temporally put in globals, entry for Granules, index -> granule entry in RMM *)
    }.

Record RData :=
  mkRData {
      (* log: list Event; *)
      (* oracle: Oracle; *)
      (* repl: Replay; *)

      (* registers ops will be generated in Spoq *)
      priv: PerCPU; 

      (* accessed by load/store Rdata *)
      share: Shared;
      stack: STACK
    }.


Definition load_RData (sz: Z) (p: Ptr) (st: RData) : (option (Z * RData)) :=
if (p.(pbase) =s "stack_type_1") then (
      Some(st.(stack).(stack_type_1), st)) else
  if (p.(pbase) =s "stack_type_2") then (
      Some(st.(stack).(stack_type_2), st)) else
  if (p.(pbase) =s "stack_type_3") then (
      Some(st.(stack).(stack_type_3), st)) else
  if (p.(pbase) =s "stack_type_3__1") then (
      Some(st.(stack).(stack_type_3__1), st)) else
  if (p.(pbase) =s "stack_s_smc_result") then (
      when ret == load_s_smc_result sz p.(poffset) st.(stack).(stack_s_smc_result);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_smc_result__1") then (
      when ret == load_s_smc_result sz p.(poffset) st.(stack).(stack_s_smc_result__1);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_rmm_trap_element") then (
      when ret == load_s_rmm_trap_element sz p.(poffset) st.(stack).(stack_s_rmm_trap_element);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_rec_exit") then (
      when ret == load_s_rec_exit sz p.(poffset) st.(stack).(stack_s_rec_exit);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_type_4") then (
      Some(st.(stack).(stack_type_4), st)) else
  if (p.(pbase) =s "stack_type_4__1") then (
      Some(st.(stack).(stack_type_4__1), st)) else
  if (p.(pbase) =s "stack_s_ns_state") then (
      when ret == load_s_ns_state sz p.(poffset) st.(stack).(stack_s_ns_state);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_q_useful_buf") then (
      when ret == load_s_q_useful_buf sz p.(poffset) st.(stack).(stack_s_q_useful_buf);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_q_useful_buf__1") then (
      when ret == load_s_q_useful_buf sz p.(poffset) st.(stack).(stack_s_q_useful_buf__1);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_q_useful_buf__2") then (
      when ret == load_s_q_useful_buf sz p.(poffset) st.(stack).(stack_s_q_useful_buf__2);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_q_useful_buf__3") then (
      when ret == load_s_q_useful_buf sz p.(poffset) st.(stack).(stack_s_q_useful_buf__3);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_attest_token_encode_ctx") then (
      when ret == load_s_attest_token_encode_ctx sz p.(poffset) st.(stack).(stack_s_attest_token_encode_ctx);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_rtt_walk") then (
      when ret == load_s_rtt_walk sz p.(poffset) st.(stack).(stack_s_rtt_walk);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_rtt_walk__1") then (
      when ret == load_s_rtt_walk sz p.(poffset) st.(stack).(stack_s_rtt_walk__1);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_psci_result") then (
      when ret == load_s_psci_result sz p.(poffset) st.(stack).(stack_s_psci_result);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_attest_result") then (
      when ret == load_s_attest_result sz p.(poffset) st.(stack).(stack_s_attest_result);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_rec_entry") then (
      when ret == load_s_rec_entry sz p.(poffset) st.(stack).(stack_s_rec_entry);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_realm_s2_context") then (
      when ret == load_s_realm_s2_context sz p.(poffset) st.(stack).(stack_s_realm_s2_context);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_rec_params") then (
      when ret == load_s_rec_params sz p.(poffset) st.(stack).(stack_s_rec_params);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_realm_params") then (
      when ret == load_s_realm_params sz p.(poffset) st.(stack).(stack_s_realm_params);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_s_psa_key_attributes_s") then (
      when ret == load_s_psa_key_attributes_s sz p.(poffset) st.(stack).(stack_s_psa_key_attributes_s);
      Some(ret, st)) else
  if (p.(pbase) =s "stack_type_5") then (
      let idx := p.(poffset) / 8 in 
      let ptr := st.(stack).(stack_type_5) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "stack_type_6") then (
       let idx := p.(poffset) / 40 in
       let elem_ofs := p.(poffset) mod 40 in
       when ret == load_s_granule_set sz elem_ofs (st.(stack).(stack_type_6) @ idx);
        Some(ret, st)) else
  if (p.(pbase) =s "stack_type_7") then (
      let idx := p.(poffset) / 8 in 
      let ptr := st.(stack).(stack_type_7) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "stack_type_8") then (
      let idx := p.(poffset) / 1 in 
      let ptr := st.(stack).(stack_type_8) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "heap") then (
       let idx := p.(poffset) / 40 in
       let elem_ofs := p.(poffset) mod 40 in
       when ret == load_s_buffer_alloc_ctx sz elem_ofs (st.(share).(globals).(g_heap) @ idx);
        Some(ret, st)) else
  if (p.(pbase) =s "debug_exits") then (
      Some(st.(share).(globals).(g_debug_exits), st)) else
  if (p.(pbase) =s "vmid_count") then (
      Some(st.(share).(globals).(g_vmid_count), st)) else
  if (p.(pbase) =s "vmid_lock") then (
      when ret == load_s_spinlock_t sz p.(poffset) st.(share).(globals).(g_vmid_lock);
      Some(ret, st)) else
  if (p.(pbase) =s "vmids") then (
      let idx := p.(poffset) / 8 in 
      let ptr := st.(share).(globals).(g_vmids) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "nr_lrs") then (
      Some(st.(share).(globals).(g_nr_lrs), st)) else
  if (p.(pbase) =s "nr_aprs") then (
      Some(st.(share).(globals).(g_nr_aprs), st)) else
  if (p.(pbase) =s "max_vintid") then (
      Some(st.(share).(globals).(g_max_vintid), st)) else
  if (p.(pbase) =s "pri_res0_mask") then (
      Some(st.(share).(globals).(g_pri_res0_mask), st)) else
  if (p.(pbase) =s "default_gicstate") then (
      when ret == load_s_gic_cpu_state sz p.(poffset) st.(share).(globals).(g_default_gicstate);
      Some(ret, st)) else
  if (p.(pbase) =s "status_handler") then (
      let idx := p.(poffset) / 8 in 
      let ptr := st.(share).(globals).(g_status_handler) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "rmm_trap_list") then (
       let idx := p.(poffset) / 16 in
       let elem_ofs := p.(poffset) mod 16 in
       when ret == load_s_rmm_trap_element sz elem_ofs (st.(share).(globals).(g_rmm_trap_list) @ idx);
        Some(ret, st)) else
  if (p.(pbase) =s "tt_l3_buffer") then (
      when ret == load_s_s1tt sz p.(poffset) st.(share).(globals).(g_tt_l3_buffer);
      Some(ret, st)) else
  if (p.(pbase) =s "tt_l2_mem0_0") then (
      when ret == load_s_s1tt sz p.(poffset) st.(share).(globals).(g_tt_l2_mem0_0);
      Some(ret, st)) else
  if (p.(pbase) =s "tt_l2_mem0_1") then (
      when ret == load_s_s1tt sz p.(poffset) st.(share).(globals).(g_tt_l2_mem0_1);
      Some(ret, st)) else
  if (p.(pbase) =s "tt_l2_mem1_0") then (
      when ret == load_s_s1tt sz p.(poffset) st.(share).(globals).(g_tt_l2_mem1_0);
      Some(ret, st)) else
  if (p.(pbase) =s "tt_l2_mem1_1") then (
      when ret == load_s_s1tt sz p.(poffset) st.(share).(globals).(g_tt_l2_mem1_1);
      Some(ret, st)) else
  if (p.(pbase) =s "tt_l2_mem1_2") then (
      when ret == load_s_s1tt sz p.(poffset) st.(share).(globals).(g_tt_l2_mem1_2);
      Some(ret, st)) else
  if (p.(pbase) =s "tt_l2_mem1_3") then (
      when ret == load_s_s1tt sz p.(poffset) st.(share).(globals).(g_tt_l2_mem1_3);
      Some(ret, st)) else
  if (p.(pbase) =s "mbedtls_mem_buf") then (
      let idx := p.(poffset) / 1 in 
      let ptr := st.(share).(globals).(g_mbedtls_mem_buf) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "granules") then (
       let idx := p.(poffset) / 16 in
       let elem_ofs := p.(poffset) mod 16 in
       when ret == load_s_granule sz elem_ofs (st.(share).(globals).(g_granules) @ idx);
        Some(ret, st)) else
  if (p.(pbase) =s "rmm_attest_signing_key") then (
      Some(st.(share).(globals).(g_rmm_attest_signing_key), st)) else
  if (p.(pbase) =s "rmm_attest_public_key") then (
      let idx := p.(poffset) / 1 in 
      let ptr := st.(share).(globals).(g_rmm_attest_public_key) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "rmm_attest_public_key_len") then (
      Some(st.(share).(globals).(g_rmm_attest_public_key_len), st)) else
  if (p.(pbase) =s "rmm_attest_public_key_hash") then (
      let idx := p.(poffset) / 1 in 
      let ptr := st.(share).(globals).(g_rmm_attest_public_key_hash) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "rmm_attest_public_key_hash_len") then (
      Some(st.(share).(globals).(g_rmm_attest_public_key_hash_len), st)) else
  if (p.(pbase) =s "platform_token_buf") then (
      let idx := p.(poffset) / 1 in 
      let ptr := st.(share).(globals).(g_platform_token_buf) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "rmm_platform_token") then (
      when ret == load_s_q_useful_buf sz p.(poffset) st.(share).(globals).(g_rmm_platform_token);
      Some(ret, st)) else
  if (p.(pbase) =s "get_realm_identity_identity") then (
      let idx := p.(poffset) / 1 in 
      let ptr := st.(share).(globals).(g_get_realm_identity_identity) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "realm_attest_private_key") then (
      let idx := p.(poffset) / 1 in 
      let ptr := st.(share).(globals).(g_realm_attest_private_key) @ idx in
      Some(ptr, st)) else
  if (p.(pbase) =s "granule_data") then (
      let idx := p.(poffset) / 4096 in
      let g_data := (st.(share).(granule_data) @ idx) in
      let elem_ofs := (p.(poffset) mod 4096) in
      let norm_data := ((g_data.(g_norm)) @ elem_ofs) in 
      Some(norm_data, st)
   ) else
   None.
    (* Some(1, st). *)


Definition global_to_ptr (v: Z) : Ptr := 
 if (v >=? MAX_GLOBAL ) then (mkPtr "null" 0) else
 if (v <? 0 ) then (mkPtr "null" 0) else
 if (v >=? REALM_ATTEST_PRIVATE_KEY_BASE) then (mkPtr "realm_attest_private_key" (v - REALM_ATTEST_PRIVATE_KEY_BASE)) else
 if (v >=? GET_REALM_IDENTITY_IDENTITY_BASE) then (mkPtr "get_realm_identity_identity" (v - GET_REALM_IDENTITY_IDENTITY_BASE)) else
 if (v >=? RMM_REALM_TOKEN_BUFS_BASE) then (mkPtr "rmm_realm_token_bufs" (v - RMM_REALM_TOKEN_BUFS_BASE)) else
 if (v >=? RMM_PLATFORM_TOKEN_BASE) then (mkPtr "rmm_platform_token" (v - RMM_PLATFORM_TOKEN_BASE)) else
 if (v >=? PLATFORM_TOKEN_BUF_BASE) then (mkPtr "platform_token_buf" (v - PLATFORM_TOKEN_BUF_BASE)) else
 if (v >=? RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE) then (mkPtr "rmm_attest_public_key_hash_len" (v - RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE)) else
 if (v >=? RMM_ATTEST_PUBLIC_KEY_HASH_BASE) then (mkPtr "rmm_attest_public_key_hash" (v - RMM_ATTEST_PUBLIC_KEY_HASH_BASE)) else
 if (v >=? RMM_ATTEST_PUBLIC_KEY_LEN_BASE) then (mkPtr "rmm_attest_public_key_len" (v - RMM_ATTEST_PUBLIC_KEY_LEN_BASE)) else
 if (v >=? RMM_ATTEST_PUBLIC_KEY_BASE) then (mkPtr "rmm_attest_public_key" (v - RMM_ATTEST_PUBLIC_KEY_BASE)) else
 if (v >=? RMM_ATTEST_SIGNING_KEY_BASE) then (mkPtr "rmm_attest_signing_key" (v - RMM_ATTEST_SIGNING_KEY_BASE)) else
 if (v >=? GRANULES_BASE) then (mkPtr "granules" (v - GRANULES_BASE)) else
 if (v >=? MBEDTLS_MEM_BUF_BASE) then (mkPtr "mbedtls_mem_buf" (v - MBEDTLS_MEM_BUF_BASE)) else
 if (v >=? TT_L3_MEM1_BASE) then (mkPtr "tt_l3_mem1" (v - TT_L3_MEM1_BASE)) else
 if (v >=? TT_L3_MEM0_BASE) then (mkPtr "tt_l3_mem0" (v - TT_L3_MEM0_BASE)) else
 if (v >=? TT_L2_MEM1_3_BASE) then (mkPtr "tt_l2_mem1_3" (v - TT_L2_MEM1_3_BASE)) else
 if (v >=? TT_L2_MEM1_2_BASE) then (mkPtr "tt_l2_mem1_2" (v - TT_L2_MEM1_2_BASE)) else
 if (v >=? TT_L2_MEM1_1_BASE) then (mkPtr "tt_l2_mem1_1" (v - TT_L2_MEM1_1_BASE)) else
 if (v >=? TT_L2_MEM1_0_BASE) then (mkPtr "tt_l2_mem1_0" (v - TT_L2_MEM1_0_BASE)) else
 if (v >=? TT_L2_MEM0_1_BASE) then (mkPtr "tt_l2_mem0_1" (v - TT_L2_MEM0_1_BASE)) else
 if (v >=? TT_L2_MEM0_0_BASE) then (mkPtr "tt_l2_mem0_0" (v - TT_L2_MEM0_0_BASE)) else
 if (v >=? TT_L3_BUFFER_BASE) then (mkPtr "tt_l3_buffer" (v - TT_L3_BUFFER_BASE)) else
 if (v >=? RMM_TRAP_LIST_BASE) then (mkPtr "rmm_trap_list" (v - RMM_TRAP_LIST_BASE)) else
 if (v >=? STATUS_HANDLER_BASE) then (mkPtr "status_handler" (v - STATUS_HANDLER_BASE)) else
 if (v >=? DEFAULT_GICSTATE_BASE) then (mkPtr "default_gicstate" (v - DEFAULT_GICSTATE_BASE)) else
 if (v >=? PRI_RES0_MASK_BASE) then (mkPtr "pri_res0_mask" (v - PRI_RES0_MASK_BASE)) else
 if (v >=? NR_PRI_BITS_BASE) then (mkPtr "nr_pri_bits" (v - NR_PRI_BITS_BASE)) else
 if (v >=? MAX_VINTID_BASE) then (mkPtr "max_vintid" (v - MAX_VINTID_BASE)) else
 if (v >=? NR_APRS_BASE) then (mkPtr "nr_aprs" (v - NR_APRS_BASE)) else
 if (v >=? NR_LRS_BASE) then (mkPtr "nr_lrs" (v - NR_LRS_BASE)) else
 if (v >=? VMIDS_BASE) then (mkPtr "vmids" (v - VMIDS_BASE)) else
 if (v >=? VMID_LOCK_BASE) then (mkPtr "vmid_lock" (v - VMID_LOCK_BASE)) else
 if (v >=? VMID_COUNT_BASE) then (mkPtr "vmid_count" (v - VMID_COUNT_BASE)) else
 if (v >=? DEBUG_EXITS_BASE) then (mkPtr "debug_exits" (v - DEBUG_EXITS_BASE)) else
 if (v >=? HEAP_BASE) then (mkPtr "heap" (v - HEAP_BASE)) else
   (mkPtr "null" 0).

(* stack variable never use ptrtoint in source code *)
Definition ptr_to_int (p: Ptr) : Z := 
 if (p.(poffset) <? 0) then -1 else (* *)
 (* global pointer to int *)
 if (p.(pbase) =s "status") then (MAX_ERR + p.(poffset)) else
 if (p.(pbase) =s "null") then 0 else
 if (p.(pbase) =s "realm_attest_private_key") then (REALM_ATTEST_PRIVATE_KEY_BASE + p.(poffset)) else
 if (p.(pbase) =s "get_realm_identity_identity") then (GET_REALM_IDENTITY_IDENTITY_BASE + p.(poffset)) else
 if (p.(pbase) =s "rmm_realm_token_bufs") then (RMM_REALM_TOKEN_BUFS_BASE + p.(poffset)) else
 if (p.(pbase) =s "rmm_platform_token") then (RMM_PLATFORM_TOKEN_BASE + p.(poffset)) else
 if (p.(pbase) =s "platform_token_buf") then (PLATFORM_TOKEN_BUF_BASE + p.(poffset)) else
 if (p.(pbase) =s "rmm_attest_public_key_hash_len") then (RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE + p.(poffset)) else
 if (p.(pbase) =s "rmm_attest_public_key_hash") then (RMM_ATTEST_PUBLIC_KEY_HASH_BASE + p.(poffset)) else
 if (p.(pbase) =s "rmm_attest_public_key_len") then (RMM_ATTEST_PUBLIC_KEY_LEN_BASE + p.(poffset)) else
 if (p.(pbase) =s "rmm_attest_public_key") then (RMM_ATTEST_PUBLIC_KEY_BASE + p.(poffset)) else
 if (p.(pbase) =s "rmm_attest_signing_key") then (RMM_ATTEST_SIGNING_KEY_BASE + p.(poffset)) else
 if (p.(pbase) =s "granules") then (GRANULES_BASE + p.(poffset)) else
 if (p.(pbase) =s "mbedtls_mem_buf") then (MBEDTLS_MEM_BUF_BASE + p.(poffset)) else
 if (p.(pbase) =s "tt_l3_mem1") then (TT_L3_MEM1_BASE + p.(poffset)) else
 if (p.(pbase) =s "tt_l3_mem0") then (TT_L3_MEM0_BASE + p.(poffset)) else
 if (p.(pbase) =s "tt_l2_mem1_3") then (TT_L2_MEM1_3_BASE + p.(poffset)) else
 if (p.(pbase) =s "tt_l2_mem1_2") then (TT_L2_MEM1_2_BASE + p.(poffset)) else
 if (p.(pbase) =s "tt_l2_mem1_1") then (TT_L2_MEM1_1_BASE + p.(poffset)) else
 if (p.(pbase) =s "tt_l2_mem1_0") then (TT_L2_MEM1_0_BASE + p.(poffset)) else
 if (p.(pbase) =s "tt_l2_mem0_1") then (TT_L2_MEM0_1_BASE + p.(poffset)) else
 if (p.(pbase) =s "tt_l2_mem0_0") then (TT_L2_MEM0_0_BASE + p.(poffset)) else
 if (p.(pbase) =s "tt_l3_buffer") then (TT_L3_BUFFER_BASE + p.(poffset)) else
 if (p.(pbase) =s "rmm_trap_list") then (RMM_TRAP_LIST_BASE + p.(poffset)) else
 if (p.(pbase) =s "status_handler") then (STATUS_HANDLER_BASE + p.(poffset)) else
 if (p.(pbase) =s "default_gicstate") then (DEFAULT_GICSTATE_BASE + p.(poffset)) else
 if (p.(pbase) =s "pri_res0_mask") then (PRI_RES0_MASK_BASE + p.(poffset)) else
 if (p.(pbase) =s "nr_pri_bits") then (NR_PRI_BITS_BASE + p.(poffset)) else
 if (p.(pbase) =s "max_vintid") then (MAX_VINTID_BASE + p.(poffset)) else
 if (p.(pbase) =s "nr_aprs") then (NR_APRS_BASE + p.(poffset)) else
 if (p.(pbase) =s "nr_lrs") then (NR_LRS_BASE + p.(poffset)) else
 if (p.(pbase) =s "vmids") then (VMIDS_BASE + p.(poffset)) else
 if (p.(pbase) =s "vmid_lock") then (VMID_LOCK_BASE + p.(poffset)) else
 if (p.(pbase) =s "vmid_count") then (VMID_COUNT_BASE + p.(poffset)) else
 if (p.(pbase) =s "debug_exits") then (DEBUG_EXITS_BASE + p.(poffset)) else
 if (p.(pbase) =s "heap") then (HEAP_BASE + p.(poffset)) else
    -1.

(* stack variable never use inttoptr in source code *)
Definition int_to_ptr (v: Z) : Ptr :=
  if (v >? (0))
  then (
    if (v <? MAX_GLOBAL) then (global_to_ptr v) else 
    if (v >=? (MAX_ERR)) then (mkPtr "status" (v - (MAX_ERR))) else
    (mkPtr "null" 0)
    (* TODO: stack: use bad stack to represent it *)
  )
  else (mkPtr "null" 0).

Definition ptr_eqb (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 =? ptr_to_int p2.

Definition ptr_ltb (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 <? ptr_to_int p2.

Definition ptr_gtb (p1: Ptr) (p2: Ptr) : bool :=
  if (p2.(pbase) =s "status") then
    (if ((p1.(pbase) <>s "status")) then false
    else p1.(poffset) >? p2.(poffset))
  else ptr_to_int p1 >? ptr_to_int p2 .

(* TODO: store RData *)
Definition store_RData (sz: Z) (p: Ptr) (v: Z) (st: RData) : option RData := 
    if (p.(pbase) =s "stack_type_1") then (
        Some(st.[stack].[stack_type_1] :< v)) else
    if (p.(pbase) =s "stack_type_2") then (
        Some(st.[stack].[stack_type_2] :< v)) else
    if (p.(pbase) =s "stack_type_3") then (
        Some(st.[stack].[stack_type_3] :< v)) else
    if (p.(pbase) =s "stack_type_3__1") then (
        Some(st.[stack].[stack_type_3__1] :< v)) else
    if (p.(pbase) =s "stack_s_smc_result") then (
        when ret == store_s_smc_result sz p.(poffset) v st.(stack).(stack_s_smc_result);
        Some(st.[stack].[stack_s_smc_result] :< ret)) else
    if (p.(pbase) =s "stack_s_smc_result__1") then (
        when ret == store_s_smc_result sz p.(poffset) v st.(stack).(stack_s_smc_result__1);
        Some(st.[stack].[stack_s_smc_result__1] :< ret)) else
    if (p.(pbase) =s "stack_s_rmm_trap_element") then (
        when ret == store_s_rmm_trap_element sz p.(poffset) v st.(stack).(stack_s_rmm_trap_element);
        Some(st.[stack].[stack_s_rmm_trap_element] :< ret)) else
    if (p.(pbase) =s "stack_s_rec_exit") then (
        when ret == store_s_rec_exit sz p.(poffset) v st.(stack).(stack_s_rec_exit);
        Some(st.[stack].[stack_s_rec_exit] :< ret)) else
    if (p.(pbase) =s "stack_type_4") then (
        Some(st.[stack].[stack_type_4] :< v)) else
    if (p.(pbase) =s "stack_type_4__1") then (
        Some(st.[stack].[stack_type_4__1] :< v)) else
    if (p.(pbase) =s "stack_s_ns_state") then (
        when ret == store_s_ns_state sz p.(poffset) v st.(stack).(stack_s_ns_state);
        Some(st.[stack].[stack_s_ns_state] :< ret)) else
    if (p.(pbase) =s "stack_s_q_useful_buf") then (
        when ret == store_s_q_useful_buf sz p.(poffset) v st.(stack).(stack_s_q_useful_buf);
        Some(st.[stack].[stack_s_q_useful_buf] :< ret)) else
    if (p.(pbase) =s "stack_s_q_useful_buf__1") then (
        when ret == store_s_q_useful_buf sz p.(poffset) v st.(stack).(stack_s_q_useful_buf__1);
        Some(st.[stack].[stack_s_q_useful_buf__1] :< ret)) else
    if (p.(pbase) =s "stack_s_q_useful_buf__2") then (
        when ret == store_s_q_useful_buf sz p.(poffset) v st.(stack).(stack_s_q_useful_buf__2);
        Some(st.[stack].[stack_s_q_useful_buf__2] :< ret)) else
    if (p.(pbase) =s "stack_s_q_useful_buf__3") then (
        when ret == store_s_q_useful_buf sz p.(poffset) v st.(stack).(stack_s_q_useful_buf__3);
        Some(st.[stack].[stack_s_q_useful_buf__3] :< ret)) else
    if (p.(pbase) =s "stack_s_attest_token_encode_ctx") then (
        when ret == store_s_attest_token_encode_ctx sz p.(poffset) v st.(stack).(stack_s_attest_token_encode_ctx);
        Some(st.[stack].[stack_s_attest_token_encode_ctx] :< ret)) else
    if (p.(pbase) =s "stack_s_rtt_walk") then (
        when ret == store_s_rtt_walk sz p.(poffset) v st.(stack).(stack_s_rtt_walk);
        Some(st.[stack].[stack_s_rtt_walk] :< ret)) else
    if (p.(pbase) =s "stack_s_rtt_walk__1") then (
        when ret == store_s_rtt_walk sz p.(poffset) v st.(stack).(stack_s_rtt_walk__1);
        Some(st.[stack].[stack_s_rtt_walk__1] :< ret)) else
    if (p.(pbase) =s "stack_s_psci_result") then (
        when ret == store_s_psci_result sz p.(poffset) v st.(stack).(stack_s_psci_result);
        Some(st.[stack].[stack_s_psci_result] :< ret)) else
    if (p.(pbase) =s "stack_s_attest_result") then (
        when ret == store_s_attest_result sz p.(poffset) v st.(stack).(stack_s_attest_result);
        Some(st.[stack].[stack_s_attest_result] :< ret)) else
    if (p.(pbase) =s "stack_s_rec_entry") then (
        when ret == store_s_rec_entry sz p.(poffset) v st.(stack).(stack_s_rec_entry);
        Some(st.[stack].[stack_s_rec_entry] :< ret)) else
    if (p.(pbase) =s "stack_s_realm_s2_context") then (
        when ret == store_s_realm_s2_context sz p.(poffset) v st.(stack).(stack_s_realm_s2_context);
        Some(st.[stack].[stack_s_realm_s2_context] :< ret)) else
    if (p.(pbase) =s "stack_s_rec_params") then (
        when ret == store_s_rec_params sz p.(poffset) v st.(stack).(stack_s_rec_params);
        Some(st.[stack].[stack_s_rec_params] :< ret)) else
    if (p.(pbase) =s "stack_s_realm_params") then (
        when ret == store_s_realm_params sz p.(poffset) v st.(stack).(stack_s_realm_params);
        Some(st.[stack].[stack_s_realm_params] :< ret)) else
    if (p.(pbase) =s "stack_s_psa_key_attributes_s") then (
        when ret == store_s_psa_key_attributes_s sz p.(poffset) v st.(stack).(stack_s_psa_key_attributes_s);
        Some(st.[stack].[stack_s_psa_key_attributes_s] :< ret)) else
    if (p.(pbase) =s "stack_type_5") then (
        let idx := p.(poffset) / 8 in 
        let ptr := (st.(stack).(stack_type_5) # idx == v) in
        Some(st.[stack].[stack_type_5] :< ptr)) else
    if (p.(pbase) =s "stack_type_6") then (
         let idx := p.(poffset) / 40 in
         let elem_ofs := p.(poffset) mod 40 in
         when ret == store_s_granule_set sz elem_ofs v (st.(stack).(stack_type_6) @ idx);
          Some(st.[stack].[stack_type_6] :< (st.(stack).(stack_type_6) # idx == ret))) else
    if (p.(pbase) =s "stack_type_7") then (
        let idx := p.(poffset) / 8 in 
        let ptr := (st.(stack).(stack_type_7) # idx == v) in
        Some(st.[stack].[stack_type_7] :< ptr)) else
    if (p.(pbase) =s "stack_type_8") then (
        let idx := p.(poffset) / 1 in 
        let ptr := (st.(stack).(stack_type_8) # idx == v) in
        Some(st.[stack].[stack_type_8] :< ptr)) else
        if (p.(pbase) =s "heap") then (
            let idx := p.(poffset) / 40 in
            let elem_ofs := p.(poffset) mod 40 in
            when ret == store_s_buffer_alloc_ctx sz elem_ofs v (st.(share).(globals).(g_heap) @ idx);
             Some(st.[share].[globals].[g_heap] :< (st.(share).(globals).(g_heap) # idx == ret) )) else
    if (p.(pbase) =s "debug_exits") then (
        Some(st.[share].[globals].[g_debug_exits] :< v)) else
    if (p.(pbase) =s "vmid_count") then (
        Some(st.[share].[globals].[g_vmid_count] :< v)) else
    if (p.(pbase) =s "vmid_lock") then (
        when ret == store_s_spinlock_t sz p.(poffset) v st.(share).(globals).(g_vmid_lock);
        Some(st.[share].[globals].[g_vmid_lock] :< ret)) else
    if (p.(pbase) =s "vmids") then (
        let idx := p.(poffset) / 8 in 
        let ptr := (st.(share).(globals).(g_vmids) # idx == v) in
        Some(st.[share].[globals].[g_vmids] :< ptr)) else
    if (p.(pbase) =s "nr_lrs") then (
        Some(st.[share].[globals].[g_nr_lrs] :< v)) else
    if (p.(pbase) =s "nr_aprs") then (
        Some(st.[share].[globals].[g_nr_aprs] :< v)) else
    if (p.(pbase) =s "max_vintid") then (
        Some(st.[share].[globals].[g_max_vintid] :< v)) else
    if (p.(pbase) =s "pri_res0_mask") then (
        Some(st.[share].[globals].[g_pri_res0_mask] :< v)) else
    if (p.(pbase) =s "default_gicstate") then (
        when ret == store_s_gic_cpu_state sz p.(poffset) v st.(share).(globals).(g_default_gicstate);
        Some(st.[share].[globals].[g_default_gicstate] :< ret)) else
    if (p.(pbase) =s "status_handler") then (
        let idx := p.(poffset) / 8 in 
        let ptr := (st.(share).(globals).(g_status_handler) # idx == v) in
        Some(st.[share].[globals].[g_status_handler] :< ptr)) else
    if (p.(pbase) =s "rmm_trap_list") then (
        let idx := p.(poffset) / 16 in
        let elem_ofs := p.(poffset) mod 16 in
        when ret == store_s_rmm_trap_element sz elem_ofs v (st.(share).(globals).(g_rmm_trap_list) @ idx);
            Some(st.[share].[globals].[g_rmm_trap_list] :< (st.(share).(globals).(g_rmm_trap_list) # idx == ret) )) else
    if (p.(pbase) =s "tt_l3_buffer") then (
        when ret == store_s_s1tt sz p.(poffset) v st.(share).(globals).(g_tt_l3_buffer);
        Some(st.[share].[globals].[g_tt_l3_buffer] :< ret)) else
    if (p.(pbase) =s "tt_l2_mem0_0") then (
        when ret == store_s_s1tt sz p.(poffset) v st.(share).(globals).(g_tt_l2_mem0_0);
        Some(st.[share].[globals].[g_tt_l2_mem0_0] :< ret)) else
    if (p.(pbase) =s "tt_l2_mem0_1") then (
        when ret == store_s_s1tt sz p.(poffset) v st.(share).(globals).(g_tt_l2_mem0_1);
        Some(st.[share].[globals].[g_tt_l2_mem0_1] :< ret)) else
    if (p.(pbase) =s "tt_l2_mem1_0") then (
        when ret == store_s_s1tt sz p.(poffset) v st.(share).(globals).(g_tt_l2_mem1_0);
        Some(st.[share].[globals].[g_tt_l2_mem1_0] :< ret)) else
    if (p.(pbase) =s "tt_l2_mem1_1") then (
        when ret == store_s_s1tt sz p.(poffset) v st.(share).(globals).(g_tt_l2_mem1_1);
        Some(st.[share].[globals].[g_tt_l2_mem1_1] :< ret)) else
    if (p.(pbase) =s "tt_l2_mem1_2") then (
        when ret == store_s_s1tt sz p.(poffset) v st.(share).(globals).(g_tt_l2_mem1_2);
        Some(st.[share].[globals].[g_tt_l2_mem1_2] :< ret)) else
    if (p.(pbase) =s "tt_l2_mem1_3") then (
        when ret == store_s_s1tt sz p.(poffset) v st.(share).(globals).(g_tt_l2_mem1_3);
        Some(st.[share].[globals].[g_tt_l2_mem1_3] :< ret)) else
    if (p.(pbase) =s "mbedtls_mem_buf") then (
        let idx := p.(poffset) / 1 in 
        let ptr := (st.(share).(globals).(g_mbedtls_mem_buf) # idx == v) in
        Some(st.[share].[globals].[g_mbedtls_mem_buf] :< ptr)) else
    if (p.(pbase) =s "granules") then (
        let idx := p.(poffset) / 16 in
        let elem_ofs := p.(poffset) mod 16 in
        when ret == store_s_granule sz elem_ofs v (st.(share).(globals).(g_granules) @ idx);
            Some(st.[share].[globals].[g_granules] :< (st.(share).(globals).(g_granules) # idx == ret) )) else
    if (p.(pbase) =s "rmm_attest_signing_key") then (
        Some(st.[share].[globals].[g_rmm_attest_signing_key] :< v)) else
    if (p.(pbase) =s "rmm_attest_public_key") then (
        let idx := p.(poffset) / 1 in 
        let ptr := (st.(share).(globals).(g_rmm_attest_public_key) # idx == v) in
        Some(st.[share].[globals].[g_rmm_attest_public_key] :< ptr)) else
    if (p.(pbase) =s "rmm_attest_public_key_len") then (
        Some(st.[share].[globals].[g_rmm_attest_public_key_len] :< v)) else
    if (p.(pbase) =s "rmm_attest_public_key_hash") then (
        let idx := p.(poffset) / 1 in 
        let ptr := (st.(share).(globals).(g_rmm_attest_public_key_hash) # idx == v) in
        Some(st.[share].[globals].[g_rmm_attest_public_key_hash] :< ptr)) else
    if (p.(pbase) =s "rmm_attest_public_key_hash_len") then (
        Some(st.[share].[globals].[g_rmm_attest_public_key_hash_len] :< v)) else
    if (p.(pbase) =s "platform_token_buf") then (
        let idx := p.(poffset) / 1 in 
        let ptr := (st.(share).(globals).(g_platform_token_buf) # idx == v) in
        Some(st.[share].[globals].[g_platform_token_buf] :< ptr)) else
    if (p.(pbase) =s "rmm_platform_token") then (
        when ret == store_s_q_useful_buf sz p.(poffset) v st.(share).(globals).(g_rmm_platform_token);
        Some(st.[share].[globals].[g_rmm_platform_token] :< ret)) else
    if (p.(pbase) =s "get_realm_identity_identity") then (
        let idx := p.(poffset) / 1 in 
        let ptr := (st.(share).(globals).(g_get_realm_identity_identity) # idx == v) in
        Some(st.[share].[globals].[g_get_realm_identity_identity] :< ptr)) else
    if (p.(pbase) =s "realm_attest_private_key") then (
        let idx := p.(poffset) / 1 in 
        let ptr := (st.(share).(globals).(g_realm_attest_private_key) # idx == v) in
        Some(st.[share].[globals].[g_realm_attest_private_key] :< ptr)) else 
    if (p.(pbase) =s "granule_data") then (
        let idx := p.(poffset) / 4096 in
        let g_data := (st.(share).(granule_data) @ idx) in
        let elem_ofs := (p.(poffset) mod 4096) in
        let new_g_data := (g_data.[g_norm] :< (g_data.(g_norm) # elem_ofs == v)) in
        let p := (st.(share).(granule_data) # idx == new_g_data) in
        let new_st := (st.[share].[granule_data] :< p) in
        Some(new_st)
    ) 
    None.

(* TODO *)
(* we have a (llvm alloca instruction)-to-(stack variable name) map in the `extractpointer` pass. *)
(** We may integrate this into Spoq in the future or pase it into this alloc_stack function here *)
Definition alloc_stack (fname: string) (sz: Z) (ofs: Z) (st: RData) : option (Ptr * RData) := (* TODO *)
    Some((mkPtr "null" 0), st).

Definition free_stack (fname: string) (init_st: RData) (st: RData) : option RData := Some st. 

Definition new_frame (fname: string) (st: RData) : option RData :=
  Some st.

Hint StackVar attest_token_encode_start v_6 stack_type_2.
Hint StackVar attest_token_encode_finish v_3 stack_s_q_useful_buf.
Hint StackVar rcsm_handle_realm_rsi v_3 stack_s_smc_result.
Hint StackVar rcsm_handle_realm_rsi v_4 stack_s_smc_result__1.
Hint StackVar rsi_data_write v_6 stack_type_3.
Hint StackVar rsi_data_read v_6 stack_type_3.
Hint StackVar rtt_create_internal v_6 stack_s_rtt_walk.
Hint StackVar rsi_rtt_destroy v_5 stack_s_rtt_walk.
Hint StackVar data_create_internal v_7 stack_s_rtt_walk.
Hint StackVar data_create_s1_el1 v_5 stack_type_4.
Hint StackVar data_create_s1_el1 v_6 stack_type_4__1.
Hint StackVar map_unmap_ns_s1 v_6 stack_s_rtt_walk.
Hint StackVar rsi_data_set_attrs v_5 stack_type_3.
Hint StackVar rsi_data_set_attrs v_6 stack_s_rtt_walk.
Hint StackVar rsi_data_destroy v_3 stack_s_rtt_walk.
Hint StackVar rsi_rtt_set_ripas v_5 stack_type_3.
Hint StackVar rsi_rtt_set_ripas v_6 stack_s_rtt_walk.
Hint StackVar handle_realm_rsi v_3 stack_s_psci_result.
Hint StackVar handle_realm_rsi v_4 stack_s_attest_result.
Hint StackVar handle_data_abort v_4 stack_type_3.
Hint StackVar rtt_walk_lock_unlock v_7 stack_type_5.
Hint StackVar rec_run_loop v_3 stack_s_ns_state.
Hint StackVar realm_ipa_to_pa v_6 stack_s_rtt_walk.
Hint StackVar find_lock_two_granules v_7 stack_type_6.
Hint StackVar smc_rec_create v_5 stack_type_4.
Hint StackVar smc_rec_create v_6 stack_type_4__1.
Hint StackVar smc_rec_create v_7 stack_s_rec_params.
Hint StackVar smc_psci_complete v_3 stack_type_4.
Hint StackVar smc_psci_complete v_4 stack_type_4__1.
Hint StackVar smc_bench_latency v_2 stack_s_rmm_trap_element.
Hint StackVar smc_rec_enter v_5 stack_s_rec_entry.
Hint StackVar smc_rec_enter v_6 stack_s_rec_exit.
Hint StackVar smc_realm_create v_3 stack_s_realm_params.
Hint StackVar smc_rtt_create v_5 stack_type_4.
Hint StackVar smc_rtt_create v_6 stack_type_4__1.
Hint StackVar smc_rtt_create v_7 stack_s_realm_s2_context.
Hint StackVar smc_rtt_create v_8 stack_s_rtt_walk__1.
Hint StackVar smc_rtt_fold v_5 stack_s_realm_s2_context.
Hint StackVar smc_rtt_fold v_6 stack_s_rtt_walk.
Hint StackVar smc_rtt_destroy v_5 stack_s_realm_s2_context.
Hint StackVar smc_rtt_destroy v_6 stack_s_rtt_walk.
Hint StackVar smc_rtt_map_protected v_4 stack_s_rtt_walk.
Hint StackVar smc_rtt_unmap_protected v_4 stack_s_realm_s2_context.
Hint StackVar smc_rtt_unmap_protected v_5 stack_s_rtt_walk.
Hint StackVar map_unmap_ns v_6 stack_s_realm_s2_context.
Hint StackVar map_unmap_ns v_7 stack_s_rtt_walk.
Hint StackVar smc_rtt_read_entry v_5 stack_s_rtt_walk.
Hint StackVar data_granule_measure v_5 stack_type_7.
Hint StackVar data_create v_5 stack_type_4.
Hint StackVar data_create v_6 stack_type_4__1.
Hint StackVar data_create v_7 stack_s_rtt_walk.
Hint StackVar smc_data_destroy v_3 stack_s_rtt_walk.
Hint StackVar smc_data_dispose v_5 stack_type_4.
Hint StackVar smc_data_dispose v_6 stack_type_4__1.
Hint StackVar smc_data_dispose v_7 stack_s_rtt_walk.
Hint StackVar attest_create_rmm_attestation_key v_1 stack_s_q_useful_buf.
Hint StackVar attest_create_rmm_attestation_key v_2 stack_type_1.
Hint StackVar attest_create_rmm_attestation_key v_3 stack_s_psa_key_attributes_s.
Hint StackVar create_realm_token v_5 stack_s_q_useful_buf__1.
Hint StackVar create_realm_token v_6 stack_s_attest_token_encode_ctx.
Hint StackVar create_realm_token v_7 stack_s_q_useful_buf__2.
Hint StackVar attest_get_platform_token v_1 stack_s_smc_result.
Hint StackVar attest_get_platform_token v_2 stack_s_q_useful_buf.
Hint StackVar handle_rsi_realm_get_attest_token v_3 stack_type_4.
Hint StackVar handle_rsi_realm_get_attest_token v_4 stack_type_3.
Hint StackVar handle_rsi_realm_get_attest_token v_5 stack_type_3__1.
Hint StackVar handle_rsi_realm_get_attest_token v_6 stack_s_q_useful_buf__3.
Hint StackVar handle_rsi_realm_extend_measurement v_2 stack_type_8.

