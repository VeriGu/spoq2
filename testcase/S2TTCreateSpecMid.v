Definition s2tte_create_table_spec_mid (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((v_pa |' (3)), st)).

Definition s2tte_get_ripas_spec_mid (v_s2tte: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_s2tte & (64)) =? (0))
  then (Some (0, st))
  else (Some (1, st)).

Definition s2tte_create_valid_spec_mid (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  if (v_level =? (3))
  then (Some ((v_pa |' (2011)), st))
  else (Some ((v_pa |' (2009)), st)).

