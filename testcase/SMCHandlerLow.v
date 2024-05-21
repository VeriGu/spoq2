Definition smc_rtt_init_ripas_spec_low (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
  when st_0 == ((new_frame "smc_rtt_init_ripas" st));
  (* when v_wi, st_1 == ((alloc_stack "smc_rtt_init_ripas" 24 8 st_0)); *)
  let v_wi := (mkPtr "stack_wi" 0) in
  let st_1 := st_0 in
  when v_call, st_2 == ((find_lock_granule_spec v_rd_addr 2 st_1));
  if (ptr_eqb v_call (mkPtr "null" 0))
  then (
    when st_4 == ((free_stack "smc_rtt_init_ripas" st_0 st_2));
    (Some (1, st_4)))
  else (
    when v_call1_0, st_3 == ((granule_map_spec v_call 2 st_2));
    when v_call2, st_4 == ((get_rd_state_locked_spec v_call1_0 st_3));
    if (v_call2 =? (0))
    then (
      when v_call6, st_5 == ((validate_rtt_entry_cmds_spec v_map_addr v_ulevel v_call1_0 st_4));
      if v_call6
      then (
        when v_call9, st_6 == ((addr_in_par_spec v_call1_0 v_map_addr st_5));
        if v_call9
        then (
          when v_2_tmp, st_8 == ((load_RData 8 (ptr_offset v_call1_0 32) st_6));
          when v_call12, st_9 == ((realm_rtt_starting_level_spec v_call1_0 st_8));
          when v_call13, st_10 == ((realm_ipa_bits_spec v_call1_0 st_9));
          rely (int_is_granule v_2_tmp);
          when st_11 == ((granule_lock_spec (int_to_ptr v_2_tmp) 6 st_10));
          when st_12 == ((granule_unlock_spec v_call st_11));
          when st_13 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_2_tmp) v_call12 v_call13 v_map_addr v_ulevel v_wi st_12));
          when v_3, st_14 == ((load_RData 8 (ptr_offset v_wi 16) st_13));
          if ((v_3 - (v_ulevel)) =? (0))
          then (
            when v_4_tmp, st_15 == ((load_RData 8 (ptr_offset v_wi 0) st_14));
            rely (int_is_granule v_4_tmp);
            when v_call19, st_16 == ((granule_map_spec (int_to_ptr v_4_tmp) 22 st_15));
            when v_6, st_17 == ((load_RData 8 (ptr_offset v_wi 8) st_16));
            when v_call20, st_18 == ((__tte_read_spec (ptr_offset v_call19 (8 * (v_6))) st_17));
            when v_call21, st_19 == ((s2tte_is_table_spec v_call20 v_ulevel st_18));
            if v_call21
            then (
              when v_call26, st_20 == ((pack_return_code_spec 4 v_ulevel st_19));
              when st_21 == ((buffer_unmap_spec v_call19 st_20));
              when st_22 == ((buffer_unmap_spec v_call1_0 st_21));
              when v_8_tmp, st_23 == ((load_RData 8 (ptr_offset v_wi 0) st_22));
              rely (int_is_granule v_8_tmp);
              when st_24 == ((granule_unlock_spec (int_to_ptr v_8_tmp) st_23));
              when st_25 == ((free_stack "smc_rtt_init_ripas" st_0 st_24));
              (Some (v_call26, st_25)))
            else (
              when v_call23, st_20 == ((s2tte_is_unassigned_spec v_call20 st_19));
              if v_call23
              then (
                when v_call28, st_21 == ((s2tte_create_ripas_spec 1 st_20));
                when v_7, st_22 == ((load_RData 8 (ptr_offset v_wi 8) st_21));
                when st_23 == ((__tte_write_spec (ptr_offset v_call19 (8 * (v_7))) (v_call28 |' (v_call20)) st_22));
                when st_24 == ((ripas_granule_measure_spec v_call1_0 v_map_addr v_ulevel st_23));
                when st_25 == ((buffer_unmap_spec v_call19 st_24));
                when st_26 == ((buffer_unmap_spec v_call1_0 st_25));
                when v_8_tmp, st_27 == ((load_RData 8 (ptr_offset v_wi 0) st_26));
                rely (int_is_granule v_8_tmp);
                when st_28 == ((granule_unlock_spec (int_to_ptr v_8_tmp) st_27));
                when st_30 == ((free_stack "smc_rtt_init_ripas" st_0 st_28));
                (Some (0, st_30)))
              else (
                when v_call26, st_21 == ((pack_return_code_spec 4 v_ulevel st_20));
                when st_22 == ((buffer_unmap_spec v_call19 st_21));
                when st_23 == ((buffer_unmap_spec v_call1_0 st_22));
                when v_8_tmp, st_24 == ((load_RData 8 (ptr_offset v_wi 0) st_23));
                rely (int_is_granule v_8_tmp);
                when st_25 == ((granule_unlock_spec (int_to_ptr v_8_tmp) st_24));
                when st_26 == ((free_stack "smc_rtt_init_ripas" st_0 st_25));
                (Some (v_call26, st_26)))))
          else (
            when v_call17, st_15 == ((pack_return_code_spec 4 v_3 st_14));
            when st_16 == ((buffer_unmap_spec v_call1_0 st_15));
            when v_8_tmp, st_17 == ((load_RData 8 (ptr_offset v_wi 0) st_16));
            rely (int_is_granule v_8_tmp);
            when st_18 == ((granule_unlock_spec (int_to_ptr v_8_tmp) st_17));
            when st_20 == ((free_stack "smc_rtt_init_ripas" st_0 st_18));
            (Some (v_call17, st_20))))
        else (
          when st_7 == ((buffer_unmap_spec v_call1_0 st_6));
          when st_8 == ((granule_unlock_spec v_call st_7));
          when st_10 == ((free_stack "smc_rtt_init_ripas" st_0 st_8));
          (Some (1, st_10))))
      else (
        when st_6 == ((buffer_unmap_spec v_call1_0 st_5));
        when st_7 == ((granule_unlock_spec v_call st_6));
        when st_9 == ((free_stack "smc_rtt_init_ripas" st_0 st_7));
        (Some (1, st_9))))
    else (
      when st_5 == ((buffer_unmap_spec v_call1_0 st_4));
      when st_6 == ((granule_unlock_spec v_call st_5));
      when st_8 == ((free_stack "smc_rtt_init_ripas" st_0 st_6));
      (Some (2, st_8)))).


Definition smc_data_destroy_spec_low (v_rd_addr: Z) (v_map_addr: Z) (st: RData) : (option (Z * RData)) :=
  when st_0 == ((new_frame "smc_data_destroy" st));
  (* when v_wi, st_1 == ((alloc_stack "smc_data_destroy" 24 8 st_0)); *)
  (* when v_s2_ctx, st_2 == ((alloc_stack "smc_data_destroy" 32 8 st_1)); *)
  let v_wi := (mkPtr "stack_wi" 0) in
  let v_s2_ctx := (mkPtr "stack_s2_ctx" 0) in
  let st_2 := st_0 in
  when v_call, st_3 == ((find_lock_granule_spec v_rd_addr 2 st_2));
  if (ptr_eqb v_call (mkPtr "null" 0))
  then (
    when st_5 == ((free_stack "smc_data_destroy" st_0 st_3));
    (Some (1, st_5)))
  else (
    when v_call1_0, st_4 == ((granule_map_spec v_call 2 st_3));
    when v_call2, st_5 == ((validate_map_addr_spec v_map_addr 3 v_call1_0 st_4));
    if v_call2
    then (
      when v_2_tmp, st_7 == ((load_RData 8 (ptr_offset v_call1_0 32) st_5));
      when v_call6, st_8 == ((realm_rtt_starting_level_spec v_call1_0 st_7));
      when v_call7, st_9 == ((realm_ipa_bits_spec v_call1_0 st_8));
      when st_10 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1_0 16) 32 false st_9));
      when st_11 == ((buffer_unmap_spec v_call1_0 st_10));
      rely (int_is_granule v_2_tmp);
      when st_12 == ((granule_lock_spec (int_to_ptr v_2_tmp) 6 st_11));
      when st_13 == ((granule_unlock_spec v_call st_12));
      when st_14 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_2_tmp) v_call6 v_call7 v_map_addr 3 v_wi st_13));
      when v_4, st_15 == ((load_RData 8 (ptr_offset v_wi 16) st_14));
      if (v_4 =? (3))
      then (
        when v_5_tmp, st_16 == ((load_RData 8 (ptr_offset v_wi 0) st_15));
        rely (int_is_granule v_5_tmp);
        when v_call14, st_17 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_16));
        when v_7, st_18 == ((load_RData 8 (ptr_offset v_wi 8) st_17));
        when v_call15, st_19 == ((__tte_read_spec (ptr_offset v_call14 (8 * (v_7))) st_18));
        when v_call16, st_20 == ((s2tte_is_valid_spec v_call15 3 st_19));
        if v_call16
        then (
          when v_call21, st_22 == ((s2tte_pa_spec v_call15 3 st_20));
          when v_8, st_23 == ((load_RData 8 (ptr_offset v_wi 8) st_22));
          when st_24 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_8))) 8 st_23));
          when st_25 == ((invalidate_page_spec v_s2_ctx v_map_addr st_24));
          when v_9_tmp, st_27 == ((load_RData 8 (ptr_offset v_wi 0) st_25));
          rely (int_is_granule v_9_tmp);
          when st_28 == ((__granule_put_spec (int_to_ptr v_9_tmp) st_27));
          when v_call32, st_29 == ((find_lock_granule_spec v_call21 5 st_28));
          when st_30 == ((granule_memzero_spec v_call32 1 st_29));
          when st_31 == ((granule_unlock_transition_spec v_call32 1 st_30));
          when st_32 == ((buffer_unmap_spec v_call14 st_31));
          when v_10_tmp, st_33 == ((load_RData 8 (ptr_offset v_wi 0) st_32));
          rely (int_is_granule v_10_tmp);
          when st_34 == ((granule_unlock_spec (int_to_ptr v_10_tmp) st_33));
          when st_35 == ((free_stack "smc_data_destroy" st_0 st_34));
          (Some (0, st_35)))
        else (
          when v_call17, st_21 == ((s2tte_is_assigned_spec v_call15 3 st_20));
          if v_call17
          then (
            when v_call21, st_23 == ((s2tte_pa_spec v_call15 3 st_21));
            when v_call25, st_24 == ((s2tte_create_unassigned_spec 0 st_23));
            when v_8, st_25 == ((load_RData 8 (ptr_offset v_wi 8) st_24));
            when st_26 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_8))) v_call25 st_25));
            when v_9_tmp, st_27 == ((load_RData 8 (ptr_offset v_wi 0) st_26));
            rely (int_is_granule v_9_tmp);
            when st_28 == ((__granule_put_spec (int_to_ptr v_9_tmp) st_27));
            when v_call32, st_29 == ((find_lock_granule_spec v_call21 5 st_28));
            when st_30 == ((granule_memzero_spec v_call32 1 st_29));
            when st_31 == ((granule_unlock_transition_spec v_call32 1 st_30));
            when st_32 == ((buffer_unmap_spec v_call14 st_31));
            when v_10_tmp, st_33 == ((load_RData 8 (ptr_offset v_wi 0) st_32));
            rely (int_is_granule v_10_tmp);
            when st_34 == ((granule_unlock_spec (int_to_ptr v_10_tmp) st_33));
            when st_35 == ((free_stack "smc_data_destroy" st_0 st_34));
            (Some (0, st_35)))
          else (
            when v_call19, st_22 == ((pack_return_code_spec 4 3 st_21));
            when st_23 == ((buffer_unmap_spec v_call14 st_22));
            when v_10_tmp, st_24 == ((load_RData 8 (ptr_offset v_wi 0) st_23));
            rely (int_is_granule v_10_tmp);
            when st_25 == ((granule_unlock_spec (int_to_ptr v_10_tmp) st_24));
            when st_27 == ((free_stack "smc_data_destroy" st_0 st_25));
            (Some (v_call19, st_27)))))
      else (
        when v_call12, st_16 == ((pack_return_code_spec 4 v_4 st_15));
        when v_10_tmp, st_17 == ((load_RData 8 (ptr_offset v_wi 0) st_16));
        rely (int_is_granule v_10_tmp);
        when st_18 == ((granule_unlock_spec (int_to_ptr v_10_tmp) st_17));
        when st_20 == ((free_stack "smc_data_destroy" st_0 st_18));
        (Some (v_call12, st_20))))
    else (
      when st_6 == ((buffer_unmap_spec v_call1_0 st_5));
      when st_7 == ((granule_unlock_spec v_call st_6));
      when st_9 == ((free_stack "smc_data_destroy" st_0 st_7));
      (Some (1, st_9)))).

(* Definition smc_rtt_fold_1_low *)
(*   (v_call1_0: Ptr) *)
(*   (v_s2_ctx: Ptr) *)
(*   (v_call: Ptr) *)
(*   (v_map_addr: Z) *)
(*   (v_ulevel: Z) *)
(*   (v_wi: Ptr) *)
(*   (st_6: RData) : option (Z * RData) := *)
(*   rely (v_call1_0.(pbase) = "slot_rd"); *)
(*   rely (v_call1_0.(poffset) = 0); *)
(*   rely (v_s2_ctx.(pbase) = "stack_s2_ctx"); *)
(*   rely (v_s2_ctx.(poffset) = 0); *)
(*   rely (v_call.(pbase) = "granules"); *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   when v_2_tmp, st_8 == ((load_RData 8 (ptr_offset v_call1_0 32) st_6)); *)
(*   when v_call6, st_9 == ((realm_rtt_starting_level_spec v_call1_0 st_8)); *)
(*   when v_call7, st_10 == ((realm_ipa_bits_spec v_call1_0 st_9)); *)
(*   when st_11 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1_0 16) 32 false st_10)); *)
(*   when st_12 == ((buffer_unmap_spec v_call1_0 st_11)); *)
(*   rely (v_2_tmp < STACK_VIRT /\ v_2_tmp >= GRANULES_BASE); *)
(*   when st_13 == ((granule_lock_spec (int_to_ptr v_2_tmp) 6 st_12)); *)
(*   when st_14 == ((granule_unlock_spec v_call st_13)); *)
(*   rely (v_2_tmp < STACK_VIRT /\ v_2_tmp >= GRANULES_BASE); *)
(*   when st_15 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_2_tmp) v_call6 v_call7 v_map_addr (v_ulevel + ((- 1))) v_wi st_14)); *)
(*   when v_4, st_16 == ((load_RData 8 (ptr_offset v_wi 16) st_15)); *)
(*   Some (v_4, st_16). *)

(* Definition smc_rtt_fold_2_low *)
(*   (v_s2_ctx: Ptr) *)
(*   (v_map_addr: Z) *)
(*   (v_wi: Ptr) *)
(*   (v_call15: Ptr) *)
(*   (v_call34: Ptr) *)
(*   (v_call44: Z) *)
(*   (v_call33: Ptr) *)
(*   (st_0: RData) *)
(*   (st_33: RData) : option (Z * RData) := *)
(*   rely (v_s2_ctx.(pbase) = "stack_s2_ctx"); *)
(*   rely (v_s2_ctx.(poffset) = 0); *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call15.(pbase) = "slot_rtt"); *)
(*   rely (v_call34.(pbase) = "slot_rtt2"); *)
(*   rely (v_call33.(pbase) = "granules"); *)
(*   when st_34 == ((invalidate_pages_in_block_spec v_s2_ctx v_map_addr st_33)); *)
(*   when v_14, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34)); *)
(*   when st_36 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_14))) v_call44 st_35)); *)
(*   when st_37 == ((granule_memzero_mapped_spec v_call34 st_36)); *)
(*   when st_38 == ((granule_set_state_spec v_call33 1 st_37)); *)
(*   when st_39 == ((buffer_unmap_spec v_call34 st_38)); *)
(*   when st_40 == ((granule_unlock_spec v_call33 st_39)); *)
(*   when st_41 == ((buffer_unmap_spec v_call15 st_40)); *)
(*   when v_15_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_41)); *)
(*   rely (v_15_tmp < STACK_VIRT /\ v_15_tmp >= GRANULES_BASE); *)
(*   when st_43 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_42)); *)
(*   when st_44 == ((free_stack "smc_rtt_fold" st_0 st_43)); *)
(*   (Some (0, st_44)). *)

(* Definition smc_rtt_fold_3_low *)
(*   (v_s2_ctx: Ptr) *)
(*   (v_map_addr: Z) *)
(*   (v_wi: Ptr) *)
(*   (v_call15: Ptr) *)
(*   (v_call34: Ptr) *)
(*   (v_call44: Z) *)
(*   (v_call33: Ptr) *)
(*   (st_0: RData) *)
(*   (st_34: RData) : option (Z * RData) := *)
(*   rely (v_s2_ctx.(pbase) = "stack_s2_ctx"); *)
(*   rely (v_s2_ctx.(poffset) = 0); *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call15.(pbase) = "slot_rtt"); *)
(*   rely (v_call34.(pbase) = "slot_rtt2"); *)
(*   rely (v_call33.(pbase) = "granules"); *)
(*   when st_34 == ((invalidate_block_spec v_s2_ctx v_map_addr st_34)); *)
(*   when v_14, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34)); *)
(*   when st_36 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_14))) v_call44 st_35)); *)
(*   when st_37 == ((granule_memzero_mapped_spec v_call34 st_36)); *)
(*   when st_38 == ((granule_set_state_spec v_call33 1 st_37)); *)
(*   when st_39 == ((buffer_unmap_spec v_call34 st_38)); *)
(*   when st_40 == ((granule_unlock_spec v_call33 st_39)); *)
(*   when st_41 == ((buffer_unmap_spec v_call15 st_40)); *)
(*   when v_15_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_41)); *)
(*   rely (v_15_tmp < STACK_VIRT /\ v_15_tmp >= GRANULES_BASE); *)
(*   when st_43 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_42)); *)
(*   when st_44 == ((free_stack "smc_rtt_fold" st_0 st_43)); *)
(*   (Some (0, st_44)). *)

(* Definition smc_rtt_fold_4_low *)
(*   (v_ripas: Ptr) *)
(*   (v_wi: Ptr) *)
(*   (v_call15: Ptr) *)
(*   (v_call44: Z) *)
(*   (v_ulevel: Z) *)
(*   (st_28: RData) : option (bool * RData) := *)
(*   rely (v_ripas.(pbase) = "stack_ripas"); *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_call15.(pbase) = "slot_rtt"); *)
(*   when v_11, st_29 == ((load_RData 4 v_ripas st_28)); *)
(*   when v_call44, st_30 == ((s2tte_create_unassigned_spec v_11 st_29)); *)
(*   when v_12_tmp, st_31 == ((load_RData 8 (ptr_offset v_wi 0) st_30)); *)
(*   rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE); *)
(*   when st_32 == ((__granule_put_spec (int_to_ptr v_12_tmp) st_31)); *)
(*   when v_13, st_34 == ((load_RData 8 (ptr_offset v_wi 8) st_32)); *)
(*   when st_35 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_34)); *)
(*   when v_call87, st_36 == ((s2tte_is_valid_spec v_call44 (v_ulevel + ((- 1))) st_35)); *)
(*   Some (v_call87, st_36). *)

(* Definition smc_rtt_fold_5_low *)
(*   (v_call34: Ptr) *)
(*   (v_call33: Ptr) *)
(*   (v_call15: Ptr) *)
(*   (v_wi: Ptr) *)
(*   (st_0: RData) *)
(*   (st_28: RData) : option (Z * RData) := *)
(*   rely (v_call34.(pbase) = "slot_rtt2"); *)
(*   rely (v_call33.(pbase) = "granules"); *)
(*   rely (v_call15.(pbase) = "slot_rtt"); *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   when st_29 == ((buffer_unmap_spec v_call34 st_28)); *)
(*   when st_30 == ((granule_unlock_spec v_call33 st_29)); *)
(*   when st_31 == ((buffer_unmap_spec v_call15 st_30)); *)
(*   when v_15_tmp, st_32 == ((load_RData 8 (ptr_offset v_wi 0) st_31)); *)
(*   rely (v_15_tmp < STACK_VIRT /\ v_15_tmp >= GRANULES_BASE); *)
(*   when st_33 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_32)); *)
(*   when st_35 == ((free_stack "smc_rtt_fold" st_0 st_33)); *)
(*   (Some (5, st_35)). *)

(* Definition smc_rtt_fold_6_low *)
(*   (v_call34: Ptr) *)
(*   (v_wi: Ptr) *)
(*   (v_call15: Ptr) *)
(*   (v_ulevel: Z) *)
(*   (v_s2_ctx: Ptr) *)
(*   (v_map_addr: Z) *)
(*   (v_call33: Ptr) *)
(*   (v_ripas: Ptr) *)
(*   (st_0: RData) *)
(*   (st_26: RData) : option (Z * RData) := *)
(*   rely (v_call34.(pbase) = "slot_rtt2"); *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call15.(pbase) = "slot_rtt"); *)
(*   rely (v_call33.(pbase) = "granules"); *)
(*   rely (v_ripas.(pbase) = "stack_ripas"); *)
(*   when v_call38, st_27 == ((table_is_destroyed_block_spec v_call34 st_26)); *)
(*   if v_call38 *)
(*   then ( *)
(*       when v_10_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_27)); *)
(*       rely (v_10_tmp < STACK_VIRT /\ v_10_tmp >= GRANULES_BASE); *)
(*       when st_29 == ((__granule_put_spec (int_to_ptr v_10_tmp) st_28)); *)
(*       when v_13, st_31 == ((load_RData 8 (ptr_offset v_wi 8) st_29)); *)
(*       when st_32 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_31)); *)
(*       when v_call87, st_33 == ((s2tte_is_valid_spec 8 (v_ulevel + ((- 1))) st_32)); *)
(*       if v_call87 *)
(*       then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 8 v_call33 st_0 st_33) *)
(*       else ( *)
(*           when v_call90, st_34 == ((s2tte_is_valid_ns_spec 8 (v_ulevel + ((- 1))) st_33)); *)
(*           if v_call90 *)
(*           then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 8 v_call33 st_0 st_34) *)
(*           else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 8 v_call33 st_0 st_34))) *)
(*   else ( *)
(*       when v_call42, st_28 == ((table_is_unassigned_block_spec v_call34 v_ripas st_27)); *)
(*       if v_call42 *)
(*       then ( *)
(*           when v_11, st_29 == ((load_RData 4 v_ripas st_28)); *)
(*           when v_call44, st_30 == ((s2tte_create_unassigned_spec v_11 st_29)); *)
(*           when v_12_tmp, st_31 == ((load_RData 8 (ptr_offset v_wi 0) st_30)); *)
(*           rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE); *)
(*           when st_32 == ((__granule_put_spec (int_to_ptr v_12_tmp) st_31)); *)
(*           when v_13, st_34 == ((load_RData 8 (ptr_offset v_wi 8) st_32)); *)
(*           when st_35 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_34)); *)
(*           when v_call87, st_36 == ((s2tte_is_valid_spec v_call44 (v_ulevel + ((- 1))) st_35)); *)
(*           if v_call87 *)
(*           then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call44 v_call33 st_0 st_36) *)
(*           else ( *)
(*               when v_call90, st_37 == ((s2tte_is_valid_ns_spec v_call44 (v_ulevel + ((- 1))) st_36)); *)
(*               if v_call90 *)
(*               then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call44 v_call33 st_0 st_37) *)
(*               else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call44 v_call33 st_0 st_37))) *)
(*       else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_28)). *)

(* Definition smc_rtt_fold_7_low *)
(*   (v_ulevel: Z) *)
(*   (v_call60: Z) *)
(*   (v_call33: Ptr) *)
(*   (v_wi: Ptr) *)
(*   (v_call15: Ptr) *)
(*   (v_call34: Ptr) *)
(*   (v_s2_ctx: Ptr) *)
(*   (v_map_addr: Z) *)
(*   (st_0: RData) *)
(*   (st_29: RData) : option (Z * RData) := *)
(*   rely (v_call33.(pbase) = "granules"); *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call15.(pbase) = "slot_rtt"); *)
(*   rely (v_call34.(pbase) = "slot_rtt2"); *)
(*   when v_call64, st_30 == ((s2tte_create_assigned_empty_spec v_call60 (v_ulevel + ((- 1))) st_29)); *)
(*   when st_32 == ((__granule_refcount_dec_spec v_call33 512 st_30)); *)
(*   when v_13, st_33 == ((load_RData 8 (ptr_offset v_wi 8) st_32)); *)
(*   when st_34 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_33)); *)
(*   when v_call87, st_35 == ((s2tte_is_valid_spec v_call64 (v_ulevel + ((- 1))) st_34)); *)
(*   if v_call87 *)
(*   then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call64 v_call33 st_0 st_35) *)
(*   else ( *)
(*       when v_call90, st_36 == ((s2tte_is_valid_ns_spec v_call64 (v_ulevel + ((- 1))) st_35)); *)
(*       if v_call90 *)
(*       then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call64 v_call33 st_0 st_36) *)
(*       else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call64 v_call33 st_0 st_36)). *)

(* Definition smc_rtt_fold_8_low *)
(*   (v_call34: Ptr) *)
(*   (v_ulevel: Z) *)
(*   (v_call60: Z) *)
(*   (v_call33: Ptr) *)
(*   (v_wi: Ptr) *)
(*   (v_call15: Ptr) *)
(*   (v_call34: Ptr) *)
(*   (v_s2_ctx: Ptr) *)
(*   (v_map_addr: Z) *)
(*   (st_0: RData) *)
(*   (st_29: RData) : option (Z * RData) := *)
(*   rely (v_call34.(pbase) = "slot_rtt2"); *)
(*   rely (v_call33.(pbase) = "granules"); *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call15.(pbase) = "slot_rtt"); *)
(*   rely (v_call34.(pbase) = "slot_rtt2"); *)
(*   when v_call66, st_30 == ((table_maps_valid_block_spec v_call34 v_ulevel st_29)); *)
(*   if v_call66 *)
(*   then ( *)
(*       when v_call69, st_31 == ((s2tte_create_valid_spec v_call60 (v_ulevel + ((- 1))) st_30)); *)
(*       when st_33 == ((__granule_refcount_dec_spec v_call33 512 st_31)); *)
(*       when v_13, st_34 == ((load_RData 8 (ptr_offset v_wi 8) st_33)); *)
(*       when st_35 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_34)); *)
(*       when v_call87, st_36 == ((s2tte_is_valid_spec v_call69 (v_ulevel + ((- 1))) st_35)); *)
(*       if v_call87 *)
(*       then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call69 v_call33 st_0 st_36) *)
(*       else ( *)
(*           when v_call90, st_37 == ((s2tte_is_valid_ns_spec v_call69 (v_ulevel + ((- 1))) st_36)); *)
(*           if v_call90 *)
(*           then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call69 v_call33 st_0 st_37) *)
(*           else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call69 v_call33 st_0 st_37))) *)
(*   else ( *)
(*       when v_call71, st_31 == ((table_maps_valid_ns_block_spec v_call34 v_ulevel st_30)); *)
(*       if v_call71 *)
(*       then ( *)
(*           when v_call74, st_32 == ((s2tte_create_valid_ns_spec v_call60 (v_ulevel + ((- 1))) st_31)); *)
(*           when st_34 == ((__granule_refcount_dec_spec v_call33 512 st_32)); *)
(*           when v_13, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34)); *)
(*           when st_36 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_35)); *)
(*           when v_call87, st_37 == ((s2tte_is_valid_spec v_call74 (v_ulevel + ((- 1))) st_36)); *)
(*           if v_call87 *)
(*           then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call74 v_call33 st_0 st_37) *)
(*           else ( *)
(*               when v_call90, st_38 == ((s2tte_is_valid_ns_spec v_call74 (v_ulevel + ((- 1))) st_37)); *)
(*               if v_call90 *)
(*               then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call74 v_call33 st_0 st_38) *)
(*               else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call74 v_call33 st_0 st_38))) *)
(*       else ( *)
(*           when v_call77, st_32 == ((pack_return_code_spec 4 v_ulevel st_31)); *)
(*           when v_call78, st_39 == smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_32; *)
(*           (Some (v_call77, st_39)))). *)

(* Definition smc_rtt_fold_spec_low (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) := *)
(*   when st_0 == ((new_frame "smc_rtt_fold" st)); *)
(*   when v_wi, st_1 == ((alloc_stack "smc_rtt_fold" 24 8 st_0)); *)
(*   when v_s2_ctx, st_2 == ((alloc_stack "smc_rtt_fold" 32 8 st_1)); *)
(*   when v_ripas, st_3 == ((alloc_stack "smc_rtt_fold" 4 4 st_2)); *)
(*   when v_call, st_4 == ((find_lock_granule_spec v_rd_addr 2 st_3)); *)
(*   if (ptr_eqb v_call (mkPtr "null" 0)) *)
(*   then ( *)
(*     when st_6 == ((free_stack "smc_rtt_fold" st_0 st_4)); *)
(*     (Some (1, st_6))) *)
(*   else ( *)
(*     when v_call1_0, st_5 == ((granule_map_spec v_call 2 st_4)); *)
(*     when v_call2, st_6 == ((validate_rtt_structure_cmds_spec v_map_addr v_ulevel v_call1_0 st_5)); *)
(*     if v_call2 *)
(*     then ( *)
(*       when v_4, st_16 == smc_rtt_fold_1 v_call1_0 v_s2_ctx v_call v_map_addr v_ulevel v_wi st_6; *)
(*       if ((v_4 - ((v_ulevel + ((- 1))))) =? (0)) *)
(*       then ( *)
(*         when v_5_tmp, st_17 == ((load_RData 8 (ptr_offset v_wi 0) st_16)); *)
(*         rely (v_5_tmp < STACK_VIRT /\ v_5_tmp >= GRANULES_BASE); *)
(*         when v_call15, st_18 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_17)); *)
(*         when v_7, st_19 == ((load_RData 8 (ptr_offset v_wi 8) st_18)); *)
(*         when v_call16, st_20 == ((__tte_read_spec (ptr_offset v_call15 (8 * (v_7))) st_19)); *)
(*         when v_call18, st_21 == ((s2tte_is_table_spec v_call16 (v_ulevel + ((- 1))) st_20)); *)
(*         if v_call18 *)
(*         then ( *)
(*           when v_call25, st_22 == ((s2tte_pa_table_spec v_call16 (v_ulevel + ((- 1))) st_21)); *)
(*           if ((v_call25 - (v_rtt_addr)) =? (0)) *)
(*           then ( *)
(*             when v_call33, st_24 == ((find_lock_granule_spec v_rtt_addr 6 st_22)); *)
(*             when v_call34, st_25 == ((granule_map_spec v_call33 23 st_24)); *)
(*             when v_9, st_26 == ((load_RData 8 (ptr_offset v_call33 8) st_25)); *)
(*             if (v_9 =? (0)) *)
(*             then (smc_rtt_fold_6 v_call34 v_wi v_call15 v_ulevel v_s2_ctx v_map_addr v_call33 v_ripas st_0 st_26) *)
(*             else ( *)
(*               if (v_9 =? (512)) *)
(*               then ( *)
(*                 if (v_ulevel <? (3)) *)
(*                 then ( *)
(*                   when st_27 == ((buffer_unmap_spec v_call34 st_26)); *)
(*                   when st_28 == ((granule_unlock_spec v_call33 st_27)); *)
(*                   when st_29 == ((buffer_unmap_spec v_call15 st_28)); *)
(*                   when v_15_tmp, st_30 == ((load_RData 8 (ptr_offset v_wi 0) st_29)); *)
(*                   rely (v_15_tmp < STACK_VIRT /\ v_15_tmp >= GRANULES_BASE); *)
(*                   when st_31 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_30)); *)
(*                   when st_33 == ((free_stack "smc_rtt_fold" st_0 st_31)); *)
(*                   (Some (5, st_33))) *)
(*                 else ( *)
(*                   when v_call59, st_27 == ((__tte_read_spec v_call34 st_26)); *)
(*                   when v_call60, st_28 == ((s2tte_pa_spec v_call59 v_ulevel st_27)); *)
(*                   when v_call61, st_29 == ((table_maps_assigned_block_spec v_call34 v_ulevel st_28)); *)
(*                   if v_call61 *)
(*                   then (smc_rtt_fold_7 v_ulevel v_call60 v_call33 v_wi v_call15 v_call34 v_s2_ctx v_map_addr st_0 st_29) *)
(*                   else (smc_rtt_fold_8 v_call34 v_ulevel v_call60 v_call33 v_wi v_call15 v_call34 v_s2_ctx v_map_addr st_0 st_29))) *)
(*               else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_26))) *)
(*           else ( *)
(*             when v_call31, st_23 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_22)); *)
(*             when st_24 == ((buffer_unmap_spec v_call15 st_23)); *)
(*             when v_15_tmp, st_25 == ((load_RData 8 (ptr_offset v_wi 0) st_24)); *)
(*             rely (v_15_tmp < STACK_VIRT /\ v_15_tmp >= GRANULES_BASE); *)
(*             when st_26 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_25)); *)
(*             when st_28 == ((free_stack "smc_rtt_fold" st_0 st_26)); *)
(*             (Some (v_call31, st_28)))) *)
(*         else ( *)
(*           when v_call22, st_22 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_21)); *)
(*           when st_23 == ((buffer_unmap_spec v_call15 st_22)); *)
(*           when v_15_tmp, st_24 == ((load_RData 8 (ptr_offset v_wi 0) st_23)); *)
(*           rely (v_15_tmp < STACK_VIRT /\ v_15_tmp >= GRANULES_BASE); *)
(*           when st_25 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_24)); *)
(*           when st_27 == ((free_stack "smc_rtt_fold" st_0 st_25)); *)
(*           (Some (v_call22, st_27)))) *)
(*       else ( *)
(*         when v_call13, st_17 == ((pack_return_code_spec 4 v_4 st_16)); *)
(*         when v_15_tmp, st_18 == ((load_RData 8 (ptr_offset v_wi 0) st_17)); *)
(*         rely (v_15_tmp < STACK_VIRT /\ v_15_tmp >= GRANULES_BASE); *)
(*         when st_19 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_18)); *)
(*         when st_21 == ((free_stack "smc_rtt_fold" st_0 st_19)); *)
(*         (Some (v_call13, st_21)))) *)
(*     else ( *)
(*       when st_7 == ((buffer_unmap_spec v_call1_0 st_6)); *)
(*       when st_8 == ((granule_unlock_spec v_call st_7)); *)
(*       when st_10 == ((free_stack "smc_rtt_fold" st_0 st_8)); *)
(*       (Some (1, st_10)))). *)

Definition smc_rtt_set_ripas_1_low
  (v_s2_ctx: Ptr)
  (v_map_addr: Z)
  (v_call9: Ptr)
  (v_call30: Z)
  (v_call47: Ptr)
  (v_wi: Ptr)
  (v_call25: Ptr)
  (v_g_rec: Ptr)
  (v_g_rd: Ptr)
  (st_0: RData)
  (st_35: RData) : option (Z * RData) :=
  rely (v_s2_ctx.(pbase) = "smc_rtt_set_ripas_stack");
  rely (v_call9.(pbase) = "slot_rec");
  rely (v_call9.(poffset) = 0);
  rely (v_call47.(pbase) = "slot_rtt");
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  rely (v_call25.(pbase) = "slot_rd");
  rely (v_g_rec.(pbase) = "stack_g1");
  rely (v_g_rd.(pbase) = "stack_g0");
  when st_36 == ((invalidate_page_spec v_s2_ctx v_map_addr st_35));
  when v_21, st_39 == ((load_RData 8 (ptr_offset v_call9 864) st_36));
  when st_40 == ((store_RData 8 (ptr_offset v_call9 864) (v_21 + (v_call30)) st_39));
  when st_42 == ((buffer_unmap_spec v_call47 st_40));
  when v_22_tmp, st_44 == ((load_RData 8 (ptr_offset v_wi 0) st_42));
  rely (v_22_tmp < STACK_VIRT /\ v_22_tmp >= GRANULES_BASE);
  when st_45 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_44));
  when st_48 == ((buffer_unmap_spec v_call25 st_45));
  when st_52 == ((buffer_unmap_spec v_call9 st_48));
  when v_23_tmp, st_54 == ((load_RData 8 v_g_rec st_52));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_55 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_54));
  when v_24_tmp, st_56 == ((load_RData 8 v_g_rd st_55));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_57 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_56));
  when st_60 == ((free_stack "smc_rtt_set_ripas" st_0 st_57));
  (Some (0, st_60)).

Definition smc_rtt_set_ripas_2_low
  (v_s2_ctx: Ptr)
  (v_map_addr: Z)
  (v_call9: Ptr)
  (v_call30: Z)
  (v_call47: Ptr)
  (v_wi: Ptr)
  (v_call25: Ptr)
  (v_g_rec: Ptr)
  (v_g_rd: Ptr)
  (st_0: RData)
  (st_35: RData) : option (Z * RData) :=
  rely (v_s2_ctx.(pbase) = "stack_s2_ctx");
  rely (v_call9.(pbase) = "slot_rec");
  rely (v_call9.(poffset) = 0);
  rely (v_call47.(pbase) = "slot_rtt");
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  rely (v_call25.(pbase) = "slot_rd");
  rely (v_g_rec.(pbase) = "stack_g1");
  rely (v_g_rd.(pbase) = "stack_g0");
  when st_36 == ((invalidate_block_spec v_s2_ctx v_map_addr st_35));
  when v_21, st_39 == ((load_RData 8 (ptr_offset v_call9 864) st_36));
  when st_40 == ((store_RData 8 (ptr_offset v_call9 864) (v_21 + (v_call30)) st_39));
  when st_42 == ((buffer_unmap_spec v_call47 st_40));
  when v_22_tmp, st_44 == ((load_RData 8 (ptr_offset v_wi 0) st_42));
  rely (v_22_tmp < STACK_VIRT /\ v_22_tmp >= GRANULES_BASE);
  when st_45 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_44));
  when st_48 == ((buffer_unmap_spec v_call25 st_45));
  when st_52 == ((buffer_unmap_spec v_call9 st_48));
  when v_23_tmp, st_54 == ((load_RData 8 v_g_rec st_52));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_55 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_54));
  when v_24_tmp, st_56 == ((load_RData 8 v_g_rd st_55));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_57 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_56));
  when st_60 == ((free_stack "smc_rtt_set_ripas" st_0 st_57));
  (Some (0, st_60)).

Definition smc_rtt_set_ripas_3_low
  (v_call9: Ptr)
  (v_call30: Z)
  (v_call47: Ptr)
  (v_wi: Ptr)
  (v_call25: Ptr)
  (v_g_rec: Ptr)
  (v_g_rd: Ptr)
  (st_0: RData)
  (st_35: RData) : option (Z * RData) :=
  rely (v_call9.(pbase) = "slot_rec");
  rely (v_call9.(poffset) = 0);
  rely (v_call47.(pbase) = "slot_rtt");
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  rely (v_call25.(pbase) = "slot_rd");
  rely (v_g_rec.(pbase) = "stack_g1");
  rely (v_g_rd.(pbase) = "stack_g0");
  when v_21, st_37 == ((load_RData 8 (ptr_offset v_call9 864) st_35));
  when st_38 == ((store_RData 8 (ptr_offset v_call9 864) (v_21 + (v_call30)) st_37));
  when st_40 == ((buffer_unmap_spec v_call47 st_38));
  when v_22_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_40));
  rely (v_22_tmp < STACK_VIRT /\ v_22_tmp >= GRANULES_BASE);
  when st_43 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_42));
  when st_46 == ((buffer_unmap_spec v_call25 st_43));
  when st_50 == ((buffer_unmap_spec v_call9 st_46));
  when v_23_tmp, st_52 == ((load_RData 8 v_g_rec st_50));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_53 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_52));
  when v_24_tmp, st_54 == ((load_RData 8 v_g_rd st_53));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_55 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_54));
  when st_58 == ((free_stack "smc_rtt_set_ripas" st_0 st_55));
  (Some (0, st_58)).

Definition smc_rtt_set_ripas_4_low
  (v_ulevel: Z)
  (v_call47: Ptr)
  (v_wi: Ptr)
  (v_call25: Ptr)
  (v_call9: Ptr)
  (v_g_rec: Ptr)
  (v_g_rd: Ptr)
  (st_0: RData)
  (st_32: RData) : option (Z * RData) :=
  rely (v_call47.(pbase) = "slot_rtt");
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  rely (v_call25.(pbase) = "slot_rd");
  rely (v_call9.(pbase) = "slot_rec");
  rely (v_g_rec.(pbase) = "stack_g1");
  rely (v_g_rd.(pbase) = "stack_g0");
  when v_call53, st_33 == ((pack_return_code_spec 4 v_ulevel st_32));
  when st_35 == ((buffer_unmap_spec v_call47 st_33));
  when v_22_tmp, st_37 == ((load_RData 8 (ptr_offset v_wi 0) st_35));
  rely (v_22_tmp < STACK_VIRT /\ v_22_tmp >= GRANULES_BASE);
  when st_38 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_37));
  when st_41 == ((buffer_unmap_spec v_call25 st_38));
  when st_45 == ((buffer_unmap_spec v_call9 st_41));
  when v_23_tmp, st_47 == ((load_RData 8 v_g_rec st_45));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_48 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_47));
  when v_24_tmp, st_49 == ((load_RData 8 v_g_rd st_48));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_50 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_49));
  when st_53 == ((free_stack "smc_rtt_set_ripas" st_0 st_50));
  (Some (v_call53, st_53)).

Definition smc_rtt_set_ripas_5_low
  (v_15: Z)
  (v_wi: Ptr)
  (v_call25: Ptr)
  (v_call9: Ptr)
  (v_g_rec: Ptr)
  (v_g_rd: Ptr)
  (st_0: RData)
  (st_25: RData) : option (Z * RData) :=
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  rely (v_call25.(pbase) = "slot_rd");
  rely (v_call9.(pbase) = "slot_rec");
  rely (v_g_rec.(pbase) = "stack_g1");
  rely (v_g_rd.(pbase) = "stack_g0");
  when v_call45, st_26 == ((pack_return_code_spec 4 v_15 st_25));
  when v_22_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_26));
  rely (v_22_tmp < STACK_VIRT /\ v_22_tmp >= GRANULES_BASE);
  when st_29 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_28));
  when st_32 == ((buffer_unmap_spec v_call25 st_29));
  when st_36 == ((buffer_unmap_spec v_call9 st_32));
  when v_23_tmp, st_38 == ((load_RData 8 v_g_rec st_36));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_39 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_38));
  when v_24_tmp, st_40 == ((load_RData 8 v_g_rd st_39));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_41 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_40));
  when st_44 == ((free_stack "smc_rtt_set_ripas" st_0 st_41));
  (Some (v_call45, st_44)).

Definition smc_rtt_set_ripas_6_low
  (v_call25: Ptr)
  (v_call9: Ptr)
  (v_g_rec: Ptr)
  (v_g_rd: Ptr)
  (st_0: RData)
  (st_18: RData) : option (Z * RData) :=
  rely (v_call25.(pbase) = "slot_rd");
  rely (v_call9.(pbase) = "slot_rec");
  rely (v_g_rec.(pbase) = "stack_g1");
  rely (v_g_rd.(pbase) = "stack_g0");
  when st_21 == ((buffer_unmap_spec v_call25 st_18));
  when st_25 == ((buffer_unmap_spec v_call9 st_21));
  when v_23_tmp, st_27 == ((load_RData 8 v_g_rec st_25));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_28 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_27));
  when v_24_tmp, st_29 == ((load_RData 8 v_g_rd st_28));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_30 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_29));
  when st_33 == ((free_stack "smc_rtt_set_ripas" st_0 st_30));
  (Some (1, st_33)).

Definition smc_rtt_set_ripas_7_low
  (v_call9: Ptr)
  (v_g_rec: Ptr)
  (v_g_rd: Ptr)
  (st_0: RData)
  (st_13: RData) : option (Z * RData) :=
  rely (v_call9.(pbase) = "slot_rec");
  rely (v_g_rec.(pbase) = "stack_g1");
  rely (v_g_rd.(pbase) = "stack_g0");
  when st_16 == ((buffer_unmap_spec v_call9 st_13));
  when v_23_tmp, st_18 == ((load_RData 8 v_g_rec st_16));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_19 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_18));
  when v_24_tmp, st_20 == ((load_RData 8 v_g_rd st_19));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_21 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_20));
  when st_24 == ((free_stack "smc_rtt_set_ripas" st_0 st_21));
  (Some (1, st_24)).

Definition smc_rtt_set_ripas_8_low
  (v_g_rec: Ptr)
  (v_g_rd: Ptr)
  (st_0: RData)
  (st_8: RData) : option (Z * RData) :=
  rely (v_g_rec.(pbase) = "stack_g1");
  rely (v_g_rd.(pbase) = "stack_g0");
  when v_23_tmp, st_10 == ((load_RData 8 v_g_rec st_8));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_11 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_10));
  when v_24_tmp, st_12 == ((load_RData 8 v_g_rd st_11));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_13 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_12));
  when st_16 == ((free_stack "smc_rtt_set_ripas" st_0 st_13));
  (Some (5, st_16)).

Definition smc_rtt_set_ripas_9_low
  (v_ulevel: Z)
  (v_call9: Ptr)
  (v_map_addr: Z)
  (v_call25: Ptr)
  (v_g_rec: Ptr)
  (v_g_rd: Ptr)
  (v_wi: Ptr)
  (v_s2_ctx: Ptr)
  (v_s2tte: Ptr)
  (v_uripas: Z)
  (st_0: RData)
  (st_16: RData) : option (Z * RData) :=
  rely (v_call9.(pbase) = "slot_rec");
  rely (v_call9.(poffset) = 0);
  rely (v_call25.(pbase) = "slot_rd");
  rely (v_call25.(poffset) = 0);
  rely (v_g_rec.(pbase) = "stack_g1");
  rely (v_g_rd.(pbase) = "stack_g0");
  rely (v_wi.(pbase) = "stack_wi");
  rely (v_wi.(poffset) = 0);
  rely (v_s2_ctx.(pbase) = "stack_s2_ctx");
  rely (v_s2_ctx.(poffset) = 0);
  rely (v_s2tte.(pbase) = "stack_s2tte");
  when v_call30, st_17 == ((s2tte_map_size_spec v_ulevel st_16));
  when v_11, st_18 == ((load_RData 8 (ptr_offset v_call9 856) st_17));
  if (((v_call30 + (v_map_addr)) - (v_11)) >? (0))
  then (
      when st_21 == ((buffer_unmap_spec v_call25 st_18));
      when st_25 == ((buffer_unmap_spec v_call9 st_21));
      when v_23_tmp, st_27 == ((load_RData 8 v_g_rec st_25));
      rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
      when st_28 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_27));
      when v_24_tmp, st_29 == ((load_RData 8 v_g_rd st_28));
      rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
      when st_30 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_29));
      when st_33 == ((free_stack "smc_rtt_set_ripas" st_0 st_30));
      (Some (1, st_33)))
  else (
      when v_13_tmp, st_19 == ((load_RData 8 (ptr_offset v_call25 32) st_18));
      when v_call37, st_20 == ((realm_rtt_starting_level_spec v_call25 st_19));
      when v_call38, st_21 == ((realm_ipa_bits_spec v_call25 st_20));
      when st_22 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call25 16) 32 false st_21));
      rely (v_13_tmp < STACK_VIRT /\ v_13_tmp >= GRANULES_BASE);
      when st_23 == ((granule_lock_spec (int_to_ptr v_13_tmp) 6 st_22));
      when st_24 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_13_tmp) v_call37 v_call38 v_map_addr v_ulevel v_wi st_23));
      when v_15, st_25 == ((load_RData 8 (ptr_offset v_wi 16) st_24));
      if ((v_15 - (v_ulevel)) =? (0))
      then (
          when v_16_tmp, st_26 == ((load_RData 8 (ptr_offset v_wi 0) st_25));
          rely (v_16_tmp < STACK_VIRT /\ v_16_tmp >= GRANULES_BASE);
          when v_call47, st_27 == ((granule_map_spec (int_to_ptr v_16_tmp) 22 st_26));
          when v_18, st_28 == ((load_RData 8 (ptr_offset v_wi 8) st_27));
          when v_call48, st_29 == ((__tte_read_spec (ptr_offset v_call47 (8 * (v_18))) st_28));
          when st_30 == ((store_RData 8 v_s2tte v_call48 st_29));
          when v_call49, st_31 == ((s2tte_is_valid_spec v_call48 v_ulevel st_30));
          when v_call50, st_32 == ((update_ripas_spec v_s2tte v_ulevel v_uripas st_31));
          if v_call50
          then (
              when v_19, st_33 == ((load_RData 8 (ptr_offset v_wi 8) st_32));
              when v_20, st_34 == ((load_RData 8 v_s2tte st_33));
              when st_35 == ((__tte_write_spec (ptr_offset v_call47 (8 * (v_19))) v_20 st_34));
              if ((v_uripas =? (0)) && (v_call49))
              then (
                  if (v_ulevel =? (3))
                  then (smc_rtt_set_ripas_1 v_s2_ctx v_map_addr v_call9 v_call30 v_call47 v_wi v_call25 v_g_rec v_g_rd st_0 st_35)
                  else (smc_rtt_set_ripas_2 v_s2_ctx v_map_addr v_call9 v_call30 v_call47 v_wi v_call25 v_g_rec v_g_rd st_0 st_35))
              else (smc_rtt_set_ripas_3 v_call9 v_call30 v_call47 v_wi v_call25 v_g_rec v_g_rd st_0 st_35))
          else (smc_rtt_set_ripas_4 v_ulevel v_call47 v_wi v_call25 v_call9 v_g_rec v_g_rd st_0 st_32))
      else (smc_rtt_set_ripas_5 v_15 v_wi v_call25 v_call9 v_g_rec v_g_rd st_0 st_25)).

Definition smc_rtt_set_ripas_spec_low (v_rd_addr: Z) (v_rec_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (v_uripas: Z) (st: RData) : (option (Z * RData)) :=
  when st_0 == ((new_frame "smc_rtt_set_ripas" st));
  (* when v_g_rd, st_1 == ((alloc_stack "smc_rtt_set_ripas" 8 8 st_0)); *)
  (* when v_g_rec, st_2 == ((alloc_stack "smc_rtt_set_ripas" 8 8 st_1)); *)
  (* when v_wi, st_3 == ((alloc_stack "smc_rtt_set_ripas" 24 8 st_2)); *)
  (* when v_s2tte, st_4 == ((alloc_stack "smc_rtt_set_ripas" 8 8 st_3)); *)
  (* when v_s2_ctx, st_5 == ((alloc_stack "smc_rtt_set_ripas" 32 8 st_4)); *)
  let v_g_rd := (mkPtr "stack_g0" 0) in
  let v_g_rec := (mkPtr "stack_g1" 0) in
  let v_wi := (mkPtr "stack_wi" 0) in
  let v_s2tte := (mkPtr "stack_s2tte" 0) in
  let v_s2_ctx := (mkPtr "stack_s2_ctx" 0) in
  let st_5 := st_0 in
  if (v_uripas >? (1))
  then (
    when st_7 == ((free_stack "smc_rtt_set_ripas" st_0 st_5));
    (Some (1, st_7)))
  else (
    when v_call, st_6 == ((find_lock_two_granules_spec v_rd_addr 2 v_g_rd v_rec_addr 3 v_g_rec st_5));
    if v_call
    then (
      when v_0_tmp, st_7 == ((load_RData 8 v_g_rec st_6));
      when v_call4, st_8 == ((granule_refcount_read_acquire_spec (int_to_ptr v_0_tmp) st_7));
      if (v_call4 =? (0))
      then (
        when v_1_tmp, st_9 == ((load_RData 8 v_g_rec st_8));
        when v_call9, st_10 == ((granule_map_spec (int_to_ptr v_1_tmp) 3 st_9));
        when v_2_tmp, st_11 == ((load_RData 8 v_g_rd st_10));
        when v_4_tmp, st_12 == ((load_RData 8 (ptr_offset v_call9 904) st_11));
        rely (v_2_tmp < STACK_VIRT /\ v_2_tmp >= GRANULES_BASE);
        rely (v_4_tmp < STACK_VIRT /\ v_4_tmp >= GRANULES_BASE);
        if (ptr_eqb (int_to_ptr v_2_tmp) (int_to_ptr v_4_tmp))
        then (
          when v_6, st_13 == ((load_RData 4 (ptr_offset v_call9 872) st_12));
          if ((v_6 - (v_uripas)) =? (0))
          then (
            when v_8, st_14 == ((load_RData 8 (ptr_offset v_call9 864) st_13));
            if ((v_8 - (v_map_addr)) =? (0))
            then (
              when v_call25, st_15 == ((granule_map_spec (int_to_ptr v_2_tmp) 2 st_14));
              when v_call26, st_16 == ((validate_rtt_entry_cmds_spec v_map_addr v_ulevel v_call25 st_15));
              if v_call26
              then (smc_rtt_set_ripas_9 v_ulevel v_call9 v_map_addr v_call25 v_g_rec v_g_rd v_wi v_s2_ctx v_s2tte v_uripas st_0 st_16)
              else (
                when st_18 == ((buffer_unmap_spec v_call25 st_16));
                when st_22 == ((buffer_unmap_spec v_call9 st_18));
                when v_23_tmp, st_24 == ((load_RData 8 v_g_rec st_22));
                rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
                when st_25 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_24));
                when v_24_tmp, st_26 == ((load_RData 8 v_g_rd st_25));
                rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
                when st_27 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_26));
                when st_30 == ((free_stack "smc_rtt_set_ripas" st_0 st_27));
                (Some (1, st_30))))
            else (
              when st_18 == ((buffer_unmap_spec v_call9 st_14));
              when v_23_tmp, st_20 == ((load_RData 8 v_g_rec st_18));
              rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
              when st_21 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_20));
              when v_24_tmp, st_22 == ((load_RData 8 v_g_rd st_21));
              rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
              when st_23 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_22));
              when st_26 == ((free_stack "smc_rtt_set_ripas" st_0 st_23));
              (Some (1, st_26))))
          else (
            when st_16 == ((buffer_unmap_spec v_call9 st_13));
            when v_23_tmp, st_18 == ((load_RData 8 v_g_rec st_16));
            rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
            when st_19 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_18));
            when v_24_tmp, st_20 == ((load_RData 8 v_g_rd st_19));
            rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
            when st_21 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_20));
            when st_24 == ((free_stack "smc_rtt_set_ripas" st_0 st_21));
            (Some (1, st_24))))
        else (
          when st_14 == ((buffer_unmap_spec v_call9 st_12));
          when v_23_tmp, st_16 == ((load_RData 8 v_g_rec st_14));
          rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
          when st_17 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_16));
          when v_24_tmp, st_18 == ((load_RData 8 v_g_rd st_17));
          rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
          when st_19 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_18));
          when st_22 == ((free_stack "smc_rtt_set_ripas" st_0 st_19));
          (Some (3, st_22))))
      else (
        when v_23_tmp, st_10 == ((load_RData 8 v_g_rec st_8));
        rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
        when st_11 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_10));
        when v_24_tmp, st_12 == ((load_RData 8 v_g_rd st_11));
        rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
        when st_13 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_12));
        when st_16 == ((free_stack "smc_rtt_set_ripas" st_0 st_13));
        (Some (5, st_16))))
    else (
      when st_9 == ((free_stack "smc_rtt_set_ripas" st_0 st_6));
      (Some (1, st_9)))).

(* Definition smc_rtt_destroy_1_low *)
(*   (v_wi: Ptr) *)
(*   (v_call16: Ptr) *)
(*   (v_map_addr: Z) *)
(*   (v_s2_ctx: Ptr) *)
(*   (v_call36: Ptr) *)
(*   (v_call31: Ptr) *)
(*   (st_0: RData) *)
(*   (st_24: RData) : option (Z * RData) := *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call16.(pbase) = "slot_rtt"); *)
(*   rely (v_s2_ctx.(pbase) = "stack_s2_ctx"); *)
(*   rely (v_s2_ctx.(poffset) = 0); *)
(*   rely (v_call36.(pbase) = "slot_rtt2"); *)
(*   rely (v_call31.(pbase) = "granules"); *)
(*   when v_9_tmp, st_26 == ((load_RData 8 (ptr_offset v_wi 0) st_24)); *)
(*   rely (v_9_tmp < STACK_VIRT /\ v_9_tmp >= GRANULES_BASE); *)
(*   when st_27 == ((__granule_put_spec (int_to_ptr v_9_tmp) st_26)); *)
(*   when v_10, st_28 == ((load_RData 8 (ptr_offset v_wi 8) st_27)); *)
(*   when st_29 == ((__tte_write_spec (ptr_offset v_call16 (8 * (v_10))) 0 st_28)); *)
(*   when st_30 == ((invalidate_block_spec v_s2_ctx v_map_addr st_29)); *)
(*   when v_11, st_31 == ((load_RData 8 (ptr_offset v_wi 8) st_30)); *)
(*   when st_32 == (__tte_write_spec (ptr_offset v_call16 (8 * (v_11))) 0 st_31); *)
(*   when st_33 == ((granule_memzero_mapped_spec v_call36 st_32)); *)
(*   when st_34 == ((granule_set_state_spec v_call31 1 st_33)); *)
(*   when st_35 == ((buffer_unmap_spec v_call36 st_34)); *)
(*   when st_37 == ((granule_unlock_spec v_call31 st_35)); *)
(*   when st_40 == ((buffer_unmap_spec v_call16 st_37)); *)
(*   when v_12_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_40)); *)
(*   rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE); *)
(*   when st_43 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_42)); *)
(*   when st_46 == ((free_stack "smc_rtt_destroy" st_0 st_43)); *)
(*   (Some (0, st_46)). *)

(* Definition smc_rtt_destroy_2_low *)
(*   (v_wi: Ptr) *)
(*   (v_call16: Ptr) *)
(*   (v_map_addr: Z) *)
(*   (v_s2_ctx: Ptr) *)
(*   (v_call36: Ptr) *)
(*   (v_call31: Ptr) *)
(*   (st_0: RData) *)
(*   (st_24: RData) : option (Z * RData) := *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call16.(pbase) = "slot_rtt"); *)
(*   rely (v_s2_ctx.(pbase) = "stack_s2_ctx"); *)
(*   rely (v_s2_ctx.(poffset) = 0); *)
(*   rely (v_call36.(pbase) = "slot_rtt2"); *)
(*   rely (v_call31.(pbase) = "granules"); *)
(*   when v_9_tmp, st_26 == ((load_RData 8 (ptr_offset v_wi 0) st_24)); *)
(*   rely (v_9_tmp < STACK_VIRT /\ v_9_tmp >= GRANULES_BASE); *)
(*   when st_27 == ((__granule_put_spec (int_to_ptr v_9_tmp) st_26)); *)
(*   when v_10, st_28 == ((load_RData 8 (ptr_offset v_wi 8) st_27)); *)
(*   when st_29 == ((__tte_write_spec (ptr_offset v_call16 (8 * (v_10))) 0 st_28)); *)
(*   when st_30 == ((invalidate_block_spec v_s2_ctx v_map_addr st_29)); *)
(*   when v_11, st_31 == ((load_RData 8 (ptr_offset v_wi 8) st_30)); *)
(*   when st_32 == (__tte_write_spec (ptr_offset v_call16 (8 * (v_11))) 8 st_31); *)
(*   when st_33 == ((granule_memzero_mapped_spec v_call36 st_32)); *)
(*   when st_34 == ((granule_set_state_spec v_call31 1 st_33)); *)
(*   when st_35 == ((buffer_unmap_spec v_call36 st_34)); *)
(*   when st_37 == ((granule_unlock_spec v_call31 st_35)); *)
(*   when st_40 == ((buffer_unmap_spec v_call16 st_37)); *)
(*   when v_12_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_40)); *)
(*   rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE); *)
(*   when st_43 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_42)); *)
(*   when st_46 == ((free_stack "smc_rtt_destroy" st_0 st_43)); *)
(*   (Some (0, st_46)). *)

(* Definition smc_rtt_destroy_3_low *)
(*   (v_call17: Z) *)
(*   (v_ulevel: Z) *)
(*   (v_rtt_addr: Z) *)
(*   (v_call9: bool) *)
(*   (v_wi: Ptr) *)
(*   (v_call16: Ptr) *)
(*   (v_map_addr: Z) *)
(*   (v_s2_ctx: Ptr) *)
(*   (st_0: RData) *)
(*   (st_20: RData) : option (Z * RData) := *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call16.(pbase) = "slot_rtt"); *)
(*   when v_call26, st_21 == ((s2tte_pa_table_spec v_call17 (v_ulevel + ((- 1))) st_20)); *)
(*   if ((v_call26 - (v_rtt_addr)) =? (0)) *)
(*   then ( *)
(*     when v_call31, st_22 == ((find_lock_granule_spec v_rtt_addr 6 st_21)); *)
(*     when v_8, st_23 == ((load_RData 8 (ptr_offset v_call31 8) st_22)); *)
(*     if (v_8 =? (0)) *)
(*     then ( *)
(*       when v_call36, st_24 == ((granule_map_spec v_call31 23 st_23)); *)
(*       if v_call9 *)
(*       then (smc_rtt_destroy_2 v_wi v_call16 v_map_addr v_s2_ctx v_call36 v_call31 st_0 st_24) *)
(*       else (smc_rtt_destroy_1 v_wi v_call16 v_map_addr v_s2_ctx v_call36 v_call31 st_0 st_24)) *)
(*     else ( *)
(*       when st_25 == ((granule_unlock_spec v_call31 st_23)); *)
(*       when st_28 == ((buffer_unmap_spec v_call16 st_25)); *)
(*       when v_12_tmp, st_30 == ((load_RData 8 (ptr_offset v_wi 0) st_28)); *)
(*       rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE); *)
(*       when st_31 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_30)); *)
(*       when st_34 == ((free_stack "smc_rtt_destroy" st_0 st_31)); *)
(*       (Some (5, st_34)))) *)
(*   else ( *)
(*     when st_24 == ((buffer_unmap_spec v_call16 st_21)); *)
(*     when v_12_tmp, st_26 == ((load_RData 8 (ptr_offset v_wi 0) st_24)); *)
(*     rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE); *)
(*     when st_27 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_26)); *)
(*     when st_30 == ((free_stack "smc_rtt_destroy" st_0 st_27)); *)
(*     (Some (1, st_30))). *)

(* Definition smc_rtt_destroy_spec_low (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) := *)
(*   when st_0 == ((new_frame "smc_rtt_destroy" st)); *)
(*   (* when v_wi, st_1 == ((alloc_stack "smc_rtt_destroy" 24 8 st_0)); *) *)
(*   (* when v_s2_ctx, st_2 == ((alloc_stack "smc_rtt_destroy" 32 8 st_1)); *) *)
(*   let v_wi := (mkPtr "stack_wi" 0) in *)
(*   let v_s2_ctx := (mkPtr "stack_s2_ctx" 0) in *)
(*   let st_2 := st_0 in *)
(*   when v_call, st_3 == ((find_lock_granule_spec v_rd_addr 2 st_2)); *)
(*   if (ptr_eqb v_call (mkPtr "null" 0)) *)
(*   then ( *)
(*     when st_5 == ((free_stack "smc_rtt_destroy" st_0 st_3)); *)
(*     (Some (1, st_5))) *)
(*   else ( *)
(*     when v_call1, st_4 == ((granule_map_spec v_call 2 st_3)); *)
(*     when v_call2, st_5 == ((validate_rtt_structure_cmds_spec v_map_addr v_ulevel v_call1 st_4)); *)
(*     if v_call2 *)
(*     then ( *)
(*       when v_2_tmp, st_6 == ((load_RData 8 (ptr_offset v_call1 32) st_5)); *)
(*       when v_call6, st_7 == ((realm_rtt_starting_level_spec v_call1 st_6)); *)
(*       when v_call7, st_8 == ((realm_ipa_bits_spec v_call1 st_7)); *)
(*       when st_9 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1 16) 32 false st_8)); *)
(*       when v_call9, st_10 == ((addr_in_par_spec v_call1 v_map_addr st_9)); *)
(*       when st_11 == ((buffer_unmap_spec v_call1 st_10)); *)
(*       rely (v_2_tmp < STACK_VIRT /\ v_2_tmp >= GRANULES_BASE); *)
(*       when st_12 == ((granule_lock_spec (int_to_ptr v_2_tmp) 6 st_11)); *)
(*       when st_13 == ((granule_unlock_spec v_call st_12)); *)
(*       when st_14 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_2_tmp) v_call6 v_call7 v_map_addr (v_ulevel + ((- 1))) v_wi st_13)); *)
(*       when v_4, st_15 == ((load_RData 8 (ptr_offset v_wi 16) st_14)); *)
(*       if ((v_4 - ((v_ulevel + ((- 1))))) =? (0)) *)
(*       then ( *)
(*         when v_5_tmp, st_16 == ((load_RData 8 (ptr_offset v_wi 0) st_15)); *)
(*         rely (v_5_tmp < STACK_VIRT /\ v_5_tmp >= GRANULES_BASE); *)
(*         when v_call16, st_17 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_16)); *)
(*         when v_7, st_18 == ((load_RData 8 (ptr_offset v_wi 8) st_17)); *)
(*         when v_call17, st_19 == ((__tte_read_spec (ptr_offset v_call16 (8 * (v_7))) st_18)); *)
(*         when v_call19, st_20 == ((s2tte_is_table_spec v_call17 (v_ulevel + ((- 1))) st_19)); *)
(*         if v_call19 *)
(*         then (smc_rtt_destroy_3 v_call17 v_ulevel v_rtt_addr v_call9 v_wi v_call16 v_map_addr v_s2_ctx st_0 st_20) *)
(*         else ( *)
(*           when v_call23, st_21 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_20)); *)
(*           when st_23 == ((buffer_unmap_spec v_call16 st_21)); *)
(*           when v_12_tmp, st_25 == ((load_RData 8 (ptr_offset v_wi 0) st_23)); *)
(*           rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE); *)
(*           when st_26 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_25)); *)
(*           when st_29 == ((free_stack "smc_rtt_destroy" st_0 st_26)); *)
(*           (Some (v_call23, st_29)))) *)
(*       else ( *)
(*         when v_call14, st_16 == ((pack_return_code_spec 4 v_4 st_15)); *)
(*         when v_12_tmp, st_18 == ((load_RData 8 (ptr_offset v_wi 0) st_16)); *)
(*         rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE); *)
(*         when st_19 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_18)); *)
(*         when st_22 == ((free_stack "smc_rtt_destroy" st_0 st_19)); *)
(*         (Some (v_call14, st_22)))) *)
(*     else ( *)
(*       when st_6 == ((buffer_unmap_spec v_call1 st_5)); *)
(*       when st_7 == ((granule_unlock_spec v_call st_6)); *)
(*       when st_10 == ((free_stack "smc_rtt_destroy" st_0 st_7)); *)
(*       (Some (1, st_10)))). *)

(* Definition smc_rtt_create_6_low *)
(*   (v_wi: Ptr) *)
(*   (v_call14: Ptr) *)
(*   (v_call15: Z) *)
(*   (v_call16: Ptr) *)
(*   (v_ulevel: Z) *)
(*   (v_g_tbl: Ptr) *)
(*   (v_rtt_addr: Z) *)
(*   (st_0: RData) *)
(*   (st_26: RData) : *)
(*   option (Z * RData) := *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call16.(pbase) = "slot_delegated"); *)
(*   rely (v_call14.(pbase) = "slot_rtt"); *)
(*   rely (v_g_tbl.(pbase) = "stack_g0"); *)
(*   rely (v_g_tbl.(poffset) = 0); *)
(*   when v_call19, st_27 == ((s2tte_get_ripas_spec v_call15 st_26)); *)
(*   when st_28 == ((s2tt_init_unassigned_spec v_call16 v_call19 st_27)); *)
(*   when v_14_tmp, st_29 == ((load_RData 8 (ptr_offset v_wi 0) st_28)); *)
(*   rely (v_14_tmp < STACK_VIRT /\ v_14_tmp >= GRANULES_BASE); *)
(*   when st_30 == ((__granule_get_spec (int_to_ptr v_14_tmp) st_29)); *)
(*   when v_21_tmp, st_32 == ((load_RData 8 v_g_tbl st_30)); *)
(*   rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE); *)
(*   when st_33 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_32)); *)
(*   when v_call63, st_34 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_33)); *)
(*   when v_22, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34)); *)
(*   when st_36 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_35)); *)
(*   when st_37 == ((buffer_unmap_spec v_call16 st_36)); *)
(*   when st_38 == ((buffer_unmap_spec v_call14 st_37)); *)
(*   when v_23_tmp, st_39 == ((load_RData 8 (ptr_offset v_wi 0) st_38)); *)
(*   rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE); *)
(*   when st_40 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_39)); *)
(*   when v_24_tmp, st_41 == ((load_RData 8 v_g_tbl st_40)); *)
(*   rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE); *)
(*   when st_42 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_41)); *)
(*   when st_43 == ((free_stack "smc_rtt_create" st_0 st_42)); *)
(*   (Some (0, st_43)). *)

(* Definition smc_rtt_create_5_low *)
(*   (v_wi: Ptr) *)
(*   (v_call14: Ptr) *)
(*   (v_call15: Z) *)
(*   (v_call16: Ptr) *)
(*   (v_ulevel: Z) *)
(*   (v_g_tbl: Ptr) *)
(*   (v_rtt_addr: Z) *)
(*   (st_0: RData) *)
(*   (st_27: RData) : *)
(*   option (Z * RData) := *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call16.(pbase) = "slot_delegated"); *)
(*   rely (v_call14.(pbase) = "slot_rtt"); *)
(*   rely (v_g_tbl.(pbase) = "stack_g0"); *)
(*   rely (v_g_tbl.(poffset) = 0); *)
(*   when st_28 == ((s2tt_init_destroyed_spec v_call16 st_27)); *)
(*   when v_15_tmp, st_29 == ((load_RData 8 (ptr_offset v_wi 0) st_28)); *)
(*   rely (v_15_tmp < STACK_VIRT /\ v_15_tmp >= GRANULES_BASE); *)
(*   when st_30 == ((__granule_get_spec (int_to_ptr v_15_tmp) st_29)); *)
(*   when v_21_tmp, st_32 == ((load_RData 8 v_g_tbl st_30)); *)
(*   rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE); *)
(*   when st_33 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_32)); *)
(*   when v_call63, st_34 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_33)); *)
(*   when v_22, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34)); *)
(*   when st_36 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_35)); *)
(*   when st_37 == ((buffer_unmap_spec v_call16 st_36)); *)
(*   when st_38 == ((buffer_unmap_spec v_call14 st_37)); *)
(*   when v_23_tmp, st_39 == ((load_RData 8 (ptr_offset v_wi 0) st_38)); *)
(*   rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE); *)
(*   when st_40 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_39)); *)
(*   when v_24_tmp, st_41 == ((load_RData 8 v_g_tbl st_40)); *)
(*   rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE); *)
(*   when st_42 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_41)); *)
(*   when st_43 == ((free_stack "smc_rtt_create" st_0 st_42)); *)
(*   (Some (0, st_43)). *)

(* Definition smc_rtt_create_4_low *)
(*   (v_wi: Ptr) *)
(*   (v_call14: Ptr) *)
(*   (v_call15: Z) *)
(*   (v_call16: Ptr) *)
(*   (v_ulevel: Z) *)
(*   (v_g_tbl: Ptr) *)
(*   (v_rtt_addr: Z) *)
(*   (st_0: RData) *)
(*   (st_28: RData) : *)
(*   option (Z * RData) := *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call16.(pbase) = "slot_delegated"); *)
(*   rely (v_call14.(pbase) = "slot_rtt"); *)
(*   rely (v_g_tbl.(pbase) = "stack_g0"); *)
(*   rely (v_g_tbl.(poffset) = 0); *)
(*   when v_call29, st_29 == ((s2tte_pa_spec v_call15 (v_ulevel + ((- 1))) st_28)); *)
(*   when st_30 == ((s2tt_init_assigned_empty_spec v_call16 v_call29 v_ulevel st_29)); *)
(*   when v_16_tmp, st_31 == ((load_RData 8 v_g_tbl st_30)); *)
(*   rely (v_16_tmp < STACK_VIRT /\ v_16_tmp >= GRANULES_BASE); *)
(*   when st_32 == ((__granule_refcount_inc_spec (int_to_ptr v_16_tmp) 512 st_31)); *)
(*   when v_21_tmp, st_34 == ((load_RData 8 v_g_tbl st_32)); *)
(*   rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE); *)
(*   when st_35 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_34)); *)
(*   when v_call63, st_36 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_35)); *)
(*   when v_22, st_37 == ((load_RData 8 (ptr_offset v_wi 8) st_36)); *)
(*   when st_38 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_37)); *)
(*   when st_39 == ((buffer_unmap_spec v_call16 st_38)); *)
(*   when st_40 == ((buffer_unmap_spec v_call14 st_39)); *)
(*   when v_23_tmp, st_41 == ((load_RData 8 (ptr_offset v_wi 0) st_40)); *)
(*   rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE); *)
(*   when st_42 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_41)); *)
(*   when v_24_tmp, st_43 == ((load_RData 8 v_g_tbl st_42)); *)
(*   rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE); *)
(*   when st_44 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_43)); *)
(*   when st_45 == ((free_stack "smc_rtt_create" st_0 st_44)); *)
(*   (Some (0, st_45)). *)

(* Definition smc_rtt_create_3_low *)
(*   (v_wi: Ptr) *)
(*   (v_map_addr: Z) *)
(*   (v_call14: Ptr) *)
(*   (v_call15: Z) *)
(*   (v_call16: Ptr) *)
(*   (v_s2_ctx: Ptr) *)
(*   (v_g_tbl: Ptr) *)
(*   (v_rtt_addr: Z) *)
(*   (v_ulevel: Z) *)
(*   (st_0: RData) *)
(*   (st_29: RData) : *)
(*   option (Z * RData) := *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call16.(pbase) = "slot_delegated"); *)
(*   rely (v_call14.(pbase) = "slot_rtt"); *)
(*   rely (v_g_tbl.(pbase) = "stack_g0"); *)
(*   rely (v_g_tbl.(poffset) = 0); *)
(*   rely (v_s2_ctx.(pbase) = "stack_s2_ctx"); *)
(*   rely (v_s2_ctx.(poffset) = 0); *)
(*   when v_17, st_30 == ((load_RData 8 (ptr_offset v_wi 8) st_29)); *)
(*   when st_31 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_17))) 0 st_30)); *)
(*   when st_32 == ((invalidate_block_spec v_s2_ctx v_map_addr st_31)); *)
(*   when v_call38, st_33 == ((s2tte_pa_spec v_call15 (v_ulevel + ((- 1))) st_32)); *)
(*   when st_34 == ((s2tt_init_valid_spec v_call16 v_call38 v_ulevel st_33)); *)
(*   when v_18_tmp, st_35 == ((load_RData 8 v_g_tbl st_34)); *)
(*   rely (v_18_tmp < STACK_VIRT /\ v_18_tmp >= GRANULES_BASE); *)
(*   when st_36 == ((__granule_refcount_inc_spec (int_to_ptr v_18_tmp) 512 st_35)); *)
(*   when v_21_tmp, st_38 == ((load_RData 8 v_g_tbl st_36)); *)
(*   rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE); *)
(*   when st_39 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_38)); *)
(*   when v_call63, st_40 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_39)); *)
(*   when v_22, st_41 == ((load_RData 8 (ptr_offset v_wi 8) st_40)); *)
(*   when st_42 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_41)); *)
(*   when st_43 == ((buffer_unmap_spec v_call16 st_42)); *)
(*   when st_44 == ((buffer_unmap_spec v_call14 st_43)); *)
(*   when v_23_tmp, st_45 == ((load_RData 8 (ptr_offset v_wi 0) st_44)); *)
(*   rely (v_23_tmp > 0); *)
(*   rely (v_23_tmp < STACK_VIRT); *)
(*   rely (v_23_tmp >= GRANULES_BASE); *)
(*   rely (v_23_tmp < MAX_ERR); *)
(*   when st_46 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_45)); *)
(*   when v_24_tmp, st_47 == ((load_RData 8 v_g_tbl st_46)); *)
(*   rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE); *)
(*   when st_48 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_47)); *)
(*   when st_49 == ((free_stack "smc_rtt_create" st_0 st_48)); *)
(*   (Some (0, st_49)). *)

(* Definition smc_rtt_create_2_low *)
(*   (v_map_addr: Z) *)
(*   (v_wi: Ptr) *)
(*   (v_call14: Ptr) *)
(*   (v_call15: Z) *)
(*   (v_call16: Ptr) *)
(*   (v_ulevel: Z) *)
(*   (v_g_tbl: Ptr) *)
(*   (v_s2_ctx: Ptr) *)
(*   (v_rtt_addr: Z) *)
(*   (st_0: RData) *)
(*   (st_30: RData) : *)
(*   option (Z * RData) := *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call16.(pbase) = "slot_delegated"); *)
(*   rely (v_call14.(pbase) = "slot_rtt"); *)
(*   rely (v_g_tbl.(pbase) = "stack_g0"); *)
(*   rely (v_g_tbl.(poffset) = 0); *)
(*   rely (v_s2_ctx.(pbase) = "stack_s2_ctx"); *)
(*   rely (v_s2_ctx.(poffset) = 0); *)
(*   when v_19, st_31 == ((load_RData 8 (ptr_offset v_wi 8) st_30)); *)
(*   when st_32 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_19))) 0 st_31)); *)
(*   when st_33 == ((invalidate_block_spec v_s2_ctx v_map_addr st_32)); *)
(*   when v_call47, st_34 == ((s2tte_pa_spec v_call15 (v_ulevel + ((- 1))) st_33)); *)
(*   when st_35 == ((s2tt_init_valid_ns_spec v_call16 v_call47 v_ulevel st_34)); *)
(*   when v_20_tmp, st_36 == ((load_RData 8 v_g_tbl st_35)); *)
(*   rely (v_20_tmp < STACK_VIRT /\ v_20_tmp >= GRANULES_BASE); *)
(*   when st_37 == ((__granule_refcount_inc_spec (int_to_ptr v_20_tmp) 512 st_36)); *)
(*   when v_21_tmp, st_39 == ((load_RData 8 v_g_tbl st_37)); *)
(*   rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE); *)
(*   when st_40 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_39)); *)
(*   when v_call63, st_41 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_40)); *)
(*   when v_22, st_42 == ((load_RData 8 (ptr_offset v_wi 8) st_41)); *)
(*   when st_43 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_42)); *)
(*   when st_44 == ((buffer_unmap_spec v_call16 st_43)); *)
(*   when st_45 == ((buffer_unmap_spec v_call14 st_44)); *)
(*   when v_23_tmp, st_46 == ((load_RData 8 (ptr_offset v_wi 0) st_45)); *)
(*   rely (v_23_tmp > 0); *)
(*   rely (v_23_tmp < MAX_ERR); *)
(*   rely (v_23_tmp < STACK_VIRT); *)
(*   rely (v_23_tmp >= GRANULES_BASE); *)
(*   when st_47 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_46)); *)
(*   when v_24_tmp, st_48 == ((load_RData 8 v_g_tbl st_47)); *)
(*   rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE); *)
(*   when st_49 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_48)); *)
(*   when st_50 == ((free_stack "smc_rtt_create" st_0 st_49)); *)
(*   (Some (0, st_50)). *)

(* Definition smc_rtt_create_1_low *)
(*   (v_ulevel: Z) *)
(*   (v_call14: Ptr) *)
(*   (v_call16: Ptr) *)
(*   (v_wi: Ptr) *)
(*   (v_g_tbl: Ptr) *)
(*   (st_0: RData) *)
(*   (st_31: RData) : *)
(*   option (Z * RData) := *)
(*   rely (v_g_tbl.(pbase) = "stack_g0"); *)
(*   rely (v_g_tbl.(poffset) = 0); *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call16.(pbase) = "slot_delegated"); *)
(*   rely (v_call14.(pbase) = "slot_rtt"); *)
(*   when v_call54, st_32 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_31)); *)
(*   when st_33 == ((buffer_unmap_spec v_call16 st_32)); *)
(*   when st_34 == ((buffer_unmap_spec v_call14 st_33)); *)
(*   when v_23_tmp, st_35 == ((load_RData 8 (ptr_offset v_wi 0) st_34)); *)
(*   rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE); *)
(*   when st_36 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_35)); *)
(*   when v_24_tmp, st_37 == ((load_RData 8 v_g_tbl st_36)); *)
(*   rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE); *)
(*   when st_38 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_37)); *)
(*   when st_40 == ((free_stack "smc_rtt_create" st_0 st_38)); *)
(*   (Some (v_call54, st_40)). *)

(* Definition smc_rtt_create_0_low *)
(*   (v_g_tbl: Ptr) *)
(*   (v_rtt_addr: Z) *)
(*   (v_ulevel: Z) *)
(*   (v_wi: Ptr) *)
(*   (v_call14: Ptr) *)
(*   (v_call16: Ptr) *)
(*   (st_0: RData) *)
(*   (st_31: RData) : *)
(*   option (Z * RData) := *)
(*   rely (v_g_tbl.(pbase) = "stack_g0"); *)
(*   rely (v_g_tbl.(poffset) = 0); *)
(*   rely (v_wi.(pbase) = "stack_wi"); *)
(*   rely (v_wi.(poffset) = 0); *)
(*   rely (v_call16.(pbase) = "slot_delegated"); *)
(*   rely (v_call14.(pbase) = "slot_rtt"); *)
(*   when v_21_tmp, st_33 == ((load_RData 8 v_g_tbl st_31)); *)
(*   rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE); *)
(*   when st_34 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_33)); *)
(*   when v_call63, st_35 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_34)); *)
(*   when v_22, st_36 == ((load_RData 8 (ptr_offset v_wi 8) st_35)); *)
(*   when st_37 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_36)); *)
(*   when st_38 == ((buffer_unmap_spec v_call16 st_37)); *)
(*   when st_39 == ((buffer_unmap_spec v_call14 st_38)); *)
(*   when v_23_tmp, st_40 == ((load_RData 8 (ptr_offset v_wi 0) st_39)); *)
(*   rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE); *)
(*   when st_41 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_40)); *)
(*   when v_24_tmp, st_42 == ((load_RData 8 v_g_tbl st_41)); *)
(*   rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE); *)
(*   when st_43 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_42)); *)
(*   when st_44 == ((free_stack "smc_rtt_create" st_0 st_43)); *)
(*   (Some (0, st_44)). *)

(* Definition smc_rtt_create_spec_low (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) := *)
(*   when st_0 == ((new_frame "smc_rtt_create" st)); *)
(*   (* when v_g_rd, st_1 == ((alloc_stack "smc_rtt_create" 8 8 st_0)); *) *)
(*   (* when v_g_tbl, st_2 == ((alloc_stack "smc_rtt_create" 8 8 st_1)); *) *)
(*   (* when v_wi, st_3 == ((alloc_stack "smc_rtt_create" 24 8 st_2)); *) *)
(*   (* when v_s2_ctx, st_4 == ((alloc_stack "smc_rtt_create" 32 8 st_3)); *) *)
(*   let v_g_rd := (mkPtr "stack_g1" 0) in *)
(*   let v_g_tbl := (mkPtr "stack_g0" 0) in *)
(*   let v_wi := (mkPtr "stack_wi" 0) in *)
(*   let v_s2_ctx := (mkPtr "v_s2_ctx" 0) in *)
(*   let st_4 := st_0 in; *)
(*   when v_call, st_5 == ((find_lock_two_granules_spec v_rtt_addr 1 v_g_tbl v_rd_addr 2 v_g_rd st_4)); *)
(*   if v_call *)
(*   then ( *)
(*     when v_0_tmp, st_6 == ((load_RData 8 v_g_rd st_5)); *)
(*     rely (v_0_tmp < STACK_VIRT /\ v_0_tmp >= GRANULES_BASE); *)
(*     when v_call1_0, st_7 == ((granule_map_spec (int_to_ptr v_0_tmp) 2 st_6)); *)
(*     when v_call2, st_8 == ((validate_rtt_structure_cmds_spec v_map_addr v_ulevel v_call1_0 st_7)); *)
(*     if v_call2 *)
(*     then ( *)
(*       when v_5_tmp, st_10 == ((load_RData 8 (ptr_offset v_call1_0 32) st_8)); *)
(*       when v_call6, st_11 == ((realm_rtt_starting_level_spec v_call1_0 st_10)); *)
(*       when v_call7, st_12 == ((realm_ipa_bits_spec v_call1_0 st_11)); *)
(*       when st_13 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1_0 16) 32 false st_12)); *)
(*       when st_14 == ((buffer_unmap_spec v_call1_0 st_13)); *)
(*       rely (v_5_tmp < STACK_VIRT /\ v_5_tmp >= GRANULES_BASE); *)
(*       when st_15 == ((granule_lock_spec (int_to_ptr v_5_tmp) 6 st_14)); *)
(*       when v_7_tmp, st_16 == ((load_RData 8 v_g_rd st_15)); *)
(*       rely (v_7_tmp < STACK_VIRT /\ v_7_tmp >= GRANULES_BASE); *)
(*       when st_17 == ((granule_unlock_spec (int_to_ptr v_7_tmp) st_16)); *)
(*       when st_18 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_5_tmp) v_call6 v_call7 v_map_addr (v_ulevel + ((- 1))) v_wi st_17)); *)
(*       when v_8, st_19 == ((load_RData 8 (ptr_offset v_wi 16) st_18)); *)
(*       if ((v_8 - ((v_ulevel + ((- 1))))) =? (0)) *)
(*       then ( *)
(*         when v_9_tmp, st_20 == ((load_RData 8 (ptr_offset v_wi 0) st_19)); *)
(*         rely (v_9_tmp < STACK_VIRT /\ v_9_tmp >= GRANULES_BASE); *)
(*         when v_call14, st_21 == ((granule_map_spec (int_to_ptr v_9_tmp) 22 st_20)); *)
(*         when v_11, st_22 == ((load_RData 8 (ptr_offset v_wi 8) st_21)); *)
(*         when v_call15, st_23 == ((__tte_read_spec (ptr_offset v_call14 (8 * (v_11))) st_22)); *)
(*         when v_12_tmp, st_24 == ((load_RData 8 v_g_tbl st_23)); *)
(*         rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE); *)
(*         when v_call16, st_25 == ((granule_map_spec (int_to_ptr v_12_tmp) 1 st_24)); *)
(*         when v_call17, st_26 == ((s2tte_is_unassigned_spec v_call15 st_25)); *)
(*         if v_call17 *)
(*         then (smc_rtt_create_6 v_wi v_call14 v_call15 v_call16 v_ulevel v_g_tbl v_rtt_addr st_0 st_26) *)
(*         else ( *)
(*           when v_call21, st_27 == ((s2tte_is_destroyed_spec v_call15 st_26)); *)
(*           if v_call21 *)
(*           then (smc_rtt_create_5 v_wi v_call14 v_call15 v_call16 v_ulevel v_g_tbl v_rtt_addr st_0 st_27) *)
(*           else ( *)
(*             when v_call26, st_28 == ((s2tte_is_assigned_spec v_call15 (v_ulevel + ((- 1))) st_27)); *)
(*             if v_call26 *)
(*             then (smc_rtt_create_4 v_wi v_call14 v_call15 v_call16 v_ulevel v_g_tbl v_rtt_addr st_0 st_28) *)
(*             else ( *)
(*               when v_call32, st_29 == ((s2tte_is_valid_spec v_call15 (v_ulevel + ((- 1))) st_28)); *)
(*               if v_call32 *)
(*               then (smc_rtt_create_3 v_wi v_map_addr v_call14 v_call15 v_call16 v_s2_ctx v_g_tbl v_rtt_addr v_ulevel st_0 st_29) *)
(*               else ( *)
(*                 when v_call41, st_30 == ((s2tte_is_valid_ns_spec v_call15 (v_ulevel + ((- 1))) st_29)); *)
(*                 if v_call41 *)
(*                 then (smc_rtt_create_2 v_map_addr v_wi v_call14 v_call15 v_call16 v_ulevel v_g_tbl v_s2_ctx v_rtt_addr st_0 st_30) *)
(*                 else ( *)
(*                   when v_call50, st_31 == ((s2tte_is_table_spec v_call15 (v_ulevel + ((- 1))) st_30)); *)
(*                   if v_call50 *)
(*                   then (smc_rtt_create_1 v_ulevel v_call14 v_call16 v_wi v_g_tbl st_0 st_31) *)
(*                   else (smc_rtt_create_0 v_g_tbl v_rtt_addr v_ulevel v_wi v_call14 v_call16 st_0 st_31 ))))))) *)
(*       else ( *)
(*         when v_call12, st_20 == ((pack_return_code_spec 4 v_8 st_19)); *)
(*         when v_23_tmp, st_21 == ((load_RData 8 (ptr_offset v_wi 0) st_20)); *)
(*         rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE); *)
(*         when st_22 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_21)); *)
(*         when v_24_tmp, st_23 == ((load_RData 8 v_g_tbl st_22)); *)
(*         rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE); *)
(*         when st_24 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_23)); *)
(*         when st_26 == ((free_stack "smc_rtt_create" st_0 st_24)); *)
(*         (Some (v_call12, st_26)))) *)
(*     else ( *)
(*       when st_9 == ((buffer_unmap_spec v_call1_0 st_8)); *)
(*       when v_2_tmp, st_10 == ((load_RData 8 v_g_rd st_9)); *)
(*       rely (v_2_tmp < STACK_VIRT /\ v_2_tmp >= GRANULES_BASE); *)
(*       when st_11 == ((granule_unlock_spec (int_to_ptr v_2_tmp) st_10)); *)
(*       when v_3_tmp, st_12 == ((load_RData 8 v_g_tbl st_11)); *)
(*       rely (v_3_tmp < STACK_VIRT /\ v_3_tmp >= GRANULES_BASE); *)
(*       when st_13 == ((granule_unlock_spec (int_to_ptr v_3_tmp) st_12)); *)
(*       when st_15 == ((free_stack "smc_rtt_create" st_0 st_13)); *)
(*       (Some (1, st_15)))) *)
(*   else ( *)
(*     when st_7 == ((free_stack "smc_rtt_create" st_0 st_5)); *)
(*     (Some (1, st_7))). *)

