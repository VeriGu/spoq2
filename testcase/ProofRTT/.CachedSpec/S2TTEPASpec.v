Definition s2tte_pa_table_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_s2tte & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))), st)).

Definition s2tte_pa_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_s2tte & (281474976710655)) & (((- 1) << (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))), st)).

Definition s2tte_map_size_spec (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((1 << ((((3 - (v_level)) * (9)) + (12)))), st)).

Definition s2tte_create_assigned_empty_spec (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((v_pa |' (4)), st)).

Definition s2tte_create_ripas_spec (v_ripas: Z) (st: RData) : (option (Z * RData)) :=
  if (v_ripas =? (0))
  then (Some (0, st))
  else (Some (64, st)).

