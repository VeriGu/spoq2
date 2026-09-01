Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_refcount_read_acquire_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (16)) = (0)))));
    when v_3, st_0 == (
        let (ptr, st_0) := ((mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))), st) in
        (load_RData 64 ptr st_0));
    (Some ((v_3 & (4095)), st_0)).

End Layer10_Spec.

#[global] Hint Unfold granule_refcount_read_acquire_spec: spec.
