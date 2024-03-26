Definition smc_granule_delegate_spec (v_addr: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_addr & (4095)) =? (0))
  then (
    if ((v_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match (((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock))) with
      | None =>
        if (((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_state)) =? (0))
        then (
          if (
            match (((((st.(share)).(granules)) @ ((v_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
            | (Some cid) => true
            | None => false
            end)
          then (
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            (Some (
              0  ,
              (((((lens 416 st).[share].[gpt] :< (((st.(share)).(gpt)) # (v_addr / (GRANULE_SIZE)) == true)).[share].[granule_data] :<
                (((st.(share)).(granule_data)) #
                  (v_addr / (GRANULE_SIZE)) ==
                  ((((st.(share)).(granule_data)) @ (v_addr / (GRANULE_SIZE))).[g_norm] :< zero_granule_data_normal))).[share].[granules] :<
                ((((lens 406 st).(share)).(granules)) # (v_addr / (GRANULE_SIZE)) == (((((lens 406 st).(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                ((((st.(share)).(slots)) # SLOT_DELEGATED == (v_addr / (GRANULE_SIZE))) # SLOT_DELEGATED == (- 1)))
            )))
          else None)
        else (
          (Some (
            1  ,
            (((lens 407 st).[log] :<
              ((EVT CPU_ID (REL (v_addr / (GRANULE_SIZE)) (((((lens 406 st).(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                (((lens 407 st).(log))))).[share].[granules] :<
              ((((lens 406 st).(share)).(granules)) # (v_addr / (GRANULE_SIZE)) == (((((lens 406 st).(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< None)))
          )))
      | (Some cid) => None
      end))
  else (Some (1, st)).

Definition smc_granule_undelegate_spec (v_addr: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_addr & (4095)) =? (0))
  then (
    if ((v_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match (((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock))) with
      | None =>
        if ((((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_state)) - (1)) =? (0))
        then (
          if (
            match (((((st.(share)).(granules)) @ ((v_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
            | (Some cid) => true
            | None => false
            end)
          then (
            (Some (
              0  ,
              (((lens 422 st).[share].[gpt] :< (((st.(share)).(gpt)) # (v_addr / (GRANULE_SIZE)) == false)).[share].[granules] :<
                ((((lens 406 st).(share)).(granules)) # (v_addr / (GRANULE_SIZE)) == (((((lens 406 st).(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< None)))
            )))
          else None)
        else (
          (Some (
            1  ,
            (((lens 407 st).[log] :<
              ((EVT CPU_ID (REL (v_addr / (GRANULE_SIZE)) (((((lens 406 st).(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                (((lens 407 st).(log))))).[share].[granules] :<
              ((((lens 406 st).(share)).(granules)) # (v_addr / (GRANULE_SIZE)) == (((((lens 406 st).(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< None)))
          )))
      | (Some cid) => None
      end))
  else (Some (1, st)).

