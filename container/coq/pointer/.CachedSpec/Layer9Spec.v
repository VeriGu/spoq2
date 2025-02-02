Parameter check_rcsm_mask_para : abs_PA_t -> bool.

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
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (3)) =? (0))
      then (
        rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
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

Definition rsi_rtt_create_spec (v_0_Zptr: Z) (v_1_Zptr: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
  if (check_rcsm_mask_para (test_PA v_1_Zptr))
  then (
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
    then (
      rely ((((((test_PA v_1_Zptr).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_1_Zptr).(meta_granule_offset)) >= (0)))));
      rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
      when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_1));
      if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
      then (
        when ret_record, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) 0 64 v_2 v_3 st_2));
        rely ((((ret_record.(e_2)).(pbase)) =s ("granules")));
        rely (((((ret_record.(e_2)).(poffset)) mod (16)) = (0)));
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
            rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
            rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
            when st_16 == (
                (granule_unlock_spec
                  (ret_record.(e_2))
                  ((st_10.[share].[globals].[g_granules] :<
                    (((((st_10.(share)).(globals)).(g_granules)) #
                      ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                      (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                        ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                      ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                      ((((((st_10.(share)).(globals)).(g_granules)) #
                        ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                        (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                          ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :<
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
                  rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                  when st_14 == (
                      (granule_unlock_spec
                        (ret_record.(e_2))
                        ((st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
              rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
              when st_14 == (
                  (granule_unlock_spec
                    (ret_record.(e_2))
                    ((st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (3)) =? (0))
    then (
      rely ((((((test_PA v_1_Zptr).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_1_Zptr).(meta_granule_offset)) >= (0)))));
      rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
      when st_2 == (
          (spinlock_acquire_spec
            (mkPtr
              ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(pbase))
              ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(poffset)))
            st_1));
      if (
        (((((((st_2.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(poffset)) / (16))).(e_state_s_granule)) -
          (5)) =?
          (0)))
      then (
        when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_2));
        if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
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
          rely ((((ret_record.(e_2)).(pbase)) =s ("granules")));
          rely (((((ret_record.(e_2)).(poffset)) mod (16)) = (0)));
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
              rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
              rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
              when st_16 == (
                  (granule_unlock_spec
                    (ret_record.(e_2))
                    ((st_10.[share].[globals].[g_granules] :<
                      (((((st_10.(share)).(globals)).(g_granules)) #
                        ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                        (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                          ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                        ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                        ((((((st_10.(share)).(globals)).(g_granules)) #
                          ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :<
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
                    rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                    when st_14 == (
                        (granule_unlock_spec
                          (ret_record.(e_2))
                          ((st_10.[share].[globals].[g_granules] :<
                            ((((st_10.(share)).(globals)).(g_granules)) #
                              ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                              (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                when st_14 == (
                    (granule_unlock_spec
                      (ret_record.(e_2))
                      ((st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                    rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                    when st_17 == (
                        (granule_unlock_spec
                          (ret_record.(e_2))
                          ((st_11.[share].[globals].[g_granules] :<
                            (((((st_11.(share)).(globals)).(g_granules)) #
                              ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                              ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                              ((((((st_11.(share)).(globals)).(g_granules)) #
                                ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :<
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
                          rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                          when st_15 == (
                              (granule_unlock_spec
                                (ret_record.(e_2))
                                ((st_11.[share].[globals].[g_granules] :<
                                  ((((st_11.(share)).(globals)).(g_granules)) #
                                    ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                                    (((((st_11.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                      rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                      when st_15 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_5.[share].[globals].[g_granules] :<
                              ((((st_5.(share)).(globals)).(g_granules)) #
                                ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                                (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
        if (((((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
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
          rely ((((ret_record.(e_2)).(pbase)) =s ("granules")));
          rely (((((ret_record.(e_2)).(poffset)) mod (16)) = (0)));
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
              rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
              rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
              when st_16 == (
                  (granule_unlock_spec
                    (ret_record.(e_2))
                    ((st_10.[share].[globals].[g_granules] :<
                      (((((st_10.(share)).(globals)).(g_granules)) #
                        ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                        (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                          ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                        ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                        ((((((st_10.(share)).(globals)).(g_granules)) #
                          ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :<
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
                    rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                    when st_14 == (
                        (granule_unlock_spec
                          (ret_record.(e_2))
                          ((st_10.[share].[globals].[g_granules] :<
                            ((((st_10.(share)).(globals)).(g_granules)) #
                              ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                              (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                when st_14 == (
                    (granule_unlock_spec
                      (ret_record.(e_2))
                      ((st_5.[share].[globals].[g_granules] :<
                        ((((st_5.(share)).(globals)).(g_granules)) #
                          ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                          (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                    rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                    when st_17 == (
                        (granule_unlock_spec
                          (ret_record.(e_2))
                          ((st_11.[share].[globals].[g_granules] :<
                            (((((st_11.(share)).(globals)).(g_granules)) #
                              ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                              ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                              ((((((st_11.(share)).(globals)).(g_granules)) #
                                ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :<
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
                          rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                          when st_15 == (
                              (granule_unlock_spec
                                (ret_record.(e_2))
                                ((st_11.[share].[globals].[g_granules] :<
                                  ((((st_11.(share)).(globals)).(g_granules)) #
                                    ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                                    (((((st_11.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                      rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                      when st_15 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_6.[share].[globals].[g_granules] :<
                              ((((st_6.(share)).(globals)).(g_granules)) #
                                ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                                (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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

Definition rsi_data_create_unknown_s1_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
  if (check_rcsm_mask_para (test_PA v_1))
  then (
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
    then (
      rely (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\ (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
      when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
      if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
        when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 0 64 v_2 3 st_2));
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
              when v_11, st_5 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_3));
              if v_11
              then (
                when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_5));
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
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          ((((((st_18.(share)).(globals)).(g_granules)) #
                            ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) #
                              ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              ((g_mapped_addr_set_para
                                (((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                                v_2) +
                                (1)))))).[share].[granule_data] :<
                        (((st_18.(share)).(granule_data)) #
                          ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                          ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 1))))))));
                when st_6 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                      (st_29.[share].[globals].[g_granules] :<
                        ((((st_29.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_29.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                (Some (0, st_6)))
              else (
                when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_5));
                when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                then (
                  when st_6 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_21.[share].[globals].[g_granules] :<
                          ((((st_21.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_21.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_6)))
                else (
                  when st_6 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_21.[share].[globals].[g_granules] :<
                          ((((st_21.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_21.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_6)))))
            else (
              when st_5 == ((spinlock_release_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_3));
              when v_11, st_6 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
              if v_11
              then (
                when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_6));
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
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          ((((((st_18.(share)).(globals)).(g_granules)) #
                            ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) #
                              ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              ((g_mapped_addr_set_para
                                (((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                                v_2) +
                                (1)))))).[share].[granule_data] :<
                        (((st_18.(share)).(granule_data)) #
                          ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                          ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 1))))))));
                when st_7 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                      (st_29.[share].[globals].[g_granules] :<
                        ((((st_29.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_29.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                (Some (0, st_7)))
              else (
                when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_6));
                when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                then (
                  when st_7 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_21.[share].[globals].[g_granules] :<
                          ((((st_21.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_21.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7)))
                else (
                  when st_7 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_21.[share].[globals].[g_granules] :<
                          ((((st_21.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_21.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7))))))
          else (
            when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
            if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
            then (
              when st_3 == (
                  (granule_unlock_spec
                    (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                    (st_13.[share].[globals].[g_granules] :<
                      ((((st_13.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_13.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
              (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_3)))
            else (
              when st_3 == (
                  (granule_unlock_spec
                    (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                    (st_13.[share].[globals].[g_granules] :<
                      ((((st_13.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_13.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
              (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_3)))))
        else (
          when st_8 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
          if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
          then (
            when st_3 == (
                (granule_unlock_spec
                  (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                  (st_8.[share].[globals].[g_granules] :<
                    ((((st_8.(share)).(globals)).(g_granules)) #
                      ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                      (((((st_8.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
            (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_3)))
          else (
            when st_3 == (
                (granule_unlock_spec
                  (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                  (st_8.[share].[globals].[g_granules] :<
                    ((((st_8.(share)).(globals)).(g_granules)) #
                      ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                      (((((st_8.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
            (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_3)))))
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
      if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
      then (
        when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
        if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (3)) =? (0))
        then (
          when st_3 == (
              (spinlock_acquire_spec
                (mkPtr
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(pbase))
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)))
                st_2));
          if (
            (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)) / (16))).(e_state_s_granule)) -
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
                  (((((((st_5.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(poffset)) / (16))).(e_state_s_granule)) -
                    (2)) =?
                    (0)))
                then (
                  when v_11, st_6 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
                  if v_11
                  then (
                    when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) st_6));
                    rely ((((rtt_ret.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (16)) - (8)) =? (0))
                    then (
                      when st_30 == (
                          (granule_unlock_spec
                            (rtt_ret.(e_2))
                            ((st_18.[share].[globals].[g_granules] :<
                              (((((st_18.(share)).(globals)).(g_granules)) #
                                ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                ((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                    (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                      ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    ((g_mapped_addr_set_para
                                      (((((((st_18.(share)).(globals)).(g_granules)) #
                                        ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                        (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                          ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                                      v_2) +
                                      (1)))))).[share].[granule_data] :<
                              (((st_18.(share)).(granule_data)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                                ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))));
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_30));
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some (0, st_7)))
                    else None)
                  else (
                    when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_6));
                    when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) st_18));
                    when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7)))
                    else (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7)))))
                else (
                  when st_6 == (
                      (spinlock_release_spec
                        (mkPtr
                          ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(pbase))
                          ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(poffset)))
                        st_5));
                  when v_11, st_7 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_6));
                  if v_11
                  then (
                    when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) st_7));
                    rely ((((rtt_ret.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (16)) - (8)) =? (0))
                    then (
                      when st_30 == (
                          (granule_unlock_spec
                            (rtt_ret.(e_2))
                            ((st_18.[share].[globals].[g_granules] :<
                              (((((st_18.(share)).(globals)).(g_granules)) #
                                ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                ((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                    (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                      ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    ((g_mapped_addr_set_para
                                      (((((((st_18.(share)).(globals)).(g_granules)) #
                                        ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                        (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                          ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                                      v_2) +
                                      (1)))))).[share].[granule_data] :<
                              (((st_18.(share)).(granule_data)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                                ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))));
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_30));
                      when st_8 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some (0, st_8)))
                    else None)
                  else (
                    when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_7));
                    when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) st_18));
                    when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      when st_8 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_8)))
                    else (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      when st_8 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_8))))))
              else (
                when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
                if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
                then (
                  when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_13));
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  when st_5 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_5)))
                else (
                  when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_13));
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  when st_5 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_5)))))
            else (
              when st_8 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
              if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
              then (
                when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_8));
                rely (
                  ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                    (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                when st_5 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                      (st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_5)))
              else (
                when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_8));
                rely (
                  ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                    (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                when st_5 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                      (st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_5)))))
          else (
            when st_4 == (
                (spinlock_release_spec
                  (mkPtr
                    ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(pbase))
                    ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)))
                  st_3));
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
                  (((((((st_6.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(poffset)) / (16))).(e_state_s_granule)) -
                    (2)) =?
                    (0)))
                then (
                  when v_11, st_7 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_6));
                  if v_11
                  then (
                    when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5) st_7));
                    rely ((((rtt_ret.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (16)) - (8)) =? (0))
                    then (
                      when st_30 == (
                          (granule_unlock_spec
                            (rtt_ret.(e_2))
                            ((st_18.[share].[globals].[g_granules] :<
                              (((((st_18.(share)).(globals)).(g_granules)) #
                                ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                ((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                    (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                      ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    ((g_mapped_addr_set_para
                                      (((((((st_18.(share)).(globals)).(g_granules)) #
                                        ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                        (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                          ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                                      v_2) +
                                      (1)))))).[share].[granule_data] :<
                              (((st_18.(share)).(granule_data)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                                ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))));
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_30));
                      when st_8 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some (0, st_8)))
                    else None)
                  else (
                    when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_7));
                    when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5) st_18));
                    when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      when st_8 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_8)))
                    else (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      when st_8 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_8)))))
                else (
                  when st_7 == (
                      (spinlock_release_spec
                        (mkPtr
                          ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(pbase))
                          ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(poffset)))
                        st_6));
                  when v_11, st_8 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_7));
                  if v_11
                  then (
                    when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5) st_8));
                    rely ((((rtt_ret.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (16)) - (8)) =? (0))
                    then (
                      when st_30 == (
                          (granule_unlock_spec
                            (rtt_ret.(e_2))
                            ((st_18.[share].[globals].[g_granules] :<
                              (((((st_18.(share)).(globals)).(g_granules)) #
                                ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                ((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                    (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                      ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    ((g_mapped_addr_set_para
                                      (((((((st_18.(share)).(globals)).(g_granules)) #
                                        ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                        (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                          ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                                      v_2) +
                                      (1)))))).[share].[granule_data] :<
                              (((st_18.(share)).(granule_data)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                                ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))));
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_30));
                      when st_9 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some (0, st_9)))
                    else None)
                  else (
                    when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_8));
                    when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5) st_18));
                    when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      when st_9 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9)))
                    else (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      when st_9 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9))))))
              else (
                when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_5));
                if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
                then (
                  when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_13));
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  when st_7 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7)))
                else (
                  when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_13));
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  when st_7 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7)))))
            else (
              when st_8 == ((granule_unlock_spec (rtt_ret.(e_2)) st_5));
              if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
              then (
                when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_8));
                rely (
                  ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                    (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                when st_7 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                      (st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
              else (
                when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_8));
                rely (
                  ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                    (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                when st_7 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                      (st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7))))))
        else (
          when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_2));
          when st_4 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st_3));
          (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_4))))
      else (
        when st_2 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_2))))).

