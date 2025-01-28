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
    e_val : Z}.

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