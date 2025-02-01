Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_find_lock_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_granule_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    None.

End Layer5_find_lock_granule_LowSpec.

#[global] Hint Unfold find_lock_granule_spec_low: spec.
