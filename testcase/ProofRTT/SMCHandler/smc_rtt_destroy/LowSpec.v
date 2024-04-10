Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_rtt_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_destroy_3_low (v_call17: Z) (v_ulevel: Z) (v_rtt_addr: Z) (v_call9: bool) (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (st_0: RData) (st_20: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")));
    rely (((v_call16.(pbase)) = ("slot_rtt")));
    when v_call26, st_21 == ((s2tte_pa_table_spec v_call17 (v_ulevel + ((- 1))) st_20));
    if ((v_call26 - (v_rtt_addr)) =? (0))
    then (
      when v_call31, st_22 == ((find_lock_granule_spec v_rtt_addr 6 st_21));
      when v_8, st_23 == ((load_RData 8 (ptr_offset v_call31 8) st_22));
      if (v_8 =? (0))
      then (
        when v_call36, st_24 == ((granule_map_spec v_call31 23 st_23));
        if v_call9
        then (smc_rtt_destroy_2 v_wi v_call16 v_map_addr v_s2_ctx v_call36 v_call31 st_0 st_24)
        else (smc_rtt_destroy_1 v_wi v_call16 v_map_addr v_s2_ctx v_call36 v_call31 st_0 st_24))
      else (
        when st_25 == ((granule_unlock_spec v_call31 st_23));
        when st_28 == ((buffer_unmap_spec v_call16 st_25));
        when v_12_tmp, st_30 == ((load_RData 8 (ptr_offset v_wi 0) st_28));
        rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
        when st_31 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_30));
        when st_34 == ((free_stack "smc_rtt_destroy" st_0 st_31));
        (Some (5, st_34))))
    else (
      when st_24 == ((buffer_unmap_spec v_call16 st_21));
      when v_12_tmp, st_26 == ((load_RData 8 (ptr_offset v_wi 0) st_24));
      rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
      when st_27 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_26));
      when st_30 == ((free_stack "smc_rtt_destroy" st_0 st_27));
      (Some (1, st_30))).

  Definition smc_rtt_destroy_2_low (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (v_call36: Ptr) (v_call31: Ptr) (st_0: RData) (st_24: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")));
    rely (((v_call16.(pbase)) = ("slot_rtt")));
    rely (((v_s2_ctx.(pbase)) = ("smc_rtt_destroy_stack")));
    rely (((v_call36.(pbase)) = ("slot_rtt2")));
    rely (((v_call31.(pbase)) = ("granules")));
    when v_9_tmp, st_26 == ((load_RData 8 (ptr_offset v_wi 0) st_24));
    rely (((v_9_tmp < (STACK_VIRT)) /\ ((v_9_tmp >= (GRANULES_BASE)))));
    when st_27 == ((__granule_put_spec (int_to_ptr v_9_tmp) st_26));
    when v_10, st_28 == ((load_RData 8 (ptr_offset v_wi 8) st_27));
    when st_29 == ((__tte_write_spec (ptr_offset v_call16 (8 * (v_10))) 0 st_28));
    when st_30 == ((invalidate_block_spec v_s2_ctx v_map_addr st_29));
    when v_11, st_31 == ((load_RData 8 (ptr_offset v_wi 8) st_30));
    when st_32 == ((__tte_write_spec (ptr_offset v_call16 (8 * (v_11))) 8 st_31));
    when st_33 == ((granule_memzero_mapped_spec v_call36 st_32));
    when st_34 == ((granule_set_state_spec v_call31 1 st_33));
    when st_35 == ((buffer_unmap_spec v_call36 st_34));
    when st_37 == ((granule_unlock_spec v_call31 st_35));
    when st_40 == ((buffer_unmap_spec v_call16 st_37));
    when v_12_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_40));
    rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
    when st_43 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_42));
    when st_46 == ((free_stack "smc_rtt_destroy" st_0 st_43));
    (Some (0, st_46)).

  Definition smc_rtt_destroy_1_low (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (v_call36: Ptr) (v_call31: Ptr) (st_0: RData) (st_24: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")));
    rely (((v_call16.(pbase)) = ("slot_rtt")));
    rely (((v_s2_ctx.(pbase)) = ("smc_rtt_destroy_stack")));
    rely (((v_call36.(pbase)) = ("slot_rtt2")));
    rely (((v_call31.(pbase)) = ("granules")));
    when v_9_tmp, st_26 == ((load_RData 8 (ptr_offset v_wi 0) st_24));
    rely (((v_9_tmp < (STACK_VIRT)) /\ ((v_9_tmp >= (GRANULES_BASE)))));
    when st_27 == ((__granule_put_spec (int_to_ptr v_9_tmp) st_26));
    when v_10, st_28 == ((load_RData 8 (ptr_offset v_wi 8) st_27));
    when st_29 == ((__tte_write_spec (ptr_offset v_call16 (8 * (v_10))) 0 st_28));
    when st_30 == ((invalidate_block_spec v_s2_ctx v_map_addr st_29));
    when v_11, st_31 == ((load_RData 8 (ptr_offset v_wi 8) st_30));
    when st_32 == ((__tte_write_spec (ptr_offset v_call16 (8 * (v_11))) 0 st_31));
    when st_33 == ((granule_memzero_mapped_spec v_call36 st_32));
    when st_34 == ((granule_set_state_spec v_call31 1 st_33));
    when st_35 == ((buffer_unmap_spec v_call36 st_34));
    when st_37 == ((granule_unlock_spec v_call31 st_35));
    when st_40 == ((buffer_unmap_spec v_call16 st_37));
    when v_12_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_40));
    rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
    when st_43 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_42));
    when st_46 == ((free_stack "smc_rtt_destroy" st_0 st_43));
    (Some (0, st_46)).

  Definition smc_rtt_destroy_spec_low (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_destroy" st));
    when v_wi, st_1 == ((alloc_stack "smc_rtt_destroy" 24 8 st_0));
    when v_s2_ctx, st_2 == ((alloc_stack "smc_rtt_destroy" 32 8 st_1));
    when v_call, st_3 == ((find_lock_granule_spec v_rd_addr 2 st_2));
    if (ptr_eqb v_call (mkPtr "null" 0))
    then (
      when st_5 == ((free_stack "smc_rtt_destroy" st_0 st_3));
      (Some (1, st_5)))
    else (
      when v_call1, st_4 == ((granule_map_spec v_call 2 st_3));
      when v_call2, st_5 == ((validate_rtt_structure_cmds_spec v_map_addr v_ulevel v_call1 st_4));
      if v_call2
      then (
        when v_2_tmp, st_6 == ((load_RData 8 (ptr_offset v_call1 32) st_5));
        when v_call6, st_7 == ((realm_rtt_starting_level_spec v_call1 st_6));
        when v_call7, st_8 == ((realm_ipa_bits_spec v_call1 st_7));
        when st_9 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1 16) 32 false st_8));
        when v_call9, st_10 == ((addr_in_par_spec v_call1 v_map_addr st_9));
        when st_11 == ((buffer_unmap_spec v_call1 st_10));
        rely (((v_2_tmp < (STACK_VIRT)) /\ ((v_2_tmp >= (GRANULES_BASE)))));
        when st_12 == ((granule_lock_spec (int_to_ptr v_2_tmp) 6 st_11));
        when st_13 == ((granule_unlock_spec v_call st_12));
        when st_14 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_2_tmp) v_call6 v_call7 v_map_addr (v_ulevel + ((- 1))) v_wi st_13));
        when v_4, st_15 == ((load_RData 8 (ptr_offset v_wi 16) st_14));
        if ((v_4 - ((v_ulevel + ((- 1))))) =? (0))
        then (
          when v_5_tmp, st_16 == ((load_RData 8 (ptr_offset v_wi 0) st_15));
          rely (((v_5_tmp < (STACK_VIRT)) /\ ((v_5_tmp >= (GRANULES_BASE)))));
          when v_call16, st_17 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_16));
          when v_7, st_18 == ((load_RData 8 (ptr_offset v_wi 8) st_17));
          when v_call17, st_19 == ((__tte_read_spec (ptr_offset v_call16 (8 * (v_7))) st_18));
          when v_call19, st_20 == ((s2tte_is_table_spec v_call17 (v_ulevel + ((- 1))) st_19));
          if v_call19
          then (smc_rtt_destroy_3 v_call17 v_ulevel v_rtt_addr v_call9 v_wi v_call16 v_map_addr v_s2_ctx st_0 st_20)
          else (
            when v_call23, st_21 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_20));
            when st_23 == ((buffer_unmap_spec v_call16 st_21));
            when v_12_tmp, st_25 == ((load_RData 8 (ptr_offset v_wi 0) st_23));
            rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
            when st_26 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_25));
            when st_29 == ((free_stack "smc_rtt_destroy" st_0 st_26));
            (Some (v_call23, st_29))))
        else (
          when v_call14, st_16 == ((pack_return_code_spec 4 v_4 st_15));
          when v_12_tmp, st_18 == ((load_RData 8 (ptr_offset v_wi 0) st_16));
          rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
          when st_19 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_18));
          when st_22 == ((free_stack "smc_rtt_destroy" st_0 st_19));
          (Some (v_call14, st_22))))
      else (
        when st_6 == ((buffer_unmap_spec v_call1 st_5));
        when st_7 == ((granule_unlock_spec v_call st_6));
        when st_10 == ((free_stack "smc_rtt_destroy" st_0 st_7));
        (Some (1, st_10)))).

End SMCHandler_smc_rtt_destroy_LowSpec.

#[global] Hint Unfold smc_rtt_destroy_3_low: spec.
#[global] Hint Unfold smc_rtt_destroy_2_low: spec.
#[global] Hint Unfold smc_rtt_destroy_1_low: spec.
#[global] Hint Unfold smc_rtt_destroy_spec_low: spec.
