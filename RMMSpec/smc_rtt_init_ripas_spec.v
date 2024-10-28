Definition smc_rtt_init_ripas_spec (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
    if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
      rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) =? (0)));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      if (
        match ((((((lens 15 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end)
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        if ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_rd_state)) =? (0))
        then (
          when cid == ((((((lens 17 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)));
          if (
            ((v_ulevel >? (3)) ||
              (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) - (v_ulevel)) >? (0)))))
          then (Some (1, ((lens 24 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))
          else (
            rely (((Some cid) = ((Some CPU_ID))));
            if (((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
            then (
              if ((((v_map_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) - (v_map_addr)) =? (0))
              then (
                if ((((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_map_addr)) >? (0))
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
                      (((lens 17 st).(repl))
                        (((lens 17 st).(oracle)) ((lens 17 st).(log)))
                        (((lens 17 st).(share)).[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))))));
                  if (
                    match ((((((lens 26 st).(share)).(granules)) @ (1152921504605528063 + ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end)
                  then (
                    when st_13 == (
                        (rtt_walk_lock_unlock_spec
                          (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                          ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                          ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                          v_map_addr
                          v_ulevel
                          (mkPtr "stack_wi" 0)
                          ((lens 30 st).[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))))));
                    if (((((st_13.(stack)).(stack_wi)).(e_last_level)) - (v_ulevel)) =? (0))
                    then (
                      rely (
                        ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                          ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
                      rely ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
                      when cid_0 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
                      if (
                        ((v_ulevel <? (3)) &&
                          ((((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                            (3)) =?
                            (3)))))
                      then (
                        when cid_1 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                        (Some (
                          (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                          ((lens 31 st_13).[share].[slots] :<
                            (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
                        )))
                      else (
                        if (
                          (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                            (3)) =?
                            (0)))
                        then (
                          if (
                            (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                              (60)) =?
                              (0)))
                          then (
                            when cid_1 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                            (Some (
                              0  ,
                              (((lens 33 st_13).[share].[granule_data] :<
                                (((st_13.(share)).(granule_data)) #
                                  (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)) ==
                                  ((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                    (((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                      (8 * ((((st_13.(stack)).(stack_wi)).(e_index)))) ==
                                      (64 |'
                                        ((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))))))))).[share].[slots] :<
                                (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
                            )))
                          else (
                            when cid_1 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                            (Some (
                              (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                              ((lens 34 st_13).[share].[slots] :<
                                (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
                            ))))
                        else (
                          when cid_1 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                          (Some (
                            (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                            ((lens 35 st_13).[share].[slots] :<
                              (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
                          )))))
                    else (
                      rely (
                        ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                          ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
                      when cid_0 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                      (Some (
                        ((((((((st_13.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) >> (24)) & (4294967040)) |'
                          (((((((st_13.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) & (4294967295))))  ,
                        ((lens 36 st_13).[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RD == (- 1)))
                      ))))
                  else None)
                else (Some (1, ((lens 38 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
              else (Some (1, ((lens 40 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
            else (Some (1, ((lens 42 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))))
        else (Some (2, ((lens 44 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
      else None))
  else (Some (1, st)).

