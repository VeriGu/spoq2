  Definition rtt_walk_lock_unlock_2_low (__return__: bool) (v_g_tbls: Ptr) (v_map_addr: Z) (v_level: Z) (v_wi: Ptr) (init_st: RData) (st: RData) : (option RData) :=
    rely (v_g_tbls.(pbase) = "rtt_walk_lock_unlock_stack");
    rely (
      ((((((((((((v_wi.(pbase)) = ("smc_rtt_create_stack")) \/ (((v_wi.(pbase)) = ("smc_rtt_fold_stack")))) \/ (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("map_unmap_ns_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_read_entry_stack")))) \/
        (((v_wi.(pbase)) = ("data_create_stack")))) \/
        (((v_wi.(pbase)) = ("smc_data_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_init_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_to_pa_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_get_ripas_stack")))));
    if __return__
    then (
      when st == ((free_stack "rtt_walk_lock_unlock" init_st st));
      (Some st))
    else (
      let v_conv19 := v_level in
      let v_last_level_0 := v_conv19 in
      let v_conv20 := v_last_level_0 in
      let v_last_level21 := (ptr_offset v_wi ((24 * (0)) + ((16 + (0))))) in
      when st == ((store_RData 8 v_last_level21 v_conv20 st));
      rely (((0 <= (v_conv20)) /\ ((v_conv20 < (4)))));
      let v_arrayidx23 := (ptr_offset v_g_tbls (((8 * (4)) * (0)) + (((8 * (v_conv20)) + (0))))) in
      when v_4_tmp, st == ((load_RData 8 v_arrayidx23 st));
      let v_4 := (int_to_ptr v_4_tmp) in
      let v_g_llt := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in
      when st == ((store_RData 8 v_g_llt (ptr_to_int v_4) st));
      when v_call25, st == ((s2_addr_to_idx_spec v_map_addr v_conv20 st));
      let v_index := (ptr_offset v_wi ((24 * (0)) + ((8 + (0))))) in
      when st == ((store_RData 8 v_index v_call25 st));
      let __return__ := true in
      when st == ((free_stack "rtt_walk_lock_unlock" init_st st));
      (Some st)).

  Fixpoint rtt_walk_lock_unlock_loop370_low (_N_: nat) (__return__: bool) (__break__: bool) (v_g_tbls: Ptr) (v_indvars_iv: Z) (v_level: Z) (v_map_addr: Z) (v_wi: Ptr) (st: RData) : (option (bool * bool * Ptr * Z * Z * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
    | (S _N_) =>
      match ((rtt_walk_lock_unlock_loop370_low _N_ __return__ __break__ v_g_tbls v_indvars_iv v_level v_map_addr v_wi st)) with
      | (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st)) =>
        if __break__
        then (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
        else (
          if __return__
          then (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
          else (
            rely (((0 <= (v_indvars_iv)) /\ ((v_indvars_iv < (4)))));
            let v_arrayidx5 := (ptr_offset v_g_tbls (((8 * (4)) * (0)) + (((8 * (v_indvars_iv)) + (0))))) in
            when v_1_tmp, st == ((load_RData 8 v_arrayidx5 st));
            let v_1 := (int_to_ptr v_1_tmp) in
            when v_call7, st == ((__find_lock_next_level_spec v_1 v_map_addr v_indvars_iv st));
            let v_indvars_iv_next := (v_indvars_iv + (1)) in
            rely (((0 <= (v_indvars_iv_next)) /\ ((v_indvars_iv_next < (4)))));
            let v_arrayidx9 := (ptr_offset v_g_tbls (((8 * (4)) * (0)) + (((8 * (v_indvars_iv_next)) + (0))))) in
            when st == ((store_RData 8 v_arrayidx9 (ptr_to_int v_call7) st));
            let v_cmp13 := (ptr_eqb v_call7 (mkPtr "null" 0)) in
            when __return__, st == (
                if v_cmp13
                then (
                  let v_2 := v_indvars_iv in
                  let v_last_level_0 := v_2 in
                  let v_conv20 := v_last_level_0 in
                  let v_last_level21 := (ptr_offset v_wi ((24 * (0)) + ((16 + (0))))) in
                  when st == ((store_RData 8 v_last_level21 v_conv20 st));
                  rely (((0 <= (v_conv20)) /\ ((v_conv20 < (4)))));
                  let v_arrayidx23 := (ptr_offset v_g_tbls (((8 * (4)) * (0)) + (((8 * (v_conv20)) + (0))))) in
                  when v_4_tmp, st == ((load_RData 8 v_arrayidx23 st));
                  let v_4 := (int_to_ptr v_4_tmp) in
                  let v_g_llt := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in
                  when st == ((store_RData 8 v_g_llt (ptr_to_int v_4) st));
                  when v_call25, st == ((s2_addr_to_idx_spec v_map_addr v_conv20 st));
                  let v_index := (ptr_offset v_wi ((24 * (0)) + ((8 + (0))))) in
                  when st == ((store_RData 8 v_index v_call25 st));
                  let __return__ := true in
                  (Some (__return__, st)))
                else (Some (__return__, st)));
            if __return__
            then (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
            else (
              when v_3_tmp, st == ((load_RData 8 v_arrayidx5 st));
              let v_3 := (int_to_ptr v_3_tmp) in
              when st == ((granule_unlock_spec v_3 st));
              let v_cmp2 := (v_indvars_iv_next <? (v_level)) in
              match (
                let __continue__ := false in
                if v_cmp2
                then (
                  let v_indvars_iv := v_indvars_iv_next in
                  let __continue__ := true in
                  (Some (__break__, __continue__, v_indvars_iv, st)))
                else (
                  let __break__ := true in
                  (Some (__break__, __continue__, v_indvars_iv, st)))
              ) with
              | (Some (__break__, __continue__, v_indvars_iv, st)) =>
                if __break__
                then (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
                else (
                  if __continue__
                  then (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
                  else (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st)))
              | None => None
              end)))
      | None => None
      end
    end.

  Definition rtt_walk_lock_unlock_1_low (v_g_tbls: Ptr) (v_g_root_addr_0: Ptr) (v_start_level: Z) (v_ipa_bits: Z) (v_map_addr: Z) (v_level: Z) (v_wi: Ptr) (init_st: RData) (st: RData) : (option RData) :=
    rely (v_g_tbls.(pbase) = "rtt_walk_lock_unlock_stack");
    rely (v_g_root_addr_0.(pbase) = "granules");
    rely (
      ((((((((((((v_wi.(pbase)) = ("smc_rtt_create_stack")) \/ (((v_wi.(pbase)) = ("smc_rtt_fold_stack")))) \/ (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("map_unmap_ns_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_read_entry_stack")))) \/
        (((v_wi.(pbase)) = ("data_create_stack")))) \/
        (((v_wi.(pbase)) = ("smc_data_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_init_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_to_pa_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_get_ripas_stack")))));
    let v_idxprom := v_start_level in
    rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (4)))));
    let v_arrayidx := (ptr_offset v_g_tbls (((8 * (4)) * (0)) + (((8 * (v_idxprom)) + (0))))) in
    when st == ((store_RData 8 v_arrayidx (ptr_to_int v_g_root_addr_0) st));
    let v_conv122 := v_start_level in
    let v_cmp223 := (v_conv122 <? (v_level)) in
    when __return__, st == (
        let __return__ := false in
        if v_cmp223
        then (
          let v_indvars_iv := v_conv122 in
          rely (((rtt_walk_lock_unlock_loop370_rank v_g_tbls v_indvars_iv v_level v_map_addr v_wi) >= (0)));
          match (
            (rtt_walk_lock_unlock_loop370_low
              (z_to_nat (rtt_walk_lock_unlock_loop370_rank v_g_tbls v_indvars_iv v_level v_map_addr v_wi))
              false
              false
              v_g_tbls
              v_indvars_iv
              v_level
              v_map_addr
              v_wi
              st)
          ) with
          | (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st)) =>
            if __return__
            then (Some (__return__, st))
            else (Some (__return__, st))
          | None => None
          end)
        else (Some (__return__, st)));
    rtt_walk_lock_unlock_2_low __return__ v_g_tbls v_map_addr v_level v_wi init_st st.

  Definition rtt_walk_lock_unlock_spec_low (v_g_root: Ptr) (v_start_level: Z) (v_ipa_bits: Z) (v_map_addr: Z) (v_level: Z) (v_wi: Ptr) (st: RData) : (option RData) :=
    when st == ((new_frame "rtt_walk_lock_unlock" st));
    let init_st := st in
    rely (
      ((((((((((((v_wi.(pbase)) = ("smc_rtt_create_stack")) \/ (((v_wi.(pbase)) = ("smc_rtt_fold_stack")))) \/ (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("map_unmap_ns_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_read_entry_stack")))) \/
        (((v_wi.(pbase)) = ("data_create_stack")))) \/
        (((v_wi.(pbase)) = ("smc_data_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_init_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_to_pa_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_get_ripas_stack")))));
    rely (((v_g_root.(pbase)) = ("granules")));
    when v_g_tbls, st == ((alloc_stack "rtt_walk_lock_unlock" 32 8 st));
    let v_0 := v_g_tbls in
    when st == ((llvm_memset_p0i8_i64_spec v_0 0 32 false st));
    when v_call, st == ((s2_sl_addr_to_idx_spec v_map_addr v_start_level v_ipa_bits st));
    let v_cmp := (v_call >? (511)) in
    when v_g_root_addr_0, st == (
        let v_g_root_addr_0 := (mkPtr "#" 0) in
        if v_cmp
        then (
          let v_shr := (v_call >> (9)) in
          let v_idx_ext := (v_shr & (4294967295)) in
          let v_add_ptr := (ptr_offset v_g_root ((16 * (v_idx_ext)) + (0))) in
          when st == ((granule_lock_spec v_add_ptr 6 st));
          when st == ((granule_unlock_spec v_g_root st));
          let v_g_root_addr_0 := v_add_ptr in
          (Some (v_g_root_addr_0, st)))
        else (
          let v_g_root_addr_0 := v_g_root in
          (Some (v_g_root_addr_0, st))));
    rtt_walk_lock_unlock_1_low v_g_tbls v_g_root_addr_0 v_start_level v_ipa_bits v_map_addr v_level v_wi init_st st.
