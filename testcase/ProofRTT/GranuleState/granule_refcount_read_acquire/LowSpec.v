Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleState_granule_refcount_read_acquire_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_refcount_read_acquire_spec_low (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    let v_refcount := (ptr_offset v_g ((16 * (0)) + ((8 + (0))))) in
    when v_call, st == ((__sca_read64_acquire_spec v_refcount st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End GranuleState_granule_refcount_read_acquire_LowSpec.

#[global] Hint Unfold granule_refcount_read_acquire_spec_low: spec.
