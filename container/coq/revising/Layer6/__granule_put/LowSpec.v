Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6___granule_put_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __granule_put_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_0 == ((atomic_granule_put_spec v_0 st));
    (Some st_0).

End Layer6___granule_put_LowSpec.

#[global] Hint Unfold __granule_put_spec_low: spec.
