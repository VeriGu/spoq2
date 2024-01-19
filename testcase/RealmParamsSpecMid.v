Definition get_realm_params_spec_mid (v_realm_params: Ptr) (v_realm_params_addr: Z) (st: RData) : (option (bool * RData)) :=
  rely (((v_realm_params.(pbase)) = ("smc_realm_create_stack")));
  if ((v_realm_params_addr & (4095)) =? (0))
  then (
    if ((v_realm_params_addr / (GRANULE_SIZE)) >? (1048575))
    then (
      (anno (((0 - (0)) = (0)));
      (Some (false, st))))
    else (
      rely ((((0 - ((v_realm_params_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_realm_params_addr / (GRANULE_SIZE)) < (1048576)))));
      (anno (((16 * (0)) = (0)));
      (anno (((4 + (0)) = (4)));
      (anno (((0 + (4)) = (4)));
      (anno ((((16 * ((v_realm_params_addr / (GRANULE_SIZE)))) + (4)) = ((4 * (((4 * ((v_realm_params_addr / (GRANULE_SIZE)))) + (1)))))));
      (anno (((4 * (((4 * ((v_realm_params_addr / (GRANULE_SIZE)))) + (1)))) = ((4 + ((16 * ((v_realm_params_addr / (GRANULE_SIZE)))))))));
      (anno ((((4 + ((16 * ((v_realm_params_addr / (GRANULE_SIZE)))))) / (ST_GRANULE_SIZE)) = ((v_realm_params_addr / (GRANULE_SIZE)))));
      rely (
        match (((((st.(share)).(granules)) @ (v_realm_params_addr / (GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => (true = (true))
        | _ => (false = (true))
        end);
      (anno ((((16 * ((v_realm_params_addr / (GRANULE_SIZE)))) + (4)) = ((4 * (((4 * ((v_realm_params_addr / (GRANULE_SIZE)))) + (1)))))));
      (anno (((4 * (((4 * ((v_realm_params_addr / (GRANULE_SIZE)))) + (1)))) = ((4 + ((16 * ((v_realm_params_addr / (GRANULE_SIZE)))))))));
      (anno ((((4 + ((16 * ((v_realm_params_addr / (GRANULE_SIZE)))))) / (ST_GRANULE_SIZE)) = ((v_realm_params_addr / (GRANULE_SIZE)))));
      if (((((st.(share)).(granules)) @ (v_realm_params_addr / (GRANULE_SIZE))).(e_state)) =? (0))
      then (
        (anno ((((16 * ((v_realm_params_addr / (GRANULE_SIZE)))) mod (ST_GRANULE_SIZE)) = (0)));
        rely (
          (((((0 = (0)) /\ ((0 = (0)))) /\ (("granules" = ("granules")))) /\ ((0 = (0)))) /\
            ((((0 = (0)) /\ (((0 = (0)) /\ (("granules" = ("granules")))))) /\ ((((0 <= (24)) /\ ((0 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
        (anno ((((16 * ((v_realm_params_addr / (GRANULE_SIZE)))) >> (4)) = ((v_realm_params_addr / (GRANULE_SIZE)))));
        when v_call5, st_1 == (
            (memcpy_ns_read_spec_state_oracle
              v_realm_params 
              (mkPtr "slot_ns" 0) 
              4096 
              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == (v_realm_params_addr / (GRANULE_SIZE))))));
        (anno (((- 1) = ((- 1))));
        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1)))))))))
      else (Some (false, st)))))))))))))
  else (
    (anno (((0 - (0)) = (0)));
    (Some (false, st)))).

Definition validate_realm_params_spec_mid (v_p: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (((v_p.(pbase)) = ("smc_realm_create_stack")));
  (anno (((4096 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno ((((v_p.(poffset)) + (0)) = ((v_p.(poffset)))));
  when ret == ((validate_feature_register_spec' 0 (((st.(stack)).(smc_realm_create_stack)) @ (v_p.(poffset))) st));
  rely ((ret = (false)));
  (Some (false, st))))).

