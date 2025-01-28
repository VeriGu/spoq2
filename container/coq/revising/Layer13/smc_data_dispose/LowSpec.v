Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.
Require Import Layer11.Spec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_data_dispose_LowSpec.

  Context `{int_ptr: IntPtrCast}.


  Definition smc_data_dispose_0_low (st_0: RData) (st_26: RData) (v_70: Ptr) (v_74: bool) (v__sroa_032_0_copyload_tmp: Z) (v__sroa_3_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_74 = (true)));
    when v_78, st_27 == ((s2tte_create_unassigned_spec 1 st_26));
    when st_28 == ((__tte_write_spec (ptr_offset v_70 (8 * (v__sroa_3_0_copyload))) v_78 st_27));
    when st_31 == ((granule_unlock_spec (int_to_ptr v__sroa_032_0_copyload_tmp) st_28));
    when v_83_tmp, st_37 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_31));
    when st_38 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_37));
    when v_84_tmp, st_39 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_38));
    when st_40 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_39));
    when st_43 == ((free_stack "smc_data_dispose" st_0 st_40));
    (Some (0, st_43)).

  Definition smc_data_dispose_1_low (st_0: RData) (st_8: RData) (v_34: Z) : (option (Z * RData)) :=
    rely ((((v_34 & (1)) =? (0)) = (true)));
    when v_37, st_9 == ((pack_return_code_spec 7 0 st_8));
    when v_83_tmp, st_13 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_9));
    when st_14 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_13));
    when v_84_tmp, st_15 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_14));
    when st_16 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_15));
    when st_19 == ((free_stack "smc_data_dispose" st_0 st_16));
    (Some (v_37, st_19)).

  Definition smc_data_dispose_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_data_dispose" st));
    when v_8, st_1 == ((find_lock_two_granules_spec v_0 2 (mkPtr "stack_type_4" 0) v_1 3 (mkPtr "stack_type_4__1" 0) st_0));
    if (v_8 =? (3))
    then (
      when v_11, st_2 == ((pack_return_code_spec 3 0 st_1));
      when st_4 == ((free_stack "smc_data_dispose" st_0 st_2));
      (Some (v_11, st_4)))
    else (
      if (v_8 =? (0))
      then (
        when v_19_tmp, st_2 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_1));
        when v_20, st_3 == ((granule_refcount_read_acquire_spec (int_to_ptr v_19_tmp) st_2));
        if (v_20 =? (0))
        then (
          when v_24_tmp, st_4 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_3));
          when v_25, st_5 == ((granule_map_spec (int_to_ptr v_24_tmp) 3 st_4));
          when v_26_tmp, st_6 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_5));
          when v_29_tmp, st_7 == ((load_RData 8 (ptr_offset v_25 944) st_6));
          if (ptr_eqb (int_to_ptr v_26_tmp) (int_to_ptr v_29_tmp))
          then (
            when v_34, st_8 == ((load_RData 1 (ptr_offset v_25 896) st_7));
            if ((v_34 & (1)) =? (0))
            then (smc_data_dispose_1_low st_0 st_8 v_34)
            else (
              when v_41, st_9 == ((load_RData 8 (ptr_offset v_25 904) st_8));
              when v_44, st_10 == ((load_RData 8 (ptr_offset v_25 912) st_9));
              when v_47, st_11 == ((s2tte_map_size_spec v_3 st_10));
              when v_49, st_12 == ((region_is_contained_spec v_41 (v_44 + (v_41)) v_2 (v_47 + (v_2)) st_11));
              if v_49
              then (
                when v_53_tmp, st_13 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_12));
                when v_54, st_14 == ((granule_map_spec (int_to_ptr v_53_tmp) 2 st_13));
                when v_56, st_15 == ((validate_rtt_map_cmds_spec v_2 v_3 v_54 st_14));
                if (v_56 =? (0))
                then (
                  when v_63_tmp, st_16 == ((load_RData 8 (ptr_offset v_54 32) st_15));
                  when v_64, st_17 == ((realm_rtt_starting_level_spec v_54 st_16));
                  when v_65, st_18 == ((realm_ipa_bits_spec v_54 st_17));
                  when st_19 == ((granule_lock_spec (int_to_ptr v_63_tmp) 5 st_18));
                  when st_20 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_63_tmp) v_64 v_65 v_2 v_3 st_19));
                  rely ((((st_20.(share)).(granule_data)) = (((st_19.(share)).(granule_data)))));
                  when v__sroa_032_0_copyload_tmp, st_21 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_20));
                  when v__sroa_5_0_copyload, st_22 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_21));
                  if ((v__sroa_5_0_copyload - (v_3)) =? (0))
                  then (
                    when v__sroa_3_0_copyload, st_23 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_22));
                    when v_70, st_24 == ((granule_map_spec (int_to_ptr v__sroa_032_0_copyload_tmp) 6 st_23));
                    when v_73, st_25 == ((__tte_read_spec (ptr_offset v_70 (8 * (v__sroa_3_0_copyload))) st_24));
                    when v_74, st_26 == ((s2tte_is_destroyed_spec v_73 st_25));
                    if v_74
                    then (smc_data_dispose_0_low st_0 st_26 v_70 v_74 v__sroa_032_0_copyload_tmp v__sroa_3_0_copyload)
                    else (
                      when v_76, st_27 == ((pack_return_code_spec 9 0 st_26));
                      when st_30 == ((granule_unlock_spec (int_to_ptr v__sroa_032_0_copyload_tmp) st_27));
                      when v_83_tmp, st_36 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_30));
                      when st_37 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_36));
                      when v_84_tmp, st_38 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_37));
                      when st_39 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_38));
                      when st_42 == ((free_stack "smc_data_dispose" st_0 st_39));
                      (Some (v_76, st_42))))
                  else (
                    when v_68, st_23 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_22));
                    when st_25 == ((granule_unlock_spec (int_to_ptr v__sroa_032_0_copyload_tmp) st_23));
                    when v_83_tmp, st_31 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_25));
                    when st_32 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_31));
                    when v_84_tmp, st_33 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_32));
                    when st_34 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_33));
                    when st_37 == ((free_stack "smc_data_dispose" st_0 st_34));
                    (Some (v_68, st_37))))
                else (
                  when v_59, st_16 == ((pack_return_code_spec v_56 ((v_56 >> (32)) + (3)) st_15));
                  when v_83_tmp, st_22 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_16));
                  when st_23 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_22));
                  when v_84_tmp, st_24 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_23));
                  when st_25 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_24));
                  when st_28 == ((free_stack "smc_data_dispose" st_0 st_25));
                  (Some (v_59, st_28))))
              else (
                when v_51, st_13 == ((pack_return_code_spec 1 3 st_12));
                when v_83_tmp, st_18 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_13));
                when st_19 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_18));
                when v_84_tmp, st_20 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_19));
                when st_21 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_20));
                when st_24 == ((free_stack "smc_data_dispose" st_0 st_21));
                (Some (v_51, st_24)))))
          else (
            when v_31, st_8 == ((pack_return_code_spec 6 0 st_7));
            when v_83_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_8));
            when st_12 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_11));
            when v_84_tmp, st_13 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_12));
            when st_14 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_13));
            when st_17 == ((free_stack "smc_data_dispose" st_0 st_14));
            (Some (v_31, st_17))))
        else (
          when v_22, st_4 == ((pack_return_code_spec 4 0 st_3));
          when v_83_tmp, st_6 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_4));
          when st_7 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_6));
          when v_84_tmp, st_8 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_7));
          when st_9 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_8));
          when st_12 == ((free_stack "smc_data_dispose" st_0 st_9));
          (Some (v_22, st_12))))
      else (
        when v_16, st_2 == ((pack_return_code_spec 1 ((v_8 >> (32)) + (1)) st_1));
        when st_5 == ((free_stack "smc_data_dispose" st_0 st_2));
        (Some (v_16, st_5)))).


End Layer13_smc_data_dispose_LowSpec.

#[global] Hint Unfold smc_data_dispose_spec_low: spec.
#[global] Hint Unfold smc_data_dispose_0_low: spec.
#[global] Hint Unfold smc_data_dispose_1_low: spec.
