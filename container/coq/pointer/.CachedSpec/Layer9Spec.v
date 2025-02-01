Definition rsi_rtt_create_spec (v_0_Zptr: Z) (v_1_Zptr: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
  when v__0, st_0 == (
      if (((test_PA v_1_Zptr) & (1)) =? (0))
      then (
        when v_18, st_0 == (
            when ret, st' == ((granule_try_lock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) 5 st));
            if ret
            then (Some ((mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))), st'))
            else (Some ((mkPtr "null" 0), st')));
        rely (((((v_18.(poffset)) mod (16)) = (0)) /\ (((v_18.(poffset)) >= (0)))));
        rely ((((v_18.(pbase)) = ("granules")) \/ (((v_18.(pbase)) = ("null")))));
        when v__1, st_1 == (
            if (((v_18.(pbase)) =? ("null")) /\ (((v_18.(poffset)) =? (0))))
            then (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_0))
            else (
              when v_23, st_1 == (
                  when ret, st' == ((granule_try_lock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) 1 st_0));
                  if ret
                  then (
                    when ret_record, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) v_18 0 64 v_2 v_3 st'));
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
                                      (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0))))))));
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
                                            (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0))))))));
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
                                        (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0))))))));
                          when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_14));
                          (Some (0, st_15)))))
                    else (
                      when st_6 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
                      when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_6));
                      (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7))))
                  else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st')));
              (Some (((v_23 << (32)) >> (32)), st_1))));
        (Some (v__1, st_1)))
      else (
        when v_8, st_0 == (
            when ret, st' == ((granule_try_lock_spec (mkPtr "granules" (((test_PA v_1_Zptr) & ((- 2))).(meta_granule_offset))) 3 st));
            if ret
            then (Some ((mkPtr "granules" (((test_PA v_1_Zptr) & ((- 2))).(meta_granule_offset))), st'))
            else (Some ((mkPtr "null" 0), st')));
        rely (((((v_8.(poffset)) mod (16)) = (0)) /\ (((v_8.(poffset)) >= (0)))));
        rely ((((v_8.(pbase)) = ("granules")) \/ (((v_8.(pbase)) = ("null")))));
        when v__1, st_1 == (
            if (((v_8.(pbase)) =? ("null")) /\ (((v_8.(poffset)) =? (0))))
            then (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_0))
            else (
              when v_15, st_2 == (
                  when st_2 == ((granule_lock_spec (rec_to_ttbr1_para (mkPtr "granule_data" (v_8.(poffset))) st_0) 5 st_0));
                  when v_7, st_3 == (
                      when ret, st' == ((granule_try_lock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) 1 st_2));
                      if ret
                      then (
                        when ret_record, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (rec_to_ttbr1_para (mkPtr "granule_data" (v_8.(poffset))) st_0) 0 64 v_2 v_3 st'));
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
                                          (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0))))))));
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
                                                (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0))))))));
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
                                            (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0))))))));
                              when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_14));
                              (Some (0, st_15)))))
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
                              then (Some (__retval___0, st_5))
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
                                                (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0))))))));
                                  when st_18 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_17));
                                  (Some (0, st_18)))
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
                                      then (Some (retval___1, st_11))
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
                                                      (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0))))))));
                                        when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_15));
                                        (Some (0, st_16)))
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
                                                  (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0))))))));
                                    when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_15));
                                    (Some (0, st_16)))))
                            | None => None
                            end)
                          else (
                            when st_7 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
                            when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_7));
                            (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_8)))))
                      else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st')));
                  ((Some v_7), st_3));
              when st_3 == ((granule_unlock_spec v_8 st_2));
              (Some (((v_15 << (32)) >> (32)), st_3))));
        (Some (v__1, st_1))));
  (Some (v__0, st_0)).

