Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_rtt_set_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_set_ripas_1_low (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
    rely (((v_s2_ctx.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_call9.(poffset)) = (0)));
    rely (((v_call47.(pbase)) = ("slot_rtt")));
    rely (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
    when st_36 == ((invalidate_page_spec v_s2_ctx v_map_addr st_35));
    when v_21, st_39 == ((load_RData 8 (ptr_offset v_call9 864) st_36));
    when st_40 == ((store_RData 8 (ptr_offset v_call9 864) (v_21 + (v_call30)) st_39));
    when st_42 == ((buffer_unmap_spec v_call47 st_40));
    when v_22_tmp, st_44 == ((load_RData 8 (ptr_offset v_wi 0) st_42));
    rely (((v_22_tmp < (STACK_VIRT)) /\ ((v_22_tmp >= (GRANULES_BASE)))));
    when st_45 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_44));
    when st_48 == ((buffer_unmap_spec v_call25 st_45));
    when st_52 == ((buffer_unmap_spec v_call9 st_48));
    when v_23_tmp, st_54 == ((load_RData 8 v_g_rec st_52));
    rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
    when st_55 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_54));
    when v_24_tmp, st_56 == ((load_RData 8 v_g_rd st_55));
    rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
    when st_57 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_56));
    when st_60 == ((free_stack "smc_rtt_set_ripas" st_0 st_57));
    (Some (0, st_60)).

  Definition smc_rtt_set_ripas_2_low (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
    rely (((v_s2_ctx.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_call9.(poffset)) = (0)));
    rely (((v_call47.(pbase)) = ("slot_rtt")));
    rely (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
    when st_36 == ((invalidate_block_spec v_s2_ctx v_map_addr st_35));
    when v_21, st_39 == ((load_RData 8 (ptr_offset v_call9 864) st_36));
    when st_40 == ((store_RData 8 (ptr_offset v_call9 864) (v_21 + (v_call30)) st_39));
    when st_42 == ((buffer_unmap_spec v_call47 st_40));
    when v_22_tmp, st_44 == ((load_RData 8 (ptr_offset v_wi 0) st_42));
    rely (((v_22_tmp < (STACK_VIRT)) /\ ((v_22_tmp >= (GRANULES_BASE)))));
    when st_45 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_44));
    when st_48 == ((buffer_unmap_spec v_call25 st_45));
    when st_52 == ((buffer_unmap_spec v_call9 st_48));
    when v_23_tmp, st_54 == ((load_RData 8 v_g_rec st_52));
    rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
    when st_55 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_54));
    when v_24_tmp, st_56 == ((load_RData 8 v_g_rd st_55));
    rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
    when st_57 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_56));
    when st_60 == ((free_stack "smc_rtt_set_ripas" st_0 st_57));
    (Some (0, st_60)).

  Definition smc_rtt_set_ripas_3_low (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_call9.(poffset)) = (0)));
    rely (((v_call47.(pbase)) = ("slot_rtt")));
    rely (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
    when v_21, st_37 == ((load_RData 8 (ptr_offset v_call9 864) st_35));
    when st_38 == ((store_RData 8 (ptr_offset v_call9 864) (v_21 + (v_call30)) st_37));
    when st_40 == ((buffer_unmap_spec v_call47 st_38));
    when v_22_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_40));
    rely (((v_22_tmp < (STACK_VIRT)) /\ ((v_22_tmp >= (GRANULES_BASE)))));
    when st_43 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_42));
    when st_46 == ((buffer_unmap_spec v_call25 st_43));
    when st_50 == ((buffer_unmap_spec v_call9 st_46));
    when v_23_tmp, st_52 == ((load_RData 8 v_g_rec st_50));
    rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
    when st_53 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_52));
    when v_24_tmp, st_54 == ((load_RData 8 v_g_rd st_53));
    rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
    when st_55 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_54));
    when st_58 == ((free_stack "smc_rtt_set_ripas" st_0 st_55));
    (Some (0, st_58)).

  Definition smc_rtt_set_ripas_4_low (v_ulevel: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_32: RData) : (option (Z * RData)) :=
    rely (((v_call47.(pbase)) = ("slot_rtt")));
    rely (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
    when v_call53, st_33 == ((pack_return_code_spec 4 v_ulevel st_32));
    when st_35 == ((buffer_unmap_spec v_call47 st_33));
    when v_22_tmp, st_37 == ((load_RData 8 (ptr_offset v_wi 0) st_35));
    rely (((v_22_tmp < (STACK_VIRT)) /\ ((v_22_tmp >= (GRANULES_BASE)))));
    when st_38 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_37));
    when st_41 == ((buffer_unmap_spec v_call25 st_38));
    when st_45 == ((buffer_unmap_spec v_call9 st_41));
    when v_23_tmp, st_47 == ((load_RData 8 v_g_rec st_45));
    rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
    when st_48 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_47));
    when v_24_tmp, st_49 == ((load_RData 8 v_g_rd st_48));
    rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
    when st_50 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_49));
    when st_53 == ((free_stack "smc_rtt_set_ripas" st_0 st_50));
    (Some (v_call53, st_53)).

  Definition smc_rtt_set_ripas_5_low (v_15: Z) (v_wi: Ptr) (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_25: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
    when v_call45, st_26 == ((pack_return_code_spec 4 v_15 st_25));
    when v_22_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_26));
    rely (((v_22_tmp < (STACK_VIRT)) /\ ((v_22_tmp >= (GRANULES_BASE)))));
    when st_29 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_28));
    when st_32 == ((buffer_unmap_spec v_call25 st_29));
    when st_36 == ((buffer_unmap_spec v_call9 st_32));
    when v_23_tmp, st_38 == ((load_RData 8 v_g_rec st_36));
    rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
    when st_39 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_38));
    when v_24_tmp, st_40 == ((load_RData 8 v_g_rd st_39));
    rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
    when st_41 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_40));
    when st_44 == ((free_stack "smc_rtt_set_ripas" st_0 st_41));
    (Some (v_call45, st_44)).

  Definition smc_rtt_set_ripas_6_low (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_18: RData) : (option (Z * RData)) :=
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
    when st_21 == ((buffer_unmap_spec v_call25 st_18));
    when st_25 == ((buffer_unmap_spec v_call9 st_21));
    when v_23_tmp, st_27 == ((load_RData 8 v_g_rec st_25));
    rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
    when st_28 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_27));
    when v_24_tmp, st_29 == ((load_RData 8 v_g_rd st_28));
    rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
    when st_30 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_29));
    when st_33 == ((free_stack "smc_rtt_set_ripas" st_0 st_30));
    (Some (1, st_33)).

  Definition smc_rtt_set_ripas_7_low (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_13: RData) : (option (Z * RData)) :=
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
    when st_16 == ((buffer_unmap_spec v_call9 st_13));
    when v_23_tmp, st_18 == ((load_RData 8 v_g_rec st_16));
    rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
    when st_19 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_18));
    when v_24_tmp, st_20 == ((load_RData 8 v_g_rd st_19));
    rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
    when st_21 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_20));
    when st_24 == ((free_stack "smc_rtt_set_ripas" st_0 st_21));
    (Some (1, st_24)).

  Definition smc_rtt_set_ripas_8_low (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_8: RData) : (option (Z * RData)) :=
    rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
    when v_23_tmp, st_10 == ((load_RData 8 v_g_rec st_8));
    rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
    when st_11 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_10));
    when v_24_tmp, st_12 == ((load_RData 8 v_g_rd st_11));
    rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
    when st_13 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_12));
    when st_16 == ((free_stack "smc_rtt_set_ripas" st_0 st_13));
    (Some (5, st_16)).

  Definition smc_rtt_set_ripas_spec_low (v_rd_addr: Z) (v_rec_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (v_uripas: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_set_ripas" st));
    when v_g_rd, st_1 == ((alloc_stack "smc_rtt_set_ripas" 8 8 st_0));
    when v_g_rec, st_2 == ((alloc_stack "smc_rtt_set_ripas" 8 8 st_1));
    when v_wi, st_3 == ((alloc_stack "smc_rtt_set_ripas" 24 8 st_2));
    when v_s2tte, st_4 == ((alloc_stack "smc_rtt_set_ripas" 8 8 st_3));
    when v_s2_ctx, st_5 == ((alloc_stack "smc_rtt_set_ripas" 32 8 st_4));
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
          rely (((v_2_tmp < (STACK_VIRT)) /\ ((v_2_tmp >= (GRANULES_BASE)))));
          rely (((v_4_tmp < (STACK_VIRT)) /\ ((v_4_tmp >= (GRANULES_BASE)))));
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
                then (
                  when v_call30, st_17 == ((s2tte_map_size_spec v_ulevel st_16));
                  when v_11, st_18 == ((load_RData 8 (ptr_offset v_call9 856) st_17));
                  if (((v_call30 + (v_map_addr)) - (v_11)) >? (0))
                  then (
                    when st_21 == ((buffer_unmap_spec v_call25 st_18));
                    when st_25 == ((buffer_unmap_spec v_call9 st_21));
                    when v_23_tmp, st_27 == ((load_RData 8 v_g_rec st_25));
                    rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
                    when st_28 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_27));
                    when v_24_tmp, st_29 == ((load_RData 8 v_g_rd st_28));
                    rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
                    when st_30 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_29));
                    when st_33 == ((free_stack "smc_rtt_set_ripas" st_0 st_30));
                    (Some (1, st_33)))
                  else (
                    when v_13_tmp, st_19 == ((load_RData 8 (ptr_offset v_call25 32) st_18));
                    when v_call37, st_20 == ((realm_rtt_starting_level_spec v_call25 st_19));
                    when v_call38, st_21 == ((realm_ipa_bits_spec v_call25 st_20));
                    when st_22 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call25 16) 32 false st_21));
                    rely (((v_13_tmp < (STACK_VIRT)) /\ ((v_13_tmp >= (GRANULES_BASE)))));
                    when st_23 == ((granule_lock_spec (int_to_ptr v_13_tmp) 6 st_22));
                    when st_24 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_13_tmp) v_call37 v_call38 v_map_addr v_ulevel v_wi st_23));
                    when v_15, st_25 == ((load_RData 8 (ptr_offset v_wi 16) st_24));
                    if ((v_15 - (v_ulevel)) =? (0))
                    then (
                      when v_16_tmp, st_26 == ((load_RData 8 (ptr_offset v_wi 0) st_25));
                      rely (((v_16_tmp < (STACK_VIRT)) /\ ((v_16_tmp >= (GRANULES_BASE)))));
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
                    else (smc_rtt_set_ripas_5 v_15 v_wi v_call25 v_call9 v_g_rec v_g_rd st_0 st_25)))
                else (
                  when st_18 == ((buffer_unmap_spec v_call25 st_16));
                  when st_22 == ((buffer_unmap_spec v_call9 st_18));
                  when v_23_tmp, st_24 == ((load_RData 8 v_g_rec st_22));
                  rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
                  when st_25 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_24));
                  when v_24_tmp, st_26 == ((load_RData 8 v_g_rd st_25));
                  rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
                  when st_27 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_26));
                  when st_30 == ((free_stack "smc_rtt_set_ripas" st_0 st_27));
                  (Some (1, st_30))))
              else (
                when st_18 == ((buffer_unmap_spec v_call9 st_14));
                when v_23_tmp, st_20 == ((load_RData 8 v_g_rec st_18));
                rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
                when st_21 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_20));
                when v_24_tmp, st_22 == ((load_RData 8 v_g_rd st_21));
                rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
                when st_23 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_22));
                when st_26 == ((free_stack "smc_rtt_set_ripas" st_0 st_23));
                (Some (1, st_26))))
            else (
              when st_16 == ((buffer_unmap_spec v_call9 st_13));
              when v_23_tmp, st_18 == ((load_RData 8 v_g_rec st_16));
              rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
              when st_19 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_18));
              when v_24_tmp, st_20 == ((load_RData 8 v_g_rd st_19));
              rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
              when st_21 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_20));
              when st_24 == ((free_stack "smc_rtt_set_ripas" st_0 st_21));
              (Some (1, st_24))))
          else (
            when st_14 == ((buffer_unmap_spec v_call9 st_12));
            when v_23_tmp, st_16 == ((load_RData 8 v_g_rec st_14));
            rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
            when st_17 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_16));
            when v_24_tmp, st_18 == ((load_RData 8 v_g_rd st_17));
            rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
            when st_19 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_18));
            when st_22 == ((free_stack "smc_rtt_set_ripas" st_0 st_19));
            (Some (3, st_22))))
        else (
          when v_23_tmp, st_10 == ((load_RData 8 v_g_rec st_8));
          rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
          when st_11 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_10));
          when v_24_tmp, st_12 == ((load_RData 8 v_g_rd st_11));
          rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
          when st_13 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_12));
          when st_16 == ((free_stack "smc_rtt_set_ripas" st_0 st_13));
          (Some (5, st_16))))
      else (
        when st_9 == ((free_stack "smc_rtt_set_ripas" st_0 st_6));
        (Some (1, st_9)))).

End SMCHandler_smc_rtt_set_ripas_LowSpec.

#[global] Hint Unfold smc_rtt_set_ripas_1_low: spec.
#[global] Hint Unfold smc_rtt_set_ripas_2_low: spec.
#[global] Hint Unfold smc_rtt_set_ripas_3_low: spec.
#[global] Hint Unfold smc_rtt_set_ripas_4_low: spec.
#[global] Hint Unfold smc_rtt_set_ripas_5_low: spec.
#[global] Hint Unfold smc_rtt_set_ripas_6_low: spec.
#[global] Hint Unfold smc_rtt_set_ripas_7_low: spec.
#[global] Hint Unfold smc_rtt_set_ripas_8_low: spec.
#[global] Hint Unfold smc_rtt_set_ripas_spec_low: spec.
