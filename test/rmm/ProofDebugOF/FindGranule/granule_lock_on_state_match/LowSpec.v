Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section FindGranule_granule_lock_on_state_match_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_lock_on_state_match_spec_low (v_g: Ptr) (v_expected_state: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) = (0)));
    rely ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_g.(pbase)) = ("granules")));
    when st_0 == ((spinlock_acquire_spec (ptr_offset v_g 0) st));
    when v_call, st_1 == ((granule_get_state_spec v_g st_0));
    if ((v_call - (v_expected_state)) =? (0))
    then (Some (true, st_1))
    else (
      when st_2 == ((spinlock_release_spec (ptr_offset v_g 0) st_1));
      (Some (false, st_2))).

End FindGranule_granule_lock_on_state_match_LowSpec.

#[global] Hint Unfold granule_lock_on_state_match_spec_low: spec.
