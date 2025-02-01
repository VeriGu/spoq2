Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_data_create_s1_el1_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition data_create_s1_el1_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (Z * RData)) :=
    let v_0_pte := (test_Z_PTE v_0) in
    let v_1_pa := (test_PA v_1) in
    when st_0 == ((new_frame "data_create_s1_el1" st));
    rely (((((v_3.(pbase)) = ("granules")) /\ ((((v_3.(poffset)) mod (16)) = (0)))) /\ (((v_3.(poffset)) >= (0)))));
    when v_7, st_1 == ((s1tte_pa_spec_abs v_0_pte st_0));
    when ret_2ptr, st_2 == ((find_lock_two_granules_spec_abs v_7 1 (mkPtr "stack_type_4" 0) v_1_pa 3 (mkPtr "stack_type_4__1" 0) st_1));
    let ret_1 := (ret_2ptr.(e_1)) in
    let ret_2 := (ret_2ptr.(e_2)) in
    if ((ret_1.(pbase)) =s ("null"))
    then (
      when v_11, st_3 == ((pack_return_code_spec 3 0 st_2));
      when st_5 == ((free_stack "data_create_s1_el1" st_0 st_3));
      (Some (v_11, st_5)))
    else (
      let v_19 := ret_2 in
      when v_20, st_4 == ((granule_map_spec v_19 3 st_2));
      let v_24 := (rec_to_ttbr1_para v_20 st_4) in
      when st_6 == ((granule_lock_spec v_24 5 st_4));
      when v_25, st_7 == ((data_create_internal_spec_abs v_0_pte v_24 v_2 v_3 v_20 1 st_6));
      if (v_25 =? (0))
      then (data_create_s1_el1_0 st_0 st_7 v_25 ret_1 ret_2)
      else (
        let v_29 := ret_2 in
        when st_10 == ((granule_unlock_spec v_29 st_7));
        let v_30 := ret_1 in
        when st_12 == ((granule_unlock_transition_spec v_30 1 st_10));
        when st_15 == ((free_stack "data_create_s1_el1" st_0 st_12));
        (Some (v_25, st_15)))).

End Layer8_data_create_s1_el1_LowSpec.

#[global] Hint Unfold data_create_s1_el1_spec_low: spec.
