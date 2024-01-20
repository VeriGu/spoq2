Record s_realm_s2_context :=
 mks_realm_s2_context {
    e_ipa_bits : Z;
    e_s2_starting_level : Z;
    e_num_root_rtts : Z;
    e_g_rtt : Z;
    e_vmid : Z
  }.

Record s_rd :=
 mks_rd {
    e_state : Z;
    e_rec_count : Z;
    e_s2_ctx : s_realm_s2_context;
    e_num_rec_aux : Z;
    e_algorithm : Z;
    e_pmu_enabled : Z;
    e_pmu_num_cnts : Z;
    e_sve_enabled : Z;
    e_sve_vq : Z;
    e_measurement : (ZMap.t (ZMap.t Z));
    e_rpv : (ZMap.t Z)
  }.

Definition load_s_realm_s2_context (sz: Z) (ofs: Z) (st: s_realm_s2_context) : option Z :=
  if (ofs =? 0) then Some (st.(e_ipa_bits)) else
  if (ofs =? 4) then Some (st.(e_s2_starting_level)) else
  if (ofs =? 8) then Some (st.(e_num_root_rtts)) else
  if (ofs =? 16) then Some (st.(e_g_rtt)) else
  if (ofs =? 24) then Some (st.(e_vmid)) else
  None.

Definition store_s_realm_s2_context (sz: Z) (ofs: Z) (v: Z) (st: s_realm_s2_context) : option s_realm_s2_context :=
  if (ofs =? 0) then Some (st.[e_ipa_bits] :< v) else
  if (ofs =? 4) then Some (st.[e_s2_starting_level] :< v) else
  if (ofs =? 8) then Some (st.[e_num_root_rtts] :< v) else
  if (ofs =? 16) then Some (st.[e_g_rtt] :< v) else
  if (ofs =? 24) then Some (st.[e_vmid] :< v) else
  None.

Definition load_s_rd (sz: Z) (ofs: Z) (st: s_rd) : option Z :=
  if (ofs =? 0) then Some (st.(e_state)) else
  if (ofs =? 8) then Some (st.(e_rec_count)) else
  if (ofs >=? 16) && (ofs <? 48) then (
    let elem_ofs := ofs - 16 in
    load_s_realm_s2_context sz elem_ofs (st.(e_s2_ctx))) else
  if (ofs =? 48) then Some (st.(e_num_rec_aux)) else
  if (ofs =? 52) then Some (st.(e_algorithm)) else
  if (ofs =? 56) then Some (st.(e_pmu_enabled)) else
  if (ofs =? 60) then Some (st.(e_pmu_num_cnts)) else
  if (ofs =? 64) then Some (st.(e_sve_enabled)) else
  if (ofs =? 65) then Some (st.(e_sve_vq)) else
  if (ofs >=? 66) && (ofs <? 386) then (
    let idx := (ofs - 66) / 64 in
    None (* Not support nested vector *)
  if (ofs >=? 386) && (ofs <? 450) then (
    let idx := (ofs - 386) / 1 in
    Some (st.(e_rpv) @ idx)) else
  None.

Definition store_s_rd (sz: Z) (ofs: Z) (v: Z) (st: s_rd) : option s_rd :=
  if (ofs =? 0) then Some (st.[e_state] :< v) else
  if (ofs =? 8) then Some (st.[e_rec_count] :< v) else
  if (ofs >=? 16) && (ofs <? 48) then (
    let elem_ofs := ofs - 16 in
    when ret == store_s_realm_s2_context sz elem_ofs v st.(e_s2_ctx);
    Some (st.[e_s2_ctx] :< ret)) else
  if (ofs =? 48) then Some (st.[e_num_rec_aux] :< v) else
  if (ofs =? 52) then Some (st.[e_algorithm] :< v) else
  if (ofs =? 56) then Some (st.[e_pmu_enabled] :< v) else
  if (ofs =? 60) then Some (st.[e_pmu_num_cnts] :< v) else
  if (ofs =? 64) then Some (st.[e_sve_enabled] :< v) else
  if (ofs =? 65) then Some (st.[e_sve_vq] :< v) else
  if (ofs >=? 66) && (ofs <? 386) then (
    let idx := (ofs - 66) / 64 in
    None (* Not support nested vector *)
  if (ofs >=? 386) && (ofs <? 450) then (
    let idx := (ofs - 386) / 1 in
    Some (st.[e_rpv] :< (st.(e_rpv) # idx == v))) else
  None.

