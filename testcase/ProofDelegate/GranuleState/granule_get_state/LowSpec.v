Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleState_granule_get_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_get_state_spec_low (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    let v_state := (ptr_offset v_g ((16 * (0)) + ((4 + (0))))) in
    when v_0, st == ((load_RData 4 v_state st));
    let __return__ := true in
    let __retval__ := v_0 in
    (Some (__retval__, st)).

End GranuleState_granule_get_state_LowSpec.

#[global] Hint Unfold granule_get_state_spec_low: spec.
