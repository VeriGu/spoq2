Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rtt_map_protected_LowSpec.

  Context `{int_ptr: IntPtrCast}.


  Definition smc_rtt_map_protected_0_low (st_0: RData) (st_15: RData) (v_2: Z) (v_26: Ptr) (v_29: Z) (v_30: bool) (v__sroa_018_0_copyload_tmp: Z) (v__sroa_320_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_30 = (true)));
    when v_34, st_16 == ((s2tte_pa_spec v_29 v_2 st_15));
    when v_35, st_17 == ((s2tte_create_valid_spec v_34 v_2 st_16));
    when st_18 == ((__tte_write_spec (ptr_offset v_26 (8 * (v__sroa_320_0_copyload))) v_35 st_17));
    when st_21 == ((granule_unlock_spec (int_to_ptr v__sroa_018_0_copyload_tmp) st_18));
    when st_20 == ((free_stack "smc_rtt_map_protected" st_0 st_21));
    (Some (0, st_20)).



  Definition smc_rtt_map_protected_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_map_protected" st));
    when v_5, st_1 == ((find_lock_granule_spec v_0 2 st_0));
    rely (((((v_5.(poffset)) mod (16)) = (0)) /\ (((v_5.(poffset)) >= (0)))));
    rely ((((v_5.(pbase)) = ("granules")) \/ (((v_5.(pbase)) = ("null")))));
    if (ptr_eqb v_5 (mkPtr "null" 0))
    then (
      when v_7, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "smc_rtt_map_protected" st_0 st_2));
      (Some (v_7, st_4)))
    else (
      when v_9, st_2 == ((granule_map_spec v_5 2 st_1));
      when v_11, st_3 == ((validate_rtt_map_cmds_spec v_1 v_2 v_9 st_2));
      if (v_11 =? (0))
      then (
        when v_19_tmp, st_4 == ((load_RData 8 (ptr_offset v_9 32) st_3));
        when v_20, st_5 == ((realm_rtt_starting_level_spec v_9 st_4));
        when v_21, st_6 == ((realm_ipa_bits_spec v_9 st_5));
        when st_7 == ((granule_lock_spec (int_to_ptr v_19_tmp) 5 st_6));
        when st_8 == ((granule_unlock_spec v_5 st_7));
        when st_9 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_19_tmp) v_20 v_21 v_1 v_2 st_8));
        rely ((((st_9.(share)).(granule_data)) = (((st_8.(share)).(granule_data)))));
        when v__sroa_018_0_copyload_tmp, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_9));
        when v__sroa_5_0_copyload, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_10));
        if ((v__sroa_5_0_copyload - (v_2)) =? (0))
        then (
          when v__sroa_320_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_11));
          when v_26, st_13 == ((granule_map_spec (int_to_ptr v__sroa_018_0_copyload_tmp) 6 st_12));
          when v_29, st_14 == ((__tte_read_spec (ptr_offset v_26 (8 * (v__sroa_320_0_copyload))) st_13));
          when v_30, st_15 == ((s2tte_is_assigned_spec v_29 v_2 st_14));
          if v_30
          then (smc_rtt_map_protected_0_low st_0 st_15 v_2 v_26 v_29 v_30 v__sroa_018_0_copyload_tmp v__sroa_320_0_copyload)
          else (
            when v_32, st_16 == ((pack_return_code_spec 9 0 st_15));
            when st_19 == ((granule_unlock_spec (int_to_ptr v__sroa_018_0_copyload_tmp) st_16));
            when st_18 == ((free_stack "smc_rtt_map_protected" st_0 st_19));
            (Some (v_32, st_18))))
        else (
          when v_24, st_12 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_11));
          when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_018_0_copyload_tmp) st_12));
          when st_15 == ((free_stack "smc_rtt_map_protected" st_0 st_14));
          (Some (v_24, st_15))))
      else (
        when st_4 == ((granule_unlock_spec v_5 st_3));
        when v_14, st_5 == ((pack_return_code_spec v_11 ((v_11 >> (32)) + (2)) st_4));
        when st_7 == ((free_stack "smc_rtt_map_protected" st_0 st_5));
        (Some (v_14, st_7)))).
End Layer13_smc_rtt_map_protected_LowSpec.

#[global] Hint Unfold smc_rtt_map_protected_spec_low: spec.
#[global] Hint Unfold smc_rtt_map_protected_0_low: spec.
