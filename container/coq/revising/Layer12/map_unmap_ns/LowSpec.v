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

Section Layer12_map_unmap_ns_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition map_unmap_ns_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "map_unmap_ns" st));
    when v_8, st_1 == ((find_lock_granule_spec v_0 2 st_0));
    rely (((((v_8.(poffset)) mod (16)) = (0)) /\ (((v_8.(poffset)) >= (0)))));
    rely ((((v_8.(pbase)) = ("granules")) \/ (((v_8.(pbase)) = ("null")))));
    if (ptr_eqb v_8 (mkPtr "null" 0))
    then (
      when v_10, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "map_unmap_ns" st_0 st_2));
      (Some (v_10, st_4)))
    else (
      when v_13, st_2 == ((granule_map_spec v_8 2 st_1));
      when v_15, st_3 == ((validate_rtt_map_cmds_spec v_1 v_2 v_13 st_2));
      if (v_15 =? (0))
      then (
        when v_24_tmp, st_4 == ((load_RData 8 (ptr_offset v_13 32) st_3));
        when v_35, st_5 == ((realm_rtt_starting_level_spec v_13 st_4));
        when v_36, st_6 == ((realm_ipa_bits_spec v_13 st_5));
        if (v_4 =? (0))
        then (
          when v_38, st_7 == ((addr_block_intersects_par_spec v_13 v_1 v_2 st_6));
          if v_38
          then (
            when st_8 == ((granule_unlock_spec v_8 st_7));
            when v_39, st_9 == ((pack_return_code_spec 1 2 st_8));
            when st_11 == ((free_stack "map_unmap_ns" st_0 st_9));
            (Some (v_39, st_11)))
          else (
            when st_9 == ((llvm_memcpy_p0i8_p0i8_i64_spec (mkPtr "stack_s_realm_s2_context" 0) (ptr_offset v_13 16) 32 false st_7));
            when st_10 == ((granule_lock_spec (int_to_ptr v_24_tmp) 5 st_9));
            when st_11 == ((granule_unlock_spec v_8 st_10));
            when st_12 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_24_tmp) v_35 v_36 v_1 v_2 st_11));
            rely ((((st_12.(share)).(granule_data)) = (((st_11.(share)).(granule_data)))));
            when v__sroa_05_0_copyload_tmp, st_13 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_12));
            when v__sroa_8_0_copyload, st_14 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_13));
            if ((v__sroa_8_0_copyload - (v_2)) =? (0))
            then (
              when v__sroa_5_0_copyload, st_15 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_14));
              when v_39, st_16 == ((granule_map_spec (int_to_ptr v__sroa_05_0_copyload_tmp) 6 st_15));
              when v_42, st_17 == ((__tte_read_spec (ptr_offset v_39 (8 * (v__sroa_5_0_copyload))) st_16));
              when v_44, st_18 == ((s2tte_is_unassigned_spec v_42 st_17));
              if v_44
              then (
                when v_50, st_19 == ((s2tte_create_valid_ns_spec v_3 v_2 st_18));
                when st_20 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_5_0_copyload))) v_50 st_19));
                when st_21 == ((__granule_get_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_20));
                when st_23 == ((granule_unlock_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_21));
                when st_24 == ((free_stack "map_unmap_ns" st_0 st_23));
                (Some (0, st_24)))
              else (
                when v_46, st_19 == ((s2tte_is_destroyed_spec v_42 st_18));
                if v_46
                then (
                  when v_50, st_20 == ((s2tte_create_valid_ns_spec v_3 v_2 st_19));
                  when st_21 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_5_0_copyload))) v_50 st_20));
                  when st_22 == ((__granule_get_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_21));
                  when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_22));
                  when st_25 == ((free_stack "map_unmap_ns" st_0 st_24));
                  (Some (0, st_25)))
                else (
                  when v_48, st_20 == ((pack_return_code_spec 9 0 st_19));
                  when st_21 == ((granule_unlock_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_20));
                  when st_22 == ((free_stack "map_unmap_ns" st_0 st_21));
                  (Some (v_48, st_22)))))
            else (
              when v_37, st_15 == ((pack_return_code_spec 8 v__sroa_8_0_copyload st_14));
              when st_16 == ((granule_unlock_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_15));
              when st_17 == ((free_stack "map_unmap_ns" st_0 st_16));
              (Some (v_37, st_17)))))
        else (
          when st_8 == ((llvm_memcpy_p0i8_p0i8_i64_spec (mkPtr "stack_s_realm_s2_context" 0) (ptr_offset v_13 16) 32 false st_6));
          when st_9 == ((granule_lock_spec (int_to_ptr v_24_tmp) 5 st_8));
          when st_10 == ((granule_unlock_spec v_8 st_9));
          when st_11 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_24_tmp) v_35 v_36 v_1 v_2 st_10));
          rely ((((st_11.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
          when v__sroa_05_0_copyload_tmp, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_11));
          when v__sroa_8_0_copyload, st_13 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_12));
          if ((v__sroa_8_0_copyload - (v_2)) =? (0))
          then (
            when v__sroa_5_0_copyload, st_14 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_13));
            when v_39, st_15 == ((granule_map_spec (int_to_ptr v__sroa_05_0_copyload_tmp) 6 st_14));
            when v_42, st_16 == ((__tte_read_spec (ptr_offset v_39 (8 * (v__sroa_5_0_copyload))) st_15));
            when v_53, st_17 == ((s2tte_is_valid_ns_spec v_42 v_2 st_16));
            if v_53
            then (
              when v_57, st_18 == ((s2tte_create_unassigned_spec 1 st_17));
              when st_19 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_5_0_copyload))) v_57 st_18));
              when st_20 == ((__granule_put_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_19));
              if (v_2 =? (3))
              then (
                when st_21 == ((invalidate_page_spec (mkPtr "stack_s_realm_s2_context" 0) v_1 st_20));
                when st_23 == ((granule_unlock_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_21));
                when st_24 == ((free_stack "map_unmap_ns" st_0 st_23));
                (Some (0, st_24)))
              else (
                when st_21 == ((invalidate_block_spec (mkPtr "stack_s_realm_s2_context" 0) v_1 st_20));
                when st_23 == ((granule_unlock_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_21));
                when st_24 == ((free_stack "map_unmap_ns" st_0 st_23));
                (Some (0, st_24))))
            else (
              when v_55, st_18 == ((pack_return_code_spec 9 0 st_17));
              when st_19 == ((granule_unlock_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_18));
              when st_20 == ((free_stack "map_unmap_ns" st_0 st_19));
              (Some (v_55, st_20))))
          else (
            when v_37, st_14 == ((pack_return_code_spec 8 v__sroa_8_0_copyload st_13));
            when st_15 == ((granule_unlock_spec (int_to_ptr v__sroa_05_0_copyload_tmp) st_14));
            when st_16 == ((free_stack "map_unmap_ns" st_0 st_15));
            (Some (v_37, st_16)))))
      else (
        when st_4 == ((granule_unlock_spec v_8 st_3));
        when v_18, st_5 == ((pack_return_code_spec v_15 ((v_15 >> (32)) + (2)) st_4));
        when st_7 == ((free_stack "map_unmap_ns" st_0 st_5));
        (Some (v_18, st_7)))).

End Layer12_map_unmap_ns_LowSpec.

#[global] Hint Unfold map_unmap_ns_spec_low: spec.
