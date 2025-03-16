Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_rtt_create_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_rtt_create_spec_low (v_0_Zptr: Z) (v_1_Zptr: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if (check_rcsm_mask_para (test_PA v_1_Zptr))
    then (
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_1_Zptr).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1_Zptr).(meta_granule_offset)) >= (0)))));
        rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
        when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_1));
        if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
        then (
          when ret_record, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) 0 64 v_2 v_3 st_2));
          rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
          rely ((((ret_record.(e_2)).(pbase)) = ("granules")));
          rely (((((ret_record.(e_2)).(poffset)) mod (4096)) = (0)));
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
              rely (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
              rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
              rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
              when st_16 == (
                  (granule_unlock_spec
                    (ret_record.(e_2))
                    ((st_10.[share].[globals].[g_granules] :<
                      ((((st_10.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                        (((((st_10.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                    rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                    when st_14 == (
                        (granule_unlock_spec
                          (ret_record.(e_2))
                          ((st_10.[share].[globals].[g_granules] :<
                            ((((st_10.(share)).(globals)).(g_granules)) #
                              (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                              (((((st_10.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                rely (
                  ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) =
                    (GRANULE_STATE_RTT)));
                when st_14 == (
                    (granule_unlock_spec
                      (ret_record.(e_2))
                      ((st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (3)) =? (0))
      then (
        rely ((((((test_PA v_1_Zptr).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1_Zptr).(meta_granule_offset)) >= (0)))));
        rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
        when st_2 == (
            (spinlock_acquire_spec
              (mkPtr
                ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(pbase))
                ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(poffset)))
              st_1));
        if (
          (((((((st_2.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(poffset)) / (4096))).(e_state_s_granule)) -
            (5)) =?
            (0)))
        then (
          when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_2));
          if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
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
            rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
            rely ((((ret_record.(e_2)).(pbase)) = ("granules")));
            rely (((((ret_record.(e_2)).(poffset)) mod (4096)) = (0)));
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
                rely (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                when st_16 == (
                    (granule_unlock_spec
                      (ret_record.(e_2))
                      ((st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                      rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                      rely (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                      when st_14 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                  rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                  when st_14 == (
                      (granule_unlock_spec
                        (ret_record.(e_2))
                        ((st_4.[share].[globals].[g_granules] :<
                          ((((st_4.(share)).(globals)).(g_granules)) #
                            (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                            (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                      rely (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                      rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                      when st_17 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_11.[share].[globals].[g_granules] :<
                              ((((st_11.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                                (((((st_11.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                            rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                            when st_15 == (
                                (granule_unlock_spec
                                  (ret_record.(e_2))
                                  ((st_11.[share].[globals].[g_granules] :<
                                    ((((st_11.(share)).(globals)).(g_granules)) #
                                      (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                                      (((((st_11.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                        rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                        rely (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                        when st_15 == (
                            (granule_unlock_spec
                              (ret_record.(e_2))
                              ((st_5.[share].[globals].[g_granules] :<
                                ((((st_5.(share)).(globals)).(g_granules)) #
                                  (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                                  (((((st_5.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
          if (((((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
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
            rely (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
            rely ((((ret_record.(e_2)).(pbase)) = ("granules")));
            rely (((((ret_record.(e_2)).(poffset)) mod (4096)) = (0)));
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
                rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                when st_16 == (
                    (granule_unlock_spec
                      (ret_record.(e_2))
                      ((st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                      rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                      when st_14 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                  rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                  rely (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) = (5)));
                  when st_14 == (
                      (granule_unlock_spec
                        (ret_record.(e_2))
                        ((st_5.[share].[globals].[g_granules] :<
                          ((((st_5.(share)).(globals)).(g_granules)) #
                            (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                            (((((st_5.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                      rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                      rely (
                        ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(e_state_s_granule)) =
                          (GRANULE_STATE_RTT)));
                      when st_17 == (
                          (granule_unlock_spec
                            (ret_record.(e_2))
                            ((st_11.[share].[globals].[g_granules] :<
                              ((((st_11.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                                (((((st_11.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                            rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                            when st_15 == (
                                (granule_unlock_spec
                                  (ret_record.(e_2))
                                  ((st_11.[share].[globals].[g_granules] :<
                                    ((((st_11.(share)).(globals)).(g_granules)) #
                                      (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                                      (((((st_11.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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
                        rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (4096)) = (0)));
                        when st_15 == (
                            (granule_unlock_spec
                              (ret_record.(e_2))
                              ((st_6.[share].[globals].[g_granules] :<
                                ((((st_6.(share)).(globals)).(g_granules)) #
                                  (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096)) ==
                                  (((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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

End Layer9_rsi_rtt_create_LowSpec.

#[global] Hint Unfold rsi_rtt_create_spec_low: spec.
