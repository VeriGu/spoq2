Definition smc_rtt_create_6_low
  (v_wi: Ptr)
  (v_call14: Ptr)
  (v_call15: Z)
  (v_call16: Ptr)
  (v_ulevel: Z)
  (v_g_tbl: Ptr)
  (v_rtt_addr: Z)
  (st_0: RData)
  (st_26: RData) :
  option (Z * RData) :=
  rely (v_wi.(pbase) = "smc_rtt_create_stack");
  rely (v_call16.(pbase) = "slot_delegated");
  rely (v_call14.(pbase) = "slot_rtt");
  rely (v_g_tbl.(pbase) = "smc_rtt_create_stack");
  when v_call19, st_27 == ((s2tte_get_ripas_spec v_call15 st_26));
  when st_28 == ((s2tt_init_unassigned_spec v_call16 v_call19 st_27));
  when v_14_tmp, st_29 == ((load_RData 8 (ptr_offset v_wi 0) st_28));
  rely (v_14_tmp < STACK_VIRT /\ v_14_tmp >= GRANULES_BASE);
  when st_30 == ((__granule_get_spec (int_to_ptr v_14_tmp) st_29));
  when v_21_tmp, st_32 == ((load_RData 8 v_g_tbl st_30));
  rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE);
  when st_33 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_32));
  when v_call63, st_34 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_33));
  when v_22, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34));
  when st_36 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_35));
  when st_37 == ((buffer_unmap_spec v_call16 st_36));
  when st_38 == ((buffer_unmap_spec v_call14 st_37));
  when v_23_tmp, st_39 == ((load_RData 8 (ptr_offset v_wi 0) st_38));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_40 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_39));
  when v_24_tmp, st_41 == ((load_RData 8 v_g_tbl st_40));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_42 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_41));
  when st_43 == ((free_stack "smc_rtt_create" st_0 st_42));
  (Some (0, st_43)).

Definition smc_rtt_create_5_low
  (v_wi: Ptr)
  (v_call14: Ptr)
  (v_call15: Z)
  (v_call16: Ptr)
  (v_ulevel: Z)
  (v_g_tbl: Ptr)
  (v_rtt_addr: Z)
  (st_0: RData)
  (st_27: RData) :
  option (Z * RData) :=
  rely (v_wi.(pbase) = "smc_rtt_create_stack");
  rely (v_call16.(pbase) = "slot_delegated");
  rely (v_call14.(pbase) = "slot_rtt");
  rely (v_g_tbl.(pbase) = "smc_rtt_create_stack");
  when st_28 == ((s2tt_init_destroyed_spec v_call16 st_27));
  when v_15_tmp, st_29 == ((load_RData 8 (ptr_offset v_wi 0) st_28));
  rely (v_15_tmp < STACK_VIRT /\ v_15_tmp >= GRANULES_BASE);
  when st_30 == ((__granule_get_spec (int_to_ptr v_15_tmp) st_29));
  when v_21_tmp, st_32 == ((load_RData 8 v_g_tbl st_30));
  rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE);
  when st_33 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_32));
  when v_call63, st_34 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_33));
  when v_22, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34));
  when st_36 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_35));
  when st_37 == ((buffer_unmap_spec v_call16 st_36));
  when st_38 == ((buffer_unmap_spec v_call14 st_37));
  when v_23_tmp, st_39 == ((load_RData 8 (ptr_offset v_wi 0) st_38));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_40 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_39));
  when v_24_tmp, st_41 == ((load_RData 8 v_g_tbl st_40));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_42 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_41));
  when st_43 == ((free_stack "smc_rtt_create" st_0 st_42));
  (Some (0, st_43)).

Definition smc_rtt_create_4_low
  (v_wi: Ptr)
  (v_call14: Ptr)
  (v_call15: Z)
  (v_call16: Ptr)
  (v_ulevel: Z)
  (v_g_tbl: Ptr)
  (v_rtt_addr: Z)
  (st_0: RData)
  (st_28: RData) :
  option (Z * RData) :=
  rely (v_wi.(pbase) = "smc_rtt_create_stack");
  rely (v_call16.(pbase) = "slot_delegated");
  rely (v_call14.(pbase) = "slot_rtt");
  rely (v_g_tbl.(pbase) = "smc_rtt_create_stack");
  when v_call29, st_29 == ((s2tte_pa_spec v_call15 (v_ulevel + ((- 1))) st_28));
  when st_30 == ((s2tt_init_assigned_empty_spec v_call16 v_call29 v_ulevel st_29));
  when v_16_tmp, st_31 == ((load_RData 8 v_g_tbl st_30));
  rely (v_16_tmp < STACK_VIRT /\ v_16_tmp >= GRANULES_BASE);
  when st_32 == ((__granule_refcount_inc_spec (int_to_ptr v_16_tmp) 512 st_31));
  when v_21_tmp, st_34 == ((load_RData 8 v_g_tbl st_32));
  rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE);
  when st_35 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_34));
  when v_call63, st_36 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_35));
  when v_22, st_37 == ((load_RData 8 (ptr_offset v_wi 8) st_36));
  when st_38 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_37));
  when st_39 == ((buffer_unmap_spec v_call16 st_38));
  when st_40 == ((buffer_unmap_spec v_call14 st_39));
  when v_23_tmp, st_41 == ((load_RData 8 (ptr_offset v_wi 0) st_40));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_42 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_41));
  when v_24_tmp, st_43 == ((load_RData 8 v_g_tbl st_42));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_44 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_43));
  when st_45 == ((free_stack "smc_rtt_create" st_0 st_44));
  (Some (0, st_45)).

Definition smc_rtt_create_3_low
  (v_wi: Ptr)
  (v_map_addr: Z)
  (v_call14: Ptr)
  (v_call15: Z)
  (v_call16: Ptr)
  (v_s2_ctx: Ptr)
  (v_g_tbl: Ptr)
  (v_rtt_addr: Z)
  (v_ulevel: Z)
  (st_0: RData)
  (st_29: RData) :
  option (Z * RData) :=
  rely (v_wi.(pbase) = "smc_rtt_create_stack");
  rely (v_call16.(pbase) = "slot_delegated");
  rely (v_call14.(pbase) = "slot_rtt");
  rely (v_g_tbl.(pbase) = "smc_rtt_create_stack");
  rely (v_s2_ctx.(pbase) = "smc_rtt_create_stack");
  when v_17, st_30 == ((load_RData 8 (ptr_offset v_wi 8) st_29));
  when st_31 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_17))) 0 st_30));
  when st_32 == ((invalidate_block_spec v_s2_ctx v_map_addr st_31));
  when v_call38, st_33 == ((s2tte_pa_spec v_call15 (v_ulevel + ((- 1))) st_32));
  when st_34 == ((s2tt_init_valid_spec v_call16 v_call38 v_ulevel st_33));
  when v_18_tmp, st_35 == ((load_RData 8 v_g_tbl st_34));
  rely (v_18_tmp < STACK_VIRT /\ v_18_tmp >= GRANULES_BASE);
  when st_36 == ((__granule_refcount_inc_spec (int_to_ptr v_18_tmp) 512 st_35));
  when v_21_tmp, st_38 == ((load_RData 8 v_g_tbl st_36));
  rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE);
  when st_39 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_38));
  when v_call63, st_40 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_39));
  when v_22, st_41 == ((load_RData 8 (ptr_offset v_wi 8) st_40));
  when st_42 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_41));
  when st_43 == ((buffer_unmap_spec v_call16 st_42));
  when st_44 == ((buffer_unmap_spec v_call14 st_43));
  when v_23_tmp, st_45 == ((load_RData 8 (ptr_offset v_wi 0) st_44));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_46 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_45));
  when v_24_tmp, st_47 == ((load_RData 8 v_g_tbl st_46));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_48 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_47));
  when st_49 == ((free_stack "smc_rtt_create" st_0 st_48));
  (Some (0, st_49)).

Definition smc_rtt_create_2_low
  (v_map_addr: Z)
  (v_wi: Ptr)
  (v_call14: Ptr)
  (v_call15: Z)
  (v_call16: Ptr)
  (v_ulevel: Z)
  (v_g_tbl: Ptr)
  (v_s2_ctx: Ptr)
  (v_rtt_addr: Z)
  (st_0: RData)
  (st_30: RData) :
  option (Z * RData) :=
  rely (v_wi.(pbase) = "smc_rtt_create_stack");
  rely (v_call16.(pbase) = "slot_delegated");
  rely (v_call14.(pbase) = "slot_rtt");
  rely (v_g_tbl.(pbase) = "smc_rtt_create_stack");
  rely (v_s2_ctx.(pbase) = "smc_rtt_create_stack");
  when v_19, st_31 == ((load_RData 8 (ptr_offset v_wi 8) st_30));
  when st_32 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_19))) 0 st_31));
  when st_33 == ((invalidate_block_spec v_s2_ctx v_map_addr st_32));
  when v_call47, st_34 == ((s2tte_pa_spec v_call15 (v_ulevel + ((- 1))) st_33));
  when st_35 == ((s2tt_init_valid_ns_spec v_call16 v_call47 v_ulevel st_34));
  when v_20_tmp, st_36 == ((load_RData 8 v_g_tbl st_35));
  rely (v_20_tmp < STACK_VIRT /\ v_20_tmp >= GRANULES_BASE);
  when st_37 == ((__granule_refcount_inc_spec (int_to_ptr v_20_tmp) 512 st_36));
  when v_21_tmp, st_39 == ((load_RData 8 v_g_tbl st_37));
  rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE);
  when st_40 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_39));
  when v_call63, st_41 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_40));
  when v_22, st_42 == ((load_RData 8 (ptr_offset v_wi 8) st_41));
  when st_43 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_42));
  when st_44 == ((buffer_unmap_spec v_call16 st_43));
  when st_45 == ((buffer_unmap_spec v_call14 st_44));
  when v_23_tmp, st_46 == ((load_RData 8 (ptr_offset v_wi 0) st_45));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_47 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_46));
  when v_24_tmp, st_48 == ((load_RData 8 v_g_tbl st_47));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_49 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_48));
  when st_50 == ((free_stack "smc_rtt_create" st_0 st_49));
  (Some (0, st_50)).

Definition smc_rtt_create_1_low
  (v_ulevel: Z)
  (v_call14: Ptr)
  (v_call16: Ptr)
  (v_wi: Ptr)
  (v_g_tbl: Ptr)
  (st_0: RData)
  (st_31: RData) :
  option (Z * RData) :=
  rely (v_g_tbl.(pbase) = "smc_rtt_create_stack");
  rely (v_wi.(pbase) = "smc_rtt_create_stack");
  rely (v_call16.(pbase) = "slot_delegated");
  rely (v_call14.(pbase) = "slot_rtt");
  when v_call54, st_32 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_31));
  when st_33 == ((buffer_unmap_spec v_call16 st_32));
  when st_34 == ((buffer_unmap_spec v_call14 st_33));
  when v_23_tmp, st_35 == ((load_RData 8 (ptr_offset v_wi 0) st_34));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_36 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_35));
  when v_24_tmp, st_37 == ((load_RData 8 v_g_tbl st_36));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_38 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_37));
  when st_40 == ((free_stack "smc_rtt_create" st_0 st_38));
  (Some (v_call54, st_40)).

Definition smc_rtt_create_0_low
  (v_g_tbl: Ptr)
  (v_rtt_addr: Z)
  (v_ulevel: Z)
  (v_wi: Ptr)
  (v_call14: Ptr)
  (v_call16: Ptr)
  (st_0: RData)
  (st_31: RData) :
  option (Z * RData) :=
  rely (v_g_tbl.(pbase) = "smc_rtt_create_stack");
  rely (v_wi.(pbase) = "smc_rtt_create_stack");
  rely (v_call16.(pbase) = "slot_delegated");
  rely (v_call14.(pbase) = "slot_rtt");
  when v_21_tmp, st_33 == ((load_RData 8 v_g_tbl st_31));
  rely (v_21_tmp < STACK_VIRT /\ v_21_tmp >= GRANULES_BASE);
  when st_34 == ((granule_set_state_spec (int_to_ptr v_21_tmp) 6 st_33));
  when v_call63, st_35 == ((s2tte_create_table_spec v_rtt_addr (v_ulevel + ((- 1))) st_34));
  when v_22, st_36 == ((load_RData 8 (ptr_offset v_wi 8) st_35));
  when st_37 == ((__tte_write_spec (ptr_offset v_call14 (8 * (v_22))) v_call63 st_36));
  when st_38 == ((buffer_unmap_spec v_call16 st_37));
  when st_39 == ((buffer_unmap_spec v_call14 st_38));
  when v_23_tmp, st_40 == ((load_RData 8 (ptr_offset v_wi 0) st_39));
  rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
  when st_41 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_40));
  when v_24_tmp, st_42 == ((load_RData 8 v_g_tbl st_41));
  rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
  when st_43 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_42));
  when st_44 == ((free_stack "smc_rtt_create" st_0 st_43));
  (Some (0, st_44)).

Definition smc_rtt_create_spec_low (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
  when st_0 == ((new_frame "smc_rtt_create" st));
  when v_g_rd, st_1 == ((alloc_stack "smc_rtt_create" 8 8 st_0));
  when v_g_tbl, st_2 == ((alloc_stack "smc_rtt_create" 8 8 st_1));
  when v_wi, st_3 == ((alloc_stack "smc_rtt_create" 24 8 st_2));
  when v_s2_ctx, st_4 == ((alloc_stack "smc_rtt_create" 32 8 st_3));
  when v_call, st_5 == ((find_lock_two_granules_spec v_rtt_addr 1 v_g_tbl v_rd_addr 2 v_g_rd st_4));
  if v_call
  then (
    when v_0_tmp, st_6 == ((load_RData 8 v_g_rd st_5));
    rely (v_0_tmp < STACK_VIRT /\ v_0_tmp >= GRANULES_BASE);
    when v_call1_0, st_7 == ((granule_map_spec (int_to_ptr v_0_tmp) 2 st_6));
    when v_call2, st_8 == ((validate_rtt_structure_cmds_spec v_map_addr v_ulevel v_call1_0 st_7));
    if v_call2
    then (
      when v_5_tmp, st_10 == ((load_RData 8 (ptr_offset v_call1_0 32) st_8));
      when v_call6, st_11 == ((realm_rtt_starting_level_spec v_call1_0 st_10));
      when v_call7, st_12 == ((realm_ipa_bits_spec v_call1_0 st_11));
      when st_13 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1_0 16) 32 false st_12));
      when st_14 == ((buffer_unmap_spec v_call1_0 st_13));
      rely (v_5_tmp < STACK_VIRT /\ v_5_tmp >= GRANULES_BASE);
      when st_15 == ((granule_lock_spec (int_to_ptr v_5_tmp) 6 st_14));
      when v_7_tmp, st_16 == ((load_RData 8 v_g_rd st_15));
      rely (v_7_tmp < STACK_VIRT /\ v_7_tmp >= GRANULES_BASE);
      when st_17 == ((granule_unlock_spec (int_to_ptr v_7_tmp) st_16));
      when st_18 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_5_tmp) v_call6 v_call7 v_map_addr (v_ulevel + ((- 1))) v_wi st_17));
      when v_8, st_19 == ((load_RData 8 (ptr_offset v_wi 16) st_18));
      if ((v_8 - ((v_ulevel + ((- 1))))) =? (0))
      then (
        when v_9_tmp, st_20 == ((load_RData 8 (ptr_offset v_wi 0) st_19));
        rely (v_9_tmp < STACK_VIRT /\ v_9_tmp >= GRANULES_BASE);
        when v_call14, st_21 == ((granule_map_spec (int_to_ptr v_9_tmp) 22 st_20));
        when v_11, st_22 == ((load_RData 8 (ptr_offset v_wi 8) st_21));
        when v_call15, st_23 == ((__tte_read_spec (ptr_offset v_call14 (8 * (v_11))) st_22));
        when v_12_tmp, st_24 == ((load_RData 8 v_g_tbl st_23));
        rely (v_12_tmp < STACK_VIRT /\ v_12_tmp >= GRANULES_BASE);
        when v_call16, st_25 == ((granule_map_spec (int_to_ptr v_12_tmp) 1 st_24));
        when v_call17, st_26 == ((s2tte_is_unassigned_spec v_call15 st_25));
        if v_call17
        then (smc_rtt_create_6 v_wi v_call14 v_call15 v_call16 v_ulevel v_g_tbl v_rtt_addr st_0 st_26)
        else (
          when v_call21, st_27 == ((s2tte_is_destroyed_spec v_call15 st_26));
          if v_call21
          then (smc_rtt_create_5 v_wi v_call14 v_call15 v_call16 v_ulevel v_g_tbl v_rtt_addr st_0 st_27)
          else (
            when v_call26, st_28 == ((s2tte_is_assigned_spec v_call15 (v_ulevel + ((- 1))) st_27));
            if v_call26
            then (smc_rtt_create_4 v_wi v_call14 v_call15 v_call16 v_ulevel v_g_tbl v_rtt_addr st_0 st_28)
            else (
              when v_call32, st_29 == ((s2tte_is_valid_spec v_call15 (v_ulevel + ((- 1))) st_28));
              if v_call32
              then (smc_rtt_create_3 v_wi v_map_addr v_call14 v_call15 v_call16 v_s2_ctx v_g_tbl v_rtt_addr v_ulevel st_0 st_29)
              else (
                when v_call41, st_30 == ((s2tte_is_valid_ns_spec v_call15 (v_ulevel + ((- 1))) st_29));
                if v_call41
                then (smc_rtt_create_2 v_map_addr v_wi v_call14 v_call15 v_call16 v_ulevel v_g_tbl v_s2_ctx v_rtt_addr st_0 st_30)
                else (
                  when v_call50, st_31 == ((s2tte_is_table_spec v_call15 (v_ulevel + ((- 1))) st_30));
                  if v_call50
                  then (smc_rtt_create_1 v_ulevel v_call14 v_call16 v_wi v_g_tbl st_0 st_31)
                  else (smc_rtt_create_0 v_g_tbl v_rtt_addr v_ulevel v_wi v_call14 v_call16 st_0 st_31 )))))))
      else (
        when v_call12, st_20 == ((pack_return_code_spec 4 v_8 st_19));
        when v_23_tmp, st_21 == ((load_RData 8 (ptr_offset v_wi 0) st_20));
        rely (v_23_tmp < STACK_VIRT /\ v_23_tmp >= GRANULES_BASE);
        when st_22 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_21));
        when v_24_tmp, st_23 == ((load_RData 8 v_g_tbl st_22));
        rely (v_24_tmp < STACK_VIRT /\ v_24_tmp >= GRANULES_BASE);
        when st_24 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_23));
        when st_26 == ((free_stack "smc_rtt_create" st_0 st_24));
        (Some (v_call12, st_26))))
    else (
      when st_9 == ((buffer_unmap_spec v_call1_0 st_8));
      when v_2_tmp, st_10 == ((load_RData 8 v_g_rd st_9));
      rely (v_2_tmp < STACK_VIRT /\ v_2_tmp >= GRANULES_BASE);
      when st_11 == ((granule_unlock_spec (int_to_ptr v_2_tmp) st_10));
      when v_3_tmp, st_12 == ((load_RData 8 v_g_tbl st_11));
      rely (v_3_tmp < STACK_VIRT /\ v_3_tmp >= GRANULES_BASE);
      when st_13 == ((granule_unlock_spec (int_to_ptr v_3_tmp) st_12));
      when st_15 == ((free_stack "smc_rtt_create" st_0 st_13));
      (Some (1, st_15))))
  else (
    when st_7 == ((free_stack "smc_rtt_create" st_0 st_5));
    (Some (1, st_7))).

