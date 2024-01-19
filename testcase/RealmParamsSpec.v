Definition get_realm_params_spec (v_realm_params: Ptr) (v_realm_params_addr: Z) (st: RData) : (option (bool * RData)) :=
  rely (((v_realm_params.(pbase)) = ("smc_realm_create_stack")));
  if ((v_realm_params_addr & (4095)) =? (0))
  then (
    if ((v_realm_params_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (false, st))
    else (
      rely (
        ((((0 - ((v_realm_params_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_realm_params_addr / (GRANULE_SIZE)) < (1048576)))) /\
          (match (((((st.(share)).(granules)) @ (v_realm_params_addr / (GRANULE_SIZE))).(e_lock))) with
          | (Some cid) => (true = (true))
          | _ => (false = (true))
          end)));
      if (((((st.(share)).(granules)) @ (v_realm_params_addr / (GRANULE_SIZE))).(e_state)) =? (0))
      then (
        rely (
          (((((0 = (0)) /\ ((0 = (0)))) /\ (("granules" = ("granules")))) /\ ((0 = (0)))) /\
            ((((0 = (0)) /\ (((0 = (0)) /\ (("granules" = ("granules")))))) /\ ((((0 <= (24)) /\ ((0 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
        when v_call5, st_1 == (
            (memcpy_ns_read_spec_state_oracle
              v_realm_params 
              (mkPtr "slot_ns" 0) 
              4096 
              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == (v_realm_params_addr / (GRANULE_SIZE))))));
        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
      else (Some (false, st))))
  else (Some (false, st)).

Definition validate_realm_params_spec (v_p: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (((v_p.(pbase)) = ("smc_realm_create_stack")));
  when ret == ((validate_feature_register_spec' 0 (((st.(stack)).(smc_realm_create_stack)) @ (v_p.(poffset))) st));
  rely ((ret = (false)));
  (Some (false, st)).

