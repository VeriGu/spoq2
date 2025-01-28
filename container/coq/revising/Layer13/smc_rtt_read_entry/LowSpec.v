Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer12.Spec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rtt_read_entry_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_read_entry_0_low (st_0: RData) (st_22: RData) (v_29: Z) (v_3: Ptr) (v_55: bool) (v__sroa_017_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option RData) :=
    rely ((v_55 = (true)));
    when st_23 == ((store_RData 8 (ptr_offset v_3 16) 3 st_22));
    when v_58, st_24 == ((s2tte_pa_spec v_29 v__sroa_4_0_copyload st_23));
    when st_25 == ((store_RData 8 (ptr_offset v_3 24) v_58 st_24));
    when st_32 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_25));
    when st_33 == ((store_RData 8 (ptr_offset v_3 0) 0 st_32));
    when st_36 == ((free_stack "smc_rtt_read_entry" st_0 st_33));
    (Some st_36).

  Definition smc_rtt_read_entry_1_low (st_0: RData) (st_21: RData) (v_29: Z) (v_3: Ptr) (v_50: bool) (v__sroa_017_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option RData) :=
    rely ((v_50 = (true)));
    when st_22 == ((store_RData 8 (ptr_offset v_3 16) 5 st_21));
    when v_53, st_23 == ((host_ns_s2tte_spec v_29 v__sroa_4_0_copyload st_22));
    when st_24 == ((store_RData 8 (ptr_offset v_3 24) v_53 st_23));
    when st_30 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_24));
    when st_31 == ((store_RData 8 (ptr_offset v_3 0) 0 st_30));
    when st_34 == ((free_stack "smc_rtt_read_entry" st_0 st_31));
    (Some st_34).

  Definition smc_rtt_read_entry_2_low (st_0: RData) (st_20: RData) (v_29: Z) (v_3: Ptr) (v_45: bool) (v__sroa_017_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option RData) :=
    rely ((v_45 = (true)));
    when st_21 == ((store_RData 8 (ptr_offset v_3 16) 4 st_20));
    when v_48, st_22 == ((s2tte_pa_spec v_29 v__sroa_4_0_copyload st_21));
    when st_23 == ((store_RData 8 (ptr_offset v_3 24) v_48 st_22));
    when st_28 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_23));
    when st_29 == ((store_RData 8 (ptr_offset v_3 0) 0 st_28));
    when st_32 == ((free_stack "smc_rtt_read_entry" st_0 st_29));
    (Some st_32).

  Definition smc_rtt_read_entry_3_low (st_0: RData) (st_19: RData) (v_29: Z) (v_3: Ptr) (v_40: bool) (v__sroa_017_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option RData) :=
    rely ((v_40 = (true)));
    when st_20 == ((store_RData 8 (ptr_offset v_3 16) 2 st_19));
    when v_43, st_21 == ((s2tte_pa_spec v_29 v__sroa_4_0_copyload st_20));
    when st_22 == ((store_RData 8 (ptr_offset v_3 24) v_43 st_21));
    when st_26 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_22));
    when st_27 == ((store_RData 8 (ptr_offset v_3 0) 0 st_26));
    when st_30 == ((free_stack "smc_rtt_read_entry" st_0 st_27));
    (Some st_30).



  Definition smc_rtt_read_entry_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "smc_rtt_read_entry" st));
    when v_6, st_1 == ((find_lock_granule_spec v_0 2 st_0));
    rely (((((v_6.(poffset)) mod (16)) = (0)) /\ (((v_6.(poffset)) >= (0)))));
    rely ((((v_6.(pbase)) = ("granules")) \/ (((v_6.(pbase)) = ("null")))));
    if (ptr_eqb v_6 (mkPtr "null" 0))
    then (
      when v_8, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_3 == ((store_RData 8 (ptr_offset v_3 0) v_8 st_2));
      when st_5 == ((free_stack "smc_rtt_read_entry" st_0 st_3));
      (Some st_5))
    else (
      when v_12, st_2 == ((granule_map_spec v_6 2 st_1));
      when v_14, st_3 == ((validate_rtt_entry_cmds_spec v_1 v_2 v_12 st_2));
      if (v_14 =? (0))
      then (
        when v_23_tmp, st_4 == ((load_RData 8 (ptr_offset v_12 32) st_3));
        when v_24, st_5 == ((realm_rtt_starting_level_spec v_12 st_4));
        when v_25, st_6 == ((realm_ipa_bits_spec v_12 st_5));
        when st_7 == ((granule_lock_spec (int_to_ptr v_23_tmp) 5 st_6));
        when st_8 == ((granule_unlock_spec v_6 st_7));
        when st_9 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_23_tmp) v_24 v_25 v_1 v_2 st_8));
        rely ((((st_9.(share)).(granule_data)) = (((st_8.(share)).(granule_data)))));
        when v__sroa_017_0_copyload_tmp, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_9));
        when v__sroa_319_0_copyload, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_10));
        when v__sroa_4_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_11));
        when v_26, st_13 == ((granule_map_spec (int_to_ptr v__sroa_017_0_copyload_tmp) 6 st_12));
        when v_29, st_14 == ((__tte_read_spec (ptr_offset v_26 (8 * (v__sroa_319_0_copyload))) st_13));
        when st_15 == ((store_RData 8 (ptr_offset v_3 8) v__sroa_4_0_copyload st_14));
        when st_16 == ((store_RData 8 (ptr_offset v_3 24) 0 st_15));
        when v_32, st_17 == ((s2tte_is_unassigned_spec v_29 st_16));
        if v_32
        then (
          when st_18 == ((store_RData 8 (ptr_offset v_3 16) 0 st_17));
          when st_20 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_18));
          when st_21 == ((store_RData 8 (ptr_offset v_3 0) 0 st_20));
          when st_24 == ((free_stack "smc_rtt_read_entry" st_0 st_21));
          (Some st_24))
        else (
          when v_36, st_18 == ((s2tte_is_destroyed_spec v_29 st_17));
          if v_36
          then (
            when st_19 == ((store_RData 8 (ptr_offset v_3 16) 1 st_18));
            when st_22 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_19));
            when st_23 == ((store_RData 8 (ptr_offset v_3 0) 0 st_22));
            when st_26 == ((free_stack "smc_rtt_read_entry" st_0 st_23));
            (Some st_26))
          else (
            when v_40, st_19 == ((s2tte_is_assigned_spec v_29 v__sroa_4_0_copyload st_18));
            if v_40
            then (smc_rtt_read_entry_3_low st_0 st_19 v_29 v_3 v_40 v__sroa_017_0_copyload_tmp v__sroa_4_0_copyload)
            else (
              when v_45, st_20 == ((s2tte_is_valid_spec v_29 v__sroa_4_0_copyload st_19));
              if v_45
              then (smc_rtt_read_entry_2_low st_0 st_20 v_29 v_3 v_45 v__sroa_017_0_copyload_tmp v__sroa_4_0_copyload)
              else (
                when v_50, st_21 == ((s2tte_is_valid_ns_spec v_29 v__sroa_4_0_copyload st_20));
                if v_50
                then (smc_rtt_read_entry_1_low st_0 st_21 v_29 v_3 v_50 v__sroa_017_0_copyload_tmp v__sroa_4_0_copyload)
                else (
                  when v_55, st_22 == ((s2tte_is_table_spec v_29 v__sroa_4_0_copyload st_21));
                  if v_55
                  then (smc_rtt_read_entry_0_low st_0 st_22 v_29 v_3 v_55 v__sroa_017_0_copyload_tmp v__sroa_4_0_copyload)
                  else (
                    when st_29 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_22));
                    when st_30 == ((store_RData 8 (ptr_offset v_3 0) 0 st_29));
                    when st_33 == ((free_stack "smc_rtt_read_entry" st_0 st_30));
                    (Some st_33))))))))
      else (
        when st_4 == ((granule_unlock_spec v_6 st_3));
        when v_17, st_5 == ((pack_return_code_spec v_14 ((v_14 >> (32)) + (2)) st_4));
        when st_6 == ((store_RData 8 (ptr_offset v_3 0) v_17 st_5));
        when st_9 == ((free_stack "smc_rtt_read_entry" st_0 st_6));
        (Some st_9))).

End Layer13_smc_rtt_read_entry_LowSpec.

#[global] Hint Unfold smc_rtt_read_entry_spec_low: spec.
#[global] Hint Unfold smc_rtt_read_entry_0_low: spec.
#[global] Hint Unfold smc_rtt_read_entry_1_low: spec.
#[global] Hint Unfold smc_rtt_read_entry_2_low: spec.
#[global] Hint Unfold smc_rtt_read_entry_3_low: spec.
