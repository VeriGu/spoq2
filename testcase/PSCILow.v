Definition psci_complete_request_spec_low (v_calling_rec: Ptr) (v_target_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (v_calling_rec.(pbase) = "slot_rec" /\ v_calling_rec.(poffset) = 0);
  rely (v_target_rec.(pbase) = "slot_rec2" /\ v_target_rec.(poffset) = 0);
  let v_arrayidx := (ptr_offset v_calling_rec ((3272 * 0) + (24 + ((8 * 1) + 0)))) in
  when v_0, st == ((load_RData 8 v_arrayidx st));
  let v_pending := (ptr_offset v_calling_rec ((3272 * 0) + (960 + (0 + 0)))) in
  when v_1, st == ((load_RData 1 v_pending st));
  let v_2 := (v_1 & 1) in
  let v_tobool_not := (v_2 =? 0) in
  when v_retval_0, st == (
      let v_retval_0 := 0 in
      if v_tobool_not
      then (
        let v_retval_0 := 1 in
        (Some (v_retval_0, st)))
      else (
        let v_g_rd := (ptr_offset v_calling_rec ((3272 * 0) + (880 + (24 + 0)))) in
        when v_3_tmp, st == ((load_RData 8 v_g_rd st));
        rely (v_3_tmp > 0 /\ ((v_3_tmp >= GRANULES_BASE) /\ (v_3_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
        let v_3 := (int_to_ptr v_3_tmp) in
        let v_g_rd2 := (ptr_offset v_target_rec ((3272 * 0) + (880 + (24 + 0)))) in
        when v_4_tmp, st == ((load_RData 8 v_g_rd2 st));
        rely (v_4_tmp > 0 /\ ((v_4_tmp >= GRANULES_BASE) /\ (v_4_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
        let v_4 := (int_to_ptr v_4_tmp) in
        let v_cmp_not := (ptr_eqb v_3 v_4) in
        when v_retval_0, st == (
            let v_retval_0 := 0 in
            if v_cmp_not
            then (
              when v_call, st == ((mpidr_to_rec_idx_spec v_0 st));
              let v_rec_idx := (ptr_offset v_target_rec ((3272 * 0) + (8 + 0))) in
              when v_5, st == ((load_RData 8 v_rec_idx st));
              let v_cmp5_not := (v_call =? v_5) in
              when v_retval_0, st == (
                  let v_retval_0 := 0 in
                  if v_cmp5_not
                  then (
                    rely (((0 <= 0) /\ (0 < 31)));
                    let v_arrayidx9 := (ptr_offset v_calling_rec ((3272 * 0) + (24 + ((8 * 0) + 0)))) in
                    when v_6, st == ((load_RData 8 v_arrayidx9 st));
                    when v_ret_0, st == (
                        let v_ret_0 := 0 in
                        if ((v_6 =? 2214592515) || (v_6 =? 3288334339))
                        then (
                          let v_ret_0 := (- 1) in
                          (Some (v_ret_0, st)))
                        else (
                          when v_call14, st == ((complete_psci_affinity_info_spec v_target_rec st));
                          let v_ret_0 := v_call14 in
                          (Some (v_ret_0, st))));
                    when st == ((store_RData 8 v_arrayidx9 v_ret_0 st));
                    when st == ((store_RData 8 v_arrayidx 0 st));
                    rely (((0 <= 2) /\ (2 < 31)));
                    let v_arrayidx20 := (ptr_offset v_calling_rec ((3272 * 0) + (24 + ((8 * 2) + 0)))) in
                    when st == ((store_RData 8 v_arrayidx20 0 st));
                    rely (((0 <= 3) /\ (3 < 31)));
                    let v_arrayidx22 := (ptr_offset v_calling_rec ((3272 * 0) + (24 + ((8 * 3) + 0)))) in
                    when st == ((store_RData 8 v_arrayidx22 0 st));
                    when st == ((store_RData 1 v_pending 0 st));
                    let v_retval_0 := 0 in
                    (Some (v_retval_0, st)))
                  else (
                    let v_retval_0 := 1 in
                    (Some (v_retval_0, st))));
              (Some (v_retval_0, st)))
            else (
              let v_retval_0 := 1 in
              (Some (v_retval_0, st))));
        (Some (v_retval_0, st))));
  let __return__ := true in
  let __retval__ := v_retval_0 in
  (Some (__retval__, st)).

Definition system_off_reboot_spec_low (v_rec: Ptr) (st: RData) : (option RData) :=
  rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
  let v_g_rd1 := (ptr_offset v_rec ((3272 * 0) + (880 + (24 + 0)))) in
  when v_0_tmp, st == ((load_RData 8 v_g_rd1 st));
  rely (v_0_tmp > 0 /\ ((v_0_tmp >= GRANULES_BASE) /\ (v_0_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
  let v_0 := (int_to_ptr v_0_tmp) in
  when st == ((granule_lock_spec v_0 2 st));
  when v_1_tmp, st == ((load_RData 8 v_g_rd1 st));
  rely (v_1_tmp > 0 /\ ((v_1_tmp >= GRANULES_BASE) /\ (v_1_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
  let v_1 := (int_to_ptr v_1_tmp) in
  when v_call, st == ((granule_map_spec v_1 2 st));
  let v_2 := v_call in
  when st == ((set_rd_state_spec v_2 2 st));
  when st == ((buffer_unmap_spec v_call st));
  when st == ((granule_unlock_spec v_0 st));
  let __return__ := true in
  (Some st).
