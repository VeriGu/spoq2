Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_atomic_granule_put_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition atomic_granule_put_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    let v_2 := (ptr_offset v_0 ((16 * (0)) + ((8 + ((0 + (0))))))) in
    when st == ((atomic_add_64_spec v_2 (- 1) st));
    let __return__ := true in
    (Some st).

End Layer5_atomic_granule_put_LowSpec.

#[global] Hint Unfold atomic_granule_put_spec_low: spec.
