Record s_gic_cpu_state :=
 mks_gic_cpu_state {
    e_ich_ap0r_el2 : (ZMap.t Z);
    e_ich_ap1r_el2 : (ZMap.t Z);
    e_ich_vmcr_el2 : Z;
    e_ich_hcr_el2 : Z;
    e_ich_lr_el2 : (ZMap.t Z);
    e_ich_misr_el2 : Z
  }.

Record s_sysreg_state :=
 mks_sysreg_state {
    e_sysreg_sp_el0 : Z;
    e_sysreg_sp_el1 : Z;
    e_sysreg_elr_el1 : Z;
    e_sysreg_spsr_el1 : Z;
    e_sysreg_pmcr_el0 : Z;
    e_sysreg_tpidrro_el0 : Z;
    e_sysreg_tpidr_el0 : Z;
    e_sysreg_csselr_el1 : Z;
    e_sysreg_sctlr_el1 : Z;
    e_sysreg_actlr_el1 : Z;
    e_sysreg_cpacr_el1 : Z;
    e_sysreg_zcr_el1 : Z;
    e_sysreg_ttbr0_el1 : Z;
    e_sysreg_ttbr1_el1 : Z;
    e_sysreg_tcr_el1 : Z;
    e_sysreg_esr_el1 : Z;
    e_sysreg_afsr0_el1 : Z;
    e_sysreg_afsr1_el1 : Z;
    e_sysreg_far_el1 : Z;
    e_sysreg_mair_el1 : Z;
    e_sysreg_vbar_el1 : Z;
    e_sysreg_contextidr_el1 : Z;
    e_sysreg_tpidr_el1 : Z;
    e_sysreg_amair_el1 : Z;
    e_sysreg_cntkctl_el1 : Z;
    e_sysreg_par_el1 : Z;
    e_sysreg_mdscr_el1 : Z;
    e_sysreg_mdccint_el1 : Z;
    e_sysreg_disr_el1 : Z;
    e_sysreg_mpam0_el1 : Z;
    e_sysreg_cnthctl_el2 : Z;
    e_sysreg_cntvoff_el2 : Z;
    e_sysreg_cntpoff_el2 : Z;
    e_sysreg_cntp_ctl_el0 : Z;
    e_sysreg_cntp_cval_el0 : Z;
    e_sysreg_cntv_ctl_el0 : Z;
    e_sysreg_cntv_cval_el0 : Z;
    e_sysreg_gicstate : s_gic_cpu_state;
    e_sysreg_vmpidr_el2 : Z;
    e_sysreg_hcr_el2 : Z
  }.

Record s_common_sysreg_state :=
 mks_common_sysreg_state {
    e_common_vttbr_el2 : Z;
    e_common_vtcr_el2 : Z;
    e_common_hcr_el2 : Z;
    e_common_mdcr_el2 : Z
  }.

Record s_set_ripas :=
 mks_set_ripas {
    e_start : Z;
    e_end : Z;
    e_addr : Z;
    e_ripas : Z
  }.

Record s_realm_info :=
 mks_realm_info {
    e_ipa_bits : Z;
    e_s2_starting_level : Z;
    e_g_rtt : Z;
    e_g_rd : Z;
    e_pmu_enabled : Z;
    e_pmu_num_cnts : Z;
    e_sve_enabled : Z;
    e_sve_vq : Z
  }.

Record s_last_run_info :=
 mks_last_run_info {
    e_esr : Z;
    e_hpfar : Z;
    e_far : Z
  }.

Record s_psci_info :=
 mks_psci_info {
     e_pending : Z
  }.

Record s_rec_simd_state :=
 mks_rec_simd_state {
    e_simd : Z;
    e_simd_allowed : Z;
    e_init_done : Z
  }.

Record s_rec_aux_data :=
 mks_rec_aux_data {
    e_attest_heap_buf : Z;
    e_pmu : Z;
    e_rec_simd : s_rec_simd_state
  }.

(* Record s_q_useful_buf := *)
(*  mks_q_useful_buf { *)
(*     e_ptr : Z; *)
(*     e_len : Z *)
(*   }. *)

(* Record s_useful_out_buf := *)
(*  mks_useful_out_buf { *)
(*     e_UB : s_q_useful_buf; *)
(*     e_data_len : Z; *)
(*     e_magic : Z; *)
(*     e_err : Z *)
(*   }. *)

(* Record s_anon := *)
(*  mks_anon { *)
(*     e_____ : Z; *)
(*     e______ : Z; *)
(*     e_______ : Z *)
(*   }. *)

(* Record s___QCBORTrackNesting := *)
(*  mks___QCBORTrackNesting { *)
(*     e_pArrays : (ZMap.t s_anon); *)
(*     e_pCurrentNesting : Z *)
(*   }. *)

(* Record s__QCBOREncodeContext := *)
(*  mks__QCBOREncodeContext { *)
(*     e_OutBuf : s_useful_out_buf; *)
(*     e_uError : Z; *)
(*     e_nesting : s___QCBORTrackNesting *)
(*   }. *)

(* Record u_anon := *)
(*  mku_anon { *)
(*     e_key_ptr : Z *)
(*   }. *)

(* Record s_t_cose_key := *)
(*  mks_t_cose_key { *)
(*     e_crypto_lib : Z; *)
(*     e_k : u_anon *)
(*   }. *)

(* Record s_t_cose_sign1_sign_ctx := *)
(*  mks_t_cose_sign1_sign_ctx { *)
(*     e_rst_ctx : Z; *)
(*     e_protected_parameters : s_q_useful_buf; *)
(*     e_cose_algorithm_id : Z; *)
(*     e_signing_key : s_t_cose_key; *)
(*     e_option_flags : Z; *)
(*     e_kid : s_q_useful_buf; *)
(*     e_content_type_uint : Z; *)
(*     e_content_type_tstr : Z; *)
(*     e_crypto_ctx : Z *)
(*   }. *)

(* Record s_t_cose_sign1_sign_restart_ctx := *)
(*  mks_t_cose_sign1_sign_restart_ctx { *)
(*     e_encode_context : s__QCBOREncodeContext; *)
(*     e_tbs_hash : s_q_useful_buf; *)
(*     e_c_buffer_for_tbs_hash : (ZMap.t Z); *)
(*     e_buffer_for_tbs_hash : s_q_useful_buf; *)
(*     e_started : Z *)
(*   }. *)

(* Record s_mbedtls_ecp_restart_ctx := *)
(*  mks_mbedtls_ecp_restart_ctx { *)
(*     e_private_ops_done : Z; *)
(*     e_private_depth : Z; *)
(*     e_private_rsm : Z; *)
(*     e_private_ma : Z *)
(*   }. *)

(* Record s_mbedtls_ecdsa_restart_ctx := *)
(*  mks_mbedtls_ecdsa_restart_ctx { *)
(*     e_private_ecp : s_mbedtls_ecp_restart_ctx; *)
(*     e_private_ver : Z; *)
(*     e_private_sig : Z; *)
(*     e_private_det : Z *)
(*   }. *)

(* Record s_mbedtls_mpi := *)
(*  mks_mbedtls_mpi { *)
(*     e_private_s : Z; *)
(*     e_private_n : Z; *)
(*     e_private_p : Z *)
(*   }. *)

(* Record s_mbedtls_ecp_point := *)
(*  mks_mbedtls_ecp_point { *)
(*     e_private_X : s_mbedtls_mpi; *)
(*     e_private_Y : s_mbedtls_mpi; *)
(*     e_private_Z : s_mbedtls_mpi *)
(*   }. *)

(* Record s_mbedtls_ecp_group := *)
(*  mks_mbedtls_ecp_group { *)
(*     e_id : Z; *)
(*     e_P : s_mbedtls_mpi; *)
(*     e_A : s_mbedtls_mpi; *)
(*     e_B : s_mbedtls_mpi; *)
(*     e_G : s_mbedtls_ecp_point; *)
(*     e_N : s_mbedtls_mpi; *)
(*     e_pbits : Z; *)
(*     e_nbits : Z; *)
(*     e_private_h : Z; *)
(*     e_private_modp : Z; *)
(*     e_private_t_pre : Z; *)
(*     e_private_t_post : Z; *)
(*     e_private_t_data : Z; *)
(*     e_private_T : Z; *)
(*     e_private_T_size : Z *)
(*   }. *)

(* Record s_mbedtls_ecp_keypair := *)
(*  mks_mbedtls_ecp_keypair { *)
(*     e_private_grp : s_mbedtls_ecp_group; *)
(*     e_private_d : s_mbedtls_mpi; *)
(*     e_private_Q : s_mbedtls_ecp_point *)
(*   }. *)

(* Record s_t_cose_crypto_backend_ctx := *)
(*  mks_t_cose_crypto_backend_ctx { *)
(*     e_ecdsa_rst_ctx : s_mbedtls_ecdsa_restart_ctx; *)
(*     e_ecdsa_ctx : s_mbedtls_ecp_keypair *)
(*   }. *)

(* Record s_attest_token_encode_ctx := *)
(*  mks_attest_token_encode_ctx { *)
(*     e_cbor_enc_ctx : s__QCBOREncodeContext; *)
(*     e_opt_flags : Z; *)
(*     e_key_select : Z; *)
(*     e_signer_ctx : s_t_cose_sign1_sign_ctx; *)
(*     e_signer_restart_ctx : s_t_cose_sign1_sign_restart_ctx; *)
(*     e__crypto_ctx : s_t_cose_crypto_backend_ctx *)
(*   }. *)

(* Record s_token_sign_ctx := *)
(*  mks_token_sign_ctx { *)
(*     e_state : Z; *)
(*     e_ctx : s_attest_token_encode_ctx; *)
(*     e_token_ipa : Z; *)
(*     e_challenge : (ZMap.t Z) *)
(*   }. *)

Record s_buffer_alloc_ctx :=
 mks_buffer_alloc_ctx {
    e_buf : Z;
    e__len : Z;
    e_first : Z;
    e_first_free : Z;
    e_verify : Z
  }.

Record s_alloc_info :=
 mks_alloc_info {
    e__ctx : s_buffer_alloc_ctx;
    e_ctx_initialised : Z
  }.

Record s_serror_info :=
 mks_serror_info {
    e_vsesr_el2 : Z;
    e_inject : Z
  }.

Record s_rec :=
 mks_rec {
    e_g_rec : Z;
    e_rec_idx : Z;
    e_runnable : Z;
    e_regs : (ZMap.t Z);
    e_pc : Z;
    e_pstate : Z;
    e_sysregs : s_sysreg_state;
    e_common_sysregs : s_common_sysreg_state;
    e_set_ripas : s_set_ripas;
    e_realm_info : s_realm_info;
    e_last_run_info : s_last_run_info;
    e_ns : Z;
    e_psci_info : s_psci_info;
    e_num_rec_aux : Z;
    e_g_aux : (ZMap.t Z);
    e_aux_data : s_rec_aux_data;
    (* e_rmm_realm_token_buf : (ZMap.t Z); *)
    (* e_rmm_realm_token : s_q_useful_buf; *)
    (* e_token_sign_ctx : s_token_sign_ctx; *)
    e_alloc_info : s_alloc_info;
    e_serror_info : s_serror_info;
    e_host_call : Z
  }.

Definition load_s_gic_cpu_state (sz: Z) (ofs: Z) (st: s_gic_cpu_state) : option Z :=
  if (ofs >=? 0) && (ofs <? 32) then (
    let idx := (ofs - 0) / 8 in
    Some (st.(e_ich_ap0r_el2) @ idx)) else
  if (ofs >=? 32) && (ofs <? 64) then (
    let idx := (ofs - 32) / 8 in
    Some (st.(e_ich_ap1r_el2) @ idx)) else
  if (ofs =? 64) then Some (st.(e_ich_vmcr_el2)) else
  if (ofs =? 72) then Some (st.(e_ich_hcr_el2)) else
  if (ofs >=? 80) && (ofs <? 208) then (
    let idx := (ofs - 80) / 8 in
    Some (st.(e_ich_lr_el2) @ idx)) else
  if (ofs =? 208) then Some (st.(e_ich_misr_el2)) else
  None.

Definition store_s_gic_cpu_state (sz: Z) (ofs: Z) (v: Z) (st: s_gic_cpu_state) : option s_gic_cpu_state :=
  if (ofs >=? 0) && (ofs <? 32) then (
    let idx := (ofs - 0) / 8 in
    Some (st.[e_ich_ap0r_el2] :< (st.(e_ich_ap0r_el2) # idx == v))) else
  if (ofs >=? 32) && (ofs <? 64) then (
    let idx := (ofs - 32) / 8 in
    Some (st.[e_ich_ap1r_el2] :< (st.(e_ich_ap1r_el2) # idx == v))) else
  if (ofs =? 64) then Some (st.[e_ich_vmcr_el2] :< v) else
  if (ofs =? 72) then Some (st.[e_ich_hcr_el2] :< v) else
  if (ofs >=? 80) && (ofs <? 208) then (
    let idx := (ofs - 80) / 8 in
    Some (st.[e_ich_lr_el2] :< (st.(e_ich_lr_el2) # idx == v))) else
  if (ofs =? 208) then Some (st.[e_ich_misr_el2] :< v) else
  None.

Definition load_s_sysreg_state (sz: Z) (ofs: Z) (st: s_sysreg_state) : option Z :=
  if (ofs =? 0) then Some (st.(e_sysreg_sp_el0)) else
  if (ofs =? 8) then Some (st.(e_sysreg_sp_el1)) else
  if (ofs =? 16) then Some (st.(e_sysreg_elr_el1)) else
  if (ofs =? 24) then Some (st.(e_sysreg_spsr_el1)) else
  if (ofs =? 32) then Some (st.(e_sysreg_pmcr_el0)) else
  if (ofs =? 40) then Some (st.(e_sysreg_tpidrro_el0)) else
  if (ofs =? 48) then Some (st.(e_sysreg_tpidr_el0)) else
  if (ofs =? 56) then Some (st.(e_sysreg_csselr_el1)) else
  if (ofs =? 64) then Some (st.(e_sysreg_sctlr_el1)) else
  if (ofs =? 72) then Some (st.(e_sysreg_actlr_el1)) else
  if (ofs =? 80) then Some (st.(e_sysreg_cpacr_el1)) else
  if (ofs =? 88) then Some (st.(e_sysreg_zcr_el1)) else
  if (ofs =? 96) then Some (st.(e_sysreg_ttbr0_el1)) else
  if (ofs =? 104) then Some (st.(e_sysreg_ttbr1_el1)) else
  if (ofs =? 112) then Some (st.(e_sysreg_tcr_el1)) else
  if (ofs =? 120) then Some (st.(e_sysreg_esr_el1)) else
  if (ofs =? 128) then Some (st.(e_sysreg_afsr0_el1)) else
  if (ofs =? 136) then Some (st.(e_sysreg_afsr1_el1)) else
  if (ofs =? 144) then Some (st.(e_sysreg_far_el1)) else
  if (ofs =? 152) then Some (st.(e_sysreg_mair_el1)) else
  if (ofs =? 160) then Some (st.(e_sysreg_vbar_el1)) else
  if (ofs =? 168) then Some (st.(e_sysreg_contextidr_el1)) else
  if (ofs =? 176) then Some (st.(e_sysreg_tpidr_el1)) else
  if (ofs =? 184) then Some (st.(e_sysreg_amair_el1)) else
  if (ofs =? 192) then Some (st.(e_sysreg_cntkctl_el1)) else
  if (ofs =? 200) then Some (st.(e_sysreg_par_el1)) else
  if (ofs =? 208) then Some (st.(e_sysreg_mdscr_el1)) else
  if (ofs =? 216) then Some (st.(e_sysreg_mdccint_el1)) else
  if (ofs =? 224) then Some (st.(e_sysreg_disr_el1)) else
  if (ofs =? 232) then Some (st.(e_sysreg_mpam0_el1)) else
  if (ofs =? 240) then Some (st.(e_sysreg_cnthctl_el2)) else
  if (ofs =? 248) then Some (st.(e_sysreg_cntvoff_el2)) else
  if (ofs =? 256) then Some (st.(e_sysreg_cntpoff_el2)) else
  if (ofs =? 264) then Some (st.(e_sysreg_cntp_ctl_el0)) else
  if (ofs =? 272) then Some (st.(e_sysreg_cntp_cval_el0)) else
  if (ofs =? 280) then Some (st.(e_sysreg_cntv_ctl_el0)) else
  if (ofs =? 288) then Some (st.(e_sysreg_cntv_cval_el0)) else
  if (ofs >=? 296) && (ofs <? 512) then (
    let elem_ofs := ofs - 296 in
    load_s_gic_cpu_state sz elem_ofs (st.(e_sysreg_gicstate))) else
  if (ofs =? 512) then Some (st.(e_sysreg_vmpidr_el2)) else
  if (ofs =? 520) then Some (st.(e_sysreg_hcr_el2)) else
  None.

Definition store_s_sysreg_state (sz: Z) (ofs: Z) (v: Z) (st: s_sysreg_state) : option s_sysreg_state :=
  if (ofs =? 0) then Some (st.[e_sysreg_sp_el0] :< v) else
  if (ofs =? 8) then Some (st.[e_sysreg_sp_el1] :< v) else
  if (ofs =? 16) then Some (st.[e_sysreg_elr_el1] :< v) else
  if (ofs =? 24) then Some (st.[e_sysreg_spsr_el1] :< v) else
  if (ofs =? 32) then Some (st.[e_sysreg_pmcr_el0] :< v) else
  if (ofs =? 40) then Some (st.[e_sysreg_tpidrro_el0] :< v) else
  if (ofs =? 48) then Some (st.[e_sysreg_tpidr_el0] :< v) else
  if (ofs =? 56) then Some (st.[e_sysreg_csselr_el1] :< v) else
  if (ofs =? 64) then Some (st.[e_sysreg_sctlr_el1] :< v) else
  if (ofs =? 72) then Some (st.[e_sysreg_actlr_el1] :< v) else
  if (ofs =? 80) then Some (st.[e_sysreg_cpacr_el1] :< v) else
  if (ofs =? 88) then Some (st.[e_sysreg_zcr_el1] :< v) else
  if (ofs =? 96) then Some (st.[e_sysreg_ttbr0_el1] :< v) else
  if (ofs =? 104) then Some (st.[e_sysreg_ttbr1_el1] :< v) else
  if (ofs =? 112) then Some (st.[e_sysreg_tcr_el1] :< v) else
  if (ofs =? 120) then Some (st.[e_sysreg_esr_el1] :< v) else
  if (ofs =? 128) then Some (st.[e_sysreg_afsr0_el1] :< v) else
  if (ofs =? 136) then Some (st.[e_sysreg_afsr1_el1] :< v) else
  if (ofs =? 144) then Some (st.[e_sysreg_far_el1] :< v) else
  if (ofs =? 152) then Some (st.[e_sysreg_mair_el1] :< v) else
  if (ofs =? 160) then Some (st.[e_sysreg_vbar_el1] :< v) else
  if (ofs =? 168) then Some (st.[e_sysreg_contextidr_el1] :< v) else
  if (ofs =? 176) then Some (st.[e_sysreg_tpidr_el1] :< v) else
  if (ofs =? 184) then Some (st.[e_sysreg_amair_el1] :< v) else
  if (ofs =? 192) then Some (st.[e_sysreg_cntkctl_el1] :< v) else
  if (ofs =? 200) then Some (st.[e_sysreg_par_el1] :< v) else
  if (ofs =? 208) then Some (st.[e_sysreg_mdscr_el1] :< v) else
  if (ofs =? 216) then Some (st.[e_sysreg_mdccint_el1] :< v) else
  if (ofs =? 224) then Some (st.[e_sysreg_disr_el1] :< v) else
  if (ofs =? 232) then Some (st.[e_sysreg_mpam0_el1] :< v) else
  if (ofs =? 240) then Some (st.[e_sysreg_cnthctl_el2] :< v) else
  if (ofs =? 248) then Some (st.[e_sysreg_cntvoff_el2] :< v) else
  if (ofs =? 256) then Some (st.[e_sysreg_cntpoff_el2] :< v) else
  if (ofs =? 264) then Some (st.[e_sysreg_cntp_ctl_el0] :< v) else
  if (ofs =? 272) then Some (st.[e_sysreg_cntp_cval_el0] :< v) else
  if (ofs =? 280) then Some (st.[e_sysreg_cntv_ctl_el0] :< v) else
  if (ofs =? 288) then Some (st.[e_sysreg_cntv_cval_el0] :< v) else
  if (ofs >=? 296) && (ofs <? 512) then (
    let elem_ofs := ofs - 296 in
    when ret == store_s_gic_cpu_state sz elem_ofs v st.(e_sysreg_gicstate);
    Some (st.[e_sysreg_gicstate] :< ret)) else
  if (ofs =? 512) then Some (st.[e_sysreg_vmpidr_el2] :< v) else
  if (ofs =? 520) then Some (st.[e_sysreg_hcr_el2] :< v) else
  None.

Definition load_s_common_sysreg_state (sz: Z) (ofs: Z) (st: s_common_sysreg_state) : option Z :=
  if (ofs =? 0) then Some (st.(e_common_vttbr_el2)) else
  if (ofs =? 8) then Some (st.(e_common_vtcr_el2)) else
  if (ofs =? 16) then Some (st.(e_common_hcr_el2)) else
  if (ofs =? 24) then Some (st.(e_common_mdcr_el2)) else
  None.

Definition store_s_common_sysreg_state (sz: Z) (ofs: Z) (v: Z) (st: s_common_sysreg_state) : option s_common_sysreg_state :=
  if (ofs =? 0) then Some (st.[e_common_vttbr_el2] :< v) else
  if (ofs =? 8) then Some (st.[e_common_vtcr_el2] :< v) else
  if (ofs =? 16) then Some (st.[e_common_hcr_el2] :< v) else
  if (ofs =? 24) then Some (st.[e_common_mdcr_el2] :< v) else
  None.

Definition load_s_set_ripas (sz: Z) (ofs: Z) (st: s_set_ripas) : option Z :=
  if (ofs =? 0) then Some (st.(e_start)) else
  if (ofs =? 8) then Some (st.(e_end)) else
  if (ofs =? 16) then Some (st.(e_addr)) else
  if (ofs =? 24) then Some (st.(e_ripas)) else
  None.

Definition store_s_set_ripas (sz: Z) (ofs: Z) (v: Z) (st: s_set_ripas) : option s_set_ripas :=
  if (ofs =? 0) then Some (st.[e_start] :< v) else
  if (ofs =? 8) then Some (st.[e_end] :< v) else
  if (ofs =? 16) then Some (st.[e_addr] :< v) else
  if (ofs =? 24) then Some (st.[e_ripas] :< v) else
  None.

Definition load_s_realm_info (sz: Z) (ofs: Z) (st: s_realm_info) : option Z :=
  if (ofs =? 0) then Some (st.(e_ipa_bits)) else
  if (ofs =? 8) then Some (st.(e_s2_starting_level)) else
  if (ofs =? 16) then Some (st.(e_g_rtt)) else
  if (ofs =? 24) then rely (int_is_granule (st.(e_g_rd))); Some (st.(e_g_rd)) else
  if (ofs =? 32) then Some (st.(e_pmu_enabled)) else
  if (ofs =? 36) then Some (st.(e_pmu_num_cnts)) else
  if (ofs =? 40) then Some (st.(e_sve_enabled)) else
  if (ofs =? 41) then Some (st.(e_sve_vq)) else
  None.

Definition store_s_realm_info (sz: Z) (ofs: Z) (v: Z) (st: s_realm_info) : option s_realm_info :=
  if (ofs =? 0) then Some (st.[e_ipa_bits] :< v) else
  if (ofs =? 8) then Some (st.[e_s2_starting_level] :< v) else
  if (ofs =? 16) then Some (st.[e_g_rtt] :< v) else
  if (ofs =? 24) then Some (st.[e_g_rd] :< v) else
  if (ofs =? 32) then Some (st.[e_pmu_enabled] :< v) else
  if (ofs =? 36) then Some (st.[e_pmu_num_cnts] :< v) else
  if (ofs =? 40) then Some (st.[e_sve_enabled] :< v) else
  if (ofs =? 41) then Some (st.[e_sve_vq] :< v) else
  None.

Definition load_s_last_run_info (sz: Z) (ofs: Z) (st: s_last_run_info) : option Z :=
  if (ofs =? 0) then Some (st.(e_esr)) else
  if (ofs =? 8) then Some (st.(e_hpfar)) else
  if (ofs =? 16) then Some (st.(e_far)) else
  None.

Definition store_s_last_run_info (sz: Z) (ofs: Z) (v: Z) (st: s_last_run_info) : option s_last_run_info :=
  if (ofs =? 0) then Some (st.[e_esr] :< v) else
  if (ofs =? 8) then Some (st.[e_hpfar] :< v) else
  if (ofs =? 16) then Some (st.[e_far] :< v) else
  None.

Definition load_s_psci_info (sz: Z) (ofs: Z) (st: s_psci_info) : option Z :=
  if (ofs =? 0) then Some (st.(e_pending)) else
  None.

Definition store_s_psci_info (sz: Z) (ofs: Z) (v: Z) (st: s_psci_info) : option s_psci_info :=
  if (ofs =? 0) then Some (st.[e_pending] :< v) else
  None.

Definition load_s_rec_simd_state (sz: Z) (ofs: Z) (st: s_rec_simd_state) : option Z :=
  if (ofs =? 0) then (
    let ret := st.(e_simd) in
    rely (ret < MAX_ERR);
    rely (ret >= SLOT_VIRT);
    let slot := ((ret - SLOT_VIRT) / GRANULE_SIZE) in
    rely (slot >= SLOT_REC_AUX0);
    rely (slot < SLOT_REC_AUX0 + MAX_REC_AUX_GRANULES);
    Some ret
  ) else
  if (ofs =? 8) then Some (st.(e_simd_allowed)) else
  if (ofs =? 9) then Some (st.(e_init_done)) else
  None.

Definition store_s_rec_simd_state (sz: Z) (ofs: Z) (v: Z) (st: s_rec_simd_state) : option s_rec_simd_state :=
  if (ofs =? 0) then Some (st.[e_simd] :< v) else
  if (ofs =? 8) then Some (st.[e_simd_allowed] :< v) else
  if (ofs =? 9) then Some (st.[e_init_done] :< v) else
  None.

Definition load_s_rec_aux_data (sz: Z) (ofs: Z) (st: s_rec_aux_data) : option Z :=
  if (ofs =? 0) then Some (st.(e_attest_heap_buf)) else
  if (ofs =? 8) then Some (st.(e_pmu)) else
  if (ofs >=? 16) && (ofs <? 32) then (
    let elem_ofs := ofs - 16 in
    load_s_rec_simd_state sz elem_ofs (st.(e_rec_simd))) else
  None.

Definition store_s_rec_aux_data (sz: Z) (ofs: Z) (v: Z) (st: s_rec_aux_data) : option s_rec_aux_data :=
  if (ofs =? 0) then Some (st.[e_attest_heap_buf] :< v) else
  if (ofs =? 8) then Some (st.[e_pmu] :< v) else
  if (ofs >=? 16) && (ofs <? 32) then (
    let elem_ofs := ofs - 16 in
    when ret == store_s_rec_simd_state sz elem_ofs v st.(e_rec_simd);
    Some (st.[e_rec_simd] :< ret)) else
  None.

(* Definition load_s_q_useful_buf (sz: Z) (ofs: Z) (st: s_q_useful_buf) : option Z := *)
(*   if (ofs =? 0) then Some (st.(e_ptr)) else *)
(*   if (ofs =? 8) then Some (st.(e_len)) else *)
(*   None. *)

(* Definition store_s_q_useful_buf (sz: Z) (ofs: Z) (v: Z) (st: s_q_useful_buf) : option s_q_useful_buf := *)
(*   if (ofs =? 0) then Some (st.[e_ptr] :< v) else *)
(*   if (ofs =? 8) then Some (st.[e_len] :< v) else *)
(*   None. *)

(* Definition load_s_useful_out_buf (sz: Z) (ofs: Z) (st: s_useful_out_buf) : option Z := *)
(*   if (ofs >=? 0) && (ofs <? 16) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     load_s_q_useful_buf sz elem_ofs (st.(e_UB))) else *)
(*   if (ofs =? 16) then Some (st.(e_data_len)) else *)
(*   if (ofs =? 24) then Some (st.(e_magic)) else *)
(*   if (ofs =? 26) then Some (st.(e_err)) else *)
(*   None. *)

(* Definition store_s_useful_out_buf (sz: Z) (ofs: Z) (v: Z) (st: s_useful_out_buf) : option s_useful_out_buf := *)
(*   if (ofs >=? 0) && (ofs <? 16) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     when ret == store_s_q_useful_buf sz elem_ofs v st.(e_UB); *)
(*     Some (st.[e_UB] :< ret)) else *)
(*   if (ofs =? 16) then Some (st.[e_data_len] :< v) else *)
(*   if (ofs =? 24) then Some (st.[e_magic] :< v) else *)
(*   if (ofs =? 26) then Some (st.[e_err] :< v) else *)
(*   None. *)

(* Definition load_s_anon (sz: Z) (ofs: Z) (st: s_anon) : option Z := *)
(*   if (ofs =? 0) then Some (st.(e_____)) else *)
(*   if (ofs =? 0) then Some (st.(e______)) else *)
(*   if (ofs =? 0) then Some (st.(e_______)) else *)
(*   None. *)

(* Definition store_s_anon (sz: Z) (ofs: Z) (v: Z) (st: s_anon) : option s_anon := *)
(*   if (ofs =? 0) then Some (st.[e_____] :< v) else *)
(*   if (ofs =? 0) then Some (st.[e______] :< v) else *)
(*   if (ofs =? 0) then Some (st.[e_______] :< v) else *)
(*   None. *)

(* Definition load_s___QCBORTrackNesting (sz: Z) (ofs: Z) (st: s___QCBORTrackNesting) : option Z := *)
(*   if (ofs >=? 0) && (ofs <? 0) then ( *)
(*     let idx := (ofs - 0) / 0 in *)
(*     let elem_ofs := (ofs - 0) mod 0 in *)
(*     load_s_anon sz elem_ofs (st.(e_pArrays) @ idx)) else *)
(*   if (ofs =? 128) then Some (st.(e_pCurrentNesting)) else *)
(*   None. *)

(* Definition store_s___QCBORTrackNesting (sz: Z) (ofs: Z) (v: Z) (st: s___QCBORTrackNesting) : option s___QCBORTrackNesting := *)
(*   if (ofs >=? 0) && (ofs <? 0) then ( *)
(*     let idx := (ofs - 0) / 0 in *)
(*     let elem_ofs := (ofs - 0) mod 0 in *)
(*     when ret == store_s_anon sz elem_ofs v (st.(e_pArrays) @ idx); *)
(*     Some (st.[e_pArrays] :< (st.(e_pArrays) # idx == ret))) else *)
(*   if (ofs =? 128) then Some (st.[e_pCurrentNesting] :< v) else *)
(*   None. *)

(* Definition load_s__QCBOREncodeContext (sz: Z) (ofs: Z) (st: s__QCBOREncodeContext) : option Z := *)
(*   if (ofs >=? 0) && (ofs <? 32) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     load_s_useful_out_buf sz elem_ofs (st.(e_OutBuf))) else *)
(*   if (ofs =? 32) then Some (st.(e_uError)) else *)
(*   if (ofs >=? 40) && (ofs <? 176) then ( *)
(*     let elem_ofs := ofs - 40 in *)
(*     load_s___QCBORTrackNesting sz elem_ofs (st.(e_nesting))) else *)
(*   None. *)

(* Definition store_s__QCBOREncodeContext (sz: Z) (ofs: Z) (v: Z) (st: s__QCBOREncodeContext) : option s__QCBOREncodeContext := *)
(*   if (ofs >=? 0) && (ofs <? 32) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     when ret == store_s_useful_out_buf sz elem_ofs v st.(e_OutBuf); *)
(*     Some (st.[e_OutBuf] :< ret)) else *)
(*   if (ofs =? 32) then Some (st.[e_uError] :< v) else *)
(*   if (ofs >=? 40) && (ofs <? 176) then ( *)
(*     let elem_ofs := ofs - 40 in *)
(*     when ret == store_s___QCBORTrackNesting sz elem_ofs v st.(e_nesting); *)
(*     Some (st.[e_nesting] :< ret)) else *)
(*   None. *)

(* Definition load_u_anon (sz: Z) (ofs: Z) (st: u_anon) : option Z := *)
(*   if (ofs =? 0) then Some (st.(e_key_ptr)) else *)
(*   None. *)

(* Definition store_u_anon (sz: Z) (ofs: Z) (v: Z) (st: u_anon) : option u_anon := *)
(*   if (ofs =? 0) then Some (st.[e_key_ptr] :< v) else *)
(*   None. *)

(* Definition load_s_t_cose_key (sz: Z) (ofs: Z) (st: s_t_cose_key) : option Z := *)
(*   if (ofs =? 0) then Some (st.(e_crypto_lib)) else *)
(*   if (ofs >=? 8) && (ofs <? 16) then ( *)
(*     let elem_ofs := ofs - 8 in *)
(*     load_u_anon sz elem_ofs (st.(e_k))) else *)
(*   None. *)

(* Definition store_s_t_cose_key (sz: Z) (ofs: Z) (v: Z) (st: s_t_cose_key) : option s_t_cose_key := *)
(*   if (ofs =? 0) then Some (st.[e_crypto_lib] :< v) else *)
(*   if (ofs >=? 8) && (ofs <? 16) then ( *)
(*     let elem_ofs := ofs - 8 in *)
(*     when ret == store_u_anon sz elem_ofs v st.(e_k); *)
(*     Some (st.[e_k] :< ret)) else *)
(*   None. *)

(* Definition load_s_t_cose_sign1_sign_ctx (sz: Z) (ofs: Z) (st: s_t_cose_sign1_sign_ctx) : option Z := *)
(*   if (ofs =? 0) then Some (st.(e_rst_ctx)) else *)
(*   if (ofs >=? 8) && (ofs <? 24) then ( *)
(*     let elem_ofs := ofs - 8 in *)
(*     load_s_q_useful_buf sz elem_ofs (st.(e_protected_parameters))) else *)
(*   if (ofs =? 24) then Some (st.(e_cose_algorithm_id)) else *)
(*   if (ofs >=? 32) && (ofs <? 48) then ( *)
(*     let elem_ofs := ofs - 32 in *)
(*     load_s_t_cose_key sz elem_ofs (st.(e_signing_key))) else *)
(*   if (ofs =? 48) then Some (st.(e_option_flags)) else *)
(*   if (ofs >=? 56) && (ofs <? 72) then ( *)
(*     let elem_ofs := ofs - 56 in *)
(*     load_s_q_useful_buf sz elem_ofs (st.(e_kid))) else *)
(*   if (ofs =? 72) then Some (st.(e_content_type_uint)) else *)
(*   if (ofs =? 80) then Some (st.(e_content_type_tstr)) else *)
(*   if (ofs =? 88) then Some (st.(e_crypto_ctx)) else *)
(*   None. *)

(* Definition store_s_t_cose_sign1_sign_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_t_cose_sign1_sign_ctx) : option s_t_cose_sign1_sign_ctx := *)
(*   if (ofs =? 0) then Some (st.[e_rst_ctx] :< v) else *)
(*   if (ofs >=? 8) && (ofs <? 24) then ( *)
(*     let elem_ofs := ofs - 8 in *)
(*     when ret == store_s_q_useful_buf sz elem_ofs v st.(e_protected_parameters); *)
(*     Some (st.[e_protected_parameters] :< ret)) else *)
(*   if (ofs =? 24) then Some (st.[e_cose_algorithm_id] :< v) else *)
(*   if (ofs >=? 32) && (ofs <? 48) then ( *)
(*     let elem_ofs := ofs - 32 in *)
(*     when ret == store_s_t_cose_key sz elem_ofs v st.(e_signing_key); *)
(*     Some (st.[e_signing_key] :< ret)) else *)
(*   if (ofs =? 48) then Some (st.[e_option_flags] :< v) else *)
(*   if (ofs >=? 56) && (ofs <? 72) then ( *)
(*     let elem_ofs := ofs - 56 in *)
(*     when ret == store_s_q_useful_buf sz elem_ofs v st.(e_kid); *)
(*     Some (st.[e_kid] :< ret)) else *)
(*   if (ofs =? 72) then Some (st.[e_content_type_uint] :< v) else *)
(*   if (ofs =? 80) then Some (st.[e_content_type_tstr] :< v) else *)
(*   if (ofs =? 88) then Some (st.[e_crypto_ctx] :< v) else *)
(*   None. *)

(* Definition load_s_t_cose_sign1_sign_restart_ctx (sz: Z) (ofs: Z) (st: s_t_cose_sign1_sign_restart_ctx) : option Z := *)
(*   if (ofs >=? 0) && (ofs <? 176) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     load_s__QCBOREncodeContext sz elem_ofs (st.(e_encode_context))) else *)
(*   if (ofs >=? 176) && (ofs <? 192) then ( *)
(*     let elem_ofs := ofs - 176 in *)
(*     load_s_q_useful_buf sz elem_ofs (st.(e_tbs_hash))) else *)
(*   if (ofs >=? 192) && (ofs <? 256) then ( *)
(*     let idx := (ofs - 192) / 1 in *)
(*     Some (st.(e_c_buffer_for_tbs_hash) @ idx)) else *)
(*   if (ofs >=? 256) && (ofs <? 272) then ( *)
(*     let elem_ofs := ofs - 256 in *)
(*     load_s_q_useful_buf sz elem_ofs (st.(e_buffer_for_tbs_hash))) else *)
(*   if (ofs =? 272) then Some (st.(e_started)) else *)
(*   None. *)

(* Definition store_s_t_cose_sign1_sign_restart_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_t_cose_sign1_sign_restart_ctx) : option s_t_cose_sign1_sign_restart_ctx := *)
(*   if (ofs >=? 0) && (ofs <? 176) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     when ret == store_s__QCBOREncodeContext sz elem_ofs v st.(e_encode_context); *)
(*     Some (st.[e_encode_context] :< ret)) else *)
(*   if (ofs >=? 176) && (ofs <? 192) then ( *)
(*     let elem_ofs := ofs - 176 in *)
(*     when ret == store_s_q_useful_buf sz elem_ofs v st.(e_tbs_hash); *)
(*     Some (st.[e_tbs_hash] :< ret)) else *)
(*   if (ofs >=? 192) && (ofs <? 256) then ( *)
(*     let idx := (ofs - 192) / 1 in *)
(*     Some (st.[e_c_buffer_for_tbs_hash] :< (st.(e_c_buffer_for_tbs_hash) # idx == v))) else *)
(*   if (ofs >=? 256) && (ofs <? 272) then ( *)
(*     let elem_ofs := ofs - 256 in *)
(*     when ret == store_s_q_useful_buf sz elem_ofs v st.(e_buffer_for_tbs_hash); *)
(*     Some (st.[e_buffer_for_tbs_hash] :< ret)) else *)
(*   if (ofs =? 272) then Some (st.[e_started] :< v) else *)
(*   None. *)

(* Definition load_s_mbedtls_ecp_restart_ctx (sz: Z) (ofs: Z) (st: s_mbedtls_ecp_restart_ctx) : option Z := *)
(*   if (ofs =? 0) then Some (st.(e_private_ops_done)) else *)
(*   if (ofs =? 4) then Some (st.(e_private_depth)) else *)
(*   if (ofs =? 8) then Some (st.(e_private_rsm)) else *)
(*   if (ofs =? 16) then Some (st.(e_private_ma)) else *)
(*   None. *)

(* Definition store_s_mbedtls_ecp_restart_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_mbedtls_ecp_restart_ctx) : option s_mbedtls_ecp_restart_ctx := *)
(*   if (ofs =? 0) then Some (st.[e_private_ops_done] :< v) else *)
(*   if (ofs =? 4) then Some (st.[e_private_depth] :< v) else *)
(*   if (ofs =? 8) then Some (st.[e_private_rsm] :< v) else *)
(*   if (ofs =? 16) then Some (st.[e_private_ma] :< v) else *)
(*   None. *)

(* Definition load_s_mbedtls_ecdsa_restart_ctx (sz: Z) (ofs: Z) (st: s_mbedtls_ecdsa_restart_ctx) : option Z := *)
(*   if (ofs >=? 0) && (ofs <? 24) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     load_s_mbedtls_ecp_restart_ctx sz elem_ofs (st.(e_private_ecp))) else *)
(*   if (ofs =? 24) then Some (st.(e_private_ver)) else *)
(*   if (ofs =? 32) then Some (st.(e_private_sig)) else *)
(*   if (ofs =? 40) then Some (st.(e_private_det)) else *)
(*   None. *)

(* Definition store_s_mbedtls_ecdsa_restart_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_mbedtls_ecdsa_restart_ctx) : option s_mbedtls_ecdsa_restart_ctx := *)
(*   if (ofs >=? 0) && (ofs <? 24) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     when ret == store_s_mbedtls_ecp_restart_ctx sz elem_ofs v st.(e_private_ecp); *)
(*     Some (st.[e_private_ecp] :< ret)) else *)
(*   if (ofs =? 24) then Some (st.[e_private_ver] :< v) else *)
(*   if (ofs =? 32) then Some (st.[e_private_sig] :< v) else *)
(*   if (ofs =? 40) then Some (st.[e_private_det] :< v) else *)
(*   None. *)

(* Definition load_s_mbedtls_mpi (sz: Z) (ofs: Z) (st: s_mbedtls_mpi) : option Z := *)
(*   if (ofs =? 0) then Some (st.(e_private_s)) else *)
(*   if (ofs =? 8) then Some (st.(e_private_n)) else *)
(*   if (ofs =? 16) then Some (st.(e_private_p)) else *)
(*   None. *)

(* Definition store_s_mbedtls_mpi (sz: Z) (ofs: Z) (v: Z) (st: s_mbedtls_mpi) : option s_mbedtls_mpi := *)
(*   if (ofs =? 0) then Some (st.[e_private_s] :< v) else *)
(*   if (ofs =? 8) then Some (st.[e_private_n] :< v) else *)
(*   if (ofs =? 16) then Some (st.[e_private_p] :< v) else *)
(*   None. *)

(* Definition load_s_mbedtls_ecp_point (sz: Z) (ofs: Z) (st: s_mbedtls_ecp_point) : option Z := *)
(*   if (ofs >=? 0) && (ofs <? 24) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     load_s_mbedtls_mpi sz elem_ofs (st.(e_private_X))) else *)
(*   if (ofs >=? 24) && (ofs <? 48) then ( *)
(*     let elem_ofs := ofs - 24 in *)
(*     load_s_mbedtls_mpi sz elem_ofs (st.(e_private_Y))) else *)
(*   if (ofs >=? 48) && (ofs <? 72) then ( *)
(*     let elem_ofs := ofs - 48 in *)
(*     load_s_mbedtls_mpi sz elem_ofs (st.(e_private_Z))) else *)
(*   None. *)

(* Definition store_s_mbedtls_ecp_point (sz: Z) (ofs: Z) (v: Z) (st: s_mbedtls_ecp_point) : option s_mbedtls_ecp_point := *)
(*   if (ofs >=? 0) && (ofs <? 24) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     when ret == store_s_mbedtls_mpi sz elem_ofs v st.(e_private_X); *)
(*     Some (st.[e_private_X] :< ret)) else *)
(*   if (ofs >=? 24) && (ofs <? 48) then ( *)
(*     let elem_ofs := ofs - 24 in *)
(*     when ret == store_s_mbedtls_mpi sz elem_ofs v st.(e_private_Y); *)
(*     Some (st.[e_private_Y] :< ret)) else *)
(*   if (ofs >=? 48) && (ofs <? 72) then ( *)
(*     let elem_ofs := ofs - 48 in *)
(*     when ret == store_s_mbedtls_mpi sz elem_ofs v st.(e_private_Z); *)
(*     Some (st.[e_private_Z] :< ret)) else *)
(*   None. *)

(* Definition load_s_mbedtls_ecp_group (sz: Z) (ofs: Z) (st: s_mbedtls_ecp_group) : option Z := *)
(*   if (ofs =? 0) then Some (st.(e_id)) else *)
(*   if (ofs >=? 8) && (ofs <? 32) then ( *)
(*     let elem_ofs := ofs - 8 in *)
(*     load_s_mbedtls_mpi sz elem_ofs (st.(e_P))) else *)
(*   if (ofs >=? 32) && (ofs <? 56) then ( *)
(*     let elem_ofs := ofs - 32 in *)
(*     load_s_mbedtls_mpi sz elem_ofs (st.(e_A))) else *)
(*   if (ofs >=? 56) && (ofs <? 80) then ( *)
(*     let elem_ofs := ofs - 56 in *)
(*     load_s_mbedtls_mpi sz elem_ofs (st.(e_B))) else *)
(*   if (ofs >=? 80) && (ofs <? 152) then ( *)
(*     let elem_ofs := ofs - 80 in *)
(*     load_s_mbedtls_ecp_point sz elem_ofs (st.(e_G))) else *)
(*   if (ofs >=? 152) && (ofs <? 176) then ( *)
(*     let elem_ofs := ofs - 152 in *)
(*     load_s_mbedtls_mpi sz elem_ofs (st.(e_N))) else *)
(*   if (ofs =? 176) then Some (st.(e_pbits)) else *)
(*   if (ofs =? 184) then Some (st.(e_nbits)) else *)
(*   if (ofs =? 192) then Some (st.(e_private_h)) else *)
(*   if (ofs =? 200) then Some (st.(e_private_modp)) else *)
(*   if (ofs =? 208) then Some (st.(e_private_t_pre)) else *)
(*   if (ofs =? 216) then Some (st.(e_private_t_post)) else *)
(*   if (ofs =? 224) then Some (st.(e_private_t_data)) else *)
(*   if (ofs =? 232) then Some (st.(e_private_T)) else *)
(*   if (ofs =? 240) then Some (st.(e_private_T_size)) else *)
(*   None. *)

(* Definition store_s_mbedtls_ecp_group (sz: Z) (ofs: Z) (v: Z) (st: s_mbedtls_ecp_group) : option s_mbedtls_ecp_group := *)
(*   if (ofs =? 0) then Some (st.[e_id] :< v) else *)
(*   if (ofs >=? 8) && (ofs <? 32) then ( *)
(*     let elem_ofs := ofs - 8 in *)
(*     when ret == store_s_mbedtls_mpi sz elem_ofs v st.(e_P); *)
(*     Some (st.[e_P] :< ret)) else *)
(*   if (ofs >=? 32) && (ofs <? 56) then ( *)
(*     let elem_ofs := ofs - 32 in *)
(*     when ret == store_s_mbedtls_mpi sz elem_ofs v st.(e_A); *)
(*     Some (st.[e_A] :< ret)) else *)
(*   if (ofs >=? 56) && (ofs <? 80) then ( *)
(*     let elem_ofs := ofs - 56 in *)
(*     when ret == store_s_mbedtls_mpi sz elem_ofs v st.(e_B); *)
(*     Some (st.[e_B] :< ret)) else *)
(*   if (ofs >=? 80) && (ofs <? 152) then ( *)
(*     let elem_ofs := ofs - 80 in *)
(*     when ret == store_s_mbedtls_ecp_point sz elem_ofs v st.(e_G); *)
(*     Some (st.[e_G] :< ret)) else *)
(*   if (ofs >=? 152) && (ofs <? 176) then ( *)
(*     let elem_ofs := ofs - 152 in *)
(*     when ret == store_s_mbedtls_mpi sz elem_ofs v st.(e_N); *)
(*     Some (st.[e_N] :< ret)) else *)
(*   if (ofs =? 176) then Some (st.[e_pbits] :< v) else *)
(*   if (ofs =? 184) then Some (st.[e_nbits] :< v) else *)
(*   if (ofs =? 192) then Some (st.[e_private_h] :< v) else *)
(*   if (ofs =? 200) then Some (st.[e_private_modp] :< v) else *)
(*   if (ofs =? 208) then Some (st.[e_private_t_pre] :< v) else *)
(*   if (ofs =? 216) then Some (st.[e_private_t_post] :< v) else *)
(*   if (ofs =? 224) then Some (st.[e_private_t_data] :< v) else *)
(*   if (ofs =? 232) then Some (st.[e_private_T] :< v) else *)
(*   if (ofs =? 240) then Some (st.[e_private_T_size] :< v) else *)
(*   None. *)

(* Definition load_s_mbedtls_ecp_keypair (sz: Z) (ofs: Z) (st: s_mbedtls_ecp_keypair) : option Z := *)
(*   if (ofs >=? 0) && (ofs <? 248) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     load_s_mbedtls_ecp_group sz elem_ofs (st.(e_private_grp))) else *)
(*   if (ofs >=? 248) && (ofs <? 272) then ( *)
(*     let elem_ofs := ofs - 248 in *)
(*     load_s_mbedtls_mpi sz elem_ofs (st.(e_private_d))) else *)
(*   if (ofs >=? 272) && (ofs <? 344) then ( *)
(*     let elem_ofs := ofs - 272 in *)
(*     load_s_mbedtls_ecp_point sz elem_ofs (st.(e_private_Q))) else *)
(*   None. *)

(* Definition store_s_mbedtls_ecp_keypair (sz: Z) (ofs: Z) (v: Z) (st: s_mbedtls_ecp_keypair) : option s_mbedtls_ecp_keypair := *)
(*   if (ofs >=? 0) && (ofs <? 248) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     when ret == store_s_mbedtls_ecp_group sz elem_ofs v st.(e_private_grp); *)
(*     Some (st.[e_private_grp] :< ret)) else *)
(*   if (ofs >=? 248) && (ofs <? 272) then ( *)
(*     let elem_ofs := ofs - 248 in *)
(*     when ret == store_s_mbedtls_mpi sz elem_ofs v st.(e_private_d); *)
(*     Some (st.[e_private_d] :< ret)) else *)
(*   if (ofs >=? 272) && (ofs <? 344) then ( *)
(*     let elem_ofs := ofs - 272 in *)
(*     when ret == store_s_mbedtls_ecp_point sz elem_ofs v st.(e_private_Q); *)
(*     Some (st.[e_private_Q] :< ret)) else *)
(*   None. *)

(* Definition load_s_t_cose_crypto_backend_ctx (sz: Z) (ofs: Z) (st: s_t_cose_crypto_backend_ctx) : option Z := *)
(*   if (ofs >=? 0) && (ofs <? 48) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     load_s_mbedtls_ecdsa_restart_ctx sz elem_ofs (st.(e_ecdsa_rst_ctx))) else *)
(*   if (ofs >=? 48) && (ofs <? 392) then ( *)
(*     let elem_ofs := ofs - 48 in *)
(*     load_s_mbedtls_ecp_keypair sz elem_ofs (st.(e_ecdsa_ctx))) else *)
(*   None. *)

(* Definition store_s_t_cose_crypto_backend_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_t_cose_crypto_backend_ctx) : option s_t_cose_crypto_backend_ctx := *)
(*   if (ofs >=? 0) && (ofs <? 48) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     when ret == store_s_mbedtls_ecdsa_restart_ctx sz elem_ofs v st.(e_ecdsa_rst_ctx); *)
(*     Some (st.[e_ecdsa_rst_ctx] :< ret)) else *)
(*   if (ofs >=? 48) && (ofs <? 392) then ( *)
(*     let elem_ofs := ofs - 48 in *)
(*     when ret == store_s_mbedtls_ecp_keypair sz elem_ofs v st.(e_ecdsa_ctx); *)
(*     Some (st.[e_ecdsa_ctx] :< ret)) else *)
(*   None. *)

(* Definition load_s_attest_token_encode_ctx (sz: Z) (ofs: Z) (st: s_attest_token_encode_ctx) : option Z := *)
(*   if (ofs >=? 0) && (ofs <? 176) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     load_s__QCBOREncodeContext sz elem_ofs (st.(e_cbor_enc_ctx))) else *)
(*   if (ofs =? 176) then Some (st.(e_opt_flags)) else *)
(*   if (ofs =? 180) then Some (st.(e_key_select)) else *)
(*   if (ofs >=? 184) && (ofs <? 280) then ( *)
(*     let elem_ofs := ofs - 184 in *)
(*     load_s_t_cose_sign1_sign_ctx sz elem_ofs (st.(e_signer_ctx))) else *)
(*   if (ofs >=? 280) && (ofs <? 560) then ( *)
(*     let elem_ofs := ofs - 280 in *)
(*     load_s_t_cose_sign1_sign_restart_ctx sz elem_ofs (st.(e_signer_restart_ctx))) else *)
(*   if (ofs >=? 560) && (ofs <? 952) then ( *)
(*     let elem_ofs := ofs - 560 in *)
(*     load_s_t_cose_crypto_backend_ctx sz elem_ofs (st.(e__crypto_ctx))) else *)
(*   None. *)

(* Definition store_s_attest_token_encode_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_attest_token_encode_ctx) : option s_attest_token_encode_ctx := *)
(*   if (ofs >=? 0) && (ofs <? 176) then ( *)
(*     let elem_ofs := ofs - 0 in *)
(*     when ret == store_s__QCBOREncodeContext sz elem_ofs v st.(e_cbor_enc_ctx); *)
(*     Some (st.[e_cbor_enc_ctx] :< ret)) else *)
(*   if (ofs =? 176) then Some (st.[e_opt_flags] :< v) else *)
(*   if (ofs =? 180) then Some (st.[e_key_select] :< v) else *)
(*   if (ofs >=? 184) && (ofs <? 280) then ( *)
(*     let elem_ofs := ofs - 184 in *)
(*     when ret == store_s_t_cose_sign1_sign_ctx sz elem_ofs v st.(e_signer_ctx); *)
(*     Some (st.[e_signer_ctx] :< ret)) else *)
(*   if (ofs >=? 280) && (ofs <? 560) then ( *)
(*     let elem_ofs := ofs - 280 in *)
(*     when ret == store_s_t_cose_sign1_sign_restart_ctx sz elem_ofs v st.(e_signer_restart_ctx); *)
(*     Some (st.[e_signer_restart_ctx] :< ret)) else *)
(*   if (ofs >=? 560) && (ofs <? 952) then ( *)
(*     let elem_ofs := ofs - 560 in *)
(*     when ret == store_s_t_cose_crypto_backend_ctx sz elem_ofs v st.(e__crypto_ctx); *)
(*     Some (st.[e__crypto_ctx] :< ret)) else *)
(*   None. *)

(* Definition load_s_token_sign_ctx (sz: Z) (ofs: Z) (st: s_token_sign_ctx) : option Z := *)
(*   if (ofs =? 0) then Some (st.(e_state)) else *)
(*   if (ofs >=? 8) && (ofs <? 960) then ( *)
(*     let elem_ofs := ofs - 8 in *)
(*     load_s_attest_token_encode_ctx sz elem_ofs (st.(e_ctx))) else *)
(*   if (ofs =? 960) then Some (st.(e_token_ipa)) else *)
(*   if (ofs >=? 968) && (ofs <? 1032) then ( *)
(*     let idx := (ofs - 968) / 1 in *)
(*     Some (st.(e_challenge) @ idx)) else *)
(*   None. *)

(* Definition store_s_token_sign_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_token_sign_ctx) : option s_token_sign_ctx := *)
(*   if (ofs =? 0) then Some (st.[e_state] :< v) else *)
(*   if (ofs >=? 8) && (ofs <? 960) then ( *)
(*     let elem_ofs := ofs - 8 in *)
(*     when ret == store_s_attest_token_encode_ctx sz elem_ofs v st.(e_ctx); *)
(*     Some (st.[e_ctx] :< ret)) else *)
(*   if (ofs =? 960) then Some (st.[e_token_ipa] :< v) else *)
(*   if (ofs >=? 968) && (ofs <? 1032) then ( *)
(*     let idx := (ofs - 968) / 1 in *)
(*     Some (st.[e_challenge] :< (st.(e_challenge) # idx == v))) else *)
(*   None. *)

Definition load_s_buffer_alloc_ctx (sz: Z) (ofs: Z) (st: s_buffer_alloc_ctx) : option Z :=
  if (ofs =? 0) then Some (st.(e_buf)) else
  if (ofs =? 8) then Some (st.(e__len)) else
  if (ofs =? 16) then Some (st.(e_first)) else
  if (ofs =? 24) then Some (st.(e_first_free)) else
  if (ofs =? 32) then Some (st.(e_verify)) else
  None.

Definition store_s_buffer_alloc_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_buffer_alloc_ctx) : option s_buffer_alloc_ctx :=
  if (ofs =? 0) then Some (st.[e_buf] :< v) else
  if (ofs =? 8) then Some (st.[e__len] :< v) else
  if (ofs =? 16) then Some (st.[e_first] :< v) else
  if (ofs =? 24) then Some (st.[e_first_free] :< v) else
  if (ofs =? 32) then Some (st.[e_verify] :< v) else
  None.

Definition load_s_alloc_info (sz: Z) (ofs: Z) (st: s_alloc_info) : option Z :=
  if (ofs >=? 0) && (ofs <? 40) then (
    let elem_ofs := ofs - 0 in
    load_s_buffer_alloc_ctx sz elem_ofs (st.(e__ctx))) else
  if (ofs =? 40) then Some (st.(e_ctx_initialised)) else
  None.

Definition store_s_alloc_info (sz: Z) (ofs: Z) (v: Z) (st: s_alloc_info) : option s_alloc_info :=
  if (ofs >=? 0) && (ofs <? 40) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_buffer_alloc_ctx sz elem_ofs v st.(e__ctx);
    Some (st.[e__ctx] :< ret)) else
  if (ofs =? 40) then Some (st.[e_ctx_initialised] :< v) else
  None.

Definition load_s_serror_info (sz: Z) (ofs: Z) (st: s_serror_info) : option Z :=
  if (ofs =? 0) then Some (st.(e_vsesr_el2)) else
  if (ofs =? 8) then Some (st.(e_inject)) else
  None.

Definition store_s_serror_info (sz: Z) (ofs: Z) (v: Z) (st: s_serror_info) : option s_serror_info :=
  if (ofs =? 0) then Some (st.[e_vsesr_el2] :< v) else
  if (ofs =? 8) then Some (st.[e_inject] :< v) else
  None.

Definition load_s_rec (sz: Z) (ofs: Z) (st: s_rec) : option Z :=
  if (ofs =? 0) then Some (st.(e_g_rec)) else
  if (ofs =? 8) then Some (st.(e_rec_idx)) else
  if (ofs =? 16) then Some (st.(e_runnable)) else
  if (ofs >=? 24) && (ofs <? 272) then (
    let idx := (ofs - 24) / 8 in
    Some (st.(e_regs) @ idx)) else
  if (ofs =? 272) then Some (st.(e_pc)) else
  if (ofs =? 280) then Some (st.(e_pstate)) else
  if (ofs >=? 288) && (ofs <? 816) then (
    let elem_ofs := ofs - 288 in
    load_s_sysreg_state sz elem_ofs (st.(e_sysregs))) else
  if (ofs >=? 816) && (ofs <? 848) then (
    let elem_ofs := ofs - 816 in
    load_s_common_sysreg_state sz elem_ofs (st.(e_common_sysregs))) else
  if (ofs >=? 848) && (ofs <? 880) then (
    let elem_ofs := ofs - 848 in
    load_s_set_ripas sz elem_ofs (st.(e_set_ripas))) else
  if (ofs >=? 880) && (ofs <? 928) then (
    let elem_ofs := ofs - 880 in
    load_s_realm_info sz elem_ofs (st.(e_realm_info))) else
  if (ofs >=? 928) && (ofs <? 952) then (
    let elem_ofs := ofs - 928 in
    load_s_last_run_info sz elem_ofs (st.(e_last_run_info))) else
  if (ofs =? 952) then Some (st.(e_ns)) else
  if (ofs >=? 960) && (ofs <? 961) then (
    let elem_ofs := ofs - 960 in
    load_s_psci_info sz elem_ofs (st.(e_psci_info))) else
  if (ofs =? 964) then Some (st.(e_num_rec_aux)) else
  if (ofs >=? 968) && (ofs <? 1096) then (
    let idx := (ofs - 968) / 8 in
    Some (st.(e_g_aux) @ idx)) else
  if (ofs >=? 1096) && (ofs <? 1128) then (
    let elem_ofs := ofs - 1096 in
    load_s_rec_aux_data sz elem_ofs (st.(e_aux_data))) else
  (* if (ofs >=? 1128) && (ofs <? 2152) then ( *)
  (*   let idx := (ofs - 1128) / 1 in *)
  (*   Some (st.(e_rmm_realm_token_buf) @ idx)) else *)
  (* if (ofs >=? 2152) && (ofs <? 2168) then ( *)
  (*   let elem_ofs := ofs - 2152 in *)
  (*   load_s_q_useful_buf sz elem_ofs (st.(e_rmm_realm_token))) else *)
  (* if (ofs >=? 2168) && (ofs <? 3200) then ( *)
  (*   let elem_ofs := ofs - 2168 in *)
  (*   load_s_token_sign_ctx sz elem_ofs (st.(e_token_sign_ctx))) else *)
  if (ofs >=? 3200) && (ofs <? 3248) then (
    let elem_ofs := ofs - 3200 in
    load_s_alloc_info sz elem_ofs (st.(e_alloc_info))) else
  if (ofs >=? 3248) && (ofs <? 3264) then (
    let elem_ofs := ofs - 3248 in
    load_s_serror_info sz elem_ofs (st.(e_serror_info))) else
  if (ofs =? 3264) then Some (st.(e_host_call)) else
  None.

Definition store_s_rec (sz: Z) (ofs: Z) (v: Z) (st: s_rec) : option s_rec :=
  if (ofs =? 0) then Some (st.[e_g_rec] :< v) else
  if (ofs =? 8) then Some (st.[e_rec_idx] :< v) else
  if (ofs =? 16) then Some (st.[e_runnable] :< v) else
  if (ofs >=? 24) && (ofs <? 272) then (
    let idx := (ofs - 24) / 8 in
    Some (st.[e_regs] :< (st.(e_regs) # idx == v))) else
  if (ofs =? 272) then Some (st.[e_pc] :< v) else
  if (ofs =? 280) then Some (st.[e_pstate] :< v) else
  if (ofs >=? 288) && (ofs <? 816) then (
    let elem_ofs := ofs - 288 in
    when ret == store_s_sysreg_state sz elem_ofs v st.(e_sysregs);
    Some (st.[e_sysregs] :< ret)) else
  if (ofs >=? 816) && (ofs <? 848) then (
    let elem_ofs := ofs - 816 in
    when ret == store_s_common_sysreg_state sz elem_ofs v st.(e_common_sysregs);
    Some (st.[e_common_sysregs] :< ret)) else
  if (ofs >=? 848) && (ofs <? 880) then (
    let elem_ofs := ofs - 848 in
    when ret == store_s_set_ripas sz elem_ofs v st.(e_set_ripas);
    Some (st.[e_set_ripas] :< ret)) else
  if (ofs >=? 880) && (ofs <? 928) then (
    let elem_ofs := ofs - 880 in
    when ret == store_s_realm_info sz elem_ofs v st.(e_realm_info);
    Some (st.[e_realm_info] :< ret)) else
  if (ofs >=? 928) && (ofs <? 952) then (
    let elem_ofs := ofs - 928 in
    when ret == store_s_last_run_info sz elem_ofs v st.(e_last_run_info);
    Some (st.[e_last_run_info] :< ret)) else
  if (ofs =? 952) then Some (st.[e_ns] :< v) else
  if (ofs >=? 960) && (ofs <? 961) then (
    let elem_ofs := ofs - 960 in
    when ret == store_s_psci_info sz elem_ofs v st.(e_psci_info);
    Some (st.[e_psci_info] :< ret)) else
  if (ofs =? 964) then Some (st.[e_num_rec_aux] :< v) else
  if (ofs >=? 968) && (ofs <? 1096) then (
    let idx := (ofs - 968) / 8 in
    Some (st.[e_g_aux] :< (st.(e_g_aux) # idx == v))) else
  if (ofs >=? 1096) && (ofs <? 1128) then (
    let elem_ofs := ofs - 1096 in
    when ret == store_s_rec_aux_data sz elem_ofs v st.(e_aux_data);
    Some (st.[e_aux_data] :< ret)) else
  (* if (ofs >=? 1128) && (ofs <? 2152) then ( *)
  (*   let idx := (ofs - 1128) / 1 in *)
  (*   Some (st.[e_rmm_realm_token_buf] :< (st.(e_rmm_realm_token_buf) # idx == v))) else *)
  (* if (ofs >=? 2152) && (ofs <? 2168) then ( *)
  (*   let elem_ofs := ofs - 2152 in *)
  (*   when ret == store_s_q_useful_buf sz elem_ofs v st.(e_rmm_realm_token); *)
  (*   Some (st.[e_rmm_realm_token] :< ret)) else *)
  (* if (ofs >=? 2168) && (ofs <? 3200) then ( *)
  (*   let elem_ofs := ofs - 2168 in *)
  (*   when ret == store_s_token_sign_ctx sz elem_ofs v st.(e_token_sign_ctx); *)
  (*   Some (st.[e_token_sign_ctx] :< ret)) else *)
  if (ofs >=? 3200) && (ofs <? 3248) then (
    let elem_ofs := ofs - 3200 in
    when ret == store_s_alloc_info sz elem_ofs v st.(e_alloc_info);
    Some (st.[e_alloc_info] :< ret)) else
  if (ofs >=? 3248) && (ofs <? 3264) then (
    let elem_ofs := ofs - 3248 in
    when ret == store_s_serror_info sz elem_ofs v st.(e_serror_info);
    Some (st.[e_serror_info] :< ret)) else
  if (ofs =? 3264) then Some (st.[e_host_call] :< v) else
  None.

