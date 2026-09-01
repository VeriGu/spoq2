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
    let v_3 := (ptr_offset v_0 ((16 * (0)) + ((0 + (0))))) in
    when st == ((spinlock_acquire_spec v_3 st));
    when v_4, st == ((granule_get_state_spec v_0 st));
    let v__not := (v_4 =? (v_1)) in
    when st == (
        if v__not
        then (Some st)
        else (
          when st == ((spinlock_release_spec v_3 st));
          (Some st)));
    let __return__ := true in
    let __retval__ := v__not in
    (Some (__retval__, st)).

End Layer3_granule_try_lock_LowSpec.

#[global] Hint Unfold granule_try_lock_spec_low: spec.
