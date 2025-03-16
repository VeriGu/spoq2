Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_g_refcount_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition g_refcount_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    let v_2 := (ptr_offset v_0 ((16 * (0)) + ((8 + ((0 + (0))))))) in
    when v_3, st == ((load_RData 8 v_2 st));
    let v_4 := (v_3 & (4095)) in
    let __return__ := true in
    let __retval__ := v_4 in
    (Some (__retval__, st)).

End Layer6_g_refcount_LowSpec.

#[global] Hint Unfold g_refcount_spec_low: spec.
