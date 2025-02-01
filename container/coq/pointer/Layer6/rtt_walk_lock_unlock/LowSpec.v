Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_rtt_walk_lock_unlock_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rtt_walk_lock_unlock_spec_low (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option RData) :=
    None.

End Layer6_rtt_walk_lock_unlock_LowSpec.

#[global] Hint Unfold rtt_walk_lock_unlock_spec_low: spec.
