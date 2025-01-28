Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_validate_rmm_feature_register_0_value_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_rmm_feature_register_0_value_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    when v_2, st_0 == ((rmm_feature_register_0_value_spec st));
    if (((v_0 & (255)) - ((v_2 & (255)))) >? (0))
    then (Some (false, st_0))
    else (
      if ((v_0 & (256)) =? (0))
      then (Some (true, st_0))
      else (Some (false, st_0))).

End Layer10_validate_rmm_feature_register_0_value_LowSpec.

#[global] Hint Unfold validate_rmm_feature_register_0_value_spec_low: spec.
