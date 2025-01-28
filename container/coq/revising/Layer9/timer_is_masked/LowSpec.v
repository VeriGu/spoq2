Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_timer_is_masked_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition timer_is_masked_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (2)) <>? (0)), st)).

End Layer9_timer_is_masked_LowSpec.

#[global] Hint Unfold timer_is_masked_spec_low: spec.
