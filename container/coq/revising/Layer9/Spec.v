Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
(* Require Import Layer12.Spec. *)
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer7.data_create_internal.LowSpec.
Require Import Layer8.Spec.
Require Import Layer8.map_unmap_ns_s1.LowSpec.
Require Import Layer9.gic_restore_state.LowSpec.
Require Import Layer9.rsi_data_set_attrs.LowSpec.
Require Import Layer9.rsi_rtt_set_ripas.LowSpec.
Require Import Layer9.rsi_data_read.LowSpec.
Require Import Layer9.rsi_data_write.LowSpec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_map_extra_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (4)) =? (0))
    then (
      rely (((((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\ (((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) >= (0)))));
      when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) 0 64 v_1 3 st_2));
        rely ((((st_4.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
        if ((rtt_ret.(e_1)) =? (3))
        then (
          if (
            (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
              ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
              ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
          then (
            when st_13 == ((granule_lock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) 2 st_4));
            when v_11, st_3 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_13));
            if v_11
            then (
              when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_3));
              rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
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
                        ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        ((((((st_18.(share)).(globals)).(g_granules)) #
                          ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                          (((((((st_18.(share)).(globals)).(g_granules)) #
                            ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            ((g_mapped_addr_set_para
                              (((((((st_18.(share)).(globals)).(g_granules)) #
                                ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_18.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
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
              when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) 0 4096 st_3));
              when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
              when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
              when st_6 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_2).(meta_PA)).(meta_granule_offset))) st_21));
              (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_6))))
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

  Definition rsi_rtt_set_ripas_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if (v_3 >? (1))
    then (Some (1, st))
    else (
      if (check_rcsm_mask_para (test_PA v_0))
      then (
        when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
        if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
        then (
          rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
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
        if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (3)) =? (0))
        then (
          rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
          rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
          when st_2 == (
              (spinlock_acquire_spec
                (mkPtr
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(pbase))
                  ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)))
                st_1));
          if (
            (((((((st_2.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (16))).(e_state_s_granule)) -
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


  Definition rsi_rtt_unmap_non_secure_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 & (1)) =? (0))
    then (
      when v_19, st_0 == ((map_unmap_ns_s1_spec v_0 v_1 v_2 0 1 st));
      (Some (v_19, st_0)))
    else (
      when v_7, st_0 == ((find_lock_granule_spec (v_0 & ((- 2))) 3 st));
      rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
      rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
      if (ptr_eqb v_7 (mkPtr "null" 0))
      then (
        when v_9, st_1 == ((pack_return_code_spec 1 1 st_0));
        (Some (v_9, st_1)))
      else (
        when v_12, st_1 == ((granule_map_spec v_7 3 st_0));
        when v_15_tmp, st_2 == ((load_RData 8 (ptr_offset v_12 1544) st_1));
        when v_16, st_3 == ((granule_addr_spec (int_to_ptr v_15_tmp) st_2));
        when v_17, st_4 == ((map_unmap_ns_s1_spec v_16 v_1 v_2 0 1 st_3));
        when st_5 == ((granule_unlock_spec v_7 st_4));
        (Some (v_17, st_5)))).

  Definition rsi_rtt_create_spec (v_0_Zptr: Z) (v_1_Zptr: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if (check_rcsm_mask_para (test_PA v_1_Zptr))
    then (
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
      then (
        rely ((((((test_PA v_1_Zptr).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_1_Zptr).(meta_granule_offset)) >= (0)))));
        rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
        when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_1));
        if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
        then (
          when ret_record, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) 0 64 v_2 v_3 st_2));
          rely ((((ret_record.(e_2)).(pbase)) = ("granules")));
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
                                  (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
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
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (3)) =? (0))
      then (
        rely ((((((test_PA v_1_Zptr).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_1_Zptr).(meta_granule_offset)) >= (0)))));
        rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
        when st_2 == (
            (spinlock_acquire_spec
              (mkPtr
                ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(pbase))
                ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(poffset)))
              st_1));
        if (
          (((((((st_2.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1_Zptr).(meta_granule_offset))) st_1).(poffset)) / (16))).(e_state_s_granule)) -
            (5)) =?
            (0)))
        then (
          when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_2));
          if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
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
            rely ((((ret_record.(e_2)).(pbase)) = ("granules")));
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
                                    (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                      when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_14));
                      when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_15));
                      (Some (0, st_6)))
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
                                          (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                            when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_15));
                            when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_16));
                            (Some (0, st_7)))
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
          if (((((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
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
            rely ((((ret_record.(e_2)).(pbase)) = ("granules")));
            rely (((((ret_record.(e_2)).(poffset)) mod (16)) = (0)));
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
                                    (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                      when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_14));
                      when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_15));
                      (Some (0, st_6)))
                  | None => None
                  end)
                else (
                  rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                  when st_14 == (
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
                                          (test_PTE_Z (mkabs_PTE_t (test_PA v_0_Zptr) 3 0 0))))))));
                            when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_15));
                            when st_7 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1_Zptr).(meta_granule_offset))) st_16));
                            (Some (0, st_7)))
                        | None => None
                        end)
                      else (
                        rely (((((test_PA v_0_Zptr).(meta_granule_offset)) mod (16)) = (0)));
                        when st_15 == (
                            (granule_unlock_spec
                              (ret_record.(e_2))
                              ((st_6.[share].[globals].[g_granules] :<
                                ((((st_6.(share)).(globals)).(g_granules)) #
                                  ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16)) ==
                                  (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_PA v_0_Zptr).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
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


  Definition s2tte_create_destroyed_abs : abs_PTE_t :=
    let v_0 := (mkabs_PA_t (-1)) in
    ((mkabs_PTE_t v_0 0 0 2)).

  Definition rsi_data_destroy_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
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
        when st_2 == (
            (spinlock_acquire_spec
              (mkPtr
                ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(pbase))
                ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)))
              st_1));
        if (
          (((((((st_2.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (16))).(e_state_s_granule)) -
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
                3
                st_5));
          if ((ret_rtt.(e_1)) =? (3))
          then (
            rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
            rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
            if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
            then (
              rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
              when st_3 == (
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
                (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                  (4)) =?
                  (0)))
              then (
                rely (
                  ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                    (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                if (
                  ((g_refcount_para
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                    (st_3.[share].[globals].[g_granules] :<
                      ((((st_3.(share)).(globals)).(g_granules)) #
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                          ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                              ((- 1)))))))) =?
                    (0)))
                then (
                  when v_4, st_6 == (
                      (memset_spec
                        (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        0
                        4096
                        (st_3.[share].[globals].[g_granules] :<
                          ((((st_3.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))));
                  when st_8 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        (st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                              1)))));
                  when st_24 == ((granule_unlock_spec (ret_rtt.(e_2)) st_8));
                  (Some (0, st_24)))
                else (
                  when st_22 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        (st_3.[share].[globals].[g_granules] :<
                          ((((st_3.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
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
                when st_3 == (
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
                  (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                    (4)) =?
                    (0)))
                then (
                  rely (
                    ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                      (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  if (
                    ((g_refcount_para
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      (st_3.[share].[globals].[g_granules] :<
                        ((((st_3.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))) =?
                      (0)))
                  then (
                    when v_4, st_6 == (
                        (memset_spec
                          (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                          0
                          4096
                          (st_3.[share].[globals].[g_granules] :<
                            ((((st_3.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                    ((- 1)))))))));
                    when st_8 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                          (st_6.[share].[globals].[g_granules] :<
                            ((((st_6.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                                1)))));
                    when st_26 == ((granule_unlock_spec (ret_rtt.(e_2)) st_8));
                    (Some (0, st_26)))
                  else (
                    when st_24 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                          (st_3.[share].[globals].[g_granules] :<
                            ((((st_3.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
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
                3
                st_5));
          if ((ret_rtt.(e_1)) =? (3))
          then (
            rely ((("granule_data" = ("granule_data")) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
            rely (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)));
            if (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_desc_type)) =? (3))
            then (
              rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
              when st_6 == (
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
                (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                  (4)) =?
                  (0)))
              then (
                rely (
                  ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                    (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                if (
                  ((g_refcount_para
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                    (st_6.[share].[globals].[g_granules] :<
                      ((((st_6.(share)).(globals)).(g_granules)) #
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                          ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                              ((- 1)))))))) =?
                    (0)))
                then (
                  when v_4, st_8 == (
                      (memset_spec
                        (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        0
                        4096
                        (st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))));
                  when st_9 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        (st_8.[share].[globals].[g_granules] :<
                          ((((st_8.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_8.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                              1)))));
                  when st_24 == ((granule_unlock_spec (ret_rtt.(e_2)) st_9));
                  (Some (0, st_24)))
                else (
                  when st_22 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                        (st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
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
                when st_6 == (
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
                  (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                    (4)) =?
                    (0)))
                then (
                  rely (
                    ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                      (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  if (
                    ((g_refcount_para
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                      (st_6.[share].[globals].[g_granules] :<
                        ((((st_6.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))) =?
                      (0)))
                  then (
                    when v_4, st_8 == (
                        (memset_spec
                          (mkPtr "granule_data" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                          0
                          4096
                          (st_6.[share].[globals].[g_granules] :<
                            ((((st_6.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                    ((- 1)))))))));
                    when st_9 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                          (st_8.[share].[globals].[g_granules] :<
                            ((((st_8.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_8.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :<
                                1)))));
                    when st_26 == ((granule_unlock_spec (ret_rtt.(e_2)) st_9));
                    (Some (0, st_26)))
                  else (
                    when st_24 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)))
                          (st_6.[share].[globals].[g_granules] :<
                            ((((st_6.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                ((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_6.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_7).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                    ((- 1)))))))));
                    when st_25 == ((granule_unlock_spec (ret_rtt.(e_2)) st_24));
                    (Some (0, st_25))))
                else None)
              else (
                when st_16 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
                (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_16)))))
          else (
            when st_11 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
            (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_11)))))
      else (
        when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2)))).
      
  Definition rsi_rtt_destroy_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
    then (
      rely ((((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
      when ret_rtt, st_2 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 0 64 v_2 (v_3 + ((- 1))) st_1));
      if (((ret_rtt.(e_1)) - ((v_3 + ((- 1))))) =? (0))
      then (
        rely ((((ret_rtt.(e_3)) < (512)) /\ (((ret_rtt.(e_3)) >= (0)))));
        if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_desc_type)) =? (3))))
        then (
          if (
            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_PA)).(meta_granule_offset)) -
              (((test_PA v_0).(meta_granule_offset)))) =?
              (0)))
          then (
            when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
            if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
            then (
              rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
              if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3) =? (0))
              then (
                rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                when v_5, st_4 == (
                    (memset_spec
                      (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                      0
                      4096
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
                              (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                when st_24 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                      (st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                when st_28 == ((granule_unlock_spec (ret_rtt.(e_2)) st_24));
                (Some (0, st_28)))
              else (
                when st_14 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
                when st_18 == ((granule_unlock_spec (ret_rtt.(e_2)) st_14));
                (Some ((pack_struct_return_code_para (make_return_code_para 4)), st_18))))
            else None)
          else (
            when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
            (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))
        else (
          when st_12 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
          (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_12))))
      else (
        when st_7 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
        (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).

  Definition rsi_data_create_s1_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when v_5, st_0 == ((s1tte_pa_spec v_0 st));
    when v_6, st_1 == ((find_granule_spec v_3 st_0));
    rely ((((v_6.(pbase)) = ("granules")) \/ (((v_6.(pbase)) = ("null")))));
    if (ptr_eqb v_6 (mkPtr "null" 0))
    then (
      when v_8, st_2 == ((pack_return_code_spec 1 4 st_1));
      (Some (v_8, st_2)))
    else (
      if ((v_1 & (1)) =? (0))
      then (
        when v_16, st_2 == ((find_lock_granule_spec v_1 5 st_1));
        rely (((((v_16.(poffset)) mod (16)) = (0)) /\ (((v_16.(poffset)) >= (0)))));
        rely ((((v_16.(pbase)) = ("granules")) \/ (((v_16.(pbase)) = ("null")))));
        if (ptr_eqb v_16 (mkPtr "null" 0))
        then (
          when v_18, st_3 == ((pack_return_code_spec 1 2 st_2));
          (Some (v_18, st_3)))
        else (
          when v_21, st_3 == ((find_lock_granule_spec v_5 1 st_2));
          rely (((((v_21.(poffset)) mod (16)) = (0)) /\ (((v_21.(poffset)) >= (0)))));
          rely ((((v_21.(pbase)) = ("granules")) \/ (((v_21.(pbase)) = ("null")))));
          if (ptr_eqb v_21 (mkPtr "null" 0))
          then (
            when v_23, st_4 == ((pack_return_code_spec 1 1 st_3));
            (Some (v_23, st_4)))
          else (
            when v_26, st_4 == ((data_create_internal_spec v_0 v_16 v_2 v_6 (mkPtr "null" 0) 0 st_3));
            if (v_26 =? (0))
            then (
              when st_6 == ((granule_unlock_transition_spec v_21 4 st_4));
              (Some (((v_26 << (32)) >> (32)), st_6)))
            else (
              when st_6 == ((granule_unlock_transition_spec v_21 1 st_4));
              (Some (((v_26 << (32)) >> (32)), st_6))))))
      else (
        when v_14, st_2 == ((data_create_s1_el1_spec v_0 (v_1 & ((- 2))) v_2 v_6 st_1));
        (Some (v_14, st_2)))).

  Fixpoint rsi_data_read_loop175 (_N_: nat) (__return__: bool) (__break__: bool) (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (v_6: Ptr) (v__027: Z) (st: RData) : (option (bool * bool * Ptr * Z * Z * Z * Z * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_0, v_1, v_2, v_3, v_4, v_6, v__027, st))
    | (S _N__0) =>
      match ((rsi_data_read_loop175 _N__0 __return__ __break__ v_0 v_1 v_2 v_3 v_4 v_6 v__027 st)) with
      | (Some (__return___0, __break___0, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0)) =>
        if __break___0
        then (Some (__return___0, true, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0))
        else (
          if __return___0
          then (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0))
          else (
            when v_13, st_1 == ((virt_to_phys_spec (v__28 + (v_8)) 0 v_7 v_9 st_0));
            if (v_13 =? (0))
            then (
              when v_14, st_2 == ((pack_return_code_spec 8 0 st_1));
              when st_3 == ((store_RData 8 (ptr_offset v_11 0) v_14 st_2));
              when st_4 == ((store_RData 8 (ptr_offset v_11 8) 2516582400 st_3));
              when v_18, st_5 == ((load_RData 8 v_7 st_4));
              when st_6 == ((store_RData 8 (ptr_offset v_11 8) (((v_18 >> (1)) & (63)) |' (2516582400)) st_5));
              when st_7 == ((store_RData 8 (ptr_offset v_11 16) (v__28 + (v_8)) st_6));
              (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_7)))
            else (
              when v_26, st_2 == ((next_granule_spec v_13 st_1));
              when v_28, st_3 == ((next_granule_spec (v__28 + (v_10)) st_2));
              when v_30, st_4 == ((min_spec (v_5 - (v__28)) (v_26 - (v_13)) (v_28 - ((v__28 + (v_10)))) st_3));
              when v_31, st_5 == ((ns_buffer_write_byte_spec (v__28 + (v_10)) v_30 v_13 st_4));
              if v_31
              then (
                if (((v_30 + (v__28)) - (v_5)) <? (0))
                then (Some (false, false, v_11, v_8, v_10, v_5, v_9, v_7, (v_30 + (v__28)), st_5))
                else (Some (false, true, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_5)))
              else (
                when v_34, st_6 == ((pack_return_code_spec 1 208 st_5));
                when st_7 == ((store_RData 8 (ptr_offset v_11 0) v_34 st_6));
                (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_7))))))
      | None => None
      end
    end.

  Definition rsi_data_read_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "rsi_data_read" st));
    when st_1 == ((rc_update_ttbr0_el12_spec v_4 st_0));
    if ((0 - (v_3)) <? (0))
    then (
      rely (((rsi_data_read_loop175_rank v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0) >= (0)));
      match ((rsi_data_read_loop175 (z_to_nat (rsi_data_read_loop175_rank v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0)) false false v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0 st_1)) with
      | (Some (__return___0, __break__, v_12, v_9, v_11, v_5, v_10, v_8, v__28, st_2)) =>
        if __return___0
        then (
          when st_4 == ((free_stack "rsi_data_read" st_0 st_2));
          (Some st_4))
        else (
          when st_4 == ((store_RData 8 (ptr_offset v_0 0) 0 st_2));
          when st_5 == ((free_stack "rsi_data_read" st_0 st_4));
          (Some st_5))
      | None => None
      end)
    else (
      when st_3 == ((store_RData 8 (ptr_offset v_0 0) 0 st_1));
      when st_4 == ((free_stack "rsi_data_read" st_0 st_3));
      (Some st_4)).

  Definition rsi_rtt_map_non_secure_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 & (1)) =? (0))
    then (
      when v_20, st_0 == ((map_unmap_ns_s1_spec v_0 v_1 v_2 v_3 0 st));
      (Some (v_20, st_0)))
    else (
      when v_8, st_0 == ((find_lock_granule_spec (v_0 & ((- 2))) 3 st));
      rely (((((v_8.(poffset)) mod (16)) = (0)) /\ (((v_8.(poffset)) >= (0)))));
      rely ((((v_8.(pbase)) = ("granules")) \/ (((v_8.(pbase)) = ("null")))));
      if (ptr_eqb v_8 (mkPtr "null" 0))
      then (
        when v_10, st_1 == ((pack_return_code_spec 1 1 st_0));
        (Some (v_10, st_1)))
      else (
        when v_13, st_1 == ((granule_map_spec v_8 3 st_0));
        rely (((((v_13.(pbase)) = ("granule_data")) /\ ((((v_13.(poffset)) mod (4096)) = (0)))) /\ (((v_13.(poffset)) >= (0)))));
        rely ((((((st_1.(share)).(granule_data)) @ ((v_13.(poffset)) / (4096))).(g_granule_state)) = (GRANULE_STATE_REC)));
        when v_16_tmp, st_2 == ((load_RData 8 (ptr_offset v_13 1544) st_1));
        when v_17, st_3 == ((granule_addr_spec (int_to_ptr v_16_tmp) st_2));
        when v_18, st_4 == ((map_unmap_ns_s1_spec v_17 v_1 v_2 v_3 0 st_3));
        when st_5 == ((granule_unlock_spec v_8 st_4));
        (Some (v_18, st_5)))).

  Fixpoint rsi_data_write_loop104 (_N_: nat) (__return__: bool) (__break__: bool) (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (v_6: Ptr) (v__027: Z) (st: RData) : (option (bool * bool * Ptr * Z * Z * Z * Z * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_0, v_1, v_2, v_3, v_4, v_6, v__027, st))
    | (S _N__0) =>
      match ((rsi_data_write_loop104 _N__0 __return__ __break__ v_0 v_1 v_2 v_3 v_4 v_6 v__027 st)) with
      | (Some (__return___0, __break___0, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0)) =>
        if __break___0
        then (Some (__return___0, true, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0))
        else (
          if __return___0
          then (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0))
          else (
            when v_13, st_1 == ((virt_to_phys_spec (v__28 + (v_8)) 1 v_7 v_9 st_0));
            if (v_13 =? (0))
            then (
              when v_14, st_2 == ((pack_return_code_spec 8 0 st_1));
              when st_3 == ((store_RData 8 (ptr_offset v_11 0) v_14 st_2));
              when st_4 == ((store_RData 8 (ptr_offset v_11 8) 2516582464 st_3));
              when v_18, st_5 == ((load_RData 8 v_7 st_4));
              when st_6 == ((store_RData 8 (ptr_offset v_11 8) (((v_18 >> (1)) & (63)) |' (2516582464)) st_5));
              when st_7 == ((store_RData 8 (ptr_offset v_11 16) (v__28 + (v_8)) st_6));
              (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_7)))
            else (
              when v_26, st_2 == ((next_granule_spec (v__28 + (v_10)) st_1));
              when v_28, st_3 == ((next_granule_spec v_13 st_2));
              when v_30, st_4 == ((min_spec (v_5 - (v__28)) (v_26 - ((v__28 + (v_10)))) (v_28 - (v_13)) st_3));
              when v_31, st_5 == ((ns_buffer_read_byte_spec (v__28 + (v_10)) v_30 v_13 st_4));
              if v_31
              then (
                if (((v_30 + (v__28)) - (v_5)) <? (0))
                then (Some (false, false, v_11, v_8, v_10, v_5, v_9, v_7, (v_30 + (v__28)), st_5))
                else (Some (false, true, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_5)))
              else (
                when v_34, st_6 == ((pack_return_code_spec 1 139 st_5));
                when st_7 == ((store_RData 8 (ptr_offset v_11 0) v_34 st_6));
                (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_7))))))
      | None => None
      end
    end.
  
  Definition rsi_data_write_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "rsi_data_write" st));
    when st_1 == ((rc_update_ttbr0_el12_spec v_4 st_0));
    if ((0 - (v_3)) <? (0))
    then (
      rely (((rsi_data_write_loop104_rank v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0) >= (0)));
      match ((rsi_data_write_loop104 (z_to_nat (rsi_data_write_loop104_rank v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0)) false false v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0 st_1)) with
      | (Some (__return___0, __break__, v_12, v_9, v_11, v_5, v_10, v_8, v__28, st_2)) =>
        if __return___0
        then (
          when st_4 == ((free_stack "rsi_data_write" st_0 st_2));
          (Some st_4))
        else (
          when st_4 == ((store_RData 8 (ptr_offset v_0 0) 0 st_2));
          when st_5 == ((free_stack "rsi_data_write" st_0 st_4));
          (Some st_5))
      | None => None
      end)
    else (
      when st_3 == ((store_RData 8 (ptr_offset v_0 0) 0 st_1));
      when st_4 == ((free_stack "rsi_data_write" st_0 st_3));
      (Some st_4)).

  Definition rsi_set_ttbr0_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((find_lock_granule_spec (v_1 & (281474976710654)) 5 st));
    rely (((((v_4.(poffset)) mod (16)) = (0)) /\ (((v_4.(poffset)) >= (0)))));
    rely ((((v_4.(pbase)) = ("granules")) \/ (((v_4.(pbase)) = ("null")))));
    if (ptr_eqb v_4 (mkPtr "null" 0))
    then (
      when v_6, st_1 == ((pack_return_code_spec 1 2 st_0));
      (Some (v_6, st_1)))
    else (
      when st_1 == ((store_RData 8 (ptr_offset v_0 1536) (ptr_to_int v_4) st_0));
      when st_2 == ((store_RData 8 (ptr_offset v_0 392) v_1 st_1));
      when st_3 == ((iasm_82_spec v_1 st_2));
      when st_4 == ((iasm_12_isb_spec st_3));
      when st_5 == ((granule_unlock_spec v_4 st_4));
      (Some (0, st_5))).

  Definition rsi_data_make_root_rtt_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((find_granule_spec v_0 st));
    rely ((((v_2.(pbase)) = ("granules")) \/ (((v_2.(pbase)) = ("null")))));
    if (ptr_eqb v_2 (mkPtr "null" 0))
    then (
      when v_4, st_1 == ((pack_return_code_spec 1 22 st_0));
      (Some (v_4, st_1)))
    else (
      when v_7, st_1 == ((granule_try_lock_spec v_2 1 st_0));
      if v_7
      then (
        when v_9, st_2 == ((granule_map_spec v_2 1 st_1));
        when st_3 == ((s2tt_init_unassigned_spec v_9 1 st_2));
        when st_4 == ((granule_unlock_transition_spec v_2 5 st_3));
        (Some (0, st_4)))
      else (Some (0, st_1))).

  Definition rsi_expected_result_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_0 =? (3221225482)) || ((v_0 =? (3221225491))))
    then (
      if (v_0 =? (3221225482))
      then (Some (false, st))
      else (
        when v_4, st_0 == ((pack_return_code_spec 9 1234 st));
        (Some (((v_4 - (v_1)) =? (0)), st_0))))
    else (
      when v_8, st_1 == ((pack_return_code_spec 8 0 st));
      (Some (((v_8 - (v_1)) =? (0)), st_1))).

  Definition smc_granule_delegate_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((find_lock_granule_spec v_0 0 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_5, st_1)))
    else (
      when st_1 == ((granule_set_state_spec v_3 1 st_0));
      when v_7, st_2 == ((set_pas_realm_spec v_0 st_1));
      when st_3 == ((clear_tte_ns_spec v_0 st_2));
      if (v_7 =? (0))
      then (
        when st_4 == ((granule_memzero_spec v_3 1 st_3));
        when st_6 == ((granule_unlock_spec v_3 st_4));
        (Some (0, st_6)))
      else (
        when st_5 == ((granule_unlock_spec v_3 st_3));
        when v_12, st_6 == ((pack_return_code_spec 1 1 st_5));
        (Some (v_12, st_6)))).

  Definition smc_granule_undelegate_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((find_lock_granule_spec v_0 1 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_5, st_1)))
    else (
      when st_1 == ((set_pas_ns_spec v_0 st_0));
      when st_2 == ((granule_set_state_spec v_3 0 st_1));
      when st_3 == ((set_tte_ns_spec v_0 st_2));
      when st_4 == ((granule_unlock_spec v_3 st_3));
      (Some (0, st_4))).

  Definition rsi_data_set_attrs_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "rsi_data_set_attrs" st));
    when v_7, st_1 == ((find_lock_granule_spec v_0 5 st_0));
    rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
    rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
    if (ptr_eqb v_7 (mkPtr "null" 0))
    then (
      when v_9, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "rsi_data_set_attrs" st_0 st_2));
      (Some (v_9, st_4)))
    else (
      when st_2 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) v_7 0 64 v_1 3 st_1));
      rely ((((st_2.(share)).(granule_data)) = (((st_1.(share)).(granule_data)))));
      when v__sroa_0_0_copyload_tmp, st_3 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_2));
      when v__sroa_6_0_copyload, st_4 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_3));
      if (v__sroa_6_0_copyload =? (3))
      then (rsi_data_set_attrs_0_low st_0 st_4 v_2 v__sroa_0_0_copyload_tmp v__sroa_6_0_copyload)
      else (
        when v_14, st_5 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_4));
        when st_7 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_5));
        when st_9 == ((free_stack "rsi_data_set_attrs" st_0 st_7));
        (Some (v_14, st_9)))).

  Definition timer_condition_met_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (5)) =? (5)), st)).

  Definition timer_is_masked_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (2)) <>? (0)), st)).

  Definition read_ap0r_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 =? (0))
    then (
      when v_9, st_0 == ((iasm_98_spec st));
      (Some (v_9, st_0)))
    else (
      if (v_0 =? (3))
      then (
        when v_3, st_0 == ((iasm_99_spec st));
        (Some (v_3, st_0)))
      else (
        if (v_0 =? (2))
        then (
          when v_5, st_0 == ((iasm_100_spec st));
          (Some (v_5, st_0)))
        else (
          if (v_0 =? (1))
          then (
            when v_7, st_0 == ((iasm_101_spec st));
            (Some (v_7, st_0)))
          else (Some (0, st))))).

  Definition read_ap1r_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 =? (0))
    then (
      when v_9, st_0 == ((iasm_102_spec st));
      (Some (v_9, st_0)))
    else (
      if (v_0 =? (3))
      then (
        when v_3, st_0 == ((iasm_103_spec st));
        (Some (v_3, st_0)))
      else (
        if (v_0 =? (2))
        then (
          when v_5, st_0 == ((iasm_104_spec st));
          (Some (v_5, st_0)))
        else (
          if (v_0 =? (1))
          then (
            when v_7, st_0 == ((iasm_105_spec st));
            (Some (v_7, st_0)))
          else (Some (0, st))))).

  Definition read_lr_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 =? (0))
    then (
      when v_33, st_0 == ((iasm_117_spec st));
      (Some (v_33, st_0)))
    else (
      if (v_0 =? (15))
      then (
        when v_3, st_0 == ((iasm_118_spec st));
        (Some (v_3, st_0)))
      else (
        if (v_0 =? (14))
        then (
          when v_5, st_0 == ((iasm_119_spec st));
          (Some (v_5, st_0)))
        else (
          if (v_0 =? (13))
          then (
            when v_7, st_0 == ((iasm_120_spec st));
            (Some (v_7, st_0)))
          else (
            if (v_0 =? (12))
            then (
              when v_9, st_0 == ((iasm_121_spec st));
              (Some (v_9, st_0)))
            else (
              if (v_0 =? (11))
              then (
                when v_11, st_0 == ((iasm_122_spec st));
                (Some (v_11, st_0)))
              else (
                if (v_0 =? (10))
                then (
                  when v_13, st_0 == ((iasm_123_spec st));
                  (Some (v_13, st_0)))
                else (
                  if (v_0 =? (9))
                  then (
                    when v_15, st_0 == ((iasm_124_spec st));
                    (Some (v_15, st_0)))
                  else (
                    if (v_0 =? (8))
                    then (
                      when v_17, st_0 == ((iasm_125_spec st));
                      (Some (v_17, st_0)))
                    else (
                      if (v_0 =? (7))
                      then (
                        when v_19, st_0 == ((iasm_126_spec st));
                        (Some (v_19, st_0)))
                      else (
                        if (v_0 =? (6))
                        then (
                          when v_21, st_0 == ((iasm_127_spec st));
                          (Some (v_21, st_0)))
                        else (
                          if (v_0 =? (5))
                          then (
                            when v_23, st_0 == ((iasm_128_spec st));
                            (Some (v_23, st_0)))
                          else (
                            if (v_0 =? (4))
                            then (
                              when v_25, st_0 == ((iasm_129_spec st));
                              (Some (v_25, st_0)))
                            else (
                              if (v_0 =? (3))
                              then (
                                when v_27, st_0 == ((iasm_130_spec st));
                                (Some (v_27, st_0)))
                              else (
                                if (v_0 =? (2))
                                then (
                                  when v_29, st_0 == ((iasm_131_spec st));
                                  (Some (v_29, st_0)))
                                else (
                                  if (v_0 =? (1))
                                  then (
                                    when v_31, st_0 == ((iasm_132_spec st));
                                    (Some (v_31, st_0)))
                                  else (Some (0, st))))))))))))))))).

  Fixpoint gic_restore_state_loop219 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_indvars_iv, st))
    | (S _N__0) =>
      match ((gic_restore_state_loop219 _N__0 __break__ v_0 v_indvars_iv st)) with
      | (Some (__break___0, v_1, v_indvars_iv_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_indvars_iv_0, st_0))
        else (
          rely ((((0 - (v_indvars_iv_0)) <= (0)) /\ ((v_indvars_iv_0 < (16)))));
          when v_19, st_1 == ((load_RData 8 (ptr_offset v_1 (80 + ((8 * (v_indvars_iv_0))))) st_0));
          when st_2 == ((write_lr_spec v_indvars_iv_0 v_19 st_1));
          when v_21, st_3 == ((load_RData 4 (mkPtr "nr_lrs" 0) st_2));
          if (((v_indvars_iv_0 + (1)) - (v_21)) <? (0))
          then (Some (false, v_1, (v_indvars_iv_0 + (1)), st_3))
          else (Some (true, v_1, v_indvars_iv_0, st_3)))
      | None => None
      end
    end.

  Fixpoint gic_restore_state_loop214 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_indvars_iv22: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_indvars_iv22, st))
    | (S _N__0) =>
      match ((gic_restore_state_loop214 _N__0 __break__ v_0 v_indvars_iv22 st)) with
      | (Some (__break___0, v_1, v_indvars_iv22_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_indvars_iv22_0, st_0))
        else (
          rely ((((0 - (v_indvars_iv22_0)) <= (0)) /\ ((v_indvars_iv22_0 < (4)))));
          when v_6, st_1 == ((load_RData 8 (ptr_offset v_1 (8 * (v_indvars_iv22_0))) st_0));
          when st_2 == ((write_ap0r_spec v_indvars_iv22_0 v_6 st_1));
          when v_9, st_3 == ((load_RData 8 (ptr_offset v_1 (32 + ((8 * (v_indvars_iv22_0))))) st_2));
          when st_4 == ((write_ap1r_spec v_indvars_iv22_0 v_9 st_3));
          when v_11, st_5 == ((load_RData 4 (mkPtr "nr_aprs" 0) st_4));
          if (((v_indvars_iv22_0 + (1)) - (v_11)) <? (0))
          then (Some (false, v_1, (v_indvars_iv22_0 + (1)), st_5))
          else (Some (true, v_1, v_indvars_iv22_0, st_5)))
      | None => None
      end
    end.

  Definition gic_restore_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((load_RData 4 (mkPtr "nr_aprs" 0) st));
    if ((0 - (v_2)) <? (0))
    then (
      rely (((gic_restore_state_loop214_rank v_0 0) >= (0)));
      match ((gic_restore_state_loop214 (z_to_nat (gic_restore_state_loop214_rank v_0 0)) false v_0 0 st_0)) with
      | (Some (__break__, v_1, v_indvars_iv22_0, st_1)) =>
        when v_15, st_3 == ((load_RData 4 (mkPtr "nr_lrs" 0) st_1));
        if ((0 - (v_15)) <? (0))
        then (gic_restore_state_0_low st_3 v_0 v_15)
        else (
          when v_26, st_5 == ((load_RData 8 (ptr_offset v_0 64) st_3));
          when st_6 == ((iasm_35_spec v_26 st_5));
          when v_28, st_7 == ((load_RData 8 (ptr_offset v_0 72) st_6));
          when st_8 == ((iasm_36_spec v_28 st_7));
          (Some st_8))
      | None => None
      end)
    else (
      when v_15, st_2 == ((load_RData 4 (mkPtr "nr_lrs" 0) st_0));
      if ((0 - (v_15)) <? (0))
      then (gic_restore_state_1_low st_2 v_0 v_15)
      else (
        when v_26, st_4 == ((load_RData 8 (ptr_offset v_0 64) st_2));
        when st_5 == ((iasm_35_spec v_26 st_4));
        when v_28, st_6 == ((load_RData 8 (ptr_offset v_0 72) st_5));
        when st_7 == ((iasm_36_spec v_28 st_6));
        (Some st_7))).

  Definition feat_vmid16_spec (st: RData) : (option (bool * RData)) :=
    when v_1, st_0 == ((iasm_31_spec st));
    (Some (((v_1 & (240)) <>? (0)), st_0)).

  Definition validate_map_addr_spec' (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_2.(pbase)) = ("granule_data")) /\ (((v_2.(poffset)) >= (0)))) /\ (((0 - (((v_2.(poffset)) mod (4096)))) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    when ret, st' == ((realm_ipa_bits_spec' v_2 st));
    if (ret =? (64))
    then (
      if ((1 - (v_0)) >? (0))
      then (
        if ((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_rd)).(e_is_rc_s_rd)) =? (0))
        then (
          if ((((v_0 & (281474976710655)) & (((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))))) - (v_0)) =? (0))
          then (Some (0, st))
          else (Some (1, st)))
        else (
          if (((((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))) & (v_0)) - (v_0)) =? (0))
          then (Some (0, st))
          else (Some (1, st))))
      else (Some (1, st)))
    else (
      if (((1 << (ret)) - (v_0)) >? (0))
      then (
        if ((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_rd)).(e_is_rc_s_rd)) =? (0))
        then (
          if ((((v_0 & (281474976710655)) & (((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))))) - (v_0)) =? (0))
          then (Some (0, st))
          else (Some (1, st)))
        else (
          if (((((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))) & (v_0)) - (v_0)) =? (0))
          then (Some (0, st))
          else (Some (1, st))))
      else (Some (1, st))).

  Definition validate_map_addr_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((validate_map_addr_spec' v_0 v_1 v_2 st));
    (Some (ret, st)).

    (* 
  Definition validate_map_addr_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_2.(pbase)) = ("granule_data")) /\ (((v_2.(poffset)) >= (0)))) /\ ((0 = (((v_2.(poffset)) mod (4096)))))));
    rely ((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_granule_state)) = (GRANULE_STATE_RD)));
    when v_4, st == ((realm_ipa_size_spec v_2 st));
    let v__not := (v_4 >? (v_0)) in
    when v__sroa_0_0, st == (
        let v__sroa_0_0 := 0 in
        if v__not
        then (
          let v_8 := (ptr_offset v_2 ((416 * (0)) + ((408 + (0))))) in
          rely ((408 = (((v_8.(poffset)) mod (4096)))));
          when v_9, st == ((load_RData 8 v_8 st));
          let v__not8 := (v_9 =? (0)) in
          when v__0_in, st == (
              let v__0_in := false in
              if v__not8
              then (
                when v_13, st == ((addr_is_level_aligned_spec v_0 v_1 st));
                let v__0_in := v_13 in
                (Some (v__0_in, st)))
              else (
                when v_11, st == ((s1addr_is_level_aligned_spec v_0 v_1 st));
                let v__0_in := v_11 in
                (Some (v__0_in, st))));
          when v__sroa_0_0, st == (
              let v__sroa_0_0 := 0 in
              if v__0_in
              then (
                when v_18, st == ((make_return_code_spec 0 0 st));
                let v__sroa_0_0 := v_18 in
                (Some (v__sroa_0_0, st)))
              else (
                when v_16, st == ((make_return_code_spec 1 0 st));
                let v__sroa_0_0 := v_16 in
                (Some (v__sroa_0_0, st))));
          (Some (v__sroa_0_0, st)))
        else (
          when v_6, st == ((make_return_code_spec 1 0 st));
          let v__sroa_0_0 := v_6 in
          (Some (v__sroa_0_0, st))));
    let __return__ := true in
    let __retval__ := v__sroa_0_0 in
    (Some (__retval__, st)). *)

  Definition rmm_feature_register_0_value_spec (st: RData) : (option (Z * RData)) :=
    when v_1, st_0 == ((max_pa_size_spec st));
    (Some (v_1, st_0)).

    Definition rsi_data_create_unknown_s1_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
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
                when st_3 == ((spinlock_acquire_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_4));
                if (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset)) / (16))).(e_state_s_granule)) - (2)) =? (0))
                then (
                  when v_11, st_5 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_3));
                  if v_11
                  then (
                    when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_5));
                    rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
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
                    when st_6 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                          (st_29.[share].[globals].[g_granules] :<
                            ((((st_29.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_29.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                    (Some (0, st_6)))
                  else (
                    when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_5));
                    when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                    when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      when st_6 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_21.[share].[globals].[g_granules] :<
                              ((((st_21.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_21.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_6)))
                    else (
                      when st_6 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_21.[share].[globals].[g_granules] :<
                              ((((st_21.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_21.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_6)))))
                else (
                  when st_5 == ((spinlock_release_spec (mkPtr ((rec_to_rd_para (mkPtr "null" 0) st_4).(pbase)) ((rec_to_rd_para (mkPtr "null" 0) st_4).(poffset))) st_3));
                  when v_11, st_6 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
                  if v_11
                  then (
                    when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_6));
                    rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
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
                    when st_7 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                          (st_29.[share].[globals].[g_granules] :<
                            ((((st_29.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_29.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                    (Some (0, st_7)))
                  else (
                    when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_6));
                    when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "null" 0) st_4) st_18));
                    when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_21.[share].[globals].[g_granules] :<
                              ((((st_21.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_21.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7)))
                    else (
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_21.[share].[globals].[g_granules] :<
                              ((((st_21.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_21.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7))))))
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
              when st_3 == (
                  (spinlock_acquire_spec
                    (mkPtr
                      ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(pbase))
                      ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)))
                    st_2));
              if (
                (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)) / (16))).(e_state_s_granule)) -
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
                      (((((((st_5.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(poffset)) / (16))).(e_state_s_granule)) -
                        (2)) =?
                        (0)))
                    then (
                      when v_11, st_6 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_5));
                      if v_11
                      then (
                        when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) st_6));
                        rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
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
                          when st_7 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                          (Some (0, st_7)))
                        else None)
                      else (
                        when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_6));
                        when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) st_18));
                        when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                        if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                        then (
                          when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                          rely (
                            ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                              (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          when st_7 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7)))
                        else (
                          when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                          rely (
                            ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                              (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          when st_7 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7)))))
                    else (
                      when st_6 == (
                          (spinlock_release_spec
                            (mkPtr
                              ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(pbase))
                              ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4).(poffset)))
                            st_5));
                      when v_11, st_7 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_6));
                      if v_11
                      then (
                        when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) st_7));
                        rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
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
                          when st_8 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                          (Some (0, st_8)))
                        else None)
                      else (
                        when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_7));
                        when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_4) st_18));
                        when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                        if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                        then (
                          when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                          rely (
                            ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                              (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          when st_8 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_8)))
                        else (
                          when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                          rely (
                            ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                              (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          when st_8 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_8))))))
                  else (
                    when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
                    if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
                    then (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_13));
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
                      (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_5)))
                    else (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_13));
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
                      (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_5)))))
                else (
                  when st_8 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
                  if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
                  then (
                    when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_8));
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
                    (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_5)))
                  else (
                    when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_8));
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
                    (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_5)))))
              else (
                when st_4 == (
                    (spinlock_release_spec
                      (mkPtr
                        ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(pbase))
                        ((rec_to_ttbr1_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_2).(poffset)))
                      st_3));
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
                      (((((((st_6.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(poffset)) / (16))).(e_state_s_granule)) -
                        (2)) =?
                        (0)))
                    then (
                      when v_11, st_7 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_6));
                      if v_11
                      then (
                        when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5) st_7));
                        rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
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
                          when st_8 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                          (Some (0, st_8)))
                        else None)
                      else (
                        when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_7));
                        when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5) st_18));
                        when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                        if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                        then (
                          when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                          rely (
                            ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                              (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          when st_8 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_8)))
                        else (
                          when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                          rely (
                            ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                              (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          when st_8 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_8)))))
                    else (
                      when st_7 == (
                          (spinlock_release_spec
                            (mkPtr
                              ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(pbase))
                              ((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5).(poffset)))
                            st_6));
                      when v_11, st_8 == ((memcpy_ns_read_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" 0) 4096 st_7));
                      if v_11
                      then (
                        when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5) st_8));
                        rely ((((rtt_ret.(e_2)).(pbase)) = ("granules")));
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
                          when st_9 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                          (Some (0, st_9)))
                        else None)
                      else (
                        when v_33, st_18 == ((memset_spec (mkPtr "granule_data" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) 0 4096 st_8));
                        when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) st_5) st_18));
                        when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                        if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                        then (
                          when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                          rely (
                            ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                              (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          when st_9 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9)))
                        else (
                          when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_21));
                          rely (
                            ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                              (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                          when st_9 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                                (st_10.[share].[globals].[g_granules] :<
                                  ((((st_10.(share)).(globals)).(g_granules)) #
                                    ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                    (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9))))))
                  else (
                    when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_5));
                    if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
                    then (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_13));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7)))
                    else (
                      when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_13));
                      rely (
                        ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                          (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                            (st_10.[share].[globals].[g_granules] :<
                              ((((st_10.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                      (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_7)))))
                else (
                  when st_8 == ((granule_unlock_spec (rtt_ret.(e_2)) st_5));
                  if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
                  then (
                    when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_8));
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    when st_7 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                          (st_10.[share].[globals].[g_granules] :<
                            ((((st_10.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                    (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7)))
                  else (
                    when st_10 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_8));
                    rely (
                      ((("granules" = ("granules")) /\ ((((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\
                        (((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    when st_7 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)))
                          (st_10.[share].[globals].[g_granules] :<
                            ((((st_10.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                    (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7))))))
            else (
              when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_2));
              when st_4 == ((granule_unlock_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st_3));
              (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_4))))
          else (
            when st_2 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_0).(meta_PA)).(meta_granule_offset))) st_1));
            (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_2))))).

End Layer9_Spec.

#[global] Hint Unfold gic_restore_state_loop214_rank: spec.
#[global] Hint Unfold gic_restore_state_loop219_rank: spec.
#[global] Hint Unfold rsi_rtt_set_ripas_spec: spec.
#[global] Hint Unfold rsi_rtt_unmap_non_secure_spec: spec.
#[global] Hint Unfold rsi_rtt_create_spec: spec.
#[global] Hint Unfold rsi_data_destroy_spec: spec.
#[global] Hint Unfold rsi_rtt_destroy_spec: spec.
#[global] Hint Unfold rsi_data_map_extra_spec: spec.
#[global] Hint Unfold rsi_data_create_s1_spec: spec.
#[global] Hint Unfold rsi_data_create_unknown_s1_spec: spec.
#[global] Hint Unfold rsi_data_read_loop175: spec.
#[global] Hint Unfold rsi_data_read_spec: spec.
#[global] Hint Unfold rsi_rtt_map_non_secure_spec: spec.
#[global] Hint Unfold rsi_data_write_loop104: spec.
#[global] Hint Unfold rsi_data_write_spec: spec.
#[global] Hint Unfold rsi_set_ttbr0_spec: spec.
#[global] Hint Unfold rsi_data_make_root_rtt_spec: spec.
#[global] Hint Unfold rsi_expected_result_spec: spec.
#[global] Hint Unfold smc_granule_delegate_spec: spec.
#[global] Hint Unfold smc_granule_undelegate_spec: spec.
#[global] Hint Unfold rsi_data_set_attrs_spec: spec.
#[global] Hint Unfold timer_condition_met_spec: spec.
#[global] Hint Unfold timer_is_masked_spec: spec.
#[global] Hint Unfold read_ap0r_spec: spec.
#[global] Hint Unfold read_ap1r_spec: spec.
#[global] Hint Unfold read_lr_spec: spec.
#[global] Hint Unfold gic_restore_state_loop219: spec.
#[global] Hint Unfold gic_restore_state_loop214: spec.
#[global] Hint Unfold gic_restore_state_spec: spec.
#[global] Hint Unfold feat_vmid16_spec: spec.
#[global] Hint Unfold validate_map_addr_spec: spec.
#[global] Hint Unfold rmm_feature_register_0_value_spec: spec.
