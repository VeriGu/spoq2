Definition s2tt_init_valid_ns_loop738_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
  (512 - (v_indvars_iv)).

Definition s2tt_init_valid_loop719_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
  (512 - (v_indvars_iv)).

Definition s2tt_init_assigned_empty_loop700_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
  (512 - (v_indvars_iv)).

Definition s2tt_init_destroyed_loop0_rank (v_index: Z) (v_s2tt: Ptr) : Z :=
  (256 - (v_index/2)).

Definition s2tt_init_unassigned_loop0_rank (v_call: Z) (v_index: Z) (v_s2tt: Ptr) : Z :=
  (256 - (v_index/2)).

Fixpoint s2tt_init_valid_ns_loop738 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_valid_ns_loop738 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
      rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
      when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
      if ((v_indvars_iv_0 + (1)) <>? (512))
      then (Some (__return___0, v_call_0, (v_indvars_iv_0 + (1)), v_level_0, (v_pa_addr_6 + (v_call_0)), v_s2tt_0, st_0))
      else (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
    | None => None
    end
  end.

Definition s2tt_init_valid_ns_spec (v_s2tt: Ptr) (v_pa: Z) (v_level: Z) (st: RData) : (option RData) :=
  rely (((v_s2tt.(pbase)) = ("slot_delegated")));
  match ((s2tt_init_valid_ns_loop738 (z_to_nat 512) false (1 << ((39 + (((- 9) * (v_level)))))) 0 v_level v_pa v_s2tt st)) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) => (Some st_1)
  | None => None
  end.

Fixpoint s2tt_init_valid_loop719 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_valid_loop719 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
      rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
      when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
      if ((v_indvars_iv_0 + (1)) <>? (512))
      then (Some (__return___0, v_call_0, (v_indvars_iv_0 + (1)), v_level_0, (v_pa_addr_6 + (v_call_0)), v_s2tt_0, st_0))
      else (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
    | None => None
    end
  end.

Definition s2tt_init_valid_spec (v_s2tt: Ptr) (v_pa: Z) (v_level: Z) (st: RData) : (option RData) :=
  rely (((v_s2tt.(pbase)) = ("slot_delegated")));
  match ((s2tt_init_valid_loop719 (z_to_nat 512) false (1 << ((39 + (((- 9) * (v_level)))))) 0 v_level v_pa v_s2tt st)) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) => (Some st_1)
  | None => None
  end.

Fixpoint s2tt_init_assigned_empty_loop700 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_assigned_empty_loop700 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
      rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
      when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
      if ((v_indvars_iv_0 + (1)) <>? (512))
      then (Some (__return___0, v_call_0, (v_indvars_iv_0 + (1)), v_level_0, (v_pa_addr_6 + (v_call_0)), v_s2tt_0, st_0))
      else (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
    | None => None
    end
  end.

Definition s2tt_init_assigned_empty_spec (v_s2tt: Ptr) (v_pa: Z) (v_level: Z) (st: RData) : (option RData) :=
  rely (((v_s2tt.(pbase)) = ("slot_delegated")));
  match ((s2tt_init_assigned_empty_loop700 (z_to_nat 512) false (1 << ((39 + (((- 9) * (v_level)))))) 0 v_level v_pa v_s2tt st)) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) => (Some st_1)
  | None => None
  end.

Fixpoint s2tt_init_destroyed_loop0 (_N_: nat) (__return__: bool) (v_index: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_index, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_destroyed_loop0 _N__0 __return__ v_index v_s2tt st)) with
    | (Some (__return___0, v_index_0, v_s2tt_0, st_0)) =>
      rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
      when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
      if ((v_index_0 + (2)) =? (512))
      then (Some (true, v_index_0, v_s2tt_0, st_0))
      else (Some (__return___0, (v_index_0 + (2)), v_s2tt_0, st_0))
    | None => None
    end
  end.

Definition s2tt_init_destroyed_spec (v_s2tt: Ptr) (st: RData) : (option RData) :=
  rely (((v_s2tt.(pbase)) = ("slot_delegated")));
  match ((s2tt_init_destroyed_loop0 (z_to_nat 512) false 0 v_s2tt st)) with
  | (Some (__return__, v_index_0, v_s2tt_0, st_0)) => (Some st_0)
  | None => None
  end.

Fixpoint s2tt_init_unassigned_loop0 (_N_: nat) (__return__: bool) (v_call: Z) (v_index: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_index, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_unassigned_loop0 _N__0 __return__ v_call v_index v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_index_0, v_s2tt_0, st_0)) =>
      rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
      when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
      if ((v_index_0 + (2)) =? (512))
      then (Some (true, v_call_0, v_index_0, v_s2tt_0, st_0))
      else (Some (__return___0, v_call_0, (v_index_0 + (2)), v_s2tt_0, st_0))
    | None => None
    end
  end.

Definition s2tt_init_unassigned_spec (v_s2tt: Ptr) (v_ripas: Z) (st: RData) : (option RData) :=
  rely (((v_s2tt.(pbase)) = ("slot_delegated")));
  match ((s2tt_init_unassigned_loop0 (z_to_nat 512) false (s2tte_create_ripas_spec' v_ripas st) 0 v_s2tt st)) with
  | (Some (__return__, v_call_0, v_index_0, v_s2tt_0, st_1)) => (Some st_1)
  | None => None
  end.

Definition realm_ipa_get_ripas_spec (v_rec: Ptr) (v_ipa: Z) (v_ripas_ptr: Ptr) (v_rtt_level: Ptr) (st: RData) : (option (Z * RData)) :=
  when st == ((new_frame "realm_ipa_get_ripas" st));
  let init_st := st in
  rely (
    (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_ripas_ptr.(pbase)) = ("handle_rsi_ipa_state_get_stack")))) /\
      (((v_rtt_level.(pbase)) = ("handle_rsi_ipa_state_get_stack")))));
  when v_wi, st == ((alloc_stack "realm_ipa_get_ripas" 24 8 st));
  let v_g_rtt := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((16 + (0))))))) in
  when v_0_tmp, st == ((load_RData 8 v_g_rtt st));
  let v_0 := (int_to_ptr v_0_tmp) in
  when st == ((granule_lock_spec v_0 6 st));
  when v_1_tmp, st == ((load_RData 8 v_g_rtt st));
  let v_1 := (int_to_ptr v_1_tmp) in
  let v_s2_starting_level := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((8 + (0))))))) in
  when v_2, st == ((load_RData 4 v_s2_starting_level st));
  let v_ipa_bits := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((0 + (0))))))) in
  when v_3, st == ((load_RData 8 v_ipa_bits st));
  when st == ((rtt_walk_lock_unlock_spec v_1 v_2 v_3 v_ipa 3 v_wi st));
  let v_g_llt := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in
  when v_4_tmp, st == ((load_RData 8 v_g_llt st));
  let v_4 := (int_to_ptr v_4_tmp) in
  when v_call, st == ((granule_map_spec v_4 22 st));
  let v_5 := v_call in
  let v_index := (ptr_offset v_wi ((24 * (0)) + ((8 + (0))))) in
  when v_6, st == ((load_RData 8 v_index st));
  let v_arrayidx := (ptr_offset v_5 ((8 * (v_6)) + (0))) in
  when v_call5, st == ((__tte_read_spec v_arrayidx st));
  when v_call6, st == ((s2tte_is_destroyed_spec v_call5 st));
  when v_ws_0, st == (
      let v_ws_0 := 0 in
      if v_call6
      then (
        let v_last_level := (ptr_offset v_wi ((24 * (0)) + ((16 + (0))))) in
        when v_7, st == ((load_RData 8 v_last_level st));
        when st == ((store_RData 8 v_rtt_level v_7 st));
        let v_ws_0 := 2 in
        (Some (v_ws_0, st)))
      else (
        when v_call7, st == ((s2tte_get_ripas_spec v_call5 st));
        when st == ((store_RData 4 v_ripas_ptr v_call7 st));
        let v_ws_0 := 0 in
        (Some (v_ws_0, st))));
  when st == ((buffer_unmap_spec v_call st));
  when v_8_tmp, st == ((load_RData 8 v_g_llt st));
  let v_8 := (int_to_ptr v_8_tmp) in
  when st == ((granule_unlock_spec v_8 st));
  let __return__ := true in
  let __retval__ := v_ws_0 in
  when st == ((free_stack "realm_ipa_get_ripas" init_st st));
  (Some (__retval__, st)).

Definition realm_ipa_to_pa_spec (v_rd: Ptr) (v_ipa: Z) (v_s2_walk: Ptr) (st: RData) : (option (Z * RData)) :=
  when st == ((new_frame "realm_ipa_to_pa" st));
  let init_st := st in
  rely (
    (((v_rd.(pbase)) = ("slot_rd")) /\
      (((((v_s2_walk.(pbase)) = ("rsi_walk_smc_result_stack")) \/ (((v_s2_walk.(pbase)) = ("do_host_call_stack")))) \/
        (((v_s2_walk.(pbase)) = ("attest_token_continue_write_state_stack")))))));
  when v_wi, st == ((alloc_stack "realm_ipa_to_pa" 24 8 st));
  let v_rem := (v_ipa & (4095)) in
  let v_cmp := (v_rem =? (0)) in
  match (
    let __retval__ := 0 in
    let __return__ := false in
    if v_cmp
    then (
      when v_call, st == ((addr_in_par_spec v_rd v_ipa st));
      match (
        let __retval__ := 0 in
        let __return__ := false in
        if v_call
        then (
          let v_g_rtt := (ptr_offset v_rd ((456 * (0)) + ((16 + ((16 + (0))))))) in
          when v_0_tmp, st == ((load_RData 8 v_g_rtt st));
          let v_0 := (int_to_ptr v_0_tmp) in
          when st == ((granule_lock_spec v_0 6 st));
          when v_call1, st == ((realm_rtt_starting_level_spec v_rd st));
          when v_call2, st == ((realm_ipa_bits_spec v_rd st));
          when st == ((rtt_walk_lock_unlock_spec v_0 v_call1 v_call2 v_ipa 3 v_wi st));
          let v_g_llt := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in
          when v_1_tmp, st == ((load_RData 8 v_g_llt st));
          let v_1 := (int_to_ptr v_1_tmp) in
          when v_call3, st == ((granule_map_spec v_1 22 st));
          let v_2 := v_call3 in
          when v_3_tmp, st == ((load_RData 8 v_g_llt st));
          let v_3 := (int_to_ptr v_3_tmp) in
          let v_llt := (ptr_offset v_s2_walk ((32 * (0)) + ((24 + (0))))) in
          when st == ((store_RData 8 v_llt (ptr_to_int v_3) st));
          let v_index := (ptr_offset v_wi ((24 * (0)) + ((8 + (0))))) in
          when v_4, st == ((load_RData 8 v_index st));
          let v_arrayidx := (ptr_offset v_2 ((8 * (v_4)) + (0))) in
          when v_call5, st == ((__tte_read_spec v_arrayidx st));
          let v_last_level := (ptr_offset v_wi ((24 * (0)) + ((16 + (0))))) in
          when v_5, st == ((load_RData 8 v_last_level st));
          when v_call6, st == ((s2tte_is_valid_spec v_call5 v_5 st));
          when v_walk_status_0, st == (
              let v_walk_status_0 := 0 in
              if v_call6
              then (
                when v_8, st == ((load_RData 8 v_last_level st));
                when v_call16, st == ((s2tte_pa_spec v_call5 v_8 st));
                let v_pa := (ptr_offset v_s2_walk ((32 * (0)) + ((0 + (0))))) in
                when st == ((store_RData 8 v_pa v_call16 st));
                when v_9, st == ((load_RData 8 v_last_level st));
                let v_conv := v_9 in
                when v_call18, st == ((s2tte_map_size_spec v_conv st));
                let v_sub := (v_call18 + ((- 1))) in
                let v_and := (v_sub & (v_ipa)) in
                when v_10, st == ((load_RData 8 v_pa st));
                let v_add := (v_and + (v_10)) in
                when st == ((store_RData 8 v_pa v_add st));
                let v_ripas20 := (ptr_offset v_s2_walk ((32 * (0)) + ((16 + (0))))) in
                when st == ((store_RData 4 v_ripas20 1 st));
                let v_walk_status_0 := 0 in
                (Some (v_walk_status_0, st)))
              else (
                when v_6, st == ((load_RData 8 v_last_level st));
                let v_rtt_level := (ptr_offset v_s2_walk ((32 * (0)) + ((8 + (0))))) in
                when st == ((store_RData 8 v_rtt_level v_6 st));
                when v_call9, st == ((s2tte_is_destroyed_spec v_call5 st));
                when st == (
                    if v_call9
                    then (
                      let v_destroyed := (ptr_offset v_s2_walk ((32 * (0)) + ((20 + (0))))) in
                      when st == ((store_RData 1 v_destroyed 1 st));
                      (Some st))
                    else (
                      when v_call11, st == ((s2tte_get_ripas_spec v_call5 st));
                      let v_ripas := (ptr_offset v_s2_walk ((32 * (0)) + ((16 + (0))))) in
                      when st == ((store_RData 4 v_ripas v_call11 st));
                      (Some st)));
                when v_7_tmp, st == ((load_RData 8 v_g_llt st));
                let v_7 := (int_to_ptr v_7_tmp) in
                when st == ((granule_unlock_spec v_7 st));
                let v_walk_status_0 := 2 in
                (Some (v_walk_status_0, st))));
          when st == ((buffer_unmap_spec v_call3 st));
          let v_retval_0 := v_walk_status_0 in
          let __return__ := true in
          let __retval__ := v_retval_0 in
          (Some (__return__, __retval__, st)))
        else (Some (__return__, __retval__, st))
      ) with
      | (Some (__return__, __retval__, st)) =>
        if __return__
        then (Some (__return__, __retval__, st))
        else (Some (__return__, __retval__, st))
      | None => None
      end)
    else (Some (__return__, __retval__, st))
  ) with
  | (Some (__return__, __retval__, st)) =>
    if __return__
    then (
      when st == ((free_stack "realm_ipa_to_pa" init_st st));
      (Some (__retval__, st)))
    else (
      let v_retval_0 := 1 in
      let __return__ := true in
      let __retval__ := v_retval_0 in
      when st == ((free_stack "realm_ipa_to_pa" init_st st));
      (Some (__retval__, st)))
  | None => None
  end.

