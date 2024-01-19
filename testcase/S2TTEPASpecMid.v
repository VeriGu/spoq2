Definition s2tte_pa_table_spec_mid (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (anno (((- 1) = ((- 1))));
  (anno (((39 + ((38654705655 * (3)))) = ((3 * ((13 + ((12884901885 * (3)))))))));
  (anno (((12884901885 * (3)) = (38654705655)));
  (anno (((13 + (38654705655)) = (38654705668)));
  (anno (((3 * (38654705668)) = (115964117004)));
  (anno (((115964117004 & (4294967295)) = (12)));
  (anno ((((- 1) << (12)) = ((- 4096))));
  (Some (((v_s2tte & (281474976710655)) & ((- 4096))), st))))))))).

Definition s2tte_pa_spec_mid (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (anno (((- 1) = ((- 1))));
  (anno (((39 + ((38654705655 * (v_level)))) = ((3 * ((13 + ((12884901885 * (v_level)))))))));
  (anno (((3 * ((13 + ((12884901885 * (v_level)))))) = ((39 + ((38654705655 * (v_level)))))));
  (Some (((v_s2tte & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))), st))))).

Definition s2tte_map_size_spec_mid (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (anno (((((3 - (v_level)) * (9)) + (12)) = ((3 * ((((3 - (v_level)) * (3)) + (4)))))));
  (anno (((((3 - (v_level)) * (3)) + (4)) = ((13 + (((- 3) * (v_level)))))));
  (anno (((39 + (((- 9) * (v_level)))) = ((3 * ((13 + (((- 3) * (v_level)))))))));
  (anno (((3 * ((13 + (((- 3) * (v_level)))))) = ((39 + (((- 9) * (v_level)))))));
  (Some ((1 << ((39 + (((- 9) * (v_level)))))), st)))))).

Definition s2tte_create_assigned_empty_spec_mid (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((v_pa |' (4)), st)).

Definition s2tte_create_ripas_spec_mid (v_ripas: Z) (st: RData) : (option (Z * RData)) :=
  if (v_ripas =? (0))
  then (Some (0, st))
  else (Some (64, st)).

