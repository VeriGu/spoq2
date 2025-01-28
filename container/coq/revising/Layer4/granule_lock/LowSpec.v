Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer3.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer4_granule_lock_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_lock_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when v_3, st_0 == ((granule_try_lock_spec v_0 v_1 st));
    (Some st_0).

End Layer4_granule_lock_LowSpec.

#[global] Hint Unfold granule_lock_spec_low: spec.
