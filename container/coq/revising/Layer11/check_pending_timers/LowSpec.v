Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_check_pending_timers_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition check_pending_timers_spec_low (v_0: Ptr) (st: RData) : (option (bool * RData)) :=
    when v_2, st_0 == ((iasm_6_spec st));
    when v_3, st_1 == ((iasm_7_spec st_0));
    when v_4, st_2 == ((timer_output_is_asserted_spec v_2 st_1));
    when v_6, st_3 == ((load_RData 8 (ptr_offset v_0 568) st_2));
    when v_7, st_4 == ((timer_output_is_asserted_spec v_6 st_3));
    if (xorb v_4 v_7)
    then (Some (true, st_4))
    else (
      when v_10, st_5 == ((timer_output_is_asserted_spec v_3 st_4));
      when v_12, st_6 == ((load_RData 8 (ptr_offset v_0 552) st_5));
      when v_13, st_7 == ((timer_output_is_asserted_spec v_12 st_6));
      (Some ((xorb v_10 v_13), st_7))).

End Layer11_check_pending_timers_LowSpec.

#[global] Hint Unfold check_pending_timers_spec_low: spec.
