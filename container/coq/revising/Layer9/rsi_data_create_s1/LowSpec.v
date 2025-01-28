Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_create_s1_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_create_s1_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
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

End Layer9_rsi_data_create_s1_LowSpec.

#[global] Hint Unfold rsi_data_create_s1_spec_low: spec.
