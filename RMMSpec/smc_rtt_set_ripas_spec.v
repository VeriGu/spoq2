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
  if (
    match (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
    | None => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
    end)
  then (
    rely (((v_call47.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
    when cid == (((((st_35.(share)).(granules)) @ (((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call25.(poffset)) = (0)));
    rely (
      (((((st_35.(stack)).(stack_g1)) > (0)) /\ (((((st_35.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (
      (((((st_35.(stack)).(stack_g0)) > (0)) /\ (((((st_35.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some (
      0  ,
      (((lens 129 st_35).[share].[granule_data] :<
        (((st_35.(share)).(granule_data)) #
          (((st_35.(share)).(slots)) @ SLOT_REC) ==
          ((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
            (((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_set_ripas] :<
              ((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).[e_addr] :<
                (((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).(e_addr)) + (v_call30))))))).[share].[slots] :<
        (((((st_35.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1)))
    )))
  else None.

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
  if (
    match (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
    | None => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
    end)
  then (
    rely (((v_call47.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
    when cid == (((((st_35.(share)).(granules)) @ (((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call25.(poffset)) = (0)));
    rely (
      (((((st_35.(stack)).(stack_g1)) > (0)) /\ (((((st_35.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (
      (((((st_35.(stack)).(stack_g0)) > (0)) /\ (((((st_35.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some (
      0  ,
      (((lens 146 st_35).[share].[granule_data] :<
        (((st_35.(share)).(granule_data)) #
          (((st_35.(share)).(slots)) @ SLOT_REC) ==
          ((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
            (((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_set_ripas] :<
              ((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).[e_addr] :<
                (((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).(e_addr)) + (v_call30))))))).[share].[slots] :<
        (((((st_35.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1)))
    )))
  else None.

Definition smc_rtt_set_ripas_3 (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_call9.(poffset)) = (0)));
  rely (((v_call47.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  if (
    match (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
    | None => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
    end)
  then (
    rely (((v_call47.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
    when cid == (((((st_35.(share)).(granules)) @ (((((st_35.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call25.(poffset)) = (0)));
    rely (
      (((((st_35.(stack)).(stack_g1)) > (0)) /\ (((((st_35.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (
      (((((st_35.(stack)).(stack_g0)) > (0)) /\ (((((st_35.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_35.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    (Some (
      0  ,
      (((lens 163 st_35).[share].[granule_data] :<
        (((st_35.(share)).(granule_data)) #
          (((st_35.(share)).(slots)) @ SLOT_REC) ==
          ((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
            (((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_set_ripas] :<
              ((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).[e_addr] :<
                (((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).(e_addr)) + (v_call30))))))).[share].[slots] :<
        (((((st_35.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1)))
    )))
  else None.

Definition smc_rtt_set_ripas_4 (v_ulevel: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_32: RData) : (option (Z * RData)) :=
  rely (((v_call47.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  rely (((v_call47.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((((((st_32.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_32.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_32.(share)).(granules)) @ (((((st_32.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call25.(poffset)) = (0)));
  rely (((v_call9.(poffset)) = (0)));
  rely (
    (((((st_32.(stack)).(stack_g1)) > (0)) /\ (((((st_32.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_32.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
  rely (
    (((((st_32.(stack)).(stack_g0)) > (0)) /\ (((((st_32.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_32.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
  (Some (
    (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
    ((lens 168 st_32).[share].[slots] :< (((((st_32.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1)))
  )).

Definition smc_rtt_set_ripas_5 (v_15: Z) (v_wi: Ptr) (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_25: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  rely (((((((st_25.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_25.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_25.(share)).(granules)) @ (((((st_25.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call25.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((v_call9.(poffset)) = (0)));
  rely (
    (((((st_25.(stack)).(stack_g1)) > (0)) /\ (((((st_25.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_25.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
  rely (
    (((((st_25.(stack)).(stack_g0)) > (0)) /\ (((((st_25.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_25.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
  (Some (
    (((((v_15 << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_15 << (32)) + (4)) & (4294967295))))  ,
    ((lens 172 st_25).[share].[slots] :< ((((st_25.(share)).(slots)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1)))
  )).

Definition smc_rtt_set_ripas_6 (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_18: RData) : (option (Z * RData)) :=
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  rely (((v_call25.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((v_call9.(poffset)) = (0)));
  rely (
    (((((st_18.(stack)).(stack_g1)) > (0)) /\ (((((st_18.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_18.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
  when cid == (((((st_18.(share)).(granules)) @ ((((st_18.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (
    (((((st_18.(stack)).(stack_g0)) > (0)) /\ (((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_18.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
  (Some (1, ((lens 175 st_18).[share].[slots] :< ((((st_18.(share)).(slots)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1))))).

Definition smc_rtt_set_ripas_7 (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_13: RData) : (option (Z * RData)) :=
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("stack_g1")));
  rely (((v_g_rd.(pbase)) = ("stack_g0")));
  rely (((v_call9.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    (((((st_13.(stack)).(stack_g1)) > (0)) /\ (((((st_13.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_13.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
  when cid == (((((st_13.(share)).(granules)) @ ((((st_13.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (
    (((((st_13.(stack)).(stack_g0)) > (0)) /\ (((((st_13.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_13.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
  (Some (1, ((lens 178 st_13).[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_REC == (- 1))))).

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
  (Some (5, (lens 179 st_8))).

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
    match (((((st_16.(share)).(granules)) @ (((st_16.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => (((((st_16.(share)).(granules)) @ (((st_16.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
    | None => (((((st_16.(share)).(granules)) @ (((st_16.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
    end)
  then (
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
      (Some (1, ((lens 182 st_16).[share].[slots] :< ((((st_16.(share)).(slots)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1))))))
    else (
      when cid == (((((st_16.(share)).(granules)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(e_lock)));
      rely (
        (((((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
          (((((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
      rely (
        ((((((st_16.(share)).(granules)) @
          ((((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
          (6)) =?
          (0)));
      rely (((((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
      when sh == (((st_16.(repl)) ((st_16.(oracle)) (st_16.(log))) (st_16.(share))));
      if (
        match (
          (((((lens 183 st_16).(share)).(granules)) @
            (1152921504605528063 +
              ((((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))
        ) with
        | (Some cid_0) => true
        | None => false
        end)
      then (
        when st_24 == (
            (rtt_walk_lock_unlock_spec
              (mkPtr "granules" (((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
              ((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
              ((((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
              v_map_addr
              v_ulevel
              v_wi
              ((lens 184 st_16).[stack].[stack_s2_ctx] :< (((((st_16.(share)).(granule_data)) @ (((st_16.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)))));
        if (((((st_24.(stack)).(stack_wi)).(e_last_level)) - (v_ulevel)) =? (0))
        then (
          rely (((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
          rely ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          when cid_0 == (((((st_24.(share)).(granules)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
          if (
            (((((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))) &
              (36028797018963968)) =?
              (0)))
          then (
            if (
              ((v_ulevel =? (3)) &&
                ((((((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))) &
                  (3)) =?
                  (3)))))
            then (
              when v_call50, st_32 == (
                  (update_ripas_spec
                    v_s2tte
                    v_ulevel
                    v_uripas
                    ((st_24.[share].[slots] :< (((st_24.(share)).(slots)) # SLOT_RTT == (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2tte] :<
                      (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))))));
              if v_call50
              then (
                when cid_1 == (((((st_32.(share)).(granules)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
                if (v_uripas =? (0))
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
            else (
              if (
                ((v_ulevel =? (2)) &&
                  ((((((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))) &
                    (3)) =?
                    (1)))))
              then (
                when v_call50, st_32 == (
                    (update_ripas_spec
                      v_s2tte
                      v_ulevel
                      v_uripas
                      ((st_24.[share].[slots] :< (((st_24.(share)).(slots)) # SLOT_RTT == (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2tte] :<
                        (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))))));
                if v_call50
                then (
                  when cid_1 == (((((st_32.(share)).(granules)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
                  if (v_uripas =? (0))
                  then (
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
                              ((st_32.(stack)).(stack_s2tte))))))))
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
              else (
                when v_call50, st_32 == (
                    (update_ripas_spec
                      v_s2tte
                      v_ulevel
                      v_uripas
                      ((st_24.[share].[slots] :< (((st_24.(share)).(slots)) # SLOT_RTT == (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2tte] :<
                        (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))))));
                if v_call50
                then (
                  when cid_1 == (((((st_32.(share)).(granules)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
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
                            ((st_32.(stack)).(stack_s2tte))))))))
                else (smc_rtt_set_ripas_4 v_ulevel (mkPtr "slot_rtt" 0) v_wi v_call25 v_call9 v_g_rec v_g_rd st_0 st_32))))
          else (
            when v_call50, st_32 == (
                (update_ripas_spec
                  v_s2tte
                  v_ulevel
                  v_uripas
                  ((st_24.[share].[slots] :< (((st_24.(share)).(slots)) # SLOT_RTT == (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2tte] :<
                    (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))))));
            if v_call50
            then (
              when cid_1 == (((((st_32.(share)).(granules)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
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
                        ((st_32.(stack)).(stack_s2tte))))))))
            else (smc_rtt_set_ripas_4 v_ulevel (mkPtr "slot_rtt" 0) v_wi v_call25 v_call9 v_g_rec v_g_rd st_0 st_32)))
        else (smc_rtt_set_ripas_5 (((st_24.(stack)).(stack_wi)).(e_last_level)) v_wi v_call25 v_call9 v_g_rec v_g_rd st_0 st_24))
      else None))
  else None.

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
      if (
        if ((((((st_6.(share)).(granules)) @ (1152921504605528063 + ((((st_6.(stack)).(stack_g1)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
        then true
        else (
          match (((((st_6.(share)).(granules)) @ (1152921504605528063 + ((((st_6.(stack)).(stack_g1)) / (ST_GRANULE_SIZE))))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end))
      then (
        if (((((st_6.(share)).(granules)) @ (1152921504605528063 + ((((st_6.(stack)).(stack_g1)) / (ST_GRANULE_SIZE))))).(e_refcount)) =? (0))
        then (
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          rely (
            (((((st_6.(stack)).(stack_g0)) > (0)) /\ (((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
              (((((st_6.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
          if (
            match (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(e_lock))) with
            | (Some cid) => (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(e_refcount)) =? (0))
            | None => (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(e_refcount)) =? (1))
            end)
          then (
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
                  when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(e_lock)));
                  if (
                    ((v_ulevel >? (3)) ||
                      (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) - (v_ulevel)) >?
                        (0)))))
                  then (
                    when cid_0 == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                    (Some (
                      1  ,
                      ((lens 196 st_6).[share].[slots] :<
                        ((((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                          SLOT_RD ==
                          ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))) #
                          SLOT_RD ==
                          (- 1)) #
                          SLOT_REC ==
                          (- 1)))
                    )))
                  else (
                    rely (((Some cid) = ((Some CPU_ID))));
                    if (
                      (((1 << (((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) -
                        (v_map_addr)) >?
                        (0)))
                    then (
                      if ((((v_map_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) - (v_map_addr)) =? (0))
                      then (
                        if (
                          ((((1 << ((39 + (((- 9) * (v_ulevel)))))) + (v_map_addr)) -
                            (((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rec)).(e_set_ripas)).(e_end)))) >?
                            (0)))
                        then (
                          when cid_0 == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                          (Some (
                            1  ,
                            ((lens 197 st_6).[share].[slots] :<
                              ((((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                                SLOT_RD ==
                                ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))) #
                                SLOT_RD ==
                                (- 1)) #
                                SLOT_REC ==
                                (- 1)))
                          )))
                        else (
                          rely (
                            (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
                              (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
                          rely (
                            ((((((st_6.(share)).(granules)) @
                              ((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) /
                                (ST_GRANULE_SIZE))).(e_state)) -
                              (6)) =?
                              (0)));
                          rely (((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
                          when sh == (
                              ((st_6.(repl))
                                ((st_6.(oracle)) (st_6.(log)))
                                ((st_6.(share)).[slots] :<
                                  ((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                                    SLOT_RD ==
                                    ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))));
                          if (
                            match (
                              (((((lens 198 st_6).(share)).(granules)) @
                                (1152921504605528063 +
                                  ((((((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))
                            ) with
                            | (Some cid_1) => true
                            | None => false
                            end)
                          then (
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
                                  (((lens 199 st_6).[share].[slots] :<
                                    ((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                                      SLOT_RD ==
                                      ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2_ctx] :<
                                    (((((st_6.(share)).(granule_data)) @ ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)))));
                            if (((((st_24.(stack)).(stack_wi)).(e_last_level)) - (v_ulevel)) =? (0))
                            then (
                              rely (((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                              rely ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
                              when cid_1 == (((((st_24.(share)).(granules)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
                              if (
                                (((((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))) &
                                  (36028797018963968)) =?
                                  (0)))
                              then (
                                if (
                                  ((v_ulevel =? (3)) &&
                                    ((((((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))) &
                                      (3)) =?
                                      (3)))))
                                then (
                                  when v_call50, st_32 == (
                                      (update_ripas_spec
                                        (mkPtr "stack_s2tte" 0)
                                        v_ulevel
                                        v_uripas
                                        ((st_24.[share].[slots] :< (((st_24.(share)).(slots)) # SLOT_RTT == (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2tte] :<
                                          (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))))));
                                  if v_call50
                                  then (
                                    when cid_2 == (((((st_32.(share)).(granules)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
                                    if (v_uripas =? (0))
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
                                  if (
                                    ((v_ulevel =? (2)) &&
                                      ((((((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))) &
                                        (3)) =?
                                        (1)))))
                                  then (
                                    when v_call50, st_32 == (
                                        (update_ripas_spec
                                          (mkPtr "stack_s2tte" 0)
                                          v_ulevel
                                          v_uripas
                                          ((st_24.[share].[slots] :< (((st_24.(share)).(slots)) # SLOT_RTT == (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2tte] :<
                                            (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))))));
                                    if v_call50
                                    then (
                                      when cid_2 == (((((st_32.(share)).(granules)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
                                      if (v_uripas =? (0))
                                      then (
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
                                                  ((st_32.(stack)).(stack_s2tte))))))))
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
                                    when v_call50, st_32 == (
                                        (update_ripas_spec
                                          (mkPtr "stack_s2tte" 0)
                                          v_ulevel
                                          v_uripas
                                          ((st_24.[share].[slots] :< (((st_24.(share)).(slots)) # SLOT_RTT == (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2tte] :<
                                            (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))))));
                                    if v_call50
                                    then (
                                      when cid_2 == (((((st_32.(share)).(granules)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
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
                                                ((st_32.(stack)).(stack_s2tte))))))))
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
                                        st_32)))))
                              else (
                                when v_call50, st_32 == (
                                    (update_ripas_spec
                                      (mkPtr "stack_s2tte" 0)
                                      v_ulevel
                                      v_uripas
                                      ((st_24.[share].[slots] :< (((st_24.(share)).(slots)) # SLOT_RTT == (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))).[stack].[stack_s2tte] :<
                                        (((((st_24.(share)).(granule_data)) @ (((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_24.(stack)).(stack_wi)).(e_index))))))));
                                if v_call50
                                then (
                                  when cid_2 == (((((st_32.(share)).(granules)) @ (((st_32.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
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
                                            ((st_32.(stack)).(stack_s2tte))))))))
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
                                    st_32))))
                            else (
                              (smc_rtt_set_ripas_5
                                (((st_24.(stack)).(stack_wi)).(e_last_level))
                                (mkPtr "stack_wi" 0)
                                (mkPtr "slot_rd" 0)
                                (mkPtr "slot_rec" 0)
                                (mkPtr "stack_g1" 0)
                                (mkPtr "stack_g0" 0)
                                st
                                st_24)))
                          else None))
                      else (
                        when cid_0 == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                        (Some (
                          1  ,
                          ((lens 202 st_6).[share].[slots] :<
                            ((((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                              SLOT_RD ==
                              ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))) #
                              SLOT_RD ==
                              (- 1)) #
                              SLOT_REC ==
                              (- 1)))
                        ))))
                    else (
                      when cid_0 == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                      (Some (
                        1  ,
                        ((lens 205 st_6).[share].[slots] :<
                          ((((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) #
                            SLOT_RD ==
                            ((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))) #
                            SLOT_RD ==
                            (- 1)) #
                            SLOT_REC ==
                            (- 1)))
                      )))))
                else (
                  when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    1  ,
                    ((lens 208 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) # SLOT_REC == (- 1)))
                  ))))
              else (
                when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some (
                  1  ,
                  ((lens 211 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) # SLOT_REC == (- 1)))
                ))))
            else (
              when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
              (Some (
                3  ,
                ((lens 214 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_REC == ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) # SLOT_REC == (- 1)))
              ))))
          else None)
        else (
          when cid == (((((st_6.(share)).(granules)) @ ((((st_6.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          rely (
            (((((st_6.(stack)).(stack_g0)) > (0)) /\ (((((st_6.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
              (((((st_6.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
          (Some (5, (lens 215 st_6)))))
      else None)
    else (Some (1, st_6))).

