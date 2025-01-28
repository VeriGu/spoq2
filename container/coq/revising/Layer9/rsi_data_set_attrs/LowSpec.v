Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_set_attrs_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_set_attrs_0_low (st_0: RData) (st_4: RData) (v_2: Z) (v__sroa_0_0_copyload_tmp: Z) (v__sroa_6_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v__sroa_6_0_copyload =? (3)) = (true)));
    when v__sroa_3_0_copyload, st_5 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_4));
    when v_16, st_6 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_5));
    when v_19, st_7 == ((__tte_read_spec (ptr_offset v_16 (8 * (v__sroa_3_0_copyload))) st_6));
    when st_8 == ((store_RData 8 (mkPtr "stack_type_3" 0) v_19 st_7));
    when st_9 == ((masked_assign_spec (mkPtr "stack_type_3" 0) v_2 18446462598732845055 st_8));
    when st_10 == ((__tte_write_spec (ptr_offset v_16 (8 * (v__sroa_3_0_copyload))) 0 st_9));
    when st_11 == ((iasm_8_spec st_10));
    when st_12 == ((stage1_tlbi_all_spec st_11));
    when v_20, st_13 == ((load_RData 8 (mkPtr "stack_type_3" 0) st_12));
    when st_14 == ((store_RData 8 (mkPtr "stack_type_3" 0) (v_20 |' (1024)) st_13));
    when st_15 == ((__tte_write_spec (ptr_offset v_16 (8 * (v__sroa_3_0_copyload))) (v_20 |' (1024)) st_14));
    when st_16 == ((iasm_8_spec st_15));
    when st_17 == ((iasm_12_isb_spec st_16));
    when st_19 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_17));
    when st_21 == ((free_stack "rsi_data_set_attrs" st_0 st_19));
    (Some (0, st_21)).


  Definition rsi_data_set_attrs_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "rsi_data_set_attrs" st));
    when v_7, st_1 == ((find_lock_granule_spec v_0 5 st_0));
    rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
    rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
    if (ptr_eqb v_7 (mkPtr "null" 0))
    then (
      when v_9, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "rsi_data_set_attrs" st_0 st_2));
      (Some (v_9, st_4)))
    else (
      when st_2 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) v_7 0 64 v_1 3 st_1));
      rely ((((st_2.(share)).(granule_data)) = (((st_1.(share)).(granule_data)))));
      when v__sroa_0_0_copyload_tmp, st_3 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_2));
      when v__sroa_6_0_copyload, st_4 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_3));
      if (v__sroa_6_0_copyload =? (3))
      then (rsi_data_set_attrs_0_low st_0 st_4 v_2 v__sroa_0_0_copyload_tmp v__sroa_6_0_copyload)
      else (
        when v_14, st_5 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_4));
        when st_7 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_5));
        when st_9 == ((free_stack "rsi_data_set_attrs" st_0 st_7));
        (Some (v_14, st_9)))).

 
End Layer9_rsi_data_set_attrs_LowSpec.

#[global] Hint Unfold rsi_data_set_attrs_spec_low: spec.
#[global] Hint Unfold rsi_data_set_attrs_0_low: spec.
