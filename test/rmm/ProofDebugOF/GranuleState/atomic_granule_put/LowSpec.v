Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleState_atomic_granule_put_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition atomic_granule_put_spec_low (v_g: Ptr) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    when st_0 == ((atomic_add_64_spec (ptr_offset v_g 8) (- 1) st));
    (Some st_0).

End GranuleState_atomic_granule_put_LowSpec.

#[global] Hint Unfold atomic_granule_put_spec_low: spec.
