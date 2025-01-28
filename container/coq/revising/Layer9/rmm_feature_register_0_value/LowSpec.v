Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rmm_feature_register_0_value_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rmm_feature_register_0_value_spec_low (st: RData) : (option (Z * RData)) :=
    when v_1, st_0 == ((max_pa_size_spec st));
    (Some (v_1, st_0)).

End Layer9_rmm_feature_register_0_value_LowSpec.

#[global] Hint Unfold rmm_feature_register_0_value_spec_low: spec.
