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

Definition s2tt_init_assigned_loop801_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z :=
  512.

Definition s2tt_init_valid_ns_loop839_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z :=
  512.

Definition rtt_walk_lock_unlock_loop467_rank (v_0: Ptr) (v_4: Z) (v_5: Z) (v_7: Ptr) (v_indvars_iv: Z) : Z :=
  512.

Definition s2tt_init_valid_loop820_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z :=
  512.

Definition copy_gic_state_to_ns_loop59_rank (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
  v_wide_trip_count.

Definition copy_gic_state_from_ns_loop48_rank (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
  v_wide_trip_count.

Definition total_root_rtt_refcount_loop295_rank (v_0: Ptr) (v__011: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
  v_wide_trip_count.

Definition find_lock_unused_granule_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
  rely (
    (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - ((MEM0_PHYS + (MEM0_SIZE)))) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - ((MEM1_PHYS + (MEM1_SIZE)))) < (0)))))) /\
      (((v_0 & (4095)) = (0)))));
  when st_1 == ((query_oracle st));
  rely (((((st_1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
  if ((v_0 - (MEM1_PHYS)) >=? (0))
  then (
    when st1 == ((query_oracle st));
    match (((((((st1.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (4096))).(e_lock)).(e_val))) with
    | None =>
      rely (((true /\ ((((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) mod (4096)) = (0)))) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
      if (((((((st1.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (4096))).(e_state_s_granule)) - (v_1)) =? (0))
      then (
        if (((GRANULES_BASE + (((mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))).(poffset)))) - ((ptr_to_int (mkPtr "null" 0)))) =? (0))
        then (
          when v_5, st_3 == (
              (status_ptr_spec
                1
                (st1.[share].[globals].[g_granules] :<
                  ((((st1.(share)).(globals)).(g_granules)) #
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (4096)) ==
                    (((((st1.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))));
          (Some (v_5, st_3)))
        else (
          when v_8, st_3 == (
              (granule_refcount_read_acquire_spec
                (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))
                (st1.[share].[globals].[g_granules] :<
                  ((((st1.(share)).(globals)).(g_granules)) #
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (4096)) ==
                    (((((st1.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))));
          if (v_8 =? (0))
          then (Some ((mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))), st_3))
          else (
            when st_4 == ((granule_unlock_spec (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))) st_3));
            when v_10, st_5 == ((status_ptr_spec 4 st_4));
            (Some (v_10, st_5)))))
      else (
        if (ptr_eqb (mkPtr "null" 0) (mkPtr "null" 0))
        then (
          when v_5, st_3 == (
              (status_ptr_spec
                1
                (st1.[share].[globals].[g_granules] :<
                  ((((st1.(share)).(globals)).(g_granules)) #
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (4096)) ==
                    (((((st1.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (4096))).[e_lock].[e_val] :< None)))));
          (Some (v_5, st_3)))
        else (
          when v_8, st_3 == (
              (granule_refcount_read_acquire_spec
                (mkPtr "null" 0)
                (st1.[share].[globals].[g_granules] :<
                  ((((st1.(share)).(globals)).(g_granules)) #
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (4096)) ==
                    (((((st1.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (4096))).[e_lock].[e_val] :< None)))));
          if (v_8 =? (0))
          then (Some ((mkPtr "null" 0), st_3))
          else (
            when st_4 == ((granule_unlock_spec (mkPtr "null" 0) st_3));
            when v_10, st_5 == ((status_ptr_spec 4 st_4));
            (Some (v_10, st_5)))))
    | (Some cid) => None
    end)
  else (
    if (ptr_eqb (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) (mkPtr "null" 0))
    then (
      if (ptr_eqb (mkPtr "null" 0) (mkPtr "null" 0))
      then (
        when v_5, st_2 == ((status_ptr_spec 1 st_1));
        (Some (v_5, st_2)))
      else (
        when v_8, st_2 == ((granule_refcount_read_acquire_spec (mkPtr "null" 0) st_1));
        if (v_8 =? (0))
        then (Some ((mkPtr "null" 0), st_2))
        else (
          when st_3 == ((granule_unlock_spec (mkPtr "null" 0) st_2));
          when v_10, st_4 == ((status_ptr_spec 4 st_3));
          (Some (v_10, st_4)))))
    else (
      when v_6, st_2 == ((granule_try_lock_spec (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) v_1 st_1));
      if v_6
      then (
        when v_8, st_3 == ((granule_refcount_read_acquire_spec (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) st_2));
        if (v_8 =? (0))
        then (Some ((mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))), st_3))
        else (
          when st_4 == ((granule_unlock_spec (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) st_3));
          when v_10, st_5 == ((status_ptr_spec 4 st_4));
          (Some (v_10, st_5))))
      else (
        if (ptr_eqb (mkPtr "null" 0) (mkPtr "null" 0))
        then (
          when v_5, st_3 == ((status_ptr_spec 1 st_2));
          (Some (v_5, st_3)))
        else (
          when v_8, st_3 == ((granule_refcount_read_acquire_spec (mkPtr "null" 0) st_2));
          if (v_8 =? (0))
          then (Some ((mkPtr "null" 0), st_3))
          else (
            when st_4 == ((granule_unlock_spec (mkPtr "null" 0) st_3));
            when v_10, st_5 == ((status_ptr_spec 4 st_4));
            (Some (v_10, st_5))))))).

Definition ptr_is_err_spec (v_0: Ptr) (st: RData) : (option (bool * RData)) :=
  if (((int_to_ptr 18446744073709547520).(pbase)) =s ("status"))
  then (
    if ((v_0.(pbase)) <>s ("status"))
    then (Some (false, st))
    else (Some (((v_0.(poffset)) >? (((int_to_ptr 18446744073709547520).(poffset)))), st)))
  else (
    (Some (
      (if ((v_0.(pbase)) =s ("status"))
      then (MAX_ERR + ((v_0.(poffset))))
      else (
        if ((v_0.(pbase)) =s ("null"))
        then 0
        else (
          if ((v_0.(pbase)) =s ("realm_attest_private_key"))
          then (REALM_ATTEST_PRIVATE_KEY_BASE + ((v_0.(poffset))))
          else (
            if ((v_0.(pbase)) =s ("get_realm_identity_identity"))
            then (GET_REALM_IDENTITY_IDENTITY_BASE + ((v_0.(poffset))))
            else (
              if ((v_0.(pbase)) =s ("rmm_realm_token_bufs"))
              then (RMM_REALM_TOKEN_BUFS_BASE + ((v_0.(poffset))))
              else (
                if ((v_0.(pbase)) =s ("rmm_platform_token"))
                then (RMM_PLATFORM_TOKEN_BASE + ((v_0.(poffset))))
                else (
                  if ((v_0.(pbase)) =s ("platform_token_buf"))
                  then (PLATFORM_TOKEN_BUF_BASE + ((v_0.(poffset))))
                  else (
                    if ((v_0.(pbase)) =s ("rmm_attest_public_key_hash_len"))
                    then (RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE + ((v_0.(poffset))))
                    else (
                      if ((v_0.(pbase)) =s ("rmm_attest_public_key_hash"))
                      then (RMM_ATTEST_PUBLIC_KEY_HASH_BASE + ((v_0.(poffset))))
                      else (
                        if ((v_0.(pbase)) =s ("rmm_attest_public_key_len"))
                        then (RMM_ATTEST_PUBLIC_KEY_LEN_BASE + ((v_0.(poffset))))
                        else (
                          if ((v_0.(pbase)) =s ("rmm_attest_public_key"))
                          then (RMM_ATTEST_PUBLIC_KEY_BASE + ((v_0.(poffset))))
                          else (
                            if ((v_0.(pbase)) =s ("rmm_attest_signing_key"))
                            then (RMM_ATTEST_SIGNING_KEY_BASE + ((v_0.(poffset))))
                            else (
                              if ((v_0.(pbase)) =s ("granules"))
                              then (GRANULES_BASE + ((v_0.(poffset))))
                              else (
                                if ((v_0.(pbase)) =s ("mbedtls_mem_buf"))
                                then (MBEDTLS_MEM_BUF_BASE + ((v_0.(poffset))))
                                else (
                                  if ((v_0.(pbase)) =s ("tt_l3_mem1"))
                                  then (TT_L3_MEM1_BASE + ((v_0.(poffset))))
                                  else (
                                    if ((v_0.(pbase)) =s ("tt_l3_mem0"))
                                    then (TT_L3_MEM0_BASE + ((v_0.(poffset))))
                                    else (
                                      if ((v_0.(pbase)) =s ("tt_l2_mem1_3"))
                                      then (TT_L2_MEM1_3_BASE + ((v_0.(poffset))))
                                      else (
                                        if ((v_0.(pbase)) =s ("tt_l2_mem1_2"))
                                        then (TT_L2_MEM1_2_BASE + ((v_0.(poffset))))
                                        else (
                                          if ((v_0.(pbase)) =s ("tt_l2_mem1_1"))
                                          then (TT_L2_MEM1_1_BASE + ((v_0.(poffset))))
                                          else (
                                            if ((v_0.(pbase)) =s ("tt_l2_mem1_0"))
                                            then (TT_L2_MEM1_0_BASE + ((v_0.(poffset))))
                                            else (
                                              if ((v_0.(pbase)) =s ("tt_l2_mem0_1"))
                                              then (TT_L2_MEM0_1_BASE + ((v_0.(poffset))))
                                              else (
                                                if ((v_0.(pbase)) =s ("tt_l2_mem0_0"))
                                                then (TT_L2_MEM0_0_BASE + ((v_0.(poffset))))
                                                else (
                                                  if ((v_0.(pbase)) =s ("tt_l3_buffer"))
                                                  then (TT_L3_BUFFER_BASE + ((v_0.(poffset))))
                                                  else (
                                                    if ((v_0.(pbase)) =s ("rmm_trap_list"))
                                                    then (RMM_TRAP_LIST_BASE + ((v_0.(poffset))))
                                                    else (
                                                      if ((v_0.(pbase)) =s ("status_handler"))
                                                      then (STATUS_HANDLER_BASE + ((v_0.(poffset))))
                                                      else (
                                                        if ((v_0.(pbase)) =s ("default_gicstate"))
                                                        then (DEFAULT_GICSTATE_BASE + ((v_0.(poffset))))
                                                        else (
                                                          if ((v_0.(pbase)) =s ("pri_res0_mask"))
                                                          then (PRI_RES0_MASK_BASE + ((v_0.(poffset))))
                                                          else (
                                                            if ((v_0.(pbase)) =s ("nr_pri_bits"))
                                                            then (NR_PRI_BITS_BASE + ((v_0.(poffset))))
                                                            else (
                                                              if ((v_0.(pbase)) =s ("max_vintid"))
                                                              then (MAX_VINTID_BASE + ((v_0.(poffset))))
                                                              else (
                                                                if ((v_0.(pbase)) =s ("nr_aprs"))
                                                                then (NR_APRS_BASE + ((v_0.(poffset))))
                                                                else (
                                                                  if ((v_0.(pbase)) =s ("nr_lrs"))
                                                                  then (NR_LRS_BASE + ((v_0.(poffset))))
                                                                  else (
                                                                    if ((v_0.(pbase)) =s ("vmids"))
                                                                    then (VMIDS_BASE + ((v_0.(poffset))))
                                                                    else (
                                                                      if ((v_0.(pbase)) =s ("vmid_lock"))
                                                                      then (VMID_LOCK_BASE + ((v_0.(poffset))))
                                                                      else (
                                                                        if ((v_0.(pbase)) =s ("vmid_count"))
                                                                        then (VMID_COUNT_BASE + ((v_0.(poffset))))
                                                                        else (
                                                                          if ((v_0.(pbase)) =s ("debug_exits"))
                                                                          then (DEBUG_EXITS_BASE + ((v_0.(poffset))))
                                                                          else (
                                                                            if ((v_0.(pbase)) =s ("heap"))
                                                                            then (HEAP_BASE + ((v_0.(poffset))))
                                                                            else (
                                                                              if ((v_0.(pbase)) =s ("stack_type_4"))
                                                                              then (STACK_TYPE_4_BASE + ((v_0.(poffset))))
                                                                              else (
                                                                                if ((v_0.(pbase)) =s ("stack_type_4__1"))
                                                                                then (STACK_TYPE_4__1_BASE + ((v_0.(poffset))))
                                                                                else (
                                                                                  if ((v_0.(pbase)) =s ("granule_data"))
                                                                                  then (
                                                                                    if ((v_0.(poffset)) <? (MEM0_SIZE))
                                                                                    then (MEM0_VIRT + ((v_0.(poffset))))
                                                                                    else ((MEM1_VIRT + ((v_0.(poffset)))) - (MEM0_SIZE)))
                                                                                  else 1)))))))))))))))))))))))))))))))))))))) >?
        (18446744073709547520))  ,
      st
    ))).

Definition ptr_status_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
  if ((v_0.(pbase)) =s ("status"))
  then (Some ((0 - ((MAX_ERR + ((v_0.(poffset)))))), st))
  else (
    if ((v_0.(pbase)) =s ("null"))
    then (Some (0, st))
    else (
      if ((v_0.(pbase)) =s ("realm_attest_private_key"))
      then (Some ((0 - ((REALM_ATTEST_PRIVATE_KEY_BASE + ((v_0.(poffset)))))), st))
      else (
        if ((v_0.(pbase)) =s ("get_realm_identity_identity"))
        then (Some ((0 - ((GET_REALM_IDENTITY_IDENTITY_BASE + ((v_0.(poffset)))))), st))
        else (
          if ((v_0.(pbase)) =s ("rmm_realm_token_bufs"))
          then (Some ((0 - ((RMM_REALM_TOKEN_BUFS_BASE + ((v_0.(poffset)))))), st))
          else (
            if ((v_0.(pbase)) =s ("rmm_platform_token"))
            then (Some ((0 - ((RMM_PLATFORM_TOKEN_BASE + ((v_0.(poffset)))))), st))
            else (
              if ((v_0.(pbase)) =s ("platform_token_buf"))
              then (Some ((0 - ((PLATFORM_TOKEN_BUF_BASE + ((v_0.(poffset)))))), st))
              else (
                if ((v_0.(pbase)) =s ("rmm_attest_public_key_hash_len"))
                then (Some ((0 - ((RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE + ((v_0.(poffset)))))), st))
                else (
                  if ((v_0.(pbase)) =s ("rmm_attest_public_key_hash"))
                  then (Some ((0 - ((RMM_ATTEST_PUBLIC_KEY_HASH_BASE + ((v_0.(poffset)))))), st))
                  else (
                    if ((v_0.(pbase)) =s ("rmm_attest_public_key_len"))
                    then (Some ((0 - ((RMM_ATTEST_PUBLIC_KEY_LEN_BASE + ((v_0.(poffset)))))), st))
                    else (
                      if ((v_0.(pbase)) =s ("rmm_attest_public_key"))
                      then (Some ((0 - ((RMM_ATTEST_PUBLIC_KEY_BASE + ((v_0.(poffset)))))), st))
                      else (
                        if ((v_0.(pbase)) =s ("rmm_attest_signing_key"))
                        then (Some ((0 - ((RMM_ATTEST_SIGNING_KEY_BASE + ((v_0.(poffset)))))), st))
                        else (
                          if ((v_0.(pbase)) =s ("granules"))
                          then (Some ((0 - ((GRANULES_BASE + ((v_0.(poffset)))))), st))
                          else (
                            if ((v_0.(pbase)) =s ("mbedtls_mem_buf"))
                            then (Some ((0 - ((MBEDTLS_MEM_BUF_BASE + ((v_0.(poffset)))))), st))
                            else (
                              if ((v_0.(pbase)) =s ("tt_l3_mem1"))
                              then (Some ((0 - ((TT_L3_MEM1_BASE + ((v_0.(poffset)))))), st))
                              else (
                                if ((v_0.(pbase)) =s ("tt_l3_mem0"))
                                then (Some ((0 - ((TT_L3_MEM0_BASE + ((v_0.(poffset)))))), st))
                                else (
                                  if ((v_0.(pbase)) =s ("tt_l2_mem1_3"))
                                  then (Some ((0 - ((TT_L2_MEM1_3_BASE + ((v_0.(poffset)))))), st))
                                  else (
                                    if ((v_0.(pbase)) =s ("tt_l2_mem1_2"))
                                    then (Some ((0 - ((TT_L2_MEM1_2_BASE + ((v_0.(poffset)))))), st))
                                    else (
                                      if ((v_0.(pbase)) =s ("tt_l2_mem1_1"))
                                      then (Some ((0 - ((TT_L2_MEM1_1_BASE + ((v_0.(poffset)))))), st))
                                      else (
                                        if ((v_0.(pbase)) =s ("tt_l2_mem1_0"))
                                        then (Some ((0 - ((TT_L2_MEM1_0_BASE + ((v_0.(poffset)))))), st))
                                        else (
                                          if ((v_0.(pbase)) =s ("tt_l2_mem0_1"))
                                          then (Some ((0 - ((TT_L2_MEM0_1_BASE + ((v_0.(poffset)))))), st))
                                          else (
                                            if ((v_0.(pbase)) =s ("tt_l2_mem0_0"))
                                            then (Some ((0 - ((TT_L2_MEM0_0_BASE + ((v_0.(poffset)))))), st))
                                            else (
                                              if ((v_0.(pbase)) =s ("tt_l3_buffer"))
                                              then (Some ((0 - ((TT_L3_BUFFER_BASE + ((v_0.(poffset)))))), st))
                                              else (
                                                if ((v_0.(pbase)) =s ("rmm_trap_list"))
                                                then (Some ((0 - ((RMM_TRAP_LIST_BASE + ((v_0.(poffset)))))), st))
                                                else (
                                                  if ((v_0.(pbase)) =s ("status_handler"))
                                                  then (Some ((0 - ((STATUS_HANDLER_BASE + ((v_0.(poffset)))))), st))
                                                  else (
                                                    if ((v_0.(pbase)) =s ("default_gicstate"))
                                                    then (Some ((0 - ((DEFAULT_GICSTATE_BASE + ((v_0.(poffset)))))), st))
                                                    else (
                                                      if ((v_0.(pbase)) =s ("pri_res0_mask"))
                                                      then (Some ((0 - ((PRI_RES0_MASK_BASE + ((v_0.(poffset)))))), st))
                                                      else (
                                                        if ((v_0.(pbase)) =s ("nr_pri_bits"))
                                                        then (Some ((0 - ((NR_PRI_BITS_BASE + ((v_0.(poffset)))))), st))
                                                        else (
                                                          if ((v_0.(pbase)) =s ("max_vintid"))
                                                          then (Some ((0 - ((MAX_VINTID_BASE + ((v_0.(poffset)))))), st))
                                                          else (
                                                            if ((v_0.(pbase)) =s ("nr_aprs"))
                                                            then (Some ((0 - ((NR_APRS_BASE + ((v_0.(poffset)))))), st))
                                                            else (
                                                              if ((v_0.(pbase)) =s ("nr_lrs"))
                                                              then (Some ((0 - ((NR_LRS_BASE + ((v_0.(poffset)))))), st))
                                                              else (
                                                                if ((v_0.(pbase)) =s ("vmids"))
                                                                then (Some ((0 - ((VMIDS_BASE + ((v_0.(poffset)))))), st))
                                                                else (
                                                                  if ((v_0.(pbase)) =s ("vmid_lock"))
                                                                  then (Some ((0 - ((VMID_LOCK_BASE + ((v_0.(poffset)))))), st))
                                                                  else (
                                                                    if ((v_0.(pbase)) =s ("vmid_count"))
                                                                    then (Some ((0 - ((VMID_COUNT_BASE + ((v_0.(poffset)))))), st))
                                                                    else (
                                                                      if ((v_0.(pbase)) =s ("debug_exits"))
                                                                      then (Some ((0 - ((DEBUG_EXITS_BASE + ((v_0.(poffset)))))), st))
                                                                      else (
                                                                        if ((v_0.(pbase)) =s ("heap"))
                                                                        then (Some ((0 - ((HEAP_BASE + ((v_0.(poffset)))))), st))
                                                                        else (
                                                                          if ((v_0.(pbase)) =s ("stack_type_4"))
                                                                          then (Some ((0 - ((STACK_TYPE_4_BASE + ((v_0.(poffset)))))), st))
                                                                          else (
                                                                            if ((v_0.(pbase)) =s ("stack_type_4__1"))
                                                                            then (Some ((0 - ((STACK_TYPE_4__1_BASE + ((v_0.(poffset)))))), st))
                                                                            else (
                                                                              if ((v_0.(pbase)) =s ("granule_data"))
                                                                              then (
                                                                                if ((v_0.(poffset)) <? (MEM0_SIZE))
                                                                                then (Some ((0 - ((MEM0_VIRT + ((v_0.(poffset)))))), st))
                                                                                else (Some ((0 - (((MEM1_VIRT + ((v_0.(poffset)))) - (MEM0_SIZE)))), st)))
                                                                              else (Some ((- 1), st)))))))))))))))))))))))))))))))))))))))).

