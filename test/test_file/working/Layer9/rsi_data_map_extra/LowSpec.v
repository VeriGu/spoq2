Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_map_extra_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_map_extra_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (4)) =? (0))
    then (
      rely (((((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) >= (0)))));
      when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) 0 64 v_1 3 st_2));
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
              when v_11, st_5 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_3));
              if v_11
              then (
                when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_5));
                rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                when st_29 == (
                    (granule_unlock_spec
                      (rtt_ret.(e_2))
                      ((st_18.[share].[globals].[g_granules] :<
                        (((((st_18.(share)).(globals)).(g_granules)) #
                          ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                            ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((((st_18.(share)).(globals)).(g_granules)) #
                            ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) #
                              ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                              (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              ((g_mapped_addr_set_para
                                (((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0))
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
                when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) 0 4096 st_5));
                when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                when st_6 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_21));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_6))))
            else (
              when st_5 == ((spinlock_release_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_3));
              when v_11, st_6 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
              if v_11
              then (
                when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_6));
                rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
                rely ((((((rtt_ret.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                when st_29 == (
                    (granule_unlock_spec
                      (rtt_ret.(e_2))
                      ((st_18.[share].[globals].[g_granules] :<
                        (((((st_18.(share)).(globals)).(g_granules)) #
                          ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                            ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                          ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                          ((((((st_18.(share)).(globals)).(g_granules)) #
                            ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                            (((((((st_18.(share)).(globals)).(g_granules)) #
                              ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                              (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                              ((g_mapped_addr_set_para
                                (((((((st_18.(share)).(globals)).(g_granules)) #
                                  ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0))
                                v_1) +
                                (1)))))).[share].[granule_data] :<
                        (((st_18.(share)).(granule_data)) #
                          ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                          ((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_18.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                              ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t ((test_Z_PTE v_2).(meta_PA)) 0 0 1))))))));
                when st_7 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_29));
                (Some (0, st_7)))
              else (
                when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) 0 4096 st_6));
                when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                when st_7 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_21));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7)))))
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

End Layer9_rsi_data_map_extra_LowSpec.

#[global] Hint Unfold rsi_data_map_extra_spec_low: spec.
