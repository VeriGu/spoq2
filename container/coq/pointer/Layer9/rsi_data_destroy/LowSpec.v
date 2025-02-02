Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_destroy_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
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
        when st_4 == ((granule_lock_spec (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1) 5 st_1));
        when st_5 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_4));
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
            when st_2 == (
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
              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                (4)) =?
                (0)))
            then (
              rely (
                ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                  (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
              if (
                ((g_refcount_para
                  (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                  (st_2.[share].[globals].[g_granules] :<
                    ((((st_2.(share)).(globals)).(g_granules)) #
                      ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                      (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                            ((- 1)))))))) =?
                  (0)))
              then (
                when v_4, st_3 == (
                    (memset_spec
                      (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      0
                      4096
                      (st_2.[share].[globals].[g_granules] :<
                        ((((st_2.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))));
                when st_6 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      (st_3.[share].[globals].[g_granules] :<
                        ((((st_3.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                            1)))));
                when st_24 == ((granule_unlock_spec (ret_rtt.(e_2)) st_6));
                (Some (0, st_24)))
              else (
                when st_22 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      (st_2.[share].[globals].[g_granules] :<
                        ((((st_2.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
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
              when st_2 == (
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
                (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                  (4)) =?
                  (0)))
              then (
                rely (
                  ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                    (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                if (
                  ((g_refcount_para
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                    (st_2.[share].[globals].[g_granules] :<
                      ((((st_2.(share)).(globals)).(g_granules)) #
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                              ((- 1)))))))) =?
                    (0)))
                then (
                  when v_4, st_3 == (
                      (memset_spec
                        (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        0
                        4096
                        (st_2.[share].[globals].[g_granules] :<
                          ((((st_2.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))));
                  when st_6 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        (st_3.[share].[globals].[g_granules] :<
                          ((((st_3.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                              1)))));
                  when st_26 == ((granule_unlock_spec (ret_rtt.(e_2)) st_6));
                  (Some (0, st_26)))
                else (
                  when st_24 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        (st_2.[share].[globals].[g_granules] :<
                          ((((st_2.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
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
        when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2)))).

End Layer9_rsi_data_destroy_LowSpec.

#[global] Hint Unfold rsi_data_destroy_spec_low: spec.
