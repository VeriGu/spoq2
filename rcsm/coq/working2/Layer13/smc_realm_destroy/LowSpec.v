Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer12.Spec.
Require Import Layer2.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_realm_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_realm_destroy_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((find_lock_unused_granule_spec v_0 2 st));
    when v_4, st_1 == ((ptr_is_err_spec v_2 st_0));
    if v_4
    then (
      when v_6, st_2 == ((ptr_status_spec v_2 st_1));
      if (v_6 =? (1))
      then (
        when v_9, st_3 == ((pack_return_code_spec 1 1 st_2));
        (Some (v_9, st_3)))
      else (Some (v_6, st_2)))
    else (
      when v_13, st_2 == ((granule_map_spec v_2 2 st_1));
      when v_16_tmp, st_3 == ((load_RData 8 (ptr_offset v_13 32) st_2));
      when v_19, st_4 == ((load_RData 4 (ptr_offset v_13 24) st_3));
      when v_22, st_5 == ((load_RData 4 (ptr_offset v_13 40) st_4));
      when st_6 == ((vmid_free_spec v_22 st_5));
      when v_23, st_7 == ((total_root_rtt_refcount_spec (int_to_ptr v_16_tmp) v_19 st_6));
      if (v_23 =? (0))
      then (
        when st_8 == ((free_sl_rtts_spec (int_to_ptr v_16_tmp) v_19 true st_7));
        when st_9 == ((granule_memzero_spec v_2 2 st_8));
        when st_10 == ((granule_unlock_transition_spec v_2 1 st_9));
        (Some (0, st_10)))
      else (
        when st_8 == ((granule_unlock_spec v_2 st_7));
        when v_25, st_9 == ((pack_return_code_spec 4 0 st_8));
        (Some (v_25, st_9)))).

End Layer13_smc_realm_destroy_LowSpec.

#[global] Hint Unfold smc_realm_destroy_spec_low: spec.
