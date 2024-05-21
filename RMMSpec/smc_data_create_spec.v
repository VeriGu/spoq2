Definition smc_data_create_unknown_spec (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (st: RData) : (option (Z * RData)) :=
  when v_call, st_4 == ((find_lock_two_granules_spec v_data_addr 1 (mkPtr "stack_g0" 0) v_rd_addr 2 (mkPtr "stack_g1" 0) st));
  if v_call
  then (
    rely (
      (((((st_4.(stack)).(stack_g1)) > (0)) /\ (((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_4.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (((((st_4.(stack)).(stack_g1)) mod (16)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely ((((((st_4.(share)).(granules)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(e_lock)) = ((Some CPU_ID))));
    when cid == (((((st_4.(share)).(granules)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(e_lock)));
    if (
      ((((1 << (((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) -
        (v_map_addr)) >?
        (0)))
    then (
      if ((((v_map_addr & (281474976710655)) & (((- 1) << (12)))) - (v_map_addr)) =? (0))
      then (
        rely (
          (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
            (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
        rely (
          ((((((st_4.(share)).(granules)) @
            ((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) /
              (ST_GRANULE_SIZE))).(e_state)) -
            (6)) =?
            (0)));
        rely (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
        when sh == (
            ((st_4.(repl))
              ((st_4.(oracle)) (st_4.(log)))
              ((st_4.(share)).[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
        if (
          match (
            (((((lens 82 st_4).(share)).(granules)) @
              (1152921504605528063 +
                ((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))
          ) with
          | (Some cid_0) => true
          | None => false
          end)
        then (
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
                ((lens 83 st_4).[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
          if ((((st_13.(stack)).(stack_wi)).(e_last_level)) =? (3))
          then (
            rely (((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
            rely ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
            when cid_0 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
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
                if (
                  (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                    (64)) =?
                    (0)))
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
        else None)
      else (
        when v_call_0, st_0 == (
            (data_create_5
              (mkPtr "slot_rd" 0)
              (mkPtr "stack_g1" 0)
              (mkPtr "stack_g0" 0)
              1
              st
              (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
        (Some (v_call_0, st_0))))
    else (
      when v_call_0, st_0 == (
          (data_create_5
            (mkPtr "slot_rd" 0)
            (mkPtr "stack_g1" 0)
            (mkPtr "stack_g0" 0)
            1
            st
            (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
      (Some (v_call_0, st_0))))
  else (Some (1, st_4)).

Definition smc_data_create_spec (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_src_addr: Z) (v_flags: Z) (st: RData) : (option (Z * RData)) :=
  if (v_flags <? (2))
  then (
    if ((v_src_addr & (4095)) =? (0))
    then (
      if ((v_src_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_src_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_src_addr / (GRANULE_SIZE)) < (1048576)))));
        if (
          match (((((st.(share)).(granules)) @ (v_src_addr / (GRANULE_SIZE))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end)
        then (
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
              when cid == (((((st_4.(share)).(granules)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(e_lock)));
              if ((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_rd_state)) =? (0))
              then (
                rely (((Some cid) = ((Some CPU_ID))));
                if (
                  ((((1 << (((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) -
                    (v_map_addr)) >?
                    (0)))
                then (
                  if ((((v_map_addr & (281474976710655)) & (((- 1) << (12)))) - (v_map_addr)) =? (0))
                  then (
                    rely (
                      (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
                        (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
                    rely (
                      ((((((st_4.(share)).(granules)) @
                        ((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) /
                          (ST_GRANULE_SIZE))).(e_state)) -
                        (6)) =?
                        (0)));
                    rely (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
                    when sh == (
                        ((st_4.(repl))
                          ((st_4.(oracle)) (st_4.(log)))
                          ((st_4.(share)).[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
                    if (
                      match (
                        (((((lens 84 st_4).(share)).(granules)) @
                          (1152921504605528063 +
                            ((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))
                      ) with
                      | (Some cid_0) => true
                      | None => false
                      end)
                    then (
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
                            ((lens 85 st_4).[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
                      if ((((st_13.(stack)).(stack_wi)).(e_last_level)) =? (3))
                      then (
                        rely (((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                        rely ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
                        when cid_0 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
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
                            if (
                              (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                                (64)) =?
                                (0)))
                            then (
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
                                when v_call6, st_2 == (
                                    (data_create_1
                                      v_data_addr
                                      (mkPtr "stack_wi" 0)
                                      (mkPtr "slot_rtt" 0)
                                      (mkPtr "slot_rd" 0)
                                      (mkPtr "stack_g1" 0)
                                      (mkPtr "stack_g0" 0)
                                      st
                                      (st_1.[share].[slots] :< ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1)))));
                                (Some (v_call6, st_2)))
                              else (
                                when cid_1 == (((((st_1.(share)).(granules)) @ ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED)).(e_lock)));
                                rely (((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                                when cid_2 == (((((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                                rely (
                                  (((((st_1.(stack)).(stack_g1)) > (0)) /\ (((((st_1.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
                                    (((((st_1.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
                                rely (
                                  (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
                                    (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
                                rely ((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_g0)) mod (16)) = (0)))));
                                if (
                                  match ((((((lens 86 st_1).(share)).(granules)) @ (1152921504605528063 + ((((st_1.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock))) with
                                  | (Some cid_3) => true
                                  | None => false
                                  end)
                                then (
                                  (Some (
                                    1  ,
                                    (((lens 87 st_1).[share].[granule_data] :<
                                      (((st_1.(share)).(granule_data)) #
                                        ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED) ==
                                        ((((st_1.(share)).(granule_data)) @ ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED)).[g_norm] :< zero_granule_data_normal))).[share].[slots] :<
                                      ((((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
                                  )))
                                else None))
                            else (
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
                                when v_call6, st_2 == (
                                    (data_create_2
                                      v_data_addr
                                      (mkPtr "stack_wi" 0)
                                      (mkPtr "slot_rtt" 0)
                                      (mkPtr "slot_rd" 0)
                                      (mkPtr "stack_g1" 0)
                                      (mkPtr "stack_g0" 0)
                                      st
                                      (st_1.[share].[slots] :< ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1)))));
                                (Some (v_call6, st_2)))
                              else (
                                when cid_1 == (((((st_1.(share)).(granules)) @ ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED)).(e_lock)));
                                rely (((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                                when cid_2 == (((((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                                rely (
                                  (((((st_1.(stack)).(stack_g1)) > (0)) /\ (((((st_1.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
                                    (((((st_1.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
                                rely (
                                  (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
                                    (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
                                rely ((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_g0)) mod (16)) = (0)))));
                                if (
                                  match ((((((lens 88 st_1).(share)).(granules)) @ (1152921504605528063 + ((((st_1.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock))) with
                                  | (Some cid_3) => true
                                  | None => false
                                  end)
                                then (
                                  (Some (
                                    1  ,
                                    (((lens 89 st_1).[share].[granule_data] :<
                                      (((st_1.(share)).(granule_data)) #
                                        ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED) ==
                                        ((((st_1.(share)).(granule_data)) @ ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED)).[g_norm] :< zero_granule_data_normal))).[share].[slots] :<
                                      ((((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
                                  )))
                                else None)))
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
                    else None)
                  else (
                    when v_call6, st_2 == (
                        (data_create_5
                          (mkPtr "slot_rd" 0)
                          (mkPtr "stack_g1" 0)
                          (mkPtr "stack_g0" 0)
                          1
                          st
                          (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
                    (Some (v_call6, st_2))))
                else (
                  when v_call6, st_2 == (
                      (data_create_5
                        (mkPtr "slot_rd" 0)
                        (mkPtr "stack_g1" 0)
                        (mkPtr "stack_g0" 0)
                        1
                        st
                        (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
                  (Some (v_call6, st_2))))
              else (
                when v_call6, st_2 == (
                    (data_create_5
                      (mkPtr "slot_rd" 0)
                      (mkPtr "stack_g1" 0)
                      (mkPtr "stack_g0" 0)
                      2
                      st
                      (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
                (Some (v_call6, st_2))))
            else (Some (1, st_4)))
          else (Some (1, st)))
        else None))
    else (Some (1, st)))
  else (Some (1, st)).

