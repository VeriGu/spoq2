Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter test_Ptr_PTE : Ptr -> abs_PTE_t.

Parameter rec_to_ttbr1_para : Ptr -> (RData -> Ptr).

Section Layer8_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition update_ripas_spec' (v_0: Ptr) (v_1: Z) (v_2: Z) : (option bool) :=
    if ((v_1 <? (3)) && ((((test_Ptr_PTE v_0).(meta_desc_type)) =? (3))))
    then (Some false)
    else (
      if ((v_1 =? (3)) && ((((test_Ptr_PTE v_0).(meta_desc_type)) =? (3))))
      then (Some true)
      else (
        if ((v_1 <>? (3)) && ((((test_Ptr_PTE v_0).(meta_desc_type)) =? (1))))
        then (Some true)
        else (
          if (((((test_Ptr_PTE v_0).(meta_desc_type)) =? (0)) && ((((test_Ptr_PTE v_0).(meta_ripas)) =? (0)))) && ((((test_Ptr_PTE v_0).(meta_mem_attr)) =? (0))))
          then (Some true)
          else (
            if (((((test_Ptr_PTE v_0).(meta_desc_type)) =? (0)) && ((((test_Ptr_PTE v_0).(meta_ripas)) =? (0)))) && ((((test_Ptr_PTE v_0).(meta_mem_attr)) =? (1))))
            then (Some true)
            else (Some false))))).

  Definition update_ripas_spec_abs (v_0: abs_PTE_t) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * abs_PTE_t)) :=
    when v_5, st_1 == ((s2tte_is_table_spec_abs v_0 v_1 st));
    if v_5
    then (Some (false, v_0))
    else (
      when v_9, st_2 == ((s1tte_is_valid_spec_abs v_0 v_1 st_1));
      if v_9
      then (
        if (v_2 =? (0))
        then (
          when v_14, st_3 == ((s2tte_pa_spec_abs v_0 v_1 st_2));
          when v_15, st_4 == ((s2tte_create_assigned_spec_abs v_14 v_1 st_3));
          (Some (true, v_15)))
        else (Some (true, v_0)))
      else (
        when v_19, st_5 == ((s2tte_is_unassigned_spec_abs v_0 st_1));
        if v_19
        then (
          let v_with_ripas := (mkabs_PTE_t (v_0.(meta_PA)) (v_0.(meta_desc_type)) v_2 (v_0.(meta_mem_attr))) in
          (Some (true, v_with_ripas)))
        else (
          when v_22, st_7 == ((s2tte_is_assigned_spec_abs v_0 v_1 st_5));
          if v_22
          then (
            let v_with_ripas := (mkabs_PTE_t (v_0.(meta_PA)) (v_0.(meta_desc_type)) v_2 (v_0.(meta_mem_attr))) in
            (Some (true, v_with_ripas)))
          else (Some (false, v_0))))).

  Definition rtt_create_s1_el1_spec_abs (v_0: Ptr) (v_1: abs_PA_t) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    let ttbr := (rec_to_ttbr1_para v_0 st) in
    when st_1 == ((granule_lock_spec ttbr 5 st));
    when v_7, st_2 == ((rtt_create_internal_spec_abs ttbr v_1 v_2 v_3 1 st_1));
    (Some (v_7, st_2)).

  Definition data_create_s1_el1_0 (st_0: RData) (st_7: RData) (v_25: Z) (ret_1: Ptr) (ret_2: Ptr) : (option (Z * RData)) :=
    let v_29 := ret_2 in
    when st_10 == ((granule_unlock_spec v_29 st_7));
    let v_30 := ret_1 in
    when st_12 == ((granule_unlock_transition_spec v_30 4 st_10));
    when st_15 == ((free_stack "data_create_s1_el1" st_0 st_12));
    (Some (v_25, st_15)).

  Definition data_create_s1_el1_spec_abs (v_0_pte: abs_PTE_t) (v_1_pa: abs_PA_t) (v_2: Z) (v_3: Ptr) (st: RData) : (option (Z * RData)) :=
    if ((((v_0_pte.(meta_PA)).(meta_granule_offset)) - ((v_1_pa.(meta_granule_offset)))) =? (0))
    then (Some ((pack_struct_return_code_para (make_return_code_para 3)), st))
    else (
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((v_0_pte.(meta_PA)).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
      then (
        when st_2 == ((spinlock_acquire_spec (mkPtr "granules" (v_1_pa.(meta_granule_offset))) st_1));
        if (((((((st_2.(share)).(globals)).(g_granules)) @ ((v_1_pa.(meta_granule_offset)) / (16))).(e_state_s_granule)) - (3)) =? (0))
        then (
          when st_6 == ((granule_lock_spec (rec_to_ttbr1_para (mkPtr "granule_data" (v_1_pa.(meta_granule_offset))) st_2) 5 st_2));
          rely (((((((st_6.(share)).(granule_data)) @ ((v_1_pa.(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
          rely (((("granule_data" = ("granule_data")) /\ ((((v_1_pa.(meta_granule_offset)) mod (4096)) = (0)))) /\ (((v_1_pa.(meta_granule_offset)) >= (0)))));
          when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (rec_to_ttbr1_para (mkPtr "granule_data" (v_1_pa.(meta_granule_offset))) st_2) 0 64 v_2 3 st_6));
          rely ((((st_4.(share)).(granule_data)) = (((st_6.(share)).(granule_data)))));
          if ((rtt_ret.(e_1)) =? (3))
          then (
            if (
              (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
                ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
                ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
            then (
              when st_13 == ((granule_lock_spec (rec_to_rd_para (mkPtr "granule_data" (v_1_pa.(meta_granule_offset))) st_4) 2 st_4));
              when v_11, st_3 == ((memcpy_ns_read_spec (mkPtr "granule_data" ((v_0_pte.(meta_PA)).(meta_granule_offset))) (mkPtr "granule_data" (v_3.(poffset))) 4096 st_13));
              if v_11
              then (
                when st_18 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" (v_1_pa.(meta_granule_offset))) st_4) st_3));
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
                  when st_10 == ((granule_unlock_spec (mkPtr "granules" (v_1_pa.(meta_granule_offset))) st_30));
                  when st_5 == (
                      (granule_unlock_spec
                        (mkPtr "granules" ((v_0_pte.(meta_PA)).(meta_granule_offset)))
                        (st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                  (Some (0, st_5)))
                else None)
              else (
                when v_33, st_18 == ((memset_spec (mkPtr "granule_data" ((v_0_pte.(meta_PA)).(meta_granule_offset))) 0 4096 st_3));
                when st_19 == ((granule_unlock_spec (rec_to_rd_para (mkPtr "granule_data" (v_1_pa.(meta_granule_offset))) st_4) st_18));
                when st_21 == ((granule_unlock_spec (rtt_ret.(e_2)) st_19));
                if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                then (
                  when st_10 == ((granule_unlock_spec (mkPtr "granules" (v_1_pa.(meta_granule_offset))) st_21));
                  rely (((("granules" = ("granules")) /\ (((((v_0_pte.(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\ ((((v_0_pte.(meta_PA)).(meta_granule_offset)) >= (0)))));
                  when st_5 == (
                      (granule_unlock_spec
                        (mkPtr "granules" ((v_0_pte.(meta_PA)).(meta_granule_offset)))
                        (st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5)))
                else (
                  when st_10 == ((granule_unlock_spec (mkPtr "granules" (v_1_pa.(meta_granule_offset))) st_21));
                  rely (((("granules" = ("granules")) /\ (((((v_0_pte.(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\ ((((v_0_pte.(meta_PA)).(meta_granule_offset)) >= (0)))));
                  when st_5 == (
                      (granule_unlock_spec
                        (mkPtr "granules" ((v_0_pte.(meta_PA)).(meta_granule_offset)))
                        (st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5)))))
            else (
              when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
              if ((pack_struct_return_code_para (make_return_code_para 9)) =? (0))
              then (
                when st_10 == ((granule_unlock_spec (mkPtr "granules" (v_1_pa.(meta_granule_offset))) st_13));
                rely (((("granules" = ("granules")) /\ (((((v_0_pte.(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\ ((((v_0_pte.(meta_PA)).(meta_granule_offset)) >= (0)))));
                when st_3 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((v_0_pte.(meta_PA)).(meta_granule_offset)))
                      (st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_3)))
              else (
                when st_10 == ((granule_unlock_spec (mkPtr "granules" (v_1_pa.(meta_granule_offset))) st_13));
                rely (((("granules" = ("granules")) /\ (((((v_0_pte.(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\ ((((v_0_pte.(meta_PA)).(meta_granule_offset)) >= (0)))));
                when st_3 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((v_0_pte.(meta_PA)).(meta_granule_offset)))
                      (st_10.[share].[globals].[g_granules] :<
                        ((((st_10.(share)).(globals)).(g_granules)) #
                          (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_10.(share)).(globals)).(g_granules)) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_3)))))
          else (
            when st_8 == ((granule_unlock_spec (rtt_ret.(e_2)) st_4));
            if ((pack_struct_return_code_para (make_return_code_para 8)) =? (0))
            then (
              when st_10 == ((granule_unlock_spec (mkPtr "granules" (v_1_pa.(meta_granule_offset))) st_8));
              rely (((("granules" = ("granules")) /\ (((((v_0_pte.(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\ ((((v_0_pte.(meta_PA)).(meta_granule_offset)) >= (0)))));
              when st_3 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((v_0_pte.(meta_PA)).(meta_granule_offset)))
                    (st_10.[share].[globals].[g_granules] :<
                      ((((st_10.(share)).(globals)).(g_granules)) #
                        (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_10.(share)).(globals)).(g_granules)) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 4)))));
              (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_3)))
            else (
              when st_10 == ((granule_unlock_spec (mkPtr "granules" (v_1_pa.(meta_granule_offset))) st_8));
              rely (((("granules" = ("granules")) /\ (((((v_0_pte.(meta_PA)).(meta_granule_offset)) mod (16)) = (0)))) /\ ((((v_0_pte.(meta_PA)).(meta_granule_offset)) >= (0)))));
              when st_3 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((v_0_pte.(meta_PA)).(meta_granule_offset)))
                    (st_10.[share].[globals].[g_granules] :<
                      ((((st_10.(share)).(globals)).(g_granules)) #
                        (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_10.(share)).(globals)).(g_granules)) @ (((v_0_pte.(meta_PA)).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
              (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_3)))))
        else (
          when st_3 == ((spinlock_release_spec (mkPtr "granules" (v_1_pa.(meta_granule_offset))) st_2));
          when st_4 == ((granule_unlock_spec (mkPtr "granules" ((v_0_pte.(meta_PA)).(meta_granule_offset))) st_3));
          (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_4))))
      else (
        when st_2 == ((spinlock_release_spec (mkPtr "granules" ((v_0_pte.(meta_PA)).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_2)))).

  Definition granule_memzero_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when v_4, st_1 == ((memset_spec (mkPtr "granule_data" (v_0.(poffset))) 0 4096 st));
    (Some st_1).

  Definition map_unmap_ns_s1_0 (st_0: RData) (st_12: RData) (v_17: Ptr) (v_3: abs_PTE_t) (v_31: Z) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_31 =? (0)) = (true)));
    rely (((v__sroa_0_0_copyload.(pbase)) =s ("granules")));
    rely (((((v__sroa_0_0_copyload.(poffset)) + (8)) mod (16)) = (8)));
    when st_19 == (
        (granule_unlock_spec
          v__sroa_0_0_copyload
          ((st_12.[share].[globals].[g_granules] :<
            ((((st_12.(share)).(globals)).(g_granules)) #
              (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16)) ==
              (((((st_12.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).[e_ref] :<
                ((((((st_12.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                  (((((((st_12.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
            (((st_12.(share)).(granule_data)) #
              (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096)) ==
              ((((st_12.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).[g_norm] :<
                (((((st_12.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).(g_norm)) #
                  (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) mod (4096)) ==
                  (test_PTE_Z v_3)))))));
    (Some (0, st_19)).

  Definition map_unmap_ns_s1_1 (st_0: RData) (st_11: RData) (v_17: Ptr) (v_3: abs_PTE_t) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v__sroa_0_0_copyload.(pbase)) =s ("granules")));
    rely (((((v__sroa_0_0_copyload.(poffset)) + (8)) mod (16)) = (8)));
    when st_18 == (
        (granule_unlock_spec
          v__sroa_0_0_copyload
          ((st_11.[share].[globals].[g_granules] :<
            ((((st_11.(share)).(globals)).(g_granules)) #
              (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16)) ==
              (((((st_11.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).[e_ref] :<
                ((((((st_11.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                  (((((((st_11.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
            (((st_11.(share)).(granule_data)) #
              (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096)) ==
              ((((st_11.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).[g_norm] :<
                (((((st_11.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).(g_norm)) #
                  (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) mod (4096)) ==
                  (test_PTE_Z v_3)))))));
    (Some (0, st_18)).

  Definition map_unmap_ns_s1_2 (st_0: RData) (st_12: RData) (v_17: Ptr) (v_47: Z) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_47 =? (0)) = (true)));
    rely (((((v__sroa_0_0_copyload.(pbase)) = ("granules")) /\ ((((v__sroa_0_0_copyload.(poffset)) mod (16)) = (0)))) /\ (((v__sroa_0_0_copyload.(poffset)) >= (0)))));
    rely (((((v__sroa_0_0_copyload.(pbase)) = ("granules")) /\ ((((v__sroa_0_0_copyload.(poffset)) mod (16)) = (0)))) /\ (((v__sroa_0_0_copyload.(poffset)) >= (0)))));
    rely (((v__sroa_0_0_copyload.(pbase)) =s ("granules")));
    rely (((((v__sroa_0_0_copyload.(poffset)) + (8)) mod (16)) = (8)));
    when st_20 == (
        (granule_unlock_spec
          v__sroa_0_0_copyload
          ((st_12.[share].[globals].[g_granules] :<
            ((((st_12.(share)).(globals)).(g_granules)) #
              (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16)) ==
              (((((st_12.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).[e_ref] :<
                ((((((st_12.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                  (((((((st_12.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
            (((st_12.(share)).(granule_data)) #
              (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096)) ==
              ((((st_12.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).[g_norm] :<
                (((((st_12.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).(g_norm)) #
                  (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) mod (4096)) ==
                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
    (Some (0, st_20)).

  Definition map_unmap_ns_s1_3 (st_0: RData) (st_11: RData) (v_17: Ptr) (v_20: abs_PTE_t) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely (((((v__sroa_0_0_copyload.(pbase)) = ("granules")) /\ ((((v__sroa_0_0_copyload.(poffset)) mod (16)) = (0)))) /\ (((v__sroa_0_0_copyload.(poffset)) >= (0)))));
    rely (((((v__sroa_0_0_copyload.(pbase)) = ("granules")) /\ ((((v__sroa_0_0_copyload.(poffset)) mod (16)) = (0)))) /\ (((v__sroa_0_0_copyload.(poffset)) >= (0)))));
    rely (((v__sroa_0_0_copyload.(pbase)) =s ("granules")));
    rely (((((v__sroa_0_0_copyload.(poffset)) + (8)) mod (16)) = (8)));
    when st_19 == (
        (granule_unlock_spec
          v__sroa_0_0_copyload
          ((st_11.[share].[globals].[g_granules] :<
            ((((st_11.(share)).(globals)).(g_granules)) #
              (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16)) ==
              (((((st_11.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).[e_ref] :<
                ((((((st_11.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                  (((((((st_11.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
            (((st_11.(share)).(granule_data)) #
              (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096)) ==
              ((((st_11.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).[g_norm] :<
                (((((st_11.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).(g_norm)) #
                  (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) mod (4096)) ==
                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
    (Some (0, st_19)).

  Definition map_unmap_ns_s1_spec (v_0_Zptr: Z) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
    rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
    then (
      when ret_rtt, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) 0 64 v_1 v_2 st_1));
      rely ((((st_4.(share)).(granule_data)) = (((st_1.(share)).(granule_data)))));
      if (((ret_rtt.(e_1)) - (v_2)) =? (0))
      then (
        if (v_4 =? (0))
        then (
          if (
            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
          then (
            if (uart0_phys_para (test_Z_PTE v_3))
            then (
              rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
              rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
              when st_18 == (
                  (granule_unlock_spec
                    (ret_rtt.(e_2))
                    ((st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                          ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                      (((st_4.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (test_Z_PTE v_3))))))));
              (Some (0, st_18)))
            else (
              when st_2 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_4));
              if ((((((st_2.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) =? (0))
              then (
                rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                when st_6 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)))
                      (st_2.[share].[globals].[g_granules] :<
                        ((((st_2.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              ((g_mapped_addr_set_para
                                ((((((st_2.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                                v_1) +
                                (1)))).[e_state_s_granule] :<
                            6)))));
                rely ((true = (true)));
                rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                when st_19 == (
                    (granule_unlock_spec
                      (ret_rtt.(e_2))
                      ((st_6.[share].[globals].[g_granules] :<
                        ((((st_6.(share)).(globals)).(g_granules)) #
                          ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                        (((st_6.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (test_Z_PTE v_3))))))));
                (Some (0, st_19)))
              else (
                when st_3 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_2));
                when st_5 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_3));
                if (((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (6)) =? (0))
                then (
                  rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                  when st_6 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)))
                        (st_5.[share].[globals].[g_granules] :<
                          ((((st_5.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                  rely ((true = (true)));
                  rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                  rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                  when st_19 == (
                      (granule_unlock_spec
                        (ret_rtt.(e_2))
                        ((st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                          (((st_6.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (test_Z_PTE v_3))))))));
                  (Some (0, st_19)))
                else (
                  when st_6 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_5));
                  if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                  then (
                    rely ((true = (true)));
                    rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    when st_19 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_6.[share].[globals].[g_granules] :<
                            ((((st_6.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                            (((st_6.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (test_Z_PTE v_3))))))));
                    (Some (0, st_19)))
                  else (
                    when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_6));
                    (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14)))))))
          else (
            when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
            (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13))))
        else (
          if (v_4 =? (1))
          then (
            if ((v_2 =? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
            then (
              if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
              then (
                rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                when st_19 == (
                    (granule_unlock_spec
                      (ret_rtt.(e_2))
                      ((st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                (Some (0, st_19)))
              else (
                when st_2 == (
                    (spinlock_acquire_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                      st_4));
                if (
                  (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                    (6)) =?
                    (0)))
                then (
                  rely (
                    ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                      (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  if (
                    ((g_refcount_para
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                      (st_2.[share].[globals].[g_granules] :<
                        ((((st_2.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))) =?
                      (0)))
                  then (
                    when st_7 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          (st_2.[share].[globals].[g_granules] :<
                            ((((st_2.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (g_mapped_addr_set_para
                                    (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))
                                    0))).[e_state_s_granule] :<
                                0)))));
                    rely ((true = (true)));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    when st_20 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                    (Some (0, st_20)))
                  else (
                    when st_5 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          (st_2.[share].[globals].[g_granules] :<
                            ((((st_2.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (g_mapped_addr_set_para
                                    (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))
                                    0)))))));
                    rely ((true = (true)));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    when st_20 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_5.[share].[globals].[g_granules] :<
                            ((((st_5.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                    (Some (0, st_20))))
                else (
                  when st_3 == (
                      (spinlock_release_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                        st_2));
                  if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                  then (
                    rely ((true = (true)));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    when st_20 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_3.[share].[globals].[g_granules] :<
                            ((((st_3.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_3.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                    (Some (0, st_20)))
                  else (
                    when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_3));
                    (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))))
            else (
              if ((v_2 <>? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (1))))
              then (
                if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
                then (
                  rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                  rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                  when st_19 == (
                      (granule_unlock_spec
                        (ret_rtt.(e_2))
                        ((st_4.[share].[globals].[g_granules] :<
                          ((((st_4.(share)).(globals)).(g_granules)) #
                            ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                          (((st_4.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                  (Some (0, st_19)))
                else (
                  when st_2 == (
                      (spinlock_acquire_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                        st_4));
                  if (
                    (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                      (6)) =?
                      (0)))
                  then (
                    rely (
                      ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                        (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (
                      ((g_refcount_para
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                        (st_2.[share].[globals].[g_granules] :<
                          ((((st_2.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))) =?
                        (0)))
                    then (
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            (st_2.[share].[globals].[g_granules] :<
                              ((((st_2.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (g_mapped_addr_set_para
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))
                                      0))).[e_state_s_granule] :<
                                  0)))));
                      rely ((true = (true)));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                      when st_20 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            ((st_7.[share].[globals].[g_granules] :<
                              ((((st_7.(share)).(globals)).(g_granules)) #
                                ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                      (Some (0, st_20)))
                    else (
                      when st_5 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            (st_2.[share].[globals].[g_granules] :<
                              ((((st_2.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (g_mapped_addr_set_para
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))
                                      0)))))));
                      rely ((true = (true)));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                      when st_20 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            ((st_5.[share].[globals].[g_granules] :<
                              ((((st_5.(share)).(globals)).(g_granules)) #
                                ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_5.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                      (Some (0, st_20))))
                  else (
                    when st_3 == (
                        (spinlock_release_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          st_2));
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      rely ((true = (true)));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                      when st_20 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            ((st_3.[share].[globals].[g_granules] :<
                              ((((st_3.(share)).(globals)).(g_granules)) #
                                ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_3.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                      (Some (0, st_20)))
                    else (
                      when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_3));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))))
              else (
                when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
                (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13)))))
          else (
            when st_12 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
            (Some (0, st_12)))))
      else (
        when st_8 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
        (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_8))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_1));
      when ret_rtt, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) 0 64 v_1 v_2 st_2));
      rely ((((st_4.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
      if (((ret_rtt.(e_1)) - (v_2)) =? (0))
      then (
        if (v_4 =? (0))
        then (
          if (
            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
          then (
            if (uart0_phys_para (test_Z_PTE v_3))
            then (
              rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
              rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
              when st_18 == (
                  (granule_unlock_spec
                    (ret_rtt.(e_2))
                    ((st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                          ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                      (((st_4.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (test_Z_PTE v_3))))))));
              (Some (0, st_18)))
            else (
              when st_3 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_4));
              if ((((((st_3.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) =? (0))
              then (
                rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                when st_6 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)))
                      (st_3.[share].[globals].[g_granules] :<
                        ((((st_3.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          ((((((st_3.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_3.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              ((g_mapped_addr_set_para
                                ((((((st_3.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                                v_1) +
                                (1)))).[e_state_s_granule] :<
                            6)))));
                rely ((true = (true)));
                rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                when st_19 == (
                    (granule_unlock_spec
                      (ret_rtt.(e_2))
                      ((st_6.[share].[globals].[g_granules] :<
                        ((((st_6.(share)).(globals)).(g_granules)) #
                          ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                        (((st_6.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (test_Z_PTE v_3))))))));
                (Some (0, st_19)))
              else (
                when st_5 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_3));
                when st_6 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_5));
                if (((((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (6)) =? (0))
                then (
                  rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                  when st_7 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)))
                        (st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                  rely ((true = (true)));
                  rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                  rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                  when st_19 == (
                      (granule_unlock_spec
                        (ret_rtt.(e_2))
                        ((st_7.[share].[globals].[g_granules] :<
                          ((((st_7.(share)).(globals)).(g_granules)) #
                            ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                          (((st_7.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (test_Z_PTE v_3))))))));
                  (Some (0, st_19)))
                else (
                  when st_7 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_6));
                  if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                  then (
                    rely ((true = (true)));
                    rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    when st_19 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (test_Z_PTE v_3))))))));
                    (Some (0, st_19)))
                  else (
                    when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
                    (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14)))))))
          else (
            when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
            (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13))))
        else (
          if (v_4 =? (1))
          then (
            if ((v_2 =? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
            then (
              if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
              then (
                rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                when st_19 == (
                    (granule_unlock_spec
                      (ret_rtt.(e_2))
                      ((st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                (Some (0, st_19)))
              else (
                when st_3 == (
                    (spinlock_acquire_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                      st_4));
                if (
                  (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                    (6)) =?
                    (0)))
                then (
                  rely (
                    ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                      (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  if (
                    ((g_refcount_para
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                      (st_3.[share].[globals].[g_granules] :<
                        ((((st_3.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))) =?
                      (0)))
                  then (
                    when st_7 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          (st_3.[share].[globals].[g_granules] :<
                            ((((st_3.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (g_mapped_addr_set_para
                                    (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))
                                    0))).[e_state_s_granule] :<
                                0)))));
                    rely ((true = (true)));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    when st_20 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                    (Some (0, st_20)))
                  else (
                    when st_5 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          (st_3.[share].[globals].[g_granules] :<
                            ((((st_3.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (g_mapped_addr_set_para
                                    (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))
                                    0)))))));
                    rely ((true = (true)));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    when st_20 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_5.[share].[globals].[g_granules] :<
                            ((((st_5.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                    (Some (0, st_20))))
                else (
                  when st_5 == (
                      (spinlock_release_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                        st_3));
                  if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                  then (
                    rely ((true = (true)));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                    when st_20 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_5.[share].[globals].[g_granules] :<
                            ((((st_5.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                              (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                    (Some (0, st_20)))
                  else (
                    when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_5));
                    (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))))
            else (
              if ((v_2 <>? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (1))))
              then (
                if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
                then (
                  rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                  rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                  when st_19 == (
                      (granule_unlock_spec
                        (ret_rtt.(e_2))
                        ((st_4.[share].[globals].[g_granules] :<
                          ((((st_4.(share)).(globals)).(g_granules)) #
                            ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                          (((st_4.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                  (Some (0, st_19)))
                else (
                  when st_3 == (
                      (spinlock_acquire_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                        st_4));
                  if (
                    (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                      (6)) =?
                      (0)))
                  then (
                    rely (
                      ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                        (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    if (
                      ((g_refcount_para
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                        (st_3.[share].[globals].[g_granules] :<
                          ((((st_3.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                  ((- 1)))))))) =?
                        (0)))
                    then (
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            (st_3.[share].[globals].[g_granules] :<
                              ((((st_3.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                  ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (g_mapped_addr_set_para
                                      (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))
                                      0))).[e_state_s_granule] :<
                                  0)))));
                      rely ((true = (true)));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                      when st_20 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            ((st_7.[share].[globals].[g_granules] :<
                              ((((st_7.(share)).(globals)).(g_granules)) #
                                ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                      (Some (0, st_20)))
                    else (
                      when st_5 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            (st_3.[share].[globals].[g_granules] :<
                              ((((st_3.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                                (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                  ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (g_mapped_addr_set_para
                                      (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))
                                      0)))))));
                      rely ((true = (true)));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                      when st_20 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            ((st_5.[share].[globals].[g_granules] :<
                              ((((st_5.(share)).(globals)).(g_granules)) #
                                ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_5.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                      (Some (0, st_20))))
                  else (
                    when st_5 == (
                        (spinlock_release_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          st_3));
                    if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                    then (
                      rely ((true = (true)));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                      when st_20 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            ((st_5.[share].[globals].[g_granules] :<
                              ((((st_5.(share)).(globals)).(g_granules)) #
                                ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                                (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                                  ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_5.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                      (Some (0, st_20)))
                    else (
                      when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_5));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))))
              else (
                when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
                (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13)))))
          else (
            when st_12 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
            (Some (0, st_12)))))
      else (
        when st_8 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
        (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_8)))).

  Definition data_create_s1_el1_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (Z * RData)) :=
    None.

  Definition granule_memzero_mapped_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((memset_spec v_0 0 4096 st));
    (Some st_0).

  Definition rtt_create_s1_el1_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr ((rec_to_ttbr1_para v_0 st).(pbase)) ((rec_to_ttbr1_para v_0 st).(poffset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((rec_to_ttbr1_para v_0 st).(poffset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
    then (
      when st_2 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
      if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
      then (
        when ret_record, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (rec_to_ttbr1_para v_0 st) 0 64 v_2 v_3 st_2));
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
            when st_16 == (
                (granule_unlock_spec
                  (ret_record.(e_2))
                  ((st_10.[share].[globals].[g_granules] :<
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
                        5))).[share].[granule_data] :<
                    (((st_10.(share)).(granule_data)) #
                      ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                      ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                        (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                          ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                          (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
            when st_17 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_16));
            ((Some 0), st_17))
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
                then ((Some retval___1), st_10)
                else (
                  rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
                  when st_14 == (
                      (granule_unlock_spec
                        (ret_record.(e_2))
                        ((st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                          (((st_10.(share)).(granule_data)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                            ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
                  when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_14));
                  ((Some 0), st_15))
              | None => None
              end)
            else (
              rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
              when st_14 == (
                  (granule_unlock_spec
                    (ret_record.(e_2))
                    ((st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                      (((st_4.(share)).(granule_data)) #
                        ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                        ((((st_4.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_4.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
              when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_14));
              ((Some 0), st_15))))
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
              then ((Some __retval___0), st_5)
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
                  when st_17 == (
                      (granule_unlock_spec
                        (ret_record.(e_2))
                        ((st_11.[share].[globals].[g_granules] :<
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
                              5))).[share].[granule_data] :<
                          (((st_11.(share)).(granule_data)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                            ((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
                  when st_18 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_17));
                  ((Some 0), st_18))
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
                      then ((Some retval___1), st_11)
                      else (
                        rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
                        when st_15 == (
                            (granule_unlock_spec
                              (ret_record.(e_2))
                              ((st_11.[share].[globals].[g_granules] :<
                                ((((st_11.(share)).(globals)).(g_granules)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                                  (((((st_11.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                                (((st_11.(share)).(granule_data)) #
                                  ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                  ((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
                        when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_15));
                        ((Some 0), st_16))
                    | None => None
                    end)
                  else (
                    rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
                    when st_15 == (
                        (granule_unlock_spec
                          (ret_record.(e_2))
                          ((st_5.[share].[globals].[g_granules] :<
                            ((((st_5.(share)).(globals)).(g_granules)) #
                              ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                              (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                              ((((st_5.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
                    when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_15));
                    ((Some 0), st_16))))
            | None => None
            end)
          else (
            when st_7 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
            when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_7));
            ((Some (pack_struct_return_code_para (make_return_code_para 8))), st_8))))
      else (
        when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_2));
        ((Some (pack_struct_return_code_para (make_return_code_para 1))), st_3)))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr ((rec_to_ttbr1_para v_0 st).(pbase)) ((rec_to_ttbr1_para v_0 st).(poffset))) st_1));
      when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_2));
      if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
      then (
        when ret_record, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (rec_to_ttbr1_para v_0 st) 0 64 v_2 v_3 st_3));
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
            when st_16 == (
                (granule_unlock_spec
                  (ret_record.(e_2))
                  ((st_10.[share].[globals].[g_granules] :<
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
                        5))).[share].[granule_data] :<
                    (((st_10.(share)).(granule_data)) #
                      ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                      ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                        (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                          ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                          (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
            when st_17 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_16));
            ((Some 0), st_17))
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
                then ((Some retval___1), st_10)
                else (
                  rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
                  when st_14 == (
                      (granule_unlock_spec
                        (ret_record.(e_2))
                        ((st_10.[share].[globals].[g_granules] :<
                          ((((st_10.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                            (((((st_10.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                          (((st_10.(share)).(granule_data)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                            ((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_10.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
                  when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_14));
                  ((Some 0), st_15))
              | None => None
              end)
            else (
              rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
              when st_14 == (
                  (granule_unlock_spec
                    (ret_record.(e_2))
                    ((st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                      (((st_4.(share)).(granule_data)) #
                        ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                        ((((st_4.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_4.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
              when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_14));
              ((Some 0), st_15))))
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
              then ((Some __retval___0), st_5)
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
                  when st_17 == (
                      (granule_unlock_spec
                        (ret_record.(e_2))
                        ((st_11.[share].[globals].[g_granules] :<
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
                              5))).[share].[granule_data] :<
                          (((st_11.(share)).(granule_data)) #
                            ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                            ((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
                  when st_18 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_17));
                  ((Some 0), st_18))
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
                      then ((Some retval___1), st_11)
                      else (
                        rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
                        when st_15 == (
                            (granule_unlock_spec
                              (ret_record.(e_2))
                              ((st_11.[share].[globals].[g_granules] :<
                                ((((st_11.(share)).(globals)).(g_granules)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                                  (((((st_11.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                                (((st_11.(share)).(granule_data)) #
                                  ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                                  ((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_11.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
                        when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_15));
                        ((Some 0), st_16))
                    | None => None
                    end)
                  else (
                    rely (((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)));
                    when st_15 == (
                        (granule_unlock_spec
                          (ret_record.(e_2))
                          ((st_5.[share].[globals].[g_granules] :<
                            ((((st_5.(share)).(globals)).(g_granules)) #
                              ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16)) ==
                              (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (4)) / (16))).[e_state_s_granule] :< 5))).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096)) ==
                              ((((st_5.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_record.(e_2)).(poffset)) + ((8 * ((ret_record.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (test_PA v_1) 3 0 0))))))));
                    when st_16 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_15));
                    ((Some 0), st_16))))
            | None => None
            end)
          else (
            when st_7 == ((granule_unlock_spec (ret_record.(e_2)) st_4));
            when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_7));
            ((Some (pack_struct_return_code_para (make_return_code_para 8))), st_8))))
      else (
        when st_4 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_3));
        ((Some (pack_struct_return_code_para (make_return_code_para 1))), st_4))).

  Definition update_ripas_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    when ret == ((update_ripas_spec' v_0 v_1 v_2));
    (Some (ret, st)).

End Layer8_Spec.

Opaque update_ripas_spec'.
#[global] Hint Unfold update_ripas_spec_abs: spec.
#[global] Hint Unfold rtt_create_s1_el1_spec_abs: spec.
#[global] Hint Unfold data_create_s1_el1_0: spec.
#[global] Hint Unfold data_create_s1_el1_spec_abs: spec.
#[global] Hint Unfold granule_memzero_spec: spec.
#[global] Hint Unfold map_unmap_ns_s1_0: spec.
#[global] Hint Unfold map_unmap_ns_s1_1: spec.
#[global] Hint Unfold map_unmap_ns_s1_2: spec.
#[global] Hint Unfold map_unmap_ns_s1_3: spec.
#[global] Hint Unfold map_unmap_ns_s1_spec: spec.
#[global] Hint Unfold data_create_s1_el1_spec: spec.
#[global] Hint Unfold granule_memzero_mapped_spec: spec.
#[global] Hint Unfold rtt_create_s1_el1_spec: spec.
#[global] Hint Unfold update_ripas_spec: spec.
