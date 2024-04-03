Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTInit_realm_ipa_to_pa_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_ipa_to_pa_spec_low (v_rd: Ptr) (v_ipa: Z) (v_s2_walk: Ptr) (st: RData) : (option (Z * RData)) :=
    when st == ((new_frame "realm_ipa_to_pa" st));
    let init_st := st in
    rely (
      (((v_rd.(pbase)) = ("slot_rd")) /\
        (((((v_s2_walk.(pbase)) = ("rsi_walk_smc_result_stack")) \/ (((v_s2_walk.(pbase)) = ("do_host_call_stack")))) \/
          (((v_s2_walk.(pbase)) = ("attest_token_continue_write_state_stack")))))));
    when v_wi, st == ((alloc_stack "realm_ipa_to_pa" 24 8 st));
    let v_rem := (v_ipa & (4095)) in
    let v_cmp := (v_rem =? (0)) in
    match (
      let __retval__ := 0 in
      let __return__ := false in
      if v_cmp
      then (
        when v_call, st == ((addr_in_par_spec v_rd v_ipa st));
        match (
          let __retval__ := 0 in
          let __return__ := false in
          if v_call
          then (
            let v_g_rtt := (ptr_offset v_rd ((456 * (0)) + ((16 + ((16 + (0))))))) in
            when v_0_tmp, st == ((load_RData 8 v_g_rtt st));
            let v_0 := (int_to_ptr v_0_tmp) in
            when st == ((granule_lock_spec v_0 6 st));
            when v_call1, st == ((realm_rtt_starting_level_spec v_rd st));
            when v_call2, st == ((realm_ipa_bits_spec v_rd st));
            when st == ((rtt_walk_lock_unlock_spec v_0 v_call1 v_call2 v_ipa 3 v_wi st));
            let v_g_llt := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in
            when v_1_tmp, st == ((load_RData 8 v_g_llt st));
            let v_1 := (int_to_ptr v_1_tmp) in
            when v_call3, st == ((granule_map_spec v_1 22 st));
            let v_2 := v_call3 in
            when v_3_tmp, st == ((load_RData 8 v_g_llt st));
            let v_3 := (int_to_ptr v_3_tmp) in
            let v_llt := (ptr_offset v_s2_walk ((32 * (0)) + ((24 + (0))))) in
            when st == ((store_RData 8 v_llt (ptr_to_int v_3) st));
            let v_index := (ptr_offset v_wi ((24 * (0)) + ((8 + (0))))) in
            when v_4, st == ((load_RData 8 v_index st));
            let v_arrayidx := (ptr_offset v_2 ((8 * (v_4)) + (0))) in
            when v_call5, st == ((__tte_read_spec v_arrayidx st));
            let v_last_level := (ptr_offset v_wi ((24 * (0)) + ((16 + (0))))) in
            when v_5, st == ((load_RData 8 v_last_level st));
            when v_call6, st == ((s2tte_is_valid_spec v_call5 v_5 st));
            when v_walk_status_0, st == (
                let v_walk_status_0 := 0 in
                if v_call6
                then (
                  when v_8, st == ((load_RData 8 v_last_level st));
                  when v_call16, st == ((s2tte_pa_spec v_call5 v_8 st));
                  let v_pa := (ptr_offset v_s2_walk ((32 * (0)) + ((0 + (0))))) in
                  when st == ((store_RData 8 v_pa v_call16 st));
                  when v_9, st == ((load_RData 8 v_last_level st));
                  let v_conv := v_9 in
                  when v_call18, st == ((s2tte_map_size_spec v_conv st));
                  let v_sub := (v_call18 + ((- 1))) in
                  let v_and := (v_sub & (v_ipa)) in
                  when v_10, st == ((load_RData 8 v_pa st));
                  let v_add := (v_and + (v_10)) in
                  when st == ((store_RData 8 v_pa v_add st));
                  let v_ripas20 := (ptr_offset v_s2_walk ((32 * (0)) + ((16 + (0))))) in
                  when st == ((store_RData 4 v_ripas20 1 st));
                  let v_walk_status_0 := 0 in
                  (Some (v_walk_status_0, st)))
                else (
                  when v_6, st == ((load_RData 8 v_last_level st));
                  let v_rtt_level := (ptr_offset v_s2_walk ((32 * (0)) + ((8 + (0))))) in
                  when st == ((store_RData 8 v_rtt_level v_6 st));
                  when v_call9, st == ((s2tte_is_destroyed_spec v_call5 st));
                  when st == (
                      if v_call9
                      then (
                        let v_destroyed := (ptr_offset v_s2_walk ((32 * (0)) + ((20 + (0))))) in
                        when st == ((store_RData 1 v_destroyed 1 st));
                        (Some st))
                      else (
                        when v_call11, st == ((s2tte_get_ripas_spec v_call5 st));
                        let v_ripas := (ptr_offset v_s2_walk ((32 * (0)) + ((16 + (0))))) in
                        when st == ((store_RData 4 v_ripas v_call11 st));
                        (Some st)));
                  when v_7_tmp, st == ((load_RData 8 v_g_llt st));
                  let v_7 := (int_to_ptr v_7_tmp) in
                  when st == ((granule_unlock_spec v_7 st));
                  let v_walk_status_0 := 2 in
                  (Some (v_walk_status_0, st))));
            when st == ((buffer_unmap_spec v_call3 st));
            let v_retval_0 := v_walk_status_0 in
            let __return__ := true in
            let __retval__ := v_retval_0 in
            (Some (__return__, __retval__, st)))
          else (Some (__return__, __retval__, st))
        ) with
        | (Some (__return__, __retval__, st)) =>
          if __return__
          then (Some (__return__, __retval__, st))
          else (Some (__return__, __retval__, st))
        | None => None
        end)
      else (Some (__return__, __retval__, st))
    ) with
    | (Some (__return__, __retval__, st)) =>
      if __return__
      then (
        when st == ((free_stack "realm_ipa_to_pa" init_st st));
        (Some (__retval__, st)))
      else (
        let v_retval_0 := 1 in
        let __return__ := true in
        let __retval__ := v_retval_0 in
        when st == ((free_stack "realm_ipa_to_pa" init_st st));
        (Some (__retval__, st)))
    | None => None
    end.

End S2TTInit_realm_ipa_to_pa_LowSpec.

#[global] Hint Unfold realm_ipa_to_pa_spec_low: spec.
