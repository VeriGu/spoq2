  Definition complete_psci_cpu_on_spec_low (v_target_rec: Ptr) (v_entry_point_address: Z) (v_caller_sctlr_el1: Z) (st: RData) : (option (Z * RData)) :=
    rely (v_target_rec.(pbase) = "slot_rec2" /\ v_target_rec.(poffset) = 0);
    let v_g_rec := (ptr_offset v_target_rec ((3272 * 0) + (0 + 0))) in
    when v_0_tmp, st == ((load_RData 8 v_g_rec st));
    rely (int_is_granule v_0_tmp);
    let v_0 := (int_to_ptr v_0_tmp) in
    when v_call, st == ((granule_refcount_read_acquire_spec v_0 st));
    let v_cmp_not := (v_call =? 0) in
    match (
      let __retval__ := 0 in
      let __return__ := false in
      if v_cmp_not
      then (
        let v_runnable := (ptr_offset v_target_rec ((3272 * 0) + (16 + 0))) in
        when v_1, st == ((load_RData 1 v_runnable st));
        let v_2 := (v_1 & 1) in
        let v_tobool_not := (v_2 =? 0) in
        match (
          let __retval__ := 0 in
          let __return__ := false in
          if v_tobool_not
          then (
            when st == ((psci_reset_rec_spec v_target_rec v_caller_sctlr_el1 st));
            let v_pc := (ptr_offset v_target_rec ((3272 * 0) + (272 + 0))) in
            when st == ((store_RData 8 v_pc v_entry_point_address st));
            when st == ((store_RData 1 v_runnable 1 st));
            let v_retval_0 := 0 in
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
      then (Some (__retval__, st))
      else (
        let v_retval_0 := (- 4) in
        let __return__ := true in
        let __retval__ := v_retval_0 in
        (Some (__retval__, st)))
    | None => None
    end.

  Definition complete_psci_affinity_info_spec_low (v_target_rec: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (v_target_rec.(pbase) = "slot_rec2" /\ v_target_rec.(poffset) = 0);
    let v_g_rec := (ptr_offset v_target_rec ((3272 * 0) + (0 + 0))) in
    when v_0_tmp, st == ((load_RData 8 v_g_rec st));
    rely (int_is_granule v_0_tmp);
    let v_0 := (int_to_ptr v_0_tmp) in
    when v_call, st == ((granule_refcount_read_acquire_spec v_0 st));
    let v_cmp_not := (v_call =? 0) in
    match (
      let __retval__ := 0 in
      let __return__ := false in
      if v_cmp_not
      then (
        let v_runnable := (ptr_offset v_target_rec ((3272 * 0) + (16 + 0))) in
        when v_1, st == ((load_RData 1 v_runnable st));
        let v_2 := (v_1 & 1) in
        let v_tobool_not := (v_2 =? 0) in
        match (
          let __retval__ := 0 in
          let __return__ := false in
          if v_tobool_not
          then (
            let v_retval_0 := 1 in
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
      then (Some (__retval__, st))
      else (
        let v_retval_0 := 0 in
        let __return__ := true in
        let __retval__ := v_retval_0 in
        (Some (__retval__, st)))
    | None => None
    end.
