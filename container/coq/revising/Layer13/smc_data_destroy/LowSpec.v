Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_data_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_data_destroy_0_low (st_0: RData) (st_15: RData) (v_25: Ptr) (v_28: Z) (v_29: bool) (v__sroa_016_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_29 = (true)));
    when v_33, st_16 == ((s2tte_pa_spec v_28 3 st_15));
    when st_17 == ((__tte_write_spec (ptr_offset v_25 (8 * (v__sroa_4_0_copyload))) 8 st_16));
    when st_18 == ((__granule_put_spec (int_to_ptr v__sroa_016_0_copyload_tmp) st_17));
    when v_34, st_19 == ((find_lock_granule_spec v_33 4 st_18));
    rely (((((v_34.(poffset)) mod (16)) = (0)) /\ (((v_34.(poffset)) >= (0)))));
    rely ((((v_34.(pbase)) = ("granules")) \/ (((v_34.(pbase)) = ("null")))));
    when st_20 == ((granule_memzero_spec v_34 1 st_19));
    when st_21 == ((granule_unlock_transition_spec v_34 1 st_20));
    when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_016_0_copyload_tmp) st_21));
    when st_27 == ((free_stack "smc_data_destroy" st_0 st_24));
    (Some (0, st_27)).

  Definition smc_data_destroy_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_data_destroy" st));
    when v_4, st_1 == ((find_lock_granule_spec v_0 2 st_0));
    rely (((((v_4.(poffset)) mod (16)) = (0)) /\ (((v_4.(poffset)) >= (0)))));
    rely ((((v_4.(pbase)) = ("granules")) \/ (((v_4.(pbase)) = ("null")))));
    if (ptr_eqb v_4 (mkPtr "null" 0))
    then (
      when v_6, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "smc_data_destroy" st_0 st_2));
      (Some (v_6, st_4)))
    else (
      when v_9, st_2 == ((granule_map_spec v_4 2 st_1));
      when v_11, st_3 == ((validate_map_addr_spec v_1 3 v_9 st_2));
      if (v_11 =? (0))
      then (
        when v_18_tmp, st_4 == ((load_RData 8 (ptr_offset v_9 32) st_3));
        when v_19, st_5 == ((realm_rtt_starting_level_spec v_9 st_4));
        when v_20, st_6 == ((realm_ipa_bits_spec v_9 st_5));
        when st_7 == ((granule_lock_spec (int_to_ptr v_18_tmp) 5 st_6));
        when st_8 == ((granule_unlock_spec v_4 st_7));
        when st_9 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_18_tmp) v_19 v_20 v_1 3 st_8));
        rely ((((st_9.(share)).(granule_data)) = (((st_8.(share)).(granule_data)))));
        when v__sroa_016_0_copyload_tmp, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_9));
        when v__sroa_6_0_copyload, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_10));
        if (v__sroa_6_0_copyload =? (3))
        then (
          when v__sroa_4_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_11));
          when v_25, st_13 == ((granule_map_spec (int_to_ptr v__sroa_016_0_copyload_tmp) 6 st_12));
          when v_28, st_14 == ((__tte_read_spec (ptr_offset v_25 (8 * (v__sroa_4_0_copyload))) st_13));
          when v_29, st_15 == ((s2tte_is_assigned_spec v_28 3 st_14));
          if v_29
          then (smc_data_destroy_0_low st_0 st_15 v_25 v_28 v_29 v__sroa_016_0_copyload_tmp v__sroa_4_0_copyload)
          else (
            when v_31, st_16 == ((pack_return_code_spec 9 0 st_15));
            when st_19 == ((granule_unlock_spec (int_to_ptr v__sroa_016_0_copyload_tmp) st_16));
            when st_22 == ((free_stack "smc_data_destroy" st_0 st_19));
            (Some (v_31, st_22))))
        else (
          when v_23, st_12 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_11));
          when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_016_0_copyload_tmp) st_12));
          when st_17 == ((free_stack "smc_data_destroy" st_0 st_14));
          (Some (v_23, st_17))))
      else (
        when st_4 == ((granule_unlock_spec v_4 st_3));
        when v_13, st_5 == ((pack_return_code_spec 1 2 st_4));
        when st_8 == ((free_stack "smc_data_destroy" st_0 st_5));
        (Some (v_13, st_8)))).



End Layer13_smc_data_destroy_LowSpec.

#[global] Hint Unfold smc_data_destroy_spec_low: spec.
#[global] Hint Unfold smc_data_destroy_0_low: spec.
