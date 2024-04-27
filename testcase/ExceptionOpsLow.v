Definition data_create_1_low
  (v_data_addr: Z)
  (v_wi: Ptr)
  (v_call14: Ptr)
  (v_call1_0: Ptr)
  (v_g_rd: Ptr)
  (v_g_data: Ptr)
  (st_0: RData)
  (st_20: RData) : option (Z * RData) :=
  rely (v_wi.(pbase) = "data_create_stack");
  rely (v_call14.(pbase) = "slot_rtt");
  rely (v_call1_0.(pbase) = "slot_rd");
  rely (v_g_rd.(pbase) = "data_create_stack");
  rely (v_g_data.(pbase) = "data_create_stack");
  when v_call33, st_22 == ((s2tte_create_assigned_empty_spec v_data_addr 3 st_20));
  when v_9, st_23 == ((load_RData 8 (ptr_offset v_wi 8) st_22));
  when st_24 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_9))) v_call33 st_23));
  when v_10_tmp, st_25 == ((load_RData 8 (ptr_offset v_wi 0) st_24));
  rely (v_10_tmp < STACK_VIRT /\ v_10_tmp >= GRANULES_BASE);
  when st_26 == ((__granule_get_spec (int_to_ptr v_10_tmp) st_25));
  when st_27 == ((buffer_unmap_spec v_call14 st_26));
  when v_11_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_27));
  rely (v_11_tmp < STACK_VIRT /\ v_11_tmp >= GRANULES_BASE);
  when st_29 == ((granule_unlock_spec (int_to_ptr v_11_tmp) st_28));
  when st_30 == ((buffer_unmap_spec v_call1_0 st_29));
  when v_12_tmp, st_31 == ((load_RData 8 v_g_rd st_30));
  rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE);
  when st_32 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_31));
  when v_13_tmp, st_33 == ((load_RData 8 v_g_data st_32));
  rely (v_13_tmp < STACK_VIRT /\ v_13_tmp >= GRANULES_BASE);
  when st_34 == ((granule_unlock_transition_spec (int_to_ptr v_13_tmp) 5 st_33));
  when st_35 == ((free_stack "data_create" st_0 st_34));
  (Some (0, st_35)).

Definition data_create_2_low
  (v_data_addr: Z)
  (v_wi: Ptr)
  (v_call14: Ptr)
  (v_call1_0: Ptr)
  (v_g_rd: Ptr)
  (v_g_data: Ptr)
  (st_0: RData)
  (st_20: RData) : option (Z * RData) :=
  rely (v_wi.(pbase) = "data_create_stack");
  rely (v_call14.(pbase) = "slot_rtt");
  rely (v_call1_0.(pbase) = "slot_rd");
  rely (v_g_rd.(pbase) = "data_create_stack");
  rely (v_g_data.(pbase) = "data_create_stack");
  when v_call35, st_22 == ((s2tte_create_valid_spec v_data_addr 3 st_20));
  when v_9, st_23 == ((load_RData 8 (ptr_offset v_wi 8) st_22));
  when st_24 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_9))) v_call35 st_23));
  when v_10_tmp, st_25 == ((load_RData 8 (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) st_24));
  rely (v_10_tmp < STACK_VIRT /\ v_10_tmp >= GRANULES_BASE);
  when st_26 == ((__granule_get_spec (int_to_ptr v_10_tmp) st_25));
  when st_27 == ((buffer_unmap_spec v_call14 st_26));
  when v_11_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) st_27));
  rely (v_11_tmp < STACK_VIRT /\ v_11_tmp >= GRANULES_BASE);
  when st_29 == ((granule_unlock_spec (int_to_ptr v_11_tmp) st_28));
  when st_30 == ((buffer_unmap_spec v_call1_0 st_29));
  when v_12_tmp, st_31 == ((load_RData 8 v_g_rd st_30));
  rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE);
  when st_32 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_31));
  when v_13_tmp, st_33 == ((load_RData 8 v_g_data st_32));
  rely (v_13_tmp < STACK_VIRT /\ v_13_tmp >= GRANULES_BASE);
  when st_34 == ((granule_unlock_transition_spec (int_to_ptr v_13_tmp) 5 st_33));
  when st_35 == ((free_stack "data_create" st_0 st_34));
  (Some (0, st_35)).

Definition data_create_3_low
  (v_call14: Ptr)
  (v_wi: Ptr)
  (v_call1_0: Ptr)
  (v_g_rd: Ptr)
  (v_g_data: Ptr)
  (st_0: RData)
  (st_19: RData) : option (Z * RData) :=
  rely (v_call14.(pbase) = "slot_rtt");
  rely (v_wi.(pbase) = "data_create_stack");
  rely (v_call1_0.(pbase) = "slot_rd");
  rely (v_g_rd.(pbase) = "data_create_stack");
  rely (v_g_data.(pbase) = "data_create_stack");
  when v_call18, st_20 == ((pack_return_code_spec 4 3 st_19));
  when st_21 == ((buffer_unmap_spec v_call14 st_20));
  when v_11_tmp, st_22 == ((load_RData 8 (ptr_offset v_wi 0) st_21));
  rely (v_11_tmp < STACK_VIRT /\ v_11_tmp >= GRANULES_BASE);
  when st_23 == ((granule_unlock_spec (int_to_ptr v_11_tmp) st_22));
  when st_24 == ((buffer_unmap_spec v_call1_0 st_23));
  when v_12_tmp, st_25 == ((load_RData 8 v_g_rd st_24));
  rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE);
  when st_26 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_25));
  when v_13_tmp, st_27 == ((load_RData 8 v_g_data st_26));
  rely (v_13_tmp < STACK_VIRT /\ v_13_tmp >= GRANULES_BASE);
  when st_28 == ((granule_unlock_transition_spec (int_to_ptr v_13_tmp) 1 st_27));
  when st_30 == ((free_stack "data_create" st_0 st_28));
  (Some (v_call18, st_30)).

Definition data_create_4_low
  (v_4: Z)
  (v_wi: Ptr)
  (v_call1_0: Ptr)
  (v_g_rd: Ptr)
  (v_g_data: Ptr)
  (st_0: RData)
  (st_14: RData) : option (Z * RData) :=
  rely (v_wi.(pbase) = "data_create_stack");
  rely (v_call1_0.(pbase) = "slot_rd");
  rely (v_g_rd.(pbase) = "data_create_stack");
  rely (v_g_data.(pbase) = "data_create_stack");
  when v_call12, st_15 == ((pack_return_code_spec 4 v_4 st_14));
  when v_11_tmp, st_16 == ((load_RData 8 (ptr_offset v_wi 0) st_15));
  rely (v_11_tmp < STACK_VIRT /\ v_11_tmp >= GRANULES_BASE);
  when st_17 == ((granule_unlock_spec (int_to_ptr v_11_tmp) st_16));
  when st_18 == ((buffer_unmap_spec v_call1_0 st_17));
  when v_12_tmp, st_19 == ((load_RData 8 v_g_rd st_18));
  rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE);
  when st_20 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_19));
  when v_13_tmp, st_21 == ((load_RData 8 v_g_data st_20));
  rely (v_13_tmp < STACK_VIRT /\ v_13_tmp >= GRANULES_BASE);
  when st_22 == ((granule_unlock_transition_spec (int_to_ptr v_13_tmp) 1 st_21));
  when st_24 == ((free_stack "data_create" st_0 st_22));
  (Some (v_call12, st_24)).

Definition data_create_5_low
  (v_call1_0: Ptr)
  (v_g_rd: Ptr)
  (v_g_data: Ptr)
  (v_call3: Z)
  (st_0: RData)
  (st_7: RData) : option (Z * RData) :=
  rely (v_call1_0.(pbase) = "slot_rd");
  rely (v_g_rd.(pbase) = "data_create_stack");
  rely (v_g_data.(pbase) = "data_create_stack");
  when st_9 == ((buffer_unmap_spec v_call1_0 st_7));
  when v_12_tmp, st_10 == ((load_RData 8 v_g_rd st_9));
  rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE);
  when st_11 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_10));
  when v_13_tmp, st_12 == ((load_RData 8 v_g_data st_11));
  rely (v_13_tmp < STACK_VIRT /\ v_13_tmp >= GRANULES_BASE);
  when st_13 == ((granule_unlock_transition_spec (int_to_ptr v_13_tmp) 1 st_12));
  when st_15 == ((free_stack "data_create" st_0 st_13));
  (Some (v_call3, st_15)).

Definition data_create_6_low
  (v_call24: Ptr)
  (v_call14: Ptr)
  (v_wi: Ptr)
  (v_call1_0: Ptr)
  (v_g_rd: Ptr)
  (v_g_data: Ptr)
  (st_0: RData)
  (st_23: RData) : option (Z * RData) :=
  rely (v_call24.(pbase) = "slot_delegated");
  rely (v_call14.(pbase) = "slot_rtt");
  rely (v_wi.(pbase) = "smc_rtt_create_stack");
  rely (v_call1_0.(pbase) = "slot_rd");
  rely (v_g_rd.(pbase) = "data_create_stack");
  rely (v_g_data.(pbase) = "data_create_stack");
  when v_call27, st_24 == ((memset_spec v_call24 0 4096 st_23));
  when st_25 == ((buffer_unmap_spec v_call24 st_24));
  when st_26 == ((buffer_unmap_spec v_call14 st_25));
  when v_11_tmp, st_27 == ((load_RData 8 (ptr_offset v_wi 0) st_26));
  rely (v_11_tmp < STACK_VIRT /\ v_11_tmp >= GRANULES_BASE);
  when st_28 == ((granule_unlock_spec (int_to_ptr v_11_tmp) st_27));
  when st_29 == ((buffer_unmap_spec v_call1_0 st_28));
  when v_12_tmp, st_30 == ((load_RData 8 v_g_rd st_29));
  rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE);
  when st_31 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_30));
  when v_13_tmp, st_32 == ((load_RData 8 v_g_data st_31));
  rely (v_13_tmp < STACK_VIRT /\ v_13_tmp >= GRANULES_BASE);
  when st_33 == ((granule_unlock_transition_spec (int_to_ptr v_13_tmp) 1 st_32));
  when st_35 == ((free_stack "data_create" st_0 st_33));
  (Some (1, st_35)).

Definition data_create_spec_low (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_g_src: Ptr) (v_flags: Z) (st: RData) : (option (Z * RData)) :=
  when st_0 == ((new_frame "data_create" st));
  rely (((v_g_src.(pbase)) = ("granules")) \/ ((v_g_src.(pbase)) = ("null")));
  when v_g_data, st_1 == ((alloc_stack "data_create" 8 8 st_0));
  when v_g_rd, st_2 == ((alloc_stack "data_create" 8 8 st_1));
  when v_wi, st_3 == ((alloc_stack "data_create" 24 8 st_2));
  when v_call, st_4 == ((find_lock_two_granules_spec v_data_addr 1 v_g_data v_rd_addr 2 v_g_rd st_3));
  if v_call
  then (
    when v_0_tmp, st_5 == ((load_RData 8 v_g_rd st_4));
    rely (v_0_tmp < STACK_VIRT /\ v_0_tmp >= GRANULES_BASE);
    when v_call1_0, st_6 == ((granule_map_spec (int_to_ptr v_0_tmp) 2 st_5));
    if (ptr_eqb v_g_src (mkPtr "null" 0))
    then (
      when v_call3, st_7 == ((validate_data_create_unknown_spec v_map_addr v_call1_0 st_6));
      if (v_call3 =? (0))
      then (
        when v_3_tmp, st_9 == ((load_RData 8 (ptr_offset v_call1_0 32) st_7));
        when v_call7, st_10 == ((realm_rtt_starting_level_spec v_call1_0 st_9));
        when v_call8, st_11 == ((realm_ipa_bits_spec v_call1_0 st_10));
        rely (v_3_tmp < STACK_VIRT /\ v_3_tmp >= GRANULES_BASE);
        when st_12 == ((granule_lock_spec (int_to_ptr v_3_tmp) 6 st_11));
        when st_13 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_3_tmp) v_call7 v_call8 v_map_addr 3 v_wi st_12));
        when v_4, st_14 == ((load_RData 8 (ptr_offset v_wi 16) st_13));
        if (v_4 =? (3))
        then (
          when v_5_tmp, st_15 == ((load_RData 8 (ptr_offset v_wi 0) st_14));
          rely (v_5_tmp < STACK_VIRT /\ v_5_tmp >= GRANULES_BASE);
          when v_call14, st_16 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_15));
          when v_7, st_17 == ((load_RData 8 (ptr_offset v_wi 8) st_16));
          when v_call15, st_18 == ((__tte_read_spec (ptr_offset v_call14 (8 * (v_7))) st_17));
          when v_call16, st_19 == ((s2tte_is_unassigned_spec v_call15 st_18));
          if v_call16
          then (
            when v_call20, st_20 == ((s2tte_get_ripas_spec v_call15 st_19));
            if (v_call20 =? (0))
            then (data_create_1 v_data_addr v_wi v_call14 v_call1_0 v_g_rd v_g_data st_0 st_20)
            else (data_create_2 v_data_addr v_wi v_call14 v_call1_0 v_g_rd v_g_data st_0 st_20))
          else (data_create_3 v_call14 v_wi v_call1_0 v_g_rd v_g_data st_0 st_19))
        else (data_create_4 v_4 v_wi v_call1_0 v_g_rd v_g_data st_0 st_14))
      else (data_create_5 v_call1_0 v_g_rd v_g_data v_call3 st_0 st_7))
    else (
      when v_call2, st_7 == ((validate_data_create_spec v_map_addr v_call1_0 st_6));
      if (v_call2 =? (0))
      then (
        when v_3_tmp, st_9 == ((load_RData 8 (ptr_offset v_call1_0 32) st_7));
        when v_call7, st_10 == ((realm_rtt_starting_level_spec v_call1_0 st_9));
        when v_call8, st_11 == ((realm_ipa_bits_spec v_call1_0 st_10));
        rely (v_3_tmp < STACK_VIRT /\ v_3_tmp >= GRANULES_BASE);
        when st_12 == ((granule_lock_spec (int_to_ptr v_3_tmp) 6 st_11));
        when st_13 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_3_tmp) v_call7 v_call8 v_map_addr 3 v_wi st_12));
        when v_4, st_14 == ((load_RData 8 (ptr_offset v_wi 16) st_13));
        if (v_4 =? (3))
        then (
          when v_5_tmp, st_15 == ((load_RData 8 (ptr_offset v_wi 0) st_14));
          rely (v_5_tmp < STACK_VIRT /\ v_5_tmp >= GRANULES_BASE);
          when v_call14, st_16 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_15));
          when v_7, st_17 == ((load_RData 8 (ptr_offset v_wi 8) st_16));
          when v_call15, st_18 == ((__tte_read_spec (ptr_offset v_call14 (8 * (v_7))) st_17));
          when v_call16, st_19 == ((s2tte_is_unassigned_spec v_call15 st_18));
          if v_call16
          then (
            when v_call20, st_20 == ((s2tte_get_ripas_spec v_call15 st_19));
            when v_8_tmp, st_21 == ((load_RData 8 v_g_data st_20));
            rely (v_8_tmp < STACK_VIRT /\ v_8_tmp >= GRANULES_BASE);
            when v_call24, st_22 == ((granule_map_spec (int_to_ptr v_8_tmp) 1 st_21));
            when v_call25, st_23 == ((ns_buffer_read_spec 0 v_g_src 0 4096 v_call24 st_22));
            if v_call25
            then (
              when st_24 == ((data_granule_measure_spec v_call1_0 v_call24 v_map_addr v_flags st_23));
              when st_25 == ((buffer_unmap_spec v_call24 st_24));
              if (v_call20 =? (0))
              then (data_create_1 v_data_addr v_wi v_call14 v_call1_0 v_g_rd v_g_data st_0 st_25)
              else (data_create_2 v_data_addr v_wi v_call14 v_call1_0 v_g_rd v_g_data st_0 st_25))
            else (data_create_6 v_call24 v_call14 v_wi v_call1_0 v_g_rd v_g_data st_0 st_23))
          else (data_create_3 v_call14 v_wi v_call1_0 v_g_rd v_g_data st_0 st_19))
        else (data_create_4 v_4 v_wi v_call1_0 v_g_rd v_g_data st_0 st_14))
      else (data_create_5 v_call1_0 v_g_rd v_g_data v_call2 st_0 st_7)))
  else (
    when st_6 == ((free_stack "data_create" st_0 st_4));
    (Some (1, st_6))).
