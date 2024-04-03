Definition atomic_granule_put_release_spec (v_g: Ptr) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then true
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end))
  then (
    when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
    then None
    else (
      if (
        (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
          (((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =? (0)))))
      then (Some (lens 516 st))
      else (Some (lens 462 st))))
  else None.

Definition atomic_granule_put_spec (v_g: Ptr) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then true
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end))
  then (
    when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
    then None
    else (
      if (
        (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
          (((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =? (0)))))
      then (Some (lens 573 st))
      else (Some (lens 519 st))))
  else None.

Definition atomic_granule_get_spec (v_g: Ptr) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then true
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end))
  then (
    when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
    then None
    else (
      if (
        (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
          (((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =? (0)))))
      then (Some (lens 630 st))
      else (Some (lens 576 st))))
  else None.

Definition granule_get_state_spec (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid) => true
    | None => false
    end)
  then (Some (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_state)), st))
  else None.

Definition granule_refcount_read_acquire_spec (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then true
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end))
  then (Some (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)), st))
  else None.

Definition granule_set_state_spec (v_g: Ptr) (v_state: Z) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid) => true
    | None => false
    end)
  then (
    when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock)));
    (Some (lens 633 st)))
  else None.

Definition granule_from_idx_spec (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((((0 - (v_idx)) <= (0)) /\ ((v_idx < (1048576)))));
  (Some ((mkPtr "granules" (16 * (v_idx))), st)).

