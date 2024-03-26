Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers___granule_refcount_dec_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __granule_refcount_dec_spec_low (v_g: Ptr) (v_val: Z) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    let v_refcount := (ptr_offset v_g ((16 * (0)) + ((8 + (0))))) in
    when v_0, st == ((load_RData 8 v_refcount st));
    let v_sub := (v_0 - (512)) in
    when st == ((store_RData 8 v_refcount v_sub st));
    let __return__ := true in
    (Some st).

End Helpers___granule_refcount_dec_LowSpec.

#[global] Hint Unfold __granule_refcount_dec_spec_low: spec.
