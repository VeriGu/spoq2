Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleInfo_granule_unlock_transition_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_unlock_transition_spec_low (v_g: Ptr) (v_new_state: Z) (st: RData) : (option RData) :=
    when st_0 == ((granule_set_state_spec v_g v_new_state st));
    when st_1 == ((granule_unlock_spec v_g st_0));
    (Some st_1).

End GranuleInfo_granule_unlock_transition_LowSpec.

#[global] Hint Unfold granule_unlock_transition_spec_low: spec.
