Definition s2tte_is_assigned_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((s2tte_has_hipas_spec' v_s2tte 4 st), st)).

Definition s2tte_is_unassigned_spec (v_s2tte: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((s2tte_has_hipas_spec' v_s2tte 0 st), st)).

Definition s2tte_is_valid_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((s2tte_check_spec' v_s2tte v_level 0 st), st)).

Definition s2tte_is_valid_ns_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((s2tte_check_spec' v_s2tte v_level 36028797018963968 st), st)).

Definition s2tte_is_table_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_level <? (3)) && (((v_s2tte & (3)) =? (3)))), st)).

Definition s2tte_is_destroyed_spec (v_s2tte: Z) (st: RData) : (option (bool * RData)) :=
  (Some ((s2tte_has_hipas_spec' v_s2tte 8 st), st)).

Definition host_ns_s2tte_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((((281474976710655 & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) |' (988)) & (v_s2tte)), st)).

Definition host_ns_s2tte_is_valid_spec' (v_s2tte: Z) (v_level: Z) (st: RData) : bool :=
  if (((Z.lxor ((281474976710655 & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) |' (988)) (- 1)) & (v_s2tte)) =? (0))
  then (
    if ((v_s2tte & (28)) =? (16))
    then false
    else (
      if ((v_s2tte & (768)) =? (256))
      then false
      else true))
  else false.

Definition host_ns_s2tte_is_valid_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  let ret := (host_ns_s2tte_is_valid_spec' v_s2tte v_level st) in
  (Some (ret, st)).

Definition table_entry_to_phys_spec (v_entry1: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_entry1 & (281474976710655)) & ((- 4096))), st)).

Definition addr_is_level_aligned_spec (v_addr: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((((v_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) - (v_addr)) =? (0)), st)).

