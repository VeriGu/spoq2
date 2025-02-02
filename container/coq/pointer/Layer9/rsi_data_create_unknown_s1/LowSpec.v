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
              when st_13 == ((granule_lock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) 2 st_4));
              when v_11, st_3 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_13));
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
                when st_5 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                      (st_29.[share].[globals].[g_granules] :<
                        ((((st_29.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_29.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                (Some (0, st_5)))
              else (
                when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_3));
                when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                then (
                  when st_5 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_21.[share].[globals].[g_granules] :<
                          ((((st_21.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_21.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5)))
                else (
                  when st_5 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_21.[share].[globals].[g_granules] :<
                          ((((st_21.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_21.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5)))))
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
            when st_6 == ((granule_lock_spec (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2) 5 st_2));
            rely (((((((st_6.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
            rely (((("granule_data" = ("granule_data")) /\ (((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
            when rtt_ret, st_4 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "stack_s_rtt_walk" 0)
                  (rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2)
                  0
                  64
                  v_2
                  3
                  st_6));
            rely ((((st_4.(share)).(granule_data)) = (((st_6.(share)).(granule_data)))));
            if ((rtt_ret.(e_1)) =? (3))
            then (
              if (
                (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
              then (
                when st_13 == ((granule_lock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) 2 st_4));
                when v_11, st_3 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_13));
                if v_11
                then (
                  when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) st_3));
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
                    when st_5 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                          (st_10.[share].[globals].[g_granules] :<
                            ((((st_10.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                    (Some (0, st_5)))
                  else None)
                else (
                  when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_3));
                  when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) st_18));
                  when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                  if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                  then (
                    when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
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
                    (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5)))
                  else (
                    when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
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
                    (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5)))))
              else (
                when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
                if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
                then (
                  when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_13));
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  when st_3 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_3)))
                else (
                  when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_13));
                  rely (
                    ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                      (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  when st_3 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                        (st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_3)))))
            else (
              when st_8 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
              if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
              then (
                when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_8));
                rely (
                  ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                    (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                when st_3 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                      (st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_3)))
              else (
                when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_8));
                rely (
                  ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                    (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                when st_3 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                      (st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_3)))))
          else (
            when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_2));
            when st_4 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st_3));
            (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_4))))
        else (
          when st_2 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st_1));
          (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_2))))).

End Layer9_rsi_data_create_unknown_s1_LowSpec.

#[global] Hint Unfold rsi_data_create_unknown_s1_spec_low: spec.
