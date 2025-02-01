Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_rtt_create_internal_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rtt_create_internal_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((granule_try_lock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 1 st));
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
                (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                ((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_ripas))
                st_4));
          rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
          rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
          when st_15 == (
              (__tte_write_spec_abs
                (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))))
                (mkabs_PTE_t (test_PA v_1) 3 0)
                (st_10.[share].[globals].[g_granules] :<
                  (((((st_10.(share)).(globals)).(g_granules)) #
                    ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                      ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                        (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                    ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                    ((((((st_10.(share)).(globals)).(g_granules)) #
                      ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                      (((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                        ((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_10.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :<
                      5)))));
          when st_16 == ((granule_unlock_spec (ret_record.(e_2)) st_15));
          when st_17 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_16));
          (Some (0, st_17)))
        else (
          if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
          then (
            match (
              match (
                when st_11 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
                when st_12 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_11));
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
                rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
                when st_13 == (
                    (__tte_write_spec_abs
                      (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))))
                      (mkabs_PTE_t (test_PA v_1) 3 0)
                      (st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5)))));
                when st_14 == ((granule_unlock_spec (ret_record.(e_2)) st_13));
                when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_14));
                (Some (0, st_15)))
            | None => None
            end)
          else (
            rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
            when st_13 == (
                (__tte_write_spec_abs
                  (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))))
                  (mkabs_PTE_t (test_PA v_1) 3 0)
                  (st_4.[share].[globals].[g_granules] :<
                    ((((st_4.(share)).(globals)).(g_granules)) #
                      ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                      (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5)))));
            when st_14 == ((granule_unlock_spec (ret_record.(e_2)) st_13));
            when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_14));
            (Some (0, st_15)))))
      else (
        if (v_4 =? (0))
        then (
          when st_6 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
          when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_6));
          (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
        else (
          if (((ret_record.(e_1)) - (v_3)) =? (0))
          then (
            match (
              match (
                match (
                  when st_6 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
                  when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_6));
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
                  when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_7));
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
                        (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                        ((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_ripas))
                        st_5));
                  rely ((((((ret_record.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                  rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
                  when st_16 == (
                      (__tte_write_spec_abs
                        (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))))
                        (mkabs_PTE_t (test_PA v_1) 3 0)
                        (st_11.[share].[globals].[g_granules] :<
                          (((((st_11.(share)).(globals)).(g_granules)) #
                            ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                            ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                            ((((((st_11.(share)).(globals)).(g_granules)) #
                              ((((ret_record.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_11.(share)).(globals)).(g_granules)) @ ((((ret_record.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :<
                              5)))));
                  when st_17 == ((granule_unlock_spec (ret_record.(e_2)) st_16));
                  when st_18 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_17));
                  (Some (0, st_18)))
                else (
                  if (((abs_tte_read (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3))))))) st_5).(meta_desc_type)) =? (3))
                  then (
                    match (
                      match (
                        when st_12 == ((granule_unlock_spec (ret_record.(e_2)) st_5));
                        when st_13 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_12));
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
                        rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
                        when st_14 == (
                            (__tte_write_spec_abs
                              (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))))
                              (mkabs_PTE_t (test_PA v_1) 3 0)
                              (st_11.[share].[globals].[g_granules] :<
                                ((((st_11.(share)).(globals)).(g_granules)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                                  (((((st_11.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5)))));
                        when st_15 == ((granule_unlock_spec (ret_record.(e_2)) st_14));
                        when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_15));
                        (Some (0, st_16)))
                    | None => None
                    end)
                  else (
                    rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
                    when st_14 == (
                        (__tte_write_spec_abs
                          (mkPtr "granule_data" (((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))))
                          (mkabs_PTE_t (test_PA v_1) 3 0)
                          (st_5.[share].[globals].[g_granules] :<
                            ((((st_5.(share)).(globals)).(g_granules)) #
                              ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                              (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5)))));
                    when st_15 == ((granule_unlock_spec (ret_record.(e_2)) st_14));
                    when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_15));
                    (Some (0, st_16)))))
            | None => None
            end)
          else (
            when st_7 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
            when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_7));
            (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_8))))))
    else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st')).

End Layer7_rtt_create_internal_LowSpec.

#[global] Hint Unfold rtt_create_internal_spec_low: spec.
