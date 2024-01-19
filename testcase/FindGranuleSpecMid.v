Definition granule_lock_on_state_match_spec_mid (v_g: Ptr) (v_expected_state: Z) (st: RData) : (option (bool * RData)) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  (anno (((16 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
  (anno (((((v_g.(poffset)) + (0)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((0 / (ST_GRANULE_SIZE)))))));
  (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
  (anno (((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + (0)) = (((v_g.(poffset)) / (ST_GRANULE_SIZE)))));
  match ((((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    (anno (((((v_g.(poffset)) + (0)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((0 / (ST_GRANULE_SIZE)))))));
    (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
    (anno (((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + (0)) = (((v_g.(poffset)) / (ST_GRANULE_SIZE)))));
    if (((((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
    then (
      (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
      (anno (((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + (0)) = (((v_g.(poffset)) / (ST_GRANULE_SIZE)))));
      (Some (
        (((((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))  ,
        ((st.[log] :< ((EVT CPU_ID (ACQ ((v_g.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
          (sh.[granules] :<
            ((sh.(granules)) # ((v_g.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))))
      )))))
    else (
      (anno (((16 * (0)) = (0)));
      (anno (((0 + (0)) = (0)));
      (anno (((((v_g.(poffset)) + (0)) / (ST_GRANULE_SIZE)) = ((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + ((0 / (ST_GRANULE_SIZE)))))));
      (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
      (anno (((((v_g.(poffset)) / (ST_GRANULE_SIZE)) + (0)) = (((v_g.(poffset)) / (ST_GRANULE_SIZE)))));
      (Some (
        (((((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))  ,
        ((st.[log] :<
          ((EVT CPU_ID (REL ((v_g.(poffset)) / (ST_GRANULE_SIZE)) (((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
            (((EVT CPU_ID (ACQ ((v_g.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
          (sh.[granules] :< ((sh.(granules)) # ((v_g.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None))))
      )))))))))))
  | (Some cid) => None
  end))))).

Definition find_granule_spec_mid (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
  if ((v_addr & (4095)) =? (0))
  then (
    if ((v_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some ((mkPtr "null" 0), st))
    else (
      rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
      (Some ((mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE))))), st))))
  else (Some ((mkPtr "null" 0), st)).

Definition sort_granules_spec_mid (v_granules: Ptr) (v_n: Z) (st: RData) : (option RData) :=
  rely (((v_granules.(pbase)) = ("find_lock_two_granules_stack")));
  (anno (((40 + (0)) = (40)));
  (anno (((40 + (8)) = (48)));
  (anno (((40 * (1)) = (40)));
  (anno (((16 + (0)) = (16)));
  (anno (((40 + (16)) = (56)));
  (anno (((40 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  if (
    (((((st.(stack)).(find_lock_two_granules_stack)) @ ((v_granules.(poffset)) + (8))) -
      ((((st.(stack)).(find_lock_two_granules_stack)) @ ((v_granules.(poffset)) + (48))))) >?
      (0)))
  then (
    (anno (((40 * (1)) = (40)));
    (anno (((40 + (0)) = (40)));
    (anno (((1 - (0)) = (1)));
    (anno (((0 + (0)) = (0)));
    (anno (((8 + (0)) = (8)));
    (anno (((0 + (8)) = (8)));
    (anno (((40 * (0)) = (0)));
    (anno (((16 + (0)) = (16)));
    (anno (((0 + (16)) = (16)));
    (anno ((((v_granules.(poffset)) + (0)) = ((v_granules.(poffset)))));
    (Some ((st.[stack].[find_lock_two_granules_stack] :<
      ((((st.(stack)).(find_lock_two_granules_stack)) # (v_granules.(poffset)) == (((st.(stack)).(find_lock_two_granules_stack)) @ ((v_granules.(poffset)) + (40)))) #
        ((v_granules.(poffset)) + (8)) ==
        (((st.(stack)).(find_lock_two_granules_stack)) @ ((v_granules.(poffset)) + (48))))).[stack].[sort_granules_stack] :<
      ((st.(stack)).(sort_granules_stack)))))))))))))))
  else (
    (anno (((1 - (1)) = (0)));
    (Some st))))))))))).

Definition addr_to_granule_spec_mid (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
  (Some ((mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE))))), st)).

