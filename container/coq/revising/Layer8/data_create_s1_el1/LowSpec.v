Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_data_create_s1_el1_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition data_create_s1_el1_0_low (st_0: RData) (st_7: RData) (v_25: Z) : (option (Z * RData)) :=
    rely (((v_25 =? (0)) = (true)));
    when v_29_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_7));
    when st_10 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_9));
    when v_30_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_10));
    when st_12 == ((granule_unlock_transition_spec (int_to_ptr v_30_tmp) 4 st_11));
    when st_15 == ((free_stack "data_create_s1_el1" st_0 st_12));
    (Some (((v_25 << (32)) >> (32)), st_15)).

  Definition data_create_s1_el1_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "data_create_s1_el1" st));
    rely (((((v_3.(pbase)) = ("granules")) /\ ((((v_3.(poffset)) mod (16)) = (0)))) /\ (((v_3.(poffset)) >= (0)))));
    when v_7, st_1 == ((s1tte_pa_spec v_0 st_0));
    when v_8, st_2 == ((find_lock_two_granules_spec v_7 1 (mkPtr "stack_type_4" 0) v_1 3 (mkPtr "stack_type_4__1" 0) st_1));
    if (v_8 =? (3))
    then (
      when v_11, st_3 == ((pack_return_code_spec 3 0 st_2));
      when st_5 == ((free_stack "data_create_s1_el1" st_0 st_3));
      (Some (v_11, st_5)))
    else (
      if (v_8 =? (0))
      then (
        when v_19_tmp, st_3 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_2));
        when v_20, st_4 == ((granule_map_spec (int_to_ptr v_19_tmp) 3 st_3));
        rely (((((v_20.(pbase)) = ("granule_data")) /\ (((v_20.(poffset)) >= (0)))) /\ ((((v_20.(poffset)) mod (4096)) = (0)))));
        rely ((((((st_4.(share)).(granule_data)) @ ((v_20.(poffset)) / (4096))).(g_granule_state)) = (GRANULE_STATE_REC)));
        when v_24_tmp, st_5 == ((load_RData 8 (ptr_offset v_20 1544) st_4));
        when st_6 == ((granule_lock_spec (int_to_ptr v_24_tmp) 5 st_5));
        when v_25, st_7 == ((data_create_internal_spec v_0 (int_to_ptr v_24_tmp) v_2 v_3 v_20 1 st_6));
        if (v_25 =? (0))
        then (data_create_s1_el1_0_low st_0 st_7 v_25)
        else (
          when v_29_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_7));
          when st_10 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_9));
          when v_30_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_10));
          when st_12 == ((granule_unlock_transition_spec (int_to_ptr v_30_tmp) 1 st_11));
          when st_15 == ((free_stack "data_create_s1_el1" st_0 st_12));
          (Some (((v_25 << (32)) >> (32)), st_15))))
      else (
        when v_16, st_3 == ((pack_return_code_spec 1 ((v_8 >> (32)) + (1)) st_2));
        when st_6 == ((free_stack "data_create_s1_el1" st_0 st_3));
        (Some (v_16, st_6)))).

End Layer8_data_create_s1_el1_LowSpec.

#[global] Hint Unfold data_create_s1_el1_0_low: spec.
#[global] Hint Unfold data_create_s1_el1_spec_low: spec.
