Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer10.Spec.
Require Import Layer11.Spec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_data_create_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition data_create_0_low (st_0: RData) (st_17: RData) (v_0: Z) (v_39: Ptr) (v_57: Z) (v__sroa_028_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_57 =? (0)) = (true)));
    when v_60, st_18 == ((s2tte_create_assigned_spec v_0 3 st_17));
    when st_20 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) v_60 st_18));
    when st_21 == ((__granule_get_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_20));
    when st_22 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_21));
    when v_68_tmp, st_23 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_22));
    when st_24 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_23));
    when v_69_tmp, st_25 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_24));
    when st_26 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 4 st_25));
    when st_27 == ((free_stack "data_create" st_0 st_26));
    (Some (0, st_27)).

  Definition data_create_1_low (st_0: RData) (st_23: RData) (v_0: Z) (v_39: Ptr) (v_57: Z) (v__sroa_028_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_57 =? (0)) = (true)));
    when v_60, st_24 == ((s2tte_create_assigned_spec v_0 3 st_23));
    when st_25 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) v_60 st_24));
    when st_26 == ((__granule_get_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_25));
    when st_27 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_26));
    when v_68_tmp, st_28 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_27));
    when st_29 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_28));
    when v_69_tmp, st_30 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_29));
    when st_31 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 4 st_30));
    when st_32 == ((free_stack "data_create" st_0 st_31));
    (Some (0, st_32)).



  Definition data_create_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "data_create" st));
    when v_8, st_1 == ((find_lock_two_granules_spec v_0 1 (mkPtr "stack_type_4" 0) v_1 2 (mkPtr "stack_type_4__1" 0) st_0));
    if (v_8 =? (3))
    then (
      when v_11, st_2 == ((pack_return_code_spec 3 0 st_1));
      when st_4 == ((free_stack "data_create" st_0 st_2));
      (Some (v_11, st_4)))
    else (
      if (v_8 =? (0))
      then (
        when v_19_tmp, st_2 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_1));
        when v_24, st_3 == ((granule_map_spec (int_to_ptr v_19_tmp) 2 st_2));
        if (ptr_eqb v_3 (mkPtr "null" 0))
        then (
          when v_26, st_4 == ((validate_data_create_unknown_spec v_2 v_24 st_3));
          if (v_26 =? (0))
          then (
            when v_32_tmp, st_6 == ((load_RData 8 (ptr_offset v_24 32) st_4));
            when v_33, st_7 == ((realm_rtt_starting_level_spec v_24 st_6));
            when v_34, st_8 == ((realm_ipa_bits_spec v_24 st_7));
            when st_9 == ((granule_lock_spec (int_to_ptr v_32_tmp) 5 st_8));
            when st_10 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_32_tmp) v_33 v_34 v_2 3 st_9));
            rely ((((st_10.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
            when v__sroa_028_0_copyload_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_10));
            when v__sroa_6_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_11));
            if (v__sroa_6_0_copyload =? (3))
            then (
              when v__sroa_4_0_copyload, st_13 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_12));
              when v_39, st_14 == ((granule_map_spec (int_to_ptr v__sroa_028_0_copyload_tmp) 6 st_13));
              when v_42, st_15 == ((__tte_read_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) st_14));
              when v_43, st_16 == ((s2tte_is_unassigned_spec v_42 st_15));
              if v_43
              then (
                when v_57, st_17 == ((s2tte_get_ripas_spec v_42 st_16));
                if (v_57 =? (0))
                then (data_create_0_low st_0 st_17 v_0 v_39 v_57 v__sroa_028_0_copyload_tmp v__sroa_4_0_copyload)
                else (
                  when v_62, st_18 == ((s2tte_create_valid_spec v_0 3 st_17));
                  when st_20 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) v_62 st_18));
                  when st_21 == ((__granule_get_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_20));
                  when st_22 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_21));
                  when v_68_tmp, st_23 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_22));
                  when st_24 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_23));
                  when v_69_tmp, st_25 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_24));
                  when st_26 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 4 st_25));
                  when st_27 == ((free_stack "data_create" st_0 st_26));
                  (Some (0, st_27))))
              else (
                when v_45, st_17 == ((pack_return_code_spec 9 0 st_16));
                when st_18 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_17));
                when v_68_tmp, st_19 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_18));
                when st_20 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_19));
                when v_69_tmp, st_21 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_20));
                when st_22 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_21));
                when st_24 == ((free_stack "data_create" st_0 st_22));
                (Some (v_45, st_24))))
            else (
              when v_37, st_13 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_12));
              when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_13));
              when v_68_tmp, st_15 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_14));
              when st_16 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_15));
              when v_69_tmp, st_17 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_16));
              when st_18 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_17));
              when st_20 == ((free_stack "data_create" st_0 st_18));
              (Some (v_37, st_20))))
          else (
            when v_28, st_6 == ((pack_struct_return_code_spec v_26 st_4));
            when v_68_tmp, st_7 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_6));
            when st_8 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_7));
            when v_69_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_8));
            when st_10 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_9));
            when st_12 == ((free_stack "data_create" st_0 st_10));
            (Some (v_28, st_12))))
        else (
          when v_26, st_4 == ((validate_data_create_spec v_2 v_24 st_3));
          if (v_26 =? (0))
          then (
            when v_32_tmp, st_6 == ((load_RData 8 (ptr_offset v_24 32) st_4));
            when v_33, st_7 == ((realm_rtt_starting_level_spec v_24 st_6));
            when v_34, st_8 == ((realm_ipa_bits_spec v_24 st_7));
            when st_9 == ((granule_lock_spec (int_to_ptr v_32_tmp) 5 st_8));
            when st_10 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_32_tmp) v_33 v_34 v_2 3 st_9));
            rely ((((st_10.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
            when v__sroa_028_0_copyload_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_10));
            when v__sroa_6_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_11));
            if (v__sroa_6_0_copyload =? (3))
            then (
              when v__sroa_4_0_copyload, st_13 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_12));
              when v_39, st_14 == ((granule_map_spec (int_to_ptr v__sroa_028_0_copyload_tmp) 6 st_13));
              when v_42, st_15 == ((__tte_read_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) st_14));
              when v_43, st_16 == ((s2tte_is_unassigned_spec v_42 st_15));
              if v_43
              then (
                when v_48_tmp, st_17 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_16));
                when v_49, st_18 == ((granule_map_spec (int_to_ptr v_48_tmp) 1 st_17));
                when v_50, st_19 == ((granule_addr_spec v_3 st_18));
                when v_51, st_20 == ((ns_buffer_read_spec 0 v_50 4096 v_49 st_19));
                when st_21 == ((ns_buffer_unmap_spec 0 st_20));
                if v_51
                then (
                  when v_57, st_23 == ((s2tte_get_ripas_spec v_42 st_21));
                  if (v_57 =? (0))
                  then (data_create_1_low st_0 st_23 v_0 v_39 v_57 v__sroa_028_0_copyload_tmp v__sroa_4_0_copyload)
                  else (
                    when v_62, st_24 == ((s2tte_create_valid_spec v_0 3 st_23));
                    when st_25 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) v_62 st_24));
                    when st_26 == ((__granule_get_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_25));
                    when st_27 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_26));
                    when v_68_tmp, st_28 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_27));
                    when st_29 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_28));
                    when v_69_tmp, st_30 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_29));
                    when st_31 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 4 st_30));
                    when st_32 == ((free_stack "data_create" st_0 st_31));
                    (Some (0, st_32))))
                else (
                  when v_53, st_22 == ((memset_spec v_49 0 4096 st_21));
                  when v_54, st_23 == ((pack_return_code_spec 1 4 st_22));
                  when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_23));
                  when v_68_tmp, st_25 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_24));
                  when st_26 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_25));
                  when v_69_tmp, st_27 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_26));
                  when st_28 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_27));
                  when st_30 == ((free_stack "data_create" st_0 st_28));
                  (Some (v_54, st_30))))
              else (
                when v_45, st_17 == ((pack_return_code_spec 9 0 st_16));
                when st_18 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_17));
                when v_68_tmp, st_19 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_18));
                when st_20 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_19));
                when v_69_tmp, st_21 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_20));
                when st_22 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_21));
                when st_24 == ((free_stack "data_create" st_0 st_22));
                (Some (v_45, st_24))))
            else (
              when v_37, st_13 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_12));
              when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_13));
              when v_68_tmp, st_15 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_14));
              when st_16 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_15));
              when v_69_tmp, st_17 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_16));
              when st_18 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_17));
              when st_20 == ((free_stack "data_create" st_0 st_18));
              (Some (v_37, st_20))))
          else (
            when v_28, st_6 == ((pack_struct_return_code_spec v_26 st_4));
            when v_68_tmp, st_7 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_6));
            when st_8 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_7));
            when v_69_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_8));
            when st_10 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_9));
            when st_12 == ((free_stack "data_create" st_0 st_10));
            (Some (v_28, st_12)))))
      else (
        when v_16, st_2 == ((pack_return_code_spec 1 ((v_8 >> (32)) + (1)) st_1));
        when st_4 == ((free_stack "data_create" st_0 st_2));
        (Some (v_16, st_4)))).

End Layer12_data_create_LowSpec.

#[global] Hint Unfold data_create_spec_low: spec.
#[global] Hint Unfold data_create_0_low: spec.
#[global] Hint Unfold data_create_1_low: spec.
