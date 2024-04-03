Definition granule_lock_spec (v_g: Ptr) (v_expected_state: Z) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
  match (((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    if ((((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
    then (
      (Some ((lens 692 st).[share].[granules] :<
        ((((lens 691 st).(share)).(granules)) #
          ((v_g.(poffset)) / (ST_GRANULE_SIZE)) ==
          (((((lens 691 st).(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))))))
    else (
      (Some (((lens 692 st).[log] :<
        ((EVT
          CPU_ID
          (REL ((v_g.(poffset)) / (ST_GRANULE_SIZE)) (((((lens 691 st).(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
          (((lens 692 st).(log))))).[share].[granules] :<
        ((((lens 691 st).(share)).(granules)) #
          ((v_g.(poffset)) / (ST_GRANULE_SIZE)) ==
          (((((lens 691 st).(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))))
  | (Some cid) => None
  end.

Definition granule_unlock_spec (v_g: Ptr) (st: RData) : (option RData) :=
  if ((v_g.(pbase)) =s ("granules"))
  then (
    when cid == (((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
    (Some ((lens 1154 st).[share].[granules] :<
      (((st.(share)).(granules)) # ((v_g.(poffset)) / (ST_GRANULE_SIZE)) == ((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))))
  else None.

Definition find_lock_granule_spec (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
  if ((v_addr & (4095)) =? (0))
  then (
    if ((v_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some ((mkPtr "null" 0), st))
    else (
      rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match (((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock))) with
      | None =>
        if ((((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
        then (
          (Some (
            (mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE)))))  ,
            ((lens 692 st).[share].[granules] :<
              ((((lens 691 st).(share)).(granules)) #
                (v_addr / (GRANULE_SIZE)) ==
                (((((lens 691 st).(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))))
          )))
        else (
          (Some (
            (mkPtr "null" 0)  ,
            (((lens 692 st).[log] :<
              ((EVT CPU_ID (REL (v_addr / (GRANULE_SIZE)) (((((lens 691 st).(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                (((lens 692 st).(log))))).[share].[granules] :<
              ((((lens 691 st).(share)).(granules)) # (v_addr / (GRANULE_SIZE)) == (((((lens 691 st).(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< None)))
          )))
      | (Some cid) => None
      end))
  else (Some ((mkPtr "null" 0), st)).

