Definition atomic_granule_put_release_spec_mid (v_g: Ptr) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then (true = (true))
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end));
  rely (
    if (((v_g.(poffset)) + (8)) =? (8))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
        (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
        (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
        (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
        match (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))))))))))
    else (false = (true)));
  (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  when cid == (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock)));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))) <? (0))
  then None
  else (
    (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
    (anno ((((v_g.(poffset)) + (8)) = (8)));
    (anno (((8 mod (ST_GRANULE_SIZE)) = (8)));
    (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
    (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
    (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
    if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_REC)) =? (0))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some ((st.[log] :< ((EVT CPU_ID (REC_REF (v_g.(poffset)) (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))))))))))
    else (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))))))))))))))))))))))))))).

Definition atomic_granule_put_spec_mid (v_g: Ptr) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then (true = (true))
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end));
  rely (
    if (((v_g.(poffset)) + (8)) =? (8))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
        (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
        (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
        (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
        match (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))))))))))
    else (false = (true)));
  (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  when cid == (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock)));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))) <? (0))
  then None
  else (
    (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
    (anno ((((v_g.(poffset)) + (8)) = (8)));
    (anno (((8 mod (ST_GRANULE_SIZE)) = (8)));
    (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
    (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
    (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
    if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_REC)) =? (0))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some ((st.[log] :< ((EVT CPU_ID (REC_REF (v_g.(poffset)) (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))))))))))
    else (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + ((- 1))))))))))))))))))))))))))))).

Definition atomic_granule_get_spec_mid (v_g: Ptr) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then (true = (true))
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end));
  rely (
    if (((v_g.(poffset)) + (8)) =? (8))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then (true = (true))
      else (
        (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
        (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
        (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
        (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
        match (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end))))))))))
    else (false = (true)));
  (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  when cid == (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_lock)));
  (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
  if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)) <? (0))
  then None
  else (
    (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
    (anno ((((v_g.(poffset)) + (8)) = (8)));
    (anno (((8 mod (ST_GRANULE_SIZE)) = (8)));
    (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
    (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
    (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
    if ((((((st.(share)).(granules)) @ (v_g.(poffset))).(e_state)) - (GRANULE_STATE_REC)) =? (0))
    then (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some ((st.[log] :< ((EVT CPU_ID (REC_REF (v_g.(poffset)) (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)))))))))))
    else (
      (anno (((((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
      (anno ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) = ((v_g.(poffset)))));
      (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
      (anno ((((v_g.(poffset)) + (0)) = ((v_g.(poffset)))));
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (v_g.(poffset)) ==
          ((((st.(share)).(granules)) @ (v_g.(poffset))).[e_refcount] :< (((((st.(share)).(granules)) @ (v_g.(poffset))).(e_refcount)) + (1)))))))))))))))))))))))))))).

Definition granule_get_state_spec_mid (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  (anno (((16 * (0)) = (0)));
  (anno (((4 + (0)) = (4)));
  (anno (((0 + (4)) = (4)));
  rely (
    match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid) => (true = (true))
    | _ => (false = (true))
    end);
  (Some (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_state)), st))))).

Definition granule_refcount_read_acquire_spec_mid (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  (anno (((16 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  rely (
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then (true = (true))
    else (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end));
  (Some (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)), st))))).

Definition granule_set_state_spec_mid (v_g: Ptr) (v_state: Z) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  (anno (((16 * (0)) = (0)));
  (anno (((4 + (0)) = (4)));
  (anno (((0 + (4)) = (4)));
  rely (
    match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid) => (true = (true))
    | _ => (false = (true))
    end);
  match (
    match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid) => (Some ((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).[e_state] :< v_state))
    | _ => None
    end
  ) with
  | (Some ret) => (Some (st.[share].[granules] :< (((st.(share)).(granules)) # (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE)) == ret)))
  | _ => None
  end))).

Definition granule_from_idx_spec_mid (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((((0 - (v_idx)) <= (0)) /\ ((v_idx < (1048576)))));
  (anno (((16 * (1048576)) = (16777216)));
  (anno (((16777216 * (0)) = (0)));
  (anno ((((16 * (v_idx)) + (0)) = ((16 * (v_idx)))));
  (anno (((0 + ((16 * (v_idx)))) = ((16 * (v_idx)))));
  (Some ((mkPtr "granules" (16 * (v_idx))), st)))))).

