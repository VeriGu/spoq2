Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer12.Spec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rtt_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_destroy_0_low (st_0: RData) (st_19: RData) (v_2: Z) (v_31: Ptr) (v_44: Ptr) (v_45: Z) (v__sroa_019_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_45 =? (0)) = (true)));
    when v_49, st_20 == ((granule_map_spec v_44 7 st_19));
    when st_21 == ((__granule_put_spec (int_to_ptr v__sroa_019_0_copyload_tmp) st_20));
    when st_22 == ((__tte_write_spec (ptr_offset v_31 (8 * (v__sroa_4_0_copyload))) 0 st_21));
    when st_23 == ((invalidate_block_spec (mkPtr "stack_s_realm_s2_context" 0) v_2 st_22));
    when st_24 == ((__tte_write_spec (ptr_offset v_31 (8 * (v__sroa_4_0_copyload))) 8 st_23));
    when st_25 == ((granule_memzero_mapped_spec v_49 st_24));
    when st_26 == ((granule_set_state_spec v_44 1 st_25));
    when st_28 == ((granule_unlock_spec v_44 st_26));
    when st_32 == ((granule_unlock_spec (int_to_ptr v__sroa_019_0_copyload_tmp) st_28));
    when st_29 == ((free_stack "smc_rtt_destroy" st_0 st_32));
    (Some (0, st_29)).



  Definition smc_rtt_destroy_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_destroy" st));
    when v_7, st_1 == ((find_lock_granule_spec v_1 2 st_0));
    rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
    rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
    if (ptr_eqb v_7 (mkPtr "null" 0))
    then (
      when v_9, st_2 == ((pack_return_code_spec 1 2 st_1));
      when st_4 == ((free_stack "smc_rtt_destroy" st_0 st_2));
      (Some (v_9, st_4)))
    else (
      when v_11, st_2 == ((granule_map_spec v_7 2 st_1));
      when v_13, st_3 == ((validate_rtt_structure_cmds_spec v_2 v_3 v_11 st_2));
      if (v_13 =? (0))
      then (
        when v_22_tmp, st_4 == ((load_RData 8 (ptr_offset v_11 32) st_3));
        when v_23, st_5 == ((realm_rtt_starting_level_spec v_11 st_4));
        when v_24, st_6 == ((realm_ipa_bits_spec v_11 st_5));
        when st_7 == ((llvm_memcpy_p0i8_p0i8_i64_spec (mkPtr "stack_s_realm_s2_context" 0) (ptr_offset v_11 16) 32 false st_6));
        when st_8 == ((granule_lock_spec (int_to_ptr v_22_tmp) 5 st_7));
        when st_9 == ((granule_unlock_spec v_7 st_8));
        when st_10 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_22_tmp) v_23 v_24 v_2 (v_3 + ((- 1))) st_9));
        rely ((((st_10.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
        when v__sroa_019_0_copyload_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_10));
        when v__sroa_7_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_11));
        if ((v__sroa_7_0_copyload - ((v_3 + ((- 1))))) =? (0))
        then (
          when v__sroa_4_0_copyload, st_13 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_12));
          when v_31, st_14 == ((granule_map_spec (int_to_ptr v__sroa_019_0_copyload_tmp) 6 st_13));
          when v_34, st_15 == ((__tte_read_spec (ptr_offset v_31 (8 * (v__sroa_4_0_copyload))) st_14));
          when v_35, st_16 == ((s2tte_is_table_spec v_34 (v_3 + ((- 1))) st_15));
          if v_35
          then (
            when v_40, st_17 == ((s2tte_pa_spec v_34 (v_3 + ((- 1))) st_16));
            if ((v_40 - (v_0)) =? (0))
            then (
              when v_44, st_18 == ((find_lock_granule_spec v_0 5 st_17));
              rely (((((v_44.(poffset)) mod (16)) = (0)) /\ (((v_44.(poffset)) >= (0)))));
              rely ((((v_44.(pbase)) = ("granules")) \/ (((v_44.(pbase)) = ("null")))));
              when v_45, st_19 == ((g_refcount_spec v_44 st_18));
              if (v_45 =? (0))
              then (smc_rtt_destroy_0_low st_0 st_19 v_2 v_31 v_44 v_45 v__sroa_019_0_copyload_tmp v__sroa_4_0_copyload)
              else (
                when v_47, st_20 == ((pack_return_code_spec 4 0 st_19));
                when st_22 == ((granule_unlock_spec v_44 st_20));
                when st_26 == ((granule_unlock_spec (int_to_ptr v__sroa_019_0_copyload_tmp) st_22));
                when st_23 == ((free_stack "smc_rtt_destroy" st_0 st_26));
                (Some (v_47, st_23))))
            else (
              when v_42, st_18 == ((pack_return_code_spec 1 1 st_17));
              when st_22 == ((granule_unlock_spec (int_to_ptr v__sroa_019_0_copyload_tmp) st_18));
              when st_20 == ((free_stack "smc_rtt_destroy" st_0 st_22));
              (Some (v_42, st_20))))
          else (
            when v_38, st_17 == ((pack_return_code_spec 8 (v_3 + ((- 1))) st_16));
            when st_20 == ((granule_unlock_spec (int_to_ptr v__sroa_019_0_copyload_tmp) st_17));
            when st_19 == ((free_stack "smc_rtt_destroy" st_0 st_20));
            (Some (v_38, st_19))))
        else (
          when v_29, st_13 == ((pack_return_code_spec 8 v__sroa_7_0_copyload st_12));
          when st_15 == ((granule_unlock_spec (int_to_ptr v__sroa_019_0_copyload_tmp) st_13));
          when st_16 == ((free_stack "smc_rtt_destroy" st_0 st_15));
          (Some (v_29, st_16))))
      else (
        when st_4 == ((granule_unlock_spec v_7 st_3));
        when v_16, st_5 == ((pack_return_code_spec v_13 ((v_13 >> (32)) + (3)) st_4));
        when st_7 == ((free_stack "smc_rtt_destroy" st_0 st_5));
        (Some (v_16, st_7)))).

End Layer13_smc_rtt_destroy_LowSpec.

#[global] Hint Unfold smc_rtt_destroy_spec_low: spec.
#[global] Hint Unfold smc_rtt_destroy_0_low: spec.
