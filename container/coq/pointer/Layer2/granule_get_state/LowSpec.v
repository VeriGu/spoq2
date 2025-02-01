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
    when v_3, st_0 == ((load_RData 4 (ptr_offset v_0 4) st));
    (Some (v_3, st_0)).

End Layer2_granule_get_state_LowSpec.

#[global] Hint Unfold granule_get_state_spec_low: spec.
