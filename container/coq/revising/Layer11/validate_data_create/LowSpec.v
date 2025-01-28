Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_validate_data_create_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_data_create_spec_low (v_0: Z) (v_1: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((get_rd_state_locked_spec v_1 st));
    if (v_3 =? (0))
    then (
      when v_7, st_1 == ((validate_data_create_unknown_spec v_0 v_1 st_0));
      (Some (v_7, st_1)))
    else (
      when v_5, st_1 == ((make_return_code_spec 5 0 st_0));
      (Some (v_5, st_1))).

End Layer11_validate_data_create_LowSpec.

#[global] Hint Unfold validate_data_create_spec_low: spec.
