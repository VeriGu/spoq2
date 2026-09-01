Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_granule_refcount_read_acquire_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_refcount_read_acquire_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (16)) = (0)))));
    let v_2 := (ptr_offset v_0 ((16 * (0)) + ((8 + ((0 + (0))))))) in
    when v_3, st == ((__sca_read64_acquire_spec v_2 st));
    let v_4 := (v_3 & (4095)) in
    let __return__ := true in
    let __retval__ := v_4 in
    (Some (__retval__, st)).

End Layer10_granule_refcount_read_acquire_LowSpec.

#[global] Hint Unfold granule_refcount_read_acquire_spec_low: spec.
