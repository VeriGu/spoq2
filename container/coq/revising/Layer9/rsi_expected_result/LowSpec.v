Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_expected_result_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_expected_result_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_0 =? (3221225482)) || ((v_0 =? (3221225491))))
    then (
      if (v_0 =? (3221225482))
      then (Some (false, st))
      else (
        when v_4, st_0 == ((pack_return_code_spec 9 1234 st));
        (Some (((v_4 - (v_1)) =? (0)), st_0))))
    else (
      when v_8, st_1 == ((pack_return_code_spec 8 0 st));
      (Some (((v_8 - (v_1)) =? (0)), st_1))).

End Layer9_rsi_expected_result_LowSpec.

#[global] Hint Unfold rsi_expected_result_spec_low: spec.
