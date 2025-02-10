Require Import CommonDeps.
Require Import DataTypes.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter CPU_ID : Z.

Parameter vmpidr_is_valid_para: (Z -> (bool)).

Parameter vmpidr_to_rec_idx_para: (Z -> (Z)).

Parameter s2_addr_to_idx_para : Z -> Z -> Z.

Parameter empty_rec : s_rec.

Parameter empty_rd : s_rd.

Parameter lens : Z -> (RData -> RData).

Parameter g_mapped_addr_set_para : Z -> Z -> Z.

Parameter pack_struct_return_code_para : Z -> Z.

Parameter make_return_code_para : Z -> Z.

Parameter test_PTE_Z : abs_PTE_t -> Z.

Parameter test_Z_PTE : Z -> abs_PTE_t.

Parameter uart0_phys_para : abs_PTE_t -> bool.

Parameter test_PA : Z -> abs_PA_t.

Parameter g_refcount_para : Ptr -> (RData -> Z).

Parameter rec_to_rd_para : Ptr -> (RData -> Ptr).

Parameter test_Ptr_PTE : Ptr -> abs_PTE_t.

Parameter rec_to_ttbr1_para : Ptr -> (RData -> Ptr).

Parameter check_rcsm_mask_para : abs_PA_t -> bool.

Parameter abs_tte_read : Ptr -> (RData -> abs_PTE_t).

Section GlobalDefs.

  Context `{int_ptr: IntPtrCast}.

  Definition ptr_offset (_ptr: Ptr) (_offs: Z) : Ptr :=
    (mkPtr (_ptr.(pbase)) ((_ptr.(poffset)) + (_offs))).

  Definition bool_to_int (_b: bool) : Z :=
    if _b
    then 1
    else 0.

  Definition MAX_ERR  : Z :=
    18446744039349813248.

  Definition HEAP_BASE  : Z :=
    67108864.

  Definition DEBUG_EXITS_BASE  : Z :=
    67112960.

  Definition VMID_COUNT_BASE  : Z :=
    67117056.

  Definition VMID_LOCK_BASE  : Z :=
    67121152.

  Definition VMIDS_BASE  : Z :=
    67125248.

  Definition NR_LRS_BASE  : Z :=
    67133440.

  Definition NR_APRS_BASE  : Z :=
    67137536.

  Definition MAX_VINTID_BASE  : Z :=
    67141632.

  Definition NR_PRI_BITS_BASE  : Z :=
    67145728.

  Definition PRI_RES0_MASK_BASE  : Z :=
    67149824.

  Definition DEFAULT_GICSTATE_BASE  : Z :=
    67153920.

  Definition STATUS_HANDLER_BASE  : Z :=
    67158016.

  Definition RMM_TRAP_LIST_BASE  : Z :=
    67162112.

  Definition TT_L3_BUFFER_BASE  : Z :=
    67166208.

  Definition TT_L2_MEM0_0_BASE  : Z :=
    67170304.

  Definition TT_L2_MEM0_1_BASE  : Z :=
    67174400.

  Definition TT_L2_MEM1_0_BASE  : Z :=
    67178496.

  Definition TT_L2_MEM1_1_BASE  : Z :=
    67182592.

  Definition TT_L2_MEM1_2_BASE  : Z :=
    67186688.

  Definition TT_L2_MEM1_3_BASE  : Z :=
    67190784.

  Definition TT_L3_MEM0_BASE  : Z :=
    67194880.

  Definition TT_L3_MEM1_BASE  : Z :=
    71389184.

  Definition MBEDTLS_MEM_BUF_BASE  : Z :=
    79777792.

  Definition RMM_ATTEST_SIGNING_KEY_BASE  : Z :=
    105336832.

  Definition RMM_ATTEST_PUBLIC_KEY_BASE  : Z :=
    105340928.

  Definition RMM_ATTEST_PUBLIC_KEY_LEN_BASE  : Z :=
    105345024.

  Definition RMM_ATTEST_PUBLIC_KEY_HASH_BASE  : Z :=
    105349120.

  Definition RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE  : Z :=
    105353216.

  Definition PLATFORM_TOKEN_BUF_BASE  : Z :=
    105357312.

  Definition RMM_PLATFORM_TOKEN_BASE  : Z :=
    105361408.

  Definition RMM_REALM_TOKEN_BUFS_BASE  : Z :=
    105365504.

  Definition GET_REALM_IDENTITY_IDENTITY_BASE  : Z :=
    105431040.

  Definition REALM_ATTEST_PRIVATE_KEY_BASE  : Z :=
    105435136.

  Definition MAX_GLOBAL  : Z :=
    105439232.

  Definition STACK_TYPE_4_BASE  : Z :=
    110000000.

  Definition STACK_TYPE_4__1_BASE  : Z :=
    120000000.

  Definition GRANULES_BASE  : Z :=
    130000000.

  Definition GRANULE_SIZE  : Z :=
    4096.

  Definition MEM0_PHYS  : Z :=
    2147483648.

  Definition MEM1_PHYS  : Z :=
    551903297536.

  Definition MEM0_VIRT  : Z :=
    18446744007137558528.

  Definition MEM1_VIRT  : Z :=
    18446744009285042176.

  Definition MEM0_SIZE  : Z :=
    2147483648.

  Definition MEM1_SIZE  : Z :=
    4294967296.

  Definition NR_GRANULES  : Z :=
    1572864.

  Definition load_s_buffer_alloc_ctx (sz: Z) (ofs: Z) (st: s_buffer_alloc_ctx) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_buf)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_len)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_first)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_first_free)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_verify)))
            else None)))).

  Definition store_s_buffer_alloc_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_buffer_alloc_ctx) : (option s_buffer_alloc_ctx) :=
    if (ofs =? (0))
    then (Some (st.[e_buf] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_len] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_first] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_first_free] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_verify] :< v))
            else None)))).

  Definition load_s__memory_header (sz: Z) (ofs: Z) (st: s__memory_header) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_magic1)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_size)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_alloc)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_prev)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_next)))
            else (
              if (ofs =? (40))
              then (Some (st.(e_prev_free)))
              else (
                if (ofs =? (48))
                then (Some (st.(e_next_free)))
                else (
                  if (ofs =? (56))
                  then (Some (st.(e_magic2)))
                  else None))))))).

  Definition store_s__memory_header (sz: Z) (ofs: Z) (v: Z) (st: s__memory_header) : (option s__memory_header) :=
    if (ofs =? (0))
    then (Some (st.[e_magic1] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_size] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_alloc] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_prev] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_next] :< v))
            else (
              if (ofs =? (40))
              then (Some (st.[e_prev_free] :< v))
              else (
                if (ofs =? (48))
                then (Some (st.[e_next_free] :< v))
                else (
                  if (ofs =? (56))
                  then (Some (st.[e_magic2] :< v))
                  else None))))))).

  Definition load_s_spinlock_t (sz: Z) (ofs: Z) (st: s_spinlock_t) : (option Z) :=
    if (ofs =? (0))
    then (st.(e_val))
    else None.

  Definition store_s_spinlock_t (sz: Z) (ofs: Z) (v: Z) (st: s_spinlock_t) : (option s_spinlock_t) :=
    if (ofs =? (0))
    then (Some (st.[e_val] :< (Some v)))
    else None.

  Definition load_s_gic_cpu_state (sz: Z) (ofs: Z) (st: s_gic_cpu_state) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some ((st.(e_ich_ap0r)) @ idx)))
    else (
      if ((ofs >=? (32)) && ((ofs <? (64))))
      then (
        let idx := ((ofs - (32)) / (8)) in
        (Some ((st.(e_ich_ap1r)) @ idx)))
      else (
        if (ofs =? (64))
        then (Some (st.(e_ich_vmcr)))
        else (
          if (ofs =? (72))
          then (Some (st.(e_ich_hcr)))
          else (
            if ((ofs >=? (80)) && ((ofs <? (208))))
            then (
              let idx := ((ofs - (80)) / (8)) in
              (Some ((st.(e_ich_lr)) @ idx)))
            else (
              if (ofs =? (208))
              then (Some (st.(e_ich_misr)))
              else None))))).

  Definition store_s_gic_cpu_state (sz: Z) (ofs: Z) (v: Z) (st: s_gic_cpu_state) : (option s_gic_cpu_state) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some (st.[e_ich_ap0r] :< ((st.(e_ich_ap0r)) # idx == v))))
    else (
      if ((ofs >=? (32)) && ((ofs <? (64))))
      then (
        let idx := ((ofs - (32)) / (8)) in
        (Some (st.[e_ich_ap1r] :< ((st.(e_ich_ap1r)) # idx == v))))
      else (
        if (ofs =? (64))
        then (Some (st.[e_ich_vmcr] :< v))
        else (
          if (ofs =? (72))
          then (Some (st.[e_ich_hcr] :< v))
          else (
            if ((ofs >=? (80)) && ((ofs <? (208))))
            then (
              let idx := ((ofs - (80)) / (8)) in
              (Some (st.[e_ich_lr] :< ((st.(e_ich_lr)) # idx == v))))
            else (
              if (ofs =? (208))
              then (Some (st.[e_ich_misr] :< v))
              else None))))).

  Definition load_s_smc_handler (sz: Z) (ofs: Z) (st: s_smc_handler) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_fn_name)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_type)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_f0)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_f1)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_f2)))
            else (
              if (ofs =? (40))
              then (Some (st.(e_f3)))
              else (
                if (ofs =? (48))
                then (Some (st.(e_f4)))
                else (
                  if (ofs =? (56))
                  then (Some (st.(e_f1_o)))
                  else (
                    if (ofs =? (64))
                    then (Some (st.(e_f2_o)))
                    else (
                      if (ofs =? (72))
                      then (Some (st.(e_f3_o)))
                      else (
                        if (ofs =? (80))
                        then (Some (st.(e_f4_o)))
                        else (
                          if (ofs =? (88))
                          then (Some (st.(e_log_exec)))
                          else (
                            if (ofs =? (89))
                            then (Some (st.(e_log_error)))
                            else None)))))))))))).

  Definition store_s_smc_handler (sz: Z) (ofs: Z) (v: Z) (st: s_smc_handler) : (option s_smc_handler) :=
    if (ofs =? (0))
    then (Some (st.[e_fn_name] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_type] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_f0] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_f1] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_f2] :< v))
            else (
              if (ofs =? (40))
              then (Some (st.[e_f3] :< v))
              else (
                if (ofs =? (48))
                then (Some (st.[e_f4] :< v))
                else (
                  if (ofs =? (56))
                  then (Some (st.[e_f1_o] :< v))
                  else (
                    if (ofs =? (64))
                    then (Some (st.[e_f2_o] :< v))
                    else (
                      if (ofs =? (72))
                      then (Some (st.[e_f3_o] :< v))
                      else (
                        if (ofs =? (80))
                        then (Some (st.[e_f4_o] :< v))
                        else (
                          if (ofs =? (88))
                          then (Some (st.[e_log_exec] :< v))
                          else (
                            if (ofs =? (89))
                            then (Some (st.[e_log_error] :< v))
                            else None)))))))))))).

  Definition load_s_smc_result (sz: Z) (ofs: Z) (st: s_smc_result) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_x0)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_x1)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_x2)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_x3)))
          else None))).

  Definition store_s_smc_result (sz: Z) (ofs: Z) (v: Z) (st: s_smc_result) : (option s_smc_result) :=
    if (ofs =? (0))
    then (Some (st.[e_x0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_x1] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_x2] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_x3] :< v))
          else None))).

  Definition load_s_rmm_trap_element (sz: Z) (ofs: Z) (st: s_rmm_trap_element) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_aborted_pc)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_new_pc)))
      else None).

  Definition store_s_rmm_trap_element (sz: Z) (ofs: Z) (v: Z) (st: s_rmm_trap_element) : (option s_rmm_trap_element) :=
    if (ofs =? (0))
    then (Some (st.[e_aborted_pc] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_new_pc] :< v))
      else None).

  Definition load_s_sysreg_handler (sz: Z) (ofs: Z) (st: s_sysreg_handler) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_esr_mask)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_esr_value)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_fn)))
        else None)).

  Definition store_s_sysreg_handler (sz: Z) (ofs: Z) (v: Z) (st: s_sysreg_handler) : (option s_sysreg_handler) :=
    if (ofs =? (0))
    then (Some (st.[e_esr_mask] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_esr_value] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_fn] :< v))
        else None)).

  Definition load_s_common_sysreg_state (sz: Z) (ofs: Z) (st: s_common_sysreg_state) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_vttbr_el2)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_vtcr_el2)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_hcr_el2_common_flags)))
        else None)).

  Definition store_s_common_sysreg_state (sz: Z) (ofs: Z) (v: Z) (st: s_common_sysreg_state) : (option s_common_sysreg_state) :=
    if (ofs =? (0))
    then (Some (st.[e_vttbr_el2] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_vtcr_el2] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_hcr_el2_common_flags] :< v))
        else None)).

  Definition load_s_anon_1 (sz: Z) (ofs: Z) (st: s_anon_1) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_s_anon_1_0)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_s_anon_1_1)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_s_anon_1_2)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_s_anon_1_3)))
          else None))).

  Definition store_s_anon_1 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_1) : (option s_anon_1) :=
    if (ofs =? (0))
    then (Some (st.[e_s_anon_1_0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_s_anon_1_1] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_s_anon_1_2] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_s_anon_1_3] :< v))
          else None))).

  Definition load_s_anon_0 (sz: Z) (ofs: Z) (st: s_anon_0) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_s_anon_0_0)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_s_anon_0_1)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_s_anon_0_2)))
        else None)).

  Definition store_s_anon_0 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_0) : (option s_anon_0) :=
    if (ofs =? (0))
    then (Some (st.[e_s_anon_0_0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_s_anon_0_1] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_s_anon_0_2] :< v))
        else None)).

  Definition load_s_anon_1_2 (sz: Z) (ofs: Z) (st: s_anon_1_2) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_s_anon_1_2_0)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_s_anon_1_2_1)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_s_anon_1_2_2)))
        else (
          if (ofs =? (24))
          then (
            rely (((st.(e_g_rd_s_realm_info)) >= (GRANULES_BASE)));
            rely (((st.(e_g_rd_s_realm_info)) < (MEM0_VIRT)));
            (Some (st.(e_g_rd_s_realm_info))))
          else None))).

  Definition store_s_anon_1_2 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_1_2) : (option s_anon_1_2) :=
    if (ofs =? (0))
    then (Some (st.[e_s_anon_1_2_0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_s_anon_1_2_1] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_s_anon_1_2_2] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_g_rd_s_realm_info] :< v))
          else None))).

  Definition load_u_anon_3 (sz: Z) (ofs: Z) (st: u_anon_3) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_u_anon_3_0)))
    else None.

  Definition store_u_anon_3 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_3) : (option u_anon_3) :=
    if (ofs =? (0))
    then (Some (st.[e_u_anon_3_0] :< v))
    else None.

  Definition load_s_fpu_state (sz: Z) (ofs: Z) (st: s_fpu_state) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (512))))
    then (
      let idx := ((ofs - (0)) / (16)) in
      (Some ((st.(e_q)) @ idx)))
    else (
      if (ofs =? (512))
      then (Some (st.(e_fpsr)))
      else (
        if (ofs =? (520))
        then (Some (st.(e_fpcr)))
        else (
          if (ofs =? (528))
          then (Some (st.(e_used)))
          else None))).

  Definition store_s_fpu_state (sz: Z) (ofs: Z) (v: Z) (st: s_fpu_state) : (option s_fpu_state) :=
    if ((ofs >=? (0)) && ((ofs <? (512))))
    then (
      let idx := ((ofs - (0)) / (16)) in
      (Some (st.[e_q] :< ((st.(e_q)) # idx == v))))
    else (
      if (ofs =? (512))
      then (Some (st.[e_fpsr] :< v))
      else (
        if (ofs =? (520))
        then (Some (st.[e_fpcr] :< v))
        else (
          if (ofs =? (528))
          then (Some (st.[e_used] :< v))
          else None))).

  Definition load_s_anon_3 (sz: Z) (ofs: Z) (st: s_anon_3) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_s_anon_3_0)))
    else None.

  Definition store_s_anon_3 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_3) : (option s_anon_3) :=
    if (ofs =? (0))
    then (Some (st.[e_s_anon_3_0] :< v))
    else None.

  Definition load_s_realm_s1_context (sz: Z) (ofs: Z) (st: s_realm_s1_context) : (option Z) :=
    if (ofs =? (0))
    then (
      rely ((((st.(e_g_ttbr0)) >= (GRANULES_BASE)) /\ (((st.(e_g_ttbr0)) < (MEM0_VIRT)))));
      (Some (st.(e_g_ttbr0))))
    else (
      if (ofs =? (8))
      then (
        rely ((((st.(e_g_ttbr1)) >= (GRANULES_BASE)) /\ (((st.(e_g_ttbr1)) < (MEM0_VIRT)))));
        (Some (st.(e_g_ttbr1))))
      else None).

  Definition store_s_realm_s1_context (sz: Z) (ofs: Z) (v: Z) (st: s_realm_s1_context) : (option s_realm_s1_context) :=
    if (ofs =? (0))
    then (Some (st.[e_g_ttbr0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_g_ttbr1] :< v))
      else None).

  Definition load_s_s1tt (sz: Z) (ofs: Z) (st: s_s1tt) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (4096))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some ((st.(e_s1tte)) @ idx)))
    else None.

  Definition store_s_s1tt (sz: Z) (ofs: Z) (v: Z) (st: s_s1tt) : (option s_s1tt) :=
    if ((ofs >=? (0)) && ((ofs <? (4096))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some (st.[e_s1tte] :< ((st.(e_s1tte)) # idx == v))))
    else None.

  Definition load_s_q_useful_buf (sz: Z) (ofs: Z) (st: s_q_useful_buf) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_ptr)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_len_s_q_useful_buf)))
      else None).

  Definition store_s_q_useful_buf (sz: Z) (ofs: Z) (v: Z) (st: s_q_useful_buf) : (option s_q_useful_buf) :=
    if (ofs =? (0))
    then (Some (st.[e_ptr] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_len_s_q_useful_buf] :< v))
      else None).

  Definition load_s_std____va_list (sz: Z) (ofs: Z) (st: s_std____va_list) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_s_std____va_list_0)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_s_std____va_list_1)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_s_std____va_list_2)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_s_std____va_list_3)))
          else (
            if (ofs =? (28))
            then (Some (st.(e_s_std____va_list_4)))
            else None)))).

  Definition store_s_std____va_list (sz: Z) (ofs: Z) (v: Z) (st: s_std____va_list) : (option s_std____va_list) :=
    if (ofs =? (0))
    then (Some (st.[e_s_std____va_list_0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_s_std____va_list_1] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_s_std____va_list_2] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_s_std____va_list_3] :< v))
          else (
            if (ofs =? (28))
            then (Some (st.[e_s_std____va_list_4] :< v))
            else None)))).

  Definition load_s_out_fct_wrap_type (sz: Z) (ofs: Z) (st: s_out_fct_wrap_type) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_fct)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_arg)))
      else None).

  Definition store_s_out_fct_wrap_type (sz: Z) (ofs: Z) (v: Z) (st: s_out_fct_wrap_type) : (option s_out_fct_wrap_type) :=
    if (ofs =? (0))
    then (Some (st.[e_fct] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_arg] :< v))
      else None).

  Definition load_s_mbedtls_sha256_context (sz: Z) (ofs: Z) (st: s_mbedtls_sha256_context) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (8))))
    then (
      let idx := ((ofs - (0)) / (4)) in
      (Some ((st.(e_total)) @ idx)))
    else (
      if ((ofs >=? (8)) && ((ofs <? (40))))
      then (
        let idx := ((ofs - (8)) / (4)) in
        (Some ((st.(e_state)) @ idx)))
      else (
        if ((ofs >=? (40)) && ((ofs <? (104))))
        then (
          let idx := ((ofs - (40)) / (1)) in
          (Some ((st.(e_buffer)) @ idx)))
        else (
          if (ofs =? (104))
          then (Some (st.(e_is224)))
          else None))).

  Definition store_s_mbedtls_sha256_context (sz: Z) (ofs: Z) (v: Z) (st: s_mbedtls_sha256_context) : (option s_mbedtls_sha256_context) :=
    if ((ofs >=? (0)) && ((ofs <? (8))))
    then (
      let idx := ((ofs - (0)) / (4)) in
      (Some (st.[e_total] :< ((st.(e_total)) # idx == v))))
    else (
      if ((ofs >=? (8)) && ((ofs <? (40))))
      then (
        let idx := ((ofs - (8)) / (4)) in
        (Some (st.[e_state] :< ((st.(e_state)) # idx == v))))
      else (
        if ((ofs >=? (40)) && ((ofs <? (104))))
        then (
          let idx := ((ofs - (40)) / (1)) in
          (Some (st.[e_buffer] :< ((st.(e_buffer)) # idx == v))))
        else (
          if (ofs =? (104))
          then (Some (st.[e_is224] :< v))
          else None))).

  Definition load_u_anon (sz: Z) (ofs: Z) (st: u_anon) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some ((st.(e_u_anon_0)) @ idx)))
    else None.

  Definition store_u_anon (sz: Z) (ofs: Z) (v: Z) (st: u_anon) : (option u_anon) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some (st.[e_u_anon_0] :< ((st.(e_u_anon_0)) # idx == v))))
    else None.

  Definition load_s_anon (sz: Z) (ofs: Z) (st: s_anon) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_s_anon_0)))
    else (
      if (ofs =? (4))
      then (Some (st.(e_s_anon_1)))
      else (
        if (ofs =? (6))
        then (Some (st.(e_s_anon_2)))
        else None)).

  Definition store_s_anon (sz: Z) (ofs: Z) (v: Z) (st: s_anon) : (option s_anon) :=
    if (ofs =? (0))
    then (Some (st.[e_s_anon_0] :< v))
    else (
      if (ofs =? (4))
      then (Some (st.[e_s_anon_1] :< v))
      else (
        if (ofs =? (6))
        then (Some (st.[e_s_anon_2] :< v))
        else None)).

  Definition load_u_anon_0 (sz: Z) (ofs: Z) (st: u_anon_0) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_u_anon_0_0)))
    else None.

  Definition store_u_anon_0 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_0) : (option u_anon_0) :=
    if (ofs =? (0))
    then (Some (st.[e_u_anon_0_0] :< v))
    else None.

  Definition load_s_return_code_t (sz: Z) (ofs: Z) (st: s_return_code_t) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_status)))
    else (
      if (ofs =? (4))
      then (Some (st.(e_index)))
      else None).

  Definition store_s_return_code_t (sz: Z) (ofs: Z) (v: Z) (st: s_return_code_t) : (option s_return_code_t) :=
    if (ofs =? (0))
    then (Some (st.[e_status] :< v))
    else (
      if (ofs =? (4))
      then (Some (st.[e_index] :< v))
      else None).

  Definition load_s_rtt_walk (sz: Z) (ofs: Z) (st: s_rtt_walk) : (option Z) :=
    if (ofs =? (0))
    then (
      rely (((st.(e_g_llt)) >= (GRANULES_BASE)));
      rely (((st.(e_g_llt)) < (MEM0_VIRT)));
      (Some (st.(e_g_llt))))
    else (
      if (ofs =? (8))
      then (Some (st.(e_index_s_rtt_walk)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_last_level)))
        else None)).

  Definition store_s_rtt_walk (sz: Z) (ofs: Z) (v: Z) (st: s_rtt_walk) : (option s_rtt_walk) :=
    if (ofs =? (0))
    then (Some (st.[e_g_llt] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_index_s_rtt_walk] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_last_level] :< v))
        else None)).

  Definition load_s_realm_s2_context (sz: Z) (ofs: Z) (st: s_realm_s2_context) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_ipa_bits)))
    else (
      if (ofs =? (4))
      then (Some (st.(e_s2_starting_level)))
      else (
        if (ofs =? (8))
        then (Some (st.(e_num_root_rtts)))
        else (
          if (ofs =? (16))
          then (
            rely (((st.(e_g_rtt)) >= (GRANULES_BASE)));
            rely (((st.(e_g_rtt)) < (MEM0_VIRT)));
            (Some (st.(e_g_rtt))))
          else (
            if (ofs =? (24))
            then (Some (st.(e_vmid)))
            else None)))).

  Definition store_s_realm_s2_context (sz: Z) (ofs: Z) (v: Z) (st: s_realm_s2_context) : (option s_realm_s2_context) :=
    if (ofs =? (0))
    then (Some (st.[e_ipa_bits] :< v))
    else (
      if (ofs =? (4))
      then (Some (st.[e_s2_starting_level] :< v))
      else (
        if (ofs =? (8))
        then (Some (st.[e_num_root_rtts] :< v))
        else (
          if (ofs =? (16))
          then (Some (st.[e_g_rtt] :< v))
          else (
            if (ofs =? (24))
            then (Some (st.[e_vmid] :< v))
            else None)))).

  Definition load_s_anon_5 (sz: Z) (ofs: Z) (st: s_anon_5) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_s_anon_5_0)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_s_anon_5_1)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_s_anon_5_2)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_s_anon_5_3)))
          else None))).

  Definition store_s_anon_5 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_5) : (option s_anon_5) :=
    if (ofs =? (0))
    then (Some (st.[e_s_anon_5_0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_s_anon_5_1] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_s_anon_5_2] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_s_anon_5_3] :< v))
          else None))).

  Definition load_s_rec_entry (sz: Z) (ofs: Z) (st: s_rec_entry) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (56))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some ((st.(e_gprs)) @ idx)))
    else (
      if (ofs =? (56))
      then (Some (st.(e_is_emulated_mmio)))
      else (
        if (ofs =? (64))
        then (Some (st.(e_emulated_read_val)))
        else (
          if (ofs =? (72))
          then (Some (st.(e_dispose_response)))
          else (
            if ((ofs >=? (80)) && ((ofs <? (208))))
            then (
              let idx := ((ofs - (80)) / (8)) in
              (Some ((st.(e_gicv3_lrs)) @ idx)))
            else (
              if (ofs =? (208))
              then (Some (st.(e_gicv3_hcr)))
              else (
                if (ofs =? (216))
                then (Some (st.(e_trap_wfi)))
                else (
                  if (ofs =? (224))
                  then (Some (st.(e_trap_wfe)))
                  else None))))))).

  Definition store_s_rec_entry (sz: Z) (ofs: Z) (v: Z) (st: s_rec_entry) : (option s_rec_entry) :=
    if ((ofs >=? (0)) && ((ofs <? (56))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some (st.[e_gprs] :< ((st.(e_gprs)) # idx == v))))
    else (
      if (ofs =? (56))
      then (Some (st.[e_is_emulated_mmio] :< v))
      else (
        if (ofs =? (64))
        then (Some (st.[e_emulated_read_val] :< v))
        else (
          if (ofs =? (72))
          then (Some (st.[e_dispose_response] :< v))
          else (
            if ((ofs >=? (80)) && ((ofs <? (208))))
            then (
              let idx := ((ofs - (80)) / (8)) in
              (Some (st.[e_gicv3_lrs] :< ((st.(e_gicv3_lrs)) # idx == v))))
            else (
              if (ofs =? (208))
              then (Some (st.[e_gicv3_hcr] :< v))
              else (
                if (ofs =? (216))
                then (Some (st.[e_trap_wfi] :< v))
                else (
                  if (ofs =? (224))
                  then (Some (st.[e_trap_wfe] :< v))
                  else None))))))).

  Definition load_s_granule_set (sz: Z) (ofs: Z) (st: s_granule_set) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_idx)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_addr)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_state_s_granule_set)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_g)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_g_ret)))
            else None)))).

  Definition store_s_granule_set (sz: Z) (ofs: Z) (v: Z) (st: s_granule_set) : (option s_granule_set) :=
    if (ofs =? (0))
    then (Some (st.[e_idx] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_addr] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_state_s_granule_set] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_g] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_g_ret] :< v))
            else None)))).

  Definition load_s_rec_params (sz: Z) (ofs: Z) (st: s_rec_params) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (248))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some ((st.(e_gprs_s_rec_params)) @ idx)))
    else (
      if (ofs =? (248))
      then (Some (st.(e_pc)))
      else (
        if (ofs =? (256))
        then (Some (st.(e_flags)))
        else (
          if (ofs =? (264))
          then (Some (st.(e_is_pico)))
          else (
            if (ofs =? (272))
            then (Some (st.(e_rtt)))
            else (
              if (ofs =? (280))
              then (Some (st.(e_vbar_el1)))
              else None))))).

  Definition store_s_rec_params (sz: Z) (ofs: Z) (v: Z) (st: s_rec_params) : (option s_rec_params) :=
    if ((ofs >=? (0)) && ((ofs <? (248))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      (Some (st.[e_gprs_s_rec_params] :< ((st.(e_gprs_s_rec_params)) # idx == v))))
    else (
      if (ofs =? (248))
      then (Some (st.[e_pc] :< v))
      else (
        if (ofs =? (256))
        then (Some (st.[e_flags] :< v))
        else (
          if (ofs =? (264))
          then (Some (st.[e_is_pico] :< v))
          else (
            if (ofs =? (272))
            then (Some (st.[e_rtt] :< v))
            else (
              if (ofs =? (280))
              then (Some (st.[e_vbar_el1] :< v))
              else None))))).

  Definition load_s_realm_params (sz: Z) (ofs: Z) (st: s_realm_params) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_par_base)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_par_size)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_rtt_addr)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_measurement_algo)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_realm_feat_0)))
            else (
              if (ofs =? (40))
              then (Some (st.(e_s2_starting_level_s_realm_params)))
              else (
                if (ofs =? (48))
                then (Some (st.(e_num_s2_sl_rtts)))
                else (
                  if (ofs =? (52))
                  then (Some (st.(e_vmid_s_realm_params)))
                  else (
                    if (ofs =? (56))
                    then (Some (st.(e_is_rc)))
                    else None)))))))).

  Definition store_s_realm_params (sz: Z) (ofs: Z) (v: Z) (st: s_realm_params) : (option s_realm_params) :=
    if (ofs =? (0))
    then (Some (st.[e_par_base] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_par_size] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_rtt_addr] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_measurement_algo] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_realm_feat_0] :< v))
            else (
              if (ofs =? (40))
              then (Some (st.[e_s2_starting_level_s_realm_params] :< v))
              else (
                if (ofs =? (48))
                then (Some (st.[e_num_s2_sl_rtts] :< v))
                else (
                  if (ofs =? (52))
                  then (Some (st.[e_vmid_s_realm_params] :< v))
                  else (
                    if (ofs =? (56))
                    then (Some (st.[e_is_rc] :< v))
                    else None)))))))).

  Definition load_s_psa_key_policy_s (sz: Z) (ofs: Z) (st: s_psa_key_policy_s) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_usage)))
    else (
      if (ofs =? (4))
      then (Some (st.(e_alg)))
      else (
        if (ofs =? (8))
        then (Some (st.(e_alg2)))
        else None)).

  Definition store_s_psa_key_policy_s (sz: Z) (ofs: Z) (v: Z) (st: s_psa_key_policy_s) : (option s_psa_key_policy_s) :=
    if (ofs =? (0))
    then (Some (st.[e_usage] :< v))
    else (
      if (ofs =? (4))
      then (Some (st.[e_alg] :< v))
      else (
        if (ofs =? (8))
        then (Some (st.[e_alg2] :< v))
        else None)).

  Definition load_s_sysreg_state (sz: Z) (ofs: Z) (st: s_sysreg_state) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_sp_el0)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_sp_el1)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_elr_el1)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_spsr_el1)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_pmcr_el0)))
            else (
              if (ofs =? (40))
              then (Some (st.(e_pmuserenr_el0)))
              else (
                if (ofs =? (48))
                then (Some (st.(e_tpidrro_el0)))
                else (
                  if (ofs =? (56))
                  then (Some (st.(e_tpidr_el0)))
                  else (
                    if (ofs =? (64))
                    then (Some (st.(e_csselr_el1)))
                    else (
                      if (ofs =? (72))
                      then (Some (st.(e_sctlr_el1)))
                      else (
                        if (ofs =? (80))
                        then (Some (st.(e_actlr_el1)))
                        else (
                          if (ofs =? (88))
                          then (Some (st.(e_cpacr_el1)))
                          else (
                            if (ofs =? (96))
                            then (Some (st.(e_zcr_el1)))
                            else (
                              if (ofs =? (104))
                              then (Some (st.(e_ttbr0_el1)))
                              else (
                                if (ofs =? (112))
                                then (Some (st.(e_ttbr1_el1)))
                                else (
                                  if (ofs =? (120))
                                  then (Some (st.(e_tcr_el1)))
                                  else (
                                    if (ofs =? (128))
                                    then (Some (st.(e_esr_el1)))
                                    else (
                                      if (ofs =? (136))
                                      then (Some (st.(e_afsr0_el1)))
                                      else (
                                        if (ofs =? (144))
                                        then (Some (st.(e_afsr1_el1)))
                                        else (
                                          if (ofs =? (152))
                                          then (Some (st.(e_far_el1)))
                                          else (
                                            if (ofs =? (160))
                                            then (Some (st.(e_mair_el1)))
                                            else (
                                              if (ofs =? (168))
                                              then (Some (st.(e_vbar_el1_s_sysreg_state)))
                                              else (
                                                if (ofs =? (176))
                                                then (Some (st.(e_contextidr_el1)))
                                                else (
                                                  if (ofs =? (184))
                                                  then (Some (st.(e_tpidr_el1)))
                                                  else (
                                                    if (ofs =? (192))
                                                    then (Some (st.(e_amair_el1)))
                                                    else (
                                                      if (ofs =? (200))
                                                      then (Some (st.(e_cntkctl_el1)))
                                                      else (
                                                        if (ofs =? (208))
                                                        then (Some (st.(e_par_el1)))
                                                        else (
                                                          if (ofs =? (216))
                                                          then (Some (st.(e_mdscr_el1)))
                                                          else (
                                                            if (ofs =? (224))
                                                            then (Some (st.(e_mdccint_el1)))
                                                            else (
                                                              if (ofs =? (232))
                                                              then (Some (st.(e_disr_el1)))
                                                              else (
                                                                if (ofs =? (240))
                                                                then (Some (st.(e_mpam0_el1)))
                                                                else (
                                                                  if (ofs =? (248))
                                                                  then (Some (st.(e_cnthctl_el2)))
                                                                  else (
                                                                    if (ofs =? (256))
                                                                    then (Some (st.(e_cntvoff_el2)))
                                                                    else (
                                                                      if (ofs =? (264))
                                                                      then (Some (st.(e_cntp_ctl_el0)))
                                                                      else (
                                                                        if (ofs =? (272))
                                                                        then (Some (st.(e_cntp_cval_el0)))
                                                                        else (
                                                                          if (ofs =? (280))
                                                                          then (Some (st.(e_cntv_ctl_el0)))
                                                                          else (
                                                                            if (ofs =? (288))
                                                                            then (Some (st.(e_cntv_cval_el0)))
                                                                            else (
                                                                              if ((ofs >=? (296)) && ((ofs <? (512))))
                                                                              then (
                                                                                let elem_ofs := (ofs - (296)) in
                                                                                (load_s_gic_cpu_state sz elem_ofs (st.(e_gicstate))))
                                                                              else (
                                                                                if (ofs =? (512))
                                                                                then (Some (st.(e_vmpidr_el2)))
                                                                                else (
                                                                                  if (ofs =? (520))
                                                                                  then (Some (st.(e_hcr_el2)))
                                                                                  else (
                                                                                    if (ofs =? (528))
                                                                                    then (Some (st.(e_cptr_el2)))
                                                                                    else (
                                                                                      if (ofs =? (536))
                                                                                      then (Some (st.(e_tcr_el2)))
                                                                                      else (
                                                                                        if (ofs =? (544))
                                                                                        then (Some (st.(e_sctlr_el2)))
                                                                                        else None)))))))))))))))))))))))))))))))))))))))))).

  Definition store_s_sysreg_state (sz: Z) (ofs: Z) (v: Z) (st: s_sysreg_state) : (option s_sysreg_state) :=
    if (ofs =? (0))
    then (Some (st.[e_sp_el0] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_sp_el1] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_elr_el1] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_spsr_el1] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_pmcr_el0] :< v))
            else (
              if (ofs =? (40))
              then (Some (st.[e_pmuserenr_el0] :< v))
              else (
                if (ofs =? (48))
                then (Some (st.[e_tpidrro_el0] :< v))
                else (
                  if (ofs =? (56))
                  then (Some (st.[e_tpidr_el0] :< v))
                  else (
                    if (ofs =? (64))
                    then (Some (st.[e_csselr_el1] :< v))
                    else (
                      if (ofs =? (72))
                      then (Some (st.[e_sctlr_el1] :< v))
                      else (
                        if (ofs =? (80))
                        then (Some (st.[e_actlr_el1] :< v))
                        else (
                          if (ofs =? (88))
                          then (Some (st.[e_cpacr_el1] :< v))
                          else (
                            if (ofs =? (96))
                            then (Some (st.[e_zcr_el1] :< v))
                            else (
                              if (ofs =? (104))
                              then (Some (st.[e_ttbr0_el1] :< v))
                              else (
                                if (ofs =? (112))
                                then (Some (st.[e_ttbr1_el1] :< v))
                                else (
                                  if (ofs =? (120))
                                  then (Some (st.[e_tcr_el1] :< v))
                                  else (
                                    if (ofs =? (128))
                                    then (Some (st.[e_esr_el1] :< v))
                                    else (
                                      if (ofs =? (136))
                                      then (Some (st.[e_afsr0_el1] :< v))
                                      else (
                                        if (ofs =? (144))
                                        then (Some (st.[e_afsr1_el1] :< v))
                                        else (
                                          if (ofs =? (152))
                                          then (Some (st.[e_far_el1] :< v))
                                          else (
                                            if (ofs =? (160))
                                            then (Some (st.[e_mair_el1] :< v))
                                            else (
                                              if (ofs =? (168))
                                              then (Some (st.[e_vbar_el1_s_sysreg_state] :< v))
                                              else (
                                                if (ofs =? (176))
                                                then (Some (st.[e_contextidr_el1] :< v))
                                                else (
                                                  if (ofs =? (184))
                                                  then (Some (st.[e_tpidr_el1] :< v))
                                                  else (
                                                    if (ofs =? (192))
                                                    then (Some (st.[e_amair_el1] :< v))
                                                    else (
                                                      if (ofs =? (200))
                                                      then (Some (st.[e_cntkctl_el1] :< v))
                                                      else (
                                                        if (ofs =? (208))
                                                        then (Some (st.[e_par_el1] :< v))
                                                        else (
                                                          if (ofs =? (216))
                                                          then (Some (st.[e_mdscr_el1] :< v))
                                                          else (
                                                            if (ofs =? (224))
                                                            then (Some (st.[e_mdccint_el1] :< v))
                                                            else (
                                                              if (ofs =? (232))
                                                              then (Some (st.[e_disr_el1] :< v))
                                                              else (
                                                                if (ofs =? (240))
                                                                then (Some (st.[e_mpam0_el1] :< v))
                                                                else (
                                                                  if (ofs =? (248))
                                                                  then (Some (st.[e_cnthctl_el2] :< v))
                                                                  else (
                                                                    if (ofs =? (256))
                                                                    then (Some (st.[e_cntvoff_el2] :< v))
                                                                    else (
                                                                      if (ofs =? (264))
                                                                      then (Some (st.[e_cntp_ctl_el0] :< v))
                                                                      else (
                                                                        if (ofs =? (272))
                                                                        then (Some (st.[e_cntp_cval_el0] :< v))
                                                                        else (
                                                                          if (ofs =? (280))
                                                                          then (Some (st.[e_cntv_ctl_el0] :< v))
                                                                          else (
                                                                            if (ofs =? (288))
                                                                            then (Some (st.[e_cntv_cval_el0] :< v))
                                                                            else (
                                                                              if ((ofs >=? (296)) && ((ofs <? (512))))
                                                                              then (
                                                                                let elem_ofs := (ofs - (296)) in
                                                                                when ret == ((store_s_gic_cpu_state sz elem_ofs v (st.(e_gicstate))));
                                                                                (Some (st.[e_gicstate] :< ret)))
                                                                              else (
                                                                                if (ofs =? (512))
                                                                                then (Some (st.[e_vmpidr_el2] :< v))
                                                                                else (
                                                                                  if (ofs =? (520))
                                                                                  then (Some (st.[e_hcr_el2] :< v))
                                                                                  else (
                                                                                    if (ofs =? (528))
                                                                                    then (Some (st.[e_cptr_el2] :< v))
                                                                                    else (
                                                                                      if (ofs =? (536))
                                                                                      then (Some (st.[e_tcr_el2] :< v))
                                                                                      else (
                                                                                        if (ofs =? (544))
                                                                                        then (Some (st.[e_sctlr_el2] :< v))
                                                                                        else None)))))))))))))))))))))))))))))))))))))))))).

  Definition load_s_rec_exit (sz: Z) (ofs: Z) (st: s_rec_exit) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_exit_reason)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_esr)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_far)))
        else (
          if (ofs =? (24))
          then (Some (st.(e_hpfar)))
          else (
            if (ofs =? (32))
            then (Some (st.(e_emulated_write_val)))
            else (
              if ((ofs >=? (40)) && ((ofs <? (96))))
              then (
                let idx := ((ofs - (40)) / (8)) in
                (Some ((st.(e_gprs_s_rec_exit)) @ idx)))
              else (
                if (ofs =? (96))
                then (Some (st.(e_target_rec)))
                else (
                  if (ofs =? (104))
                  then (Some (st.(e_disposed_addr)))
                  else (
                    if (ofs =? (112))
                    then (Some (st.(e_disposed_size)))
                    else (
                      if (ofs =? (120))
                      then (Some (st.(e_gicv3_vmcr)))
                      else (
                        if (ofs =? (128))
                        then (Some (st.(e_gicv3_misr)))
                        else (
                          if ((ofs >=? (136)) && ((ofs <? (168))))
                          then (
                            let elem_ofs := (ofs - (136)) in
                            (load_s_smc_result sz elem_ofs (st.(e_timer_info))))
                          else (
                            if ((ofs >=? (168)) && ((ofs <? (296))))
                            then (
                              let idx := ((ofs - (168)) / (8)) in
                              (Some ((st.(e_gicv3_lrs_s_rec_exit)) @ idx)))
                            else (
                              if (ofs =? (296))
                              then (Some (st.(e_gicv3_hcr_s_rec_exit)))
                              else None))))))))))))).

  Definition store_s_rec_exit (sz: Z) (ofs: Z) (v: Z) (st: s_rec_exit) : (option s_rec_exit) :=
    if (ofs =? (0))
    then (Some (st.[e_exit_reason] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_esr] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_far] :< v))
        else (
          if (ofs =? (24))
          then (Some (st.[e_hpfar] :< v))
          else (
            if (ofs =? (32))
            then (Some (st.[e_emulated_write_val] :< v))
            else (
              if ((ofs >=? (40)) && ((ofs <? (96))))
              then (
                let idx := ((ofs - (40)) / (8)) in
                (Some (st.[e_gprs_s_rec_exit] :< ((st.(e_gprs_s_rec_exit)) # idx == v))))
              else (
                if (ofs =? (96))
                then (Some (st.[e_target_rec] :< v))
                else (
                  if (ofs =? (104))
                  then (Some (st.[e_disposed_addr] :< v))
                  else (
                    if (ofs =? (112))
                    then (Some (st.[e_disposed_size] :< v))
                    else (
                      if (ofs =? (120))
                      then (Some (st.[e_gicv3_vmcr] :< v))
                      else (
                        if (ofs =? (128))
                        then (Some (st.[e_gicv3_misr] :< v))
                        else (
                          if ((ofs >=? (136)) && ((ofs <? (168))))
                          then (
                            let elem_ofs := (ofs - (136)) in
                            when ret == ((store_s_smc_result sz elem_ofs v (st.(e_timer_info))));
                            (Some (st.[e_timer_info] :< ret)))
                          else (
                            if ((ofs >=? (168)) && ((ofs <? (296))))
                            then (
                              let idx := ((ofs - (168)) / (8)) in
                              (Some (st.[e_gicv3_lrs_s_rec_exit] :< ((st.(e_gicv3_lrs_s_rec_exit)) # idx == v))))
                            else (
                              if (ofs =? (296))
                              then (Some (st.[e_gicv3_hcr_s_rec_exit] :< v))
                              else None))))))))))))).

  Definition load_s_attest_result (sz: Z) (ofs: Z) (st: s_attest_result) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_return_to_realm)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_rtt_level)))
      else (
        if ((ofs >=? (16)) && ((ofs <? (48))))
        then (
          let elem_ofs := (ofs - (16)) in
          (load_s_smc_result sz elem_ofs (st.(e_smc_result))))
        else None)).

  Definition store_s_attest_result (sz: Z) (ofs: Z) (v: Z) (st: s_attest_result) : (option s_attest_result) :=
    if (ofs =? (0))
    then (Some (st.[e_return_to_realm] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_rtt_level] :< v))
      else (
        if ((ofs >=? (16)) && ((ofs <? (48))))
        then (
          let elem_ofs := (ofs - (16)) in
          when ret == ((store_s_smc_result sz elem_ofs v (st.(e_smc_result))));
          (Some (st.[e_smc_result] :< ret)))
        else None)).

  Definition load_s_granule (sz: Z) (ofs: Z) (st: s_granule) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (4))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_spinlock_t sz elem_ofs (st.(e_lock))))
    else (
      if (ofs =? (4))
      then (Some (st.(e_state_s_granule)))
      else (
        if ((ofs >=? (8)) && ((ofs <? (16))))
        then (
          let elem_ofs := (ofs - (8)) in
          (load_u_anon_3 sz elem_ofs (st.(e_ref))))
        else None)).

  Definition store_s_granule (sz: Z) (ofs: Z) (v: Z) (st: s_granule) : (option s_granule) :=
    if ((ofs >=? (0)) && ((ofs <? (4))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_spinlock_t sz elem_ofs v (st.(e_lock))));
      (Some (st.[e_lock] :< ret)))
    else (
      if (ofs =? (4))
      then (Some (st.[e_state_s_granule] :< v))
      else (
        if ((ofs >=? (8)) && ((ofs <? (16))))
        then (
          let elem_ofs := (ofs - (8)) in
          when ret == ((store_u_anon_3 sz elem_ofs v (st.(e_ref))));
          (Some (st.[e_ref] :< ret)))
        else None)).

  Definition load_s_useful_out_buf (sz: Z) (ofs: Z) (st: s_useful_out_buf) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (16))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_q_useful_buf sz elem_ofs (st.(e_UB))))
    else (
      if (ofs =? (16))
      then (Some (st.(e_data_len)))
      else (
        if (ofs =? (24))
        then (Some (st.(e_magic)))
        else (
          if (ofs =? (26))
          then (Some (st.(e_err)))
          else None))).

  Definition store_s_useful_out_buf (sz: Z) (ofs: Z) (v: Z) (st: s_useful_out_buf) : (option s_useful_out_buf) :=
    if ((ofs >=? (0)) && ((ofs <? (16))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_q_useful_buf sz elem_ofs v (st.(e_UB))));
      (Some (st.[e_UB] :< ret)))
    else (
      if (ofs =? (16))
      then (Some (st.[e_data_len] :< v))
      else (
        if (ofs =? (24))
        then (Some (st.[e_magic] :< v))
        else (
          if (ofs =? (26))
          then (Some (st.[e_err] :< v))
          else None))).

  Definition load_s_measurement_ctx (sz: Z) (ofs: Z) (st: s_measurement_ctx) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (108))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_mbedtls_sha256_context sz elem_ofs (st.(e_c))))
    else (
      if (ofs =? (108))
      then (Some (st.(e_measurement_algo_s_measurement_ctx)))
      else None).

  Definition store_s_measurement_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_measurement_ctx) : (option s_measurement_ctx) :=
    if ((ofs >=? (0)) && ((ofs <? (108))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_mbedtls_sha256_context sz elem_ofs v (st.(e_c))));
      (Some (st.[e_c] :< ret)))
    else (
      if (ofs =? (108))
      then (Some (st.[e_measurement_algo_s_measurement_ctx] :< v))
      else None).

  Definition load_s_measurement (sz: Z) (ofs: Z) (st: s_measurement) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_u_anon sz elem_ofs (st.(e_0))))
    else None.

  Definition store_s_measurement (sz: Z) (ofs: Z) (v: Z) (st: s_measurement) : (option s_measurement) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_u_anon sz elem_ofs v (st.(e_0))));
      (Some (st.[e_0] :< ret)))
    else None.

  Definition load_s___QCBORTrackNesting (sz: Z) (ofs: Z) (st: s___QCBORTrackNesting) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (128))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      let elem_ofs := ((ofs - (0)) mod (8)) in
      (load_s_anon sz elem_ofs ((st.(e_pArrays)) @ idx)))
    else (
      if (ofs =? (128))
      then (Some (st.(e_pCurrentNesting)))
      else None).

  Definition store_s___QCBORTrackNesting (sz: Z) (ofs: Z) (v: Z) (st: s___QCBORTrackNesting) : (option s___QCBORTrackNesting) :=
    if ((ofs >=? (0)) && ((ofs <? (128))))
    then (
      let idx := ((ofs - (0)) / (8)) in
      let elem_ofs := ((ofs - (0)) mod (8)) in
      when ret == ((store_s_anon sz elem_ofs v ((st.(e_pArrays)) @ idx)));
      (Some (st.[e_pArrays] :< ((st.(e_pArrays)) # idx == ret))))
    else (
      if (ofs =? (128))
      then (Some (st.[e_pCurrentNesting] :< v))
      else None).

  Definition load_s_t_cose_key (sz: Z) (ofs: Z) (st: s_t_cose_key) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_crypto_lib)))
    else (
      if ((ofs >=? (8)) && ((ofs <? (16))))
      then (
        let elem_ofs := (ofs - (8)) in
        (load_u_anon_0 sz elem_ofs (st.(e_k))))
      else None).

  Definition store_s_t_cose_key (sz: Z) (ofs: Z) (v: Z) (st: s_t_cose_key) : (option s_t_cose_key) :=
    if (ofs =? (0))
    then (Some (st.[e_crypto_lib] :< v))
    else (
      if ((ofs >=? (8)) && ((ofs <? (16))))
      then (
        let elem_ofs := (ofs - (8)) in
        when ret == ((store_u_anon_0 sz elem_ofs v (st.(e_k))));
        (Some (st.[e_k] :< ret)))
      else None).

  Definition load_s_psci_result (sz: Z) (ofs: Z) (st: s_psci_result) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_anon_5 sz elem_ofs (st.(e_hvc_forward))))
    else (
      if ((ofs >=? (32)) && ((ofs <? (64))))
      then (
        let elem_ofs := (ofs - (32)) in
        (load_s_smc_result sz elem_ofs (st.(e_smc_result_s_psci_result))))
      else None).

  Definition store_s_psci_result (sz: Z) (ofs: Z) (v: Z) (st: s_psci_result) : (option s_psci_result) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_anon_5 sz elem_ofs v (st.(e_hvc_forward))));
      (Some (st.[e_hvc_forward] :< ret)))
    else (
      if ((ofs >=? (32)) && ((ofs <? (64))))
      then (
        let elem_ofs := (ofs - (32)) in
        when ret == ((store_s_smc_result sz elem_ofs v (st.(e_smc_result_s_psci_result))));
        (Some (st.[e_smc_result_s_psci_result] :< ret)))
      else None).

  Definition load_s_psa_core_key_attributes_t (sz: Z) (ofs: Z) (st: s_psa_core_key_attributes_t) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_type_s_psa_core_key_attributes_t)))
    else (
      if (ofs =? (2))
      then (Some (st.(e_bits)))
      else (
        if (ofs =? (4))
        then (Some (st.(e_lifetime)))
        else (
          if (ofs =? (8))
          then (Some (st.(e_id)))
          else (
            if ((ofs >=? (12)) && ((ofs <? (24))))
            then (
              let elem_ofs := (ofs - (12)) in
              (load_s_psa_key_policy_s sz elem_ofs (st.(e_policy))))
            else (
              if (ofs =? (24))
              then (Some (st.(e_flags_s_psa_core_key_attributes_t)))
              else None))))).

  Definition store_s_psa_core_key_attributes_t (sz: Z) (ofs: Z) (v: Z) (st: s_psa_core_key_attributes_t) : (option s_psa_core_key_attributes_t) :=
    if (ofs =? (0))
    then (Some (st.[e_type_s_psa_core_key_attributes_t] :< v))
    else (
      if (ofs =? (2))
      then (Some (st.[e_bits] :< v))
      else (
        if (ofs =? (4))
        then (Some (st.[e_lifetime] :< v))
        else (
          if (ofs =? (8))
          then (Some (st.[e_id] :< v))
          else (
            if ((ofs >=? (12)) && ((ofs <? (24))))
            then (
              let elem_ofs := (ofs - (12)) in
              when ret == ((store_s_psa_key_policy_s sz elem_ofs v (st.(e_policy))));
              (Some (st.[e_policy] :< ret)))
            else (
              if (ofs =? (24))
              then (Some (st.[e_flags_s_psa_core_key_attributes_t] :< v))
              else None))))).

  Definition load_s_rec (sz: Z) (ofs: Z) (st: s_rec) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_g_rec)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_rec_idx)))
      else (
        if (ofs =? (16))
        then (Some (st.(e_runnable)))
        else (
          if ((ofs >=? (24)) && ((ofs <? (272))))
          then (
            let idx := ((ofs - (24)) / (8)) in
            (Some ((st.(e_regs)) @ idx)))
          else (
            if (ofs =? (272))
            then (Some (st.(e_pc_s_rec)))
            else (
              if (ofs =? (280))
              then (Some (st.(e_pstate)))
              else (
                if ((ofs >=? (288)) && ((ofs <? (840))))
                then (
                  let elem_ofs := (ofs - (288)) in
                  (load_s_sysreg_state sz elem_ofs (st.(e_sysregs))))
                else (
                  if ((ofs >=? (840)) && ((ofs <? (864))))
                  then (
                    let elem_ofs := (ofs - (840)) in
                    (load_s_common_sysreg_state sz elem_ofs (st.(e_common_sysregs))))
                  else (
                    if ((ofs >=? (864)) && ((ofs <? (896))))
                    then (
                      let elem_ofs := (ofs - (864)) in
                      (load_s_anon_1 sz elem_ofs (st.(e_set_ripas))))
                    else (
                      if ((ofs >=? (896)) && ((ofs <? (920))))
                      then (
                        let elem_ofs := (ofs - (896)) in
                        (load_s_anon_0 sz elem_ofs (st.(e_dispose_info))))
                      else (
                        if ((ofs >=? (920)) && ((ofs <? (952))))
                        then (
                          let elem_ofs := (ofs - (920)) in
                          (load_s_anon_1_2 sz elem_ofs (st.(e_realm_info))))
                        else (
                          if ((ofs >=? (952)) && ((ofs <? (960))))
                          then (
                            let elem_ofs := (ofs - (952)) in
                            (load_u_anon_3 sz elem_ofs (st.(e_last_run_info))))
                          else (
                            if ((ofs >=? (960)) && ((ofs <? (1504))))
                            then (
                              let elem_ofs := (ofs - (960)) in
                              (load_s_fpu_state sz elem_ofs (st.(e_fpu))))
                            else (
                              if (ofs =? (1504))
                              then (Some (st.(e_ns)))
                              else (
                                if ((ofs >=? (1512)) && ((ofs <? (1513))))
                                then (
                                  let elem_ofs := (ofs - (1512)) in
                                  (load_s_anon_3 sz elem_ofs (st.(e_psci_info))))
                                else (
                                  if (ofs =? (1520))
                                  then (Some (st.(e_is_pico_s_rec)))
                                  else (
                                    if (ofs =? (1528))
                                    then (Some (st.(e_initialized)))
                                    else (
                                      if ((ofs >=? (1536)) && ((ofs <? (1552))))
                                      then (
                                        let elem_ofs := (ofs - (1536)) in
                                        (load_s_realm_s1_context sz elem_ofs (st.(e_s1_ctx))))
                                      else None))))))))))))))))).

  Definition store_s_rec (sz: Z) (ofs: Z) (v: Z) (st: s_rec) : (option s_rec) :=
    if (ofs =? (0))
    then (Some (st.[e_g_rec] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_rec_idx] :< v))
      else (
        if (ofs =? (16))
        then (Some (st.[e_runnable] :< v))
        else (
          if ((ofs >=? (24)) && ((ofs <? (272))))
          then (
            let idx := ((ofs - (24)) / (8)) in
            (Some (st.[e_regs] :< ((st.(e_regs)) # idx == v))))
          else (
            if (ofs =? (272))
            then (Some (st.[e_pc_s_rec] :< v))
            else (
              if (ofs =? (280))
              then (Some (st.[e_pstate] :< v))
              else (
                if ((ofs >=? (288)) && ((ofs <? (840))))
                then (
                  let elem_ofs := (ofs - (288)) in
                  when ret == ((store_s_sysreg_state sz elem_ofs v (st.(e_sysregs))));
                  (Some (st.[e_sysregs] :< ret)))
                else (
                  if ((ofs >=? (840)) && ((ofs <? (864))))
                  then (
                    let elem_ofs := (ofs - (840)) in
                    when ret == ((store_s_common_sysreg_state sz elem_ofs v (st.(e_common_sysregs))));
                    (Some (st.[e_common_sysregs] :< ret)))
                  else (
                    if ((ofs >=? (864)) && ((ofs <? (896))))
                    then (
                      let elem_ofs := (ofs - (864)) in
                      when ret == ((store_s_anon_1 sz elem_ofs v (st.(e_set_ripas))));
                      (Some (st.[e_set_ripas] :< ret)))
                    else (
                      if ((ofs >=? (896)) && ((ofs <? (920))))
                      then (
                        let elem_ofs := (ofs - (896)) in
                        when ret == ((store_s_anon_0 sz elem_ofs v (st.(e_dispose_info))));
                        (Some (st.[e_dispose_info] :< ret)))
                      else (
                        if ((ofs >=? (920)) && ((ofs <? (952))))
                        then (
                          let elem_ofs := (ofs - (920)) in
                          when ret == ((store_s_anon_1_2 sz elem_ofs v (st.(e_realm_info))));
                          (Some (st.[e_realm_info] :< ret)))
                        else (
                          if ((ofs >=? (952)) && ((ofs <? (960))))
                          then (
                            let elem_ofs := (ofs - (952)) in
                            when ret == ((store_u_anon_3 sz elem_ofs v (st.(e_last_run_info))));
                            (Some (st.[e_last_run_info] :< ret)))
                          else (
                            if ((ofs >=? (960)) && ((ofs <? (1504))))
                            then (
                              let elem_ofs := (ofs - (960)) in
                              when ret == ((store_s_fpu_state sz elem_ofs v (st.(e_fpu))));
                              (Some (st.[e_fpu] :< ret)))
                            else (
                              if (ofs =? (1504))
                              then (Some (st.[e_ns] :< v))
                              else (
                                if ((ofs >=? (1512)) && ((ofs <? (1513))))
                                then (
                                  let elem_ofs := (ofs - (1512)) in
                                  when ret == ((store_s_anon_3 sz elem_ofs v (st.(e_psci_info))));
                                  (Some (st.[e_psci_info] :< ret)))
                                else (
                                  if (ofs =? (1520))
                                  then (Some (st.[e_is_pico_s_rec] :< v))
                                  else (
                                    if (ofs =? (1528))
                                    then (Some (st.[e_initialized] :< v))
                                    else (
                                      if ((ofs >=? (1536)) && ((ofs <? (1552))))
                                      then (
                                        let elem_ofs := (ofs - (1536)) in
                                        when ret == ((store_s_realm_s1_context sz elem_ofs v (st.(e_s1_ctx))));
                                        (Some (st.[e_s1_ctx] :< ret)))
                                      else None))))))))))))))))).

  Definition load_s_ns_state (sz: Z) (ofs: Z) (st: s_ns_state) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (552))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_sysreg_state sz elem_ofs (st.(e_sysregs_s_ns_state))))
    else (
      if (ofs =? (552))
      then (Some (st.(e_sp_el0_s_ns_state)))
      else (
        if (ofs =? (560))
        then (Some (st.(e_icc_sre_el2)))
        else (
          if ((ofs >=? (576)) && ((ofs <? (1120))))
          then (
            let elem_ofs := (ofs - (576)) in
            (load_s_fpu_state sz elem_ofs (st.(e_fpu_s_ns_state))))
          else None))).

  Definition store_s_ns_state (sz: Z) (ofs: Z) (v: Z) (st: s_ns_state) : (option s_ns_state) :=
    if ((ofs >=? (0)) && ((ofs <? (552))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_sysreg_state sz elem_ofs v (st.(e_sysregs_s_ns_state))));
      (Some (st.[e_sysregs_s_ns_state] :< ret)))
    else (
      if (ofs =? (552))
      then (Some (st.[e_sp_el0_s_ns_state] :< v))
      else (
        if (ofs =? (560))
        then (Some (st.[e_icc_sre_el2] :< v))
        else (
          if ((ofs >=? (576)) && ((ofs <? (1120))))
          then (
            let elem_ofs := (ofs - (576)) in
            when ret == ((store_s_fpu_state sz elem_ofs v (st.(e_fpu_s_ns_state))));
            (Some (st.[e_fpu_s_ns_state] :< ret)))
          else None))).

  Definition load_s_rd (sz: Z) (ofs: Z) (st: s_rd) : (option Z) :=
    if (ofs =? (0))
    then (Some (st.(e_state_s_rd)))
    else (
      if (ofs =? (8))
      then (Some (st.(e_rec_count)))
      else (
        if ((ofs >=? (16)) && ((ofs <? (48))))
        then (
          let elem_ofs := (ofs - (16)) in
          (load_s_realm_s2_context sz elem_ofs (st.(e_s2_ctx))))
        else (
          if (ofs =? (48))
          then (Some (st.(e_par_base_s_rd)))
          else (
            if (ofs =? (56))
            then (Some (st.(e_par_size_s_rd)))
            else (
              if (ofs =? (64))
              then (Some (st.(e_par_end)))
              else (
                if ((ofs >=? (72)) && ((ofs <? (184))))
                then (
                  let elem_ofs := (ofs - (72)) in
                  (load_s_measurement_ctx sz elem_ofs (st.(e_ctx))))
                else (
                  if ((ofs >=? (184)) && ((ofs <? (408))))
                  then (
                    let idx := ((ofs - (184)) / (32)) in
                    let elem_ofs := ((ofs - (184)) mod (32)) in
                    (load_s_measurement sz elem_ofs ((st.(e_measurement)) @ idx)))
                  else (
                    if (ofs =? (408))
                    then (Some (st.(e_is_rc_s_rd)))
                    else None)))))))).

  Definition store_s_rd (sz: Z) (ofs: Z) (v: Z) (st: s_rd) : (option s_rd) :=
    if (ofs =? (0))
    then (Some (st.[e_state_s_rd] :< v))
    else (
      if (ofs =? (8))
      then (Some (st.[e_rec_count] :< v))
      else (
        if ((ofs >=? (16)) && ((ofs <? (48))))
        then (
          let elem_ofs := (ofs - (16)) in
          when ret == ((store_s_realm_s2_context sz elem_ofs v (st.(e_s2_ctx))));
          (Some (st.[e_s2_ctx] :< ret)))
        else (
          if (ofs =? (48))
          then (Some (st.[e_par_base_s_rd] :< v))
          else (
            if (ofs =? (56))
            then (Some (st.[e_par_size_s_rd] :< v))
            else (
              if (ofs =? (64))
              then (Some (st.[e_par_end] :< v))
              else (
                if ((ofs >=? (72)) && ((ofs <? (184))))
                then (
                  let elem_ofs := (ofs - (72)) in
                  when ret == ((store_s_measurement_ctx sz elem_ofs v (st.(e_ctx))));
                  (Some (st.[e_ctx] :< ret)))
                else (
                  if ((ofs >=? (184)) && ((ofs <? (408))))
                  then (
                    let idx := ((ofs - (184)) / (32)) in
                    let elem_ofs := ((ofs - (184)) mod (32)) in
                    when ret == ((store_s_measurement sz elem_ofs v ((st.(e_measurement)) @ idx)));
                    (Some (st.[e_measurement] :< ((st.(e_measurement)) # idx == ret))))
                  else (
                    if (ofs =? (408))
                    then (Some (st.[e_is_rc_s_rd] :< v))
                    else None)))))))).

  Definition load_s__QCBOREncodeContext (sz: Z) (ofs: Z) (st: s__QCBOREncodeContext) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_useful_out_buf sz elem_ofs (st.(e_OutBuf))))
    else (
      if (ofs =? (32))
      then (Some (st.(e_uError)))
      else (
        if ((ofs >=? (40)) && ((ofs <? (176))))
        then (
          let elem_ofs := (ofs - (40)) in
          (load_s___QCBORTrackNesting sz elem_ofs (st.(e_nesting))))
        else None)).

  Definition store_s__QCBOREncodeContext (sz: Z) (ofs: Z) (v: Z) (st: s__QCBOREncodeContext) : (option s__QCBOREncodeContext) :=
    if ((ofs >=? (0)) && ((ofs <? (32))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_useful_out_buf sz elem_ofs v (st.(e_OutBuf))));
      (Some (st.[e_OutBuf] :< ret)))
    else (
      if (ofs =? (32))
      then (Some (st.[e_uError] :< v))
      else (
        if ((ofs >=? (40)) && ((ofs <? (176))))
        then (
          let elem_ofs := (ofs - (40)) in
          when ret == ((store_s___QCBORTrackNesting sz elem_ofs v (st.(e_nesting))));
          (Some (st.[e_nesting] :< ret)))
        else None)).

  Definition load_s_t_cose_sign1_sign_ctx (sz: Z) (ofs: Z) (st: s_t_cose_sign1_sign_ctx) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (16))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_q_useful_buf sz elem_ofs (st.(e_protected_parameters))))
    else (
      if (ofs =? (16))
      then (Some (st.(e_cose_algorithm_id)))
      else (
        if ((ofs >=? (24)) && ((ofs <? (40))))
        then (
          let elem_ofs := (ofs - (24)) in
          (load_s_t_cose_key sz elem_ofs (st.(e_signing_key))))
        else (
          if (ofs =? (40))
          then (Some (st.(e_option_flags)))
          else (
            if ((ofs >=? (48)) && ((ofs <? (64))))
            then (
              let elem_ofs := (ofs - (48)) in
              (load_s_q_useful_buf sz elem_ofs (st.(e_kid))))
            else (
              if (ofs =? (64))
              then (Some (st.(e_content_type_uint)))
              else (
                if (ofs =? (72))
                then (Some (st.(e_content_type_tstr)))
                else None)))))).

  Definition store_s_t_cose_sign1_sign_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_t_cose_sign1_sign_ctx) : (option s_t_cose_sign1_sign_ctx) :=
    if ((ofs >=? (0)) && ((ofs <? (16))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_q_useful_buf sz elem_ofs v (st.(e_protected_parameters))));
      (Some (st.[e_protected_parameters] :< ret)))
    else (
      if (ofs =? (16))
      then (Some (st.[e_cose_algorithm_id] :< v))
      else (
        if ((ofs >=? (24)) && ((ofs <? (40))))
        then (
          let elem_ofs := (ofs - (24)) in
          when ret == ((store_s_t_cose_key sz elem_ofs v (st.(e_signing_key))));
          (Some (st.[e_signing_key] :< ret)))
        else (
          if (ofs =? (40))
          then (Some (st.[e_option_flags] :< v))
          else (
            if ((ofs >=? (48)) && ((ofs <? (64))))
            then (
              let elem_ofs := (ofs - (48)) in
              when ret == ((store_s_q_useful_buf sz elem_ofs v (st.(e_kid))));
              (Some (st.[e_kid] :< ret)))
            else (
              if (ofs =? (64))
              then (Some (st.[e_content_type_uint] :< v))
              else (
                if (ofs =? (72))
                then (Some (st.[e_content_type_tstr] :< v))
                else None)))))).

  Definition load_s_psa_key_attributes_s (sz: Z) (ofs: Z) (st: s_psa_key_attributes_s) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (28))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s_psa_core_key_attributes_t sz elem_ofs (st.(e_core))))
    else (
      if (ofs =? (32))
      then (Some (st.(e_domain_parameters)))
      else (
        if (ofs =? (40))
        then (Some (st.(e_domain_parameters_size)))
        else None)).

  Definition store_s_psa_key_attributes_s (sz: Z) (ofs: Z) (v: Z) (st: s_psa_key_attributes_s) : (option s_psa_key_attributes_s) :=
    if ((ofs >=? (0)) && ((ofs <? (28))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s_psa_core_key_attributes_t sz elem_ofs v (st.(e_core))));
      (Some (st.[e_core] :< ret)))
    else (
      if (ofs =? (32))
      then (Some (st.[e_domain_parameters] :< v))
      else (
        if (ofs =? (40))
        then (Some (st.[e_domain_parameters_size] :< v))
        else None)).

  Definition load_s_attest_token_encode_ctx (sz: Z) (ofs: Z) (st: s_attest_token_encode_ctx) : (option Z) :=
    if ((ofs >=? (0)) && ((ofs <? (176))))
    then (
      let elem_ofs := (ofs - (0)) in
      (load_s__QCBOREncodeContext sz elem_ofs (st.(e_cbor_enc_ctx))))
    else (
      if (ofs =? (176))
      then (Some (st.(e_opt_flags)))
      else (
        if (ofs =? (180))
        then (Some (st.(e_key_select)))
        else (
          if ((ofs >=? (184)) && ((ofs <? (264))))
          then (
            let elem_ofs := (ofs - (184)) in
            (load_s_t_cose_sign1_sign_ctx sz elem_ofs (st.(e_signer_ctx))))
          else None))).

  Definition store_s_attest_token_encode_ctx (sz: Z) (ofs: Z) (v: Z) (st: s_attest_token_encode_ctx) : (option s_attest_token_encode_ctx) :=
    if ((ofs >=? (0)) && ((ofs <? (176))))
    then (
      let elem_ofs := (ofs - (0)) in
      when ret == ((store_s__QCBOREncodeContext sz elem_ofs v (st.(e_cbor_enc_ctx))));
      (Some (st.[e_cbor_enc_ctx] :< ret)))
    else (
      if (ofs =? (176))
      then (Some (st.[e_opt_flags] :< v))
      else (
        if (ofs =? (180))
        then (Some (st.[e_key_select] :< v))
        else (
          if ((ofs >=? (184)) && ((ofs <? (264))))
          then (
            let elem_ofs := (ofs - (184)) in
            when ret == ((store_s_t_cose_sign1_sign_ctx sz elem_ofs v (st.(e_signer_ctx))));
            (Some (st.[e_signer_ctx] :< ret)))
          else None))).

  Definition GRANULE_STATE_NS  : Z :=
    0.

  Definition GRANULE_STATE_DELEGATED  : Z :=
    1.

  Definition GRANULE_STATE_RD  : Z :=
    2.

  Definition GRANULE_STATE_REC  : Z :=
    3.

  Definition GRANULE_STATE_DATA  : Z :=
    4.

  Definition GRANULE_STATE_RTT  : Z :=
    5.

  Definition GRANULE_STATE_ANY  : Z :=
    6.

  Definition query_oracle (st: RData) : (option RData) :=
    let lo := ((st.(oracle)) (st.(log))) in
    when sh == (((st.(repl)) lo (st.(share))));
    (Some ((st.[log] :< (lo ++ ((st.(log))))).[share] :< sh)).

  Definition load_r_granule_data (ofs: Z) (st: r_granule_data) : (option Z) :=
    if ((st.(g_granule_state)) =? (GRANULE_STATE_DATA))
    then (Some ((st.(g_norm)) @ ofs))
    else (
      if ((st.(g_granule_state)) =? (GRANULE_STATE_REC))
      then (load_s_rec 8 ofs (st.(g_rec)))
      else (
        if ((st.(g_granule_state)) =? (GRANULE_STATE_RD))
        then (load_s_rd 8 ofs (st.(g_rd)))
        else (Some ((st.(g_norm)) @ ofs)))).

  Definition load_s_stack_type_4 (ofs: Z) (st: RData) : (option Z) :=
    rely ((((st.(stack)).(stack_type_4)) >= (GRANULES_BASE)));
    (Some ((st.(stack)).(stack_type_4))).

  Definition load_s_stack_type_4__1 (ofs: Z) (st: RData) : (option Z) :=
    rely ((((st.(stack)).(stack_type_4__1)) >= (GRANULES_BASE)));
    (Some ((st.(stack)).(stack_type_4__1))).

  Definition load_RData (sz: Z) (p: Ptr) (st: RData) : (option (Z * RData)) :=
    if ((p.(pbase)) =s ("stack_type_1"))
    then (Some (((st.(stack)).(stack_type_1)), st))
    else (
      if ((p.(pbase)) =s ("stack_type_2"))
      then (Some (((st.(stack)).(stack_type_2)), st))
      else (
        if ((p.(pbase)) =s ("stack_type_3"))
        then (Some (((st.(stack)).(stack_type_3)), st))
        else (
          if ((p.(pbase)) =s ("stack_type_3__1"))
          then (Some (((st.(stack)).(stack_type_3__1)), st))
          else (
            if ((p.(pbase)) =s ("stack_s_smc_result"))
            then (
              when ret == ((load_s_smc_result sz (p.(poffset)) ((st.(stack)).(stack_s_smc_result))));
              (Some (ret, st)))
            else (
              if ((p.(pbase)) =s ("stack_s_smc_result__1"))
              then (
                when ret == ((load_s_smc_result sz (p.(poffset)) ((st.(stack)).(stack_s_smc_result__1))));
                (Some (ret, st)))
              else (
                if ((p.(pbase)) =s ("stack_s_rmm_trap_element"))
                then (
                  when ret == ((load_s_rmm_trap_element sz (p.(poffset)) ((st.(stack)).(stack_s_rmm_trap_element))));
                  (Some (ret, st)))
                else (
                  if ((p.(pbase)) =s ("stack_s_rec_exit"))
                  then (
                    when ret == ((load_s_rec_exit sz (p.(poffset)) ((st.(stack)).(stack_s_rec_exit))));
                    (Some (ret, st)))
                  else (
                    if ((p.(pbase)) =s ("stack_type_4"))
                    then (
                      when ret == ((load_s_stack_type_4 sz st));
                      (Some (ret, st)))
                    else (
                      if ((p.(pbase)) =s ("stack_type_4__1"))
                      then (
                        when ret == ((load_s_stack_type_4__1 sz st));
                        (Some (ret, st)))
                      else (
                        if ((p.(pbase)) =s ("stack_s_ns_state"))
                        then (
                          when ret == ((load_s_ns_state sz (p.(poffset)) ((st.(stack)).(stack_s_ns_state))));
                          (Some (ret, st)))
                        else (
                          if ((p.(pbase)) =s ("stack_s_q_useful_buf"))
                          then (
                            when ret == ((load_s_q_useful_buf sz (p.(poffset)) ((st.(stack)).(stack_s_q_useful_buf))));
                            (Some (ret, st)))
                          else (
                            if ((p.(pbase)) =s ("stack_s_q_useful_buf__1"))
                            then (
                              when ret == ((load_s_q_useful_buf sz (p.(poffset)) ((st.(stack)).(stack_s_q_useful_buf__1))));
                              (Some (ret, st)))
                            else (
                              if ((p.(pbase)) =s ("stack_s_q_useful_buf__2"))
                              then (
                                when ret == ((load_s_q_useful_buf sz (p.(poffset)) ((st.(stack)).(stack_s_q_useful_buf__2))));
                                (Some (ret, st)))
                              else (
                                if ((p.(pbase)) =s ("stack_s_q_useful_buf__3"))
                                then (
                                  when ret == ((load_s_q_useful_buf sz (p.(poffset)) ((st.(stack)).(stack_s_q_useful_buf__3))));
                                  (Some (ret, st)))
                                else (
                                  if ((p.(pbase)) =s ("stack_s_attest_token_encode_ctx"))
                                  then (
                                    when ret == ((load_s_attest_token_encode_ctx sz (p.(poffset)) ((st.(stack)).(stack_s_attest_token_encode_ctx))));
                                    (Some (ret, st)))
                                  else (
                                    if ((p.(pbase)) =s ("stack_s_rtt_walk"))
                                    then (
                                      when ret == ((load_s_rtt_walk sz (p.(poffset)) ((st.(stack)).(stack_s_rtt_walk))));
                                      (Some (ret, st)))
                                    else (
                                      if ((p.(pbase)) =s ("stack_s_rtt_walk__1"))
                                      then (
                                        when ret == ((load_s_rtt_walk sz (p.(poffset)) ((st.(stack)).(stack_s_rtt_walk__1))));
                                        (Some (ret, st)))
                                      else (
                                        if ((p.(pbase)) =s ("stack_s_psci_result"))
                                        then (
                                          when ret == ((load_s_psci_result sz (p.(poffset)) ((st.(stack)).(stack_s_psci_result))));
                                          (Some (ret, st)))
                                        else (
                                          if ((p.(pbase)) =s ("stack_s_attest_result"))
                                          then (
                                            when ret == ((load_s_attest_result sz (p.(poffset)) ((st.(stack)).(stack_s_attest_result))));
                                            (Some (ret, st)))
                                          else (
                                            if ((p.(pbase)) =s ("stack_s_rec_entry"))
                                            then (
                                              when ret == ((load_s_rec_entry sz (p.(poffset)) ((st.(stack)).(stack_s_rec_entry))));
                                              (Some (ret, st)))
                                            else (
                                              if ((p.(pbase)) =s ("stack_s_realm_s2_context"))
                                              then (
                                                when ret == ((load_s_realm_s2_context sz (p.(poffset)) ((st.(stack)).(stack_s_realm_s2_context))));
                                                (Some (ret, st)))
                                              else (
                                                if ((p.(pbase)) =s ("stack_s_rec_params"))
                                                then (
                                                  when ret == ((load_s_rec_params sz (p.(poffset)) ((st.(stack)).(stack_s_rec_params))));
                                                  (Some (ret, st)))
                                                else (
                                                  if ((p.(pbase)) =s ("stack_s_realm_params"))
                                                  then (
                                                    when ret == ((load_s_realm_params sz (p.(poffset)) ((st.(stack)).(stack_s_realm_params))));
                                                    (Some (ret, st)))
                                                  else (
                                                    if ((p.(pbase)) =s ("stack_s_psa_key_attributes_s"))
                                                    then (
                                                      when ret == ((load_s_psa_key_attributes_s sz (p.(poffset)) ((st.(stack)).(stack_s_psa_key_attributes_s))));
                                                      (Some (ret, st)))
                                                    else (
                                                      if ((p.(pbase)) =s ("stack_type_5"))
                                                      then (
                                                        let idx := ((p.(poffset)) / (8)) in
                                                        let ptr := (((st.(stack)).(stack_type_5)) @ idx) in
                                                        (Some (ptr, st)))
                                                      else (
                                                        if ((p.(pbase)) =s ("stack_type_6"))
                                                        then (
                                                          let idx := ((p.(poffset)) / (40)) in
                                                          let elem_ofs := ((p.(poffset)) mod (40)) in
                                                          when ret == ((load_s_granule_set sz elem_ofs (((st.(stack)).(stack_type_6)) @ idx)));
                                                          (Some (ret, st)))
                                                        else (
                                                          if ((p.(pbase)) =s ("stack_type_7"))
                                                          then (
                                                            let idx := ((p.(poffset)) / (8)) in
                                                            let ptr := (((st.(stack)).(stack_type_7)) @ idx) in
                                                            (Some (ptr, st)))
                                                          else (
                                                            if ((p.(pbase)) =s ("stack_type_8"))
                                                            then (
                                                              let idx := ((p.(poffset)) / (1)) in
                                                              let ptr := (((st.(stack)).(stack_type_8)) @ idx) in
                                                              (Some (ptr, st)))
                                                            else (
                                                              if ((p.(pbase)) =s ("heap"))
                                                              then (
                                                                let idx := ((p.(poffset)) / (40)) in
                                                                let elem_ofs := ((p.(poffset)) mod (40)) in
                                                                when ret == ((load_s_buffer_alloc_ctx sz elem_ofs ((((st.(share)).(globals)).(g_heap)) @ idx)));
                                                                (Some (ret, st)))
                                                              else (
                                                                if ((p.(pbase)) =s ("debug_exits"))
                                                                then (Some ((((st.(share)).(globals)).(g_debug_exits)), st))
                                                                else (
                                                                  if ((p.(pbase)) =s ("vmid_count"))
                                                                  then (Some ((((st.(share)).(globals)).(g_vmid_count)), st))
                                                                  else (
                                                                    if ((p.(pbase)) =s ("vmid_lock"))
                                                                    then (
                                                                      when ret == ((load_s_spinlock_t sz (p.(poffset)) (((st.(share)).(globals)).(g_vmid_lock))));
                                                                      (Some (ret, st)))
                                                                    else (
                                                                      if ((p.(pbase)) =s ("vmids"))
                                                                      then (
                                                                        let idx := ((p.(poffset)) / (8)) in
                                                                        let ptr := ((((st.(share)).(globals)).(g_vmids)) @ idx) in
                                                                        (Some (ptr, st)))
                                                                      else (
                                                                        if ((p.(pbase)) =s ("nr_lrs"))
                                                                        then (Some ((((st.(share)).(globals)).(g_nr_lrs)), st))
                                                                        else (
                                                                          if ((p.(pbase)) =s ("nr_aprs"))
                                                                          then (Some ((((st.(share)).(globals)).(g_nr_aprs)), st))
                                                                          else (
                                                                            if ((p.(pbase)) =s ("max_vintid"))
                                                                            then (Some ((((st.(share)).(globals)).(g_max_vintid)), st))
                                                                            else (
                                                                              if ((p.(pbase)) =s ("pri_res0_mask"))
                                                                              then (Some ((((st.(share)).(globals)).(g_pri_res0_mask)), st))
                                                                              else (
                                                                                if ((p.(pbase)) =s ("default_gicstate"))
                                                                                then (
                                                                                  when ret == ((load_s_gic_cpu_state sz (p.(poffset)) (((st.(share)).(globals)).(g_default_gicstate))));
                                                                                  (Some (ret, st)))
                                                                                else (
                                                                                  if ((p.(pbase)) =s ("status_handler"))
                                                                                  then (
                                                                                    let idx := ((p.(poffset)) / (8)) in
                                                                                    let ptr := ((((st.(share)).(globals)).(g_status_handler)) @ idx) in
                                                                                    (Some (ptr, st)))
                                                                                  else (
                                                                                    if ((p.(pbase)) =s ("rmm_trap_list"))
                                                                                    then (
                                                                                      let idx := ((p.(poffset)) / (16)) in
                                                                                      let elem_ofs := ((p.(poffset)) mod (16)) in
                                                                                      when ret == ((load_s_rmm_trap_element sz elem_ofs ((((st.(share)).(globals)).(g_rmm_trap_list)) @ idx)));
                                                                                      (Some (ret, st)))
                                                                                    else (
                                                                                      if ((p.(pbase)) =s ("tt_l3_buffer"))
                                                                                      then (
                                                                                        when ret == ((load_s_s1tt sz (p.(poffset)) (((st.(share)).(globals)).(g_tt_l3_buffer))));
                                                                                        (Some (ret, st)))
                                                                                      else (
                                                                                        if ((p.(pbase)) =s ("tt_l2_mem0_0"))
                                                                                        then (
                                                                                          when ret == ((load_s_s1tt sz (p.(poffset)) (((st.(share)).(globals)).(g_tt_l2_mem0_0))));
                                                                                          (Some (ret, st)))
                                                                                        else (
                                                                                          if ((p.(pbase)) =s ("tt_l2_mem0_1"))
                                                                                          then (
                                                                                            when ret == ((load_s_s1tt sz (p.(poffset)) (((st.(share)).(globals)).(g_tt_l2_mem0_1))));
                                                                                            (Some (ret, st)))
                                                                                          else (
                                                                                            if ((p.(pbase)) =s ("tt_l2_mem1_0"))
                                                                                            then (
                                                                                              when ret == ((load_s_s1tt sz (p.(poffset)) (((st.(share)).(globals)).(g_tt_l2_mem1_0))));
                                                                                              (Some (ret, st)))
                                                                                            else (
                                                                                              if ((p.(pbase)) =s ("tt_l2_mem1_1"))
                                                                                              then (
                                                                                                when ret == ((load_s_s1tt sz (p.(poffset)) (((st.(share)).(globals)).(g_tt_l2_mem1_1))));
                                                                                                (Some (ret, st)))
                                                                                              else (
                                                                                                if ((p.(pbase)) =s ("tt_l2_mem1_2"))
                                                                                                then (
                                                                                                  when ret == ((load_s_s1tt sz (p.(poffset)) (((st.(share)).(globals)).(g_tt_l2_mem1_2))));
                                                                                                  (Some (ret, st)))
                                                                                                else (
                                                                                                  if ((p.(pbase)) =s ("tt_l2_mem1_3"))
                                                                                                  then (
                                                                                                    when ret == ((load_s_s1tt sz (p.(poffset)) (((st.(share)).(globals)).(g_tt_l2_mem1_3))));
                                                                                                    (Some (ret, st)))
                                                                                                  else (
                                                                                                    if ((p.(pbase)) =s ("tt_l1_upper"))
                                                                                                    then (
                                                                                                      let idx := ((p.(poffset)) / (1)) in
                                                                                                      let ret := ((((st.(share)).(globals)).(g_tt_l1_upper)) @ idx) in
                                                                                                      (Some (ret, st)))
                                                                                                    else (
                                                                                                      if ((p.(pbase)) =s ("mbedtls_mem_buf"))
                                                                                                      then (
                                                                                                        let idx := ((p.(poffset)) / (1)) in
                                                                                                        let ptr := ((((st.(share)).(globals)).(g_mbedtls_mem_buf)) @ idx) in
                                                                                                        (Some (ptr, st)))
                                                                                                      else (
                                                                                                        if ((p.(pbase)) =s ("granules"))
                                                                                                        then (
                                                                                                          let idx := ((p.(poffset)) / (4096)) in
                                                                                                          let elem_ofs := ((p.(poffset)) mod (4096)) in
                                                                                                          when ret == ((load_s_granule sz elem_ofs ((((st.(share)).(globals)).(g_granules)) @ idx)));
                                                                                                          (Some (ret, st)))
                                                                                                        else (
                                                                                                          if ((p.(pbase)) =s ("rmm_attest_signing_key"))
                                                                                                          then (Some ((((st.(share)).(globals)).(g_rmm_attest_signing_key)), st))
                                                                                                          else (
                                                                                                            if ((p.(pbase)) =s ("rmm_attest_public_key"))
                                                                                                            then (
                                                                                                              let idx := ((p.(poffset)) / (1)) in
                                                                                                              let ptr := ((((st.(share)).(globals)).(g_rmm_attest_public_key)) @ idx) in
                                                                                                              (Some (ptr, st)))
                                                                                                            else (
                                                                                                              if ((p.(pbase)) =s ("rmm_attest_public_key_len"))
                                                                                                              then (Some ((((st.(share)).(globals)).(g_rmm_attest_public_key_len)), st))
                                                                                                              else (
                                                                                                                if ((p.(pbase)) =s ("rmm_attest_public_key_hash"))
                                                                                                                then (
                                                                                                                  let idx := ((p.(poffset)) / (1)) in
                                                                                                                  let ptr := ((((st.(share)).(globals)).(g_rmm_attest_public_key_hash)) @ idx) in
                                                                                                                  (Some (ptr, st)))
                                                                                                                else (
                                                                                                                  if ((p.(pbase)) =s ("rmm_attest_public_key_hash_len"))
                                                                                                                  then (Some ((((st.(share)).(globals)).(g_rmm_attest_public_key_hash_len)), st))
                                                                                                                  else (
                                                                                                                    if ((p.(pbase)) =s ("platform_token_buf"))
                                                                                                                    then (
                                                                                                                      let idx := ((p.(poffset)) / (1)) in
                                                                                                                      let ptr := ((((st.(share)).(globals)).(g_platform_token_buf)) @ idx) in
                                                                                                                      (Some (ptr, st)))
                                                                                                                    else (
                                                                                                                      if ((p.(pbase)) =s ("rmm_platform_token"))
                                                                                                                      then (
                                                                                                                        when ret == ((load_s_q_useful_buf sz (p.(poffset)) (((st.(share)).(globals)).(g_rmm_platform_token))));
                                                                                                                        (Some (ret, st)))
                                                                                                                      else (
                                                                                                                        if ((p.(pbase)) =s ("get_realm_identity_identity"))
                                                                                                                        then (
                                                                                                                          let idx := ((p.(poffset)) / (1)) in
                                                                                                                          let ptr := ((((st.(share)).(globals)).(g_get_realm_identity_identity)) @ idx) in
                                                                                                                          (Some (ptr, st)))
                                                                                                                        else (
                                                                                                                          if ((p.(pbase)) =s ("realm_attest_private_key"))
                                                                                                                          then (
                                                                                                                            let idx := ((p.(poffset)) / (1)) in
                                                                                                                            let ptr := ((((st.(share)).(globals)).(g_realm_attest_private_key)) @ idx) in
                                                                                                                            (Some (ptr, st)))
                                                                                                                          else (
                                                                                                                            if ((p.(pbase)) =s ("granule_data"))
                                                                                                                            then (
                                                                                                                              let idx := ((p.(poffset)) / (4096)) in
                                                                                                                              let g_data := (((st.(share)).(granule_data)) @ idx) in
                                                                                                                              let elem_ofs := ((p.(poffset)) mod (4096)) in
                                                                                                                              when ret == ((load_r_granule_data elem_ofs g_data));
                                                                                                                              (Some (ret, st)))
                                                                                                                            else None)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))).

  Definition global_to_ptr (v: Z) : Ptr :=
    if (v >=? (MAX_GLOBAL))
    then (mkPtr "null" 0)
    else (
      if (v <? (0))
      then (mkPtr "null" 0)
      else (
        if (v >=? (REALM_ATTEST_PRIVATE_KEY_BASE))
        then (mkPtr "realm_attest_private_key" (v - (REALM_ATTEST_PRIVATE_KEY_BASE)))
        else (
          if (v >=? (GET_REALM_IDENTITY_IDENTITY_BASE))
          then (mkPtr "get_realm_identity_identity" (v - (GET_REALM_IDENTITY_IDENTITY_BASE)))
          else (
            if (v >=? (RMM_REALM_TOKEN_BUFS_BASE))
            then (mkPtr "rmm_realm_token_bufs" (v - (RMM_REALM_TOKEN_BUFS_BASE)))
            else (
              if (v >=? (RMM_PLATFORM_TOKEN_BASE))
              then (mkPtr "rmm_platform_token" (v - (RMM_PLATFORM_TOKEN_BASE)))
              else (
                if (v >=? (PLATFORM_TOKEN_BUF_BASE))
                then (mkPtr "platform_token_buf" (v - (PLATFORM_TOKEN_BUF_BASE)))
                else (
                  if (v >=? (RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE))
                  then (mkPtr "rmm_attest_public_key_hash_len" (v - (RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE)))
                  else (
                    if (v >=? (RMM_ATTEST_PUBLIC_KEY_HASH_BASE))
                    then (mkPtr "rmm_attest_public_key_hash" (v - (RMM_ATTEST_PUBLIC_KEY_HASH_BASE)))
                    else (
                      if (v >=? (RMM_ATTEST_PUBLIC_KEY_LEN_BASE))
                      then (mkPtr "rmm_attest_public_key_len" (v - (RMM_ATTEST_PUBLIC_KEY_LEN_BASE)))
                      else (
                        if (v >=? (RMM_ATTEST_PUBLIC_KEY_BASE))
                        then (mkPtr "rmm_attest_public_key" (v - (RMM_ATTEST_PUBLIC_KEY_BASE)))
                        else (
                          if (v >=? (RMM_ATTEST_SIGNING_KEY_BASE))
                          then (mkPtr "rmm_attest_signing_key" (v - (RMM_ATTEST_SIGNING_KEY_BASE)))
                          else (
                            if (v >=? (MBEDTLS_MEM_BUF_BASE))
                            then (mkPtr "mbedtls_mem_buf" (v - (MBEDTLS_MEM_BUF_BASE)))
                            else (
                              if (v >=? (TT_L3_MEM1_BASE))
                              then (mkPtr "tt_l3_mem1" (v - (TT_L3_MEM1_BASE)))
                              else (
                                if (v >=? (TT_L3_MEM0_BASE))
                                then (mkPtr "tt_l3_mem0" (v - (TT_L3_MEM0_BASE)))
                                else (
                                  if (v >=? (TT_L2_MEM1_3_BASE))
                                  then (mkPtr "tt_l2_mem1_3" (v - (TT_L2_MEM1_3_BASE)))
                                  else (
                                    if (v >=? (TT_L2_MEM1_2_BASE))
                                    then (mkPtr "tt_l2_mem1_2" (v - (TT_L2_MEM1_2_BASE)))
                                    else (
                                      if (v >=? (TT_L2_MEM1_1_BASE))
                                      then (mkPtr "tt_l2_mem1_1" (v - (TT_L2_MEM1_1_BASE)))
                                      else (
                                        if (v >=? (TT_L2_MEM1_0_BASE))
                                        then (mkPtr "tt_l2_mem1_0" (v - (TT_L2_MEM1_0_BASE)))
                                        else (
                                          if (v >=? (TT_L2_MEM0_1_BASE))
                                          then (mkPtr "tt_l2_mem0_1" (v - (TT_L2_MEM0_1_BASE)))
                                          else (
                                            if (v >=? (TT_L2_MEM0_0_BASE))
                                            then (mkPtr "tt_l2_mem0_0" (v - (TT_L2_MEM0_0_BASE)))
                                            else (
                                              if (v >=? (TT_L3_BUFFER_BASE))
                                              then (mkPtr "tt_l3_buffer" (v - (TT_L3_BUFFER_BASE)))
                                              else (
                                                if (v >=? (RMM_TRAP_LIST_BASE))
                                                then (mkPtr "rmm_trap_list" (v - (RMM_TRAP_LIST_BASE)))
                                                else (
                                                  if (v >=? (STATUS_HANDLER_BASE))
                                                  then (mkPtr "status_handler" (v - (STATUS_HANDLER_BASE)))
                                                  else (
                                                    if (v >=? (DEFAULT_GICSTATE_BASE))
                                                    then (mkPtr "default_gicstate" (v - (DEFAULT_GICSTATE_BASE)))
                                                    else (
                                                      if (v >=? (PRI_RES0_MASK_BASE))
                                                      then (mkPtr "pri_res0_mask" (v - (PRI_RES0_MASK_BASE)))
                                                      else (
                                                        if (v >=? (NR_PRI_BITS_BASE))
                                                        then (mkPtr "nr_pri_bits" (v - (NR_PRI_BITS_BASE)))
                                                        else (
                                                          if (v >=? (MAX_VINTID_BASE))
                                                          then (mkPtr "max_vintid" (v - (MAX_VINTID_BASE)))
                                                          else (
                                                            if (v >=? (NR_APRS_BASE))
                                                            then (mkPtr "nr_aprs" (v - (NR_APRS_BASE)))
                                                            else (
                                                              if (v >=? (NR_LRS_BASE))
                                                              then (mkPtr "nr_lrs" (v - (NR_LRS_BASE)))
                                                              else (
                                                                if (v >=? (VMIDS_BASE))
                                                                then (mkPtr "vmids" (v - (VMIDS_BASE)))
                                                                else (
                                                                  if (v >=? (VMID_LOCK_BASE))
                                                                  then (mkPtr "vmid_lock" (v - (VMID_LOCK_BASE)))
                                                                  else (
                                                                    if (v >=? (VMID_COUNT_BASE))
                                                                    then (mkPtr "vmid_count" (v - (VMID_COUNT_BASE)))
                                                                    else (
                                                                      if (v >=? (DEBUG_EXITS_BASE))
                                                                      then (mkPtr "debug_exits" (v - (DEBUG_EXITS_BASE)))
                                                                      else (
                                                                        if (v >=? (HEAP_BASE))
                                                                        then (mkPtr "heap" (v - (HEAP_BASE)))
                                                                        else (mkPtr "null" 0))))))))))))))))))))))))))))))))))).

  Definition ptr_to_int (p: Ptr) : Z :=
    if ((p.(pbase)) =s ("status"))
    then (MAX_ERR + ((p.(poffset))))
    else (
      if ((p.(pbase)) =s ("null"))
      then 0
      else (
        if ((p.(pbase)) =s ("realm_attest_private_key"))
        then (REALM_ATTEST_PRIVATE_KEY_BASE + ((p.(poffset))))
        else (
          if ((p.(pbase)) =s ("get_realm_identity_identity"))
          then (GET_REALM_IDENTITY_IDENTITY_BASE + ((p.(poffset))))
          else (
            if ((p.(pbase)) =s ("rmm_realm_token_bufs"))
            then (RMM_REALM_TOKEN_BUFS_BASE + ((p.(poffset))))
            else (
              if ((p.(pbase)) =s ("rmm_platform_token"))
              then (RMM_PLATFORM_TOKEN_BASE + ((p.(poffset))))
              else (
                if ((p.(pbase)) =s ("platform_token_buf"))
                then (PLATFORM_TOKEN_BUF_BASE + ((p.(poffset))))
                else (
                  if ((p.(pbase)) =s ("rmm_attest_public_key_hash_len"))
                  then (RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE + ((p.(poffset))))
                  else (
                    if ((p.(pbase)) =s ("rmm_attest_public_key_hash"))
                    then (RMM_ATTEST_PUBLIC_KEY_HASH_BASE + ((p.(poffset))))
                    else (
                      if ((p.(pbase)) =s ("rmm_attest_public_key_len"))
                      then (RMM_ATTEST_PUBLIC_KEY_LEN_BASE + ((p.(poffset))))
                      else (
                        if ((p.(pbase)) =s ("rmm_attest_public_key"))
                        then (RMM_ATTEST_PUBLIC_KEY_BASE + ((p.(poffset))))
                        else (
                          if ((p.(pbase)) =s ("rmm_attest_signing_key"))
                          then (RMM_ATTEST_SIGNING_KEY_BASE + ((p.(poffset))))
                          else (
                            if ((p.(pbase)) =s ("granules"))
                            then (GRANULES_BASE + ((p.(poffset))))
                            else (
                              if ((p.(pbase)) =s ("mbedtls_mem_buf"))
                              then (MBEDTLS_MEM_BUF_BASE + ((p.(poffset))))
                              else (
                                if ((p.(pbase)) =s ("tt_l3_mem1"))
                                then (TT_L3_MEM1_BASE + ((p.(poffset))))
                                else (
                                  if ((p.(pbase)) =s ("tt_l3_mem0"))
                                  then (TT_L3_MEM0_BASE + ((p.(poffset))))
                                  else (
                                    if ((p.(pbase)) =s ("tt_l2_mem1_3"))
                                    then (TT_L2_MEM1_3_BASE + ((p.(poffset))))
                                    else (
                                      if ((p.(pbase)) =s ("tt_l2_mem1_2"))
                                      then (TT_L2_MEM1_2_BASE + ((p.(poffset))))
                                      else (
                                        if ((p.(pbase)) =s ("tt_l2_mem1_1"))
                                        then (TT_L2_MEM1_1_BASE + ((p.(poffset))))
                                        else (
                                          if ((p.(pbase)) =s ("tt_l2_mem1_0"))
                                          then (TT_L2_MEM1_0_BASE + ((p.(poffset))))
                                          else (
                                            if ((p.(pbase)) =s ("tt_l2_mem0_1"))
                                            then (TT_L2_MEM0_1_BASE + ((p.(poffset))))
                                            else (
                                              if ((p.(pbase)) =s ("tt_l2_mem0_0"))
                                              then (TT_L2_MEM0_0_BASE + ((p.(poffset))))
                                              else (
                                                if ((p.(pbase)) =s ("tt_l3_buffer"))
                                                then (TT_L3_BUFFER_BASE + ((p.(poffset))))
                                                else (
                                                  if ((p.(pbase)) =s ("rmm_trap_list"))
                                                  then (RMM_TRAP_LIST_BASE + ((p.(poffset))))
                                                  else (
                                                    if ((p.(pbase)) =s ("status_handler"))
                                                    then (STATUS_HANDLER_BASE + ((p.(poffset))))
                                                    else (
                                                      if ((p.(pbase)) =s ("default_gicstate"))
                                                      then (DEFAULT_GICSTATE_BASE + ((p.(poffset))))
                                                      else (
                                                        if ((p.(pbase)) =s ("pri_res0_mask"))
                                                        then (PRI_RES0_MASK_BASE + ((p.(poffset))))
                                                        else (
                                                          if ((p.(pbase)) =s ("nr_pri_bits"))
                                                          then (NR_PRI_BITS_BASE + ((p.(poffset))))
                                                          else (
                                                            if ((p.(pbase)) =s ("max_vintid"))
                                                            then (MAX_VINTID_BASE + ((p.(poffset))))
                                                            else (
                                                              if ((p.(pbase)) =s ("nr_aprs"))
                                                              then (NR_APRS_BASE + ((p.(poffset))))
                                                              else (
                                                                if ((p.(pbase)) =s ("nr_lrs"))
                                                                then (NR_LRS_BASE + ((p.(poffset))))
                                                                else (
                                                                  if ((p.(pbase)) =s ("vmids"))
                                                                  then (VMIDS_BASE + ((p.(poffset))))
                                                                  else (
                                                                    if ((p.(pbase)) =s ("vmid_lock"))
                                                                    then (VMID_LOCK_BASE + ((p.(poffset))))
                                                                    else (
                                                                      if ((p.(pbase)) =s ("vmid_count"))
                                                                      then (VMID_COUNT_BASE + ((p.(poffset))))
                                                                      else (
                                                                        if ((p.(pbase)) =s ("debug_exits"))
                                                                        then (DEBUG_EXITS_BASE + ((p.(poffset))))
                                                                        else (
                                                                          if ((p.(pbase)) =s ("heap"))
                                                                          then (HEAP_BASE + ((p.(poffset))))
                                                                          else (
                                                                            if ((p.(pbase)) =s ("stack_type_4"))
                                                                            then (STACK_TYPE_4_BASE + ((p.(poffset))))
                                                                            else (
                                                                              if ((p.(pbase)) =s ("stack_type_4__1"))
                                                                              then (STACK_TYPE_4__1_BASE + ((p.(poffset))))
                                                                              else (
                                                                                if ((p.(pbase)) =s ("granule_data"))
                                                                                then (
                                                                                  if ((p.(poffset)) <? (MEM0_SIZE))
                                                                                  then (MEM0_VIRT + ((p.(poffset))))
                                                                                  else ((MEM1_VIRT + ((p.(poffset)))) - (MEM0_SIZE)))
                                                                                else 1)))))))))))))))))))))))))))))))))))))).

  Definition int_to_ptr (v: Z) : Ptr :=
    if (v >? (0))
    then (
      if (v <? (MAX_GLOBAL))
      then (global_to_ptr v)
      else (
        if (v >=? (MAX_ERR))
        then (mkPtr "status" (v - (MAX_ERR)))
        else (
          if (v >=? (MEM1_VIRT))
          then (mkPtr "granule_data" ((v - (MEM1_VIRT)) + (MEM0_SIZE)))
          else (
            if (v >=? (MEM0_VIRT))
            then (mkPtr "granule_data" (v - (MEM0_VIRT)))
            else (
              if (v >=? (GRANULES_BASE))
              then (mkPtr "granules" (v - (GRANULES_BASE)))
              else (
                if (v >=? (STACK_TYPE_4__1_BASE))
                then (mkPtr "stack_type_4__1" (v - (STACK_TYPE_4__1_BASE)))
                else (
                  if (v >=? (STACK_TYPE_4_BASE))
                  then (mkPtr "stack_type_4" (v - (STACK_TYPE_4_BASE)))
                  else (mkPtr "null" 0))))))))
    else (mkPtr "null" 0).

  Definition ptr_eqb (p1: Ptr) (p2: Ptr) : bool :=
    ((ptr_to_int p1) =? ((ptr_to_int p2))).

  Definition ptr_ltb (p1: Ptr) (p2: Ptr) : bool :=
    ((ptr_to_int p1) <? ((ptr_to_int p2))).

  Definition ptr_gtb (p1: Ptr) (p2: Ptr) : bool :=
    if ((p2.(pbase)) =s ("status"))
    then (
      if ((p1.(pbase)) <>s ("status"))
      then false
      else ((p1.(poffset)) >? ((p2.(poffset)))))
    else ((ptr_to_int p1) >? ((ptr_to_int p2))).

  Definition store_RData (sz: Z) (p: Ptr) (v: Z) (st: RData) : (option RData) :=
    if ((p.(pbase)) =s ("stack_type_1"))
    then (Some (st.[stack].[stack_type_1] :< v))
    else (
      if ((p.(pbase)) =s ("stack_type_2"))
      then (Some (st.[stack].[stack_type_2] :< v))
      else (
        if ((p.(pbase)) =s ("stack_type_3"))
        then (Some (st.[stack].[stack_type_3] :< v))
        else (
          if ((p.(pbase)) =s ("stack_type_3__1"))
          then (Some (st.[stack].[stack_type_3__1] :< v))
          else (
            if ((p.(pbase)) =s ("stack_s_smc_result"))
            then (
              when ret == ((store_s_smc_result sz (p.(poffset)) v ((st.(stack)).(stack_s_smc_result))));
              (Some (st.[stack].[stack_s_smc_result] :< ret)))
            else (
              if ((p.(pbase)) =s ("stack_s_smc_result__1"))
              then (
                when ret == ((store_s_smc_result sz (p.(poffset)) v ((st.(stack)).(stack_s_smc_result__1))));
                (Some (st.[stack].[stack_s_smc_result__1] :< ret)))
              else (
                if ((p.(pbase)) =s ("stack_s_rmm_trap_element"))
                then (
                  when ret == ((store_s_rmm_trap_element sz (p.(poffset)) v ((st.(stack)).(stack_s_rmm_trap_element))));
                  (Some (st.[stack].[stack_s_rmm_trap_element] :< ret)))
                else (
                  if ((p.(pbase)) =s ("stack_s_rec_exit"))
                  then (
                    when ret == ((store_s_rec_exit sz (p.(poffset)) v ((st.(stack)).(stack_s_rec_exit))));
                    (Some (st.[stack].[stack_s_rec_exit] :< ret)))
                  else (
                    if ((p.(pbase)) =s ("stack_type_4"))
                    then (Some (st.[stack].[stack_type_4] :< v))
                    else (
                      if ((p.(pbase)) =s ("stack_type_4__1"))
                      then (Some (st.[stack].[stack_type_4__1] :< v))
                      else (
                        if ((p.(pbase)) =s ("stack_s_ns_state"))
                        then (
                          when ret == ((store_s_ns_state sz (p.(poffset)) v ((st.(stack)).(stack_s_ns_state))));
                          (Some (st.[stack].[stack_s_ns_state] :< ret)))
                        else (
                          if ((p.(pbase)) =s ("stack_s_q_useful_buf"))
                          then (
                            when ret == ((store_s_q_useful_buf sz (p.(poffset)) v ((st.(stack)).(stack_s_q_useful_buf))));
                            (Some (st.[stack].[stack_s_q_useful_buf] :< ret)))
                          else (
                            if ((p.(pbase)) =s ("stack_s_q_useful_buf__1"))
                            then (
                              when ret == ((store_s_q_useful_buf sz (p.(poffset)) v ((st.(stack)).(stack_s_q_useful_buf__1))));
                              (Some (st.[stack].[stack_s_q_useful_buf__1] :< ret)))
                            else (
                              if ((p.(pbase)) =s ("stack_s_q_useful_buf__2"))
                              then (
                                when ret == ((store_s_q_useful_buf sz (p.(poffset)) v ((st.(stack)).(stack_s_q_useful_buf__2))));
                                (Some (st.[stack].[stack_s_q_useful_buf__2] :< ret)))
                              else (
                                if ((p.(pbase)) =s ("stack_s_q_useful_buf__3"))
                                then (
                                  when ret == ((store_s_q_useful_buf sz (p.(poffset)) v ((st.(stack)).(stack_s_q_useful_buf__3))));
                                  (Some (st.[stack].[stack_s_q_useful_buf__3] :< ret)))
                                else (
                                  if ((p.(pbase)) =s ("stack_s_attest_token_encode_ctx"))
                                  then (
                                    when ret == ((store_s_attest_token_encode_ctx sz (p.(poffset)) v ((st.(stack)).(stack_s_attest_token_encode_ctx))));
                                    (Some (st.[stack].[stack_s_attest_token_encode_ctx] :< ret)))
                                  else (
                                    if ((p.(pbase)) =s ("stack_s_rtt_walk"))
                                    then (
                                      when ret == ((store_s_rtt_walk sz (p.(poffset)) v ((st.(stack)).(stack_s_rtt_walk))));
                                      (Some (st.[stack].[stack_s_rtt_walk] :< ret)))
                                    else (
                                      if ((p.(pbase)) =s ("stack_s_rtt_walk__1"))
                                      then (
                                        when ret == ((store_s_rtt_walk sz (p.(poffset)) v ((st.(stack)).(stack_s_rtt_walk__1))));
                                        (Some (st.[stack].[stack_s_rtt_walk__1] :< ret)))
                                      else (
                                        if ((p.(pbase)) =s ("stack_s_psci_result"))
                                        then (
                                          when ret == ((store_s_psci_result sz (p.(poffset)) v ((st.(stack)).(stack_s_psci_result))));
                                          (Some (st.[stack].[stack_s_psci_result] :< ret)))
                                        else (
                                          if ((p.(pbase)) =s ("stack_s_attest_result"))
                                          then (
                                            when ret == ((store_s_attest_result sz (p.(poffset)) v ((st.(stack)).(stack_s_attest_result))));
                                            (Some (st.[stack].[stack_s_attest_result] :< ret)))
                                          else (
                                            if ((p.(pbase)) =s ("stack_s_rec_entry"))
                                            then (
                                              when ret == ((store_s_rec_entry sz (p.(poffset)) v ((st.(stack)).(stack_s_rec_entry))));
                                              (Some (st.[stack].[stack_s_rec_entry] :< ret)))
                                            else (
                                              if ((p.(pbase)) =s ("stack_s_realm_s2_context"))
                                              then (
                                                when ret == ((store_s_realm_s2_context sz (p.(poffset)) v ((st.(stack)).(stack_s_realm_s2_context))));
                                                (Some (st.[stack].[stack_s_realm_s2_context] :< ret)))
                                              else (
                                                if ((p.(pbase)) =s ("stack_s_rec_params"))
                                                then (
                                                  when ret == ((store_s_rec_params sz (p.(poffset)) v ((st.(stack)).(stack_s_rec_params))));
                                                  (Some (st.[stack].[stack_s_rec_params] :< ret)))
                                                else (
                                                  if ((p.(pbase)) =s ("stack_s_realm_params"))
                                                  then (
                                                    when ret == ((store_s_realm_params sz (p.(poffset)) v ((st.(stack)).(stack_s_realm_params))));
                                                    (Some (st.[stack].[stack_s_realm_params] :< ret)))
                                                  else (
                                                    if ((p.(pbase)) =s ("stack_s_psa_key_attributes_s"))
                                                    then (
                                                      when ret == ((store_s_psa_key_attributes_s sz (p.(poffset)) v ((st.(stack)).(stack_s_psa_key_attributes_s))));
                                                      (Some (st.[stack].[stack_s_psa_key_attributes_s] :< ret)))
                                                    else (
                                                      if ((p.(pbase)) =s ("stack_type_5"))
                                                      then (
                                                        let idx := ((p.(poffset)) / (8)) in
                                                        let ptr := (((st.(stack)).(stack_type_5)) # idx == v) in
                                                        (Some (st.[stack].[stack_type_5] :< ptr)))
                                                      else (
                                                        if ((p.(pbase)) =s ("stack_type_6"))
                                                        then (
                                                          let idx := ((p.(poffset)) / (40)) in
                                                          let elem_ofs := ((p.(poffset)) mod (40)) in
                                                          when ret == ((store_s_granule_set sz elem_ofs v (((st.(stack)).(stack_type_6)) @ idx)));
                                                          (Some (st.[stack].[stack_type_6] :< (((st.(stack)).(stack_type_6)) # idx == ret))))
                                                        else (
                                                          if ((p.(pbase)) =s ("stack_type_7"))
                                                          then (
                                                            let idx := ((p.(poffset)) / (8)) in
                                                            let ptr := (((st.(stack)).(stack_type_7)) # idx == v) in
                                                            (Some (st.[stack].[stack_type_7] :< ptr)))
                                                          else (
                                                            if ((p.(pbase)) =s ("stack_type_8"))
                                                            then (
                                                              let idx := ((p.(poffset)) / (1)) in
                                                              let ptr := (((st.(stack)).(stack_type_8)) # idx == v) in
                                                              (Some (st.[stack].[stack_type_8] :< ptr)))
                                                            else (
                                                              if ((p.(pbase)) =s ("heap"))
                                                              then (
                                                                let idx := ((p.(poffset)) / (40)) in
                                                                let elem_ofs := ((p.(poffset)) mod (40)) in
                                                                when ret == ((store_s_buffer_alloc_ctx sz elem_ofs v ((((st.(share)).(globals)).(g_heap)) @ idx)));
                                                                (Some (st.[share].[globals].[g_heap] :< ((((st.(share)).(globals)).(g_heap)) # idx == ret))))
                                                              else (
                                                                if ((p.(pbase)) =s ("debug_exits"))
                                                                then (Some (st.[share].[globals].[g_debug_exits] :< v))
                                                                else (
                                                                  if ((p.(pbase)) =s ("vmid_count"))
                                                                  then (Some (st.[share].[globals].[g_vmid_count] :< v))
                                                                  else (
                                                                    if ((p.(pbase)) =s ("vmid_lock"))
                                                                    then (
                                                                      when ret == ((store_s_spinlock_t sz (p.(poffset)) v (((st.(share)).(globals)).(g_vmid_lock))));
                                                                      (Some (st.[share].[globals].[g_vmid_lock] :< ret)))
                                                                    else (
                                                                      if ((p.(pbase)) =s ("vmids"))
                                                                      then (
                                                                        let idx := ((p.(poffset)) / (8)) in
                                                                        let ptr := ((((st.(share)).(globals)).(g_vmids)) # idx == v) in
                                                                        (Some (st.[share].[globals].[g_vmids] :< ptr)))
                                                                      else (
                                                                        if ((p.(pbase)) =s ("nr_lrs"))
                                                                        then (Some (st.[share].[globals].[g_nr_lrs] :< v))
                                                                        else (
                                                                          if ((p.(pbase)) =s ("nr_aprs"))
                                                                          then (Some (st.[share].[globals].[g_nr_aprs] :< v))
                                                                          else (
                                                                            if ((p.(pbase)) =s ("max_vintid"))
                                                                            then (Some (st.[share].[globals].[g_max_vintid] :< v))
                                                                            else (
                                                                              if ((p.(pbase)) =s ("pri_res0_mask"))
                                                                              then (Some (st.[share].[globals].[g_pri_res0_mask] :< v))
                                                                              else (
                                                                                if ((p.(pbase)) =s ("default_gicstate"))
                                                                                then (
                                                                                  when ret == ((store_s_gic_cpu_state sz (p.(poffset)) v (((st.(share)).(globals)).(g_default_gicstate))));
                                                                                  (Some (st.[share].[globals].[g_default_gicstate] :< ret)))
                                                                                else (
                                                                                  if ((p.(pbase)) =s ("status_handler"))
                                                                                  then (
                                                                                    let idx := ((p.(poffset)) / (8)) in
                                                                                    let ptr := ((((st.(share)).(globals)).(g_status_handler)) # idx == v) in
                                                                                    (Some (st.[share].[globals].[g_status_handler] :< ptr)))
                                                                                  else (
                                                                                    if ((p.(pbase)) =s ("rmm_trap_list"))
                                                                                    then (
                                                                                      let idx := ((p.(poffset)) / (16)) in
                                                                                      let elem_ofs := ((p.(poffset)) mod (16)) in
                                                                                      when ret == ((store_s_rmm_trap_element sz elem_ofs v ((((st.(share)).(globals)).(g_rmm_trap_list)) @ idx)));
                                                                                      (Some (st.[share].[globals].[g_rmm_trap_list] :< ((((st.(share)).(globals)).(g_rmm_trap_list)) # idx == ret))))
                                                                                    else (
                                                                                      if ((p.(pbase)) =s ("tt_l3_buffer"))
                                                                                      then (
                                                                                        when ret == ((store_s_s1tt sz (p.(poffset)) v (((st.(share)).(globals)).(g_tt_l3_buffer))));
                                                                                        (Some (st.[share].[globals].[g_tt_l3_buffer] :< ret)))
                                                                                      else (
                                                                                        if ((p.(pbase)) =s ("tt_l2_mem0_0"))
                                                                                        then (
                                                                                          when ret == ((store_s_s1tt sz (p.(poffset)) v (((st.(share)).(globals)).(g_tt_l2_mem0_0))));
                                                                                          (Some (st.[share].[globals].[g_tt_l2_mem0_0] :< ret)))
                                                                                        else (
                                                                                          if ((p.(pbase)) =s ("tt_l2_mem0_1"))
                                                                                          then (
                                                                                            when ret == ((store_s_s1tt sz (p.(poffset)) v (((st.(share)).(globals)).(g_tt_l2_mem0_1))));
                                                                                            (Some (st.[share].[globals].[g_tt_l2_mem0_1] :< ret)))
                                                                                          else (
                                                                                            if ((p.(pbase)) =s ("tt_l2_mem1_0"))
                                                                                            then (
                                                                                              when ret == ((store_s_s1tt sz (p.(poffset)) v (((st.(share)).(globals)).(g_tt_l2_mem1_0))));
                                                                                              (Some (st.[share].[globals].[g_tt_l2_mem1_0] :< ret)))
                                                                                            else (
                                                                                              if ((p.(pbase)) =s ("tt_l2_mem1_1"))
                                                                                              then (
                                                                                                when ret == ((store_s_s1tt sz (p.(poffset)) v (((st.(share)).(globals)).(g_tt_l2_mem1_1))));
                                                                                                (Some (st.[share].[globals].[g_tt_l2_mem1_1] :< ret)))
                                                                                              else (
                                                                                                if ((p.(pbase)) =s ("tt_l2_mem1_2"))
                                                                                                then (
                                                                                                  when ret == ((store_s_s1tt sz (p.(poffset)) v (((st.(share)).(globals)).(g_tt_l2_mem1_2))));
                                                                                                  (Some (st.[share].[globals].[g_tt_l2_mem1_2] :< ret)))
                                                                                                else (
                                                                                                  if ((p.(pbase)) =s ("tt_l2_mem1_3"))
                                                                                                  then (
                                                                                                    when ret == ((store_s_s1tt sz (p.(poffset)) v (((st.(share)).(globals)).(g_tt_l2_mem1_3))));
                                                                                                    (Some (st.[share].[globals].[g_tt_l2_mem1_3] :< ret)))
                                                                                                  else (
                                                                                                    if ((p.(pbase)) =s ("tt_l1_upper"))
                                                                                                    then (
                                                                                                      let idx := ((p.(poffset)) / (1)) in
                                                                                                      let ptr := ((((st.(share)).(globals)).(g_tt_l1_upper)) # idx == v) in
                                                                                                      (Some (st.[share].[globals].[g_tt_l1_upper] :< ptr)))
                                                                                                    else (
                                                                                                      if ((p.(pbase)) =s ("mbedtls_mem_buf"))
                                                                                                      then (
                                                                                                        let idx := ((p.(poffset)) / (1)) in
                                                                                                        let ptr := ((((st.(share)).(globals)).(g_mbedtls_mem_buf)) # idx == v) in
                                                                                                        (Some (st.[share].[globals].[g_mbedtls_mem_buf] :< ptr)))
                                                                                                      else (
                                                                                                        if ((p.(pbase)) =s ("granules"))
                                                                                                        then (
                                                                                                          let idx := ((p.(poffset)) / (16)) in
                                                                                                          let elem_ofs := ((p.(poffset)) mod (16)) in
                                                                                                          when ret == ((store_s_granule sz elem_ofs v ((((st.(share)).(globals)).(g_granules)) @ idx)));
                                                                                                          (Some (st.[share].[globals].[g_granules] :< ((((st.(share)).(globals)).(g_granules)) # idx == ret))))
                                                                                                        else (
                                                                                                          if ((p.(pbase)) =s ("rmm_attest_signing_key"))
                                                                                                          then (Some (st.[share].[globals].[g_rmm_attest_signing_key] :< v))
                                                                                                          else (
                                                                                                            if ((p.(pbase)) =s ("rmm_attest_public_key"))
                                                                                                            then (
                                                                                                              let idx := ((p.(poffset)) / (1)) in
                                                                                                              let ptr := ((((st.(share)).(globals)).(g_rmm_attest_public_key)) # idx == v) in
                                                                                                              (Some (st.[share].[globals].[g_rmm_attest_public_key] :< ptr)))
                                                                                                            else (
                                                                                                              if ((p.(pbase)) =s ("rmm_attest_public_key_len"))
                                                                                                              then (Some (st.[share].[globals].[g_rmm_attest_public_key_len] :< v))
                                                                                                              else (
                                                                                                                if ((p.(pbase)) =s ("rmm_attest_public_key_hash"))
                                                                                                                then (
                                                                                                                  let idx := ((p.(poffset)) / (1)) in
                                                                                                                  let ptr := ((((st.(share)).(globals)).(g_rmm_attest_public_key_hash)) # idx == v) in
                                                                                                                  (Some (st.[share].[globals].[g_rmm_attest_public_key_hash] :< ptr)))
                                                                                                                else (
                                                                                                                  if ((p.(pbase)) =s ("rmm_attest_public_key_hash_len"))
                                                                                                                  then (Some (st.[share].[globals].[g_rmm_attest_public_key_hash_len] :< v))
                                                                                                                  else (
                                                                                                                    if ((p.(pbase)) =s ("platform_token_buf"))
                                                                                                                    then (
                                                                                                                      let idx := ((p.(poffset)) / (1)) in
                                                                                                                      let ptr := ((((st.(share)).(globals)).(g_platform_token_buf)) # idx == v) in
                                                                                                                      (Some (st.[share].[globals].[g_platform_token_buf] :< ptr)))
                                                                                                                    else (
                                                                                                                      if ((p.(pbase)) =s ("rmm_platform_token"))
                                                                                                                      then (
                                                                                                                        when ret == ((store_s_q_useful_buf sz (p.(poffset)) v (((st.(share)).(globals)).(g_rmm_platform_token))));
                                                                                                                        (Some (st.[share].[globals].[g_rmm_platform_token] :< ret)))
                                                                                                                      else (
                                                                                                                        if ((p.(pbase)) =s ("get_realm_identity_identity"))
                                                                                                                        then (
                                                                                                                          let idx := ((p.(poffset)) / (1)) in
                                                                                                                          let ptr := ((((st.(share)).(globals)).(g_get_realm_identity_identity)) # idx == v) in
                                                                                                                          (Some (st.[share].[globals].[g_get_realm_identity_identity] :< ptr)))
                                                                                                                        else (
                                                                                                                          if ((p.(pbase)) =s ("realm_attest_private_key"))
                                                                                                                          then (
                                                                                                                            let idx := ((p.(poffset)) / (1)) in
                                                                                                                            let ptr := ((((st.(share)).(globals)).(g_realm_attest_private_key)) # idx == v) in
                                                                                                                            (Some (st.[share].[globals].[g_realm_attest_private_key] :< ptr)))
                                                                                                                          else (
                                                                                                                            if ((p.(pbase)) =s ("granule_data"))
                                                                                                                            then (
                                                                                                                              let idx := ((p.(poffset)) / (4096)) in
                                                                                                                              let g_data := (((st.(share)).(granule_data)) @ idx) in
                                                                                                                              let elem_ofs := ((p.(poffset)) mod (4096)) in
                                                                                                                              let new_g_data := (g_data.[g_norm] :< ((g_data.(g_norm)) # elem_ofs == v)) in
                                                                                                                              let p := (((st.(share)).(granule_data)) # idx == new_g_data) in
                                                                                                                              let new_st := (st.[share].[granule_data] :< p) in
                                                                                                                              (Some new_st))
                                                                                                                            else None)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))).

  Definition alloc_stack (fname: string) (sz: Z) (ofs: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some ((mkPtr "null" 0), st)).

  Definition free_stack (fname: string) (init_st: RData) (st: RData) : (option RData) :=
    (Some st).

  Definition new_frame (fname: string) (st: RData) : (option RData) :=
    (Some st).

End GlobalDefs.

#[global] Hint Unfold ptr_offset: spec.
#[global] Hint Unfold bool_to_int: spec.
#[global] Hint Unfold MAX_ERR: spec.
#[global] Hint Unfold HEAP_BASE: spec.
#[global] Hint Unfold DEBUG_EXITS_BASE: spec.
#[global] Hint Unfold VMID_COUNT_BASE: spec.
#[global] Hint Unfold VMID_LOCK_BASE: spec.
#[global] Hint Unfold VMIDS_BASE: spec.
#[global] Hint Unfold NR_LRS_BASE: spec.
#[global] Hint Unfold NR_APRS_BASE: spec.
#[global] Hint Unfold MAX_VINTID_BASE: spec.
#[global] Hint Unfold NR_PRI_BITS_BASE: spec.
#[global] Hint Unfold PRI_RES0_MASK_BASE: spec.
#[global] Hint Unfold DEFAULT_GICSTATE_BASE: spec.
#[global] Hint Unfold STATUS_HANDLER_BASE: spec.
#[global] Hint Unfold RMM_TRAP_LIST_BASE: spec.
#[global] Hint Unfold TT_L3_BUFFER_BASE: spec.
#[global] Hint Unfold TT_L2_MEM0_0_BASE: spec.
#[global] Hint Unfold TT_L2_MEM0_1_BASE: spec.
#[global] Hint Unfold TT_L2_MEM1_0_BASE: spec.
#[global] Hint Unfold TT_L2_MEM1_1_BASE: spec.
#[global] Hint Unfold TT_L2_MEM1_2_BASE: spec.
#[global] Hint Unfold TT_L2_MEM1_3_BASE: spec.
#[global] Hint Unfold TT_L3_MEM0_BASE: spec.
#[global] Hint Unfold TT_L3_MEM1_BASE: spec.
#[global] Hint Unfold MBEDTLS_MEM_BUF_BASE: spec.
#[global] Hint Unfold RMM_ATTEST_SIGNING_KEY_BASE: spec.
#[global] Hint Unfold RMM_ATTEST_PUBLIC_KEY_BASE: spec.
#[global] Hint Unfold RMM_ATTEST_PUBLIC_KEY_LEN_BASE: spec.
#[global] Hint Unfold RMM_ATTEST_PUBLIC_KEY_HASH_BASE: spec.
#[global] Hint Unfold RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE: spec.
#[global] Hint Unfold PLATFORM_TOKEN_BUF_BASE: spec.
#[global] Hint Unfold RMM_PLATFORM_TOKEN_BASE: spec.
#[global] Hint Unfold RMM_REALM_TOKEN_BUFS_BASE: spec.
#[global] Hint Unfold GET_REALM_IDENTITY_IDENTITY_BASE: spec.
#[global] Hint Unfold REALM_ATTEST_PRIVATE_KEY_BASE: spec.
#[global] Hint Unfold MAX_GLOBAL: spec.
#[global] Hint Unfold STACK_TYPE_4_BASE: spec.
#[global] Hint Unfold STACK_TYPE_4__1_BASE: spec.
#[global] Hint Unfold GRANULES_BASE: spec.
#[global] Hint Unfold GRANULE_SIZE: spec.
#[global] Hint Unfold MEM0_PHYS: spec.
#[global] Hint Unfold MEM1_PHYS: spec.
#[global] Hint Unfold MEM0_VIRT: spec.
#[global] Hint Unfold MEM1_VIRT: spec.
#[global] Hint Unfold MEM0_SIZE: spec.
#[global] Hint Unfold MEM1_SIZE: spec.
#[global] Hint Unfold NR_GRANULES: spec.
#[global] Hint Unfold load_s_buffer_alloc_ctx: spec.
#[global] Hint Unfold store_s_buffer_alloc_ctx: spec.
#[global] Hint Unfold load_s__memory_header: spec.
#[global] Hint Unfold store_s__memory_header: spec.
#[global] Hint Unfold load_s_spinlock_t: spec.
#[global] Hint Unfold store_s_spinlock_t: spec.
#[global] Hint Unfold load_s_gic_cpu_state: spec.
#[global] Hint Unfold store_s_gic_cpu_state: spec.
#[global] Hint Unfold load_s_smc_handler: spec.
#[global] Hint Unfold store_s_smc_handler: spec.
#[global] Hint Unfold load_s_smc_result: spec.
#[global] Hint Unfold store_s_smc_result: spec.
#[global] Hint Unfold load_s_rmm_trap_element: spec.
#[global] Hint Unfold store_s_rmm_trap_element: spec.
#[global] Hint Unfold load_s_sysreg_handler: spec.
#[global] Hint Unfold store_s_sysreg_handler: spec.
#[global] Hint Unfold load_s_common_sysreg_state: spec.
#[global] Hint Unfold store_s_common_sysreg_state: spec.
#[global] Hint Unfold load_s_anon_1: spec.
#[global] Hint Unfold store_s_anon_1: spec.
#[global] Hint Unfold load_s_anon_0: spec.
#[global] Hint Unfold store_s_anon_0: spec.
#[global] Hint Unfold load_s_anon_1_2: spec.
#[global] Hint Unfold store_s_anon_1_2: spec.
#[global] Hint Unfold load_u_anon_3: spec.
#[global] Hint Unfold store_u_anon_3: spec.
#[global] Hint Unfold load_s_fpu_state: spec.
#[global] Hint Unfold store_s_fpu_state: spec.
#[global] Hint Unfold load_s_anon_3: spec.
#[global] Hint Unfold store_s_anon_3: spec.
#[global] Hint Unfold load_s_realm_s1_context: spec.
#[global] Hint Unfold store_s_realm_s1_context: spec.
#[global] Hint Unfold load_s_s1tt: spec.
#[global] Hint Unfold store_s_s1tt: spec.
#[global] Hint Unfold load_s_q_useful_buf: spec.
#[global] Hint Unfold store_s_q_useful_buf: spec.
#[global] Hint Unfold load_s_std____va_list: spec.
#[global] Hint Unfold store_s_std____va_list: spec.
#[global] Hint Unfold load_s_out_fct_wrap_type: spec.
#[global] Hint Unfold store_s_out_fct_wrap_type: spec.
#[global] Hint Unfold load_s_mbedtls_sha256_context: spec.
#[global] Hint Unfold store_s_mbedtls_sha256_context: spec.
#[global] Hint Unfold load_u_anon: spec.
#[global] Hint Unfold store_u_anon: spec.
#[global] Hint Unfold load_s_anon: spec.
#[global] Hint Unfold store_s_anon: spec.
#[global] Hint Unfold load_u_anon_0: spec.
#[global] Hint Unfold store_u_anon_0: spec.
#[global] Hint Unfold load_s_return_code_t: spec.
#[global] Hint Unfold store_s_return_code_t: spec.
#[global] Hint Unfold load_s_rtt_walk: spec.
#[global] Hint Unfold store_s_rtt_walk: spec.
#[global] Hint Unfold load_s_realm_s2_context: spec.
#[global] Hint Unfold store_s_realm_s2_context: spec.
#[global] Hint Unfold load_s_anon_5: spec.
#[global] Hint Unfold store_s_anon_5: spec.
#[global] Hint Unfold load_s_rec_entry: spec.
#[global] Hint Unfold store_s_rec_entry: spec.
#[global] Hint Unfold load_s_granule_set: spec.
#[global] Hint Unfold store_s_granule_set: spec.
#[global] Hint Unfold load_s_rec_params: spec.
#[global] Hint Unfold store_s_rec_params: spec.
#[global] Hint Unfold load_s_realm_params: spec.
#[global] Hint Unfold store_s_realm_params: spec.
#[global] Hint Unfold load_s_psa_key_policy_s: spec.
#[global] Hint Unfold store_s_psa_key_policy_s: spec.
#[global] Hint Unfold load_s_sysreg_state: spec.
#[global] Hint Unfold store_s_sysreg_state: spec.
#[global] Hint Unfold load_s_rec_exit: spec.
#[global] Hint Unfold store_s_rec_exit: spec.
#[global] Hint Unfold load_s_attest_result: spec.
#[global] Hint Unfold store_s_attest_result: spec.
#[global] Hint Unfold load_s_granule: spec.
#[global] Hint Unfold store_s_granule: spec.
#[global] Hint Unfold load_s_useful_out_buf: spec.
#[global] Hint Unfold store_s_useful_out_buf: spec.
#[global] Hint Unfold load_s_measurement_ctx: spec.
#[global] Hint Unfold store_s_measurement_ctx: spec.
#[global] Hint Unfold load_s_measurement: spec.
#[global] Hint Unfold store_s_measurement: spec.
#[global] Hint Unfold load_s___QCBORTrackNesting: spec.
#[global] Hint Unfold store_s___QCBORTrackNesting: spec.
#[global] Hint Unfold load_s_t_cose_key: spec.
#[global] Hint Unfold store_s_t_cose_key: spec.
#[global] Hint Unfold load_s_psci_result: spec.
#[global] Hint Unfold store_s_psci_result: spec.
#[global] Hint Unfold load_s_psa_core_key_attributes_t: spec.
#[global] Hint Unfold store_s_psa_core_key_attributes_t: spec.
#[global] Hint Unfold load_s_rec: spec.
#[global] Hint Unfold store_s_rec: spec.
#[global] Hint Unfold load_s_ns_state: spec.
#[global] Hint Unfold store_s_ns_state: spec.
#[global] Hint Unfold load_s_rd: spec.
#[global] Hint Unfold store_s_rd: spec.
#[global] Hint Unfold load_s__QCBOREncodeContext: spec.
#[global] Hint Unfold store_s__QCBOREncodeContext: spec.
#[global] Hint Unfold load_s_t_cose_sign1_sign_ctx: spec.
#[global] Hint Unfold store_s_t_cose_sign1_sign_ctx: spec.
#[global] Hint Unfold load_s_psa_key_attributes_s: spec.
#[global] Hint Unfold store_s_psa_key_attributes_s: spec.
#[global] Hint Unfold load_s_attest_token_encode_ctx: spec.
#[global] Hint Unfold store_s_attest_token_encode_ctx: spec.
#[global] Hint Unfold GRANULE_STATE_NS: spec.
#[global] Hint Unfold GRANULE_STATE_DELEGATED: spec.
#[global] Hint Unfold GRANULE_STATE_RD: spec.
#[global] Hint Unfold GRANULE_STATE_REC: spec.
#[global] Hint Unfold GRANULE_STATE_DATA: spec.
#[global] Hint Unfold GRANULE_STATE_RTT: spec.
#[global] Hint Unfold GRANULE_STATE_ANY: spec.
#[global] Hint Unfold query_oracle: spec.
#[global] Hint Unfold load_r_granule_data: spec.
#[global] Hint Unfold load_s_stack_type_4: spec.
#[global] Hint Unfold load_s_stack_type_4__1: spec.
#[global] Hint Unfold load_RData: spec.
#[global] Hint Unfold global_to_ptr: spec.
#[global] Hint Unfold ptr_to_int: spec.
#[global] Hint Unfold int_to_ptr: spec.
#[global] Hint Unfold ptr_eqb: spec.
#[global] Hint Unfold ptr_ltb: spec.
#[global] Hint Unfold ptr_gtb: spec.
#[global] Hint Unfold store_RData: spec.
#[global] Hint Unfold alloc_stack: spec.
#[global] Hint Unfold free_stack: spec.
#[global] Hint Unfold new_frame: spec.
