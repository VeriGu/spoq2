Definition smc_data_destroy_spec (v_rd_addr: Z) (v_map_addr: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
    if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
      rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) =? (0)));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      if (
        match ((((((lens 33 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end)
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (((((((lens 35 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)) = ((Some CPU_ID))));
        if (((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
        then (
          if ((((v_map_addr & (281474976710655)) & (((- 1) << (12)))) - (v_map_addr)) =? (0))
          then (
            rely (
              (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) > (0)) /\
                (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))) /\
                (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (18446744073705226240)) < (0)))));
            rely (
              ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
                (6)) =?
                (0)));
            rely (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
            when sh_0 == (
                (((lens 35 st).(repl))
                  (((lens 35 st).(oracle)) ((lens 35 st).(log)))
                  (((lens 35 st).(share)).[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))));
            if (
              match ((((((lens 45 st).(share)).(granules)) @ (1152921504605528063 + ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
              | (Some cid) => true
              | None => false
              end)
            then (
              when st_14 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                    ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                    ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                    v_map_addr
                    3
                    (mkPtr "stack_wi" 0)
                    (((lens 50 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))).[stack].[stack_s2_ctx] :<
                      (((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)))));
              if ((((st_14.(stack)).(stack_wi)).(e_last_level)) =? (3))
              then (
                rely (
                  ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
                rely ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
                when cid == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
                if (
                  (((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                    (36028797018963968)) =?
                    (0)))
                then (
                  if (
                    (((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                      (3)) =?
                      (3)))
                  then (
                    rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_14.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                    if (
                      if ((((((st_14.(share)).(granules)) @ (1152921504605528063 + (((((st_14.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                      then true
                      else (
                        match (((((st_14.(share)).(granules)) @ (1152921504605528063 + (((((st_14.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
                        | (Some cid_0) => true
                        | None => false
                        end))
                    then (
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
                            (5)) =?
                            (0)));
                        when sh_1 == (
                            (((lens 52 st_14).(repl))
                              (((lens 52 st_14).(oracle)) ((lens 52 st_14).(log)))
                              ((((lens 52 st_14).(share)).[granule_data] :<
                                (((st_14.(share)).(granule_data)) #
                                  (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                                  ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                    (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                      (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                                      8)))).[slots] :<
                                (((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))));
                        if (
                          match (
                            (((((lens 56 st_14).(share)).(granules)) @
                              ((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                (281474976710655)) &
                                (((- 1) << (12)))) /
                                (GRANULE_SIZE))).(e_lock))
                          ) with
                          | (Some cid_1) => true
                          | None => false
                          end)
                        then (
                          if (
                            match (
                              (((((lens 58 st_14).(share)).(granules)) @
                                (((16 *
                                  (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                    (281474976710655)) &
                                    (((- 1) << (12)))) /
                                    (GRANULE_SIZE)))) /
                                  (ST_GRANULE_SIZE)) +
                                  (0))).(e_lock))
                            ) with
                            | (Some cid_1) => true
                            | None => false
                            end)
                          then (
                            (Some (
                              0  ,
                              (((lens 64 st_14).[share].[granule_data] :<
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
                                ((((((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_DELEGATED ==
                                  ((16 *
                                    (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                      (281474976710655)) &
                                      (((- 1) << (12)))) /
                                      (GRANULE_SIZE)))) >>
                                    (4))) #
                                  SLOT_DELEGATED ==
                                  (- 1)) #
                                  SLOT_RTT ==
                                  (- 1)))
                            )))
                          else None)
                        else None))
                    else None)
                  else (
                    if (
                      (((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                        (3)) =?
                        (0)))
                    then (
                      if (
                        ((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                          (60)) -
                          (4)) =?
                          (0)))
                      then (
                        rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_14.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                        if (
                          if ((((((st_14.(share)).(granules)) @ (1152921504605528063 + (((((st_14.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                          then true
                          else (
                            match (((((st_14.(share)).(granules)) @ (1152921504605528063 + (((((st_14.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
                            | (Some cid_0) => true
                            | None => false
                            end))
                        then (
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
                                (5)) =?
                                (0)));
                            when sh_1 == (
                                (((lens 66 st_14).(repl))
                                  (((lens 66 st_14).(oracle)) ((lens 66 st_14).(log)))
                                  ((((lens 66 st_14).(share)).[granule_data] :<
                                    (((st_14.(share)).(granule_data)) #
                                      (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                                      ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                        (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                          (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                                          0)))).[slots] :<
                                    (((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))));
                            if (
                              match (
                                (((((lens 70 st_14).(share)).(granules)) @
                                  ((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                    (281474976710655)) &
                                    (((- 1) << (12)))) /
                                    (GRANULE_SIZE))).(e_lock))
                              ) with
                              | (Some cid_1) => true
                              | None => false
                              end)
                            then (
                              if (
                                match (
                                  (((((lens 72 st_14).(share)).(granules)) @
                                    (((16 *
                                      (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                        (281474976710655)) &
                                        (((- 1) << (12)))) /
                                        (GRANULE_SIZE)))) /
                                      (ST_GRANULE_SIZE)) +
                                      (0))).(e_lock))
                                ) with
                                | (Some cid_1) => true
                                | None => false
                                end)
                              then (
                                (Some (
                                  0  ,
                                  (((lens 78 st_14).[share].[granule_data] :<
                                    ((((st_14.(share)).(granule_data)) #
                                      (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                                      ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                        (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                          (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                                          0))) #
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
                                            0))) @
                                        ((16 *
                                          (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                            (281474976710655)) &
                                            (((- 1) << (12)))) /
                                            (GRANULE_SIZE)))) >>
                                          (4))).[g_norm] :<
                                        zero_granule_data_normal))).[share].[slots] :<
                                    ((((((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                                      SLOT_DELEGATED ==
                                      ((16 *
                                        (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                          (281474976710655)) &
                                          (((- 1) << (12)))) /
                                          (GRANULE_SIZE)))) >>
                                        (4))) #
                                      SLOT_DELEGATED ==
                                      (- 1)) #
                                      SLOT_RTT ==
                                      (- 1)))
                                )))
                              else None)
                            else None))
                        else None)
                      else (
                        when cid_0 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                        (Some (
                          772  ,
                          ((lens 79 st_14).[share].[slots] :<
                            ((((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                        ))))
                    else (
                      when cid_0 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                      (Some (
                        772  ,
                        ((lens 80 st_14).[share].[slots] :<
                          ((((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                      )))))
                else (
                  if (
                    (((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                      (3)) =?
                      (0)))
                  then (
                    if (
                      ((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                        (60)) -
                        (4)) =?
                        (0)))
                    then (
                      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_14.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_14.(share)).(granules)) @ (1152921504605528063 + (((((st_14.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_14.(share)).(granules)) @ (1152921504605528063 + (((((st_14.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
                          | (Some cid_0) => true
                          | None => false
                          end))
                      then (
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
                              (5)) =?
                              (0)));
                          when sh_1 == (
                              (((lens 82 st_14).(repl))
                                (((lens 82 st_14).(oracle)) ((lens 82 st_14).(log)))
                                ((((lens 82 st_14).(share)).[granule_data] :<
                                  (((st_14.(share)).(granule_data)) #
                                    (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                                    ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                      (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                        (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                                        0)))).[slots] :<
                                  (((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))));
                          if (
                            match (
                              (((((lens 86 st_14).(share)).(granules)) @
                                ((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                  (281474976710655)) &
                                  (((- 1) << (12)))) /
                                  (GRANULE_SIZE))).(e_lock))
                            ) with
                            | (Some cid_1) => true
                            | None => false
                            end)
                          then (
                            if (
                              match (
                                (((((lens 88 st_14).(share)).(granules)) @
                                  (((16 *
                                    (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                      (281474976710655)) &
                                      (((- 1) << (12)))) /
                                      (GRANULE_SIZE)))) /
                                    (ST_GRANULE_SIZE)) +
                                    (0))).(e_lock))
                              ) with
                              | (Some cid_1) => true
                              | None => false
                              end)
                            then (
                              (Some (
                                0  ,
                                (((lens 94 st_14).[share].[granule_data] :<
                                  ((((st_14.(share)).(granule_data)) #
                                    (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                                    ((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                      (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                        (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))) ==
                                        0))) #
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
                                          0))) @
                                      ((16 *
                                        (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                          (281474976710655)) &
                                          (((- 1) << (12)))) /
                                          (GRANULE_SIZE)))) >>
                                        (4))).[g_norm] :<
                                      zero_granule_data_normal))).[share].[slots] :<
                                  ((((((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                                    SLOT_DELEGATED ==
                                    ((16 *
                                      (((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                                        (281474976710655)) &
                                        (((- 1) << (12)))) /
                                        (GRANULE_SIZE)))) >>
                                      (4))) #
                                    SLOT_DELEGATED ==
                                    (- 1)) #
                                    SLOT_RTT ==
                                    (- 1)))
                              )))
                            else None)
                          else None))
                      else None)
                    else (
                      when cid_0 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                      (Some (
                        772  ,
                        ((lens 95 st_14).[share].[slots] :<
                          ((((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                      ))))
                  else (
                    when cid_0 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                    (Some (
                      772  ,
                      ((lens 96 st_14).[share].[slots] :<
                        ((((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                    )))))
              else (
                rely (
                  ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
                when cid == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some (
                  ((((((((st_14.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) >> (24)) & (4294967040)) |'
                    (((((((st_14.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) & (4294967295))))  ,
                  (lens 38 st_14)
                ))))
            else None)
          else (Some (1, ((lens 98 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
        else (Some (1, ((lens 100 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
      else None))
  else (Some (1, st)).

Definition smc_rtt_set_ripas_1_low (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_call9.(poffset)) = (0)));
  rely (((v_call47.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  when st_36 == ((invalidate_page_spec v_s2_ctx v_map_addr st_35));
  when v_21, st_39 == ((load_RData 8 (ptr_offset v_call9 864) st_36));
  when st_40 == ((store_RData 8 (ptr_offset v_call9 864) (v_21 + (v_call30)) st_39));
  when st_42 == ((buffer_unmap_spec v_call47 st_40));
  when v_22_tmp, st_44 == ((load_RData 8 (ptr_offset v_wi 0) st_42));
  rely (((v_22_tmp < (STACK_VIRT)) /\ ((v_22_tmp >= (GRANULES_BASE)))));
  when st_45 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_44));
  when st_48 == ((buffer_unmap_spec v_call25 st_45));
  when st_52 == ((buffer_unmap_spec v_call9 st_48));
  when v_23_tmp, st_54 == ((load_RData 8 v_g_rec st_52));
  rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
  when st_55 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_54));
  when v_24_tmp, st_56 == ((load_RData 8 v_g_rd st_55));
  rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
  when st_57 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_56));
  when st_60 == ((free_stack "smc_rtt_set_ripas" st_0 st_57));
  (Some (0, st_60)).

Definition smc_rtt_set_ripas_2_low (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_call9.(poffset)) = (0)));
  rely (((v_call47.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  when st_36 == ((invalidate_block_spec v_s2_ctx v_map_addr st_35));
  when v_21, st_39 == ((load_RData 8 (ptr_offset v_call9 864) st_36));
  when st_40 == ((store_RData 8 (ptr_offset v_call9 864) (v_21 + (v_call30)) st_39));
  when st_42 == ((buffer_unmap_spec v_call47 st_40));
  when v_22_tmp, st_44 == ((load_RData 8 (ptr_offset v_wi 0) st_42));
  rely (((v_22_tmp < (STACK_VIRT)) /\ ((v_22_tmp >= (GRANULES_BASE)))));
  when st_45 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_44));
  when st_48 == ((buffer_unmap_spec v_call25 st_45));
  when st_52 == ((buffer_unmap_spec v_call9 st_48));
  when v_23_tmp, st_54 == ((load_RData 8 v_g_rec st_52));
  rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
  when st_55 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_54));
  when v_24_tmp, st_56 == ((load_RData 8 v_g_rd st_55));
  rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
  when st_57 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_56));
  when st_60 == ((free_stack "smc_rtt_set_ripas" st_0 st_57));
  (Some (0, st_60)).

Definition smc_rtt_set_ripas_3_low (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_call9.(poffset)) = (0)));
  rely (((v_call47.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  when v_21, st_37 == ((load_RData 8 (ptr_offset v_call9 864) st_35));
  when st_38 == ((store_RData 8 (ptr_offset v_call9 864) (v_21 + (v_call30)) st_37));
  when st_40 == ((buffer_unmap_spec v_call47 st_38));
  when v_22_tmp, st_42 == ((load_RData 8 (ptr_offset v_wi 0) st_40));
  rely (((v_22_tmp < (STACK_VIRT)) /\ ((v_22_tmp >= (GRANULES_BASE)))));
  when st_43 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_42));
  when st_46 == ((buffer_unmap_spec v_call25 st_43));
  when st_50 == ((buffer_unmap_spec v_call9 st_46));
  when v_23_tmp, st_52 == ((load_RData 8 v_g_rec st_50));
  rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
  when st_53 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_52));
  when v_24_tmp, st_54 == ((load_RData 8 v_g_rd st_53));
  rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
  when st_55 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_54));
  when st_58 == ((free_stack "smc_rtt_set_ripas" st_0 st_55));
  (Some (0, st_58)).

Definition smc_rtt_set_ripas_4_low (v_ulevel: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_32: RData) : (option (Z * RData)) :=
  rely (((v_call47.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  when v_call53, st_33 == ((pack_return_code_spec 4 v_ulevel st_32));
  when st_35 == ((buffer_unmap_spec v_call47 st_33));
  when v_22_tmp, st_37 == ((load_RData 8 (ptr_offset v_wi 0) st_35));
  rely (((v_22_tmp < (STACK_VIRT)) /\ ((v_22_tmp >= (GRANULES_BASE)))));
  when st_38 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_37));
  when st_41 == ((buffer_unmap_spec v_call25 st_38));
  when st_45 == ((buffer_unmap_spec v_call9 st_41));
  when v_23_tmp, st_47 == ((load_RData 8 v_g_rec st_45));
  rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
  when st_48 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_47));
  when v_24_tmp, st_49 == ((load_RData 8 v_g_rd st_48));
  rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
  when st_50 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_49));
  when st_53 == ((free_stack "smc_rtt_set_ripas" st_0 st_50));
  (Some (v_call53, st_53)).

Definition smc_rtt_set_ripas_5_low (v_15: Z) (v_wi: Ptr) (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_25: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  when v_call45, st_26 == ((pack_return_code_spec 4 v_15 st_25));
  when v_22_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_26));
  rely (((v_22_tmp < (STACK_VIRT)) /\ ((v_22_tmp >= (GRANULES_BASE)))));
  when st_29 == ((granule_unlock_spec (int_to_ptr v_22_tmp) st_28));
  when st_32 == ((buffer_unmap_spec v_call25 st_29));
  when st_36 == ((buffer_unmap_spec v_call9 st_32));
  when v_23_tmp, st_38 == ((load_RData 8 v_g_rec st_36));
  rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
  when st_39 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_38));
  when v_24_tmp, st_40 == ((load_RData 8 v_g_rd st_39));
  rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
  when st_41 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_40));
  when st_44 == ((free_stack "smc_rtt_set_ripas" st_0 st_41));
  (Some (v_call45, st_44)).

Definition smc_rtt_set_ripas_6_low (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_18: RData) : (option (Z * RData)) :=
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  when st_21 == ((buffer_unmap_spec v_call25 st_18));
  when st_25 == ((buffer_unmap_spec v_call9 st_21));
  when v_23_tmp, st_27 == ((load_RData 8 v_g_rec st_25));
  rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
  when st_28 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_27));
  when v_24_tmp, st_29 == ((load_RData 8 v_g_rd st_28));
  rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
  when st_30 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_29));
  when st_33 == ((free_stack "smc_rtt_set_ripas" st_0 st_30));
  (Some (1, st_33)).

Definition smc_rtt_set_ripas_7_low (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_13: RData) : (option (Z * RData)) :=
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  when st_16 == ((buffer_unmap_spec v_call9 st_13));
  when v_23_tmp, st_18 == ((load_RData 8 v_g_rec st_16));
  rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
  when st_19 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_18));
  when v_24_tmp, st_20 == ((load_RData 8 v_g_rd st_19));
  rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
  when st_21 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_20));
  when st_24 == ((free_stack "smc_rtt_set_ripas" st_0 st_21));
  (Some (1, st_24)).

Definition smc_rtt_set_ripas_8_low (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_8: RData) : (option (Z * RData)) :=
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  when v_23_tmp, st_10 == ((load_RData 8 v_g_rec st_8));
  rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
  when st_11 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_10));
  when v_24_tmp, st_12 == ((load_RData 8 v_g_rd st_11));
  rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
  when st_13 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_12));
  when st_16 == ((free_stack "smc_rtt_set_ripas" st_0 st_13));
  (Some (5, st_16)).

Definition smc_rtt_set_ripas_9_low (v_ulevel: Z) (v_call9: Ptr) (v_map_addr: Z) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (v_wi: Ptr) (v_s2_ctx: Ptr) (v_s2tte: Ptr) (v_uripas: Z) (st_0: RData) (st_16: RData) : (option (Z * RData)) :=
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
  when v_call30, st_17 == ((s2tte_map_size_spec v_ulevel st_16));
  when v_11, st_18 == ((load_RData 8 (ptr_offset v_call9 856) st_17));
  if (((v_call30 + (v_map_addr)) - (v_11)) >? (0))
  then (
    when st_21 == ((buffer_unmap_spec v_call25 st_18));
    when st_25 == ((buffer_unmap_spec v_call9 st_21));
    when v_23_tmp, st_27 == ((load_RData 8 v_g_rec st_25));
    rely (((v_23_tmp < (STACK_VIRT)) /\ ((v_23_tmp >= (GRANULES_BASE)))));
    when st_28 == ((granule_unlock_spec (int_to_ptr v_23_tmp) st_27));
    when v_24_tmp, st_29 == ((load_RData 8 v_g_rd st_28));
    rely (((v_24_tmp < (STACK_VIRT)) /\ ((v_24_tmp >= (GRANULES_BASE)))));
    when st_30 == ((granule_unlock_spec (int_to_ptr v_24_tmp) st_29));
    when st_33 == ((free_stack "smc_rtt_set_ripas" st_0 st_30));
    (Some (1, st_33)))
  else (
    when v_13_tmp, st_19 == ((load_RData 8 (ptr_offset v_call25 32) st_18));
    when v_call37, st_20 == ((realm_rtt_starting_level_spec v_call25 st_19));
    when v_call38, st_21 == ((realm_ipa_bits_spec v_call25 st_20));
    when st_22 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call25 16) 32 false st_21));
    rely (((v_13_tmp < (STACK_VIRT)) /\ ((v_13_tmp >= (GRANULES_BASE)))));
    when st_23 == ((granule_lock_spec (int_to_ptr v_13_tmp) 6 st_22));
    when st_24 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_13_tmp) v_call37 v_call38 v_map_addr v_ulevel v_wi st_23));
    when v_15, st_25 == ((load_RData 8 (ptr_offset v_wi 16) st_24));
    if ((v_15 - (v_ulevel)) =? (0))
    then (
      when v_16_tmp, st_26 == ((load_RData 8 (ptr_offset v_wi 0) st_25));
      rely (((v_16_tmp < (STACK_VIRT)) /\ ((v_16_tmp >= (GRANULES_BASE)))));
      when v_call47, st_27 == ((granule_map_spec (int_to_ptr v_16_tmp) 22 st_26));
      when v_18, st_28 == ((load_RData 8 (ptr_offset v_wi 8) st_27));
      when v_call48, st_29 == ((__tte_read_spec (ptr_offset v_call47 (8 * (v_18))) st_28));
      when st_30 == ((store_RData 8 v_s2tte v_call48 st_29));
      when v_call49, st_31 == ((s2tte_is_valid_spec v_call48 v_ulevel st_30));
      when v_call50, st_32 == ((update_ripas_spec v_s2tte v_ulevel v_uripas st_31));
      if v_call50
      then (
        when v_19, st_33 == ((load_RData 8 (ptr_offset v_wi 8) st_32));
        when v_20, st_34 == ((load_RData 8 v_s2tte st_33));
        when st_35 == ((__tte_write_spec (ptr_offset v_call47 (8 * (v_19))) v_20 st_34));
        if ((v_uripas =? (0)) && (v_call49))
        then (
          if (v_ulevel =? (3))
          then (smc_rtt_set_ripas_1 v_s2_ctx v_map_addr v_call9 v_call30 v_call47 v_wi v_call25 v_g_rec v_g_rd st_0 st_35)
          else (smc_rtt_set_ripas_2 v_s2_ctx v_map_addr v_call9 v_call30 v_call47 v_wi v_call25 v_g_rec v_g_rd st_0 st_35))
        else (smc_rtt_set_ripas_3 v_call9 v_call30 v_call47 v_wi v_call25 v_g_rec v_g_rd st_0 st_35))
      else (smc_rtt_set_ripas_4 v_ulevel v_call47 v_wi v_call25 v_call9 v_g_rec v_g_rd st_0 st_32))
    else (smc_rtt_set_ripas_5 v_15 v_wi v_call25 v_call9 v_g_rec v_g_rd st_0 st_25)).

