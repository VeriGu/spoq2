Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import ExceptionOps.Spec.
Require Import Bottom.Spec.
Require Import ValidateTable.Spec.
Require Import LockGranules.Spec.
Require Import S2TTCreate.Spec.
Require Import S2TTEDesc.Spec.
Require Import TableAux.Spec.
Require Import TableWalk.Spec.
Require Import ValidateAddr.Spec.
Require Import S2TTEDesc.Spec.
Require Import S2TTEOps.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_Spec.

  Context `{int_ptr: IntPtrCast}.

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
                  ((((((st_0.(share)).(granules)) @ ((((st_0.(stack)).(stack_gs0)).(e_gset_addr)) / (GRANULE_SIZE))).(e_state)) - ((((st_0.(stack)).(stack_gs0)).(e_gset_state)))) =
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
                    ((((((st_0.(share)).(granules)) @ ((((st_0.(stack)).(stack_gs1)).(e_gset_addr)) / (GRANULE_SIZE))).(e_state)) - ((((st_0.(stack)).(stack_gs1)).(e_gset_state)))) =
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
                      | (Some (break___2, __continue__, return___1, retval___1, v_8, _v_8, v_9, v_cmp2, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_145, v_i_241, v_inc23, v_inc33, st_8)) => (Some (return___1, retval___1, break___2, v_granules_0, v_i_145, st_8))
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

Fixpoint rtt_walk_lock_unlock_loop370 (_N_: nat) (__return__: bool) (__break__: bool) (v_g_tbls: Ptr) (v_indvars_iv: Z) (v_level: Z) (v_map_addr: Z) (v_wi: Ptr) (st: RData) : (option (bool * bool * Ptr * Z * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
  | (S _N__0) =>
    match ((rtt_walk_lock_unlock_loop370 _N__0 __return__ __break__ v_g_tbls v_indvars_iv v_level v_map_addr v_wi st)) with
    | (Some (__return___0, __break___0, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_0)) =>
      if __break___0
      then (Some (__return___0, true, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_0))
      else (
        if __return___0
        then (Some (true, false, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_0))
        else (
          rely (((v_wi_0.(poffset)) = (0)));
          rely (((v_wi_0.(pbase)) = ("stack_wi")));
          rely (((v_g_tbls_0.(poffset)) = (0)));
          rely (((v_g_tbls_0.(pbase)) = ("stack_g_tbls")));
          rely ((((0 - (v_indvars_iv_0)) <= (0)) /\ ((v_indvars_iv_0 < (4)))));
          rely (
            ((((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) > (0)) /\
              ((((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (18446744073705226240)) < (0)))));
          rely (((((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          when cid == (((((st_0.(share)).(granules)) @ (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))).(e_lock)));
          if (
            (((((((st_0.(share)).(granule_data)) @ (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
              (3)) =?
              (3)))
          then (
            rely (
              (((0 -
                ((((((((st_0.(share)).(granule_data)) @ (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
                  (281474976710655)) /
                  (GRANULE_SIZE)))) <=
                (0)) /\
                (((((((((st_0.(share)).(granule_data)) @ (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
                  (281474976710655)) /
                  (GRANULE_SIZE)) <
                  (1048576)))));
            rely (
              ((((((st_0.(share)).(granules)) @
                ((16 *
                  ((((((((st_0.(share)).(granule_data)) @ (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
                    (281474976710655)) /
                    (GRANULE_SIZE)))) /
                  (ST_GRANULE_SIZE))).(e_state)) -
                (6)) =
                (0)));
            when sh == (
                ((st_0.(repl))
                  ((st_0.(oracle)) (st_0.(log)))
                  ((st_0.(share)).[slots] :<
                    ((((st_0.(share)).(slots)) #
                      SLOT_RTT ==
                      (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))) #
                      SLOT_RTT ==
                      (- 1)))));
            rely ((((0 - ((v_indvars_iv_0 + (1)))) <= (0)) /\ (((v_indvars_iv_0 + (1)) < (4)))));
            if (((v_indvars_iv_0 + (1)) - (v_level_0)) <? (0))
            then (
              (Some (
                false  ,
                false  ,
                v_g_tbls_0  ,
                (v_indvars_iv_0 + (1))  ,
                v_level_0  ,
                v_map_addr_0  ,
                v_wi_0  ,
                (((lens 66 st_0).[share].[slots] :<
                  ((((st_0.(share)).(slots)) #
                    SLOT_RTT ==
                    (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))) #
                    SLOT_RTT ==
                    (- 1))).[stack].[stack_g_tbls] :<
                  (((st_0.(stack)).(stack_g_tbls)) #
                    ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * ((v_indvars_iv_0 + (1)))) / (8)) + (0)))))) ==
                    (GRANULES_BASE +
                      ((16 *
                        ((((((((st_0.(share)).(granule_data)) @ (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
                          (281474976710655)) /
                          (GRANULE_SIZE))))))))
              )))
            else (
              (Some (
                false  ,
                true  ,
                v_g_tbls_0  ,
                v_indvars_iv_0  ,
                v_level_0  ,
                v_map_addr_0  ,
                v_wi_0  ,
                (((lens 66 st_0).[share].[slots] :<
                  ((((st_0.(share)).(slots)) #
                    SLOT_RTT ==
                    (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))) #
                    SLOT_RTT ==
                    (- 1))).[stack].[stack_g_tbls] :<
                  (((st_0.(stack)).(stack_g_tbls)) #
                    ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * ((v_indvars_iv_0 + (1)))) / (8)) + (0)))))) ==
                    (GRANULES_BASE +
                      ((16 *
                        ((((((((st_0.(share)).(granule_data)) @ (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
                          (281474976710655)) /
                          (GRANULE_SIZE))))))))
              ))))
          else (
            rely ((((0 - ((v_indvars_iv_0 + (1)))) <= (0)) /\ (((v_indvars_iv_0 + (1)) < (4)))));
            (Some (
              true  ,
              false  ,
              v_g_tbls_0  ,
              v_indvars_iv_0  ,
              v_level_0  ,
              v_map_addr_0  ,
              v_wi_0  ,
              (((st_0.[share].[slots] :<
                ((((st_0.(share)).(slots)) #
                  SLOT_RTT ==
                  (((((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0))))))) - (GRANULES_BASE)) >> (4))) #
                  SLOT_RTT ==
                  (- 1))).[stack].[stack_g_tbls] :<
                (((st_0.(stack)).(stack_g_tbls)) # ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * ((v_indvars_iv_0 + (1)))) / (8)) + (0)))))) == 0)).[stack].[stack_wi] :<
                (((((st_0.(stack)).(stack_wi)).[e_g_llt] :< (((st_0.(stack)).(stack_g_tbls)) @ ((v_g_tbls_0.(poffset)) + ((0 + ((((8 * (v_indvars_iv_0)) / (8)) + (0)))))))).[e_index] :<
                  ((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))).[e_last_level] :<
                  v_indvars_iv_0))
            )))))
    | None => None
    end
  end.

Definition rtt_walk_lock_unlock_spec (v_g_root: Ptr) (v_start_level: Z) (v_ipa_bits: Z) (v_map_addr: Z) (v_level: Z) (v_wi: Ptr) (st: RData) : (option RData) :=
  rely ((v_start_level < (4)));
  rely ((v_start_level >= (0)));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_g_root.(pbase)) = ("granules")));
  if ((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((39 + (((- 9) * (v_start_level)))))) >? (511))
  then (
    rely (
      ((((((st.(share)).(granules)) @
        (((v_g_root.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((39 + (((- 9) * (v_start_level)))))) >> (9)) & (4294967295)))))) /
          (ST_GRANULE_SIZE))).(e_state)) -
        (6)) =
        (0)));
    rely ((((v_g_root.(poffset)) mod (16)) = (0)));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    if ((v_start_level - (v_level)) <? (0))
    then (
      match (
        (rtt_walk_lock_unlock_loop370
          (z_to_nat v_level)
          false
          false
          (mkPtr "stack_g_tbls" 0)
          v_start_level
          v_level
          v_map_addr
          v_wi
          ((lens 105 st).[stack].[stack_g_tbls] :<
            ((ZMap.init 0) #
              v_start_level ==
              (GRANULES_BASE +
                (((v_g_root.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((39 + (((- 9) * (v_start_level)))))) >> (9)) & (4294967295)))))))))))
      ) with
      | (Some (__return___0, __break__, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_8)) =>
        rely (((v_wi_0.(poffset)) = (0)));
        rely (((v_wi_0.(pbase)) = ("stack_wi")));
        rely (((v_g_tbls_0.(poffset)) = (0)));
        rely (((v_g_tbls_0.(pbase)) = ("stack_g_tbls")));
        if __return___0
        then (Some st_8)
        else (
          rely ((((0 - (v_level)) <= (0)) /\ ((v_level < (4)))));
          rely (
            ((((((st_8.(stack)).(stack_g_tbls)) @ v_level) > (0)) /\ ((((((st_8.(stack)).(stack_g_tbls)) @ v_level) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_8.(stack)).(stack_g_tbls)) @ v_level) - (18446744073705226240)) < (0)))));
          (Some (st_8.[stack].[stack_wi] :<
            (((((st_8.(stack)).(stack_wi)).[e_g_llt] :< (((st_8.(stack)).(stack_g_tbls)) @ v_level)).[e_index] :<
              ((v_map_addr >> (((39 + ((38654705655 * (v_level)))) & (4294967295)))) & (511))).[e_last_level] :<
              v_level))))
      | None => None
      end)
    else (
      rely ((((0 - (v_level)) <= (0)) /\ ((v_level < (4)))));
      rely (
        ((((((ZMap.init 0) #
          v_start_level ==
          (GRANULES_BASE +
            (((v_g_root.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((39 + (((- 9) * (v_start_level)))))) >> (9)) & (4294967295))))))))) @ v_level) >
          (0)) /\
          ((((((ZMap.init 0) #
            v_start_level ==
            (GRANULES_BASE +
              (((v_g_root.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((39 + (((- 9) * (v_start_level)))))) >> (9)) & (4294967295))))))))) @ v_level) -
            (GRANULES_BASE)) >=
            (0)))) /\
          ((((((ZMap.init 0) #
            v_start_level ==
            (GRANULES_BASE +
              (((v_g_root.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((39 + (((- 9) * (v_start_level)))))) >> (9)) & (4294967295))))))))) @ v_level) -
            (18446744073705226240)) <
            (0)))));
      (Some (((lens 105 st).[stack].[stack_g_tbls] :<
        ((ZMap.init 0) #
          v_start_level ==
          (GRANULES_BASE +
            (((v_g_root.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((39 + (((- 9) * (v_start_level)))))) >> (9)) & (4294967295)))))))))).[stack].[stack_wi] :<
        (((((st.(stack)).(stack_wi)).[e_g_llt] :<
          (((ZMap.init 0) #
            v_start_level ==
            (GRANULES_BASE +
              (((v_g_root.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((39 + (((- 9) * (v_start_level)))))) >> (9)) & (4294967295))))))))) @ v_level)).[e_index] :<
          ((v_map_addr >> (((39 + ((38654705655 * (v_level)))) & (4294967295)))) & (511))).[e_last_level] :<
          v_level)))))
  else (
    if ((v_start_level - (v_level)) <? (0))
    then (
      match (
        (rtt_walk_lock_unlock_loop370
          (z_to_nat v_level)
          false
          false
          (mkPtr "stack_g_tbls" 0)
          v_start_level
          v_level
          v_map_addr
          v_wi
          (st.[stack].[stack_g_tbls] :< ((ZMap.init 0) # v_start_level == (GRANULES_BASE + ((v_g_root.(poffset)))))))
      ) with
      | (Some (__return___0, __break__, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_6)) =>
        rely (((v_wi_0.(poffset)) = (0)));
        rely (((v_wi_0.(pbase)) = ("stack_wi")));
        rely (((v_g_tbls_0.(poffset)) = (0)));
        rely (((v_g_tbls_0.(pbase)) = ("stack_g_tbls")));
        if __return___0
        then (Some st_6)
        else (
          rely ((((0 - (v_level)) <= (0)) /\ ((v_level < (4)))));
          rely (
            ((((((st_6.(stack)).(stack_g_tbls)) @ v_level) > (0)) /\ ((((((st_6.(stack)).(stack_g_tbls)) @ v_level) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_6.(stack)).(stack_g_tbls)) @ v_level) - (18446744073705226240)) < (0)))));
          (Some (st_6.[stack].[stack_wi] :<
            (((((st_6.(stack)).(stack_wi)).[e_g_llt] :< (((st_6.(stack)).(stack_g_tbls)) @ v_level)).[e_index] :<
              ((v_map_addr >> (((39 + ((38654705655 * (v_level)))) & (4294967295)))) & (511))).[e_last_level] :<
              v_level))))
      | None => None
      end)
    else (
      rely ((((0 - (v_level)) <= (0)) /\ ((v_level < (4)))));
      rely (
        ((((((ZMap.init 0) # v_start_level == (GRANULES_BASE + ((v_g_root.(poffset))))) @ v_level) > (0)) /\
          ((((((ZMap.init 0) # v_start_level == (GRANULES_BASE + ((v_g_root.(poffset))))) @ v_level) - (GRANULES_BASE)) >= (0)))) /\
          ((((((ZMap.init 0) # v_start_level == (GRANULES_BASE + ((v_g_root.(poffset))))) @ v_level) - (18446744073705226240)) < (0)))));
      (Some ((st.[stack].[stack_g_tbls] :< ((ZMap.init 0) # v_start_level == (GRANULES_BASE + ((v_g_root.(poffset)))))).[stack].[stack_wi] :<
        (((((st.(stack)).(stack_wi)).[e_g_llt] :< (((ZMap.init 0) # v_start_level == (GRANULES_BASE + ((v_g_root.(poffset))))) @ v_level)).[e_index] :<
          ((v_map_addr >> (((39 + ((38654705655 * (v_level)))) & (4294967295)))) & (511))).[e_last_level] :<
          v_level))))).

Definition rtt_walk_lock_unlock_loop370_rank (v_g_tbls: Ptr) (v_indvars_iv: Z) (v_level: Z) (v_map_addr: Z) (v_wi: Ptr) : Z :=
  v_level.

Fixpoint __table_is_uniform_block_loop777 (_N_: nat) (__break__: bool) (v_cmp_not: bool) (v_indvars_iv: Z) (v_retval_0: bool) (v_ripas_0: Z) (v_ripas_ptr: Ptr) (v_table: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * bool * Z * bool * Z * Ptr * Ptr * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_cmp_not, v_indvars_iv, v_retval_0, v_ripas_0, v_ripas_ptr, v_table, v_s2tte_is_x, st))
  | (S _N__0) =>
    match ((__table_is_uniform_block_loop777 _N__0 __break__ v_cmp_not v_indvars_iv v_retval_0 v_ripas_0 v_ripas_ptr v_table v_s2tte_is_x st)) with
    | (Some (__break___0, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)) =>
      if __break___0
      then (Some (true, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
      else (
        rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
        rely (((v_s2tte_is_x_0.(poffset)) = (0)));
        rely (((v_table_0.(pbase)) = ("slot_rtt2")));
        rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
        when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
        if ((v_s2tte_is_x_0.(pbase)) =s ("s2tte_is_unassigned"))
        then (
          if (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (3)) =? (0))
          then (
            if (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (60)) =? (0))
            then (
              if v_cmp_not_0
              then (
                if ((v_indvars_iv_0 + (1)) <>? (512))
                then (Some (false, true, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                else (Some (true, true, v_indvars_iv_0, true, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
              else (
                if (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (64)) =? (0))
                then (
                  if ((0 - (v_ripas_1)) =? (0))
                  then (
                    if ((v_indvars_iv_0 + (1)) <>? (512))
                    then (Some (false, false, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                    else None)
                  else (Some (true, false, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
                else (
                  if ((1 - (v_ripas_1)) =? (0))
                  then (
                    if ((v_indvars_iv_0 + (1)) <>? (512))
                    then (Some (false, false, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                    else None)
                  else (Some (true, false, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))))
            else (Some (true, v_cmp_not_0, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
          else (Some (true, v_cmp_not_0, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
        else (
          if (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (3)) =? (0))
          then (
            if (
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (60)) - (8)) =?
                (0)))
            then (
              if v_cmp_not_0
              then (
                if ((v_indvars_iv_0 + (1)) <>? (512))
                then (Some (false, true, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                else (Some (true, true, v_indvars_iv_0, true, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
              else (
                if (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (64)) =? (0))
                then (
                  if ((0 - (v_ripas_1)) =? (0))
                  then (
                    if ((v_indvars_iv_0 + (1)) <>? (512))
                    then (Some (false, false, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                    else None)
                  else (Some (true, false, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
                else (
                  if ((1 - (v_ripas_1)) =? (0))
                  then (
                    if ((v_indvars_iv_0 + (1)) <>? (512))
                    then (Some (false, false, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                    else None)
                  else (Some (true, false, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))))
            else (Some (true, v_cmp_not_0, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
          else (Some (true, v_cmp_not_0, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))))
    | None => None
    end
  end.

  Fixpoint __table_maps_block_loop840 (_N_: nat) (__break__: bool) (v_call: Z) (v_call3: Z) (v_i_015: Z) (v_level: Z) (v_retval_0: bool) (v_table: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * bool * Ptr * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st))
    | (S _N__0) =>
      match ((__table_maps_block_loop840 _N__0 __break__ v_call v_call3 v_i_015 v_level v_retval_0 v_table v_s2tte_is_x st)) with
      | (Some (__break___0, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_0)) =>
        rely ((__break___0 = (true)));
        (Some (true, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_0))
      | None => None
      end
    end.

Definition smc_rtt_fold_1 (v_call1_0: Ptr) (v_s2_ctx: Ptr) (v_call: Ptr) (v_map_addr: Z) (v_ulevel: Z) (v_wi: Ptr) (st_6: RData) : (option (Z * RData)) :=
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_call1_0.(poffset)) = (0)));
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely (((v_call.(pbase)) = ("granules")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  when cid == (((((st_6.(share)).(granules)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(e_lock)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    (((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
      (((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
  rely (
    ((((((st_6.(share)).(granules)) @ ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
      (6)) =
      (0)));
  rely (((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
  when sh == (((st_6.(repl)) ((st_6.(oracle)) (st_6.(log))) ((st_6.(share)).[slots] :< (((st_6.(share)).(slots)) # SLOT_RD == (- 1)))));
  if (
    match (
      (((((lens 88 st_6).(share)).(granules)) @
        (1152921504605528063 + ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))
    ) with
    | (Some cid_0) => true
    | None => false
    end)
  then (
    when st_15 == (
        (rtt_walk_lock_unlock_spec
          (mkPtr "granules" (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
          ((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
          ((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
          v_map_addr
          (v_ulevel + ((- 1)))
          v_wi
          (((lens 92 st_6).[share].[slots] :< (((st_6.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[stack_s2_ctx] :<
            (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)))));
    (Some ((((st_15.(stack)).(stack_wi)).(e_last_level)), st_15)))
  else None.

Definition smc_rtt_fold_2 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_call44: Z) (v_call33: Ptr) (st_0: RData) (st_33: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_call33.(pbase)) = ("granules")));
  when cid == (((((st_33.(share)).(granules)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  when cid_0 == (((((st_33.(share)).(granules)) @ (((st_33.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
  rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match (((((st_33.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid_1) => true
    | None => false
    end)
  then (
    when cid_1 == (((((st_33.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call34.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((v_call15.(poffset)) = (0)));
    rely (((((((st_33.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_33.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
    (Some (
      0  ,
      (((lens 99 st_33).[share].[granule_data] :<
        ((((st_33.(share)).(granule_data)) #
          (((st_33.(share)).(slots)) @ SLOT_RTT) ==
          ((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
              ((v_call15.(poffset)) + ((8 * ((((st_33.(stack)).(stack_wi)).(e_index)))))) ==
              v_call44))) #
          (((st_33.(share)).(slots)) @ SLOT_RTT2) ==
          (((((st_33.(share)).(granule_data)) #
            (((st_33.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call15.(poffset)) + ((8 * ((((st_33.(stack)).(stack_wi)).(e_index)))))) ==
                v_call44))) @ (((st_33.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
            zero_granule_data_normal))).[share].[slots] :<
        ((((st_33.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
    )))
  else None.

Definition smc_rtt_fold_3 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_call44: Z) (v_call33: Ptr) (st_0: RData) (st_34: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_call33.(pbase)) = ("granules")));
  when cid == (((((st_34.(share)).(granules)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  when cid_0 == (((((st_34.(share)).(granules)) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
  rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match (((((st_34.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid_1) => true
    | None => false
    end)
  then (
    when cid_1 == (((((st_34.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call34.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((v_call15.(poffset)) = (0)));
    rely (((((((st_34.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_34.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
    (Some (
      0  ,
      (((lens 106 st_34).[share].[granule_data] :<
        ((((st_34.(share)).(granule_data)) #
          (((st_34.(share)).(slots)) @ SLOT_RTT) ==
          ((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
              ((v_call15.(poffset)) + ((8 * ((((st_34.(stack)).(stack_wi)).(e_index)))))) ==
              v_call44))) #
          (((st_34.(share)).(slots)) @ SLOT_RTT2) ==
          (((((st_34.(share)).(granule_data)) #
            (((st_34.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call15.(poffset)) + ((8 * ((((st_34.(stack)).(stack_wi)).(e_index)))))) ==
                v_call44))) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
            zero_granule_data_normal))).[share].[slots] :<
        ((((st_34.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
    )))
  else None.

Definition smc_rtt_fold_4 (v_ripas: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call44: Z) (v_ulevel: Z) (st_28: RData) : (option (bool * RData)) :=
  rely (((v_ripas.(pbase)) = ("stack_ripas")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  if (((st_28.(stack)).(stack_ripas)) =? (0))
  then (
    if ((v_wi.(poffset)) =? (0))
    then (
      rely (((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
      if (
        if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
        then true
        else (
          match (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end))
      then (
        when cid == (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
        if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
        then None
        else (
          (Some (
            false  ,
            ((lens 17 st_28).[share].[granule_data] :<
              (((st_28.(share)).(granule_data)) #
                (((st_28.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call15.(poffset)) + ((8 * ((((st_28.(stack)).(stack_wi)).(e_index)))))) ==
                    0))))
          ))))
      else None)
    else (
      if ((v_wi.(poffset)) =? (8))
      then (
        rely (((((((st_28.(stack)).(stack_wi)).(e_index)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_index)) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_index)))) mod (ST_GRANULE_SIZE)) = (8)))));
        if (
          if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
          then true
          else (
            match (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_lock))) with
            | (Some cid) => true
            | None => false
            end))
        then (
          when cid == (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_lock)));
          if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
          then None
          else (
            (Some (
              false  ,
              ((lens 17 st_28).[share].[granule_data] :<
                (((st_28.(share)).(granule_data)) #
                  (((st_28.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call15.(poffset)) + ((8 * ((((st_28.(stack)).(stack_wi)).(e_last_level)))))) ==
                      0))))
            ))))
        else None)
      else (
        if ((v_wi.(poffset)) =? (16))
        then (
          rely (((((((st_28.(stack)).(stack_wi)).(e_last_level)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_last_level)) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_last_level)))) mod (ST_GRANULE_SIZE)) = (8)))));
          None)
        else None)))
  else (
    if ((v_wi.(poffset)) =? (0))
    then (
      rely (((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
      if (
        if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
        then true
        else (
          match (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end))
      then (
        when cid == (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
        if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
        then None
        else (
          (Some (
            false  ,
            ((lens 17 st_28).[share].[granule_data] :<
              (((st_28.(share)).(granule_data)) #
                (((st_28.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call15.(poffset)) + ((8 * ((((st_28.(stack)).(stack_wi)).(e_index)))))) ==
                    0))))
          ))))
      else None)
    else (
      if ((v_wi.(poffset)) =? (8))
      then (
        rely (((((((st_28.(stack)).(stack_wi)).(e_index)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_index)) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_index)))) mod (ST_GRANULE_SIZE)) = (8)))));
        if (
          if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
          then true
          else (
            match (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_lock))) with
            | (Some cid) => true
            | None => false
            end))
        then (
          when cid == (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_lock)));
          if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
          then None
          else (
            (Some (
              false  ,
              ((lens 17 st_28).[share].[granule_data] :<
                (((st_28.(share)).(granule_data)) #
                  (((st_28.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call15.(poffset)) + ((8 * ((((st_28.(stack)).(stack_wi)).(e_last_level)))))) ==
                      0))))
            ))))
        else None)
      else (
        if ((v_wi.(poffset)) =? (16))
        then (
          rely (((((((st_28.(stack)).(stack_wi)).(e_last_level)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_last_level)) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_last_level)))) mod (ST_GRANULE_SIZE)) = (8)))));
          if (
            if (
              ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_last_level)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =?
                (0)))
            then true
            else (
              match (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_last_level)) / (ST_GRANULE_SIZE))))).(e_lock))) with
              | (Some cid) => true
              | None => false
              end))
          then (
            when cid == (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_last_level)) / (ST_GRANULE_SIZE))))).(e_lock)));
            None)
          else None)
        else None))).

Definition smc_rtt_fold_5 (v_call34: Ptr) (v_call33: Ptr) (v_call15: Ptr) (v_wi: Ptr) (st_0: RData) (st_28: RData) : (option (Z * RData)) :=
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_call33.(pbase)) = ("granules")));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call34.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  when cid == (((((st_28.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call15.(poffset)) = (0)));
  rely (((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  (Some (5, ((lens 109 st_28).[share].[slots] :< ((((st_28.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))))).

Definition smc_rtt_fold_6 (v_call34: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_ulevel: Z) (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call33: Ptr) (v_ripas: Ptr) (st_0: RData) (st_26: RData) : (option (Z * RData)) :=
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_call33.(pbase)) = ("granules")));
  rely (((v_ripas.(pbase)) = ("stack_ripas")));
  when cid == (((((st_26.(share)).(granules)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
  if (((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (0))
  then (
    if ((((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (60)) - (8)) =? (0))
    then (
      match ((__table_is_uniform_block_loop777 (z_to_nat 511) false true 1 false 0 (mkPtr "null" 0) v_call34 (mkPtr "s2tte_is_destroyed" 0) st_26)) with
      | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_1, v_s2tte_is_x_0, st_3)) =>
        rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
        rely (((v_s2tte_is_x_0.(poffset)) = (0)));
        rely (((v_table_1.(pbase)) = ("slot_rtt2")));
        rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
        if v_retval_1
        then (
          rely (((((((st_3.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_3.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_3.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
          if (
            if ((((((st_3.(share)).(granules)) @ ((18446744073688449016 + ((((st_3.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
            then true
            else (
              match (((((st_3.(share)).(granules)) @ ((18446744073688449016 + ((((st_3.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
              | (Some cid_0) => true
              | None => false
              end))
          then (
            when cid_0 == (((((st_3.(share)).(granules)) @ ((18446744073688449016 + ((((st_3.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
            if ((((((st_3.(share)).(granules)) @ ((18446744073688449016 + ((((st_3.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
            then None
            else (
              (smc_rtt_fold_3
                v_s2_ctx
                v_map_addr
                v_wi
                v_call15
                v_call34
                8
                v_call33
                st_0
                ((lens 17 st_3).[share].[granule_data] :<
                  (((st_3.(share)).(granule_data)) #
                    (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                    ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                      (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                        ((v_call15.(poffset)) + ((8 * ((((st_3.(stack)).(stack_wi)).(e_index)))))) ==
                        0)))))))
          else None)
        else (
          when cid_0 == (((((st_3.(share)).(granules)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
          if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (0))
          then (
            if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (60)) =? (0))
            then (
              if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (64)) =? (0))
              then (
                match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 0 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_3)) with
                | (Some (__break___0, v_cmp_not_1, v_indvars_iv_1, v_retval_2, v_ripas_2, v_ripas_ptr_1, v_table_2, v_s2tte_is_x_1, st_4)) =>
                  rely (((v_ripas_ptr_1.(pbase)) = ("smc_rtt_fold_stack")));
                  rely (((v_s2tte_is_x_1.(poffset)) = (0)));
                  rely (((v_table_2.(pbase)) = ("slot_rtt2")));
                  rely ((((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_destroyed")))));
                  if v_retval_2
                  then (
                    if (((st_4.(stack)).(stack_ripas)) =? (0))
                    then (
                      rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        when cid_1 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                        then None
                        else (
                          (smc_rtt_fold_3
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            0
                            v_call33
                            st_0
                            ((lens 17 st_4).[share].[granule_data] :<
                              (((st_4.(share)).(granule_data)) #
                                (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                                    0)))))))
                      else None)
                    else (
                      rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        when cid_1 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                        then None
                        else (
                          (smc_rtt_fold_3
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            64
                            v_call33
                            st_0
                            ((lens 17 st_4).[share].[granule_data] :<
                              (((st_4.(share)).(granule_data)) #
                                (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                                    0)))))))
                      else None))
                  else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_4)
                | None => None
                end)
              else (
                match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 1 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_3)) with
                | (Some (__break___0, v_cmp_not_1, v_indvars_iv_1, v_retval_2, v_ripas_2, v_ripas_ptr_1, v_table_2, v_s2tte_is_x_1, st_4)) =>
                  rely (((v_ripas_ptr_1.(pbase)) = ("smc_rtt_fold_stack")));
                  rely (((v_s2tte_is_x_1.(poffset)) = (0)));
                  rely (((v_table_2.(pbase)) = ("slot_rtt2")));
                  rely ((((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_destroyed")))));
                  if v_retval_2
                  then (
                    if (((st_4.(stack)).(stack_ripas)) =? (0))
                    then (
                      rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        when cid_1 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                        then None
                        else (
                          (smc_rtt_fold_3
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            0
                            v_call33
                            st_0
                            ((lens 17 st_4).[share].[granule_data] :<
                              (((st_4.(share)).(granule_data)) #
                                (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                                    0)))))))
                      else None)
                    else (
                      rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        when cid_1 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                        then None
                        else (
                          (smc_rtt_fold_3
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            64
                            v_call33
                            st_0
                            ((lens 17 st_4).[share].[granule_data] :<
                              (((st_4.(share)).(granule_data)) #
                                (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                                    0)))))))
                      else None))
                  else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_4)
                | None => None
                end))
            else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_3))
          else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_3))
      | None => None
      end)
    else (
      if (((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (60)) =? (0))
      then (
        if (((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (64)) =? (0))
        then (
          match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 0 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_26)) with
          | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_1, v_s2tte_is_x_0, st_4)) =>
            rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
            rely (((v_s2tte_is_x_0.(poffset)) = (0)));
            rely (((v_table_1.(pbase)) = ("slot_rtt2")));
            rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
            if v_retval_1
            then (
              if (((st_4.(stack)).(stack_ripas)) =? (0))
              then (
                rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                if (
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                  then true
                  else (
                    match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end))
                then (
                  when cid_0 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                  then None
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      0
                      v_call33
                      st_0
                      ((lens 17 st_4).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))
                else None)
              else (
                rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                if (
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                  then true
                  else (
                    match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end))
                then (
                  when cid_0 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                  then None
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      64
                      v_call33
                      st_0
                      ((lens 17 st_4).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))
                else None))
            else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_4)
          | None => None
          end)
        else (
          match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 1 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_26)) with
          | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_1, v_s2tte_is_x_0, st_4)) =>
            rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
            rely (((v_s2tte_is_x_0.(poffset)) = (0)));
            rely (((v_table_1.(pbase)) = ("slot_rtt2")));
            rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
            if v_retval_1
            then (
              if (((st_4.(stack)).(stack_ripas)) =? (0))
              then (
                rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                if (
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                  then true
                  else (
                    match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end))
                then (
                  when cid_0 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                  then None
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      0
                      v_call33
                      st_0
                      ((lens 17 st_4).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))
                else None)
              else (
                rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                if (
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                  then true
                  else (
                    match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end))
                then (
                  when cid_0 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                  then None
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      64
                      v_call33
                      st_0
                      ((lens 17 st_4).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))
                else None))
            else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_4)
          | None => None
          end))
      else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_26)))
  else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_26).

Definition smc_rtt_fold_7 (v_ulevel: Z) (v_call60: Z) (v_call33: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_s2_ctx: Ptr) (v_map_addr: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) :=
  rely (((v_call33.(pbase)) = ("granules")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
  if (
    if ((((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then true
    else (
      match (((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end))
  then (
    when cid == (((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
    then None
    else (
      if (((v_call60 |' (4)) & (36028797018963968)) =? (0))
      then (
        if (((v_ulevel + ((- 1))) =? (3)) && ((((v_call60 |' (4)) & (3)) =? (3))))
        then (
          (smc_rtt_fold_2
            v_s2_ctx
            v_map_addr
            v_wi
            v_call15
            v_call34
            (v_call60 |' (4))
            v_call33
            st_0
            ((lens 8 st_29).[share].[granule_data] :<
              (((st_29.(share)).(granule_data)) #
                (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                    0))))))
        else (
          if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (4)) & (3)) =? (1))))
          then (
            (smc_rtt_fold_2
              v_s2_ctx
              v_map_addr
              v_wi
              v_call15
              v_call34
              (v_call60 |' (4))
              v_call33
              st_0
              ((lens 8 st_29).[share].[granule_data] :<
                (((st_29.(share)).(granule_data)) #
                  (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                      0))))))
          else (
            (smc_rtt_fold_3
              v_s2_ctx
              v_map_addr
              v_wi
              v_call15
              v_call34
              (v_call60 |' (4))
              v_call33
              st_0
              ((lens 8 st_29).[share].[granule_data] :<
                (((st_29.(share)).(granule_data)) #
                  (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                      0))))))))
      else (
        if ((((v_call60 |' (4)) & (36028797018963968)) - (36028797018963968)) =? (0))
        then (
          if (((v_ulevel + ((- 1))) =? (3)) && ((((v_call60 |' (4)) & (3)) =? (3))))
          then (
            (smc_rtt_fold_2
              v_s2_ctx
              v_map_addr
              v_wi
              v_call15
              v_call34
              (v_call60 |' (4))
              v_call33
              st_0
              ((lens 8 st_29).[share].[granule_data] :<
                (((st_29.(share)).(granule_data)) #
                  (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                      0))))))
          else (
            if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (4)) & (3)) =? (1))))
            then (
              (smc_rtt_fold_2
                v_s2_ctx
                v_map_addr
                v_wi
                v_call15
                v_call34
                (v_call60 |' (4))
                v_call33
                st_0
                ((lens 8 st_29).[share].[granule_data] :<
                  (((st_29.(share)).(granule_data)) #
                    (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                    ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                      (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                        ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                        0))))))
            else (
              (smc_rtt_fold_3
                v_s2_ctx
                v_map_addr
                v_wi
                v_call15
                v_call34
                (v_call60 |' (4))
                v_call33
                st_0
                ((lens 8 st_29).[share].[granule_data] :<
                  (((st_29.(share)).(granule_data)) #
                    (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                    ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                      (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                        ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                        0))))))))
        else (
          (smc_rtt_fold_3
            v_s2_ctx
            v_map_addr
            v_wi
            v_call15
            v_call34
            (v_call60 |' (4))
            v_call33
            st_0
            ((lens 8 st_29).[share].[granule_data] :<
              (((st_29.(share)).(granule_data)) #
                (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                    0)))))))))
  else None.

Definition smc_rtt_fold_8 (v_call34: Ptr) (v_ulevel: Z) (v_call60: Z) (v_call33: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_s2_ctx: Ptr) (v_map_addr: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) :=
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_call33.(pbase)) = ("granules")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  when cid == (((((st_29.(share)).(granules)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
  if (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) =? (0))
  then (
    if ((v_ulevel =? (3)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (3))))
    then (
      if (
        (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
          (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
          (281474976710655)) &
          (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
          ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
            (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
          (0)))
      then (
        match (
          (__table_maps_block_loop840
            (z_to_nat 511)
            false
            (1 << ((39 + (((- 9) * (v_ulevel))))))
            (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
              (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
            1
            v_ulevel
            false
            v_call34
            (mkPtr "s2tte_is_valid" 0)
            st_29)
        ) with
        | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) =>
          rely (((v_s2tte_is_x_0.(poffset)) = (0)));
          rely (((v_table_1.(pbase)) = ("slot_rtt22")));
          rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
          if v_retval_2
          then (
            rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
            if (
              if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
              then true
              else (
                match (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                | (Some cid_0) => true
                | None => false
                end))
            then (
              when cid_0 == (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
              if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
              then None
              else (
                if (((v_call60 |' (2009)) & (36028797018963968)) =? (0))
                then (
                  if (((v_call60 |' (2009)) & (3)) =? (1))
                  then (
                    (smc_rtt_fold_2
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      (v_call60 |' (2009))
                      v_call33
                      st_0
                      ((lens 8 st_5).[share].[granule_data] :<
                        (((st_5.(share)).(granule_data)) #
                          (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                              0))))))
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      (v_call60 |' (2009))
                      v_call33
                      st_0
                      ((lens 8 st_5).[share].[granule_data] :<
                        (((st_5.(share)).(granule_data)) #
                          (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))
                else (
                  if ((((v_call60 |' (2009)) & (36028797018963968)) - (36028797018963968)) =? (0))
                  then (
                    if (((v_call60 |' (2009)) & (3)) =? (1))
                    then (
                      (smc_rtt_fold_2
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (2009))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0))))))
                    else (
                      (smc_rtt_fold_3
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (2009))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0)))))))
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      (v_call60 |' (2009))
                      v_call33
                      st_0
                      ((lens 8 st_5).[share].[granule_data] :<
                        (((st_5.(share)).(granule_data)) #
                          (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))))
            else None)
          else (
            when cid_0 == (((((st_5.(share)).(granules)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
            if (
              ((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) - (36028797018963968)) =?
                (0)))
            then (
              if (((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (3))
              then (
                if (
                  (((((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                    (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
                    (281474976710655)) &
                    (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
                    ((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                      (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
                    (0)))
                then (
                  match (
                    (__table_maps_block_loop840
                      (z_to_nat 511)
                      false
                      (1 << ((39 + (((- 9) * (v_ulevel))))))
                      (((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                        (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                      1
                      v_ulevel
                      false
                      v_call34
                      (mkPtr "s2tte_is_valid_ns" 0)
                      st_5)
                  ) with
                  | (Some (__break___0, v_call_1, v_call3_1, v_i_17, v_level_2, v_retval_3, v_table_2, v_s2tte_is_x_1, st_6)) =>
                    rely (((v_s2tte_is_x_1.(poffset)) = (0)));
                    rely (((v_table_2.(pbase)) = ("slot_rtt22")));
                    rely (((((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_valid_ns")))));
                    if v_retval_3
                    then (
                      rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        when cid_1 == (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                        if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
                        then None
                        else (
                          if (((v_call60 |' (54043195528446977)) & (36028797018963968)) =? (0))
                          then (
                            if (((v_call60 |' (54043195528446977)) & (3)) =? (1))
                            then (
                              (smc_rtt_fold_2
                                v_s2_ctx
                                v_map_addr
                                v_wi
                                v_call15
                                v_call34
                                (v_call60 |' (54043195528446977))
                                v_call33
                                st_0
                                ((lens 8 st_6).[share].[granule_data] :<
                                  (((st_6.(share)).(granule_data)) #
                                    (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                    ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                      (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                        ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                        0))))))
                            else (
                              (smc_rtt_fold_3
                                v_s2_ctx
                                v_map_addr
                                v_wi
                                v_call15
                                v_call34
                                (v_call60 |' (54043195528446977))
                                v_call33
                                st_0
                                ((lens 8 st_6).[share].[granule_data] :<
                                  (((st_6.(share)).(granule_data)) #
                                    (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                    ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                      (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                        ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                        0)))))))
                          else (
                            if ((((v_call60 |' (54043195528446977)) & (36028797018963968)) - (36028797018963968)) =? (0))
                            then (
                              if (((v_call60 |' (54043195528446977)) & (3)) =? (1))
                              then (
                                (smc_rtt_fold_2
                                  v_s2_ctx
                                  v_map_addr
                                  v_wi
                                  v_call15
                                  v_call34
                                  (v_call60 |' (54043195528446977))
                                  v_call33
                                  st_0
                                  ((lens 8 st_6).[share].[granule_data] :<
                                    (((st_6.(share)).(granule_data)) #
                                      (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                          0))))))
                              else (
                                (smc_rtt_fold_3
                                  v_s2_ctx
                                  v_map_addr
                                  v_wi
                                  v_call15
                                  v_call34
                                  (v_call60 |' (54043195528446977))
                                  v_call33
                                  st_0
                                  ((lens 8 st_6).[share].[granule_data] :<
                                    (((st_6.(share)).(granule_data)) #
                                      (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                          0)))))))
                            else (
                              (smc_rtt_fold_3
                                v_s2_ctx
                                v_map_addr
                                v_wi
                                v_call15
                                v_call34
                                (v_call60 |' (54043195528446977))
                                v_call33
                                st_0
                                ((lens 8 st_6).[share].[granule_data] :<
                                  (((st_6.(share)).(granule_data)) #
                                    (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                    ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                      (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                        ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                        0)))))))))
                      else None)
                    else (
                      when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_6));
                      (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))
                  | None => None
                  end)
                else (
                  when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                  (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
              else (
                when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
            else (
              when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
              (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
        | None => None
        end)
      else (
        when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
        (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
    else (
      if ((v_ulevel =? (2)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (1))))
      then (
        if (
          (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
            (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
            (281474976710655)) &
            (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
            ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
              (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
            (0)))
        then (
          match (
            (__table_maps_block_loop840
              (z_to_nat 511)
              false
              (1 << ((39 + (((- 9) * (v_ulevel))))))
              (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
              1
              v_ulevel
              false
              v_call34
              (mkPtr "s2tte_is_valid" 0)
              st_29)
          ) with
          | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) =>
            rely (((v_s2tte_is_x_0.(poffset)) = (0)));
            rely (((v_table_1.(pbase)) = ("slot_rtt22")));
            rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
            if v_retval_2
            then (
              rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
              if (
                if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                then true
                else (
                  match (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                  | (Some cid_0) => true
                  | None => false
                  end))
              then (
                when cid_0 == (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
                then None
                else (
                  if (((v_call60 |' (2009)) & (36028797018963968)) =? (0))
                  then (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      (v_call60 |' (2009))
                      v_call33
                      st_0
                      ((lens 8 st_5).[share].[granule_data] :<
                        (((st_5.(share)).(granule_data)) #
                          (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                              0))))))
                  else (
                    if ((((v_call60 |' (2009)) & (36028797018963968)) - (36028797018963968)) =? (0))
                    then (
                      if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (2009)) & (3)) =? (1))))
                      then (
                        (smc_rtt_fold_2
                          v_s2_ctx
                          v_map_addr
                          v_wi
                          v_call15
                          v_call34
                          (v_call60 |' (2009))
                          v_call33
                          st_0
                          ((lens 8 st_5).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                  0))))))
                      else (
                        (smc_rtt_fold_3
                          v_s2_ctx
                          v_map_addr
                          v_wi
                          v_call15
                          v_call34
                          (v_call60 |' (2009))
                          v_call33
                          st_0
                          ((lens 8 st_5).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                  0)))))))
                    else (
                      (smc_rtt_fold_3
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (2009))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0)))))))))
              else None)
            else (
              when cid_0 == (((((st_5.(share)).(granules)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
              if (
                ((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) - (36028797018963968)) =?
                  (0)))
              then (
                if (((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (1))
                then (
                  if (
                    (((((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                      (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
                      (281474976710655)) &
                      (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
                      ((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                        (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
                      (0)))
                  then (
                    match (
                      (__table_maps_block_loop840
                        (z_to_nat 511)
                        false
                        (1 << ((39 + (((- 9) * (v_ulevel))))))
                        (((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                          (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                        1
                        v_ulevel
                        false
                        v_call34
                        (mkPtr "s2tte_is_valid_ns" 0)
                        st_5)
                    ) with
                    | (Some (__break___0, v_call_1, v_call3_1, v_i_17, v_level_2, v_retval_3, v_table_2, v_s2tte_is_x_1, st_6)) =>
                      rely (((v_s2tte_is_x_1.(poffset)) = (0)));
                      rely (((v_table_2.(pbase)) = ("slot_rtt22")));
                      rely (((((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_valid_ns")))));
                      if v_retval_3
                      then (
                        rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                        if (
                          if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                          then true
                          else (
                            match (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                            | (Some cid_1) => true
                            | None => false
                            end))
                        then (
                          when cid_1 == (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                          if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
                          then None
                          else (
                            if (((v_call60 |' (54043195528446977)) & (36028797018963968)) =? (0))
                            then (
                              (smc_rtt_fold_3
                                v_s2_ctx
                                v_map_addr
                                v_wi
                                v_call15
                                v_call34
                                (v_call60 |' (54043195528446977))
                                v_call33
                                st_0
                                ((lens 8 st_6).[share].[granule_data] :<
                                  (((st_6.(share)).(granule_data)) #
                                    (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                    ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                      (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                        ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                        0))))))
                            else (
                              if ((((v_call60 |' (54043195528446977)) & (36028797018963968)) - (36028797018963968)) =? (0))
                              then (
                                if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (54043195528446977)) & (3)) =? (1))))
                                then (
                                  (smc_rtt_fold_2
                                    v_s2_ctx
                                    v_map_addr
                                    v_wi
                                    v_call15
                                    v_call34
                                    (v_call60 |' (54043195528446977))
                                    v_call33
                                    st_0
                                    ((lens 8 st_6).[share].[granule_data] :<
                                      (((st_6.(share)).(granule_data)) #
                                        (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                        ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                          (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                            ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                            0))))))
                                else (
                                  (smc_rtt_fold_3
                                    v_s2_ctx
                                    v_map_addr
                                    v_wi
                                    v_call15
                                    v_call34
                                    (v_call60 |' (54043195528446977))
                                    v_call33
                                    st_0
                                    ((lens 8 st_6).[share].[granule_data] :<
                                      (((st_6.(share)).(granule_data)) #
                                        (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                        ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                          (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                            ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                            0)))))))
                              else (
                                (smc_rtt_fold_3
                                  v_s2_ctx
                                  v_map_addr
                                  v_wi
                                  v_call15
                                  v_call34
                                  (v_call60 |' (54043195528446977))
                                  v_call33
                                  st_0
                                  ((lens 8 st_6).[share].[granule_data] :<
                                    (((st_6.(share)).(granule_data)) #
                                      (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                          0)))))))))
                        else None)
                      else (
                        when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_6));
                        (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))
                    | None => None
                    end)
                  else (
                    when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                    (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
                else (
                  when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                  (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
              else (
                when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
          | None => None
          end)
        else (
          when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
          (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
      else (
        when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
        (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))))
  else (
    if (
      ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) - (36028797018963968)) =?
        (0)))
    then (
      if ((v_ulevel =? (3)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (3))))
      then (
        if (
          (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
            (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
            (281474976710655)) &
            (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
            ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
              (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
            (0)))
        then (
          match (
            (__table_maps_block_loop840
              (z_to_nat 511)
              false
              (1 << ((39 + (((- 9) * (v_ulevel))))))
              (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
              1
              v_ulevel
              false
              v_call34
              (mkPtr "s2tte_is_valid_ns" 0)
              st_29)
          ) with
          | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) =>
            rely (((v_s2tte_is_x_0.(poffset)) = (0)));
            rely (((v_table_1.(pbase)) = ("slot_rtt22")));
            rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
            if v_retval_2
            then (
              rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
              if (
                if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                then true
                else (
                  match (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                  | (Some cid_0) => true
                  | None => false
                  end))
              then (
                when cid_0 == (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
                then None
                else (
                  if (((v_call60 |' (54043195528446977)) & (36028797018963968)) =? (0))
                  then (
                    if (((v_call60 |' (54043195528446977)) & (3)) =? (1))
                    then (
                      (smc_rtt_fold_2
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (54043195528446977))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0))))))
                    else (
                      (smc_rtt_fold_3
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (54043195528446977))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0)))))))
                  else (
                    if ((((v_call60 |' (54043195528446977)) & (36028797018963968)) - (36028797018963968)) =? (0))
                    then (
                      if (((v_call60 |' (54043195528446977)) & (3)) =? (1))
                      then (
                        (smc_rtt_fold_2
                          v_s2_ctx
                          v_map_addr
                          v_wi
                          v_call15
                          v_call34
                          (v_call60 |' (54043195528446977))
                          v_call33
                          st_0
                          ((lens 8 st_5).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                  0))))))
                      else (
                        (smc_rtt_fold_3
                          v_s2_ctx
                          v_map_addr
                          v_wi
                          v_call15
                          v_call34
                          (v_call60 |' (54043195528446977))
                          v_call33
                          st_0
                          ((lens 8 st_5).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                  0)))))))
                    else (
                      (smc_rtt_fold_3
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (54043195528446977))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0)))))))))
              else None)
            else (
              when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
              (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))
          | None => None
          end)
        else (
          when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
          (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
      else (
        if ((v_ulevel =? (2)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (1))))
        then (
          if (
            (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
              (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
              (281474976710655)) &
              (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
              ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
              (0)))
          then (
            match (
              (__table_maps_block_loop840
                (z_to_nat 511)
                false
                (1 << ((39 + (((- 9) * (v_ulevel))))))
                (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                  (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                1
                v_ulevel
                false
                v_call34
                (mkPtr "s2tte_is_valid_ns" 0)
                st_29)
            ) with
            | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) =>
              rely (((v_s2tte_is_x_0.(poffset)) = (0)));
              rely (((v_table_1.(pbase)) = ("slot_rtt22")));
              rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
              if v_retval_2
              then (
                rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                if (
                  if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                  then true
                  else (
                    match (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end))
                then (
                  when cid_0 == (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                  if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
                  then None
                  else (
                    if (((v_call60 |' (54043195528446977)) & (36028797018963968)) =? (0))
                    then (
                      (smc_rtt_fold_3
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (54043195528446977))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0))))))
                    else (
                      if ((((v_call60 |' (54043195528446977)) & (36028797018963968)) - (36028797018963968)) =? (0))
                      then (
                        if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (54043195528446977)) & (3)) =? (1))))
                        then (
                          (smc_rtt_fold_2
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            (v_call60 |' (54043195528446977))
                            v_call33
                            st_0
                            ((lens 8 st_5).[share].[granule_data] :<
                              (((st_5.(share)).(granule_data)) #
                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                    0))))))
                        else (
                          (smc_rtt_fold_3
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            (v_call60 |' (54043195528446977))
                            v_call33
                            st_0
                            ((lens 8 st_5).[share].[granule_data] :<
                              (((st_5.(share)).(granule_data)) #
                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                    0)))))))
                      else (
                        (smc_rtt_fold_3
                          v_s2_ctx
                          v_map_addr
                          v_wi
                          v_call15
                          v_call34
                          (v_call60 |' (54043195528446977))
                          v_call33
                          st_0
                          ((lens 8 st_5).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                  0)))))))))
                else None)
              else (
                when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))
            | None => None
            end)
          else (
            when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
            (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
        else (
          when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
          (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))))
    else (
      when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
      (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))).

Definition smc_rtt_fold_spec (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
    if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
      rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) = (0)));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      if (
        match ((((((lens 42 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end)
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when cid == ((((((lens 44 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)));
        if (
          ((v_ulevel >? (3)) ||
            ((((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) + (1)) - (v_ulevel)) >? (0)))))
        then (Some (1, ((lens 111 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))
        else (
          rely (((Some cid) = ((Some CPU_ID))));
          if (((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
          then (
            if ((((v_map_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) - (v_map_addr)) =? (0))
            then (
              when v_4, st_16 == (
                  (smc_rtt_fold_1
                    (mkPtr "slot_rd" 0)
                    (mkPtr "bad_stack" 0)
                    (mkPtr "granules" (16 * ((v_rd_addr / (GRANULE_SIZE)))))
                    v_map_addr
                    v_ulevel
                    (mkPtr "bad_stack" 0)
                    ((lens 44 st).[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))))));
              if ((v_4 - ((v_ulevel + ((- 1))))) =? (0))
              then (
                rely ((((DEFAULT_STACK_VAL - (STACK_VIRT)) < (0)) /\ (((DEFAULT_STACK_VAL - (GRANULES_BASE)) >= (0)))));
                rely (((DEFAULT_STACK_VAL mod (16)) = (0)));
                when cid_0 == (((((st_16.(share)).(granules)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))).(e_lock)));
                if (((((((st_16.(share)).(granule_data)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * (DEFAULT_STACK_VAL))) & (3)) =? (3))
                then (
                  if (
                    (((((((((st_16.(share)).(granule_data)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * (DEFAULT_STACK_VAL))) & (281474976710655)) &
                      (((- 1) << (12)))) -
                      (v_rtt_addr)) =?
                      (0)))
                  then (
                    rely ((((v_rtt_addr & (4095)) =? (0)) = (true)));
                    rely ((((v_rtt_addr / (GRANULE_SIZE)) >? (1048575)) = (false)));
                    rely ((((0 - ((v_rtt_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rtt_addr / (GRANULE_SIZE)) < (1048576)))));
                    rely (((((((st_16.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_state)) - (6)) = (0)));
                    when sh_0 == (
                        ((st_16.(repl))
                          ((st_16.(oracle)) (st_16.(log)))
                          ((st_16.(share)).[slots] :< (((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))))));
                    if (
                      match ((((((lens 112 st_16).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock))) with
                      | (Some cid_1) => true
                      | None => false
                      end)
                    then (
                      if (
                        match ((((((lens 113 st_16).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock))) with
                        | (Some cid_1) => true
                        | None => false
                        end)
                      then (
                        if ((((((lens 113 st_16).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_refcount)) =? (0))
                        then (
                          (smc_rtt_fold_6
                            (mkPtr "slot_rtt2" 0)
                            (mkPtr "bad_stack" 0)
                            (mkPtr "slot_rtt" 0)
                            v_ulevel
                            (mkPtr "bad_stack" 0)
                            v_map_addr
                            (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                            (mkPtr "bad_stack" 0)
                            st
                            ((lens 113 st_16).[share].[slots] :<
                              ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))))))
                        else (
                          if ((((((lens 113 st_16).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_refcount)) =? (512))
                          then (
                            if (v_ulevel <? (3))
                            then (
                              (Some (
                                5  ,
                                ((lens 117 st_16).[share].[slots] :<
                                  ((((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))) # SLOT_RTT2 == (- 1)) #
                                    SLOT_RTT ==
                                    (- 1)))
                              )))
                            else (
                              if (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (3)) =? (0))
                              then (
                                if ((((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (60)) - (4)) =? (0))
                                then (
                                  if (
                                    (((((((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                      (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
                                      (281474976710655)) &
                                      (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
                                      ((((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                        (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
                                      (0)))
                                  then (
                                    match (
                                      (__table_maps_block_loop840
                                        (z_to_nat 511)
                                        false
                                        (1 << ((39 + (((- 9) * (v_ulevel))))))
                                        (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                          (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                        1
                                        v_ulevel
                                        false
                                        (mkPtr "slot_rtt2" 0)
                                        (mkPtr "s2tte_is_assigned" 0)
                                        ((lens 113 st_16).[share].[slots] :<
                                          ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE)))))
                                    ) with
                                    | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) =>
                                      rely (((v_s2tte_is_x_0.(poffset)) = (0)));
                                      rely (((v_table_1.(pbase)) = ("slot_rtt22")));
                                      rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
                                      if v_retval_2
                                      then (
                                        (smc_rtt_fold_7
                                          v_ulevel
                                          (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                            (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                          (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                                          (mkPtr "bad_stack" 0)
                                          (mkPtr "slot_rtt" 0)
                                          (mkPtr "slot_rtt2" 0)
                                          (mkPtr "bad_stack" 0)
                                          v_map_addr
                                          st
                                          st_5))
                                      else (
                                        (smc_rtt_fold_8
                                          (mkPtr "slot_rtt2" 0)
                                          v_ulevel
                                          (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                            (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                          (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                                          (mkPtr "bad_stack" 0)
                                          (mkPtr "slot_rtt" 0)
                                          (mkPtr "slot_rtt2" 0)
                                          (mkPtr "bad_stack" 0)
                                          v_map_addr
                                          st
                                          st_5))
                                    | None => None
                                    end)
                                  else (
                                    (smc_rtt_fold_8
                                      (mkPtr "slot_rtt2" 0)
                                      v_ulevel
                                      (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                        (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                      (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                                      (mkPtr "bad_stack" 0)
                                      (mkPtr "slot_rtt" 0)
                                      (mkPtr "slot_rtt2" 0)
                                      (mkPtr "bad_stack" 0)
                                      v_map_addr
                                      st
                                      ((lens 113 st_16).[share].[slots] :<
                                        ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE)))))))
                                else (
                                  (smc_rtt_fold_8
                                    (mkPtr "slot_rtt2" 0)
                                    v_ulevel
                                    (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                      (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                    (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                                    (mkPtr "bad_stack" 0)
                                    (mkPtr "slot_rtt" 0)
                                    (mkPtr "slot_rtt2" 0)
                                    (mkPtr "bad_stack" 0)
                                    v_map_addr
                                    st
                                    ((lens 113 st_16).[share].[slots] :<
                                      ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE)))))))
                              else (
                                (smc_rtt_fold_8
                                  (mkPtr "slot_rtt2" 0)
                                  v_ulevel
                                  (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                    (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                  (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                                  (mkPtr "bad_stack" 0)
                                  (mkPtr "slot_rtt" 0)
                                  (mkPtr "slot_rtt2" 0)
                                  (mkPtr "bad_stack" 0)
                                  v_map_addr
                                  st
                                  ((lens 113 st_16).[share].[slots] :<
                                    ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))))))))
                          else (
                            (smc_rtt_fold_5
                              (mkPtr "slot_rtt2" 0)
                              (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                              (mkPtr "slot_rtt" 0)
                              (mkPtr "bad_stack" 0)
                              st
                              ((lens 113 st_16).[share].[slots] :<
                                ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))))))))
                      else None)
                    else None)
                  else (
                    when cid_1 == (((((st_16.(share)).(granules)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                    (Some (
                      ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
                      ((lens 118 st_16).[share].[slots] :< ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                    ))))
                else (
                  when cid_1 == (((((st_16.(share)).(granules)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
                    ((lens 119 st_16).[share].[slots] :< ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                  ))))
              else (
                rely ((((DEFAULT_STACK_VAL - (STACK_VIRT)) < (0)) /\ (((DEFAULT_STACK_VAL - (GRANULES_BASE)) >= (0)))));
                when cid_0 == (((((st_16.(share)).(granules)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some ((((((v_4 << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_4 << (32)) + (4)) & (4294967295)))), (lens 47 st_16)))))
            else (Some (1, ((lens 121 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
          else (Some (1, ((lens 123 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))))
      else None))
  else (Some (1, st)).

Fixpoint s2tt_init_assigned_empty_loop700 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_assigned_empty_loop700 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
      if __return___0
      then (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
      else (
        rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
        when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
        if ((v_indvars_iv_0 + (1)) <>? (512))
        then (
          (Some (
            false  ,
            v_call_0  ,
            (v_indvars_iv_0 + (1))  ,
            v_level_0  ,
            (v_pa_addr_6 + (v_call_0))  ,
            v_s2tt_0  ,
            (st_0.[share].[granule_data] :<
              (((st_0.(share)).(granule_data)) #
                (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                  (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                    ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                    (v_pa_addr_6 |' (4))))))
          )))
        else (
          (Some (
            true  ,
            v_call_0  ,
            v_indvars_iv_0  ,
            v_level_0  ,
            v_pa_addr_6  ,
            v_s2tt_0  ,
            (st_0.[share].[granule_data] :<
              (((st_0.(share)).(granule_data)) #
                (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                  (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                    ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                    (v_pa_addr_6 |' (4))))))
          ))))
    | None => None
    end
  end.

Fixpoint s2tt_init_unassigned_loop0 (_N_: nat) (__return__: bool) (v_call: Z) (v_index: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_index, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_unassigned_loop0 _N__0 __return__ v_call v_index v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_index_0, v_s2tt_0, st_0)) =>
      if __return___0
      then (Some (true, v_call_0, v_index_0, v_s2tt_0, st_0))
      else (
        rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
        when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
        if ((v_index_0 + (2)) =? (512))
        then (
          (Some (
            true  ,
            v_call_0  ,
            v_index_0  ,
            v_s2tt_0  ,
            (st_0.[share].[granule_data] :<
              (((st_0.(share)).(granule_data)) #
                (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                  ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_index_0)) + (0)))) == v_call_0) #
                    ((v_s2tt_0.(poffset)) + (((8 * ((v_index_0 + (1)))) + (0)))) ==
                    v_call_0))))
          )))
        else (
          (Some (
            false  ,
            v_call_0  ,
            (v_index_0 + (2))  ,
            v_s2tt_0  ,
            (st_0.[share].[granule_data] :<
              (((st_0.(share)).(granule_data)) #
                (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                  ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_index_0)) + (0)))) == v_call_0) #
                    ((v_s2tt_0.(poffset)) + (((8 * ((v_index_0 + (1)))) + (0)))) ==
                    v_call_0))))
          ))))
    | None => None
    end
  end.


Fixpoint s2tt_init_valid_ns_loop738 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_valid_ns_loop738 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
      if __return___0
      then (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
      else (
        rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
        if (v_level_0 =? (3))
        then (
          when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (
            (Some (
              false  ,
              v_call_0  ,
              (v_indvars_iv_0 + (1))  ,
              v_level_0  ,
              (v_pa_addr_6 + (v_call_0))  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (54043195528446979))))))
            )))
          else (
            (Some (
              true  ,
              v_call_0  ,
              v_indvars_iv_0  ,
              v_level_0  ,
              v_pa_addr_6  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (54043195528446979))))))
            ))))
        else (
          when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (
            (Some (
              false  ,
              v_call_0  ,
              (v_indvars_iv_0 + (1))  ,
              v_level_0  ,
              (v_pa_addr_6 + (v_call_0))  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (54043195528446977))))))
            )))
          else (
            (Some (
              true  ,
              v_call_0  ,
              v_indvars_iv_0  ,
              v_level_0  ,
              v_pa_addr_6  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (54043195528446977))))))
            )))))
    | None => None
    end
  end.

  Definition smc_rtt_destroy_1 (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (v_call36: Ptr) (v_call31: Ptr) (st_0: RData) (st_24: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("stack_wi")));
    rely (((v_wi.(poffset)) = (0)));
    rely (((v_call16.(pbase)) = ("slot_rtt")));
    rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
    rely (((v_s2_ctx.(poffset)) = (0)));
    rely (((v_call36.(pbase)) = ("slot_rtt2")));
    rely (((v_call31.(pbase)) = ("granules")));
    rely (
      ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
    rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_24.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
    when cid == (((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
    if ((((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
    then None
    else (
      rely ((((v_call31.(pbase)) = ("granules")) /\ ((((v_call31.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      (Some (
        0  ,
        ((lens 41 st_24).[share].[granule_data] :<
          ((((st_24.(share)).(granule_data)) #
            (((st_24.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call16.(poffset)) + ((8 * ((((st_24.(stack)).(stack_wi)).(e_index)))))) ==
                0))) #
            (((st_24.(share)).(slots)) @ SLOT_RTT2) ==
            (((((st_24.(share)).(granule_data)) #
              (((st_24.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call16.(poffset)) + ((8 * ((((st_24.(stack)).(stack_wi)).(e_index)))))) ==
                  0))) @ (((st_24.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
              zero_granule_data_normal)))
      ))).

  Definition smc_rtt_destroy_2 (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (v_call36: Ptr) (v_call31: Ptr) (st_0: RData) (st_24: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("stack_wi")));
    rely (((v_wi.(poffset)) = (0)));
    rely (((v_call16.(pbase)) = ("slot_rtt")));
    rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
    rely (((v_s2_ctx.(poffset)) = (0)));
    rely (((v_call36.(pbase)) = ("slot_rtt2")));
    rely (((v_call31.(pbase)) = ("granules")));
    rely (
      ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
    rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_24.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
    when cid == (((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
    if ((((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
    then None
    else (
      rely ((((v_call31.(pbase)) = ("granules")) /\ ((((v_call31.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      (Some (
        0  ,
        ((lens 47 st_24).[share].[granule_data] :<
          ((((st_24.(share)).(granule_data)) #
            (((st_24.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call16.(poffset)) + ((8 * ((((st_24.(stack)).(stack_wi)).(e_index)))))) ==
                8))) #
            (((st_24.(share)).(slots)) @ SLOT_RTT2) ==
            (((((st_24.(share)).(granule_data)) #
              (((st_24.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call16.(poffset)) + ((8 * ((((st_24.(stack)).(stack_wi)).(e_index)))))) ==
                  8))) @ (((st_24.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
              zero_granule_data_normal)))
      ))).

  Definition smc_rtt_destroy_3 (v_call17: Z) (v_ulevel: Z) (v_rtt_addr: Z) (v_call9: bool) (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (st_0: RData) (st_20: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("stack_wi")));
    rely (((v_wi.(poffset)) = (0)));
    rely (((v_call16.(pbase)) = ("slot_rtt")));
    if ((((v_call17 & (281474976710655)) & (((- 1) << (12)))) - (v_rtt_addr)) =? (0))
    then (
      if ((v_rtt_addr & (4095)) =? (0))
      then (
        if ((v_rtt_addr / (GRANULE_SIZE)) >? (1048575))
        then None
        else (
          rely ((((0 - ((v_rtt_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rtt_addr / (GRANULE_SIZE)) < (1048576)))));
          rely (((((((st_20.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_state)) - (6)) = (0)));
          when sh == (((st_20.(repl)) ((st_20.(oracle)) (st_20.(log))) (st_20.(share))));
          if ((((((lens 31 st_20).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_refcount)) =? (0))
          then (
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            if v_call9
            then (
              (smc_rtt_destroy_2
                v_wi
                v_call16
                v_map_addr
                v_s2_ctx
                (mkPtr "slot_rtt2" 0)
                (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                st_0
                ((lens 31 st_20).[share].[slots] :< (((st_20.(share)).(slots)) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))))))
            else (
              (smc_rtt_destroy_1
                v_wi
                v_call16
                v_map_addr
                v_s2_ctx
                (mkPtr "slot_rtt2" 0)
                (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                st_0
                ((lens 31 st_20).[share].[slots] :< (((st_20.(share)).(slots)) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE)))))))
          else (
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            rely (
              ((((((st_20.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
            (Some (5, (lens 49 st_20))))))
      else None)
    else (
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      rely (
        ((((((st_20.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
          ((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
      when cid == (((((st_20.(share)).(granules)) @ (((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
      (Some (1, (lens 34 st_20)))).

  Definition smc_rtt_destroy_spec (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_rd_addr & (4095)) =? (0))
    then (
      if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
        rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) = (0)));
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when ret, st' == (
            (validate_rtt_structure_cmds_spec'
              v_map_addr
              v_ulevel
              (mkPtr "slot_rd" 0)
              ((lens 31 st).[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))))));
        if ret
        then (
          rely (
            (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) > (0)) /\
              (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))) /\
              (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (18446744073705226240)) < (0)))));
          rely (((((((lens 31 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)) = ((Some CPU_ID))));
          rely (
            ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
              (6)) =
              (0)));
          rely (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
          when sh_0 == (
              (((lens 31 st).(repl))
                (((lens 31 st).(oracle)) ((lens 31 st).(log)))
                (((lens 31 st).(share)).[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))))));
          when st_14 == (
              (rtt_walk_lock_unlock_spec
                (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                v_map_addr
                (v_ulevel + ((- 1)))
                (mkPtr "stack_wi" 0)
                (((lens 55 st).[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE)))).[stack].[stack_s2_ctx] :<
                  (((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)))));
          if (((((st_14.(stack)).(stack_wi)).(e_last_level)) - ((v_ulevel + ((- 1))))) =? (0))
          then (
            rely (
              ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
            rely ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
            when cid == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
            if (
              (((v_ulevel + ((- 1))) <? (3)) &&
                ((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                  (3)) =?
                  (3)))))
            then (
              (smc_rtt_destroy_3
                (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))))
                v_ulevel
                v_rtt_addr
                ((((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_map_addr)) >? (0))
                (mkPtr "stack_wi" 0)
                (mkPtr "slot_rtt" 0)
                v_map_addr
                (mkPtr "stack_s2_ctx" 0)
                st
                (st_14.[share].[slots] :< (((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))))
            else (
              when cid_0 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
              (Some (
                ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
                ((lens 56 st_14).[share].[slots] :< (((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))
              ))))
          else (
            rely (
              ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
            when cid == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (Some (
              ((((((((st_14.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) >> (24)) & (4294967040)) |'
                (((((((st_14.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) & (4294967295))))  ,
              (lens 34 st_14)
            ))))
        else (Some (1, ((lens 58 st).[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))))))))
    else (Some (1, st)).
  Definition smc_data_create_spec (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_src_addr: Z) (v_flags: Z) (st: RData) : (option (Z * RData)) :=
    if (v_flags <? (2))
    then (
      if ((v_src_addr & (4095)) =? (0))
      then (
        if ((v_src_addr / (GRANULE_SIZE)) >? (1048575))
        then (Some (1, st))
        else (
          rely ((((0 - ((v_src_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_src_addr / (GRANULE_SIZE)) < (1048576)))));
          if (((((st.(share)).(granules)) @ (v_src_addr / (GRANULE_SIZE))).(e_state)) =? (0))
          then (
            when v_call, st_4 == ((find_lock_two_granules_spec v_data_addr 1 (mkPtr "stack_g0" 0) v_rd_addr 2 (mkPtr "stack_g1" 0) st));
            if v_call
            then (
              rely (
                (((((st_4.(stack)).(stack_g1)) > (0)) /\ (((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
                  (((((st_4.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
              rely (((((st_4.(stack)).(stack_g1)) mod (16)) = (0)));
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              when ret, st' == (
                  (validate_data_create_spec'
                    v_map_addr
                    (mkPtr "slot_rd" 0)
                    (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
              if (ret =? (0))
              then (
                rely (
                  (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) > (0)) /\
                    (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))) /\
                    (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (18446744073705226240)) <
                      (0)))));
                rely (
                  ((((((st_4.(share)).(granules)) @
                    ((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) /
                      (ST_GRANULE_SIZE))).(e_state)) -
                    (6)) =
                    (0)));
                rely (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
                when sh == (
                    ((st_4.(repl))
                      ((st_4.(oracle)) (st_4.(log)))
                      ((st_4.(share)).[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
                when st_13 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr
                        "granules"
                        (((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                      ((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                      ((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                      v_map_addr
                      3
                      (mkPtr "stack_wi" 0)
                      ((lens 62 st_4).[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
                if ((((st_13.(stack)).(stack_wi)).(e_last_level)) =? (3))
                then (
                  rely (
                    ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
                  rely ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
                  when cid == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
                  when ret_0 == (
                      (s2tte_has_hipas_spec'
                        (((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index)))))
                        0));
                  if ret_0
                  then (
                    when ret_1 == (
                        (s2tte_get_ripas_spec'
                          (((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index)))))));
                    rely (
                      (((((st_13.(stack)).(stack_g0)) > (0)) /\ (((((st_13.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
                        (((((st_13.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
                    rely (((((st_13.(stack)).(stack_g0)) mod (16)) = (0)));
                    when v_call5, st_1 == (
                        (memcpy_ns_read_spec_state_oracle
                          (mkPtr "slot_delegated" 0)
                          (mkPtr "slot_ns" 0)
                          4096
                          (st_13.[share].[slots] :<
                            (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                              SLOT_DELEGATED ==
                              ((((st_13.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))) #
                              SLOT_NS ==
                              (v_src_addr / (GRANULE_SIZE))))));
                    if v_call5
                    then (
                      if (ret_1 =? (0))
                      then (
                        when v_call6, st_2 == ((data_create_1 v_data_addr (mkPtr "stack_wi" 0) (mkPtr "slot_rtt" 0) (mkPtr "slot_rd" 0) (mkPtr "stack_g1" 0) (mkPtr "stack_g0" 0) st st_1));
                        (Some (v_call6, st_2)))
                      else (
                        when v_call6, st_2 == ((data_create_2 v_data_addr (mkPtr "stack_wi" 0) (mkPtr "slot_rtt" 0) (mkPtr "slot_rd" 0) (mkPtr "stack_g1" 0) (mkPtr "stack_g0" 0) st st_1));
                        (Some (v_call6, st_2))))
                    else (
                      when cid_0 == (((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
                      rely (
                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
                      when cid_1 == (((((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                      rely (
                        (((((st_1.(stack)).(stack_g1)) > (0)) /\ (((((st_1.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
                          (((((st_1.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
                      rely (
                        (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
                          (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
                      rely ((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_g0)) mod (16)) = (0)))));
                      (Some (
                        1  ,
                        ((lens 60 st_1).[share].[granule_data] :<
                          (((st_1.(share)).(granule_data)) #
                            (((st_1.(share)).(slots)) @ SLOT_DELEGATED) ==
                            ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :< zero_granule_data_normal)))
                      ))))
                  else (
                    when v_call6, st_2 == (
                        (data_create_3
                          (mkPtr "slot_rtt" 0)
                          (mkPtr "stack_wi" 0)
                          (mkPtr "slot_rd" 0)
                          (mkPtr "stack_g1" 0)
                          (mkPtr "stack_g0" 0)
                          st
                          (st_13.[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))));
                    (Some (v_call6, st_2))))
                else (
                  when v_call6, st_2 == ((data_create_4 (((st_13.(stack)).(stack_wi)).(e_last_level)) (mkPtr "stack_wi" 0) (mkPtr "slot_rd" 0) (mkPtr "stack_g1" 0) (mkPtr "stack_g0" 0) st st_13));
                  (Some (v_call6, st_2))))
              else (
                when v_call6, st_2 == (
                    (data_create_5
                      (mkPtr "slot_rd" 0)
                      (mkPtr "stack_g1" 0)
                      (mkPtr "stack_g0" 0)
                      ret
                      st
                      (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
                (Some (v_call6, st_2))))
            else (Some (1, st_4)))
          else (Some (1, st))))
      else (Some (1, st)))
    else (Some (1, st)).

  Definition smc_data_create_unknown_spec (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st_4 == ((find_lock_two_granules_spec v_data_addr 1 (mkPtr "stack_g0" 0) v_rd_addr 2 (mkPtr "stack_g1" 0) st));
    if v_call
    then (
      rely (
        (((((st_4.(stack)).(stack_g1)) > (0)) /\ (((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_4.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
      rely (((((st_4.(stack)).(stack_g1)) mod (16)) = (0)));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      when ret, st' == (
          (validate_data_create_unknown_spec'
            v_map_addr
            (mkPtr "slot_rd" 0)
            (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
      if (ret =? (0))
      then (
        rely (
          (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) > (0)) /\
            (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))) /\
            (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (18446744073705226240)) <
              (0)))));
        rely (
          ((((((st_4.(share)).(granules)) @
            ((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) /
              (ST_GRANULE_SIZE))).(e_state)) -
            (6)) =
            (0)));
        rely (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
        when sh == (
            ((st_4.(repl))
              ((st_4.(oracle)) (st_4.(log)))
              ((st_4.(share)).[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
        when st_13 == (
            (rtt_walk_lock_unlock_spec
              (mkPtr
                "granules"
                (((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
              ((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
              ((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
              v_map_addr
              3
              (mkPtr "stack_wi" 0)
              ((lens 61 st_4).[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
        if ((((st_13.(stack)).(stack_wi)).(e_last_level)) =? (3))
        then (
          rely (
            ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
          rely ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
          when cid == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
          when ret_0 == (
              (s2tte_has_hipas_spec'
                (((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index)))))
                0));
          if ret_0
          then (
            when ret_1 == (
                (s2tte_get_ripas_spec'
                  (((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index)))))));
            if (ret_1 =? (0))
            then (
              when v_call_0, st_0 == (
                  (data_create_1
                    v_data_addr
                    (mkPtr "stack_wi" 0)
                    (mkPtr "slot_rtt" 0)
                    (mkPtr "slot_rd" 0)
                    (mkPtr "stack_g1" 0)
                    (mkPtr "stack_g0" 0)
                    st
                    (st_13.[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))));
              (Some (v_call_0, st_0)))
            else (
              when v_call_0, st_0 == (
                  (data_create_2
                    v_data_addr
                    (mkPtr "stack_wi" 0)
                    (mkPtr "slot_rtt" 0)
                    (mkPtr "slot_rd" 0)
                    (mkPtr "stack_g1" 0)
                    (mkPtr "stack_g0" 0)
                    st
                    (st_13.[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))));
              (Some (v_call_0, st_0))))
          else (
            when v_call_0, st_0 == (
                (data_create_3
                  (mkPtr "slot_rtt" 0)
                  (mkPtr "stack_wi" 0)
                  (mkPtr "slot_rd" 0)
                  (mkPtr "stack_g1" 0)
                  (mkPtr "stack_g0" 0)
                  st
                  (st_13.[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))));
            (Some (v_call_0, st_0))))
        else (
          when v_call_0, st_0 == ((data_create_4 (((st_13.(stack)).(stack_wi)).(e_last_level)) (mkPtr "stack_wi" 0) (mkPtr "slot_rd" 0) (mkPtr "stack_g1" 0) (mkPtr "stack_g0" 0) st st_13));
          (Some (v_call_0, st_0))))
      else (
        when v_call_0, st_0 == (
            (data_create_5
              (mkPtr "slot_rd" 0)
              (mkPtr "stack_g1" 0)
              (mkPtr "stack_g0" 0)
              ret
              st
              (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
        (Some (v_call_0, st_0))))
    else (Some (1, st_4)).

  Definition smc_data_destroy_spec (v_rd_addr: Z) (v_map_addr: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_rd_addr & (4095)) =? (0))
    then (
      if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
        rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) = (0)));
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when ret, st' == ((validate_map_addr_spec' v_map_addr 3 (mkPtr "slot_rd" 0) ((lens 31 st).[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))))));
        if ret
        then (
          rely (
            (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) > (0)) /\
              (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))) /\
              (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (18446744073705226240)) < (0)))));
          rely (
            ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
              (6)) =
              (0)));
          rely (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
          when sh_0 == (
              (((lens 31 st).(repl))
                (((lens 31 st).(oracle)) ((lens 31 st).(log)))
                (((lens 31 st).(share)).[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))))));
          when st_14 == (
              (rtt_walk_lock_unlock_spec
                (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                v_map_addr
                3
                (mkPtr "stack_wi" 0)
                (((lens 42 st).[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE)))).[stack].[stack_s2_ctx] :<
                  (((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)))));
          if ((((st_14.(stack)).(stack_wi)).(e_last_level)) =? (3))
          then (
            rely (
              ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
            rely ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
            when cid == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
            when ret_0 == (
                (s2tte_check_spec'
                  (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))))
                  3
                  0));
            if ret_0
            then (
              rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_14.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
              when cid_0 == (((((st_14.(share)).(granules)) @ (1152921504605528063 + (((((st_14.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
              if ((((((st_14.(share)).(granules)) @ (1152921504605528063 + (((((st_14.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
              then None
              else (
                rely (
                  ((((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                    (281474976710655)) &
                    (((- 1) << (12)))) &
                    (4095)) =?
                    (0)) =
                    (true)));
                rely (
                  ((((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                    (281474976710655)) &
                    (((- 1) << (12)))) /
                    (GRANULE_SIZE)) >?
                    (1048575)) =
                    (false)));
                rely (
                  (((0 -
                    (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                      (281474976710655)) &
                      (((- 1) << (12)))) /
                      (GRANULE_SIZE)))) <=
                    (0)) /\
                    ((((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                      (281474976710655)) &
                      (((- 1) << (12)))) /
                      (GRANULE_SIZE)) <
                      (1048576)))));
                rely (
                  ((((((st_14.(share)).(granules)) @
                    ((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                      (281474976710655)) &
                      (((- 1) << (12)))) /
                      (GRANULE_SIZE))).(e_state)) -
                    (5)) =
                    (0)));
                when sh_1 == (
                    (((lens 44 st_14).(repl))
                      (((lens 44 st_14).(oracle)) ((lens 44 st_14).(log)))
                      ((((lens 44 st_14).(share)).[granule_data] :<
                        (((st_14.(share)).(granule_data)) #
                          (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                              8)))).[slots] :<
                        (((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))));
                (Some (
                  0  ,
                  (((lens 53 st_14).[share].[granule_data] :<
                    ((((st_14.(share)).(granule_data)) #
                      (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                      ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                        (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                          (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                          8))) #
                      ((16 *
                        (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                          (281474976710655)) &
                          (((- 1) << (12)))) /
                          (GRANULE_SIZE)))) >>
                        (4)) ==
                      (((((st_14.(share)).(granule_data)) #
                        (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                        ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                          (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                            (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                            8))) @
                        ((16 *
                          (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                            (281474976710655)) &
                            (((- 1) << (12)))) /
                            (GRANULE_SIZE)))) >>
                          (4))).[g_norm] :<
                        zero_granule_data_normal))).[share].[slots] :<
                    ((((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                      SLOT_DELEGATED ==
                      ((16 *
                        (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                          (281474976710655)) &
                          (((- 1) << (12)))) /
                          (GRANULE_SIZE)))) >>
                        (4))))
                ))))
            else (
              when ret_1 == (
                  (s2tte_has_hipas_spec'
                    (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))))
                    4));
              if ret_1
              then (
                when ret_2 == ((s2tte_create_unassigned_spec' 0));
                rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_14.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                when cid_0 == (((((st_14.(share)).(granules)) @ (1152921504605528063 + (((((st_14.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
                if ((((((st_14.(share)).(granules)) @ (1152921504605528063 + (((((st_14.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
                then None
                else (
                  rely (
                    ((((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                      (281474976710655)) &
                      (((- 1) << (12)))) &
                      (4095)) =?
                      (0)) =
                      (true)));
                  rely (
                    ((((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                      (281474976710655)) &
                      (((- 1) << (12)))) /
                      (GRANULE_SIZE)) >?
                      (1048575)) =
                      (false)));
                  rely (
                    (((0 -
                      (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                        (281474976710655)) &
                        (((- 1) << (12)))) /
                        (GRANULE_SIZE)))) <=
                      (0)) /\
                      ((((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                        (281474976710655)) &
                        (((- 1) << (12)))) /
                        (GRANULE_SIZE)) <
                        (1048576)))));
                  rely (
                    ((((((st_14.(share)).(granules)) @
                      ((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                        (281474976710655)) &
                        (((- 1) << (12)))) /
                        (GRANULE_SIZE))).(e_state)) -
                      (5)) =
                      (0)));
                  when sh_1 == (
                      (((lens 55 st_14).(repl))
                        (((lens 55 st_14).(oracle)) ((lens 55 st_14).(log)))
                        ((((lens 55 st_14).(share)).[granule_data] :<
                          (((st_14.(share)).(granule_data)) #
                            (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                                ret_2)))).[slots] :<
                          (((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))));
                  (Some (
                    0  ,
                    (((lens 64 st_14).[share].[granule_data] :<
                      ((((st_14.(share)).(granule_data)) #
                        (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                        ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                          (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                            (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                            ret_2))) #
                        ((16 *
                          (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                            (281474976710655)) &
                            (((- 1) << (12)))) /
                            (GRANULE_SIZE)))) >>
                          (4)) ==
                        (((((st_14.(share)).(granule_data)) #
                          (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                              ret_2))) @
                          ((16 *
                            (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                              (281474976710655)) &
                              (((- 1) << (12)))) /
                              (GRANULE_SIZE)))) >>
                            (4))).[g_norm] :<
                          zero_granule_data_normal))).[share].[slots] :<
                      ((((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                        SLOT_DELEGATED ==
                        ((16 *
                          (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                            (281474976710655)) &
                            (((- 1) << (12)))) /
                            (GRANULE_SIZE)))) >>
                          (4))))
                  ))))
              else (
                when cid_0 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some (772, ((lens 65 st_14).[share].[slots] :< (((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))))))))
          else (
            rely (
              ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
            when cid == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (Some (
              ((((((((st_14.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) >> (24)) & (4294967040)) |'
                (((((((st_14.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) & (4294967295))))  ,
              (lens 34 st_14)
            ))))
        else (Some (1, ((lens 67 st).[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))))))))
    else (Some (1, st)).

  Definition smc_rtt_set_ripas_1 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
    rely (((v_s2_ctx.(pbase)) = ("smc_rtt_set_ripas_stack")));
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_call9.(poffset)) = (0)));
    rely (((v_call47.(pbase)) = ("slot_rtt")));
    rely (((v_wi.(pbase)) = ("stack_wi")));
    rely (((v_wi.(poffset)) = (0)));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_g_rec.(pbase)) = ("stack_g1")));
    rely (((v_g_rd.(pbase)) = ("stack_g0")));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
    when cid == (((((st_35.(share)).(granules)) @ (((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (
      (((((st_35.(stack)).(stack_g1)) > (0)) /\ (((((st_35.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (
      (((((st_35.(stack)).(stack_g0)) > (0)) /\ (((((st_35.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some (
      0  ,
      ((lens 72 st_35).[share].[granule_data] :<
        (((st_35.(share)).(granule_data)) #
          (((st_35.(share)).(slots)) @ SLOT_REC) ==
          ((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
            (((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_set_ripas] :<
              ((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).[e_addr] :<
                (((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).(e_addr)) + (v_call30)))))))
    )).

  Definition smc_rtt_set_ripas_2 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
    rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_call9.(poffset)) = (0)));
    rely (((v_call47.(pbase)) = ("slot_rtt")));
    rely (((v_wi.(pbase)) = ("stack_wi")));
    rely (((v_wi.(poffset)) = (0)));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_g_rec.(pbase)) = ("stack_g1")));
    rely (((v_g_rd.(pbase)) = ("stack_g0")));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
    when cid == (((((st_35.(share)).(granules)) @ (((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (
      (((((st_35.(stack)).(stack_g1)) > (0)) /\ (((((st_35.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (
      (((((st_35.(stack)).(stack_g0)) > (0)) /\ (((((st_35.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some (
      0  ,
      ((lens 85 st_35).[share].[granule_data] :<
        (((st_35.(share)).(granule_data)) #
          (((st_35.(share)).(slots)) @ SLOT_REC) ==
          ((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
            (((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_set_ripas] :<
              ((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).[e_addr] :<
                (((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).(e_addr)) + (v_call30)))))))
    )).

  Definition smc_rtt_set_ripas_3 (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_call9.(poffset)) = (0)));
    rely (((v_call47.(pbase)) = ("slot_rtt")));
    rely (((v_wi.(pbase)) = ("stack_wi")));
    rely (((v_wi.(poffset)) = (0)));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_g_rec.(pbase)) = ("stack_g1")));
    rely (((v_g_rd.(pbase)) = ("stack_g0")));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
    when cid == (((((st_35.(share)).(granules)) @ (((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (
      (((((st_35.(stack)).(stack_g1)) > (0)) /\ (((((st_35.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (
      (((((st_35.(stack)).(stack_g0)) > (0)) /\ (((((st_35.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some (
      0  ,
      ((lens 98 st_35).[share].[granule_data] :<
        (((st_35.(share)).(granule_data)) #
          (((st_35.(share)).(slots)) @ SLOT_REC) ==
          ((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
            (((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_set_ripas] :<
              ((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).[e_addr] :<
                (((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).(e_addr)) + (v_call30)))))))
    )).

  Definition smc_rtt_set_ripas_4 (v_ulevel: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_32: RData) : (option (Z * RData)) :=
    rely (((v_call47.(pbase)) = ("slot_rtt")));
    rely (((v_wi.(pbase)) = ("stack_wi")));
    rely (((v_wi.(poffset)) = (0)));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_g_rec.(pbase)) = ("stack_g1")));
    rely (((v_g_rd.(pbase)) = ("stack_g0")));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      ((((((st_32.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_32.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_32.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
    when cid == (((((st_32.(share)).(granules)) @ (((((st_32.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (
      (((((st_32.(stack)).(stack_g1)) > (0)) /\ (((((st_32.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_32.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (
      (((((st_32.(stack)).(stack_g0)) > (0)) /\ (((((st_32.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_32.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), (lens 100 st_32))).

  Definition smc_rtt_set_ripas_5 (v_15: Z) (v_wi: Ptr) (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_25: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("stack_wi")));
    rely (((v_wi.(poffset)) = (0)));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_g_rec.(pbase)) = ("stack_g1")));
    rely (((v_g_rd.(pbase)) = ("stack_g0")));
    rely (
      ((((((st_25.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_25.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_25.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
    when cid == (((((st_25.(share)).(granules)) @ (((((st_25.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      (((((st_25.(stack)).(stack_g1)) > (0)) /\ (((((st_25.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_25.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (
      (((((st_25.(stack)).(stack_g0)) > (0)) /\ (((((st_25.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_25.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some ((((((v_15 << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_15 << (32)) + (4)) & (4294967295)))), (lens 102 st_25))).

  Definition smc_rtt_set_ripas_6 (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_18: RData) : (option (Z * RData)) :=
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_g_rec.(pbase)) = ("stack_g1")));
    rely (((v_g_rd.(pbase)) = ("stack_g0")));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      (((((st_18.(stack)).(stack_g1)) > (0)) /\ (((((st_18.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_18.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    when cid == (((((st_18.(share)).(granules)) @ ((((st_18.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (
      (((((st_18.(stack)).(stack_g0)) > (0)) /\ (((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_18.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some (1, (lens 103 st_18))).

  Definition smc_rtt_set_ripas_7 (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_13: RData) : (option (Z * RData)) :=
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_g_rec.(pbase)) = ("stack_g1")));
    rely (((v_g_rd.(pbase)) = ("stack_g0")));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      (((((st_13.(stack)).(stack_g1)) > (0)) /\ (((((st_13.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_13.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    when cid == (((((st_13.(share)).(granules)) @ ((((st_13.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (
      (((((st_13.(stack)).(stack_g0)) > (0)) /\ (((((st_13.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_13.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some (1, (lens 104 st_13))).

  Definition smc_rtt_set_ripas_8 (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_8: RData) : (option (Z * RData)) :=
    rely (((v_g_rec.(pbase)) = ("stack_g1")));
    rely (((v_g_rd.(pbase)) = ("stack_g0")));
    rely (
      (((((st_8.(stack)).(stack_g1)) > (0)) /\ (((((st_8.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_8.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    when cid == (((((st_8.(share)).(granules)) @ ((((st_8.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (
      (((((st_8.(stack)).(stack_g0)) > (0)) /\ (((((st_8.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_8.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some (5, (lens 105 st_8))).

  Definition smc_rtt_set_ripas_9 (v_ulevel: Z) (v_call9: Ptr) (v_map_addr: Z) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (v_wi: Ptr) (v_s2_ctx: Ptr) (v_s2tte: Ptr) (v_uripas: Z) (st_0: RData) (st_16: RData) : (option (Z * RData)) :=
    rely (((v_call9.(pbase)) = ("slot_rec")));
    rely (((v_call9.(poffset)) = (0)));
    rely (((v_call25.(pbase)) = ("slot_rd")));
    rely (((v_call25.(poffset)) = (0)));
    rely (((v_g_rec.(pbase)) = ("stack_g1")));
    rely (((v_g_rd.(pbase)) = ("stack_g0")));
    rely (((v_wi.(pbase)) = ("stack_wi")));
    rely (((v_wi.(poffset)) = (0)));
    rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
    rely (((v_s2_ctx.(poffset)) = (0)));
    rely (((v_s2tte.(pbase)) = ("stack_s2tte")));
    if (
      ((((1 << ((39 + (((- 9) * (v_ulevel)))))) + (v_map_addr)) -
        (((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).(e_end)))) >?
        (0)))
    then (
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      rely (
        (((((st_16.(stack)).(stack_g1)) > (0)) /\ (((((st_16.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_16.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
      when cid == (((((st_16.(share)).(granules)) @ ((((st_16.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
      rely (
        (((((st_16.(stack)).(stack_g0)) > (0)) /\ (((((st_16.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_16.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
      (Some (1, (lens 106 st_16))))
    else (
      rely (
        (((((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) > (0)) /\
          (((((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))) /\
          (((((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (18446744073705226240)) < (0)))));
      rely (
        ((((((st_16.(share)).(granules)) @
          ((((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
          (6)) =
          (0)));
      rely (((((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
      when sh == (((st_16.(repl)) ((st_16.(oracle)) (st_16.(log))) (st_16.(share))));
      when st_24 == (
          (rtt_walk_lock_unlock_spec
            (mkPtr "granules" (((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
            ((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
            ((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
            v_map_addr
            v_ulevel
            v_wi
            ((lens 107 st_16).[stack].[stack_s2_ctx] :< (((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)))));
      if (((((st_24.(stack)).(stack_wi)).(e_last_level)) - (v_ulevel)) =? (0))
      then (
        rely (
          ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
            ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
        rely ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when cid == (((((st_24.(share)).(granules)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
        when ret == (
            (s2tte_check_spec'
              (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index)))))
              v_ulevel
              0));
        when v_call50, st_32 == (
            (update_ripas_spec
              v_s2tte
              v_ulevel
              v_uripas
              ((st_24.[share].[slots] :< (((st_24.(share)).(slots)) # SLOT_RTT == (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2tte] :<
                (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))))));
        if v_call50
        then (
          when cid_0 == (((((st_32.(share)).(granules)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
          if ((v_uripas =? (0)) && (ret))
          then (
            if (v_ulevel =? (3))
            then (
              (smc_rtt_set_ripas_1
                v_s2_ctx
                v_map_addr
                v_call9
                (1 << ((39 + (((- 9) * (v_ulevel))))))
                (mkPtr "slot_rtt" 0)
                v_wi
                v_call25
                v_g_rec
                v_g_rd
                st_0
                (st_32.[share].[granule_data] :<
                  (((st_32.(share)).(granule_data)) #
                    (((st_32.(share)).(slots)) @ SLOT_RTT) ==
                    ((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                      (((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                        (8 * ((((st_32.(stack)).(stack_wi)).(e_index)))) ==
                        ((st_32.(stack)).(stack_s2tte))))))))
            else (
              (smc_rtt_set_ripas_2
                v_s2_ctx
                v_map_addr
                v_call9
                (1 << ((39 + (((- 9) * (v_ulevel))))))
                (mkPtr "slot_rtt" 0)
                v_wi
                v_call25
                v_g_rec
                v_g_rd
                st_0
                (st_32.[share].[granule_data] :<
                  (((st_32.(share)).(granule_data)) #
                    (((st_32.(share)).(slots)) @ SLOT_RTT) ==
                    ((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                      (((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                        (8 * ((((st_32.(stack)).(stack_wi)).(e_index)))) ==
                        ((st_32.(stack)).(stack_s2tte)))))))))
          else (
            (smc_rtt_set_ripas_3
              v_call9
              (1 << ((39 + (((- 9) * (v_ulevel))))))
              (mkPtr "slot_rtt" 0)
              v_wi
              v_call25
              v_g_rec
              v_g_rd
              st_0
              (st_32.[share].[granule_data] :<
                (((st_32.(share)).(granule_data)) #
                  (((st_32.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      (8 * ((((st_32.(stack)).(stack_wi)).(e_index)))) ==
                      ((st_32.(stack)).(stack_s2tte)))))))))
        else (smc_rtt_set_ripas_4 v_ulevel (mkPtr "slot_rtt" 0) v_wi v_call25 v_call9 v_g_rec v_g_rd st_0 st_32))
      else (smc_rtt_set_ripas_5 (((st_24.(stack)).(stack_wi)).(e_last_level)) v_wi v_call25 v_call9 v_g_rec v_g_rd st_0 st_24)).

  Definition smc_rtt_set_ripas_spec (v_rd_addr: Z) (v_rec_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (v_uripas: Z) (st: RData) : (option (Z * RData)) :=
    if (v_uripas >? (1))
    then (Some (1, st))
    else (
      when v_call, st_6 == ((find_lock_two_granules_spec v_rd_addr 2 (mkPtr "stack_g0" 0) v_rec_addr 3 (mkPtr "stack_g1" 0) st));
      if v_call
      then (
        rely (
          (((((st_6.(stack)).(stack_g1)) > (0)) /\ (((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
            (((((st_6.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
        rely ((("granules" = ("granules")) /\ (((((st_6.(stack)).(stack_g1)) mod (16)) = (0)))));
        if (((((st_6.(share)).(granules)) @ (1152921504605528063 + ((((st_6.(stack)).(stack_g1)) / (ST_GRANULE_SIZE))))).(e_refcount)) =? (0))
        then (
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          rely (
            (((((st_6.(stack)).(stack_g0)) > (0)) /\ (((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
              (((((st_6.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
          rely (
            (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
              (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)))) /\
              (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rec)).(e_realm_info)).(e_g_rd)) - (18446744073705226240)) < (0)))));
          if (
            ((((st_6.(stack)).(stack_g0)) +
              (((- 1) * (((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rec)).(e_realm_info)).(e_g_rd)))))) =?
              (0)))
          then (
            if ((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rec)).(e_set_ripas)).(e_ripas)) - (v_uripas)) =? (0))
            then (
              if ((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rec)).(e_set_ripas)).(e_addr)) - (v_map_addr)) =? (0))
              then (
                rely (((((st_6.(stack)).(stack_g0)) mod (16)) = (0)));
                when ret, st' == (
                    (validate_rtt_entry_cmds_spec'
                      v_map_addr
                      v_ulevel
                      (mkPtr "slot_rd" 0)
                      (st_6.[share].[slots] :<
                        ((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                          SLOT_RD ==
                          ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))));
                if ret
                then (
                  if (
                    ((((1 << ((39 + (((- 9) * (v_ulevel)))))) + (v_map_addr)) -
                      (((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rec)).(e_set_ripas)).(e_end)))) >?
                      (0)))
                  then (
                    when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                    (Some (
                      1  ,
                      ((lens 116 st_6).[share].[slots] :<
                        ((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                          SLOT_RD ==
                          ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))
                    )))
                  else (
                    rely (
                      (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) > (0)) /\
                        (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))) /\
                        (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (18446744073705226240)) <
                          (0)))));
                    rely (
                      ((((((st_6.(share)).(granules)) @
                        ((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) /
                          (ST_GRANULE_SIZE))).(e_state)) -
                        (6)) =
                        (0)));
                    rely (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
                    when sh == (
                        ((st_6.(repl))
                          ((st_6.(oracle)) (st_6.(log)))
                          ((st_6.(share)).[slots] :<
                            ((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                              SLOT_RD ==
                              ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))));
                    when st_24 == (
                        (rtt_walk_lock_unlock_spec
                          (mkPtr
                            "granules"
                            (((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                          ((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                          ((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                          v_map_addr
                          v_ulevel
                          (mkPtr "stack_wi" 0)
                          (((lens 117 st_6).[share].[slots] :<
                            ((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                              SLOT_RD ==
                              ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2_ctx] :<
                            (((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)))));
                    if (((((st_24.(stack)).(stack_wi)).(e_last_level)) - (v_ulevel)) =? (0))
                    then (
                      rely (
                        ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                          ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
                      rely ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
                      when cid == (((((st_24.(share)).(granules)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
                      when ret_0 == (
                          (s2tte_check_spec'
                            (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index)))))
                            v_ulevel
                            0));
                      when v_call50, st_32 == (
                          (update_ripas_spec
                            (mkPtr "stack_s2tte" 0)
                            v_ulevel
                            v_uripas
                            ((st_24.[share].[slots] :< (((st_24.(share)).(slots)) # SLOT_RTT == (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2tte] :<
                              (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))))));
                      if v_call50
                      then (
                        when cid_0 == (((((st_32.(share)).(granules)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
                        if ((v_uripas =? (0)) && (ret_0))
                        then (
                          if (v_ulevel =? (3))
                          then (
                            (smc_rtt_set_ripas_1
                              (mkPtr "stack_s2_ctx" 0)
                              v_map_addr
                              (mkPtr "slot_rec" 0)
                              (1 << ((39 + (((- 9) * (v_ulevel))))))
                              (mkPtr "slot_rtt" 0)
                              (mkPtr "stack_wi" 0)
                              (mkPtr "slot_rd" 0)
                              (mkPtr "stack_g1" 0)
                              (mkPtr "stack_g0" 0)
                              st
                              (st_32.[share].[granule_data] :<
                                (((st_32.(share)).(granule_data)) #
                                  (((st_32.(share)).(slots)) @ SLOT_RTT) ==
                                  ((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                    (((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                      (8 * ((((st_32.(stack)).(stack_wi)).(e_index)))) ==
                                      ((st_32.(stack)).(stack_s2tte))))))))
                          else (
                            (smc_rtt_set_ripas_2
                              (mkPtr "stack_s2_ctx" 0)
                              v_map_addr
                              (mkPtr "slot_rec" 0)
                              (1 << ((39 + (((- 9) * (v_ulevel))))))
                              (mkPtr "slot_rtt" 0)
                              (mkPtr "stack_wi" 0)
                              (mkPtr "slot_rd" 0)
                              (mkPtr "stack_g1" 0)
                              (mkPtr "stack_g0" 0)
                              st
                              (st_32.[share].[granule_data] :<
                                (((st_32.(share)).(granule_data)) #
                                  (((st_32.(share)).(slots)) @ SLOT_RTT) ==
                                  ((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                    (((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                      (8 * ((((st_32.(stack)).(stack_wi)).(e_index)))) ==
                                      ((st_32.(stack)).(stack_s2tte)))))))))
                        else (
                          (smc_rtt_set_ripas_3
                            (mkPtr "slot_rec" 0)
                            (1 << ((39 + (((- 9) * (v_ulevel))))))
                            (mkPtr "slot_rtt" 0)
                            (mkPtr "stack_wi" 0)
                            (mkPtr "slot_rd" 0)
                            (mkPtr "stack_g1" 0)
                            (mkPtr "stack_g0" 0)
                            st
                            (st_32.[share].[granule_data] :<
                              (((st_32.(share)).(granule_data)) #
                                (((st_32.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_32.(share)).(granule_data)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    (8 * ((((st_32.(stack)).(stack_wi)).(e_index)))) ==
                                    ((st_32.(stack)).(stack_s2tte)))))))))
                      else (
                        (smc_rtt_set_ripas_4
                          v_ulevel
                          (mkPtr "slot_rtt" 0)
                          (mkPtr "stack_wi" 0)
                          (mkPtr "slot_rd" 0)
                          (mkPtr "slot_rec" 0)
                          (mkPtr "stack_g1" 0)
                          (mkPtr "stack_g0" 0)
                          st
                          st_32)))
                    else (
                      (smc_rtt_set_ripas_5
                        (((st_24.(stack)).(stack_wi)).(e_last_level))
                        (mkPtr "stack_wi" 0)
                        (mkPtr "slot_rd" 0)
                        (mkPtr "slot_rec" 0)
                        (mkPtr "stack_g1" 0)
                        (mkPtr "stack_g0" 0)
                        st
                        st_24))))
                else (
                  when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    1  ,
                    ((lens 120 st_6).[share].[slots] :<
                      ((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                        SLOT_RD ==
                        ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))
                  ))))
              else (
                when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some (1, ((lens 123 st_6).[share].[slots] :< (((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))))))
            else (
              when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
              (Some (1, ((lens 126 st_6).[share].[slots] :< (((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))))))
          else (
            when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (Some (3, ((lens 129 st_6).[share].[slots] :< (((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))))))
        else (
          when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          rely (
            (((((st_6.(stack)).(stack_g0)) > (0)) /\ (((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
              (((((st_6.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
          (Some (5, (lens 130 st_6)))))
      else (Some (1, st_6))).

End SMCHandler_Spec.

#[global] Hint Unfold smc_data_create_unknown_spec: spec.
#[global] Hint Unfold smc_rtt_fold_1: spec.
#[global] Hint Unfold smc_rtt_fold_spec: spec.
#[global] Hint Unfold smc_data_create_spec: spec.
