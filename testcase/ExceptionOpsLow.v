Definition ipa_is_empty_spec_low (v_ipa: Z) (v_rec: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  rely (rec_is_locked st);
  when st == ((new_frame "ipa_is_empty" st));
  let init_st := st in
  when v_wi, st == ((alloc_stack "ipa_is_empty" 24 8 st));
  when v_call, st == ((addr_in_rec_par_spec v_rec v_ipa st));
  when v_retval_0, st == (
      let v_retval_0 := false in
      if v_call
      then (
        let v_g_rtt := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((16 + (0))))))) in
        when v_0_tmp, st == ((load_RData 8 v_g_rtt st));
        rely (v_0_tmp > 0 /\ ((v_0_tmp >= GRANULES_BASE) /\ (v_0_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
        let v_0 := (int_to_ptr v_0_tmp) in
        when st == ((granule_lock_spec v_0 6 st));
        when v_1_tmp, st == ((load_RData 8 v_g_rtt st));
        rely (v_1_tmp > 0 /\ ((v_1_tmp >= GRANULES_BASE) /\ (v_1_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
        let v_1 := (int_to_ptr v_1_tmp) in
        let v_s2_starting_level := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((8 + (0))))))) in
        when v_2, st == ((load_RData 4 v_s2_starting_level st));
        let v_ipa_bits := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((0 + (0))))))) in
        when v_3, st == ((load_RData 8 v_ipa_bits st));
        when st == ((rtt_walk_lock_unlock_spec v_1 v_2 v_3 v_ipa 3 v_wi st));
        let v_g_llt := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in
        when v_4_tmp, st == ((load_RData 8 v_g_llt st));
        rely (v_4_tmp > 0 /\ ((v_4_tmp >= GRANULES_BASE) /\ (v_4_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
        let v_4 := (int_to_ptr v_4_tmp) in
        when v_call5, st == ((granule_map_spec v_4 22 st));
        let v_5 := v_call5 in
        let v_index := (ptr_offset v_wi ((24 * (0)) + ((8 + (0))))) in
        when v_6, st == ((load_RData 8 v_index st));
        let v_arrayidx := (ptr_offset v_5 ((8 * (v_6)) + (0))) in
        when v_call6, st == ((__tte_read_spec v_arrayidx st));
        when v_call7, st == ((s2tte_is_destroyed_spec v_call6 st));
        when v_ret_0_off0, st == (
            let v_ret_0_off0 := false in
            if v_call7
            then (
              let v_ret_0_off0 := false in
              (Some (v_ret_0_off0, st)))
            else (
              when v_call10, st == ((s2tte_get_ripas_spec v_call6 st));
              let v_cmp := (v_call10 =? (0)) in
              let v_ret_0_off0 := v_cmp in
              (Some (v_ret_0_off0, st))));
        when st == ((buffer_unmap_spec v_call5 st));
        when v_7_tmp, st == ((load_RData 8 v_g_llt st));
        rely (v_7_tmp > 0 /\ ((v_7_tmp >= GRANULES_BASE) /\ (v_7_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
        let v_7 := (int_to_ptr v_7_tmp) in
        when st == ((granule_unlock_spec v_7 st));
        let v_retval_0 := v_ret_0_off0 in
        (Some (v_retval_0, st)))
      else (
        let v_retval_0 := false in
        (Some (v_retval_0, st))));
  let __return__ := true in
  let __retval__ := v_retval_0 in
  when st == ((free_stack "ipa_is_empty" init_st st));
  (Some (__retval__, st)).

Definition access_in_rec_par_spec_low (v_rec: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
  when v_call, st == ((addr_in_rec_par_spec v_rec v_addr st));
  let __return__ := true in
  let __retval__ := v_call in
  (Some (__retval__, st)).

Definition fixup_aarch32_data_abort_spec_low (v_rec: Ptr) (v_esr: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (v_esr.(pbase) = "handle_data_abort_stack");
  when v_call, st == ((read_spsr_el2_spec st));
  let v_and := (v_call & (16)) in
  let v_cmp_not := (v_and =? (0)) in
  when st == (
      if v_cmp_not
      then (Some st)
      else (
        when v_0, st == ((load_RData 8 v_esr st));
        let v_and1 := (v_0 & (18446744073692774399)) in
        when st == ((store_RData 8 v_esr v_and1 st));
        (Some st)));
  let v_1 := (xorb v_cmp_not true) in
  let __return__ := true in
  let __retval__ := v_1 in
  (Some (__retval__, st)).

Definition get_dabt_write_value_spec_low (v_rec: Ptr) (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  when v_call, st == ((esr_srt_spec v_esr st));
  let v_cmp := (v_call =? (31)) in
  when v_retval_0, st == (
      let v_retval_0 := 0 in
      if v_cmp
      then (
        let v_retval_0 := 0 in
        (Some (v_retval_0, st)))
      else (
        let v_idxprom := v_call in
        rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (31)))));
        let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (v_idxprom)) + (0))))))) in
        when v_0, st == ((load_RData 8 v_arrayidx st));
        when v_call1, st == ((access_mask_spec v_esr st));
        let v_and := (v_call1 & (v_0)) in
        let v_retval_0 := v_and in
        (Some (v_retval_0, st))));
  let __return__ := true in
  let __retval__ := v_retval_0 in
  (Some (__retval__, st)).

Definition handle_sync_external_abort_spec_low (v_rec: Ptr) (v_rec_exit: Ptr) (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  rely (v_rec_exit.(pbase) = "smc_rec_enter_stack" /\ v_rec_exit.(poffset) = 0);
  let v_and := (v_esr & (63)) in
  when v_call, st == ((fsc_is_external_abort_spec v_and st));
  when st == (
      if v_call
      then (
        let v_and1 := (v_esr & (6144)) in
        when st == (
            if (v_and1 =? (4096))
            then (Some st)
            else (
              when st == ((inject_sync_idabort_spec 16 st));
              let v_and3 := (v_esr & (4227866175)) in
              let v_esr4 := (ptr_offset v_rec_exit ((2048 * (0)) + ((256 + ((0 + ((0 + (0))))))))) in
              when st == ((store_RData 8 v_esr4 v_and3 st));
              (Some st)));
        (Some st))
      else (Some st));
  let __return__ := true in
  let __retval__ := v_call in
  (Some (__retval__, st)).

Definition emulate_sysreg_access_ns_spec_low (v_rec: Ptr) (v_rec_exit: Ptr) (v_esr: Z) (st: RData) : (option RData) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  rely (v_rec_exit.(pbase) = "smc_rec_enter_stack" /\ v_rec_exit.(poffset) = 0);
  let v_and := (v_esr & (1)) in
  let v_tobool_not := (v_and =? (0)) in
  when st == (
      if v_tobool_not
      then (
        when v_call, st == ((get_sysreg_write_value_spec v_rec v_esr st));
        rely (((0 <= (0)) /\ ((0 < (31)))));
        let v_arrayidx := (ptr_offset v_rec_exit ((2048 * (0)) + ((512 + ((0 + (((8 * (0)) + (0))))))))) in
        when st == ((store_RData 8 v_arrayidx v_call st));
        (Some st))
      else (Some st));
  let __return__ := true in
  (Some st).

Definition handle_rsi_ipa_state_get_spec_low (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
  rely (v_agg_result.(pbase) = "handle_realm_rsi_stack");
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  rely (rec_is_locked st);
  when st == ((new_frame "handle_rsi_ipa_state_get" st));
  let init_st := st in
  when v_rtt_level, st == ((alloc_stack "handle_rsi_ipa_state_get" 8 8 st));
  when v_ripas, st == ((alloc_stack "handle_rsi_ipa_state_get" 4 4 st));
  let v_0 := (ptr_offset v_agg_result ((56 * (0)) + ((0 + ((0 + (0))))))) in
  when st == ((llvm_memset_p0i8_i64_spec v_0 0 56 false st));
  rely (((0 <= (1)) /\ ((1 < (31)))));
  let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in
  when v_1, st == ((load_RData 8 v_arrayidx st));
  let v_abort := (ptr_offset v_agg_result ((56 * (0)) + ((0 + ((0 + (0))))))) in
  when st == ((store_RData 1 v_abort 0 st));
  let v_rem := (v_1 & (4095)) in
  let v_cmp := (v_rem =? (0)) in
  when __return__, st == (
      let __return__ := false in
      if v_cmp
      then (
        when v_call, st == ((addr_in_rec_par_spec v_rec v_1 st));
        when __return__, st == (
            let __return__ := false in
            if v_call
            then (
              when v_call2, st == ((realm_ipa_get_ripas_spec v_rec v_1 v_ripas v_rtt_level st));
              let v_cmp3 := (v_call2 =? (0)) in
              when st == (
                  if v_cmp3
                  then (
                    rely (((0 <= (0)) /\ ((0 < (5)))));
                    let v_arrayidx7 := (ptr_offset v_agg_result ((56 * (0)) + ((16 + ((0 + (((8 * (0)) + (0))))))))) in
                    when st == ((store_RData 8 v_arrayidx7 0 st));
                    when v_2, st == ((load_RData 4 v_ripas st));
                    let v_conv := v_2 in
                    rely (((0 <= (1)) /\ ((1 < (5)))));
                    let v_arrayidx10 := (ptr_offset v_agg_result ((56 * (0)) + ((16 + ((0 + (((8 * (1)) + (0))))))))) in
                    when st == ((store_RData 8 v_arrayidx10 v_conv st));
                    (Some st))
                  else (
                    when st == ((store_RData 1 v_abort 1 st));
                    when v_3, st == ((load_RData 8 v_rtt_level st));
                    let v_rtt_level14 := (ptr_offset v_agg_result ((56 * (0)) + ((0 + ((8 + (0))))))) in
                    when st == ((store_RData 8 v_rtt_level14 v_3 st));
                    (Some st)));
              let __return__ := true in
              (Some (__return__, st)))
            else (Some (__return__, st)));
        if __return__
        then (Some (__return__, st))
        else (Some (__return__, st)))
      else (Some (__return__, st)));
  if __return__
  then (
    when st == ((free_stack "handle_rsi_ipa_state_get" init_st st));
    (Some st))
  else (
    rely (((0 <= (0)) /\ ((0 < (5)))));
    let v_arrayidx1 := (ptr_offset v_agg_result ((56 * (0)) + ((16 + ((0 + (((8 * (0)) + (0))))))))) in
    when st == ((store_RData 8 v_arrayidx1 1 st));
    let __return__ := true in
    when st == ((free_stack "handle_rsi_ipa_state_get" init_st st));
    (Some st)).

(* Definition attest_token_continue_write_state_spec_low (v_rec: Ptr) (v_res: Ptr) (st: RData) : (option RData) := *)
(*   when st == ((new_frame "attest_token_continue_write_state" st)); *)
(*   let init_st := st in *)
(*   when v_walk_res, st == ((alloc_stack "attest_token_continue_write_state" 32 8 st)); *)
(*   when v_attest_token_buf, st == ((alloc_stack "attest_token_continue_write_state" 16 8 st)); *)
(*   rely (((0 <= (1)) /\ ((1 < (31))))); *)
(*   let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in *)
(*   when v_0, st == ((load_RData 8 v_arrayidx st)); *)
(*   let v_1 := v_walk_res in *)
(*   when st == ((llvm_memset_p0i8_i64_spec v_1 0 32 false st)); *)
(*   let v_g_rd := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((24 + (0))))))) in *)
(*   when v_2_tmp, st == ((load_RData 8 v_g_rd st)); *)
(*   let v_2 := (int_to_ptr v_2_tmp) in *)
(*   when v_call, st == ((granule_map_spec v_2 2 st)); *)
(*   let v_3 := v_call in *)
(*   when v_call1, st == ((realm_ipa_to_pa_spec v_3 v_0 v_walk_res st)); *)
(*   when st == ((buffer_unmap_spec v_call st)); *)
(*   let v_cmp := (v_call1 =? (2)) in *)
(*   when st == ( *)
(*       if v_cmp *)
(*       then ( *)
(*         when v_call2, st == ((s2_walk_result_match_ripas_spec v_walk_res 0 st)); *)
(*         when st == ( *)
(*             if v_call2 *)
(*             then ( *)
(*               rely (((0 <= (0)) /\ ((0 < (5))))); *)
(*               let v_arrayidx4 := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx4 1 st)); *)
(*               (Some st)) *)
(*             else ( *)
(*               let v_abort := (ptr_offset v_res ((64 * (0)) + ((8 + ((0 + (0))))))) in *)
(*               when st == ((store_RData 1 v_abort 1 st)); *)
(*               let v_rtt_level := (ptr_offset v_walk_res ((32 * (0)) + ((8 + (0))))) in *)
(*               when v_4, st == ((load_RData 8 v_rtt_level st)); *)
(*               let v_rtt_level6 := (ptr_offset v_res ((64 * (0)) + ((8 + ((8 + (0))))))) in *)
(*               when st == ((store_RData 8 v_rtt_level6 v_4 st)); *)
(*               rely (((0 <= (0)) /\ ((0 < (5))))); *)
(*               let v_arrayidx9 := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx9 3 st)); *)
(*               (Some st))); *)
(*         (Some st)) *)
(*       else ( *)
(*         let v_pa := (ptr_offset v_walk_res ((32 * (0)) + ((0 + (0))))) in *)
(*         when v_5, st == ((load_RData 8 v_pa st)); *)
(*         when v_call11, st == ((find_granule_spec v_5 st)); *)
(*         when v_call12, st == ((granule_map_spec v_call11 24 st)); *)
(*         let v_ptr := (ptr_offset v_attest_token_buf ((16 * (0)) + ((0 + (0))))) in *)
(*         when st == ((store_RData 8 v_ptr (ptr_to_int v_call12) st)); *)
(*         let v_len := (ptr_offset v_attest_token_buf ((16 * (0)) + ((8 + (0))))) in *)
(*         when st == ((store_RData 8 v_len 4096 st)); *)
(*         let v_rmm_realm_token := (ptr_offset v_rec ((3272 * (0)) + ((2152 + (0))))) in *)
(*         when v_call13, st == ((attest_cca_token_create_spec v_attest_token_buf v_rmm_realm_token st)); *)
(*         when st == ((buffer_unmap_spec v_call12 st)); *)
(*         let v_llt := (ptr_offset v_walk_res ((32 * (0)) + ((24 + (0))))) in *)
(*         when v_6_tmp, st == ((load_RData 8 v_llt st)); *)
(*         let v_6 := (int_to_ptr v_6_tmp) in *)
(*         when st == ((granule_unlock_spec v_6 st)); *)
(*         let v_cmp14 := (v_call13 =? (0)) in *)
(*         when st == ( *)
(*             if v_cmp14 *)
(*             then ( *)
(*               rely (((0 <= (0)) /\ ((0 < (5))))); *)
(*               let v_arrayidx18 := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx18 1 st)); *)
(*               (Some st)) *)
(*             else ( *)
(*               rely (((0 <= (0)) /\ ((0 < (5))))); *)
(*               let v_arrayidx22 := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx22 0 st)); *)
(*               rely (((0 <= (1)) /\ ((1 < (5))))); *)
(*               let v_arrayidx25 := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (1)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx25 v_call13 st)); *)
(*               (Some st))); *)
(*         let v_state := (ptr_offset v_rec ((3272 * (0)) + ((2168 + ((0 + (0))))))) in *)
(*         when st == ((store_RData 4 v_state 0 st)); *)
(*         (Some st))); *)
(*   let __return__ := true in *)
(*   when st == ((free_stack "attest_token_continue_write_state" init_st st)); *)
(*   (Some st). *)

(* Definition verify_input_parameters_consistency_spec_low (v_rec: Ptr) (st: RData) : (option (bool * RData)) := *)
(*   rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0); *)
(*   let v_token_ipa := (ptr_offset v_rec ((3272 * (0)) + ((2168 + ((960 + (0))))))) in *)
(*   when v_0, st == ((load_RData 8 v_token_ipa st)); *)
(*   rely (((0 <= (1)) /\ ((1 < (31))))); *)
(*   let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in *)
(*   when v_1, st == ((load_RData 8 v_arrayidx st)); *)
(*   let v_cmp := (v_0 =? (v_1)) in *)
(*   let __return__ := true in *)
(*   let __retval__ := v_cmp in *)
(*   (Some (__retval__, st)). *)

(* Definition attest_token_continue_sign_state_spec_low (v_rec: Ptr) (v_res: Ptr) (st: RData) : (option RData) := *)
(*   let v_ctx := (ptr_offset v_rec ((3272 * (0)) + ((2168 + ((8 + (0))))))) in *)
(*   let v_rmm_realm_token := (ptr_offset v_rec ((3272 * (0)) + ((2152 + (0))))) in *)
(*   when v_call, st == ((attest_realm_token_sign_spec v_ctx v_rmm_realm_token st)); *)
(*   let v_cmp := (v_call =? (5)) in *)
(*   let v_cmp1 := (v_call =? (0)) in *)
(*   let v_or_cond := (v_cmp || (v_cmp1)) in *)
(*   when __return__, st == ( *)
(*       let __return__ := false in *)
(*       if v_or_cond *)
(*       then ( *)
(*         let v_incomplete := (ptr_offset v_res ((64 * (0)) + ((0 + (0))))) in *)
(*         when st == ((store_RData 1 v_incomplete 1 st)); *)
(*         rely (((0 <= (0)) /\ ((0 < (5))))); *)
(*         let v_arrayidx := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*         when st == ((store_RData 8 v_arrayidx 3 st)); *)
(*         when st == ( *)
(*             if v_cmp1 *)
(*             then ( *)
(*               let v_state := (ptr_offset v_rec ((3272 * (0)) + ((2168 + ((0 + (0))))))) in *)
(*               when st == ((store_RData 4 v_state 2 st)); *)
(*               (Some st)) *)
(*             else (Some st)); *)
(*         let __return__ := true in *)
(*         (Some (__return__, st))) *)
(*       else (Some (__return__, st))); *)
(*   if __return__ *)
(*   then (Some st) *)
(*   else None. *)


(* Definition data_create_spec_low (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_g_src: Ptr) (v_flags: Z) (st: RData) : (option (Z * RData)) := *)
(*   let cur_stack := st.(stack).(data_create_stack) in *)
(*   rely (v_g_src.(pbase) = "granules" \/ v_g_src.(pbase) = "null"); *)
(*   when st == ((new_frame "data_create" st)); *)
(*   let init_st := st in *)
(*   when v_g_data, st == ((alloc_stack "data_create" 8 8 st)); *)
(*   when v_g_rd, st == ((alloc_stack "data_create" 8 8 st)); *)
(*   when v_wi, st == ((alloc_stack "data_create" 24 8 st)); *)
(*   when v_call, st == ((find_lock_two_granules_spec v_data_addr 1 v_g_data v_rd_addr 2 v_g_rd st)); *)
(*   match ( *)
(*     let v_cond := 0 in *)
(*     let v_cmp_not := false in *)
(*     let v_call1 := (mkPtr "#" 0) in *)
(*     let v_1 := (mkPtr "#" 0) in *)
(*     let __retval__ := 0 in *)
(*     let __return__ := false in *)
(*     if v_call *)
(*     then ( *)
(*       let g_data_ofs := (cur_stack @ 0) - GRANULES_BASE in *)
(*       let g_rd_ofs := (cur_stack @ 8) - GRANULES_BASE in *)
(*       rely ((st.(share).(granules) @ (g_data_ofs / ST_GRANULE_SIZE)).(e_lock) = (Some CPU_ID)); *)
(*       rely ((st.(share).(granules) @ (g_rd_ofs / ST_GRANULE_SIZE)).(e_lock) = (Some CPU_ID)); *)
(*       when v_0_tmp, st == ((load_RData 8 v_g_rd st)); *)
(*       rely (v_0_tmp > 0 /\ ((v_0_tmp >= GRANULES_BASE) /\ (v_0_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*       let v_0 := (int_to_ptr v_0_tmp) in *)
(*       when v_call1, st == ((granule_map_spec v_0 2 st)); *)
(*       let v_1 := v_call1 in *)
(*       let v_cmp_not := (ptr_eqb v_g_src (mkPtr "null" 0)) in *)
(*       when v_cond, st == ( *)
(*           let v_cond := 0 in *)
(*           if v_cmp_not *)
(*           then ( *)
(*             when v_call3, st == ((validate_data_create_unknown_spec v_map_addr v_1 st)); *)
(*             let v_cond := v_call3 in *)
(*             (Some (v_cond, st))) *)
(*           else ( *)
(*             when v_call2, st == ((validate_data_create_spec v_map_addr v_1 st)); *)
(*             let v_cond := v_call2 in *)
(*             (Some (v_cond, st)))); *)
(*       (Some (__return__, __retval__, v_1, v_call1, v_cmp_not, v_cond, st))) *)
(*     else ( *)
(*       let v_retval_0 := 1 in *)
(*       let __return__ := true in *)
(*       let __retval__ := v_retval_0 in *)
(*       (Some (__return__, __retval__, v_1, v_call1, v_cmp_not, v_cond, st))) *)
(*   ) with *)
(*   | (Some (__return__, __retval__, v_1, v_call1, v_cmp_not, v_cond, st)) => *)
(*     if __return__ *)
(*     then ( *)
(*       when st == ((free_stack "data_create" init_st st)); *)
(*       (Some (__retval__, st))) *)
(*     else ( *)
(*       let v_cmp4_not := (v_cond =? (0)) in *)
(*       match ( *)
(*         if v_cmp4_not *)
(*         then (Some (__return__, __retval__, st)) *)
(*         else ( *)
(*           let v_ret_2 := v_cond in *)
(*           let v_new_data_state_2 := 1 in *)
(*           when st == ((buffer_unmap_spec v_call1 st)); *)
(*           when v_12_tmp, st == ((load_RData 8 v_g_rd st)); *)
(*           rely (v_12_tmp > 0 /\ ((v_12_tmp >= GRANULES_BASE) /\ (v_12_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*           let v_12 := (int_to_ptr v_12_tmp) in *)
(*           when st == ((granule_unlock_spec v_12 st)); *)
(*           when v_13_tmp, st == ((load_RData 8 v_g_data st)); *)
(*           rely (v_13_tmp > 0 /\ ((v_13_tmp >= GRANULES_BASE) /\ (v_13_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*           let v_13 := (int_to_ptr v_13_tmp) in *)
(*           when st == ((granule_unlock_transition_spec v_13 v_new_data_state_2 st)); *)
(*           let v_retval_0 := v_ret_2 in *)
(*           let __return__ := true in *)
(*           let __retval__ := v_retval_0 in *)
(*           (Some (__return__, __retval__, st))) *)
(*       ) with *)
(*       | (Some (__return__, __retval__, st)) => *)
(*         if __return__ *)
(*         then ( *)
(*           when st == ((free_stack "data_create" init_st st)); *)
(*           (Some (__retval__, st))) *)
(*         else ( *)
(*           let v_g_rtt := (ptr_offset v_call1 ((1 * (32)) + (0))) in *)
(*           let v_2 := v_g_rtt in *)
(*           when v_3_tmp, st == ((load_RData 8 v_2 st)); *)
(*           rely (v_3_tmp > 0 /\ ((v_3_tmp >= GRANULES_BASE) /\ (v_3_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*           let v_3 := (int_to_ptr v_3_tmp) in *)
(*           when v_call7, st == ((realm_rtt_starting_level_spec v_1 st)); *)
(*           when v_call8, st == ((realm_ipa_bits_spec v_1 st)); *)
(*           when st == ((granule_lock_spec v_3 6 st)); *)
(*           when st == ((rtt_walk_lock_unlock_spec v_3 v_call7 v_call8 v_map_addr 3 v_wi st)); *)
(*           let v_last_level := (ptr_offset v_wi ((24 * (0)) + ((16 + (0))))) in *)
(*           when v_4, st == ((load_RData 8 v_last_level st)); *)
(*           let v_cmp9_not := (v_4 =? (3)) in *)
(*           match ( *)
(*             if v_cmp9_not *)
(*             then (Some (__return__, __retval__, st)) *)
(*             else ( *)
(*               let v_conv := v_4 in *)
(*               when v_call12, st == ((pack_return_code_spec 4 v_conv st)); *)
(*               let v_ret_1 := v_call12 in *)
(*               let v_new_data_state_1 := 1 in *)
(*               let v_g_llt41 := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in *)
(*               when v_11_tmp, st == ((load_RData 8 v_g_llt41 st)); *)
(*               rely (v_11_tmp > 0 /\ ((v_11_tmp >= GRANULES_BASE) /\ (v_11_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*               let v_11 := (int_to_ptr v_11_tmp) in *)
(*               when st == ((granule_unlock_spec v_11 st)); *)
(*               let v_ret_2 := v_ret_1 in *)
(*               let v_new_data_state_2 := v_new_data_state_1 in *)
(*               when st == ((buffer_unmap_spec v_call1 st)); *)
(*               when v_12_tmp, st == ((load_RData 8 v_g_rd st)); *)
(*               rely (v_12_tmp > 0 /\ ((v_12_tmp >= GRANULES_BASE) /\ (v_12_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*               let v_12 := (int_to_ptr v_12_tmp) in *)
(*               when st == ((granule_unlock_spec v_12 st)); *)
(*               when v_13_tmp, st == ((load_RData 8 v_g_data st)); *)
(*               rely (v_13_tmp > 0 /\ ((v_13_tmp >= GRANULES_BASE) /\ (v_13_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*               let v_13 := (int_to_ptr v_13_tmp) in *)
(*               when st == ((granule_unlock_transition_spec v_13 v_new_data_state_2 st)); *)
(*               let v_retval_0 := v_ret_2 in *)
(*               let __return__ := true in *)
(*               let __retval__ := v_retval_0 in *)
(*               (Some (__return__, __retval__, st))) *)
(*           ) with *)
(*           | (Some (__return__, __retval__, st)) => *)
(*             if __return__ *)
(*             then ( *)
(*               when st == ((free_stack "data_create" init_st st)); *)
(*               (Some (__retval__, st))) *)
(*             else ( *)
(*               let v_g_llt := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in *)
(*               when v_5_tmp, st == ((load_RData 8 v_g_llt st)); *)
(*               rely (v_5_tmp > 0 /\ ((v_5_tmp >= GRANULES_BASE) /\ (v_5_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*               let v_5 := (int_to_ptr v_5_tmp) in *)
(*               when v_call14, st == ((granule_map_spec v_5 22 st)); *)
(*               let v_6 := v_call14 in *)
(*               let v_index := (ptr_offset v_wi ((24 * (0)) + ((8 + (0))))) in *)
(*               when v_7, st == ((load_RData 8 v_index st)); *)
(*               let v_arrayidx := (ptr_offset v_6 ((8 * (v_7)) + (0))) in *)
(*               when v_call15, st == ((__tte_read_spec v_arrayidx st)); *)
(*               when v_call16, st == ((s2tte_is_unassigned_spec v_call15 st)); *)
(*               match ( *)
(*                 if v_call16 *)
(*                 then ( *)
(*                   when v_call20, st == ((s2tte_get_ripas_spec v_call15 st)); *)
(*                   match ( *)
(*                     if v_cmp_not *)
(*                     then (Some (__return__, __retval__, st)) *)
(*                     else ( *)
(*                       when v_8_tmp, st == ((load_RData 8 v_g_data st)); *)
(*                       rely (v_8_tmp > 0 /\ ((v_8_tmp >= GRANULES_BASE) /\ (v_8_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                       let v_8 := (int_to_ptr v_8_tmp) in *)
(*                       when v_call24, st == ((granule_map_spec v_8 1 st)); *)
(*                       when v_call25, st == ((ns_buffer_read_spec 0 v_g_src 0 4096 v_call24 st)); *)
(*                       match ( *)
(*                         if v_call25 *)
(*                         then ( *)
(*                           when st == ((data_granule_measure_spec v_1 v_call24 v_map_addr v_flags st)); *)
(*                           when st == ((buffer_unmap_spec v_call24 st)); *)
(*                           (Some (__return__, __retval__, st))) *)
(*                         else ( *)
(*                           when v_call27, st == ((memset_spec v_call24 0 4096 st)); *)
(*                           when st == ((buffer_unmap_spec v_call24 st)); *)
(*                           let v_ret_0 := 1 in *)
(*                           let v_new_data_state_0 := 1 in *)
(*                           when st == ((buffer_unmap_spec v_call14 st)); *)
(*                           let v_ret_1 := v_ret_0 in *)
(*                           let v_new_data_state_1 := v_new_data_state_0 in *)
(*                           let v_g_llt41 := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in *)
(*                           when v_11_tmp, st == ((load_RData 8 v_g_llt41 st)); *)
(*                           rely (v_11_tmp > 0 /\ ((v_11_tmp >= GRANULES_BASE) /\ (v_11_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                           let v_11 := (int_to_ptr v_11_tmp) in *)
(*                           when st == ((granule_unlock_spec v_11 st)); *)
(*                           let v_ret_2 := v_ret_1 in *)
(*                           let v_new_data_state_2 := v_new_data_state_1 in *)
(*                           when st == ((buffer_unmap_spec v_call1 st)); *)
(*                           when v_12_tmp, st == ((load_RData 8 v_g_rd st)); *)
(*                           rely (v_12_tmp > 0 /\ ((v_12_tmp >= GRANULES_BASE) /\ (v_12_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                           let v_12 := (int_to_ptr v_12_tmp) in *)
(*                           when st == ((granule_unlock_spec v_12 st)); *)
(*                           when v_13_tmp, st == ((load_RData 8 v_g_data st)); *)
(*                           rely (v_13_tmp > 0 /\ ((v_13_tmp >= GRANULES_BASE) /\ (v_13_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                           let v_13 := (int_to_ptr v_13_tmp) in *)
(*                           when st == ((granule_unlock_transition_spec v_13 v_new_data_state_2 st)); *)
(*                           let v_retval_0 := v_ret_2 in *)
(*                           let __return__ := true in *)
(*                           let __retval__ := v_retval_0 in *)
(*                           (Some (__return__, __retval__, st))) *)
(*                       ) with *)
(*                       | (Some (__return__, __retval__, st)) => *)
(*                         if __return__ *)
(*                         then (Some (__return__, __retval__, st)) *)
(*                         else (Some (__return__, __retval__, st)) *)
(*                       | None => None *)
(*                       end) *)
(*                   ) with *)
(*                   | (Some (__return__, __retval__, st)) => *)
(*                     if __return__ *)
(*                     then (Some (__return__, __retval__, st)) *)
(*                     else ( *)
(*                       let v_cmp30 := (v_call20 =? (0)) in *)
(*                       when v_cond37, st == ( *)
(*                           let v_cond37 := 0 in *)
(*                           if v_cmp30 *)
(*                           then ( *)
(*                             when v_call33, st == ((s2tte_create_assigned_empty_spec v_data_addr 3 st)); *)
(*                             let v_cond37 := v_call33 in *)
(*                             (Some (v_cond37, st))) *)
(*                           else ( *)
(*                             when v_call35, st == ((s2tte_create_valid_spec v_data_addr 3 st)); *)
(*                             let v_cond37 := v_call35 in *)
(*                             (Some (v_cond37, st)))); *)
(*                       when v_9, st == ((load_RData 8 v_index st)); *)
(*                       let v_arrayidx39 := (ptr_offset v_6 ((8 * (v_9)) + (0))) in *)
(*                       when st == ((__tte_write_spec v_arrayidx39 v_cond37 st)); *)
(*                       when v_10_tmp, st == ((load_RData 8 v_g_llt st)); *)
(*                       rely (v_10_tmp > 0 /\ ((v_10_tmp >= GRANULES_BASE) /\ (v_10_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                       let v_10 := (int_to_ptr v_10_tmp) in *)
(*                       when st == ((__granule_get_spec v_10 st)); *)
(*                       let v_ret_0 := 0 in *)
(*                       let v_new_data_state_0 := 5 in *)
(*                       when st == ((buffer_unmap_spec v_call14 st)); *)
(*                       let v_ret_1 := v_ret_0 in *)
(*                       let v_new_data_state_1 := v_new_data_state_0 in *)
(*                       let v_g_llt41 := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in *)
(*                       when v_11_tmp, st == ((load_RData 8 v_g_llt41 st)); *)
(*                       rely (v_11_tmp > 0 /\ ((v_11_tmp >= GRANULES_BASE) /\ (v_11_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                       let v_11 := (int_to_ptr v_11_tmp) in *)
(*                       when st == ((granule_unlock_spec v_11 st)); *)
(*                       let v_ret_2 := v_ret_1 in *)
(*                       let v_new_data_state_2 := v_new_data_state_1 in *)
(*                       when st == ((buffer_unmap_spec v_call1 st)); *)
(*                       when v_12_tmp, st == ((load_RData 8 v_g_rd st)); *)
(*                       rely (v_12_tmp > 0 /\ ((v_12_tmp >= GRANULES_BASE) /\ (v_12_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                       let v_12 := (int_to_ptr v_12_tmp) in *)
(*                       when st == ((granule_unlock_spec v_12 st)); *)
(*                       when v_13_tmp, st == ((load_RData 8 v_g_data st)); *)
(*                       rely (v_13_tmp > 0 /\ ((v_13_tmp >= GRANULES_BASE) /\ (v_13_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                       let v_13 := (int_to_ptr v_13_tmp) in *)
(*                       when st == ((granule_unlock_transition_spec v_13 v_new_data_state_2 st)); *)
(*                       let v_retval_0 := v_ret_2 in *)
(*                       let __return__ := true in *)
(*                       let __retval__ := v_retval_0 in *)
(*                       (Some (__return__, __retval__, st))) *)
(*                   | None => None *)
(*                   end) *)
(*                 else ( *)
(*                   when v_call18, st == ((pack_return_code_spec 4 3 st)); *)
(*                   let v_ret_0 := v_call18 in *)
(*                   let v_new_data_state_0 := 1 in *)
(*                   when st == ((buffer_unmap_spec v_call14 st)); *)
(*                   let v_ret_1 := v_ret_0 in *)
(*                   let v_new_data_state_1 := v_new_data_state_0 in *)
(*                   let v_g_llt41 := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in *)
(*                   when v_11_tmp, st == ((load_RData 8 v_g_llt41 st)); *)
(*                   rely (v_11_tmp > 0 /\ ((v_11_tmp >= GRANULES_BASE) /\ (v_11_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                   let v_11 := (int_to_ptr v_11_tmp) in *)
(*                   when st == ((granule_unlock_spec v_11 st)); *)
(*                   let v_ret_2 := v_ret_1 in *)
(*                   let v_new_data_state_2 := v_new_data_state_1 in *)
(*                   when st == ((buffer_unmap_spec v_call1 st)); *)
(*                   when v_12_tmp, st == ((load_RData 8 v_g_rd st)); *)
(*                   rely (v_12_tmp > 0 /\ ((v_12_tmp >= GRANULES_BASE) /\ (v_12_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                   let v_12 := (int_to_ptr v_12_tmp) in *)
(*                   when st == ((granule_unlock_spec v_12 st)); *)
(*                   when v_13_tmp, st == ((load_RData 8 v_g_data st)); *)
(*                   rely (v_13_tmp > 0 /\ ((v_13_tmp >= GRANULES_BASE) /\ (v_13_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*                   let v_13 := (int_to_ptr v_13_tmp) in *)
(*                   when st == ((granule_unlock_transition_spec v_13 v_new_data_state_2 st)); *)
(*                   let v_retval_0 := v_ret_2 in *)
(*                   let __return__ := true in *)
(*                   let __retval__ := v_retval_0 in *)
(*                   (Some (__return__, __retval__, st))) *)
(*               ) with *)
(*               | (Some (__return__, __retval__, st)) => *)
(*                 if __return__ *)
(*                 then ( *)
(*                   when st == ((free_stack "data_create" init_st st)); *)
(*                   (Some (__retval__, st))) *)
(*                 else ( *)
(*                   when st == ((free_stack "data_create" init_st st)); *)
(*                   (Some (__retval__, st))) *)
(*               | None => None *)
(*               end) *)
(*           | None => None *)
(*           end) *)
(*       | None => None *)
(*       end) *)
(*   | None => None *)
(*   end. *)

(* Definition attest_token_continue_write_state_spec_low (v_rec: Ptr) (v_res: Ptr) (st: RData) : (option RData) := *)
(*   when st == ((new_frame "attest_token_continue_write_state" st)); *)
(*   let init_st := st in *)
(*   when v_walk_res, st == ((alloc_stack "attest_token_continue_write_state" 32 8 st)); *)
(*   when v_attest_token_buf, st == ((alloc_stack "attest_token_continue_write_state" 16 8 st)); *)
(*   rely (((0 <= (1)) /\ ((1 < (31))))); *)
(*   let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in *)
(*   when v_0, st == ((load_RData 8 v_arrayidx st)); *)
(*   let v_1 := v_walk_res in *)
(*   when st == ((llvm_memset_p0i8_i64_spec v_1 0 32 false st)); *)
(*   let v_g_rd := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((24 + (0))))))) in *)
(*   when v_2_tmp, st == ((load_RData 8 v_g_rd st)); *)
(*   let v_2 := (int_to_ptr v_2_tmp) in *)
(*   when v_call, st == ((granule_map_spec v_2 2 st)); *)
(*   let v_3 := v_call in *)
(*   when v_call1, st == ((realm_ipa_to_pa_spec v_3 v_0 v_walk_res st)); *)
(*   when st == ((buffer_unmap_spec v_call st)); *)
(*   let v_cmp := (v_call1 =? (2)) in *)
(*   when st == ( *)
(*       if v_cmp *)
(*       then ( *)
(*         when v_call2, st == ((s2_walk_result_match_ripas_spec v_walk_res 0 st)); *)
(*         when st == ( *)
(*             if v_call2 *)
(*             then ( *)
(*               rely (((0 <= (0)) /\ ((0 < (5))))); *)
(*               let v_arrayidx4 := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx4 1 st)); *)
(*               (Some st)) *)
(*             else ( *)
(*               let v_abort := (ptr_offset v_res ((64 * (0)) + ((8 + ((0 + (0))))))) in *)
(*               when st == ((store_RData 1 v_abort 1 st)); *)
(*               let v_rtt_level := (ptr_offset v_walk_res ((32 * (0)) + ((8 + (0))))) in *)
(*               when v_4, st == ((load_RData 8 v_rtt_level st)); *)
(*               let v_rtt_level6 := (ptr_offset v_res ((64 * (0)) + ((8 + ((8 + (0))))))) in *)
(*               when st == ((store_RData 8 v_rtt_level6 v_4 st)); *)
(*               rely (((0 <= (0)) /\ ((0 < (5))))); *)
(*               let v_arrayidx9 := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx9 3 st)); *)
(*               (Some st))); *)
(*         (Some st)) *)
(*       else ( *)
(*         let v_pa := (ptr_offset v_walk_res ((32 * (0)) + ((0 + (0))))) in *)
(*         when v_5, st == ((load_RData 8 v_pa st)); *)
(*         when v_call11, st == ((find_granule_spec v_5 st)); *)
(*         when v_call12, st == ((granule_map_spec v_call11 24 st)); *)
(*         let v_ptr := (ptr_offset v_attest_token_buf ((16 * (0)) + ((0 + (0))))) in *)
(*         when st == ((store_RData 8 v_ptr (ptr_to_int v_call12) st)); *)
(*         let v_len := (ptr_offset v_attest_token_buf ((16 * (0)) + ((8 + (0))))) in *)
(*         when st == ((store_RData 8 v_len 4096 st)); *)
(*         let v_rmm_realm_token := (ptr_offset v_rec ((3272 * (0)) + ((2152 + (0))))) in *)
(*         when v_call13, st == ((attest_cca_token_create_spec v_attest_token_buf v_rmm_realm_token st)); *)
(*         when st == ((buffer_unmap_spec v_call12 st)); *)
(*         let v_llt := (ptr_offset v_walk_res ((32 * (0)) + ((24 + (0))))) in *)
(*         when v_6_tmp, st == ((load_RData 8 v_llt st)); *)
(*         let v_6 := (int_to_ptr v_6_tmp) in *)
(*         when st == ((granule_unlock_spec v_6 st)); *)
(*         let v_cmp14 := (v_call13 =? (0)) in *)
(*         when st == ( *)
(*             if v_cmp14 *)
(*             then ( *)
(*               rely (((0 <= (0)) /\ ((0 < (5))))); *)
(*               let v_arrayidx18 := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx18 1 st)); *)
(*               (Some st)) *)
(*             else ( *)
(*               rely (((0 <= (0)) /\ ((0 < (5))))); *)
(*               let v_arrayidx22 := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx22 0 st)); *)
(*               rely (((0 <= (1)) /\ ((1 < (5))))); *)
(*               let v_arrayidx25 := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (1)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx25 v_call13 st)); *)
(*               (Some st))); *)
(*         let v_state := (ptr_offset v_rec ((3272 * (0)) + ((2168 + ((0 + (0))))))) in *)
(*         when st == ((store_RData 4 v_state 0 st)); *)
(*         (Some st))); *)
(*   let __return__ := true in *)
(*   when st == ((free_stack "attest_token_continue_write_state" init_st st)); *)
(*   (Some st). *)

(* Definition verify_input_parameters_consistency_spec_low (v_rec: Ptr) (st: RData) : (option (bool * RData)) := *)
(*   rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0); *)
(*   let v_token_ipa := (ptr_offset v_rec ((3272 * (0)) + ((2168 + ((960 + (0))))))) in *)
(*   when v_0, st == ((load_RData 8 v_token_ipa st)); *)
(*   rely (((0 <= (1)) /\ ((1 < (31))))); *)
(*   let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in *)
(*   when v_1, st == ((load_RData 8 v_arrayidx st)); *)
(*   let v_cmp := (v_0 =? (v_1)) in *)
(*   let __return__ := true in *)
(*   let __retval__ := v_cmp in *)
(*   (Some (__retval__, st)). *)

(* Definition attest_token_continue_sign_state_spec_low (v_rec: Ptr) (v_res: Ptr) (st: RData) : (option RData) := *)
(*   let v_ctx := (ptr_offset v_rec ((3272 * (0)) + ((2168 + ((8 + (0))))))) in *)
(*   let v_rmm_realm_token := (ptr_offset v_rec ((3272 * (0)) + ((2152 + (0))))) in *)
(*   when v_call, st == ((attest_realm_token_sign_spec v_ctx v_rmm_realm_token st)); *)
(*   let v_cmp := (v_call =? (5)) in *)
(*   let v_cmp1 := (v_call =? (0)) in *)
(*   let v_or_cond := (v_cmp || (v_cmp1)) in *)
(*   when __return__, st == ( *)
(*       let __return__ := false in *)
(*       if v_or_cond *)
(*       then ( *)
(*         let v_incomplete := (ptr_offset v_res ((64 * (0)) + ((0 + (0))))) in *)
(*         when st == ((store_RData 1 v_incomplete 1 st)); *)
(*         rely (((0 <= (0)) /\ ((0 < (5))))); *)
(*         let v_arrayidx := (ptr_offset v_res ((64 * (0)) + ((24 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*         when st == ((store_RData 8 v_arrayidx 3 st)); *)
(*         when st == ( *)
(*             if v_cmp1 *)
(*             then ( *)
(*               let v_state := (ptr_offset v_rec ((3272 * (0)) + ((2168 + ((0 + (0))))))) in *)
(*               when st == ((store_RData 4 v_state 2 st)); *)
(*               (Some st)) *)
(*             else (Some st)); *)
(*         let __return__ := true in *)
(*         (Some (__return__, st))) *)
(*       else (Some (__return__, st))); *)
(*   if __return__ *)
(*   then (Some st) *)
(*   else None. *)


Definition data_create_spec_low (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_g_src: Ptr) (v_flags: Z) (st: RData) : (option (Z * RData)) :=
  let cur_stack := st.(stack).(data_create_stack) in
  rely (v_g_src.(pbase) = "granules" \/ v_g_src.(pbase) = "null");
  when st == ((new_frame "data_create" st));
  let init_st := st in
  when v_g_data, st == ((alloc_stack "data_create" 8 8 st));
  when v_g_rd, st == ((alloc_stack "data_create" 8 8 st));
  when v_wi, st == ((alloc_stack "data_create" 24 8 st));
  when v_call, st == ((find_lock_two_granules_spec v_data_addr 1 v_g_data v_rd_addr 2 v_g_rd st));
  match (
    let v_cond := 0 in
    let v_cmp_not := false in
    let v_call1 := (mkPtr "#" 0) in
    let v_1 := (mkPtr "#" 0) in
    let __retval__ := 0 in
    let __return__ := false in
    let v_retval_0 := 1 in
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__return__, __retval__, v_1, v_call1, v_cmp_not, v_cond, st))
  ) with
  | (Some (__return__, __retval__, v_1, v_call1, v_cmp_not, v_cond, st)) =>
    if __return__
    then (
      when st == ((free_stack "data_create" init_st st));
      (Some (__retval__, st)))
    else (
      let v_cmp4_not := (v_cond =? (0)) in
      match (
        if v_cmp4_not
        then (Some (__return__, __retval__, st))
        else (
          let v_ret_2 := v_cond in
          let v_new_data_state_2 := 1 in
          when st == ((buffer_unmap_spec v_call1 st));
          when v_12_tmp, st == ((load_RData 8 v_g_rd st));
          rely (v_12_tmp > 0 /\ ((v_12_tmp >= GRANULES_BASE) /\ (v_12_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
          let v_12 := (int_to_ptr v_12_tmp) in
          when st == ((granule_unlock_spec v_12 st));
          when v_13_tmp, st == ((load_RData 8 v_g_data st));
          rely (v_13_tmp > 0 /\ ((v_13_tmp >= GRANULES_BASE) /\ (v_13_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
          let v_13 := (int_to_ptr v_13_tmp) in
          when st == ((granule_unlock_transition_spec v_13 v_new_data_state_2 st));
          let v_retval_0 := v_ret_2 in
          let __return__ := true in
          let __retval__ := v_retval_0 in
          (Some (__return__, __retval__, st)))
      ) with
      | (Some (__return__, __retval__, st)) =>
        if __return__
        then (
          when st == ((free_stack "data_create" init_st st));
          (Some (__retval__, st)))
        else (
          let v_g_rtt := (ptr_offset v_call1 ((1 * (32)) + (0))) in
          let v_2 := v_g_rtt in
          when v_3_tmp, st == ((load_RData 8 v_2 st));
          rely (v_3_tmp > 0 /\ ((v_3_tmp >= GRANULES_BASE) /\ (v_3_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
          let v_3 := (int_to_ptr v_3_tmp) in
          when v_call7, st == ((realm_rtt_starting_level_spec v_1 st));
          when v_call8, st == ((realm_ipa_bits_spec v_1 st));
          when st == ((granule_lock_spec v_3 6 st));
          when st == ((rtt_walk_lock_unlock_spec v_3 v_call7 v_call8 v_map_addr 3 v_wi st));
          let v_last_level := (ptr_offset v_wi ((24 * (0)) + ((16 + (0))))) in
          when v_4, st == ((load_RData 8 v_last_level st));
          None)
      | None => None
      end)
  | None => None
  end.
