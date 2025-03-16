Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer4_granule_lock_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_lock_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    (Some st).

End Layer4_granule_lock_LowSpec.

#[global] Hint Unfold granule_lock_spec_low: spec.
