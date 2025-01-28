Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_map_unmap_ns_s1_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition map_unmap_ns_s1_0_low (st_0: RData) (st_12: RData) (v_17: Ptr) (v_3: Z) (v_31: Z) (v__sroa_0_0_copyload_tmp: Z) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_31 =? (0)) = (true)));
    when st_14 == ((stage1_tlbi_all_spec st_12));
    when st_15 == ((__tte_write_spec (ptr_offset v_17 (8 * (v__sroa_7_0_copyload))) (v_3 |' (1024)) st_14));
    when st_16 == ((iasm_8_spec st_15));
    when st_17 == ((iasm_12_isb_spec st_16));
    when st_18 == ((__granule_get_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_17));
    when st_19 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_18));
    when st_20 == ((free_stack "map_unmap_ns_s1" st_0 st_19));
    (Some (0, st_20)).

  Definition map_unmap_ns_s1_1_low (st_0: RData) (st_11: RData) (v_17: Ptr) (v_3: Z) (v__sroa_0_0_copyload_tmp: Z) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely ((((v_3 & (281474976706560)) =? (708837376)) = (true)));
    when st_13 == ((stage1_tlbi_all_spec st_11));
    when st_14 == ((__tte_write_spec (ptr_offset v_17 (8 * (v__sroa_7_0_copyload))) (v_3 |' (1024)) st_13));
    when st_15 == ((iasm_8_spec st_14));
    when st_16 == ((iasm_12_isb_spec st_15));
    when st_17 == ((__granule_get_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_16));
    when st_18 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_17));
    when st_19 == ((free_stack "map_unmap_ns_s1" st_0 st_18));
    (Some (0, st_19)).

  Definition map_unmap_ns_s1_2_low (st_0: RData) (st_12: RData) (v_17: Ptr) (v_47: Z) (v__sroa_0_0_copyload_tmp: Z) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_47 =? (0)) = (true)));
    when v_51, st_14 == ((s2tte_create_unassigned_spec 1 st_12));
    when st_15 == ((__tte_write_spec (ptr_offset v_17 (8 * (v__sroa_7_0_copyload))) v_51 st_14));
    when st_16 == ((iasm_8_spec st_15));
    when st_17 == ((iasm_12_isb_spec st_16));
    when st_18 == ((stage1_tlbi_all_spec st_17));
    when st_19 == ((__granule_put_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_18));
    when st_20 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_19));
    when st_21 == ((free_stack "map_unmap_ns_s1" st_0 st_20));
    (Some (0, st_21)).

  Definition map_unmap_ns_s1_3_low (st_0: RData) (st_11: RData) (v_17: Ptr) (v_20: Z) (v__sroa_0_0_copyload_tmp: Z) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely ((((v_20 & (281474976706560)) =? (708837376)) = (true)));
    when v_51, st_13 == ((s2tte_create_unassigned_spec 1 st_11));
    when st_14 == ((__tte_write_spec (ptr_offset v_17 (8 * (v__sroa_7_0_copyload))) v_51 st_13));
    when st_15 == ((iasm_8_spec st_14));
    when st_16 == ((iasm_12_isb_spec st_15));
    when st_17 == ((stage1_tlbi_all_spec st_16));
    when st_18 == ((__granule_put_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_17));
    when st_19 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_18));
    when st_20 == ((free_stack "map_unmap_ns_s1" st_0 st_19));
    (Some (0, st_20)).

  Definition map_unmap_ns_s1_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "map_unmap_ns_s1" st));
    when v_8, st_1 == ((find_granule_spec v_0 st_0));
    rely ((((v_8.(pbase)) = ("granules")) \/ (((v_8.(pbase)) = ("null")))));
    if (ptr_eqb v_8 (mkPtr "null" 0))
    then (
      when v_10, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "map_unmap_ns_s1" st_0 st_2));
      (Some (v_10, st_4)))
    else (
      when st_3 == ((granule_lock_spec v_8 5 st_1));
      when st_4 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) v_8 0 64 v_1 v_2 st_3));
      rely ((((st_4.(share)).(granule_data)) = (((st_3.(share)).(granule_data)))));
      when v__sroa_0_0_copyload_tmp, st_5 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_4));
      when v__sroa_10_0_copyload, st_6 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_5));
      if ((v__sroa_10_0_copyload - (v_2)) =? (0))
      then (
        when v__sroa_7_0_copyload, st_8 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_6));
        when v_17, st_9 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_8));
        when v_20, st_10 == ((__tte_read_spec (ptr_offset v_17 (8 * (v__sroa_7_0_copyload))) st_9));
        if (v_4 =? (0))
        then (
          when v_23, st_11 == ((s2tte_is_unassigned_spec v_20 st_10));
          if v_23
          then (
            if ((v_3 & (281474976706560)) =? (708837376))
            then (map_unmap_ns_s1_1_low st_0 st_11 v_17 v_3 v__sroa_0_0_copyload_tmp v__sroa_7_0_copyload)
            else (
              when v_31, st_12 == ((smc_granule_ns_to_any_spec v_1 (v_3 & (281474976706560)) st_11));
              if (v_31 =? (0))
              then (map_unmap_ns_s1_0_low st_0 st_12 v_17 v_3 v_31 v__sroa_0_0_copyload_tmp v__sroa_7_0_copyload)
              else (
                when v_33, st_13 == ((pack_return_code_spec 1 4 st_12));
                when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_13));
                when st_16 == ((free_stack "map_unmap_ns_s1" st_0 st_14));
                (Some (v_33, st_16)))))
          else (
            when v_25, st_12 == ((pack_return_code_spec 9 0 st_11));
            when st_13 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_12));
            when st_15 == ((free_stack "map_unmap_ns_s1" st_0 st_13));
            (Some (v_25, st_15))))
        else (
          if (v_4 =? (1))
          then (
            when v_39, st_11 == ((s1tte_is_valid_spec v_20 v_2 st_10));
            if v_39
            then (
              if ((v_20 & (281474976706560)) =? (708837376))
              then (map_unmap_ns_s1_3_low st_0 st_11 v_17 v_20 v__sroa_0_0_copyload_tmp v__sroa_7_0_copyload)
              else (
                when v_47, st_12 == ((smc_granule_any_to_ns_spec (v_20 & (281474976706560)) st_11));
                if (v_47 =? (0))
                then (map_unmap_ns_s1_2_low st_0 st_12 v_17 v_47 v__sroa_0_0_copyload_tmp v__sroa_7_0_copyload)
                else (
                  when v_49, st_13 == ((pack_return_code_spec 1 2 st_12));
                  when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_13));
                  when st_16 == ((free_stack "map_unmap_ns_s1" st_0 st_14));
                  (Some (v_49, st_16)))))
            else (
              when v_41, st_12 == ((pack_return_code_spec 9 0 st_11));
              when st_13 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_12));
              when st_15 == ((free_stack "map_unmap_ns_s1" st_0 st_13));
              (Some (v_41, st_15))))
          else (
            when st_12 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_10));
            when st_13 == ((free_stack "map_unmap_ns_s1" st_0 st_12));
            (Some (0, st_13)))))
      else (
        when v_15, st_7 == ((pack_return_code_spec 8 v__sroa_10_0_copyload st_6));
        when st_8 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_7));
        when st_10 == ((free_stack "map_unmap_ns_s1" st_0 st_8));
        (Some (v_15, st_10)))).


End Layer8_map_unmap_ns_s1_LowSpec.

#[global] Hint Unfold map_unmap_ns_s1_spec_low: spec.
#[global] Hint Unfold map_unmap_ns_s1_0_low: spec.
#[global] Hint Unfold map_unmap_ns_s1_1_low: spec.
#[global] Hint Unfold map_unmap_ns_s1_2_low: spec.
#[global] Hint Unfold map_unmap_ns_s1_3_low: spec.
