Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_smc_granule_undelegate_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_granule_undelegate_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((find_lock_granule_spec v_0 1 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_5, st_1)))
    else (
      when st_1 == ((set_pas_ns_spec v_0 st_0));
      when st_2 == ((granule_set_state_spec v_3 0 st_1));
      when st_3 == ((set_tte_ns_spec v_0 st_2));
      when st_4 == ((granule_unlock_spec v_3 st_3));
      (Some (0, st_4))).

End Layer9_smc_granule_undelegate_LowSpec.

#[global] Hint Unfold smc_granule_undelegate_spec_low: spec.
