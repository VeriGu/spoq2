Parameter check_rcsm_mask_para : abs_PA_t -> bool.

Definition map_unmap_ns_s1_0_low (st_0: RData) (st_12: RData) (v_17: Ptr) (v_3: abs_PTE_t) (v_31: Z) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
  rely (((v_31 =? (0)) = (true)));
  when st_14 == ((stage1_tlbi_all_spec st_12));
  when st_15 == ((__tte_write_spec_abs (ptr_offset v_17 (8 * (v__sroa_7_0_copyload))) v_3 st_14));
  when st_16 == ((iasm_8_spec st_15));
  when st_17 == ((iasm_12_isb_spec st_16));
  when st_18 == ((__granule_get_spec v__sroa_0_0_copyload st_17));
  when st_19 == ((granule_unlock_spec v__sroa_0_0_copyload st_18));
  when st_20 == ((free_stack "map_unmap_ns_s1" st_0 st_19));
  (Some (0, st_20)).

Definition map_unmap_ns_s1_1_low (st_0: RData) (st_11: RData) (v_17: Ptr) (v_3: abs_PTE_t) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
  when st_13 == ((stage1_tlbi_all_spec st_11));
  when st_14 == ((__tte_write_spec_abs (ptr_offset v_17 (8 * (v__sroa_7_0_copyload))) v_3 st_13));
  when st_15 == ((iasm_8_spec st_14));
  when st_16 == ((iasm_12_isb_spec st_15));
  when st_17 == ((__granule_get_spec v__sroa_0_0_copyload st_16));
  when st_18 == ((granule_unlock_spec v__sroa_0_0_copyload st_17));
  when st_19 == ((free_stack "map_unmap_ns_s1" st_0 st_18));
  (Some (0, st_19)).

Definition map_unmap_ns_s1_2_low (st_0: RData) (st_12: RData) (v_17: Ptr) (v_47: Z) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
  rely (((v_47 =? (0)) = (true)));
  when v_51, st_14 == ((s2tte_create_unassigned_spec_abs 1 st_12));
  when st_15 == ((__tte_write_spec_abs (ptr_offset v_17 (8 * (v__sroa_7_0_copyload))) v_51 st_14));
  when st_16 == ((iasm_8_spec st_15));
  when st_17 == ((iasm_12_isb_spec st_16));
  when st_18 == ((stage1_tlbi_all_spec st_17));
  when st_19 == ((__granule_put_spec v__sroa_0_0_copyload st_18));
  when st_20 == ((granule_unlock_spec v__sroa_0_0_copyload st_19));
  when st_21 == ((free_stack "map_unmap_ns_s1" st_0 st_20));
  (Some (0, st_21)).

Definition map_unmap_ns_s1_3_low (st_0: RData) (st_11: RData) (v_17: Ptr) (v_20: abs_PTE_t) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
  when v_51, st_13 == ((s2tte_create_unassigned_spec_abs 1 st_11));
  when st_14 == ((__tte_write_spec_abs (ptr_offset v_17 (8 * (v__sroa_7_0_copyload))) v_51 st_13));
  when st_15 == ((iasm_8_spec st_14));
  when st_16 == ((iasm_12_isb_spec st_15));
  when st_17 == ((stage1_tlbi_all_spec st_16));
  when st_18 == ((__granule_put_spec v__sroa_0_0_copyload st_17));
  when st_19 == ((granule_unlock_spec v__sroa_0_0_copyload st_18));
  when st_20 == ((free_stack "map_unmap_ns_s1" st_0 st_19));
  (Some (0, st_20)).

Definition rsi_rtt_set_ripas_0_low (st_0: RData) (st_10: RData) (v_34: Ptr) (v_38: bool) (v__sroa_0_0_copyload: Ptr) (v__sroa_3_0_copyload: Z) (tte_to_write: abs_PTE_t) : (option (Z * RData)) :=
  rely ((v_38 = (true)));
  when st_12 == ((__tte_write_spec_abs (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) tte_to_write st_10));
  when st_13 == ((iasm_8_spec st_12));
  when st_14 == ((stage1_tlbi_all_spec st_13));
  when st_16 == ((granule_unlock_spec v__sroa_0_0_copyload st_14));
  when st_15 == ((free_stack "rsi_rtt_set_ripas" st_0 st_16));
  (Some (0, st_15)).

Definition rsi_rtt_set_ripas_1_low (st_0: RData) (st_14: RData) (v_34: Ptr) (v_38: bool) (v__sroa_0_0_copyload: Ptr) (v__sroa_3_0_copyload: Z) (tte_to_write: abs_PTE_t) : (option (Z * RData)) :=
  rely ((v_38 = (true)));
  when st_16 == ((__tte_write_spec_abs (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) tte_to_write st_14));
  when st_17 == ((iasm_8_spec st_16));
  when st_18 == ((stage1_tlbi_all_spec st_17));
  when st_19 == ((granule_unlock_spec v__sroa_0_0_copyload st_18));
  when st_20 == ((free_stack "rsi_rtt_set_ripas" st_0 st_19));
  (Some (0, st_20)).

Definition rsi_data_map_extra_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
  when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st));
  if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (4)) =? (0))
  then (
    rely (((((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\ (((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) >= (0)))));
    when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
    if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
    then (
      rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) 0 64 v_1 3 st_2));
      rely ((((st_4.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
      if ((rtt_ret.(e_1)) =? (3))
      then (
        if (
          (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
            ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
            ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
        then (
          when st_13 == ((granule_lock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) 2 st_4));
          when v_11, st_3 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_13));
          if v_11
          then (
            when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_3));
            rely ((((rtt_ret.(e_2)).(pbase)) =s ("granules")));
            rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
            when st_29 == (
                (granule_unlock_spec
                  (rtt_ret.(e_2))
                  ((st_18.[share].[globals].[g_granules] :<
                    (((((st_18.(share)).(globals)).(g_granules)) #
                      ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                      (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                        ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                      ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (16)) ==
                      ((((((st_18.(share)).(globals)).(g_granules)) #
                        ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                        (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                          ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                        (((((((st_18.(share)).(globals)).(g_granules)) #
                          ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          ((g_mapped_addr_set_para
                            (((((((st_18.(share)).(globals)).(g_granules)) #
                              ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
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
            when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) 0 4096 st_3));
            when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
            when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
            when st_6 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_21));
            (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_6))))
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

Definition rsi_data_destroy_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
  if (check_rcsm_mask_para (test_PA v_0))
  then (
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
    then (
      rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      when ret_rtt, st_3 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) 0 64 v_1 3 st_1));
      if ((ret_rtt.(e_1)) =? (3))
      then (
        if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_desc_type)) =? (3))
        then (
          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
          when st_2 == (
              (spinlock_acquire_spec
                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                ((st_3.[share].[globals].[g_granules] :<
                  ((((st_3.(share)).(globals)).(g_granules)) #
                    (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                    (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                      ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                        (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                  (((st_3.(share)).(granule_data)) #
                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                    ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                      (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                        (test_PTE_Z s2tte_create_destroyed_abs)))))));
          if (
            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
              (4)) =?
              (0)))
          then (
            rely (
              ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
            if (
              ((g_refcount_para
                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                (st_2.[share].[globals].[g_granules] :<
                  ((((st_2.(share)).(globals)).(g_granules)) #
                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                    (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                        (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                          ((- 1)))))))) =?
                (0)))
            then (
              when v_4, st_4 == (
                  (memset_spec
                    (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                    0
                    4096
                    (st_2.[share].[globals].[g_granules] :<
                      ((((st_2.(share)).(globals)).(g_granules)) #
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                              ((- 1)))))))));
              when st_5 == (
                  (granule_unlock_spec
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                    (st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                          1)))));
              when st_23 == ((granule_unlock_spec (ret_rtt.(e_2)) st_5));
              (Some (0, st_23)))
            else (
              when st_20 == (
                  (granule_unlock_spec
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                    (st_2.[share].[globals].[g_granules] :<
                      ((((st_2.(share)).(globals)).(g_granules)) #
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                              ((- 1)))))))));
              when st_22 == ((granule_unlock_spec (ret_rtt.(e_2)) st_20));
              (Some (0, st_22))))
          else None)
        else (
          if (
            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_desc_type)) =? (0)) &&
              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_ripas)) =? (0)))) &&
              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_mem_attr)) =? (1)))))
          then (
            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
            when st_2 == (
                (spinlock_acquire_spec
                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                  ((st_3.[share].[globals].[g_granules] :<
                    ((((st_3.(share)).(globals)).(g_granules)) #
                      (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                      (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                        ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                    (((st_3.(share)).(granule_data)) #
                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                      ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                        (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                          (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
            if (
              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                (4)) =?
                (0)))
            then (
              rely (
                ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                  (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
              if (
                ((g_refcount_para
                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                  (st_2.[share].[globals].[g_granules] :<
                    ((((st_2.(share)).(globals)).(g_granules)) #
                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                      (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                            ((- 1)))))))) =?
                  (0)))
              then (
                when v_4, st_4 == (
                    (memset_spec
                      (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                      0
                      4096
                      (st_2.[share].[globals].[g_granules] :<
                        ((((st_2.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))));
                when st_5 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                      (st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                            1)))));
                when st_24 == ((granule_unlock_spec (ret_rtt.(e_2)) st_5));
                (Some (0, st_24)))
              else (
                when st_22 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)))
                      (st_2.[share].[globals].[g_granules] :<
                        ((((st_2.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))));
                when st_23 == ((granule_unlock_spec (ret_rtt.(e_2)) st_22));
                (Some (0, st_23))))
            else None)
          else (
            when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_3));
            (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13)))))
      else (
        when st_7 == ((granule_unlock_spec (ret_rtt.(e_2)) st_3));
        (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))
  else (
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (3)) =? (0))
    then (
      rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      rely (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)));
      rely (((((((st.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
      when st_2 == (
          (spinlock_acquire_spec
            (mkPtr
              ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(pbase))
              ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)))
            st_1));
      if (
        (((((((st_2.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (16))).(e_state_s_granule)) -
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
              3
              st_5));
        if ((ret_rtt.(e_1)) =? (3))
        then (
          rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
          rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
          if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
          then (
            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
            when st_3 == (
                (spinlock_acquire_spec
                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                  ((st_7.[share].[globals].[g_granules] :<
                    ((((st_7.(share)).(globals)).(g_granules)) #
                      (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                      (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                        ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                    (((st_7.(share)).(granule_data)) #
                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                      ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                        (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                          (test_PTE_Z s2tte_create_destroyed_abs)))))));
            if (
              (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                (4)) =?
                (0)))
            then (
              rely (
                ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                  (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
              if (
                ((g_refcount_para
                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                  (st_3.[share].[globals].[g_granules] :<
                    ((((st_3.(share)).(globals)).(g_granules)) #
                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                      (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                        ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                            ((- 1)))))))) =?
                  (0)))
              then (
                when v_4, st_6 == (
                    (memset_spec
                      (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      0
                      4096
                      (st_3.[share].[globals].[g_granules] :<
                        ((((st_3.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))));
                when st_8 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      (st_6.[share].[globals].[g_granules] :<
                        ((((st_6.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                            1)))));
                when st_24 == ((granule_unlock_spec (ret_rtt.(e_2)) st_8));
                (Some (0, st_24)))
              else (
                when st_22 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      (st_3.[share].[globals].[g_granules] :<
                        ((((st_3.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))));
                when st_23 == ((granule_unlock_spec (ret_rtt.(e_2)) st_22));
                (Some (0, st_23))))
            else None)
          else (
            if (
              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
            then (
              rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
              when st_3 == (
                  (spinlock_acquire_spec
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                    ((st_7.[share].[globals].[g_granules] :<
                      ((((st_7.(share)).(globals)).(g_granules)) #
                        (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                        (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                          ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                      (((st_7.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
              if (
                (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                  (4)) =?
                  (0)))
              then (
                rely (
                  ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                    (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                if (
                  ((g_refcount_para
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                    (st_3.[share].[globals].[g_granules] :<
                      ((((st_3.(share)).(globals)).(g_granules)) #
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                          ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                              ((- 1)))))))) =?
                    (0)))
                then (
                  when v_4, st_6 == (
                      (memset_spec
                        (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        0
                        4096
                        (st_3.[share].[globals].[g_granules] :<
                          ((((st_3.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))));
                  when st_8 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        (st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                              1)))));
                  when st_26 == ((granule_unlock_spec (ret_rtt.(e_2)) st_8));
                  (Some (0, st_26)))
                else (
                  when st_24 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        (st_3.[share].[globals].[g_granules] :<
                          ((((st_3.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))));
                  when st_25 == ((granule_unlock_spec (ret_rtt.(e_2)) st_24));
                  (Some (0, st_25))))
              else None)
            else (
              when st_16 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
              (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_16)))))
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
              3
              st_5));
        if ((ret_rtt.(e_1)) =? (3))
        then (
          rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
          rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
          if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
          then (
            rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
            when st_6 == (
                (spinlock_acquire_spec
                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                  ((st_7.[share].[globals].[g_granules] :<
                    ((((st_7.(share)).(globals)).(g_granules)) #
                      (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                      (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                        ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                    (((st_7.(share)).(granule_data)) #
                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                      ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                        (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                          (test_PTE_Z s2tte_create_destroyed_abs)))))));
            if (
              (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                (4)) =?
                (0)))
            then (
              rely (
                ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                  (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
              if (
                ((g_refcount_para
                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                  (st_6.[share].[globals].[g_granules] :<
                    ((((st_6.(share)).(globals)).(g_granules)) #
                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                      (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                        ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                            ((- 1)))))))) =?
                  (0)))
              then (
                when v_4, st_8 == (
                    (memset_spec
                      (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      0
                      4096
                      (st_6.[share].[globals].[g_granules] :<
                        ((((st_6.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))));
                when st_9 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      (st_8.[share].[globals].[g_granules] :<
                        ((((st_8.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_8.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                            1)))));
                when st_24 == ((granule_unlock_spec (ret_rtt.(e_2)) st_9));
                (Some (0, st_24)))
              else (
                when st_22 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      (st_6.[share].[globals].[g_granules] :<
                        ((((st_6.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))));
                when st_23 == ((granule_unlock_spec (ret_rtt.(e_2)) st_22));
                (Some (0, st_23))))
            else None)
          else (
            if (
              (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (0)) &&
                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_ripas)) =? (0)))) &&
                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_mem_attr)) =? (1)))))
            then (
              rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
              when st_6 == (
                  (spinlock_acquire_spec
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                    ((st_7.[share].[globals].[g_granules] :<
                      ((((st_7.(share)).(globals)).(g_granules)) #
                        (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                        (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                          ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                      (((st_7.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 0))))))));
              if (
                (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                  (4)) =?
                  (0)))
              then (
                rely (
                  ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                    (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                if (
                  ((g_refcount_para
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                    (st_6.[share].[globals].[g_granules] :<
                      ((((st_6.(share)).(globals)).(g_granules)) #
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                          ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                              ((- 1)))))))) =?
                    (0)))
                then (
                  when v_4, st_8 == (
                      (memset_spec
                        (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        0
                        4096
                        (st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))));
                  when st_9 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        (st_8.[share].[globals].[g_granules] :<
                          ((((st_8.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_8.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                              1)))));
                  when st_26 == ((granule_unlock_spec (ret_rtt.(e_2)) st_9));
                  (Some (0, st_26)))
                else (
                  when st_24 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        (st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))));
                  when st_25 == ((granule_unlock_spec (ret_rtt.(e_2)) st_24));
                  (Some (0, st_25))))
              else None)
            else (
              when st_16 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
              (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_16)))))
        else (
          when st_11 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
          (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_11)))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2)))).

Definition rsi_rtt_destroy_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
  when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st));
  if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
  then (
    rely ((((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
    when ret_rtt, st_2 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 0 64 v_2 (v_3 + ((- 1))) st_1));
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
          if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
          then (
            rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
            if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3) =? (0))
            then (
              rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
              when v_5, st_4 == (
                  (memset_spec
                    (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                    0
                    4096
                    ((st_3.[share].[globals].[g_granules] :<
                      ((((st_3.(share)).(globals)).(g_granules)) #
                        (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                        (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                      (((st_3.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
              when st_24 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
              when st_28 == ((granule_unlock_spec (ret_rtt.(e_2)) st_24));
              (Some (0, st_28)))
            else (
              when st_14 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
              when st_18 == ((granule_unlock_spec (ret_rtt.(e_2)) st_14));
              (Some ((pack_struct_return_code_para (make_return_code_para 4)), st_18))))
          else None)
        else (
          when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))
      else (
        when st_12 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
        (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_12))))
    else (
      when st_7 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
      (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7))))
  else (
    when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
    (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).

