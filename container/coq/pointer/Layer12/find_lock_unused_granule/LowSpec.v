Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.
Require Import Layer11.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_find_lock_unused_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_unused_granule_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_3, st_0 == ((find_lock_granule_spec v_0 v_1 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((status_ptr_spec 1 st_0));
      (Some (v_5, st_1)))
    else (
      when v_8, st_1 == ((granule_refcount_read_acquire_spec v_3 st_0));
      if (v_8 =? (0))
      then (Some (v_3, st_1))
      else (
        when st_2 == ((granule_unlock_spec v_3 st_1));
        when v_10, st_3 == ((status_ptr_spec 4 st_2));
        (Some (v_10, st_3)))).

End Layer12_find_lock_unused_granule_LowSpec.

#[global] Hint Unfold find_lock_unused_granule_spec_low: spec.
