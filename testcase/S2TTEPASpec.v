Definition s2tte_pa_table_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_s2tte & (281474976710655)) & ((- 4096))), st)).

Definition s2tte_pa_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_s2tte & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))), st)).

Definition s2tte_map_size_spec (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((1 << ((39 + (((- 9) * (v_level)))))), st)).

Definition s2tte_create_assigned_empty_spec (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((v_pa |' (4)), st)).

Definition s2tte_create_ripas_spec' (v_ripas: Z) (st: RData) : Z :=
  if (v_ripas =? (0))
  then 0
  else 64.

Definition s2tte_create_ripas_spec (v_ripas: Z) (st: RData) : (option (Z * RData)) :=
  let ret := (s2tte_create_ripas_spec' v_ripas st) in
  (Some (ret, st)).

