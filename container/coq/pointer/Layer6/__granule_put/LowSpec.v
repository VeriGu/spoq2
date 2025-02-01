Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6___granule_put_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __granule_put_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_1 == ((atomic_add_64 (ptr_offset v_0 8) (- 1) st));
    (Some st_1).

End Layer6___granule_put_LowSpec.

#[global] Hint Unfold __granule_put_spec_low: spec.
