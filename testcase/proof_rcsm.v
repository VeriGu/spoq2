Definition PROJ_NAME: string := "working".
Definition PROJ_BASE: string := "coq/working".

Parameter CPU_ID: Z.

(* Hint NoHighSpec true. *)

(* Hint OnlyTrans ns_buffer_unmap. *)
(* Hint OnlyTrans ns_buffer_read. *)
(* Hint OnlyTrans s2tte_create_table. *)
(* Hint OnlyTrans s2tt_init_unassigned. *)
(* Hint OnlyTrans stage1_tlbi_all. *)
Hint OnlyTrans __find_lock_next_level.
(* Hint OnlyTrans s2tte_is_unassigned. *)

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
  (* e_val : option Z *)
  (* for now, we use Z to align with the definition *)
  e_val : Z
}. 

Definition load_s_spinlock_t (sz: Z) (ofs:Z)  (st: s_spinlock_t) : option Z := 
  if (ofs =? 0) then Some (st.(e_val)) else
  None.

Definition store_s_spinlock_t (sz: Z) (ofs:Z) (v:Z)  (st: s_spinlock_t) : option s_spinlock_t := 
  if (ofs =? 0) then Some (st.[e_val] :< v) else
  None.


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
    e_s_anon_1_2_3 : Z}.

Definition load_s_anon_1_2 (sz: Z) (ofs:Z)  (st: s_anon_1_2) : option Z := 
  if (ofs =? 0) then Some (st.(e_s_anon_1_2_0)) else
  if (ofs =? 8) then Some (st.(e_s_anon_1_2_1)) else
  if (ofs =? 16) then Some (st.(e_s_anon_1_2_2)) else
  if (ofs =? 24) then Some (st.(e_s_anon_1_2_3)) else
  None.

Definition store_s_anon_1_2 (sz: Z) (ofs:Z) (v:Z)  (st: s_anon_1_2) : option s_anon_1_2 := 
  if (ofs =? 0) then Some (st.[e_s_anon_1_2_0] :< v) else
  if (ofs =? 8) then Some (st.[e_s_anon_1_2_1] :< v) else
  if (ofs =? 16) then Some (st.[e_s_anon_1_2_2] :< v) else
  if (ofs =? 24) then Some (st.[e_s_anon_1_2_3] :< v) else
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
  if (ofs =? 0) then Some (st.(e_g_ttbr0)) else
  if (ofs =? 8) then Some (st.(e_g_ttbr1)) else
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
  if (ofs =? 0) then Some (st.(e_g_llt)) else
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
  if (ofs =? 16) then Some (st.(e_g_rtt)) else
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

Definition GRANULE_SIZE : Z := 4096.

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
      g_rec: s_rec;

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
      pcpu_gpregs: GPRegs;
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
      g_realm_attest_private_key: (ZMap.t Z);
    }.


Record Shared :=
  mkShared {
      (* glk: ZMap.t (option Z); *)
      (* gpt: ZMap.t bool; gidx -> PAS *)

      granule_data: ZMap.t r_granule_data;

      globals: GLOBALS;
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

Definition MEM0_PHYS : Z := 2147483648.
Definition MEM1_PHYS : Z := 551903297536.
Definition MEM0_VIRT : Z := 18446744007137558528.
Definition MEM1_VIRT : Z := 18446744009285042176.
Definition MEM0_SIZE : Z := 2147483648.
Definition MEM1_SIZE : Z := 4294967296.
Definition NR_GRANULES : Z := 1572864. (*  (MEM0_SIZE + MEM1_SIZE) / GRANULE_SIZE *)



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
    if (v >=? (MAX_ERR)) then (mkPtr "status" (v - (MAX_ERR))) else
    if (v >=? MEM1_VIRT) then (
      mkPtr "granule_data" (v - MEM1_VIRT + MEM0_SIZE)
    ) else
    if (v >=? MEM0_VIRT) then (
      mkPtr "granule_data" (v - MEM0_VIRT)
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


Section Bottom.
  Definition LAYER_DATA := RData.
  Definition LAYER_NEW_FRAME : string := "new_frame".  
  Definition LAYER_CODE : string := "./rmm-opt.linked.ir2json.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PRIMS: list string :=
    "attest_get_platform_token" ::
    "__sca_read64" :: 
    nil.
  Definition attest_get_platform_token_spec (st: RData) : option (Z * RData) := Some (0, st).
  Definition __sca_read64_spec (ptr: Ptr) (st: RData) : option (Z * RData) := load_RData 64 ptr st.
  Definition __sca_read64_acquire_spec (ptr: Ptr) (st: RData) : option (Z * RData) := load_RData 64 ptr st.
  Definition __sca_write64_spec (ptr: Ptr) (val: Z) (st: RData) : option RData := store_RData 64 ptr val st.
  Definition __sca_write64_release_spec (v_state1: Ptr) (v_state: Z) (st: RData) : option RData := store_RData 64 v_state1 v_state st.

  Definition iasm_10_spec (st: RData) : option RData :=
    Some st.
    
  Definition iasm_12_isb_spec (st: RData) : option RData :=
    Some st.
      
  Definition iasm_258_spec (st: RData) : option RData :=
    Some st.
  
    (* TODO: printf_spec *)

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
  Definition spinlock_release_spec (lock: Ptr) (st: RData) : option RData := Some st.
  (* if lock.(pbase) =s "granules" then
    let ofs := lock.(poffset) in
    let gidx_l := ofs / ST_GRANULE_SIZE in
    let g := (st.(globals).(g_granules) @ gidx_l) in
    match g.(e_lock) with
    | Some cid =>
        let e := EVT CPU_ID (REL gidx_l g) in
        let new_granules := (st.(globals).(g_granules)) # gidx_l == (g.[e_lock] :< None) in
        let new_st := st.[globals].[g_granules] :< new_granules in
        Some (new_st.[log] :< (e :: new_st.(log)))
    | None => None
    end
  else None. *)
  Definition spinlock_acquire_spec (lock: Ptr) (st: RData) : option RData := Some st.

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
    nil.

  (* todo: move them to other places *)
  Definition atomic_add_64_spec (loc: Ptr) (val: Z) (st: RData) : option RData :=
    when v, st == load_RData 64 loc st;
    when st == store_RData 64 loc (v + val) st;
    Some st.

  Definition cpuid_spec (st: RData) : option (Z * RData) := Some (CPU_ID, st). (* TODO: CPUID *)

  Definition find_granule_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    if (v_0 >=? (MEM1_PHYS))
    then (
      let mem1_id := ((v_0 + (-MEM1_PHYS)) >> (12) + (524288)) in
      Some ((mkPtr "granules" (mem1_id * 16)), st)
    ) else (
      let mem0_id := ((v_0 + (-MEM0_PHYS)) >> (12)) in
      Some ((mkPtr "granules" (mem0_id * 16)), st)
    ).
  Hint PostEnsure __find_next_level_idx (v_0.(pbase) = "granules").
  Hint PostEnsure __find_next_level_idx (v_0.(poffset) mod 16 = 0).
  Hint PostEnsure __find_next_level_idx (v_0.(poffset) >= 0).
  Hint InitRely find_granule (((v_0 >= MEM0_PHYS /\ v_0 < MEM0_PHYS + MEM0_SIZE) \/ (v_0 >= MEM1_PHYS /\ v_0 < MEM1_PHYS + MEM1_SIZE)) /\ (v_0 & 4095 = 0)). 
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
    (* "sort_granules" :: *)
    "s2tte_create_unassigned" ::
    nil.
  
  Parameter llvm_memset_p0i8_i64_spec_state_oracle : Ptr -> (Z -> (Z -> (bool -> (RData -> (option RData))))).
  Definition llvm_memset_p0i8_i64_spec (v_0: Ptr) (arg1: Z) (arg2: Z) (arg3: bool) (st: RData) : option RData :=
    llvm_memset_p0i8_i64_spec_state_oracle v_0 arg1 arg2 arg3 st.

  Parameter memcpy_ns_read_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).
  Definition memcpy_ns_read_spec (v_dest: Ptr) (v_src: Ptr) (v_conv: Z) (st: RData) : option (bool * RData) :=
      rely (v_src.(pbase) = "granule_data" /\ v_src.(poffset) >= 0);
      memcpy_ns_read_spec_state_oracle v_dest v_src v_conv st.

  Hint InitRely atomic_granule_get ((v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0 )).
  Hint InitRely atomic_granule_put (v_0.(pbase) = "granules" /\ (v_0.(poffset) mod 16 = 0) /\ v_0.(poffset) >= 0 ).
  Hint InitRely granule_pa_to_va ((v_0 >= MEM0_PHYS /\ v_0 < MEM0_PHYS + MEM0_SIZE) \/ (v_0 >= MEM1_PHYS /\ v_0 < MEM1_PHYS + MEM1_SIZE)). 
  Hint InitRely set_rd_state ((v_0).(pbase) = "granule_data").
  Hint InitRely get_rd_rec_count_unlocked ((v_0).(pbase) = "granule_data").
  
  (* TODO: give a complete spec of monitor_call *)
  Parameter monitor_call_state_oracle : Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (RData -> (option (Z * RData))))))))).
  Definition monitor_call_spec (id: Z) (arg0: Z) (arg1: Z) (arg2: Z) (arg3: Z) (arg4: Z) (arg5: Z) (st: RData) : option (Z * RData) := monitor_call_state_oracle id arg0 arg1 arg2 arg3 arg4 arg5 st.

  (* Hint InitRely sort_granules (v_1 == 2). *)
  (* TODO: we need post-condition hint support on spoq to simplify __find_lock_next_level! *)
  Hint InitRely __find_lock_next_level (v_0.(pbase) = "granules" /\ (v_0.(poffset) mod 16 = 0) /\ v_0.(poffset) >= 0). 

  Hint InitRely find_lock_granule (((v_0 >= MEM0_PHYS /\ v_0 < MEM0_PHYS + MEM0_SIZE) \/ (v_0 >= MEM1_PHYS /\ v_0 < MEM1_PHYS + MEM1_SIZE))
                       /\ (v_0 & 4095 = 0)).
  
  (* Definition __find_lock_next_level_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((s2_addr_to_idx_spec v_1 v_2 st));
    when v_5, st_1 == ((__find_next_level_idx_spec v_0 v_4 st_0));
    (* rely ((((v_5.(pbase)) = ("granules")) /\ ((((v_5.(poffset)) mod (16)) = (0)))) /\ (((v_5.(poffset)) >= (0)))); *)
    if (ptr_eqb v_5 (mkPtr "null" 0))
    then (Some (v_5, st_1))
    else (
      when st_2 == ((granule_lock_spec v_5 5 st_1));
      (Some (v_5, st_2))). *)

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
    (* "rtt_walk_lock_unlock" ::  *)
    "realm_ipa_bits" ::
    "realm_rtt_starting_level" ::
    "is_addr_in_par" ::
    (* "system_off_reboot" :: *)
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
    (* "find_lock_granules" :: *)
    "s2tte_create_table" :: 
    "s2tt_init_unassigned" ::
    nil.

  Hint InitRely get_realm_identity ((v_0.(pbase) = "stack_s_q_useful_buf" /\ v_0.(poffset) >= 0) /\ 
                                    (v_1.(pbase) = "stack_s_q_useful_buf" /\ v_1.(poffset) >= 0)).
  Hint InitRely realm_ipa_bits (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0).
  Hint InitRely realm_rtt_starting_level (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0).
  Hint InitRely is_addr_in_par (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0 /\ v_1 mod 4096 = 0).
  Hint InitRely system_off_reboot (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0).
  Hint InitRely rd_map_read_rec_count (v_0.(pbase) = "granules"  /\ (v_0.(poffset) mod 16 = 0) /\ v_0.(poffset) >= 0).
  Hint InitRely g_mapped_addr_set (v_0.(pbase) = "granules"  /\ (v_0.(poffset) mod 16 = 0) /\ v_0.(poffset) >= 0).

  Hint InitRely granule_set_state ((v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0) /\ v_1 >= 0 /\ v_1 <= 6).

  Hint InitRely __granule_get (v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0).
  Hint InitRely g_refcount (v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0).

  Hint InitRely __granule_put (v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0).

  Hint InitRely __tte_write (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0).

  Definition memset_spec (v_s: Ptr) (c: Z) (n: Z) (st: RData) : option (Ptr * RData) := Some (v_s, st).
  (* Hint NoUnfold s2tt_init_unassigned_spec. *)

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
    "s2tte_is_assigned" ::
    (* "rtt_create_internal" :: *)
    (* "find_lock_two_granules" :: *)
    (* "data_create_internal" :: *)
    "granule_unlock_transition" ::
    (* "memcpy_ns_write_byte" :: *)
    (* "smc_granule_any_to_ns" :: *)
    "s1tte_is_valid" ::
    (* "smc_granule_ns_to_any" :: *) (* TODO: operation on None value may cause error *)
    (* "memcpy_ns_read_byte" :: *)
    (* "get_tte" :: *)
    "region_is_contained" ::
    (* "realm_ipa_to_pa" :: *)
    (* "memcpy" :: *)
    (* "create_realm_token" :: *)
    "access_mask" ::
    "esr_srt" ::
    "get_sysreg_write_value" ::
    "ranges_intersect" ::
    "s1addr_level_mask" :: 
    nil.
  
  Hint InitRely granule_unlock_transition ((v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0) /\ v_1 >= 0 /\ v_1 <= 6).
  Hint InitRely smc_granule_ns_to_any ((v_0.(pbase) = "granules" /\ ((v_0.(poffset)) mod 16 = 0) /\ v_0.(poffset) >= 0)).
  Hint InitRely get_sysreg_write_value (v_0.(pbase) = "granule_data" /\ v_0.(poffset) >= 0 /\ (v_0.(poffset) mod 4096 = 0)).

End Layer7. 


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



