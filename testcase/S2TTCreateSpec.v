Definition s2tte_create_table_spec (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((v_pa |' (3)), st)).

Definition s2tte_get_ripas_spec' (v_s2tte: Z) (st: RData) : Z :=
  if ((v_s2tte & (64)) =? (0))
  then 0
  else 1.

Definition s2tte_get_ripas_spec (v_s2tte: Z) (st: RData) : (option (Z * RData)) :=
  let ret := (s2tte_get_ripas_spec' v_s2tte st) in
  (Some (ret, st)).

Definition s2tte_create_valid_spec' (v_pa: Z) (v_level: Z) (st: RData) : Z :=
  if (v_level =? (3))
  then (v_pa |' (2011))
  else (v_pa |' (2009)).

Definition s2tte_create_valid_spec (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  let ret := (s2tte_create_valid_spec' v_pa v_level st) in
  (Some (ret, st)).

