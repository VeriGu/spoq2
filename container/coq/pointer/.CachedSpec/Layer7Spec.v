Parameter test_PA : Z -> abs_PA_t.

Parameter g_refcount_para : Ptr -> (RData -> Z).

Parameter rec_to_rd_para : Ptr -> (RData -> Ptr).

Definition s1tte_is_valid_spec_abs (v_0: abs_PTE_t) (v_1: Z) (st: RData) : (option (bool * RData)) :=
  if ((v_1 =? (3)) && (((v_0.(meta_desc_type)) =? (3))))
  then (Some (true, st))
  else (
    if ((v_1 <>? (3)) && (((v_0.(meta_desc_type)) =? (1))))
    then (Some (true, st))
    else (Some (false, st))).

Definition s2tte_create_table_spec_abs (v_0: abs_PA_t) (v_1: Z) (st: RData) : (option (abs_PTE_t * RData)) :=
  (Some ((mkabs_PTE_t v_0 3 0 0), st)).

Definition rtt_create_internal_spec_abs (v_0: Ptr) (v_1_abs: abs_PA_t) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
  when ret, st' == ((granule_try_lock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) 1 st));
  if ret
  then (
    when ret_record, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) v_0 0 64 v_2 v_3 st'));
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
              (mkPtr "granule_data" (v_1_abs.(meta_granule_offset)))
              ((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_ripas))
              st_4));
        rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
        rely ((((v_1_abs.(meta_granule_offset)) mod (16)) = (0)));
        when st_16 == (
            (granule_unlock_spec
              (ret_record.(e_2))
              ((st_10.[share].[globals].[g_granules] :<
                (((((st_10.(share)).(globals)).(g_granules)) #
                  ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                  (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                    ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                      (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                  (((v_1_abs.(meta_granule_offset)) + (4)) / (16)) ==
                  ((((((st_10.(share)).(globals)).(g_granules)) #
                    ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                      ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                        (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ (((v_1_abs.(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :<
                    5))).[share].[granule_data] :<
                (((st_10.(share)).(granule_data)) #
                  ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                  ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                    (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                      ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                      (test_PTE_Z (mkabs_PTE_t v_1_abs 3 0 0))))))));
        when st_17 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_16));
        (Some (0, st_17)))
      else (
        if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
        then (
          match (
            match (
              when st_11 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
              when st_12 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_11));
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
              rely ((((v_1_abs.(meta_granule_offset)) mod (16)) = (0)));
              when st_14 == (
                  (granule_unlock_spec
                    (ret_record.(e_2))
                    ((st_10.[share].[globals].[g_granules] :<
                      ((((st_10.(share)).(globals)).(g_granules)) #
                        (((v_1_abs.(meta_granule_offset)) + (4)) / (16)) ==
                        (((((st_10.(share)).(globals)).(g_granules)) @ (((v_1_abs.(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                      (((st_10.(share)).(granule_data)) #
                        ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                        ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t v_1_abs 3 0 0))))))));
              when st_15 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_14));
              (Some (0, st_15)))
          | None => None
          end)
        else (
          rely ((((v_1_abs.(meta_granule_offset)) mod (16)) = (0)));
          when st_14 == (
              (granule_unlock_spec
                (ret_record.(e_2))
                ((st_4.[share].[globals].[g_granules] :<
                  ((((st_4.(share)).(globals)).(g_granules)) #
                    (((v_1_abs.(meta_granule_offset)) + (4)) / (16)) ==
                    (((((st_4.(share)).(globals)).(g_granules)) @ (((v_1_abs.(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                  (((st_4.(share)).(granule_data)) #
                    ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                    ((((st_4.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                      (((((st_4.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                        ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                        (test_PTE_Z (mkabs_PTE_t v_1_abs 3 0 0))))))));
          when st_15 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_14));
          (Some (0, st_15)))))
    else (
      if (v_4 =? (0))
      then (
        when st_6 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
        when st_7 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_6));
        (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
      else (
        if (((ret_record.(e_1)) - (v_3)) =? (0))
        then (
          match (
            match (
              match (
                when st_6 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
                when st_7 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_6));
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
                when st_8 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_7));
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
                      (mkPtr "granule_data" (v_1_abs.(meta_granule_offset)))
                      ((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_ripas))
                      st_5));
                rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                rely ((((v_1_abs.(meta_granule_offset)) mod (16)) = (0)));
                when st_17 == (
                    (granule_unlock_spec
                      (ret_record.(e_2))
                      ((st_11.[share].[globals].[g_granules] :<
                        (((((st_11.(share)).(globals)).(g_granules)) #
                          ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          (((v_1_abs.(meta_granule_offset)) + (4)) / (16)) ==
                          ((((((st_11.(share)).(globals)).(g_granules)) #
                            ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ (((v_1_abs.(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :<
                            5))).[share].[granule_data] :<
                        (((st_11.(share)).(granule_data)) #
                          ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                          ((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t v_1_abs 3 0 0))))))));
                when st_18 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_17));
                (Some (0, st_18)))
              else (
                if (((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_desc_type)) =? (3))
                then (
                  match (
                    match (
                      when st_12 == ((granule_unlock_spec (ret_record.(e_2)) st_5));
                      when st_13 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_12));
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
                      rely ((((v_1_abs.(meta_granule_offset)) mod (16)) = (0)));
                      when st_15 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_11.[share].[globals].[g_granules] :<
                              ((((st_11.(share)).(globals)).(g_granules)) #
                                (((v_1_abs.(meta_granule_offset)) + (4)) / (16)) ==
                                (((((st_11.(share)).(globals)).(g_granules)) @ (((v_1_abs.(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                              (((st_11.(share)).(granule_data)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                ((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t v_1_abs 3 0 0))))))));
                      when st_16 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_15));
                      (Some (0, st_16)))
                  | None => None
                  end)
                else (
                  rely ((((v_1_abs.(meta_granule_offset)) mod (16)) = (0)));
                  when st_15 == (
                      (granule_unlock_spec
                        (ret_record.(e_2))
                        ((st_5.[share].[globals].[g_granules] :<
                          ((((st_5.(share)).(globals)).(g_granules)) #
                            (((v_1_abs.(meta_granule_offset)) + (4)) / (16)) ==
                            (((((st_5.(share)).(globals)).(g_granules)) @ (((v_1_abs.(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                            ((((st_5.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t v_1_abs 3 0 0))))))));
                  when st_16 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_15));
                  (Some (0, st_16)))))
          | None => None
          end)
        else (
          when st_7 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
          when st_8 == ((granule_unlock_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_7));
          (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_8))))))
  else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st')).

Definition set_pas_any_to_ns_spec (v_0: Z) (st: RData) : (option RData) :=
  (Some st).

Definition set_pas_ns_to_any_spec (v_0: Z) (st: RData) : (option RData) :=
  (Some st).

Definition smc_granule_ns_to_any_spec_abs (v_0: Z) (v_1_abs: abs_PA_t) (st: RData) : (option (Z * RData)) :=
  when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st));
  if ((((((st_1.(share)).(globals)).(g_granules)) @ ((v_1_abs.(meta_granule_offset)) / (16))).(e_state_s_granule)) =? (0))
  then (
    rely (((((v_1_abs.(meta_granule_offset)) mod (16)) = (0)) /\ (((v_1_abs.(meta_granule_offset)) >= (0)))));
    when st_6 == (
        (granule_unlock_spec
          (mkPtr "granules" (v_1_abs.(meta_granule_offset)))
          (st_1.[share].[globals].[g_granules] :<
            ((((st_1.(share)).(globals)).(g_granules)) #
              ((v_1_abs.(meta_granule_offset)) / (16)) ==
              ((((((st_1.(share)).(globals)).(g_granules)) @ ((v_1_abs.(meta_granule_offset)) / (16))).[e_ref] :<
                ((((((st_1.(share)).(globals)).(g_granules)) @ ((v_1_abs.(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                  ((g_mapped_addr_set_para ((((((st_1.(share)).(globals)).(g_granules)) @ ((v_1_abs.(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) v_0) + (1)))).[e_state_s_granule] :<
                6)))));
    (Some (0, st_6)))
  else (
    when st_2 == ((spinlock_release_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_1));
    when st_3 == ((spinlock_acquire_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_2));
    if (((((((st_3.(share)).(globals)).(g_granules)) @ ((v_1_abs.(meta_granule_offset)) / (16))).(e_state_s_granule)) - (6)) =? (0))
    then (
      rely (((((v_1_abs.(meta_granule_offset)) mod (16)) = (0)) /\ (((v_1_abs.(meta_granule_offset)) >= (0)))));
      rely (((((v_1_abs.(meta_granule_offset)) + (8)) mod (16)) = (8)));
      when st_4 == (
          (granule_unlock_spec
            (mkPtr "granules" (v_1_abs.(meta_granule_offset)))
            (st_3.[share].[globals].[g_granules] :<
              ((((st_3.(share)).(globals)).(g_granules)) #
                ((v_1_abs.(meta_granule_offset)) / (16)) ==
                (((((st_3.(share)).(globals)).(g_granules)) @ ((v_1_abs.(meta_granule_offset)) / (16))).[e_ref] :<
                  ((((((st_3.(share)).(globals)).(g_granules)) @ ((v_1_abs.(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                    (((((((st_3.(share)).(globals)).(g_granules)) @ ((v_1_abs.(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
      (Some (0, st_4)))
    else (
      when st_4 == ((spinlock_release_spec (mkPtr "granules" (v_1_abs.(meta_granule_offset))) st_3));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_4)))).

Definition smc_granule_any_to_ns_spec_abs (v_0_abs: abs_PA_t) (st: RData) : (option (Z * RData)) :=
  when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (v_0_abs.(meta_granule_offset))) st));
  if (((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0_abs.(meta_granule_offset)) / (16))).(e_state_s_granule)) - (6)) =? (0))
  then (
    rely (((((v_0_abs.(meta_granule_offset)) mod (16)) = (0)) /\ (((v_0_abs.(meta_granule_offset)) >= (0)))));
    if (
      ((g_refcount_para
        (mkPtr "granules" (v_0_abs.(meta_granule_offset)))
        (st_1.[share].[globals].[g_granules] :<
          ((((st_1.(share)).(globals)).(g_granules)) #
            ((v_0_abs.(meta_granule_offset)) / (16)) ==
            (((((st_1.(share)).(globals)).(g_granules)) @ ((v_0_abs.(meta_granule_offset)) / (16))).[e_ref] :<
              ((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0_abs.(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                (((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0_abs.(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))) =?
        (0)))
    then (
      when st_7 == (
          (granule_unlock_spec
            (mkPtr "granules" (v_0_abs.(meta_granule_offset)))
            (st_1.[share].[globals].[g_granules] :<
              ((((st_1.(share)).(globals)).(g_granules)) #
                ((v_0_abs.(meta_granule_offset)) / (16)) ==
                ((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0_abs.(meta_granule_offset)) / (16))).[e_ref] :<
                  ((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0_abs.(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                    (g_mapped_addr_set_para (((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0_abs.(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))) 0))).[e_state_s_granule] :<
                  0)))));
      (Some (0, st_7)))
    else (
      when st_5 == (
          (granule_unlock_spec
            (mkPtr "granules" (v_0_abs.(meta_granule_offset)))
            (st_1.[share].[globals].[g_granules] :<
              ((((st_1.(share)).(globals)).(g_granules)) #
                ((v_0_abs.(meta_granule_offset)) / (16)) ==
                (((((st_1.(share)).(globals)).(g_granules)) @ ((v_0_abs.(meta_granule_offset)) / (16))).[e_ref] :<
                  ((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0_abs.(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                    (g_mapped_addr_set_para (((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0_abs.(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))) 0)))))));
      (Some (0, st_5))))
  else (
    when st_2 == ((spinlock_release_spec (mkPtr "granules" (v_0_abs.(meta_granule_offset))) st_1));
    (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).

Definition granule_pa_to_va_spec_abs (v_0: abs_PA_t) (st: RData) : (option (Ptr * RData)) :=
  (Some ((mkPtr "granule_data" (v_0.(meta_granule_offset))), st)).

Definition ns_buffer_read_spec_abs (v_0: Z) (v_1: abs_PA_t) (v_2: Z) (v_3: Ptr) (st: RData) : (option (bool * RData)) :=
  when v_5, st_0 == ((granule_pa_to_va_spec_abs v_1 st));
  when v_6, st_1 == ((memcpy_ns_read_spec v_3 v_5 v_2 st_0));
  (Some (v_6, st_1)).

Definition data_create_internal_spec_abs (v_0_pte: abs_PTE_t) (v_1: Ptr) (v_2: Z) (v_3: Ptr) (v_4: Ptr) (v_5: Z) (st: RData) : (option (Z * RData)) :=
  when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) v_1 0 64 v_2 3 st));
  rely ((((st_4.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
  if ((rtt_ret.(e_1)) =? (3))
  then (
    if (
      (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
        ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
        ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
    then (
      when st_13 == ((granule_lock_spec (rec_to_rd_para v_4 st_4) 2 st_4));
      when v_11, st_2 == ((memcpy_ns_read_spec (mkPtr "granule_data" ((v_0_pte.(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" (v_3.(poffset))) 4096 st_13));
      if v_11
      then (
        when st_18 == ((granule_unlock_spec (rec_to_rd_para v_4 st_4) st_2));
        if (v_5 =? (0))
        then (
          rely ((((rtt_ret.(e_2)).(pbase)) =s ("granules")));
          rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
          rely (((("granules" = ("granules")) /\ (((((v_0_pte.(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\ ((((v_0_pte.(meta_PA)).(meta_granule_offset)) >= (0)))));
          when st_29 == (
              (granule_unlock_spec
                (rtt_ret.(e_2))
                ((st_18.[share].[globals].[g_granules] :<
                  (((((st_18.(share)).(globals)).(g_granules)) #
                    ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                    (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                      ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                        (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                    (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16)) ==
                    ((((((st_18.(share)).(globals)).(g_granules)) #
                      ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                      (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                        ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                      (((((((st_18.(share)).(globals)).(g_granules)) #
                        ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                        (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                          ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                        ((g_mapped_addr_set_para
                          (((((((st_18.(share)).(globals)).(g_granules)) #
                            ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                          v_2) +
                          (1)))))).[share].[granule_data] :<
                  (((st_18.(share)).(granule_data)) #
                    ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                    ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                      (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                        ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                        (test_PTE_Z (mkabs_PTE_t (v_0_pte.(meta_PA)) 0 0 1))))))));
          (Some (0, st_29)))
        else (
          rely ((((rtt_ret.(e_2)).(pbase)) =s ("granules")));
          rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
          rely (((("granules" = ("granules")) /\ (((((v_0_pte.(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\ ((((v_0_pte.(meta_PA)).(meta_granule_offset)) >= (0)))));
          if ((((((v_0_pte.(meta_PA)).(meta_granule_offset)) + (8)) mod (16)) - (8)) =? (0))
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
                      (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16)) ==
                      ((((((st_18.(share)).(globals)).(g_granules)) #
                        ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                        (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                          ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                        (((((((st_18.(share)).(globals)).(g_granules)) #
                          ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          ((g_mapped_addr_set_para
                            (((((((st_18.(share)).(globals)).(g_granules)) #
                              ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                            v_2) +
                            (1)))))).[share].[granule_data] :<
                    (((st_18.(share)).(granule_data)) #
                      ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                      ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                        (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                          ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                          (test_PTE_Z (mkabs_PTE_t (v_0_pte.(meta_PA)) 0 0 3))))))));
            (Some (0, st_30)))
          else None))
      else (
        when v_33, st_18 == ((memset_spec (mkPtr "granule_data" ((v_0_pte.(meta_PA)).(meta_granule_offset))) 0 4096 st_2));
        when st_19 == ((granule_unlock_spec (rec_to_rd_para v_4 st_4) st_18));
        when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_21))))
    else (
      when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
      (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13))))
  else (
    when st_8 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
    (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_8))).

Definition data_create_internal_spec (v_0: Z) (v_1: Ptr) (v_2: Z) (v_3: Ptr) (v_4: Ptr) (v_5: Z) (st: RData) : (option (Z * RData)) :=
  None.

