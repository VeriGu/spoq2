Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_granule_set_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_set_state_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))) /\ ((v_1 >= (0)))) /\ ((v_1 <= (6)))));
    let v_3 := (ptr_offset v_0 ((16 * (0)) + ((4 + (0))))) in
    when st == ((store_RData 4 v_3 v_1 st));
    let __return__ := true in
    (Some st).

End Layer6_granule_set_state_LowSpec.

#[global] Hint Unfold granule_set_state_spec_low: spec.
