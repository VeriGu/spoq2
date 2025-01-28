Definition smc_data_dispose_0_low (st_0: RData) (st_26: RData) (v_70: Ptr) (v_74: bool) (v__sroa_032_0_copyload_tmp: Z) (v__sroa_3_0_copyload: Z) : (option (Z * RData)) :=
  rely ((v_74 = (true)));
  when v_78, st_27 == ((s2tte_create_unassigned_spec 1 st_26));
  when st_28 == ((__tte_write_spec (ptr_offset v_70 (8 * (v__sroa_3_0_copyload))) v_78 st_27));
  when st_31 == ((granule_unlock_spec (int_to_ptr v__sroa_032_0_copyload_tmp) st_28));
  when v_83_tmp, st_37 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_31));
  when st_38 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_37));
  when v_84_tmp, st_39 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_38));
  when st_40 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_39));
  when st_43 == ((free_stack "smc_data_dispose" st_0 st_40));
  (Some (0, st_43)).

Definition smc_data_dispose_1_low (st_0: RData) (st_8: RData) (v_34: Z) : (option (Z * RData)) :=
  rely ((((v_34 & (1)) =? (0)) = (true)));
  when v_37, st_9 == ((pack_return_code_spec 7 0 st_8));
  when v_83_tmp, st_13 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_9));
  when st_14 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_13));
  when v_84_tmp, st_15 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_14));
  when st_16 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_15));
  when st_19 == ((free_stack "smc_data_dispose" st_0 st_16));
  (Some (v_37, st_19)).

Definition smc_data_destroy_0_low (st_0: RData) (st_15: RData) (v_25: Ptr) (v_28: Z) (v_29: bool) (v__sroa_016_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
  rely ((v_29 = (true)));
  when v_33, st_16 == ((s2tte_pa_spec v_28 3 st_15));
  when st_17 == ((__tte_write_spec (ptr_offset v_25 (8 * (v__sroa_4_0_copyload))) 8 st_16));
  when st_18 == ((__granule_put_spec (int_to_ptr v__sroa_016_0_copyload_tmp) st_17));
  when v_34, st_19 == ((find_lock_granule_spec v_33 4 st_18));
  rely (((((v_34.(poffset)) mod (16)) = (0)) /\ (((v_34.(poffset)) >= (0)))));
  rely ((((v_34.(pbase)) = ("granules")) \/ (((v_34.(pbase)) = ("null")))));
  when st_20 == ((granule_memzero_spec v_34 1 st_19));
  when st_21 == ((granule_unlock_transition_spec v_34 1 st_20));
  when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_016_0_copyload_tmp) st_21));
  when st_27 == ((free_stack "smc_data_destroy" st_0 st_24));
  (Some (0, st_27)).

Definition smc_rtt_map_protected_0_low (st_0: RData) (st_15: RData) (v_2: Z) (v_26: Ptr) (v_29: Z) (v_30: bool) (v__sroa_018_0_copyload_tmp: Z) (v__sroa_320_0_copyload: Z) : (option (Z * RData)) :=
  rely ((v_30 = (true)));
  when v_34, st_16 == ((s2tte_pa_spec v_29 v_2 st_15));
  when v_35, st_17 == ((s2tte_create_valid_spec v_34 v_2 st_16));
  when st_18 == ((__tte_write_spec (ptr_offset v_26 (8 * (v__sroa_320_0_copyload))) v_35 st_17));
  when st_21 == ((granule_unlock_spec (int_to_ptr v__sroa_018_0_copyload_tmp) st_18));
  when st_20 == ((free_stack "smc_rtt_map_protected" st_0 st_21));
  (Some (0, st_20)).

Definition smc_realm_destroy_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
  rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) /\ (((v_0 & (4095)) = (0)))));
  when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
  rely (
    (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
      (((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
      (0)));
  rely ((((((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0)) = (true)));
  rely (((((((((((lens 28 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0)) = (true)));
  rely (
    ((((4096 * (((v_0 + ((- MEM0_PHYS))) >> (12)))) >= (0)) /\ ((((- 2147483648) + ((4096 * (((v_0 + ((- MEM0_PHYS))) >> (12)))))) < (0)))) /\
      (((((4096 * (((v_0 + ((- MEM0_PHYS))) >> (12)))) + (2147483648)) & (549755813888)) = (0)))));
  rely ((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_granule_state)) - (2)) = (0)));
  rely ((((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
  rely ((((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
  when sh_0 == ((((lens 28 st).(repl)) (((lens 28 st).(oracle)) ((lens 28 st).(log))) ((lens 28 st).(share))));
  rely (
    (((0 - (((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_vmid)) >> (6)))) <= (0)) /\
      ((((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_vmid)) >> (6)) < (1024)))));
  when sh_1 == ((((lens 143 st).(repl)) (((lens 139 st).(oracle)) ((lens 137 st).(log))) ((lens 141 st).(share))));
  if ((0 - ((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_num_root_rtts)))) <? (0))
  then (
    match (
      (total_root_rtt_refcount_loop295
        (z_to_nat (((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_num_root_rtts)))
        false
        (mkPtr "granules" ((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
        0
        0
        0
        (((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_num_root_rtts))
        ((lens 150 st).[halt] :< false))
    ) with
    | (Some (__break__, v_3, v__12, v__0_lcssa_0, v_indvars_iv_0, v_wide_trip_count_0, st_1)) =>
      if (v__0_lcssa_0 =? (0))
      then (
        match (
          (free_sl_rtts_loop194
            (z_to_nat 0)
            false
            (mkPtr "granules" ((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
            true
            0
            (((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_num_root_rtts))
            st_1)
        ) with
        | (Some (__break___0, v_5, v_6, v_indvars_iv_1, v_wide_trip_count_1, st_2)) =>
          when st_9 == ((granule_memzero_spec (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) 2 st_2));
          (Some (0, ((lens 101 st_9).[halt] :< false)))
        | None => None
        end)
      else (
        when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
        (Some (4, ((lens 155 st_1).[halt] :< false))))
    | None => None
    end)
  else (
    when st_9 == ((granule_memzero_spec (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) 2 ((lens 150 st).[halt] :< false)));
    (Some (0, ((lens 101 st_9).[halt] :< false)))).

