Definition status_ptr_spec' (v_0: Z) : (option Ptr) :=
  if ((0 - (v_0)) >? (0))
  then (
    if (((0 - (v_0)) - (MAX_GLOBAL)) <? (0))
    then (
      if (((0 - (v_0)) - (REALM_ATTEST_PRIVATE_KEY_BASE)) >=? (0))
      then (Some (mkPtr "realm_attest_private_key" ((0 - (v_0)) - (REALM_ATTEST_PRIVATE_KEY_BASE))))
      else (
        if (((0 - (v_0)) - (GET_REALM_IDENTITY_IDENTITY_BASE)) >=? (0))
        then (Some (mkPtr "get_realm_identity_identity" ((0 - (v_0)) - (GET_REALM_IDENTITY_IDENTITY_BASE))))
        else (
          if (((0 - (v_0)) - (RMM_REALM_TOKEN_BUFS_BASE)) >=? (0))
          then (Some (mkPtr "rmm_realm_token_bufs" ((0 - (v_0)) - (RMM_REALM_TOKEN_BUFS_BASE))))
          else (
            if (((0 - (v_0)) - (RMM_PLATFORM_TOKEN_BASE)) >=? (0))
            then (Some (mkPtr "rmm_platform_token" ((0 - (v_0)) - (RMM_PLATFORM_TOKEN_BASE))))
            else (
              if (((0 - (v_0)) - (PLATFORM_TOKEN_BUF_BASE)) >=? (0))
              then (Some (mkPtr "platform_token_buf" ((0 - (v_0)) - (PLATFORM_TOKEN_BUF_BASE))))
              else (
                if (((0 - (v_0)) - (RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE)) >=? (0))
                then (Some (mkPtr "rmm_attest_public_key_hash_len" ((0 - (v_0)) - (RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE))))
                else (
                  if (((0 - (v_0)) - (RMM_ATTEST_PUBLIC_KEY_HASH_BASE)) >=? (0))
                  then (Some (mkPtr "rmm_attest_public_key_hash" ((0 - (v_0)) - (RMM_ATTEST_PUBLIC_KEY_HASH_BASE))))
                  else (
                    if (((0 - (v_0)) - (RMM_ATTEST_PUBLIC_KEY_LEN_BASE)) >=? (0))
                    then (Some (mkPtr "rmm_attest_public_key_len" ((0 - (v_0)) - (RMM_ATTEST_PUBLIC_KEY_LEN_BASE))))
                    else (
                      if (((0 - (v_0)) - (RMM_ATTEST_PUBLIC_KEY_BASE)) >=? (0))
                      then (Some (mkPtr "rmm_attest_public_key" ((0 - (v_0)) - (RMM_ATTEST_PUBLIC_KEY_BASE))))
                      else (
                        if (((0 - (v_0)) - (RMM_ATTEST_SIGNING_KEY_BASE)) >=? (0))
                        then (Some (mkPtr "rmm_attest_signing_key" ((0 - (v_0)) - (RMM_ATTEST_SIGNING_KEY_BASE))))
                        else (
                          if (((0 - (v_0)) - (MBEDTLS_MEM_BUF_BASE)) >=? (0))
                          then (Some (mkPtr "mbedtls_mem_buf" ((0 - (v_0)) - (MBEDTLS_MEM_BUF_BASE))))
                          else (
                            if (((0 - (v_0)) - (TT_L3_MEM1_BASE)) >=? (0))
                            then (Some (mkPtr "tt_l3_mem1" ((0 - (v_0)) - (TT_L3_MEM1_BASE))))
                            else (
                              if (((0 - (v_0)) - (TT_L3_MEM0_BASE)) >=? (0))
                              then (Some (mkPtr "tt_l3_mem0" ((0 - (v_0)) - (TT_L3_MEM0_BASE))))
                              else (
                                if (((0 - (v_0)) - (TT_L2_MEM1_3_BASE)) >=? (0))
                                then (Some (mkPtr "tt_l2_mem1_3" ((0 - (v_0)) - (TT_L2_MEM1_3_BASE))))
                                else (
                                  if (((0 - (v_0)) - (TT_L2_MEM1_2_BASE)) >=? (0))
                                  then (Some (mkPtr "tt_l2_mem1_2" ((0 - (v_0)) - (TT_L2_MEM1_2_BASE))))
                                  else (
                                    if (((0 - (v_0)) - (TT_L2_MEM1_1_BASE)) >=? (0))
                                    then (Some (mkPtr "tt_l2_mem1_1" ((0 - (v_0)) - (TT_L2_MEM1_1_BASE))))
                                    else (
                                      if (((0 - (v_0)) - (TT_L2_MEM1_0_BASE)) >=? (0))
                                      then (Some (mkPtr "tt_l2_mem1_0" ((0 - (v_0)) - (TT_L2_MEM1_0_BASE))))
                                      else (
                                        if (((0 - (v_0)) - (TT_L2_MEM0_1_BASE)) >=? (0))
                                        then (Some (mkPtr "tt_l2_mem0_1" ((0 - (v_0)) - (TT_L2_MEM0_1_BASE))))
                                        else (
                                          if (((0 - (v_0)) - (TT_L2_MEM0_0_BASE)) >=? (0))
                                          then (Some (mkPtr "tt_l2_mem0_0" ((0 - (v_0)) - (TT_L2_MEM0_0_BASE))))
                                          else (
                                            if (((0 - (v_0)) - (TT_L3_BUFFER_BASE)) >=? (0))
                                            then (Some (mkPtr "tt_l3_buffer" ((0 - (v_0)) - (TT_L3_BUFFER_BASE))))
                                            else (
                                              if (((0 - (v_0)) - (RMM_TRAP_LIST_BASE)) >=? (0))
                                              then (Some (mkPtr "rmm_trap_list" ((0 - (v_0)) - (RMM_TRAP_LIST_BASE))))
                                              else (
                                                if (((0 - (v_0)) - (STATUS_HANDLER_BASE)) >=? (0))
                                                then (Some (mkPtr "status_handler" ((0 - (v_0)) - (STATUS_HANDLER_BASE))))
                                                else (
                                                  if (((0 - (v_0)) - (DEFAULT_GICSTATE_BASE)) >=? (0))
                                                  then (Some (mkPtr "default_gicstate" ((0 - (v_0)) - (DEFAULT_GICSTATE_BASE))))
                                                  else (
                                                    if (((0 - (v_0)) - (PRI_RES0_MASK_BASE)) >=? (0))
                                                    then (Some (mkPtr "pri_res0_mask" ((0 - (v_0)) - (PRI_RES0_MASK_BASE))))
                                                    else (
                                                      if (((0 - (v_0)) - (NR_PRI_BITS_BASE)) >=? (0))
                                                      then (Some (mkPtr "nr_pri_bits" ((0 - (v_0)) - (NR_PRI_BITS_BASE))))
                                                      else (
                                                        if (((0 - (v_0)) - (MAX_VINTID_BASE)) >=? (0))
                                                        then (Some (mkPtr "max_vintid" ((0 - (v_0)) - (MAX_VINTID_BASE))))
                                                        else (
                                                          if (((0 - (v_0)) - (NR_APRS_BASE)) >=? (0))
                                                          then (Some (mkPtr "nr_aprs" ((0 - (v_0)) - (NR_APRS_BASE))))
                                                          else (
                                                            if (((0 - (v_0)) - (NR_LRS_BASE)) >=? (0))
                                                            then (Some (mkPtr "nr_lrs" ((0 - (v_0)) - (NR_LRS_BASE))))
                                                            else (
                                                              if (((0 - (v_0)) - (VMIDS_BASE)) >=? (0))
                                                              then (Some (mkPtr "vmids" ((0 - (v_0)) - (VMIDS_BASE))))
                                                              else (
                                                                if (((0 - (v_0)) - (VMID_LOCK_BASE)) >=? (0))
                                                                then (Some (mkPtr "vmid_lock" ((0 - (v_0)) - (VMID_LOCK_BASE))))
                                                                else (
                                                                  if (((0 - (v_0)) - (VMID_COUNT_BASE)) >=? (0))
                                                                  then (Some (mkPtr "vmid_count" ((0 - (v_0)) - (VMID_COUNT_BASE))))
                                                                  else (
                                                                    if (((0 - (v_0)) - (DEBUG_EXITS_BASE)) >=? (0))
                                                                    then (Some (mkPtr "debug_exits" ((0 - (v_0)) - (DEBUG_EXITS_BASE))))
                                                                    else (
                                                                      if (((0 - (v_0)) - (HEAP_BASE)) >=? (0))
                                                                      then (Some (mkPtr "heap" ((0 - (v_0)) - (HEAP_BASE))))
                                                                      else (Some (mkPtr "null" 0)))))))))))))))))))))))))))))))))))
    else (
      if (((0 - (v_0)) - (MAX_ERR)) >=? (0))
      then (Some (mkPtr "status" ((0 - (v_0)) - (MAX_ERR))))
      else (
        if (((0 - (v_0)) - (MEM1_VIRT)) >=? (0))
        then (Some (mkPtr "granule_data" (((0 - (v_0)) - (MEM1_VIRT)) + (MEM0_SIZE))))
        else (
          if (((0 - (v_0)) - (MEM0_VIRT)) >=? (0))
          then (Some (mkPtr "granule_data" ((0 - (v_0)) - (MEM0_VIRT))))
          else (
            if (((0 - (v_0)) - (GRANULES_BASE)) >=? (0))
            then (Some (mkPtr "granules" ((0 - (v_0)) - (GRANULES_BASE))))
            else (
              if (((0 - (v_0)) - (STACK_TYPE_4__1_BASE)) >=? (0))
              then (Some (mkPtr "stack_type_4__1" ((0 - (v_0)) - (STACK_TYPE_4__1_BASE))))
              else (
                if (((0 - (v_0)) - (STACK_TYPE_4_BASE)) >=? (0))
                then (Some (mkPtr "stack_type_4" ((0 - (v_0)) - (STACK_TYPE_4_BASE))))
                else (Some (mkPtr "null" 0)))))))))
  else (Some (mkPtr "null" 0)).

Definition __table_is_uniform_block_funptr_wrap907 (func_ptr: Ptr) (arg0: Z) (st: RData) : (option (bool * RData)) :=
  if ((func_ptr.(pbase)) =s ("s2tte_is_unassigned"))
  then (s2tte_is_unassigned_spec arg0 st)
  else (
    if ((func_ptr.(pbase)) =s ("s2tte_is_destroyed"))
    then (s2tte_is_destroyed_spec arg0 st)
    else None).

Definition __table_is_uniform_block_loop904_rank (v_0: Ptr) (v_1: Z) (v_2: Ptr) : Z :=
  (512 - (v_1)).

Definition __table_maps_block_loop946_rank (v_0: Ptr) (v_1: Z) (v_10: Z) (v_5: Z) (v__02223: Z) (v_2: Ptr) : Z :=
  0.

Definition __table_maps_block_funptr_wrap954 (func_ptr: Ptr) (arg0: Z) (arg1: Z) (st: RData) : (option (bool * RData)) :=
  if ((func_ptr.(pbase)) =s ("s2tte_is_assigned"))
  then (s2tte_is_assigned_spec arg0 arg1 st)
  else (
    if ((func_ptr.(pbase)) =s ("s2tte_is_valid"))
    then (s2tte_is_valid_spec arg0 arg1 st)
    else (
      if ((func_ptr.(pbase)) =s ("s2tte_is_valid_ns"))
      then (s2tte_is_valid_ns_spec arg0 arg1 st)
      else None)).

Definition __table_maps_block_funptr_wrap942 (func_ptr: Ptr) (arg0: Z) (arg1: Z) (st: RData) : (option (bool * RData)) :=
  if ((func_ptr.(pbase)) =s ("s2tte_is_assigned"))
  then (s2tte_is_assigned_spec arg0 arg1 st)
  else (
    if ((func_ptr.(pbase)) =s ("s2tte_is_valid"))
    then (s2tte_is_valid_spec arg0 arg1 st)
    else (
      if ((func_ptr.(pbase)) =s ("s2tte_is_valid_ns"))
      then (s2tte_is_valid_ns_spec arg0 arg1 st)
      else None)).

Definition bitmap_clear_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
  rely ((((0 - ((v_1 >> (6)))) <= (0)) /\ (((v_1 >> (6)) < (1024)))));
  (Some (lens 107 st)).

Definition status_ptr_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
  when ret == ((status_ptr_spec' v_0));
  (Some (ret, st)).

Fixpoint free_sl_rtts_loop194 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_2: bool) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * bool * Z * Z * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_0, v_2, v_indvars_iv, v_wide_trip_count, st))
  | (S _N__0) =>
    match ((free_sl_rtts_loop194 _N__0 __break__ v_0 v_2 v_indvars_iv v_wide_trip_count st)) with
    | (Some (__break___0, v_1, v_3, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
      if __break___0
      then (Some (true, v_1, v_3, v_indvars_iv_0, v_wide_trip_count_0, st_0))
      else (
        when st_1 == ((granule_lock_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 5 st_0));
        if v_3
        then (
          when st_2 == ((granule_memzero_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 6 st_1));
          when st_4 == ((granule_unlock_transition_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 1 st_2));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (Some (false, v_1, true, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_4))
          else (Some (true, v_1, true, v_indvars_iv_0, v_wide_trip_count_0, st_4)))
        else (
          when st_3 == ((granule_unlock_transition_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 1 st_1));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (Some (false, v_1, false, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_3))
          else (Some (true, v_1, false, v_indvars_iv_0, v_wide_trip_count_0, st_3))))
    | None => None
    end
  end.

Definition  (v_0: Ptr) (v_2: bool) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
  0.

Definition free_sl_rtts_spec (v_0: Ptr) (v_1: Z) (v_2: bool) (st: RData) : (option RData) :=
  if ((0 - (v_1)) <? (0))
  then (
    match ((free_sl_rtts_loop194 (z_to_nat 0) false v_0 v_2 0 v_1 st)) with
    | (Some (__break__, v_5, v_3, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some st_0)
    | None => None
    end)
  else (Some st).

