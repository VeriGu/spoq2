Definition handle_rsi_host_call_spec_low (v_agg_result: Ptr) (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : (option RData) :=
  rely (v_agg_result.(pbase) = "handle_realm_rsi_stack");
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  let v_0 := (ptr_offset v_agg_result ((24 * (0)) + ((0 + ((0 + (0))))))) in
  when st == ((llvm_memset_p0i8_i64_spec v_0 0 24 false st));
  rely (((0 <= (1)) /\ ((1 < (31)))));
  let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in
  when v_1, st == ((load_RData 8 v_arrayidx st));
  let v_rem := (v_1 & (255)) in
  let v_cmp := (v_rem =? (0)) in
  when st == (
      if v_cmp
      then (
        let v_sub := (v_1 + (255)) in
        let v_cmp2_not_unshifted := (Z.lxor v_sub v_1) in
        let v_cmp2_not := (v_cmp2_not_unshifted <? (4096)) in
        when st == (
            if v_cmp2_not
            then (
              when v_call, st == ((addr_in_rec_par_spec v_rec v_1 st));
              when st == (
                  if v_call
                  then (
                    let v_walk_result := (ptr_offset v_agg_result ((24 * (0)) + ((0 + (0))))) in
                    when v_call9, st == ((do_host_call_spec v_rec v_rec_exit (mkPtr "null" 0) v_walk_result st));
                    let v_conv := v_call9 in
                    let v_smc_result10 := (ptr_offset v_agg_result ((24 * (0)) + ((16 + (0))))) in
                    when st == ((store_RData 8 v_smc_result10 v_conv st));
                    (Some st))
                  else (
                    let v_smc_result7 := (ptr_offset v_agg_result ((24 * (0)) + ((16 + (0))))) in
                    when st == ((store_RData 8 v_smc_result7 1 st));
                    (Some st)));
              (Some st))
            else (
              let v_smc_result4 := (ptr_offset v_agg_result ((24 * (0)) + ((16 + (0))))) in
              when st == ((store_RData 8 v_smc_result4 1 st));
              (Some st)));
        (Some st))
      else (
        let v_smc_result := (ptr_offset v_agg_result ((24 * (0)) + ((16 + (0))))) in
        when st == ((store_RData 8 v_smc_result 1 st));
        (Some st)));
  let __return__ := true in
  (Some st).

Definition handle_rsi_ipa_state_set_spec_low (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  rely (v_rec_exit.(pbase) = "smc_rec_enter_stack");
  let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in
  when v_0, st == ((load_RData 8 v_arrayidx st));
  rely (((0 <= (2)) /\ ((2 < (31)))));
  let v_arrayidx2 := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (2)) + (0))))))) in
  when v_1, st == ((load_RData 8 v_arrayidx2 st));
  let v_add := (v_1 + (v_0)) in
  rely (((0 <= (3)) /\ ((3 < (31)))));
  let v_arrayidx4 := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (3)) + (0))))))) in
  when v_2, st == ((load_RData 8 v_arrayidx4 st));
  let v_conv := v_2 in
  let v_cmp := (v_conv >? (1)) in
  when v_retval_0, st == (
      let v_retval_0 := false in
      if v_cmp
      then (
        let v_retval_0 := true in
        (Some (v_retval_0, st)))
      else (
        let v_rem := (v_0 & (4095)) in
        let v_cmp6 := (v_rem =? (0)) in
        when v_retval_0, st == (
            let v_retval_0 := false in
            if v_cmp6
            then (
              let v_rem10 := (v_1 & (4095)) in
              let v_cmp11 := (v_rem10 =? (0)) in
              when v_retval_0, st == (
                  let v_retval_0 := false in
                  if v_cmp11
                  then (
                    let v_cmp15_not := (v_add >? (v_0)) in
                    when v_retval_0, st == (
                        let v_retval_0 := false in
                        if v_cmp15_not
                        then (
                          when v_call, st == ((region_in_rec_par_spec v_rec v_0 v_add st));
                          when v_retval_0, st == (
                              let v_retval_0 := false in
                              if v_call
                              then (
                                let v_start21 := (ptr_offset v_rec ((3272 * (0)) + ((848 + ((0 + (0))))))) in
                                when st == ((store_RData 8 v_start21 v_0 st));
                                let v_end23 := (ptr_offset v_rec ((3272 * (0)) + ((848 + ((8 + (0))))))) in
                                when st == ((store_RData 8 v_end23 v_add st));
                                let v_addr := (ptr_offset v_rec ((3272 * (0)) + ((848 + ((16 + (0))))))) in
                                when st == ((store_RData 8 v_addr v_0 st));
                                let v_ripas26 := (ptr_offset v_rec ((3272 * (0)) + ((848 + ((24 + (0))))))) in
                                when st == ((store_RData 4 v_ripas26 v_conv st));
                                let v_exit_reason := (ptr_offset v_rec_exit ((2048 * (0)) + ((0 + ((0 + (0))))))) in
                                when st == ((store_RData 8 v_exit_reason 4 st));
                                let v_ripas_base := (ptr_offset v_rec_exit ((2048 * (0)) + ((1280 + ((0 + ((0 + (0))))))))) in
                                when st == ((store_RData 8 v_ripas_base v_0 st));
                                let v_ripas_size := (ptr_offset v_rec_exit ((2048 * (0)) + ((1280 + ((0 + ((8 + (0))))))))) in
                                when st == ((store_RData 8 v_ripas_size v_1 st));
                                let v_conv27 := v_2 in
                                let v_ripas_value := (ptr_offset v_rec_exit ((2048 * (0)) + ((1280 + ((0 + ((16 + (0))))))))) in
                                when st == ((store_RData 1 v_ripas_value v_conv27 st));
                                let v_retval_0 := false in
                                (Some (v_retval_0, st)))
                              else (
                                let v_retval_0 := true in
                                (Some (v_retval_0, st))));
                          (Some (v_retval_0, st)))
                        else (
                          let v_retval_0 := true in
                          (Some (v_retval_0, st))));
                    (Some (v_retval_0, st)))
                  else (
                    let v_retval_0 := true in
                    (Some (v_retval_0, st))));
              (Some (v_retval_0, st)))
            else (
              let v_retval_0 := true in
              (Some (v_retval_0, st))));
        (Some (v_retval_0, st))));
  let __return__ := true in
  let __retval__ := v_retval_0 in
  (Some (__retval__, st)).

Definition check_pending_irq_spec_low (st: RData) : (option (bool * RData)) :=
  when v_call, st == ((read_isr_el1_spec st));
  let v_cmp := (v_call <>? (0)) in
  let __return__ := true in
  let __retval__ := v_cmp in
  (Some (__retval__, st)).

Definition emulate_stage2_data_abort_spec_low (v_rec: Ptr) (v_rec_exit: Ptr) (v_rtt_level: Z) (st: RData) : (option RData) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  rely (v_rec_exit.(pbase) = "smc_rec_enter_stack");
  let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in
  when v_0, st == ((load_RData 8 v_arrayidx st));
  let v_add := (v_rtt_level + (4)) in
  let v_or := (v_add |' (2415919104)) in
  let v_esr := (ptr_offset v_rec_exit ((2048 * (0)) + ((256 + ((0 + ((0 + (0))))))))) in
  when st == ((store_RData 8 v_esr v_or st));
  let v_far := (ptr_offset v_rec_exit ((2048 * (0)) + ((256 + ((0 + ((8 + (0))))))))) in
  when st == ((store_RData 8 v_far 0 st));
  let v_shr := (v_0 >> (8)) in
  let v_hpfar := (ptr_offset v_rec_exit ((2048 * (0)) + ((256 + ((0 + ((16 + (0))))))))) in
  when st == ((store_RData 8 v_hpfar v_shr st));
  let v_exit_reason := (ptr_offset v_rec_exit ((2048 * (0)) + ((0 + ((0 + (0))))))) in
  when st == ((store_RData 8 v_exit_reason 0 st));
  let __return__ := true in
  (Some st).

Definition return_result_to_realm_spec_low (v_rec: Ptr) (v_result: Ptr) (st: RData) : (option RData) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  rely (v_result.(pbase) = "handle_realm_rsi_stack");
  let v_arrayidx := (ptr_offset v_result ((40 * (0)) + ((0 + (((8 * (0)) + (0))))))) in
  when v_0, st == ((load_RData 8 v_arrayidx st));
  let v_arrayidx1 := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (0)) + (0))))))) in
  when st == ((store_RData 8 v_arrayidx1 v_0 st));
  let v_arrayidx3 := (ptr_offset v_result ((40 * (0)) + ((0 + (((8 * (1)) + (0))))))) in
  when v_1, st == ((load_RData 8 v_arrayidx3 st));
  let v_arrayidx5 := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in
  when st == ((store_RData 8 v_arrayidx5 v_1 st));
  let v_arrayidx7 := (ptr_offset v_result ((40 * (0)) + ((0 + (((8 * (2)) + (0))))))) in
  when v_2, st == ((load_RData 8 v_arrayidx7 st));
  let v_arrayidx9 := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (2)) + (0))))))) in
  when st == ((store_RData 8 v_arrayidx9 v_2 st));
  let v_arrayidx11 := (ptr_offset v_result ((40 * (0)) + ((0 + (((8 * (3)) + (0))))))) in
  when v_3, st == ((load_RData 8 v_arrayidx11 st));
  let v_arrayidx13 := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (3)) + (0))))))) in
  when st == ((store_RData 8 v_arrayidx13 v_3 st));
  let __return__ := true in
  (Some st).

Definition complete_mmio_emulation_spec_low (v_rec: Ptr) (v_rec_entry: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  rely (v_rec_entry.(pbase) = "smc_rec_enter_stack");
  let v_esr1 := (ptr_offset v_rec ((3272 * (0)) + ((928 + ((0 + (0))))))) in
  when v_0, st == ((load_RData 8 v_esr1 st));
  when v_call, st == ((esr_srt_spec v_0 st));
  let v_flags := (ptr_offset v_rec_entry ((2048 * (0)) + ((0 + ((0 + (0))))))) in
  when v_1, st == ((load_RData 8 v_flags st));
  let v_and := (v_1 & (1)) in
  let v_cmp := (v_and =? (0)) in
  match (
    let __retval__ := false in
    let __return__ := false in
    if v_cmp
    then (
      let v_retval_0 := true in
      let __return__ := true in
      let __retval__ := v_retval_0 in
      (Some (__return__, __retval__, st)))
    else (
      let v_and2 := (v_0 & (4227858432)) in
      let v_cmp3_not := (v_and2 =? (2415919104)) in
      match (
        let __retval__ := false in
        let __return__ := false in
        if v_cmp3_not
        then (
          let v_and4 := (v_0 & (16777216)) in
          let v_tobool_not := (v_and4 =? (0)) in
          match (
            let __retval__ := false in
            let __return__ := false in
            if v_tobool_not
            then (Some (__return__, __retval__, st))
            else (
              when v_call7, st == ((esr_is_write_spec v_0 st));
              let v_call7_not := (xorb v_call7 true) in
              let v_cmp8 := (v_call <>? (31)) in
              let v_or_cond := (
                  if v_call7_not
                  then v_cmp8
                  else false) in
              when st == (
                  if v_or_cond
                  then (
                    rely (((0 <= (0)) /\ ((0 < (31)))));
                    let v_arrayidx := (ptr_offset v_rec_entry ((2048 * (0)) + ((512 + ((0 + (((8 * (0)) + (0))))))))) in
                    when v_2, st == ((load_RData 8 v_arrayidx st));
                    when v_call10, st == ((access_mask_spec v_0 st));
                    let v_and11 := (v_call10 & (v_2)) in
                    when v_call12, st == ((esr_sign_extend_spec v_0 st));
                    when v_val_0, st == (
                        let v_val_0 := 0 in
                        if v_call12
                        then (
                          when v_call14, st == ((access_len_spec v_0 st));
                          let v_mul := (v_call14 * (8)) in
                          let v_sub := (v_mul + ((- 1))) in
                          let v_sh_prom := v_sub in
                          let v_shl := (1 << (v_sh_prom)) in
                          let v_xor := (Z.lxor v_shl v_and11) in
                          let v_sub15 := (v_xor - (v_shl)) in
                          when v_call16, st == ((esr_sixty_four_spec v_0 st));
                          when v_val_0, st == (
                              let v_val_0 := 0 in
                              if v_call16
                              then (
                                let v_val_0 := v_sub15 in
                                (Some (v_val_0, st)))
                              else (
                                let v_and18 := (v_sub15 & (4294967295)) in
                                let v_val_0 := v_and18 in
                                (Some (v_val_0, st))));
                          (Some (v_val_0, st)))
                        else (
                          let v_val_0 := v_and11 in
                          (Some (v_val_0, st))));
                    let v_idxprom := v_call in
                    rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (31)))));
                    let v_arrayidx21 := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (v_idxprom)) + (0))))))) in
                    when st == ((store_RData 8 v_arrayidx21 v_val_0 st));
                    (Some st))
                  else (Some st));
              let v_pc := (ptr_offset v_rec ((3272 * (0)) + ((272 + (0))))) in
              when v_3, st == ((load_RData 8 v_pc st));
              let v_add := (v_3 + (4)) in
              when st == ((store_RData 8 v_pc v_add st));
              let v_retval_0 := true in
              let __return__ := true in
              let __retval__ := v_retval_0 in
              (Some (__return__, __retval__, st)))
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
        then (Some (__return__, __retval__, st))
        else (
          let v_retval_0 := false in
          let __return__ := true in
          let __retval__ := v_retval_0 in
          (Some (__return__, __retval__, st)))
      | None => None
      end)
  ) with
  | (Some (__return__, __retval__, st)) =>
    if __return__
    then (Some (__retval__, st))
    else (Some (__retval__, st))
  | None => None
  end.

