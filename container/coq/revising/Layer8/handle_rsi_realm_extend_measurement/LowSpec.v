Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_handle_rsi_realm_extend_measurement_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition handle_rsi_realm_extend_measurement_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "handle_rsi_realm_extend_measurement" st));
    rely (((((((st_0.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_4_tmp, st_1 == ((load_RData 8 (ptr_offset v_0 944) st_0));
    when st_2 == ((granule_lock_spec (int_to_ptr v_4_tmp) 2 st_1));
    when v_5_tmp, st_3 == ((load_RData 8 (ptr_offset v_0 944) st_2));
    when v_6, st_4 == ((granule_map_spec (int_to_ptr v_5_tmp) 2 st_3));
    when v_8, st_5 == ((load_RData 8 (ptr_offset v_0 32) st_4));
    if (((v_8 + ((- 7))) - ((- 6))) <? (0))
    then (
      when v_13, st_6 == ((pack_return_code_spec 1 1 st_5));
      when v_33_tmp, st_8 == ((load_RData 8 (ptr_offset v_0 944) st_6));
      when st_9 == ((granule_unlock_spec (int_to_ptr v_33_tmp) st_8));
      when st_10 == ((free_stack "handle_rsi_realm_extend_measurement" st_0 st_9));
      (Some (v_13, st_10)))
    else (
      when v_16, st_6 == ((load_RData 8 (ptr_offset v_0 40) st_5));
      if (v_16 >? (64))
      then (
        when v_19, st_7 == ((pack_return_code_spec 1 2 st_6));
        when v_33_tmp, st_10 == ((load_RData 8 (ptr_offset v_0 944) st_7));
        when st_11 == ((granule_unlock_spec (int_to_ptr v_33_tmp) st_10));
        when st_12 == ((free_stack "handle_rsi_realm_extend_measurement" st_0 st_11));
        (Some (v_19, st_12)))
      else (
        rely ((((0 - ((v_8 & (4294967295)))) <= (0)) /\ (((v_8 & (4294967295)) < (7)))));
        when v_29, st_7 == ((memcpy_spec (ptr_offset (mkPtr "stack_type_8" 0) 0) (ptr_offset (ptr_offset v_6 184) (32 * ((v_8 & (4294967295))))) 32 st_6));
        when v_31, st_8 == ((memcpy_spec (ptr_offset (mkPtr "stack_type_8" 0) 32) (ptr_offset v_0 48) v_16 st_7));
        when v_33_tmp, st_11 == ((load_RData 8 (ptr_offset v_0 944) st_8));
        when st_12 == ((granule_unlock_spec (int_to_ptr v_33_tmp) st_11));
        when st_13 == ((free_stack "handle_rsi_realm_extend_measurement" st_0 st_12));
        (Some (0, st_13)))).

End Layer8_handle_rsi_realm_extend_measurement_LowSpec.

#[global] Hint Unfold handle_rsi_realm_extend_measurement_spec_low: spec.
