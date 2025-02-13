Definition PROJ_NAME: string := "working".
Definition PROJ_BASE: string := "coq/working".

Parameter CPU_ID: Z.

(* Hint OnlyTrans map_unmap_ns_s1. *)
(* Hint OnlyTrans rsi_data_create_unknown_s1. *)
Hint OnlyTrans rsi_data_destroy.
(* Hint OnlyTrans rsi_rtt_create. *)
Hint NoHighSpec true. 
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

(* MAX_ERR must be larger than MEM1_VIRT + MEM1_SIZE to make int_to_ptr work *)
Definition MAX_ERR : Z := 18446744039349813248. (* TODO: check this value *) 
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
(* Definition TT_L1_UPPER_BASE : Z := 68000000. *)
Definition MBEDTLS_MEM_BUF_BASE : Z := 79777792.
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
Definition STACK_TYPE_4_BASE : Z := 110000000.
Definition STACK_TYPE_4__1_BASE : Z := 120000000.
Definition GRANULES_BASE : Z := 130000000.

Definition GRANULE_SIZE : Z := 4096.

Definition MEM0_PHYS : Z := 2147483648.
Definition MEM1_PHYS : Z := 551903297536.
Definition MEM0_VIRT : Z := 18446744007137558528.
Definition MEM1_VIRT : Z := 18446744009285042176.
Definition MEM0_SIZE : Z := 2147483648.
Definition MEM1_SIZE : Z := 4294967296.
Definition NR_GRANULES : Z := 1572864. (*  (MEM0_SIZE + MEM1_SIZE) / GRANULE_SIZE *)


Record s_buffer_alloc_ctx :=
 mks_buffer_alloc_ctx {
    e_buf : Z;
    e_len : Z;
    e_first : Z;
    e_first_free : Z;
    e_verify : Z}.

Definition load_s_buffer_alloc_ctx (sz: Z) (ofs:Z)  (st: s_buffer_alloc_ctx) : option Z := 
  if (ofs =? 0) then Some (st.(e_buf)) else
  if (ofs =? 8) then Some (st.(e_len)) else
  if (ofs =? 16) then Some (st.(e_first)) else
  if (ofs =? 24) then Some (st.(e_first_free)) else
  if (ofs =? 32) then Some (st.(e_verify)) else
  None.

Definition store_s_buffer_alloc_ctx (sz: Z) (ofs:Z) (v:Z)  (st: s_buffer_alloc_ctx) : option s_buffer_alloc_ctx := 
  if (ofs =? 0) then Some (st.[e_buf] :< v) else
  if (ofs =? 8) then Some (st.[e_len] :< v) else
  if (ofs =? 16) then Some (st.[e_first] :< v) else
  if (ofs =? 24) then Some (st.[e_first_free] :< v) else
  if (ofs =? 32) then Some (st.[e_verify] :< v) else
  None.


Record s__memory_header :=
 mks__memory_header {
    e_magic1 : Z;
    e_size : Z;
    e_alloc : Z;
    e_prev : Z;
    e_next : Z;
    e_prev_free : Z;
    e_next_free : Z;
    e_magic2 : Z}.

Definition load_s__memory_header (sz: Z) (ofs:Z)  (st: s__memory_header) : option Z := 
  if (ofs =? 0) then Some (st.(e_magic1)) else
  if (ofs =? 8) then Some (st.(e_size)) else
  if (ofs =? 16) then Some (st.(e_alloc)) else
  if (ofs =? 24) then Some (st.(e_prev)) else
  if (ofs =? 32) then Some (st.(e_next)) else
  if (ofs =? 40) then Some (st.(e_prev_free)) else
  if (ofs =? 48) then Some (st.(e_next_free)) else
  if (ofs =? 56) then Some (st.(e_magic2)) else
  None.

Definition store_s__memory_header (sz: Z) (ofs:Z) (v:Z)  (st: s__memory_header) : option s__memory_header := 
  if (ofs =? 0) then Some (st.[e_magic1] :< v) else
  if (ofs =? 8) then Some (st.[e_size] :< v) else
  if (ofs =? 16) then Some (st.[e_alloc] :< v) else
  if (ofs =? 24) then Some (st.[e_prev] :< v) else
  if (ofs =? 32) then Some (st.[e_next] :< v) else
  if (ofs =? 40) then Some (st.[e_prev_free] :< v) else
  if (ofs =? 48) then Some (st.[e_next_free] :< v) else
  if (ofs =? 56) then Some (st.[e_magic2] :< v) else
  None.


Record s_spinlock_t :=
 mks_spinlock_t {
  (* We need `option Z` if we follow the RMM verification. *)
  e_val : option Z
  (* for now, we use Z to align with the definition *)
  (* e_val : Z *)
}. 

Definition load_s_spinlock_t (sz: Z) (ofs:Z)  (st: s_spinlock_t) : option Z := 
  if (ofs =? 0) then st.(e_val) else
  None.

Definition store_s_spinlock_t (sz: Z) (ofs: Z) (v: Z) (st: s_spinlock_t) : (option s_spinlock_t) :=
  if (ofs =? (0))
  then (Some (st.[e_val] :< (Some(v))))
  else None.



Record s_gic_cpu_state :=
 mks_gic_cpu_state {
    e_ich_ap0r : (ZMap.t Z);
    e_ich_ap1r : (ZMap.t Z);
    e_ich_vmcr : Z;
    e_ich_hcr : Z;
    e_ich_lr : (ZMap.t Z);
    e_ich_misr : Z}.

Definition load_s_gic_cpu_state (sz: Z) (ofs:Z)  (st: s_gic_cpu_state) : option Z := 
  if (ofs >=? 0) && (ofs <? 32) then (
    let idx := (ofs - 0) / 8 in
    Some (st.(e_ich_ap0r) @ idx)) else
  if (ofs >=? 32) && (ofs <? 64) then (
    let idx := (ofs - 32) / 8 in
    Some (st.(e_ich_ap1r) @ idx)) else
  if (ofs =? 64) then Some (st.(e_ich_vmcr)) else
  if (ofs =? 72) then Some (st.(e_ich_hcr)) else
  if (ofs >=? 80) && (ofs <? 208) then (
    let idx := (ofs - 80) / 8 in
    Some (st.(e_ich_lr) @ idx)) else
  if (ofs =? 208) then Some (st.(e_ich_misr)) else
  None.

Definition store_s_gic_cpu_state (sz: Z) (ofs:Z) (v:Z)  (st: s_gic_cpu_state) : option s_gic_cpu_state := 
  if (ofs >=? 0) && (ofs <? 32) then (
    let idx := (ofs - 0) / 8 in
    Some (st.[e_ich_ap0r] :< (st.(e_ich_ap0r) # idx == v))) else
  if (ofs >=? 32) && (ofs <? 64) then (
    let idx := (ofs - 32) / 8 in
    Some (st.[e_ich_ap1r] :< (st.(e_ich_ap1r) # idx == v))) else
  if (ofs =? 64) then Some (st.[e_ich_vmcr] :< v) else
  if (ofs =? 72) then Some (st.[e_ich_hcr] :< v) else
  if (ofs >=? 80) && (ofs <? 208) then (
    let idx := (ofs - 80) / 8 in
    Some (st.[e_ich_lr] :< (st.(e_ich_lr) # idx == v))) else
  if (ofs =? 208) then Some (st.[e_ich_misr] :< v) else
  None.


Record s_smc_handler :=
 mks_smc_handler {
    e_fn_name : Z;
    e_type : Z;
    e_f0 : Z;
    e_f1 : Z;
    e_f2 : Z;
    e_f3 : Z;
    e_f4 : Z;
    e_f1_o : Z;
    e_f2_o : Z;
    e_f3_o : Z;
    e_f4_o : Z;
    e_log_exec : Z;
    e_log_error : Z}.

Definition load_s_smc_handler (sz: Z) (ofs:Z)  (st: s_smc_handler) : option Z := 
  if (ofs =? 0) then Some (st.(e_fn_name)) else
  if (ofs =? 8) then Some (st.(e_type)) else
  if (ofs =? 16) then Some (st.(e_f0)) else
  if (ofs =? 24) then Some (st.(e_f1)) else
  if (ofs =? 32) then Some (st.(e_f2)) else
  if (ofs =? 40) then Some (st.(e_f3)) else
  if (ofs =? 48) then Some (st.(e_f4)) else
  if (ofs =? 56) then Some (st.(e_f1_o)) else
  if (ofs =? 64) then Some (st.(e_f2_o)) else
  if (ofs =? 72) then Some (st.(e_f3_o)) else
  if (ofs =? 80) then Some (st.(e_f4_o)) else
  if (ofs =? 88) then Some (st.(e_log_exec)) else
  if (ofs =? 89) then Some (st.(e_log_error)) else
  None.

Definition store_s_smc_handler (sz: Z) (ofs:Z) (v:Z)  (st: s_smc_handler) : option s_smc_handler := 
  if (ofs =? 0) then Some (st.[e_fn_name] :< v) else
  if (ofs =? 8) then Some (st.[e_type] :< v) else
  if (ofs =? 16) then Some (st.[e_f0] :< v) else
  if (ofs =? 24) then Some (st.[e_f1] :< v) else
  if (ofs =? 32) then Some (st.[e_f2] :< v) else
  if (ofs =? 40) then Some (st.[e_f3] :< v) else
  if (ofs =? 48) then Some (st.[e_f4] :< v) else
  if (ofs =? 56) then Some (st.[e_f1_o] :< v) else
  if (ofs =? 64) then Some (st.[e_f2_o] :< v) else
  if (ofs =? 72) then Some (st.[e_f3_o] :< v) else
  if (ofs =? 80) then Some (st.[e_f4_o] :< v) else
  if (ofs =? 88) then Some (st.[e_log_exec] :< v) else
  if (ofs =? 89) then Some (st.[e_log_error] :< v) else
  None.


Record s_smc_result :=
 mks_smc_result {
    e_x0 : Z;
    e_x1 : Z;
    e_x2 : Z;
    e_x3 : Z}.

Definition load_s_smc_result (sz: Z) (ofs:Z)  (st: s_smc_result) : option Z := 
  if (ofs =? 0) then Some (st.(e_x0)) else
  if (ofs =? 8) then Some (st.(e_x1)) else
  if (ofs =? 16) then Some (st.(e_x2)) else
  if (ofs =? 24) then Some (st.(e_x3)) else
  None.

Definition store_s_smc_result (sz: Z) (ofs:Z) (v:Z)  (st: s_smc_result) : option s_smc_result := 
  if (ofs =? 0) then Some (st.[e_x0] :< v) else
  if (ofs =? 8) then Some (st.[e_x1] :< v) else
  if (ofs =? 16) then Some (st.[e_x2] :< v) else
  if (ofs =? 24) then Some (st.[e_x3] :< v) else
  None.


Record s_rmm_trap_element :=
 mks_rmm_trap_element {
    e_aborted_pc : Z;
    e_new_pc : Z}.

Definition load_s_rmm_trap_element (sz: Z) (ofs:Z)  (st: s_rmm_trap_element) : option Z := 
  if (ofs =? 0) then Some (st.(e_aborted_pc)) else
  if (ofs =? 8) then Some (st.(e_new_pc)) else
  None.

Definition store_s_rmm_trap_element (sz: Z) (ofs:Z) (v:Z)  (st: s_rmm_trap_element) : option s_rmm_trap_element := 
  if (ofs =? 0) then Some (st.[e_aborted_pc] :< v) else
  if (ofs =? 8) then Some (st.[e_new_pc] :< v) else
  None.


Record s_sysreg_handler :=
 mks_sysreg_handler {
    e_esr_mask : Z;
    e_esr_value : Z;
    e_fn : Z}.

Definition load_s_sysreg_handler (sz: Z) (ofs:Z)  (st: s_sysreg_handler) : option Z := 
  if (ofs =? 0) then Some (st.(e_esr_mask)) else
  if (ofs =? 8) then Some (st.(e_esr_value)) else
  if (ofs =? 16) then Some (st.(e_fn)) else
  None.

Definition store_s_sysreg_handler (sz: Z) (ofs:Z) (v:Z)  (st: s_sysreg_handler) : option s_sysreg_handler := 
  if (ofs =? 0) then Some (st.[e_esr_mask] :< v) else
  if (ofs =? 8) then Some (st.[e_esr_value] :< v) else
  if (ofs =? 16) then Some (st.[e_fn] :< v) else
  None.


Record s_common_sysreg_state :=
 mks_common_sysreg_state {
    e_vttbr_el2 : Z;
    e_vtcr_el2 : Z;
    e_hcr_el2_common_flags : Z}.

Definition load_s_common_sysreg_state (sz: Z) (ofs:Z)  (st: s_common_sysreg_state) : option Z := 
  if (ofs =? 0) then Some (st.(e_vttbr_el2)) else
  if (ofs =? 8) then Some (st.(e_vtcr_el2)) else
  if (ofs =? 16) then Some (st.(e_hcr_el2_common_flags)) else
  None.

Definition store_s_common_sysreg_state (sz: Z) (ofs:Z) (v:Z)  (st: s_common_sysreg_state) : option s_common_sysreg_state := 
  if (ofs =? 0) then Some (st.[e_vttbr_el2] :< v) else
  if (ofs =? 8) then Some (st.[e_vtcr_el2] :< v) else
  if (ofs =? 16) then Some (st.[e_hcr_el2_common_flags] :< v) else
  None.


Record s_anon_1 :=
 mks_anon_1 {
    e_s_anon_1_0 : Z;
    e_s_anon_1_1 : Z;
    e_s_anon_1_2 : Z;
    e_s_anon_1_3 : Z}.

Definition load_s_anon_1 (sz: Z) (ofs:Z)  (st: s_anon_1) : option Z := 
  if (ofs =? 0) then Some (st.(e_s_anon_1_0)) else
  if (ofs =? 8) then Some (st.(e_s_anon_1_1)) else
  if (ofs =? 16) then Some (st.(e_s_anon_1_2)) else
  if (ofs =? 24) then Some (st.(e_s_anon_1_3)) else
  None.

Definition store_s_anon_1 (sz: Z) (ofs:Z) (v:Z)  (st: s_anon_1) : option s_anon_1 := 
  if (ofs =? 0) then Some (st.[e_s_anon_1_0] :< v) else
  if (ofs =? 8) then Some (st.[e_s_anon_1_1] :< v) else
  if (ofs =? 16) then Some (st.[e_s_anon_1_2] :< v) else
  if (ofs =? 24) then Some (st.[e_s_anon_1_3] :< v) else
  None.


Record s_anon_0 :=
 mks_anon_0 {
    e_s_anon_0_0 : Z;
    e_s_anon_0_1 : Z;
    e_s_anon_0_2 : Z}.

Definition load_s_anon_0 (sz: Z) (ofs:Z)  (st: s_anon_0) : option Z := 
  if (ofs =? 0) then Some (st.(e_s_anon_0_0)) else
  if (ofs =? 8) then Some (st.(e_s_anon_0_1)) else
  if (ofs =? 16) then Some (st.(e_s_anon_0_2)) else
  None.

Definition store_s_anon_0 (sz: Z) (ofs:Z) (v:Z)  (st: s_anon_0) : option s_anon_0 := 
  if (ofs =? 0) then Some (st.[e_s_anon_0_0] :< v) else
  if (ofs =? 8) then Some (st.[e_s_anon_0_1] :< v) else
  if (ofs =? 16) then Some (st.[e_s_anon_0_2] :< v) else
  None.


Record s_anon_1_2 :=
 mks_anon_1_2 {
    e_s_anon_1_2_0 : Z;
    e_s_anon_1_2_1 : Z;
    e_s_anon_1_2_2 : Z;
    e_g_rd_s_realm_info : Z}.
(* e_g_rd_s_realm_info: g_rd *)
Definition load_s_anon_1_2 (sz: Z) (ofs:Z)  (st: s_anon_1_2) : option Z := 
  if (ofs =? 0) then Some (st.(e_s_anon_1_2_0)) else
  if (ofs =? 8) then Some (st.(e_s_anon_1_2_1)) else
  if (ofs =? 16) then Some (st.(e_s_anon_1_2_2)) else
  if (ofs =? 24) then (
    rely (st.(e_g_rd_s_realm_info) >= GRANULES_BASE);
    rely (st.(e_g_rd_s_realm_info) < MEM0_VIRT);
    Some (st.(e_g_rd_s_realm_info))
  ) else
  None.

Definition store_s_anon_1_2 (sz: Z) (ofs:Z) (v:Z)  (st: s_anon_1_2) : option s_anon_1_2 := 
  if (ofs =? 0) then Some (st.[e_s_anon_1_2_0] :< v) else
  if (ofs =? 8) then Some (st.[e_s_anon_1_2_1] :< v) else
  if (ofs =? 16) then Some (st.[e_s_anon_1_2_2] :< v) else
  if (ofs =? 24) then Some (st.[e_g_rd_s_realm_info] :< v) else
  None.


Record u_anon_3 :=
 mku_anon_3 {
    e_u_anon_3_0 : Z}.

Definition load_u_anon_3 (sz: Z) (ofs:Z)  (st: u_anon_3) : option Z := 
  if (ofs =? 0) then Some (st.(e_u_anon_3_0)) else
  None.

Definition store_u_anon_3 (sz: Z) (ofs:Z) (v:Z)  (st: u_anon_3) : option u_anon_3 := 
  if (ofs =? 0) then Some (st.[e_u_anon_3_0] :< v) else
  None.


Record s_fpu_state :=
 mks_fpu_state {
    e_q : (ZMap.t Z);
    e_fpsr : Z;
    e_fpcr : Z;
    e_used : Z}.

Definition load_s_fpu_state (sz: Z) (ofs:Z)  (st: s_fpu_state) : option Z := 
  if (ofs >=? 0) && (ofs <? 512) then (
    let idx := (ofs - 0) / 16 in
    Some (st.(e_q) @ idx)) else
  if (ofs =? 512) then Some (st.(e_fpsr)) else
  if (ofs =? 520) then Some (st.(e_fpcr)) else
  if (ofs =? 528) then Some (st.(e_used)) else
  None.

Definition store_s_fpu_state (sz: Z) (ofs:Z) (v:Z)  (st: s_fpu_state) : option s_fpu_state := 
  if (ofs >=? 0) && (ofs <? 512) then (
    let idx := (ofs - 0) / 16 in
    Some (st.[e_q] :< (st.(e_q) # idx == v))) else
  if (ofs =? 512) then Some (st.[e_fpsr] :< v) else
  if (ofs =? 520) then Some (st.[e_fpcr] :< v) else
  if (ofs =? 528) then Some (st.[e_used] :< v) else
  None.


Record s_anon_3 :=
 mks_anon_3 {
    e_s_anon_3_0 : Z}.

Definition load_s_anon_3 (sz: Z) (ofs:Z)  (st: s_anon_3) : option Z := 
  if (ofs =? 0) then Some (st.(e_s_anon_3_0)) else
  None.

Definition store_s_anon_3 (sz: Z) (ofs:Z) (v:Z)  (st: s_anon_3) : option s_anon_3 := 
  if (ofs =? 0) then Some (st.[e_s_anon_3_0] :< v) else
  None.


Record s_realm_s1_context :=
 mks_realm_s1_context {
    e_g_ttbr0 : Z;
    e_g_ttbr1 : Z}.

Definition load_s_realm_s1_context (sz: Z) (ofs:Z)  (st: s_realm_s1_context) : option Z := 
  if (ofs =? 0) then 
    ( rely (st.(e_g_ttbr0) >= GRANULES_BASE /\ (st.(e_g_ttbr0)) < MEM0_VIRT);
      Some (st.(e_g_ttbr0))) else
  if (ofs =? 8) then 
    ( rely (st.(e_g_ttbr1) >= GRANULES_BASE /\ (st.(e_g_ttbr1)) < MEM0_VIRT);
      Some (st.(e_g_ttbr1))) else
  None.

Definition store_s_realm_s1_context (sz: Z) (ofs:Z) (v:Z)  (st: s_realm_s1_context) : option s_realm_s1_context := 
  if (ofs =? 0) then Some (st.[e_g_ttbr0] :< v) else
  if (ofs =? 8) then Some (st.[e_g_ttbr1] :< v) else
  None.


Record s_s1tt :=
 mks_s1tt {
    e_s1tte : (ZMap.t Z)}.

Definition load_s_s1tt (sz: Z) (ofs:Z)  (st: s_s1tt) : option Z := 
  if (ofs >=? 0) && (ofs <? 4096) then (
    let idx := (ofs - 0) / 8 in
    Some (st.(e_s1tte) @ idx)) else
  None.

Definition store_s_s1tt (sz: Z) (ofs:Z) (v:Z)  (st: s_s1tt) : option s_s1tt := 
  if (ofs >=? 0) && (ofs <? 4096) then (
    let idx := (ofs - 0) / 8 in
    Some (st.[e_s1tte] :< (st.(e_s1tte) # idx == v))) else
  None.


Record s_q_useful_buf :=
 mks_q_useful_buf {
    e_ptr : Z;
    e_len_s_q_useful_buf : Z}.

Definition load_s_q_useful_buf (sz: Z) (ofs:Z)  (st: s_q_useful_buf) : option Z := 
  if (ofs =? 0) then Some (st.(e_ptr)) else
  if (ofs =? 8) then Some (st.(e_len_s_q_useful_buf)) else
  None.

Definition store_s_q_useful_buf (sz: Z) (ofs:Z) (v:Z)  (st: s_q_useful_buf) : option s_q_useful_buf := 
  if (ofs =? 0) then Some (st.[e_ptr] :< v) else
  if (ofs =? 8) then Some (st.[e_len_s_q_useful_buf] :< v) else
  None.


Record s_std____va_list :=
 mks_std____va_list {
    e_s_std____va_list_0 : Z;
    e_s_std____va_list_1 : Z;
    e_s_std____va_list_2 : Z;
    e_s_std____va_list_3 : Z;
    e_s_std____va_list_4 : Z}.

Definition load_s_std____va_list (sz: Z) (ofs:Z)  (st: s_std____va_list) : option Z := 
  if (ofs =? 0) then Some (st.(e_s_std____va_list_0)) else
  if (ofs =? 8) then Some (st.(e_s_std____va_list_1)) else
  if (ofs =? 16) then Some (st.(e_s_std____va_list_2)) else
  if (ofs =? 24) then Some (st.(e_s_std____va_list_3)) else
  if (ofs =? 28) then Some (st.(e_s_std____va_list_4)) else
  None.

Definition store_s_std____va_list (sz: Z) (ofs:Z) (v:Z)  (st: s_std____va_list) : option s_std____va_list := 
  if (ofs =? 0) then Some (st.[e_s_std____va_list_0] :< v) else
  if (ofs =? 8) then Some (st.[e_s_std____va_list_1] :< v) else
  if (ofs =? 16) then Some (st.[e_s_std____va_list_2] :< v) else
  if (ofs =? 24) then Some (st.[e_s_std____va_list_3] :< v) else
  if (ofs =? 28) then Some (st.[e_s_std____va_list_4] :< v) else
  None.


Record s_out_fct_wrap_type :=
 mks_out_fct_wrap_type {
    e_fct : Z;
    e_arg : Z}.

Definition load_s_out_fct_wrap_type (sz: Z) (ofs:Z)  (st: s_out_fct_wrap_type) : option Z := 
  if (ofs =? 0) then Some (st.(e_fct)) else
  if (ofs =? 8) then Some (st.(e_arg)) else
  None.

Definition store_s_out_fct_wrap_type (sz: Z) (ofs:Z) (v:Z)  (st: s_out_fct_wrap_type) : option s_out_fct_wrap_type := 
  if (ofs =? 0) then Some (st.[e_fct] :< v) else
  if (ofs =? 8) then Some (st.[e_arg] :< v) else
  None.


Record s_mbedtls_sha256_context :=
 mks_mbedtls_sha256_context {
    e_total : (ZMap.t Z);
    e_state : (ZMap.t Z);
    e_buffer : (ZMap.t Z);
    e_is224 : Z}.

Definition load_s_mbedtls_sha256_context (sz: Z) (ofs:Z)  (st: s_mbedtls_sha256_context) : option Z := 
  if (ofs >=? 0) && (ofs <? 8) then (
    let idx := (ofs - 0) / 4 in
    Some (st.(e_total) @ idx)) else
  if (ofs >=? 8) && (ofs <? 40) then (
    let idx := (ofs - 8) / 4 in
    Some (st.(e_state) @ idx)) else
  if (ofs >=? 40) && (ofs <? 104) then (
    let idx := (ofs - 40) / 1 in
    Some (st.(e_buffer) @ idx)) else
  if (ofs =? 104) then Some (st.(e_is224)) else
  None.

Definition store_s_mbedtls_sha256_context (sz: Z) (ofs:Z) (v:Z)  (st: s_mbedtls_sha256_context) : option s_mbedtls_sha256_context := 
  if (ofs >=? 0) && (ofs <? 8) then (
    let idx := (ofs - 0) / 4 in
    Some (st.[e_total] :< (st.(e_total) # idx == v))) else
  if (ofs >=? 8) && (ofs <? 40) then (
    let idx := (ofs - 8) / 4 in
    Some (st.[e_state] :< (st.(e_state) # idx == v))) else
  if (ofs >=? 40) && (ofs <? 104) then (
    let idx := (ofs - 40) / 1 in
    Some (st.[e_buffer] :< (st.(e_buffer) # idx == v))) else
  if (ofs =? 104) then Some (st.[e_is224] :< v) else
  None.


Record u_anon :=
 mku_anon {
    e_u_anon_0 : (ZMap.t Z)}.

Definition load_u_anon (sz: Z) (ofs:Z)  (st: u_anon) : option Z := 
  if (ofs >=? 0) && (ofs <? 32) then (
    let idx := (ofs - 0) / 8 in
    Some (st.(e_u_anon_0) @ idx)) else
  None.

Definition store_u_anon (sz: Z) (ofs:Z) (v:Z)  (st: u_anon) : option u_anon := 
  if (ofs >=? 0) && (ofs <? 32) then (
    let idx := (ofs - 0) / 8 in
    Some (st.[e_u_anon_0] :< (st.(e_u_anon_0) # idx == v))) else
  None.


Record s_anon :=
 mks_anon {
    e_s_anon_0 : Z;
    e_s_anon_1 : Z;
    e_s_anon_2 : Z}.

Definition load_s_anon (sz: Z) (ofs:Z)  (st: s_anon) : option Z := 
  if (ofs =? 0) then Some (st.(e_s_anon_0)) else
  if (ofs =? 4) then Some (st.(e_s_anon_1)) else
  if (ofs =? 6) then Some (st.(e_s_anon_2)) else
  None.

Definition store_s_anon (sz: Z) (ofs:Z) (v:Z)  (st: s_anon) : option s_anon := 
  if (ofs =? 0) then Some (st.[e_s_anon_0] :< v) else
  if (ofs =? 4) then Some (st.[e_s_anon_1] :< v) else
  if (ofs =? 6) then Some (st.[e_s_anon_2] :< v) else
  None.


Record u_anon_0 :=
 mku_anon_0 {
    e_u_anon_0_0 : Z}.

Definition load_u_anon_0 (sz: Z) (ofs:Z)  (st: u_anon_0) : option Z := 
  if (ofs =? 0) then Some (st.(e_u_anon_0_0)) else
  None.

Definition store_u_anon_0 (sz: Z) (ofs:Z) (v:Z)  (st: u_anon_0) : option u_anon_0 := 
  if (ofs =? 0) then Some (st.[e_u_anon_0_0] :< v) else
  None.


Record s_return_code_t :=
 mks_return_code_t {
    e_status : Z;
    e_index : Z}.

Definition load_s_return_code_t (sz: Z) (ofs:Z)  (st: s_return_code_t) : option Z := 
  if (ofs =? 0) then Some (st.(e_status)) else
  if (ofs =? 4) then Some (st.(e_index)) else
  None.

Definition store_s_return_code_t (sz: Z) (ofs:Z) (v:Z)  (st: s_return_code_t) : option s_return_code_t := 
  if (ofs =? 0) then Some (st.[e_status] :< v) else
  if (ofs =? 4) then Some (st.[e_index] :< v) else
  None.


Record s_rtt_walk :=
 mks_rtt_walk {
    e_g_llt : Z;
    e_index_s_rtt_walk : Z;
    e_last_level : Z}.

Definition load_s_rtt_walk (sz: Z) (ofs:Z)  (st: s_rtt_walk) : option Z := 
  if (ofs =? 0) then (
    rely (st.(e_g_llt) >= GRANULES_BASE);
    rely (st.(e_g_llt) < MEM0_VIRT);
    Some (st.(e_g_llt))) else
  if (ofs =? 8) then Some (st.(e_index_s_rtt_walk)) else
  if (ofs =? 16) then Some (st.(e_last_level)) else
  None.

Definition store_s_rtt_walk (sz: Z) (ofs:Z) (v:Z)  (st: s_rtt_walk) : option s_rtt_walk := 
  if (ofs =? 0) then Some (st.[e_g_llt] :< v) else
  if (ofs =? 8) then Some (st.[e_index_s_rtt_walk] :< v) else
  if (ofs =? 16) then Some (st.[e_last_level] :< v) else
  None.


Record s_realm_s2_context :=
 mks_realm_s2_context {
    e_ipa_bits : Z;
    e_s2_starting_level : Z;
    e_num_root_rtts : Z;
    e_g_rtt : Z;
    e_vmid : Z}.

Definition load_s_realm_s2_context (sz: Z) (ofs:Z)  (st: s_realm_s2_context) : option Z := 
  if (ofs =? 0) then Some (st.(e_ipa_bits)) else
  if (ofs =? 4) then Some (st.(e_s2_starting_level)) else
  if (ofs =? 8) then Some (st.(e_num_root_rtts)) else
  if (ofs =? 16) then (
    rely (st.(e_g_rtt) >= GRANULES_BASE);
    rely (st.(e_g_rtt) < MEM0_VIRT);
    Some (st.(e_g_rtt))
  ) else
  if (ofs =? 24) then Some (st.(e_vmid)) else
  None.

Definition store_s_realm_s2_context (sz: Z) (ofs:Z) (v:Z)  (st: s_realm_s2_context) : option s_realm_s2_context := 
  if (ofs =? 0) then Some (st.[e_ipa_bits] :< v) else
  if (ofs =? 4) then Some (st.[e_s2_starting_level] :< v) else
  if (ofs =? 8) then Some (st.[e_num_root_rtts] :< v) else
  if (ofs =? 16) then Some (st.[e_g_rtt] :< v) else
  if (ofs =? 24) then Some (st.[e_vmid] :< v) else
  None.


Record s_anon_5 :=
 mks_anon_5 {
    e_s_anon_5_0 : Z;
    e_s_anon_5_1 : Z;
    e_s_anon_5_2 : Z;
    e_s_anon_5_3 : Z}.

Definition load_s_anon_5 (sz: Z) (ofs:Z)  (st: s_anon_5) : option Z := 
  if (ofs =? 0) then Some (st.(e_s_anon_5_0)) else
  if (ofs =? 8) then Some (st.(e_s_anon_5_1)) else
  if (ofs =? 16) then Some (st.(e_s_anon_5_2)) else
  if (ofs =? 24) then Some (st.(e_s_anon_5_3)) else
  None.

Definition store_s_anon_5 (sz: Z) (ofs:Z) (v:Z)  (st: s_anon_5) : option s_anon_5 := 
  if (ofs =? 0) then Some (st.[e_s_anon_5_0] :< v) else
  if (ofs =? 8) then Some (st.[e_s_anon_5_1] :< v) else
  if (ofs =? 16) then Some (st.[e_s_anon_5_2] :< v) else
  if (ofs =? 24) then Some (st.[e_s_anon_5_3] :< v) else
  None.


Record s_rec_entry :=
 mks_rec_entry {
    e_gprs : (ZMap.t Z);
    e_is_emulated_mmio : Z;
    e_emulated_read_val : Z;
    e_dispose_response : Z;
    e_gicv3_lrs : (ZMap.t Z);
    e_gicv3_hcr : Z;
    e_trap_wfi : Z;
    e_trap_wfe : Z}.

Definition load_s_rec_entry (sz: Z) (ofs:Z)  (st: s_rec_entry) : option Z := 
  if (ofs >=? 0) && (ofs <? 56) then (
    let idx := (ofs - 0) / 8 in
    Some (st.(e_gprs) @ idx)) else
  if (ofs =? 56) then Some (st.(e_is_emulated_mmio)) else
  if (ofs =? 64) then Some (st.(e_emulated_read_val)) else
  if (ofs =? 72) then Some (st.(e_dispose_response)) else
  if (ofs >=? 80) && (ofs <? 208) then (
    let idx := (ofs - 80) / 8 in
    Some (st.(e_gicv3_lrs) @ idx)) else
  if (ofs =? 208) then Some (st.(e_gicv3_hcr)) else
  if (ofs =? 216) then Some (st.(e_trap_wfi)) else
  if (ofs =? 224) then Some (st.(e_trap_wfe)) else
  None.

Definition store_s_rec_entry (sz: Z) (ofs:Z) (v:Z)  (st: s_rec_entry) : option s_rec_entry := 
  if (ofs >=? 0) && (ofs <? 56) then (
    let idx := (ofs - 0) / 8 in
    Some (st.[e_gprs] :< (st.(e_gprs) # idx == v))) else
  if (ofs =? 56) then Some (st.[e_is_emulated_mmio] :< v) else
  if (ofs =? 64) then Some (st.[e_emulated_read_val] :< v) else
  if (ofs =? 72) then Some (st.[e_dispose_response] :< v) else
  if (ofs >=? 80) && (ofs <? 208) then (
    let idx := (ofs - 80) / 8 in
    Some (st.[e_gicv3_lrs] :< (st.(e_gicv3_lrs) # idx == v))) else
  if (ofs =? 208) then Some (st.[e_gicv3_hcr] :< v) else
  if (ofs =? 216) then Some (st.[e_trap_wfi] :< v) else
  if (ofs =? 224) then Some (st.[e_trap_wfe] :< v) else
  None.


Record s_granule_set :=
 mks_granule_set {
    e_idx : Z;
    e_addr : Z;
    e_state_s_granule_set : Z;
    e_g : Z;
    e_g_ret : Z}.

Definition load_s_granule_set (sz: Z) (ofs:Z)  (st: s_granule_set) : option Z := 
  if (ofs =? 0) then Some (st.(e_idx)) else
  if (ofs =? 8) then Some (st.(e_addr)) else
  if (ofs =? 16) then Some (st.(e_state_s_granule_set)) else
  if (ofs =? 24) then Some (st.(e_g)) else
  if (ofs =? 32) then Some (st.(e_g_ret)) else
  None.

Definition store_s_granule_set (sz: Z) (ofs:Z) (v:Z)  (st: s_granule_set) : option s_granule_set := 
  if (ofs =? 0) then Some (st.[e_idx] :< v) else
  if (ofs =? 8) then Some (st.[e_addr] :< v) else
  if (ofs =? 16) then Some (st.[e_state_s_granule_set] :< v) else
  if (ofs =? 24) then Some (st.[e_g] :< v) else
  if (ofs =? 32) then Some (st.[e_g_ret] :< v) else
  None.


Record s_rec_params :=
 mks_rec_params {
    e_gprs_s_rec_params : (ZMap.t Z);
    e_pc : Z;
    e_flags : Z;
    e_is_pico : Z;
    e_rtt : Z;
    e_vbar_el1 : Z}.

Definition load_s_rec_params (sz: Z) (ofs:Z)  (st: s_rec_params) : option Z := 
  if (ofs >=? 0) && (ofs <? 248) then (
    let idx := (ofs - 0) / 8 in
    Some (st.(e_gprs_s_rec_params) @ idx)) else
  if (ofs =? 248) then Some (st.(e_pc)) else
  if (ofs =? 256) then Some (st.(e_flags)) else
  if (ofs =? 264) then Some (st.(e_is_pico)) else
  if (ofs =? 272) then Some (st.(e_rtt)) else
  if (ofs =? 280) then Some (st.(e_vbar_el1)) else
  None.

Definition store_s_rec_params (sz: Z) (ofs:Z) (v:Z)  (st: s_rec_params) : option s_rec_params := 
  if (ofs >=? 0) && (ofs <? 248) then (
    let idx := (ofs - 0) / 8 in
    Some (st.[e_gprs_s_rec_params] :< (st.(e_gprs_s_rec_params) # idx == v))) else
  if (ofs =? 248) then Some (st.[e_pc] :< v) else
  if (ofs =? 256) then Some (st.[e_flags] :< v) else
  if (ofs =? 264) then Some (st.[e_is_pico] :< v) else
  if (ofs =? 272) then Some (st.[e_rtt] :< v) else
  if (ofs =? 280) then Some (st.[e_vbar_el1] :< v) else
  None.


Record s_realm_params :=
 mks_realm_params {
    e_par_base : Z;
    e_par_size : Z;
    e_rtt_addr : Z;
    e_measurement_algo : Z;
    e_realm_feat_0 : Z;
    e_s2_starting_level_s_realm_params : Z;
    e_num_s2_sl_rtts : Z;
    e_vmid_s_realm_params : Z;
    e_is_rc : Z}.

Definition load_s_realm_params (sz: Z) (ofs:Z)  (st: s_realm_params) : option Z := 
  if (ofs =? 0) then Some (st.(e_par_base)) else
  if (ofs =? 8) then Some (st.(e_par_size)) else
  if (ofs =? 16) then Some (st.(e_rtt_addr)) else
  if (ofs =? 24) then Some (st.(e_measurement_algo)) else
  if (ofs =? 32) then Some (st.(e_realm_feat_0)) else
  if (ofs =? 40) then Some (st.(e_s2_starting_level_s_realm_params)) else
  if (ofs =? 48) then Some (st.(e_num_s2_sl_rtts)) else
  if (ofs =? 52) then Some (st.(e_vmid_s_realm_params)) else
  if (ofs =? 56) then Some (st.(e_is_rc)) else
  None.

Definition store_s_realm_params (sz: Z) (ofs:Z) (v:Z)  (st: s_realm_params) : option s_realm_params := 
  if (ofs =? 0) then Some (st.[e_par_base] :< v) else
  if (ofs =? 8) then Some (st.[e_par_size] :< v) else
  if (ofs =? 16) then Some (st.[e_rtt_addr] :< v) else
  if (ofs =? 24) then Some (st.[e_measurement_algo] :< v) else
  if (ofs =? 32) then Some (st.[e_realm_feat_0] :< v) else
  if (ofs =? 40) then Some (st.[e_s2_starting_level_s_realm_params] :< v) else
  if (ofs =? 48) then Some (st.[e_num_s2_sl_rtts] :< v) else
  if (ofs =? 52) then Some (st.[e_vmid_s_realm_params] :< v) else
  if (ofs =? 56) then Some (st.[e_is_rc] :< v) else
  None.


Record s_psa_key_policy_s :=
 mks_psa_key_policy_s {
    e_usage : Z;
    e_alg : Z;
    e_alg2 : Z}.

Definition load_s_psa_key_policy_s (sz: Z) (ofs:Z)  (st: s_psa_key_policy_s) : option Z := 
  if (ofs =? 0) then Some (st.(e_usage)) else
  if (ofs =? 4) then Some (st.(e_alg)) else
  if (ofs =? 8) then Some (st.(e_alg2)) else
  None.

Definition store_s_psa_key_policy_s (sz: Z) (ofs:Z) (v:Z)  (st: s_psa_key_policy_s) : option s_psa_key_policy_s := 
  if (ofs =? 0) then Some (st.[e_usage] :< v) else
  if (ofs =? 4) then Some (st.[e_alg] :< v) else
  if (ofs =? 8) then Some (st.[e_alg2] :< v) else
  None.


Record s_sysreg_state :=
 mks_sysreg_state {
    e_sp_el0 : Z;
    e_sp_el1 : Z;
    e_elr_el1 : Z;
    e_spsr_el2 : Z;
    e_spsr_el1 : Z;
    e_pmcr_el0 : Z;
    e_pmuserenr_el0 : Z;
    e_tpidrro_el0 : Z;
    e_tpidr_el0 : Z;
    e_csselr_el1 : Z;
    e_sctlr_el1 : Z;
    e_actlr_el1 : Z;
    e_cpacr_el1 : Z;
    e_zcr_el1 : Z;
    e_ttbr0_el1 : Z;
    e_ttbr1_el1 : Z;
    e_tcr_el1 : Z;
    e_esr_el1 : Z;
    e_afsr0_el1 : Z;
    e_afsr1_el1 : Z;
    e_far_el1 : Z;
    e_mair_el1 : Z;
    e_vbar_el1_s_sysreg_state : Z;
    e_contextidr_el1 : Z;
    e_tpidr_el1 : Z;
    e_amair_el1 : Z;
    e_cntkctl_el1 : Z;
    e_par_el1 : Z;
    e_mdscr_el1 : Z;
    e_mdccint_el1 : Z;
    e_disr_el1 : Z;
    e_mpam0_el1 : Z;
    e_cnthctl_el2 : Z;
    e_cntvoff_el2 : Z;
    e_cntp_ctl_el0 : Z;
    e_cntp_cval_el0 : Z;
    e_cntv_ctl_el0 : Z;
    e_cntv_cval_el0 : Z;
    e_gicstate : s_gic_cpu_state;
    e_vmpidr_el2 : Z;
    e_hcr_el2 : Z;
    e_cptr_el2 : Z;
    e_tcr_el2 : Z;
    e_sctlr_el2 : Z}.

Definition load_s_sysreg_state (sz: Z) (ofs:Z)  (st: s_sysreg_state) : option Z := 
  if (ofs =? 0) then Some (st.(e_sp_el0)) else
  if (ofs =? 8) then Some (st.(e_sp_el1)) else
  if (ofs =? 16) then Some (st.(e_elr_el1)) else
  if (ofs =? 24) then Some (st.(e_spsr_el1)) else
  if (ofs =? 32) then Some (st.(e_pmcr_el0)) else
  if (ofs =? 40) then Some (st.(e_pmuserenr_el0)) else
  if (ofs =? 48) then Some (st.(e_tpidrro_el0)) else
  if (ofs =? 56) then Some (st.(e_tpidr_el0)) else
  if (ofs =? 64) then Some (st.(e_csselr_el1)) else
  if (ofs =? 72) then Some (st.(e_sctlr_el1)) else
  if (ofs =? 80) then Some (st.(e_actlr_el1)) else
  if (ofs =? 88) then Some (st.(e_cpacr_el1)) else
  if (ofs =? 96) then Some (st.(e_zcr_el1)) else
  if (ofs =? 104) then Some (st.(e_ttbr0_el1)) else
  if (ofs =? 112) then Some (st.(e_ttbr1_el1)) else
  if (ofs =? 120) then Some (st.(e_tcr_el1)) else
  if (ofs =? 128) then Some (st.(e_esr_el1)) else
  if (ofs =? 136) then Some (st.(e_afsr0_el1)) else
  if (ofs =? 144) then Some (st.(e_afsr1_el1)) else
  if (ofs =? 152) then Some (st.(e_far_el1)) else
  if (ofs =? 160) then Some (st.(e_mair_el1)) else
  if (ofs =? 168) then Some (st.(e_vbar_el1_s_sysreg_state)) else
  if (ofs =? 176) then Some (st.(e_contextidr_el1)) else
  if (ofs =? 184) then Some (st.(e_tpidr_el1)) else
  if (ofs =? 192) then Some (st.(e_amair_el1)) else
  if (ofs =? 200) then Some (st.(e_cntkctl_el1)) else
  if (ofs =? 208) then Some (st.(e_par_el1)) else
  if (ofs =? 216) then Some (st.(e_mdscr_el1)) else
  if (ofs =? 224) then Some (st.(e_mdccint_el1)) else
  if (ofs =? 232) then Some (st.(e_disr_el1)) else
  if (ofs =? 240) then Some (st.(e_mpam0_el1)) else
  if (ofs =? 248) then Some (st.(e_cnthctl_el2)) else
  if (ofs =? 256) then Some (st.(e_cntvoff_el2)) else
  if (ofs =? 264) then Some (st.(e_cntp_ctl_el0)) else
  if (ofs =? 272) then Some (st.(e_cntp_cval_el0)) else
  if (ofs =? 280) then Some (st.(e_cntv_ctl_el0)) else
  if (ofs =? 288) then Some (st.(e_cntv_cval_el0)) else
  if (ofs >=? 296) && (ofs <? 512) then (
    let elem_ofs := ofs - 296 in
    load_s_gic_cpu_state sz elem_ofs (st.(e_gicstate))) else
  if (ofs =? 512) then Some (st.(e_vmpidr_el2)) else
  if (ofs =? 520) then Some (st.(e_hcr_el2)) else
  if (ofs =? 528) then Some (st.(e_cptr_el2)) else
  if (ofs =? 536) then Some (st.(e_tcr_el2)) else
  if (ofs =? 544) then Some (st.(e_sctlr_el2)) else
  None.

Definition store_s_sysreg_state (sz: Z) (ofs:Z) (v:Z)  (st: s_sysreg_state) : option s_sysreg_state := 
  if (ofs =? 0) then Some (st.[e_sp_el0] :< v) else
  if (ofs =? 8) then Some (st.[e_sp_el1] :< v) else
  if (ofs =? 16) then Some (st.[e_elr_el1] :< v) else
  if (ofs =? 24) then Some (st.[e_spsr_el1] :< v) else
  if (ofs =? 32) then Some (st.[e_pmcr_el0] :< v) else
  if (ofs =? 40) then Some (st.[e_pmuserenr_el0] :< v) else
  if (ofs =? 48) then Some (st.[e_tpidrro_el0] :< v) else
  if (ofs =? 56) then Some (st.[e_tpidr_el0] :< v) else
  if (ofs =? 64) then Some (st.[e_csselr_el1] :< v) else
  if (ofs =? 72) then Some (st.[e_sctlr_el1] :< v) else
  if (ofs =? 80) then Some (st.[e_actlr_el1] :< v) else
  if (ofs =? 88) then Some (st.[e_cpacr_el1] :< v) else
  if (ofs =? 96) then Some (st.[e_zcr_el1] :< v) else
  if (ofs =? 104) then Some (st.[e_ttbr0_el1] :< v) else
  if (ofs =? 112) then Some (st.[e_ttbr1_el1] :< v) else
  if (ofs =? 120) then Some (st.[e_tcr_el1] :< v) else
  if (ofs =? 128) then Some (st.[e_esr_el1] :< v) else
  if (ofs =? 136) then Some (st.[e_afsr0_el1] :< v) else
  if (ofs =? 144) then Some (st.[e_afsr1_el1] :< v) else
  if (ofs =? 152) then Some (st.[e_far_el1] :< v) else
  if (ofs =? 160) then Some (st.[e_mair_el1] :< v) else
  if (ofs =? 168) then Some (st.[e_vbar_el1_s_sysreg_state] :< v) else
  if (ofs =? 176) then Some (st.[e_contextidr_el1] :< v) else
  if (ofs =? 184) then Some (st.[e_tpidr_el1] :< v) else
  if (ofs =? 192) then Some (st.[e_amair_el1] :< v) else
  if (ofs =? 200) then Some (st.[e_cntkctl_el1] :< v) else
  if (ofs =? 208) then Some (st.[e_par_el1] :< v) else
  if (ofs =? 216) then Some (st.[e_mdscr_el1] :< v) else
  if (ofs =? 224) then Some (st.[e_mdccint_el1] :< v) else
  if (ofs =? 232) then Some (st.[e_disr_el1] :< v) else
  if (ofs =? 240) then Some (st.[e_mpam0_el1] :< v) else
  if (ofs =? 248) then Some (st.[e_cnthctl_el2] :< v) else
  if (ofs =? 256) then Some (st.[e_cntvoff_el2] :< v) else
  if (ofs =? 264) then Some (st.[e_cntp_ctl_el0] :< v) else
  if (ofs =? 272) then Some (st.[e_cntp_cval_el0] :< v) else
  if (ofs =? 280) then Some (st.[e_cntv_ctl_el0] :< v) else
  if (ofs =? 288) then Some (st.[e_cntv_cval_el0] :< v) else
  if (ofs >=? 296) && (ofs <? 512) then (
    let elem_ofs := ofs - 296 in
    when ret == store_s_gic_cpu_state sz elem_ofs v st.(e_gicstate);
    Some (st.[e_gicstate] :< ret)) else 
  if (ofs =? 512) then Some (st.[e_vmpidr_el2] :< v) else
  if (ofs =? 520) then Some (st.[e_hcr_el2] :< v) else
  if (ofs =? 528) then Some (st.[e_cptr_el2] :< v) else
  if (ofs =? 536) then Some (st.[e_tcr_el2] :< v) else
  if (ofs =? 544) then Some (st.[e_sctlr_el2] :< v) else
  None.


Record s_rec_exit :=
 mks_rec_exit {
    e_exit_reason : Z;
    e_esr : Z;
    e_far : Z;
    e_hpfar : Z;
    e_emulated_write_val : Z;
    e_gprs_s_rec_exit : (ZMap.t Z);
    e_target_rec : Z;
    e_disposed_addr : Z;
    e_disposed_size : Z;
    e_gicv3_vmcr : Z;
    e_gicv3_misr : Z;
    e_timer_info : s_smc_result;
    e_gicv3_lrs_s_rec_exit : (ZMap.t Z);
    e_gicv3_hcr_s_rec_exit : Z}.

Definition load_s_rec_exit (sz: Z) (ofs:Z)  (st: s_rec_exit) : option Z := 
  if (ofs =? 0) then Some (st.(e_exit_reason)) else
  if (ofs =? 8) then Some (st.(e_esr)) else
  if (ofs =? 16) then Some (st.(e_far)) else
  if (ofs =? 24) then Some (st.(e_hpfar)) else
  if (ofs =? 32) then Some (st.(e_emulated_write_val)) else
  if (ofs >=? 40) && (ofs <? 96) then (
    let idx := (ofs - 40) / 8 in
    Some (st.(e_gprs_s_rec_exit) @ idx)) else
  if (ofs =? 96) then Some (st.(e_target_rec)) else
  if (ofs =? 104) then Some (st.(e_disposed_addr)) else
  if (ofs =? 112) then Some (st.(e_disposed_size)) else
  if (ofs =? 120) then Some (st.(e_gicv3_vmcr)) else
  if (ofs =? 128) then Some (st.(e_gicv3_misr)) else
  if (ofs >=? 136) && (ofs <? 168) then (
    let elem_ofs := ofs - 136 in
    load_s_smc_result sz elem_ofs (st.(e_timer_info))) else
  if (ofs >=? 168) && (ofs <? 296) then (
    let idx := (ofs - 168) / 8 in
    Some (st.(e_gicv3_lrs_s_rec_exit) @ idx)) else
  if (ofs =? 296) then Some (st.(e_gicv3_hcr_s_rec_exit)) else
  None.

Definition store_s_rec_exit (sz: Z) (ofs:Z) (v:Z)  (st: s_rec_exit) : option s_rec_exit := 
  if (ofs =? 0) then Some (st.[e_exit_reason] :< v) else
  if (ofs =? 8) then Some (st.[e_esr] :< v) else
  if (ofs =? 16) then Some (st.[e_far] :< v) else
  if (ofs =? 24) then Some (st.[e_hpfar] :< v) else
  if (ofs =? 32) then Some (st.[e_emulated_write_val] :< v) else
  if (ofs >=? 40) && (ofs <? 96) then (
    let idx := (ofs - 40) / 8 in
    Some (st.[e_gprs_s_rec_exit] :< (st.(e_gprs_s_rec_exit) # idx == v))) else
  if (ofs =? 96) then Some (st.[e_target_rec] :< v) else
  if (ofs =? 104) then Some (st.[e_disposed_addr] :< v) else
  if (ofs =? 112) then Some (st.[e_disposed_size] :< v) else
  if (ofs =? 120) then Some (st.[e_gicv3_vmcr] :< v) else
  if (ofs =? 128) then Some (st.[e_gicv3_misr] :< v) else
  if (ofs >=? 136) && (ofs <? 168) then (
    let elem_ofs := ofs - 136 in
    when ret == store_s_smc_result sz elem_ofs v st.(e_timer_info);
    Some (st.[e_timer_info] :< ret)) else 
  if (ofs >=? 168) && (ofs <? 296) then (
    let idx := (ofs - 168) / 8 in
    Some (st.[e_gicv3_lrs_s_rec_exit] :< (st.(e_gicv3_lrs_s_rec_exit) # idx == v))) else
  if (ofs =? 296) then Some (st.[e_gicv3_hcr_s_rec_exit] :< v) else
  None.


Record s_attest_result :=
 mks_attest_result {
    e_return_to_realm : Z;
    e_rtt_level : Z;
    e_smc_result : s_smc_result}.

Definition load_s_attest_result (sz: Z) (ofs:Z)  (st: s_attest_result) : option Z := 
  if (ofs =? 0) then Some (st.(e_return_to_realm)) else
  if (ofs =? 8) then Some (st.(e_rtt_level)) else
  if (ofs >=? 16) && (ofs <? 48) then (
    let elem_ofs := ofs - 16 in
    load_s_smc_result sz elem_ofs (st.(e_smc_result))) else
  None.

Definition store_s_attest_result (sz: Z) (ofs:Z) (v:Z)  (st: s_attest_result) : option s_attest_result := 
  if (ofs =? 0) then Some (st.[e_return_to_realm] :< v) else
  if (ofs =? 8) then Some (st.[e_rtt_level] :< v) else
  if (ofs >=? 16) && (ofs <? 48) then (
    let elem_ofs := ofs - 16 in
    when ret == store_s_smc_result sz elem_ofs v st.(e_smc_result);
    Some (st.[e_smc_result] :< ret)) else 
  None.


Record s_granule :=
 mks_granule {
    e_lock : s_spinlock_t;
    e_state_s_granule : Z;
    e_ref : u_anon_3}.

Definition load_s_granule (sz: Z) (ofs:Z)  (st: s_granule) : option Z := 
  if (ofs >=? 0) && (ofs <? 4) then (
    let elem_ofs := ofs - 0 in
    load_s_spinlock_t sz elem_ofs (st.(e_lock))) else
  if (ofs =? 4) then Some (st.(e_state_s_granule)) else
  if (ofs >=? 8) && (ofs <? 16) then (
    let elem_ofs := ofs - 8 in
    load_u_anon_3 sz elem_ofs (st.(e_ref))) else
  None.

Definition store_s_granule (sz: Z) (ofs:Z) (v:Z)  (st: s_granule) : option s_granule := 
  if (ofs >=? 0) && (ofs <? 4) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_spinlock_t sz elem_ofs v st.(e_lock);
    Some (st.[e_lock] :< ret)) else 
  if (ofs =? 4) then Some (st.[e_state_s_granule] :< v) else
  if (ofs >=? 8) && (ofs <? 16) then (
    let elem_ofs := ofs - 8 in
    when ret == store_u_anon_3 sz elem_ofs v st.(e_ref);
    Some (st.[e_ref] :< ret)) else 
  None.


Record s_useful_out_buf :=
 mks_useful_out_buf {
    e_UB : s_q_useful_buf;
    e_data_len : Z;
    e_magic : Z;
    e_err : Z}.

Definition load_s_useful_out_buf (sz: Z) (ofs:Z)  (st: s_useful_out_buf) : option Z := 
  if (ofs >=? 0) && (ofs <? 16) then (
    let elem_ofs := ofs - 0 in
    load_s_q_useful_buf sz elem_ofs (st.(e_UB))) else
  if (ofs =? 16) then Some (st.(e_data_len)) else
  if (ofs =? 24) then Some (st.(e_magic)) else
  if (ofs =? 26) then Some (st.(e_err)) else
  None.

Definition store_s_useful_out_buf (sz: Z) (ofs:Z) (v:Z)  (st: s_useful_out_buf) : option s_useful_out_buf := 
  if (ofs >=? 0) && (ofs <? 16) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_q_useful_buf sz elem_ofs v st.(e_UB);
    Some (st.[e_UB] :< ret)) else 
  if (ofs =? 16) then Some (st.[e_data_len] :< v) else
  if (ofs =? 24) then Some (st.[e_magic] :< v) else
  if (ofs =? 26) then Some (st.[e_err] :< v) else
  None.


Record s_measurement_ctx :=
 mks_measurement_ctx {
    e_c : s_mbedtls_sha256_context;
    e_measurement_algo_s_measurement_ctx : Z}.

Definition load_s_measurement_ctx (sz: Z) (ofs:Z)  (st: s_measurement_ctx) : option Z := 
  if (ofs >=? 0) && (ofs <? 108) then (
    let elem_ofs := ofs - 0 in
    load_s_mbedtls_sha256_context sz elem_ofs (st.(e_c))) else
  if (ofs =? 108) then Some (st.(e_measurement_algo_s_measurement_ctx)) else
  None.

Definition store_s_measurement_ctx (sz: Z) (ofs:Z) (v:Z)  (st: s_measurement_ctx) : option s_measurement_ctx := 
  if (ofs >=? 0) && (ofs <? 108) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_mbedtls_sha256_context sz elem_ofs v st.(e_c);
    Some (st.[e_c] :< ret)) else 
  if (ofs =? 108) then Some (st.[e_measurement_algo_s_measurement_ctx] :< v) else
  None.


Record s_measurement :=
 mks_measurement {
    e_0 : u_anon}.

Definition load_s_measurement (sz: Z) (ofs:Z)  (st: s_measurement) : option Z := 
  if (ofs >=? 0) && (ofs <? 32) then (
    let elem_ofs := ofs - 0 in
    load_u_anon sz elem_ofs (st.(e_0))) else
  None.

Definition store_s_measurement (sz: Z) (ofs:Z) (v:Z)  (st: s_measurement) : option s_measurement := 
  if (ofs >=? 0) && (ofs <? 32) then (
    let elem_ofs := ofs - 0 in
    when ret == store_u_anon sz elem_ofs v st.(e_0);
    Some (st.[e_0] :< ret)) else 
  None.


Record s___QCBORTrackNesting :=
 mks___QCBORTrackNesting {
    e_pArrays : (ZMap.t s_anon);
    e_pCurrentNesting : Z}.

Definition load_s___QCBORTrackNesting (sz: Z) (ofs:Z)  (st: s___QCBORTrackNesting) : option Z := 
  if (ofs >=? 0) && (ofs <? 128) then (
    let idx := (ofs - 0) / 8 in
    let elem_ofs := (ofs - 0) mod 8 in
    load_s_anon sz elem_ofs (st.(e_pArrays) @ idx)) else
  if (ofs =? 128) then Some (st.(e_pCurrentNesting)) else
  None.

Definition store_s___QCBORTrackNesting (sz: Z) (ofs:Z) (v:Z)  (st: s___QCBORTrackNesting) : option s___QCBORTrackNesting := 
  if (ofs >=? 0) && (ofs <? 128) then (
    let idx := (ofs - 0) / 8 in
    let elem_ofs := (ofs - 0) mod 8 in
    when ret == store_s_anon sz elem_ofs v (st.(e_pArrays) @ idx);
    Some (st.[e_pArrays] :< (st.(e_pArrays) # idx == ret))) else 
  if (ofs =? 128) then Some (st.[e_pCurrentNesting] :< v) else
  None.


Record s_t_cose_key :=
 mks_t_cose_key {
    e_crypto_lib : Z;
    e_k : u_anon_0}.

Definition load_s_t_cose_key (sz: Z) (ofs:Z)  (st: s_t_cose_key) : option Z := 
  if (ofs =? 0) then Some (st.(e_crypto_lib)) else
  if (ofs >=? 8) && (ofs <? 16) then (
    let elem_ofs := ofs - 8 in
    load_u_anon_0 sz elem_ofs (st.(e_k))) else
  None.

Definition store_s_t_cose_key (sz: Z) (ofs:Z) (v:Z)  (st: s_t_cose_key) : option s_t_cose_key := 
  if (ofs =? 0) then Some (st.[e_crypto_lib] :< v) else
  if (ofs >=? 8) && (ofs <? 16) then (
    let elem_ofs := ofs - 8 in
    when ret == store_u_anon_0 sz elem_ofs v st.(e_k);
    Some (st.[e_k] :< ret)) else 
  None.


Record s_psci_result :=
 mks_psci_result {
    e_hvc_forward : s_anon_5;
    e_smc_result_s_psci_result : s_smc_result}.

Definition load_s_psci_result (sz: Z) (ofs:Z)  (st: s_psci_result) : option Z := 
  if (ofs >=? 0) && (ofs <? 32) then (
    let elem_ofs := ofs - 0 in
    load_s_anon_5 sz elem_ofs (st.(e_hvc_forward))) else
  if (ofs >=? 32) && (ofs <? 64) then (
    let elem_ofs := ofs - 32 in
    load_s_smc_result sz elem_ofs (st.(e_smc_result_s_psci_result))) else
  None.

Definition store_s_psci_result (sz: Z) (ofs:Z) (v:Z)  (st: s_psci_result) : option s_psci_result := 
  if (ofs >=? 0) && (ofs <? 32) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_anon_5 sz elem_ofs v st.(e_hvc_forward);
    Some (st.[e_hvc_forward] :< ret)) else 
  if (ofs >=? 32) && (ofs <? 64) then (
    let elem_ofs := ofs - 32 in
    when ret == store_s_smc_result sz elem_ofs v st.(e_smc_result_s_psci_result);
    Some (st.[e_smc_result_s_psci_result] :< ret)) else 
  None.


Record s_psa_core_key_attributes_t :=
 mks_psa_core_key_attributes_t {
    e_type_s_psa_core_key_attributes_t : Z;
    e_bits : Z;
    e_lifetime : Z;
    e_id : Z;
    e_policy : s_psa_key_policy_s;
    e_flags_s_psa_core_key_attributes_t : Z}.

Definition load_s_psa_core_key_attributes_t (sz: Z) (ofs:Z)  (st: s_psa_core_key_attributes_t) : option Z := 
  if (ofs =? 0) then Some (st.(e_type_s_psa_core_key_attributes_t)) else
  if (ofs =? 2) then Some (st.(e_bits)) else
  if (ofs =? 4) then Some (st.(e_lifetime)) else
  if (ofs =? 8) then Some (st.(e_id)) else
  if (ofs >=? 12) && (ofs <? 24) then (
    let elem_ofs := ofs - 12 in
    load_s_psa_key_policy_s sz elem_ofs (st.(e_policy))) else
  if (ofs =? 24) then Some (st.(e_flags_s_psa_core_key_attributes_t)) else
  None.

Definition store_s_psa_core_key_attributes_t (sz: Z) (ofs:Z) (v:Z)  (st: s_psa_core_key_attributes_t) : option s_psa_core_key_attributes_t := 
  if (ofs =? 0) then Some (st.[e_type_s_psa_core_key_attributes_t] :< v) else
  if (ofs =? 2) then Some (st.[e_bits] :< v) else
  if (ofs =? 4) then Some (st.[e_lifetime] :< v) else
  if (ofs =? 8) then Some (st.[e_id] :< v) else
  if (ofs >=? 12) && (ofs <? 24) then (
    let elem_ofs := ofs - 12 in
    when ret == store_s_psa_key_policy_s sz elem_ofs v st.(e_policy);
    Some (st.[e_policy] :< ret)) else 
  if (ofs =? 24) then Some (st.[e_flags_s_psa_core_key_attributes_t] :< v) else
  None.


Record s_rec :=
 mks_rec {
    e_g_rec : Z;
    e_rec_idx : Z;
    e_runnable : Z;
    e_regs : (ZMap.t Z);
    e_pc_s_rec : Z;
    e_pstate : Z;
    e_sysregs : s_sysreg_state;
    e_common_sysregs : s_common_sysreg_state;
    e_set_ripas : s_anon_1;
    e_dispose_info : s_anon_0;
    e_realm_info : s_anon_1_2;
    e_last_run_info : u_anon_3;
    e_fpu : s_fpu_state;
    e_ns : Z;
    e_psci_info : s_anon_3;
    e_is_pico_s_rec : Z;
    e_initialized : Z;
    e_s1_ctx : s_realm_s1_context}.

Definition load_s_rec (sz: Z) (ofs:Z)  (st: s_rec) : option Z := 
  if (ofs =? 0) then Some (st.(e_g_rec)) else
  if (ofs =? 8) then Some (st.(e_rec_idx)) else
  if (ofs =? 16) then Some (st.(e_runnable)) else
  if (ofs >=? 24) && (ofs <? 272) then (
    let idx := (ofs - 24) / 8 in
    Some (st.(e_regs) @ idx)) else
  if (ofs =? 272) then Some (st.(e_pc_s_rec)) else
  if (ofs =? 280) then Some (st.(e_pstate)) else
  if (ofs >=? 288) && (ofs <? 840) then (
    let elem_ofs := ofs - 288 in
    load_s_sysreg_state sz elem_ofs (st.(e_sysregs))) else
  if (ofs >=? 840) && (ofs <? 864) then (
    let elem_ofs := ofs - 840 in
    load_s_common_sysreg_state sz elem_ofs (st.(e_common_sysregs))) else
  if (ofs >=? 864) && (ofs <? 896) then (
    let elem_ofs := ofs - 864 in
    load_s_anon_1 sz elem_ofs (st.(e_set_ripas))) else
  if (ofs >=? 896) && (ofs <? 920) then (
    let elem_ofs := ofs - 896 in
    load_s_anon_0 sz elem_ofs (st.(e_dispose_info))) else
  if (ofs >=? 920) && (ofs <? 952) then (
    let elem_ofs := ofs - 920 in
    load_s_anon_1_2 sz elem_ofs (st.(e_realm_info))) else
  if (ofs >=? 952) && (ofs <? 960) then (
    let elem_ofs := ofs - 952 in
    load_u_anon_3 sz elem_ofs (st.(e_last_run_info))) else
  if (ofs >=? 960) && (ofs <? 1504) then (
    let elem_ofs := ofs - 960 in
    load_s_fpu_state sz elem_ofs (st.(e_fpu))) else
  if (ofs =? 1504) then Some (st.(e_ns)) else
  if (ofs >=? 1512) && (ofs <? 1513) then (
    let elem_ofs := ofs - 1512 in
    load_s_anon_3 sz elem_ofs (st.(e_psci_info))) else
  if (ofs =? 1520) then Some (st.(e_is_pico_s_rec)) else
  if (ofs =? 1528) then Some (st.(e_initialized)) else
  if (ofs >=? 1536) && (ofs <? 1552) then (
    let elem_ofs := ofs - 1536 in
    load_s_realm_s1_context sz elem_ofs (st.(e_s1_ctx))) else
  None.

Definition store_s_rec (sz: Z) (ofs:Z) (v:Z)  (st: s_rec) : option s_rec := 
  if (ofs =? 0) then Some (st.[e_g_rec] :< v) else
  if (ofs =? 8) then Some (st.[e_rec_idx] :< v) else
  if (ofs =? 16) then Some (st.[e_runnable] :< v) else
  if (ofs >=? 24) && (ofs <? 272) then (
    let idx := (ofs - 24) / 8 in
    Some (st.[e_regs] :< (st.(e_regs) # idx == v))) else
  if (ofs =? 272) then Some (st.[e_pc_s_rec] :< v) else
  if (ofs =? 280) then Some (st.[e_pstate] :< v) else
  if (ofs >=? 288) && (ofs <? 840) then (
    let elem_ofs := ofs - 288 in
    when ret == store_s_sysreg_state sz elem_ofs v st.(e_sysregs);
    Some (st.[e_sysregs] :< ret)) else 
  if (ofs >=? 840) && (ofs <? 864) then (
    let elem_ofs := ofs - 840 in
    when ret == store_s_common_sysreg_state sz elem_ofs v st.(e_common_sysregs);
    Some (st.[e_common_sysregs] :< ret)) else 
  if (ofs >=? 864) && (ofs <? 896) then (
    let elem_ofs := ofs - 864 in
    when ret == store_s_anon_1 sz elem_ofs v st.(e_set_ripas);
    Some (st.[e_set_ripas] :< ret)) else 
  if (ofs >=? 896) && (ofs <? 920) then (
    let elem_ofs := ofs - 896 in
    when ret == store_s_anon_0 sz elem_ofs v st.(e_dispose_info);
    Some (st.[e_dispose_info] :< ret)) else 
  if (ofs >=? 920) && (ofs <? 952) then (
    let elem_ofs := ofs - 920 in
    when ret == store_s_anon_1_2 sz elem_ofs v st.(e_realm_info);
    Some (st.[e_realm_info] :< ret)) else 
  if (ofs >=? 952) && (ofs <? 960) then (
    let elem_ofs := ofs - 952 in
    when ret == store_u_anon_3 sz elem_ofs v st.(e_last_run_info);
    Some (st.[e_last_run_info] :< ret)) else 
  if (ofs >=? 960) && (ofs <? 1504) then (
    let elem_ofs := ofs - 960 in
    when ret == store_s_fpu_state sz elem_ofs v st.(e_fpu);
    Some (st.[e_fpu] :< ret)) else 
  if (ofs =? 1504) then Some (st.[e_ns] :< v) else
  if (ofs >=? 1512) && (ofs <? 1513) then (
    let elem_ofs := ofs - 1512 in
    when ret == store_s_anon_3 sz elem_ofs v st.(e_psci_info);
    Some (st.[e_psci_info] :< ret)) else 
  if (ofs =? 1520) then Some (st.[e_is_pico_s_rec] :< v) else
  if (ofs =? 1528) then Some (st.[e_initialized] :< v) else
  if (ofs >=? 1536) && (ofs <? 1552) then (
    let elem_ofs := ofs - 1536 in
    when ret == store_s_realm_s1_context sz elem_ofs v st.(e_s1_ctx);
    Some (st.[e_s1_ctx] :< ret)) else 
  None.


Record s_ns_state :=
 mks_ns_state {
    e_sysregs_s_ns_state : s_sysreg_state;
    e_sp_el0_s_ns_state : Z;
    e_icc_sre_el2 : Z;
    e_fpu_s_ns_state : s_fpu_state}.

Definition load_s_ns_state (sz: Z) (ofs:Z)  (st: s_ns_state) : option Z := 
  if (ofs >=? 0) && (ofs <? 552) then (
    let elem_ofs := ofs - 0 in
    load_s_sysreg_state sz elem_ofs (st.(e_sysregs_s_ns_state))) else
  if (ofs =? 552) then Some (st.(e_sp_el0_s_ns_state)) else
  if (ofs =? 560) then Some (st.(e_icc_sre_el2)) else
  if (ofs >=? 576) && (ofs <? 1120) then (
    let elem_ofs := ofs - 576 in
    load_s_fpu_state sz elem_ofs (st.(e_fpu_s_ns_state))) else
  None.

Definition store_s_ns_state (sz: Z) (ofs:Z) (v:Z)  (st: s_ns_state) : option s_ns_state := 
  if (ofs >=? 0) && (ofs <? 552) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_sysreg_state sz elem_ofs v st.(e_sysregs_s_ns_state);
    Some (st.[e_sysregs_s_ns_state] :< ret)) else 
  if (ofs =? 552) then Some (st.[e_sp_el0_s_ns_state] :< v) else
  if (ofs =? 560) then Some (st.[e_icc_sre_el2] :< v) else
  if (ofs >=? 576) && (ofs <? 1120) then (
    let elem_ofs := ofs - 576 in
    when ret == store_s_fpu_state sz elem_ofs v st.(e_fpu_s_ns_state);
    Some (st.[e_fpu_s_ns_state] :< ret)) else 
  None.


Record s_rd :=
 mks_rd {
    e_state_s_rd : Z;
    e_rec_count : Z;
    e_s2_ctx : s_realm_s2_context;
    e_par_base_s_rd : Z;
    e_par_size_s_rd : Z;
    e_par_end : Z;
    e_ctx : s_measurement_ctx;
    e_measurement : (ZMap.t s_measurement);
    e_is_rc_s_rd : Z}.

Definition load_s_rd (sz: Z) (ofs:Z)  (st: s_rd) : option Z := 
  if (ofs =? 0) then Some (st.(e_state_s_rd)) else
  if (ofs =? 8) then Some (st.(e_rec_count)) else
  if (ofs >=? 16) && (ofs <? 48) then (
    let elem_ofs := ofs - 16 in
    load_s_realm_s2_context sz elem_ofs (st.(e_s2_ctx))) else
  if (ofs =? 48) then Some (st.(e_par_base_s_rd)) else
  if (ofs =? 56) then Some (st.(e_par_size_s_rd)) else
  if (ofs =? 64) then Some (st.(e_par_end)) else
  if (ofs >=? 72) && (ofs <? 184) then (
    let elem_ofs := ofs - 72 in
    load_s_measurement_ctx sz elem_ofs (st.(e_ctx))) else
  if (ofs >=? 184) && (ofs <? 408) then (
    let idx := (ofs - 184) / 32 in
    let elem_ofs := (ofs - 184) mod 32 in
    load_s_measurement sz elem_ofs (st.(e_measurement) @ idx)) else
  if (ofs =? 408) then Some (st.(e_is_rc_s_rd)) else
  None.

Definition store_s_rd (sz: Z) (ofs:Z) (v:Z)  (st: s_rd) : option s_rd := 
  if (ofs =? 0) then Some (st.[e_state_s_rd] :< v) else
  if (ofs =? 8) then Some (st.[e_rec_count] :< v) else
  if (ofs >=? 16) && (ofs <? 48) then (
    let elem_ofs := ofs - 16 in
    when ret == store_s_realm_s2_context sz elem_ofs v st.(e_s2_ctx);
    Some (st.[e_s2_ctx] :< ret)) else 
  if (ofs =? 48) then Some (st.[e_par_base_s_rd] :< v) else
  if (ofs =? 56) then Some (st.[e_par_size_s_rd] :< v) else
  if (ofs =? 64) then Some (st.[e_par_end] :< v) else
  if (ofs >=? 72) && (ofs <? 184) then (
    let elem_ofs := ofs - 72 in
    when ret == store_s_measurement_ctx sz elem_ofs v st.(e_ctx);
    Some (st.[e_ctx] :< ret)) else 
  if (ofs >=? 184) && (ofs <? 408) then (
    let idx := (ofs - 184) / 32 in
    let elem_ofs := (ofs - 184) mod 32 in
    when ret == store_s_measurement sz elem_ofs v (st.(e_measurement) @ idx);
    Some (st.[e_measurement] :< (st.(e_measurement) # idx == ret))) else 
  if (ofs =? 408) then Some (st.[e_is_rc_s_rd] :< v) else
  None.


Record s__QCBOREncodeContext :=
 mks__QCBOREncodeContext {
    e_OutBuf : s_useful_out_buf;
    e_uError : Z;
    e_nesting : s___QCBORTrackNesting}.

Definition load_s__QCBOREncodeContext (sz: Z) (ofs:Z)  (st: s__QCBOREncodeContext) : option Z := 
  if (ofs >=? 0) && (ofs <? 32) then (
    let elem_ofs := ofs - 0 in
    load_s_useful_out_buf sz elem_ofs (st.(e_OutBuf))) else
  if (ofs =? 32) then Some (st.(e_uError)) else
  if (ofs >=? 40) && (ofs <? 176) then (
    let elem_ofs := ofs - 40 in
    load_s___QCBORTrackNesting sz elem_ofs (st.(e_nesting))) else
  None.

Definition store_s__QCBOREncodeContext (sz: Z) (ofs:Z) (v:Z)  (st: s__QCBOREncodeContext) : option s__QCBOREncodeContext := 
  if (ofs >=? 0) && (ofs <? 32) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_useful_out_buf sz elem_ofs v st.(e_OutBuf);
    Some (st.[e_OutBuf] :< ret)) else 
  if (ofs =? 32) then Some (st.[e_uError] :< v) else
  if (ofs >=? 40) && (ofs <? 176) then (
    let elem_ofs := ofs - 40 in
    when ret == store_s___QCBORTrackNesting sz elem_ofs v st.(e_nesting);
    Some (st.[e_nesting] :< ret)) else 
  None.


Record s_t_cose_sign1_sign_ctx :=
 mks_t_cose_sign1_sign_ctx {
    e_protected_parameters : s_q_useful_buf;
    e_cose_algorithm_id : Z;
    e_signing_key : s_t_cose_key;
    e_option_flags : Z;
    e_kid : s_q_useful_buf;
    e_content_type_uint : Z;
    e_content_type_tstr : Z}.

Definition load_s_t_cose_sign1_sign_ctx (sz: Z) (ofs:Z)  (st: s_t_cose_sign1_sign_ctx) : option Z := 
  if (ofs >=? 0) && (ofs <? 16) then (
    let elem_ofs := ofs - 0 in
    load_s_q_useful_buf sz elem_ofs (st.(e_protected_parameters))) else
  if (ofs =? 16) then Some (st.(e_cose_algorithm_id)) else
  if (ofs >=? 24) && (ofs <? 40) then (
    let elem_ofs := ofs - 24 in
    load_s_t_cose_key sz elem_ofs (st.(e_signing_key))) else
  if (ofs =? 40) then Some (st.(e_option_flags)) else
  if (ofs >=? 48) && (ofs <? 64) then (
    let elem_ofs := ofs - 48 in
    load_s_q_useful_buf sz elem_ofs (st.(e_kid))) else
  if (ofs =? 64) then Some (st.(e_content_type_uint)) else
  if (ofs =? 72) then Some (st.(e_content_type_tstr)) else
  None.

Definition store_s_t_cose_sign1_sign_ctx (sz: Z) (ofs:Z) (v:Z)  (st: s_t_cose_sign1_sign_ctx) : option s_t_cose_sign1_sign_ctx := 
  if (ofs >=? 0) && (ofs <? 16) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_q_useful_buf sz elem_ofs v st.(e_protected_parameters);
    Some (st.[e_protected_parameters] :< ret)) else 
  if (ofs =? 16) then Some (st.[e_cose_algorithm_id] :< v) else
  if (ofs >=? 24) && (ofs <? 40) then (
    let elem_ofs := ofs - 24 in
    when ret == store_s_t_cose_key sz elem_ofs v st.(e_signing_key);
    Some (st.[e_signing_key] :< ret)) else 
  if (ofs =? 40) then Some (st.[e_option_flags] :< v) else
  if (ofs >=? 48) && (ofs <? 64) then (
    let elem_ofs := ofs - 48 in
    when ret == store_s_q_useful_buf sz elem_ofs v st.(e_kid);
    Some (st.[e_kid] :< ret)) else 
  if (ofs =? 64) then Some (st.[e_content_type_uint] :< v) else
  if (ofs =? 72) then Some (st.[e_content_type_tstr] :< v) else
  None.


Record s_psa_key_attributes_s :=
 mks_psa_key_attributes_s {
    e_core : s_psa_core_key_attributes_t;
    e_domain_parameters : Z;
    e_domain_parameters_size : Z}.

Definition load_s_psa_key_attributes_s (sz: Z) (ofs:Z)  (st: s_psa_key_attributes_s) : option Z := 
  if (ofs >=? 0) && (ofs <? 28) then (
    let elem_ofs := ofs - 0 in
    load_s_psa_core_key_attributes_t sz elem_ofs (st.(e_core))) else
  if (ofs =? 32) then Some (st.(e_domain_parameters)) else
  if (ofs =? 40) then Some (st.(e_domain_parameters_size)) else
  None.

Definition store_s_psa_key_attributes_s (sz: Z) (ofs:Z) (v:Z)  (st: s_psa_key_attributes_s) : option s_psa_key_attributes_s := 
  if (ofs >=? 0) && (ofs <? 28) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_psa_core_key_attributes_t sz elem_ofs v st.(e_core);
    Some (st.[e_core] :< ret)) else 
  if (ofs =? 32) then Some (st.[e_domain_parameters] :< v) else
  if (ofs =? 40) then Some (st.[e_domain_parameters_size] :< v) else
  None.


Record s_attest_token_encode_ctx :=
 mks_attest_token_encode_ctx {
    e_cbor_enc_ctx : s__QCBOREncodeContext;
    e_opt_flags : Z;
    e_key_select : Z;
    e_signer_ctx : s_t_cose_sign1_sign_ctx}.

Definition load_s_attest_token_encode_ctx (sz: Z) (ofs:Z)  (st: s_attest_token_encode_ctx) : option Z := 
  if (ofs >=? 0) && (ofs <? 176) then (
    let elem_ofs := ofs - 0 in
    load_s__QCBOREncodeContext sz elem_ofs (st.(e_cbor_enc_ctx))) else
  if (ofs =? 176) then Some (st.(e_opt_flags)) else
  if (ofs =? 180) then Some (st.(e_key_select)) else
  if (ofs >=? 184) && (ofs <? 264) then (
    let elem_ofs := ofs - 184 in
    load_s_t_cose_sign1_sign_ctx sz elem_ofs (st.(e_signer_ctx))) else
  None.

Definition store_s_attest_token_encode_ctx (sz: Z) (ofs:Z) (v:Z)  (st: s_attest_token_encode_ctx) : option s_attest_token_encode_ctx := 
  if (ofs >=? 0) && (ofs <? 176) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s__QCBOREncodeContext sz elem_ofs v st.(e_cbor_enc_ctx);
    Some (st.[e_cbor_enc_ctx] :< ret)) else 
  if (ofs =? 176) then Some (st.[e_opt_flags] :< v) else
  if (ofs =? 180) then Some (st.[e_key_select] :< v) else
  if (ofs >=? 184) && (ofs <? 264) then (
    let elem_ofs := ofs - 184 in
    when ret == store_s_t_cose_sign1_sign_ctx sz elem_ofs v st.(e_signer_ctx);
    Some (st.[e_signer_ctx] :< ret)) else 
  None.


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
    stack_type_8: (ZMap.t Z)
    }.

Definition GRANULE_STATE_NS : Z := 0.
Definition GRANULE_STATE_DELEGATED : Z := 1.
Definition GRANULE_STATE_RD : Z := 2.
Definition GRANULE_STATE_REC : Z := 3.
Definition GRANULE_STATE_DATA : Z := 4.
Definition GRANULE_STATE_RTT : Z := 5.
Definition GRANULE_STATE_ANY : Z := 6.

Record r_granule_data :=
  mkr_granule_data {
      (* the index of granule entry for the current phyical Granule*)
      gd_g_idx: Z;

      g_granule_state : Z; (* 0/1/2/3/4/5/6 *)
      (* RTT/NS/Data *)
      (* NS, GRANULE_STATE_NS = 0 *)
      (* DELEGATED, GRANULE_STATE_DELEGATED = 1*)
      (* DATA, GRANULE_STATE_DATA = 4 *)
      (* RTT, GRANULE_STATE_RTT = 5 *)
      (* ANY, GRANULE_STATE_ANY = 6 : ANY is converted from NS with refcount extension*)
      (* XXX: offset -> data *)
      (* TODO: for now, we use norm for all*)
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
      pcpu_ich_misr_el2: Z;
      pcpu_ich_vmcr_el2: Z;

      pcpu_ich_ap0r3_el2: Z;
      pcpu_ich_ap0r2_el2: Z;
      pcpu_ich_ap0r1_el2: Z;
      pcpu_ich_ap0r0_el2: Z;

      pcpu_ich_ap1r3_el2: Z;
      pcpu_ich_ap1r2_el2: Z;
      pcpu_ich_ap1r1_el2: Z;
      pcpu_ich_ap1r0_el2: Z;

      pcpu_ich_ir0 : Z;
      pcpu_ich_ir1 : Z;
      pcpu_ich_ir2 : Z;
      pcpu_ich_ir3 : Z;
      pcpu_ich_ir4 : Z;
      pcpu_ich_ir5 : Z;
      pcpu_ich_ir6 : Z;
      pcpu_ich_ir7 : Z;
      pcpu_ich_ir8 : Z;
      pcpu_ich_ir9 : Z;

      pcpu_ich_lr0_el2 : Z;
      pcpu_ich_lr1_el2 : Z;
      pcpu_ich_lr2_el2 : Z;
      pcpu_ich_lr3_el2 : Z;
      pcpu_ich_lr4_el2 : Z;
      pcpu_ich_lr5_el2 : Z;
      pcpu_ich_lr6_el2 : Z;
      pcpu_ich_lr7_el2 : Z;
      pcpu_ich_lr8_el2 : Z;
      pcpu_ich_lr9_el2 : Z;
      pcpu_ich_lr10_el2 : Z;
      pcpu_ich_lr11_el2 : Z;
      pcpu_ich_lr12_el2 : Z;
      pcpu_ich_lr13_el2 : Z;
      pcpu_ich_lr14_el2 : Z;
      pcpu_ich_lr15_el2 : Z;


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

      pcpu_cntfrq_el0: Z;

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
      g_tt_l1_upper: (ZMap.t Z);
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
      gpt: ZMap.t bool; 
      (* gidx -> PAS *)

      granule_data: ZMap.t r_granule_data;

      globals: GLOBALS
      (* granules is temporally put in globals, entry for Granules, index -> granule entry in RMM *)
    }.


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

Parameter vmid_lock_idx: Z.
Parameter vmid_lock_g : s_granule.

Inductive AtomicEvent :=
(* acqure lock of gidx with tag *)
| ACQ (gidx: Z)
(* release lock *)
| REL (gidx1: Z) (gn: s_granule)
(* access Rec's refcount protected *)
| REC_REF (ref_gidx: Z) (ref_cnt: Z)
(* update realm or rec's refcount *)
| GET_GCNT (gidx3: Z)
| INC_GCNT (gidx4: Z)
| DEC_RD_GCNT (gidx5: Z)
| DEC_REC_GCNT (gidx6: Z) (gn_1: s_granule)
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

Definition Oracle := Log -> (Log).

Definition Replay := Log -> (Shared -> (option Shared)).

Record RData :=
  mkRData {
      log: list Event;
      oracle: Oracle;
      repl: Replay;

      (* registers ops will be generated in Spoq *)
      priv: PerCPU; 

      (* accessed by load/store Rdata *)
      share: Shared;
      stack: STACK;

      halt: bool
    }.

Definition query_oracle (st: RData) : option RData :=
  let lo := (st.(oracle) (st.(log))) in
  when sh == st.(repl) lo (st.(share));
  Some ((st.[log] :< lo ++ st.(log)).[share] :< sh).
(* FIX: add general load/store function of "granule_data" *)
Hint NoUnfold query_oracle.

Definition load_r_granule_data (ofs: Z) (st: r_granule_data) : option Z :=
  if (st.(g_granule_state) =? GRANULE_STATE_DATA) then (
    Some (st.(g_norm) @ ofs)
  ) else 
  if (st.(g_granule_state) =? GRANULE_STATE_REC) then (
    (load_s_rec 8 ofs (st.(g_rec)))
  ) else 
  if (st.(g_granule_state) =? GRANULE_STATE_RD) then (
    (load_s_rd 8 ofs (st.(g_rd)))
  ) else ( 
    (* None *)
    (* for other cases, we use norm_data *)
    Some (st.(g_norm) @ ofs)
  ).

Definition load_s_stack_type_4 (ofs: Z) (st: RData) : option Z :=
  rely (st.(stack).(stack_type_4) >= GRANULES_BASE);
  Some (st.(stack).(stack_type_4)).
Definition load_s_stack_type_4__1 (ofs: Z) (st: RData) : option Z :=
  (* rely (st.(stack).(stack_type_4__1) >=? GRANULES_BASE /\ st.(stack).(stack_type_4__1) <? MEM0_VIRT); *)
  rely (st.(stack).(stack_type_4__1) >= GRANULES_BASE);
  Some (st.(stack).(stack_type_4__1)).
  
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
    (* rely (st.(stack).(stack_type_4) >=? GRANULES_BASE /\ st.(stack).(stack_type_4) <? MEM0_VIRT); *)
    (* rely (); *)
    when ret == load_s_stack_type_4 sz st;
    Some (ret, st)
    (* Some(st.(stack).(stack_type_4), st)) *)
    ) else
  if (p.(pbase) =s "stack_type_4__1") then (
    when ret == load_s_stack_type_4__1 sz st;
    Some (ret, st)
    (* rely (st.(stack).(stacktype_4__1) >=? GRANULES_BASE /\ st.(stack).(stacktype_4__1) <? MEM0_VIRT); *)
    (* rely (); *)
    (* Some(st.(stack).(stack_type_4__1), st)) *)
    ) else
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
  if (p.(pbase) =s "tt_l1_upper") then (
      let idx := p.(poffset) / 1 in 
      let ret := (st.(share).(globals).(g_tt_l1_upper) @ idx) in
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
      when ret == load_r_granule_data elem_ofs g_data;
      Some(ret, st)
      (* let norm_data := ((g_data.(g_norm)) @ elem_ofs) in  *)
      (* Some(norm_data, st) *)
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
 (* if (v >=? GRANULES_BASE) then (mkPtr "granules" (v - GRANULES_BASE)) else *)
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
 (* if (p.(poffset) <? 0) then -1 else  *) (* remove this line for simplicity *)
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
 if (p.(pbase) =s "stack_type_4") then (STACK_TYPE_4_BASE + p.(poffset)) else
 if (p.(pbase) =s "stack_type_4__1") then (STACK_TYPE_4__1_BASE + p.(poffset)) else
 if (p.(pbase) =s "granule_data") then (
  if (p.(poffset) <? MEM0_SIZE) then (MEM0_VIRT + p.(poffset))
  else (MEM1_VIRT + p.(poffset) - MEM0_SIZE)
 ) else
    1.

(* stack variable never use inttoptr in source code *)
Definition int_to_ptr (v: Z) : Ptr :=
  (* (mkPtr "null" 0). *)
  if (v >? (0))
  then (
    if (v <? MAX_GLOBAL) then (global_to_ptr v) else 
    if (v >=? (MAX_ERR)) then (
      mkPtr "status" (v - (MAX_ERR))
    ) else
    if (v >=? MEM1_VIRT) then (
      mkPtr "granule_data" (v - MEM1_VIRT + MEM0_SIZE)
    ) else
    if (v >=? MEM0_VIRT) then (
      mkPtr "granule_data" (v - MEM0_VIRT)
    ) else 
    if (v >=? GRANULES_BASE) then (
      mkPtr "granules" (v - GRANULES_BASE)
    ) else 
    if (v >=? STACK_TYPE_4__1_BASE) then (
      mkPtr "stack_type_4__1" (v - STACK_TYPE_4__1_BASE)
    ) else
    if (v >=? STACK_TYPE_4_BASE) then (
      mkPtr "stack_type_4" (v - STACK_TYPE_4_BASE)
    ) else
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
    if (p.(pbase) =s "tt_l1_upper") then (
      let idx := p.(poffset) / 1 in 
      let ptr := (st.(share).(globals).(g_tt_l1_upper) # idx == v) in
      Some(st.[share].[globals].[g_tt_l1_upper] :< ptr)) else
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
    else
    None.

(* TODO *)
(* we have a (llvm alloca instruction)-to-(stack variable name) map in the `extractpointer` pass. *)
(** We may integrate this into Spoq in the future or pase it into this alloc_stack function here *)
Definition alloc_stack (fname: string) (sz: Z) (ofs: Z) (st: RData) : option (Ptr * RData) := (* TODO *)
    Some((mkPtr "null" 0), st).

Definition free_stack (fname: string) (init_st: RData) (st: RData) : option RData := Some st. 

Definition new_frame (fname: string) (st: RData) : option RData :=
  Some st.

Parameter empty_rec: s_rec.
Parameter empty_rd: s_rd.


(* pointer-abstraction params BEGIN *)
Record abs_PA_t :=
  mkabs_PA_t {
    meta_granule_offset: Z
}.

Record abs_PTE_t :=
  mkabs_PTE_t {
    meta_PA: abs_PA_t;
    meta_desc_type: Z;
    meta_ripas: Z;
    meta_mem_attr: Z
}.

Record abs_ret_rtt :=
  mkabs_ret_rtt {
    e_1: Z;
    e_2: Ptr;
    e_3: Z
}.
(* e_1: last-level ;; e_2: g_llt ;; e_3 : index *)
Record abs_ret_2ptr :=
  mkabs_ret_2ptr {
    e_ret_2ptr_1: Ptr;
    e_ret_2ptr_2: Ptr
}.


Parameter s2_addr_to_idx_para : Z -> (Z -> (Z)).
Parameter empty_rec : s_rec.
Parameter empty_rd : s_rd.
Parameter lens : Z -> (RData -> (RData)).
Parameter g_mapped_addr_set_para : Z -> (Z -> (Z)).
Parameter pack_struct_return_code_para : Z -> (Z).
Parameter make_return_code_para : Z -> (Z).
Parameter test_PTE_Z : abs_PTE_t -> (Z).
Parameter test_Z_PTE : Z -> (abs_PTE_t).
Parameter uart0_phys_para : abs_PTE_t -> (bool).
Parameter test_PA : Z -> (abs_PA_t).
Parameter g_refcount_para : Ptr -> (RData -> (Z)).
Parameter rec_to_rd_para : Ptr -> (RData -> (Ptr)).
Parameter test_Ptr_PTE : Ptr -> (abs_PTE_t).
Parameter rec_to_ttbr1_para : Ptr -> (RData -> (Ptr)).
Parameter check_rcsm_mask_para : abs_PA_t -> (bool).
Parameter abs_tte_read : Ptr -> (RData -> (abs_PTE_t)).

Parameter total_root_rtt_refcount_para : (Z -> (Z -> (RData -> (Z)))).
Parameter test_Z_Ptr : (Z -> (Ptr)).


(* pointer-abstraction params END *)

Section Bottom.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".  
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PRIMS: list string :=
    "attest_get_platform_token" ::
    "__sca_read64" :: 
    "ns_buffer_read_byte" :: 
    "ns_buffer_write_byte" ::
    "atomic_load_add_release_64" ::
    "validate_gic_state" ::
    "run_realm" ::
    "rec_run_loop" :: 
    "pico_rec_enter" ::
    "invalidate_block" ::
    nil.

  (** TODO: RE in z3_eval, fix it  *)
  (* Definition abs_tte_read (p: Ptr) (st: RData) : abs_PTE_t := 
    test_Z_PTE ((st.(share).(granule_data) @ (p.(poffset) / 4096)).(g_norm).(p.(poffset) mod 4096)). *)


  Definition attest_get_platform_token_spec (st: RData) : option (Z * RData) := Some (0, st).
  Definition __sca_read64_spec (ptr: Ptr) (st: RData) : option (Z * RData) := load_RData 64 ptr st.
  Definition __sca_read64_acquire_spec (ptr: Ptr) (st: RData) : option (Z * RData) := load_RData 64 ptr st.
  Definition __sca_write64_spec (ptr: Ptr) (val: Z) (st: RData) : option RData := store_RData 64 ptr val st.
  Definition __sca_write64_release_spec (v_state1: Ptr) (v_state: Z) (st: RData) : option RData := store_RData 64 v_state1 v_state st.

 (* TODO *)
  Definition invalidate_block_spec (ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition invalidate_pages_in_block_spec (ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition pico_rec_enter_spec (rec: Ptr) (arg2: Z) (arg3: Z) (ent_ret: Ptr) (st: RData) : option (RData) := 
    (Some st).

  Definition run_realm_spec (regs: Ptr) (st: RData) : option (Z * RData) := Some (0, st).

  Definition rec_run_loop_spec (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : (option RData) := Some st.

  Definition validate_gic_state_spec (v_0: Ptr) (st: RData) : (option (bool * RData)) :=
    Some(true, st).

  Definition ST_GRANULE_SIZE : Z := 4096.
  Definition atomic_load_add_release_64_spec (loc: Ptr) (val: Z) (st: RData) : option (Z * RData) :=
    (* rely (loc >=? GRANULES_BASE); *)
    (* rely (loc <? MEM0_VIRT); *)
    rely (loc.(pbase) = "granules");
    rely (loc.(poffset) >= 0);
    rely (loc.(poffset) mod ST_GRANULE_SIZE = 8);
    when v, st == (load_RData 64 loc st);
    when st == (store_RData 64 loc (v + val) st);
    Some (v + val, st).
  
  Definition iasm_33_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_cntfrq_el0), st).
  
  Definition iasm_get_cnthctl_el2_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_cnthctl_el2), st).

  Definition iasm_207_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_icc_sre_el2), st).

  Definition iasm_set_cnthctl_el2_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_cnthctl_el2] :< val).

  Definition iasm_145_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_icc_sre_el2] :< val).

  Definition iasm_set_spsr_el2_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_spsr_el2] :< val).

  Definition iasm_set_hcr_el2_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_hcr_el2] :< val).

  
  Definition iasm_8_spec (st: RData) : option RData :=
    Some st.

  Definition iasm_9_spec (val : Z) (st: RData) : option RData :=
    Some st.

  Definition iasm_10_spec (st: RData) : option RData :=
    Some st.
    
  Definition iasm_12_isb_spec (st: RData) : option RData :=
    Some st.

  Definition iasm_12_spec (st: RData) : option RData :=
    Some st.

  Definition iasm_31_spec  (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_id_aa64mmfr1_el1), st).
  
  Definition iasm_35_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_vmcr_el2] :< val).

  Definition iasm_36_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_hcr_el2] :< val).

  Definition iasm_37_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_vmcr_el2), st).

  Definition iasm_38_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_hcr_el2), st).

  Definition iasm_39_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_misr_el2), st).
  
  Definition iasm_74_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_id_aa64mmfr0_el1), st).

  Definition iasm_81_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ttbr0_el12), st).

  Definition iasm_82_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ttbr0_el12] :< val).
  
  Definition iasm_84_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ttbr1_el12] :< val).

  Definition iasm_98_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_ap0r0_el2), st).

  Definition iasm_99_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_ap0r3_el2), st).
  
  Definition iasm_100_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_ap0r2_el2), st).
  
  Definition iasm_101_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_ap0r1_el2), st).
  
  Definition iasm_102_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_ap1r0_el2), st).

  Definition iasm_103_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_ap1r3_el2), st).

  Definition iasm_104_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_ap1r2_el2), st).

  Definition iasm_105_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_ap1r1_el2), st).
  
  Definition iasm_117_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr0_el2), st).
  
  Definition iasm_118_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr15_el2), st).
  
  Definition iasm_119_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr14_el2), st).
  
  Definition iasm_120_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr13_el2), st).
  
  Definition iasm_121_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr12_el2), st).
  
  Definition iasm_122_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr11_el2), st).
  
  Definition iasm_123_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr10_el2), st).
  
  Definition iasm_124_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr9_el2), st).
  
  Definition iasm_125_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr8_el2), st).
  
  Definition iasm_126_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr7_el2), st).
  
  Definition iasm_127_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr6_el2), st).
  
  Definition iasm_128_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr5_el2), st).
  
  Definition iasm_129_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr4_el2), st).
  
  Definition iasm_130_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr3_el2), st).
  
  Definition iasm_131_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr2_el2), st).
  
  Definition iasm_132_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ich_lr1_el2), st).
  
  Definition iasm_212_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_elr_el12), st).
  
  Definition iasm_213_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_spsr_el12), st).

  
  Definition iasm_258_spec (st: RData) : option RData :=
    Some st.
  
  (* tlbi vaale1, val *)
  Definition iasm_261_spec (val : Z) (st: RData) : option RData :=
    Some st.
 
  (* tlbi vaale1, val *)
  Definition iasm_264_spec (val : Z) (st: RData) : option RData :=
    Some st.
  
  
  (* tlbi ipas2e1is, val *)
  (* Invalidate stage 2 only translations used at EL1 for the specified IPA for the current VMID, Inner Shareable *)
  Definition iasm_270_spec (val : Z) (st: RData) : option RData :=
    Some st.
  
  Definition iasm_277_spec (val : Z) (st: RData) : option RData :=
    Some st.
  
  Definition iasm_278_spec (val : Z) (st: RData) : option RData :=
    Some st.
  
  Definition iasm_281_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_ap0r0_el2] :< val).

  Definition iasm_282_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_ap0r3_el2] :< val).

  Definition iasm_283_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_ap0r2_el2] :< val).

  Definition iasm_284_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_ap0r1_el2] :< val).
  
  
  Definition iasm_285_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_ap1r0_el2] :< val).

  Definition iasm_286_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_ap1r3_el2] :< val).

  Definition iasm_287_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_ap1r2_el2] :< val).
  
  Definition iasm_288_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_ap1r1_el2] :< val).

  Definition iasm_289_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr0_el2] :< val).

  Definition iasm_290_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr15_el2] :< val).

  Definition iasm_291_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr14_el2] :< val).
  
  Definition iasm_292_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr13_el2] :< val).
  
  Definition iasm_293_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr12_el2] :< val).
  
  Definition iasm_294_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr11_el2] :< val).
  
  Definition iasm_295_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr10_el2] :< val).
  
  Definition iasm_296_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr9_el2] :< val).
  
  Definition iasm_297_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr8_el2] :< val).
  
  Definition iasm_298_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr7_el2] :< val).
  
  Definition iasm_299_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr6_el2] :< val).
  
  Definition iasm_300_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr5_el2] :< val).
  
  Definition iasm_301_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr4_el2] :< val).
  
  Definition iasm_302_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr3_el2] :< val).
  
  Definition iasm_303_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr2_el2] :< val).
  
  Definition iasm_304_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ich_lr1_el2] :< val).

  Definition iasm_set_vttbr_el2_spec (val: Z) (st: RData) : option (RData) :=
    Some (st.[priv].[pcpu_regs].[pcpu_vttbr_el2] :< val).

  Definition iasm_get_vttbr_el2_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_vttbr_el2), st).
  
  Definition iasm_get_pmcr_el0_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_pmcr_el0), st).
  
  Definition iasm_get_pmuserenr_el0_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_pmuserenr_el0), st).

  Definition iasm_get_tpidrro_el0_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_tpidrro_el0), st).
  
  Definition iasm_get_tpidr_el0_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_tpidr_el0), st).
  
  Definition iasm_get_tpidr_el1_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_tpidr_el1), st).

  Definition iasm_get_csselr_el1_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_csselr_el1), st).

  Definition iasm_219_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_sctlr_el12), st).
  
  Definition iasm_get_actlr_el1_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_actlr_el1), st).

  Definition iasm_221_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_cpacr_el12), st).
  
  (* Definition iasm_81_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ttbr0_el12), st). *)
  
  Definition iasm_84_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_ttbr1_el12), st).
  
  Definition iasm_224_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_tcr_el12), st).
  
  Definition iasm_225_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_esr_el12), st).
  
  Definition iasm_226_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_afsr0_el12), st).
  
  Definition iasm_227_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_afsr1_el12), st).
  
  Definition iasm_228_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_far_el12), st).
  
  Definition iasm_229_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_mair_el12), st).
  
  Definition iasm_230_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_vbar_el12), st).
  
  Definition iasm_231_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_contextidr_el12), st).
  
  Definition iasm_get_tpidr_el1_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_tpidr_el1), st).
  
  Definition iasm_233_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_amair_el12), st).
  
  Definition iasm_234_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_cntkctl_el12), st).
  
  (* Definition iasm_get_par_el1_spec (st: RData) : option (Z * RData) := *)
    (* Some (st.(priv).(pcpu_regs).(pcpu_par_el12), st). *)
  
  Definition iasm_get_mdscr_el1_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_mdscr_el1), st).
  
  Definition iasm_get_mdccint_el1_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_mdccint_el1), st).
  
  Definition iasm_get_disr_el1_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_disr_el1), st).
  
  Definition iasm_get_cntvoff_el2_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_cntvoff_el2), st).
  
  Definition iasm_7_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_cntp_ctl_el02), st).
  
  Definition iasm_139_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_cntp_cval_el02), st).
  
  Definition iasm_6_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_cntv_ctl_el02), st).
  
  Definition iasm_136_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_cntv_cval_el02), st).
  
  Definition iasm_set_sp_el0_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_sp_el0] :< val).

  Definition iasm_set_sp_el1_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_sp_el1] :< val).
  
  Definition iasm_153_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_elr_el12] :< val).
  
  Definition iasm_154_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_spsr_el12] :< val).
  
  Definition iasm_set_pmcr_el0_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_pmcr_el0] :< val).
  
  Definition iasm_set_pmuserenr_el0_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_pmuserenr_el0] :< val).
  
  Definition iasm_set_tpidrro_el0_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_tpidrro_el0] :< val).
  
  Definition iasm_set_tpidr_el0_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_tpidr_el0] :< val).
  
  Definition iasm_set_csselr_el1_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_csselr_el1] :< val).
  
  Definition iasm_75_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_sctlr_el12] :< val).
  
  Definition iasm_set_actlr_el1_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_actlr_el1] :< val).
  
  Definition iasm_162_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_cpacr_el12] :< val).
  
  Definition iasm_82_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ttbr0_el12] :< val).
  
  Definition iasm_88_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_ttbr1_el12] :< val).
  
  Definition iasm_76_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_tcr_el12] :< val).
  
  Definition iasm_166_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_esr_el12] :< val).
  
  Definition iasm_167_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_afsr0_el12] :< val).
  
  Definition iasm_168_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_afsr1_el12] :< val).
  
  Definition iasm_169_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_far_el12] :< val).
  
  Definition iasm_170_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_mair_el12] :< val).
  
  Definition iasm_77_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_vbar_el12] :< val).
  
  Definition iasm_172_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_contextidr_el12] :< val).
  
  Definition iasm_set_tpidr_el1_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_tpidr_el1] :< val).
  
  Definition iasm_174_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_amair_el12] :< val).
  
  Definition iasm_175_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_cntkctl_el12] :< val).
  
  Definition iasm_set_par_el1_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_par_el1] :< val).
  
  Definition iasm_set_mdscr_el1_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_mdscr_el1] :< val).
  
  Definition iasm_set_mdccint_el1_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_mdccint_el1] :< val).
  
  Definition iasm_set_disr_el1_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_disr_el1] :< val).
  
  Definition iasm_set_vmpidr_el2_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_vmpidr_el2] :< val).
  
  Definition iasm_set_cntvoff_el2_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_cntvoff_el2] :< val).
  
  Definition iasm_182_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_cntp_cval_el02] :< val).
  
  Definition iasm_183_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_cntp_ctl_el02] :< val).
  
  Definition iasm_184_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_cntv_cval_el02] :< val).
  
  Definition iasm_185_spec (val: Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_cntv_ctl_el02] :< val).

  Parameter iasm_get_par_el1_oracle : RData -> (Z).
  Definition iasm_get_par_el1_spec (st: RData) : option (Z * RData) :=
    Some ((iasm_get_par_el1_oracle st), st).

  Definition iasm_get_elr_el2_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_elr_el2), st).
  
  Definition iasm_set_elr_el2_spec (val : Z) (st: RData) : option RData :=
    Some (st.[priv].[pcpu_regs].[pcpu_elr_el2] :< val).

  Definition iasm_get_spsr_el2_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_spsr_el2), st).
  
  Definition iasm_get_sp_el0_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_sp_el0), st).
  
  Definition iasm_get_sp_el1_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_sp_el1), st).

  Definition iasm_get_id_aa64mmfr0_el1_spec (st: RData) : option (Z * RData) :=
    Some (st.(priv).(pcpu_regs).(pcpu_id_aa64mmfr0_el1), st).
  
  Definition memcpy_spec (v_dst: Ptr) (v_src: Ptr) (v_len: Z) (st: RData) : option (Ptr * RData) := 
    Some (v_dst, st).
  
  Parameter zero_granule_data: ZMap.t Z.
  Parameter non_zero_granule_data: ZMap.t Z.

  (* Definition memset_spec (v_s: Ptr) (c: Z) (n: Z) (st: RData) : option (Ptr * RData) := *)
    (* Some (v_s, st). *)
  Definition memset_spec (v_s: Ptr) (c: Z) (n: Z) (st: RData) : option (Ptr * RData) := 
    if (v_s.(pbase) =s "granule_data" /\ c=? 0 /\ n =? GRANULE_SIZE) then
      let g_idx := v_s.(poffset) / (4096) in
      let g_data := st.(share).(granule_data) @ g_idx in 
      Some (v_s, st.[share].[granule_data] :< (st.(share).(granule_data) # g_idx == (g_data.[g_norm] :< zero_granule_data)))
    else Some (v_s, st). 


  (* TODO: check case for rec and rd *)
  (* Definition memset_spec (v_s: Ptr) (c: Z) (n: Z) (st: RData) : option (Ptr * RData) :=
    (* TODO: more accurate condition *)
    if ((v_s.(pbase) =s "granule_data") /\ c =? 0 /\ n =? GRANULE_SIZE ) then
      let g_idx := v_s.(poffset) / GRANULE_SIZE in
      let g_data := st.(share).(granule_data) @ g_idx in
      let g := st.(share).(granules) @ g_idx in
      (* match g.(e_lock) with *)
      (* | Some cid => *)
          Some (v_s, st.[share].[granule_data] :<
                  (st.(share).(granule_data) # g_idx == (g_data.[g_norm] :<
                                                           zero_granule)))
      (* | None => None *)
      (* end *)
    else Some (v_s, st). *)
    (* if (v_s.(pbase) =s "granules") then
      let idx := v_s.(poffset) / 16 in
      let elem_ofs := v_s.(poffset) mod 16 in
      let new_g_data := (st.(share).(granule_data) @ idx).[g_norm] :< (st.(share).(granule_data) @ idx).(g_norm) # elem_ofs == c in
      let p := (st.(share).(granule_data) # idx == new_g_data) in
      let new_st := (st.[share].[granule_data] :< p) in
      Some (v_s, new_st)
    else *)
  
  Parameter memcpy_ns_buffer_read_byte_spec_state_oracle : Z -> (Z -> (Z -> (RData -> (option (bool * RData))))).
  Definition ns_buffer_read_byte_spec_low (src_pa: Z) (size: Z) (dst_pa: Z) (st: RData) : option (bool * RData) :=
    memcpy_ns_buffer_read_byte_spec_state_oracle dst_pa src_pa size st.
  Definition ns_buffer_read_byte_spec (src_pa: Z) (size: Z) (dst_pa: Z) (st: RData) : option (bool * RData) :=
    memcpy_ns_buffer_read_byte_spec_state_oracle dst_pa src_pa size st.
  
  Parameter memcpy_ns_buffer_write_byte_spec_state_oracle : Z -> (Z -> (Z -> (RData -> (option (bool * RData))))).
  Definition ns_buffer_write_byte_spec_low (src_pa: Z) (size: Z) (dst_pa: Z) (st: RData) : option (bool * RData) :=
    memcpy_ns_buffer_write_byte_spec_state_oracle dst_pa src_pa size st.
  Definition ns_buffer_write_byte_spec (src_pa: Z) (size: Z) (dst_pa: Z) (st: RData) : option (bool * RData) :=
    memcpy_ns_buffer_write_byte_spec_state_oracle dst_pa src_pa size st.

  (* TODO: printf_spec *)

  (* TODO: fully implementation *)
  (* Definition VA_TO_PA (va: Ptr): Z := 0. *)
  Definition PA_TO_VA (pa: Z): Z := 0.
  Hint NoUnfold PA_TO_VA.
  Hint PostEnsure PA_TO_VA (ret_0 >= MEM1_VIRT \/ ret_0 >= MEM0_VIRT).
  Hint PostEnsure PA_TO_VA (ret_0 < MAX_ERR).

  (* TODO: alloc a "sort_granules_stack" *)
  Definition llvm_memcpy_p0i8_p0i8_i64_spec (v_dest: Ptr) (v_src: Ptr) (sz: Z) (is_volatile: bool) (st: RData) : option RData :=
    Some st.
    (* if (v_dest.(pbase) =s "sort_granules_stack") && (v_src.(pbase) =s "find_lock_two_granules_stack") then
      let _src_0 := (st.(stack).(find_lock_two_granules_stack) @ (v_src.(poffset))) in
      let _src_1 := (st.(stack).(find_lock_two_granules_stack) @ (v_src.(poffset) + 8)) in
      let _src_2 := (st.(stack).(find_lock_two_granules_stack) @ (v_src.(poffset) + 16)) in
      let _dest_0 := (st.(stack).(sort_granules_stack) # 0 == _src_0) in
      let _dest_1 := (_dest_0 # 8 == _src_1) in
      let _dest_2 := (_dest_1 # 16 == _src_2) in
      Some (st.[stack].[sort_granules_stack] :< _dest_2)
    else *)
End Bottom.

Section Layer1.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    "granule_addr" ::
    "buffer_map" ::
    nil.
  
  Hint InitRely granule_addr (v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0).
  Hint InitRely buffer_map ( 
    ((v_1 >= MEM0_PHYS /\ v_1 < MEM0_PHYS + MEM0_SIZE)  /\ (v_1 & (549755813888) = 0 ))
    \/ ((v_1 >= MEM1_PHYS /\ v_1 < MEM1_PHYS + MEM1_SIZE) /\ (v_1 & (549755813888) = 1 )) ). 
    (* for bit operation *)
  Hint PostEnsure buffer_map (ret_0.(pbase) = "granule_data" /\ ret_0.(poffset) >= 0).
  (* Hint PostEnsure buffer_map ((ret_1.(share).(granule_data) @ (v_12.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_DATA); *)
End Layer1.


Section Layer2.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    "addr_to_idx" ::
    "granule_from_idx" ::
    "granule_map" ::
    "granule_get_state" ::
    "__tte_read" :: (* TODO: assembly *)
    nil.

  Hint InitRely granule_map ((v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0) /\ v_1 >= 0 /\ v_1 <= 24).
  Hint InitRely addr_to_idx ((v_0 >= MEM0_PHYS /\ v_0 < MEM0_PHYS + MEM0_SIZE) \/ (v_0 >= MEM1_PHYS /\ v_0 < MEM1_PHYS + MEM1_SIZE)). 
  Hint InitRely granule_from_idx (v_0 < NR_GRANULES /\ v_0 >= 0).
  Hint InitRely granule_get_state ((v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0)).
  Hint InitRely __tte_read (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0).
  Hint NoTrans __tte_read_spec.
  Hint NoUnfold __tte_read_spec.
  Hint PostEnsure __tte_read (ret_1.(share).(granule_data) = st.(share).(granule_data)). 
  (* Hint PostEnsure __tte_read (ret_1 = st). *) (* TODO: do not use this with low spec *)
  (* Hint InitRely __tte_read ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RTT). *)

End Layer2. 
Section Layer3.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    (* "spinlock_release" :: *)
    (* "spinlock_acquire" :: *)
    "table_entry_to_phys" ::
    "addr_to_granule" ::
    "__table_get_entry" ::
    "entry_is_table" ::
    "granule_try_lock" ::
    nil.

  (* TODO: log event, CPUID, *)
  (* Definition spinlock_release_spec (lock: Ptr) (st: RData) : option RData := Some st. *)
  
  (* Definition spinlock_release_spec (lock: Ptr) (st: RData) : option RData :=
    if lock.(pbase) =s "granules" then
      let ofs := lock.(poffset) in
      let gidx_l := ofs / 16 in
      let g := (st.(share).(globals).(g_granules) @ gidx_l) in
      match g.(e_lock).(e_val) with
      | Some cid =>
        let e := EVT CPU_ID (REL gidx_l g) in
        let new_granules := (st.(share).(globals).(g_granules)) # gidx_l == (g.[e_lock].[e_val] :< None) in
        let new_st := st.[share].[globals].[g_granules] :< new_granules in
        Some (new_st.[log] :< (e :: new_st.(log)))
      | None => None
      end
    else if (lock.(pbase) =s "vmid_lock") then 
      when st1 == query_oracle st;
      match load_s_spinlock_t 8 lock.(poffset) st.(share).(globals).(g_vmid_lock) with 
      | Some cid => 
        let e := EVT CPU_ID (REL vmid_lock_idx vmid_lock_g) in
        let new_st := st1.[share].[globals].[g_vmid_lock].[e_val] :< None in
        Some (new_st.[log] :< (e :: new_st.(log)))
      | None => None
      end
    else None. *)

  (* Definition spinlock_acquire_spec (lock: Ptr) (st: RData) : option RData := 
    if (lock.(pbase) =s "granules") then
      let ofs := lock.(poffset) in
      let gidx_l := ofs / 16 in
      when st1 == query_oracle st;
      let g := (st1.(share).(globals).(g_granules) @ gidx_l) in
      match g.(e_lock).(e_val) with
      | None =>
        let e := EVT CPU_ID (ACQ gidx_l) in
        let new_granules := st1.(share).(globals).(g_granules) # gidx_l == (g.[e_lock].[e_val] :< (Some CPU_ID)) in
        let new_st := st1.[share].[globals].[g_granules] :< new_granules in
        rely ((st.(share).(globals).(g_granules) @ gidx_l).(e_state_s_granule) = g.(e_state_s_granule));
        Some (new_st.[log] :< (e :: new_st.(log)))
      | Some cid => None
      end
    else if (lock.(pbase) =s "vmid_lock") then 
      when st1 == query_oracle st;
      match load_s_spinlock_t 8 lock.(poffset) st.(share).(globals).(g_vmid_lock) with 
      | None => 
        let e := EVT CPU_ID (ACQ vmid_lock_idx) in
        let new_st := st1.[share].[globals].[g_vmid_lock].[e_val] :< (Some CPU_ID) in
        Some (new_st.[log] :< (e :: new_st.(log)))
      | Some cid => None
      end
    else None. *)
  (* Definition spinlock_acquire_spec (lock: Ptr) (st: RData) : option RData := Some st. *)
  (* Hint NoUnfold spinlock_acquire_spec. *)

  Definition spinlock_release_spec (lock: Ptr) (st: RData) : (option RData) :=
    if ((lock.(pbase)) =s ("granules"))
    then (
      when cid == (((((((st.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).(e_lock)).(e_val)));
      (Some (st.[share].[globals].[g_granules] :<
        ((((st.(share)).(globals)).(g_granules)) #
          ((lock.(poffset)) / (4096)) ==
          (((((st.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).[e_lock].[e_val] :< None)))))
    else (
      if ((lock.(pbase)) =s ("vmid_lock"))
      then (
        when st1 == ((query_oracle st));
        rely (st1.(share).(globals).(g_granules) = st.(share).(globals).(g_granules));
        if ((lock.(poffset)) =? (0))
        then (
          when cid == (((((st.(share)).(globals)).(g_vmid_lock)).(e_val)));
          (Some st1))
        else None)
      else None).

  Definition spinlock_acquire_spec (lock: Ptr) (st: RData) : (option RData) :=
    if ((lock.(pbase)) =s ("granules"))
    then (
      when st1 == ((query_oracle st));
      rely (st1.(share).(globals).(g_granules) = st.(share).(globals).(g_granules));
      match (((((((st1.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).(e_state_s_granule)) -
            ((((((st1.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).(e_state_s_granule)))) =
            (0)));
        (Some (st1.[share].[globals].[g_granules] :<
          ((((st1.(share)).(globals)).(g_granules)) #
            ((lock.(poffset)) / (4096)) ==
            (((((st1.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID)))))
      | (Some cid) => None
      end)
    else (
      if ((lock.(pbase)) =s ("vmid_lock"))
      then (
        when st1 == ((query_oracle st));
        rely (st1.(share).(globals).(g_granules) = st.(share).(globals).(g_granules));
        if ((lock.(poffset)) =? (0))
          then (
            match (((((st.(share)).(globals)).(g_vmid_lock)).(e_val))) with
            | None => (Some st1)
            | (Some cid) => None
            end)
          else (Some st1))
        else None).

  Definition addr_to_idx_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 >=? (MEM1_PHYS))
    then (
      let mem1_id := ((v_0 + (-MEM1_PHYS)) >> (12) + (524288)) in
      Some ((mem1_id * 16), st)
    ) else (
      let mem0_id := ((v_0 + (-MEM0_PHYS)) >> (12)) in
      Some ((mem0_id * 16), st)
    ).

  Hint InitRely addr_to_granule ((v_0 >= MEM0_PHYS /\ v_0 < MEM0_PHYS + MEM0_SIZE) \/ (v_0 >= MEM1_PHYS /\ v_0 < MEM1_PHYS + MEM1_SIZE)). 

  Definition granule_try_lock_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
  if ((v_0.(pbase)) =s ("granules"))
  then (
    when st1 == ((query_oracle st));
    rely (st1.(share).(globals).(g_granules) = st.(share).(globals).(g_granules));
    match (((((((st1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_lock)).(e_val))) with
    | None =>
      rely (
        (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)) -
          ((((((st1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)))) =
          (0)));
      rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
      if (((((((st1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)) - (v_1)) =? (0))
      then (
        (Some (
          true  ,
          (st1.[share].[globals].[g_granules] :<
            ((((st1.(share)).(globals)).(g_granules)) #
              ((v_0.(poffset)) / (4096)) ==
              (((((st1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))
        )))
      else (
        (Some (
          false  ,
          (st1.[share].[globals].[g_granules] :<
            ((((st1.(share)).(globals)).(g_granules)) #
              ((v_0.(poffset)) / (4096)) ==
              (((((st1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).[e_lock].[e_val] :< None)))
        )))
    | (Some cid) => None
    end)
  else None.

  Definition granule_try_lock_spec' (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    if (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)) - (v_1)) =? (0))
    then (Some (true, st))
    else (Some (false, st)).

End Layer3.

Section Layer4.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    "__find_next_level_idx"::
    "s2_addr_to_idx"::
    "cpuid" ::
    "find_granule" ::
    "granule_lock" ::
    "s2tte_create_ripas" ::
    "test" ::
    nil.

  Definition granule_lock_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    (Some st).
  (* todo: move them to other places *)
  Definition atomic_add_64_spec (loc: Ptr) (val: Z) (st: RData) : option RData :=
    when v, st == load_RData 64 loc st;
    when st == store_RData 64 loc (v + val) st;
    Some st.

  Definition cpuid_spec (st: RData) : option (Z * RData) := Some (CPU_ID, st). (* TODO: CPUID *)

  Definition find_granule_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    when st_1 == query_oracle st;
    rely (st_1.(share).(globals).(g_granules) = st.(share).(globals).(g_granules));
    if (v_0 >=? (MEM1_PHYS))
    then (
      let mem1_id := ((v_0 + (-MEM1_PHYS)) >> (12) + (524288)) in
      Some ((mkPtr "granules" (mem1_id * 16)), st)
    ) else (
      let mem0_id := ((v_0 + (-MEM0_PHYS)) >> (12)) in
      Some ((mkPtr "granules" (mem0_id * 16)), st_1)
    ).
  
    (* spec for test *)
  (* Definition find_granule_spec_low  (lock: Ptr) (st: RData) : option RData := 
    if (lock.(pbase) =s "granules") then
      let ofs := lock.(poffset) in
      let gidx_l := ofs / 16 in
      when vdd, st0 == query_oracle_v st;
      when st1 == (query_oracle (st0.[share].[granule_data] :< 
                                  (st0.(share).(granule_data) # vdd == 
                                    ((st0.(share).(granule_data) @ vdd).[g_norm] :< zero_granule_data))));
      let st2 := (st1.[share].[granule_data] :< 
                      (st1.(share).(granule_data) # vdd == 
                        ((st1.(share).(granule_data) @ vdd).[g_norm] :< zero_granule_data))) in
      let g := (st2.(share).(globals).(g_granules) @ gidx_l) in
      match g.(e_lock).(e_val) with
      | None =>
        let e := EVT CPU_ID (ACQ gidx_l) in
        let new_granules := st2.(share).(globals).(g_granules) # gidx_l == (g.[e_lock].[e_val] :< (Some CPU_ID)) in
        let new_st := st2.[share].[globals].[g_granules] :< new_granules in
        rely ((st.(share).(globals).(g_granules) @ gidx_l).(e_state_s_granule) = g.(e_state_s_granule));
        Some ((new_st.[log] :< (e :: new_st.(log))).[share].[granule_data] :< 
                (new_st.(share).(granule_data) # vdd == 
                  (((new_st.(share).(granule_data) @ vdd).[g_granule_state] :< GRANULE_STATE_DELEGATED))))
      | Some cid => None
      end
    else if (lock.(pbase) =s "vmid_lock") then 
      when st1 == query_oracle st;
      match load_s_spinlock_t 8 lock.(poffset) st.(share).(globals).(g_vmid_lock) with 
      | None => 
        let e := EVT CPU_ID (ACQ vmid_lock_idx) in
        let new_st := st1.[share].[globals].[g_vmid_lock].[e_val] :< (Some CPU_ID) in
        Some (new_st.[log] :< (e :: new_st.(log)))
      | Some cid => None
      end
    else None. *)

  Hint PostEnsure find_granule (ret_0.(pbase) = "granules" \/ ret_0.(pbase) = "null").
  Hint InitRely find_granule (((v_0 >= MEM0_PHYS /\ v_0 < MEM0_PHYS + MEM0_SIZE) \/ (v_0 >= MEM1_PHYS /\ v_0 < MEM1_PHYS + MEM1_SIZE)) /\ (v_0 & 4095 = 0)). 
  (* Hint Unfold find_granule_spec'. *)

End Layer4.

Section Layer5.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    "s2tte_is_table" ::
    "granule_unlock" ::
    "s2_sl_addr_to_idx" ::
    "__find_lock_next_level"::
    "addr_is_contained" ::
    "set_rd_state" ::
    "get_rd_rec_count_unlocked" ::
    "monitor_call" ::
    "pack_struct_return_code" ::
    "make_return_code" ::
    "atomic_granule_get"::
    "atomic_granule_put"::
    "slot_to_va" ::
    (* "memcpy_ns_read" :: *)
   "granule_pa_to_va" :: 
    "find_lock_granule" ::
    "sort_granules" ::
    "s2tte_create_unassigned" ::
    nil.
  
  (* Hint NoUnfold spinlock_release_spec. *)
  (* Hint NoUnfold spinlock_acquire_spec. *)
  (* Hint NoUnfold granule_unlock_spec. *)
  (* Hint NoUnfold memset_spec. *)

  Definition granule_unlock_spec_low (v_0: Ptr) (st: RData) : (option RData) := (Some st).

  Parameter llvm_memset_p0i8_i64_spec_state_oracle : Ptr -> (Z -> (Z -> (bool -> (RData -> (option RData))))).
  Definition llvm_memset_p0i8_i64_spec (v_0: Ptr) (arg1: Z) (arg2: Z) (arg3: bool) (st: RData) : option RData :=
    when st_0 == (llvm_memset_p0i8_i64_spec_state_oracle v_0 arg1 arg2 arg3 st);
    rely st_0.(share).(granule_data) = st.(share).(granule_data);
    Some st_0.
  
  Parameter memcpy_ns_write_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).
  Definition memcpy_ns_write_spec (v_dest: Ptr) (v_src: Ptr) (v_conv: Z) (st: RData) : option (bool * RData) :=
      rely (v_src.(pbase) = "granule_data" /\ v_src.(poffset) >= 0);
      memcpy_ns_read_spec_state_oracle v_dest v_src v_conv st.


  Parameter memcpy_ns_read_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).
  Definition memcpy_ns_read_spec (v_dest: Ptr) (v_src: Ptr) (v_conv: Z) (st: RData) : option (bool * RData) :=
      rely (v_src.(pbase) = "granule_data" /\ v_src.(poffset) >= 0);
      memcpy_ns_read_spec_state_oracle v_dest v_src v_conv st.

  Hint InitRely atomic_granule_get ((v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0 )).
  Hint InitRely atomic_granule_put (v_0.(pbase) = "granules" /\ (v_0.(poffset) mod 16 = 0) /\ v_0.(poffset) >= 0 ).
  Hint InitRely granule_pa_to_va ((v_0 >= MEM0_PHYS /\ v_0 < MEM0_PHYS + MEM0_SIZE) \/ (v_0 >= MEM1_PHYS /\ v_0 < MEM1_PHYS + MEM1_SIZE)). 
  Hint InitRely set_rd_state ((v_0).(pbase) = "granule_data").
  Hint InitRely set_rd_state ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).

  Hint InitRely get_rd_rec_count_unlocked ((v_0).(pbase) = "granule_data").
  Hint InitRely get_rd_rec_count_unlocked ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  
  (* TODO: give a complete spec of monitor_call *)
  Parameter monitor_call_state_oracle : Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (RData -> (option (Z * RData))))))))).
  Definition monitor_call_spec (id: Z) (arg0: Z) (arg1: Z) (arg2: Z) (arg3: Z) (arg4: Z) (arg5: Z) (st: RData) : option (Z * RData) := monitor_call_state_oracle id arg0 arg1 arg2 arg3 arg4 arg5 st.

  Definition sort_granules_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) := Some st.
  (* Hint InitRely sort_granules (v_1 == 2). *)
  (* TODO: we need post-condition hint support on spoq to simplify __find_lock_next_level! *)
  Hint InitRely __find_lock_next_level (v_0.(pbase) = "granules" /\ (v_0.(poffset) mod 16 = 0) /\ v_0.(poffset) >= 0). 

  Hint InitRely find_lock_granule (((v_0 >= MEM0_PHYS /\ v_0 < MEM0_PHYS + MEM0_SIZE) \/ (v_0 >= MEM1_PHYS /\ v_0 < MEM1_PHYS + MEM1_SIZE))
                       /\ (v_0 & 4095 = 0)).
  Hint PostEnsure find_lock_granule (ret_0.(pbase) = "granules"  \/ ret_0.(pbase) = "null").
  Hint PostEnsure find_lock_granule ((ret_0.(poffset) mod 16 = 0) /\ (ret_0.(poffset) >= 0)).

  Definition __find_lock_next_level_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((s2_addr_to_idx_spec v_1 v_2 st));
    when v_5, st_1 == ((__find_next_level_idx_spec v_0 v_4 st_0));
    rely ((((v_5.(pbase)) = ("granules")) /\ ((((v_5.(poffset)) mod (4096)) = (0)))) /\ (((v_5.(poffset)) >= (0))));
    if (ptr_eqb v_5 (mkPtr "null" 0))
    then (Some (v_5, st_1))
    else (
      when st_2 == ((granule_lock_spec v_5 5 st_1));
      (Some (v_5, st_2))).

  (* Definition find_lock_granule_spec' (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    if ((v_0 - (MEM1_PHYS)) >=? (0))
    then (
      when ret, st' == ((granule_try_lock_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))) v_1 st));
      if ret
      then (Some ((mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))), st))
      else (Some ((mkPtr "null" 0), st)))
    else (
      when ret, st' == ((granule_try_lock_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) v_1 st));
      if ret
      then (Some ((mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))), st))
      else (Some ((mkPtr "null" 0), st))). *)
End Layer5.  
  
Section Layer6.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    "esr_sysreg_rt" ::
    "esr_sas" ::
    "get_realm_identity" :: (* overwriting type Z with Z *)
    "s2tte_map_size" ::
    "s2tte_pa" ::
    "s2tte_is_valid" ::
    "rtt_walk_lock_unlock" :: 
    "realm_ipa_bits" ::
    "realm_rtt_starting_level" ::
    "is_addr_in_par" ::
    "system_off_reboot" ::
    "rd_map_read_rec_count" ::
    "vmpidr_to_rec_idx" ::
    "g_mapped_addr_set" ::
    "granule_set_state" ::
    "set_pas_ns_to_any" ::
    "pack_return_code" ::
    "__granule_get"::
    "g_refcount"::
    "__granule_put"::
    "set_pas_any_to_ns" ::
    "s2tte_create_assigned" ::
    "__tte_write" ::
    "stage1_tlbi_all" ::
    "s1tte_pa" ::
    "s2tte_is_unassigned" ::
    "s1tte_create_valid" ::
    "s2tte_get_ripas" ::
    (* "memset" :: *)
    "ns_buffer_unmap" ::
    "ns_buffer_read" ::
    "find_lock_granules" ::
    "s2tte_create_table" :: 
    "s2tt_init_unassigned" ::
    nil.
  
  Hint InitRely rtt_walk_lock_unlock (v_0.(pbase) = "stack_s_rtt_walk" /\ (v_0.(poffset) mod 16 = 0) /\ v_0.(poffset) >= 0).
  Hint InitRely rtt_walk_lock_unlock (v_1.(pbase) = "granules" /\ (v_1.(poffset) mod 16 = 0) /\ v_1.(poffset) >= 0).
  Hint PostEnsure rtt_walk_lock_unlock (ret_1.(share).(granule_data) = st.(share).(granule_data)).

  Definition rtt_walk_lock_unlock_loop467_rank  (v_0: Ptr) (v_4: Z) (v_5: Z) (v_7: Ptr) (v_indvars_iv: Z) : Z := 0.

  (* fold abs for now *)
  Definition rtt_walk_lock_unlock_spec_abs (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option (abs_ret_rtt * RData)) :=
    (Some ((mkabs_ret_rtt 0 v_0 0), st)).
    (* when ret_1, st_1 == ((__find_lock_next_level_spec v_0 v_4 0 st));
    if (ptr_eqb ret_1 (mkPtr "null" 0))
    then (
      when i, s == ((s2_addr_to_idx_spec v_4 0 st_1));
      (Some ((mkabs_ret_rtt 0 v_0 i), s)))
    else (
      when st_2 == ((granule_unlock_spec v_0 st_1));
      when ret_2, st_3 == ((__find_lock_next_level_spec ret_1 v_4 1 st_2));
      if (ptr_eqb ret_2 (mkPtr "null" 0))
      then (
        when i, s == ((s2_addr_to_idx_spec v_4 1 st_3));
        (Some ((mkabs_ret_rtt 1 ret_1 i), s)))
      else (
        when st_4 == ((granule_unlock_spec ret_1 st_3));
        when ret_3, st_5 == ((__find_lock_next_level_spec ret_2 v_4 2 st_4));
        if (ptr_eqb ret_3 (mkPtr "null" 0))
        then (
          when i, s == ((s2_addr_to_idx_spec v_4 2 st_5));
          (Some ((mkabs_ret_rtt 2 ret_2 i), s)))
        else (
          when st_6 == ((granule_unlock_spec ret_2 st_5));
          when i, s == ((s2_addr_to_idx_spec v_4 2 st_6));
          (Some ((mkabs_ret_rtt 3 ret_3 i), s))))). *)
  Hint NoUnfold rtt_walk_lock_unlock_spec_abs.

  Hint NoUnfold rtt_walk_lock_unlock_spec.
  (* Definition rtt_walk_lock_unlock_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "rtt_walk_lock_unlock" st));
    rely (((((v_1.(pbase)) = ("granules")) /\ ((((v_1.(poffset)) mod (16)) = (0)))) /\ (((v_1.(poffset)) >= (0)))));
    rely (((((v_0.(pbase)) = ("stack_s_rtt_walk")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_1 == ((llvm_memset_p0i8_i64_spec (mkPtr "stack_type_5" 0) 0 32 false st_0));
    when st_2 == ((llvm_memset_p0i8_i64_spec v_0 0 24 false st_1));
    when v_10, st_3 == ((s2_sl_addr_to_idx_spec v_4 v_2 v_3 st_2));
    if (v_10 >? (511))
    then (
      when st_4 == ((granule_lock_spec (ptr_offset v_1 (16 * (((v_10 >> (9)) & (4294967295))))) 5 st_3));
      when st_5 == ((granule_unlock_spec v_1 st_4));
      rely ((((0 - (v_2)) <= (0)) /\ ((v_2 < (4)))));
      when st_7 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_2))) (ptr_to_int (ptr_offset v_1 (16 * (((v_10 >> (9)) & (4294967295)))))) st_5));
      if ((v_2 - (v_5)) <? (0))
      then (
        rely (((rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2) >= (0)));
        match (
          (rtt_walk_lock_unlock_loop467
            (z_to_nat (rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2))
            false
            false
            v_0
            v_4
            v_5
            (mkPtr "stack_type_5" 0)
            v_2
            st_7)
        ) with
        | (Some (__return___0, __break__, v_14, v_13, v_6, v_12, v_indvars_iv_0, st_8)) =>
          if __return___0
          then (
            when st_10 == ((free_stack "rtt_walk_lock_unlock" st_0 st_8));
            (Some st_10))
          else (
            when st_10 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_8));
            rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
            when v_37_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_10));
            when st_12 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_11));
            when v_39, st_13 == ((s2_addr_to_idx_spec v_4 v_5 st_12));
            when st_14 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_13));
            when st_15 == ((free_stack "rtt_walk_lock_unlock" st_0 st_14));
            (Some st_15))
        | None => None
        end)
      else (
        when st_9 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_7));
        rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
        when v_37_tmp, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_9));
        when st_11 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_10));
        when v_39, st_12 == ((s2_addr_to_idx_spec v_4 v_5 st_11));
        when st_13 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_12));
        when st_14 == ((free_stack "rtt_walk_lock_unlock" st_0 st_13));
        (Some st_14)))
    else (
      rely ((((0 - (v_2)) <= (0)) /\ ((v_2 < (4)))));
      when st_5 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_2))) (ptr_to_int v_1) st_3));
      if ((v_2 - (v_5)) <? (0))
      then (
        rely (((rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2) >= (0)));
        match (
          (rtt_walk_lock_unlock_loop467
            (z_to_nat (rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2))
            false
            false
            v_0
            v_4
            v_5
            (mkPtr "stack_type_5" 0)
            v_2
            st_5)
        ) with
        | (Some (__return___0, __break__, v_14, v_13, v_6, v_12, v_indvars_iv_0, st_6)) =>
          if __return___0
          then (
            when st_8 == ((free_stack "rtt_walk_lock_unlock" st_0 st_6));
            (Some st_8))
          else (
            when st_8 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_6));
            rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
            when v_37_tmp, st_9 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_8));
            when st_10 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_9));
            when v_39, st_11 == ((s2_addr_to_idx_spec v_4 v_5 st_10));
            when st_12 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_11));
            when st_13 == ((free_stack "rtt_walk_lock_unlock" st_0 st_12));
            (Some st_13))
        | None => None
        end)
      else (
        when st_7 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_5));
        rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
        when v_37_tmp, st_8 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_7));
        when st_9 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_8));
        when v_39, st_10 == ((s2_addr_to_idx_spec v_4 v_5 st_9));
        when st_11 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_10));
        when st_12 == ((free_stack "rtt_walk_lock_unlock" st_0 st_11));
        (Some st_12))). *)


  Fixpoint rtt_walk_lock_unlock_loop467 (_N_: nat) (__return__: bool) (__break__: bool) (v_0: Ptr) (v_4: Z) (v_5: Z) (v_7: Ptr) (v_indvars_iv: Z) (st: RData) : (option (bool * bool * Ptr * Z * Z * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_0, v_4, v_5, v_7, v_indvars_iv, st))
    | (S _N__0) =>
      match ((rtt_walk_lock_unlock_loop467 _N__0 __return__ __break__ v_0 v_4 v_5 v_7 v_indvars_iv st)) with
      | (Some (return___9, break___9, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_9)) =>
        if break___9
        then (Some (return___9, true, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_9))
        else (
          if return___9
          then (Some (true, false, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_9))
          else (
            rely ((((0 - (v_indvars_iv_9)) <= (0)) /\ ((v_indvars_iv_9 < (4)))));
            when v_23_tmp, st_10 == ((load_RData 8 (ptr_offset v_36 (8 * (v_indvars_iv_9))) st_9));
            when v_38, st_11 == ((__find_lock_next_level_spec (int_to_ptr v_23_tmp) v_37 v_indvars_iv_9 st_10));
            rely ((((0 - ((v_indvars_iv_9 + (1)))) <= (0)) /\ (((v_indvars_iv_9 + (1)) < (4)))));
            when st_12 == ((store_RData 8 (ptr_offset v_36 (8 * ((v_indvars_iv_9 + (1))))) (ptr_to_int v_38) st_11));
            if (ptr_eqb v_38 (mkPtr "null" 0))
            then (
              when st_13 == ((store_RData 8 (ptr_offset v_13 16) v_indvars_iv_9 st_12));
              when v_37_tmp, st_16 == ((load_RData 8 (ptr_offset v_36 (8 * (v_indvars_iv_9))) st_13));
              when st_17 == ((store_RData 8 (ptr_offset v_13 0) v_37_tmp st_16));
              when v_40, st_18 == ((s2_addr_to_idx_spec v_37 v_indvars_iv_9 st_17));
              when st_20 == ((store_RData 8 (ptr_offset v_13 8) v_40 st_18));
              (Some (true, false, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_20)))
            else (
              when v_29_tmp, st_13 == ((load_RData 8 (ptr_offset v_36 (8 * (v_indvars_iv_9))) st_12));
              when st_16 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_13));
              if (((v_indvars_iv_9 + (1)) - (v_31)) <? (0))
              then (Some (false, false, v_13, v_37, v_31, v_36, (v_indvars_iv_9 + (1)), st_16))
              else (Some (false, true, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_16)))))
      | None => None
      end
    end.

  Hint NoTrans find_lock_granules.
  Hint NoUnfold find_lock_granules.
  Hint InitRely find_lock_granules (v_0.(pbase) = "stack_type_6").
  Hint InitRely find_lock_granules (v_0.(poffset) = 0).
  Hint InitRely find_lock_granules (v_1 = 2).
  (*
  Definition find_lock_granules_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (((v_0.(pbase)) = ("stack_type_6")));
    rely (((v_0.(poffset)) = (0)));
    when ret, st' == (
        (find_lock_granule_spec'
          ((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).(e_addr))
          ((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).(e_state_s_granule_set))
          (st.[stack].[stack_type_6] :<
            ((((st.(stack)).(stack_type_6)) # (v_0.(poffset)) == ((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_idx] :< 0)) #
              (1 + ((v_0.(poffset)))) ==
              ((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).[e_idx] :< 1)))));
    rely ((((ret.(pbase)) =s ("granules")) \/ (((ret.(pbase)) =s ("null")))));
    rely (((ret.(poffset)) >= (0)));
    if ((ret.(pbase)) =s ("null"))
    then (
      (Some (
        1  ,
        (st.[stack].[stack_type_6] :<
          (((((st.(stack)).(stack_type_6)) # (v_0.(poffset)) == ((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_idx] :< 0)) #
            (1 + ((v_0.(poffset)))) ==
            ((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).[e_idx] :< 1)) #
            (v_0.(poffset)) ==
            (((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_g] :< 0).[e_idx] :< 0)))
      )))
    else (
      if ((((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).(e_addr)) - (((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).(e_addr)))) =? (0))
      then (
        rely ((((- 25165824) + ((ret.(poffset)))) < (0)));
        rely ((((ret.(poffset)) mod (16)) = (0)));
        (Some (
          3  ,
          (st.[stack].[stack_type_6] :<
            (((((st.(stack)).(stack_type_6)) # (v_0.(poffset)) == ((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_idx] :< 0)) #
              (1 + ((v_0.(poffset)))) ==
              ((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).[e_idx] :< 1)) #
              (v_0.(poffset)) ==
              (((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_g] :< (GRANULES_BASE + ((ret.(poffset))))).[e_idx] :< 0)))
        )))
      else (
        when ret_0, st'_0 == (
            (find_lock_granule_spec'
              ((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).(e_addr))
              ((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).(e_state_s_granule_set))
              (st.[stack].[stack_type_6] :<
                (((((st.(stack)).(stack_type_6)) # (v_0.(poffset)) == ((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_idx] :< 0)) #
                  (1 + ((v_0.(poffset)))) ==
                  ((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).[e_idx] :< 1)) #
                  (v_0.(poffset)) ==
                  (((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_g] :< (GRANULES_BASE + ((ret.(poffset))))).[e_idx] :< 0)))));
        rely ((((ret_0.(pbase)) =s ("granules")) \/ (((ret_0.(pbase)) =s ("null")))));
        rely (((ret_0.(poffset)) >= (0)));
        if ((ret_0.(pbase)) =s ("null"))
        then (
          rely ((((- 25165824) + ((ret.(poffset)))) < (0)));
          rely ((((ret.(poffset)) mod (16)) = (0)));
          (Some (
            4294967297  ,
            (st.[stack].[stack_type_6] :<
              ((((((st.(stack)).(stack_type_6)) # (v_0.(poffset)) == ((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_idx] :< 0)) #
                (1 + ((v_0.(poffset)))) ==
                ((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).[e_idx] :< 1)) #
                (v_0.(poffset)) ==
                (((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_g] :< (GRANULES_BASE + ((ret.(poffset))))).[e_idx] :< 0)) #
                (1 + ((v_0.(poffset)))) ==
                (((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).[e_g] :< 0).[e_idx] :< 1)))
          )))
        else (
          (Some (
            0  ,
            (((st.[stack].[stack_type_4] :< (GRANULES_BASE + ((ret.(poffset))))).[stack].[stack_type_4__1] :< (GRANULES_BASE + ((ret_0.(poffset))))).[stack].[stack_type_6] :<
              ((((((st.(stack)).(stack_type_6)) # (v_0.(poffset)) == ((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_idx] :< 0)) #
                (1 + ((v_0.(poffset)))) ==
                ((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).[e_idx] :< 1)) #
                (v_0.(poffset)) ==
                (((((st.(stack)).(stack_type_6)) @ (v_0.(poffset))).[e_g] :< (GRANULES_BASE + ((ret.(poffset))))).[e_idx] :< 0)) #
                (1 + ((v_0.(poffset)))) ==
                (((((st.(stack)).(stack_type_6)) @ (1 + ((v_0.(poffset))))).[e_g] :< (GRANULES_BASE + ((ret_0.(poffset))))).[e_idx] :< 1)))
          ))))).
  *)
  Definition find_lock_granules_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=  
  let v_4 := (ptr_offset v_0 ((40 * (0)) + ((0 + (0))))) in
  rely(v_4.(pbase) = "stack_type_6");
  rely(v_4.(poffset) = 0);
  when st == ((store_RData 4 v_4 0 st));
  let v_5 := (ptr_offset v_0 ((40 * (1)) + ((0 + (0))))) in
  rely(v_5.(pbase) = "stack_type_6");
  rely(v_5.(poffset) = 40);
  when st == ((store_RData 4 v_5 1 st));
  when st == ((sort_granules_spec v_0 2 st));
  match (
    let __retval__ := 0 in
    let __return__ := false in
    (Some (__return__, __retval__, st))
  ) with
  | (Some (__return__, __retval__, st)) =>
  (
    if __return__
    then (Some (__retval__, st))
    else 
      let v_11 := (ptr_offset v_0 ((40 * (0)) + ((8 + (0))))) in
      rely(v_11.(pbase) = "stack_type_6");
      when v_12, st == ((load_RData 8 v_11 st));
      let v_13 := (ptr_offset v_0 ((40 * (0)) + ((16 + (0))))) in
      rely(v_13.(pbase) = "stack_type_6");
      when v_14, st == ((load_RData 4 v_13 st));
      when v_15, st == ((find_lock_granule_spec v_12 v_14 st));
      rely( (v_15.(pbase) = "granules") \/ (v_15.(pbase) = "null") );
      rely( v_15.(poffset) >= 0 );
      (* FIX: add upperbound for "granules" pointer, avoid offset overflow *)
      rely (v_15.(pbase) = "null" \/ (v_15.(poffset) < GRANULE_SIZE * NR_GRANULES));
      (* rely(v_15.(poffset) mod 4096 = 0); *)
      let v_16 := (ptr_offset v_0 ((40 * (0)) + ((24 + (0))))) in
      rely(v_16.(pbase) = "stack_type_6");
      when st == ((store_RData 8 v_16 (ptr_to_int v_15) st));
      let v__not := ((ptr_eqb v_15 (mkPtr "null" 0))) in
      (* let v__not := (~(ptr_eqb v_15 (mkPtr "null" 0))) in *)
      match (
        let v__1_lcssa_wide := 0 in
        let v__1_lcssa47_wide := 0 in
        if v__not
        then (
          let v__1_lcssa_wide := 0 in
          let v__1_lcssa47_wide := 0 in
          (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)))
        else (
          match (
            if true
            then (
              let v_26 := (ptr_offset v_0 ((40 * (1)) + ((8 + (0))))) in
              rely(v_26.(pbase) = "stack_type_6");
              when v_27, st == ((load_RData 8 v_26 st));
              let v_28 := (ptr_offset v_0 ((40 * (0)) + ((8 + (0))))) in
              rely(v_28.(pbase) = "stack_type_6");
              when v_29, st == ((load_RData 8 v_28 st));
              let v_30 := (v_27 =? (v_29)) in
              match (
                if v_30
                then (
                  when v_9, st == ((make_return_code_spec 3 0 st));
                  let v__148 := 1 in
                  let v__sroa_02_0 := v_9 in
                  let v_49 := (v__148 >? (0)) in
                  when st == (
                      if v_49
                      then (
                        let v_50 := v__148 in
                        let v_51 := (v_50 + ((- 1))) in
                        let v_53 := (ptr_offset v_0 ((40 * (v_51)) + ((24 + (0))))) in
                        rely(v_53.(pbase) = "stack_type_6");
                        when v_54_tmp, st == ((load_RData 8 v_53 st));
                        rely(v_54_tmp >= GRANULES_BASE);
                        rely(v_54_tmp < RMM_ATTEST_SIGNING_KEY_BASE);
                        rely(v_54_tmp mod 16 = 0);
                        let v_54 := (int_to_ptr v_54_tmp) in
                        rely(v_54.(pbase) = "granules");
                        when st == ((granule_unlock_spec v_54 st));
                        (Some st))
                      else (Some st));
                  let v__sroa_039_0_insert_insert := v__sroa_02_0 in
                  let __return__ := true in
                  let __retval__ := v__sroa_039_0_insert_insert in
                  (Some (__return__, __retval__, st)))
                else (Some (__return__, __retval__, st))
              ) with
              | (Some (__return__, __retval__, st)) =>
                if __return__
                then (Some (__return__, __retval__, st))
                else (Some (__return__, __retval__, st))
              | None => None
              end)
            else (Some (__return__, __retval__, st))
          ) with
          | (Some (__return__, __retval__, st)) =>
            if __return__
            then (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st))
            else  (
              let v_32 := (ptr_offset v_0 ((40 * (1)) + ((8 + (0))))) in
              when v_33, st == ((load_RData 8 v_32 st));
              let v_34 := (ptr_offset v_0 ((40 * (1)) + ((16 + (0))))) in
              when v_35, st == ((load_RData 4 v_34 st));
              when v_36, st == ((find_lock_granule_spec v_33 v_35 st));
              rely( (v_36.(pbase) =s "granules") \/ (v_36.(pbase) =s "null") );
              rely( v_36.(poffset) >= 0 );
              rely (v_36.(pbase) =s "null" \/ (v_36.(poffset) <? GRANULE_SIZE * NR_GRANULES));
              let v_37 := (ptr_offset v_0 ((40 * (1)) + ((24 + (0))))) in
              when st == ((store_RData 8 v_37 (ptr_to_int v_36) st));
              let v__not_1 := (ptr_eqb v_36 (mkPtr "null" 0)) in
              match (
                let v__1_lcssa_wide := 0 in
                let v__1_lcssa47_wide := 0 in
                if v__not_1
                then (
                  let v__1_lcssa_wide := 1 in
                  let v__1_lcssa47_wide := 1 in
                  (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)))
                else (
                  let v_40 := (ptr_offset v_0 ((40 * (0)) + ((24 + (0))))) in
                  when v_41_tmp, st == ((load_RData 8 v_40 st)); (*struct granule ptr(granul_set.g)*)
                  let v_43 := (mkPtr "stack_type_4" 0) in
                  (* v_43 is read from the granule_set struct and can be represented as *)
                  (* let v_42 := (ptr_offset v_0 ((40 * (0)) + ((32 + (0))))) in *)
                  (* when v_43_tmp, st == ((load_RData 8 v_42 st)); *)
                  (* rely(v_43_tmp = STACK_TYPE_4_BASE); *)
                  (* let v_43 := (int_to_ptr v_43_tmp) in *)
                  when st == ((store_RData 8 v_43 v_41_tmp st));
                  (* we use v_41_tmp for simplicity. To better describe the code, use *)
                  (* rely(v_41_tmp >= GRANULES_BASE); *)
                  (* rely(v_41_tmp < RMM_ATTEST_SIGNING_KEY_BASE); *)
                  (* rely(v_41_tmp mod 16 = 0); *)
                  (* let v_41 := (int_to_ptr v_41_tmp) in *)
                  (* rely(v_41.(pbase) = "granules"); *)
                  (* when st == ((store_RData 8 v_43 (ptr_to_int v_41) st)); *)
                  let v_44 := (ptr_offset v_0 ((40 * (1)) + ((24 + (0))))) in
                  when v_45_tmp, st == ((load_RData 8 v_44 st));
                  let v_47 := (mkPtr "stack_type_4__1" 0) in
                  (* v_47 is read from the granule_set struct and can be represented as *)
                  (* let v_46 := (ptr_offset v_0 ((40 * (1)) + ((32 + (0))))) in *)
                  (* when v_47_tmp, st == ((load_RData 8 v_46 st)); *)
                  (* rely(v_47_tmp = STACK_TYPE_4__1_BASE); *)
                  (* let v_47 := (int_to_ptr v_47_tmp) in *)
                  when st == ((store_RData 8 v_47 v_45_tmp st));
                  (* we use v_45_tmp for simplicity. To better describe the code, use *)
                  (* rely(v_45_tmp >= GRANULES_BASE); *)
                  (* rely(v_45_tmp < RMM_ATTEST_SIGNING_KEY_BASE); *)
                  (* rely(v_45_tmp mod 16 = 0); *)
                  (* let v_45 := (int_to_ptr v_45_tmp) in *)
                  (* rely(v_45.(pbase) = "granules"); *)
                  (* when st == ((store_RData 8 v_47 (ptr_to_int v_45) st)); *)
                  let v__sroa_039_0_insert_insert := 0 in
                  let __return__ := true in
                  let __retval__ := v__sroa_039_0_insert_insert in
                  (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st))
                ) 
              ) with
              | (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)) =>
                if __return__
                then (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st))
                else (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st))
              | None => None
              end 
              )
          | None => None
          end
        )
      ) with
      | (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)) =>
        if __return__
        then (Some (__retval__, st))
        else (
          let v_18 := v__1_lcssa47_wide in
          let v_19 := v__1_lcssa_wide in
          let v_20 := v_19 in
          let v_21 := (ptr_offset v_0 ((40 * (v_20)) + ((0 + (0))))) in
          when v_22, st == ((load_RData 4 v_21 st));
          when v_23, st == ((make_return_code_spec 1 v_22 st));
          let v__148 := v_18 in
          let v__sroa_02_0 := v_23 in
          let v_49 := (v__148 >? (0)) in
          when st == (
              if v_49
              then (
                let v_50 := v__148 in
                let v_51 := (v_50 + ((- 1))) in
                let v_53 := (ptr_offset v_0 ((40 * (v_51)) + ((24 + (0))))) in
                rely(v_53.(pbase) = "stack_type_6");
                when v_54_tmp, st == ((load_RData 8 v_53 st));
                rely(v_54_tmp >= GRANULES_BASE);
                rely(v_54_tmp < RMM_ATTEST_SIGNING_KEY_BASE);
                rely(v_54_tmp mod 16 = 0);
                let v_54 := (int_to_ptr v_54_tmp) in
                rely(v_54.(pbase) = "granules");
                when st == ((granule_unlock_spec v_54 st));
                (Some st))
              else (Some st));
          let v__sroa_039_0_insert_insert := v__sroa_02_0 in
          let __return__ := true in
          let __retval__ := v__sroa_039_0_insert_insert in
          (Some (__retval__, st))
      )
      | None => None
      end
  )
  | None => None
  end.

  Hint InitRely get_realm_identity ((v_0.(pbase) = "stack_s_q_useful_buf" /\ v_0.(poffset) >= 0) /\ 
                                    (v_1.(pbase) = "stack_s_q_useful_buf" /\ v_1.(poffset) >= 0)).
  Hint InitRely realm_ipa_bits (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0).
  Hint InitRely realm_ipa_bits ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).

  Hint InitRely realm_rtt_starting_level (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0).
  Hint InitRely realm_rtt_starting_level ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  
  Hint InitRely is_addr_in_par (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0 /\ ((v_0.(poffset) mod 4096) = 0) /\ v_1 mod 4096 = 0).
  Hint InitRely is_addr_in_par ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  
  Hint InitRely system_off_reboot (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely system_off_reboot ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  Hint InitRely rd_map_read_rec_count (v_0.(pbase) = "granules"  /\ (v_0.(poffset) mod 16 = 0) /\ v_0.(poffset) >= 0).
  Hint InitRely g_mapped_addr_set (v_0.(pbase) = "granules"  /\ (v_0.(poffset) mod 16 = 0) /\ v_0.(poffset) >= 0).

  Hint InitRely granule_set_state ((v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0) /\ v_1 >= 0 /\ v_1 <= 6).

  Hint InitRely __granule_get (v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0).
  Hint InitRely g_refcount (v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0).

  Hint InitRely __granule_put (v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0).

  Hint InitRely __tte_write (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0).

  (* Definition memset_spec (v_s: Ptr) (c: Z) (n: Z) (st: RData) : option (Ptr * RData) := Some (v_s, st). *)

  Definition s2tt_init_unassigned_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) := Some st.

  Hint NoUnfold s2tt_init_unassigned_spec.
  
  Definition s2tt_init_unassigned_loop759_rank (v: Ptr) (v_0: Z) (v_1:Z) : Z := 0.
  Definition s2tt_init_unassigned_loop759_0_rank (v: Ptr) (v_0: Z) (v_1:Z) : Z := 0.

End Layer6.   

Section Layer7.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    "s1addr_level_mask" :: 
    "ranges_intersect" ::
    "get_sysreg_write_value" ::
    "esr_srt" ::
    "access_mask" ::
    (* "create_realm_token" :: *)
    (* "memcpy" :: *)
    "realm_ipa_to_pa" ::
    "psci_cpu_off" ::
    "psci_system_reset" ::
    "psci_system_off" ::
    "psci_affinity_info" ::
    "psci_features" ::
    "psci_cpu_suspend" ::
    "psci_cpu_on" ::
    "psci_version" ::
    "region_is_contained" ::
    "get_tte" :: 
    (* TODO: add post-condition *)
    (* load -> arith -> int_to_ptr *)
    (* "memcpy_ns_read_byte" :: *)
    "s1tte_is_valid" ::
    "smc_granule_ns_to_any" :: 
    "smc_granule_any_to_ns" ::
    (* "memcpy_ns_write_byte" :: *)
    "granule_unlock_transition" ::
    "data_create_internal" :: 
    (* To fully automatically reason "data_create_internal", it needs to solve the transitive relation in rtt_walk_lock_unlock
      sol 1. add manual rely *)
    (* "find_lock_two_granules" :: *)
    "rtt_create_internal" ::
    "s2tte_is_assigned" ::
    nil.
  
  Hint InitRely rtt_create_internal (v_0.(pbase) = "granules" /\ (v_0.(poffset) mod 16 = 0) /\ v_0.(poffset) >= 0).

  Definition s2tte_create_ripas_spec' (v_0: Z) : (option Z) :=
    if (v_0 =? (0))
    then (Some 0)
    else (Some 64).

  Definition s2tte_get_ripas_spec' (v_0: Z) : (option Z) :=
    if ((v_0 & (64)) =? (0))
    then (Some 0)
    else (Some 1).
    
  Hint NoTrans rtt_create_internal_spec.
  Hint NoTrans rtt_create_internal_spec_low.
(*   
  Definition rtt_create_internal_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
  rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
  rely (
    (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - (4294967296)) < (0)))) \/ ((((v_1 - (MEM1_PHYS)) >= (0)) /\ (((v_1 - (556198264832)) < (0)))))) /\
      (((v_1 & (4095)) = (0)))));
  match (((((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
  | None =>
    rely (
      (((((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
        ((((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
        (0)));
    if (((((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (1)) =? (0))
    then (
      when st_3 == (
          (rtt_walk_lock_unlock_spec
            (mkPtr "stack_s_rtt_walk" 0)
            v_0
            0
            64
            v_2
            v_3
            ((st.[log] :< ((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
              ((st.(share)).[globals].[g_granules] :<
                ((((st.(share)).(globals)).(g_granules)) #
                  ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))))));
      rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >=? (0)));
      rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) <? (0)));
      if (((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
      then (
        rely (
          ((((("granules" = ("granules")) /\ ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
            ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
            ((6 >= (0)))) /\
            ((6 <= (24)))));
        when ret == ((granule_addr_spec' (mkPtr "granules" ((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
        when ret_0 == ((buffer_map_spec' 6 ret false));
        when v_25, st_n == ((__tte_read_spec (mkPtr (ret_0.(pbase)) ((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st));
        when ret_1 == ((granule_addr_spec' (mkPtr "granules" (((v_1 + ((- MEM0_PHYS))) >> (12)) * (16)))));
        when ret_2 == ((buffer_map_spec' 1 ret_1 false));
        if ((v_25 & (63)) =? (0))
        then (
          when ret_3 == ((s2tte_get_ripas_spec' v_25));
          when ret_4 == ((s2tte_create_ripas_spec' ret_3));
          match (
            match ((s2tt_init_unassigned_loop759_0 (z_to_nat 0) false ret_2 ret_4 0 st)) with
            | (Some (__break__, v_8, v_7, v_index_0, st_1)) => (Some (true, 0, st_1))
            | None => None
            end
          ) with
          | (Some (__return__, v_bc_resume_val, st_1)) =>
            if __return__
            then (
              rely ((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
              when cid == (
                  ((((((((st.(share)).(globals)).(g_granules)) #
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                      ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                        (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                    ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                    ((((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                        ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                      5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
              when cid_0 == (
                  (((((((((st.(share)).(globals)).(g_granules)) #
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                      ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                        (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                    ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                    ((((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                        ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                      5)) #
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                    (((((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                        ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                      ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                        5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                      None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
              (Some (
                0  ,
                (((st.[log] :<
                  ((EVT
                    CPU_ID
                    (REL
                      ((v_1 + ((- MEM0_PHYS))) >> (12))
                      (((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                        ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                        ((((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                            ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                          5)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                            ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                          ((((((st.(share)).(globals)).(g_granules)) #
                            (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                            5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                          None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))))) ::
                    (((EVT
                      CPU_ID
                      (REL
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                            ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                          ((((((st.(share)).(globals)).(g_granules)) #
                            (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                            5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st.(log))))))).[share].[globals].[g_granules] :<
                  (((((((st.(share)).(globals)).(g_granules)) #
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                      ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                        (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                    ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                    ((((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                        ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                      5)) #
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                    (((((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                        ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                      ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                        5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                      None)) #
                    ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                    ((((((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                        ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                      ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                        5)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                        ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                        ((((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                            ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                          5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                      None))).[share].[granule_data] :<
                  (((st.(share)).(granule_data)) #
                    (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                    (((((st.(share)).(granule_data)) @ (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                      (((((st.(share)).(granule_data)) @ (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                        (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                        (v_1 |' (3)))).[g_granule_state] :< 5)))
              )))
            else (
              match ((s2tt_init_unassigned_loop759 (z_to_nat 0) false ret_2 ret_4 v_bc_resume_val st)) with
              | (Some (__break__, v_8, v_7, v_indvars_iv_0, st_2)) =>
                rely ((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                when cid == (
                    ((((((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                        ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                      ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                        5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                when cid_0 == (
                    (((((((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                        ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                      ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                        5)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                        ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                        ((((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                            ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                          5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                (Some (
                  0  ,
                  (((st.[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        ((v_1 + ((- MEM0_PHYS))) >> (12))
                        (((((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                            ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                          ((((((st.(share)).(globals)).(g_granules)) #
                            (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                            5)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((((st.(share)).(globals)).(g_granules)) #
                            (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                            ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                            ((((((st.(share)).(globals)).(g_granules)) #
                              (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                              5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                            None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))))) ::
                      (((EVT
                        CPU_ID
                        (REL
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((((st.(share)).(globals)).(g_granules)) #
                            (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                            ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                            ((((((st.(share)).(globals)).(g_granules)) #
                              (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                              5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st.(log))))))).[share].[globals].[g_granules] :<
                    (((((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                        ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                      ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                        5)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                        ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                        ((((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                            ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                          5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) #
                      ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((((((st.(share)).(globals)).(g_granules)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                          ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                        ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                        ((((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                            ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                          5)) #
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                        (((((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                            ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                          ((((((st.(share)).(globals)).(g_granules)) #
                            (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                            5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                          None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                        None))).[share].[granule_data] :<
                    (((st.(share)).(granule_data)) #
                      (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                      (((((st.(share)).(granule_data)) @ (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                        (((((st.(share)).(granule_data)) @ (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                          (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                          (v_1 |' (3)))).[g_granule_state] :< 5)
                          ))
                ))
              | None => None
              end)
          | None => None
          end)
        else (
          if (((v_3 + ((- 1))) <? (3)) && (((v_25 & (3)) =? (3))))
          then (
            when cid == (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
            when cid_0 == (
                (((((((st.(share)).(globals)).(g_granules)) #
                  (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
            (Some (
              9  ,
              ((st.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    ((v_1 + ((- MEM0_PHYS))) >> (12))
                    (((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))))) ::
                  (((EVT
                    CPU_ID
                    (REL
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                      ((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                    ((st.(log))))))).[share].[globals].[g_granules] :<
                (((((st.(share)).(globals)).(g_granules)) #
                  (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                  ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                  ((((((st.(share)).(globals)).(g_granules)) #
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                    None)))
            )))
          else (
            rely ((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
            when cid == (
                (((((((st.(share)).(globals)).(g_granules)) #
                  ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :< 5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
            when cid_0 == (
                ((((((((st.(share)).(globals)).(g_granules)) #
                  ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :< 5)) #
                  (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                  ((((((st.(share)).(globals)).(g_granules)) #
                    ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :< 5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                    None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
            (Some (
              0  ,
              (((st.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    ((v_1 + ((- MEM0_PHYS))) >> (12))
                    ((((((st.(share)).(globals)).(g_granules)) #
                      ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :< 5)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      ((((((st.(share)).(globals)).(g_granules)) #
                        ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :< 5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))))) ::
                  (((EVT
                    CPU_ID
                    (REL
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                      (((((st.(share)).(globals)).(g_granules)) #
                        ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :< 5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                    ((st.(log))))))).[share].[globals].[g_granules] :<
                ((((((st.(share)).(globals)).(g_granules)) #
                  ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :< 5)) #
                  (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                  ((((((st.(share)).(globals)).(g_granules)) #
                    ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :< 5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                    None)) #
                  ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                  (((((((st.(share)).(globals)).(g_granules)) #
                    ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :< 5)) #
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                    ((((((st.(share)).(globals)).(g_granules)) #
                      ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :< 5)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                      None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                    None))).[share].[granule_data] :<
                (((st.(share)).(granule_data)) #
                  (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                   (((((st.(share)).(granule_data)) @ (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                    (((((st.(share)).(granule_data)) @ (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                      (((ret_0.(poffset)) + ((8 * ((((st.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                      (v_1 |' (3))) ).[g_granule_state] :< 5)))
            )))))
      else (
        if (v_4 =? (0))
        then (
          when cid == (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
          when cid_0 == (
              (((((((st.(share)).(globals)).(g_granules)) #
                (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
          (Some (
            ((((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
              ((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
            ((st.[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((v_1 + ((- MEM0_PHYS))) >> (12))
                  (((((st.(share)).(globals)).(g_granules)) #
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))))) ::
                (((EVT
                  CPU_ID
                  (REL
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                    ((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                  ((st.(log))))))).[share].[globals].[g_granules] :<
              (((((st.(share)).(globals)).(g_granules)) #
                (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                ((((((st.(share)).(globals)).(g_granules)) #
                  (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                  None)))
          )))
        else (
          if (((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_3)) =? (0))
          then (
            when cid == (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
            when cid_0 == (
                (((((((st.(share)).(globals)).(g_granules)) #
                  (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
            (Some (
              5299989959177  ,
              ((st.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    ((v_1 + ((- MEM0_PHYS))) >> (12))
                    (((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))))) ::
                  (((EVT
                    CPU_ID
                    (REL
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                      ((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                    ((st.(log))))))).[share].[globals].[g_granules] :<
                (((((st.(share)).(globals)).(g_granules)) #
                  (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                  ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                  ((((((st.(share)).(globals)).(g_granules)) #
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                    None)))
            )))
          else (
            when cid == (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
            when cid_0 == (
                (((((((st.(share)).(globals)).(g_granules)) #
                  (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
            (Some (
              ((((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                ((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
              ((st.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    ((v_1 + ((- MEM0_PHYS))) >> (12))
                    (((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))))) ::
                  (((EVT
                    CPU_ID
                    (REL
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                      ((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                    ((st.(log))))))).[share].[globals].[g_granules] :<
                (((((st.(share)).(globals)).(g_granules)) #
                  (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                  ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                  ((((((st.(share)).(globals)).(g_granules)) #
                    (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                    None)))
            ))))))
    else (
      (Some (
        4294967553  ,
        ((st.[log] :<
          ((EVT CPU_ID (REL ((v_1 + ((- MEM0_PHYS))) >> (12)) (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
            (((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
          ((st.(share)).[globals].[g_granules] :<
            ((((st.(share)).(globals)).(g_granules)) #
              ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
              (((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))
      )))
  | (Some cid) => None
  end. *)

  Hint InitRely granule_unlock_transition ((v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0) /\ v_1 >= 0 /\ v_1 <= 6).
  Hint InitRely smc_granule_ns_to_any (((v_1 >= MEM0_PHYS /\ v_1 < MEM0_PHYS + MEM0_SIZE) \/ (v_1 >= MEM1_PHYS /\ v_1 < MEM1_PHYS + MEM1_SIZE)) /\ (v_1 & 4095 = 0)).
  Hint InitRely smc_granule_any_to_ns (((v_0 >= MEM0_PHYS /\ v_0 < MEM0_PHYS + MEM0_SIZE) \/ (v_0 >= MEM1_PHYS /\ v_0 < MEM1_PHYS + MEM1_SIZE)) /\ (v_0 & 4095 = 0)).
  Hint InitRely get_sysreg_write_value (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0 /\ (v_0.(poffset) mod 4096 = 0)).
  
  Hint InitRely psci_cpu_off (v_0.(pbase) = "stack_s_psci_result" /\ v_0.(poffset) = 0).
  Hint InitRely psci_cpu_off (v_1.(pbase) = "granule_data" /\ v_1.(poffset) >= 0).
  Hint InitRely psci_cpu_off ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  Hint InitRely psci_system_reset (v_0.(pbase) = "stack_s_psci_result" /\ v_0.(poffset) = 0).
  Hint InitRely psci_system_reset (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely psci_system_reset ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  Hint InitRely psci_system_off (v_0.(pbase) = "stack_s_psci_result" /\ v_0.(poffset) = 0).
  Hint InitRely psci_system_off (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely psci_system_off ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  Hint InitRely psci_cpu_suspend (v_0.(pbase) = "stack_s_psci_result" /\ v_0.(poffset) = 0).
  Hint InitRely psci_cpu_suspend (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely psci_cpu_suspend ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  
  Hint InitRely psci_cpu_on (v_0.(pbase) = "stack_s_psci_result" /\ v_0.(poffset) = 0).
  Hint InitRely psci_cpu_on (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely psci_cpu_on ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  Hint InitRely psci_version (v_0.(pbase) = "stack_s_psci_result" /\ v_0.(poffset) = 0).
  Hint InitRely psci_version (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely psci_version ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  Hint InitRely psci_affinity_info (v_0.(pbase) = "stack_s_psci_result" /\ v_0.(poffset) = 0).
  Hint InitRely psci_affinity_info (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely psci_affinity_info ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  Hint InitRely psci_features (v_0.(pbase) = "stack_s_psci_result" /\ v_0.(poffset) = 0).
  Hint InitRely psci_features (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely psci_features ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  (* TODO: add load_s_rd *)
  Hint InitRely realm_ipa_to_pa (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0).
  Hint InitRely realm_ipa_to_pa ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  Hint InitRely realm_ipa_to_pa (v_2.(pbase) = "stack_type_3__1" /\ v_2.(poffset) = 0).
  Hint InitRely realm_ipa_to_pa (v_3.(pbase) = "stack_type_4" /\ v_3.(poffset) = 0).
  Hint InitRely realm_ipa_to_pa (v_4.(pbase) = "stack_type_3" /\ v_4.(poffset) = 0).

  Hint InitRely data_create_internal (v_3.(pbase) = "granules" /\ (v_3.(poffset) mod 16 = 0) /\ v_3.(poffset) >= 0).
  Hint InitRely data_create_internal (v_4.(pbase) = "granule_data" /\ (v_4.(poffset) mod 4096 = 0) /\ v_4.(poffset) >= 0).
  Hint InitRely data_create_internal ((st.(share).(granule_data) @ (v_4.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  (* Hint NoTrans rtt_create_internal_spec. *)
  (* Hint NoUnfold rtt_create_internal_spec. *)
  Hint NoTrans data_create_internal_spec.
  Hint NoUnfold data_create_internal_spec.
  (* Modify generated low spec, add abstract PA_TO_VA *)
  Definition get_tte_spec' (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (3)) =? (3))
    then (
      rely (
        ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
          (MEM0_VIRT)) >=
          (0)) \/
          ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
            (MEM1_VIRT)) >=
            (0)))));
      if (
        (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) - (MAX_ERR)) >=?
          (0)))
      then None
      else (
        if (
          (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
            (MEM1_VIRT)) >=?
            (0)))
        then (
          if (
            (((((((st.(share)).(granule_data)) @
              (((18446744007137558528 +
                ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                (4096))).(g_norm)) @
              (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                (4096))) &
              (3)) =?
              (3)))
          then (
            rely (
              ((((PA_TO_VA
                (((((((st.(share)).(granule_data)) @
                  (((18446744007137558528 +
                    ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                    (4096))).(g_norm)) @
                  (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                    (4096))) &
                  (281474976710655)) &
                  (((- 1) << (12))))) -
                (MEM0_VIRT)) >=
                (0)) \/
                ((((PA_TO_VA
                  (((((((st.(share)).(granule_data)) @
                    (((18446744007137558528 +
                      ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                      (4096))).(g_norm)) @
                    (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                      (4096))) &
                    (281474976710655)) &
                    (((- 1) << (12))))) -
                  (MEM1_VIRT)) >=
                  (0)))));
            if (
              (((PA_TO_VA
                (((((((st.(share)).(granule_data)) @
                  (((18446744007137558528 +
                    ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                    (4096))).(g_norm)) @
                  (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                    (4096))) &
                  (281474976710655)) &
                  (((- 1) << (12))))) -
                (MAX_ERR)) >=?
                (0)))
            then (
              (Some (
                (mkPtr
                  "status"
                  (((PA_TO_VA
                    (((((((st.(share)).(granule_data)) @
                      (((18446744007137558528 +
                        ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                        ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                        (4096))).(g_norm)) @
                      (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                        ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                        (4096))) &
                      (281474976710655)) &
                      (((- 1) << (12))))) -
                    (MAX_ERR)) +
                    ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                st
              )))
            else (
              if (
                (((PA_TO_VA
                  (((((((st.(share)).(granule_data)) @
                    (((18446744007137558528 +
                      ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                      (4096))).(g_norm)) @
                    (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                      (4096))) &
                    (281474976710655)) &
                    (((- 1) << (12))))) -
                  (MEM1_VIRT)) >=?
                  (0)))
              then (
                (Some (
                  (mkPtr
                    "granule_data"
                    ((((PA_TO_VA
                      (((((((st.(share)).(granule_data)) @
                        (((18446744007137558528 +
                          ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                          (4096))).(g_norm)) @
                        (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                          (4096))) &
                        (281474976710655)) &
                        (((- 1) << (12))))) -
                      (MEM1_VIRT)) +
                      (MEM0_SIZE)) +
                      ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                  st
                )))
              else (
                (Some (
                  (mkPtr
                    "granule_data"
                    (((PA_TO_VA
                      (((((((st.(share)).(granule_data)) @
                        (((18446744007137558528 +
                          ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                          (4096))).(g_norm)) @
                        (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                          (4096))) &
                        (281474976710655)) &
                        (((- 1) << (12))))) -
                      (MEM0_VIRT)) +
                      ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                  st
                )))))
          else (Some ((mkPtr "null" 0), st)))
        else (
          if (
            (((((((st.(share)).(granule_data)) @
              ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                (MEM0_VIRT)) +
                ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                (4096))).(g_norm)) @
              (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                (4096))) &
              (3)) =?
              (3)))
          then (
            rely (
              ((((PA_TO_VA
                (((((((st.(share)).(granule_data)) @
                  ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                    (MEM0_VIRT)) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                    (4096))).(g_norm)) @
                  (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                    (4096))) &
                  (281474976710655)) &
                  (((- 1) << (12))))) -
                (MEM0_VIRT)) >=
                (0)) \/
                ((((PA_TO_VA
                  (((((((st.(share)).(granule_data)) @
                    ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                      (MEM0_VIRT)) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                      (4096))).(g_norm)) @
                    (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                      (4096))) &
                    (281474976710655)) &
                    (((- 1) << (12))))) -
                  (MEM1_VIRT)) >=
                  (0)))));
            if (
              (((PA_TO_VA
                (((((((st.(share)).(granule_data)) @
                  ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                    (MEM0_VIRT)) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                    (4096))).(g_norm)) @
                  (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                    (4096))) &
                  (281474976710655)) &
                  (((- 1) << (12))))) -
                (MAX_ERR)) >=?
                (0)))
            then (
              (Some (
                (mkPtr
                  "status"
                  (((PA_TO_VA
                    (((((((st.(share)).(granule_data)) @
                      ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                        (MEM0_VIRT)) +
                        ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                        (4096))).(g_norm)) @
                      (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                        ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                        (4096))) &
                      (281474976710655)) &
                      (((- 1) << (12))))) -
                    (MAX_ERR)) +
                    ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                st
              )))
            else (
              if (
                (((PA_TO_VA
                  (((((((st.(share)).(granule_data)) @
                    ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                      (MEM0_VIRT)) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                      (4096))).(g_norm)) @
                    (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                      (4096))) &
                    (281474976710655)) &
                    (((- 1) << (12))))) -
                  (MEM1_VIRT)) >=?
                  (0)))
              then (
                (Some (
                  (mkPtr
                    "granule_data"
                    ((((PA_TO_VA
                      (((((((st.(share)).(granule_data)) @
                        ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                          (MEM0_VIRT)) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                          (4096))).(g_norm)) @
                        (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                          (4096))) &
                        (281474976710655)) &
                        (((- 1) << (12))))) -
                      (MEM1_VIRT)) +
                      (MEM0_SIZE)) +
                      ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                  st
                )))
              else (
                (Some (
                  (mkPtr
                    "granule_data"
                    (((PA_TO_VA
                      (((((((st.(share)).(granule_data)) @
                        ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                          (MEM0_VIRT)) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                          (4096))).(g_norm)) @
                        (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                          (4096))) &
                        (281474976710655)) &
                        (((- 1) << (12))))) -
                      (MEM0_VIRT)) +
                      ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                  st
                )))))
          else (Some ((mkPtr "null" 0), st)))))
    else (Some ((mkPtr "null" 0), st)).

  Definition get_tte_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    when ret, st' == ((get_tte_spec' v_0 st));
    (Some (ret, st)).
  Hint NoUnfold get_tte_spec.
  Hint PostEnsure get_tte_spec (ret_0.(pbase) = "granule_data" \/ ret_0.(pbase) = "null").
  (* TODO: add this post condition for get_tte: 
    Prop: ptr.pbase = "Granule_Data" ==> st.(granule_data)[ptr] = GRANULE_STATE_DATA *)

  Definition find_lock_two_granules_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (v_3: Z) (v_4: Z) (v_5: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "find_lock_two_granules" st));
    when st_1 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 0) 0 st_0));
    when st_2 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 8) v_0 st_1));
    when st_3 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 16) v_1 st_2));
    when st_4 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 24) (ptr_to_int (mkPtr "null" 0)) st_3));
    (* when st_5 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 32) (ptr_to_int v_2) st_4)); *)
    when st_6 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 40) 1 st_4));
    when st_7 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 48) v_3 st_6));
    when st_8 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 56) v_4 st_7));
    when st_9 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 64) (ptr_to_int (mkPtr "null" 0)) st_8));
    (* when st_10 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 72) (ptr_to_int v_5) st_9)); *)
    when v_19, st_11 == ((find_lock_granules_spec_low (ptr_offset (mkPtr "stack_type_6" 0) 0) 2 st_9));
    when st_12 == ((free_stack "find_lock_two_granules" st_0 st_11));
    (Some (v_19, st_12))
  (* Definition find_lock_two_granules_spec_low (v_0: Z) (v_1: Z) (v_2: Ptr) (v_3: Z) (v_4: Z) (v_5: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "find_lock_two_granules" st));
    when st_1 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 0) 0 st_0));
    when st_2 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 8) v_0 st_1));
    when st_3 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 16) v_1 st_2));
    when st_4 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 24) (ptr_to_int (mkPtr "null" 0)) st_3));
    (* when st_5 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 32) (ptr_to_int v_2) st_4)); *)
    when st_6 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 40) 1 st_4));
    when st_7 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 48) v_3 st_6));
    when st_8 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 56) v_4 st_7));
    when st_9 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 64) (ptr_to_int (mkPtr "null" 0)) st_8));
    (* when st_10 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 72) (ptr_to_int v_5) st_9)); *)
    when v_19, st_11 == ((find_lock_granules_spec (ptr_offset (mkPtr "stack_type_6" 0) 0) 2 st_9));
    when st_12 == ((free_stack "find_lock_two_granules" st_0 st_11));
    (Some (v_19, st_12)). *)
  end.

  (*
  Definition rtt_create_internal_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when ret, st' == ((find_lock_granule_spec' v_1 1 st));
    rely (((((ret.(poffset)) mod (16)) = (0)) /\ (((ret.(poffset)) >= (0)))));
    rely ((((ret.(pbase)) = ("granules")) \/ (((ret.(pbase)) = ("null")))));
    if (
      if ((ret.(pbase)) =s ("null"))
      then true
      else ((GRANULES_BASE + ((ret.(poffset)))) =? (0)))
    then (Some (4294967553, st))
    else (
      when st_3 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "stack_type_5" 0) 0 32 false st));
      when st_415 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "stack_s_rtt_walk" 0) 0 24 false st_3));
      if ((((Z.lxor ((- 1) << (64)) (- 1)) & (v_2)) >> (39)) >? (511))
      then (
        rely (
          ((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\
            ((((v_0.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (64)) (- 1)) & (v_2)) >> (39)) >> (9)) & (4294967295)))))) >= (0)))));
        if ((0 - (v_3)) <? (0))
        then (
          match (
            (rtt_walk_lock_unlock_loop467
              (z_to_nat 0)
              false
              false
              (mkPtr "stack_s_rtt_walk" 0)
              v_2
              v_3
              (mkPtr "stack_type_5" 0)
              0
              (st_415.[stack].[stack_type_5] :<
                (((st_415.(stack)).(stack_type_5)) #
                  0 ==
                  (GRANULES_BASE + (((v_0.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (64)) (- 1)) & (v_2)) >> (39)) >> (9)) & (4294967295)))))))))))
          ) with
          | (Some (return___529, __break__, v_38, v_40, v_11, v_39, v_indvars_iv_1, st_417)) =>
            if return___529
            then (
              rely ((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >=? (0)));
              if (((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
              then (
                rely (((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MAX_ERR)) >=? (0)) = (false)));
                rely (((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM1_VIRT)) >=? (0)) = (false)));
                rely (((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) >=? (0)) = (false)));
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                when ret_0 == ((granule_addr_spec' (mkPtr "granules" ((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                when ret_1 == ((buffer_map_spec' 6 ret_0 false));
                rely ((((ret_1.(pbase)) = ("granule_data")) /\ ((((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                when ret_2 == ((granule_addr_spec' ret));
                when ret_3 == ((buffer_map_spec' 1 ret_2 false));
                if (
                  (((((((st_417.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096))) &
                    (63)) =?
                    (0)))
                then (
                  when ret_4 == (
                      (s2tte_get_ripas_spec'
                        (((((st_417.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)))));
                  when ret_5 == ((s2tte_create_ripas_spec' ret_4));
                  match (
                    match ((s2tt_init_unassigned_loop759_0 (z_to_nat 0) false ret_3 ret_5 0 st_417)) with
                    | (Some (__break___0, v_8, v_7, v_index_0, st_1)) => (Some (true, 0, st_1))
                    | None => None
                    end
                  ) with
                  | (Some (__return__, v_bc_resume_val, st_1)) =>
                    if __return__
                    then (
                      (Some (
                        0  ,
                        ((st_1.[share].[globals].[g_granules] :<
                          (((((st_1.(share)).(globals)).(g_granules)) #
                            (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                            ((ret.(poffset)) / (16)) ==
                            ((((((st_1.(share)).(globals)).(g_granules)) #
                              (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              (((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                ((((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((ret.(poffset)) / (16))).[e_state_s_granule] :<
                              5))).[share].[granule_data] :<
                          (((st_1.(share)).(granule_data)) #
                            (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                            ((((st_1.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                              (((((st_1.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                (v_1 |' (3))))))
                      )))
                    else (
                      match ((s2tt_init_unassigned_loop759 (z_to_nat 0) false ret_3 ret_5 v_bc_resume_val st_1)) with
                      | (Some (__break___0, v_8, v_7, v_indvars_iv_0, st_2)) =>
                        (Some (
                          0  ,
                          ((st_2.[share].[globals].[g_granules] :<
                            (((((st_2.(share)).(globals)).(g_granules)) #
                              (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                              ((ret.(poffset)) / (16)) ==
                              ((((((st_2.(share)).(globals)).(g_granules)) #
                                (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((ret.(poffset)) / (16))).[e_state_s_granule] :<
                                5))).[share].[granule_data] :<
                            (((st_2.(share)).(granule_data)) #
                              (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_2.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_2.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  (v_1 |' (3))))))
                        ))
                      | None => None
                      end)
                  | None => None
                  end)
                else (
                  if (
                    (((v_3 + ((- 1))) <? (3)) &&
                      ((((((((st_417.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096))) &
                        (3)) =?
                        (3)))))
                  then (Some (9, st_417))
                  else (
                    (Some (
                      0  ,
                      ((st_417.[share].[globals].[g_granules] :<
                        ((((st_417.(share)).(globals)).(g_granules)) #
                          ((ret.(poffset)) / (16)) ==
                          (((((st_417.(share)).(globals)).(g_granules)) @ ((ret.(poffset)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                        (((st_417.(share)).(granule_data)) #
                          (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                          ((((st_417.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                            (((((st_417.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                              (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                              (v_1 |' (3))))))
                    )))))
              else (
                if (v_4 =? (0))
                then (
                  (Some (
                    ((((((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    st_417
                  )))
                else (
                  if (((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_3)) =? (0))
                  then (Some (5299989959177, st_417))
                  else (
                    (Some (
                      ((((((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                        ((((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                      st_417
                    ))))))
            else (
              rely ((((0 - (v_3)) <= (0)) /\ ((v_3 < (4)))));
              rely ((((((st_417.(stack)).(stack_type_5)) @ v_3) - (GRANULES_BASE)) >=? (0)));
              if (v_4 =? (0))
              then (
                (Some (
                  (((((v_3 << (32)) + (8)) >> (24)) & (4294967040)) |' (((v_3 << (32)) + (8))))  ,
                  (st_417.[stack].[stack_s_rtt_walk] :<
                    (((((st_417.(stack)).(stack_s_rtt_walk)).[e_g_llt] :< (((st_417.(stack)).(stack_type_5)) @ v_3)).[e_index_s_rtt_walk] :<
                      ((v_2 >> (((39 + (((- 9) * (v_3)))) & (4294967295)))) & (511))).[e_last_level] :<
                      v_3))
                )))
              else (
                (Some (
                  5299989959177  ,
                  (st_417.[stack].[stack_s_rtt_walk] :<
                    (((((st_417.(stack)).(stack_s_rtt_walk)).[e_g_llt] :< (((st_417.(stack)).(stack_type_5)) @ v_3)).[e_index_s_rtt_walk] :<
                      ((v_2 >> (((39 + (((- 9) * (v_3)))) & (4294967295)))) & (511))).[e_last_level] :<
                      v_3))
                ))))
          | None => None
          end)
        else (
          rely ((((0 - (v_3)) <= (0)) /\ ((v_3 < (4)))));
          if (v_4 =? (0))
          then (
            (Some (
              (((((v_3 << (32)) + (8)) >> (24)) & (4294967040)) |' (((v_3 << (32)) + (8))))  ,
              ((st_415.[stack].[stack_s_rtt_walk] :<
                (((((st_415.(stack)).(stack_s_rtt_walk)).[e_g_llt] :<
                  (GRANULES_BASE + (((v_0.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (64)) (- 1)) & (v_2)) >> (39)) >> (9)) & (4294967295))))))))).[e_index_s_rtt_walk] :<
                  ((v_2 >> (((39 + (((- 9) * (v_3)))) & (4294967295)))) & (511))).[e_last_level] :<
                  v_3)).[stack].[stack_type_5] :<
                (((st_415.(stack)).(stack_type_5)) #
                  0 ==
                  (GRANULES_BASE + (((v_0.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (64)) (- 1)) & (v_2)) >> (39)) >> (9)) & (4294967295))))))))))
            )))
          else (
            (Some (
              5299989959177  ,
              ((st_415.[stack].[stack_s_rtt_walk] :<
                (((((st_415.(stack)).(stack_s_rtt_walk)).[e_g_llt] :<
                  (GRANULES_BASE + (((v_0.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (64)) (- 1)) & (v_2)) >> (39)) >> (9)) & (4294967295))))))))).[e_index_s_rtt_walk] :<
                  ((v_2 >> (((39 + (((- 9) * (v_3)))) & (4294967295)))) & (511))).[e_last_level] :<
                  v_3)).[stack].[stack_type_5] :<
                (((st_415.(stack)).(stack_type_5)) #
                  0 ==
                  (GRANULES_BASE + (((v_0.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (64)) (- 1)) & (v_2)) >> (39)) >> (9)) & (4294967295))))))))))
            )))))
      else (
        if ((0 - (v_3)) <? (0))
        then (
          match (
            (rtt_walk_lock_unlock_loop467
              (z_to_nat 0)
              false
              false
              (mkPtr "stack_s_rtt_walk" 0)
              v_2
              v_3
              (mkPtr "stack_type_5" 0)
              0
              (st_415.[stack].[stack_type_5] :< (((st_415.(stack)).(stack_type_5)) # 0 == (GRANULES_BASE + ((v_0.(poffset)))))))
          ) with
          | (Some (return___529, __break__, v_38, v_40, v_11, v_39, v_indvars_iv_1, st_417)) =>
            if return___529
            then (
              rely ((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >=? (0)));
              if (((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
              then (
                rely (((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MAX_ERR)) >=? (0)) = (false)));
                rely (((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM1_VIRT)) >=? (0)) = (false)));
                rely (((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) >=? (0)) = (false)));
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                when ret_0 == ((granule_addr_spec' (mkPtr "granules" ((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                when ret_1 == ((buffer_map_spec' 6 ret_0 false));
                rely ((((ret_1.(pbase)) = ("granule_data")) /\ ((((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                when ret_2 == ((granule_addr_spec' ret));
                when ret_3 == ((buffer_map_spec' 1 ret_2 false));
                if (
                  (((((((st_417.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096))) &
                    (63)) =?
                    (0)))
                then (
                  when ret_4 == (
                      (s2tte_get_ripas_spec'
                        (((((st_417.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)))));
                  when ret_5 == ((s2tte_create_ripas_spec' ret_4));
                  match (
                    match ((s2tt_init_unassigned_loop759_0 (z_to_nat 0) false ret_3 ret_5 0 st_417)) with
                    | (Some (__break___0, v_8, v_7, v_index_0, st_1)) => (Some (true, 0, st_1))
                    | None => None
                    end
                  ) with
                  | (Some (__return__, v_bc_resume_val, st_1)) =>
                    if __return__
                    then (
                      (Some (
                        0  ,
                        ((st_1.[share].[globals].[g_granules] :<
                          (((((st_1.(share)).(globals)).(g_granules)) #
                            (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                            ((ret.(poffset)) / (16)) ==
                            ((((((st_1.(share)).(globals)).(g_granules)) #
                              (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              (((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                ((((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_1.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((ret.(poffset)) / (16))).[e_state_s_granule] :<
                              5))).[share].[granule_data] :<
                          (((st_1.(share)).(granule_data)) #
                            (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                            ((((st_1.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                              (((((st_1.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                (v_1 |' (3))))))
                      )))
                    else (
                      match ((s2tt_init_unassigned_loop759 (z_to_nat 0) false ret_3 ret_5 v_bc_resume_val st_1)) with
                      | (Some (__break___0, v_8, v_7, v_indvars_iv_0, st_2)) =>
                        (Some (
                          0  ,
                          ((st_2.[share].[globals].[g_granules] :<
                            (((((st_2.(share)).(globals)).(g_granules)) #
                              (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                              ((ret.(poffset)) / (16)) ==
                              ((((((st_2.(share)).(globals)).(g_granules)) #
                                (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_417.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((ret.(poffset)) / (16))).[e_state_s_granule] :<
                                5))).[share].[granule_data] :<
                            (((st_2.(share)).(granule_data)) #
                              (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_2.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_2.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  (v_1 |' (3))))))
                        ))
                      | None => None
                      end)
                  | None => None
                  end)
                else (
                  if (
                    (((v_3 + ((- 1))) <? (3)) &&
                      ((((((((st_417.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096))) &
                        (3)) =?
                        (3)))))
                  then (Some (9, st_417))
                  else (
                    (Some (
                      0  ,
                      ((st_417.[share].[globals].[g_granules] :<
                        ((((st_417.(share)).(globals)).(g_granules)) #
                          ((ret.(poffset)) / (16)) ==
                          (((((st_417.(share)).(globals)).(g_granules)) @ ((ret.(poffset)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                        (((st_417.(share)).(granule_data)) #
                          (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                          ((((st_417.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                            (((((st_417.(share)).(granule_data)) @ (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                              (((ret_1.(poffset)) + ((8 * ((((st_417.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                              (v_1 |' (3))))))
                    )))))
              else (
                if (v_4 =? (0))
                then (
                  (Some (
                    ((((((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    st_417
                  )))
                else (
                  if (((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_3)) =? (0))
                  then (Some (5299989959177, st_417))
                  else (
                    (Some (
                      ((((((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                        ((((((st_417.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                      st_417
                    ))))))
            else (
              rely ((((0 - (v_3)) <= (0)) /\ ((v_3 < (4)))));
              rely ((((((st_417.(stack)).(stack_type_5)) @ v_3) - (GRANULES_BASE)) >=? (0)));
              if (v_4 =? (0))
              then (
                (Some (
                  (((((v_3 << (32)) + (8)) >> (24)) & (4294967040)) |' (((v_3 << (32)) + (8))))  ,
                  (st_417.[stack].[stack_s_rtt_walk] :<
                    (((((st_417.(stack)).(stack_s_rtt_walk)).[e_g_llt] :< (((st_417.(stack)).(stack_type_5)) @ v_3)).[e_index_s_rtt_walk] :<
                      ((v_2 >> (((39 + (((- 9) * (v_3)))) & (4294967295)))) & (511))).[e_last_level] :<
                      v_3))
                )))
              else (
                (Some (
                  5299989959177  ,
                  (st_417.[stack].[stack_s_rtt_walk] :<
                    (((((st_417.(stack)).(stack_s_rtt_walk)).[e_g_llt] :< (((st_417.(stack)).(stack_type_5)) @ v_3)).[e_index_s_rtt_walk] :<
                      ((v_2 >> (((39 + (((- 9) * (v_3)))) & (4294967295)))) & (511))).[e_last_level] :<
                      v_3))
                ))))
          | None => None
          end)
        else (
          rely ((((0 - (v_3)) <= (0)) /\ ((v_3 < (4)))));
          if (v_4 =? (0))
          then (
            (Some (
              (((((v_3 << (32)) + (8)) >> (24)) & (4294967040)) |' (((v_3 << (32)) + (8))))  ,
              ((st_415.[stack].[stack_s_rtt_walk] :<
                (((((st_415.(stack)).(stack_s_rtt_walk)).[e_g_llt] :< (GRANULES_BASE + ((v_0.(poffset))))).[e_index_s_rtt_walk] :<
                  ((v_2 >> (((39 + (((- 9) * (v_3)))) & (4294967295)))) & (511))).[e_last_level] :<
                  v_3)).[stack].[stack_type_5] :<
                (((st_415.(stack)).(stack_type_5)) # 0 == (GRANULES_BASE + ((v_0.(poffset))))))
            )))
          else (
            (Some (
              5299989959177  ,
              ((st_415.[stack].[stack_s_rtt_walk] :<
                (((((st_415.(stack)).(stack_s_rtt_walk)).[e_g_llt] :< (GRANULES_BASE + ((v_0.(poffset))))).[e_index_s_rtt_walk] :<
                  ((v_2 >> (((39 + (((- 9) * (v_3)))) & (4294967295)))) & (511))).[e_last_level] :<
                  v_3)).[stack].[stack_type_5] :<
                (((st_415.(stack)).(stack_type_5)) # 0 == (GRANULES_BASE + ((v_0.(poffset))))))
            )))))).
  *)
End Layer7.  


Section Layer8.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    "max_pa_size" ::
    "addr_is_level_aligned" ::
    "s1addr_is_level_aligned" ::
    "realm_ipa_size" ::
    "range_intersects_par" ::
    "emulate_sysreg_access_ns" ::
    "esr_is_write" ::
    "access_len" ::
    "fixup_aarch32_data_abort" ::
    "get_dabt_write_value" ::
    (* "handle_rsi_realm_get_attest_token" :: *) (* TODO: support IInsert *)
    "emulate_stage2_data_abort" ::
    "psci_rsi" ::
    "handle_rsi_realm_extend_measurement" ::
    "rsi_memory_dispose" ::
    "write_lr" ::
    "write_ap1r" ::
    "write_ap0r" ::
    "masked_assign" ::
    (* it will only be called with pointer "s1tt[wi.index]" *)
    "set_tte_ns" ::
    "set_pas_ns" ::
    "granule_memzero" ::
    "clear_tte_ns" ::
    "set_pas_realm" ::
    (* "ns_buffer_read_byte" :: *) (* ! moved to bottom *)
    "min" :: (* low spec only *)
    "next_granule" ::
    "rc_update_ttbr0_el12" ::
    "virt_to_phys" ::
    "map_unmap_ns_s1" ::
    (* "ns_buffer_write_byte" :: *) (* ! moved to bottom *)
    "data_create_s1_el1" ::
    "s1tte_is_writable" ::
    (* "g_mapped_addr" :: *)
    "granule_memzero_mapped"::
    "rtt_create_s1_el1"::
    "update_ripas" ::
    nil.
  
  Hint InitRely realm_ipa_size (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely realm_ipa_size ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).

  Definition realm_ipa_size_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when ret, st' == ((realm_ipa_bits_spec v_0 st));
    if (ret =? (64))
    then (Some ((1 << 64), st)) (* no overflow in Coq *)
    else (Some ((1 << (ret)), st)).
  
  Hint InitRely data_create_s1_el1 (v_3.(pbase) = "granules" /\ ((v_3.(poffset)) mod 16 = 0) /\ v_3.(poffset) >= 0).
  Definition data_create_s1_el1_0_low (st_0: RData) (st_7: RData) (v_25: Z) : (option (Z * RData)) :=
    rely (((v_25 =? (0)) = (true)));
    when v_29_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_7));
    when st_10 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_9));
    when v_30_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_10));
    when st_12 == ((granule_unlock_transition_spec (int_to_ptr v_30_tmp) 4 st_11));
    when st_15 == ((free_stack "data_create_s1_el1" st_0 st_12));
    (Some (((v_25 << (32)) >> (32)), st_15)).
  
  Hint NoTrans find_lock_two_granules_spec.
  Hint NoUnfold find_lock_two_granules_spec.
  Definition data_create_s1_el1_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (Z * RData)) :=
  when st_0 == ((new_frame "data_create_s1_el1" st));
  rely (((((v_3.(pbase)) = ("granules")) /\ ((((v_3.(poffset)) mod (16)) = (0)))) /\ (((v_3.(poffset)) >= (0)))));
  when v_7, st_1 == ((s1tte_pa_spec v_0 st_0));
  when v_8, st_2 == ((find_lock_two_granules_spec v_7 1 (mkPtr "stack_type_4" 0) v_1 3 (mkPtr "stack_type_4__1" 0) st_1));
  if (v_8 =? (3))
  then (
    when v_11, st_3 == ((pack_return_code_spec 3 0 st_2));
    when st_5 == ((free_stack "data_create_s1_el1" st_0 st_3));
    (Some (v_11, st_5)))
  else (
    if (v_8 =? (0))
    then (
      when v_19_tmp, st_3 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_2));
      when v_20, st_4 == ((granule_map_spec (int_to_ptr v_19_tmp) 3 st_3));
      rely (v_20.(pbase) = "granule_data" /\ (v_20.(poffset) >= 0) /\ ((v_20.(poffset) mod 4096) = 0));
      rely ((st_4.(share).(granule_data) @ (v_20.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC);
      when v_24_tmp, st_5 == ((load_RData 8 (ptr_offset v_20 1544) st_4));
      when st_6 == ((granule_lock_spec (int_to_ptr v_24_tmp) 5 st_5));
      when v_25, st_7 == ((data_create_internal_spec v_0 (int_to_ptr v_24_tmp) v_2 v_3 v_20 1 st_6));
      if (v_25 =? (0))
      then (data_create_s1_el1_0_low st_0 st_7 v_25)
      else (
        when v_29_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_7));
        when st_10 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_9));
        when v_30_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_10));
        when st_12 == ((granule_unlock_transition_spec (int_to_ptr v_30_tmp) 1 st_11));
        when st_15 == ((free_stack "data_create_s1_el1" st_0 st_12));
        (Some (((v_25 << (32)) >> (32)), st_15))))
    else (
      when v_16, st_3 == ((pack_return_code_spec 1 ((v_8 >> (32)) + (1)) st_2));
      when st_6 == ((free_stack "data_create_s1_el1" st_0 st_3));
      (Some (v_16, st_6)))).
  
  Hint InitRely range_intersects_par (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely range_intersects_par ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  Hint InitRely emulate_sysreg_access_ns (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely emulate_sysreg_access_ns ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely emulate_sysreg_access_ns (v_1.(pbase) = "stack_s_rec_exit" /\ (v_1.(poffset) = 0 )).

  Hint InitRely fixup_aarch32_data_abort (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely fixup_aarch32_data_abort ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely fixup_aarch32_data_abort (v_1.(pbase) = "stack_type_3" /\ (v_1.(poffset) = 0)).

  Hint InitRely get_dabt_write_value (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely get_dabt_write_value ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  Hint InitRely emulate_stage2_data_abort (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely emulate_stage2_data_abort ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely emulate_stage2_data_abort (v_1.(pbase) = "stack_s_rec_exit" /\ (v_1.(poffset) = 0)).

  Hint InitRely psci_rsi (v_0.(pbase) = "stack_s_psci_result" /\ v_0.(poffset) = 0).
  Hint InitRely psci_rsi (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely psci_rsi ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  Hint InitRely handle_rsi_realm_extend_measurement (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely handle_rsi_realm_extend_measurement ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  (* Hint InitRely rsi_memory_dispose (v_0.(pbase) = "stack_s_psci_result" /\ v_0.(poffset) = 0). *)
  Hint InitRely rsi_memory_dispose (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely rsi_memory_dispose ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely rsi_memory_dispose (v_1.(pbase) = "stack_s_rec_exit" /\ (v_1.(poffset) = 0)).

  (* Now we handle the page table entries just like normal data *)
  Hint InitRely masked_assign (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0)).
  Hint InitRely masked_assign ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_DATA).

  Hint InitRely update_ripas (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0)).
  Hint InitRely update_ripas ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_DATA).

  Parameter set_tte_ns_abs : Z -> (RData -> (option RData)).
  Definition set_tte_ns_spec (v_0: Z) (st: RData) : (option RData) := Some st.

  Hint InitRely set_tte_ns ((v_0 >= MEM1_PHYS /\ v_0 < MEM1_PHYS + MEM1_SIZE) \/ (v_0 >= MEM0_PHYS /\ v_0 < MEM0_SIZE)).
  Hint InitRely granule_memzero (v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0).

  Hint InitRely virt_to_phys (v_2.(pbase) = "stack_type_3").

  Hint InitRely g_mapped_addr (v_0.(pbase) = "granules" /\ v_0.(poffset) = 0).

  Hint InitRely rtt_create_s1_el1 (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0 /\ (v_0.(poffset) mod 4096) = 0).
  Hint InitRely rtt_create_s1_el1 ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  (* Hint NoTrans map_unmap_ns_s1_spec. *)

  (* cache psci_rsi, 20 min *)
  (*
  Definition psci_rsi_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    if (
      (((((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521)))) || ((v_2 =? (2214592522)))) ||
        (((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))))) ||
        (((v_2 =? (2214592515)) || ((v_2 =? (3288334339)))))))
    then (
      if (
        ((((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521)))) || ((v_2 =? (2214592522)))) ||
          (((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))))))
      then (
        if (((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521)))) || ((v_2 =? (2214592522))))
        then (
          if ((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521))))
          then (
            if (((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520))))
            then (
              if ((v_2 =? (2214592512)) || ((v_2 =? (2214592514))))
              then (
                if (v_2 =? (2214592512))
                then (
                  (Some (st.[stack].[stack_s_psci_result] :<
                    ((((st.(stack)).(stack_s_psci_result)).[e_hvc_forward] :< ((((st.(stack)).(stack_s_psci_result)).(e_hvc_forward)).[e_s_anon_5_0] :< 0)).[e_smc_result_s_psci_result] :<
                      ((((st.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< (- 1))))))
                else (
                  when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
                  rely ((((st_1.(share)).(granule_data)) =? (((st.(share)).(granule_data)))));
                  (Some (st_1.[stack].[stack_s_psci_result] :<
                    (((st_1.(stack)).(stack_s_psci_result)).[e_smc_result_s_psci_result] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< 65537))))))
              else (
                when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
                rely ((((st_1.(share)).(granule_data)) =? (((st.(share)).(granule_data)))));
                (Some ((st_1.[share].[granule_data] :<
                  (((st_1.(share)).(granule_data)) #
                    ((v_1.(poffset)) / (4096)) ==
                    ((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).[g_norm] :<
                      (((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_norm)) # (((v_1.(poffset)) + (16)) mod (4096)) == 0)))).[stack].[stack_s_psci_result] :<
                  ((((st_1.(stack)).(stack_s_psci_result)).[e_hvc_forward] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_hvc_forward)).[e_s_anon_5_0] :< 1)).[e_smc_result_s_psci_result] :<
                    ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< 0))))))
            else (
              when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
              rely ((((st_1.(share)).(granule_data)) =? (((st.(share)).(granule_data)))));
              rely (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)) >=? (0)));
              rely (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (MEM0_VIRT)) <? (0)));
              when ret, st' == (
                  (granule_try_lock_spec'
                    (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)))
                    2
                    st_1));
              rely (
                ((((("granules" = ("granules")) /\ (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) mod (16)) = (0)))) /\
                  (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)) >= (0)))) /\
                  ((2 >= (0)))) /\
                  ((2 <= (24)))));
              when ret_0 == (
                  (granule_addr_spec'
                    (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)))));
              when ret_1 == ((buffer_map_spec' 2 ret_0 false));
              rely (((((((st_1.(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
              rely (((ret_1.(pbase)) = ("granule_data")));
              (Some ((st_1.[share].[granule_data] :<
                (((st_1.(share)).(granule_data)) #
                  ((ret_1.(poffset)) / (4096)) ==
                  ((((st_1.(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).[g_norm] :<
                    (((((st_1.(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).(g_norm)) # ((ret_1.(poffset)) mod (4096)) == 2)))).[stack].[stack_s_psci_result] :<
                (((st_1.(stack)).(stack_s_psci_result)).[e_hvc_forward] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_hvc_forward)).[e_s_anon_5_0] :< 1))))))
          else (
            rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
            rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
            rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
            when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
            rely ((((st_1.(share)).(granule_data)) =? (((st.(share)).(granule_data)))));
            rely (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)) >=? (0)));
            rely (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (MEM0_VIRT)) <? (0)));
            when ret, st' == (
                (granule_try_lock_spec'
                  (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)))
                  2
                  st_1));
            rely (
              ((((("granules" = ("granules")) /\ (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) mod (16)) = (0)))) /\
                (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)) >= (0)))) /\
                ((2 >= (0)))) /\
                ((2 <= (24)))));
            when ret_0 == (
                (granule_addr_spec'
                  (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)))));
            when ret_1 == ((buffer_map_spec' 2 ret_0 false));
            rely (((((((st_1.(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
            rely (((ret_1.(pbase)) = ("granule_data")));
            (Some ((st_1.[share].[granule_data] :<
              (((st_1.(share)).(granule_data)) #
                ((ret_1.(poffset)) / (4096)) ==
                ((((st_1.(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).[g_norm] :<
                  (((((st_1.(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).(g_norm)) # ((ret_1.(poffset)) mod (4096)) == 2)))).[stack].[stack_s_psci_result] :<
              (((st_1.(stack)).(stack_s_psci_result)).[e_hvc_forward] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_hvc_forward)).[e_s_anon_5_0] :< 1))))))
        else (
          when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
          rely ((((st_1.(share)).(granule_data)) =? (((st.(share)).(granule_data)))));
          if (
            ((((((((((v_3 =? (2214592513)) || ((v_3 =? (3288334337)))) || ((v_3 =? (2214592514)))) || ((v_3 =? (2214592515)))) || ((v_3 =? (3288334339)))) || ((v_3 =? (2214592516)))) ||
              ((v_3 =? (3288334340)))) ||
              ((v_3 =? (2214592520)))) ||
              ((v_3 =? (2214592521)))) ||
              ((v_3 =? (2214592522)))))
          then (
            (Some (st_1.[stack].[stack_s_psci_result] :<
              (((st_1.(stack)).(stack_s_psci_result)).[e_smc_result_s_psci_result] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< 0)))))
          else (
            (Some (st_1.[stack].[stack_s_psci_result] :<
              (((st_1.(stack)).(stack_s_psci_result)).[e_smc_result_s_psci_result] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< (- 1))))))))
      else (
        when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
        rely ((((st_1.(share)).(granule_data)) =? (((st.(share)).(granule_data)))));
        (Some (st_1.[stack].[stack_s_psci_result] :<
          ((((st_1.(stack)).(stack_s_psci_result)).[e_hvc_forward] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_hvc_forward)).[e_s_anon_5_0] :< 1)).[e_smc_result_s_psci_result] :<
            ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< 0))))))
    else (
      if ((v_2 =? (2214592516)) || ((v_2 =? (3288334340))))
      then (
        when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
        rely ((((st_1.(share)).(granule_data)) =? (((st.(share)).(granule_data)))));
        if ((v_4 & (4294967295)) =? (0))
        then (
          rely (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)) >=? (0)));
          rely (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (MEM0_VIRT)) <? (0)));
          rely (
            ((("granules" = ("granules")) /\ (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) mod (16)) = (0)))) /\
              (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)) >= (0)))));
          when ret == (
              (granule_addr_spec'
                (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          when ret_1, st' == ((get_rd_rec_count_unlocked_spec' ret_0 st_1));
          if (
            ((ret_1 -
              (((((((v_3 & (4294967295)) >> (4)) & (4080)) |' (((v_3 & (4294967295)) & (15)))) |' ((((v_3 & (4294967295)) >> (4)) & (1044480)))) |'
                ((((v_3 & (4294967295)) >> (12)) & (267386880)))))) >?
              (0)))
          then (
            if ((((v_1.(poffset)) + (8)) mod (4096)) =? (8))
            then (
              if (
                (((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_rec_idx)) -
                  (((((((v_3 & (4294967295)) >> (4)) & (4080)) |' (((v_3 & (4294967295)) & (15)))) |' ((((v_3 & (4294967295)) >> (4)) & (1044480)))) |'
                    ((((v_3 & (4294967295)) >> (12)) & (267386880)))))) =?
                  (0)))
              then (
                (Some (st_1.[stack].[stack_s_psci_result] :<
                  (((st_1.(stack)).(stack_s_psci_result)).[e_smc_result_s_psci_result] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< 0)))))
              else (
                (Some ((st_1.[share].[granule_data] :<
                  (((st_1.(share)).(granule_data)) #
                    ((v_1.(poffset)) / (4096)) ==
                    ((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).[g_norm] :<
                      (((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_norm)) # (((v_1.(poffset)) + (1512)) mod (4096)) == 1)))).[stack].[stack_s_psci_result] :<
                  (((st_1.(stack)).(stack_s_psci_result)).[e_hvc_forward] :<
                    (((((st_1.(stack)).(stack_s_psci_result)).(e_hvc_forward)).[e_s_anon_5_0] :< 1).[e_s_anon_5_1] :< (v_3 & (4294967295))))))))
            else None)
          else (
            (Some (st_1.[stack].[stack_s_psci_result] :<
              (((st_1.(stack)).(stack_s_psci_result)).[e_smc_result_s_psci_result] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< (- 2)))))))
        else (
          (Some (st_1.[stack].[stack_s_psci_result] :<
            (((st_1.(stack)).(stack_s_psci_result)).[e_smc_result_s_psci_result] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< (- 2)))))))
      else (
        when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
        rely ((((st_1.(share)).(granule_data)) =? (((st.(share)).(granule_data)))));
        if (v_4 =? (0))
        then (
          rely (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)) >=? (0)));
          rely (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (MEM0_VIRT)) <? (0)));
          rely (
            ((("granules" = ("granules")) /\ (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) mod (16)) = (0)))) /\
              (((((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)) >= (0)))));
          when ret == (
              (granule_addr_spec'
                (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          when ret_1, st' == ((get_rd_rec_count_unlocked_spec' ret_0 st_1));
          if ((ret_1 - ((((((v_3 >> (4)) & (4080)) |' ((v_3 & (15)))) |' (((v_3 >> (4)) & (1044480)))) |' (((v_3 >> (12)) & (267386880)))))) >? (0))
          then (
            if ((((v_1.(poffset)) + (8)) mod (4096)) =? (8))
            then (
              if (
                (((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_rec)).(e_rec_idx)) -
                  ((((((v_3 >> (4)) & (4080)) |' ((v_3 & (15)))) |' (((v_3 >> (4)) & (1044480)))) |' (((v_3 >> (12)) & (267386880)))))) =?
                  (0)))
              then (
                (Some (st_1.[stack].[stack_s_psci_result] :<
                  (((st_1.(stack)).(stack_s_psci_result)).[e_smc_result_s_psci_result] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< 0)))))
              else (
                (Some ((st_1.[share].[granule_data] :<
                  (((st_1.(share)).(granule_data)) #
                    ((v_1.(poffset)) / (4096)) ==
                    ((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).[g_norm] :<
                      (((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_norm)) # (((v_1.(poffset)) + (1512)) mod (4096)) == 1)))).[stack].[stack_s_psci_result] :<
                  (((st_1.(stack)).(stack_s_psci_result)).[e_hvc_forward] :<
                    (((((st_1.(stack)).(stack_s_psci_result)).(e_hvc_forward)).[e_s_anon_5_0] :< 1).[e_s_anon_5_1] :< v_3))))))
            else None)
          else (
            (Some (st_1.[stack].[stack_s_psci_result] :<
              (((st_1.(stack)).(stack_s_psci_result)).[e_smc_result_s_psci_result] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< (- 2)))))))
        else (
          (Some (st_1.[stack].[stack_s_psci_result] :<
            (((st_1.(stack)).(stack_s_psci_result)).[e_smc_result_s_psci_result] :< ((((st_1.(stack)).(stack_s_psci_result)).(e_smc_result_s_psci_result)).[e_x0] :< (- 2)))))))).
  *)
End Layer8.

Section Layer9.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    (* timeout around 1 hour *) 
    "rsi_rtt_set_ripas" :: (* low spec only *)
    "rsi_rtt_unmap_non_secure" :: (* low spec only *)
    "rsi_rtt_create" ::(* low spec only *)
    "rsi_data_destroy" ::
    "rsi_rtt_destroy" ::
    "rsi_data_map_extra" :: (* low spec only *)
    "rsi_data_create_s1" :: (* low spec only *)
    "rsi_data_create_unknown_s1" :: (* low spec only *)
    "rsi_data_read" :: (* low spec only *)
    "rsi_rtt_map_non_secure" ::
    "rsi_data_write" :: (* low spec only *)
    "rsi_set_ttbr0" ::
    "rsi_data_make_root_rtt" ::
    "rsi_expected_result" ::
    "smc_granule_delegate" ::
    "smc_granule_undelegate" ::
    "rsi_data_set_attrs" :: (* low spec only *)
    "timer_condition_met" ::
    "timer_is_masked" ::
    "read_ap0r" ::
    "read_ap1r" ::
    "read_lr" ::
    "gic_restore_state" ::
    (* "save_fpu_state" :: pure assmebly *)
    (* "restore_fpu_state" :: *) (* pure assembly *)
    (* ? handler *) (* "handle_realm_rsi" :: *)  
    (* ? handler *) (* "handle_data_abort" :: *)
    (* ? handler *) (* "handle_sysreg_access_trap" :: *)
    (* ? handler *) (* "handle_instruction_abort" :: *)
    (* "mbedtls_platform_set_calloc_free" :: *)
    "feat_vmid16" ::
    "validate_map_addr" ::
    "rmm_feature_register_0_value" ::
    nil.
    (* succeed one *)
    (* Definition rsi_rtt_destroy_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
        when ret_rtt, st_2 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 0 64 v_2 (v_3 + ((- 1))) st_1));
        rely (((((((st_2.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
        if (((ret_rtt.(e_1)) - ((v_3 + ((- 1))))) =? (0))
        then (
          rely ((((ret_rtt.(e_3)) < (512)) /\ (((ret_rtt.(e_3)) >= (0)))));
          if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_desc_type)) =? (3))))
          then (
            if (
              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_PA)).(meta_granule_offset)) -
                (((test_PA v_0).(meta_granule_offset)))) =?
                (0)))
            then (
              when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
              if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
              then (
                rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3) =? (0))
                then (
                  rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  (* constraint note: previously this page is RTT (5) *)
                  (* rely (
                    forall (rtt_gidx : Z) (ipa_gidx : Z),
                    ((rtt_walk_abs st_3 rtt_gidx ipa_gidx) <> (((test_PA v_0).(meta_granule_offset)) / (4096)))
                  ); *)
                  rely (
                    forall (rtt_gidx : Z) (ipa_gidx : Z),
                    ((rtt_walk_abs st_3 rtt_gidx ipa_gidx) = 
                      (rtt_walk_abs ((st_3.[share].[globals].[g_granules] :<
                      ((((st_3.(share)).(globals)).(g_granules)) 
                        # (((test_PA v_0).(meta_granule_offset)) / (4096)) 
                        == (((st_3.(share).(globals).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))) rtt_gidx ipa_gidx)
                      )
                  );
                  when st_24 == (
                      (granule_unlock_spec
                        (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                        (
                          (* (st_3.[share].[globals].[g_granules] :<
                          (((((st_3.(share)).(globals)).(g_granules)) #
                            (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                            (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                              ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) #
                            (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                            ((((((st_3.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                              (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                              1))) *)
                              (* st_3 *)

                          (st_3.[share].[globals].[g_granules] :<
                          ((((st_3.(share)).(globals)).(g_granules)) 
                            # (((test_PA v_0).(meta_granule_offset)) / (4096)) 
                            == (((st_3.(share).(globals).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                              .[share].[granule_data] :<
                          ((((st_3.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))) #
                            (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                            (((((st_3.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                              zero_granule_data))
                              )));
                  when st_28 == ((granule_unlock_spec (ret_rtt.(e_2)) st_24));
                  (Some (0, st_28)))
                else (
                  when st_14 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
                  when st_18 == ((granule_unlock_spec (ret_rtt.(e_2)) st_14));
                  (Some ((pack_struct_return_code_para (make_return_code_para 4)), st_18))))
              else None)
            else None)
          else None)
        else None)
      else None. *)

      
      (* Definition rsi_rtt_destroy_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
        when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st));
        if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
        then (
          rely ((((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
          when ret_rtt, st_2 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 0 64 v_2 (v_3 + ((- 1))) st_1));
          rely (((st_2.(share).(globals).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule) = 5);
          if (((ret_rtt.(e_1)) - ((v_3 + ((- 1))))) =? (0))
          then (
            rely ((((ret_rtt.(e_3)) < (512)) /\ (((ret_rtt.(e_3)) >= (0)))));
            if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_desc_type)) =? (3))))
            then (
              if (
                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_PA)).(meta_granule_offset)) -
                  (((test_PA v_0).(meta_granule_offset)))) =?
                  (0)))
              then (
                when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
                if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
                then (
                  rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                  if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3) =? (0))
                  then (
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    (* mapping constraints over  *)
                    when v_5, st_4 == (
                        (memset_spec
                          (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                          0
                          4096
                          (
                            (st_3.[share].[globals].[g_granules] :<
                            ((((st_3.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                              (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))
                                  .[share].[granule_data] :<
                            (((st_3.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                    rely (
                      forall (rtt_gidx : Z) (ipa_gidx : Z),
                      ((rtt_walk_abs st_4 rtt_gidx ipa_gidx) = 
                        (rtt_walk_abs (st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))) rtt_gidx ipa_gidx)
                        )
                    );
                    when st_24 == (
                        (granule_unlock_spec
                          (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                          (st_4.[share].[globals].[g_granules] :<
                            ((((st_4.(share)).(globals)).(g_granules)) #
                              (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                              (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))));
                    when st_28 == ((granule_unlock_spec (ret_rtt.(e_2)) st_24));
                    (Some (0, st_28)))
                  else (
                    when st_14 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
                    when st_18 == ((granule_unlock_spec (ret_rtt.(e_2)) st_14));
                    (Some ((pack_struct_return_code_para (make_return_code_para 4)), st_18))))
                else None)
              else (
                None))
            else (
              None))
          else (
            None))
        else (
          None). *)

  (* lensified abstract version *)
  (* Definition rsi_rtt_destroy_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
  when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st));
  if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
  then (
    rely ((((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
    when ret_rtt, st_2 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 0 64 v_2 (v_3 + ((- 1))) st_1));
    rely (((((((st_2.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
    if (((ret_rtt.(e_1)) - ((v_3 + ((- 1))))) =? (0))
    then (
      rely ((((ret_rtt.(e_3)) < (512)) /\ (((ret_rtt.(e_3)) >= (0)))));
      if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_desc_type)) =? (3))))
      then (
        if (
          (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_PA)).(meta_granule_offset)) -
            (((test_PA v_0).(meta_granule_offset)))) =?
            (0)))
        then (
          when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
          if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
          then (
            rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
            if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3) =? (0))
            then (
              rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
              (* add constraints here *)
              (* rely () *)
              when v_5, st_4 == (
                  (memset_spec
                    (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                    0
                    4096
                    (st_3.[share].[granule_data] :<
                      (((st_3.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
              rely (
                (forall (rtt_gidx: Z) (ipa_gidx: Z), ((rtt_walk_abs st_4 rtt_gidx ipa_gidx) =
                  ((rtt_walk_abs
                    (st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                    rtt_gidx
                    ipa_gidx)))));
              when st_24 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))));
              when st_28 == ((granule_unlock_spec (ret_rtt.(e_2)) st_24));
              (Some (0, st_28)))
            else (
              when st_14 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
              when st_18 == ((granule_unlock_spec (ret_rtt.(e_2)) st_14));
              (Some ((pack_struct_return_code_para (make_return_code_para 4)), st_18))))
          else None)
        else None)
      else None)
    else None)
  else None. *)
Parameter rtt_map_data_inv : RData -> (bool).
  (* lensified unfolded version trans from the upper one. Try proving this version *)
  (* Notation: run in low spec, proof timeout: 15000 *)
  Definition rsi_rtt_destroy_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st1 == ((query_oracle st));
    rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
    match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_lock)).(e_val))) with
    | None =>
      if (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
        when ret_rtt, st_2 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 0 64 v_2 (v_3 + ((- 1))) st1));
        rely (((((((st_2.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
        if (((ret_rtt.(e_1)) - ((v_3 + ((- 1))))) =? (0))
        then (
          rely ((((ret_rtt.(e_3)) < (512)) /\ (((ret_rtt.(e_3)) >= (0)))));
          if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_desc_type)) =? (3))))
          then (
            if (
              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_PA)).(meta_granule_offset)) -
                (((test_PA v_0).(meta_granule_offset)))) =?
                (0)))
            then (
              when st1_0 == ((query_oracle st_2));
              rely (((((st1_0.(share)).(globals)).(g_granules)) = ((((st_2.(share)).(globals)).(g_granules)))));
              match (((((((st1_0.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_lock)).(e_val))) with
              | None =>
                if (((((((st1_0.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
                then (
                  rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                  if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st1_0) =? (0))
                  then (
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    when v_5, st_4 == (
                        (memset_spec
                          (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                          0
                          4096
                          (st1_0.[share].[granule_data] :<
                            (((st1_0.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                    (* Lemma: set_granule will not change abs *)
                    rely (
                      (forall (rtt_gidx: Z) (ipa_gidx: Z), (((rtt_walk_abs st_4 rtt_gidx ipa_gidx) -
                        ((rtt_walk_abs
                          (st_4.[share].[globals].[g_granules] :<
                            ((((st_4.(share)).(globals)).(g_granules)) #
                              (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                              (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                          rtt_gidx
                          ipa_gidx))) =
                        (0))));
                    (Some (
                      0  ,
                      (st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                    )))
                  else (Some ((pack_struct_return_code_para (make_return_code_para 4)), st1_0)))
                else None
              | (Some cid) => None
              end)
            else None)
          else None)
        else None)
      else None
    | (Some cid) => None
    end.

  Parameter set_pas_realm_spec_para: (Z -> (RData -> (Z))).
  Definition smc_granule_delegate_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if ((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) =? (0))
    then (
      rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      if ((set_pas_realm_spec_para ((test_PA v_0).(meta_granule_offset)) st_1) =? (0))
      then (
        when st_3_1 == (
            (clear_tte_ns_spec
              v_0
              (st_1.[share] :<
                (((st_1.(share)).[globals].[g_granules] :<
                  ((((st_1.(share)).(globals)).(g_granules)) #
                    ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096)) ==
                    (((((st_1.(share)).(globals)).(g_granules)) @ ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 1))).[gpt] :<
                  (((st_1.(share)).(gpt)) # (((test_PA v_0).(meta_granule_offset)) / (4096)) == true)))));
        when v_4, st_2 == ((memset_spec (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) 0 4096 st_3_1));
        when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
        (Some (0, st_6)))
      else (
        when st_5 == (
            (granule_unlock_spec
              (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
              (st_1.[share] :< ((st_1.(share)).[gpt] :< (((st_1.(share)).(gpt)) # (((test_PA v_0).(meta_granule_offset)) / (4096)) == true)))));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).


  Definition smc_granule_undelegate_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
    then (
      rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      when st_3 == (
          (set_tte_ns_abs
            v_0
            (st_1.[share] :<
              (((st_1.(share)).[globals].[g_granules] :<
                ((((st_1.(share)).(globals)).(g_granules)) #
                  ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096)) ==
                  (((((st_1.(share)).(globals)).(g_granules)) @ ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 0))).[gpt] :<
                (((st_1.(share)).(gpt)) # (((test_PA v_0).(meta_granule_offset)) / (4096)) == false)))));
      when st_4 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
      (Some (0, st_4)))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).
(*   
  Definition smc_granule_delegate_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    when st_1 == ((query_oracle st));
    when st1 == ((query_oracle st_1));
    match (((((((st1.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
    | None =>
      rely (
        (((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
          ((((((st1.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
          (0)));
      if ((((((st1.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) =? (0))
      then (
        when v_3, st_2 == (
          (monitor_call_state_oracle
            3288334592
            v_0
            0
            0
            0
            0
            0
            (st1.[share].[globals].[g_granules] :<
              ((((st1.(share)).(globals)).(g_granules)) #
                ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                ((((((st1.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)).[e_state_s_granule] :< 1)))));
        if ((v_0 & (549755813888)) =? (0))
        then (
          when v_8, st_3 == ((get_tte_spec (v_0 + (18446744004990074880)) st1));
          when st2 == Some (st1.[share].[granule_data] :< ((st1.(share).(granule_data)) # ((v_8.(poffset)) / (4096)) == ((st1.(share).(granule_data) @ ((v_8.(poffset)) / (4096))).[g_granule_state] :< 1)));
          rely ((st2.(share).(granule_data) @ (v_8.(poffset) / 4096)).(g_granule_state) = 0);
          when v_9, st_4 == ((__tte_read_spec v_8 st_3));
          rely ((((v_8.(pbase)) = ("granule_data")) /\ (((v_8.(poffset)) >= (0)))));
          if (v_3 =? (0))
          then (
            when st_6 == Some (st2.[share].[granule_data] :<
                    (((st2.(share)).(granule_data)) #
                      ((v_8.(poffset)) / (4096)) ==
                      (((((st2.(share)).(granule_data)) @ ((v_8.(poffset)) / (4096))).[g_norm] :< zero_granule_data))));
            (Some (
              0  ,
              (st_6.[share].[globals].[g_granules] :<
                ((((st_6.(share)).(globals)).(g_granules)) #
                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                  (((((st_6.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)))
            )))
          else (
            (Some (
              4294967553  ,
              ((st2.[share].[globals].[g_granules] :<
                ((((st2.(share)).(globals)).(g_granules)) #
                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                  (((((st2.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))).[share].[granule_data] :<
                (((st2.(share)).(granule_data)) #
                  ((v_8.(poffset)) / (4096)) ==
                  ((((st2.(share)).(granule_data)) @ ((v_8.(poffset)) / (4096))).[g_norm] :<
                    (((((st2.(share)).(granule_data)) @ ((v_8.(poffset)) / (4096))).(g_norm)) # ((v_8.(poffset)) mod (4096)) == (v_9 & ((- 33)))))))
            ))))
        else (
          when v_8, st_3 == ((get_tte_spec (v_0 + (18446743457381744640)) st1));
          when st2 == Some (st1.[share].[granule_data] :< ((st1.(share).(granule_data)) # ((v_8.(poffset)) / (4096)) == ((st1.(share).(granule_data) @ ((v_8.(poffset)) / (4096))).[g_granule_state] :< 1)));
          rely ((st2.(share).(granule_data) @ (v_8.(poffset) / 4096)).(g_granule_state) = 0);
          when v_9, st_4 == ((__tte_read_spec v_8 st_3));
          rely ((((st_4.(share)).(granule_data)) = (((st_3.(share)).(granule_data)))));
          rely ((((v_8.(pbase)) = ("granule_data")) /\ (((v_8.(poffset)) >= (0)))));
          if (v_3 =? (0))
          then (
            when st_6 == Some (st2.[share].[granule_data] :<
                    (((st2.(share)).(granule_data)) #
                      ((v_8.(poffset)) / (4096)) ==
                      (((((st2.(share)).(granule_data)) @ ((v_8.(poffset)) / (4096))).[g_norm] :< zero_granule_data))));
            (Some (
              0  ,
              (st_6.[share].[globals].[g_granules] :<
                ((((st_6.(share)).(globals)).(g_granules)) #
                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                  (((((st_6.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)))
            )))
          else (
            (Some (
              4294967553  ,
              ((st2.[share].[globals].[g_granules] :<
                ((((st2.(share)).(globals)).(g_granules)) #
                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                  (((((st2.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))).[share].[granule_data] :<
                (((st2.(share)).(granule_data)) #
                  ((v_8.(poffset)) / (4096)) ==
                  ((((st2.(share)).(granule_data)) @ ((v_8.(poffset)) / (4096))).[g_norm] :<
                    (((((st2.(share)).(granule_data)) @ ((v_8.(poffset)) / (4096))).(g_norm)) # ((v_8.(poffset)) mod (4096)) == (v_9 & ((- 33)))))))
            )))))
      else (
        (Some (
          4294967553  ,
          (st1.[share].[globals].[g_granules] :<
            ((((st1.(share)).(globals)).(g_granules)) #
              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
              (((((st1.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)))
        )))
    | (Some cid) => None
    end. *)

  (* Definition smc_granule_undelegate_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    if ((v_0 - (MEM1_PHYS)) >=? (0))
    then (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
      | None =>
        if (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (1)) =? (0))
        then (
          when v_3, st_1 == (
              (monitor_call_state_oracle
                3288334593
                v_0
                0
                0
                0
                0
                0
                (st.[share].[globals].[g_granules] :<
                  ((((st.(share)).(globals)).(g_granules)) #
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
          if ((v_0 & (549755813888)) =? (0))
          then (
            when v_8, st_2 == (
                (get_tte_spec
                  (v_0 + (18446744004990074880))
                  (st_1.[share].[globals].[g_granules] :<
                    ((((st_1.(share)).(globals)).(g_granules)) #
                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      (((((st_1.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_state_s_granule] :< 0)))));
            when v_9, st_3 == ((__tte_read_spec v_8 st_2));
            rely ((((st.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
            rely ((((v_8.(pbase)) = ("granule_data")) /\ (((v_8.(poffset)) >= (0)))));
            when cid == (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
            (Some (
              0  ,
              ((st.[share].[globals].[g_granules] :<
                ((((st.(share)).(globals)).(g_granules)) #
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None))).[share].[granule_data] :<
                (((st.(share)).(granule_data)) #
                  ((v_8.(poffset)) / (4096)) ==
                  (((((st.(share)).(granule_data)) @ ((v_8.(poffset)) / (4096))).[g_norm] :<
                    (((((st.(share)).(granule_data)) @ ((v_8.(poffset)) / (4096))).(g_norm)) # ((v_8.(poffset)) mod (4096)) == (v_9 |' (32)))).[g_granule_state] :< 0)
                    ))
            )))
          else (
            when v_8, st_2 == (
                (get_tte_spec
                  (v_0 + (18446743457381744640))
                  (st_1.[share].[globals].[g_granules] :<
                    ((((st_1.(share)).(globals)).(g_granules)) #
                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      (((((st_1.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_state_s_granule] :< 0)))));
            when v_9, st_3 == ((__tte_read_spec v_8 st_2));
            rely ((((st.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
            rely ((((v_8.(pbase)) = ("granule_data")) /\ (((v_8.(poffset)) >= (0)))));
            when cid == (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
            (Some (
              0  ,
              ((st.[share].[globals].[g_granules] :<
                ((((st.(share)).(globals)).(g_granules)) #
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                  (((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None))).[share].[granule_data] :<
                (((st.(share)).(granule_data)) #
                  ((v_8.(poffset)) / (4096)) ==
                  (((((st.(share)).(granule_data)) @ ((v_8.(poffset)) / (4096))).[g_norm] :<
                    (((((st.(share)).(granule_data)) @ ((v_8.(poffset)) / (4096))).(g_norm)) # ((v_8.(poffset)) mod (4096)) == (v_9 |' (32)))).[g_granule_state] :< 0)
                    ))
            ))))
        else (
          (Some (
            4294967553  ,
            (st.[share].[globals].[g_granules] :<
              ((((st.(share)).(globals)).(g_granules)) #
                ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                (((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)))
          )))
      | (Some cid) => None
      end)
    else (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
      | None =>
        if (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (1)) =? (0))
        then None
        else (
          (Some (
            4294967553  ,
            (st.[share].[globals].[g_granules] :<
              ((((st.(share)).(globals)).(g_granules)) #
                ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                (((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)))
          )))
      | (Some cid) => None
      end). *)

  Hint InitRely rsi_data_write (v_0.(pbase) = "stack_s_smc_result" /\ v_0.(poffset) = 0).
  Hint InitRely rsi_data_read (v_0.(pbase) = "stack_s_smc_result__1" /\ v_0.(poffset) = 0).
  
  Hint InitRely rsi_set_ttbr0  (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) mod 4096 = 0) /\ v_0.(poffset) >= 0).
  Hint InitRely rsi_set_ttbr0  ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

  (* Hint InitRely gic_restore_state (v_0.(pbase) = "default_gicstate" /\ v_0.(poffset) = 0). *)
  Hint InitRely gic_restore_state ((v_0.(pbase) = "default_gicstate" /\ v_0.(poffset) = 0) \/ 
                                   (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ (v_0.(poffset) mod 4096) = 584)).
  Hint InitRely gic_restore_state ((v_0.(pbase) = "default_gicstate" /\ v_0.(poffset) = 0) \/
                                   ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC)).

  Definition rsi_rtt_create_spec_low (v_0_Zptr: Z) (v_1_Zptr: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if (check_rcsm_mask_para (test_PA v_1_Zptr))
    then (
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_1_Zptr).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1_Zptr).(meta_granule_offset)) >= (0)))));
        rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
        when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_1));
        if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
        then (
          when ret_record, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) 0 64 v_2 v_3 st_2));
          rely (((st_4.(share).(globals).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule) = 5);
          rely ((((ret_record.(e_2)).(pbase)) = ("granules")));
          rely (((((ret_record.(e_2)).(poffset)) mod (4096)) = (0)));
          rely ((((ret_record.(e_1)) <= (3)) /\ (((ret_record.(e_1)) >= (0)))));
          if (((ret_record.(e_1)) - ((v_3 + ((- 1))))) =? (0))
          then (
            if (
              ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
                ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_ripas)) =? (0)))))
            then (
              when st_10 == (
                  (s2tt_init_unassigned_spec
                    (mkPtr "granule_data" ((test_PA v_0_Zptr).(meta_granule_offset)))
                    ((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_ripas))
                    st_4));
              rely (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
              rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
              rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
              when st_16 == (
                  (granule_unlock_spec
                    (ret_record.(e_2))
                    ((st_10.[share].[globals].[g_granules] :<
                      (((((st_10.(share)).(globals)).(g_granules)) #
                        ((((ret_record.(e_2)).(poffset)) + (8)) / (4096)) ==
                        (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                          ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                        ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                        ((((((st_10.(share)).(globals)).(g_granules)) #
                          ((((ret_record.(e_2)).(poffset)) + (8)) / (4096)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                            ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :<
                          5))).[share].[granule_data] :<
                      (((st_10.(share)).(granule_data)) #
                        ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                        ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
              when st_17 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_16));
              (Some (0, st_17)))
            else (
              if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
              then (
                match (
                  match (
                    when st_11 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
                    when st_12 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_11));
                    (Some (true, (pack_struct_return_code_para (make_return_code_para 9)), st_12))
                  ) with
                  | (Some (return___1, retval___1, st_10)) => (Some (return___1, retval___1, st_10))
                  | _ => None
                  end
                ) with
                | (Some (return___1, retval___1, st_10)) =>
                  if return___1
                  then (Some (retval___1, st_10))
                  else (
                    rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                    when st_14 == (
                        (granule_unlock_spec
                          (ret_record.(e_2))
                          ((st_10.[share].[globals].[g_granules] :<
                            ((((st_10.(share)).(globals)).(g_granules)) #
                              ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                              (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                            (((st_10.(share)).(granule_data)) #
                              ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                              ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                    when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_14));
                    (Some (0, st_15)))
                | None => None
                end)
              else (
                rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                when st_14 == (
                    (granule_unlock_spec
                      (ret_record.(e_2))
                      ((st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                          ((((st_4.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_14));
                (Some (0, st_15)))))
          else (
            when st_6 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
            when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_6));
            (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7))))
        else (
          when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_2));
          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_3))))
      else (
        when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1));
        rely (((0 = (0)) /\ ((0 >= (0)))));
        rely ((("null" = ("granules")) \/ (("null" = ("null")))));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))
    else (
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (3)) =? (0))
      then (
        rely ((((((test_PA v_1_Zptr).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1_Zptr).(meta_granule_offset)) >= (0)))));
        rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
        when st_2 == (
            (spinlock_acquire_spec
              (mkPtr
                ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(pbase))
                ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(poffset)))
              st_1));
        if (
          (((((((st_2.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(poffset)) / (4096))).(e_state_s_granule)) -
            (5)) =?
            (0)))
        then (
          when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_2));
          if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
          then (
            when ret_record, st_4 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "stack_s_rtt_walk" 0)
                  (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1)
                  0
                  64
                  v_2
                  v_3
                  st_3));
            rely (((st_4.(share).(globals).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule) = 5);
            rely ((((ret_record.(e_2)).(pbase)) = ("granules")));
            rely (((((ret_record.(e_2)).(poffset)) mod (4096)) = (0)));
            rely ((((ret_record.(e_1)) <= (3)) /\ (((ret_record.(e_1)) >= (0)))));
            if (((ret_record.(e_1)) - ((v_3 + ((- 1))))) =? (0))
            then (
              if (
                ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_ripas)) =? (0)))))
              then (
                when st_10 == (
                    (s2tt_init_unassigned_spec
                      (mkPtr "granule_data" ((test_PA v_0_Zptr).(meta_granule_offset)))
                      ((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_ripas))
                      st_4));
                rely (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                when st_16 == (
                    (granule_unlock_spec
                      (ret_record.(e_2))
                      ((st_10.[share].[globals].[g_granules] :<
                        (((((st_10.(share)).(globals)).(g_granules)) #
                          ((((ret_record.(e_2)).(poffset)) + (8)) / (4096)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                            ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                          ((((((st_10.(share)).(globals)).(g_granules)) #
                            ((((ret_record.(e_2)).(poffset)) + (8)) / (4096)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :<
                            5))).[share].[granule_data] :<
                        (((st_10.(share)).(granule_data)) #
                          ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                          ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                when st_17 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_16));
                when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_17));
                (Some (0, st_6)))
              else (
                if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
                then (
                  match (
                    match (
                      when st_11 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
                      when st_12 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_11));
                      (Some (true, (pack_struct_return_code_para (make_return_code_para 9)), st_12))
                    ) with
                    | (Some (return___1, retval___1, st_10)) => (Some (return___1, retval___1, st_10))
                    | _ => None
                    end
                  ) with
                  | (Some (return___1, retval___1, st_10)) =>
                    if return___1
                    then (
                      when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_10));
                      (Some (retval___1, st_6)))
                    else (
                      rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                      when st_14 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                              (((st_10.(share)).(granule_data)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                      when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_14));
                      when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_15));
                      (Some (0, st_6)))
                  | None => None
                  end)
                else (
                  rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                  when st_14 == (
                      (granule_unlock_spec
                        (ret_record.(e_2))
                        ((st_4.[share].[globals].[g_granules] :<
                          ((((st_4.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                            (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                          (((st_4.(share)).(granule_data)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                            ((((st_4.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_4.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                  when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_14));
                  when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_15));
                  (Some (0, st_6)))))
            else (
              if (((ret_record.(e_1)) - (v_3)) =? (0))
              then (
                match (
                  match (
                    match (
                      when st_6 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
                      when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_6));
                      (Some (true, (pack_struct_return_code_para (make_return_code_para 9)), st_7))
                    ) with
                    | (Some (__return___0, __retval___0, st_5)) => (Some (__return___0, __retval___0, st_5))
                    | _ => None
                    end
                  ) with
                  | (Some (__return___0, __retval___0, st_5)) =>
                    if __return___0
                    then (Some (true, __retval___0, st_5))
                    else (
                      when st_7 == ((granule_unlock_spec (ret_record.(e_2)) st_5));
                      when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_7));
                      (Some (true, (pack_struct_return_code_para (make_return_code_para 8)), st_8)))
                  | _ => None
                  end
                ) with
                | (Some (__return___0, __retval___0, st_5)) =>
                  if __return___0
                  then (
                    when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_5));
                    (Some (__retval___0, st_7)))
                  else (
                    if (
                      ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_desc_type)) =? (0)) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_ripas)) =? (0)))))
                    then (
                      when st_11 == (
                          (s2tt_init_unassigned_spec
                            (mkPtr "granule_data" ((test_PA v_0_Zptr).(meta_granule_offset)))
                            ((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_ripas))
                            st_5));
                            rely (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                      rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                      when st_17 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_11.[share].[globals].[g_granules] :<
                              (((((st_11.(share)).(globals)).(g_granules)) #
                                ((((ret_record.(e_2)).(poffset)) + (8)) / (4096)) ==
                                (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                                ((((((st_11.(share)).(globals)).(g_granules)) #
                                  ((((ret_record.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :<
                                  5))).[share].[granule_data] :<
                              (((st_11.(share)).(granule_data)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                ((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                      when st_18 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_17));
                      when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_18));
                      (Some (0, st_7)))
                    else (
                      if (((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_desc_type)) =? (3))
                      then (
                        match (
                          match (
                            when st_12 == ((granule_unlock_spec (ret_record.(e_2)) st_5));
                            when st_13 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_12));
                            (Some (true, (pack_struct_return_code_para (make_return_code_para 9)), st_13))
                          ) with
                          | (Some (return___1, retval___1, st_11)) => (Some (return___1, retval___1, st_11))
                          | _ => None
                          end
                        ) with
                        | (Some (return___1, retval___1, st_11)) =>
                          if return___1
                          then (
                            when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_11));
                            (Some (retval___1, st_7)))
                          else (
                            rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                            when st_15 == (
                                (granule_unlock_spec
                                  (ret_record.(e_2))
                                  ((st_11.[share].[globals].[g_granules] :<
                                    ((((st_11.(share)).(globals)).(g_granules)) #
                                      ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                                      (((((st_11.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                                    (((st_11.(share)).(granule_data)) #
                                      ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                      ((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                        (((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                          ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                          (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                            when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_15));
                            when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_16));
                            (Some (0, st_7)))
                        | None => None
                        end)
                      else (
                        rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                        when st_15 == (
                            (granule_unlock_spec
                              (ret_record.(e_2))
                              ((st_5.[share].[globals].[g_granules] :<
                                ((((st_5.(share)).(globals)).(g_granules)) #
                                  ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                                  (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                                (((st_5.(share)).(granule_data)) #
                                  ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                  ((((st_5.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_5.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                        when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_15));
                        when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_16));
                        (Some (0, st_7)))))
                | None => None
                end)
              else (
                when st_7 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
                when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_7));
                when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_8));
                (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_6)))))
          else (
            when st_4 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_3));
            when st_5 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_4));
            (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5))))
        else (
          when st_3 == (
              (spinlock_release_spec
                (mkPtr
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(pbase))
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(poffset)))
                st_2));
          when st_4 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_3));
          if (((((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
          then (
            when ret_record, st_5 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "stack_s_rtt_walk" 0)
                  (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1)
                  0
                  64
                  v_2
                  v_3
                  st_4));
            rely (((st_5.(share).(globals).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule) = 5);
            rely ((((ret_record.(e_2)).(pbase)) = ("granules")));
            rely (((((ret_record.(e_2)).(poffset)) mod (4096)) = (0)));
            rely ((((ret_record.(e_1)) <= (3)) /\ (((ret_record.(e_1)) >= (0)))));
            if (((ret_record.(e_1)) - ((v_3 + ((- 1))))) =? (0))
            then (
              if (
                ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_desc_type)) =? (0)) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_ripas)) =? (0)))))
              then (
                when st_10 == (
                    (s2tt_init_unassigned_spec
                      (mkPtr "granule_data" ((test_PA v_0_Zptr).(meta_granule_offset)))
                      ((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_ripas))
                      st_5));
                rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                when st_16 == (
                    (granule_unlock_spec
                      (ret_record.(e_2))
                      ((st_10.[share].[globals].[g_granules] :<
                        (((((st_10.(share)).(globals)).(g_granules)) #
                          ((((ret_record.(e_2)).(poffset)) + (8)) / (4096)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                            ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                          ((((((st_10.(share)).(globals)).(g_granules)) #
                            ((((ret_record.(e_2)).(poffset)) + (8)) / (4096)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :<
                            5))).[share].[granule_data] :<
                        (((st_10.(share)).(granule_data)) #
                          ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                          ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                when st_17 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_16));
                when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_17));
                (Some (0, st_6)))
              else (
                if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_desc_type)) =? (3))))
                then (
                  match (
                    match (
                      when st_11 == ((granule_unlock_spec (ret_record.(e_2)) st_5));
                      when st_12 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_11));
                      (Some (true, (pack_struct_return_code_para (make_return_code_para 9)), st_12))
                    ) with
                    | (Some (return___1, retval___1, st_10)) => (Some (return___1, retval___1, st_10))
                    | _ => None
                    end
                  ) with
                  | (Some (return___1, retval___1, st_10)) =>
                    if return___1
                    then (
                      when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_10));
                      (Some (retval___1, st_6)))
                    else (
                      rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                      when st_14 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                              (((st_10.(share)).(granule_data)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                      when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_14));
                      when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_15));
                      (Some (0, st_6)))
                  | None => None
                  end)
                else (
                  rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                  when st_14 == (
                      (granule_unlock_spec
                        (ret_record.(e_2))
                        ((st_5.[share].[globals].[g_granules] :<
                          ((((st_5.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                            (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                            ((((st_5.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                  when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_14));
                  when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_15));
                  (Some (0, st_6)))))
            else (
              if (((ret_record.(e_1)) - (v_3)) =? (0))
              then (
                match (
                  match (
                    match (
                      when st_6 == ((granule_unlock_spec (ret_record.(e_2)) st_5));
                      when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_6));
                      (Some (true, (pack_struct_return_code_para (make_return_code_para 9)), st_7))
                    ) with
                    | (Some (__return___0, __retval___0, st_6)) => (Some (__return___0, __retval___0, st_6))
                    | _ => None
                    end
                  ) with
                  | (Some (__return___0, __retval___0, st_6)) =>
                    if __return___0
                    then (Some (true, __retval___0, st_6))
                    else (
                      when st_7 == ((granule_unlock_spec (ret_record.(e_2)) st_6));
                      when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_7));
                      (Some (true, (pack_struct_return_code_para (make_return_code_para 8)), st_8)))
                  | _ => None
                  end
                ) with
                | (Some (__return___0, __retval___0, st_6)) =>
                  if __return___0
                  then (
                    when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_6));
                    (Some (__retval___0, st_7)))
                  else (
                    if (
                      ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_6).(meta_desc_type)) =? (0)) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_6).(meta_ripas)) =? (0)))))
                    then (
                      when st_11 == (
                          (s2tt_init_unassigned_spec
                            (mkPtr "granule_data" ((test_PA v_0_Zptr).(meta_granule_offset)))
                            ((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_6).(meta_ripas))
                            st_6));
                      rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                      when st_17 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_11.[share].[globals].[g_granules] :<
                              (((((st_11.(share)).(globals)).(g_granules)) #
                                ((((ret_record.(e_2)).(poffset)) + (8)) / (4096)) ==
                                (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                                ((((((st_11.(share)).(globals)).(g_granules)) #
                                  ((((ret_record.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :<
                                  5))).[share].[granule_data] :<
                              (((st_11.(share)).(granule_data)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                ((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                      when st_18 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_17));
                      when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_18));
                      (Some (0, st_7)))
                    else (
                      if (((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_6).(meta_desc_type)) =? (3))
                      then (
                        match (
                          match (
                            when st_12 == ((granule_unlock_spec (ret_record.(e_2)) st_6));
                            when st_13 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_12));
                            (Some (true, (pack_struct_return_code_para (make_return_code_para 9)), st_13))
                          ) with
                          | (Some (return___1, retval___1, st_11)) => (Some (return___1, retval___1, st_11))
                          | _ => None
                          end
                        ) with
                        | (Some (return___1, retval___1, st_11)) =>
                          if return___1
                          then (
                            when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_11));
                            (Some (retval___1, st_7)))
                          else (
                            rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                            when st_15 == (
                                (granule_unlock_spec
                                  (ret_record.(e_2))
                                  ((st_11.[share].[globals].[g_granules] :<
                                    ((((st_11.(share)).(globals)).(g_granules)) #
                                      ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                                      (((((st_11.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                                    (((st_11.(share)).(granule_data)) #
                                      ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                      ((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                        (((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                          ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                          (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                            when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_15));
                            when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_16));
                            (Some (0, st_7)))
                        | None => None
                        end)
                      else (
                        rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                        when st_15 == (
                            (granule_unlock_spec
                              (ret_record.(e_2))
                              ((st_6.[share].[globals].[g_granules] :<
                                ((((st_6.(share)).(globals)).(g_granules)) #
                                  ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096)) ==
                                  (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                                (((st_6.(share)).(granule_data)) #
                                  ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                  ((((st_6.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_6.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                        when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_15));
                        when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_16));
                        (Some (0, st_7)))))
                | None => None
                end)
              else (
                when st_7 == ((granule_unlock_spec (ret_record.(e_2)) st_5));
                when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_7));
                when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_8));
                (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_6)))))
          else (
            when st_5 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_4));
            when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_5));
            (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_6)))))
      else (
        when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1));
        rely (((0 = (0)) /\ ((0 >= (0)))));
        rely ((("null" = ("granules")) \/ (("null" = ("null")))));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2)))).

  Hint NoUnfold data_create_internal_spec.

  Definition rsi_data_map_extra_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (4)) =? (0))
    then (
      rely (((((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) >= (0)))));
      when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) 0 64 v_1 3 st_2));
        rely ((((st_4.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
        if ((rtt_ret.(e_1)) =? (3))
        then (
          if (
            (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
              ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
              ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
          then (
            when st_3 == ((spinlock_acquire_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_4));
            if (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset)) / (16))).(e_state_s_granule)) - (2)) =? (0))
            then (
              when v_11, st_5 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_3));
              if v_11
              then (
                when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_5));
                rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                when st_29 == (
                    (granule_unlock_spec
                      (rtt_ret.(e_2))
                      ((st_18.[share].[globals].[g_granules] :<
                        (((((st_18.(share)).(globals)).(g_granules)) #
                          ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                            ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((((st_18.(share)).(globals)).(g_granules)) #
                            ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) #
                              ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                              (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              ((g_mapped_addr_set_para
                                (((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0))
                                v_1) +
                                (1)))))).[share].[granule_data] :<
                        (((st_18.(share)).(granule_data)) #
                          ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                          ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_2).(meta_PA)) 0 0 1))))))));
                when st_6 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_29));
                (Some (0, st_6)))
              else (
                when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) 0 4096 st_5));
                when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                when st_6 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_21));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_6))))
            else (
              when st_5 == ((spinlock_release_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_3));
              when v_11, st_6 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
              if v_11
              then (
                when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_6));
                rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                when st_29 == (
                    (granule_unlock_spec
                      (rtt_ret.(e_2))
                      ((st_18.[share].[globals].[g_granules] :<
                        (((((st_18.(share)).(globals)).(g_granules)) #
                          ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                            ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((((st_18.(share)).(globals)).(g_granules)) #
                            ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) #
                              ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                              (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              ((g_mapped_addr_set_para
                                (((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0))
                                v_1) +
                                (1)))))).[share].[granule_data] :<
                        (((st_18.(share)).(granule_data)) #
                          ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                          ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_2).(meta_PA)) 0 0 1))))))));
                when st_7 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_29));
                (Some (0, st_7)))
              else (
                when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) 0 4096 st_6));
                when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                when st_7 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_21));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7)))))
          else (
            when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
            when st_5 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_13));
            (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_5))))
        else (
          when st_8 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
          when st_5 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_8));
          (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_5))))
      else (
        when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_3))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).
(* 
  Definition rsi_data_map_extra_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (4)) =? (0))
    then (
      rely (((((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) >= (0)))));
      when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) 0 64 v_1 3 st_2));
        rely ((((st_4.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
        if ((rtt_ret.(e_1)) =? (3))
        then (
          if (
            (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
              ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
              ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
          then (
            when st_3 == ((spinlock_acquire_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_4));
            if (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset)) / (16))).(e_state_s_granule)) - (2)) =? (0))
            then (
              when v_11, st_5 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_3));
              if v_11
              then (
                when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_5));
                rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                when st_29 == (
                    (granule_unlock_spec
                      (rtt_ret.(e_2))
                      ((st_18.[share].[globals].[g_granules] :<
                        (((((st_18.(share)).(globals)).(g_granules)) #
                          ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                            ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((((st_18.(share)).(globals)).(g_granules)) #
                            ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) #
                              ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                              (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              ((g_mapped_addr_set_para
                                (((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0))
                                v_1) +
                                (1)))))).[share].[granule_data] :<
                        (((st_18.(share)).(granule_data)) #
                          ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                          ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_2).(meta_PA)) 0 0 1))))))));
                when st_6 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_29));
                (Some (0, st_6)))
              else (
                when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) 0 4096 st_5));
                when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                when st_6 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_21));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_6))))
            else (
              when st_5 == ((spinlock_release_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_3));
              when v_11, st_6 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
              if v_11
              then (
                when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_6));
                rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                when st_29 == (
                    (granule_unlock_spec
                      (rtt_ret.(e_2))
                      ((st_18.[share].[globals].[g_granules] :<
                        (((((st_18.(share)).(globals)).(g_granules)) #
                          ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                            ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((((st_18.(share)).(globals)).(g_granules)) #
                            ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) #
                              ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                              (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              ((g_mapped_addr_set_para
                                (((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0))
                                v_1) +
                                (1)))))).[share].[granule_data] :<
                        (((st_18.(share)).(granule_data)) #
                          ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                          ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_2).(meta_PA)) 0 0 1))))))));
                when st_7 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_29));
                (Some (0, st_7)))
              else (
                when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) 0 4096 st_6));
                when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                when st_7 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_21));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7)))))
          else (
            when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
            when st_5 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_13));
            (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_5))))
        else (
          when st_8 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
          when st_5 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_8));
          (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_5))))
      else (
        when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_3))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))). *)

    Definition map_unmap_ns_s1_spec_low (v_0_Zptr: Z) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
      when st1 == ((query_oracle st));
      rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
      match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
      | None =>
        if (
          ((((((((st1.(share)).(globals)).(g_granules)) #
            (((test_PA v_0_Zptr).(meta_granule_offset)) / (16)) ==
            (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
            (5)) =?
            (0)))
        then (
          when ret_rtt, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) 0 64 v_1 v_2 st1));
          rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
          rely ((((st_4.(share)).(granule_data)) = (((st1.(share)).(granule_data)))));
          if (((ret_rtt.(e_1)) - (v_2)) =? (0))
          then (
            if (v_4 =? (0))
            then (
              if (
                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
              then (
                if (uart0_phys_para (test_Z_PTE v_3))
                then (
                  rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                  rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                  (Some (
                    0  ,
                    (st_4.[share].[granule_data] :<
                      (((st_4.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (test_Z_PTE v_3))))))
                  )))
                else (
                  when st1_0 == ((query_oracle st_4));
                  rely (((((st1_0.(share)).(globals)).(g_granules)) = ((((st_4.(share)).(globals)).(g_granules)))));
                  match (((((((st1_0.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                  | None =>
                    if (
                      (((((((st1_0.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st1_0.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) =?
                        (0)))
                    then (
                      rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      (Some (
                        0  ,
                        (st1_0.[share].[granule_data] :<
                          (((st1_0.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (test_Z_PTE v_3))))))
                      )))
                    else (
                      when st1_1 == ((query_oracle st1_0));
                      rely (
                        ((((st1_1.(share)).(globals)).(g_granules)) =
                          (((((st1_0.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< None)))));
                      match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        if (
                          ((((((((st1_1.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                            (6)) =?
                            (0)))
                        then (
                          rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) = (8)));
                          rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          (Some (
                            0  ,
                            (st1_1.[share].[granule_data] :<
                              (((st1_1.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st1_1.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st1_1.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (test_Z_PTE v_3))))))
                          )))
                        else (
                          if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                          then (
                            rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                            rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                            (Some (
                              0  ,
                              (st1_1.[share].[granule_data] :<
                                (((st1_1.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st1_1.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st1_1.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (test_Z_PTE v_3))))))
                            )))
                          else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1_1)))
                      | (Some cid) => None
                      end)
                  | (Some cid) => None
                  end))
              else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_4)))
            else (
              if (v_4 =? (1))
              then (
                if ((v_2 =? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
                then (
                  if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
                  then (
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                    (Some (
                      0  ,
                      (st_4.[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                    )))
                  else (
                    when st1_0 == ((query_oracle st_4));
                    rely (((((st1_0.(share)).(globals)).(g_granules)) = ((((st_4.(share)).(globals)).(g_granules)))));
                    match (((((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                    | None =>
                      if (
                        ((((((((st1_0.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                          (6)) =?
                          (0)))
                      then (
                        rely (
                          ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        if (
                          ((g_refcount_para
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            st1_0) =?
                            (0)))
                        then (
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          (Some (
                            0  ,
                            (st1_0.[share].[granule_data] :<
                              (((st1_0.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                          )))
                        else (
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          (Some (
                            0  ,
                            (st1_0.[share].[granule_data] :<
                              (((st1_0.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                          ))))
                      else (
                        if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                        then (
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          (Some (
                            0  ,
                            (st1_0.[share].[granule_data] :<
                              (((st1_0.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                          )))
                        else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1_0)))
                    | (Some cid) => None
                    end))
                else (
                  if ((v_2 <>? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (1))))
                  then (
                    if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
                    then (
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      (Some (
                        0  ,
                        (st_4.[share].[granule_data] :<
                          (((st_4.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                      )))
                    else (
                      when st1_0 == ((query_oracle st_4));
                      rely (((((st1_0.(share)).(globals)).(g_granules)) = ((((st_4.(share)).(globals)).(g_granules)))));
                      match (((((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        if (
                          ((((((((st1_0.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                            (6)) =?
                            (0)))
                        then (
                          rely (
                            ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          if (
                            ((g_refcount_para
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                              st1_0) =?
                              (0)))
                          then (
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                            (Some (
                              0  ,
                              (st1_0.[share].[granule_data] :<
                                (((st1_0.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                            )))
                          else (
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                            (Some (
                              0  ,
                              (st1_0.[share].[granule_data] :<
                                (((st1_0.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                            ))))
                        else (
                          if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                          then (
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                            (Some (
                              0  ,
                              (st1_0.[share].[granule_data] :<
                                (((st1_0.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                            )))
                          else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1_0)))
                      | (Some cid) => None
                      end))
                  else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_4))))
              else (Some (0, st_4))))
          else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_4)))
        else (
          when ret_rtt, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) 0 64 v_1 v_2 st1));
          rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
          rely ((((st_4.(share)).(granule_data)) = (((st1.(share)).(granule_data)))));
          if (((ret_rtt.(e_1)) - (v_2)) =? (0))
          then (
            if (v_4 =? (0))
            then (
              if (
                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
              then (
                if (uart0_phys_para (test_Z_PTE v_3))
                then (
                  rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                  rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                  (Some (
                    0  ,
                    (st_4.[share].[granule_data] :<
                      (((st_4.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (test_Z_PTE v_3))))))
                  )))
                else (
                  when st1_0 == ((query_oracle st_4));
                  rely (((((st1_0.(share)).(globals)).(g_granules)) = ((((st_4.(share)).(globals)).(g_granules)))));
                  match (((((((st1_0.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                  | None =>
                    if (
                      (((((((st1_0.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st1_0.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) =?
                        (0)))
                    then (
                      rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      (Some (
                        0  ,
                        (st1_0.[share].[granule_data] :<
                          (((st1_0.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (test_Z_PTE v_3))))))
                      )))
                    else (
                      when st1_1 == ((query_oracle st1_0));
                      rely (
                        ((((st1_1.(share)).(globals)).(g_granules)) =
                          (((((st1_0.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< None)))));
                      match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        if (
                          ((((((((st1_1.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                            (6)) =?
                            (0)))
                        then (
                          rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) = (8)));
                          rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          (Some (
                            0  ,
                            (st1_1.[share].[granule_data] :<
                              (((st1_1.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st1_1.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st1_1.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (test_Z_PTE v_3))))))
                          )))
                        else (
                          if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                          then (
                            rely ((true = (true)));
                            rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                            rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                            (Some (
                              0  ,
                              (st1_1.[share].[granule_data] :<
                                (((st1_1.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st1_1.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st1_1.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (test_Z_PTE v_3))))))
                            )))
                          else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1_1)))
                      | (Some cid) => None
                      end)
                  | (Some cid) => None
                  end))
              else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_4)))
            else (
              if (v_4 =? (1))
              then (
                if ((v_2 =? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
                then (
                  if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
                  then (
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                    (Some (
                      0  ,
                      (st_4.[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                    )))
                  else (
                    when st1_0 == ((query_oracle st_4));
                    rely (((((st1_0.(share)).(globals)).(g_granules)) = ((((st_4.(share)).(globals)).(g_granules)))));
                    match (((((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                    | None =>
                      if (
                        ((((((((st1_0.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                          (6)) =?
                          (0)))
                      then (
                        rely (
                          ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        if (
                          ((g_refcount_para
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            st1_0) =?
                            (0)))
                        then (
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          (Some (
                            0  ,
                            (st1_0.[share].[granule_data] :<
                              (((st1_0.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                          )))
                        else (
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          (Some (
                            0  ,
                            (st1_0.[share].[granule_data] :<
                              (((st1_0.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                          ))))
                      else (
                        if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                        then (
                          rely ((true = (true)));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          (Some (
                            0  ,
                            (st1_0.[share].[granule_data] :<
                              (((st1_0.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                          )))
                        else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1_0)))
                    | (Some cid) => None
                    end))
                else (
                  if ((v_2 <>? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (1))))
                  then (
                    if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
                    then (
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      (Some (
                        0  ,
                        (st_4.[share].[granule_data] :<
                          (((st_4.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                      )))
                    else (
                      when st1_0 == ((query_oracle st_4));
                      rely (((((st1_0.(share)).(globals)).(g_granules)) = ((((st_4.(share)).(globals)).(g_granules)))));
                      match (((((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        if (
                          ((((((((st1_0.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                            (6)) =?
                            (0)))
                        then (
                          rely (
                            ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          if (
                            ((g_refcount_para
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                              st1_0) =?
                              (0)))
                          then (
                            rely ((true = (true)));
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                            rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                            (Some (
                              0  ,
                              (st1_0.[share].[granule_data] :<
                                (((st1_0.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                            )))
                          else (
                            rely ((true = (true)));
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                            rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                            (Some (
                              0  ,
                              (st1_0.[share].[granule_data] :<
                                (((st1_0.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                            ))))
                        else (
                          if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                          then (
                            rely ((true = (true)));
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                            rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                            (Some (
                              0  ,
                              (st1_0.[share].[granule_data] :<
                                (((st1_0.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st1_0.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))
                            )))
                          else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1_0)))
                      | (Some cid) => None
                      end))
                  else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_4))))
              else (Some (0, st_4))))
          else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_4)))
      | (Some cid) => None
      end.
  (* Definition rsi_data_create_unknown_s1_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
  if (check_rcsm_mask_para (test_PA v_1))
  then (
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
    then (
      rely (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
      when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
      if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
        when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 0 64 v_2 3 st_2));
        rely ((((st_4.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
        rely (((((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
        rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
        if ((rtt_ret.(e_1)) =? (3))
        then (
          if (
            (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
              ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
              ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
          then (
            when st_3 == ((spinlock_acquire_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_4));
            rely (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
            rely (((((((st_3.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
            if (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset)) / (4096))).(e_state_s_granule)) - (2)) =? (0))
            then (
              when v_11, st_5 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_3));
              rely (((((st_5.(share)).(globals)).(g_granules)) = ((((st_3.(share)).(globals)).(g_granules)))));
              if v_11
              then (
                rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                (Some (
                  0  ,
                  ((st_5.[share].[globals].[g_granules] :<
                    ((((st_5.(share)).(globals)).(g_granules)) #
                      ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                      (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                    (((st_5.(share)).(granule_data)) #
                      ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                      ((((st_5.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                        (((((st_5.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                          ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                          (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 1))))))
                )))
              else (
                if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                then (
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 1))  ,
                    ((st_5.[share].[globals].[g_granules] :<
                      ((((st_5.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                      (((st_5.(share)).(granule_data)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        ((((st_5.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                  )))
                else (
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 1))  ,
                    ((st_5.[share].[globals].[g_granules] :<
                      ((((st_5.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                      (((st_5.(share)).(granule_data)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        ((((st_5.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                  )))))
            else (
              when st_5 == ((spinlock_release_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_3));
              when v_11, st_6 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
              rely (((((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
              rely (((((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
              rely (((((st_6.(share)).(globals)).(g_granules)) = ((((st_5.(share)).(globals)).(g_granules)))));
              if v_11
              then (
                rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                (Some (
                  0  ,
                  ((st_6.[share].[globals].[g_granules] :<
                    ((((st_6.(share)).(globals)).(g_granules)) #
                      ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                      (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                    (((st_6.(share)).(granule_data)) #
                      ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                      ((((st_6.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                        (((((st_6.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                          ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                          (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 1))))))
                )))
              else (
                if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                then (
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 1))  ,
                    ((st_6.[share].[globals].[g_granules] :<
                      ((((st_6.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                      (((st_6.(share)).(granule_data)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        ((((st_6.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                  )))
                else (
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 1))  ,
                    ((st_6.[share].[globals].[g_granules] :<
                      ((((st_6.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                      (((st_6.(share)).(granule_data)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        ((((st_6.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                  ))))))
          else (
            if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
            then (
              (Some (
                (pack_struct_return_code_para (make_return_code_para 9))  ,
                (st_4.[share].[globals].[g_granules] :<
                  ((((st_4.(share)).(globals)).(g_granules)) #
                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                    (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
              )))
            else (
              (Some (
                (pack_struct_return_code_para (make_return_code_para 9))  ,
                (st_4.[share].[globals].[g_granules] :<
                  ((((st_4.(share)).(globals)).(g_granules)) #
                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                    (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
              )))))
        else (
          if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
          then (
            (Some (
              (pack_struct_return_code_para (make_return_code_para 8))  ,
              (st_4.[share].[globals].[g_granules] :<
                ((((st_4.(share)).(globals)).(g_granules)) #
                  ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                  (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
            )))
          else (
            (Some (
              (pack_struct_return_code_para (make_return_code_para 8))  ,
              (st_4.[share].[globals].[g_granules] :<
                ((((st_4.(share)).(globals)).(g_granules)) #
                  ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                  (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
            )))))
      else (
        when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_2));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_3))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))
  else (
    if (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) - (((test_PA v_1).(meta_granule_offset)))) =? (0))
    then (Some ((pack_struct_return_code_para (make_return_code_para 3)), st))
    else (
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
      then (
        when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
        if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (3)) =? (0))
        then (
          when st_3 == (
              (spinlock_acquire_spec
                (mkPtr
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(pbase))
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)))
                st_2));
          if (
            (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)) / (4096))).(e_state_s_granule)) -
              (5)) =?
              (0)))
          then (
            rely (((((((st_3.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
            rely (((("granule_data" = ("granule_data")) /\ (((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
            when rtt_ret, st_4 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "stack_s_rtt_walk" 0)
                  (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2)
                  0
                  64
                  v_2
                  3
                  st_3));
            rely ((((st_4.(share)).(granule_data)) = (((st_3.(share)).(granule_data)))));
            rely (((((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
            rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
            if ((rtt_ret.(e_1)) =? (3))
            then (
              if (
                (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
              then (
                when st_5 == (
                    (spinlock_acquire_spec
                      (mkPtr
                        ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(pbase))
                        ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(poffset)))
                      st_4));
                if (
                  (((((((st_5.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(poffset)) / (4096))).(e_state_s_granule)) -
                    (2)) =?
                    (0)))
                then (
                  when v_11, st_6 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
                  rely (((((st_6.(share)).(globals)).(g_granules)) = ((((st_5.(share)).(globals)).(g_granules)))));
                  rely (((((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
                  rely (((((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
                  if v_11
                  then (
                    rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                    rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) - (8)) =? (0))
                    then (
                      (Some (
                        0  ,
                        ((st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                          (((st_6.(share)).(granule_data)) #
                            ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                            ((((st_6.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_6.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))
                      )))
                    else None)
                  else (
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      (Some (
                        (pack_struct_return_code_para (make_return_code_para 1))  ,
                        ((st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                          (((st_6.(share)).(granule_data)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st_6.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                      )))
                    else (
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      (Some (
                        (pack_struct_return_code_para (make_return_code_para 1))  ,
                        ((st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                          (((st_6.(share)).(granule_data)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st_6.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                      )))))
                else (
                  when st_6 == (
                      (spinlock_release_spec
                        (mkPtr
                          ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(pbase))
                          ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(poffset)))
                        st_5));
                  when v_11, st_7 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_6));
                  rely (((((st_7.(share)).(globals)).(g_granules)) = ((((st_6.(share)).(globals)).(g_granules)))));
                  rely (((((((st_7.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
                  rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
                  if v_11
                  then (
                    rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                    rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) - (8)) =? (0))
                    then (
                      (Some (
                        0  ,
                        ((st_7.[share].[globals].[g_granules] :<
                          ((((st_7.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                          (((st_7.(share)).(granule_data)) #
                            ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                            ((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))
                      )))
                    else None)
                  else (
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      (Some (
                        (pack_struct_return_code_para (make_return_code_para 1))  ,
                        ((st_7.[share].[globals].[g_granules] :<
                          ((((st_7.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                          (((st_7.(share)).(granule_data)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st_7.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                      )))
                    else (
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      (Some (
                        (pack_struct_return_code_para (make_return_code_para 1))  ,
                        ((st_7.[share].[globals].[g_granules] :<
                          ((((st_7.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                          (((st_7.(share)).(granule_data)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st_7.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                      ))))))
              else (
                if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
                then (
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 9))  ,
                    (st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
                  )))
                else (
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 9))  ,
                    (st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                  )))))
            else (
              if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
              then (
                rely (
                  ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                    (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                rely ((st_4.(share).(globals).(g_granules) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule) = 1);
                rely ((st_4.(share).(granule_data) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(g_norm) = zero_granule_data);

                (Some (
                  (pack_struct_return_code_para (make_return_code_para 8))  ,
                  (st_4.[share].[globals].[g_granules] :<
                    ((((st_4.(share)).(globals)).(g_granules)) #
                      ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                      (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
                )))
              else (
                rely (
                  ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                    (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                (Some (
                  (pack_struct_return_code_para (make_return_code_para 8))  ,
                  (st_4.[share].[globals].[g_granules] :<
                    ((((st_4.(share)).(globals)).(g_granules)) #
                      ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                      (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                )))))
          else (
            when st_4 == (
                (spinlock_release_spec
                  (mkPtr
                    ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(pbase))
                    ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)))
                  st_3));
            rely ((((st_4.(share)).(granule_data)) = (((st_3.(share)).(granule_data)))));
            rely (((((((st_4.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
            rely (((("granule_data" = ("granule_data")) /\ (((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
            when rtt_ret, st_5 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "stack_s_rtt_walk" 0)
                  (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2)
                  0
                  64
                  v_2
                  3
                  st_4));
            rely ((((st_5.(share)).(granule_data)) = (((st_4.(share)).(granule_data)))));
            rely (((((((st_5.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
            rely (((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
            rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
            if ((rtt_ret.(e_1)) =? (3))
            then (
              if (
                (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_5).(meta_desc_type)) =? (0)) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_5).(meta_ripas)) =? (0)))) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_5).(meta_mem_attr)) =? (0)))))
              then (
                when st_6 == (
                    (spinlock_acquire_spec
                      (mkPtr
                        ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(pbase))
                        ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(poffset)))
                      st_5));
                if (
                  (((((((st_6.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(poffset)) / (4096))).(e_state_s_granule)) -
                    (2)) =?
                    (0)))
                then (
                  when v_11, st_7 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_6));
                  rely (((((st_7.(share)).(globals)).(g_granules)) = ((((st_6.(share)).(globals)).(g_granules)))));
                  rely (((((((st_7.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
                  rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
                  if v_11
                  then (
                    rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                    rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) - (8)) =? (0))
                    then (
                      (Some (
                        0  ,
                        ((st_7.[share].[globals].[g_granules] :<
                          ((((st_7.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                          (((st_7.(share)).(granule_data)) #
                            ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                            ((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))
                      )))
                    else None)
                  else (
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      (Some (
                        (pack_struct_return_code_para (make_return_code_para 1))  ,
                        ((st_7.[share].[globals].[g_granules] :<
                          ((((st_7.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                          (((st_7.(share)).(granule_data)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st_7.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                      )))
                    else (
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      (Some (
                        (pack_struct_return_code_para (make_return_code_para 1))  ,
                        ((st_7.[share].[globals].[g_granules] :<
                          ((((st_7.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                          (((st_7.(share)).(granule_data)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st_7.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                      )))))
                else (
                  when st_7 == (
                      (spinlock_release_spec
                        (mkPtr
                          ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(pbase))
                          ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(poffset)))
                        st_6));
                  when v_11, st_8 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_7));
                  rely (((((st_8.(share)).(globals)).(g_granules)) = ((((st_7.(share)).(globals)).(g_granules)))));
                  rely (((((((st_8.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
                  rely (((((((st_8.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
                  if v_11
                  then (
                    rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                    rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) - (8)) =? (0))
                    then (
                      (Some (
                        0  ,
                        ((st_8.[share].[globals].[g_granules] :<
                          ((((st_8.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_8.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                          (((st_8.(share)).(granule_data)) #
                            ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                            ((((st_8.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_8.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))
                      )))
                    else None)
                  else (
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      (Some (
                        (pack_struct_return_code_para (make_return_code_para 1))  ,
                        ((st_8.[share].[globals].[g_granules] :<
                          ((((st_8.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_8.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                          (((st_8.(share)).(granule_data)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st_8.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                      )))
                    else (
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      (Some (
                        (pack_struct_return_code_para (make_return_code_para 1))  ,
                        ((st_8.[share].[globals].[g_granules] :<
                          ((((st_8.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st_8.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                          (((st_8.(share)).(granule_data)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st_8.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                      ))))))
              else (
                if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
                then (
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 9))  ,
                    (st_5.[share].[globals].[g_granules] :<
                      ((((st_5.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
                  )))
                else (
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 9))  ,
                    (st_5.[share].[globals].[g_granules] :<
                      ((((st_5.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                  )))))
            else (
              if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
              then (
                rely (
                  ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                    (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                (Some (
                  (pack_struct_return_code_para (make_return_code_para 8))  ,
                  (st_5.[share].[globals].[g_granules] :<
                    ((((st_5.(share)).(globals)).(g_granules)) #
                      ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                      (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
                )))
              else (
                rely (
                  ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                    (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                (Some (
                  (pack_struct_return_code_para (make_return_code_para 8))  ,
                  (st_5.[share].[globals].[g_granules] :<
                    ((((st_5.(share)).(globals)).(g_granules)) #
                      ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                      (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                ))))))
        else (
          when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_2));
          (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_3))))
      else (
        when st_2 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_2))))). *)
    
  Definition gic_restore_state_loop214_rank (v_0: Ptr) (v_indvars_iv: Z) : Z := 4 - v_indvars_iv.
  Definition gic_restore_state_loop219_rank (v_0: Ptr) (v_indvars_iv: Z) : Z := 15 - v_indvars_iv.

  Hint NoUnfold map_unmap_ns_s1_spec.
  Hint NoUnfold granule_memzero_spec.

  Hint NoUnfold rtt_walk_lock_unlock_spec.

  Definition rsi_rtt_set_ripas_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if (v_3 >? (1))
    then (Some (1, st))
    else (
      if (check_rcsm_mask_para (test_PA v_0))
      then (
        when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
        if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
        then (
          rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
          rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
          when rtt_ret, st_3 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) 0 64 v_1 v_2 st_1));
          if (((rtt_ret.(e_1)) - (v_2)) =? (0))
          then (
            if ((v_2 <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_desc_type)) =? (3))))
            then (
              when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_3));
              (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_13)))
            else (
              if ((v_2 =? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_desc_type)) =? (3))))
              then (
                if (v_3 =? (0))
                then (
                  rely ((true = (true)));
                  when st_16 == (
                      (granule_unlock_spec
                        (rtt_ret.(e_2))
                        (st_3.[share].[granule_data] :<
                          (((st_3.(share)).(granule_data)) #
                            ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                            ((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t ((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_PA)) 0 0 1))))))));
                  (Some (0, st_16)))
                else (
                  rely ((true = (true)));
                  when st_16 == (
                      (granule_unlock_spec
                        (rtt_ret.(e_2))
                        (st_3.[share].[granule_data] :<
                          (((st_3.(share)).(granule_data)) #
                            ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                            ((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3))))))));
                  (Some (0, st_16))))
              else (
                if ((v_2 <>? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_desc_type)) =? (1))))
                then (
                  if (v_3 =? (0))
                  then (
                    rely ((true = (true)));
                    when st_16 == (
                        (granule_unlock_spec
                          (rtt_ret.(e_2))
                          (st_3.[share].[granule_data] :<
                            (((st_3.(share)).(granule_data)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                              ((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t ((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_PA)) 0 0 1))))))));
                    (Some (0, st_16)))
                  else (
                    rely ((true = (true)));
                    when st_16 == (
                        (granule_unlock_spec
                          (rtt_ret.(e_2))
                          (st_3.[share].[granule_data] :<
                            (((st_3.(share)).(granule_data)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                              ((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3))))))));
                    (Some (0, st_16))))
                else (
                  if (
                    (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_desc_type)) =? (0)) &&
                      ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_ripas)) =? (0)))) &&
                      ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_mem_attr)) =? (0)))))
                  then (
                    rely ((true = (true)));
                    when st_16 == (
                        (granule_unlock_spec
                          (rtt_ret.(e_2))
                          (st_3.[share].[granule_data] :<
                            (((st_3.(share)).(granule_data)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                              ((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z
                                    (mkabs_PTE_t
                                      ((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_PA))
                                      ((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_desc_type))
                                      v_3
                                      ((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_mem_attr))))))))));
                    (Some (0, st_16)))
                  else (
                    if (
                      (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_desc_type)) =? (0)) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_ripas)) =? (0)))) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_mem_attr)) =? (1)))))
                    then (
                      rely ((true = (true)));
                      when st_16 == (
                          (granule_unlock_spec
                            (rtt_ret.(e_2))
                            (st_3.[share].[granule_data] :<
                              (((st_3.(share)).(granule_data)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                                ((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_3.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z
                                      (mkabs_PTE_t
                                        ((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_PA))
                                        ((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_desc_type))
                                        v_3
                                        ((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_3).(meta_mem_attr))))))))));
                      (Some (0, st_16)))
                    else (
                      when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_3));
                      (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_13))))))))
          else (
            when st_7 == ((granule_unlock_spec (rtt_ret.(e_2)) st_3));
            (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7))))
        else (
          when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
          rely (((0 = (0)) /\ ((0 >= (0)))));
          rely ((("null" = ("granules")) \/ (("null" = ("null")))));
          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))
      else (
        when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
        if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (3)) =? (0))
        then (
          rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
          rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
          when st_2 == (
              (spinlock_acquire_spec
                (mkPtr
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(pbase))
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)))
                st_1));
          if (
            (((((((st_2.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (4096))).(e_state_s_granule)) -
              (5)) =?
              (0)))
          then (
            when st_5 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
            when ret_rtt, st_7 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "stack_s_rtt_walk" 0)
                  (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1)
                  0
                  64
                  v_1
                  v_2
                  st_5));
            rely ((((st_7.(share)).(granule_data)) = (((st_5.(share)).(granule_data)))));
            if (((ret_rtt.(e_1)) - (v_2)) =? (0))
            then (
              if ((v_2 <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))))
              then (
                when st_16 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
                (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_16)))
              else (
                if ((v_2 =? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))))
                then (
                  if (v_3 =? (0))
                  then (
                    rely ((true = (true)));
                    when st_19 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          (st_7.[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)) 0 0 1))))))));
                    (Some (0, st_19)))
                  else (
                    rely ((true = (true)));
                    when st_19 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          (st_7.[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7))))))));
                    (Some (0, st_19))))
                else (
                  if ((v_2 <>? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (1))))
                  then (
                    if (v_3 =? (0))
                    then (
                      rely ((true = (true)));
                      when st_19 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            (st_7.[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)) 0 0 1))))))));
                      (Some (0, st_19)))
                    else (
                      rely ((true = (true)));
                      when st_19 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            (st_7.[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7))))))));
                      (Some (0, st_19))))
                  else (
                    if (
                      (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (0)))))
                    then (
                      rely ((true = (true)));
                      when st_19 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            (st_7.[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z
                                      (mkabs_PTE_t
                                        ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA))
                                        ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type))
                                        v_3
                                        ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr))))))))));
                      (Some (0, st_19)))
                    else (
                      if (
                        (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                      then (
                        rely ((true = (true)));
                        when st_19 == (
                            (granule_unlock_spec
                              (ret_rtt.(e_2))
                              (st_7.[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z
                                        (mkabs_PTE_t
                                          ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA))
                                          ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type))
                                          v_3
                                          ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr))))))))));
                        (Some (0, st_19)))
                      else (
                        when st_16 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
                        (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_16))))))))
            else (
              when st_11 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
              (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_11))))
          else (
            when st_3 == (
                (spinlock_release_spec
                  (mkPtr
                    ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(pbase))
                    ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)))
                  st_2));
            when st_5 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
            when ret_rtt, st_7 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "stack_s_rtt_walk" 0)
                  (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1)
                  0
                  64
                  v_1
                  v_2
                  st_5));
            rely ((((st_7.(share)).(granule_data)) = (((st_5.(share)).(granule_data)))));
            if (((ret_rtt.(e_1)) - (v_2)) =? (0))
            then (
              if ((v_2 <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))))
              then (
                when st_16 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
                (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_16)))
              else (
                if ((v_2 =? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))))
                then (
                  if (v_3 =? (0))
                  then (
                    rely ((true = (true)));
                    when st_19 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          (st_7.[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)) 0 0 1))))))));
                    (Some (0, st_19)))
                  else (
                    rely ((true = (true)));
                    when st_19 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          (st_7.[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7))))))));
                    (Some (0, st_19))))
                else (
                  if ((v_2 <>? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (1))))
                  then (
                    if (v_3 =? (0))
                    then (
                      rely ((true = (true)));
                      when st_19 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            (st_7.[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)) 0 0 1))))))));
                      (Some (0, st_19)))
                    else (
                      rely ((true = (true)));
                      when st_19 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            (st_7.[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7))))))));
                      (Some (0, st_19))))
                  else (
                    if (
                      (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (0)))))
                    then (
                      rely ((true = (true)));
                      when st_19 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            (st_7.[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z
                                      (mkabs_PTE_t
                                        ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA))
                                        ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type))
                                        v_3
                                        ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr))))))))));
                      (Some (0, st_19)))
                    else (
                      if (
                        (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                      then (
                        rely ((true = (true)));
                        when st_19 == (
                            (granule_unlock_spec
                              (ret_rtt.(e_2))
                              (st_7.[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z
                                        (mkabs_PTE_t
                                          ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA))
                                          ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type))
                                          v_3
                                          ((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr))))))))));
                        (Some (0, st_19)))
                      else (
                        when st_16 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
                        (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_16))))))))
            else (
              when st_11 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
              (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_11)))))
        else (
          when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
          rely (((0 = (0)) /\ ((0 >= (0)))));
          rely ((("null" = ("granules")) \/ (("null" = ("null")))));
          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))).

  (* Definition rsi_rtt_set_ripas_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if (v_3 >? (1))
    then (Some (1, st))
    else (
      if ((v_0 & (1)) =? (0))
      then (
        rely (
          (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
            (((v_0 & (4095)) = (0)))));
        if ((v_0 - (MEM1_PHYS)) >=? (0))
        then (
          match (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
          | None =>
            rely (
              (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
                ((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
                (0)));
            if (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0))
            then (
              when st_3 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr "stack_s_rtt_walk" 0)
                    (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))
                    0
                    64
                    v_1
                    v_2
                    ((st.[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                      ((st.(share)).[globals].[g_granules] :<
                        ((((st.(share)).(globals)).(g_granules)) #
                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))));
              rely ((((st.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
              rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >=? (0)));
              rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) <? (0)));
              if (((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
              then (
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                None)
              else (
                when cid == (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                (Some (
                  ((((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                    ((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                  ((st.[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st.(log))))).[share].[globals].[g_granules] :<
                    ((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                ))))
            else (
              (Some (
                4294967553  ,
                ((st.[log] :<
                  ((EVT
                    CPU_ID
                    (REL
                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                      (((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                    (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                  ((st.(share)).[globals].[g_granules] :<
                    ((((st.(share)).(globals)).(g_granules)) #
                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None))))
              )))
          | (Some cid) => None
          end)
        else (
          match (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
          | None =>
            rely (
              (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                ((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                (0)));
            if (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0))
            then (
              when st_3 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr "stack_s_rtt_walk" 0)
                    (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))
                    0
                    64
                    v_1
                    v_2
                    ((st.[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                      ((st.(share)).[globals].[g_granules] :<
                        ((((st.(share)).(globals)).(g_granules)) #
                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))))));
              rely ((((st.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
              rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >=? (0)));
              rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) <? (0)));
              if (((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
              then (
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                None)
              else (
                when cid == (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                (Some (
                  ((((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                    ((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                  ((st.[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st.(log))))).[share].[globals].[g_granules] :<
                    ((((st.(share)).(globals)).(g_granules)) #
                      (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                ))))
            else (
              (Some (
                4294967553  ,
                ((st.[log] :<
                  ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) (((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                    (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                  ((st.(share)).[globals].[g_granules] :<
                    ((((st.(share)).(globals)).(g_granules)) #
                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))
              )))
          | (Some cid) => None
          end))
      else (
        rely (
          ((((((v_0 & ((- 2))) - (MEM0_PHYS)) >= (0)) /\ ((((v_0 & ((- 2))) - (4294967296)) < (0)))) \/
            (((((v_0 & ((- 2))) - (MEM1_PHYS)) >= (0)) /\ ((((v_0 & ((- 2))) - (556198264832)) < (0)))))) /\
            ((((v_0 & ((- 2))) & (4095)) = (0)))));
        if (((v_0 & ((- 2))) - (MEM1_PHYS)) >=? (0))
        then (
          match (((((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
          | None =>
            rely (
              (((((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
                ((((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
                (0)));
            if (((((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (3)) =? (0))
            then (
              when ret == ((granule_addr_spec' (mkPtr "granules" ((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)))));
              when ret_0 == ((buffer_map_spec' 3 ret false));
              rely (((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))) /\ (((ret_0.(poffset)) >= (0)))));
              rely (((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
              rely (
                (((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >=? (0)) /\
                  (((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (MEM0_VIRT)) <? (0)))));
              match (((((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
              | None =>
                rely (
                  ((((((((st.(share)).(globals)).(g_granules)) #
                    (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    ((((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                    (0)));
                rely (
                  ((("granules" = ("granules")) /\ (((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) mod (16)) = (0)))) /\
                    (((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)))));
                if (
                  (((((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    (5)) =?
                    (0)))
                then (
                  when cid == (((((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                  when st_7 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk" 0)
                        (mkPtr "granules" (((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                        0
                        64
                        v_1
                        v_2
                        ((st.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                              ((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                            (((EVT CPU_ID (ACQ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))).[share] :<
                          ((st.(share)).[globals].[g_granules] :<
                            (((((st.(share)).(globals)).(g_granules)) #
                              ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)) ==
                              (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) #
                              (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                              (((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None))))));
                  rely ((((st.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
                  rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >=? (0)));
                  rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) <? (0)));
                  if (((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    None)
                  else (
                    when cid_0 == (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                        ((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                      ((st.[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st.(log))))).[share].[globals].[g_granules] :<
                        ((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                    ))))
                else (
                  when cid == (
                      (((((((st.(share)).(globals)).(g_granules)) #
                        ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                          None)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                  when st_7 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk" 0)
                        (mkPtr "granules" (((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                        0
                        64
                        v_1
                        v_2
                        ((st.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                              (((((st.(share)).(globals)).(g_granules)) #
                                ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)) ==
                                (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                            (((EVT
                              CPU_ID
                              (REL
                                ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))
                                (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID)))) ::
                              (((EVT CPU_ID (ACQ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                                ((((st.(oracle)) ((EVT CPU_ID (ACQ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                  (((EVT CPU_ID (ACQ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))))).[share] :<
                          ((st.(share)).[globals].[g_granules] :<
                            (((((st.(share)).(globals)).(g_granules)) #
                              ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)) ==
                              (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) #
                              (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                              ((((((st.(share)).(globals)).(g_granules)) #
                                ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)) ==
                                (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
                                None))))));
                  rely ((((st.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
                  rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >=? (0)));
                  rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) <? (0)));
                  if (((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    None)
                  else (
                    when cid_0 == (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                        ((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                      ((st.[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st.(log))))).[share].[globals].[g_granules] :<
                        ((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                    ))))
              | (Some cid) => None
              end)
            else (
              (Some (
                4294967553  ,
                ((st.[log] :<
                  ((EVT
                    CPU_ID
                    (REL
                      (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                      (((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                    (((EVT CPU_ID (ACQ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                  ((st.(share)).[globals].[g_granules] :<
                    ((((st.(share)).(globals)).(g_granules)) #
                      (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None))))
              )))
          | (Some cid) => None
          end)
        else (
          match (((((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
          | None =>
            rely (
              (((((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                ((((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                (0)));
            if (((((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (3)) =? (0))
            then (
              when ret == ((granule_addr_spec' (mkPtr "granules" ((((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) * (16)))));
              when ret_0 == ((buffer_map_spec' 3 ret false));
              rely (((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))) /\ (((ret_0.(poffset)) >= (0)))));
              rely (((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
              rely (
                (((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >=? (0)) /\
                  (((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (MEM0_VIRT)) <? (0)))));
              match (((((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
              | None =>
                rely (
                  ((((((((st.(share)).(globals)).(g_granules)) #
                    (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    ((((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                    (0)));
                rely (
                  ((("granules" = ("granules")) /\ (((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) mod (16)) = (0)))) /\
                    (((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)))));
                if (
                  (((((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    (5)) =?
                    (0)))
                then (
                  when cid == (((((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                  when st_7 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk" 0)
                        (mkPtr "granules" (((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                        0
                        64
                        v_1
                        v_2
                        ((st.[log] :<
                          ((EVT CPU_ID (REL (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))))) ::
                            (((EVT CPU_ID (ACQ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))).[share] :<
                          ((st.(share)).[globals].[g_granules] :<
                            (((((st.(share)).(globals)).(g_granules)) #
                              ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)) ==
                              (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) #
                              (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ==
                              (((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))));
                  rely ((((st.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
                  rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >=? (0)));
                  rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) <? (0)));
                  if (((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    None)
                  else (
                    when cid_0 == (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                        ((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                      ((st.[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st.(log))))).[share].[globals].[g_granules] :<
                        ((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                    ))))
                else (
                  when cid == (
                      (((((((st.(share)).(globals)).(g_granules)) #
                        ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)) ==
                        (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                          None)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                  when st_7 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk" 0)
                        (mkPtr "granules" (((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                        0
                        64
                        v_1
                        v_2
                        ((st.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))
                              (((((st.(share)).(globals)).(g_granules)) #
                                ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)) ==
                                (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))))) ::
                            (((EVT
                              CPU_ID
                              (REL
                                ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))
                                (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID)))) ::
                              (((EVT CPU_ID (ACQ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                                ((((st.(oracle)) ((EVT CPU_ID (ACQ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                  (((EVT CPU_ID (ACQ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))))).[share] :<
                          ((st.(share)).[globals].[g_granules] :<
                            (((((st.(share)).(globals)).(g_granules)) #
                              ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)) ==
                              (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) #
                              (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ==
                              ((((((st.(share)).(globals)).(g_granules)) #
                                ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)) ==
                                (((((st.(share)).(globals)).(g_granules)) @ ((((((((st.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                None))))));
                  rely ((((st.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
                  rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >=? (0)));
                  rely ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) <? (0)));
                  if (((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    None)
                  else (
                    when cid_0 == (((((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                        ((((((st.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                      ((st.[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st.(log))))).[share].[globals].[g_granules] :<
                        ((((st.(share)).(globals)).(g_granules)) #
                          (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st.(share)).(globals)).(g_granules)) @ (((((st.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                    ))))
              | (Some cid) => None
              end)
            else (
              (Some (
                4294967553  ,
                ((st.[log] :<
                  ((EVT
                    CPU_ID
                    (REL
                      (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))
                      (((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                    (((EVT CPU_ID (ACQ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                  ((st.(share)).[globals].[g_granules] :<
                    ((((st.(share)).(globals)).(g_granules)) #
                      (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ==
                      (((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))
              )))
          | (Some cid) => None
          end))). *)

  Definition s2tte_create_destroyed_abs : abs_PTE_t :=
    let v_0 := (mkabs_PA_t (-1)) in
    ((mkabs_PTE_t v_0 0 0 2)).

    Definition rsi_data_destroy_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
      if (check_rcsm_mask_para (test_PA v_0))
      then (
        when st1 == ((query_oracle st));
        rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
        match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
        | None =>
          if (
            ((((((((st1.(share)).(globals)).(g_granules)) #
              (((test_PA v_0).(meta_granule_offset)) / (16)) ==
              (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
              (5)) =?
              (0)))
          then (
            rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
            when ret_rtt, st_3 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) 0 64 v_1 3 st1));
            rely (((((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
            if ((ret_rtt.(e_1)) =? (3))
            then (
              if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_desc_type)) =? (3))
              then (
                rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                when st1_0 == (
                    (query_oracle
                      (st_3.[share].[granule_data] :<
                        (((st_3.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 2))))))));
                rely (
                  ((((st1_0.(share)).(globals)).(g_granules)) =
                    (((((st_3.(share)).(globals)).(g_granules)) #
                      (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                      (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                        ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                match (((((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                | None =>
                  if (
                    ((((((((st1_0.(share)).(globals)).(g_granules)) #
                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                      (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                      (4)) =?
                      (0)))
                  then (
                    rely (
                      ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                        (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (
                      ((g_refcount_para
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                        st1_0) =?
                        (0)))
                    then (
                      (Some (
                        0  ,
                        ((st1_0.[share].[globals].[g_granules] :<
                          ((((st1_0.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ 
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                          (((st1_0.(share)).(granule_data)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st1_0.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                              zero_granule_data)))
                      )))
                    else (Some (0, st1_0)))
                  else None
                | (Some cid) => None
                end)
              else (
                if (
                  (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_desc_type)) =? (0)) &&
                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_ripas)) =? (0)))) &&
                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_mem_attr)) =? (1)))))
                then (
                  rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  when st1_0 == (
                      (query_oracle
                        (st_3.[share].[granule_data] :<
                          (((st_3.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                  rely (
                    ((((st1_0.(share)).(globals)).(g_granules)) =
                      (((((st_3.(share)).(globals)).(g_granules)) #
                        (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                        (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                  match (((((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                  | None =>
                    if (
                      ((((((((st1_0.(share)).(globals)).(g_granules)) #
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                        (4)) =?
                        (0)))
                    then (
                      rely (
                        ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                          (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      if (
                        ((g_refcount_para
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                          st1_0) =?
                          (0)))
                      then (
                        (Some (
                          0  ,
                          ((st1_0.[share].[globals].[g_granules] :<
                          ((((st1_0.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ 
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                          (((st1_0.(share)).(granule_data)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st1_0.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                              zero_granule_data)))
                        )))
                      else (Some (0, st1_0)))
                    else None
                  | (Some cid) => None
                  end)
                else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_3))))
            else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_3)))
          else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1))
        | (Some cid) => None
        end)
      else (
        when st1 == ((query_oracle st));
        rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
        match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
        | None =>
          if (
            ((((((((st1.(share)).(globals)).(g_granules)) #
              (((test_PA v_0).(meta_granule_offset)) / (16)) ==
              (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
              (3)) =?
              (0)))
          then (
            rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
            rely (((((((st.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
            if (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1).(pbase)) =s ("granules"))
            then (
              when st1_0 == ((query_oracle st1));
              rely (
                ((((st1_0.(share)).(globals)).(g_granules)) =
                  (((((st1.(share)).(globals)).(g_granules)) #
                    (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                    (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
              match (((((((st1_0.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1).(poffset)) / (16))).(e_lock)).(e_val))) with
              | None =>
                if (
                  ((((((((st1_0.(share)).(globals)).(g_granules)) #
                    (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1).(poffset)) / (16)) ==
                    (((((st1_0.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1).(poffset)) / (16))).[e_lock].[e_val] :<
                      (Some CPU_ID))) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1).(poffset)) / (4096))).(e_state_s_granule)) -
                    (5)) =?
                    (0)))
                then (
                  when ret_rtt, st_7 == (
                      (rtt_walk_lock_unlock_spec_abs
                        (mkPtr "stack_s_rtt_walk" 0)
                        (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1)
                        0
                        64
                        v_1
                        3
                        st1_0));
                  rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                  if ((ret_rtt.(e_1)) =? (3))
                  then (
                    rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
                    if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
                    then (
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      when st1_1 == (
                          (query_oracle
                            (st_7.[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 2))))))));
                      rely (
                        ((((st1_1.(share)).(globals)).(g_granules)) =
                          (((((st_7.(share)).(globals)).(g_granules)) #
                            (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                              ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                      match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        if (
                          ((((((((st1_1.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                            (4)) =?
                            (0)))
                        then (
                          rely (
                            ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          if (
                            ((g_refcount_para
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                              st1_1) =?
                              (0)))
                          then (
                            (Some (
                              0  ,
                              ((st1_1.[share].[globals].[g_granules] :<
                              ((((st1_1.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ 
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                              (((st1_1.(share)).(granule_data)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  zero_granule_data)))
                            )))
                          else (Some (0, st1_1)))
                        else None
                      | (Some cid) => None
                      end)
                    else (
                      if (
                        (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                      then (
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        when st1_1 == (
                            (query_oracle
                              (st_7.[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                        rely (
                          ((((st1_1.(share)).(globals)).(g_granules)) =
                            (((((st_7.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                        match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                        | None =>
                          if (
                            ((((((((st1_1.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                              (4)) =?
                              (0)))
                          then (
                            rely (
                              ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                            if (
                              ((g_refcount_para
                                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                st1_1) =?
                                (0)))
                            then (
                              (Some (
                                0  ,
                                ((st1_1.[share].[globals].[g_granules] :<
                                ((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ 
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                                (((st1_1.(share)).(granule_data)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                    zero_granule_data)))
                              )))
                            else (Some (0, st1_1)))
                          else None
                        | (Some cid) => None
                        end)
                      else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7))))
                  else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
                else (
                  when ret_rtt, st_7 == (
                      (rtt_walk_lock_unlock_spec_abs
                        (mkPtr "stack_s_rtt_walk" 0)
                        (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1)
                        0
                        64
                        v_1
                        3
                        st1_0));
                  rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                  if ((ret_rtt.(e_1)) =? (3))
                  then (
                    rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
                    if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
                    then (
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      when st1_1 == (
                          (query_oracle
                            (st_7.[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 2))))))));
                      rely (
                        ((((st1_1.(share)).(globals)).(g_granules)) =
                          (((((st_7.(share)).(globals)).(g_granules)) #
                            (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                              ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                      match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        if (
                          ((((((((st1_1.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                            (4)) =?
                            (0)))
                        then (
                          rely (
                            ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          if (
                            ((g_refcount_para
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                              st1_1) =?
                              (0)))
                          then (
                            (Some (
                              0  ,
                              ((st1_1.[share].[globals].[g_granules] :<
                              ((((st1_1.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ 
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                              (((st1_1.(share)).(granule_data)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  zero_granule_data)))
                            )))
                          else (Some (0, st1_1)))
                        else None
                      | (Some cid) => None
                      end)
                    else (
                      if (
                        (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                      then (
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        when st1_1 == (
                            (query_oracle
                              (st_7.[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                        rely (
                          ((((st1_1.(share)).(globals)).(g_granules)) =
                            (((((st_7.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                        match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                        | None =>
                          if (
                            ((((((((st1_1.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                              (4)) =?
                              (0)))
                          then (
                            rely (
                              ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                            if (
                              ((g_refcount_para
                                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                st1_1) =?
                                (0)))
                            then (
                              (Some (
                                0  ,
                                ((st1_1.[share].[globals].[g_granules] :<
                                ((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ 
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                                (((st1_1.(share)).(granule_data)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                    zero_granule_data)))
                              )))
                            else (Some (0, st1_1)))
                          else None
                        | (Some cid) => None
                        end)
                      else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7))))
                  else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
              | (Some cid) => None
              end)
            else (
              if (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1).(pbase)) =s ("vmid_lock"))
              then (
                when st1_0 == ((query_oracle st1));
                rely (
                  ((((st1_0.(share)).(globals)).(g_granules)) =
                    (((((st1.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                      (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
                if (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1).(poffset)) =? (0))
                then (
                  match (((((st1.(share)).(globals)).(g_vmid_lock)).(e_val))) with
                  | None =>
                    if (
                      (((((((st1_0.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1).(poffset)) / (4096))).(e_state_s_granule)) -
                        (5)) =?
                        (0)))
                    then (
                      when ret_rtt, st_7 == (
                          (rtt_walk_lock_unlock_spec_abs
                            (mkPtr "stack_s_rtt_walk" 0)
                            (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1)
                            0
                            64
                            v_1
                            3
                            st1_0));
                      rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                      if ((ret_rtt.(e_1)) =? (3))
                      then (
                        rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
                        if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
                        then (
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          when st1_1 == (
                              (query_oracle
                                (st_7.[share].[granule_data] :<
                                  (((st_7.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 2))))))));
                          rely (
                            ((((st1_1.(share)).(globals)).(g_granules)) =
                              (((((st_7.(share)).(globals)).(g_granules)) #
                                (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                          match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                          | None =>
                            if (
                              ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                                (4)) =?
                                (0)))
                            then (
                              rely (
                                ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                  (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                              if (
                                ((g_refcount_para
                                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                  st1_1) =?
                                  (0)))
                              then (
                                (Some (
                                  0  ,
                                  ((st1_1.[share].[globals].[g_granules] :<
                                  ((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ 
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                                  (((st1_1.(share)).(granule_data)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                      zero_granule_data)))
                                )))
                              else (Some (0, st1_1)))
                            else None
                          | (Some cid) => None
                          end)
                        else (
                          if (
                            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                          then (
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            when st1_1 == (
                                (query_oracle
                                  (st_7.[share].[granule_data] :<
                                    (((st_7.(share)).(granule_data)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                      ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                        (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                          (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                            rely (
                              ((((st1_1.(share)).(globals)).(g_granules)) =
                                (((((st_7.(share)).(globals)).(g_granules)) #
                                  (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                  (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                    ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                            match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                            | None =>
                              if (
                                ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                                  (4)) =?
                                  (0)))
                              then (
                                rely (
                                  ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                    (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                                if (
                                  ((g_refcount_para
                                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                    st1_1) =?
                                    (0)))
                                then (
                                  (Some (
                                    0  ,
                                      ((st1_1.[share].[globals].[g_granules] :<
                                      ((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ 
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                                      (((st1_1.(share)).(granule_data)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                        ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                          zero_granule_data)))
                                  )))
                                else (Some (0, st1_1)))
                              else None
                            | (Some cid) => None
                            end)
                          else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7))))
                      else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
                    else (
                      when st1_1 == ((query_oracle st1_0));
                      rely (((((st1_1.(share)).(globals)).(g_granules)) = ((((st1_0.(share)).(globals)).(g_granules)))));
                      when cid == (((((st1_0.(share)).(globals)).(g_vmid_lock)).(e_val)));
                      when ret_rtt, st_7 == (
                          (rtt_walk_lock_unlock_spec_abs
                            (mkPtr "stack_s_rtt_walk" 0)
                            (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1)
                            0
                            64
                            v_1
                            3
                            st1_1));
                      rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                      if ((ret_rtt.(e_1)) =? (3))
                      then (
                        rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
                        if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
                        then (
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          when st1_2 == (
                              (query_oracle
                                (st_7.[share].[granule_data] :<
                                  (((st_7.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 2))))))));
                          rely (
                            ((((st1_2.(share)).(globals)).(g_granules)) =
                              (((((st_7.(share)).(globals)).(g_granules)) #
                                (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                          match (((((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                          | None =>
                            if (
                              ((((((((st1_2.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                                (4)) =?
                                (0)))
                            then (
                              rely (
                                ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                  (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                              if (
                                ((g_refcount_para
                                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                  st1_2) =?
                                  (0)))
                              then (
                                (Some (
                                  0  ,
                                  ((st1_2.[share].[globals].[g_granules] :<
                                  ((((st1_2.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    (((((st1_2.(share)).(globals)).(g_granules)) @ 
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                                  (((st1_2.(share)).(granule_data)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((st1_2.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                      zero_granule_data)))
                                )))
                              else (Some (0, st1_2)))
                            else None
                          | (Some cid_0) => None
                          end)
                        else (
                          if (
                            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                          then (
                            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                            when st1_2 == (
                                (query_oracle
                                  (st_7.[share].[granule_data] :<
                                    (((st_7.(share)).(granule_data)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                      ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                        (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                          (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                            rely (
                              ((((st1_2.(share)).(globals)).(g_granules)) =
                                (((((st_7.(share)).(globals)).(g_granules)) #
                                  (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                  (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                    ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                            match (((((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                            | None =>
                              if (
                                ((((((((st1_2.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                                  (4)) =?
                                  (0)))
                              then (
                                rely (
                                  ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                    (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                                if (
                                  ((g_refcount_para
                                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                    st1_2) =?
                                    (0)))
                                then (
                                  (Some (
                                    0  ,
                                    ((st1_2.[share].[globals].[g_granules] :<
                                    ((((st1_2.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                      (((((st1_2.(share)).(globals)).(g_granules)) @ 
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                                    (((st1_2.(share)).(granule_data)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                      ((((st1_2.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                        zero_granule_data)))
                                  )))
                                else (Some (0, st1_2)))
                              else None
                            | (Some cid_0) => None
                            end)
                          else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7))))
                      else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
                  | (Some cid) => None
                  end)
                else (
                  if (
                    (((((((st1_0.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1).(poffset)) / (4096))).(e_state_s_granule)) -
                      (5)) =?
                      (0)))
                  then (
                    when ret_rtt, st_7 == (
                        (rtt_walk_lock_unlock_spec_abs
                          (mkPtr "stack_s_rtt_walk" 0)
                          (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st1)
                          0
                          64
                          v_1
                          3
                          st1_0));
                    rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                    if ((ret_rtt.(e_1)) =? (3))
                    then (
                      rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
                      if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
                      then (
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        when st1_1 == (
                            (query_oracle
                              (st_7.[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 2))))))));
                        rely (
                          ((((st1_1.(share)).(globals)).(g_granules)) =
                            (((((st_7.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                        match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                        | None =>
                          if (
                            ((((((((st1_1.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                              (4)) =?
                              (0)))
                          then (
                            rely (
                              ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                            if (
                              ((g_refcount_para
                                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                st1_1) =?
                                (0)))
                            then (
                              (Some (
                                0  ,
                                ((st1_1.[share].[globals].[g_granules] :<
                                ((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ 
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                                (((st1_1.(share)).(granule_data)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                    zero_granule_data)))
                              )))
                            else (Some (0, st1_1)))
                          else None
                        | (Some cid) => None
                        end)
                      else (
                        if (
                          (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                        then (
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          when st1_1 == (
                              (query_oracle
                                (st_7.[share].[granule_data] :<
                                  (((st_7.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                          rely (
                            ((((st1_1.(share)).(globals)).(g_granules)) =
                              (((((st_7.(share)).(globals)).(g_granules)) #
                                (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                          match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                          | None =>
                            if (
                              ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                                (4)) =?
                                (0)))
                            then (
                              rely (
                                ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                  (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                              if (
                                ((g_refcount_para
                                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                  st1_1) =?
                                  (0)))
                              then (
                                (Some (
                                  0  ,
                                  ((st1_1.[share].[globals].[g_granules] :<
                                  ((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ 
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                                  (((st1_1.(share)).(granule_data)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                      zero_granule_data)))
                                )))
                              else (Some (0, st1_1)))
                            else None
                          | (Some cid) => None
                          end)
                        else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7))))
                    else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
                  else None))
              else None))
          else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1))
        | (Some cid) => None
        end).
(* 
  Definition rsi_data_destroy_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if (check_rcsm_mask_para (test_PA v_0))
    then (
      when st1 == ((query_oracle st));
      rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
      match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
      | None =>
        if (
          ((((((((st1.(share)).(globals)).(g_granules)) #
            (((test_PA v_0).(meta_granule_offset)) / (16)) ==
            (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
            (5)) =?
            (0)))
        then (
          rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
          when ret_rtt, st_3 == (
              (rtt_walk_lock_unlock_spec_abs
                (mkPtr "stack_s_rtt_walk" 0)
                (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                0
                64
                v_1
                3
                (st1.[share].[globals].[g_granules] :<
                  ((((st1.(share)).(globals)).(g_granules)) #
                    (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                    (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
          rely (((((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
          if ((ret_rtt.(e_1)) =? (3))
          then (
            if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_desc_type)) =? (3))
            then (
              rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
              when st1_0 == (
                  (query_oracle
                    ((st_3.[share].[globals].[g_granules] :<
                      ((((st_3.(share)).(globals)).(g_granules)) #
                        (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                        (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                      (((st_3.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z ((mkabs_PTE_t (mkabs_PA_t (-1)) 0 0 2)))))))));
              rely (
                ((((st1_0.(share)).(globals)).(g_granules)) =
                  (((((st_3.(share)).(globals)).(g_granules)) #
                    (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                    (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                      ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                        (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
              match (((((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
              | None =>
                if (
                  ((((((((st1_0.(share)).(globals)).(g_granules)) #
                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                    (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                    (4)) =?
                    (0)))
                then (
                  rely (
                    ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                      (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  if (
                    ((g_refcount_para
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                      (st1_0.[share].[globals].[g_granules] :<
                        (((((st1_0.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                            (Some CPU_ID))) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((((st1_0.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                            (((((((st1_0.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              ((((((((st1_0.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))) =?
                      (0)))
                  then (
                    (Some (
                      0  ,
                      ((st1_0.[share].[globals].[g_granules] :<
                        (((((st1_0.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                            (Some CPU_ID))) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          (((((((st1_0.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                            (((((((st1_0.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              ((((((((st1_0.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1))))).[e_state_s_granule] :<
                            1))).[share].[granule_data] :<
                        (((st1_0.(share)).(granule_data)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((st1_0.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                            zero_granule_data)))
                    )))
                  else (
                    (Some (
                      0  ,
                      (st1_0.[share].[globals].[g_granules] :<
                        (((((st1_0.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                            (Some CPU_ID))) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((((st1_0.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                            (((((((st1_0.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              ((((((((st1_0.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))
                    ))))
                else None
              | (Some cid) => None
              end)
            else (
              if (
                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_desc_type)) =? (0)) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_ripas)) =? (0)))) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_mem_attr)) =? (1)))))
              then (
                rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                when st1_0 == (
                    (query_oracle
                      ((st_3.[share].[globals].[g_granules] :<
                        ((((st_3.(share)).(globals)).(g_granules)) #
                          (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                          (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                        (((st_3.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                rely (
                  ((((st1_0.(share)).(globals)).(g_granules)) =
                    (((((st_3.(share)).(globals)).(g_granules)) #
                      (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                      (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                        ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                match (((((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                | None =>
                  if (
                    ((((((((st1_0.(share)).(globals)).(g_granules)) #
                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                      (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                      (4)) =?
                      (0)))
                  then (
                    rely (
                      ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                        (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (
                      ((g_refcount_para
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                        (st1_0.[share].[globals].[g_granules] :<
                          (((((st1_0.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((((st1_0.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                              (((((((st1_0.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                ((((((((st1_0.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))) =?
                        (0)))
                    then (
                      (Some (
                        0  ,
                        ((st1_0.[share].[globals].[g_granules] :<
                          (((((st1_0.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            (((((((st1_0.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                              (((((((st1_0.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                ((((((((st1_0.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1))))).[e_state_s_granule] :<
                              1))).[share].[granule_data] :<
                          (((st1_0.(share)).(granule_data)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((st1_0.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                              zero_granule_data)))
                      )))
                    else (
                      (Some (
                        0  ,
                        (st1_0.[share].[globals].[g_granules] :<
                          (((((st1_0.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                            ((((((st1_0.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                              (((((((st1_0.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                ((((((((st1_0.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_0.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))
                      ))))
                  else None
                | (Some cid) => None
                end)
              else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_3))))
          else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_3)))
        else (
          (Some (
            (pack_struct_return_code_para (make_return_code_para 1))  ,
            (st1.[share].[globals].[g_granules] :<
              ((((st1.(share)).(globals)).(g_granules)) #
                (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< None)))
          )))
      | (Some cid) => None
      end)
    else (
      when st1 == ((query_oracle st));
      rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
      match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
      | None =>
        if (
          ((((((((st1.(share)).(globals)).(g_granules)) #
            (((test_PA v_0).(meta_granule_offset)) / (16)) ==
            (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
            (3)) =?
            (0)))
        then (
          rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
          rely (((((((st.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
          if (
            (((rec_to_ttbr1_para
              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
              (st1.[share].[globals].[g_granules] :<
                ((((st1.(share)).(globals)).(g_granules)) #
                  (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                  (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(pbase)) =s
              ("granules")))
          then (
            when st1_0 == (
                (query_oracle
                  (st1.[share].[globals].[g_granules] :<
                    ((((st1.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                      (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
            rely (
              ((((st1_0.(share)).(globals)).(g_granules)) =
                (((((st1.(share)).(globals)).(g_granules)) #
                  (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                  (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match (
              ((((((st1_0.(share)).(globals)).(g_granules)) @
                (((rec_to_ttbr1_para
                  (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                  (st1.[share].[globals].[g_granules] :<
                    ((((st1.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                      (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                  (16))).(e_lock)).(e_val))
            ) with
            | None =>
              if (
                ((((((((st1_0.(share)).(globals)).(g_granules)) #
                  (((rec_to_ttbr1_para
                    (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                    (st1.[share].[globals].[g_granules] :<
                      ((((st1.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                        (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                    (16)) ==
                  (((((st1_0.(share)).(globals)).(g_granules)) @
                    (((rec_to_ttbr1_para
                      (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                      (st1.[share].[globals].[g_granules] :<
                        ((((st1.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                          (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                      (16))).[e_lock].[e_val] :<
                    (Some CPU_ID))) @
                  (((rec_to_ttbr1_para
                    (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                    (st1.[share].[globals].[g_granules] :<
                      ((((st1.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                        (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                    (4096))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when ret_rtt, st_7 == (
                    (rtt_walk_lock_unlock_spec_abs
                      (mkPtr "stack_s_rtt_walk" 0)
                      (rec_to_ttbr1_para
                        (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                        (st1.[share].[globals].[g_granules] :<
                          ((((st1.(share)).(globals)).(g_granules)) #
                            (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                            (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))
                      0
                      64
                      v_1
                      3
                      (st1_0.[share].[globals].[g_granules] :<
                        ((((st1_0.(share)).(globals)).(g_granules)) #
                          (((rec_to_ttbr1_para
                            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                            (st1.[share].[globals].[g_granules] :<
                              ((((st1.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                                (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                            (16)) ==
                          (((((st1_0.(share)).(globals)).(g_granules)) @
                            (((rec_to_ttbr1_para
                              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                              (st1.[share].[globals].[g_granules] :<
                                ((((st1.(share)).(globals)).(g_granules)) #
                                  (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                                  (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                              (16))).[e_lock].[e_val] :<
                            (Some CPU_ID))))));
                rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                if ((ret_rtt.(e_1)) =? (3))
                then (
                  rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
                  if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
                  then (
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    when st1_1 == (
                        (query_oracle
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z ((mkabs_PTE_t (mkabs_PA_t (-1)) 0 0 2)))))))));
                    rely (
                      ((((st1_1.(share)).(globals)).(g_granules)) =
                        (((((st_7.(share)).(globals)).(g_granules)) #
                          (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                          (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                            ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                    match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                    | None =>
                      if (
                        ((((((((st1_1.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                          (4)) =?
                          (0)))
                      then (
                        rely (
                          ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        if (
                          ((g_refcount_para
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                            (st1_1.[share].[globals].[g_granules] :<
                              (((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                ((((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                  (((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))))))) =?
                            (0)))
                        then (
                          (Some (
                            0  ,
                            ((st1_1.[share].[globals].[g_granules] :<
                              (((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                (((((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                  (((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1))))).[e_state_s_granule] :<
                                  1))).[share].[granule_data] :<
                              (((st1_1.(share)).(granule_data)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  zero_granule_data)))
                          )))
                        else (
                          (Some (
                            0  ,
                            (st1_1.[share].[globals].[g_granules] :<
                              (((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                ((((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                  (((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))))))
                          ))))
                      else None
                    | (Some cid) => None
                    end)
                  else (
                    if (
                      (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                    then (
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      when st1_1 == (
                          (query_oracle
                            ((st_7.[share].[globals].[g_granules] :<
                              ((((st_7.(share)).(globals)).(g_granules)) #
                                (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                      rely (
                        ((((st1_1.(share)).(globals)).(g_granules)) =
                          (((((st_7.(share)).(globals)).(g_granules)) #
                            (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                              ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                      match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        if (
                          ((((((((st1_1.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                            (4)) =?
                            (0)))
                        then (
                          rely (
                            ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          if (
                            ((g_refcount_para
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                              (st1_1.[share].[globals].[g_granules] :<
                                (((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))))) =?
                              (0)))
                          then (
                            (Some (
                              0  ,
                              ((st1_1.[share].[globals].[g_granules] :<
                                (((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  (((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1))))).[e_state_s_granule] :<
                                    1))).[share].[granule_data] :<
                                (((st1_1.(share)).(granule_data)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                    zero_granule_data)))
                            )))
                          else (
                            (Some (
                              0  ,
                              (st1_1.[share].[globals].[g_granules] :<
                                (((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))))
                            ))))
                        else None
                      | (Some cid) => None
                      end)
                    else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7))))
                else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
              else (
                when ret_rtt, st_7 == (
                    (rtt_walk_lock_unlock_spec_abs
                      (mkPtr "stack_s_rtt_walk" 0)
                      (rec_to_ttbr1_para
                        (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                        (st1.[share].[globals].[g_granules] :<
                          ((((st1.(share)).(globals)).(g_granules)) #
                            (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                            (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))
                      0
                      64
                      v_1
                      3
                      (st1_0.[share].[globals].[g_granules] :<
                        ((((st1_0.(share)).(globals)).(g_granules)) #
                          (((rec_to_ttbr1_para
                            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                            (st1.[share].[globals].[g_granules] :<
                              ((((st1.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                                (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                            (16)) ==
                          (((((st1_0.(share)).(globals)).(g_granules)) @
                            (((rec_to_ttbr1_para
                              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                              (st1.[share].[globals].[g_granules] :<
                                ((((st1.(share)).(globals)).(g_granules)) #
                                  (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                                  (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                              (16))).[e_lock].[e_val] :<
                            None)))));
                rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                if ((ret_rtt.(e_1)) =? (3))
                then (
                  rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
                  if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
                  then (
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    when st1_1 == (
                        (query_oracle
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z ((mkabs_PTE_t (mkabs_PA_t (-1)) 0 0 2)))))))));
                    rely (
                      ((((st1_1.(share)).(globals)).(g_granules)) =
                        (((((st_7.(share)).(globals)).(g_granules)) #
                          (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                          (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                            ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                    match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                    | None =>
                      if (
                        ((((((((st1_1.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                          (4)) =?
                          (0)))
                      then (
                        rely (
                          ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        if (
                          ((g_refcount_para
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                            (st1_1.[share].[globals].[g_granules] :<
                              (((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                ((((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                  (((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))))))) =?
                            (0)))
                        then (
                          (Some (
                            0  ,
                            ((st1_1.[share].[globals].[g_granules] :<
                              (((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                (((((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                  (((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1))))).[e_state_s_granule] :<
                                  1))).[share].[granule_data] :<
                              (((st1_1.(share)).(granule_data)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  zero_granule_data)))
                          )))
                        else (
                          (Some (
                            0  ,
                            (st1_1.[share].[globals].[g_granules] :<
                              (((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                ((((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                  (((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))))))
                          ))))
                      else None
                    | (Some cid) => None
                    end)
                  else (
                    if (
                      (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                    then (
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      when st1_1 == (
                          (query_oracle
                            ((st_7.[share].[globals].[g_granules] :<
                              ((((st_7.(share)).(globals)).(g_granules)) #
                                (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                      rely (
                        ((((st1_1.(share)).(globals)).(g_granules)) =
                          (((((st_7.(share)).(globals)).(g_granules)) #
                            (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                              ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                      match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        if (
                          ((((((((st1_1.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                            (4)) =?
                            (0)))
                        then (
                          rely (
                            ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          if (
                            ((g_refcount_para
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                              (st1_1.[share].[globals].[g_granules] :<
                                (((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))))) =?
                              (0)))
                          then (
                            (Some (
                              0  ,
                              ((st1_1.[share].[globals].[g_granules] :<
                                (((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  (((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1))))).[e_state_s_granule] :<
                                    1))).[share].[granule_data] :<
                                (((st1_1.(share)).(granule_data)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                    zero_granule_data)))
                            )))
                          else (
                            (Some (
                              0  ,
                              (st1_1.[share].[globals].[g_granules] :<
                                (((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))))
                            ))))
                        else None
                      | (Some cid) => None
                      end)
                    else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7))))
                else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
            | (Some cid) => None
            end)
          else (
            if (
              (((rec_to_ttbr1_para
                (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                (st1.[share].[globals].[g_granules] :<
                  ((((st1.(share)).(globals)).(g_granules)) #
                    (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                    (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(pbase)) =s
                ("vmid_lock")))
            then (
              when st1_0 == (
                  (query_oracle
                    (st1.[share].[globals].[g_granules] :<
                      ((((st1.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                        (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
              rely (
                ((((st1_0.(share)).(globals)).(g_granules)) =
                  (((((st1.(share)).(globals)).(g_granules)) #
                    (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                    (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
              if (
                (((rec_to_ttbr1_para
                  (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                  (st1.[share].[globals].[g_granules] :<
                    ((((st1.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                      (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) =?
                  (0)))
              then (
                match (((((st1.(share)).(globals)).(g_vmid_lock)).(e_val))) with
                | None =>
                  if (
                    (((((((st1_0.(share)).(globals)).(g_granules)) @
                      (((rec_to_ttbr1_para
                        (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                        (st1.[share].[globals].[g_granules] :<
                          ((((st1.(share)).(globals)).(g_granules)) #
                            (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                            (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                        (4096))).(e_state_s_granule)) -
                      (5)) =?
                      (0)))
                  then (
                    when ret_rtt, st_7 == (
                        (rtt_walk_lock_unlock_spec_abs
                          (mkPtr "stack_s_rtt_walk" 0)
                          (rec_to_ttbr1_para
                            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                            (st1.[share].[globals].[g_granules] :<
                              ((((st1.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                                (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))
                          0
                          64
                          v_1
                          3
                          st1_0));
                    rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                    if ((ret_rtt.(e_1)) =? (3))
                    then (
                      rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
                      if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
                      then (
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        when st1_1 == (
                            (query_oracle
                              ((st_7.[share].[globals].[g_granules] :<
                                ((((st_7.(share)).(globals)).(g_granules)) #
                                  (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                  (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                    ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z ((mkabs_PTE_t (mkabs_PA_t (-1)) 0 0 2)))))))));
                        rely (
                          ((((st1_1.(share)).(globals)).(g_granules)) =
                            (((((st_7.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                        match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                        | None =>
                          if (
                            ((((((((st1_1.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                              (4)) =?
                              (0)))
                          then (
                            rely (
                              ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                            if (
                              ((g_refcount_para
                                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                (st1_1.[share].[globals].[g_granules] :<
                                  (((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      (((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))))) =?
                                (0)))
                            then (
                              (Some (
                                0  ,
                                ((st1_1.[share].[globals].[g_granules] :<
                                  (((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      (((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1))))).[e_state_s_granule] :<
                                      1))).[share].[granule_data] :<
                                  (((st1_1.(share)).(granule_data)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                      zero_granule_data)))
                              )))
                            else (
                              (Some (
                                0  ,
                                (st1_1.[share].[globals].[g_granules] :<
                                  (((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      (((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))))
                              ))))
                          else None
                        | (Some cid) => None
                        end)
                      else (
                        if (
                          (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                        then (
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          when st1_1 == (
                              (query_oracle
                                ((st_7.[share].[globals].[g_granules] :<
                                  ((((st_7.(share)).(globals)).(g_granules)) #
                                    (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                    (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                      ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                  (((st_7.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                          rely (
                            ((((st1_1.(share)).(globals)).(g_granules)) =
                              (((((st_7.(share)).(globals)).(g_granules)) #
                                (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                          match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                          | None =>
                            if (
                              ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                                (4)) =?
                                (0)))
                            then (
                              rely (
                                ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                  (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                              if (
                                ((g_refcount_para
                                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                  (st1_1.[share].[globals].[g_granules] :<
                                    (((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                      ((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                        (((((((st1_1.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                          ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                            (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))))) =?
                                  (0)))
                              then (
                                (Some (
                                  0  ,
                                  ((st1_1.[share].[globals].[g_granules] :<
                                    (((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                      (((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                        (((((((st1_1.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                          ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                            (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1))))).[e_state_s_granule] :<
                                        1))).[share].[granule_data] :<
                                    (((st1_1.(share)).(granule_data)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                      ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                        zero_granule_data)))
                                )))
                              else (
                                (Some (
                                  0  ,
                                  (st1_1.[share].[globals].[g_granules] :<
                                    (((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                      ((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                        (((((((st1_1.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                          ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                            (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))))
                                ))))
                            else None
                          | (Some cid) => None
                          end)
                        else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7))))
                    else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
                  else (
                    when st1_1 == ((query_oracle st1_0));
                    rely (((((st1_1.(share)).(globals)).(g_granules)) = ((((st1_0.(share)).(globals)).(g_granules)))));
                    when cid == (((((st1_0.(share)).(globals)).(g_vmid_lock)).(e_val)));
                    when ret_rtt, st_7 == (
                        (rtt_walk_lock_unlock_spec_abs
                          (mkPtr "stack_s_rtt_walk" 0)
                          (rec_to_ttbr1_para
                            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                            (st1.[share].[globals].[g_granules] :<
                              ((((st1.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                                (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))
                          0
                          64
                          v_1
                          3
                          st1_1));
                    rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                    if ((ret_rtt.(e_1)) =? (3))
                    then (
                      rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
                      if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
                      then (
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        when st1_2 == (
                            (query_oracle
                              ((st_7.[share].[globals].[g_granules] :<
                                ((((st_7.(share)).(globals)).(g_granules)) #
                                  (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                  (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                    ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z ((mkabs_PTE_t (mkabs_PA_t (-1)) 0 0 2)))))))));
                        rely (
                          ((((st1_2.(share)).(globals)).(g_granules)) =
                            (((((st_7.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                        match (((((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                        | None =>
                          if (
                            ((((((((st1_2.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                              (4)) =?
                              (0)))
                          then (
                            rely (
                              ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                            if (
                              ((g_refcount_para
                                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                (st1_2.[share].[globals].[g_granules] :<
                                  (((((st1_2.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((((st1_2.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      (((((((st1_2.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        ((((((((st1_2.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))))) =?
                                (0)))
                            then (
                              (Some (
                                0  ,
                                ((st1_2.[share].[globals].[g_granules] :<
                                  (((((st1_2.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    (((((((st1_2.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      (((((((st1_2.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        ((((((((st1_2.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1))))).[e_state_s_granule] :<
                                      1))).[share].[granule_data] :<
                                  (((st1_2.(share)).(granule_data)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((st1_2.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                      zero_granule_data)))
                              )))
                            else (
                              (Some (
                                0  ,
                                (st1_2.[share].[globals].[g_granules] :<
                                  (((((st1_2.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((((st1_2.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      (((((((st1_2.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        ((((((((st1_2.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))))
                              ))))
                          else None
                        | (Some cid_0) => None
                        end)
                      else (
                        if (
                          (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                        then (
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          when st1_2 == (
                              (query_oracle
                                ((st_7.[share].[globals].[g_granules] :<
                                  ((((st_7.(share)).(globals)).(g_granules)) #
                                    (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                    (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                      ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                  (((st_7.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                          rely (
                            ((((st1_2.(share)).(globals)).(g_granules)) =
                              (((((st_7.(share)).(globals)).(g_granules)) #
                                (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                          match (((((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                          | None =>
                            if (
                              ((((((((st1_2.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                                (4)) =?
                                (0)))
                            then (
                              rely (
                                ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                  (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                              if (
                                ((g_refcount_para
                                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                  (st1_2.[share].[globals].[g_granules] :<
                                    (((((st1_2.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                      ((((((st1_2.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                        (((((((st1_2.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                          ((((((((st1_2.(share)).(globals)).(g_granules)) #
                                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                            (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))))) =?
                                  (0)))
                              then (
                                (Some (
                                  0  ,
                                  ((st1_2.[share].[globals].[g_granules] :<
                                    (((((st1_2.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                      (((((((st1_2.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                        (((((((st1_2.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                          ((((((((st1_2.(share)).(globals)).(g_granules)) #
                                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                            (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1))))).[e_state_s_granule] :<
                                        1))).[share].[granule_data] :<
                                    (((st1_2.(share)).(granule_data)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                      ((((st1_2.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                        zero_granule_data)))
                                )))
                              else (
                                (Some (
                                  0  ,
                                  (st1_2.[share].[globals].[g_granules] :<
                                    (((((st1_2.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                      ((((((st1_2.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                        (((((((st1_2.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                          ((((((((st1_2.(share)).(globals)).(g_granules)) #
                                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                            (((((st1_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))))
                                ))))
                            else None
                          | (Some cid_0) => None
                          end)
                        else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7))))
                    else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
                | (Some cid) => None
                end)
              else (
                if (
                  (((((((st1_0.(share)).(globals)).(g_granules)) @
                    (((rec_to_ttbr1_para
                      (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                      (st1.[share].[globals].[g_granules] :<
                        ((((st1.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                          (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                      (4096))).(e_state_s_granule)) -
                    (5)) =?
                    (0)))
                then (
                  when ret_rtt, st_7 == (
                      (rtt_walk_lock_unlock_spec_abs
                        (mkPtr "stack_s_rtt_walk" 0)
                        (rec_to_ttbr1_para
                          (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                          (st1.[share].[globals].[g_granules] :<
                            ((((st1.(share)).(globals)).(g_granules)) #
                              (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                              (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))
                        0
                        64
                        v_1
                        3
                        st1_0));
                  rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                  if ((ret_rtt.(e_1)) =? (3))
                  then (
                    rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
                    if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
                    then (
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      when st1_1 == (
                          (query_oracle
                            ((st_7.[share].[globals].[g_granules] :<
                              ((((st_7.(share)).(globals)).(g_granules)) #
                                (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z ((mkabs_PTE_t (mkabs_PA_t (-1)) 0 0 2)))))))));
                      rely (
                        ((((st1_1.(share)).(globals)).(g_granules)) =
                          (((((st_7.(share)).(globals)).(g_granules)) #
                            (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                              ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                      match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        if (
                          ((((((((st1_1.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                            (4)) =?
                            (0)))
                        then (
                          rely (
                            ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          if (
                            ((g_refcount_para
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                              (st1_1.[share].[globals].[g_granules] :<
                                (((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))))) =?
                              (0)))
                          then (
                            (Some (
                              0  ,
                              ((st1_1.[share].[globals].[g_granules] :<
                                (((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  (((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1))))).[e_state_s_granule] :<
                                    1))).[share].[granule_data] :<
                                (((st1_1.(share)).(granule_data)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                    zero_granule_data)))
                            )))
                          else (
                            (Some (
                              0  ,
                              (st1_1.[share].[globals].[g_granules] :<
                                (((((st1_1.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                  (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID))) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))))
                            ))))
                        else None
                      | (Some cid) => None
                      end)
                    else (
                      if (
                        (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
                      then (
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        when st1_1 == (
                            (query_oracle
                              ((st_7.[share].[globals].[g_granules] :<
                                ((((st_7.(share)).(globals)).(g_granules)) #
                                  (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                                  (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                    ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
                        rely (
                          ((((st1_1.(share)).(globals)).(g_granules)) =
                            (((((st_7.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))));
                        match (((((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
                        | None =>
                          if (
                            ((((((((st1_1.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                              (4)) =?
                              (0)))
                          then (
                            rely (
                              ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                            if (
                              ((g_refcount_para
                                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                                (st1_1.[share].[globals].[g_granules] :<
                                  (((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      (((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))))) =?
                                (0)))
                            then (
                              (Some (
                                0  ,
                                ((st1_1.[share].[globals].[g_granules] :<
                                  (((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    (((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      (((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1))))).[e_state_s_granule] :<
                                      1))).[share].[granule_data] :<
                                  (((st1_1.(share)).(granule_data)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((st1_1.(share)).(granule_data)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :<
                                      zero_granule_data)))
                              )))
                            else (
                              (Some (
                                0  ,
                                (st1_1.[share].[globals].[g_granules] :<
                                  (((((st1_1.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID))) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((((st1_1.(share)).(globals)).(g_granules)) #
                                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                      (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                        (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      (((((((st1_1.(share)).(globals)).(g_granules)) #
                                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                        (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                          (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        ((((((((st1_1.(share)).(globals)).(g_granules)) #
                                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                          (((((st1_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_lock].[e_val] :<
                                            (Some CPU_ID))) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))))
                              ))))
                          else None
                        | (Some cid) => None
                        end)
                      else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7))))
                  else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
                else None))
            else None))
        else (
          (Some (
            (pack_struct_return_code_para (make_return_code_para 1))  ,
            (st1.[share].[globals].[g_granules] :<
              ((((st1.(share)).(globals)).(g_granules)) #
                (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< None)))
          )))
      | (Some cid) => None
      end). *)
  

  Definition validate_map_addr_spec_low (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_2.(pbase)) = ("granule_data")) /\ (((v_2.(poffset)) >= (0)))) /\ ((0 = ((v_2.(poffset)) mod (4096))))));
    rely ((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_granule_state)) = (GRANULE_STATE_RD)));
    when v_4, st == ((realm_ipa_size_spec v_2 st));
    let v__not := (v_4 >? (v_0)) in
    when v__sroa_0_0, st == (
        let v__sroa_0_0 := 0 in
        if v__not
        then (
          let v_8 := (ptr_offset v_2 ((416 * (0)) + ((408 + (0))))) in
          rely(408 = ((v_8.(poffset)) mod (4096))); (* Wihtout this rely, a pre-condition generated during load_RData is always False *)
          when v_9, st == ((load_RData 8 v_8 st));
          let v__not8 := (v_9 =? (0)) in
          when v__0_in, st == (
              let v__0_in := false in
              if v__not8
              then (
                when v_13, st == ((addr_is_level_aligned_spec v_0 v_1 st));
                let v__0_in := v_13 in
                (Some (v__0_in, st)))
              else (
                when v_11, st == ((s1addr_is_level_aligned_spec v_0 v_1 st));
                let v__0_in := v_11 in
                (Some (v__0_in, st))));
          when v__sroa_0_0, st == (
              let v__sroa_0_0 := 0 in
              if v__0_in
              then (
                when v_18, st == ((make_return_code_spec 0 0 st));
                let v__sroa_0_0 := v_18 in
                (Some (v__sroa_0_0, st)))
              else (
                when v_16, st == ((make_return_code_spec 1 0 st));
                let v__sroa_0_0 := v_16 in
                (Some (v__sroa_0_0, st))));
          (Some (v__sroa_0_0, st)))
        else (
          when v_6, st == ((make_return_code_spec 1 0 st));
          let v__sroa_0_0 := v_6 in
          (Some (v__sroa_0_0, st))));
    let __return__ := true in
    let __retval__ := v__sroa_0_0 in
    (Some (__retval__, st)).

End Layer9.

Section Layer10.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    "psci_reset_rec" ::
    "granule_refcount_read_acquire" ::
    (* "va_to_s1tte" :: *) (* not required *)
    (* "slot_to_s1tte" :: *) (* not required *)
    (* "rcsm_handle_realm_rsi" :: *)
    "timer_output_is_asserted" ::
    "gic_save_state" ::
    "save_sysreg_state" ::
    "restore_sysreg_state" ::
    (* "handle_exception_sync" :: *)
    (* "handle_excpetion_irq_lel" :: *)
    (* "mbedtls_memory_buffer_alloc_init" :: *)
    (* "psa_crypto_init" :: *)
    "realm_vtcr" ::
    "validate_data_create_unknown" ::
    "get_rd_state_locked" ::
    "stage2_tlbi_ipa" ::
    "bitmap_test_and_set" ::
    "validate_rmm_feature_register_0_value" ::
    "s2_inconsistent_sl" ::
    nil.
(* 
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
        ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (512)) / (4096))).(g_rec)).(e_sysregs)).(e_vmpidr_el2))))). *)

  Hint InitRely stage2_tlbi_ipa (v_0.(pbase) = "stack_s_realm_s2_context" /\ v_0.(poffset) = 0).

  Hint InitRely get_rd_state_locked (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely get_rd_state_locked ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).

  Hint InitRely validate_data_create_unknown (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely validate_data_create_unknown ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).

  Hint InitRely validate_data_create (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely validate_data_create ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).

  Hint InitRely realm_vtcr (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely realm_vtcr ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).

  Hint InitRely granule_refcount_read_acquire (v_0.(pbase) = "granules" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 16) = 0)).

  Hint InitRely psci_reset_rec (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely psci_reset_rec ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

End Layer10.

Section Layer11.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    (* "complete_psci_cpu_on" :: *)
    (* "complete_psci_affinity_info" :: *)
    (* "llvm_umul_with_overflow_i64" :: *)
    "verify_header" ::
    "bitmap_clear" ::
    (* "fake_buffer_unmap_no_tlbi" :: *)
    (* "fake_buffer_unmap" :: *)
    (* "fake_buffer_map" :: *)
    (* "atomic_load_add_release_64" :: *) (* move to bottom *)
    (* "rcsm_save_pico_state" :: *)
    (* "handle_pico_rec_exit" :: *)
    (* "rcsm_restore_pico_state" :: *)
    (* "memcpy_ns_write" :: *)
    "is_valid_vintid" ::
    "check_pending_timers" ::
    "report_timer_state_to_ns" ::
    "save_realm_state" ::
    "restore_ns_state" ::
    "save_ns_state" ::
    "restore_realm_state" ::
    (* "configure_realm_stage2" :: *)
    (* "handle_realm_exit" :: *)
    "reset_last_run_info" ::
    "esr_sign_extend" ::
    "esr_sixty_four" ::
    "__table_is_uniform_block" ::
    "__table_maps_block" ::
    (* "gic_init" :: *)
    (* "vmid_init" :: *)
    (* "crypto_init" :: *)
    (* "map_l3_ns" :: *)
    "init_common_sysregs" ::
    "init_rec_sysregs" ::
    "status_ptr" ::
    "validate_data_create" ::
    "s2tte_create_valid" ::
    (* "report_unexpected" :: *)
    "s2tte_is_valid_ns" ::
    "s2tte_create_valid_ns" ::
    (* "invalidate_block" :: *)
    "s2tte_is_destroyed" ::
    "validate_rtt_map_cmds" ::
    "addr_block_intersects_par" ::
    "invalidate_page" ::
    "vmid_reserve" ::
    "requested_ipa_bits" ::
    "s2_num_root_rtts" ::
    "validate_rmm_feature_register_value" ::
    "validate_ipa_bits_and_sl" ::
    "free_sl_rtts" ::
    (* "mbedtls_sha256_init" :: *)
    nil.

	
  Hint InitRely requested_ipa_bits (v_0.(pbase) = "stack_s_realm_params" /\ v_0.(poffset) = 0).
  Hint InitRely invalidate_page (v_0.(pbase) = "stack_s_realm_s2_context" /\ v_0.(poffset) = 0).
  Hint InitRely addr_block_intersects_par (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely addr_block_intersects_par ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  
  Hint InitRely validate_rtt_map_cmds (v_2.(pbase) = "granule_data" /\ (v_2.(poffset) >= 0) /\ ((v_2.(poffset) mod 4096) = 0)).
  Hint InitRely validate_rtt_map_cmds ((st.(share).(granule_data) @ (v_2.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  
  Hint InitRely init_rec_sysregs (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely init_rec_sysregs ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  
  Hint InitRely init_common_sysregs (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely init_common_sysregs (v_1.(pbase) = "granule_data" /\ (v_1.(poffset) >= 0) /\ ((v_1.(poffset) mod 4096) = 0)).
  Hint InitRely init_common_sysregs ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely init_common_sysregs ((st.(share).(granule_data) @ (v_1.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  
  Hint InitRely reset_last_run_info (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely reset_last_run_info ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  
  Hint InitRely restore_realm_state (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely restore_realm_state ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  
  Hint InitRely report_timer_state_to_ns (v_0.(pbase) = "stack_s_rec_exit" /\ v_0.(poffset) = 0).
  Hint InitRely check_pending_timers (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely check_pending_timers ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).

End Layer11.

Section Layer12.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    (* "complete_psci_request" :: *)
    (* "buffer_alloc_calloc_with_buf" :: *)
    (* "verify_chain" :: *)
    (* "buffer_alloc_free_with_buf" :: *)
    "vmid_free" ::
    "total_root_rtt_refcount" ::
    (* "fake_ns_granule_unmap_notlbi" :: *)
    (* "fake_ns_granule_unmap" :: *)
    "measurement_finish" ::
    (* "fake_ns_granule_map" :: *)
    "atomic_granule_put_release" ::
    (* "pico_rec_enter" :: *)
    "ns_buffer_write" ::
    "get_rd_state_unlocked" ::
    "copy_gic_state_from_ns" ::
    (* "rec_run_loop" :: *) (* moved to bottom *)
    "copy_gic_state_to_ns" ::
    "complete_sysreg_emulation" ::
    "complete_hvc_exit" ::
    "process_disposed_info" ::
    "complete_mmio_emulation" ::
    (* "read_idreg" :: *)
    "host_ns_s2tte_is_valid" ::
    (* "table_maps_valid_block" :: *) 
    (* "table_maps_valid_ns_block" :: *)
    (* "table_is_unassigned_block" :: *)
    (* "table_is_destroyed_block" :: *)
    "__granule_refcount_dec" ::
    (* "invalidate_pages_in_block" :: *)
    (* "table_maps_assigned_block" :: *)
    "s2tt_init_valid" ::
    "__granule_refcount_inc" ::
    "s2tt_init_valid_ns" ::
    "s2tt_init_destroyed" ::
    "validate_rtt_structure_cmds" ::
    "s2tt_init_assigned" ::
    (* "rmm_system_init" :: *)
    (* "map_mem0" :: *)
    (* "map_mem1" :: *)
    "get_cntfrq" ::
    "gic_cpu_state_init" ::
    "vmpidr_is_valid" ::
    "init_rec_regs" ::
    "get_rd_rec_count_locked" ::
    "find_lock_unused_granule" ::
    "ptr_is_err" ::
    "ptr_status" ::
    "data_create" ::
    (* "is_el2_data_abort_gpf" :: *)
    (* "is_el2_data_abort_for_os" :: *) (* return value type error *)
    (* "fatal_abort" :: *)
    "map_unmap_ns" ::
    "validate_rtt_entry_cmds" ::
    "host_ns_s2tte" ::
    (* "validate_ns_struct" :: *)
    "validate_realm_params" ::
    (* "find_lock_transition_rtts" :: *)
    (* "measurement_start" :: *)
    "get_realm_params" ::
    "set_rd_rec_count" ::
    nil.
  
  
  Definition validate_ns_struct_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((v_0 & (15)) =? (0))
    then (
      if (((v_0 & (18446744073709547520)) - (MEM1_PHYS)) >=? (0))
      then (
        if (((((v_0 + ((- 1))) + (v_1)) & (18446744073709547520)) - (MEM1_PHYS)) >=? (0))
        then (
          if (
            (((ptr_to_int (mkPtr "granules" ((((v_0 & (18446744073709547520)) + ((- MEM1_PHYS))) >> (524300)) * (16)))) -
              ((ptr_to_int (mkPtr "granules" ((((((v_0 + ((- 1))) + (v_1)) & (18446744073709547520)) + ((- MEM1_PHYS))) >> (524300)) * (16)))))) =?
              (0)))
          then (Some ((mkPtr "granules" ((((v_0 & (18446744073709547520)) + ((- MEM1_PHYS))) >> (524300)) * (16))), st))
          else (Some ((mkPtr "null" 0), st)))
        else (
          if (
            (ptr_eqb
              (mkPtr "granules" ((((v_0 & (18446744073709547520)) + ((- MEM1_PHYS))) >> (524300)) * (16)))
              (mkPtr "granules" ((((((v_0 + ((- 1))) + (v_1)) & (18446744073709547520)) + ((- MEM0_PHYS))) >> (12)) * (16)))))
          then (Some ((mkPtr "granules" ((((v_0 & (18446744073709547520)) + ((- MEM1_PHYS))) >> (524300)) * (16))), st))
          else (Some ((mkPtr "null" 0), st))))
      else (
        when v_12, st_1 == ((find_granule_spec_low (((v_0 + ((- 1))) + (v_1)) & (18446744073709547520)) st));
        rely ((((v_12.(pbase)) = ("granules")) \/ (((v_12.(pbase)) = ("null")))));
        if (ptr_eqb (mkPtr "granules" ((((v_0 & (18446744073709547520)) + ((- MEM0_PHYS))) >> (12)) * (16))) v_12)
        then (Some ((mkPtr "granules" ((((v_0 & (18446744073709547520)) + ((- MEM0_PHYS))) >> (12)) * (16))), st_1))
        else (Some ((mkPtr "null" 0), st_1))))
    else (Some ((mkPtr "null" 0), st)).

  Hint InitRely set_rd_rec_count (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely set_rd_rec_count ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
    
  Hint InitRely get_realm_params (v_0.(pbase) = "stack_s_realm_params" /\ v_0.(poffset) = 0).
  Hint InitRely validate_realm_params (v_0.(pbase) = "stack_s_realm_params" /\ v_0.(poffset) = 0).

  Hint InitRely validate_rtt_entry_cmds (v_2.(pbase) = "granule_data" /\ (v_2.(poffset) >= 0) /\ ((v_2.(poffset) mod 4096) = 0)).
  Hint InitRely validate_rtt_entry_cmds ((st.(share).(granule_data) @ (v_2.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  
  Hint InitRely data_create (v_3.(pbase) = "granules" /\ (v_3.(poffset) >= 0) /\ ((v_3.(poffset) mod 16) = 0)).

  Hint InitRely get_rd_rec_count_locked (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely get_rd_rec_count_locked ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  
  Definition s2tt_init_assigned_loop801_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z := 512.
  Hint InitRely s2tt_init_assigned (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0)).
  Hint InitRely s2tt_init_assigned ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_DATA).

  Hint InitRely validate_rtt_structure_cmds (v_2.(pbase) = "granule_data" /\ (v_2.(poffset) >= 0) /\ ((v_2.(poffset) mod 4096) = 0)).
  Hint InitRely validate_rtt_structure_cmds ((st.(share).(granule_data) @ (v_2.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  
  Definition rtt_walk_lock_unlock_loop467_rank (v_0: Ptr) (v_4: Z) (v_5: Z) (v_7: Ptr) (v_indvars_iv: Z) : Z := 512.
  Hint InitRely s2tt_init_destroyed (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0)).
  Hint InitRely s2tt_init_destroyed ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_DATA).

  Definition s2tt_init_valid_ns_loop839_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z := 512.
  Hint InitRely s2tt_init_valid_ns (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0)).
  Hint InitRely s2tt_init_valid_ns ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_DATA).

  Hint InitRely __granule_refcount_inc (v_0.(pbase) = "granules" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 16) = 0)).
  Hint InitRely __granule_refcount_dec (v_0.(pbase) = "granules" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 16) = 0)).
  
  Definition s2tt_init_valid_loop820_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z := 512.
  Hint InitRely s2tt_init_valid (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0)).
  Hint InitRely s2tt_init_valid ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_DATA).

  Hint InitRely complete_mmio_emulation (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely complete_mmio_emulation ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely complete_mmio_emulation (v_1.(pbase) = "stack_s_rec_entry" /\ (v_1.(poffset) = 0)).
  
  Hint InitRely process_disposed_info (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely process_disposed_info ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely process_disposed_info (v_1.(pbase) = "stack_s_rec_entry" /\ (v_1.(poffset) = 0)).
    
  Hint InitRely complete_hvc_exit (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely complete_hvc_exit ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely complete_hvc_exit (v_1.(pbase) = "stack_s_rec_entry" /\ (v_1.(poffset) = 0)).
      
  Hint InitRely complete_sysreg_emulation (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely complete_sysreg_emulation ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely complete_sysreg_emulation (v_1.(pbase) = "stack_s_rec_entry" /\ (v_1.(poffset) = 0)).
  
  Definition copy_gic_state_to_ns_loop59_rank (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z := v_wide_trip_count.
  Hint InitRely copy_gic_state_to_ns (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ (v_0.(poffset) mod 4096) = 584).
  Hint InitRely copy_gic_state_to_ns ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely copy_gic_state_to_ns (v_1.(pbase) = "stack_s_rec_exit" /\ (v_1.(poffset) = 0 )).
  
  Definition copy_gic_state_from_ns_loop48_rank (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z := v_wide_trip_count.
  Hint InitRely copy_gic_state_from_ns (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ (v_0.(poffset) mod 4096) = 584).
  Hint InitRely copy_gic_state_from_ns ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_REC).
  Hint InitRely copy_gic_state_from_ns (v_1.(pbase) = "stack_s_rec_entry" /\ (v_1.(poffset) = 0)).
 
  Hint InitRely get_rd_state_unlocked (v_0.(pbase) = "granule_data" /\ (v_0.(poffset) >= 0) /\ ((v_0.(poffset) mod 4096) = 0)).
  Hint InitRely get_rd_state_unlocked ((st.(share).(granule_data) @ (v_0.(poffset) / 4096)).(g_granule_state) = GRANULE_STATE_RD).
  
  Definition total_root_rtt_refcount_loop295_rank (v_0: Ptr) (v__011: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z := v_wide_trip_count.


End Layer12.

Section Layer13.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
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
    (* "smc_psci_complete" :: *)
    (* "buffer_alloc_calloc" :: *)
    (* "measurement_extend" :: *)
    (* "mbedtls_memory_buffer_alloc_verify" :: *)
    (* "handle_icc_el1_sysreg_trap" :: *)
    (* "buffer_alloc_free" :: *)
    "smc_realm_destroy" ::
    "stage1_tlbi_va" ::
    (* "smc_bench_ns_fake_unmap_notlbi" :: *)
    (* "measurement_update" :: *)
    (* "smc_bench_ns_fake_unmap" :: *)
    (* "assert_cpu_slots_empty" :: *)
    "smc_realm_activate" ::
    "stage1_tlbi_val" ::
    (* "smc_bench_ns_fake_map" :: *)
    (* "strcmp" :: *)
    (* "rcsm_rsi_log_error" :: *)
    "smc_rec_enter" ::
    (* "ns_granule_map" :: *)
    "smc_data_dispose" ::
    "smc_read_feature_register" ::
    (* "mbedtls_memory_buffer_set_verify" :: *)
    "smc_rtt_destroy" ::
    (* "system_rsi_abi_version" :: *)
    (* "smc_bench_validate_ns_struct" :: *)
    "smc_data_create" ::
    (* "handle_id_sysreg_trap" :: *)
    "smc_rtt_map_non_secure" ::
    "s2tte_create_destroyed" ::
    "smc_data_destroy" ::
    (* "buffer_unmap" :: *)
    (* "memcmp" :: *)
    "smc_rtt_fold" ::
    (* "memmove" :: *)
    "smc_system_interface_version" ::
    "smc_rtt_create" ::
    "smc_rtt_map_protected" ::
    (* "rmm_init" :: *)
    (* "handle_ns_smc" :: *)
    (* "smc_bench_latency" :: *)
    (* "smc_rec_create" :: *) (* doesn't work for now *)
    "s1tte_is_writable" ::
    "s2tte_addr_type_mask" ::
    "smc_rec_destroy" ::
    "smc_data_create_unknown" ::
    (* "handle_rmm_trap" :: *)
    "smc_rtt_unmap_non_secure" ::
    "data_granule_measure" ::
    "smc_rtt_read_entry" ::
    "smc_rtt_unmap_protected" ::
    (* "smc_bench_ns_map_unmap" :: *)
    "smc_realm_create" ::
    (* "mbedtls_memory_buffer_alloc_free" :: *)
    nil.

  Hint InitRely smc_read_feature_register (v_1.(pbase) = "stack_s_smc_result" /\ v_1.(poffset) = 0).
  Hint InitRely smc_rtt_read_entry (v_3.(pbase) = "stack_s_smc_result" /\ v_3.(poffset) = 0).

  Definition vmid_free_spec (v_0: Z) (st: RData) : (option RData) := (Some st).

  Hint NoUnfold free_sl_rtts_spec.


  Parameter test_Ptr_Z : (Ptr -> (Z)).
  Parameter wrap_180_para : (Z -> (RData -> (Z))).
  Hint NoUnfold validate_realm_params_spec.
  (* delegate zero *)
  (* Definition smc_realm_create_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely ((("granule_data" = ("granule_data")) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
    when v_7, st_2 == ((memcpy_ns_read_spec_state_oracle (mkPtr "stack_s_realm_params" 0) (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) 64 st));
    if v_7
    then (
      when v_9, st_5 == ((validate_realm_params_spec (mkPtr "stack_s_realm_params" 0) st_2));
      if (v_9 =? (0))
      then (
        when st1 == ((query_oracle st_5));
        rely (((((st1.(share)).(globals)).(g_granules)) = ((((st_5.(share)).(globals)).(g_granules)))));
        match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).(e_lock)).(e_val))) with
        | None =>
          if (
            (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
              (1)) =?
              (0)))
          then (
            rely (
              (((((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)) /\
                ((((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
            when st_4 == ((s2tt_init_unassigned_spec (mkPtr "granule_data" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) 1 st1));
            rely (((((st_4.(share)).(gpt)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))) = (true)));
            when st1_0 == (
                (query_oracle
                  (st_4.[share].[globals].[g_granules] :<
                    ((((st_4.(share)).(globals)).(g_granules)) #
                      (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                      (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                        5)))));
            rely (
              ((((st1_0.(share)).(globals)).(g_granules)) =
                (((((st_4.(share)).(globals)).(g_granules)) #
                  (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                  (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                    5)))));
            match (((((((st1_0.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_lock)).(e_val))) with
            | None =>
              if (((((((st1_0.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
              then (
                rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                rely (((((((st1_0.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                (Some (
                  0  ,
                  (st1_0.[share].[globals].[g_granules] :<
                    ((((st1_0.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                      ((((((st1_0.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID)).[e_state_s_granule] :< 2)))
                )))
              else (
                if ((0 - ((((st1_0.(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts)))) <? (0))
                then (
                  when st1_1 == ((query_oracle st1_0));
                  rely (((((st1_1.(share)).(globals)).(g_granules)) @ ((((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)))).(e_state_s_granule) = 1);
                  rely (
                    ((((st1_1.(share)).(globals)).(g_granules)) =
                      (((((st1_0.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                        (((((st1_0.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< None)))));
                  match (((((((st1_1.(share)).(globals)).(g_granules)) @ (((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).(e_lock)).(e_val))) with
                  | None =>
                    if (
                      (((((((st1_1.(share)).(globals)).(g_granules)) @ (((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                        (5)) =?
                        (0)))
                    then (
                      rely (
                        ((("granules" = ("granules")) /\ (((((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          ((((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
                      rely (((((st1_1.(share)).(gpt)) @ (((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))) = (true)));
                      (Some (
                        (pack_struct_return_code_para (make_return_code_para 1))  ,
                        (st1_1.[share].[globals].[g_granules] :<
                          ((((st1_1.(share)).(globals)).(g_granules)) #
                            (((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                            ((((((st1_1.(share)).(globals)).(g_granules)) @ (((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :<
                              (Some CPU_ID)).[e_state_s_granule] :<
                              1)))
                      )))
                    else (
                      rely (((((st1_1.(share)).(gpt)) @ (((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))) = (true)));
                      rely (
                        ((("granules" = ("granules")) /\ (((((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          ((((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
                      (Some (
                        (pack_struct_return_code_para (make_return_code_para 1))  ,
                        (st1_1.[share].[globals].[g_granules] :<
                          ((((st1_1.(share)).(globals)).(g_granules)) #
                            (((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                            ((((((st1_1.(share)).(globals)).(g_granules)) @ (((test_PA (((st1_0.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :<
                              None).[e_state_s_granule] :<
                              1)))
                      )))
                  | (Some cid) => None
                  end)
                else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1_0)))
            | (Some cid) => None
            end)
          else (Some ((pack_struct_return_code_para 1), st1))
        | (Some cid) => None
        end)
      else (Some (v_9, st_5)))
    else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2)). *)
(*   
  Definition smc_realm_create_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_7, st_2 == ((memcpy_ns_read_spec (mkPtr "stack_s_realm_params" 0) (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) 64 st));
    if v_7
    then (
      when v_9, st_5 == ((validate_realm_params_spec (mkPtr "stack_s_realm_params" 0) st_2));
      if (v_9 =? (0))
      then (
        when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_5));
        if (
          (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
            (1)) =?
            (0)))
        then (
          rely (
            (((((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)) /\
              ((((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
          when st_4 == ((s2tt_init_unassigned_spec (mkPtr "granule_data" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) 1 st_1));
          rely ((st_4.(share).(gpt) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))) = true);
          when st_3 == (
              (granule_unlock_spec
                (mkPtr "granules" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)))
                (st_4.[share].[globals].[g_granules] :<
                  ((((st_4.(share)).(globals)).(g_granules)) #
                    (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                    (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                      5)))));
          when st_6 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
          if (((((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
          then (
            rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
            rely (((((((st_6.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
            when st_7 == (
                (granule_unlock_spec
                  (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                  (st_6.[share].[globals].[g_granules] :<
                    ((((st_6.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                      (((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 2)))));
            (Some (0, st_7)))
          else (
            when st_7 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_6));
            if ((0 - ((((st_7.(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts)))) <? (0))
            then (
              when st_8 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_7));
              if (
                (((((((st_8.(share)).(globals)).(g_granules)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                rely (
                  ((("granules" = ("granules")) /\ (((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)))) /\
                    ((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
                  rely ((st_8.(share).(gpt) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))) = true);
                  when st_9 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)))
                      (st_8.[share].[globals].[g_granules] :<
                        ((((st_8.(share)).(globals)).(g_granules)) #
                          (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                          (((((st_8.(share)).(globals)).(g_granules)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                            1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9)))
              else (
                when st_9 == ((spinlock_release_spec (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_8));
                rely ((st_9.(share).(gpt) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))) = true);
                rely (
                  ((("granules" = ("granules")) /\ (((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)))) /\
                    ((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
                when st_10 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)))
                      (st_9.[share].[globals].[g_granules] :<
                        ((((st_9.(share)).(globals)).(g_granules)) #
                          (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                          (((((st_9.(share)).(globals)).(g_granules)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                            1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_10))))
            else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7))))
        else (
          when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_1));
          (Some ((pack_struct_return_code_para 1), st_3))))
      else (Some (v_9, st_5)))
    else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2)). *)
  
  Definition smc_realm_create_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_7, st_2 == ((memcpy_ns_read_spec (mkPtr "stack_s_realm_params" 0) (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) 64 st));
    if v_7
    then (
      when v_9, st_5 == ((validate_realm_params_spec (mkPtr "stack_s_realm_params" 0) st_2));
      if (v_9 =? (0))
      then (
        when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_5));
        if (
          (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
            (1)) =?
            (0)))
        then (
          rely (
            (((((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)) /\
              ((((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
          when st_4 == ((s2tt_init_unassigned_spec (mkPtr "granule_data" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) 1 st_1));
          when st_3 == (
              (granule_unlock_spec
                (mkPtr "granules" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)))
                (st_4.[share].[globals].[g_granules] :<
                  ((((st_4.(share)).(globals)).(g_granules)) #
                    (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                    (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                      5)))));
          when st_6 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
          if (((((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
          then (
            rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
            rely (((((((st_6.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
            when st_7 == (
                (granule_unlock_spec
                  (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                  ((st_6.[share].[globals].[g_granules] :<
                    ((((st_6.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                      (((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 2))).[share].[granule_data] :<
                    (((st_6.(share)).(granule_data)) #
                      (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                      ((((st_6.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                        ((((((((((((((((st_6.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) # (((test_PA v_0).(meta_granule_offset)) mod (4096)) == 0) #
                          ((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) ==
                          0) #
                          ((((test_PA v_0).(meta_granule_offset)) + (48)) mod (4096)) ==
                          (((st_6.(stack)).(stack_s_realm_params)).(e_par_base))) #
                          ((((test_PA v_0).(meta_granule_offset)) + (56)) mod (4096)) ==
                          (((st_6.(stack)).(stack_s_realm_params)).(e_par_size))) #
                          ((((test_PA v_0).(meta_granule_offset)) + (64)) mod (4096)) ==
                          ((((st_6.(stack)).(stack_s_realm_params)).(e_par_base)) + ((((st_6.(stack)).(stack_s_realm_params)).(e_par_size))))) #
                          ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)) ==
                          (test_Ptr_Z (mkPtr "granules" ((test_PA (((st_6.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))))) #
                          ((((test_PA v_0).(meta_granule_offset)) + (16)) mod (4096)) ==
                          (((st_6.(stack)).(stack_s_realm_params)).(e_realm_feat_0))) #
                          ((((test_PA v_0).(meta_granule_offset)) + (20)) mod (4096)) ==
                          (((st_6.(stack)).(stack_s_realm_params)).(e_s2_starting_level_s_realm_params))) #
                          ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                          (((st_6.(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts))) #
                          ((((test_PA v_0).(meta_granule_offset)) + (40)) mod (4096)) ==
                          (((st_6.(stack)).(stack_s_realm_params)).(e_vmid_s_realm_params))) #
                          ((((test_PA v_0).(meta_granule_offset)) + (408)) mod (4096)) ==
                          (((st_6.(stack)).(stack_s_realm_params)).(e_is_rc))) #
                          ((((test_PA v_0).(meta_granule_offset)) + (180)) mod (4096)) ==
                          (wrap_180_para
                            (((st_6.(stack)).(stack_s_realm_params)).(e_measurement_algo))
                            (st_6.[share].[granule_data] :<
                              (((st_6.(share)).(granule_data)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                ((((st_6.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  (((((((((((((((st_6.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) # (((test_PA v_0).(meta_granule_offset)) mod (4096)) == 0) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) ==
                                    0) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (48)) mod (4096)) ==
                                    (((st_6.(stack)).(stack_s_realm_params)).(e_par_base))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (56)) mod (4096)) ==
                                    (((st_6.(stack)).(stack_s_realm_params)).(e_par_size))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (64)) mod (4096)) ==
                                    ((((st_6.(stack)).(stack_s_realm_params)).(e_par_base)) + ((((st_6.(stack)).(stack_s_realm_params)).(e_par_size))))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)) ==
                                    (test_Ptr_Z (mkPtr "granules" ((test_PA (((st_6.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (16)) mod (4096)) ==
                                    (((st_6.(stack)).(stack_s_realm_params)).(e_realm_feat_0))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (20)) mod (4096)) ==
                                    (((st_6.(stack)).(stack_s_realm_params)).(e_s2_starting_level_s_realm_params))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                                    (((st_6.(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (40)) mod (4096)) ==
                                    (((st_6.(stack)).(stack_s_realm_params)).(e_vmid_s_realm_params))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (408)) mod (4096)) ==
                                    (((st_6.(stack)).(stack_s_realm_params)).(e_is_rc)))))))))))));
            (Some (0, st_7)))
          else (
            when st_7 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_6));
            if ((0 - ((((st_7.(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts)))) <? (0))
            then (
              when st_8 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_7));
              if (
                (((((((st_8.(share)).(globals)).(g_granules)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                rely (
                  ((("granules" = ("granules")) /\ (((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)))) /\
                    ((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
                when st_9 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)))
                      (st_8.[share].[globals].[g_granules] :<
                        ((((st_8.(share)).(globals)).(g_granules)) #
                          (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                          (((((st_8.(share)).(globals)).(g_granules)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                            1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9)))
              else (
                when st_9 == ((spinlock_release_spec (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_8));
                rely (
                  ((("granules" = ("granules")) /\ (((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)))) /\
                    ((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
                when st_10 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)))
                      (st_9.[share].[globals].[g_granules] :<
                        ((((st_9.(share)).(globals)).(g_granules)) #
                          (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                          (((((st_9.(share)).(globals)).(g_granules)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                            1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_10))))
            else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7))))
        else (
          when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_1));
          (Some ((pack_struct_return_code_para 1), st_3))))
      else (Some (v_9, st_5)))
    else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2)).
 
  (* Definition smc_realm_destroy_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (2)) =? (0))
    then (
      if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1) =? (0))
      then (
        rely (((("granule_data" = ("granule_data")) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))));
        when st_6 == (
            (vmid_free_spec
              (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (40)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (40)) mod (4096)))
              st_1));
        if (
          ((total_root_rtt_refcount_para
            (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)))
            (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)))
            st_6) =?
            (0)))
        then (
          when st_8 == (
              (free_sl_rtts_spec
                (test_Z_Ptr
                  (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096))))
                (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)))
                true
                st_6));
          when v_4, st_2 == ((memset_spec (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) 0 4096 st_8));
          when st_3 == (
              (granule_unlock_spec
                (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                (st_2.[share].[globals].[g_granules] :<
                  ((((st_2.(share)).(globals)).(g_granules)) #
                    (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                    (((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))));
          (Some (0, st_3)))
        else (
          when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_6));
          (Some ((pack_struct_return_code_para (make_return_code_para 4)), st_8))))
      else (
        when st_2 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))). *)

  Definition smc_rec_destroy_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (3)) =? (0))
    then (
      if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1) =? (0))
      then (
        when v_2, st_2 == ((memset_spec (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) 0 4096 st_1));
        rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod(4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        when st_3 == (
            (granule_unlock_spec
              (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
              (st_2.[share].[globals].[g_granules] :<
                ((((st_2.(share)).(globals)).(g_granules)) #
                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                  (((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))));
        rely (
          (((((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(pbase)) = ("granules")) /\
            (((((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) mod(4096)) = (0)))) /\
            ((((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) >= (0)))));
        (Some (
          0  ,
          (st_3.[share].[globals].[g_granules] :<
            ((((st_3.(share)).(globals)).(g_granules)) #
              (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (4096)) ==
              (((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (4096))).[e_ref] :<
                ((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                  (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                    ((- 1)))))))
        )))
      else (
        when st_2 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).



  Definition buffer_map_spec' (v_0: Z) (v_1: Z) (v_2: bool) : (option Ptr) :=
    rely (
      (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - (4294967296)) < (0)))) /\ (((v_1 & (549755813888)) = (0)))) \/
        (((((v_1 - (MEM1_PHYS)) >= (0)) /\ (((v_1 - (556198264832)) < (0)))) /\ (((v_1 & (549755813888)) = (1)))))));
    if ((v_1 & (549755813888)) =? (0))
    then (Some (mkPtr "granule_data" ((- 2147483648) + (v_1))))
    else (Some (mkPtr "granule_data" ((- 549755813888) + (v_1)))).
  
  Definition granule_addr_spec' (v_0: Ptr) : (option Z) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    if ((v_0.(poffset)) >? (8388592))
    then (Some (((v_0.(poffset)) * (256)) + (549755813888)))
    else (Some (((v_0.(poffset)) * (256)) + (2147483648))).

  (* Definition smc_realm_activate_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    match ((((((st.(share).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
    | None =>
      rely (
        (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
          (((((st.(share).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
          (0)));
      if ((((((st.(share).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
      then (
        when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
        when ret_0 == ((buffer_map_spec' 2 ret false));
        rely ((((((st.(share).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
        rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
        if (((((st.(share).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_state_s_rd)) =? (0))
        then (
          (Some (
            0  ,
            ((st.[log] :<
              ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((st.(share).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
              (((st.(share)).[globals].[g_granules] :<
                (((st.(share).(globals)).(g_granules)) #
                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                  ((((st.(share).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))).[granule_data] :<
                ((st.(share).(granule_data)) #
                  ((ret_0.(poffset)) / (4096)) ==
                  (((st.(share).(granule_data)) @ ((ret_0.(poffset)) / (4096))).[g_norm] :<
                    ((((st.(share).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_norm)) # ((ret_0.(poffset)) mod (4096)) == 1)))))
          )))
        else (
          (Some (
            5  ,
            ((st.[log] :<
              ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((st.(share).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
              ((st.(share)).[globals].[g_granules] :<
                (((st.(share).(globals)).(g_granules)) #
                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                  ((((st.(share).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))
          ))))
      else (
        (Some (
          4294967553  ,
          ((st.[log] :<
            ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((st.(share).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
            ((st.(share)).[globals].[g_granules] :<
              (((st.(share).(globals)).(g_granules)) #
                ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                ((((st.(share).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))
        )))
    | (Some cid) => None. *)
    (* Definition smc_realm_activate_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
      when st1 == ((query_oracle st));
      rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
      match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
      | None =>
        if (
          ((((((((st1.(share)).(globals)).(g_granules)) #
            (((test_PA v_0).(meta_granule_offset)) / (16)) ==
            (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
            (2)) =?
            (0)))
        then (
          rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
          rely (((((((st1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          if ((((((st1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_rd)).(e_state_s_rd)) =? (0))
          then (
            (Some (
              0  ,
              (st1.[share].[granule_data] :<
                (((st1.(share)).(granule_data)) #
                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                  ((((st1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                    (((((st1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) # (((test_PA v_0).(meta_granule_offset)) mod (4096)) == 1))))
            )))
          else (
            (Some (
              (pack_struct_return_code_para (make_return_code_para 5))  ,
              (st1.[share].[globals].[g_granules] :<
                ((((st1.(share)).(globals)).(g_granules)) #
                  (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                  (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))
            ))))
        else (
          (Some (
            (pack_struct_return_code_para (make_return_code_para 1))  ,
            (st1.[share].[globals].[g_granules] :<
              ((((st1.(share)).(globals)).(g_granules)) #
                (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< None)))
          )))
      | (Some cid) => None
      end. *)
      Definition smc_realm_destroy_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
        when st1 == ((query_oracle st));
        rely (((((st1.(share)).(gpt)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))) = (true)));
        rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
        match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_lock)).(e_val))) with
        | None =>
          if (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (2)) =? (0))
          then (
            if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st1) =? (0))
            then (
              rely (((("granule_data" = ("granule_data")) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))));
              if (
                ((total_root_rtt_refcount_para
                  (((((st1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)))
                  (((((st1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)))
                  st1) =?
                  (0)))
              then (
                (* when st_8 == (
                    (free_sl_rtts_spec
                      (test_Z_Ptr
                        (((((st1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096))))
                      (((((st1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)))
                      true
                      st1)); *)
                (Some (
                  0  ,
                  ((st1.[share].[globals].[g_granules] :<
                    ((((st1.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                      (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                    (((st1.(share)).(granule_data)) #
                      (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                      ((((st1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                )))
              else (Some ((pack_struct_return_code_para (make_return_code_para 4)), st1)))
            else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1)))
          else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1))
        | (Some cid) => None
        end.
  (* Definition smc_realm_destroy_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when st1 == ((query_oracle st));
    rely (st1.(share).(gpt) @ ((test_PA v_0).(meta_granule_offset) / 4096) = true);
    rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
    match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_lock)).(e_val))) with
    | None =>
      if (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (2)) =? (0))
      then (
        if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st1) =? (0))
        then (
          rely (((("granule_data" = ("granule_data")) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))));
          if (
            ((total_root_rtt_refcount_para
              (((((st1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)))
              (((((st1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)))
              st1) =?
              (0)))
          then (
            when st_8 == (
                (free_sl_rtts_spec
                  (test_Z_Ptr
                    (((((st1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096))))
                  (((((st1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)))
                  true
                  st1));
            when v_4, st_2 == ((memset_spec (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) 0 4096 st1));
            (Some (
              0  ,
              (st_2.[share].[globals].[g_granules] :<
                ((((st_2.(share)).(globals)).(g_granules)) #
                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                  (((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
            )))
          else (Some ((pack_struct_return_code_para (make_return_code_para 4)), st1)))
        else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1)))
      else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st1))
    | (Some cid) => None
    end. *)
    (* Definition smc_realm_activate_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (2)) =? (0))
      then (
        rely ((((((test_PA v_0).(meta_granule_offset)) mod(4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        rely (((("granule_data" = ("granule_data")) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))));
        rely (((((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
        if ((((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_rd)).(e_state_s_rd)) =? (0))
        then (
          when st_6 == (
              (granule_unlock_spec
                (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                (st_1.[share].[granule_data] :<
                  (((st_1.(share)).(granule_data)) #
                    (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                    ((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                      (((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) # (((test_PA v_0).(meta_granule_offset)) mod (4096)) == 1))))));
          (Some (0, st_6)))
        else (
          when st_5 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
          (Some ((pack_struct_return_code_para (make_return_code_para 5)), st_5))))
      else (
        when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))). *)
  
End Layer13.


(* rtt-related params *)
Parameter rtt_is_root : (Z -> (bool)).
Parameter rtt_walk_abs : (RData -> (Z -> (Z -> (Z)))).


Section Invariants.


(* Definition delegated_zero (st : RData) : Prop :=
  forall (gidx: Z) (Hdel: ((st.(share).(granule_data) @ gidx).(g_granule_state) = GRANULE_STATE_DELEGATED)),
    ((st.(share).(granule_data) @ gidx).(g_norm) = zero_granule_data). *)

(* Definition delegated_zero (st : RData) : Prop :=
  forall (gidx: Z) 
  (Hdel: ((st.(share).(globals).(g_granules) @ gidx).(e_state_s_granule) = GRANULE_STATE_DELEGATED)),
    ((st.(share).(granule_data) @ gidx).(g_norm) = zero_granule_data). *)

(* Definition gpt_false_ns (st: RData) : Prop := 
  forall (gidx : Z) 
  (Hgpt: ((st.(share).(gpt) @ gidx) = false)), 
    (((st.(share).(globals).(g_granules) @ gidx).(e_state_s_granule) = GRANULE_STATE_NS) \/ 
    ((st.(share).(globals).(g_granules) @ gidx).(e_state_s_granule) = GRANULE_STATE_ANY)). *)

Definition rtt_map_data (st: RData) : Prop := 
   forall (rtt_gidx : Z) (ipa_gidx : Z) (data_gidx : Z) 
    (Hrtt_root : rtt_is_root rtt_gidx = true)
    (Hrtt_is_map : ((rtt_walk_abs st rtt_gidx ipa_gidx) <> (-1)))
    (Hrtt_state : (st.(share).(globals).(g_granules) @ rtt_gidx).(e_state_s_granule) = GRANULE_STATE_RTT),
    (((st.(share).(granule_data) @ (rtt_walk_abs st rtt_gidx ipa_gidx)).(g_granule_state) = GRANULE_STATE_DATA) \/ 
     ((st.(share).(granule_data) @ (rtt_walk_abs st rtt_gidx ipa_gidx)).(g_granule_state) = GRANULE_STATE_ANY)).


End Invariants.


Section Lemmas.
  
(* Definition query_oracle_security_zero (st: RData) : Prop :=
  match (st.(repl) (st.(oracle) (st.(log))) (st.(share))) with 
  | Some sh => 
      ((delegated_zero st) -> (delegated_zero ((st.[log] :< ((st.(oracle) (st.(log))) ++ st.(log))).[share] :< sh)))
  end. *)
(* Definition query_oracle_security_gpt (st: RData) : Prop :=
  match (st.(repl) (st.(oracle) (st.(log))) (st.(share))) with 
  | Some sh => 
      ((gpt_false_ns st) -> (gpt_false_ns ((st.[log] :< ((st.(oracle) (st.(log))) ++ st.(log))).[share] :< sh)))
  end. *)
Definition query_oracle_security_rtt_map_data (st: RData) : Prop :=
  match (st.(repl) (st.(oracle) (st.(log))) (st.(share))) with 
  | Some sh => 
      ((rtt_map_data st) -> (rtt_map_data ((st.[log] :< ((st.(oracle) (st.(log))) ++ st.(log))).[share] :< sh)))
  end.

(* Definition gpt_false_check (st: RData) : Prop :=
  forall (v_0 : Z), 
    (st.(share).(gpt) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) = true). *)

Definition rtt_walk_abs_eq_cond_1 (st : RData) : Prop := 
  forall (rtt_gidx : Z) (ipa_gidx : Z) (i : Z) (d: r_granule_data) 
  (Hirrelevant: ((st.(share).(globals).(g_granules) @ i).(e_state_s_granule) <> GRANULE_STATE_RTT) /\ ((st.(share).(globals).(g_granules) @ i).(e_state_s_granule) <> GRANULE_STATE_DATA)),
    (rtt_walk_abs st rtt_gidx ipa_gidx = rtt_walk_abs (st.[share].[granule_data] :< (st.(share).(granule_data) # (i) == d)) rtt_gidx ipa_gidx).


(* Should not use this as lemma *)
(* Definition rtt_walk_abs_eq_cond_2 (st : RData) : Prop := 
  forall (rtt_gidx : Z) (ipa_gidx : Z) (i : Z) (d: s_granule) 
  (Hirrelevant: ((st.(share).(globals).(g_granules) @ i).(e_state_s_granule) <> GRANULE_STATE_RTT) /\ ((st.(share).(globals).(g_granules) @ i).(e_state_s_granule) <> GRANULE_STATE_DATA)),
  (rtt_walk_abs st rtt_gidx ipa_gidx = rtt_walk_abs (st.[share].[globals].[g_granules] :< (st.(share).(globals).(g_granules) # (i) == d)) rtt_gidx ipa_gidx). *)

Definition delegated_zero (st : RData) : Prop :=
  forall (gidx: Z) 
  (Hdel: ((st.(share).(globals).(g_granules) @ gidx).(e_state_s_granule) = GRANULE_STATE_DELEGATED)),
    ((st.(share).(granule_data) @ gidx).(g_norm) = zero_granule_data).
  
(* make a pattern-matching check: if we clear, the updated st still maintains inv *)
Definition rtt_map_data_ind_cond_1 (st: RData) : Prop :=
  (forall (offset : Z) (empty_pte : abs_PTE_t), 
    (((st.(share).(globals).(g_granules) @ (offset / 4096)).(e_state_s_granule) = GRANULE_STATE_RTT) ->
    (empty_pte.(meta_PA).(meta_granule_offset) = (-1)) ->
    (rtt_map_data st) ->
    (rtt_map_data (st.[share].[granule_data] :<
    (((st.(share)).(granule_data)) #
      (offset / (4096)) ==
      ((((st.(share)).(granule_data)) @ (offset / (4096))).[g_norm] :<
        (((((st.(share)).(granule_data)) @ (offset / (4096))).(g_norm)) # (offset mod (4096)) == (test_PTE_Z empty_pte)))))))
    ).

(* clear 2: memset *)
Definition rtt_map_data_ind_cond_2 (st: RData) : Prop := 
  (forall (offset : Z) (state : Z), 
    ((rtt_map_data st) -> 
     (rtt_map_data ((st.[share].[globals].[g_granules] :<
     ((st.(share).(globals).(g_granules)) # (offset) ==
       (((((st.(share)).(globals)).(g_granules)) @ offset).[e_state_s_granule] :< state))).[share].[granule_data] :<
     (((st.(share)).(granule_data)) # (offset) ==
       ((((st.(share)).(granule_data)) @ (offset)).[g_norm] :< zero_granule_data))))
     )).


(* update entry *)
Definition rtt_map_data_ind_cond_3 (st: RData) : Prop :=
  (forall (parent_gidx : Z) (pte_z : Z) (x : Z) (y: Z) (z : Z), 
    ((rtt_map_data st) -> 
     (* ((st.(share).(globals).(g_granules) @ (parent_gidx / 4096)).(e_state_s_granule) = GRANULE_STATE_RTT) -> *)
     (rtt_map_data ((st.[share].[globals].[g_granules] :<
                  ((((st.(share)).(globals)).(g_granules)) #
                    ((((test_Z_PTE pte_z).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                    (((((st.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE pte_z).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                  (((st.(share)).(granule_data)) # (parent_gidx / (4096)) ==
                    ((((st.(share)).(granule_data)) @ (parent_gidx / (4096))).[g_norm] :<
                      (((((st.(share)).(granule_data)) @ (parent_gidx / (4096))).(g_norm)) #
                        (parent_gidx mod (4096)) ==
                        (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE pte_z).(meta_PA)) x y z)))))))
     )).

Definition rtt_map_data_ind_cond_4 (st: RData) : Prop :=
  (forall (offset : Z),
    ((rtt_map_data st) -> 
      ((st.(share).(granule_data) @ (offset)).(g_norm) = zero_granule_data) ->
      (rtt_map_data (st.[share].[globals].[g_granules] :<
      ((st.(share).(globals).(g_granules)) # (offset) ==
        (((((st.(share)).(globals)).(g_granules)) @ offset).[e_state_s_granule] :< 4))))
    )).
End Lemmas.

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

