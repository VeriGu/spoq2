Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_validate_rmm_feature_register_value_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_rmm_feature_register_value_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if (v_0 =? (0))
    then (
      when v_4, st_0 == ((validate_rmm_feature_register_0_value_spec v_1 st));
      (Some (v_4, st_0)))
    else (Some (false, st)).

End Layer11_validate_rmm_feature_register_value_LowSpec.

#[global] Hint Unfold validate_rmm_feature_register_value_spec_low: spec.
