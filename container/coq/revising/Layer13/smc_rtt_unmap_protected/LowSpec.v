Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rtt_unmap_protected_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_unmap_protected_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_unmap_protected" st));
    when v_6, st_1 == ((find_lock_granule_spec v_0 2 st_0));
    rely (((((v_6.(poffset)) mod (16)) = (0)) /\ (((v_6.(poffset)) >= (0)))));
    rely ((((v_6.(pbase)) = ("granules")) \/ (((v_6.(pbase)) = ("null")))));
    if (ptr_eqb v_6 (mkPtr "null" 0))
    then (
      when v_8, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "smc_rtt_unmap_protected" st_0 st_2));
      (Some (v_8, st_4)))
    else (
      when v_10, st_2 == ((granule_map_spec v_6 2 st_1));
      when v_12, st_3 == ((validate_rtt_map_cmds_spec v_1 v_2 v_10 st_2));
      if (v_12 =? (0))
      then (
        when v_21_tmp, st_4 == ((load_RData 8 (ptr_offset v_10 32) st_3));
        when v_22, st_5 == ((realm_rtt_starting_level_spec v_10 st_4));
        when v_23, st_6 == ((realm_ipa_bits_spec v_10 st_5));
        when st_7 == ((llvm_memcpy_p0i8_p0i8_i64_spec (mkPtr "stack_s_realm_s2_context" 0) (ptr_offset v_10 16) 32 false st_6));
        when st_8 == ((granule_lock_spec (int_to_ptr v_21_tmp) 5 st_7));
        when st_9 == ((granule_unlock_spec v_6 st_8));
        when st_10 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_21_tmp) v_22 v_23 v_1 v_2 st_9));
        rely ((((st_10.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
        when v__sroa_017_0_copyload_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_10));
        when v__sroa_5_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_11));
        if ((v__sroa_5_0_copyload - (v_2)) =? (0))
        then (
          when v__sroa_319_0_copyload, st_13 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_12));
          when v_29, st_14 == ((granule_map_spec (int_to_ptr v__sroa_017_0_copyload_tmp) 6 st_13));
          when v_32, st_15 == ((__tte_read_spec (ptr_offset v_29 (8 * (v__sroa_319_0_copyload))) st_14));
          when v_33, st_16 == ((s2tte_is_valid_spec v_32 v_2 st_15));
          if v_33
          then (
            when v_37, st_17 == ((s2tte_pa_spec v_32 v_2 st_16));
            when v_38, st_18 == ((s2tte_create_assigned_spec v_37 v_2 st_17));
            when st_19 == ((__tte_write_spec (ptr_offset v_29 (8 * (v__sroa_319_0_copyload))) v_38 st_18));
            if (v_2 =? (3))
            then (
              when st_20 == ((invalidate_page_spec (mkPtr "stack_s_realm_s2_context" 0) v_1 st_19));
              when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_20));
              when st_22 == ((free_stack "smc_rtt_unmap_protected" st_0 st_24));
              (Some (0, st_22)))
            else (
              when st_20 == ((invalidate_block_spec (mkPtr "stack_s_realm_s2_context" 0) v_1 st_19));
              when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_20));
              when st_22 == ((free_stack "smc_rtt_unmap_protected" st_0 st_24));
              (Some (0, st_22))))
          else (
            when v_35, st_17 == ((pack_return_code_spec 9 0 st_16));
            when st_20 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_17));
            when st_19 == ((free_stack "smc_rtt_unmap_protected" st_0 st_20));
            (Some (v_35, st_19))))
        else (
          when v_27, st_13 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_12));
          when st_15 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_13));
          when st_16 == ((free_stack "smc_rtt_unmap_protected" st_0 st_15));
          (Some (v_27, st_16))))
      else (
        when st_4 == ((granule_unlock_spec v_6 st_3));
        when v_15, st_5 == ((pack_return_code_spec v_12 ((v_12 >> (32)) + (2)) st_4));
        when st_7 == ((free_stack "smc_rtt_unmap_protected" st_0 st_5));
        (Some (v_15, st_7)))).

End Layer13_smc_rtt_unmap_protected_LowSpec.

#[global] Hint Unfold smc_rtt_unmap_protected_spec_low: spec.
