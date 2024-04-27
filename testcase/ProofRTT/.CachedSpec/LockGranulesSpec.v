Definition find_lock_two_granules_spec (v_addr1: Z) (v_expected_state1: Z) (v_g1: Ptr) (v_addr2: Z) (v_expected_state2: Z) (v_g2: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (((v_g1.(pbase)) = ((v_g2.(pbase)))));
  rely (
    ((((((v_g2.(pbase)) = ("smc_rec_create_stack")) \/ (((v_g2.(pbase)) = ("smc_psci_complete_stack")))) \/ (((v_g2.(pbase)) = ("smc_rtt_create_stack")))) \/
      (((v_g2.(pbase)) = ("data_create_stack")))) \/
      (((v_g2.(pbase)) = ("smc_rtt_set_ripas_stack")))));
  if ((v_g1.(pbase)) =s ("smc_psci_complete_stack"))
  then (
    match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 2438 st))) with
    | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
      rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
      if __return__
      then (Some (__retval__, (lens 2441 st_3)))
      else (
        if (v_i_144 >? (0))
        then (
          rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
          rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
          when cid == (
              ((((st_3.(share)).(granules)) @
                (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (false, (lens 2535 st_3))))
        else (Some (false, (lens 2585 st_3))))
    | None => None
    end)
  else (
    if ((v_g1.(pbase)) =s ("smc_rec_create_stack"))
    then (
      match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 3303 st))) with
      | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
        rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
        if __return__
        then (Some (__retval__, (lens 3306 st_3)))
        else (
          if (v_i_144 >? (0))
          then (
            rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
            rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
            when cid == (
                ((((st_3.(share)).(granules)) @
                  (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (Some (false, (lens 3400 st_3))))
          else (Some (false, (lens 3450 st_3))))
      | None => None
      end)
    else (
      if ((v_g1.(pbase)) =s ("smc_rtt_set_ripas_stack"))
      then (
        match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 4168 st))) with
        | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
          rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
          if __return__
          then (Some (__retval__, (lens 4171 st_3)))
          else (
            if (v_i_144 >? (0))
            then (
              rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
              rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
              when cid == (
                  ((((st_3.(share)).(granules)) @
                    (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
              (Some (false, (lens 4265 st_3))))
            else (Some (false, (lens 4315 st_3))))
        | None => None
        end)
      else (
        if ((v_g1.(pbase)) =s ("smc_rtt_create_stack"))
        then (
          match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 5033 st))) with
          | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
            rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
            if __return__
            then (Some (__retval__, (lens 5036 st_3)))
            else (
              if (v_i_144 >? (0))
              then (
                rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
                rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
                when cid == (
                    ((((st_3.(share)).(granules)) @
                      (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some (false, (lens 5130 st_3))))
              else (Some (false, (lens 5180 st_3))))
          | None => None
          end)
        else (
          match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 5898 st))) with
          | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
            rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
            if __return__
            then (Some (__retval__, (lens 5901 st_3)))
            else (
              if (v_i_144 >? (0))
              then (
                rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
                rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
                when cid == (
                    ((((st_3.(share)).(granules)) @
                      (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some (false, (lens 5995 st_3))))
              else (Some (false, (lens 6045 st_3))))
          | None => None
          end)))).

Definition find_lock_unused_granule_spec (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
  if ((v_addr & (4095)) =? (0))
  then (
    if ((v_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some ((mkPtr "status" 1), st))
    else (
      rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match (((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock))) with
      | None =>
        if ((((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
        then (
          if (
            if ((((((st.(share)).(granules)) @ ((v_addr / (GRANULE_SIZE)) + (24))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
            then true
            else (
              match ((((((lens 1135 st).(share)).(granules)) @ ((v_addr / (GRANULE_SIZE)) + (24))).(e_lock))) with
              | (Some cid) => true
              | None => false
              end))
          then (
            if ((((((lens 1135 st).(share)).(granules)) @ ((v_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) =? (0))
            then (Some ((mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE))))), (lens 1135 st)))
            else (Some ((mkPtr "status" 5), (lens 1332 st))))
          else None)
        else (Some ((mkPtr "status" 1), (lens 1137 st)))
      | (Some cid) => None
      end))
  else (Some ((mkPtr "status" 1), st)).

