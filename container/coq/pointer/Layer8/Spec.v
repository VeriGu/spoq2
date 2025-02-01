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

  Definition update_ripas_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_1 <? (3)) && ((((test_Ptr_PTE v_0).(meta_desc_type)) =? (3))))
    then (Some (false, st))
    else (
      if ((v_1 =? (3)) && ((((test_Ptr_PTE v_0).(meta_desc_type)) =? (3))))
      then (Some (true, st))
      else (
        if ((v_1 <>? (3)) && ((((test_Ptr_PTE v_0).(meta_desc_type)) =? (1))))
        then (Some (true, st))
        else (
          if (((((test_Ptr_PTE v_0).(meta_desc_type)) =? (0)) && ((((test_Ptr_PTE v_0).(meta_ripas)) =? (0)))) && ((((test_Ptr_PTE v_0).(meta_mem_attr)) =? (0))))
          then (Some (true, st))
          else (
            if (((((test_Ptr_PTE v_0).(meta_desc_type)) =? (0)) && ((((test_Ptr_PTE v_0).(meta_ripas)) =? (0)))) && ((((test_Ptr_PTE v_0).(meta_mem_attr)) =? (1))))
            then (Some (true, st))
            else (Some (false, st)))))).

End Layer8_Spec.

#[global] Hint Unfold update_ripas_spec_abs: spec.
#[global] Hint Unfold rtt_create_s1_el1_spec_abs: spec.
#[global] Hint Unfold update_ripas_spec: spec.
