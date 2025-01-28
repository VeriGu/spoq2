Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_rtt_set_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_rtt_set_ripas_0_low (st_0: RData) (st_10: RData) (v_34: Ptr) (v_38: bool) (v__sroa_0_0_copyload_tmp: Z) (v__sroa_3_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_38 = (true)));
    when v_44, st_11 == ((load_RData 8 (mkPtr "stack_type_3" 0) st_10));
    when st_12 == ((__tte_write_spec (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) v_44 st_11));
    when st_13 == ((iasm_8_spec st_12));
    when st_14 == ((stage1_tlbi_all_spec st_13));
    when st_16 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_14));
    when st_15 == ((free_stack "rsi_rtt_set_ripas" st_0 st_16));
    (Some (0, st_15)).

  Definition rsi_rtt_set_ripas_1_low (st_0: RData) (st_14: RData) (v_34: Ptr) (v_38: bool) (v__sroa_0_0_copyload_tmp: Z) (v__sroa_3_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_38 = (true)));
    when v_44, st_15 == ((load_RData 8 (mkPtr "stack_type_3" 0) st_14));
    when st_16 == ((__tte_write_spec (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) v_44 st_15));
    when st_17 == ((iasm_8_spec st_16));
    when st_18 == ((stage1_tlbi_all_spec st_17));
    when st_19 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_18));
    when st_20 == ((free_stack "rsi_rtt_set_ripas" st_0 st_19));
    (Some (0, st_20)).



  Definition rsi_rtt_set_ripas_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "rsi_rtt_set_ripas" st));
    if (v_3 >? (1))
    then (
      when st_2 == ((free_stack "rsi_rtt_set_ripas" st_0 st_0));
      (Some (1, st_2)))
    else (
      if ((v_0 & (1)) =? (0))
      then (
        when v_24, st_1 == ((find_lock_granule_spec v_0 5 st_0));
        rely (((((v_24.(poffset)) mod (16)) = (0)) /\ (((v_24.(poffset)) >= (0)))));
        rely ((((v_24.(pbase)) = ("granules")) \/ (((v_24.(pbase)) = ("null")))));
        if (ptr_eqb v_24 (mkPtr "null" 0))
        then (
          when v_26, st_2 == ((pack_return_code_spec 1 1 st_1));
          when st_4 == ((free_stack "rsi_rtt_set_ripas" st_0 st_2));
          (Some (v_26, st_4)))
        else (
          when st_3 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) v_24 0 64 v_1 v_2 st_1));
          rely ((((st_3.(share)).(granule_data)) = (((st_1.(share)).(granule_data)))));
          when v__sroa_0_0_copyload_tmp, st_4 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_3));
          when v__sroa_5_0_copyload, st_5 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_4));
          if ((v__sroa_5_0_copyload - (v_2)) =? (0))
          then (
            when v__sroa_3_0_copyload, st_6 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_5));
            when v_34, st_7 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_6));
            when v_37, st_8 == ((__tte_read_spec (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) st_7));
            when st_9 == ((store_RData 8 (mkPtr "stack_type_3" 0) v_37 st_8));
            when v_38, st_10 == ((update_ripas_spec (mkPtr "stack_type_3" 0) v_2 v_3 st_9));
            if v_38
            then (rsi_rtt_set_ripas_0_low st_0 st_10 v_34 v_38 v__sroa_0_0_copyload_tmp v__sroa_3_0_copyload)
            else (
              when v_41, st_11 == ((pack_return_code_spec 8 v_2 st_10));
              when st_13 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_11));
              when st_12 == ((free_stack "rsi_rtt_set_ripas" st_0 st_13));
              (Some (v_41, st_12))))
          else (
            when v_31, st_6 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_5));
            when st_7 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_6));
            when st_8 == ((free_stack "rsi_rtt_set_ripas" st_0 st_7));
            (Some (v_31, st_8)))))
      else (
        when v_14, st_1 == ((find_lock_granule_spec (v_0 & ((- 2))) 3 st_0));
        rely (((((v_14.(poffset)) mod (16)) = (0)) /\ (((v_14.(poffset)) >= (0)))));
        rely ((((v_14.(pbase)) = ("granules")) \/ (((v_14.(pbase)) = ("null")))));
        if (ptr_eqb v_14 (mkPtr "null" 0))
        then (
          when v_16, st_2 == ((pack_return_code_spec 1 1 st_1));
          when st_4 == ((free_stack "rsi_rtt_set_ripas" st_0 st_2));
          (Some (v_16, st_4)))
        else (
          when v_19, st_2 == ((granule_map_spec v_14 3 st_1));
          when v_22_tmp, st_3 == ((load_RData 8 (ptr_offset v_19 1544) st_2));
          when st_4 == ((granule_lock_spec (int_to_ptr v_22_tmp) 5 st_3));
          when st_5 == ((granule_unlock_spec v_14 st_4));
          when st_7 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_22_tmp) 0 64 v_1 v_2 st_5));
          rely ((((st_7.(share)).(granule_data)) = (((st_5.(share)).(granule_data)))));
          when v__sroa_0_0_copyload_tmp, st_8 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_7));
          when v__sroa_5_0_copyload, st_9 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_8));
          if ((v__sroa_5_0_copyload - (v_2)) =? (0))
          then (
            when v__sroa_3_0_copyload, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_9));
            when v_34, st_11 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_10));
            when v_37, st_12 == ((__tte_read_spec (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) st_11));
            when st_13 == ((store_RData 8 (mkPtr "stack_type_3" 0) v_37 st_12));
            when v_38, st_14 == ((update_ripas_spec (mkPtr "stack_type_3" 0) v_2 v_3 st_13));
            if v_38
            then (rsi_rtt_set_ripas_1_low st_0 st_14 v_34 v_38 v__sroa_0_0_copyload_tmp v__sroa_3_0_copyload)
            else (
              when v_41, st_15 == ((pack_return_code_spec 8 v_2 st_14));
              when st_16 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_15));
              when st_17 == ((free_stack "rsi_rtt_set_ripas" st_0 st_16));
              (Some (v_41, st_17))))
          else (
            when v_31, st_10 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_9));
            when st_11 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_10));
            when st_12 == ((free_stack "rsi_rtt_set_ripas" st_0 st_11));
            (Some (v_31, st_12)))))).

End Layer9_rsi_rtt_set_ripas_LowSpec.

#[global] Hint Unfold rsi_rtt_set_ripas_spec_low: spec.
#[global] Hint Unfold rsi_rtt_set_ripas_0_low: spec.
#[global] Hint Unfold rsi_rtt_set_ripas_1_low: spec.
