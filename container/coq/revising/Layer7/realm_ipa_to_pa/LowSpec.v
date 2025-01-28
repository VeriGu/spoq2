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

Section Layer7_realm_ipa_to_pa_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_ipa_to_pa_0_low (st_0: RData) (st_13: RData) (v_1: Z) (v_2: Ptr) (v_21: Z) (v_22: bool) (v__sroa_5_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_22 = (true)));
    when v_25, st_14 == ((s2tte_pa_spec v_21 v__sroa_5_0_copyload st_13));
    when st_15 == ((store_RData 8 v_2 v_25 st_14));
    when v_27, st_16 == ((s2tte_map_size_spec v__sroa_5_0_copyload st_15));
    when v_30, st_17 == ((load_RData 8 v_2 st_16));
    when st_18 == ((store_RData 8 v_2 (((v_27 + ((- 1))) & (v_1)) + (v_30)) st_17));
    when st_22 == ((free_stack "realm_ipa_to_pa" st_0 st_18));
    (Some (0, st_22)).

  Definition realm_ipa_to_pa_spec_low (v_0: Ptr) (v_1: Z) (v_2: Ptr) (v_3: Ptr) (v_4: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "realm_ipa_to_pa" st));
    rely ((((v_4.(pbase)) = ("stack_type_3")) /\ (((v_4.(poffset)) = (0)))));
    rely ((((v_3.(pbase)) = ("stack_type_4")) /\ (((v_3.(poffset)) = (0)))));
    rely ((((v_2.(pbase)) = ("stack_type_3__1")) /\ (((v_2.(poffset)) = (0)))));
    rely (((((((st_0.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    if ((v_1 & (4095)) =? (0))
    then (
      when v_11, st_1 == ((is_addr_in_par_spec v_0 v_1 st_0));
      if v_11
      then (
        when v_15_tmp, st_2 == ((load_RData 8 (ptr_offset v_0 32) st_1));
        when st_3 == ((granule_lock_spec (int_to_ptr v_15_tmp) 5 st_2));
        when v_16, st_4 == ((realm_rtt_starting_level_spec v_0 st_3));
        when v_17, st_5 == ((realm_ipa_bits_spec v_0 st_4));
        when st_6 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_15_tmp) v_16 v_17 v_1 3 st_5));
        rely ((((st_6.(share)).(granule_data)) = (((st_5.(share)).(granule_data)))));
        when v__sroa_0_0_copyload_tmp, st_7 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_6));
        when v__sroa_4_0_copyload, st_8 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_7));
        when v__sroa_5_0_copyload, st_9 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_8));
        when v_18, st_10 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_9));
        when st_11 == ((store_RData 8 v_3 v__sroa_0_0_copyload_tmp st_10));
        when v_21, st_12 == ((__tte_read_spec (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) st_11));
        when v_22, st_13 == ((s2tte_is_valid_spec v_21 v__sroa_5_0_copyload st_12));
        if v_22
        then (realm_ipa_to_pa_0_low st_0 st_13 v_1 v_2 v_21 v_22 v__sroa_5_0_copyload)
        else (
          when st_14 == ((store_RData 8 v_4 v__sroa_5_0_copyload st_13));
          when st_15 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_14));
          when st_19 == ((free_stack "realm_ipa_to_pa" st_0 st_15));
          (Some (2, st_19))))
      else (
        when st_4 == ((free_stack "realm_ipa_to_pa" st_0 st_1));
        (Some (1, st_4))))
    else (
      when st_2 == ((free_stack "realm_ipa_to_pa" st_0 st_0));
      (Some (1, st_2))).



End Layer7_realm_ipa_to_pa_LowSpec.

#[global] Hint Unfold realm_ipa_to_pa_spec_low: spec.
#[global] Hint Unfold realm_ipa_to_pa_0_low: spec.
