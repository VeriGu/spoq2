Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_smc_granule_delegate_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_granule_delegate_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((find_lock_granule_spec v_0 0 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_5, st_1)))
    else (
      when st_1 == ((granule_set_state_spec v_3 1 st_0));
      when v_7, st_2 == ((set_pas_realm_spec v_0 st_1));
      when st_3 == ((clear_tte_ns_spec v_0 st_2));
      if (v_7 =? (0))
      then (
        when st_4 == ((granule_memzero_spec v_3 1 st_3));
        when st_6 == ((granule_unlock_spec v_3 st_4));
        (Some (0, st_6)))
      else (
        when st_5 == ((granule_unlock_spec v_3 st_3));
        when v_12, st_6 == ((pack_return_code_spec 1 1 st_5));
        (Some (v_12, st_6)))).

End Layer9_smc_granule_delegate_LowSpec.

#[global] Hint Unfold smc_granule_delegate_spec_low: spec.
