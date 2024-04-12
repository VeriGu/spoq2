Definition arch_feat_get_pa_width_spec (st: RData) : (option (Z * RData)) :=
  rely ((((0 - ((0 & (15)))) <= (0)) /\ (((0 & (15)) < (7)))));
  if ((4 * ((0 & (15)))) =? (0))
  then (Some (32, st))
  else (
    if ((4 * ((0 & (15)))) =? (4))
    then (Some (36, st))
    else (
      if ((4 * ((0 & (15)))) =? (8))
      then (Some (40, st))
      else (
        if ((4 * ((0 & (15)))) =? (12))
        then (Some (42, st))
        else (
          if ((4 * ((0 & (15)))) =? (16))
          then (Some (44, st))
          else (
            if ((4 * ((0 & (15)))) =? (20))
            then (Some (48, st))
            else (Some (52, st))))))).

Definition xlat_arch_get_pas_spec (v_attr: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_attr & (1024)) =? (1024))
  then (Some (32, st))
  else (
    if ((v_attr & (1024)) =? (0))
    then (Some (0, st))
    else None).

Definition __sca_read64_spec (v_ptr: Ptr) (st: RData) : (option (Z * RData)) :=
  when v_0, st == ((iasm_0_spec v_ptr st));
  let __return__ := true in
  let __retval__ := v_0 in
  (Some (__retval__, st)).

Definition __sca_write64_spec (v_ptr: Ptr) (v_val: Z) (st: RData) : (option RData) :=
  when st == ((iasm_2_spec v_ptr v_val st));
  let __return__ := true in
  (Some st).

