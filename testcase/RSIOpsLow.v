Parameter do_host_call_spec_state_oracle : RData -> (option RData).

(* Definition do_host_call_spec_low (v_rec: Ptr) (v_rec_exit: Ptr) (v_rec_entry: Ptr) (v_rsi_walk_result: Ptr) (st: RData) : (option (Z * RData)) := *)
(*   rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0); *)
(*   rely (v_rec_exit.(pbase) = "smc_rec_enter_stack" \/ v_rec_exit.(pbase) = "null"); *)
(*   rely (v_rec_entry.(pbase) = "smc_rec_enter_stack" \/ v_rec_entry.(pbase) = "null"); *)
(*   rely (v_rsi_walk_result.(pbase) = "handle_rsi_host_call_stack" \/ v_rsi_walk_result.(pbase) = "complete_rsi_host_call_stack"); *)
(*   when st == ((new_frame "do_host_call" st)); *)
(*   let init_st := st in *)
(*   when v_walk_result, st == ((alloc_stack "do_host_call" 32 8 st)); *)
(*   rely (((0 <= (1)) /\ ((1 < (31))))); *)
(*   let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in *)
(*   when v_0, st == ((load_RData 8 v_arrayidx st)); *)
(*   let v_g_rd := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((24 + (0))))))) in *)
(*   when v_1_tmp, st == ((load_RData 8 v_g_rd st)); *)
(*   rely (v_1_tmp > 0 /\ ((v_1_tmp >= GRANULES_BASE) /\ (v_1_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*   let v_1 := (int_to_ptr v_1_tmp) in *)
(*   when v_call, st == ((granule_map_spec v_1 2 st)); *)
(*   let v_2 := v_call in *)
(*   let v_and := (v_0 & (18446744073709547520)) in *)
(*   when v_call1, st == ((realm_ipa_to_pa_spec v_2 v_and v_walk_result st)); *)
(*   let v_cond := (v_call1 =? (2)) in *)
(*   when v_ret_0, st == ( *)
(*       let v_ret_0 := 0 in *)
(*       if v_cond *)
(*       then ( *)
(*         when v_call3, st == ((s2_walk_result_match_ripas_spec v_walk_result 0 st)); *)
(*         when v_ret_0, st == ( *)
(*             let v_ret_0 := 0 in *)
(*             if v_call3 *)
(*             then ( *)
(*               let v_ret_0 := 1 in *)
(*               (Some (v_ret_0, st))) *)
(*             else ( *)
(*               let v_abort := (ptr_offset v_rsi_walk_result ((16 * (0)) + ((0 + (0))))) in *)
(*               when st == ((store_RData 1 v_abort 1 st)); *)
(*               let v_rtt_level := (ptr_offset v_walk_result ((32 * (0)) + ((8 + (0))))) in *)
(*               when v_3, st == ((load_RData 8 v_rtt_level st)); *)
(*               let v_rtt_level4 := (ptr_offset v_rsi_walk_result ((16 * (0)) + ((8 + (0))))) in *)
(*               when st == ((store_RData 8 v_rtt_level4 v_3 st)); *)
(*               let v_ret_0 := 0 in *)
(*               (Some (v_ret_0, st)))); *)
(*         (Some (v_ret_0, st))) *)
(*       else ( *)
(*         let v_pa := (ptr_offset v_walk_result ((32 * (0)) + ((0 + (0))))) in *)
(*         when v_4, st == ((load_RData 8 v_pa st)); *)
(*         when v_call6, st == ((find_granule_spec v_4 st)); *)
(*         rely (v_call6.(pbase) = "granules"); *)
(*         when v_call7, st == ((granule_map_spec v_call6 24 st)); *)
(*         let v_sub := (v_0 & (4095)) in *)
(*         let v_add_ptr := (ptr_offset v_call7 ((1 * (v_sub)) + (0))) in *)
(*         let v_cmp_not := (ptr_eqb v_rec_exit (mkPtr "null" 0)) in *)
(*         when st == ( *)
(*             if v_cmp_not *)
(*             then ( *)
(*               let v_gprs22 := (ptr_offset v_add_ptr ((1 * (8)) + (0))) in *)
(*               let v_14 := v_gprs22 in *)
(*               let v_arrayidx21 := (ptr_offset v_rec_entry ((2048 * (0)) + ((512 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*               when v_15, st == ((load_RData 8 v_arrayidx21 st)); *)
(*               let v_arrayidx24 := (ptr_offset v_14 (((8 * (7)) * (0)) + (((8 * (0)) + (0))))) in *)
(*               when st == ((store_RData 8 v_arrayidx24 v_15 st)); *)
(*               let v_arrayidx21_1 := (ptr_offset v_rec_entry ((2048 * (0)) + ((512 + ((0 + (((8 * (1)) + (0))))))))) in *)
(*               when v_16, st == ((load_RData 8 v_arrayidx21_1 st)); *)
(*               let v_arrayidx24_1 := (ptr_offset v_14 (((8 * (7)) * (0)) + (((8 * (1)) + (0))))) in *)
(*               when st == ((store_RData 8 v_arrayidx24_1 v_16 st)); *)
(*               let v_arrayidx21_2 := (ptr_offset v_rec_entry ((2048 * (0)) + ((512 + ((0 + (((8 * (2)) + (0))))))))) in *)
(*               when v_17, st == ((load_RData 8 v_arrayidx21_2 st)); *)
(*               let v_arrayidx24_2 := (ptr_offset v_14 (((8 * (7)) * (0)) + (((8 * (2)) + (0))))) in *)
(*               when st == ((store_RData 8 v_arrayidx24_2 v_17 st)); *)
(*               let v_arrayidx21_3 := (ptr_offset v_rec_entry ((2048 * (0)) + ((512 + ((0 + (((8 * (3)) + (0))))))))) in *)
(*               when v_18, st == ((load_RData 8 v_arrayidx21_3 st)); *)
(*               let v_arrayidx24_3 := (ptr_offset v_14 (((8 * (7)) * (0)) + (((8 * (3)) + (0))))) in *)
(*               when st == ((store_RData 8 v_arrayidx24_3 v_18 st)); *)
(*               let v_arrayidx21_4 := (ptr_offset v_rec_entry ((2048 * (0)) + ((512 + ((0 + (((8 * (4)) + (0))))))))) in *)
(*               when v_19, st == ((load_RData 8 v_arrayidx21_4 st)); *)
(*               let v_arrayidx24_4 := (ptr_offset v_14 (((8 * (7)) * (0)) + (((8 * (4)) + (0))))) in *)
(*               when st == ((store_RData 8 v_arrayidx24_4 v_19 st)); *)
(*               let v_arrayidx21_5 := (ptr_offset v_rec_entry ((2048 * (0)) + ((512 + ((0 + (((8 * (5)) + (0))))))))) in *)
(*               when v_20, st == ((load_RData 8 v_arrayidx21_5 st)); *)
(*               let v_arrayidx24_5 := (ptr_offset v_14 (((8 * (7)) * (0)) + (((8 * (5)) + (0))))) in *)
(*               when st == ((store_RData 8 v_arrayidx24_5 v_20 st)); *)
(*               let v_arrayidx21_6 := (ptr_offset v_rec_entry ((2048 * (0)) + ((512 + ((0 + (((8 * (6)) + (0))))))))) in *)
(*               when v_21, st == ((load_RData 8 v_arrayidx21_6 st)); *)
(*               let v_arrayidx24_6 := (ptr_offset v_14 (((8 * (7)) * (0)) + (((8 * (6)) + (0))))) in *)
(*               when st == ((store_RData 8 v_arrayidx24_6 v_21 st)); *)
(*               (Some st)) *)
(*             else ( *)
(*               let v_imm := v_add_ptr in *)
(*               when v_5, st == ((load_RData 4 v_imm st)); *)
(*               let v_imm9 := (ptr_offset v_rec_exit ((2048 * (0)) + ((1536 + ((0 + (0))))))) in *)
(*               when st == ((store_RData 4 v_imm9 v_5 st)); *)
(*               let v_gprs := (ptr_offset v_add_ptr ((1 * (8)) + (0))) in *)
(*               let v_6 := v_gprs in *)
(*               let v_arrayidx11 := (ptr_offset v_6 (((8 * (7)) * (0)) + (((8 * (0)) + (0))))) in *)
(*               when v_7, st == ((load_RData 8 v_arrayidx11 st)); *)
(*               let v_arrayidx14 := (ptr_offset v_rec_exit ((2048 * (0)) + ((512 + ((0 + (((8 * (0)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx14 v_7 st)); *)
(*               let v_arrayidx11_1 := (ptr_offset v_6 (((8 * (7)) * (0)) + (((8 * (1)) + (0))))) in *)
(*               when v_8, st == ((load_RData 8 v_arrayidx11_1 st)); *)
(*               let v_arrayidx14_1 := (ptr_offset v_rec_exit ((2048 * (0)) + ((512 + ((0 + (((8 * (1)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx14_1 v_8 st)); *)
(*               let v_arrayidx11_2 := (ptr_offset v_6 (((8 * (7)) * (0)) + (((8 * (2)) + (0))))) in *)
(*               when v_9, st == ((load_RData 8 v_arrayidx11_2 st)); *)
(*               let v_arrayidx14_2 := (ptr_offset v_rec_exit ((2048 * (0)) + ((512 + ((0 + (((8 * (2)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx14_2 v_9 st)); *)
(*               let v_arrayidx11_3 := (ptr_offset v_6 (((8 * (7)) * (0)) + (((8 * (3)) + (0))))) in *)
(*               when v_10, st == ((load_RData 8 v_arrayidx11_3 st)); *)
(*               let v_arrayidx14_3 := (ptr_offset v_rec_exit ((2048 * (0)) + ((512 + ((0 + (((8 * (3)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx14_3 v_10 st)); *)
(*               let v_arrayidx11_4 := (ptr_offset v_6 (((8 * (7)) * (0)) + (((8 * (4)) + (0))))) in *)
(*               when v_11, st == ((load_RData 8 v_arrayidx11_4 st)); *)
(*               let v_arrayidx14_4 := (ptr_offset v_rec_exit ((2048 * (0)) + ((512 + ((0 + (((8 * (4)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx14_4 v_11 st)); *)
(*               let v_arrayidx11_5 := (ptr_offset v_6 (((8 * (7)) * (0)) + (((8 * (5)) + (0))))) in *)
(*               when v_12, st == ((load_RData 8 v_arrayidx11_5 st)); *)
(*               let v_arrayidx14_5 := (ptr_offset v_rec_exit ((2048 * (0)) + ((512 + ((0 + (((8 * (5)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx14_5 v_12 st)); *)
(*               let v_arrayidx11_6 := (ptr_offset v_6 (((8 * (7)) * (0)) + (((8 * (6)) + (0))))) in *)
(*               when v_13, st == ((load_RData 8 v_arrayidx11_6 st)); *)
(*               let v_arrayidx14_6 := (ptr_offset v_rec_exit ((2048 * (0)) + ((512 + ((0 + (((8 * (6)) + (0))))))))) in *)
(*               when st == ((store_RData 8 v_arrayidx14_6 v_13 st)); *)
(*               (Some st))); *)
(*         when st == ((buffer_unmap_spec v_call7 st)); *)
(*         let v_llt := (ptr_offset v_walk_result ((32 * (0)) + ((24 + (0))))) in *)
(*         when v_22_tmp, st == ((load_RData 8 v_llt st)); *)
(*         rely (v_22_tmp > 0 /\ ((v_22_tmp >= GRANULES_BASE) /\ (v_22_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE))); *)
(*         let v_22 := (int_to_ptr v_22_tmp) in *)
(*         when st == ((granule_unlock_spec v_22 st)); *)
(*         let v_ret_0 := 0 in *)
(*         (Some (v_ret_0, st)))); *)
(*   when st == ((buffer_unmap_spec v_call st)); *)
(*   let __return__ := true in *)
(*   let __retval__ := v_ret_0 in *)
(*   when st == ((free_stack "do_host_call" init_st st)); *)
(*   (Some (__retval__, st)). *)

Definition do_host_call_spec_low (v_rec: Ptr) (v_rec_exit: Ptr) (v_rec_entry: Ptr) (v_rsi_walk_result: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  rely (v_rec_exit.(pbase) = "smc_rec_enter_stack" \/ v_rec_exit.(pbase) = "null");
  rely (v_rec_entry.(pbase) = "smc_rec_enter_stack" \/ v_rec_entry.(pbase) = "null");
  rely (v_rsi_walk_result.(pbase) = "handle_rsi_host_call_stack" \/ v_rsi_walk_result.(pbase) = "complete_rsi_host_call_stack");
  when st == ((new_frame "do_host_call" st));
  let init_st := st in
  when v_walk_result, st == ((alloc_stack "do_host_call" 32 8 st));
  rely (((0 <= (1)) /\ ((1 < (31)))));
  let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in
  when v_0, st == ((load_RData 8 v_arrayidx st));
  let v_g_rd := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((24 + (0))))))) in
  when v_1_tmp, st == ((load_RData 8 v_g_rd st));
  rely (v_1_tmp > 0 /\ ((v_1_tmp >= GRANULES_BASE) /\ (v_1_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
  let v_1 := (int_to_ptr v_1_tmp) in
  when v_call, st == ((granule_map_spec v_1 2 st));
  let v_2 := v_call in
  let v_and := (v_0 & (18446744073709547520)) in
  when v_call1, st == ((realm_ipa_to_pa_spec v_2 v_and v_walk_result st));
  let v_cond := (v_call1 =? (2)) in
  when v_ret_0, st == (
      let v_ret_0 := 0 in
      if v_cond
      then (
        when v_call3, st == ((s2_walk_result_match_ripas_spec v_walk_result 0 st));
        when v_ret_0, st == (
            let v_ret_0 := 0 in
            if v_call3
            then (
              let v_ret_0 := 1 in
              (Some (v_ret_0, st)))
            else (
              let v_abort := (ptr_offset v_rsi_walk_result ((16 * (0)) + ((0 + (0))))) in
              when st == ((store_RData 1 v_abort 1 st));
              let v_rtt_level := (ptr_offset v_walk_result ((32 * (0)) + ((8 + (0))))) in
              when v_3, st == ((load_RData 8 v_rtt_level st));
              let v_rtt_level4 := (ptr_offset v_rsi_walk_result ((16 * (0)) + ((8 + (0))))) in
              when st == ((store_RData 8 v_rtt_level4 v_3 st));
              let v_ret_0 := 0 in
              (Some (v_ret_0, st))));
        (Some (v_ret_0, st)))
      else (
        let v_pa := (ptr_offset v_walk_result ((32 * (0)) + ((0 + (0))))) in
        when v_4, st == ((load_RData 8 v_pa st));
        when v_call6, st == ((find_granule_spec v_4 st));
        rely (v_call6.(pbase) = "granules");
        when v_call7, st == ((granule_map_spec v_call6 24 st));
        let v_sub := (v_0 & (4095)) in
        let v_add_ptr := (ptr_offset v_call7 ((1 * (v_sub)) + (0))) in
        let v_cmp_not := (ptr_eqb v_rec_exit (mkPtr "null" 0)) in
        when st == do_host_call_spec_state_oracle st;
        when st == ((buffer_unmap_spec v_call7 st));
        let v_llt := (ptr_offset v_walk_result ((32 * (0)) + ((24 + (0))))) in
        when v_22_tmp, st == ((load_RData 8 v_llt st));
        rely (v_22_tmp > 0 /\ ((v_22_tmp >= GRANULES_BASE) /\ (v_22_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
        let v_22 := (int_to_ptr v_22_tmp) in
        when st == ((granule_unlock_spec v_22 st));
        let v_ret_0 := 0 in
        (Some (v_ret_0, st))));
  when st == ((buffer_unmap_spec v_call st));
  let __return__ := true in
  let __retval__ := v_ret_0 in
  when st == ((free_stack "do_host_call" init_st st));
  (Some (__retval__, st)).

Definition region_in_rec_par_spec_low (v_rec: Ptr) (v_base: Z) (v_end: Z) (st: RData) : (option (bool * RData)) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  when v_call, st == ((rec_par_size_spec v_rec st));
  when v_call1, st == ((region_is_contained_spec 0 v_call v_base v_end st));
  let __return__ := true in
  let __retval__ := v_call1 in
  (Some (__retval__, st)).
