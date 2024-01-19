Definition atomic_granule_put_release_spec (v_g: Ptr) (st: RData) : (option RData) :=
  rely (
    if (((v_g.(poffset)) + (8)) =? (8))
    then (
      if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        match (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))
    else (false = (true)));
  when cid == (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock)));
  if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))) <? (0))
  then None
  else (
    if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_REC)) =? (0))
    then (
      (Some ((st.[log] :< ((EVT CPU_ID (REC_REF (v_g.(poffset)) (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))))))
    else (
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))))))).

Definition atomic_granule_put_spec (v_g: Ptr) (st: RData) : (option RData) :=
  rely (
    if (((v_g.(poffset)) + (8)) =? (8))
    then (
      if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        match (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))
    else (false = (true)));
  when cid == (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock)));
  if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))) <? (0))
  then None
  else (
    if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_REC)) =? (0))
    then (
      (Some ((st.[log] :< ((EVT CPU_ID (REC_REF (v_g.(poffset)) (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))))))
    else (
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))))))).

Definition atomic_granule_get_spec (v_g: Ptr) (st: RData) : (option RData) :=
  rely (
    if (((v_g.(poffset)) + (8)) =? (8))
    then (
      if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        match (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))
    else (false = (true)));
  when cid == (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock)));
  if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)) <? (0))
  then None
  else (
    if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_REC)) =? (0))
    then (
      (Some ((st.[log] :< ((EVT CPU_ID (REC_REF (v_g.(poffset)) (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)))))))
    else (
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)))))))).

Definition granule_get_state_spec (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))) /\
      (match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end)));
  (Some (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_state)), st)).

Definition granule_refcount_read_acquire_spec (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))) /\
      (if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))));
  (Some (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)), st)).

Definition granule_from_idx_spec (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((((0 - (v_idx)) <= (0)) /\ ((v_idx < (1048576)))));
  (Some ((mkPtr "granules" (16 * (v_idx))), st)).

Definition granule_set_state_spec (v_g: Ptr) (v_state: Z) (st: RData) : (option RData) :=
  rely (
    ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))) /\
      (match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end)));
  match (
    match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid) => (Some ((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).[e_state] :< v_state))
    | _ => None
    end
  ) with
  | (Some ret) => (Some (st.[share].[granules] :< (((st.(share)).(granules)) # (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE)) == ret)))
  | _ => None
  end.

