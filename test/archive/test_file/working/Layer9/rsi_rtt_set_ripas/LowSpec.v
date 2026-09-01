Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_rtt_set_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_rtt_set_ripas_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if (v_3 >? (1))
    then (Some (1, st))
    else (
      if (check_rcsm_mask_para (test_PA v_0))
      then (
        when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
        if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
        then (
          rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
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
        if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (3)) =? (0))
        then (
          rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
          rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
          when st_2 == (
              (spinlock_acquire_spec
                (mkPtr
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(pbase))
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)))
                st_1));
          if (
            (((((((st_2.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (4096))).(e_state_s_granule)) -
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

End Layer9_rsi_rtt_set_ripas_LowSpec.

#[global] Hint Unfold rsi_rtt_set_ripas_spec_low: spec.
