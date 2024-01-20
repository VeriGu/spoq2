Definition validate_data_create_unknown_spec' (v_map_addr: Z) (v_rd: Ptr) (st: RData) : (option Z) :=
  rely (
    ((((v_rd.(poffset)) = (0)) /\ (((v_rd.(pbase)) = ("slot_rd")))) /\
      ((((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))) /\ ((0 = (0)))) /\ (("slot_rd" = ("slot_rd")))))));
  if ((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_map_addr)) >? (0))
  then (
    when ret == ((validate_map_addr_spec' v_map_addr 3 v_rd st));
    if ret
    then (Some 0)
    else (Some 1))
  else (Some 1).

Definition validate_data_create_unknown_spec (v_map_addr: Z) (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  when ret == ((validate_data_create_unknown_spec' v_map_addr v_rd st));
  (Some (ret, st)).

Definition validate_rtt_entry_cmds_spec' (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option bool) :=
  rely ((((v_rd.(poffset)) = (0)) /\ (((v_rd.(pbase)) = ("slot_rd")))));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) =>
    if (
      ((v_level >? (3)) ||
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) - (v_level)) >? (0)))))
    then (Some false)
    else (
      when ret == ((validate_map_addr_spec' v_map_addr v_level v_rd st));
      (Some ret))
  | _ => None
  end.

Definition validate_rtt_entry_cmds_spec (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
  when ret == ((validate_rtt_entry_cmds_spec' v_map_addr v_level v_rd st));
  (Some (ret, st)).

Definition validate_rtt_map_cmds_spec' (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option bool) :=
  rely ((((v_rd.(poffset)) = (0)) /\ (((v_rd.(pbase)) = ("slot_rd")))));
  if ((v_level + ((- 4))) <? ((- 2)))
  then (Some false)
  else (
    when ret == ((validate_map_addr_spec' v_map_addr v_level v_rd st));
    (Some ret)).

Definition validate_rtt_map_cmds_spec (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
  when ret == ((validate_rtt_map_cmds_spec' v_map_addr v_level v_rd st));
  (Some (ret, st)).

Definition validate_rtt_structure_cmds_spec' (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option bool) :=
  rely ((((v_rd.(poffset)) = (0)) /\ (((v_rd.(pbase)) = ("slot_rd")))));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) =>
    if (
      ((v_level >? (3)) ||
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) + (1)) - (v_level)) >? (0)))))
    then (Some false)
    else (
      when ret == ((validate_map_addr_spec' v_map_addr v_level v_rd st));
      (Some ret))
  | _ => None
  end.

Definition validate_rtt_structure_cmds_spec (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
  when ret == ((validate_rtt_structure_cmds_spec' v_map_addr v_level v_rd st));
  (Some (ret, st)).

Definition s2tte_create_valid_ns_spec' (v_s2tte: Z) (v_level: Z) (st: RData) : Z :=
  if (v_level =? (3))
  then (v_s2tte |' (54043195528446979))
  else (v_s2tte |' (54043195528446977)).

Definition s2tte_create_valid_ns_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  let ret := (s2tte_create_valid_ns_spec' v_s2tte v_level st) in
  (Some (ret, st)).

