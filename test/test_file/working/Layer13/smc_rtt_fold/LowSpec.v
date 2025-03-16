Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rtt_fold_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_fold_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    rely (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)));
    if (check_rcsm_mask_para (test_PA v_1))
    then (
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (3)) =? (0))
      then (
        rely ((((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
        rely (
          (((test_Z_Ptr
            (((((st_1.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) mod (4096)))).(pbase)) =
            ("granules")));
        rely (
          ((((test_Z_Ptr
            (((((st_1.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) mod (4096)))).(poffset)) mod
            (4096)) =
            (0)));
        rely (
          (((test_Z_Ptr
            (((((st_1.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) mod (4096)))).(poffset)) >=
            (0)));
        when st_3 == (
            (spinlock_acquire_spec
              (mkPtr
                ((test_Z_Ptr
                  (((((st_1.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) mod (4096)))).(pbase))
                ((test_Z_Ptr
                  (((((st_1.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) mod (4096)))).(poffset)))
              st_1));
        if (
          (((((((st_3.(share)).(globals)).(g_granules)) @
            (((test_Z_Ptr
              (((((st_1.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) mod (4096)))).(poffset)) /
              (4096))).(e_state_s_granule)) -
            (5)) =?
            (0)))
        then (
          when rtt_ret, st_4 == (
              (rtt_walk_lock_unlock_spec_abs
                (mkPtr "null" 0)
                (test_Z_Ptr
                  (((((st_1.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) mod (4096))))
                0
                64
                v_2
                (v_3 + ((- 1)))
                st_3));
          if (((rtt_ret.(e_1)) - ((v_3 + ((- 1))))) =? (0))
          then (
            if (
              (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) -
                (((test_PA v_0).(meta_granule_offset)))) =?
                (0)))
            then (
              when st_7 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_4));
              rely ((((((((st_7.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) = (0)));
              rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
              rely ((((((((st_7.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(e_state_s_granule)) - (5)) = (0)));
              if ((((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
              then (
                if ((((((((st_7.(share)).(globals)).(g_granules)) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (512))
                then (
                  if (table_maps_assigned_block_s1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) v_3 st_7)
                  then (
                    if ((v_3 + ((- 1))) =? (3))
                    then (
                      when v_9, st_11 == (
                          (memset_spec
                            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                            0
                            4096
                            (st_7.[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t ((abs_tte_read (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_7).(meta_PA)) 0 0 3))))))));
                      rely ((((((st_11.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) = (zero_granule_data)));
                      (Some (
                        0  ,
                        (st_11.[share].[globals].[g_granules] :<
                          ((((st_11.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096)) ==
                            (((((st_11.(share)).(globals)).(g_granules)) @ ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 1)))
                      )))
                    else (
                      when v_9, st_11 == (
                          (memset_spec
                            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                            0
                            4096
                            (st_7.[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t ((abs_tte_read (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_7).(meta_PA)) 0 0 1))))))));
                      rely ((((((st_11.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) = (zero_granule_data)));
                      (Some (
                        0  ,
                        (st_11.[share].[globals].[g_granules] :<
                          ((((st_11.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096)) ==
                            (((((st_11.(share)).(globals)).(g_granules)) @ ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 1)))
                      ))))
                  else (Some ((pack_struct_return_code_para (make_return_code_para 4)), st_7)))
                else (
                  when v_9, st_11 == (
                      (memset_spec
                        (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                        0
                        4096
                        (st_7.[share].[granule_data] :<
                          (((st_7.(share)).(granule_data)) #
                            ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                            ((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4))))))));
                  rely ((((((st_11.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) = (zero_granule_data)));
                  (Some (
                    0  ,
                    (st_11.[share].[globals].[g_granules] :<
                      ((((st_11.(share)).(globals)).(g_granules)) #
                        ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096)) ==
                        (((((st_11.(share)).(globals)).(g_granules)) @ ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 1)))
                  ))))
              else None)
            else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_4)))
          else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_4)))
        else (
          when st_4 == (
              (spinlock_release_spec
                (mkPtr
                  ((test_Z_Ptr
                    (((((st_1.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) mod (4096)))).(pbase))
                  ((test_Z_Ptr
                    (((((st_1.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) mod (4096)))).(poffset)))
                st_3));
          when rtt_ret, st_5 == (
              (rtt_walk_lock_unlock_spec_abs
                (mkPtr "null" 0)
                (test_Z_Ptr
                  (((((st_1.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (1544)) mod (4096))))
                0
                64
                v_2
                (v_3 + ((- 1)))
                st_4));
          if (((rtt_ret.(e_1)) - ((v_3 + ((- 1))))) =? (0))
          then (
            if (
              (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_5).(meta_PA)).(meta_granule_offset)) -
                (((test_PA v_0).(meta_granule_offset)))) =?
                (0)))
            then (
              when st_9 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_5));
              rely ((((((((st_9.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) = (0)));
              rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
              if ((((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
              then (
                rely ((((((((st_9.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(e_state_s_granule)) - (5)) = (0)));
                if ((((((((st_9.(share)).(globals)).(g_granules)) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (512))
                then (
                  if (table_maps_assigned_block_s1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) v_3 st_9)
                  then (
                    if ((v_3 + ((- 1))) =? (3))
                    then (
                      when v_9, st_12 == (
                          (memset_spec
                            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                            0
                            4096
                            (st_9.[share].[granule_data] :<
                              (((st_9.(share)).(granule_data)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                                ((((st_9.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_9.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t ((abs_tte_read (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_9).(meta_PA)) 0 0 3))))))));
                      rely ((((((st_12.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) = (zero_granule_data)));
                      (Some (
                        0  ,
                        (st_12.[share].[globals].[g_granules] :<
                          ((((st_12.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096)) ==
                            (((((st_12.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                      )))
                    else (
                      when v_9, st_12 == (
                          (memset_spec
                            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                            0
                            4096
                            (st_9.[share].[granule_data] :<
                              (((st_9.(share)).(granule_data)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                                ((((st_9.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_9.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t ((abs_tte_read (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_9).(meta_PA)) 0 0 1))))))));
                      rely ((((((st_12.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) = (zero_granule_data)));
                      (Some (
                        0  ,
                        (st_12.[share].[globals].[g_granules] :<
                          ((((st_12.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096)) ==
                            (((((st_12.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                      ))))
                  else (Some ((pack_struct_return_code_para (make_return_code_para 4)), st_9)))
                else (
                  when v_9, st_12 == (
                      (memset_spec
                        (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                        0
                        4096
                        (st_9.[share].[granule_data] :<
                          (((st_9.(share)).(granule_data)) #
                            ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                            ((((st_9.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_9.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_5))))))));
                  rely ((((((st_12.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) = (zero_granule_data)));
                  (Some (
                    0  ,
                    (st_12.[share].[globals].[g_granules] :<
                      ((((st_12.(share)).(globals)).(g_granules)) #
                        ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096)) ==
                        (((((st_12.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                  ))))
              else None)
            else (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_5)))
          else (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_5))))
      else (
        when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))
    else (Some (0, st)).

End Layer13_smc_rtt_fold_LowSpec.

#[global] Hint Unfold smc_rtt_fold_spec_low: spec.
