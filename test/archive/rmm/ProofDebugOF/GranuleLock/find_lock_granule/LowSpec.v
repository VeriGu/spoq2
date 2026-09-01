Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Spec.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleLock_find_lock_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_granule_spec_low (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st_0 == ((find_granule_spec v_addr st));
    if (ptr_eqb v_call (mkPtr "null" 0))
    then (Some ((mkPtr "null" 0), st_0))
    else (
      when v_call1, st_1 == ((granule_lock_on_state_match_spec v_call v_expected_state st_0));
      if v_call1
      then (Some (v_call, st_1))
      else (Some ((mkPtr "null" 0), st_1))).

End GranuleLock_find_lock_granule_LowSpec.

#[global] Hint Unfold find_lock_granule_spec_low: spec.
