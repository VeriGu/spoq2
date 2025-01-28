Definition smc_realm_activate_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
  rely (
    (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
      (((v_0 & (4095)) = (0)))));
  if ((v_0 - (MEM1_PHYS)) >=? (0))
  then (
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    match ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
    | None =>
      rely (
        (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
          (((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
          (0)));
      if ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
      then (
        when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
        when ret_0 == ((buffer_map_spec' 2 ret false));
        rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
        rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
        if (((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_state_s_rd)) =? (0))
        then (
          (Some (
            0  ,
            ((lens 6 st).[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          )))
        else (
          (Some (
            5  ,
            ((lens 7 st).[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          ))))
      else (
        (Some (
          4294967553  ,
          ((lens 8 st).[log] :<
            ((EVT
              CPU_ID
              (REL
                ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
        )))
    | (Some cid) => None
    end)
  else (
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    match ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
    | None =>
      rely (
        (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
          (((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
          (0)));
      if ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
      then (
        when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
        when ret_0 == ((buffer_map_spec' 2 ret false));
        rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
        rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
        if (((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_state_s_rd)) =? (0))
        then (
          (Some (
            0  ,
            ((lens 9 st).[log] :<
              ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          )))
        else (
          (Some (
            5  ,
            ((lens 10 st).[log] :<
              ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          ))))
      else (
        (Some (
          4294967553  ,
          ((lens 11 st).[log] :<
            ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
        )))
    | (Some cid) => None
    end).



Definition smc_read_feature_register_spec (v_0: Z) (v_1: Ptr) (st: RData) : (option RData) :=
  rely ((((v_1.(pbase)) = ("stack_s_smc_result")) /\ (((v_1.(poffset)) = (0)))));
  if (v_0 =? (0))
  then (
    when ret, st' == ((max_pa_size_spec' st));
    (Some (lens 0 st)))
  else (Some (lens 1 st)).



  Definition smc_rtt_unmap_protected_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
  rely (
    (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
      (((v_0 & (4095)) = (0)))));
  if ((v_0 - (MEM1_PHYS)) >=? (0))
  then (
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    match ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
    | None =>
      rely (
        (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
          (((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
          (0)));
      if ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
      then (
        when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
        when ret_0 == ((buffer_map_spec' 2 ret false));
        rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
        rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
        when ret_1, st' == (
            (validate_rtt_map_cmds_spec'
              v_1
              v_2
              ret_0
              ((lens 54 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
        if (ret_1 =? (0))
        then (
          rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
          rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
          when ret_2, st'_0 == (
              (realm_rtt_starting_level_spec'
                ret_0
                ((lens 55 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          when ret_3, st'_1 == (
              (realm_ipa_bits_spec'
                ret_0
                ((lens 56 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          when sh_0 == (
              ((st.(repl))
                ((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                (sh.[globals].[g_granules] :<
                  (((sh.(globals)).(g_granules)) #
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                    ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
          match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
          | None =>
            rely (
              ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
            if (
              ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                (5)) =?
                (0)))
            then (
              when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
              when st_10 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr "stack_s_rtt_walk" 0)
                    (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                    ret_2
                    ret_3
                    v_1
                    v_2
                    ((lens 57 st).[log] :<
                      ((EVT
                        CPU_ID
                        (REL ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) (((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                        (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                          ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                            (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
              rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
              rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
              rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
              if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
              then (
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    )));
                when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                when v_32, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                when ret_6 == ((s2tte_is_valid_spec' v_32 v_2));
                if ret_6
                then (
                  when ret_7 == ((s2tte_pa_spec' v_32 v_2));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                  if (v_2 =? (3))
                  then (
                    match (
                      (stage2_tlbi_ipa_loop210
                        (z_to_nat 0)
                        false
                        v_1
                        4096
                        ((lens 20 st_15).[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                            ((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                (ret_7 |' (4)))))))
                    ) with
                    | (Some (__break__, v__13, v__912, st_4)) =>
                      when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        0  ,
                        ((lens 60 st_4).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_4.(log)))))
                      ))
                    | None => None
                    end)
                  else (
                    when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      0  ,
                      (((lens 61 st_15).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_15.(log))))).[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                          ((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                              (ret_7 |' (4))))))
                    ))))
                else (
                  when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    9  ,
                    ((lens 62 st_15).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_15.(log)))))
                  ))))
              else (
                when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                (Some (
                  ((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                    ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                  ((lens 63 st_10).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st_10.(log)))))
                ))))
            else (
              when cid == (
                  ((((((sh_0.(globals)).(g_granules)) #
                    (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                    ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                      None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
              when st_10 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr "stack_s_rtt_walk" 0)
                    (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                    ret_2
                    ret_3
                    v_1
                    v_2
                    ((lens 64 st).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                          ((((sh_0.(globals)).(g_granules)) #
                            (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                            ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                              None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                        (((EVT
                          CPU_ID
                          (REL
                            (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                            ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID)))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))))));
              rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
              rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
              rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
              if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
              then (
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                when v_32, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                when ret_6 == ((s2tte_is_valid_spec' v_32 v_2));
                if ret_6
                then (
                  when ret_7 == ((s2tte_pa_spec' v_32 v_2));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                  if (v_2 =? (3))
                  then (
                    match (
                      (stage2_tlbi_ipa_loop210
                        (z_to_nat 0)
                        false
                        v_1
                        4096
                        ((lens 27 st_15).[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                            ((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                (ret_7 |' (4)))))))
                    ) with
                    | (Some (__break__, v__13, v__912, st_4)) =>
                      when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        0  ,
                        ((lens 67 st_4).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_4.(log)))))
                      ))
                    | None => None
                    end)
                  else (
                    when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      0  ,
                      (((lens 68 st_15).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_15.(log))))).[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                          ((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                              (ret_7 |' (4))))))
                    ))))
                else (
                  when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    9  ,
                    ((lens 69 st_15).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_15.(log)))))
                  ))))
              else (
                when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                (Some (
                  ((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                    ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                  ((lens 70 st_10).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st_10.(log)))))
                ))))
          | (Some cid) => None
          end)
        else (
          (Some (
            (((((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (2)) << (32)) + (ret_1))))  ,
            ((lens 71 st).[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          ))))
      else (
        (Some (
          4294967553  ,
          ((lens 72 st).[log] :<
            ((EVT
              CPU_ID
              (REL
                ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
        )))
    | (Some cid) => None
    end)
  else (
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    match ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
    | None =>
      rely (
        (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
          (((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
          (0)));
      if ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
      then (
        when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
        when ret_0 == ((buffer_map_spec' 2 ret false));
        rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
        rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
        when ret_1, st' == (
            (validate_rtt_map_cmds_spec'
              v_1
              v_2
              ret_0
              ((lens 73 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
        if (ret_1 =? (0))
        then (
          rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
          rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
          when ret_2, st'_0 == (
              (realm_rtt_starting_level_spec'
                ret_0
                ((lens 74 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 ((lens 75 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          when sh_0 == (
              ((st.(repl))
                ((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                (sh.[globals].[g_granules] :<
                  (((sh.(globals)).(g_granules)) #
                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                    ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
          match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
          | None =>
            rely (
              ((((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
            if (
              ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                (5)) =?
                (0)))
            then (
              when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
              when st_10 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr "stack_s_rtt_walk" 0)
                    (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                    ret_2
                    ret_3
                    v_1
                    v_2
                    ((lens 76 st).[log] :<
                      ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) (((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                        (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                          ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                            (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
              rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
              rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
              rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
              if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
              then (
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                when v_32, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                when ret_6 == ((s2tte_is_valid_spec' v_32 v_2));
                if ret_6
                then (
                  when ret_7 == ((s2tte_pa_spec' v_32 v_2));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                  if (v_2 =? (3))
                  then (
                    match (
                      (stage2_tlbi_ipa_loop210
                        (z_to_nat 0)
                        false
                        v_1
                        4096
                        ((lens 39 st_15).[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                            ((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                (ret_7 |' (4)))))))
                    ) with
                    | (Some (__break__, v__13, v__912, st_4)) =>
                      when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        0  ,
                        ((lens 79 st_4).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_4.(log)))))
                      ))
                    | None => None
                    end)
                  else (
                    when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      0  ,
                      (((lens 80 st_15).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_15.(log))))).[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                          ((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                              (ret_7 |' (4))))))
                    ))))
                else (
                  when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    9  ,
                    ((lens 81 st_15).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_15.(log)))))
                  ))))
              else (
                when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                (Some (
                  ((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                    ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                  ((lens 82 st_10).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st_10.(log)))))
                ))))
            else (
              when cid == (
                  ((((((sh_0.(globals)).(g_granules)) #
                    (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                    ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                      None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
              when st_10 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr "stack_s_rtt_walk" 0)
                    (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                    ret_2
                    ret_3
                    v_1
                    v_2
                    ((lens 83 st).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          ((v_0 + ((- MEM0_PHYS))) >> (12))
                          ((((sh_0.(globals)).(g_granules)) #
                            (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                            ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                              None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                        (((EVT
                          CPU_ID
                          (REL
                            (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                            ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID)))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))))));
              rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
              rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
              rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
              if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
              then (
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                when v_32, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                when ret_6 == ((s2tte_is_valid_spec' v_32 v_2));
                if ret_6
                then (
                  when ret_7 == ((s2tte_pa_spec' v_32 v_2));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                  if (v_2 =? (3))
                  then (
                    match (
                      (stage2_tlbi_ipa_loop210
                        (z_to_nat 0)
                        false
                        v_1
                        4096
                        ((lens 46 st_15).[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                            ((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                (ret_7 |' (4)))))))
                    ) with
                    | (Some (__break__, v__13, v__912, st_4)) =>
                      when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        0  ,
                        ((lens 86 st_4).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_4.(log)))))
                      ))
                    | None => None
                    end)
                  else (
                    when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      0  ,
                      (((lens 87 st_15).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_15.(log))))).[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                          ((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                              (ret_7 |' (4))))))
                    ))))
                else (
                  when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    9  ,
                    ((lens 88 st_15).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_15.(log)))))
                  ))))
              else (
                when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                (Some (
                  ((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                    ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                  ((lens 89 st_10).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st_10.(log)))))
                ))))
          | (Some cid) => None
          end)
        else (
          (Some (
            (((((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (2)) << (32)) + (ret_1))))  ,
            ((lens 90 st).[log] :<
              ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          ))))
      else (
        (Some (
          4294967553  ,
          ((lens 91 st).[log] :<
            ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
        )))
    | (Some cid) => None
    end).




  Definition smc_rtt_read_entry_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option RData) :=
    rely ((((v_3.(pbase)) = ("stack_s_smc_result")) /\ (((v_3.(poffset)) = (0)))));
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    if ((v_0 - (MEM1_PHYS)) >=? (0))
    then (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
            (((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
            (0)));
        if ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == (
              (validate_rtt_entry_cmds_spec'
                v_1
                v_2
                ret_0
                ((lens 86 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          if (ret_1 =? (0))
          then (
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
            when ret_2, st'_0 == (
                (realm_rtt_starting_level_spec'
                  ret_0
                  ((lens 87 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when ret_3, st'_1 == (
                (realm_ipa_bits_spec'
                  ret_0
                  ((lens 88 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when sh_0 == (
                ((st.(repl))
                  ((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
            | None =>
              rely (
                (((((((sh.(globals)).(g_granules)) #
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                  (0)));
              rely (
                ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                  ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              if (
                ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                when st_9 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      v_2
                      ((lens 89 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) (((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
                rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
                rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
                if ((v_29 & (63)) =? (0))
                then (
                  when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some ((lens 92 st_14).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st_14.(log)))))))
                else (
                  if ((v_29 & (63)) =? (8))
                  then (
                    when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some ((lens 95 st_14).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_14.(log)))))))
                  else (
                    if ((v_29 & (63)) =? (4))
                    then (
                      when ret_6 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                      when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some ((lens 98 st_14).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_14.(log)))))))
                    else (
                      when ret_6 == ((s2tte_is_valid_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                      if ret_6
                      then (
                        when ret_7 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                        when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some ((lens 101 st_14).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_14.(log)))))))
                      else (
                        when ret_7 == ((s2tte_is_valid_ns_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                        if ret_7
                        then (
                          when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some ((lens 104 st_14).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_14.(log)))))))
                        else (
                          if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) <? (3)) && (((v_29 & (3)) =? (3))))
                          then (
                            when ret_8 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                            when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some ((lens 107 st_14).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_14.(log)))))))
                          else (
                            when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some ((lens 110 st_14).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_14.(log)))))))))))))
              else (
                when cid == (
                    ((((((sh_0.(globals)).(g_granules)) #
                      (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                      ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                when st_9 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      v_2
                      ((lens 111 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                          (((EVT
                            CPU_ID
                            (REL
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID)))) ::
                            (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))))));
                rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
                rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
                if ((v_29 & (63)) =? (0))
                then (
                  when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some ((lens 114 st_14).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st_14.(log)))))))
                else (
                  if ((v_29 & (63)) =? (8))
                  then (
                    when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some ((lens 117 st_14).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_14.(log)))))))
                  else (
                    if ((v_29 & (63)) =? (4))
                    then (
                      when ret_6 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                      when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some ((lens 120 st_14).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_14.(log)))))))
                    else (
                      when ret_6 == ((s2tte_is_valid_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                      if ret_6
                      then (
                        when ret_7 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                        when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some ((lens 123 st_14).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_14.(log)))))))
                      else (
                        when ret_7 == ((s2tte_is_valid_ns_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                        if ret_7
                        then (
                          when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some ((lens 126 st_14).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_14.(log)))))))
                        else (
                          if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) <? (3)) && (((v_29 & (3)) =? (3))))
                          then (
                            when ret_8 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                            when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some ((lens 129 st_14).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_14.(log)))))))
                          else (
                            when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some ((lens 132 st_14).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_14.(log)))))))))))))
            | (Some cid) => None
            end)
          else (
            (Some ((lens 135 st).[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))
        else (
          (Some ((lens 138 st).[log] :<
            ((EVT
              CPU_ID
              (REL
                ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))
      | (Some cid) => None
      end)
    else (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
            (((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
            (0)));
        if ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == (
              (validate_rtt_entry_cmds_spec'
                v_1
                v_2
                ret_0
                ((lens 139 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          if (ret_1 =? (0))
          then (
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
            when ret_2, st'_0 == (
                (realm_rtt_starting_level_spec'
                  ret_0
                  ((lens 140 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 ((lens 141 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when sh_0 == (
                ((st.(repl))
                  ((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
            | None =>
              rely (
                (((((((sh.(globals)).(g_granules)) #
                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                  ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                  (0)));
              rely (
                ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                  ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              if (
                ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                when st_9 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      v_2
                      ((lens 142 st).[log] :<
                        ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) (((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
                rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
                rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
                if ((v_29 & (63)) =? (0))
                then (
                  when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some ((lens 145 st_14).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st_14.(log)))))))
                else (
                  if ((v_29 & (63)) =? (8))
                  then (
                    when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some ((lens 148 st_14).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_14.(log)))))))
                  else (
                    if ((v_29 & (63)) =? (4))
                    then (
                      when ret_6 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                      when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some ((lens 151 st_14).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_14.(log)))))))
                    else (
                      when ret_6 == ((s2tte_is_valid_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                      if ret_6
                      then (
                        when ret_7 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                        when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some ((lens 154 st_14).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_14.(log)))))))
                      else (
                        when ret_7 == ((s2tte_is_valid_ns_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                        if ret_7
                        then (
                          when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some ((lens 157 st_14).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_14.(log)))))))
                        else (
                          if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) <? (3)) && (((v_29 & (3)) =? (3))))
                          then (
                            when ret_8 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                            when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some ((lens 160 st_14).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_14.(log)))))))
                          else (
                            when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some ((lens 163 st_14).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_14.(log)))))))))))))
              else (
                when cid == (
                    ((((((sh_0.(globals)).(g_granules)) #
                      (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                      ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                when st_9 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      v_2
                      ((lens 164 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((v_0 + ((- MEM0_PHYS))) >> (12))
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                          (((EVT
                            CPU_ID
                            (REL
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID)))) ::
                            (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))))));
                rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                rely (
                  ((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                    ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                    ((6 >= (0)))) /\
                    ((6 <= (24)))));
                when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
                rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
                if ((v_29 & (63)) =? (0))
                then (
                  when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some ((lens 167 st_14).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                        ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                      ((st_14.(log)))))))
                else (
                  if ((v_29 & (63)) =? (8))
                  then (
                    when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some ((lens 170 st_14).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_14.(log)))))))
                  else (
                    if ((v_29 & (63)) =? (4))
                    then (
                      when ret_6 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                      when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some ((lens 173 st_14).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_14.(log)))))))
                    else (
                      when ret_6 == ((s2tte_is_valid_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                      if ret_6
                      then (
                        when ret_7 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                        when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some ((lens 176 st_14).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_14.(log)))))))
                      else (
                        when ret_7 == ((s2tte_is_valid_ns_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                        if ret_7
                        then (
                          when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some ((lens 179 st_14).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_14.(log)))))))
                        else (
                          if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) <? (3)) && (((v_29 & (3)) =? (3))))
                          then (
                            when ret_8 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
                            when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some ((lens 182 st_14).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_14.(log)))))))
                          else (
                            when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some ((lens 185 st_14).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_14.(log)))))))))))))
            | (Some cid) => None
            end)
          else (
            (Some ((lens 188 st).[log] :<
              ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))
        else (
          (Some ((lens 191 st).[log] :<
            ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))
      | (Some cid) => None
      end).



Definition smc_rtt_destroy_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - (4294967296)) < (0)))) \/ ((((v_1 - (MEM1_PHYS)) >= (0)) /\ (((v_1 - (556198264832)) < (0)))))) /\
        (((v_1 & (4095)) = (0)))));
    if ((v_1 - (MEM1_PHYS)) >=? (0))
    then (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
            (((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
            (0)));
        if ((((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == (
              (validate_rtt_structure_cmds_spec'
                v_2
                v_3
                ret_0
                ((lens 54 st).[log] :< ((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          if (ret_1 =? (0))
          then (
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
            when ret_2, st'_0 == (
                (realm_rtt_starting_level_spec'
                  ret_0
                  ((lens 55 st).[log] :< ((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when ret_3, st'_1 == (
                (realm_ipa_bits_spec'
                  ret_0
                  ((lens 56 st).[log] :< ((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when sh_0 == (
                ((st.(repl))
                  ((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      ((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
            | None =>
              rely (
                (((((((sh.(globals)).(g_granules)) #
                  ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                  ((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                  (0)));
              rely (
                ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                  ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              if (
                ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                when st_10 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_2
                      (v_3 + ((- 1)))
                      ((lens 57 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) (((sh_0.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
                rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_34, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                  rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                  if (((v_3 + ((- 1))) <? (3)) && (((v_34 & (3)) =? (3))))
                  then (
                    when ret_6 == ((s2tte_pa_spec' v_34 (v_3 + ((- 1)))));
                    if ((ret_6 - (v_0)) =? (0))
                    then (
                      rely (
                        (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
                          (((v_0 & (4095)) = (0)))));
                      if ((v_0 - (MEM1_PHYS)) >=? (0))
                      then (
                        when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
                        match ((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
                        | None =>
                          rely (
                            (((((((st_15.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
                              (((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
                              (0)));
                          rely ((((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                          rely (((0 = (0)) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
                          if (((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                          then (
                            when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
                            when ret_8 == ((buffer_map_spec' 7 ret_7 false));
                            rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (Some CPU_ID);
                            when cid_1 == (
                                (((((sh_1.(globals)).(g_granules))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val));
                            (Some (
                              0  ,
                              ((lens 58 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
                                        None).[e_state_s_granule] :<
                                        1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_state_s_granule] :<
                                        1))) ::
                                    (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                          else (
                            when cid_0 == (
                                ((((((sh_1.(globals)).(g_granules)) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              4  ,
                              ((lens 59 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                                    (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                        | (Some cid_0) => None
                        end)
                      else (
                        when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
                        match ((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
                        | None =>
                          rely (
                            (((((((st_15.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                              (((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                              (0)));
                          rely ((((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                          if (((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                          then (
                            when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
                            when ret_8 == ((buffer_map_spec' 7 ret_7 false));
                            rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == ((Some CPU_ID));
                            when cid_1 == (
                                ((((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  (((((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                    None).[e_state_s_granule] :<
                                    1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              ((lens 60 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                        None).[e_state_s_granule] :<
                                        1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((v_0 + ((- MEM0_PHYS))) >> (12))
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                                        1))) ::
                                    (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                          else (
                            when cid_0 == (
                                ((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              4  ,
                              ((lens 61 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                                    (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                        | (Some cid_0) => None
                        end))
                    else (
                      when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        4294967553  ,
                        ((lens 62 st_15).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_15.(log)))))
                      ))))
                  else (
                    when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((v_3 + ((- 1))) << (32)) + (8)) >> (24)) & (4294967040)) |' ((((v_3 + ((- 1))) << (32)) + (8))))  ,
                      ((lens 63 st_15).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_15.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 64 st_10).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_10.(log)))))
                  ))))
              else (
                when cid == (
                    ((((((sh_0.(globals)).(g_granules)) #
                      (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                      ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                when st_10 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_2
                      (v_3 + ((- 1)))
                      ((lens 65 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                          (((EVT
                            CPU_ID
                            (REL
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID)))) ::
                            (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))))));
                rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_34, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                  rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                  if (((v_3 + ((- 1))) <? (3)) && (((v_34 & (3)) =? (3))))
                  then (
                    when ret_6 == ((s2tte_pa_spec' v_34 (v_3 + ((- 1)))));
                    if ((ret_6 - (v_0)) =? (0))
                    then (
                      rely (
                        (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
                          (((v_0 & (4095)) = (0)))));
                      if ((v_0 - (MEM1_PHYS)) >=? (0))
                      then (
                        when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
                        match ((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
                        | None =>
                          rely (
                            (((((((st_15.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
                              (((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
                              (0)));
                          rely ((((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                          rely (((0 = (0)) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
                          if (((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                          then (
                            when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
                            when ret_8 == ((buffer_map_spec' 7 ret_7 false));
                            rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (
                                (((((((sh_1.(globals)).(g_granules)) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                            when cid_1 == (
                                ((((((((sh_1.(globals)).(g_granules)) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  (((((((sh_1.(globals)).(g_granules)) #
                                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
                                    None).[e_state_s_granule] :<
                                    1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              ((lens 66 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
                                        None).[e_state_s_granule] :<
                                        1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_state_s_granule] :<
                                        1))) ::
                                    (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                          else (
                            when cid_0 == (
                                ((((((sh_1.(globals)).(g_granules)) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              4  ,
                              ((lens 67 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                                    (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                        | (Some cid_0) => None
                        end)
                      else (
                        when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
                        match ((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
                        | None =>
                          rely (
                            (((((((st_15.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                              (((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                              (0)));
                          rely ((((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                          if (((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                          then (
                            when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
                            when ret_8 == ((buffer_map_spec' 7 ret_7 false));
                            rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (
                                (((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                            when cid_1 == (
                                ((((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  (((((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                    None).[e_state_s_granule] :<
                                    1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              ((lens 68 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                        None).[e_state_s_granule] :<
                                        1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((v_0 + ((- MEM0_PHYS))) >> (12))
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                                        1))) ::
                                    (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                          else (
                            when cid_0 == (
                                ((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              4  ,
                              ((lens 69 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                                    (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                        | (Some cid_0) => None
                        end))
                    else (
                      when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        4294967553  ,
                        ((lens 70 st_15).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_15.(log)))))
                      ))))
                  else (
                    when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((v_3 + ((- 1))) << (32)) + (8)) >> (24)) & (4294967040)) |' ((((v_3 + ((- 1))) << (32)) + (8))))  ,
                      ((lens 71 st_15).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_15.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 72 st_10).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_10.(log)))))
                  ))))
            | (Some cid) => None
            end)
          else (
            (Some (
              (((((((ret_1 >> (32)) + (3)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (3)) << (32)) + (ret_1))))  ,
              ((lens 73 st).[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                    ((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
            ))))
        else (
          (Some (
            8589935105  ,
            ((lens 74 st).[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                  ((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          )))
      | (Some cid) => None
      end)
    else (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
            (((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
            (0)));
        if ((((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_1 + ((- MEM0_PHYS))) >> (12)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == (
              (validate_rtt_structure_cmds_spec'
                v_2
                v_3
                ret_0
                ((lens 75 st).[log] :< ((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          if (ret_1 =? (0))
          then (
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
            when ret_2, st'_0 == (
                (realm_rtt_starting_level_spec'
                  ret_0
                  ((lens 76 st).[log] :< ((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 ((lens 77 st).[log] :< ((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when sh_0 == (
                ((st.(repl))
                  ((st.(oracle)) ((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
            | None =>
              rely (
                (((((((sh.(globals)).(g_granules)) #
                  ((v_1 + ((- MEM0_PHYS))) >> (12)) ==
                  ((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                  (0)));
              rely (
                ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                  ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              if (
                ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                when st_10 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_2
                      (v_3 + ((- 1)))
                      ((lens 78 st).[log] :<
                        ((EVT CPU_ID (REL ((v_1 + ((- MEM0_PHYS))) >> (12)) (((sh_0.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
                rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_34, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                  rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                  if (((v_3 + ((- 1))) <? (3)) && (((v_34 & (3)) =? (3))))
                  then (
                    when ret_6 == ((s2tte_pa_spec' v_34 (v_3 + ((- 1)))));
                    if ((ret_6 - (v_0)) =? (0))
                    then (
                      rely (
                        (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
                          (((v_0 & (4095)) = (0)))));
                      if ((v_0 - (MEM1_PHYS)) >=? (0))
                      then (
                        when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
                        match ((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
                        | None =>
                          rely (
                            (((((((st_15.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
                              (((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
                              (0)));
                          rely ((((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                          rely (((0 = (0)) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
                          if (((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                          then (
                            when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
                            when ret_8 == ((buffer_map_spec' 7 ret_7 false));
                            rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (
                                (((((((sh_1.(globals)).(g_granules)) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                            when cid_1 == (
                                ((((((((sh_1.(globals)).(g_granules)) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  (((((((sh_1.(globals)).(g_granules)) #
                                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
                                    None).[e_state_s_granule] :<
                                    1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              ((lens 79 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
                                        None).[e_state_s_granule] :<
                                        1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_state_s_granule] :<
                                        1))) ::
                                    (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                          else (
                            when cid_0 == (
                                ((((((sh_1.(globals)).(g_granules)) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              4  ,
                              ((lens 80 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                                    (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                        | (Some cid_0) => None
                        end)
                      else (
                        when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
                        match ((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
                        | None =>
                          rely (
                            (((((((st_15.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                              (((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                              (0)));
                          rely ((((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                          if (((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                          then (
                            when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
                            when ret_8 == ((buffer_map_spec' 7 ret_7 false));
                            rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (
                                (((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                            when cid_1 == (
                                ((((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  (((((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                    None).[e_state_s_granule] :<
                                    1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              ((lens 81 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                        None).[e_state_s_granule] :<
                                        1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((v_0 + ((- MEM0_PHYS))) >> (12))
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                                        1))) ::
                                    (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                          else (
                            when cid_0 == (
                                ((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              4  ,
                              ((lens 82 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                                    (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                        | (Some cid_0) => None
                        end))
                    else (
                      when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        4294967553  ,
                        ((lens 83 st_15).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_15.(log)))))
                      ))))
                  else (
                    when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((v_3 + ((- 1))) << (32)) + (8)) >> (24)) & (4294967040)) |' ((((v_3 + ((- 1))) << (32)) + (8))))  ,
                      ((lens 84 st_15).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_15.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 85 st_10).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_10.(log)))))
                  ))))
              else (
                when cid == (
                    ((((((sh_0.(globals)).(g_granules)) #
                      (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                      ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                when st_10 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_2
                      (v_3 + ((- 1)))
                      ((lens 86 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((v_1 + ((- MEM0_PHYS))) >> (12))
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))))) ::
                          (((EVT
                            CPU_ID
                            (REL
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID)))) ::
                            (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))))));
                rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_34, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                  rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                  if (((v_3 + ((- 1))) <? (3)) && (((v_34 & (3)) =? (3))))
                  then (
                    when ret_6 == ((s2tte_pa_spec' v_34 (v_3 + ((- 1)))));
                    if ((ret_6 - (v_0)) =? (0))
                    then (
                      rely (
                        (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
                          (((v_0 & (4095)) = (0)))));
                      if ((v_0 - (MEM1_PHYS)) >=? (0))
                      then (
                        when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
                        match ((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
                        | None =>
                          rely (
                            (((((((st_15.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
                              (((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
                              (0)));
                          rely ((((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                          rely (((0 = (0)) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
                          if (((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                          then (
                            when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
                            when ret_8 == ((buffer_map_spec' 7 ret_7 false));
                            rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (
                                (((((((sh_1.(globals)).(g_granules)) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                            when cid_1 == (
                                ((((((((sh_1.(globals)).(g_granules)) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  (((((((sh_1.(globals)).(g_granules)) #
                                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
                                    None).[e_state_s_granule] :<
                                    1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              ((lens 87 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
                                        None).[e_state_s_granule] :<
                                        1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_state_s_granule] :<
                                        1))) ::
                                    (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                          else (
                            when cid_0 == (
                                ((((((sh_1.(globals)).(g_granules)) #
                                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              4  ,
                              ((lens 88 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((sh_1.(globals)).(g_granules)) #
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                      ((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                                    (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                        | (Some cid_0) => None
                        end)
                      else (
                        when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
                        match ((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
                        | None =>
                          rely (
                            (((((((st_15.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                              (((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                              (0)));
                          rely ((((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                          if (((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                          then (
                            when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
                            when ret_8 == ((buffer_map_spec' 7 ret_7 false));
                            rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (
                                (((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                            when cid_1 == (
                                ((((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                  (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                        ((- 1)))))) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  (((((((sh_1.(globals)).(g_granules)) #
                                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                    ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                    None).[e_state_s_granule] :<
                                    1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              ((lens 89 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))))) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      (((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                        None).[e_state_s_granule] :<
                                        1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      ((v_0 + ((- MEM0_PHYS))) >> (12))
                                      ((((((sh_1.(globals)).(g_granules)) #
                                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                        ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((sh_1.(globals)).(g_granules)) #
                                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                          ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((sh_1.(globals)).(g_granules)) #
                                            ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                            ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((sh_1.(globals)).(g_granules)) #
                                              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                              ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                              ((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_state_s_granule] :<
                                        1))) ::
                                    (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                          else (
                            when cid_0 == (
                                ((((((sh_1.(globals)).(g_granules)) #
                                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                  ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              4  ,
                              ((lens 90 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((sh_1.(globals)).(g_granules)) #
                                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                      ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                                    (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_15.(oracle)) (st_15.(log))) ++ ((st_15.(log)))))))))))
                            )))
                        | (Some cid_0) => None
                        end))
                    else (
                      when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        4294967553  ,
                        ((lens 91 st_15).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_15.(log)))))
                      ))))
                  else (
                    when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((v_3 + ((- 1))) << (32)) + (8)) >> (24)) & (4294967040)) |' ((((v_3 + ((- 1))) << (32)) + (8))))  ,
                      ((lens 92 st_15).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_15.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 93 st_10).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_10.(log)))))
                  ))))
            | (Some cid) => None
            end)
          else (
            (Some (
              (((((((ret_1 >> (32)) + (3)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (3)) << (32)) + (ret_1))))  ,
              ((lens 94 st).[log] :<
                ((EVT CPU_ID (REL ((v_1 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
            ))))
        else (
          (Some (
            8589935105  ,
            ((lens 95 st).[log] :<
              ((EVT CPU_ID (REL ((v_1 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          )))
      | (Some cid) => None
      end).


Definition smc_data_destroy_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    if ((v_0 - (MEM1_PHYS)) >=? (0))
    then (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
            (((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
            (0)));
        if ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == (
              (validate_map_addr_spec'
                v_1
                3
                ret_0
                ((lens 50 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          if (ret_1 =? (0))
          then (
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
            when ret_2, st'_0 == (
                (realm_rtt_starting_level_spec'
                  ret_0
                  ((lens 51 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when ret_3, st'_1 == (
                (realm_ipa_bits_spec'
                  ret_0
                  ((lens 52 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when sh_0 == (
                ((st.(repl))
                  ((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
            | None =>
              rely (
                (((((((sh.(globals)).(g_granules)) #
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                  (0)));
              rely (
                ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                  ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              if (
                ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                when st_9 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      3
                      ((lens 53 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) (((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
                rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if ((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_28, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
                  rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
                  if ((v_28 & (63)) =? (4))
                  then (
                    when ret_6 == ((s2tte_pa_spec' v_28 3));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                    rely (
                      (((((ret_6 - (MEM0_PHYS)) >= (0)) /\ (((ret_6 - (4294967296)) < (0)))) \/ ((((ret_6 - (MEM1_PHYS)) >= (0)) /\ (((ret_6 - (556198264832)) < (0)))))) /\
                        (((ret_6 & (4095)) = (0)))));
                    if ((ret_6 - (MEM1_PHYS)) >=? (0))
                    then (
                      when sh_1 == (
                          ((st_14.(repl))
                            ((st_14.(oracle)) (st_14.(log)))
                            (((st_14.(share)).[globals].[g_granules] :<
                              ((((st_14.(share)).(globals)).(g_granules)) #
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
                              (((st_14.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    8))))));
                      match ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        rely (
                          ((((((((st_14.(share)).(globals)).(g_granules)) #
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
                            (((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
                            (0)));
                        if ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (4)) =? (0))
                        then (
                          rely (((0 = (0)) /\ (((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
                          when st_20 == (
                              (granule_memzero_spec
                                (mkPtr "granules" (((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)))
                                1
                                ((lens 54 st_14).[log] :<
                                  ((EVT CPU_ID (ACQ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_14.(oracle)) (st_14.(log))) ++ ((st_14.(log)))))))));
                          when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                          when cid_1 == (
                              (((((((st_20.(share)).(globals)).(g_granules)) #
                                ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            ((lens 55 st_20).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_20.(share)).(globals)).(g_granules)) #
                                    ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                    (((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_state_s_granule] :< 1))) ::
                                  ((st_20.(log)))))))
                          )))
                        else None
                      | (Some cid_0) => None
                      end)
                    else (
                      when sh_1 == (
                          ((st_14.(repl))
                            ((st_14.(oracle)) (st_14.(log)))
                            (((st_14.(share)).[globals].[g_granules] :<
                              ((((st_14.(share)).(globals)).(g_granules)) #
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
                              (((st_14.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    8))))));
                      match ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
                      | None =>
                        rely (
                          ((((((((st_14.(share)).(globals)).(g_granules)) #
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                            (((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                            (0)));
                        if ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (4)) =? (0))
                        then (
                          when st_20 == (
                              (granule_memzero_spec
                                (mkPtr "granules" (((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)))
                                1
                                ((lens 56 st_14).[log] :< ((EVT CPU_ID (ACQ ((ret_6 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_14.(oracle)) (st_14.(log))) ++ ((st_14.(log)))))))));
                          when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).(e_lock)).(e_val)));
                          when cid_1 == (
                              (((((((st_20.(share)).(globals)).(g_granules)) #
                                ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
                                ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            ((lens 57 st_20).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_20.(share)).(globals)).(g_granules)) #
                                    ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
                                    ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))
                                    (((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_state_s_granule] :< 1))) ::
                                  ((st_20.(log)))))))
                          )))
                        else None
                      | (Some cid_0) => None
                      end))
                  else (
                    when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      9  ,
                      ((lens 58 st_14).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_14.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 59 st_9).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_9.(log)))))
                  ))))
              else (
                when cid == (
                    ((((((sh_0.(globals)).(g_granules)) #
                      (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                      ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                when st_9 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      3
                      ((lens 60 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                          (((EVT
                            CPU_ID
                            (REL
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID)))) ::
                            (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))))));
                rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if ((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_28, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
                  rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
                  if ((v_28 & (63)) =? (4))
                  then (
                    when ret_6 == ((s2tte_pa_spec' v_28 3));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                    rely (
                      (((((ret_6 - (MEM0_PHYS)) >= (0)) /\ (((ret_6 - (4294967296)) < (0)))) \/ ((((ret_6 - (MEM1_PHYS)) >= (0)) /\ (((ret_6 - (556198264832)) < (0)))))) /\
                        (((ret_6 & (4095)) = (0)))));
                    if ((ret_6 - (MEM1_PHYS)) >=? (0))
                    then (
                      when sh_1 == (
                          ((st_14.(repl))
                            ((st_14.(oracle)) (st_14.(log)))
                            (((st_14.(share)).[globals].[g_granules] :<
                              ((((st_14.(share)).(globals)).(g_granules)) #
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
                              (((st_14.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    8))))));
                      match ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        rely (
                          ((((((((st_14.(share)).(globals)).(g_granules)) #
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
                            (((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
                            (0)));
                        if ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (4)) =? (0))
                        then (
                          rely (((0 = (0)) /\ (((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
                          when st_20 == (
                              (granule_memzero_spec
                                (mkPtr "granules" (((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)))
                                1
                                ((lens 61 st_14).[log] :<
                                  ((EVT CPU_ID (ACQ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_14.(oracle)) (st_14.(log))) ++ ((st_14.(log)))))))));
                          when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                          when cid_1 == (
                              (((((((st_20.(share)).(globals)).(g_granules)) #
                                ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            ((lens 62 st_20).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_20.(share)).(globals)).(g_granules)) #
                                    ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                    (((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_state_s_granule] :< 1))) ::
                                  ((st_20.(log)))))))
                          )))
                        else None
                      | (Some cid_0) => None
                      end)
                    else (
                      when sh_1 == (
                          ((st_14.(repl))
                            ((st_14.(oracle)) (st_14.(log)))
                            (((st_14.(share)).[globals].[g_granules] :<
                              ((((st_14.(share)).(globals)).(g_granules)) #
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
                              (((st_14.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    8))))));
                      match ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
                      | None =>
                        rely (
                          ((((((((st_14.(share)).(globals)).(g_granules)) #
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                            (((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                            (0)));
                        if ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (4)) =? (0))
                        then (
                          when st_20 == (
                              (granule_memzero_spec
                                (mkPtr "granules" (((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)))
                                1
                                ((lens 63 st_14).[log] :< ((EVT CPU_ID (ACQ ((ret_6 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_14.(oracle)) (st_14.(log))) ++ ((st_14.(log)))))))));
                          when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).(e_lock)).(e_val)));
                          when cid_1 == (
                              (((((((st_20.(share)).(globals)).(g_granules)) #
                                ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
                                ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            ((lens 64 st_20).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_20.(share)).(globals)).(g_granules)) #
                                    ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
                                    ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))
                                    (((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_state_s_granule] :< 1))) ::
                                  ((st_20.(log)))))))
                          )))
                        else None
                      | (Some cid_0) => None
                      end))
                  else (
                    when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      9  ,
                      ((lens 65 st_14).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_14.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 66 st_9).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_9.(log)))))
                  ))))
            | (Some cid) => None
            end)
          else (
            (Some (
              8589935105  ,
              ((lens 67 st).[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                    ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
            ))))
        else (
          (Some (
            4294967553  ,
            ((lens 68 st).[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          )))
      | (Some cid) => None
      end)
    else (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
            (((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
            (0)));
        if ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == (
              (validate_map_addr_spec'
                v_1
                3
                ret_0
                ((lens 69 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          if (ret_1 =? (0))
          then (
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
            when ret_2, st'_0 == (
                (realm_rtt_starting_level_spec'
                  ret_0
                  ((lens 70 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 ((lens 71 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when sh_0 == (
                ((st.(repl))
                  ((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
            | None =>
              rely (
                (((((((sh.(globals)).(g_granules)) #
                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                  ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                  (0)));
              rely (
                ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                  ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              if (
                ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                when st_9 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      3
                      ((lens 72 st).[log] :<
                        ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) (((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
                rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if ((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_28, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
                  rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
                  if ((v_28 & (63)) =? (4))
                  then (
                    when ret_6 == ((s2tte_pa_spec' v_28 3));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                    rely (
                      (((((ret_6 - (MEM0_PHYS)) >= (0)) /\ (((ret_6 - (4294967296)) < (0)))) \/ ((((ret_6 - (MEM1_PHYS)) >= (0)) /\ (((ret_6 - (556198264832)) < (0)))))) /\
                        (((ret_6 & (4095)) = (0)))));
                    if ((ret_6 - (MEM1_PHYS)) >=? (0))
                    then (
                      when sh_1 == (
                          ((st_14.(repl))
                            ((st_14.(oracle)) (st_14.(log)))
                            (((st_14.(share)).[globals].[g_granules] :<
                              ((((st_14.(share)).(globals)).(g_granules)) #
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
                              (((st_14.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    8))))));
                      match ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        rely (
                          ((((((((st_14.(share)).(globals)).(g_granules)) #
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
                            (((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
                            (0)));
                        if ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (4)) =? (0))
                        then (
                          rely (((0 = (0)) /\ (((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
                          when st_20 == (
                              (granule_memzero_spec
                                (mkPtr "granules" (((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)))
                                1
                                ((lens 73 st_14).[log] :<
                                  ((EVT CPU_ID (ACQ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_14.(oracle)) (st_14.(log))) ++ ((st_14.(log)))))))));
                          when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                          when cid_1 == (
                              (((((((st_20.(share)).(globals)).(g_granules)) #
                                ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            ((lens 74 st_20).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_20.(share)).(globals)).(g_granules)) #
                                    ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                    (((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_state_s_granule] :< 1))) ::
                                  ((st_20.(log)))))))
                          )))
                        else None
                      | (Some cid_0) => None
                      end)
                    else (
                      when sh_1 == (
                          ((st_14.(repl))
                            ((st_14.(oracle)) (st_14.(log)))
                            (((st_14.(share)).[globals].[g_granules] :<
                              ((((st_14.(share)).(globals)).(g_granules)) #
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
                              (((st_14.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    8))))));
                      match ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
                      | None =>
                        rely (
                          ((((((((st_14.(share)).(globals)).(g_granules)) #
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                            (((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                            (0)));
                        if ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (4)) =? (0))
                        then (
                          when st_20 == (
                              (granule_memzero_spec
                                (mkPtr "granules" (((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)))
                                1
                                ((lens 75 st_14).[log] :< ((EVT CPU_ID (ACQ ((ret_6 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_14.(oracle)) (st_14.(log))) ++ ((st_14.(log)))))))));
                          when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).(e_lock)).(e_val)));
                          when cid_1 == (
                              (((((((st_20.(share)).(globals)).(g_granules)) #
                                ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
                                ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            ((lens 76 st_20).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_20.(share)).(globals)).(g_granules)) #
                                    ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
                                    ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))
                                    (((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_state_s_granule] :< 1))) ::
                                  ((st_20.(log)))))))
                          )))
                        else None
                      | (Some cid_0) => None
                      end))
                  else (
                    when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      9  ,
                      ((lens 77 st_14).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_14.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 78 st_9).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_9.(log)))))
                  ))))
              else (
                when cid == (
                    ((((((sh_0.(globals)).(g_granules)) #
                      (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                      ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                when st_9 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      3
                      ((lens 79 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((v_0 + ((- MEM0_PHYS))) >> (12))
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                          (((EVT
                            CPU_ID
                            (REL
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID)))) ::
                            (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))))));
                rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if ((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_28, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
                  rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
                  if ((v_28 & (63)) =? (4))
                  then (
                    when ret_6 == ((s2tte_pa_spec' v_28 3));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                    rely (
                      (((((ret_6 - (MEM0_PHYS)) >= (0)) /\ (((ret_6 - (4294967296)) < (0)))) \/ ((((ret_6 - (MEM1_PHYS)) >= (0)) /\ (((ret_6 - (556198264832)) < (0)))))) /\
                        (((ret_6 & (4095)) = (0)))));
                    if ((ret_6 - (MEM1_PHYS)) >=? (0))
                    then (
                      when sh_1 == (
                          ((st_14.(repl))
                            ((st_14.(oracle)) (st_14.(log)))
                            (((st_14.(share)).[globals].[g_granules] :<
                              ((((st_14.(share)).(globals)).(g_granules)) #
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
                              (((st_14.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    8))))));
                      match ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
                      | None =>
                        rely (
                          ((((((((st_14.(share)).(globals)).(g_granules)) #
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
                            (((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
                            (0)));
                        if ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (4)) =? (0))
                        then (
                          rely (((0 = (0)) /\ (((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
                          when st_20 == (
                              (granule_memzero_spec
                                (mkPtr "granules" (((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)))
                                1
                                ((lens 80 st_14).[log] :<
                                  ((EVT CPU_ID (ACQ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st_14.(oracle)) (st_14.(log))) ++ ((st_14.(log)))))))));
                          when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                          when cid_1 == (
                              (((((((st_20.(share)).(globals)).(g_granules)) #
                                ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            ((lens 81 st_20).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_20.(share)).(globals)).(g_granules)) #
                                    ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                    ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                    (((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_state_s_granule] :< 1))) ::
                                  ((st_20.(log)))))))
                          )))
                        else None
                      | (Some cid_0) => None
                      end)
                    else (
                      when sh_1 == (
                          ((st_14.(repl))
                            ((st_14.(oracle)) (st_14.(log)))
                            (((st_14.(share)).[globals].[g_granules] :<
                              ((((st_14.(share)).(globals)).(g_granules)) #
                                (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
                              (((st_14.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    8))))));
                      match ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
                      | None =>
                        rely (
                          ((((((((st_14.(share)).(globals)).(g_granules)) #
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                              ((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                            (((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                            (0)));
                        if ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (4)) =? (0))
                        then (
                          when st_20 == (
                              (granule_memzero_spec
                                (mkPtr "granules" (((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)))
                                1
                                ((lens 82 st_14).[log] :< ((EVT CPU_ID (ACQ ((ret_6 + ((- MEM0_PHYS))) >> (12)))) :: ((((st_14.(oracle)) (st_14.(log))) ++ ((st_14.(log)))))))));
                          when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).(e_lock)).(e_val)));
                          when cid_1 == (
                              (((((((st_20.(share)).(globals)).(g_granules)) #
                                ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
                                ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            ((lens 83 st_20).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_20.(share)).(globals)).(g_granules)) #
                                    ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
                                    ((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))
                                    (((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_state_s_granule] :< 1))) ::
                                  ((st_20.(log)))))))
                          )))
                        else None
                      | (Some cid_0) => None
                      end))
                  else (
                    when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      9  ,
                      ((lens 84 st_14).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_14.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 85 st_9).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_9.(log)))))
                  ))))
            | (Some cid) => None
            end)
          else (
            (Some (
              8589935105  ,
              ((lens 86 st).[log] :<
                ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
            ))))
        else (
          (Some (
            4294967553  ,
            ((lens 87 st).[log] :<
              ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          )))
      | (Some cid) => None
      end).


Definition smc_data_create_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_3 - (MEM1_PHYS)) >=? (0))
    then (
      if ((v_1 & (1)) =? (0))
      then (
        when v_8, st_1 == ((find_lock_two_granules_spec v_0 1 (mkPtr "stack_type_4" 0) v_1 2 (mkPtr "stack_type_4__1" 0) st));
        if (v_8 =? (3))
        then (Some (3, st_1))
        else (
          if (v_8 =? (0))
          then (
            rely (((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
            rely ((((((st_1.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
            rely ((((((st_1.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
            rely ((((((st_1.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
            rely (
              ((((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                ((2 >= (0)))) /\
                ((2 <= (24)))));
            when ret == ((granule_addr_spec' (mkPtr "granules" (((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)))));
            when ret_0 == ((buffer_map_spec' 2 ret false));
            rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
            rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
            rely (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
            when ret_1, st' == ((validate_data_create_spec' v_2 ret_0 st_1));
            if (ret_1 =? (0))
            then (
              rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
              rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
              when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 st_1));
              when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 st_1));
              when sh == (((st_1.(repl)) ((st_1.(oracle)) (st_1.(log))) (st_1.(share))));
              rely (
                ((("granules" = ("granules")) /\ (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                  (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              if (
                (((((((st_1.(share)).(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when st_10 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_2
                      3
                      ((lens 7 st_1).[log] :<
                        ((EVT CPU_ID (ACQ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                          ((((st_1.(oracle)) (st_1.(log))) ++ ((st_1.(log)))))))));
                rely ((((st_10.(share)).(granule_data)) = ((((lens 7 st_1).(share)).(granule_data)))));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if ((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_42, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                  rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                  if ((v_42 & (63)) =? (0))
                  then (
                    rely (((((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                    rely ((((((st_15.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                    rely ((((((st_15.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                    rely ((((((st_15.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                    rely (
                      ((((("granules" = ("granules")) /\ (((((st_15.(stack)).(stack_type_4)) mod (16)) = (0)))) /\ (((((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                        ((1 >= (0)))) /\
                        ((1 <= (24)))));
                    when ret_6 == ((granule_addr_spec' (mkPtr "granules" (((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)))));
                    when ret_7 == ((buffer_map_spec' 1 ret_6 false));
                    rely ((((ret_7.(pbase)) = ("granule_data")) /\ (((ret_7.(poffset)) >= (0)))));
                    when ret_8 == ((granule_addr_spec' (mkPtr "granules" (((v_3 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
                    when ret_9 == ((granule_pa_to_va_spec' ret_8));
                    rely ((((ret_9.(pbase)) = ("granule_data")) /\ (((ret_9.(poffset)) >= (0)))));
                    when v_9, st_2 == ((memcpy_ns_read_spec_state_oracle ret_7 ret_9 4096 st_15));
                    if v_9
                    then (
                      when ret_10 == ((s2tte_get_ripas_spec' v_42));
                      if (ret_10 =? (0))
                      then (
                        rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                        rely ((((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                        if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                        then None
                        else (
                          if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                          then None
                          else (
                            if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                            then None
                            else (
                              rely ((((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                              rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                              rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                              rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                              rely (
                                ((((("granules" = ("granules")) /\ ((((((lens 636 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                  ((((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                  ((4 >= (0)))) /\
                                  ((4 <= (6)))));
                              (Some (
                                0  ,
                                (((lens 748 st_2).[log] :<
                                  ((EVT
                                    CPU_ID
                                    (REL
                                      (((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                      (((((lens 750 st_2).(share)).(globals)).(g_granules)) @ (((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        ((((((lens 636 st_2).(share)).(globals)).(g_granules)) #
                                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((lens 636 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          (((((lens 636 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_2.(log))))))))).[share].[granule_data] :<
                                  (((st_2.(share)).(granule_data)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                    ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                      (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                        (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                        (v_0 |' (4))))))
                              ))))))
                      else (
                        when ret_11 == ((s2tte_create_valid_spec' v_0 3));
                        rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                        rely ((((((lens 755 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                        if (((((lens 755 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                        then None
                        else (
                          if (((((lens 755 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                          then None
                          else (
                            if (((((lens 755 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                            then None
                            else (
                              rely ((((((lens 755 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                              rely (((((((lens 755 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                              rely (((((((lens 755 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                              rely (((((((lens 755 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                              rely (
                                ((((("granules" = ("granules")) /\ ((((((lens 755 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                  ((((((lens 755 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                  ((4 >= (0)))) /\
                                  ((4 <= (6)))));
                              (Some (
                                0  ,
                                (((lens 867 st_2).[log] :<
                                  ((EVT
                                    CPU_ID
                                    (REL
                                      (((((lens 755 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                      (((((lens 869 st_2).(share)).(globals)).(g_granules)) @ (((((lens 755 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((lens 755 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        ((((((lens 755 st_2).(share)).(globals)).(g_granules)) #
                                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((lens 755 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ (((((lens 755 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          (((((lens 755 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_2.(log))))))))).[share].[granule_data] :<
                                  (((st_2.(share)).(granule_data)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                    ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                      (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                        (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                        ret_11))))
                              )))))))
                    else (
                      when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      rely ((((((lens 872 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                      if (((((lens 872 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                      then None
                      else (
                        if (((((lens 872 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                        then None
                        else (
                          if (((((lens 872 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                          then None
                          else (
                            rely ((((((lens 872 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                            rely (((((((lens 872 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                            rely (((((((lens 872 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                            rely (((((((lens 872 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                            rely (
                              ((((("granules" = ("granules")) /\ ((((((lens 872 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                ((((((lens 872 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                ((1 >= (0)))) /\
                                ((1 <= (6)))));
                            (Some (
                              1025  ,
                              ((lens 944 st_2).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((lens 872 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                    (((((lens 946 st_2).(share)).(globals)).(g_granules)) @ (((((lens 872 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((lens 872 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                      (((((lens 872 st_2).(share)).(globals)).(g_granules)) @ (((((lens 872 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                        ((((st_2.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                      ((st_2.(log)))))))))
                            )))))))
                  else (
                    when cid == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    rely ((((((lens 949 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                    if (((((lens 949 st_15).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                    then None
                    else (
                      if (((((lens 949 st_15).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                      then None
                      else (
                        if (((((lens 949 st_15).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                        then None
                        else (
                          rely ((((((lens 949 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                          rely (((((((lens 949 st_15).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                          rely (((((((lens 949 st_15).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                          rely (((((((lens 949 st_15).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                          rely (
                            ((((("granules" = ("granules")) /\ ((((((lens 949 st_15).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                              ((((((lens 949 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                              ((1 >= (0)))) /\
                              ((1 <= (6)))));
                          (Some (
                            9  ,
                            ((lens 1021 st_15).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((lens 949 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                  (((((lens 1023 st_15).(share)).(globals)).(g_granules)) @ (((((lens 949 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    (((((lens 949 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                    (((((lens 949 st_15).(share)).(globals)).(g_granules)) @ (((((lens 949 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                      ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                    ((st_15.(log)))))))))
                          )))))))
                else (
                  when cid == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  rely ((((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                  if (((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                  then None
                  else (
                    if (((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                    then None
                    else (
                      if (((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                      then None
                      else (
                        rely ((((((lens 1026 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                        rely (((((((lens 1026 st_10).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                        rely (((((((lens 1026 st_10).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                        rely (((((((lens 1026 st_10).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                        rely (
                          ((((("granules" = ("granules")) /\ ((((((lens 1026 st_10).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                            ((((((lens 1026 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                            ((1 >= (0)))) /\
                            ((1 <= (6)))));
                        (Some (
                          ((((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                            ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)))) <<
                            (32)) >>
                            (32))  ,
                          ((lens 1098 st_10).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((lens 1026 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                (((((lens 1100 st_10).(share)).(globals)).(g_granules)) @ (((((lens 1026 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                              (((EVT
                                CPU_ID
                                (REL
                                  (((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                  (((((lens 1026 st_10).(share)).(globals)).(g_granules)) @ (((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  ((st_10.(log)))))))))
                        )))))))
              else (
                when st_10 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_2
                      3
                      ((lens 9 st_1).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                            ((((((lens 1 st_1).(share)).(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID)))) ::
                          (((EVT CPU_ID (ACQ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st_1.(oracle)) (st_1.(log))) ++ ((st_1.(log)))))))))));
                rely ((((st_10.(share)).(granule_data)) = ((((lens 9 st_1).(share)).(granule_data)))));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if ((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_42, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                  rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                  if ((v_42 & (63)) =? (0))
                  then (
                    rely (((((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                    rely ((((((st_15.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                    rely ((((((st_15.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                    rely ((((((st_15.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                    rely (
                      ((((("granules" = ("granules")) /\ (((((st_15.(stack)).(stack_type_4)) mod (16)) = (0)))) /\ (((((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                        ((1 >= (0)))) /\
                        ((1 <= (24)))));
                    when ret_6 == ((granule_addr_spec' (mkPtr "granules" (((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)))));
                    when ret_7 == ((buffer_map_spec' 1 ret_6 false));
                    rely ((((ret_7.(pbase)) = ("granule_data")) /\ (((ret_7.(poffset)) >= (0)))));
                    when ret_8 == ((granule_addr_spec' (mkPtr "granules" (((v_3 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
                    when ret_9 == ((granule_pa_to_va_spec' ret_8));
                    rely ((((ret_9.(pbase)) = ("granule_data")) /\ (((ret_9.(poffset)) >= (0)))));
                    when v_9, st_2 == ((memcpy_ns_read_spec_state_oracle ret_7 ret_9 4096 st_15));
                    if v_9
                    then (
                      when ret_10 == ((s2tte_get_ripas_spec' v_42));
                      if (ret_10 =? (0))
                      then (
                        rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                        rely ((((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                        if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                        then None
                        else (
                          if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                          then None
                          else (
                            if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                            then None
                            else (
                              rely ((((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                              rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                              rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                              rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                              rely (
                                ((((("granules" = ("granules")) /\ ((((((lens 636 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                  ((((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                  ((4 >= (0)))) /\
                                  ((4 <= (6)))));
                              (Some (
                                0  ,
                                (((lens 748 st_2).[log] :<
                                  ((EVT
                                    CPU_ID
                                    (REL
                                      (((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                      (((((lens 750 st_2).(share)).(globals)).(g_granules)) @ (((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        ((((((lens 636 st_2).(share)).(globals)).(g_granules)) #
                                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((lens 636 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          (((((lens 636 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_2.(log))))))))).[share].[granule_data] :<
                                  (((st_2.(share)).(granule_data)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                    ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                      (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                        (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                        (v_0 |' (4))))))
                              ))))))
                      else (
                        when ret_11 == ((s2tte_create_valid_spec' v_0 3));
                        rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                        rely ((((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                        if (((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                        then None
                        else (
                          if (((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                          then None
                          else (
                            if (((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                            then None
                            else (
                              rely ((((((lens 1101 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                              rely (((((((lens 1101 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                              rely (((((((lens 1101 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                              rely (((((((lens 1101 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                              rely (
                                ((((("granules" = ("granules")) /\ ((((((lens 1101 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                  ((((((lens 1101 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                  ((4 >= (0)))) /\
                                  ((4 <= (6)))));
                              (Some (
                                0  ,
                                (((lens 1213 st_2).[log] :<
                                  ((EVT
                                    CPU_ID
                                    (REL
                                      (((((lens 1101 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                      (((((lens 1215 st_2).(share)).(globals)).(g_granules)) @ (((((lens 1101 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        ((((((lens 1101 st_2).(share)).(globals)).(g_granules)) #
                                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((lens 1101 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ (((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          (((((lens 1101 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_2.(log))))))))).[share].[granule_data] :<
                                  (((st_2.(share)).(granule_data)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                    ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                      (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                        (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                        ret_11))))
                              )))))))
                    else (
                      when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      rely ((((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                      if (((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                      then None
                      else (
                        if (((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                        then None
                        else (
                          if (((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                          then None
                          else (
                            rely ((((((lens 1218 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                            rely (((((((lens 1218 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                            rely (((((((lens 1218 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                            rely (((((((lens 1218 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                            rely (
                              ((((("granules" = ("granules")) /\ ((((((lens 1218 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                ((((((lens 1218 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                ((1 >= (0)))) /\
                                ((1 <= (6)))));
                            (Some (
                              1025  ,
                              ((lens 1290 st_2).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((lens 1218 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                    (((((lens 1292 st_2).(share)).(globals)).(g_granules)) @ (((((lens 1218 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                      (((((lens 1218 st_2).(share)).(globals)).(g_granules)) @ (((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                        ((((st_2.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                      ((st_2.(log)))))))))
                            )))))))
                  else (
                    when cid == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    rely ((((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                    if (((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                    then None
                    else (
                      if (((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                      then None
                      else (
                        if (((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                        then None
                        else (
                          rely ((((((lens 1295 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                          rely (((((((lens 1295 st_15).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                          rely (((((((lens 1295 st_15).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                          rely (((((((lens 1295 st_15).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                          rely (
                            ((((("granules" = ("granules")) /\ ((((((lens 1295 st_15).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                              ((((((lens 1295 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                              ((1 >= (0)))) /\
                              ((1 <= (6)))));
                          (Some (
                            9  ,
                            ((lens 1367 st_15).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((lens 1295 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                  (((((lens 1369 st_15).(share)).(globals)).(g_granules)) @ (((((lens 1295 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    (((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                    (((((lens 1295 st_15).(share)).(globals)).(g_granules)) @ (((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                      ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                    ((st_15.(log)))))))))
                          )))))))
                else (
                  when cid == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  rely ((((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                  if (((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                  then None
                  else (
                    if (((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                    then None
                    else (
                      if (((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                      then None
                      else (
                        rely ((((((lens 1372 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                        rely (((((((lens 1372 st_10).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                        rely (((((((lens 1372 st_10).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                        rely (((((((lens 1372 st_10).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                        rely (
                          ((((("granules" = ("granules")) /\ ((((((lens 1372 st_10).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                            ((((((lens 1372 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                            ((1 >= (0)))) /\
                            ((1 <= (6)))));
                        (Some (
                          ((((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                            ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)))) <<
                            (32)) >>
                            (32))  ,
                          ((lens 1444 st_10).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((lens 1372 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                (((((lens 1446 st_10).(share)).(globals)).(g_granules)) @ (((((lens 1372 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                              (((EVT
                                CPU_ID
                                (REL
                                  (((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                  (((((lens 1372 st_10).(share)).(globals)).(g_granules)) @ (((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  ((st_10.(log)))))))))
                        ))))))))
            else (
              when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
              rely ((((((lens 1449 st_1).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
              rely (((((((lens 1449 st_1).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
              rely (((((((lens 1449 st_1).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
              rely (((((((lens 1449 st_1).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
              rely (
                ((((("granules" = ("granules")) /\ ((((((lens 1449 st_1).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                  ((((((lens 1449 st_1).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                  ((1 >= (0)))) /\
                  ((1 <= (6)))));
              (Some (
                (((((ret_1 >> (24)) & (4294967040)) |' (ret_1)) << (32)) >> (32))  ,
                ((lens 1465 st_1).[log] :<
                  ((EVT
                    CPU_ID
                    (REL
                      (((((lens 1449 st_1).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                      (((((lens 1467 st_1).(share)).(globals)).(g_granules)) @ (((((lens 1449 st_1).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                    (((EVT
                      CPU_ID
                      (REL
                        ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                        ((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                      ((st_1.(log)))))))
              ))))
          else (Some ((((((((((v_8 >> (32)) + (1)) << (32)) + (1)) >> (24)) & (4294967040)) |' (((((v_8 >> (32)) + (1)) << (32)) + (1)))) << (32)) >> (32)), st_1))))
      else (
        when v_8, st_2 == ((find_lock_two_granules_spec ((v_0 & (281474976710655)) & (((- 1) << (12)))) 1 (mkPtr "stack_type_4" 0) (v_1 & ((- 2))) 3 (mkPtr "stack_type_4__1" 0) st));
        if (v_8 =? (3))
        then (Some (3, st_2))
        else (
          if (v_8 =? (0))
          then (
            rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
            rely (
              ((((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                ((3 >= (0)))) /\
                ((3 <= (24)))));
            when ret == ((granule_addr_spec' (mkPtr "granules" (((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)))));
            when ret_0 == ((buffer_map_spec' 3 ret false));
            rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
            rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
            rely (((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
            rely (
              (((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)) /\
                (((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (MEM0_VIRT)) < (0)))));
            when sh == (((st_2.(repl)) ((st_2.(oracle)) (st_2.(log))) (st_2.(share))));
            rely (
              ((("granules" = ("granules")) /\ (((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) mod (16)) = (0)))) /\
                (((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)))));
            if (
              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                (5)) =?
                (0)))
            then (
              when v_25, st_7 == (
                  (data_create_internal_spec
                    v_0
                    (mkPtr "granules" (((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                    v_2
                    (mkPtr "granules" (((v_3 + ((- MEM1_PHYS))) >> (524300)) * (16)))
                    ret_0
                    1
                    ((lens 7 st_2).[log] :<
                      ((EVT CPU_ID (ACQ ((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                        ((((st_2.(oracle)) (st_2.(log))) ++ ((st_2.(log)))))))));
              if (v_25 =? (0))
              then (
                rely (((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                if ((((st_7.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                then None
                else (
                  if ((((st_7.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                  then None
                  else (
                    if ((((st_7.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                    then None
                    else (
                      when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      rely ((((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                      rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                      rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                      rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                      rely (
                        ((((("granules" = ("granules")) /\ ((((((lens 348 st_7).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                          ((((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                          ((4 >= (0)))) /\
                          ((4 <= (6)))));
                      (Some (
                        ((((v_25 << (32)) >> (32)) << (32)) >> (32))  ,
                        ((lens 364 st_7).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                              (((((lens 366 st_7).(share)).(globals)).(g_granules)) @ (((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                            (((EVT
                              CPU_ID
                              (REL
                                ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                ((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_7.(log)))))))
                      ))))))
              else (
                rely (((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                if ((((st_7.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                then None
                else (
                  if ((((st_7.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                  then None
                  else (
                    if ((((st_7.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                    then None
                    else (
                      when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      rely ((((((lens 384 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                      rely (((((((lens 384 st_7).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                      rely (((((((lens 384 st_7).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                      rely (((((((lens 384 st_7).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                      rely (
                        ((((("granules" = ("granules")) /\ ((((((lens 384 st_7).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                          ((((((lens 384 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                          ((1 >= (0)))) /\
                          ((1 <= (6)))));
                      (Some (
                        ((((v_25 << (32)) >> (32)) << (32)) >> (32))  ,
                        ((lens 400 st_7).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((lens 384 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                              (((((lens 402 st_7).(share)).(globals)).(g_granules)) @ (((((lens 384 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                            (((EVT
                              CPU_ID
                              (REL
                                ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                ((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_7.(log)))))))
                      )))))))
            else (
              when v_25, st_7 == (
                  (data_create_internal_spec
                    v_0
                    (mkPtr "granules" (((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                    v_2
                    (mkPtr "granules" (((v_3 + ((- MEM1_PHYS))) >> (524300)) * (16)))
                    ret_0
                    1
                    ((lens 9 st_2).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          ((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))
                          ((((((lens 1 st_2).(share)).(globals)).(g_granules)) @ ((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                            (Some CPU_ID)))) ::
                        (((EVT CPU_ID (ACQ ((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                          ((((st_2.(oracle)) (st_2.(log))) ++ ((st_2.(log)))))))))));
              if (v_25 =? (0))
              then (
                rely (((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                if ((((st_7.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                then None
                else (
                  if ((((st_7.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                  then None
                  else (
                    if ((((st_7.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                    then None
                    else (
                      when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      rely ((((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                      rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                      rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                      rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                      rely (
                        ((((("granules" = ("granules")) /\ ((((((lens 348 st_7).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                          ((((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                          ((4 >= (0)))) /\
                          ((4 <= (6)))));
                      (Some (
                        ((((v_25 << (32)) >> (32)) << (32)) >> (32))  ,
                        ((lens 364 st_7).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                              (((((lens 366 st_7).(share)).(globals)).(g_granules)) @ (((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                            (((EVT
                              CPU_ID
                              (REL
                                ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                ((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_7.(log)))))))
                      ))))))
              else (
                rely (((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                if ((((st_7.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                then None
                else (
                  if ((((st_7.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                  then None
                  else (
                    if ((((st_7.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                    then None
                    else (
                      when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      rely ((((((lens 420 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                      rely (((((((lens 420 st_7).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                      rely (((((((lens 420 st_7).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                      rely (((((((lens 420 st_7).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                      rely (
                        ((((("granules" = ("granules")) /\ ((((((lens 420 st_7).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                          ((((((lens 420 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                          ((1 >= (0)))) /\
                          ((1 <= (6)))));
                      (Some (
                        ((((v_25 << (32)) >> (32)) << (32)) >> (32))  ,
                        ((lens 436 st_7).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((lens 420 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                              (((((lens 438 st_7).(share)).(globals)).(g_granules)) @ (((((lens 420 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                            (((EVT
                              CPU_ID
                              (REL
                                ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                ((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_7.(log)))))))
                      ))))))))
          else (Some ((((((((((v_8 >> (32)) + (1)) << (32)) + (1)) >> (24)) & (4294967040)) |' (((((v_8 >> (32)) + (1)) << (32)) + (1)))) << (32)) >> (32)), st_2)))))
    else (
      if ((GRANULES_BASE + ((((v_3 + ((- MEM0_PHYS))) >> (12)) * (16)))) =? (0))
      then (Some (17179870209, st))
      else (
        if ((v_1 & (1)) =? (0))
        then (
          rely (((("granules" = ("granules")) /\ (((((v_3 + ((- MEM0_PHYS))) >> (12)) * (16)) >= (0)))) /\ ((0 = (0)))));
          when v_8, st_1 == ((find_lock_two_granules_spec v_0 1 (mkPtr "stack_type_4" 0) v_1 2 (mkPtr "stack_type_4__1" 0) st));
          if (v_8 =? (3))
          then (Some (3, st_1))
          else (
            if (v_8 =? (0))
            then (
              rely (((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
              rely ((((((st_1.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
              rely ((((((st_1.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
              rely ((((((st_1.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
              rely (
                ((((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                  ((2 >= (0)))) /\
                  ((2 <= (24)))));
              when ret == ((granule_addr_spec' (mkPtr "granules" (((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)))));
              when ret_0 == ((buffer_map_spec' 2 ret false));
              rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
              rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
              rely (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
              when ret_1, st' == ((validate_data_create_spec' v_2 ret_0 st_1));
              if (ret_1 =? (0))
              then (
                rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
                rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
                when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 st_1));
                when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 st_1));
                when sh == (((st_1.(repl)) ((st_1.(oracle)) (st_1.(log))) (st_1.(share))));
                rely (
                  ((("granules" = ("granules")) /\ (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                    (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
                if (
                  (((((((st_1.(share)).(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    (5)) =?
                    (0)))
                then (
                  when st_10 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk" 0)
                        (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                        ret_2
                        ret_3
                        v_2
                        3
                        ((lens 7 st_1).[log] :<
                          ((EVT CPU_ID (ACQ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st_1.(oracle)) (st_1.(log))) ++ ((st_1.(log)))))))));
                  rely ((((st_10.(share)).(granule_data)) = ((((lens 7 st_1).(share)).(granule_data)))));
                  rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                  rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                  if ((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                    when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                    when v_42, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                    rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                    if ((v_42 & (63)) =? (0))
                    then (
                      rely (((((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                      rely ((((((st_15.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                      rely ((((((st_15.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                      rely ((((((st_15.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                      rely (
                        ((((("granules" = ("granules")) /\ (((((st_15.(stack)).(stack_type_4)) mod (16)) = (0)))) /\ (((((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                          ((1 >= (0)))) /\
                          ((1 <= (24)))));
                      when ret_6 == ((granule_addr_spec' (mkPtr "granules" (((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)))));
                      when ret_7 == ((buffer_map_spec' 1 ret_6 false));
                      rely ((((ret_7.(pbase)) = ("granule_data")) /\ (((ret_7.(poffset)) >= (0)))));
                      when ret_8 == ((granule_addr_spec' (mkPtr "granules" (((v_3 + ((- MEM0_PHYS))) >> (12)) * (16)))));
                      when ret_9 == ((granule_pa_to_va_spec' ret_8));
                      rely ((((ret_9.(pbase)) = ("granule_data")) /\ (((ret_9.(poffset)) >= (0)))));
                      when v_9, st_2 == ((memcpy_ns_read_spec_state_oracle ret_7 ret_9 4096 st_15));
                      if v_9
                      then (
                        when ret_10 == ((s2tte_get_ripas_spec' v_42));
                        if (ret_10 =? (0))
                        then (
                          rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                          rely ((((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                          if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                          then None
                          else (
                            if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                            then None
                            else (
                              if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                              then None
                              else (
                                rely ((((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                                rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                                rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                                rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                                rely (
                                  ((((("granules" = ("granules")) /\ ((((((lens 636 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                    ((((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                    ((4 >= (0)))) /\
                                    ((4 <= (6)))));
                                (Some (
                                  0  ,
                                  (((lens 748 st_2).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                        (((((lens 750 st_2).(share)).(globals)).(g_granules)) @ (((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                          ((((((lens 636 st_2).(share)).(globals)).(g_granules)) #
                                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((lens 636 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                              None)) @ (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                        (((EVT
                                          CPU_ID
                                          (REL
                                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                            (((((lens 636 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                          ((st_2.(log))))))))).[share].[granule_data] :<
                                    (((st_2.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          (v_0 |' (4))))))
                                ))))))
                        else (
                          when ret_11 == ((s2tte_create_valid_spec' v_0 3));
                          rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                          rely ((((((lens 755 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                          if (((((lens 755 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                          then None
                          else (
                            if (((((lens 755 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                            then None
                            else (
                              if (((((lens 755 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                              then None
                              else (
                                rely ((((((lens 755 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                                rely (((((((lens 755 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                                rely (((((((lens 755 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                                rely (((((((lens 755 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                                rely (
                                  ((((("granules" = ("granules")) /\ ((((((lens 755 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                    ((((((lens 755 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                    ((4 >= (0)))) /\
                                    ((4 <= (6)))));
                                (Some (
                                  0  ,
                                  (((lens 867 st_2).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((lens 755 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                        (((((lens 869 st_2).(share)).(globals)).(g_granules)) @ (((((lens 755 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((lens 755 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                          ((((((lens 755 st_2).(share)).(globals)).(g_granules)) #
                                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((lens 755 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                              None)) @ (((((lens 755 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                        (((EVT
                                          CPU_ID
                                          (REL
                                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                            (((((lens 755 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                          ((st_2.(log))))))))).[share].[granule_data] :<
                                    (((st_2.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          ret_11))))
                                )))))))
                      else (
                        when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        rely ((((((lens 872 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                        if (((((lens 872 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                        then None
                        else (
                          if (((((lens 872 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                          then None
                          else (
                            if (((((lens 872 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                            then None
                            else (
                              rely ((((((lens 872 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                              rely (((((((lens 872 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                              rely (((((((lens 872 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                              rely (((((((lens 872 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                              rely (
                                ((((("granules" = ("granules")) /\ ((((((lens 872 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                  ((((((lens 872 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                  ((1 >= (0)))) /\
                                  ((1 <= (6)))));
                              (Some (
                                1025  ,
                                ((lens 944 st_2).[log] :<
                                  ((EVT
                                    CPU_ID
                                    (REL
                                      (((((lens 872 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                      (((((lens 946 st_2).(share)).(globals)).(g_granules)) @ (((((lens 872 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((lens 872 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        (((((lens 872 st_2).(share)).(globals)).(g_granules)) @ (((((lens 872 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          ((((st_2.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_2.(log)))))))))
                              )))))))
                    else (
                      when cid == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      rely ((((((lens 949 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                      if (((((lens 949 st_15).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                      then None
                      else (
                        if (((((lens 949 st_15).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                        then None
                        else (
                          if (((((lens 949 st_15).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                          then None
                          else (
                            rely ((((((lens 949 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                            rely (((((((lens 949 st_15).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                            rely (((((((lens 949 st_15).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                            rely (((((((lens 949 st_15).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                            rely (
                              ((((("granules" = ("granules")) /\ ((((((lens 949 st_15).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                ((((((lens 949 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                ((1 >= (0)))) /\
                                ((1 <= (6)))));
                            (Some (
                              9  ,
                              ((lens 1021 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((lens 949 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                    (((((lens 1023 st_15).(share)).(globals)).(g_granules)) @ (((((lens 949 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((lens 949 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                      (((((lens 949 st_15).(share)).(globals)).(g_granules)) @ (((((lens 949 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                        ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                      ((st_15.(log)))))))))
                            )))))))
                  else (
                    when cid == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    rely ((((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                    if (((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                    then None
                    else (
                      if (((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                      then None
                      else (
                        if (((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                        then None
                        else (
                          rely ((((((lens 1026 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                          rely (((((((lens 1026 st_10).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                          rely (((((((lens 1026 st_10).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                          rely (((((((lens 1026 st_10).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                          rely (
                            ((((("granules" = ("granules")) /\ ((((((lens 1026 st_10).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                              ((((((lens 1026 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                              ((1 >= (0)))) /\
                              ((1 <= (6)))));
                          (Some (
                            ((((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                              ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)))) <<
                              (32)) >>
                              (32))  ,
                            ((lens 1098 st_10).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((lens 1026 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                  (((((lens 1100 st_10).(share)).(globals)).(g_granules)) @ (((((lens 1026 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    (((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                    (((((lens 1026 st_10).(share)).(globals)).(g_granules)) @ (((((lens 1026 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                      ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                    ((st_10.(log)))))))))
                          )))))))
                else (
                  when st_10 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk" 0)
                        (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                        ret_2
                        ret_3
                        v_2
                        3
                        ((lens 9 st_1).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                              ((((((lens 1 st_1).(share)).(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID)))) ::
                            (((EVT CPU_ID (ACQ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st_1.(oracle)) (st_1.(log))) ++ ((st_1.(log)))))))))));
                  rely ((((st_10.(share)).(granule_data)) = ((((lens 9 st_1).(share)).(granule_data)))));
                  rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                  rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                  if ((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                    when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                    when v_42, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
                    rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
                    if ((v_42 & (63)) =? (0))
                    then (
                      rely (((((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                      rely ((((((st_15.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                      rely ((((((st_15.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                      rely ((((((st_15.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                      rely (
                        ((((("granules" = ("granules")) /\ (((((st_15.(stack)).(stack_type_4)) mod (16)) = (0)))) /\ (((((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                          ((1 >= (0)))) /\
                          ((1 <= (24)))));
                      when ret_6 == ((granule_addr_spec' (mkPtr "granules" (((st_15.(stack)).(stack_type_4)) - (GRANULES_BASE)))));
                      when ret_7 == ((buffer_map_spec' 1 ret_6 false));
                      rely ((((ret_7.(pbase)) = ("granule_data")) /\ (((ret_7.(poffset)) >= (0)))));
                      when ret_8 == ((granule_addr_spec' (mkPtr "granules" (((v_3 + ((- MEM0_PHYS))) >> (12)) * (16)))));
                      when ret_9 == ((granule_pa_to_va_spec' ret_8));
                      rely ((((ret_9.(pbase)) = ("granule_data")) /\ (((ret_9.(poffset)) >= (0)))));
                      when v_9, st_2 == ((memcpy_ns_read_spec_state_oracle ret_7 ret_9 4096 st_15));
                      if v_9
                      then (
                        when ret_10 == ((s2tte_get_ripas_spec' v_42));
                        if (ret_10 =? (0))
                        then (
                          rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                          rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) >? (0)) = (true)));
                          rely (((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MAX_GLOBAL)) <? (0)) = (false)));
                          rely (((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MAX_ERR)) >=? (0)) = (false)));
                          rely (((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM1_VIRT)) >=? (0)) = (false)));
                          rely (((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) >=? (0)) = (false)));
                          rely (((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >=? (0)) = (true)));
                          rely (
                            ((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                              ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                          rely ((((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                          if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                          then None
                          else (
                            if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                            then None
                            else (
                              if (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                              then None
                              else (
                                rely ((((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                                rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                                rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                                rely (((((((lens 636 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                                rely (
                                  ((((("granules" = ("granules")) /\ ((((((lens 636 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                    ((((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                    ((4 >= (0)))) /\
                                    ((4 <= (6)))));
                                (Some (
                                  0  ,
                                  (((lens 748 st_2).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                        (((((lens 750 st_2).(share)).(globals)).(g_granules)) @ (((((lens 636 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                          ((((((lens 636 st_2).(share)).(globals)).(g_granules)) #
                                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((lens 636 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                              None)) @ (((((lens 636 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                        (((EVT
                                          CPU_ID
                                          (REL
                                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                            (((((lens 636 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                          ((st_2.(log))))))))).[share].[granule_data] :<
                                    (((st_2.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          (v_0 |' (4))))))
                                ))))))
                        else (
                          when ret_11 == ((s2tte_create_valid_spec' v_0 3));
                          rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                          rely ((((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                          if (((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                          then None
                          else (
                            if (((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                            then None
                            else (
                              if (((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                              then None
                              else (
                                rely ((((((lens 1101 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                                rely (((((((lens 1101 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                                rely (((((((lens 1101 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                                rely (((((((lens 1101 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                                rely (
                                  ((((("granules" = ("granules")) /\ ((((((lens 1101 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                    ((((((lens 1101 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                    ((4 >= (0)))) /\
                                    ((4 <= (6)))));
                                (Some (
                                  0  ,
                                  (((lens 1213 st_2).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((lens 1101 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                        (((((lens 1215 st_2).(share)).(globals)).(g_granules)) @ (((((lens 1101 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                          ((((((lens 1101 st_2).(share)).(globals)).(g_granules)) #
                                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((lens 1101 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                              None)) @ (((((lens 1101 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                        (((EVT
                                          CPU_ID
                                          (REL
                                            (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                            (((((lens 1101 st_2).(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                          ((st_2.(log))))))))).[share].[granule_data] :<
                                    (((st_2.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          ret_11))))
                                )))))))
                      else (
                        when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        rely ((((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                        if (((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                        then None
                        else (
                          if (((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                          then None
                          else (
                            if (((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                            then None
                            else (
                              rely ((((((lens 1218 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                              rely (((((((lens 1218 st_2).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                              rely (((((((lens 1218 st_2).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                              rely (((((((lens 1218 st_2).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                              rely (
                                ((((("granules" = ("granules")) /\ ((((((lens 1218 st_2).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                  ((((((lens 1218 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                  ((1 >= (0)))) /\
                                  ((1 <= (6)))));
                              (Some (
                                1025  ,
                                ((lens 1290 st_2).[log] :<
                                  ((EVT
                                    CPU_ID
                                    (REL
                                      (((((lens 1218 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                      (((((lens 1292 st_2).(share)).(globals)).(g_granules)) @ (((((lens 1218 st_2).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        (((((lens 1218 st_2).(share)).(globals)).(g_granules)) @ (((((lens 1218 st_2).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          ((((st_2.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_2.(log)))))))))
                              )))))))
                    else (
                      when cid == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      rely ((((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                      if (((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                      then None
                      else (
                        if (((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                        then None
                        else (
                          if (((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                          then None
                          else (
                            rely ((((((lens 1295 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                            rely (((((((lens 1295 st_15).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                            rely (((((((lens 1295 st_15).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                            rely (((((((lens 1295 st_15).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                            rely (
                              ((((("granules" = ("granules")) /\ ((((((lens 1295 st_15).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                                ((((((lens 1295 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                                ((1 >= (0)))) /\
                                ((1 <= (6)))));
                            (Some (
                              9  ,
                              ((lens 1367 st_15).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((lens 1295 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                    (((((lens 1369 st_15).(share)).(globals)).(g_granules)) @ (((((lens 1295 st_15).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                      (((((lens 1295 st_15).(share)).(globals)).(g_granules)) @ (((((lens 1295 st_15).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                        ((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                      ((st_15.(log)))))))))
                            )))))))
                  else (
                    when cid == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    rely ((((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                    if (((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                    then None
                    else (
                      if (((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                      then None
                      else (
                        if (((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                        then None
                        else (
                          rely ((((((lens 1372 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                          rely (((((((lens 1372 st_10).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                          rely (((((((lens 1372 st_10).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                          rely (((((((lens 1372 st_10).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                          rely (
                            ((((("granules" = ("granules")) /\ ((((((lens 1372 st_10).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                              ((((((lens 1372 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                              ((1 >= (0)))) /\
                              ((1 <= (6)))));
                          (Some (
                            ((((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                              ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)))) <<
                              (32)) >>
                              (32))  ,
                            ((lens 1444 st_10).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((lens 1372 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                  (((((lens 1446 st_10).(share)).(globals)).(g_granules)) @ (((((lens 1372 st_10).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    (((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                    (((((lens 1372 st_10).(share)).(globals)).(g_granules)) @ (((((lens 1372 st_10).(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                      ((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                    ((st_10.(log)))))))))
                          ))))))))
              else (
                when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                rely ((((((lens 1449 st_1).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                rely (((((((lens 1449 st_1).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                rely (((((((lens 1449 st_1).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                rely (((((((lens 1449 st_1).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                rely (
                  ((((("granules" = ("granules")) /\ ((((((lens 1449 st_1).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                    ((((((lens 1449 st_1).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                    ((1 >= (0)))) /\
                    ((1 <= (6)))));
                (Some (
                  (((((ret_1 >> (24)) & (4294967040)) |' (ret_1)) << (32)) >> (32))  ,
                  ((lens 1465 st_1).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((lens 1449 st_1).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                        (((((lens 1467 st_1).(share)).(globals)).(g_granules)) @ (((((lens 1449 st_1).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                      (((EVT
                        CPU_ID
                        (REL
                          ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                          ((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_1.(log)))))))
                ))))
            else (Some ((((((((((v_8 >> (32)) + (1)) << (32)) + (1)) >> (24)) & (4294967040)) |' (((((v_8 >> (32)) + (1)) << (32)) + (1)))) << (32)) >> (32)), st_1))))
        else (
          rely (((("granules" = ("granules")) /\ ((0 = (0)))) /\ (((((v_3 + ((- MEM0_PHYS))) >> (12)) * (16)) >= (0)))));
          when v_8, st_2 == ((find_lock_two_granules_spec ((v_0 & (281474976710655)) & (((- 1) << (12)))) 1 (mkPtr "stack_type_4" 0) (v_1 & ((- 2))) 3 (mkPtr "stack_type_4__1" 0) st));
          if (v_8 =? (3))
          then (Some (3, st_2))
          else (
            if (v_8 =? (0))
            then (
              rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
              rely (
                ((((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                  ((3 >= (0)))) /\
                  ((3 <= (24)))));
              when ret == ((granule_addr_spec' (mkPtr "granules" (((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)))));
              when ret_0 == ((buffer_map_spec' 3 ret false));
              rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
              rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
              rely (((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
              rely (
                (((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)) /\
                  (((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (MEM0_VIRT)) < (0)))));
              when sh == (((st_2.(repl)) ((st_2.(oracle)) (st_2.(log))) (st_2.(share))));
              rely (
                ((("granules" = ("granules")) /\ (((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) mod (16)) = (0)))) /\
                  (((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)))));
              if (
                (((((((st_2.(share)).(globals)).(g_granules)) @ ((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when v_25, st_7 == (
                    (data_create_internal_spec
                      v_0
                      (mkPtr "granules" (((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                      v_2
                      (mkPtr "granules" (((v_3 + ((- MEM0_PHYS))) >> (12)) * (16)))
                      ret_0
                      1
                      ((lens 7 st_2).[log] :<
                        ((EVT CPU_ID (ACQ ((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                          ((((st_2.(oracle)) (st_2.(log))) ++ ((st_2.(log)))))))));
                if (v_25 =? (0))
                then (
                  rely (((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                  if ((((st_7.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                  then None
                  else (
                    if ((((st_7.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                    then None
                    else (
                      if ((((st_7.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                      then None
                      else (
                        when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        rely ((((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                        rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                        rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                        rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                        rely (
                          ((((("granules" = ("granules")) /\ ((((((lens 348 st_7).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                            ((((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                            ((4 >= (0)))) /\
                            ((4 <= (6)))));
                        (Some (
                          ((((v_25 << (32)) >> (32)) << (32)) >> (32))  ,
                          ((lens 364 st_7).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                (((((lens 366 st_7).(share)).(globals)).(g_granules)) @ (((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                              (((EVT
                                CPU_ID
                                (REL
                                  ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                  ((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_7.(log)))))))
                        ))))))
                else (
                  rely (((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                  if ((((st_7.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                  then None
                  else (
                    if ((((st_7.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                    then None
                    else (
                      if ((((st_7.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                      then None
                      else (
                        when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        rely ((((((lens 384 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                        rely (((((((lens 384 st_7).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                        rely (((((((lens 384 st_7).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                        rely (((((((lens 384 st_7).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                        rely (
                          ((((("granules" = ("granules")) /\ ((((((lens 384 st_7).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                            ((((((lens 384 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                            ((1 >= (0)))) /\
                            ((1 <= (6)))));
                        (Some (
                          ((((v_25 << (32)) >> (32)) << (32)) >> (32))  ,
                          ((lens 400 st_7).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((lens 384 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                (((((lens 402 st_7).(share)).(globals)).(g_granules)) @ (((((lens 384 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                              (((EVT
                                CPU_ID
                                (REL
                                  ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                  ((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_7.(log)))))))
                        )))))))
              else (
                when v_25, st_7 == (
                    (data_create_internal_spec
                      v_0
                      (mkPtr "granules" (((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                      v_2
                      (mkPtr "granules" (((v_3 + ((- MEM0_PHYS))) >> (12)) * (16)))
                      ret_0
                      1
                      ((lens 9 st_2).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))
                            ((((((lens 1 st_2).(share)).(globals)).(g_granules)) @ ((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID)))) ::
                          (((EVT CPU_ID (ACQ ((((((((st_2.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st_2.(oracle)) (st_2.(log))) ++ ((st_2.(log)))))))))));
                if (v_25 =? (0))
                then (
                  rely (((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                  if ((((st_7.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                  then None
                  else (
                    if ((((st_7.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                    then None
                    else (
                      if ((((st_7.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                      then None
                      else (
                        when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        rely ((((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                        rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                        rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                        rely (((((((lens 348 st_7).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                        rely (
                          ((((("granules" = ("granules")) /\ ((((((lens 348 st_7).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                            ((((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                            ((4 >= (0)))) /\
                            ((4 <= (6)))));
                        (Some (
                          ((((v_25 << (32)) >> (32)) << (32)) >> (32))  ,
                          ((lens 364 st_7).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                (((((lens 366 st_7).(share)).(globals)).(g_granules)) @ (((((lens 348 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                              (((EVT
                                CPU_ID
                                (REL
                                  ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                  ((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_7.(log)))))))
                        ))))))
                else (
                  rely (((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                  if ((((st_7.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                  then None
                  else (
                    if ((((st_7.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                    then None
                    else (
                      if ((((st_7.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                      then None
                      else (
                        when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        rely ((((((lens 420 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                        rely (((((((lens 420 st_7).(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
                        rely (((((((lens 420 st_7).(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
                        rely (((((((lens 420 st_7).(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
                        rely (
                          ((((("granules" = ("granules")) /\ ((((((lens 420 st_7).(stack)).(stack_type_4)) mod (16)) = (0)))) /\
                            ((((((lens 420 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                            ((1 >= (0)))) /\
                            ((1 <= (6)))));
                        (Some (
                          ((((v_25 << (32)) >> (32)) << (32)) >> (32))  ,
                          ((lens 436 st_7).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((lens 420 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                (((((lens 438 st_7).(share)).(globals)).(g_granules)) @ (((((lens 420 st_7).(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                              (((EVT
                                CPU_ID
                                (REL
                                  ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                  ((((st_7.(share)).(globals)).(g_granules)) @ ((((st_7.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_7.(log)))))))
                        ))))))))
            else (Some ((((((((((v_8 >> (32)) + (1)) << (32)) + (1)) >> (24)) & (4294967040)) |' (((((v_8 >> (32)) + (1)) << (32)) + (1)))) << (32)) >> (32)), st_2)))))).

  Definition smc_rtt_unmap_non_secure_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    if ((v_0 - (MEM1_PHYS)) >=? (0))
    then (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
            (((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
            (0)));
        if ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == (
              (validate_rtt_map_cmds_spec'
                v_1
                v_2
                ret_0
                ((lens 1510 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          if (ret_1 =? (0))
          then (
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
            when ret_2, st'_0 == (
                (realm_rtt_starting_level_spec'
                  ret_0
                  ((lens 1511 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when ret_3, st'_1 == (
                (realm_ipa_bits_spec'
                  ret_0
                  ((lens 1512 st).[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when sh_0 == (
                ((st.(repl))
                  ((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
            | None =>
              rely (
                (((((((sh.(globals)).(g_granules)) #
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                  (0)));
              rely (
                ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                  ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              if (
                ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                when st_11 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      v_2
                      ((lens 1513 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) (((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
                rely ((((st_11.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if (((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_42, st_16 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_11));
                  rely ((((st_16.(share)).(granule_data)) = (((st_11.(share)).(granule_data)))));
                  when ret_6 == ((s2tte_is_valid_ns_spec' v_42 v_2));
                  if ret_6
                  then (
                    when ret_7 == ((s2tte_create_ripas_spec' 1));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                    if (v_2 =? (3))
                    then (
                      match (
                        (stage2_tlbi_ipa_loop210
                          (z_to_nat 0)
                          false
                          v_1
                          4096
                          ((lens 1514 st_16).[share].[granule_data] :<
                            (((st_16.(share)).(granule_data)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7)))))
                      ) with
                      | (Some (__break__, v__13, v__912, st_4)) =>
                        when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          ((lens 1517 st_4).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_4.(log)))))
                        ))
                      | None => None
                      end)
                    else (
                      when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        0  ,
                        (((lens 1518 st_16).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))) ::
                            ((st_16.(log))))).[share].[granule_data] :<
                          (((st_16.(share)).(granule_data)) #
                            (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                            ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                              (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                ret_7))))
                      ))))
                  else (
                    when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      9  ,
                      ((lens 1519 st_16).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_16.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 1520 st_11).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_11.(log)))))
                  ))))
              else (
                when cid == (
                    ((((((sh_0.(globals)).(g_granules)) #
                      (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                      ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                when st_11 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      v_2
                      ((lens 1521 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                          (((EVT
                            CPU_ID
                            (REL
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID)))) ::
                            (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))))));
                rely ((((st_11.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if (((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_42, st_16 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_11));
                  rely ((((st_16.(share)).(granule_data)) = (((st_11.(share)).(granule_data)))));
                  when ret_6 == ((s2tte_is_valid_ns_spec' v_42 v_2));
                  if ret_6
                  then (
                    when ret_7 == ((s2tte_create_ripas_spec' 1));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                    if (v_2 =? (3))
                    then (
                      match (
                        (stage2_tlbi_ipa_loop210
                          (z_to_nat 0)
                          false
                          v_1
                          4096
                          ((lens 1522 st_16).[share].[granule_data] :<
                            (((st_16.(share)).(granule_data)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7)))))
                      ) with
                      | (Some (__break__, v__13, v__912, st_4)) =>
                        when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          ((lens 1525 st_4).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_4.(log)))))
                        ))
                      | None => None
                      end)
                    else (
                      when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        0  ,
                        (((lens 1526 st_16).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))) ::
                            ((st_16.(log))))).[share].[granule_data] :<
                          (((st_16.(share)).(granule_data)) #
                            (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                            ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                              (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                ret_7))))
                      ))))
                  else (
                    when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      9  ,
                      ((lens 1527 st_16).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_16.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 1528 st_11).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_11.(log)))))
                  ))))
            | (Some cid) => None
            end)
          else (
            (Some (
              (((((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (2)) << (32)) + (ret_1))))  ,
              ((lens 1529 st).[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                    ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
            ))))
        else (
          (Some (
            4294967553  ,
            ((lens 1530 st).[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          )))
      | (Some cid) => None
      end)
    else (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
            (((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
            (0)));
        if ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == (
              (validate_rtt_map_cmds_spec'
                v_1
                v_2
                ret_0
                ((lens 1531 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
          if (ret_1 =? (0))
          then (
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
            when ret_2, st'_0 == (
                (realm_rtt_starting_level_spec'
                  ret_0
                  ((lens 1532 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 ((lens 1533 st).[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))));
            when sh_0 == (
                ((st.(repl))
                  ((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
            | None =>
              rely (
                (((((((sh.(globals)).(g_granules)) #
                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                  ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                  (0)));
              rely (
                ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                  ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              if (
                ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                when st_11 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      v_2
                      ((lens 1534 st).[log] :<
                        ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) (((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
                rely ((((st_11.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if (((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_42, st_16 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_11));
                  rely ((((st_16.(share)).(granule_data)) = (((st_11.(share)).(granule_data)))));
                  when ret_6 == ((s2tte_is_valid_ns_spec' v_42 v_2));
                  if ret_6
                  then (
                    when ret_7 == ((s2tte_create_ripas_spec' 1));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                    if (v_2 =? (3))
                    then (
                      match (
                        (stage2_tlbi_ipa_loop210
                          (z_to_nat 0)
                          false
                          v_1
                          4096
                          ((lens 1535 st_16).[share].[granule_data] :<
                            (((st_16.(share)).(granule_data)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7)))))
                      ) with
                      | (Some (__break__, v__13, v__912, st_4)) =>
                        when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          ((lens 1538 st_4).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_4.(log)))))
                        ))
                      | None => None
                      end)
                    else (
                      when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        0  ,
                        (((lens 1539 st_16).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))) ::
                            ((st_16.(log))))).[share].[granule_data] :<
                          (((st_16.(share)).(granule_data)) #
                            (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                            ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                              (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                ret_7))))
                      ))))
                  else (
                    when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      9  ,
                      ((lens 1540 st_16).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_16.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 1541 st_11).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_11.(log)))))
                  ))))
              else (
                when cid == (
                    ((((((sh_0.(globals)).(g_granules)) #
                      (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                      ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                        None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                when st_11 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "stack_s_rtt_walk" 0)
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                      ret_2
                      ret_3
                      v_1
                      v_2
                      ((lens 1542 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((v_0 + ((- MEM0_PHYS))) >> (12))
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                          (((EVT
                            CPU_ID
                            (REL
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID)))) ::
                            (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))))));
                rely ((((st_11.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                if (((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                then (
                  rely (
                    ((((("granules" = ("granules")) /\ ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                      ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                      ((6 >= (0)))) /\
                      ((6 <= (24)))));
                  when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                  when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                  when v_42, st_16 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_11));
                  rely ((((st_16.(share)).(granule_data)) = (((st_11.(share)).(granule_data)))));
                  when ret_6 == ((s2tte_is_valid_ns_spec' v_42 v_2));
                  if ret_6
                  then (
                    when ret_7 == ((s2tte_create_ripas_spec' 1));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                    if (v_2 =? (3))
                    then (
                      match (
                        (stage2_tlbi_ipa_loop210
                          (z_to_nat 0)
                          false
                          v_1
                          4096
                          ((lens 1543 st_16).[share].[granule_data] :<
                            (((st_16.(share)).(granule_data)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7)))))
                      ) with
                      | (Some (__break__, v__13, v__912, st_4)) =>
                        when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          ((lens 1546 st_4).[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                              ((st_4.(log)))))
                        ))
                      | None => None
                      end)
                    else (
                      when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        0  ,
                        (((lens 1547 st_16).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))) ::
                            ((st_16.(log))))).[share].[granule_data] :<
                          (((st_16.(share)).(granule_data)) #
                            (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                            ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                              (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                ret_7))))
                      ))))
                  else (
                    when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      9  ,
                      ((lens 1548 st_16).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_16.(log)))))
                    ))))
                else (
                  when cid_0 == (((((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    ((((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                      ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                    ((lens 1549 st_11).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                          ((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_11.(log)))))
                  ))))
            | (Some cid) => None
            end)
          else (
            (Some (
              (((((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (2)) << (32)) + (ret_1))))  ,
              ((lens 1550 st).[log] :<
                ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
            ))))
        else (
          (Some (
            4294967553  ,
            ((lens 1551 st).[log] :<
              ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
          )))
      | (Some cid) => None
      end).



 Definition smc_rtt_create_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_1 & (1)) =? (0))
    then (
      when v_22, st_1 == ((find_lock_two_granules_spec v_0 1 (mkPtr "stack_type_4__1" 0) v_1 2 (mkPtr "stack_type_4" 0) st));
      if (v_22 =? (3))
      then (Some (3, st_1))
      else (
        if (v_22 =? (0))
        then (
          rely (((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
          rely ((((((st_1.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
          rely ((((((st_1.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
          rely ((((((st_1.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
          rely (
            ((((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_type_4)) mod (16)) = (0)))) /\ (((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
              ((2 >= (0)))) /\
              ((2 <= (24)))));
          when ret == ((granule_addr_spec' (mkPtr "granules" (((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == ((validate_rtt_structure_cmds_spec' v_2 v_3 ret_0 st_1));
          if (ret_1 =? (0))
          then (
            if (((((ret_0.(poffset)) + (32)) mod (4096)) - (16)) =? (16))
            then (
              rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
              rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
              when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 st_1));
              when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 st_1));
              when sh == (((st_1.(repl)) ((st_1.(oracle)) (st_1.(log))) (st_1.(share))));
              match ((((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
              | None =>
                rely (
                  (((((((st_1.(share)).(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    (((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                    (0)));
                rely (
                  ((("granules" = ("granules")) /\ (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                    (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
                if (
                  ((((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    (5)) =?
                    (0)))
                then (
                  when cid == (
                      ((((((sh.(globals)).(g_granules)) #
                        ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                        ((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                          (Some CPU_ID))) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  when st_13 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk__1" 0)
                        (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                        ret_2
                        ret_3
                        v_2
                        (v_3 + ((- 1)))
                        ((lens 237 st_1).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                              ((((sh.(globals)).(g_granules)) #
                                ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                ((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                            (((EVT CPU_ID (ACQ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st_1.(oracle)) (st_1.(log))) ++ ((st_1.(log)))))))))));
                  rely ((((st_13.(share)).(granule_data)) = ((sh.(granule_data)))));
                  rely ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                  rely ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                  if (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)))));
                    when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                    when v_60, st_18 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk))))))) st_13));
                    rely ((((st_18.(share)).(granule_data)) = (((st_13.(share)).(granule_data)))));
                    rely (((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                    rely ((((((st_18.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                    rely ((((((st_18.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                    rely ((((((st_18.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                    rely (
                      ((((("granules" = ("granules")) /\ (((((st_18.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                        ((1 >= (0)))) /\
                        ((1 <= (24)))));
                    when ret_6 == ((granule_addr_spec' (mkPtr "granules" (((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)))));
                    when ret_7 == ((buffer_map_spec' 1 ret_6 false));
                    rely ((((ret_7.(pbase)) = ("granule_data")) /\ (((ret_7.(poffset)) >= (0)))));
                    if ((v_60 & (63)) =? (0))
                    then (
                      when ret_8 == ((s2tte_get_ripas_spec' v_60));
                      when ret_9 == ((s2tte_create_ripas_spec' ret_8));
                      match (
                        match ((s2tt_init_unassigned_loop759_0 (z_to_nat 0) false ret_7 ret_9 0 st_18)) with
                        | (Some (__break__, v_7, v_6, v_index_0, st_2)) => (Some (true, 0, st_2))
                        | None => None
                        end
                      ) with
                      | (Some (__return__, v_bc_resume_val, st_2)) =>
                        if __return__
                        then (
                          rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                          if (((st_2.(stack)).(stack_type_4__1)) >? (0))
                          then (
                            if ((((st_2.(stack)).(stack_type_4__1)) - (MAX_GLOBAL)) <? (0))
                            then None
                            else (
                              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                              if ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >=? (0))
                              then (
                                rely (
                                  ((((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                                    ((5 >= (0)))) /\
                                    ((5 <= (6)))));
                                rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                                when cid_0 == (
                                    ((((((((st_2.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                        5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                when cid_1 == (
                                    (((((((((st_2.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                        5)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((((st_2.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                        None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                (Some (
                                  0  ,
                                  (((lens 238 st_2).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        (((((((st_2.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                          ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_2.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                            5)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((((st_2.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                            ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_2.(share)).(globals)).(g_granules)) #
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                  (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                              5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          ((((((st_2.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                            ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_2.(share)).(globals)).(g_granules)) #
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                  (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                              5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_2.(log))))))).[share].[granule_data] :<
                                    (((st_2.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          (v_0 |' (3))))))
                                )))
                              else None))
                          else None)
                        else (
                          match ((s2tt_init_unassigned_loop759 (z_to_nat 0) false ret_7 ret_9 v_bc_resume_val st_2)) with
                          | (Some (__break__, v_7, v_6, v_indvars_iv_0, st_3)) =>
                            rely (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                            if (((st_3.(stack)).(stack_type_4__1)) >? (0))
                            then (
                              if ((((st_3.(stack)).(stack_type_4__1)) - (MAX_GLOBAL)) <? (0))
                              then None
                              else (
                                rely ((((((st_3.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                                rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                                rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                                rely (
                                  ((((("granules" = ("granules")) /\ (((((st_3.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                                    ((5 >= (0)))) /\
                                    ((5 <= (6)))));
                                rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                                when cid_0 == (
                                    ((((((((st_3.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                      ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_3.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                        5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                when cid_1 == (
                                    (((((((((st_3.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                      ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_3.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                        5)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((((st_3.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                        ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_3.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                        None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                (Some (
                                  0  ,
                                  (((lens 239 st_3).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        (((((((st_3.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                          ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_3.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                            5)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((((st_3.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                            ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_3.(share)).(globals)).(g_granules)) #
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                  (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                              5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          ((((((st_3.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                            ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_3.(share)).(globals)).(g_granules)) #
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                  (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                              5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_3.(log))))))).[share].[granule_data] :<
                                    (((st_3.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_3.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_3.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          (v_0 |' (3))))))
                                ))))
                            else None
                          | None => None
                          end)
                      | None => None
                      end)
                    else (
                      if ((v_60 & (63)) =? (8))
                      then (
                        rely (((((((st_18.(share)).(granule_data)) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
                        match (
                          match ((s2tt_init_destroyed_loop776_0 (z_to_nat 0) false ret_7 0 st_18)) with
                          | (Some (__break__, v_5, v_index_0, st_2)) => (Some (true, 0, st_2))
                          | None => None
                          end
                        ) with
                        | (Some (__return__, v_bc_resume_val, st_2)) =>
                          if __return__
                          then (
                            rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                            if (((st_2.(stack)).(stack_type_4__1)) >? (0))
                            then (
                              if ((((st_2.(stack)).(stack_type_4__1)) - (MAX_GLOBAL)) <? (0))
                              then None
                              else (
                                rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                                rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                                rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                                if ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >=? (0))
                                then (
                                  rely (
                                    ((((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                                      ((5 >= (0)))) /\
                                      ((5 <= (6)))));
                                  rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                                  when cid_0 == (
                                      ((((((((st_2.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                  when cid_1 == (
                                      (((((((((st_2.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                          5)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((((st_2.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                          ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_2.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                            5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                          None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                  (Some (
                                    0  ,
                                    (((lens 240 st_2).[log] :<
                                      ((EVT
                                        CPU_ID
                                        (REL
                                          ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                          (((((((st_2.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                            ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_2.(share)).(globals)).(g_granules)) #
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                  (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                              5)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((((st_2.(share)).(globals)).(g_granules)) #
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                  (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                              ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                              ((((((st_2.(share)).(globals)).(g_granules)) #
                                                (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                  ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                    (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                                5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                              None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                        (((EVT
                                          CPU_ID
                                          (REL
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                            ((((((st_2.(share)).(globals)).(g_granules)) #
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                  (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                              ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                              ((((((st_2.(share)).(globals)).(g_granules)) #
                                                (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                  ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                    (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                                5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                          ((st_2.(log))))))).[share].[granule_data] :<
                                      (((st_2.(share)).(granule_data)) #
                                        (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                        ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                          (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                            (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                            (v_0 |' (3))))))
                                  )))
                                else None))
                            else None)
                          else (
                            match ((s2tt_init_destroyed_loop776 (z_to_nat 0) false ret_7 v_bc_resume_val st_2)) with
                            | (Some (__break__, v_5, v_indvars_iv_0, st_3)) =>
                              rely (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                              if (((st_3.(stack)).(stack_type_4__1)) >? (0))
                              then (
                                if ((((st_3.(stack)).(stack_type_4__1)) - (MAX_GLOBAL)) <? (0))
                                then None
                                else (
                                  rely ((((((st_3.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                                  rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                                  rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                                  if ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >=? (0))
                                  then (
                                    rely (
                                      ((((("granules" = ("granules")) /\ (((((st_3.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                                        ((5 >= (0)))) /\
                                        ((5 <= (6)))));
                                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                                    when cid_0 == (
                                        ((((((((st_3.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                          ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_3.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                            5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                    when cid_1 == (
                                        (((((((((st_3.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                          ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_3.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                            5)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((((st_3.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                            ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_3.(share)).(globals)).(g_granules)) #
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                  (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                              5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                    (Some (
                                      0  ,
                                      (((lens 241 st_3).[log] :<
                                        ((EVT
                                          CPU_ID
                                          (REL
                                            ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                            (((((((st_3.(share)).(globals)).(g_granules)) #
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                  (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                              ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                              ((((((st_3.(share)).(globals)).(g_granules)) #
                                                (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                  ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                    (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                                5)) #
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((((st_3.(share)).(globals)).(g_granules)) #
                                                (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                  ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                    (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                                ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                                ((((((st_3.(share)).(globals)).(g_granules)) #
                                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                  (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                    ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                      (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                                  5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                          (((EVT
                                            CPU_ID
                                            (REL
                                              (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                              ((((((st_3.(share)).(globals)).(g_granules)) #
                                                (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                  ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                    (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                                ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                                ((((((st_3.(share)).(globals)).(g_granules)) #
                                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                  (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                                    ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                      (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                                  5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                            ((st_3.(log))))))).[share].[granule_data] :<
                                        (((st_3.(share)).(granule_data)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                          ((((st_3.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                            (((((st_3.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                              (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                              (v_0 |' (3))))))
                                    )))
                                  else None))
                              else None
                            | None => None
                            end)
                        | None => None
                        end)
                      else (
                        if ((v_60 & (63)) =? (4))
                        then (
                          when ret_8 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
                          rely (((((((st_18.(share)).(granule_data)) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
                          match ((s2tt_init_assigned_loop801 (z_to_nat 512) false ret_7 v_3 (1 << ((39 + (((- 9) * (v_3)))))) ret_8 0 st_18)) with
                          | (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
                            rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                            rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (
                                (((((((st_2.(share)).(globals)).(g_granules)) #
                                  ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                    5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            when cid_1 == (
                                ((((((((st_2.(share)).(globals)).(g_granules)) #
                                  ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                    5)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_2.(share)).(globals)).(g_granules)) #
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                      5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                    None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              (((lens 242 st_2).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                    ((((((st_2.(share)).(globals)).(g_granules)) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                        5)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                        None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                      (((((st_2.(share)).(globals)).(g_granules)) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                    ((st_2.(log))))))).[share].[granule_data] :<
                                (((st_2.(share)).(granule_data)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                  ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                    (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                      (v_0 |' (3))))))
                            ))
                          | None => None
                          end)
                        else (
                          when ret_8 == ((s2tte_is_valid_spec' v_60 (v_3 + ((- 1)))));
                          if ret_8
                          then (
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when ret_9 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
                            rely (
                              (((((((st_18.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    0))) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) -
                                (GRANULE_STATE_DATA)) =
                                (0)));
                            match (
                              (s2tt_init_valid_loop820
                                (z_to_nat 512)
                                false
                                ret_7
                                v_3
                                (1 << ((39 + (((- 9) * (v_3))))))
                                ret_9
                                0
                                (st_18.[share].[granule_data] :<
                                  (((st_18.(share)).(granule_data)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                    ((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                      (((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                        (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                        0)))))
                            ) with
                            | (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
                              rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                              rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
                              when cid_0 == (
                                  (((((((st_2.(share)).(globals)).(g_granules)) #
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                      5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                              when cid_1 == (
                                  ((((((((st_2.(share)).(globals)).(g_granules)) #
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                      5)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                        5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                      None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                              (Some (
                                0  ,
                                (((lens 243 st_2).[log] :<
                                  ((EVT
                                    CPU_ID
                                    (REL
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                          5)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) #
                                          ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                            5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                          None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                        (((((st_2.(share)).(globals)).(g_granules)) #
                                          ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                            5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                      ((st_2.(log))))))).[share].[granule_data] :<
                                  (((st_2.(share)).(granule_data)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                    ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                      (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                        (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                        (v_0 |' (3))))))
                              ))
                            | None => None
                            end)
                          else (
                            when ret_9 == ((s2tte_is_valid_ns_spec' v_60 (v_3 + ((- 1)))));
                            if ret_9
                            then (
                              rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                              when ret_10 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
                              rely (
                                (((((((st_18.(share)).(granule_data)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                  ((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                    (((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                      0))) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) -
                                  (GRANULE_STATE_DATA)) =
                                  (0)));
                              match (
                                (s2tt_init_valid_ns_loop839
                                  (z_to_nat 512)
                                  false
                                  ret_7
                                  v_3
                                  (1 << ((39 + (((- 9) * (v_3))))))
                                  ret_10
                                  0
                                  (st_18.[share].[granule_data] :<
                                    (((st_18.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          0)))))
                              ) with
                              | (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
                                rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                                rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                                rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                                rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                                rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
                                when cid_0 == (
                                    (((((((st_2.(share)).(globals)).(g_granules)) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                        5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                when cid_1 == (
                                    ((((((((st_2.(share)).(globals)).(g_granules)) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                        5)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                        None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                (Some (
                                  0  ,
                                  (((lens 244 st_2).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        ((((((st_2.(share)).(globals)).(g_granules)) #
                                          ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                            5)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_2.(share)).(globals)).(g_granules)) #
                                            ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                              5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          (((((st_2.(share)).(globals)).(g_granules)) #
                                            ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                              5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_2.(log))))))).[share].[granule_data] :<
                                    (((st_2.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          (v_0 |' (3))))))
                                ))
                              | None => None
                              end)
                            else (
                              if (((v_3 + ((- 1))) <? (3)) && (((v_60 & (3)) =? (3))))
                              then (
                                when cid_0 == (((((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                when cid_1 == (
                                    (((((((st_18.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                (Some (
                                  9  ,
                                  ((lens 245 st_18).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        (((((st_18.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          ((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_18.(log)))))))
                                )))
                              else (
                                rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                                when cid_0 == (
                                    (((((((st_18.(share)).(globals)).(g_granules)) #
                                      ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                when cid_1 == (
                                    ((((((((st_18.(share)).(globals)).(g_granules)) #
                                      ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_18.(share)).(globals)).(g_granules)) #
                                        ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                        None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                (Some (
                                  0  ,
                                  (((lens 246 st_18).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        ((((((st_18.(share)).(globals)).(g_granules)) #
                                          ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_18.(share)).(globals)).(g_granules)) #
                                            ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          (((((st_18.(share)).(globals)).(g_granules)) #
                                            ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_18.(log))))))).[share].[granule_data] :<
                                    (((st_18.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          (v_0 |' (3))))))
                                )))))))))
                  else (
                    when cid_0 == (((((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    rely (((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                    if ((((st_13.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                    then None
                    else (
                      if ((((st_13.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                      then None
                      else (
                        if ((((st_13.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                        then None
                        else (
                          when cid_1 == (
                              (((((((st_13.(share)).(globals)).(g_granules)) #
                                (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            ((((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                              ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) << (32)) + (8))))  ,
                            ((lens 247 st_13).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  ((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                  (((((st_13.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  ((st_13.(log)))))))
                          )))))))
                else (
                  when cid == (
                      ((((((sh.(globals)).(g_granules)) #
                        ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                        ((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                          None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  when st_13 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk__1" 0)
                        (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                        ret_2
                        ret_3
                        v_2
                        (v_3 + ((- 1)))
                        ((lens 248 st_1).[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                              ((((sh.(globals)).(g_granules)) #
                                ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                ((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                            (((EVT
                              CPU_ID
                              (REL
                                ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                                ((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID)))) ::
                              (((EVT CPU_ID (ACQ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                                ((((st_1.(oracle)) (st_1.(log))) ++ ((st_1.(log)))))))))))));
                  rely ((((st_13.(share)).(granule_data)) = ((sh.(granule_data)))));
                  rely ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                  rely ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                  if (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)))));
                    when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                    when v_60, st_18 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk))))))) st_13));
                    rely ((((st_18.(share)).(granule_data)) = (((st_13.(share)).(granule_data)))));
                    rely (((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                    rely ((((((st_18.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                    rely ((((((st_18.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                    rely ((((((st_18.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                    rely (
                      ((((("granules" = ("granules")) /\ (((((st_18.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                        ((1 >= (0)))) /\
                        ((1 <= (24)))));
                    when ret_6 == ((granule_addr_spec' (mkPtr "granules" (((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)))));
                    when ret_7 == ((buffer_map_spec' 1 ret_6 false));
                    rely ((((ret_7.(pbase)) = ("granule_data")) /\ (((ret_7.(poffset)) >= (0)))));
                    if ((v_60 & (63)) =? (0))
                    then (
                      when ret_8 == ((s2tte_get_ripas_spec' v_60));
                      when ret_9 == ((s2tte_create_ripas_spec' ret_8));
                      match (
                        match ((s2tt_init_unassigned_loop759_0 (z_to_nat 0) false ret_7 ret_9 0 st_18)) with
                        | (Some (__break__, v_7, v_6, v_index_0, st_2)) => (Some (true, 0, st_2))
                        | None => None
                        end
                      ) with
                      | (Some (__return__, v_bc_resume_val, st_2)) =>
                        if __return__
                        then (
                          rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                          rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                          rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                          rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                          rely (
                            ((((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                              ((5 >= (0)))) /\
                              ((5 <= (6)))));
                          rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                          when cid_0 == (
                              ((((((((st_2.(share)).(globals)).(g_granules)) #
                                (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                ((((((st_2.(share)).(globals)).(g_granules)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                  5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          when cid_1 == (
                              (((((((((st_2.(share)).(globals)).(g_granules)) #
                                (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                ((((((st_2.(share)).(globals)).(g_granules)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                  5)) #
                                (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((((st_2.(share)).(globals)).(g_granules)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                  ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_2.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                    5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            (((lens 249 st_2).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                  (((((((st_2.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                      5)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((((st_2.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                        5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                      None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((((st_2.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                        5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  ((st_2.(log))))))).[share].[granule_data] :<
                              (((st_2.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    (v_0 |' (3))))))
                          )))
                        else (
                          match ((s2tt_init_unassigned_loop759 (z_to_nat 0) false ret_7 ret_9 v_bc_resume_val st_2)) with
                          | (Some (__break__, v_7, v_6, v_indvars_iv_0, st_3)) =>
                            rely (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                            rely ((((((st_3.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                            rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                            rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                            rely (
                              ((((("granules" = ("granules")) /\ (((((st_3.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                                ((5 >= (0)))) /\
                                ((5 <= (6)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (
                                ((((((((st_3.(share)).(globals)).(g_granules)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                  ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_3.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                    5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            when cid_1 == (
                                (((((((((st_3.(share)).(globals)).(g_granules)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                  ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_3.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                    5)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((((st_3.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                    ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_3.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                      5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                    None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              (((lens 250 st_3).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                    (((((((st_3.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                      ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_3.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                        5)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((((st_3.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                        ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_3.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                        None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                      ((((((st_3.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                        ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_3.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                    ((st_3.(log))))))).[share].[granule_data] :<
                                (((st_3.(share)).(granule_data)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                  ((((st_3.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                    (((((st_3.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                      (v_0 |' (3))))))
                            ))
                          | None => None
                          end)
                      | None => None
                      end)
                    else (
                      if ((v_60 & (63)) =? (8))
                      then (
                        rely (((((((st_18.(share)).(granule_data)) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
                        match (
                          match ((s2tt_init_destroyed_loop776_0 (z_to_nat 0) false ret_7 0 st_18)) with
                          | (Some (__break__, v_5, v_index_0, st_2)) => (Some (true, 0, st_2))
                          | None => None
                          end
                        ) with
                        | (Some (__return__, v_bc_resume_val, st_2)) =>
                          if __return__
                          then (
                            rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                            rely (
                              ((((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                                ((5 >= (0)))) /\
                                ((5 <= (6)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (
                                ((((((((st_2.(share)).(globals)).(g_granules)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                  ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_2.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                    5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            when cid_1 == (
                                (((((((((st_2.(share)).(globals)).(g_granules)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                  ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_2.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                    5)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  (((((((st_2.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                      5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                    None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              (((lens 251 st_2).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                    (((((((st_2.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                        5)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((((st_2.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                        None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                    ((st_2.(log))))))).[share].[granule_data] :<
                                (((st_2.(share)).(granule_data)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                  ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                    (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                      (v_0 |' (3))))))
                            )))
                          else (
                            match ((s2tt_init_destroyed_loop776 (z_to_nat 0) false ret_7 v_bc_resume_val st_2)) with
                            | (Some (__break__, v_5, v_indvars_iv_0, st_3)) =>
                              rely (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                              rely ((((((st_3.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                              rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                              rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                              rely (
                                ((((("granules" = ("granules")) /\ (((((st_3.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
                                  ((5 >= (0)))) /\
                                  ((5 <= (6)))));
                              rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                              when cid_0 == (
                                  ((((((((st_3.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                    ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_3.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                      5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                              when cid_1 == (
                                  (((((((((st_3.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                    ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_3.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                      5)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((((st_3.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                      ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_3.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                        5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                      None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                              (Some (
                                0  ,
                                (((lens 252 st_3).[log] :<
                                  ((EVT
                                    CPU_ID
                                    (REL
                                      ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                      (((((((st_3.(share)).(globals)).(g_granules)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                        ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_3.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                          5)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((((st_3.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                          ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_3.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                            5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                          None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                        ((((((st_3.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
                                          ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_3.(share)).(globals)).(g_granules)) #
                                            (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
                                            5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                      ((st_3.(log))))))).[share].[granule_data] :<
                                  (((st_3.(share)).(granule_data)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                    ((((st_3.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                      (((((st_3.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                        (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                        (v_0 |' (3))))))
                              ))
                            | None => None
                            end)
                        | None => None
                        end)
                      else (
                        if ((v_60 & (63)) =? (4))
                        then (
                          when ret_8 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
                          rely (((((((st_18.(share)).(granule_data)) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
                          match ((s2tt_init_assigned_loop801 (z_to_nat 512) false ret_7 v_3 (1 << ((39 + (((- 9) * (v_3)))))) ret_8 0 st_18)) with
                          | (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
                            rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                            rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                            rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid_0 == (
                                (((((((st_2.(share)).(globals)).(g_granules)) #
                                  ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                    5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            when cid_1 == (
                                ((((((((st_2.(share)).(globals)).(g_granules)) #
                                  ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                    5)) #
                                  (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                  ((((((st_2.(share)).(globals)).(g_granules)) #
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                      5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                    None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            (Some (
                              0  ,
                              (((lens 253 st_2).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                    ((((((st_2.(share)).(globals)).(g_granules)) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                        5)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                        None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                  (((EVT
                                    CPU_ID
                                    (REL
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                      (((((st_2.(share)).(globals)).(g_granules)) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                    ((st_2.(log))))))).[share].[granule_data] :<
                                (((st_2.(share)).(granule_data)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                  ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                    (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                      (v_0 |' (3))))))
                            ))
                          | None => None
                          end)
                        else (
                          when ret_8 == ((s2tte_is_valid_spec' v_60 (v_3 + ((- 1)))));
                          if ret_8
                          then (
                            rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when ret_9 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
                            rely (
                              (((((((st_18.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    0))) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) -
                                (GRANULE_STATE_DATA)) =
                                (0)));
                            match (
                              (s2tt_init_valid_loop820
                                (z_to_nat 512)
                                false
                                ret_7
                                v_3
                                (1 << ((39 + (((- 9) * (v_3))))))
                                ret_9
                                0
                                (st_18.[share].[granule_data] :<
                                  (((st_18.(share)).(granule_data)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                    ((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                      (((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                        (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                        0)))))
                            ) with
                            | (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
                              rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                              rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                              rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
                              when cid_0 == (
                                  (((((((st_2.(share)).(globals)).(g_granules)) #
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                      5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                              when cid_1 == (
                                  ((((((((st_2.(share)).(globals)).(g_granules)) #
                                    ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                      5)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                        5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                      None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                              (Some (
                                0  ,
                                (((lens 254 st_2).[log] :<
                                  ((EVT
                                    CPU_ID
                                    (REL
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                          5)) #
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) #
                                          ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                            5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                          None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                    (((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                        (((((st_2.(share)).(globals)).(g_granules)) #
                                          ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                            5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                      ((st_2.(log))))))).[share].[granule_data] :<
                                  (((st_2.(share)).(granule_data)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                    ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                      (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                        (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                        (v_0 |' (3))))))
                              ))
                            | None => None
                            end)
                          else (
                            when ret_9 == ((s2tte_is_valid_ns_spec' v_60 (v_3 + ((- 1)))));
                            if ret_9
                            then (
                              rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                              when ret_10 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
                              rely (
                                (((((((st_18.(share)).(granule_data)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                  ((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                    (((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                      0))) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) -
                                  (GRANULE_STATE_DATA)) =
                                  (0)));
                              match (
                                (s2tt_init_valid_ns_loop839
                                  (z_to_nat 512)
                                  false
                                  ret_7
                                  v_3
                                  (1 << ((39 + (((- 9) * (v_3))))))
                                  ret_10
                                  0
                                  (st_18.[share].[granule_data] :<
                                    (((st_18.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          0)))))
                              ) with
                              | (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
                                rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                                rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
                                rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
                                rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
                                rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
                                when cid_0 == (
                                    (((((((st_2.(share)).(globals)).(g_granules)) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                        5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                when cid_1 == (
                                    ((((((((st_2.(share)).(globals)).(g_granules)) #
                                      ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                        5)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_2.(share)).(globals)).(g_granules)) #
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                            (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                          5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                        None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                (Some (
                                  0  ,
                                  (((lens 255 st_2).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        ((((((st_2.(share)).(globals)).(g_granules)) #
                                          ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                              (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                            5)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_2.(share)).(globals)).(g_granules)) #
                                            ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                              5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          (((((st_2.(share)).(globals)).(g_granules)) #
                                            ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                              ((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                                (((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
                                              5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_2.(log))))))).[share].[granule_data] :<
                                    (((st_2.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_2.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          (v_0 |' (3))))))
                                ))
                              | None => None
                              end)
                            else (
                              if (((v_3 + ((- 1))) <? (3)) && (((v_60 & (3)) =? (3))))
                              then (
                                when cid_0 == (((((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                when cid_1 == (
                                    (((((((st_18.(share)).(globals)).(g_granules)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                (Some (
                                  9  ,
                                  ((lens 256 st_18).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        (((((st_18.(share)).(globals)).(g_granules)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          ((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_18.(log)))))))
                                )))
                              else (
                                rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
                                when cid_0 == (
                                    (((((((st_18.(share)).(globals)).(g_granules)) #
                                      ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                when cid_1 == (
                                    ((((((((st_18.(share)).(globals)).(g_granules)) #
                                      ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) #
                                      (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      ((((((st_18.(share)).(globals)).(g_granules)) #
                                        ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                        None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                (Some (
                                  0  ,
                                  (((lens 257 st_18).[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                        ((((((st_18.(share)).(globals)).(g_granules)) #
                                          ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                          (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) #
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                          ((((((st_18.(share)).(globals)).(g_granules)) #
                                            ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                            None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REL
                                          (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                          (((((st_18.(share)).(globals)).(g_granules)) #
                                            ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                        ((st_18.(log))))))).[share].[granule_data] :<
                                    (((st_18.(share)).(granule_data)) #
                                      (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                      ((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                        (((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                          (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                          (v_0 |' (3))))))
                                )))))))))
                  else (
                    when cid_0 == (((((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    rely (((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                    if ((((st_13.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                    then None
                    else (
                      if ((((st_13.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                      then None
                      else (
                        if ((((st_13.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                        then None
                        else (
                          when cid_1 == (
                              (((((((st_13.(share)).(globals)).(g_granules)) #
                                (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            ((((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                              ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) << (32)) + (8))))  ,
                            ((lens 258 st_13).[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  ((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                  (((((st_13.(share)).(globals)).(g_granules)) #
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                    (((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                (((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                    ((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                  ((st_13.(log)))))))
                          )))))))
              | (Some cid) => None
              end)
            else None)
          else (
            when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
            rely (((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
            if ((((st_1.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
            then None
            else (
              if ((((st_1.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
              then None
              else (
                if ((((st_1.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                then None
                else (
                  when cid_0 == (
                      (((((((st_1.(share)).(globals)).(g_granules)) #
                        ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
                        (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    (((((((ret_1 >> (32)) + (3)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (3)) << (32)) + (ret_1))))  ,
                    ((lens 259 st_1).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                          (((((st_1.(share)).(globals)).(g_granules)) #
                            ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                        (((EVT
                          CPU_ID
                          (REL
                            ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                            ((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_1.(log)))))))
                  )))))))
        else (Some ((((((((v_22 >> (32)) + (1)) << (32)) + (1)) >> (24)) & (4294967040)) |' (((((v_22 >> (32)) + (1)) << (32)) + (1)))), st_1))))
    else (
      rely (
        ((((((v_1 & ((- 2))) - (MEM0_PHYS)) >= (0)) /\ ((((v_1 & ((- 2))) - (4294967296)) < (0)))) \/
          (((((v_1 & ((- 2))) - (MEM1_PHYS)) >= (0)) /\ ((((v_1 & ((- 2))) - (556198264832)) < (0)))))) /\
          ((((v_1 & ((- 2))) & (4095)) = (0)))));
      if (((v_1 & ((- 2))) - (MEM1_PHYS)) >=? (0))
      then (
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        match ((((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
        | None =>
          rely (
            (((((((st.(share)).(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
              (((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
              (0)));
          if ((((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (3)) =? (0))
          then (
            when ret == ((granule_addr_spec' (mkPtr "granules" ((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)))));
            when ret_0 == ((buffer_map_spec' 3 ret false));
            rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
            rely (((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))) /\ (((ret_0.(poffset)) >= (0)))));
            rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
            rely (
              ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)) /\
                ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (MEM0_VIRT)) < (0)))));
            when sh_0 == (
                ((st.(repl))
                  ((st.(oracle)) ((EVT CPU_ID (ACQ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      ((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
            | None =>
              rely (
                (((((((sh.(globals)).(g_granules)) #
                  (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                  ((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                  (0)));
              rely (
                ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) mod (16)) = (0)))) /\
                  ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)))));
              if (
                ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when v_8, st_2 == (
                    (rtt_create_internal_spec
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                      v_0
                      v_2
                      v_3
                      1
                      ((lens 260 st).[log] :<
                        ((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                          ((((st.(oracle)) ((EVT CPU_ID (ACQ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                            (((EVT CPU_ID (ACQ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))));
                when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                (Some (
                  ((((v_8 << (32)) >> (32)) << (32)) >> (32))  ,
                  ((lens 261 st_2).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                        ((((st_2.(share)).(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                      ((st_2.(log)))))
                )))
              else (
                when v_8, st_2 == (
                    (rtt_create_internal_spec
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                      v_0
                      v_2
                      v_3
                      1
                      ((lens 262 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))
                            ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID)))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
                when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                (Some (
                  ((((v_8 << (32)) >> (32)) << (32)) >> (32))  ,
                  ((lens 263 st_2).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                        ((((st_2.(share)).(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                      ((st_2.(log)))))
                )))
            | (Some cid) => None
            end)
          else (
            (Some (
              8589935105  ,
              ((lens 264 st).[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                    ((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
            )))
        | (Some cid) => None
        end)
      else (
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        match ((((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
        | None =>
          rely (
            (((((((st.(share)).(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
              (((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
              (0)));
          if ((((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (3)) =? (0))
          then (
            when ret == ((granule_addr_spec' (mkPtr "granules" ((((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) * (16)))));
            when ret_0 == ((buffer_map_spec' 3 ret false));
            rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
            rely (((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))) /\ (((ret_0.(poffset)) >= (0)))));
            rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
            rely (
              ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)) /\
                ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (MEM0_VIRT)) < (0)))));
            when sh_0 == (
                ((st.(repl))
                  ((st.(oracle)) ((EVT CPU_ID (ACQ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ==
                      ((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
            match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
            | None =>
              rely (
                (((((((sh.(globals)).(g_granules)) #
                  (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ==
                  ((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                  (0)));
              rely (
                ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) mod (16)) = (0)))) /\
                  ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)))));
              if (
                ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                when v_8, st_2 == (
                    (rtt_create_internal_spec
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                      v_0
                      v_2
                      v_3
                      1
                      ((lens 265 st).[log] :<
                        ((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                          ((((st.(oracle)) ((EVT CPU_ID (ACQ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                            (((EVT CPU_ID (ACQ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))));
                when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                (Some (
                  ((((v_8 << (32)) >> (32)) << (32)) >> (32))  ,
                  ((lens 266 st_2).[log] :<
                    ((EVT CPU_ID (REL (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ((((st_2.(share)).(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))))) ::
                      ((st_2.(log)))))
                )))
              else (
                when v_8, st_2 == (
                    (rtt_create_internal_spec
                      (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
                      v_0
                      v_2
                      v_3
                      1
                      ((lens 267 st).[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))
                            ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                              (Some CPU_ID)))) ::
                          (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16)))) ::
                            ((((st.(oracle)) ((EVT CPU_ID (ACQ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                              (((EVT CPU_ID (ACQ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))))))));
                when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                (Some (
                  ((((v_8 << (32)) >> (32)) << (32)) >> (32))  ,
                  ((lens 268 st_2).[log] :<
                    ((EVT CPU_ID (REL (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ((((st_2.(share)).(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))))) ::
                      ((st_2.(log)))))
                )))
            | (Some cid) => None
            end)
          else (
            (Some (
              8589935105  ,
              ((lens 269 st).[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))
                    ((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))))
            )))
        | (Some cid) => None
        end)).


 Definition smc_data_dispose_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when v_8, st_1 == ((find_lock_two_granules_spec v_0 2 (mkPtr "stack_type_4" 0) v_1 3 (mkPtr "stack_type_4__1" 0) st));
    if (v_8 =? (3))
    then (Some (3, st_1))
    else (
      if (v_8 =? (0))
      then (
        rely (((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
        rely ((((((st_1.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
        rely ((((((st_1.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
        rely ((((((st_1.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
        rely (((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_1.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
        if ((((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)))));
          when ret_0 == ((buffer_map_spec' 3 ret false));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
          rely (((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
          rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)) >= (0)));
          rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (MEM0_VIRT)) < (0)));
          if ((((st_1.(stack)).(stack_type_4)) - (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)))) =? (0))
          then (
            if ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_dispose_info)).(e_s_anon_0_0)) & (1)) =? (0))
            then (
              when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
              when cid_0 == (
                  (((((((st_1.(share)).(globals)).(g_granules)) #
                    ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                    (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
              (Some (
                7  ,
                ((lens 25 st_1).[log] :<
                  ((EVT
                    CPU_ID
                    (REL
                      ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                      (((((st_1.(share)).(globals)).(g_granules)) #
                        ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                        (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                    (((EVT
                      CPU_ID
                      (REL
                        ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                        ((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                      ((st_1.(log)))))))
              )))
            else (
              when ret_1 == (
                  (region_is_contained_spec'
                    ((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_dispose_info)).(e_s_anon_0_1))
                    (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_dispose_info)).(e_s_anon_0_2)) +
                      (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_dispose_info)).(e_s_anon_0_1))))
                    v_2
                    ((1 << ((39 + (((- 9) * (v_3)))))) + (v_2))));
              if ret_1
              then (
                rely (
                  ((((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_type_4)) mod (16)) = (0)))) /\ (((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
                    ((2 >= (0)))) /\
                    ((2 <= (24)))));
                when ret_2 == ((granule_addr_spec' (mkPtr "granules" (((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)))));
                when ret_3 == ((buffer_map_spec' 2 ret_2 false));
                rely (((((ret_3.(pbase)) = ("granule_data")) /\ (((ret_3.(poffset)) >= (0)))) /\ ((((ret_3.(poffset)) mod (4096)) = (0)))));
                rely (((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                when ret_4, st' == ((validate_rtt_map_cmds_spec' v_2 v_3 ret_3 st_1));
                if (ret_4 =? (0))
                then (
                  if (((((ret_3.(poffset)) + (32)) mod (4096)) - (16)) =? (16))
                  then (
                    rely (((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
                    rely (((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
                    when ret_5, st'_0 == ((realm_rtt_starting_level_spec' ret_3 st_1));
                    when ret_6, st'_1 == ((realm_ipa_bits_spec' ret_3 st_1));
                    when sh == (((st_1.(repl)) ((st_1.(oracle)) (st_1.(log))) (st_1.(share))));
                    match ((((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
                    | None =>
                      rely (
                        (((((((st_1.(share)).(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                          (((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                          (0)));
                      rely (
                        ((("granules" = ("granules")) /\ (((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                          (((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
                      if (
                        ((((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                          (5)) =?
                          (0)))
                      then (
                        when st_20 == (
                            (rtt_walk_lock_unlock_spec
                              (mkPtr "stack_s_rtt_walk" 0)
                              (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                              ret_5
                              ret_6
                              v_2
                              v_3
                              ((lens 26 st_1).[log] :<
                                ((EVT CPU_ID (ACQ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                                  ((((st_1.(oracle)) (st_1.(log))) ++ ((st_1.(log)))))))));
                        rely ((((st_20.(share)).(granule_data)) = ((sh.(granule_data)))));
                        rely ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                        rely ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                        if (((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_3)) =? (0))
                        then (
                          rely (
                            ((((("granules" = ("granules")) /\ ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                              ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                              ((6 >= (0)))) /\
                              ((6 <= (24)))));
                          when ret_7 == ((granule_addr_spec' (mkPtr "granules" ((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                          when ret_8 == ((buffer_map_spec' 6 ret_7 false));
                          when v_73, st_25 == ((__tte_read_spec (mkPtr (ret_8.(pbase)) ((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_20));
                          rely ((((st_25.(share)).(granule_data)) = (((st_20.(share)).(granule_data)))));
                          if ((v_73 & (63)) =? (8))
                          then (
                            when ret_9 == ((s2tte_create_ripas_spec' 1));
                            rely ((((ret_8.(pbase)) = ("granule_data")) /\ ((((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid == (((((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            rely (((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                            if ((((st_25.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                            then None
                            else (
                              if ((((st_25.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                              then None
                              else (
                                if ((((st_25.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                                then None
                                else (
                                  when cid_0 == (
                                      (((((((st_25.(share)).(globals)).(g_granules)) #
                                        (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                  rely (((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                                  if ((((st_25.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
                                  then None
                                  else (
                                    if ((((st_25.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
                                    then None
                                    else (
                                      if ((((st_25.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
                                      then None
                                      else (
                                        when cid_1 == (
                                            ((((((((st_25.(share)).(globals)).(g_granules)) #
                                              (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                              ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                              ((((((st_25.(share)).(globals)).(g_granules)) #
                                                (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                        (Some (
                                          0  ,
                                          (((lens 27 st_25).[log] :<
                                            ((EVT
                                              CPU_ID
                                              (REL
                                                ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                                ((((((st_25.(share)).(globals)).(g_granules)) #
                                                  (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                  (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                                  ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                                  ((((((st_25.(share)).(globals)).(g_granules)) #
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                    (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                    None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                              (((EVT
                                                CPU_ID
                                                (REL
                                                  ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                                  (((((st_25.(share)).(globals)).(g_granules)) #
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                    (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                                (((EVT
                                                  CPU_ID
                                                  (REL
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                                    ((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                                  ((st_25.(log))))))))).[share].[granule_data] :<
                                            (((st_25.(share)).(granule_data)) #
                                              (((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                              ((((st_25.(share)).(granule_data)) @ (((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                                (((((st_25.(share)).(granule_data)) @ (((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                                  (((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                                  ret_9))))
                                        )))))))))
                          else (
                            when cid == (((((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            rely (((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                            if ((((st_25.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                            then None
                            else (
                              if ((((st_25.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                              then None
                              else (
                                if ((((st_25.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                                then None
                                else (
                                  when cid_0 == (
                                      (((((((st_25.(share)).(globals)).(g_granules)) #
                                        (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                  rely (((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                                  if ((((st_25.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
                                  then None
                                  else (
                                    if ((((st_25.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
                                    then None
                                    else (
                                      if ((((st_25.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
                                      then None
                                      else (
                                        when cid_1 == (
                                            ((((((((st_25.(share)).(globals)).(g_granules)) #
                                              (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                              ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                              ((((((st_25.(share)).(globals)).(g_granules)) #
                                                (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                        (Some (
                                          9  ,
                                          ((lens 28 st_25).[log] :<
                                            ((EVT
                                              CPU_ID
                                              (REL
                                                ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                                ((((((st_25.(share)).(globals)).(g_granules)) #
                                                  (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                  (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                                  ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                                  ((((((st_25.(share)).(globals)).(g_granules)) #
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                    (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                    None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                              (((EVT
                                                CPU_ID
                                                (REL
                                                  ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                                  (((((st_25.(share)).(globals)).(g_granules)) #
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                    (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                                (((EVT
                                                  CPU_ID
                                                  (REL
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                                    ((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                                  ((st_25.(log)))))))))
                                        ))))))))))
                        else (
                          when cid == (((((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          rely (((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                          if ((((st_20.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                          then None
                          else (
                            if ((((st_20.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                            then None
                            else (
                              if ((((st_20.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                              then None
                              else (
                                when cid_0 == (
                                    (((((((st_20.(share)).(globals)).(g_granules)) #
                                      (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                rely (((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                                if ((((st_20.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
                                then None
                                else (
                                  if ((((st_20.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
                                  then None
                                  else (
                                    if ((((st_20.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
                                    then None
                                    else (
                                      when cid_1 == (
                                          ((((((((st_20.(share)).(globals)).(g_granules)) #
                                            (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                            ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_20.(share)).(globals)).(g_granules)) #
                                              (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                              None)) @ ((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                      (Some (
                                        ((((((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                                          ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                                        ((lens 29 st_20).[log] :<
                                          ((EVT
                                            CPU_ID
                                            (REL
                                              ((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                              ((((((st_20.(share)).(globals)).(g_granules)) #
                                                (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                                ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                                ((((((st_20.(share)).(globals)).(g_granules)) #
                                                  (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                  (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                  None)) @ ((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                            (((EVT
                                              CPU_ID
                                              (REL
                                                ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                                (((((st_20.(share)).(globals)).(g_granules)) #
                                                  (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                  (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                              (((EVT
                                                CPU_ID
                                                (REL
                                                  (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                                  ((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                                ((st_20.(log)))))))))
                                      ))))))))))
                      else (
                        when st_20 == (
                            (rtt_walk_lock_unlock_spec
                              (mkPtr "stack_s_rtt_walk" 0)
                              (mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                              ret_5
                              ret_6
                              v_2
                              v_3
                              ((lens 30 st_1).[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                                    ((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                      (Some CPU_ID)))) ::
                                  (((EVT CPU_ID (ACQ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                                    ((((st_1.(oracle)) (st_1.(log))) ++ ((st_1.(log)))))))))));
                        rely ((((st_20.(share)).(granule_data)) = ((sh.(granule_data)))));
                        rely ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                        rely ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                        if (((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_3)) =? (0))
                        then (
                          rely (
                            ((((("granules" = ("granules")) /\ ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                              ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                              ((6 >= (0)))) /\
                              ((6 <= (24)))));
                          when ret_7 == ((granule_addr_spec' (mkPtr "granules" ((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                          when ret_8 == ((buffer_map_spec' 6 ret_7 false));
                          when v_73, st_25 == ((__tte_read_spec (mkPtr (ret_8.(pbase)) ((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_20));
                          rely ((((st_25.(share)).(granule_data)) = (((st_20.(share)).(granule_data)))));
                          if ((v_73 & (63)) =? (8))
                          then (
                            when ret_9 == ((s2tte_create_ripas_spec' 1));
                            rely ((((ret_8.(pbase)) = ("granule_data")) /\ ((((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                            when cid == (((((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            rely (((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                            if ((((st_25.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                            then None
                            else (
                              if ((((st_25.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                              then None
                              else (
                                if ((((st_25.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                                then None
                                else (
                                  when cid_0 == (
                                      (((((((st_25.(share)).(globals)).(g_granules)) #
                                        (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                  rely (((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                                  if ((((st_25.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
                                  then None
                                  else (
                                    if ((((st_25.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
                                    then None
                                    else (
                                      if ((((st_25.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
                                      then None
                                      else (
                                        when cid_1 == (
                                            ((((((((st_25.(share)).(globals)).(g_granules)) #
                                              (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                              ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                              ((((((st_25.(share)).(globals)).(g_granules)) #
                                                (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                        (Some (
                                          0  ,
                                          (((lens 31 st_25).[log] :<
                                            ((EVT
                                              CPU_ID
                                              (REL
                                                ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                                ((((((st_25.(share)).(globals)).(g_granules)) #
                                                  (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                  (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                                  ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                                  ((((((st_25.(share)).(globals)).(g_granules)) #
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                    (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                    None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                              (((EVT
                                                CPU_ID
                                                (REL
                                                  ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                                  (((((st_25.(share)).(globals)).(g_granules)) #
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                    (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                                (((EVT
                                                  CPU_ID
                                                  (REL
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                                    ((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                                  ((st_25.(log))))))))).[share].[granule_data] :<
                                            (((st_25.(share)).(granule_data)) #
                                              (((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                              ((((st_25.(share)).(granule_data)) @ (((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                                (((((st_25.(share)).(granule_data)) @ (((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                                  (((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                                  ret_9))))
                                        )))))))))
                          else (
                            when cid == (((((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                            rely (((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                            if ((((st_25.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                            then None
                            else (
                              if ((((st_25.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                              then None
                              else (
                                if ((((st_25.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                                then None
                                else (
                                  when cid_0 == (
                                      (((((((st_25.(share)).(globals)).(g_granules)) #
                                        (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                        (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                  rely (((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                                  if ((((st_25.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
                                  then None
                                  else (
                                    if ((((st_25.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
                                    then None
                                    else (
                                      if ((((st_25.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
                                      then None
                                      else (
                                        when cid_1 == (
                                            ((((((((st_25.(share)).(globals)).(g_granules)) #
                                              (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                              ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                              ((((((st_25.(share)).(globals)).(g_granules)) #
                                                (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                        (Some (
                                          9  ,
                                          ((lens 32 st_25).[log] :<
                                            ((EVT
                                              CPU_ID
                                              (REL
                                                ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                                ((((((st_25.(share)).(globals)).(g_granules)) #
                                                  (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                  (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                                  ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                                  ((((((st_25.(share)).(globals)).(g_granules)) #
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                    (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                    None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                              (((EVT
                                                CPU_ID
                                                (REL
                                                  ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                                  (((((st_25.(share)).(globals)).(g_granules)) #
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                    (((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                                (((EVT
                                                  CPU_ID
                                                  (REL
                                                    (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                                    ((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                                  ((st_25.(log)))))))))
                                        ))))))))))
                        else (
                          when cid == (((((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          rely (((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
                          if ((((st_20.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
                          then None
                          else (
                            if ((((st_20.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
                            then None
                            else (
                              if ((((st_20.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
                              then None
                              else (
                                when cid_0 == (
                                    (((((((st_20.(share)).(globals)).(g_granules)) #
                                      (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                      (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                rely (((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
                                if ((((st_20.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
                                then None
                                else (
                                  if ((((st_20.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
                                  then None
                                  else (
                                    if ((((st_20.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
                                    then None
                                    else (
                                      when cid_1 == (
                                          ((((((((st_20.(share)).(globals)).(g_granules)) #
                                            (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                            (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                            ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                            ((((((st_20.(share)).(globals)).(g_granules)) #
                                              (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                              (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                              None)) @ ((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                                      (Some (
                                        ((((((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                                          ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                                        ((lens 33 st_20).[log] :<
                                          ((EVT
                                            CPU_ID
                                            (REL
                                              ((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                                              ((((((st_20.(share)).(globals)).(g_granules)) #
                                                (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
                                                ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                                                ((((((st_20.(share)).(globals)).(g_granules)) #
                                                  (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                  (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                                  None)) @ ((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                                            (((EVT
                                              CPU_ID
                                              (REL
                                                ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                                                (((((st_20.(share)).(globals)).(g_granules)) #
                                                  (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                                  (((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                                              (((EVT
                                                CPU_ID
                                                (REL
                                                  (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                                  ((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                                ((st_20.(log)))))))))
                                      ))))))))))
                    | (Some cid) => None
                    end)
                  else None)
                else (
                  when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  when cid_0 == (
                      (((((((st_1.(share)).(globals)).(g_granules)) #
                        ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                        (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    (((((((ret_4 >> (32)) + (3)) << (32)) + (ret_4)) >> (24)) & (4294967040)) |' (((((ret_4 >> (32)) + (3)) << (32)) + (ret_4))))  ,
                    ((lens 34 st_1).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                          (((((st_1.(share)).(globals)).(g_granules)) #
                            ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                        (((EVT
                          CPU_ID
                          (REL
                            ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                            ((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_1.(log)))))))
                  ))))
              else (
                when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                when cid_0 == (
                    (((((((st_1.(share)).(globals)).(g_granules)) #
                      ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                      (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                (Some (
                  12884902657  ,
                  ((lens 35 st_1).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                        (((((st_1.(share)).(globals)).(g_granules)) #
                          ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                          (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                      (((EVT
                        CPU_ID
                        (REL
                          ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                          ((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_1.(log)))))))
                )))))
          else (
            when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
            if ((((st_1.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
            then None
            else (
              if ((((st_1.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
              then None
              else (
                if ((((st_1.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
                then None
                else (
                  when cid_0 == (
                      (((((((st_1.(share)).(globals)).(g_granules)) #
                        ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                        (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                  (Some (
                    6  ,
                    ((lens 36 st_1).[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                          (((((st_1.(share)).(globals)).(g_granules)) #
                            ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                        (((EVT
                          CPU_ID
                          (REL
                            ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                            ((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_1.(log)))))))
                  )))))))
        else (
          when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
          rely (((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
          if ((((st_1.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
          then None
          else (
            if ((((st_1.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
            then None
            else (
              if ((((st_1.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
              then None
              else (
                when cid_0 == (
                    (((((((st_1.(share)).(globals)).(g_granules)) #
                      ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                      (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                (Some (
                  4  ,
                  ((lens 37 st_1).[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))
                        (((((st_1.(share)).(globals)).(g_granules)) #
                          ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
                          (((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))))) ::
                      (((EVT
                        CPU_ID
                        (REL
                          ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))
                          ((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))))) ::
                        ((st_1.(log)))))))
                )))))))
      else (Some ((((((((v_8 >> (32)) + (1)) << (32)) + (1)) >> (24)) & (4294967040)) |' (((((v_8 >> (32)) + (1)) << (32)) + (1)))), st_1))).