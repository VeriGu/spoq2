Definition sort_granules_spec (v_granules: Ptr) (v_n: Z) (st: RData) : (option RData) :=
  (Some st).

Definition granule_lock_on_state_match_spec (v_g: Ptr) (v_expected_state: Z) (st: RData) : (option (bool * RData)) :=
  rely (((((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) = (0)));
  rely ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
  rely (((v_g.(pbase)) = ("granules")));
  when st1 == ((query_oracle st));
  match (((((st1.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    rely (
      ((((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) -
        (((((st1.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)))) =
        (0)));
    (Some (
      true  ,
      ((st1.[log] :< ((EVT CPU_ID (ACQ ((v_g.(poffset)) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))).[share].[granules] :<
        (((st1.(share)).(granules)) #
          ((v_g.(poffset)) / (ST_GRANULE_SIZE)) ==
          ((((st1.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))))
    ))
  | (Some cid) => None
  end.

Definition find_granule_spec (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
  if ((v_addr & (4095)) =? (0))
  then (
    if ((v_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some ((mkPtr "null" 0), st))
    else (
      rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
      (Some ((mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE))))), st))))
  else (Some ((mkPtr "null" 0), st)).

