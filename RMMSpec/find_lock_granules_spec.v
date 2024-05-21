Fixpoint find_lock_granules_loop197 (_N_: nat) (__break__: bool) (v_granules: Ptr) (v_i_241: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_granules, v_i_241, st))
  | (S _N__0) =>
    match ((find_lock_granules_loop197 _N__0 __break__ v_granules v_i_241 st)) with
    | (Some (__break___0, v_granules_0, v_i_242, st_0)) =>
      if __break___0
      then (Some (true, v_granules_0, v_i_242, st_0))
      else (
        rely (((v_granules_0.(poffset)) = (0)));
        rely (((v_granules_0.(pbase)) = ("stack_gs")));
        if ((((v_granules_0.(poffset)) + (((40 * (v_i_242)) + (24)))) / (40)) =? (0))
        then (
          rely (
            ((((((st_0.(stack)).(stack_gs0)).(e_gset_g)) > (0)) /\ ((((((st_0.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_0.(stack)).(stack_gs0)).(e_gset_g)) - (18446744073705226240)) < (0)))));
          rely ((((((st_0.(stack)).(stack_gs0)).(e_gset_g_ret)) > (0)) /\ ((((- 48) + ((((((st_0.(stack)).(stack_gs0)).(e_gset_g_ret)) - (STACK_VIRT)) / (GRANULE_SIZE)))) = (0)))));
          (Some (false, v_granules_0, (v_i_242 + (1)), (st_0.[stack].[stack_g0] :< (((st_0.(stack)).(stack_gs0)).(e_gset_g))))))
        else (
          rely (
            ((((((st_0.(stack)).(stack_gs1)).(e_gset_g)) > (0)) /\ ((((((st_0.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_0.(stack)).(stack_gs1)).(e_gset_g)) - (18446744073705226240)) < (0)))));
          rely ((((((st_0.(stack)).(stack_gs1)).(e_gset_g_ret)) > (0)) /\ ((((- 49) + ((((((st_0.(stack)).(stack_gs1)).(e_gset_g_ret)) - (STACK_VIRT)) / (GRANULE_SIZE)))) = (0)))));
          if ((v_i_242 + (1)) <>? (2))
          then (Some (false, v_granules_0, (v_i_242 + (1)), (st_0.[stack].[stack_g1] :< (((st_0.(stack)).(stack_gs1)).(e_gset_g)))))
          else (Some (true, v_granules_0, v_i_242, (st_0.[stack].[stack_g1] :< (((st_0.(stack)).(stack_gs1)).(e_gset_g)))))))
    | None => None
    end
  end.

Fixpoint find_lock_granules_loop0 (_N_: nat) (__return__: bool) (__retval__: bool) (__break__: bool) (v_granules: Ptr) (v_i_143: Z) (st: RData) : (option (bool * bool * bool * Ptr * Z * RData)) :=
  match (_N_) with
  | O => (Some (__return__, __retval__, __break__, v_granules, v_i_143, st))
  | (S _N__0) =>
    match ((find_lock_granules_loop0 _N__0 __return__ __retval__ __break__ v_granules v_i_143 st)) with
    | (Some (__return___0, __retval___0, __break___0, v_granules_0, v_i_144, st_0)) =>
      if __break___0
      then (Some (__return___0, __retval___0, true, v_granules_0, v_i_144, st_0))
      else (
        if __return___0
        then (Some (true, __retval___0, false, v_granules_0, v_i_144, st_0))
        else (
          rely (((v_granules_0.(poffset)) = (0)));
          rely (((v_granules_0.(pbase)) = ("stack_gs")));
          if (v_i_144 =? (0))
          then (
            if (((((st_0.(stack)).(stack_gs0)).(e_gset_addr)) & (4095)) =? (0))
            then (
              if (((((st_0.(stack)).(stack_gs0)).(e_gset_addr)) / (GRANULE_SIZE)) >? (1048575))
              then (Some (false, __retval___0, true, v_granules_0, v_i_144, (st_0.[stack].[stack_gs0] :< (((st_0.(stack)).(stack_gs0)).[e_gset_g] :< 0))))
              else (
                rely ((((0 - (((((st_0.(stack)).(stack_gs0)).(e_gset_addr)) / (GRANULE_SIZE)))) <= (0)) /\ ((((((st_0.(stack)).(stack_gs0)).(e_gset_addr)) / (GRANULE_SIZE)) < (1048576)))));
                rely (
                  ((((((st_0.(share)).(granules)) @ ((((st_0.(stack)).(stack_gs0)).(e_gset_addr)) / (GRANULE_SIZE))).(e_state)) - ((((st_0.(stack)).(stack_gs0)).(e_gset_state)))) =?
                    (0)));
                when sh == (((st_0.(repl)) ((st_0.(oracle)) (st_0.(log))) (st_0.(share))));
                if (
                  match ((((((lens 6 st_0).(share)).(granules)) @ ((((st_0.(stack)).(stack_gs0)).(e_gset_addr)) / (GRANULE_SIZE))).(e_lock))) with
                  | (Some cid) => true
                  | None => false
                  end)
                then (
                  (Some (
                    false  ,
                    __retval___0  ,
                    false  ,
                    v_granules_0  ,
                    1  ,
                    ((lens 8 st_0).[stack].[stack_gs0] :<
                      (((st_0.(stack)).(stack_gs0)).[e_gset_g] :< (GRANULES_BASE + ((16 * (((((st_0.(stack)).(stack_gs0)).(e_gset_addr)) / (GRANULE_SIZE))))))))
                  )))
                else None))
            else (Some (false, __retval___0, true, v_granules_0, v_i_144, (st_0.[stack].[stack_gs0] :< (((st_0.(stack)).(stack_gs0)).[e_gset_g] :< 0)))))
          else (
            if (((((st_0.(stack)).(stack_gs1)).(e_gset_addr)) - ((((st_0.(stack)).(stack_gs0)).(e_gset_addr)))) =? (0))
            then (Some (false, __retval___0, true, v_granules_0, v_i_144, st_0))
            else (
              if (((((st_0.(stack)).(stack_gs1)).(e_gset_addr)) & (4095)) =? (0))
              then (
                if (((((st_0.(stack)).(stack_gs1)).(e_gset_addr)) / (GRANULE_SIZE)) >? (1048575))
                then (Some (false, __retval___0, true, v_granules_0, v_i_144, (st_0.[stack].[stack_gs1] :< (((st_0.(stack)).(stack_gs1)).[e_gset_g] :< 0))))
                else (
                  rely ((((0 - (((((st_0.(stack)).(stack_gs1)).(e_gset_addr)) / (GRANULE_SIZE)))) <= (0)) /\ ((((((st_0.(stack)).(stack_gs1)).(e_gset_addr)) / (GRANULE_SIZE)) < (1048576)))));
                  rely (
                    ((((((st_0.(share)).(granules)) @ ((((st_0.(stack)).(stack_gs1)).(e_gset_addr)) / (GRANULE_SIZE))).(e_state)) - ((((st_0.(stack)).(stack_gs1)).(e_gset_state)))) =?
                      (0)));
                  when sh == (((st_0.(repl)) ((st_0.(oracle)) (st_0.(log))) (st_0.(share))));
                  if (
                    match ((((((lens 6 st_0).(share)).(granules)) @ ((((st_0.(stack)).(stack_gs1)).(e_gset_addr)) / (GRANULE_SIZE))).(e_lock))) with
                    | (Some cid) => true
                    | None => false
                    end)
                  then (
                    if ((v_i_144 + (1)) <? (2))
                    then (
                      (Some (
                        false  ,
                        __retval___0  ,
                        false  ,
                        v_granules_0  ,
                        1  ,
                        ((lens 8 st_0).[stack].[stack_gs1] :<
                          (((st_0.(stack)).(stack_gs1)).[e_gset_g] :< (GRANULES_BASE + ((16 * (((((st_0.(stack)).(stack_gs1)).(e_gset_addr)) / (GRANULE_SIZE))))))))
                      )))
                    else (
                      match (
                        match (
                          match (
                            (find_lock_granules_loop197
                              (z_to_nat 2)
                              false
                              v_granules_0
                              0
                              ((lens 8 st_0).[stack].[stack_gs1] :<
                                (((st_0.(stack)).(stack_gs1)).[e_gset_g] :< (GRANULES_BASE + ((16 * (((((st_0.(stack)).(stack_gs1)).(e_gset_addr)) / (GRANULE_SIZE)))))))))
                          ) with
                          | (Some (break___2, v_granules_1, v_i_244, st_8)) =>
                            rely (((v_granules_1.(poffset)) = (0)));
                            rely (((v_granules_1.(pbase)) = ("stack_gs")));
                            if break___2
                            then (Some (true, false, true, true, (mkPtr "#" 0), (mkPtr "#" 0), true, false, false, (mkPtr "#" 0), (mkPtr "#" 0), v_i_144, v_i_244, 0, st_8))
                            else None
                          | None => None
                          end
                        ) with
                        | (Some (break___2, __continue___0, return___1, retval___1, v_8, v_10, v_11, v_cmp235_0, v_exitcond_0, v_g30_0, v_g_ret_0, v_i_145, v_i_242, v_inc33_0, st_8)) =>
                          if return___1
                          then (
                            (Some (
                              break___2  ,
                              __continue___0  ,
                              true  ,
                              retval___1  ,
                              v_8  ,
                              v_10  ,
                              v_11  ,
                              false  ,
                              v_cmp235_0  ,
                              v_exitcond_0  ,
                              v_g30_0  ,
                              v_g_ret_0  ,
                              v_i_145  ,
                              v_i_242  ,
                              (v_i_144 + (1))  ,
                              v_inc33_0  ,
                              st_8
                            )))
                          else (
                            if break___2
                            then (
                              (Some (
                                true  ,
                                __continue___0  ,
                                false  ,
                                retval___1  ,
                                v_8  ,
                                v_10  ,
                                v_11  ,
                                false  ,
                                v_cmp235_0  ,
                                v_exitcond_0  ,
                                v_g30_0  ,
                                v_g_ret_0  ,
                                v_i_145  ,
                                v_i_242  ,
                                (v_i_144 + (1))  ,
                                v_inc33_0  ,
                                st_8
                              )))
                            else (Some (false, true, false, retval___1, v_8, v_10, v_11, false, v_cmp235_0, v_exitcond_0, v_g30_0, v_g_ret_0, v_i_145, v_i_242, (v_i_144 + (1)), v_inc33_0, st_8)))
                        | None => None
                        end
                      ) with
                      | (Some (break___2, __continue__, return___1, retval___1, v_8, v_8, v_9, v_cmp2, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_145, v_i_241, v_inc23, v_inc33, st_8)) => (Some (return___1, retval___1, break___2, v_granules_0, v_i_145, st_8))
                      | None => None
                      end))
                  else None))
              else (Some (false, __retval___0, true, v_granules_0, v_i_144, (st_0.[stack].[stack_gs1] :< (((st_0.(stack)).(stack_gs1)).[e_gset_g] :< 0))))))))
    | None => None
    end
  end.

Definition find_lock_granules_spec (v_granules: Ptr) (v_n: Z) (st: RData) : (option (bool * RData)) :=
  rely (((v_granules.(poffset)) = (0)));
  rely (((v_granules.(pbase)) = ("stack_gs")));
  match (
    (find_lock_granules_loop0
      (z_to_nat 2)
      false
      false
      false
      v_granules
      0
      ((st.[stack].[stack_gs0] :< (((st.(stack)).(stack_gs0)).[e_gset_idx] :< 0)).[stack].[stack_gs1] :< (((st.(stack)).(stack_gs1)).[e_gset_idx] :< 1)))
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

Definition find_lock_granules_loop197_rank (v_granules: Ptr) (v_i_241: Z) : Z :=
  (2 - (v_i_241)).

Definition find_lock_granules_loop0_rank (v_granules: Ptr) (v_i_143: Z) : Z :=
  (2 - (v_i_143)).
