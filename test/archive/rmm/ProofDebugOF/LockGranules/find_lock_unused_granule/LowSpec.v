Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section LockGranules_find_lock_unused_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_unused_granule_spec_low (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st_0 == ((find_lock_granule_spec v_addr v_expected_state st));
    if (ptr_eqb v_call (mkPtr "null" 0))
    then (
      when v_call1, st_1 == ((status_ptr_spec 1 st_0));
      (Some (v_call1, st_1)))
    else (
      when v_call2, st_1 == ((granule_refcount_read_acquire_spec v_call st_0));
      if (v_call2 =? (0))
      then (Some (v_call, st_1))
      else (
        when st_2 == ((granule_unlock_spec v_call st_1));
        when v_call4, st_3 == ((status_ptr_spec 5 st_2));
        (Some (v_call4, st_3)))).

End LockGranules_find_lock_unused_granule_LowSpec.

#[global] Hint Unfold find_lock_unused_granule_spec_low: spec.
