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

Definition rsi_rtt_set_ripas_0 (st_0: RData) (st_10: RData) (v_34: Ptr) (v_38: bool) (v__sroa_0_0_copyload: Ptr) (v__sroa_3_0_copyload: Z) (tte_to_write: abs_PTE_t) : (option (Z * RData)) :=
  rely ((v_38 = (true)));
  when st_16 == (
      (granule_unlock_spec
        v__sroa_0_0_copyload
        (st_10.[share].[granule_data] :<
          (((st_10.(share)).(granule_data)) #
            (((v_34.(poffset)) + ((8 * (v__sroa_3_0_copyload)))) / (4096)) ==
            ((((st_10.(share)).(granule_data)) @ (((v_34.(poffset)) + ((8 * (v__sroa_3_0_copyload)))) / (4096))).[g_norm] :<
              (((((st_10.(share)).(granule_data)) @ (((v_34.(poffset)) + ((8 * (v__sroa_3_0_copyload)))) / (4096))).(g_norm)) #
                (((v_34.(poffset)) + ((8 * (v__sroa_3_0_copyload)))) mod (4096)) ==
                (test_PTE_Z tte_to_write)))))));
  (Some (0, st_16)).

Definition rsi_rtt_set_ripas_1 (st_0: RData) (st_14: RData) (v_34: Ptr) (v_38: bool) (v__sroa_0_0_copyload: Ptr) (v__sroa_3_0_copyload: Z) (tte_to_write: abs_PTE_t) : (option (Z * RData)) :=
  rely ((v_38 = (true)));
  when st_19 == (
      (granule_unlock_spec
        v__sroa_0_0_copyload
        (st_14.[share].[granule_data] :<
          (((st_14.(share)).(granule_data)) #
            (((v_34.(poffset)) + ((8 * (v__sroa_3_0_copyload)))) / (4096)) ==
            ((((st_14.(share)).(granule_data)) @ (((v_34.(poffset)) + ((8 * (v__sroa_3_0_copyload)))) / (4096))).[g_norm] :<
              (((((st_14.(share)).(granule_data)) @ (((v_34.(poffset)) + ((8 * (v__sroa_3_0_copyload)))) / (4096))).(g_norm)) #
                (((v_34.(poffset)) + ((8 * (v__sroa_3_0_copyload)))) mod (4096)) ==
                (test_PTE_Z tte_to_write)))))));
  (Some (0, st_19)).

Definition rsi_rtt_set_ripas_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
  if (v_3 >? (1))
  then (Some (1, st))
  else (
    if (check_rcsm_mask_para (test_PA v_0))
    then (
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
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
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))
    else (
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (3)) =? (0))
      then (
        rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        when st_4 == ((granule_lock_spec (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1) 5 st_1));
        when st_5 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_4));
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
        when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))).

