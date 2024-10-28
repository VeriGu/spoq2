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
