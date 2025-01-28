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
    when v_3, st_0 == ((__sca_read64_acquire_spec (ptr_offset v_0 8) st));
    (Some ((v_3 & (4095)), st_0)).

End Layer10_granule_refcount_read_acquire_LowSpec.

#[global] Hint Unfold granule_refcount_read_acquire_spec_low: spec.
