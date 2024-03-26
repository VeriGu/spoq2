Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleState_granule_set_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_set_state_spec_low (v_g: Ptr) (v_state: Z) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    let v_state1 := (ptr_offset v_g ((16 * (0)) + ((4 + (0))))) in
    when st == ((store_RData 4 v_state1 v_state st));
    let __return__ := true in
    (Some st).

End GranuleState_granule_set_state_LowSpec.

#[global] Hint Unfold granule_set_state_spec_low: spec.
