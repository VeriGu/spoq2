Definition map_unmap_ns_3_low
  (v_wi: Ptr)
  (st_16: RData) : option (bool * Ptr * RData) :=
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  when v_5_tmp, st_17 == ((load_RData 8 (ptr_offset v_wi 0) st_16));
  rely (v_5_tmp < STACK_VIRT /\ v_5_tmp >= GRANULES_BASE);
  when v_call18, st_18 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_17));
  when v_7, st_19 == ((load_RData 8 (ptr_offset v_wi 8) st_18));
  when v_call19, st_20 == ((__tte_read_spec (ptr_offset v_call18 (8 * (v_7))) st_19));
  when v_call23, st_21 == s2tte_is_unassigned_spec v_call19 st_20;
  Some (v_call23, v_call18, st_21).

Definition map_unmap_ns_2_low
  (v_s2_ctx: Ptr)
  (v_call1_0: Ptr)
  (v_2_tmp: Z)
  (v_call: Ptr)
  (v_call6_1: Z)
  (v_call7_1: Z)
  (v_map_addr: Z)
  (v_level: Z)
  (v_wi: Ptr)
  (st_9: RData) : option (Z * RData) :=
  rely (v_s2_ctx.(pbase) = "stack_s2_ctx");
  rely (v_s2_ctx.(poffset) = 0);
  rely (v_call1_0.(pbase) = "slot_rd");
  rely (v_call1_0.(poffset) = 0);
  rely (v_2_tmp < STACK_VIRT /\ v_2_tmp >= GRANULES_BASE);
  rely (v_call.(pbase) = "granules");
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  when st_11 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1_0 16) 32 false st_9));
  when st_12 == ((buffer_unmap_spec v_call1_0 st_11));
  when st_13 == ((granule_lock_spec (int_to_ptr v_2_tmp) 6 st_12));
  when st_14 == ((granule_unlock_spec v_call st_13));
  when st_15 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_2_tmp) v_call6_1 v_call7_1 v_map_addr v_level v_wi st_14));
  load_RData 8 (ptr_offset v_wi 16) st_11.

Definition map_unmap_ns_4_low
  (v_host_s2tte: Z)
  (v_level: Z)
  (v_wi: Ptr)
  (v_call18: Ptr)
  (st_0: RData)
  (st_21: RData) : option (Z * RData) :=
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  rely (v_call18.(pbase) = "slot_rtt");
  when v_call28, st_22 == ((s2tte_create_valid_ns_spec v_host_s2tte v_level st_21));
  when v_8, st_23 == ((load_RData 8 (ptr_offset v_wi 8) st_22));
  when st_24 == ((__tte_write_spec (ptr_offset v_call18 (8 * (v_8))) v_call28 st_23));
  when v_9_tmp, st_25 == ((load_RData 8 (ptr_offset v_wi 0) st_24));
  rely (v_9_tmp < STACK_VIRT /\ v_9_tmp >= GRANULES_BASE);
  when st_26 == ((__granule_get_spec (int_to_ptr v_9_tmp) st_25));
  when st_28 == ((buffer_unmap_spec v_call18 st_26));
  when v_12_tmp, st_29 == ((load_RData 8 (ptr_offset v_wi 0) st_28));
  rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE);
  when st_30 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_29));
  when st_31 == ((free_stack "map_unmap_ns" st_0 st_30));
  (Some (0, st_31)).

Definition map_unmap_ns_5_low
  (v_level: Z)
  (v_call18: Ptr)
  (v_wi: Ptr)
  (st_0: RData)
  (st_21: RData) : option (Z * RData) :=
  rely (v_call18.(pbase) = "slot_rtt");
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  when v_call26, st_22 == ((pack_return_code_spec 4 v_level st_21));
  when st_23 == ((buffer_unmap_spec v_call18 st_22));
  when v_12_tmp, st_24 == ((load_RData 8 (ptr_offset v_wi 0) st_23));
  rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE);
  when st_25 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_24));
  when st_27 == ((free_stack "map_unmap_ns" st_0 st_25));
  (Some (v_call26, st_27)).

Definition map_unmap_ns_6_low
  (v_4: Z)
  (v_wi: Ptr)
  (st_0: RData)
  (st_16: RData) : option (Z * RData) :=
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  when v_call16, st_17 == ((pack_return_code_spec 4 v_4 st_16));
  when v_12_tmp, st_18 == ((load_RData 8 (ptr_offset v_wi 0) st_17));
  rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE);
  when st_19 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_18));
  when st_20 == ((free_stack "map_unmap_ns" st_0 st_19));
  (Some (v_call16, st_20)).

Definition map_unmap_ns_1_low
  (v_call1_0: Ptr)
  (v_map_addr: Z)
  (v_call: Ptr)
  (v_s2_ctx: Ptr)
  (v_2_tmp: Z)
  (v_level: Z)
  (v_host_s2tte: Z)
  (v_call6_1: Z)
  (v_call7_1: Z)
  (v_wi: Ptr)
  (st_0: RData)
  (st_8: RData) : option (Z * RData) :=
  rely (v_call1_0.(pbase) = "slot_rd");
  rely (v_call.(pbase) = "granules");
  rely (v_s2_ctx.(pbase) = "stack_s2_ctx");
  rely (v_s2_ctx.(poffset) = 0);
  rely (v_2_tmp < STACK_VIRT /\ v_2_tmp >= GRANULES_BASE);
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  when v_call9, st_9 == ((addr_in_par_spec v_call1_0 v_map_addr st_8));
  if v_call9
  then (
    when st_10 == ((buffer_unmap_spec v_call1_0 st_9));
    when st_11 == ((granule_unlock_spec v_call st_10));
    when st_13 == ((free_stack "map_unmap_ns" st_0 st_11));
    (Some (1, st_13)))
  else (
    when v_4, st_16 == (map_unmap_ns_2 v_s2_ctx v_call1_0 v_2_tmp v_call v_call6_1 v_call7_1 v_map_addr v_level v_wi st_9);
    if ((v_4 - (v_level)) =? (0))
    then (
      match (map_unmap_ns_3 v_wi st_16) with
      | Some (v_call23, v_call18, st_21) =>
        if v_call23
        then (map_unmap_ns_4 v_host_s2tte v_level v_wi v_call18 st_0 st_21)
        else (map_unmap_ns_5 v_level v_call18 v_wi st_0 st_21)
      | None => None
      end)
    else (map_unmap_ns_6 v_4 v_wi st_0 st_16)).

Definition map_unmap_ns_7_low
  (v_call1_0: Ptr)
  (v_map_addr: Z)
  (v_call: Ptr)
  (v_s2_ctx: Ptr)
  (v_2_tmp: Z)
  (v_level: Z)
  (v_host_s2tte: Z)
  (v_call6_1: Z)
  (v_call7_1: Z)
  (v_wi: Ptr)
  (st_0: RData)
  (st_8: RData) : option (Z * RData) :=
  rely (v_call1_0.(pbase) = "slot_rd");
  rely (v_call.(pbase) = "granules");
  rely (v_s2_ctx.(pbase) = "stack_s2_ctx");
  rely (v_s2_ctx.(poffset) = 0);
  rely (v_2_tmp < STACK_VIRT /\ v_2_tmp >= GRANULES_BASE);
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  when v_4, st_15 == (map_unmap_ns_2 v_s2_ctx v_call1_0 v_2_tmp v_call v_call6_1 v_call7_1 v_map_addr v_level v_wi st_8);
  if ((v_4 - (v_level)) =? (0))
  then (
    when v_5_tmp, st_16 == ((load_RData 8 (ptr_offset v_wi 0) st_15));
    rely (v_5_tmp < STACK_VIRT);
    rely (v_5_tmp >= GRANULES_BASE);
    when v_call18, st_17 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_16));
    when v_7, st_18 == ((load_RData 8 (ptr_offset v_wi 8) st_17));
    when v_call19, st_19 == ((__tte_read_spec (ptr_offset v_call18 (8 * (v_7))) st_18));
    when v_call35, st_20 == ((s2tte_is_valid_ns_spec v_call19 v_level st_19));
    if v_call35
    then (
      when v_10, st_21 == ((load_RData 8 (ptr_offset v_wi 8) st_20));
      when st_22 == ((__tte_write_spec (ptr_offset v_call18 (8 * (v_10))) 0 st_21));
      when v_11_tmp, st_23 == ((load_RData 8 (ptr_offset v_wi 0) st_22));
      rely (v_11_tmp < STACK_VIRT);
      rely (v_11_tmp >= GRANULES_BASE);
      when st_24 == ((__granule_put_spec (int_to_ptr v_11_tmp) st_23));
      if (v_level =? (3))
      then (
        when st_25 == ((invalidate_page_spec v_s2_ctx v_map_addr st_24));
        when st_27 == ((buffer_unmap_spec v_call18 st_25));
        when v_12_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_27));
        rely (v_12_tmp < STACK_VIRT);
        rely (v_12_tmp >= GRANULES_BASE);
        when st_29 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_28));
        when st_30 == ((free_stack "map_unmap_ns" st_0 st_29));
        (Some (0, st_30)))
      else (
        when st_25 == ((invalidate_block_spec v_s2_ctx v_map_addr st_24));
        when st_27 == ((buffer_unmap_spec v_call18 st_25));
        when v_12_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_27));
        rely (v_12_tmp < STACK_VIRT);
        rely (v_12_tmp >= GRANULES_BASE);
        when st_29 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_28));
        when st_30 == ((free_stack "map_unmap_ns" st_0 st_29));
        (Some (0, st_30))))
    else (
      when v_call38, st_21 == ((pack_return_code_spec 4 v_level st_20));
      when st_22 == ((buffer_unmap_spec v_call18 st_21));
      when v_12_tmp, st_23 == ((load_RData 8 (ptr_offset v_wi 0) st_22));
      rely (v_12_tmp < STACK_VIRT);
      rely (v_12_tmp >= GRANULES_BASE);
      when st_24 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_23));
      when st_26 == ((free_stack "map_unmap_ns" st_0 st_24));
      (Some (v_call38, st_26))))
  else (
    when v_call16, st_16 == ((pack_return_code_spec 4 v_4 st_15));
    when v_12_tmp, st_17 == ((load_RData 8 (ptr_offset v_wi 0) st_16));
    rely (v_12_tmp < STACK_VIRT);
    rely (v_12_tmp >= GRANULES_BASE);
    when st_18 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_17));
    when st_19 == ((free_stack "map_unmap_ns" st_0 st_18));
    (Some (v_call16, st_19))).

Definition map_unmap_ns_spec_low (v_rd_addr: Z) (v_map_addr: Z) (v_level: Z) (v_host_s2tte: Z) (v_op: Z) (st: RData) : (option (Z * RData)) :=
  when st_0 == ((new_frame "map_unmap_ns" st));
  when v_wi, st_1 == ((alloc_stack "map_unmap_ns" 24 8 st_0));
  when v_s2_ctx, st_2 == ((alloc_stack "map_unmap_ns" 32 8 st_1));
  when v_call, st_3 == ((find_lock_granule_spec v_rd_addr 2 st_2));
  if (ptr_eqb v_call (mkPtr "null" 0))
  then (
    when st_5 == ((free_stack "map_unmap_ns" st_0 st_3));
    (Some (1, st_5)))
  else (
    when v_call1_0, st_4 == ((granule_map_spec v_call 2 st_3));
    when v_call2, st_5 == ((validate_rtt_map_cmds_spec v_map_addr v_level v_call1_0 st_4));
    if v_call2
    then (
      when v_2_tmp, st_6 == ((load_RData 8 (ptr_offset v_call1_0 32) st_5));
      rely (v_2_tmp < STACK_VIRT /\ v_2_tmp >= GRANULES_BASE);
      when v_call6_1, st_7 == ((realm_rtt_starting_level_spec v_call1_0 st_6));
      when v_call7_1, st_8 == ((realm_ipa_bits_spec v_call1_0 st_7));
      if (v_op =? (0))
      then (map_unmap_ns_1 v_call1_0 v_map_addr v_call v_s2_ctx v_2_tmp v_level v_host_s2tte v_call6_1 v_call7_1 v_wi st_0 st_8)
      else (map_unmap_ns_7 v_call1_0 v_map_addr v_call v_s2_ctx v_2_tmp v_level v_host_s2tte v_call6_1 v_call7_1 v_wi st_0 st_8))
    else (
      when st_6 == ((buffer_unmap_spec v_call1_0 st_5));
      when st_7 == ((granule_unlock_spec v_call st_6));
      when st_9 == ((free_stack "map_unmap_ns" st_0 st_7));
      (Some (1, st_9)))).
