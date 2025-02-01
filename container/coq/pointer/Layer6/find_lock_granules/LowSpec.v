Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_find_lock_granules_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_granules_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    None.

End Layer6_find_lock_granules_LowSpec.

#[global] Hint Unfold find_lock_granules_spec_low: spec.
