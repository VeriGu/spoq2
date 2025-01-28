Definition ptr_status_spec' (v_0: Ptr) : (option Z) :=
  if ((v_0.(pbase)) =s ("status"))
  then (Some (0 - ((MAX_ERR + ((v_0.(poffset)))))))
  else (
    if ((v_0.(pbase)) =s ("null"))
    then (Some 0)
    else (
      if ((v_0.(pbase)) =s ("realm_attest_private_key"))
      then (Some (0 - ((REALM_ATTEST_PRIVATE_KEY_BASE + ((v_0.(poffset)))))))
      else (
        if ((v_0.(pbase)) =s ("get_realm_identity_identity"))
        then (Some (0 - ((GET_REALM_IDENTITY_IDENTITY_BASE + ((v_0.(poffset)))))))
        else (
          if ((v_0.(pbase)) =s ("rmm_realm_token_bufs"))
          then (Some (0 - ((RMM_REALM_TOKEN_BUFS_BASE + ((v_0.(poffset)))))))
          else (
            if ((v_0.(pbase)) =s ("rmm_platform_token"))
            then (Some (0 - ((RMM_PLATFORM_TOKEN_BASE + ((v_0.(poffset)))))))
            else (
              if ((v_0.(pbase)) =s ("platform_token_buf"))
              then (Some (0 - ((PLATFORM_TOKEN_BUF_BASE + ((v_0.(poffset)))))))
              else (
                if ((v_0.(pbase)) =s ("rmm_attest_public_key_hash_len"))
                then (Some (0 - ((RMM_ATTEST_PUBLIC_KEY_HASH_LEN_BASE + ((v_0.(poffset)))))))
                else (
                  if ((v_0.(pbase)) =s ("rmm_attest_public_key_hash"))
                  then (Some (0 - ((RMM_ATTEST_PUBLIC_KEY_HASH_BASE + ((v_0.(poffset)))))))
                  else (
                    if ((v_0.(pbase)) =s ("rmm_attest_public_key_len"))
                    then (Some (0 - ((RMM_ATTEST_PUBLIC_KEY_LEN_BASE + ((v_0.(poffset)))))))
                    else (
                      if ((v_0.(pbase)) =s ("rmm_attest_public_key"))
                      then (Some (0 - ((RMM_ATTEST_PUBLIC_KEY_BASE + ((v_0.(poffset)))))))
                      else (
                        if ((v_0.(pbase)) =s ("rmm_attest_signing_key"))
                        then (Some (0 - ((RMM_ATTEST_SIGNING_KEY_BASE + ((v_0.(poffset)))))))
                        else (
                          if ((v_0.(pbase)) =s ("granules"))
                          then (Some (0 - ((GRANULES_BASE + ((v_0.(poffset)))))))
                          else (
                            if ((v_0.(pbase)) =s ("mbedtls_mem_buf"))
                            then (Some (0 - ((MBEDTLS_MEM_BUF_BASE + ((v_0.(poffset)))))))
                            else (
                              if ((v_0.(pbase)) =s ("tt_l3_mem1"))
                              then (Some (0 - ((TT_L3_MEM1_BASE + ((v_0.(poffset)))))))
                              else (
                                if ((v_0.(pbase)) =s ("tt_l3_mem0"))
                                then (Some (0 - ((TT_L3_MEM0_BASE + ((v_0.(poffset)))))))
                                else (
                                  if ((v_0.(pbase)) =s ("tt_l2_mem1_3"))
                                  then (Some (0 - ((TT_L2_MEM1_3_BASE + ((v_0.(poffset)))))))
                                  else (
                                    if ((v_0.(pbase)) =s ("tt_l2_mem1_2"))
                                    then (Some (0 - ((TT_L2_MEM1_2_BASE + ((v_0.(poffset)))))))
                                    else (
                                      if ((v_0.(pbase)) =s ("tt_l2_mem1_1"))
                                      then (Some (0 - ((TT_L2_MEM1_1_BASE + ((v_0.(poffset)))))))
                                      else (
                                        if ((v_0.(pbase)) =s ("tt_l2_mem1_0"))
                                        then (Some (0 - ((TT_L2_MEM1_0_BASE + ((v_0.(poffset)))))))
                                        else (
                                          if ((v_0.(pbase)) =s ("tt_l2_mem0_1"))
                                          then (Some (0 - ((TT_L2_MEM0_1_BASE + ((v_0.(poffset)))))))
                                          else (
                                            if ((v_0.(pbase)) =s ("tt_l2_mem0_0"))
                                            then (Some (0 - ((TT_L2_MEM0_0_BASE + ((v_0.(poffset)))))))
                                            else (
                                              if ((v_0.(pbase)) =s ("tt_l3_buffer"))
                                              then (Some (0 - ((TT_L3_BUFFER_BASE + ((v_0.(poffset)))))))
                                              else (
                                                if ((v_0.(pbase)) =s ("rmm_trap_list"))
                                                then (Some (0 - ((RMM_TRAP_LIST_BASE + ((v_0.(poffset)))))))
                                                else (
                                                  if ((v_0.(pbase)) =s ("status_handler"))
                                                  then (Some (0 - ((STATUS_HANDLER_BASE + ((v_0.(poffset)))))))
                                                  else (
                                                    if ((v_0.(pbase)) =s ("default_gicstate"))
                                                    then (Some (0 - ((DEFAULT_GICSTATE_BASE + ((v_0.(poffset)))))))
                                                    else (
                                                      if ((v_0.(pbase)) =s ("pri_res0_mask"))
                                                      then (Some (0 - ((PRI_RES0_MASK_BASE + ((v_0.(poffset)))))))
                                                      else (
                                                        if ((v_0.(pbase)) =s ("nr_pri_bits"))
                                                        then (Some (0 - ((NR_PRI_BITS_BASE + ((v_0.(poffset)))))))
                                                        else (
                                                          if ((v_0.(pbase)) =s ("max_vintid"))
                                                          then (Some (0 - ((MAX_VINTID_BASE + ((v_0.(poffset)))))))
                                                          else (
                                                            if ((v_0.(pbase)) =s ("nr_aprs"))
                                                            then (Some (0 - ((NR_APRS_BASE + ((v_0.(poffset)))))))
                                                            else (
                                                              if ((v_0.(pbase)) =s ("nr_lrs"))
                                                              then (Some (0 - ((NR_LRS_BASE + ((v_0.(poffset)))))))
                                                              else (
                                                                if ((v_0.(pbase)) =s ("vmids"))
                                                                then (Some (0 - ((VMIDS_BASE + ((v_0.(poffset)))))))
                                                                else (
                                                                  if ((v_0.(pbase)) =s ("vmid_lock"))
                                                                  then (Some (0 - ((VMID_LOCK_BASE + ((v_0.(poffset)))))))
                                                                  else (
                                                                    if ((v_0.(pbase)) =s ("vmid_count"))
                                                                    then (Some (0 - ((VMID_COUNT_BASE + ((v_0.(poffset)))))))
                                                                    else (
                                                                      if ((v_0.(pbase)) =s ("debug_exits"))
                                                                      then (Some (0 - ((DEBUG_EXITS_BASE + ((v_0.(poffset)))))))
                                                                      else (
                                                                        if ((v_0.(pbase)) =s ("heap"))
                                                                        then (Some (0 - ((HEAP_BASE + ((v_0.(poffset)))))))
                                                                        else (
                                                                          if ((v_0.(pbase)) =s ("stack_type_4"))
                                                                          then (Some (0 - ((STACK_TYPE_4_BASE + ((v_0.(poffset)))))))
                                                                          else (
                                                                            if ((v_0.(pbase)) =s ("stack_type_4__1"))
                                                                            then (Some (0 - ((STACK_TYPE_4__1_BASE + ((v_0.(poffset)))))))
                                                                            else (
                                                                              if ((v_0.(pbase)) =s ("granule_data"))
                                                                              then (
                                                                                if ((v_0.(poffset)) <? (MEM0_SIZE))
                                                                                then (Some (0 - ((MEM0_VIRT + ((v_0.(poffset)))))))
                                                                                else (Some (0 - ((18446744007137558528 + ((v_0.(poffset))))))))
                                                                              else (Some (- 1)))))))))))))))))))))))))))))))))))))))).

Definition ptr_is_err_spec' (v_0: Ptr) : (option bool) :=
  if ((v_0.(pbase)) <>s ("status"))
  then (Some false)
  else (Some ((v_0.(poffset)) >? (34359734272))).

Definition find_lock_transition_rtts_loop209_rank (v_0: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
  (v_wide_trip_count - (v_indvars_iv)).

Definition data_create_0_low (st_0: RData) (st_17: RData) (v_0: Z) (v_39: Ptr) (v_57: Z) (v__sroa_028_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
  rely (((v_57 =? (0)) = (true)));
  when v_60, st_18 == ((s2tte_create_assigned_spec v_0 3 st_17));
  when st_20 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) v_60 st_18));
  when st_21 == ((__granule_get_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_20));
  when st_22 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_21));
  when v_68_tmp, st_23 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_22));
  when st_24 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_23));
  when v_69_tmp, st_25 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_24));
  when st_26 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 4 st_25));
  when st_27 == ((free_stack "data_create" st_0 st_26));
  (Some (0, st_27)).

Definition data_create_1_low (st_0: RData) (st_23: RData) (v_0: Z) (v_39: Ptr) (v_57: Z) (v__sroa_028_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
  rely (((v_57 =? (0)) = (true)));
  when v_60, st_24 == ((s2tte_create_assigned_spec v_0 3 st_23));
  when st_25 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) v_60 st_24));
  when st_26 == ((__granule_get_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_25));
  when st_27 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_26));
  when v_68_tmp, st_28 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_27));
  when st_29 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_28));
  when v_69_tmp, st_30 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_29));
  when st_31 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 4 st_30));
  when st_32 == ((free_stack "data_create" st_0 st_31));
  (Some (0, st_32)).

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
      when v_12, st_1 == ((find_granule_spec (((v_0 + ((- 1))) + (v_1)) & (18446744073709547520)) st));
      rely ((((v_12.(pbase)) = ("granules")) \/ (((v_12.(pbase)) = ("null")))));
      if (ptr_eqb (mkPtr "granules" ((((v_0 & (18446744073709547520)) + ((- MEM0_PHYS))) >> (12)) * (16))) v_12)
      then (Some ((mkPtr "granules" ((((v_0 & (18446744073709547520)) + ((- MEM0_PHYS))) >> (12)) * (16))), st_1))
      else (Some ((mkPtr "null" 0), st_1))))
  else (Some ((mkPtr "null" 0), st)).

Definition s2tt_init_assigned_loop801_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z :=
  512.

Definition rtt_walk_lock_unlock_loop467_rank (v_0: Ptr) (v_4: Z) (v_5: Z) (v_7: Ptr) (v_indvars_iv: Z) : Z :=
  512.

Definition s2tt_init_valid_ns_loop839_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z :=
  512.

Definition s2tt_init_valid_loop820_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z :=
  512.

Definition copy_gic_state_to_ns_loop59_rank (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
  v_wide_trip_count.

Definition copy_gic_state_from_ns_loop48_rank (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
  v_wide_trip_count.

Definition total_root_rtt_refcount_loop295_rank (v_0: Ptr) (v__011: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
  v_wide_trip_count.

Definition vmid_free_spec (v_0: Z) (st: RData) : (option RData) :=
  when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
  match (((((st.(share)).(globals)).(g_vmid_lock)).(e_val))) with
  | None =>
    rely ((((0 - ((v_0 >> (6)))) <= (0)) /\ (((v_0 >> (6)) < (1024)))));
    when sh_0 == ((((lens 120 st).(repl)) (((lens 120 st).(oracle)) ((lens 120 st).(log))) ((lens 120 st).(share))));
    (Some ((((lens 126 st).[halt] :< false).[log] :< ((EVT CPU_ID (REL vmid_lock_idx vmid_lock_g)) :: (((lens 126 st).(log))))).[share].[globals].[g_vmid_lock].[e_val] :<
      None))
  | (Some cid) => None
  end.

Fixpoint total_root_rtt_refcount_loop295 (_N_: nat) (__break__: bool) (v_0: Ptr) (v__011: Z) (v__0_lcssa: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_0, v__011, v__0_lcssa, v_indvars_iv, v_wide_trip_count, st))
  | (S _N__0) =>
    match ((total_root_rtt_refcount_loop295 _N__0 __break__ v_0 v__011 v__0_lcssa v_indvars_iv v_wide_trip_count st)) with
    | (Some (__break___0, v_1, v__12, v__0_lcssa_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
      if __break___0
      then (Some (true, v_1, v__12, v__0_lcssa_0, v_indvars_iv_0, v_wide_trip_count_0, st_0))
      else (
        when st_1 == ((granule_lock_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 5 st_0));
        when v_6, st_2 == ((g_refcount_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) st_1));
        when st_3 == ((granule_unlock_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) st_2));
        if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
        then (Some (false, v_1, (v_6 + (v__12)), v__0_lcssa_0, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_3))
        else (Some (true, v_1, v__12, (v_6 + (v__12)), v_indvars_iv_0, v_wide_trip_count_0, st_3)))
    | None => None
    end
  end.

Definition total_root_rtt_refcount_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
  if ((0 - (v_1)) <? (0))
  then (
    match ((total_root_rtt_refcount_loop295 (z_to_nat v_1) false v_0 0 0 0 v_1 st)) with
    | (Some (__break__, v_2, v__12, v__0_lcssa_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some (v__0_lcssa_0, st_0))
    | None => None
    end)
  else (Some (0, st)).

Definition find_lock_unused_granule_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
  rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) /\ (((v_0 & (4095)) = (0)))));
  when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
  rely (
    (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
      (((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
      (0)));
  if ((((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (v_1)) =? (0))
  then (
    if (((((((((lens 28 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
    then (Some ((mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))), ((lens 28 st).[halt] :< false)))
    else (Some ((mkPtr "null" 0), ((lens 133 st).[halt] :< false))))
  else (Some ((mkPtr "null" 0), ((lens 32 st).[halt] :< false))).

Definition ptr_is_err_spec (v_0: Ptr) (st: RData) : (option (bool * RData)) :=
  when ret == ((ptr_is_err_spec' v_0));
  (Some (ret, st)).

Definition ptr_status_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
  when ret == ((ptr_status_spec' v_0));
  (Some (ret, st)).

