Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_smc_granule_any_to_ns_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_granule_any_to_ns_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    when v_2, st_0 == ((find_lock_granule_spec v_0 6 st));
    rely (((((v_2.(poffset)) mod (16)) = (0)) /\ (((v_2.(poffset)) >= (0)))));
    rely ((((v_2.(pbase)) = ("granules")) \/ (((v_2.(pbase)) = ("null")))));
    if (ptr_eqb v_2 (mkPtr "null" 0))
    then (
      when v_4, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_4, st_1)))
    else (
      when st_1 == ((__granule_put_spec v_2 st_0));
      when v_7, st_2 == ((g_refcount_spec v_2 st_1));
      if (v_7 =? (0))
      then (
        when st_3 == ((set_pas_any_to_ns_spec v_0 st_2));
        when st_4 == ((granule_set_state_spec v_2 0 st_3));
        when st_6 == ((g_mapped_addr_set_spec v_2 0 st_4));
        when st_7 == ((granule_unlock_spec v_2 st_6));
        (Some (0, st_7)))
      else (
        when st_4 == ((g_mapped_addr_set_spec v_2 0 st_2));
        when st_5 == ((granule_unlock_spec v_2 st_4));
        (Some (0, st_5)))).

End Layer7_smc_granule_any_to_ns_LowSpec.

#[global] Hint Unfold smc_granule_any_to_ns_spec_low: spec.
