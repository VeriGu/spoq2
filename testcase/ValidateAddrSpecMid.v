Definition validate_map_addr_spec_mid (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))));
  rely (((v_rd.(poffset)) = (0)));
  rely (((v_rd.(pbase)) = ("slot_rd")));
  if (((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
  then (
    (anno (((- 1) = ((- 1))));
    (anno (((39 + ((38654705655 * (v_level)))) = ((3 * ((13 + ((12884901885 * (v_level)))))))));
    (anno (((3 * ((13 + ((12884901885 * (v_level)))))) = ((39 + ((38654705655 * (v_level)))))));
    if ((((v_map_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) - (v_map_addr)) =? (0))
    then (Some (true, st))
    else (Some (false, st))))))
  else (Some (false, st)).

Definition addr_in_par_spec_mid (v_rd: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))));
  rely (((v_rd.(poffset)) = (0)));
  rely (((v_rd.(pbase)) = ("slot_rd")));
  (Some (
    ((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_addr)) >? (0))  ,
    st
  )).

