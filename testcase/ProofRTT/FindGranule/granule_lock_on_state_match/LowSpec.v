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
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    let v_lock := (ptr_offset v_g ((16 * (0)) + ((0 + (0))))) in
    when st == ((spinlock_acquire_spec v_lock st));
    when v_call, st == ((granule_get_state_spec v_g st));
    let v_cmp_not := (v_call =? (v_expected_state)) in
    when st == (
        if v_cmp_not
        then (Some st)
        else (
          when st == ((spinlock_release_spec v_lock st));
          (Some st)));
    let __return__ := true in
    let __retval__ := v_cmp_not in
    (Some (__retval__, st)).

End FindGranule_granule_lock_on_state_match_LowSpec.

#[global] Hint Unfold granule_lock_on_state_match_spec_low: spec.
