Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers___granule_put_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __granule_put_spec_low (v_g: Ptr) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    let v_refcount := (ptr_offset v_g ((16 * (0)) + ((8 + (0))))) in
    when v_0, st == ((load_RData 8 v_refcount st));
    let v_dec := (v_0 + ((- 1))) in
    when st == ((store_RData 8 v_refcount v_dec st));
    let __return__ := true in
    (Some st).

End Helpers___granule_put_LowSpec.

#[global] Hint Unfold __granule_put_spec_low: spec.
