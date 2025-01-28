Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_timer_output_is_asserted_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition timer_output_is_asserted_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    when v_2, st_0 == ((timer_is_masked_spec v_0 st));
    if v_2
    then (Some (false, st_0))
    else (
      when v_4, st_1 == ((timer_condition_met_spec v_0 st_0));
      (Some (v_4, st_1))).

End Layer10_timer_output_is_asserted_LowSpec.

#[global] Hint Unfold timer_output_is_asserted_spec_low: spec.
