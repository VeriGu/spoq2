Definition s2tte_is_assigned_spec_mid (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((s2tte_has_hipas_spec' v_s2tte 4 st), st)).

Definition s2tte_is_unassigned_spec_mid (v_s2tte: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((s2tte_has_hipas_spec' v_s2tte 0 st), st)).

Definition s2tte_is_valid_spec_mid (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((s2tte_check_spec' v_s2tte v_level 0 st), st)).

Definition s2tte_is_valid_ns_spec_mid (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((s2tte_check_spec' v_s2tte v_level 36028797018963968 st), st)).

Definition s2tte_is_table_spec_mid (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_level <? (3)) && (((v_s2tte & (3)) =? (3)))), st)).

Definition s2tte_is_destroyed_spec_mid (v_s2tte: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((s2tte_has_hipas_spec' v_s2tte 8 st), st)).

Definition host_ns_s2tte_spec_mid (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (anno (((- 1) = ((- 1))));
  (anno ((((- 1) & (281474976710655)) = (281474976710655)));
  (anno (((39 + ((38654705655 * (v_level)))) = ((3 * ((13 + ((12884901885 * (v_level)))))))));
  (anno (((3 * ((13 + ((12884901885 * (v_level)))))) = ((39 + ((38654705655 * (v_level)))))));
  (Some ((((281474976710655 & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) |' (988)) & (v_s2tte)), st)))))).

Definition host_ns_s2tte_is_valid_spec_mid (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (anno (((- 1) = ((- 1))));
  (anno ((((- 1) & (281474976710655)) = (281474976710655)));
  (anno (((39 + ((38654705655 * (v_level)))) = ((3 * ((13 + ((12884901885 * (v_level)))))))));
  (anno (((3 * ((13 + ((12884901885 * (v_level)))))) = ((39 + ((38654705655 * (v_level)))))));
  if (((Z.lxor ((281474976710655 & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) |' (988)) (- 1)) & (v_s2tte)) =? (0))
  then (
    if ((v_s2tte & (28)) =? (16))
    then (Some (false, st))
    else (
      if ((v_s2tte & (768)) =? (256))
      then (Some (false, st))
      else (Some (true, st))))
  else (Some (false, st)))))).

Definition table_entry_to_phys_spec_mid (v_entry1: Z) (st: RData) : (option (Z * RData)) :=
  (anno (((- 1) = ((- 1))));
  (anno (((39 + ((38654705655 * (3)))) = ((3 * ((13 + ((12884901885 * (3)))))))));
  (anno (((12884901885 * (3)) = (38654705655)));
  (anno (((13 + (38654705655)) = (38654705668)));
  (anno (((3 * (38654705668)) = (115964117004)));
  (anno (((115964117004 & (4294967295)) = (12)));
  (anno ((((- 1) << (12)) = ((- 4096))));
  (Some (((v_entry1 & (281474976710655)) & ((- 4096))), st))))))))).

Definition addr_is_level_aligned_spec_mid (v_addr: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (anno (((- 1) = ((- 1))));
  (anno (((39 + ((38654705655 * (v_level)))) = ((3 * ((13 + ((12884901885 * (v_level)))))))));
  (anno (((3 * ((13 + ((12884901885 * (v_level)))))) = ((39 + ((38654705655 * (v_level)))))));
  (Some (((((v_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) - (v_addr)) =? (0)), st))))).

