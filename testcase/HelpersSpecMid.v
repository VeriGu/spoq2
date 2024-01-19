Definition my_cpuid_spec_mid (st: RData) : (option (Z * RData)) :=
  (Some (CPU_ID, st)).

Definition status_ptr_spec_mid (v_status: Z) (st: RData) : (option (Ptr * RData)) :=
  rely (((v_status >= (0)) /\ ((GRANULES_BASE > (0)))));
  if ((0 - (v_status)) <? (0))
  then (
    (anno (((- (0 - (v_status))) = (v_status)));
    (Some ((mkPtr "status" v_status), st))))
  else (Some ((mkPtr "null" 0), st)).

Definition __granule_refcount_dec_spec_mid (v_g: Ptr) (v_val: Z) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then (true = (true))
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if (((v_g.(poffset)) + (8)) =? (8))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
        (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
        (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
        (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
        match (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))))))))))
    else (false = (true)));
  (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  when cid == (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock)));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) - (512)) <? (0))
  then None
  else (
    (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
    (anno ((((v_g.(poffset)) + (8)) = (8)));
    (anno (((8 mod (ST_GRANULE_SIZE)) = (8)));
    (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
    (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
    (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
    if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_REC)) =? (0))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some ((st.[log] :< ((EVT CPU_ID (REC_REF (v_g.(poffset)) (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) - (512)))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) - (512)))))))))))
    else (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) - (512))))))))))))))))))))))))))))))).

Definition __granule_put_spec_mid (v_g: Ptr) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then (true = (true))
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if (((v_g.(poffset)) + (8)) =? (8))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
        (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
        (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
        (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
        match (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))))))))))
    else (false = (true)));
  (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  when cid == (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock)));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))) <? (0))
  then None
  else (
    (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
    (anno ((((v_g.(poffset)) + (8)) = (8)));
    (anno (((8 mod (ST_GRANULE_SIZE)) = (8)));
    (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
    (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
    (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
    if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_REC)) =? (0))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some ((st.[log] :< ((EVT CPU_ID (REC_REF (v_g.(poffset)) (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))))))))))
    else (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1)))))))))))))))))))))))))))))))).

Definition __granule_get_spec_mid (v_g: Ptr) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then (true = (true))
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if (((v_g.(poffset)) + (8)) =? (8))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
        (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
        (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
        (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
        match (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))))))))))
    else (false = (true)));
  (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  when cid == (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock)));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)) <? (0))
  then None
  else (
    (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
    (anno ((((v_g.(poffset)) + (8)) = (8)));
    (anno (((8 mod (ST_GRANULE_SIZE)) = (8)));
    (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
    (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
    (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
    if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_REC)) =? (0))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some ((st.[log] :< ((EVT CPU_ID (REC_REF (v_g.(poffset)) (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)))))))))))
    else (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1))))))))))))))))))))))))))))))).

Definition pack_return_code_spec_mid (v_status: Z) (v_index: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((((((v_index << (32)) + (v_status)) >> (24)) & (4294967040)) |' ((((v_index << (32)) + (v_status)) & (4294967295)))), st)).

Definition realm_rtt_starting_level_spec_mid (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  (anno (((456 * (0)) = (0)));
  (anno (((4 + (0)) = (4)));
  (anno (((16 + (4)) = (20)));
  (anno (((0 + (20)) = (20)));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) => (Some (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)), st))
  | _ => None
  end)))).

Definition realm_ipa_bits_spec_mid (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  (anno (((456 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno (((16 + (0)) = (16)));
  (anno (((0 + (16)) = (16)));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) => (Some (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)), st))
  | _ => None
  end)))).

Definition s2_addr_to_idx_spec_mid (v_addr: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (anno (
    (((((12884901888 * (((v_level * (1431655765)) + (1)))) >> (32)) * (9)) + (12)) =
      ((3 * (((((12884901888 * (((v_level * (1431655765)) + (1)))) >> (32)) * (3)) + (4)))))));
  (anno ((((v_level * (18446744069414584320)) + (12884901888)) = ((12884901888 * (((v_level * (1431655765)) + (1)))))));
  (anno (((12884901888 * (((v_level * (1431655765)) + (1)))) = ((12884901888 + ((18446744069414584320 * (v_level)))))));
  (anno ((((12884901888 + ((18446744069414584320 * (v_level)))) >> (32)) = ((3 + ((4294967295 * (v_level)))))));
  (anno ((((3 + ((4294967295 * (v_level)))) * (3)) = ((9 + ((12884901885 * (v_level)))))));
  (anno ((((9 + ((12884901885 * (v_level)))) + (4)) = ((13 + ((12884901885 * (v_level)))))));
  (anno (((39 + ((38654705655 * (v_level)))) = ((3 * ((13 + ((12884901885 * (v_level)))))))));
  (anno (((3 * ((13 + ((12884901885 * (v_level)))))) = ((39 + ((38654705655 * (v_level)))))));
  (Some (((v_addr >> (((39 + ((38654705655 * (v_level)))) & (4294967295)))) & (511)), st)))))))))).

Definition s2_sl_addr_to_idx_spec_mid (v_addr: Z) (v_start_level: Z) (v_ipa_bits: Z) (st: RData) : (option (Z * RData)) :=
  (anno (((((3 - (v_start_level)) * (9)) + (12)) = ((3 * ((((3 - (v_start_level)) * (3)) + (4)))))));
  (anno (((((3 - (v_start_level)) * (3)) + (4)) = ((13 + (((- 3) * (v_start_level)))))));
  (anno (((39 + (((- 9) * (v_start_level)))) = ((3 * ((13 + (((- 3) * (v_start_level)))))))));
  (anno (((3 * ((13 + (((- 3) * (v_start_level)))))) = ((39 + (((- 9) * (v_start_level)))))));
  (Some ((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_addr)) >> ((39 + (((- 9) * (v_start_level)))))), st)))))).

Definition entry_is_table_spec_mid (v_entry1: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_entry1 & (3)) =? (3)), st)).

Definition __tte_read_spec_mid (v_ttep: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_ttep.(pbase)) = ("slot_rtt")) \/ (((v_ttep.(pbase)) = ("slot_rtt2")))));
  if ((v_ttep.(pbase)) =s ("slot_rtt"))
  then (
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
    (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT)).(g_norm)) @ (v_ttep.(poffset))), st)))
  else (
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
    (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_ttep.(poffset))), st))).

Definition __tte_write_spec_mid (v_ttep: Ptr) (v_tte: Z) (st: RData) : (option RData) :=
  rely ((((v_ttep.(pbase)) = ("slot_rtt")) \/ (((v_ttep.(pbase)) = ("slot_rtt2")))));
  if ((v_ttep.(pbase)) =s ("slot_rtt"))
  then (
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
    (Some st))
  else (
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
    (Some st)).

Definition __granule_refcount_inc_spec_mid (v_g: Ptr) (v_val: Z) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then (true = (true))
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if (((v_g.(poffset)) + (8)) =? (8))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
        (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
        (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
        (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
        match (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))))))))))
    else (false = (true)));
  (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  when cid == (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock)));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (512)) <? (0))
  then None
  else (
    (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
    (anno ((((v_g.(poffset)) + (8)) = (8)));
    (anno (((8 mod (ST_GRANULE_SIZE)) = (8)));
    (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
    (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
    (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
    if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_REC)) =? (0))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some ((st.[log] :< ((EVT CPU_ID (REC_REF (v_g.(poffset)) (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (512)))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (512)))))))))))
    else (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (512))))))))))))))))))))))))))))))).

Definition mpidr_is_valid_spec_mid (v_mpidr: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_mpidr & (18446742978476114160)) =? (0)), st)).

Definition ptr_status_spec_mid (v_ptr: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_ptr.(pbase)) = ("status")) \/ (((v_ptr.(pbase)) = ("null")))));
  match (((v_ptr.(pbase)), (v_ptr.(poffset)))) with
  | ("status", ofs) =>
    if (ofs <? (0))
    then (
      (anno (((0 - ((- ofs))) = (ofs)));
      (Some (ofs, st))))
    else (
      (anno (((0 - (0)) = (0)));
      (Some (0, st))))
  | ("null", ofs) =>
    (anno (((0 - (0)) = (0)));
    (Some (0, st)))
  | _ =>
    (anno (((- 1) = ((- 1))));
    (anno (((0 - ((- 1))) = (1)));
    (Some (1, st))))
  end.

Definition ptr_is_err_spec_mid (v_ptr: Ptr) (st: RData) : (option (bool * RData)) :=
  rely ((((v_ptr.(pbase)) = ("status")) \/ (((v_ptr.(pbase)) = ("null")))));
  match (((v_ptr.(pbase)), (v_ptr.(poffset)))) with
  | ("status", ofs) =>
    if (ofs <? (0))
    then (
      (anno (((STACK_smc_rec_enter * (GRANULE_SIZE)) = (126976)));
      (anno (((SLOT_VIRT + (126976)) = (18446744073709547520)));
      (anno (((18446744073709547520 - (SLOT_VIRT)) = (126976)));
      (anno (((126976 mod (GRANULE_SIZE)) = (0)));
      (anno (((18446744073709547520 + (0)) = (18446744073709547520)));
      (Some ((((- ofs) - (18446744073709547520)) >? (0)), st))))))))
    else (
      (anno (((STACK_smc_rec_enter * (GRANULE_SIZE)) = (126976)));
      (anno (((SLOT_VIRT + (126976)) = (18446744073709547520)));
      (anno (((18446744073709547520 - (SLOT_VIRT)) = (126976)));
      (anno (((126976 mod (GRANULE_SIZE)) = (0)));
      (anno (((18446744073709547520 + (0)) = (18446744073709547520)));
      (anno (((0 - (18446744073709547520)) = ((- 18446744073709547520))));
      (Some (false, st)))))))))
  | ("null", ofs) =>
    (anno (((STACK_smc_rec_enter * (GRANULE_SIZE)) = (126976)));
    (anno (((SLOT_VIRT + (126976)) = (18446744073709547520)));
    (anno (((18446744073709547520 - (SLOT_VIRT)) = (126976)));
    (anno (((126976 mod (GRANULE_SIZE)) = (0)));
    (anno (((18446744073709547520 + (0)) = (18446744073709547520)));
    (anno (((0 - (18446744073709547520)) = ((- 18446744073709547520))));
    (Some (false, st))))))))
  | _ =>
    (anno (((- 1) = ((- 1))));
    (anno (((STACK_smc_rec_enter * (GRANULE_SIZE)) = (126976)));
    (anno (((SLOT_VIRT + (126976)) = (18446744073709547520)));
    (anno (((18446744073709547520 - (SLOT_VIRT)) = (126976)));
    (anno (((126976 mod (GRANULE_SIZE)) = (0)));
    (anno (((18446744073709547520 + (0)) = (18446744073709547520)));
    (anno ((((- 1) - (18446744073709547520)) = ((- 18446744073709547521))));
    (Some (false, st)))))))))
  end.

Definition s2_inconsistent_sl_spec_mid (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (bool * RData)) :=
  (anno (((((3 - (v_sl)) * (9)) + (13)) = ((40 + (((- 9) * (v_sl)))))));
  (anno (((((3 - (v_sl)) * (9)) + (25)) = ((52 + (((- 9) * (v_sl)))))));
  (Some (((((40 + (((- 9) * (v_sl)))) - (v_ipa_bits)) >? (0)) || ((((52 + (((- 9) * (v_sl)))) - (v_ipa_bits)) <? (0)))), st)))).

Definition s2_num_root_rtts_spec_mid (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (Z * RData)) :=
  (anno (((((3 - (v_sl)) * (9)) + (21)) = ((3 * ((((3 - (v_sl)) * (3)) + (7)))))));
  (anno (((((3 - (v_sl)) * (3)) + (7)) = ((16 + (((- 3) * (v_sl)))))));
  (anno (((48 + (((- 9) * (v_sl)))) = ((3 * ((16 + (((- 3) * (v_sl)))))))));
  (anno (((3 * ((16 + (((- 3) * (v_sl)))))) = ((48 + (((- 9) * (v_sl)))))));
  if (((48 + (((- 9) * (v_sl)))) - (v_ipa_bits)) <? (0))
  then (
    (anno (((((3 - (v_sl)) * (9)) + (21)) = ((3 * ((((3 - (v_sl)) * (3)) + (7)))))));
    (anno (((((3 - (v_sl)) * (3)) + (7)) = ((16 + (((- 3) * (v_sl)))))));
    (anno (((48 + (((- 9) * (v_sl)))) = ((3 * ((16 + (((- 3) * (v_sl)))))))));
    (anno (((3 * ((16 + (((- 3) * (v_sl)))))) = ((48 + (((- 9) * (v_sl)))))));
    (Some ((1 << ((v_ipa_bits - ((48 + (((- 9) * (v_sl)))))))), st)))))))
  else (Some (1, st)))))).

Definition requested_ipa_bits_spec_mid (v_p: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (((v_p.(pbase)) = ("stack")));
  (anno (((4096 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno ((((v_p.(poffset)) + (0)) = ((v_p.(poffset)))));
  rely (((((((((st.(priv)).(pcpu_stack)) @ ((v_p.(poffset)) / (MaxStackOrder))).(sf_data)) @ ((v_p.(poffset)) mod (MaxStackOrder))).(sd_size)) - (8)) = (0)));
  (anno ((((v_p.(poffset)) + (0)) = ((v_p.(poffset)))));
  (Some ((((((((st.(priv)).(pcpu_stack)) @ ((v_p.(poffset)) / (MaxStackOrder))).(sf_data)) @ ((v_p.(poffset)) mod (MaxStackOrder))).(sd_data)) & (255)), st)))))).

Definition addr_is_contained_spec_mid (v_container_base: Z) (v_container_end: Z) (v_address: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((((v_address - (v_container_base)) >=? (0)) && ((((v_container_end + ((- 1))) - (v_address)) >=? (0)))), st)).

Definition psci_reset_rec_spec_mid (v_rec: Ptr) (v_caller_sctlr_el1: Z) (st: RData) : (option RData) :=
  rely ((((v_rec.(pbase)) = ("slot_rec2")) /\ (((v_rec.(poffset)) = (0)))));
  (anno (((3272 * (0)) = (0)));
  (anno (((280 + (0)) = (280)));
  (anno (((0 + (280)) = (280)));
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
    | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
    end);
  (anno (((3272 * (0)) = (0)));
  (anno (((64 + (0)) = (64)));
  (anno (((288 + (64)) = (352)));
  (anno (((0 + (352)) = (352)));
  (Some (st.[share].[granule_data] :<
    (((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC2) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).[g_rec] :<
        ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).[e_pstate] :< 965).[e_sysregs] :<
          ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_sysregs)).[e_sysreg_sctlr_el1] :<
            ((v_caller_sctlr_el1 & (33554432)) |' (12912760))))))))))))))).

Definition advance_pc_spec_mid (st: RData) : (option RData) :=
  (Some (st.[priv].[pcpu_regs].[pcpu_elr_el2] :< ((((st.(priv)).(pcpu_regs)).(pcpu_elr_el2)) + (4)))).

Definition calc_vector_entry_spec_mid (v_vbar: Z) (v_spsr: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_spsr & (15)) =? (5))
  then (Some ((512 + (v_vbar)), st))
  else (
    if ((v_spsr & (15)) =? (4))
    then (
      (anno (((0 + (v_vbar)) = (v_vbar)));
      (Some (v_vbar, st))))
    else (
      if ((v_spsr & (15)) =? (0))
      then (
        if ((v_spsr & (16)) =? (0))
        then (Some ((1024 + (v_vbar)), st))
        else (Some ((1536 + (v_vbar)), st)))
      else (
        (anno (((0 + (v_vbar)) = (v_vbar)));
        (Some (v_vbar, st)))))).

Definition rec_is_simd_allowed_spec_mid (v_rec: Ptr) (st: RData) : (option (bool * RData)) :=
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)));
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)));
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  (anno (((3272 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((16 + (8)) = (24)));
  (anno (((1096 + (24)) = (1120)));
  (anno (((0 + (1120)) = (1120)));
  (Some ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd_allowed)) & (1)) <>? (0)), st))))))).

Definition rec_simd_type_spec_mid (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)));
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)));
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  (anno (((3272 * (0)) = (0)));
  (anno (((40 + (0)) = (40)));
  (anno (((880 + (40)) = (920)));
  (anno (((0 + (920)) = (920)));
  if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_sve_enabled)) & (1)) =? (0))
  then (Some (1, st))
  else (Some (2, st)))))).

Definition esr_is_write_spec_mid (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_esr & (64)) <>? (0)), st)).

Definition rec_ipa_size_spec_mid (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  (anno (((3272 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno (((880 + (0)) = (880)));
  (anno (((0 + (880)) = (880)));
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  (Some ((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))), st)))))).

Definition esr_sas_spec_mid (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_esr >> (22)) & (3)), st)).

Definition esr_srt_spec_mid (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_esr >> (16)) & (31)), st)).

Definition fsc_is_external_abort_spec_mid (v_fsc: Z) (st: RData) : (option (bool * RData)) :=
  if (v_fsc =? (16))
  then (Some (true, st))
  else (
    if ((v_fsc + ((- 19))) <? (5))
    then (Some (true, st))
    else (Some (false, st))).

Definition calc_esr_idabort_spec_mid (v_esr_el2: Z) (v_spsr_el2: Z) (v_fsc: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_spsr_el2 & (15)) =? (0))
  then (Some (((((v_esr_el2 & (18446744069481691456)) |' (512)) |' (v_fsc)) |' ((v_esr_el2 & (4227858432)))), st))
  else (Some (((((v_esr_el2 & (18446744069481691456)) |' (512)) |' (v_fsc)) |' (((v_esr_el2 & (4227858432)) + (67108864)))), st)).

Definition get_sysreg_write_value_spec_mid (v_rec: Ptr) (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  if (((v_esr >> (5)) & (31)) =? (31))
  then (Some (0, st))
  else (
    rely ((((0 - (((v_esr >> (5)) & (31)))) <= (0)) /\ ((((v_esr >> (5)) & (31)) < (31)))));
    (anno (((3272 * (0)) = (0)));
    rely (
      match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end);
    (anno ((((8 * (((v_esr >> (5)) & (31)))) + (0)) = ((8 * (((v_esr >> (5)) & (31)))))));
    (anno (((0 + ((24 + ((8 * (((v_esr >> (5)) & (31)))))))) = ((24 + ((8 * (((v_esr >> (5)) & (31)))))))));
    (anno ((((v_rec.(poffset)) + ((24 + ((8 * (((v_esr >> (5)) & (31)))))))) = ((24 + ((8 * (((v_esr >> (5)) & (31)))))))));
    (anno ((((24 + ((8 * (((v_esr >> (5)) & (31)))))) - (24)) = ((8 * (((v_esr >> (5)) & (31)))))));
    (anno ((((8 * (((v_esr >> (5)) & (31)))) / (8)) = (((v_esr >> (5)) & (31)))));
    (Some (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ ((v_esr >> (5)) & (31))), st))))))))).

Definition is_valid_vintid_spec_mid (v_intid: Z) (st: RData) : (option (bool * RData)) :=
  if (v_intid <? (1020))
  then (Some (true, st))
  else (
    if (v_intid >? (8191))
    then (
      if ((gic_virt_feature_3 - (v_intid)) <? (0))
      then (
        if ((gic_virt_feature_4 & (1)) =? (0))
        then (Some (false, st))
        else (Some (((v_intid & (18446744073709550592)) =? (4096)), st)))
      else (Some (true, st)))
    else (
      if ((gic_virt_feature_4 & (1)) =? (0))
      then (Some (false, st))
      else (Some (((v_intid & (18446744073709550592)) =? (4096)), st)))).

Definition esr_sign_extend_spec_mid (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_esr & (2097152)) <>? (0)), st)).

Definition esr_sixty_four_spec_mid (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_esr & (32768)) <>? (0)), st)).

Definition is_el2_data_abort_gpf_spec_mid (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  if ((v_esr & (4227858432)) =? (2483027968))
  then (
    if ((v_esr & (63)) =? (40))
    then (Some (true, st))
    else (Some (false, st)))
  else (Some (false, st)).

Definition sve_config_vq_spec_mid (v_vq: Z) (st: RData) : (option RData) :=
  if ((((((st.(priv)).(pcpu_regs)).(pcpu_zcr_el2)) & (15)) - (v_vq)) =? (0))
  then (Some st)
  else (Some (st.[priv].[pcpu_regs].[pcpu_zcr_el2] :< (((((st.(priv)).(pcpu_regs)).(pcpu_zcr_el2)) & ((- 16))) |' (v_vq)))).

