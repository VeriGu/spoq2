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
        (((((((st.(stack)).(stack_gs0)).[e_gset_addr] :< v_addr1).[e_gset_g] :< 0).[e_gset_g_ret] :< 18446744073705422848).[e_gset_idx] :< 0).[e_gset_state] :<
          v_expected_state1)).[stack].[stack_gs1] :<
        (((((((st.(stack)).(stack_gs1)).[e_gset_addr] :< v_addr2).[e_gset_g] :< 0).[e_gset_g_ret] :< 18446744073705426944).[e_gset_idx] :< 1).[e_gset_state] :<
          v_expected_state2)))
  ) with
  | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
    rely (((v_granules_0.(poffset)) = (0)));
    rely (((v_granules_0.(pbase)) = ("stack_gs")));
    if __return__
    then (Some (__retval__, st_3))
    else (
      if (v_i_144 >? (0))
      then (
        if (((v_granules_0.(poffset)) + ((((40 * ((v_i_144 + ((- 1))))) / (40)) + (0)))) =? (0))
        then (
          rely (
            ((((((st_3.(stack)).(stack_gs0)).(e_gset_g)) > (0)) /\ ((((((st_3.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_3.(stack)).(stack_gs0)).(e_gset_g)) - (18446744073705226240)) < (0)))));
          when cid == (((((st_3.(share)).(granules)) @ (((((st_3.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (false, (lens 11 st_3))))
        else (
          rely (
            ((((((st_3.(stack)).(stack_gs1)).(e_gset_g)) > (0)) /\ ((((((st_3.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_3.(stack)).(stack_gs1)).(e_gset_g)) - (18446744073705226240)) < (0)))));
          when cid == (((((st_3.(share)).(granules)) @ (((((st_3.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (false, (lens 11 st_3)))))
      else (Some (false, st_3)))
  | None => None
  end.
