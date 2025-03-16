Definition validate_map_addr_spec (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
  rely ((rd_is_locked st));
  rely (((v_rd.(poffset)) = (0)));
  rely (((v_rd.(pbase)) = ("slot_rd")));
  when v_call, st_0 == ((realm_ipa_size_spec v_rd st));
  if ((v_call - (v_map_addr)) >? (0))
  then (
    when v_call1, st_1 == ((addr_is_level_aligned_spec v_map_addr v_level st_0));
    if v_call1
    then (Some (true, st_1))
    else (Some (false, st_1)))
  else (Some (false, st_0)).

Definition addr_in_par_spec (v_rd: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
  rely ((rd_is_locked st));
  rely (((v_rd.(poffset)) = (0)));
  rely (((v_rd.(pbase)) = ("slot_rd")));
  when v_call, st_0 == ((realm_par_size_spec v_rd st));
  (Some (((v_call - (v_addr)) >? (0)), st_0)).

