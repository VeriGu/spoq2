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

  Definition granule_memzero_mapped_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((memset_spec v_0 0 4096 st));
    (Some st_0).

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
    ((Some v_7), st_2).

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

End Layer8_Spec.

#[global] Hint Unfold granule_memzero_mapped_spec: spec.
#[global] Hint Unfold update_ripas_spec_abs: spec.
#[global] Hint Unfold rtt_create_s1_el1_spec_abs: spec.
#[global] Hint Unfold data_create_s1_el1_0: spec.
#[global] Hint Unfold data_create_s1_el1_spec_abs: spec.
