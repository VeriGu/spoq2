Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_rtt_fold_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_fold_1_low (v_call1_0: Ptr) (v_s2_ctx: Ptr) (v_call: Ptr) (v_map_addr: Z) (v_ulevel: Z) (v_wi: Ptr) (st_6: RData) : (option (Z * RData)) :=
    rely (((v_call1_0.(pbase)) = ("slot_rd")));
    rely (((v_call1_0.(poffset)) = (0)));
    rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack")));
    rely (((v_call.(pbase)) = ("granules")));
    rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack")));
    when v_2_tmp, st_8 == ((load_RData 8 (ptr_offset v_call1_0 32) st_6));
    when v_call6, st_9 == ((realm_rtt_starting_level_spec v_call1_0 st_8));
    when v_call7, st_10 == ((realm_ipa_bits_spec v_call1_0 st_9));
    when st_11 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1_0 16) 32 false st_10));
    when st_12 == ((buffer_unmap_spec v_call1_0 st_11));
    rely (((v_2_tmp < (STACK_VIRT)) /\ ((v_2_tmp >= (GRANULES_BASE)))));
    when st_13 == ((granule_lock_spec (int_to_ptr v_2_tmp) 6 st_12));
    when st_14 == ((granule_unlock_spec v_call st_13));
    rely (((v_2_tmp < (STACK_VIRT)) /\ ((v_2_tmp >= (GRANULES_BASE)))));
    when st_15 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_2_tmp) v_call6 v_call7 v_map_addr (v_ulevel + ((- 1))) v_wi st_14));
    when v_4, st_16 == ((load_RData 8 (ptr_offset v_wi 16) st_15));
    (Some (v_4, st_16)).

  Definition smc_rtt_fold_2_low (v_s2_ctx: Ptr) (v_map_addr: Z) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_call44: Z) (v_call33: Ptr) (st_0: RData) (st_33: RData) : (option (Z * RData)) :=
    rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack")));
    rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack")));
    rely (((v_call15.(pbase)) = ("slot_rtt")));
    rely (((v_call34.(pbase)) = ("slot_rtt2")));
    rely (((v_call33.(pbase)) = ("granules")));
    when st_34 == ((invalidate_pages_in_block_spec v_s2_ctx v_map_addr st_33));
    when v_14, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34));
    when st_36 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_14))) v_call44 st_35));
    when st_37 == ((granule_memzero_mapped_spec v_call34 st_36));
    when st_38 == ((granule_set_state_spec v_call33 1 st_37));
    when st_39 == ((buffer_unmap_spec v_call34 st_38));
    when st_40 == ((granule_unlock_spec v_call33 st_39));
    when st_41 == ((buffer_unmap_spec v_call15 st_40));
    when v_15_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_41));
    rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE)))));
    when st_43 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_42));
    when st_44 == ((free_stack "smc_rtt_fold" st_0 st_43));
    (Some (0, st_44)).

  Definition smc_rtt_fold_3_low (v_s2_ctx: Ptr) (v_map_addr: Z) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_call44: Z) (v_call33: Ptr) (st_0: RData) (st_34: RData) : (option (Z * RData)) :=
    rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack")));
    rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack")));
    rely (((v_call15.(pbase)) = ("slot_rtt")));
    rely (((v_call34.(pbase)) = ("slot_rtt2")));
    rely (((v_call33.(pbase)) = ("granules")));
    when st_34 == ((invalidate_block_spec v_s2_ctx v_map_addr st_34));
    when v_14, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34));
    when st_36 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_14))) v_call44 st_35));
    when st_37 == ((granule_memzero_mapped_spec v_call34 st_36));
    when st_38 == ((granule_set_state_spec v_call33 1 st_37));
    when st_39 == ((buffer_unmap_spec v_call34 st_38));
    when st_40 == ((granule_unlock_spec v_call33 st_39));
    when st_41 == ((buffer_unmap_spec v_call15 st_40));
    when v_15_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_41));
    rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE)))));
    when st_43 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_42));
    when st_44 == ((free_stack "smc_rtt_fold" st_0 st_43));
    (Some (0, st_44)).

  Definition smc_rtt_fold_4_low (v_ripas: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call44: Z) (v_ulevel: Z) (st_28: RData) : (option (bool * RData)) :=
    rely (((v_ripas.(pbase)) = ("smc_rtt_fold_stack")));
    rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack")));
    rely (((v_call15.(pbase)) = ("slot_rtt")));
    when v_11, st_29 == ((load_RData 4 v_ripas st_28));
    when v_call44, st_30 == ((s2tte_create_unassigned_spec v_11 st_29));
    when v_12_tmp, st_31 == ((load_RData 8 (ptr_offset v_wi 0) st_30));
    rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
    when st_32 == ((__granule_put_spec (int_to_ptr v_12_tmp) st_31));
    when v_13, st_34 == ((load_RData 8 (ptr_offset v_wi 8) st_32));
    when st_35 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_34));
    when v_call87, st_36 == ((s2tte_is_valid_spec v_call44 (v_ulevel + ((- 1))) st_35));
    (Some (v_call87, st_36)).

  Definition smc_rtt_fold_5_low (v_call34: Ptr) (v_call33: Ptr) (v_call15: Ptr) (v_wi: Ptr) (st_0: RData) (st_28: RData) : (option (Z * RData)) :=
    rely (((v_call34.(pbase)) = ("slot_rtt2")));
    rely (((v_call33.(pbase)) = ("granules")));
    rely (((v_call15.(pbase)) = ("slot_rtt")));
    rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack")));
    when st_29 == ((buffer_unmap_spec v_call34 st_28));
    when st_30 == ((granule_unlock_spec v_call33 st_29));
    when st_31 == ((buffer_unmap_spec v_call15 st_30));
    when v_15_tmp, st_32 == ((load_RData 8 (ptr_offset v_wi 0) st_31));
    rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE)))));
    when st_33 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_32));
    when st_35 == ((free_stack "smc_rtt_fold" st_0 st_33));
    (Some (5, st_35)).

  Definition smc_rtt_fold_6_low (v_call34: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_ulevel: Z) (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call33: Ptr) (v_ripas: Ptr) (st_0: RData) (st_26: RData) : (option (Z * RData)) :=
    rely (((v_call34.(pbase)) = ("slot_rtt2")));
    rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack")));
    rely (((v_call15.(pbase)) = ("slot_rtt")));
    rely (((v_call33.(pbase)) = ("granules")));
    rely (((v_ripas.(pbase)) = ("smc_rtt_fold_stack")));
    when v_call38, st_27 == ((table_is_destroyed_block_spec v_call34 st_26));
    if v_call38
    then (
      when v_10_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_27));
      rely (((v_10_tmp < (STACK_VIRT)) /\ ((v_10_tmp >= (GRANULES_BASE)))));
      when st_29 == ((__granule_put_spec (int_to_ptr v_10_tmp) st_28));
      when v_13, st_31 == ((load_RData 8 (ptr_offset v_wi 8) st_29));
      when st_32 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_31));
      when v_call87, st_33 == ((s2tte_is_valid_spec 8 (v_ulevel + ((- 1))) st_32));
      if v_call87
      then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 8 v_call33 st_0 st_33)
      else (
        when v_call90, st_34 == ((s2tte_is_valid_ns_spec 8 (v_ulevel + ((- 1))) st_33));
        if v_call90
        then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 8 v_call33 st_0 st_34)
        else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 8 v_call33 st_0 st_34)))
    else (
      when v_call42, st_28 == ((table_is_unassigned_block_spec v_call34 v_ripas st_27));
      if v_call42
      then (
        when v_11, st_29 == ((load_RData 4 v_ripas st_28));
        when v_call44, st_30 == ((s2tte_create_unassigned_spec v_11 st_29));
        when v_12_tmp, st_31 == ((load_RData 8 (ptr_offset v_wi 0) st_30));
        rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
        when st_32 == ((__granule_put_spec (int_to_ptr v_12_tmp) st_31));
        when v_13, st_34 == ((load_RData 8 (ptr_offset v_wi 8) st_32));
        when st_35 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_34));
        when v_call87, st_36 == ((s2tte_is_valid_spec v_call44 (v_ulevel + ((- 1))) st_35));
        if v_call87
        then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call44 v_call33 st_0 st_36)
        else (
          when v_call90, st_37 == ((s2tte_is_valid_ns_spec v_call44 (v_ulevel + ((- 1))) st_36));
          if v_call90
          then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call44 v_call33 st_0 st_37)
          else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call44 v_call33 st_0 st_37)))
      else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_28)).

  Definition smc_rtt_fold_7_low (v_ulevel: Z) (v_call60: Z) (v_call33: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_s2_ctx: Ptr) (v_map_addr: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) :=
    rely (((v_call33.(pbase)) = ("granules")));
    rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack")));
    rely (((v_call15.(pbase)) = ("slot_rtt")));
    rely (((v_call34.(pbase)) = ("slot_rtt2")));
    when v_call64, st_30 == ((s2tte_create_assigned_empty_spec v_call60 (v_ulevel + ((- 1))) st_29));
    when st_32 == ((__granule_refcount_dec_spec v_call33 512 st_30));
    when v_13, st_33 == ((load_RData 8 (ptr_offset v_wi 8) st_32));
    when st_34 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_33));
    when v_call87, st_35 == ((s2tte_is_valid_spec v_call64 (v_ulevel + ((- 1))) st_34));
    if v_call87
    then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call64 v_call33 st_0 st_35)
    else (
      when v_call90, st_36 == ((s2tte_is_valid_ns_spec v_call64 (v_ulevel + ((- 1))) st_35));
      if v_call90
      then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call64 v_call33 st_0 st_36)
      else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call64 v_call33 st_0 st_36)).

  Definition smc_rtt_fold_8_low (v_call34: Ptr) (v_ulevel: Z) (v_call60: Z) (v_call33: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_s2_ctx: Ptr) (v_map_addr: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) :=
    rely (((v_call34.(pbase)) = ("slot_rtt2")));
    rely (((v_call33.(pbase)) = ("granules")));
    rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack")));
    rely (((v_call15.(pbase)) = ("slot_rtt")));
    rely (((v_call34.(pbase)) = ("slot_rtt2")));
    when v_call66, st_30 == ((table_maps_valid_block_spec v_call34 v_ulevel st_29));
    if v_call66
    then (
      when v_call69, st_31 == ((s2tte_create_valid_spec v_call60 (v_ulevel + ((- 1))) st_30));
      when st_33 == ((__granule_refcount_dec_spec v_call33 512 st_31));
      when v_13, st_34 == ((load_RData 8 (ptr_offset v_wi 8) st_33));
      when st_35 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_34));
      when v_call87, st_36 == ((s2tte_is_valid_spec v_call69 (v_ulevel + ((- 1))) st_35));
      if v_call87
      then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call69 v_call33 st_0 st_36)
      else (
        when v_call90, st_37 == ((s2tte_is_valid_ns_spec v_call69 (v_ulevel + ((- 1))) st_36));
        if v_call90
        then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call69 v_call33 st_0 st_37)
        else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call69 v_call33 st_0 st_37)))
    else (
      when v_call71, st_31 == ((table_maps_valid_ns_block_spec v_call34 v_ulevel st_30));
      if v_call71
      then (
        when v_call74, st_32 == ((s2tte_create_valid_ns_spec v_call60 (v_ulevel + ((- 1))) st_31));
        when st_34 == ((__granule_refcount_dec_spec v_call33 512 st_32));
        when v_13, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34));
        when st_36 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_35));
        when v_call87, st_37 == ((s2tte_is_valid_spec v_call74 (v_ulevel + ((- 1))) st_36));
        if v_call87
        then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call74 v_call33 st_0 st_37)
        else (
          when v_call90, st_38 == ((s2tte_is_valid_ns_spec v_call74 (v_ulevel + ((- 1))) st_37));
          if v_call90
          then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call74 v_call33 st_0 st_38)
          else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call74 v_call33 st_0 st_38)))
      else (
        when v_call77, st_32 == ((pack_return_code_spec 4 v_ulevel st_31));
        when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_32));
        (Some (v_call77, st_39)))).

  Definition smc_rtt_fold_spec_low (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_fold" st));
    when v_wi, st_1 == ((alloc_stack "smc_rtt_fold" 24 8 st_0));
    when v_s2_ctx, st_2 == ((alloc_stack "smc_rtt_fold" 32 8 st_1));
    when v_ripas, st_3 == ((alloc_stack "smc_rtt_fold" 4 4 st_2));
    when v_call, st_4 == ((find_lock_granule_spec v_rd_addr 2 st_3));
    if (ptr_eqb v_call (mkPtr "null" 0))
    then (
      when st_6 == ((free_stack "smc_rtt_fold" st_0 st_4));
      (Some (1, st_6)))
    else (
      when v_call1_0, st_5 == ((granule_map_spec v_call 2 st_4));
      when v_call2, st_6 == ((validate_rtt_structure_cmds_spec v_map_addr v_ulevel v_call1_0 st_5));
      if v_call2
      then (
        when v_4, st_16 == ((smc_rtt_fold_1 v_call1_0 v_s2_ctx v_call v_map_addr v_ulevel v_wi st_6));
        if ((v_4 - ((v_ulevel + ((- 1))))) =? (0))
        then (
          when v_5_tmp, st_17 == ((load_RData 8 (ptr_offset v_wi 0) st_16));
          rely (((v_5_tmp < (STACK_VIRT)) /\ ((v_5_tmp >= (GRANULES_BASE)))));
          when v_call15, st_18 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_17));
          when v_7, st_19 == ((load_RData 8 (ptr_offset v_wi 8) st_18));
          when v_call16, st_20 == ((__tte_read_spec (ptr_offset v_call15 (8 * (v_7))) st_19));
          when v_call18, st_21 == ((s2tte_is_table_spec v_call16 (v_ulevel + ((- 1))) st_20));
          if v_call18
          then (
            when v_call25, st_22 == ((s2tte_pa_table_spec v_call16 (v_ulevel + ((- 1))) st_21));
            if ((v_call25 - (v_rtt_addr)) =? (0))
            then (
              when v_call33, st_24 == ((find_lock_granule_spec v_rtt_addr 6 st_22));
              when v_call34, st_25 == ((granule_map_spec v_call33 23 st_24));
              when v_9, st_26 == ((load_RData 8 (ptr_offset v_call33 8) st_25));
              if (v_9 =? (0))
              then (smc_rtt_fold_6 v_call34 v_wi v_call15 v_ulevel v_s2_ctx v_map_addr v_call33 v_ripas st_0 st_26)
              else (
                if (v_9 =? (512))
                then (
                  if (v_ulevel <? (3))
                  then (
                    when st_27 == ((buffer_unmap_spec v_call34 st_26));
                    when st_28 == ((granule_unlock_spec v_call33 st_27));
                    when st_29 == ((buffer_unmap_spec v_call15 st_28));
                    when v_15_tmp, st_30 == ((load_RData 8 (ptr_offset v_wi 0) st_29));
                    rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE)))));
                    when st_31 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_30));
                    when st_33 == ((free_stack "smc_rtt_fold" st_0 st_31));
                    (Some (5, st_33)))
                  else (
                    when v_call59, st_27 == ((__tte_read_spec v_call34 st_26));
                    when v_call60, st_28 == ((s2tte_pa_spec v_call59 v_ulevel st_27));
                    when v_call61, st_29 == ((table_maps_assigned_block_spec v_call34 v_ulevel st_28));
                    if v_call61
                    then (smc_rtt_fold_7 v_ulevel v_call60 v_call33 v_wi v_call15 v_call34 v_s2_ctx v_map_addr st_0 st_29)
                    else (smc_rtt_fold_8 v_call34 v_ulevel v_call60 v_call33 v_wi v_call15 v_call34 v_s2_ctx v_map_addr st_0 st_29)))
                else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_26)))
            else (
              when v_call31, st_23 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_22));
              when st_24 == ((buffer_unmap_spec v_call15 st_23));
              when v_15_tmp, st_25 == ((load_RData 8 (ptr_offset v_wi 0) st_24));
              rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE)))));
              when st_26 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_25));
              when st_28 == ((free_stack "smc_rtt_fold" st_0 st_26));
              (Some (v_call31, st_28))))
          else (
            when v_call22, st_22 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_21));
            when st_23 == ((buffer_unmap_spec v_call15 st_22));
            when v_15_tmp, st_24 == ((load_RData 8 (ptr_offset v_wi 0) st_23));
            rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE)))));
            when st_25 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_24));
            when st_27 == ((free_stack "smc_rtt_fold" st_0 st_25));
            (Some (v_call22, st_27))))
        else (
          when v_call13, st_17 == ((pack_return_code_spec 4 v_4 st_16));
          when v_15_tmp, st_18 == ((load_RData 8 (ptr_offset v_wi 0) st_17));
          rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE)))));
          when st_19 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_18));
          when st_21 == ((free_stack "smc_rtt_fold" st_0 st_19));
          (Some (v_call13, st_21))))
      else (
        when st_7 == ((buffer_unmap_spec v_call1_0 st_6));
        when st_8 == ((granule_unlock_spec v_call st_7));
        when st_10 == ((free_stack "smc_rtt_fold" st_0 st_8));
        (Some (1, st_10)))).

End SMCHandler_smc_rtt_fold_LowSpec.

#[global] Hint Unfold smc_rtt_fold_1_low: spec.
#[global] Hint Unfold smc_rtt_fold_2_low: spec.
#[global] Hint Unfold smc_rtt_fold_3_low: spec.
#[global] Hint Unfold smc_rtt_fold_4_low: spec.
#[global] Hint Unfold smc_rtt_fold_5_low: spec.
#[global] Hint Unfold smc_rtt_fold_6_low: spec.
#[global] Hint Unfold smc_rtt_fold_7_low: spec.
#[global] Hint Unfold smc_rtt_fold_8_low: spec.
#[global] Hint Unfold smc_rtt_fold_spec_low: spec.
