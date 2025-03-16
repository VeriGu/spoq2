Definition find_lock_two_granules_spec (v_addr1: Z) (v_expected_state1: Z) (v_g1: Ptr) (v_addr2: Z) (v_expected_state2: Z) (v_g2: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (((v_g2.(poffset)) = (0)));
  rely (((v_g2.(pbase)) = ("stack_g1")));
  rely (((v_g1.(poffset)) = (0)));
  rely (((v_g1.(pbase)) = ("stack_g0")));
  match (
    (find_lock_granules_loop0
      (z_to_nat 2)
      false
      false
      false
      (mkPtr "stack_gs" 0)
      0
      ((st.[stack].[stack_gs0] :<
        (((((((st.(stack)).(stack_gs0)).[e_gset_addr] :< v_addr1).[e_gset_g] :< 0).[e_gset_g_ret] :<
          ((STACK_VIRT + (((STACK_g0 - (STACK_slot_ofs)) * (GRANULE_SIZE)))) + ((v_g1.(poffset))))).[e_gset_idx] :<
          0).[e_gset_state] :<
          v_expected_state1)).[stack].[stack_gs1] :<
        (((((((st.(stack)).(stack_gs1)).[e_gset_addr] :< v_addr2).[e_gset_g] :< 0).[e_gset_g_ret] :<
          ((STACK_VIRT + (((STACK_g1 - (STACK_slot_ofs)) * (GRANULE_SIZE)))) + ((v_g2.(poffset))))).[e_gset_idx] :<
          1).[e_gset_state] :<
          v_expected_state2)))
  ) with
  | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_4)) =>
    rely (((v_granules_0.(poffset)) = (0)));
    rely (((v_granules_0.(pbase)) = ("stack_gs")));
    if __return__
    then (Some (__retval__, st_4))
    else (
      if (v_i_144 >? (0))
      then (
        if ((((v_granules_0.(poffset)) / (40)) + (((40 * ((v_i_144 + ((- 1))))) / (40)))) =? (0))
        then (
          rely (
            ((((((st_4.(stack)).(stack_gs0)).(e_gset_g)) > (0)) /\ ((((((st_4.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_4.(stack)).(stack_gs0)).(e_gset_g)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
          when cid == (((((st_4.(share)).(granules)) @ (((((st_4.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (
            (xorb true true)  ,
            ((st_4.[log] :<
              ((EVT
                CPU_ID
                (REL
                  (((((st_4.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                  (((st_4.(share)).(granules)) @ (((((st_4.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                ((st_4.(log))))).[share].[granules] :<
              (((st_4.(share)).(granules)) #
                (((((st_4.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                ((((st_4.(share)).(granules)) @ (((((st_4.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
          )))
        else (
          rely (
            ((((((st_4.(stack)).(stack_gs1)).(e_gset_g)) > (0)) /\ ((((((st_4.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_4.(stack)).(stack_gs1)).(e_gset_g)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
          when cid == (((((st_4.(share)).(granules)) @ (((((st_4.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (
            (xorb true true)  ,
            ((st_4.[log] :<
              ((EVT
                CPU_ID
                (REL
                  (((((st_4.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                  (((st_4.(share)).(granules)) @ (((((st_4.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                ((st_4.(log))))).[share].[granules] :<
              (((st_4.(share)).(granules)) #
                (((((st_4.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                ((((st_4.(share)).(granules)) @ (((((st_4.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
          ))))
      else (Some ((xorb true true), st_4)))
  | None => None
  end.

Definition find_lock_unused_granule_spec (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
  if ((v_addr & (4095)) =? (0))
  then (
    if ((v_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some ((mkPtr "status" 1), st))
    else (
      rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
      rely (((((((st.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) = (0)));
      when st1 == ((query_oracle st));
      match (((((st1.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock))) with
      | None =>
        rely (
          ((((((st.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) -
            (((((st1.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)))) =
            (0)));
        if (((((st1.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_refcount)) =? (0))
        then (
          (Some (
            (mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE)))))  ,
            ((st1.[log] :< ((EVT CPU_ID (ACQ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))).[share].[granules] :<
              (((st1.(share)).(granules)) #
                ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                ((((st1.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))))
          )))
        else (
          (Some (
            (mkPtr "status" 5)  ,
            ((st1.[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                  ((((st1.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
              (((st1.(share)).(granules)) #
                ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                ((((st1.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
          )))
      | (Some cid) => None
      end))
  else (Some ((mkPtr "status" 1), st)).

