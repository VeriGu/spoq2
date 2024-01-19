Definition granule_lock_on_state_match_spec (v_g: Ptr) (v_expected_state: Z) (st: RData) : (option (bool * RData)) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
  match ((((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    if (((((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
    then (
      (Some (
        (((((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))  ,
        ((st.[log] :< ((EVT CPU_ID (ACQ ((v_g.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
          (sh.[granules] :<
            ((sh.(granules)) # ((v_g.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))))
      )))
    else (
      (Some (
        (((((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))  ,
        ((st.[log] :<
          ((EVT CPU_ID (REL ((v_g.(poffset)) / (ST_GRANULE_SIZE)) (((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
            (((EVT CPU_ID (ACQ ((v_g.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
          (sh.[granules] :< ((sh.(granules)) # ((v_g.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None))))
      )))
  | (Some cid) => None
  end.

Definition find_granule_spec' (v_addr: Z) (st: RData) : (option Ptr) :=
  if ((v_addr & (4095)) =? (0))
  then (
    if ((v_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (mkPtr "null" 0))
    else (
      rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
      (Some (mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE))))))))
  else (Some (mkPtr "null" 0)).

Definition find_granule_spec (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
  when ret == ((find_granule_spec' v_addr st));
  (Some (ret, st)).

Definition sort_granules_spec (v_granules: Ptr) (v_n: Z) (st: RData) : (option RData) :=
  rely (((v_granules.(pbase)) = ("find_lock_two_granules_stack")));
  if (
    (((((st.(stack)).(find_lock_two_granules_stack)) @ ((v_granules.(poffset)) + (8))) -
      ((((st.(stack)).(find_lock_two_granules_stack)) @ ((v_granules.(poffset)) + (48))))) >?
      (0)))
  then (
    (Some ((st.[stack].[find_lock_two_granules_stack] :<
      ((((st.(stack)).(find_lock_two_granules_stack)) # (v_granules.(poffset)) == (((st.(stack)).(find_lock_two_granules_stack)) @ ((v_granules.(poffset)) + (40)))) #
        ((v_granules.(poffset)) + (8)) ==
        (((st.(stack)).(find_lock_two_granules_stack)) @ ((v_granules.(poffset)) + (48))))).[stack].[sort_granules_stack] :<
      ((st.(stack)).(sort_granules_stack)))))
  else (Some st).

Definition addr_to_granule_spec (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
  (Some ((mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE))))), st)).

