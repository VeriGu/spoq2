Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_create_unknown_s1_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_create_unknown_s1_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    if (check_rcsm_mask_para (test_PA v_1))
    then (
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
      then (
        rely (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
        when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
        if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
        then (
          rely ((((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
          when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 0 64 v_2 3 st_2));
          rely ((((st_4.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
          rely (((((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
          rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
          if ((rtt_ret.(e_1)) =? (3))
          then (
            if (
              (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
                ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
                ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
            then (
              when st_3 == ((spinlock_acquire_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_4));
              rely (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
              rely (((((((st_3.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
              if (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset)) / (4096))).(e_state_s_granule)) - (2)) =? (0))
              then (
                when v_11, st_5 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_3));
                rely (((((st_5.(share)).(globals)).(g_granules)) = ((((st_3.(share)).(globals)).(g_granules)))));
                if v_11
                then (
                  rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                  rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                  (Some (
                    0  ,
                    ((st_5.[share].[globals].[g_granules] :<
                      ((((st_5.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                      (((st_5.(share)).(granule_data)) #
                        ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                        ((((st_5.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_5.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                            ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 1))))))
                  )))
                else (
                  if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                  then (
                    (Some (
                      (pack_struct_return_code_para (make_return_code_para 1))  ,
                      ((st_5.[share].[globals].[g_granules] :<
                        ((((st_5.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                        (((st_5.(share)).(granule_data)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((st_5.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                    )))
                  else (
                    (Some (
                      (pack_struct_return_code_para (make_return_code_para 1))  ,
                      ((st_5.[share].[globals].[g_granules] :<
                        ((((st_5.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                        (((st_5.(share)).(granule_data)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((st_5.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                    )))))
              else (
                when st_5 == ((spinlock_release_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_3));
                when v_11, st_6 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
                rely (((((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
                rely (((((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
                rely (((((st_6.(share)).(globals)).(g_granules)) = ((((st_5.(share)).(globals)).(g_granules)))));
                if v_11
                then (
                  rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                  rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                  (Some (
                    0  ,
                    ((st_6.[share].[globals].[g_granules] :<
                      ((((st_6.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                      (((st_6.(share)).(granule_data)) #
                        ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                        ((((st_6.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_6.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                            ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 1))))))
                  )))
                else (
                  if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                  then (
                    (Some (
                      (pack_struct_return_code_para (make_return_code_para 1))  ,
                      ((st_6.[share].[globals].[g_granules] :<
                        ((((st_6.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                        (((st_6.(share)).(granule_data)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((st_6.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                    )))
                  else (
                    (Some (
                      (pack_struct_return_code_para (make_return_code_para 1))  ,
                      ((st_6.[share].[globals].[g_granules] :<
                        ((((st_6.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                        (((st_6.(share)).(granule_data)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((st_6.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                    ))))))
            else (
              if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
              then (
                (Some (
                  (pack_struct_return_code_para (make_return_code_para 9))  ,
                  (st_4.[share].[globals].[g_granules] :<
                    ((((st_4.(share)).(globals)).(g_granules)) #
                      ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                      (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
                )))
              else (
                (Some (
                  (pack_struct_return_code_para (make_return_code_para 9))  ,
                  (st_4.[share].[globals].[g_granules] :<
                    ((((st_4.(share)).(globals)).(g_granules)) #
                      ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                      (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                )))))
          else (
            if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
            then (
              (Some (
                (pack_struct_return_code_para (make_return_code_para 8))  ,
                (st_4.[share].[globals].[g_granules] :<
                  ((((st_4.(share)).(globals)).(g_granules)) #
                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                    (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
              )))
            else (
              (Some (
                (pack_struct_return_code_para (make_return_code_para 8))  ,
                (st_4.[share].[globals].[g_granules] :<
                  ((((st_4.(share)).(globals)).(g_granules)) #
                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                    (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
              )))))
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
        if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
        then (
          when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
          if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (3)) =? (0))
          then (
            when st_3 == (
                (spinlock_acquire_spec
                  (mkPtr
                    ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(pbase))
                    ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)))
                  st_2));
            if (
              (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)) / (4096))).(e_state_s_granule)) -
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
              rely (((((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
              rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
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
                    (((((((st_5.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(poffset)) / (4096))).(e_state_s_granule)) -
                      (2)) =?
                      (0)))
                  then (
                    when v_11, st_6 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
                    rely (((((st_6.(share)).(globals)).(g_granules)) = ((((st_5.(share)).(globals)).(g_granules)))));
                    rely (((((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
                    rely (((((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
                    if v_11
                    then (
                      rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                      rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) - (8)) =? (0))
                      then (
                        (Some (
                          0  ,
                          ((st_6.[share].[globals].[g_granules] :<
                            ((((st_6.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                            (((st_6.(share)).(granule_data)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                              ((((st_6.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_6.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))
                        )))
                      else None)
                    else (
                      if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                      then (
                        rely (
                          ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                            (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        (Some (
                          (pack_struct_return_code_para (make_return_code_para 1))  ,
                          ((st_6.[share].[globals].[g_granules] :<
                            ((((st_6.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                            (((st_6.(share)).(granule_data)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              ((((st_6.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                        )))
                      else (
                        rely (
                          ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                            (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        (Some (
                          (pack_struct_return_code_para (make_return_code_para 1))  ,
                          ((st_6.[share].[globals].[g_granules] :<
                            ((((st_6.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                            (((st_6.(share)).(granule_data)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              ((((st_6.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                        )))))
                  else (
                    when st_6 == (
                        (spinlock_release_spec
                          (mkPtr
                            ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(pbase))
                            ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(poffset)))
                          st_5));
                    when v_11, st_7 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_6));
                    rely (((((st_7.(share)).(globals)).(g_granules)) = ((((st_6.(share)).(globals)).(g_granules)))));
                    rely (((((((st_7.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
                    rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
                    if v_11
                    then (
                      rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                      rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) - (8)) =? (0))
                      then (
                        (Some (
                          0  ,
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))
                        )))
                      else None)
                    else (
                      if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                      then (
                        rely (
                          ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                            (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        (Some (
                          (pack_struct_return_code_para (make_return_code_para 1))  ,
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                        )))
                      else (
                        rely (
                          ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                            (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        (Some (
                          (pack_struct_return_code_para (make_return_code_para 1))  ,
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                        ))))))
                else (
                  if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
                  then (
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    (Some (
                      (pack_struct_return_code_para (make_return_code_para 9))  ,
                      (st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
                    )))
                  else (
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    (Some (
                      (pack_struct_return_code_para (make_return_code_para 9))  ,
                      (st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                    )))))
              else (
                if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
                then (
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
                  rely ((((((st_4.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(g_norm)) = (zero_granule_data)));
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 8))  ,
                    (st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
                  )))
                else (
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 8))  ,
                    (st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                  )))))
            else (
              when st_4 == (
                  (spinlock_release_spec
                    (mkPtr
                      ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(pbase))
                      ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)))
                    st_3));
              rely ((((st_4.(share)).(granule_data)) = (((st_3.(share)).(granule_data)))));
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
              rely (((((((st_5.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
              rely (((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
              rely (((((((st_4.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
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
                    (((((((st_6.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(poffset)) / (4096))).(e_state_s_granule)) -
                      (2)) =?
                      (0)))
                  then (
                    when v_11, st_7 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_6));
                    rely (((((st_7.(share)).(globals)).(g_granules)) = ((((st_6.(share)).(globals)).(g_granules)))));
                    rely (((((((st_7.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
                    rely (((((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
                    if v_11
                    then (
                      rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                      rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) - (8)) =? (0))
                      then (
                        (Some (
                          0  ,
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))
                        )))
                      else None)
                    else (
                      if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                      then (
                        rely (
                          ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                            (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        (Some (
                          (pack_struct_return_code_para (make_return_code_para 1))  ,
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                        )))
                      else (
                        rely (
                          ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                            (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        (Some (
                          (pack_struct_return_code_para (make_return_code_para 1))  ,
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                        )))))
                  else (
                    when st_7 == (
                        (spinlock_release_spec
                          (mkPtr
                            ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(pbase))
                            ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(poffset)))
                          st_6));
                    when v_11, st_8 == ((memcpy_ns_read_spec_state_oracle (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_7));
                    rely (((((st_8.(share)).(globals)).(g_granules)) = ((((st_7.(share)).(globals)).(g_granules)))));
                    rely (((((((st_8.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (5)));
                    rely (((((((st_8.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) = (1)));
                    if v_11
                    then (
                      rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                      rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      if (((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) - (8)) =? (0))
                      then (
                        (Some (
                          0  ,
                          ((st_8.[share].[globals].[g_granules] :<
                            ((((st_8.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_8.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                            (((st_8.(share)).(granule_data)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                              ((((st_8.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_8.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_0).(meta_PA)) 0 0 3))))))
                        )))
                      else None)
                    else (
                      if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                      then (
                        rely (
                          ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                            (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        (Some (
                          (pack_struct_return_code_para (make_return_code_para 1))  ,
                          ((st_8.[share].[globals].[g_granules] :<
                            ((((st_8.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_8.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4))).[share].[granule_data] :<
                            (((st_8.(share)).(granule_data)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              ((((st_8.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                        )))
                      else (
                        rely (
                          ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                            (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        (Some (
                          (pack_struct_return_code_para (make_return_code_para 1))  ,
                          ((st_8.[share].[globals].[g_granules] :<
                            ((((st_8.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_8.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                            (((st_8.(share)).(granule_data)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              ((((st_8.(share)).(granule_data)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))
                        ))))))
                else (
                  if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
                  then (
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    (Some (
                      (pack_struct_return_code_para (make_return_code_para 9))  ,
                      (st_5.[share].[globals].[g_granules] :<
                        ((((st_5.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
                    )))
                  else (
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    (Some (
                      (pack_struct_return_code_para (make_return_code_para 9))  ,
                      (st_5.[share].[globals].[g_granules] :<
                        ((((st_5.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                    )))))
              else (
                if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
                then (
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 8))  ,
                    (st_5.[share].[globals].[g_granules] :<
                      ((((st_5.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 4)))
                  )))
                else (
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  (Some (
                    (pack_struct_return_code_para (make_return_code_para 8))  ,
                    (st_5.[share].[globals].[g_granules] :<
                      ((((st_5.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                        (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))
                  ))))))
          else (
            when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_2));
            (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_3))))
        else (
          when st_2 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st_1));
          (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_2))))).

End Layer9_rsi_data_create_unknown_s1_LowSpec.

#[global] Hint Unfold rsi_data_create_unknown_s1_spec_low: spec.
