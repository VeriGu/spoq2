Parameter advance_pc_spec_state_oracle : RData -> (option RData).

Parameter sve_config_vq_spec_state_oracle : RData -> (option RData).

Definition my_cpuid_spec (st: RData) : (option (Z * RData)) :=
  (Some (CPU_ID, st)).

Definition status_ptr_spec' (v_status: Z) (st: RData) : (option Ptr) :=
  rely (((v_status >= (0)) /\ ((GRANULES_BASE > (0)))));
  if ((0 - (v_status)) <? (0))
  then (Some (mkPtr "status" v_status))
  else (Some (mkPtr "null" 0)).

Definition status_ptr_spec (v_status: Z) (st: RData) : (option (Ptr * RData)) :=
  when ret == ((status_ptr_spec' v_status st));
  (Some (ret, st)).

Definition __granule_refcount_dec_spec (v_g: Ptr) (v_val: Z) (st: RData) : (option RData) :=
  rely (
    ((((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RTT)) = (0)) /\
      ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))))) /\
      ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)) = ((Some CPU_ID))))));
  when v_0, st_0 == ((load_store_oracle st));
  when _v, st_2 == ((load_store_oracle st_0));
  (Some (st_2.[share].[granules] :<
    (((st_2.(share)).(granules)) #
      (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) ==
      ((((st_2.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :< (v_0 - (512)))))).

Definition __granule_put_spec (v_g: Ptr) (st: RData) : (option RData) :=
  rely (
    ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))) /\
      ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)) = ((Some CPU_ID))))));
  if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RTT)) <>? (0))
  then None
  else (
    when v_0, st_0 == ((load_store_oracle st));
    when _v, st_2 == ((load_store_oracle st_0));
    (Some (st_2.[share].[granules] :<
      (((st_2.(share)).(granules)) #
        (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) ==
        ((((st_2.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :< (v_0 + ((- 1)))))))).

Definition __granule_get_spec (v_g: Ptr) (st: RData) : (option RData) :=
  rely (
    ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))) /\
      ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)) = ((Some CPU_ID))))));
  if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RTT)) <>? (0))
  then None
  else (
    when v_0, st_0 == ((load_store_oracle st));
    when _v, st_2 == ((load_store_oracle st_0));
    (Some (st_2.[share].[granules] :<
      (((st_2.(share)).(granules)) #
        (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) ==
        ((((st_2.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :< (v_0 + (1))))))).

Definition pack_return_code_spec (v_status: Z) (v_index: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((((((v_index << (32)) + (v_status)) >> (24)) & (4294967040)) |' ((((v_index << (32)) + (v_status)) & (4294967295)))), st)).

Definition realm_rtt_starting_level_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  when v_0, st_0 == ((load_store_oracle st));
  (Some (v_0, st_0)).

Definition realm_ipa_bits_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  when v_0, st_0 == ((load_store_oracle st));
  (Some (v_0, st_0)).

Definition s2_addr_to_idx_spec (v_addr: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_addr >> (((39 + ((38654705655 * (v_level)))) & (4294967295)))) & (511)), st)).

Definition s2_sl_addr_to_idx_spec (v_addr: Z) (v_start_level: Z) (v_ipa_bits: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_addr)) >> ((39 + (((- 9) * (v_start_level)))))), st)).

Definition entry_is_table_spec (v_entry1: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_entry1 & (3)) =? (3)), st)).

Definition __tte_read_spec (v_ttep: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_ttep.(pbase)) = ("slot_rtt")) \/ (((v_ttep.(pbase)) = ("slot_rtt2")))));
  if ((v_ttep.(pbase)) =s ("slot_rtt"))
  then (
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
    when v_call, st_0 == ((load_store_oracle st));
    (Some (v_call, st_0)))
  else (
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
    when v_call, st_0 == ((load_store_oracle st));
    (Some (v_call, st_0))).

Definition __tte_write_spec (v_ttep: Ptr) (v_tte: Z) (st: RData) : (option RData) :=
  rely ((((v_ttep.(pbase)) = ("slot_rtt")) \/ (((v_ttep.(pbase)) = ("slot_rtt2")))));
  if ((v_ttep.(pbase)) =s ("slot_rtt"))
  then (
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
    when _v, st_1 == ((load_store_oracle st));
    (Some st_1))
  else (
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
    when _v, st_1 == ((load_store_oracle st));
    (Some st_1)).

Definition __granule_refcount_inc_spec (v_g: Ptr) (v_val: Z) (st: RData) : (option RData) :=
  rely (
    ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))) /\
      ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)) = ((Some CPU_ID))))));
  if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RTT)) <>? (0))
  then None
  else (
    when v_0, st_0 == ((load_store_oracle st));
    when _v, st_2 == ((load_store_oracle st_0));
    (Some (st_2.[share].[granules] :<
      (((st_2.(share)).(granules)) #
        (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) ==
        ((((st_2.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :< (v_0 + (512))))))).

Definition mpidr_is_valid_spec (v_mpidr: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_mpidr & (18446742978476114160)) =? (0)), st)).

Definition ptr_status_spec' (v_ptr: Ptr) (st: RData) : (option Z) :=
  rely ((((v_ptr.(pbase)) = ("status")) \/ (((v_ptr.(pbase)) = ("null")))));
  match (((v_ptr.(pbase)), (v_ptr.(poffset)))) with
  | ("status", ofs) =>
    if (ofs <? (0))
    then (Some ofs)
    else (Some 0)
  | ("null", ofs) => (Some 0)
  | _ => (Some 1)
  end.

Definition ptr_status_spec (v_ptr: Ptr) (st: RData) : (option (Z * RData)) :=
  when ret == ((ptr_status_spec' v_ptr st));
  (Some (ret, st)).

Definition ptr_is_err_spec' (v_ptr: Ptr) (st: RData) : (option bool) :=
  rely ((((v_ptr.(pbase)) = ("status")) \/ (((v_ptr.(pbase)) = ("null")))));
  match (((v_ptr.(pbase)), (v_ptr.(poffset)))) with
  | ("status", ofs) =>
    if (ofs <? (0))
    then (Some (((- ofs) - (18446744073709547520)) >? (0)))
    else (Some false)
  | ("null", ofs) => (Some false)
  | _ => (Some false)
  end.

Definition ptr_is_err_spec (v_ptr: Ptr) (st: RData) : (option (bool * RData)) :=
  when ret == ((ptr_is_err_spec' v_ptr st));
  (Some (ret, st)).

Definition s2_inconsistent_sl_spec (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((((40 + (((- 9) * (v_sl)))) - (v_ipa_bits)) >? (0)) || ((((52 + (((- 9) * (v_sl)))) - (v_ipa_bits)) <? (0)))), st)).

Definition s2_num_root_rtts_spec' (v_ipa_bits: Z) (v_sl: Z) (st: RData) : Z :=
  if (((48 + (((- 9) * (v_sl)))) - (v_ipa_bits)) <? (0))
  then (1 << ((v_ipa_bits - ((48 + (((- 9) * (v_sl))))))))
  else 1.

Definition s2_num_root_rtts_spec (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (Z * RData)) :=
  let ret := (s2_num_root_rtts_spec' v_ipa_bits v_sl st) in
  (Some (ret, st)).

Definition requested_ipa_bits_spec (v_p: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (((v_p.(pbase)) = ("stack")));
  when v_0, st_0 == ((load_store_oracle st));
  (Some ((v_0 & (255)), st_0)).

Definition addr_is_contained_spec (v_container_base: Z) (v_container_end: Z) (v_address: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((((v_address - (v_container_base)) >=? (0)) && ((((v_container_end + ((- 1))) - (v_address)) >=? (0)))), st)).

Definition psci_reset_rec_spec (v_rec: Ptr) (v_caller_sctlr_el1: Z) (st: RData) : (option RData) :=
  rely (
    ((((v_rec.(pbase)) = ("slot_rec2")) /\ (((v_rec.(poffset)) = (0)))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
      end)));
  when _v, st_1 == ((load_store_oracle st));
  when _v_0, st_2 == ((load_store_oracle st_1));
  (Some st_2).

Definition advance_pc_spec_shadow (st: RData) : (option RData) :=
  (Some (st.[priv].[pcpu_regs].[pcpu_elr_el2] :< ((((st.(priv)).(pcpu_regs)).(pcpu_elr_el2)) + (4)))).

Definition advance_pc_spec (st: RData) : (option RData) :=
  when st' == ((advance_pc_spec_state_oracle st));
  (Some st').

Definition calc_vector_entry_spec' (v_vbar: Z) (v_spsr: Z) (st: RData) : Z :=
  if ((v_spsr & (15)) =? (5))
  then (512 + (v_vbar))
  else (
    if ((v_spsr & (15)) =? (4))
    then v_vbar
    else (
      if ((v_spsr & (15)) =? (0))
      then (
        if ((v_spsr & (16)) =? (0))
        then (1024 + (v_vbar))
        else (1536 + (v_vbar)))
      else v_vbar)).

Definition calc_vector_entry_spec (v_vbar: Z) (v_spsr: Z) (st: RData) : (option (Z * RData)) :=
  let ret := (calc_vector_entry_spec' v_vbar v_spsr st) in
  (Some (ret, st)).

Definition rec_is_simd_allowed_spec (v_rec: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (
    (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)))) /\
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when v_0, st_0 == ((load_store_oracle st));
  (Some (((v_0 & (1)) <>? (0)), st_0)).

Definition rec_simd_type_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)))) /\
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when v_0, st_0 == ((load_store_oracle st));
  if ((v_0 & (1)) =? (0))
  then (Some (1, st_0))
  else (Some (2, st_0)).

Definition esr_is_write_spec (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_esr & (64)) <>? (0)), st)).

Definition rec_ipa_size_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end)));
  when v_0, st_0 == ((load_store_oracle st));
  (Some ((1 << (v_0)), st_0)).

Definition esr_sas_spec (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_esr >> (22)) & (3)), st)).

Definition esr_srt_spec (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_esr >> (16)) & (31)), st)).

Definition fsc_is_external_abort_spec' (v_fsc: Z) (st: RData) : bool :=
  if (v_fsc =? (16))
  then true
  else (
    if ((v_fsc + ((- 19))) <? (5))
    then true
    else false).

Definition fsc_is_external_abort_spec (v_fsc: Z) (st: RData) : (option (bool * RData)) :=
  let ret := (fsc_is_external_abort_spec' v_fsc st) in
  (Some (ret, st)).

Definition calc_esr_idabort_spec' (v_esr_el2: Z) (v_spsr_el2: Z) (v_fsc: Z) (st: RData) : Z :=
  if ((v_spsr_el2 & (15)) =? (0))
  then ((((v_esr_el2 & (18446744069481691456)) |' (512)) |' (v_fsc)) |' ((v_esr_el2 & (4227858432))))
  else ((((v_esr_el2 & (18446744069481691456)) |' (512)) |' (v_fsc)) |' (((v_esr_el2 & (4227858432)) + (67108864)))).

Definition calc_esr_idabort_spec (v_esr_el2: Z) (v_spsr_el2: Z) (v_fsc: Z) (st: RData) : (option (Z * RData)) :=
  let ret := (calc_esr_idabort_spec' v_esr_el2 v_spsr_el2 v_fsc st) in
  (Some (ret, st)).

Definition get_sysreg_write_value_spec (v_rec: Ptr) (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  if (((v_esr >> (5)) & (31)) =? (31))
  then (Some (0, st))
  else (
    rely (
      ((((0 - (((v_esr >> (5)) & (31)))) <= (0)) /\ ((((v_esr >> (5)) & (31)) < (31)))) /\
        (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
        | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
        | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
        end)));
    when v_2, st_0 == ((load_store_oracle st));
    (Some (v_2, st_0))).

Definition is_valid_vintid_spec (v_intid: Z) (st: RData) : (option (bool * RData)) :=
  if (v_intid <? (1020))
  then (Some (true, st))
  else (
    if (v_intid >? (8191))
    then (
      when v_0, st_0 == ((load_store_oracle st));
      if ((v_0 - (v_intid)) <? (0))
      then (
        when v_1, st_2 == ((load_store_oracle st_0));
        if ((v_1 & (1)) =? (0))
        then (Some (false, st_2))
        else (Some (((v_intid & (18446744073709550592)) =? (4096)), st_2)))
      else (Some (true, st_0)))
    else (
      when v_1, st_1 == ((load_store_oracle st));
      if ((v_1 & (1)) =? (0))
      then (Some (false, st_1))
      else (Some (((v_intid & (18446744073709550592)) =? (4096)), st_1)))).

Definition esr_sign_extend_spec (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_esr & (2097152)) <>? (0)), st)).

Definition esr_sixty_four_spec (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_esr & (32768)) <>? (0)), st)).

Definition is_el2_data_abort_gpf_spec' (v_esr: Z) (st: RData) : bool :=
  if ((v_esr & (4227858432)) =? (2483027968))
  then (
    if ((v_esr & (63)) =? (40))
    then true
    else false)
  else false.

Definition is_el2_data_abort_gpf_spec (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  let ret := (is_el2_data_abort_gpf_spec' v_esr st) in
  (Some (ret, st)).

Definition sve_config_vq_spec_shadow (v_vq: Z) (st: RData) : (option RData) :=
  if ((((((st.(priv)).(pcpu_regs)).(pcpu_zcr_el2)) & (15)) - (v_vq)) =? (0))
  then (Some st)
  else (Some (st.[priv].[pcpu_regs].[pcpu_zcr_el2] :< (((((st.(priv)).(pcpu_regs)).(pcpu_zcr_el2)) & ((-16))) |' (v_vq)))).

Definition sve_config_vq_spec (v_vq: Z) (st: RData) : (option RData) :=
  when st' == ((sve_config_vq_spec_state_oracle st));
  (Some st').

