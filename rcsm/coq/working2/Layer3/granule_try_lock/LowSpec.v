Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer3.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer3_granule_try_lock_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_try_lock_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when st_0 == ((spinlock_acquire_spec (ptr_offset v_0 0) st));
    when v_4, st_1 == ((granule_get_state_spec v_0 st_0));
    if ((v_4 - (v_1)) =? (0))
    then (Some (true, st_1))
    else (
      when st_2 == ((spinlock_release_spec (ptr_offset v_0 0) st_1));
      (Some (false, st_2))).

End Layer3_granule_try_lock_LowSpec.

#[global] Hint Unfold granule_try_lock_spec_low: spec.
