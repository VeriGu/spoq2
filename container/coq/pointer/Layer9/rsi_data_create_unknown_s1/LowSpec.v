Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_create_unknown_s1_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_create_unknown_s1_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    let v_0_pte := (test_Z_PTE v_0) in
    let v_1_pa := (test_PA v_1) in
    when v_4, st_0 == ((s1tte_pa_spec_abs v_0_pte st));
    if (check_rcsm_mask_para v_1_pa)
    then (
      when v_10, st_1 == ((find_lock_granule_spec_abs v_4 1 st_0));
      rely (((((v_10.(poffset)) mod (16)) = (0)) /\ (((v_10.(poffset)) >= (0)))));
      rely ((((v_10.(pbase)) = ("granules")) \/ (((v_10.(pbase)) = ("null")))));
      if (ptr_eqb v_10 (mkPtr "null" 0))
      then (
        when v_12, st_2 == ((pack_return_code_spec 1 1 st_1));
        (Some (v_12, st_2)))
      else (
        when v_15, st_2 == ((find_lock_granule_spec_abs v_1_pa 5 st_1));
        rely (((((v_15.(poffset)) mod (16)) = (0)) /\ (((v_15.(poffset)) >= (0)))));
        rely ((((v_15.(pbase)) = ("granules")) \/ (((v_15.(pbase)) = ("null")))));
        if (ptr_eqb v_15 (mkPtr "null" 0))
        then (
          when v_17, st_3 == ((pack_return_code_spec 1 2 st_2));
          (Some (v_17, st_3)))
        else (
          when v_20, st_3 == ((data_create_internal_spec_abs v_0_pte v_15 v_2 (mkPtr "null" 0) (mkPtr "null" 0) 0 st_2));
          if (v_20 =? (0))
          then (
            when st_5 == ((granule_unlock_transition_spec v_10 4 st_3));
            (Some (v_20, st_5)))
          else (
            when st_5 == ((granule_unlock_transition_spec v_10 1 st_3));
            (Some (v_20, st_5))))))
    else (
      when v_8, st_1 == ((data_create_s1_el1_spec_abs v_0_pte v_1_pa v_2 (mkPtr "null" 0) st_0));
      (Some (v_8, st_1))).

End Layer9_rsi_data_create_unknown_s1_LowSpec.

#[global] Hint Unfold rsi_data_create_unknown_s1_spec_low: spec.
