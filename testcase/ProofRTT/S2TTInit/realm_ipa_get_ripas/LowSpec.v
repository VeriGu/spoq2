Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTInit_realm_ipa_get_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_ipa_get_ripas_1_low (v_call: Ptr) (v_g_llt: Ptr) (v_ws_0: Z) (init_st: RData) (st: RData) : (option (Z * RData)) :=
    rely (((v_call.(pbase)) = ("slot_rtt")));
    rely (((v_g_llt.(pbase)) = ("realm_ipa_get_ripas_stack")));
    when st == ((buffer_unmap_spec v_call st));
    when v_8_tmp, st == ((load_RData 8 v_g_llt st));
    rely (((v_8_tmp < (STACK_VIRT)) /\ ((v_8_tmp >= (GRANULES_BASE)))));
    let v_8 := (int_to_ptr v_8_tmp) in
    when st == ((granule_unlock_spec v_8 st));
    let __retval__ := v_ws_0 in
    when st == ((free_stack "realm_ipa_get_ripas" init_st st));
    (Some (__retval__, st)).

  Definition realm_ipa_get_ripas_spec_low (v_rec: Ptr) (v_ipa: Z) (v_ripas_ptr: Ptr) (v_rtt_level: Ptr) (st: RData) : (option (Z * RData)) :=
    when st == ((new_frame "realm_ipa_get_ripas" st));
    let init_st := st in
    rely (
      (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_ripas_ptr.(pbase)) = ("handle_rsi_ipa_state_get_stack")))) /\
        (((v_rtt_level.(pbase)) = ("handle_rsi_ipa_state_get_stack")))));
    when v_wi, st == ((alloc_stack "realm_ipa_get_ripas" 24 8 st));
    let v_g_rtt := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((16 + (0))))))) in
    when v_0_tmp, st == ((load_RData 8 v_g_rtt st));
    rely (((v_0_tmp < (STACK_VIRT)) /\ ((v_0_tmp >= (GRANULES_BASE)))));
    let v_0 := (int_to_ptr v_0_tmp) in
    when st == ((granule_lock_spec v_0 6 st));
    when v_1_tmp, st == ((load_RData 8 v_g_rtt st));
    rely (((v_1_tmp < (STACK_VIRT)) /\ ((v_1_tmp >= (GRANULES_BASE)))));
    let v_1 := (int_to_ptr v_1_tmp) in
    let v_s2_starting_level := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((8 + (0))))))) in
    when v_2, st == ((load_RData 4 v_s2_starting_level st));
    let v_ipa_bits := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((0 + (0))))))) in
    when v_3, st == ((load_RData 8 v_ipa_bits st));
    when st == ((rtt_walk_lock_unlock_spec v_1 v_2 v_3 v_ipa 3 v_wi st));
    let v_g_llt := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in
    when v_4_tmp, st == ((load_RData 8 v_g_llt st));
    rely (((v_4_tmp < (STACK_VIRT)) /\ ((v_4_tmp >= (GRANULES_BASE)))));
    let v_4 := (int_to_ptr v_4_tmp) in
    when v_call, st == ((granule_map_spec v_4 22 st));
    let v_5 := v_call in
    let v_index := (ptr_offset v_wi ((24 * (0)) + ((8 + (0))))) in
    when v_6, st == ((load_RData 8 v_index st));
    let v_arrayidx := (ptr_offset v_5 ((8 * (v_6)) + (0))) in
    when v_call5, st == ((__tte_read_spec v_arrayidx st));
    when v_call6, st == ((s2tte_is_destroyed_spec v_call5 st));
    when v_ws_0, st == (
        let v_ws_0 := 0 in
        if v_call6
        then (
          let v_last_level := (ptr_offset v_wi ((24 * (0)) + ((16 + (0))))) in
          when v_7, st == ((load_RData 8 v_last_level st));
          when st == ((store_RData 8 v_rtt_level v_7 st));
          let v_ws_0 := 2 in
          (Some (v_ws_0, st)))
        else (
          when v_call7, st == ((s2tte_get_ripas_spec v_call5 st));
          when st == ((store_RData 4 v_ripas_ptr v_call7 st));
          let v_ws_0 := 0 in
          (Some (v_ws_0, st))));
    (realm_ipa_get_ripas_1_low v_call v_g_llt v_ws_0 init_st st).

End S2TTInit_realm_ipa_get_ripas_LowSpec.

#[global] Hint Unfold realm_ipa_get_ripas_1_low: spec.
#[global] Hint Unfold realm_ipa_get_ripas_spec_low: spec.
