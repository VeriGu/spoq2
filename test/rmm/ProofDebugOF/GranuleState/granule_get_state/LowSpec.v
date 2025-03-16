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
    when v_0, st_0 == ((load_RData 4 (ptr_offset v_g 4) st));
    (Some (v_0, st_0)).

End GranuleState_granule_get_state_LowSpec.

#[global] Hint Unfold granule_get_state_spec_low: spec.
