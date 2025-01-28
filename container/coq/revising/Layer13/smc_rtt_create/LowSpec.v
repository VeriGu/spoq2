Require Import Bottom.Spec.
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
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rtt_create_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_create_0_low (st_0: RData) (st_25: RData) (v_0: Z) (v_2: Z) (v_3: Z) (v_57: Ptr) (v_60: Z) (v_62: Ptr) (v_81: bool) (v__sroa_053_0_copyload_tmp: Z) (v__sroa_5_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_81 = (true)));
    when st_26 == ((__tte_write_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) 0 st_25));
    when st_27 == ((invalidate_block_spec (mkPtr "stack_s_realm_s2_context" 0) v_2 st_26));
    when v_83, st_28 == ((s2tte_pa_spec v_60 (v_3 + ((- 1))) st_27));
    when st_29 == ((s2tt_init_valid_ns_spec v_62 v_83 v_3 st_28));
    when v_84_tmp, st_30 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_29));
    when st_31 == ((__granule_refcount_inc_spec (int_to_ptr v_84_tmp) 512 st_30));
    when v_90_tmp, st_33 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_31));
    when st_34 == ((granule_set_state_spec (int_to_ptr v_90_tmp) 5 st_33));
    when v_91, st_35 == ((s2tte_create_table_spec v_0 (v_3 + ((- 1))) st_34));
    when st_36 == ((__tte_write_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) v_91 st_35));
    when st_37 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_36));
    when v_94_tmp, st_38 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_37));
    when st_39 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_38));
    when st_40 == ((free_stack "smc_rtt_create" st_0 st_39));
    (Some (0, st_40)).

  Definition smc_rtt_create_1_low (st_0: RData) (st_24: RData) (v_0: Z) (v_2: Z) (v_3: Z) (v_57: Ptr) (v_60: Z) (v_62: Ptr) (v_76: bool) (v__sroa_053_0_copyload_tmp: Z) (v__sroa_5_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_76 = (true)));
    when st_25 == ((__tte_write_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) 0 st_24));
    when st_26 == ((invalidate_block_spec (mkPtr "stack_s_realm_s2_context" 0) v_2 st_25));
    when v_78, st_27 == ((s2tte_pa_spec v_60 (v_3 + ((- 1))) st_26));
    when st_28 == ((s2tt_init_valid_spec v_62 v_78 v_3 st_27));
    when v_79_tmp, st_29 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_28));
    when st_30 == ((__granule_refcount_inc_spec (int_to_ptr v_79_tmp) 512 st_29));
    when v_90_tmp, st_32 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_30));
    when st_33 == ((granule_set_state_spec (int_to_ptr v_90_tmp) 5 st_32));
    when v_91, st_34 == ((s2tte_create_table_spec v_0 (v_3 + ((- 1))) st_33));
    when st_35 == ((__tte_write_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) v_91 st_34));
    when st_36 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_35));
    when v_94_tmp, st_37 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_36));
    when st_38 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_37));
    when st_39 == ((free_stack "smc_rtt_create" st_0 st_38));
    (Some (0, st_39)).

  Definition smc_rtt_create_2_low (st_0: RData) (st_23: RData) (v_0: Z) (v_3: Z) (v_57: Ptr) (v_60: Z) (v_62: Ptr) (v_71: bool) (v__sroa_053_0_copyload_tmp: Z) (v__sroa_5_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_71 = (true)));
    when v_73, st_24 == ((s2tte_pa_spec v_60 (v_3 + ((- 1))) st_23));
    when st_25 == ((s2tt_init_assigned_spec v_62 v_73 v_3 st_24));
    when v_74_tmp, st_26 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_25));
    when st_27 == ((__granule_refcount_inc_spec (int_to_ptr v_74_tmp) 512 st_26));
    when v_90_tmp, st_29 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_27));
    when st_30 == ((granule_set_state_spec (int_to_ptr v_90_tmp) 5 st_29));
    when v_91, st_31 == ((s2tte_create_table_spec v_0 (v_3 + ((- 1))) st_30));
    when st_32 == ((__tte_write_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) v_91 st_31));
    when st_33 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_32));
    when v_94_tmp, st_34 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_33));
    when st_35 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_34));
    when st_36 == ((free_stack "smc_rtt_create" st_0 st_35));
    (Some (0, st_36)).

  Definition smc_rtt_create_3_low (st_0: RData) (st_22: RData) (v_0: Z) (v_3: Z) (v_57: Ptr) (v_62: Ptr) (v_68: bool) (v__sroa_053_0_copyload_tmp: Z) (v__sroa_5_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_68 = (true)));
    when st_23 == ((s2tt_init_destroyed_spec v_62 st_22));
    when st_24 == ((__granule_get_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_23));
    when v_90_tmp, st_25 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_24));
    when st_26 == ((granule_set_state_spec (int_to_ptr v_90_tmp) 5 st_25));
    when v_91, st_27 == ((s2tte_create_table_spec v_0 (v_3 + ((- 1))) st_26));
    when st_28 == ((__tte_write_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) v_91 st_27));
    when st_29 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_28));
    when v_94_tmp, st_30 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_29));
    when st_31 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_30));
    when st_32 == ((free_stack "smc_rtt_create" st_0 st_31));
    (Some (0, st_32)).

  Definition smc_rtt_create_4_low (st_0: RData) (st_21: RData) (v_0: Z) (v_3: Z) (v_57: Ptr) (v_60: Z) (v_62: Ptr) (v_64: bool) (v__sroa_053_0_copyload_tmp: Z) (v__sroa_5_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_64 = (true)));
    when v_66, st_22 == ((s2tte_get_ripas_spec v_60 st_21));
    when st_23 == ((s2tt_init_unassigned_spec v_62 v_66 st_22));
    when st_24 == ((__granule_get_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_23));
    when v_90_tmp, st_25 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_24));
    when st_26 == ((granule_set_state_spec (int_to_ptr v_90_tmp) 5 st_25));
    when v_91, st_27 == ((s2tte_create_table_spec v_0 (v_3 + ((- 1))) st_26));
    when st_28 == ((__tte_write_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) v_91 st_27));
    when st_29 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_28));
    when v_94_tmp, st_30 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_29));
    when st_31 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_30));
    when st_32 == ((free_stack "smc_rtt_create" st_0 st_31));
    (Some (0, st_32)).

  Definition smc_rtt_create_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_create" st));
    if ((v_1 & (1)) =? (0))
    then (
      when v_22, st_1 == ((find_lock_two_granules_spec v_0 1 (mkPtr "stack_type_4__1" 0) v_1 2 (mkPtr "stack_type_4" 0) st_0));
      if (v_22 =? (3))
      then (
        when v_25, st_2 == ((pack_return_code_spec 3 0 st_1));
        when st_4 == ((free_stack "smc_rtt_create" st_0 st_2));
        (Some (v_25, st_4)))
      else (
        if (v_22 =? (0))
        then (
          when v_33_tmp, st_2 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_1));
          when v_40, st_3 == ((granule_map_spec (int_to_ptr v_33_tmp) 2 st_2));
          when v_42, st_4 == ((validate_rtt_structure_cmds_spec v_2 v_3 v_40 st_3));
          if (v_42 =? (0))
          then (
            when v_47_tmp, st_6 == ((load_RData 8 (ptr_offset v_40 32) st_4));
            when v_48, st_7 == ((realm_rtt_starting_level_spec v_40 st_6));
            when v_49, st_8 == ((realm_ipa_bits_spec v_40 st_7));
            when st_9 == ((llvm_memcpy_p0i8_p0i8_i64_spec (mkPtr "stack_s_realm_s2_context" 0) (ptr_offset v_40 16) 32 false st_8));
            when st_10 == ((granule_lock_spec (int_to_ptr v_47_tmp) 5 st_9));
            when v_51_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_10));
            when st_12 == ((granule_unlock_spec (int_to_ptr v_51_tmp) st_11));
            when st_13 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk__1" 0) (int_to_ptr v_47_tmp) v_48 v_49 v_2 (v_3 + ((- 1))) st_12));
            rely ((((st_13.(share)).(granule_data)) = (((st_12.(share)).(granule_data)))));
            when v__sroa_053_0_copyload_tmp, st_14 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk__1" 0) 0) st_13));
            when v__sroa_9_0_copyload, st_15 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk__1" 0) 16) st_14));
            if ((v__sroa_9_0_copyload - ((v_3 + ((- 1))))) =? (0))
            then (
              when v__sroa_5_0_copyload, st_16 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk__1" 0) 8) st_15));
              when v_57, st_17 == ((granule_map_spec (int_to_ptr v__sroa_053_0_copyload_tmp) 6 st_16));
              when v_60, st_18 == ((__tte_read_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) st_17));
              when v_61_tmp, st_19 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_18));
              when v_62, st_20 == ((granule_map_spec (int_to_ptr v_61_tmp) 1 st_19));
              when v_64, st_21 == ((s2tte_is_unassigned_spec v_60 st_20));
              if v_64
              then (smc_rtt_create_4_low st_0 st_21 v_0 v_3 v_57 v_60 v_62 v_64 v__sroa_053_0_copyload_tmp v__sroa_5_0_copyload)
              else (
                when v_68, st_22 == ((s2tte_is_destroyed_spec v_60 st_21));
                if v_68
                then (smc_rtt_create_3_low st_0 st_22 v_0 v_3 v_57 v_62 v_68 v__sroa_053_0_copyload_tmp v__sroa_5_0_copyload)
                else (
                  when v_71, st_23 == ((s2tte_is_assigned_spec v_60 (v_3 + ((- 1))) st_22));
                  if v_71
                  then (smc_rtt_create_2_low st_0 st_23 v_0 v_3 v_57 v_60 v_62 v_71 v__sroa_053_0_copyload_tmp v__sroa_5_0_copyload)
                  else (
                    when v_76, st_24 == ((s2tte_is_valid_spec v_60 (v_3 + ((- 1))) st_23));
                    if v_76
                    then (smc_rtt_create_1_low st_0 st_24 v_0 v_2 v_3 v_57 v_60 v_62 v_76 v__sroa_053_0_copyload_tmp v__sroa_5_0_copyload)
                    else (
                      when v_81, st_25 == ((s2tte_is_valid_ns_spec v_60 (v_3 + ((- 1))) st_24));
                      if v_81
                      then (smc_rtt_create_0_low st_0 st_25 v_0 v_2 v_3 v_57 v_60 v_62 v_81 v__sroa_053_0_copyload_tmp v__sroa_5_0_copyload)
                      else (
                        when v_86, st_26 == ((s2tte_is_table_spec v_60 (v_3 + ((- 1))) st_25));
                        if v_86
                        then (
                          when v_88, st_27 == ((pack_return_code_spec 9 0 st_26));
                          when st_28 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_27));
                          when v_94_tmp, st_29 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_28));
                          when st_30 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_29));
                          when st_32 == ((free_stack "smc_rtt_create" st_0 st_30));
                          (Some (v_88, st_32)))
                        else (
                          when v_90_tmp, st_28 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_26));
                          when st_29 == ((granule_set_state_spec (int_to_ptr v_90_tmp) 5 st_28));
                          when v_91, st_30 == ((s2tte_create_table_spec v_0 (v_3 + ((- 1))) st_29));
                          when st_31 == ((__tte_write_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) v_91 st_30));
                          when st_32 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_31));
                          when v_94_tmp, st_33 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_32));
                          when st_34 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_33));
                          when st_35 == ((free_stack "smc_rtt_create" st_0 st_34));
                          (Some (0, st_35)))))))))
            else (
              when v_55, st_16 == ((pack_return_code_spec 8 v__sroa_9_0_copyload st_15));
              when st_17 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_16));
              when v_94_tmp, st_18 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_17));
              when st_19 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_18));
              when st_21 == ((free_stack "smc_rtt_create" st_0 st_19));
              (Some (v_55, st_21))))
          else (
            when v_38_tmp, st_5 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_4));
            when st_6 == ((granule_unlock_spec (int_to_ptr v_38_tmp) st_5));
            when v_39_tmp, st_7 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_6));
            when st_8 == ((granule_unlock_spec (int_to_ptr v_39_tmp) st_7));
            when v_46, st_9 == ((pack_return_code_spec v_42 ((v_42 >> (32)) + (3)) st_8));
            when st_11 == ((free_stack "smc_rtt_create" st_0 st_9));
            (Some (v_46, st_11))))
        else (
          when v_30, st_2 == ((pack_return_code_spec 1 ((v_22 >> (32)) + (1)) st_1));
          when st_4 == ((free_stack "smc_rtt_create" st_0 st_2));
          (Some (v_30, st_4)))))
    else (
      when v_12, st_1 == ((find_lock_granule_spec (v_1 & ((- 2))) 3 st_0));
      rely (((((v_12.(poffset)) mod (16)) = (0)) /\ (((v_12.(poffset)) >= (0)))));
      rely ((((v_12.(pbase)) = ("granules")) \/ (((v_12.(pbase)) = ("null")))));
      if (ptr_eqb v_12 (mkPtr "null" 0))
      then (
        when v_14, st_2 == ((pack_return_code_spec 1 2 st_1));
        when st_4 == ((free_stack "smc_rtt_create" st_0 st_2));
        (Some (v_14, st_4)))
      else (
        when v_17, st_2 == ((granule_map_spec v_12 3 st_1));
        when v_19, st_3 == ((rtt_create_s1_el1_spec v_17 v_0 v_2 v_3 st_2));
        when st_4 == ((granule_unlock_spec v_12 st_3));
        when st_6 == ((free_stack "smc_rtt_create" st_0 st_4));
        (Some (((v_19 << (32)) >> (32)), st_6)))).



End Layer13_smc_rtt_create_LowSpec.

#[global] Hint Unfold smc_rtt_create_spec_low: spec.
#[global] Hint Unfold smc_rtt_create_0_low: spec.
#[global] Hint Unfold smc_rtt_create_1_low: spec.
#[global] Hint Unfold smc_rtt_create_2_low: spec.
#[global] Hint Unfold smc_rtt_create_3_low: spec.
#[global] Hint Unfold smc_rtt_create_4_low: spec.
