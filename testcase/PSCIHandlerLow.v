  Definition psci_affinity_info_spec_low (v_agg_result: Ptr) (v_rec: Ptr) (v_target_affinity: Z) (v_lowest_affinity_level: Z) (st: RData) : (option RData) :=
    rely (v_agg_result.(pbase) = "handle_realm_rsi_stack");
    rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
    let v_0 := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((llvm_memset_p0i8_i64_spec v_0 0 72 false st));
    let v_cmp_not := (v_lowest_affinity_level =? 0) in
    when st == (
        if v_cmp_not
        then (
          when v_call, st == ((mpidr_to_rec_idx_spec v_target_affinity st));
          let v_g_rd := (ptr_offset v_rec ((3272 * 0) + (880 + (24 + 0)))) in
          when v_1_tmp, st == ((load_RData 0 v_g_rd st));
          rely (v_1_tmp > 0 /\ ((v_1_tmp >= GRANULES_BASE) /\ (v_1_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
          let v_1 := (int_to_ptr v_1_tmp) in
          when v_call1, st == ((rd_map_read_rec_count_spec v_1 st));
          let v_cmp2_not := (v_call <? v_call1) in
          when st == (
              if v_cmp2_not
              then (
                let v_rec_idx := (ptr_offset v_rec ((3272 * 0) + (8 + 0))) in
                when v_2, st == ((load_RData 8 v_rec_idx st));
                let v_cmp8 := (v_call =? v_2) in
                when st == (
                    if v_cmp8
                    then (
                      rely (((0 <= 0) /\ (0 < 5)));
                      let v_arrayidx12 := (ptr_offset v_agg_result ((72 * 0) + (32 + (0 + ((8 * 0) + 0))))) in
                      when st == ((store_RData 8 v_arrayidx12 0 st));
                      (Some st))
                    else (
                      let v_pending := (ptr_offset v_rec ((3272 * 0) + (960 + (0 + 0)))) in
                      when st == ((store_RData 1 v_pending 1 st));
                      let v_forward_psci_call := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
                      when st == ((store_RData 1 v_forward_psci_call 1 st));
                      let v_x1 := (ptr_offset v_agg_result ((72 * 0) + (0 + (8 + 0)))) in
                      when st == ((store_RData 8 v_x1 v_target_affinity st));
                      (Some st)));
                (Some st))
              else (
                rely (((0 <= 0) /\ (0 < 5)));
                let v_arrayidx6 := (ptr_offset v_agg_result ((72 * 0) + (32 + (0 + ((8 * 0) + 0))))) in
                when st == ((store_RData 8 v_arrayidx6 (- 2) st));
                (Some st)));
          (Some st))
        else (
          rely (((0 <= 0) /\ (0 < 5)));
          let v_arrayidx := (ptr_offset v_agg_result ((72 * 0) + (32 + (0 + ((8 * 0) + 0))))) in
          when st == ((store_RData 8 v_arrayidx (- 2) st));
          (Some st)));
    let __return__ := true in
    (Some st).

 Definition psci_cpu_off_spec_low (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
   rely (v_agg_result.(pbase) = "handle_realm_rsi_stack");
   rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
   let v_0 := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((llvm_memset_p0i8_i64_spec v_0 0 72 false st));
    let v_forward_psci_call := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((store_RData 1 v_forward_psci_call 1 st));
    let v_runnable := (ptr_offset v_rec ((3272 * 0) + (16 + 0))) in
    when st == ((store_RData 1 v_runnable 0 st));
    rely (((0 <= 0) /\ (0 < 5)));
    let v_arrayidx := (ptr_offset v_agg_result ((72 * 0) + (32 + (0 + ((8 * 0) + 0))))) in
    when st == ((store_RData 8 v_arrayidx 0 st));
    let __return__ := true in
    (Some st).

  Definition psci_cpu_on_spec_low (v_agg_result: Ptr) (v_rec: Ptr) (v_target_cpu: Z) (v_entry_point_address: Z) (v_context_id: Z) (st: RData) : (option RData) :=
    rely (v_agg_result.(pbase) = "handle_realm_rsi_stack");
    rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
    let v_0 := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((llvm_memset_p0i8_i64_spec v_0 0 72 false st));
    when v_call, st == ((addr_in_rec_par_spec v_rec v_entry_point_address st));
    when st == (
        if v_call
        then (
          when v_call1, st == ((mpidr_to_rec_idx_spec v_target_cpu st));
          let v_g_rd := (ptr_offset v_rec ((3272 * 0) + (880 + (24 + 0)))) in
          when v_1_tmp, st == ((load_RData 8 v_g_rd st));
          rely (v_1_tmp > 0 /\ ((v_1_tmp >= GRANULES_BASE) /\ (v_1_tmp < GRANULES_BASE + RMM_MAX_GRANULES * ST_GRANULE_SIZE)));
          let v_1 := (int_to_ptr v_1_tmp) in
          when v_call2, st == ((rd_map_read_rec_count_spec v_1 st));
          let v_cmp_not := (v_call1 <? v_call2) in
          when st == (
              if v_cmp_not
              then (
                let v_rec_idx := (ptr_offset v_rec ((3272 * 0) + (8 + 0))) in
                when v_2, st == ((load_RData 8 v_rec_idx st));
                let v_cmp8 := (v_call1 =? v_2) in
                when st == (
                    if v_cmp8
                    then (
                      rely (((0 <= 0) /\ (0 < 5)));
                      let v_arrayidx12 := (ptr_offset v_agg_result ((72 * 0) + (32 + (0 + ((8 * 0) + 0))))) in
                      when st == ((store_RData 8 v_arrayidx12 (- 4) st));
                      (Some st))
                    else (
                      let v_pending := (ptr_offset v_rec ((3272 * 0) + (960 + (0 + 0)))) in
                      when st == ((store_RData 1 v_pending 1 st));
                      let v_forward_psci_call := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
                      when st == ((store_RData 1 v_forward_psci_call 1 st));
                      let v_x1 := (ptr_offset v_agg_result ((72 * 0) + (0 + (8 + 0)))) in
                      when st == ((store_RData 8 v_x1 v_target_cpu st));
                      (Some st)));
                (Some st))
              else (
                rely (((0 <= 0) /\ (0 < 5)));
                let v_arrayidx6 := (ptr_offset v_agg_result ((72 * 0) + (32 + (0 + ((8 * 0) + 0))))) in
                when st == ((store_RData 8 v_arrayidx6 (- 2) st));
                (Some st)));
          (Some st))
        else (
          rely (((0 <= 0) /\ (0 < 5)));
          let v_arrayidx := (ptr_offset v_agg_result ((72 * 0) + (32 + (0 + ((8 * 0) + 0))))) in
          when st == ((store_RData 8 v_arrayidx (- 9) st));
          (Some st)));
    let __return__ := true in
    (Some st).

  Definition psci_cpu_suspend_spec_low (v_agg_result: Ptr) (v_rec: Ptr) (v_entry_point_address: Z) (v_context_id: Z) (st: RData) : (option RData) :=
    rely (v_agg_result.(pbase) = "handle_realm_rsi_stack");
    rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
    let v_0 := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((llvm_memset_p0i8_i64_spec v_0 0 72 false st));
    let v_forward_psci_call := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((store_RData 1 v_forward_psci_call 1 st));
    rely (((0 <= 0) /\ (0 < 5)));
    let v_arrayidx := (ptr_offset v_agg_result ((72 * 0) + (32 + (0 + ((8 * 0) + 0))))) in
    when st == ((store_RData 8 v_arrayidx 0 st));
    let __return__ := true in
    (Some st).

  Definition psci_features_spec_low (v_agg_result: Ptr) (v_rec: Ptr) (v_psci_func_id: Z) (st: RData) : (option RData) :=
    rely (v_agg_result.(pbase) = "handle_realm_rsi_stack");
    rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
    let v_0 := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((llvm_memset_p0i8_i64_spec v_0 0 72 false st));
    when v_ret_0, st == (
        let v_ret_0 := 0 in
        if (
          (((((((((((v_psci_func_id =? 2214592513) || (v_psci_func_id =? 3288334337)) || (v_psci_func_id =? 2214592514)) || (v_psci_func_id =? 2214592515)) ||
            (v_psci_func_id =? 3288334339)) ||
            (v_psci_func_id =? 2214592516)) ||
            (v_psci_func_id =? 3288334340)) ||
            (v_psci_func_id =? 2214592520)) ||
            (v_psci_func_id =? 2214592521)) ||
            (v_psci_func_id =? 2214592522)) ||
            (v_psci_func_id =? 2147483648)))
        then (
          let v_ret_0 := 0 in
          (Some (v_ret_0, st)))
        else (
          let v_ret_0 := (- 1) in
          (Some (v_ret_0, st))));
    rely (((0 <= 0) /\ (0 < 5)));
    let v_arrayidx := (ptr_offset v_agg_result ((72 * 0) + (32 + (0 + ((8 * 0) + 0))))) in
    when st == ((store_RData 8 v_arrayidx v_ret_0 st));
    let __return__ := true in
    (Some st).

  Definition psci_system_off_spec_low (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
    rely (v_agg_result.(pbase) = "handle_realm_rsi_stack");
    rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
    let v_0 := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((llvm_memset_p0i8_i64_spec v_0 0 72 false st));
    when st == ((system_off_reboot_spec v_rec st));
    let v_forward_psci_call := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((store_RData 1 v_forward_psci_call 1 st));
    let __return__ := true in
    (Some st).

  Definition psci_system_reset_spec_low (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
    rely (v_agg_result.(pbase) = "handle_realm_rsi_stack");
    rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
    let v_0 := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((llvm_memset_p0i8_i64_spec v_0 0 72 false st));
    when st == ((system_off_reboot_spec v_rec st));
    let v_forward_psci_call := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((store_RData 1 v_forward_psci_call 1 st));
    let __return__ := true in
    (Some st).

  Definition psci_version_spec_low (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
    rely (v_agg_result.(pbase) = "handle_realm_rsi_stack");
    rely (v_rec.(pbase) = "slot_rec" /\ v_rec.(poffset) = 0);
    let v_0 := (ptr_offset v_agg_result ((72 * 0) + (0 + (0 + 0)))) in
    when st == ((llvm_memset_p0i8_i64_spec v_0 0 72 false st));
    rely (((0 <= 0) /\ (0 < 5)));
    let v_arrayidx := (ptr_offset v_agg_result ((72 * 0) + (32 + (0 + ((8 * 0) + 0))))) in
    when st == ((store_RData 8 v_arrayidx 65537 st));
    let __return__ := true in
    (Some st).
