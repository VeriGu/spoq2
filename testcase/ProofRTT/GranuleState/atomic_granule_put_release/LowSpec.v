Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleState_atomic_granule_put_release_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition atomic_granule_put_release_spec_low (v_g: Ptr) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    let v_refcount := (ptr_offset v_g ((16 * (0)) + ((8 + (0))))) in
    when v_call, st == ((atomic_load_add_release_64_spec v_refcount (- 1) st));
    let __return__ := true in
    (Some st).

End GranuleState_atomic_granule_put_release_LowSpec.

#[global] Hint Unfold atomic_granule_put_release_spec_low: spec.
