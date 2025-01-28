Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_timer_condition_met_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition timer_condition_met_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (5)) =? (5)), st)).

End Layer9_timer_condition_met_LowSpec.

#[global] Hint Unfold timer_condition_met_spec_low: spec.
