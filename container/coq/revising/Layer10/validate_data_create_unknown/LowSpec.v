Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_validate_data_create_unknown_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_data_create_unknown_spec_low (v_0: Z) (v_1: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((is_addr_in_par_spec v_1 v_0 st));
    if v_3
    then (
      when v_7, st_1 == ((validate_map_addr_spec v_0 3 v_1 st_0));
      if (v_7 =? (0))
      then (
        when v_11, st_2 == ((make_return_code_spec 0 0 st_1));
        (Some (v_11, st_2)))
      else (
        when v_9, st_2 == ((make_return_code_spec 1 3 st_1));
        (Some (v_9, st_2))))
    else (
      when v_5, st_1 == ((make_return_code_spec 1 3 st_0));
      (Some (v_5, st_1))).

End Layer10_validate_data_create_unknown_LowSpec.

#[global] Hint Unfold validate_data_create_unknown_spec_low: spec.
