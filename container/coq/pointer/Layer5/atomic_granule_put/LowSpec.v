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
    when v, st_1 == ((load_RData 64 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) st));
    when st_2 == ((store_RData 64 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) (v + ((- 1))) st_1));
    (Some st_2).

End Layer5_atomic_granule_put_LowSpec.

#[global] Hint Unfold atomic_granule_put_spec_low: spec.
