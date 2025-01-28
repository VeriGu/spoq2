Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_smc_granule_ns_to_any_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_granule_ns_to_any_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - (4294967296)) < (0)))) \/ ((((v_1 - (MEM1_PHYS)) >= (0)) /\ (((v_1 - (556198264832)) < (0)))))) /\
        (((v_1 & (4095)) = (0)))));
    when v_3, st_0 == ((find_lock_granule_spec v_1 0 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((find_lock_granule_spec v_1 6 st_0));
      rely (((((v_5.(poffset)) mod (16)) = (0)) /\ (((v_5.(poffset)) >= (0)))));
      rely ((((v_5.(pbase)) = ("granules")) \/ (((v_5.(pbase)) = ("null")))));
      if (ptr_eqb v_5 (mkPtr "null" 0))
      then (
        when v_7, st_2 == ((pack_return_code_spec 1 1 st_1));
        (Some (v_7, st_2)))
      else (
        when st_3 == ((__granule_get_spec v_5 st_1));
        when st_4 == ((granule_unlock_spec v_5 st_3));
        (Some (0, st_4))))
    else (
      when st_1 == ((set_pas_ns_to_any_spec v_1 st_0));
      when st_2 == ((granule_set_state_spec v_3 6 st_1));
      when st_3 == ((g_mapped_addr_set_spec v_3 v_0 st_2));
      when st_5 == ((__granule_get_spec v_3 st_3));
      when st_6 == ((granule_unlock_spec v_3 st_5));
      (Some (0, st_6))).

End Layer7_smc_granule_ns_to_any_LowSpec.

#[global] Hint Unfold smc_granule_ns_to_any_spec_low: spec.
