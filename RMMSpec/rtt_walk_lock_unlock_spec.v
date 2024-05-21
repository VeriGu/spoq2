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
          if (
            (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT)).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
              (3)) =?
              (3)))
          then (
            rely (
              (((0 -
                ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT)).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
                  (281474976710655)) /
                  (GRANULE_SIZE)))) <=
                (0)) /\
                (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT)).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
                  (281474976710655)) /
                  (GRANULE_SIZE)) <
                  (1048576)))));
            rely (
              ((((((st_0.(share)).(granules)) @
                ((16 *
                  ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT)).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
                    (281474976710655)) /
                    (GRANULE_SIZE)))) /
                  (ST_GRANULE_SIZE))).(e_state)) -
                (6)) =?
                (0)));
            when sh == ((((lens 524 st_0).(repl)) (((lens 524 st_0).(oracle)) ((lens 524 st_0).(log))) ((lens 524 st_0).(share))));
            if (
              match (
                (((((lens 525 st_0).(share)).(granules)) @
                  (((16 *
                    ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT)).(g_norm)) @ (8 * (((v_map_addr_0 >> (((39 + ((38654705655 * (v_indvars_iv_0)))) & (4294967295)))) & (511))))) &
                      (281474976710655)) /
                      (GRANULE_SIZE)))) /
                    (ST_GRANULE_SIZE)) +
                    (0))).(e_lock))
              ) with
              | (Some cid) => true
              | None => false
              end)
            then (
              rely ((((0 - ((v_indvars_iv_0 + (1)))) <= (0)) /\ (((v_indvars_iv_0 + (1)) < (4)))));
              if (((v_indvars_iv_0 + (1)) - (v_level_0)) <? (0))
              then (Some (false, false, v_g_tbls_0, (v_indvars_iv_0 + (1)), v_level_0, v_map_addr_0, v_wi_0, (lens 561 st_0)))
              else (Some (false, true, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, (lens 561 st_0))))
            else None)
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
              ((lens 591 st_0).[stack].[stack_wi] :<
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
        (6)) =?
        (0)));
    rely ((((v_g_root.(poffset)) mod (16)) = (0)));
    when sh == ((((lens 698 st).(repl)) (((lens 698 st).(oracle)) ((lens 698 st).(log))) ((lens 698 st).(share))));
    if (
      match (
        (((((lens 699 st).(share)).(granules)) @
          ((((v_g_root.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((39 + (((- 9) * (v_start_level)))))) >> (9)) & (4294967295)))))) +
            (4)) /
            (ST_GRANULE_SIZE))).(e_lock))
      ) with
      | (Some cid) => true
      | None => false
      end)
    then (
      if ((v_start_level - (v_level)) <? (0))
      then (
        match ((rtt_walk_lock_unlock_loop370 (z_to_nat v_level) false false (mkPtr "stack_g_tbls" 0) v_start_level v_level v_map_addr v_wi (lens 731 st))) with
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
          ((((((st.(stack)).(stack_g_tbls)) @ v_level) > (0)) /\ ((((((st.(stack)).(stack_g_tbls)) @ v_level) - (GRANULES_BASE)) >= (0)))) /\
            ((((((st.(stack)).(stack_g_tbls)) @ v_level) - (18446744073705226240)) < (0)))));
        (Some ((lens 731 st).[stack].[stack_wi] :<
          (((((st.(stack)).(stack_wi)).[e_g_llt] :< (((st.(stack)).(stack_g_tbls)) @ v_level)).[e_index] :<
            ((v_map_addr >> (((39 + ((38654705655 * (v_level)))) & (4294967295)))) & (511))).[e_last_level] :<
            v_level)))))
    else None)
  else (
    if ((v_start_level - (v_level)) <? (0))
    then (
      match ((rtt_walk_lock_unlock_loop370 (z_to_nat v_level) false false (mkPtr "stack_g_tbls" 0) v_start_level v_level v_map_addr v_wi (lens 921 st))) with
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
        ((((((st.(stack)).(stack_g_tbls)) @ v_level) > (0)) /\ ((((((st.(stack)).(stack_g_tbls)) @ v_level) - (GRANULES_BASE)) >= (0)))) /\
          ((((((st.(stack)).(stack_g_tbls)) @ v_level) - (18446744073705226240)) < (0)))));
      (Some ((lens 921 st).[stack].[stack_wi] :<
        (((((st.(stack)).(stack_wi)).[e_g_llt] :< (((st.(stack)).(stack_g_tbls)) @ v_level)).[e_index] :<
          ((v_map_addr >> (((39 + ((38654705655 * (v_level)))) & (4294967295)))) & (511))).[e_last_level] :<
          v_level))))).

Definition rtt_walk_lock_unlock_loop370_rank (v_g_tbls: Ptr) (v_indvars_iv: Z) (v_level: Z) (v_map_addr: Z) (v_wi: Ptr) : Z :=
  v_level.

