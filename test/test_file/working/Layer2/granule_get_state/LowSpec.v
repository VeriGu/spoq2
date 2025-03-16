Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2_granule_get_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_get_state_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    let v_2 := (ptr_offset v_0 ((16 * (0)) + ((4 + (0))))) in
    when v_3, st == ((load_RData 4 v_2 st));
    let __return__ := true in
    let __retval__ := v_3 in
    (Some (__retval__, st)).

End Layer2_granule_get_state_LowSpec.

#[global] Hint Unfold granule_get_state_spec_low: spec.
