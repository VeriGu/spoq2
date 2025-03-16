Definition smc_realm_create_loop335_rank (v_37: Ptr) (v_indvars_iv: Z) (v_rtt_num_start: Ptr) : Z :=
  0.

Definition smc_rec_create_loop222_rank (v_indvars_iv: Z) (v_rec_aux_granules: Ptr) (v_rec_params: Ptr) (v_wide_trip_count: Z) : Z :=
  0.

Definition smc_rec_destroy_spec (v_rec_addr: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rec_addr & (4095)) =? (0))
  then (
    if ((v_rec_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_rec_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rec_addr / (GRANULE_SIZE)) < (1048576)))));
      rely (((((((st.(share)).(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) - (3)) = (0)));
      when sh == ((Some (st.(share))));
      match ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock))) with
      | None =>
        rely (
          ((((((st.(share)).(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) -
            ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)))) =
            (0)));
        if ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_refcount)) =? (0))
        then (
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          rely (
            ((((((((sh.(granule_data)) @
              (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) >
              (0)) /\
              ((((((((sh.(granule_data)) @
                (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                (GRANULES_BASE)) >=
                (0)))) /\
              ((((((((sh.(granule_data)) @
                (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) <
                (0)))));
          rely (
            (("granules" = ("granules")) /\
              (((((((((sh.(granule_data)) @
                (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                (GRANULES_BASE)) mod
                (ST_GRANULE_SIZE)) =
                (0)))));
          when cid == (
              ((((sh.(granules)) #
                ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1)) @
                ((((((((sh.(granule_data)) @
                  (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                  (GRANULES_BASE)) /
                  (ST_GRANULE_SIZE)) +
                  ((8 / (ST_GRANULE_SIZE))))).(e_lock)));
          if (
            ((((((sh.(granules)) #
              ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
              ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1)) @
              ((((((((sh.(granule_data)) @
                (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                (GRANULES_BASE)) /
                (ST_GRANULE_SIZE)) +
                ((8 / (ST_GRANULE_SIZE))))).(e_refcount)) +
              ((- 1))) <?
              (0)))
          then None
          else (
            if (
              ((((((((((sh.(granule_data)) @
                (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                (GRANULES_BASE)) +
                (8)) mod
                (ST_GRANULE_SIZE)) =?
                (8)) &&
                ((((((sh.(granules)) @
                  ((((((((sh.(granule_data)) @
                    (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                    (GRANULES_BASE)) /
                    (ST_GRANULE_SIZE)) +
                    ((8 / (ST_GRANULE_SIZE))))).(e_state)) -
                  (GRANULE_STATE_REC)) =?
                  (0)))))
            then (
              (Some (
                0  ,
                ((st.[log] :<
                  ((EVT
                    CPU_ID
                    (REC_REF
                      ((((((((sh.(granule_data)) @
                        (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                        (GRANULES_BASE)) /
                        (ST_GRANULE_SIZE)) +
                        ((8 / (ST_GRANULE_SIZE))))
                      ((((sh.(granules)) @
                        ((((((((sh.(granule_data)) @
                          (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                          (GRANULES_BASE)) /
                          (ST_GRANULE_SIZE)) +
                          ((8 / (ST_GRANULE_SIZE))))).(e_refcount)) +
                        ((- 1))))) ::
                    (((EVT
                      CPU_ID
                      (REL
                        ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                        ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)).[e_state] :< 1))) ::
                      (((EVT CPU_ID (ACQ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))).[share] :<
                  (((sh.[granule_data] :<
                    ((sh.(granule_data)) #
                      (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC) ==
                      ((((sh.(granule_data)) @
                        (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).[g_norm] :<
                        zero_granule_data_normal).[g_rec] :<
                        empty_rec))).[granules] :<
                    (((sh.(granules)) #
                      ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                      ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1)) #
                      ((((((((sh.(granule_data)) @
                        (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                        (GRANULES_BASE)) /
                        (ST_GRANULE_SIZE)) +
                        ((8 / (ST_GRANULE_SIZE)))) ==
                      (((sh.(granules)) @
                        ((((((((sh.(granule_data)) @
                          (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                          (GRANULES_BASE)) /
                          (ST_GRANULE_SIZE)) +
                          ((8 / (ST_GRANULE_SIZE))))).[e_refcount] :<
                        ((((sh.(granules)) @
                          ((((((((sh.(granule_data)) @
                            (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                            (GRANULES_BASE)) /
                            (ST_GRANULE_SIZE)) +
                            ((8 / (ST_GRANULE_SIZE))))).(e_refcount)) +
                          ((- 1)))))).[slots] :<
                    ((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE)))))
              )))
            else (
              (Some (
                0  ,
                ((st.[log] :<
                  ((EVT
                    CPU_ID
                    (REL
                      ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                      ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)).[e_state] :< 1))) ::
                    (((EVT CPU_ID (ACQ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                  (((sh.[granule_data] :<
                    ((sh.(granule_data)) #
                      (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC) ==
                      ((((sh.(granule_data)) @
                        (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).[g_norm] :<
                        zero_granule_data_normal).[g_rec] :<
                        empty_rec))).[granules] :<
                    (((sh.(granules)) #
                      ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                      ((((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1)) #
                      ((((((((sh.(granule_data)) @
                        (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                        (GRANULES_BASE)) /
                        (ST_GRANULE_SIZE)) +
                        ((8 / (ST_GRANULE_SIZE)))) ==
                      (((sh.(granules)) @
                        ((((((((sh.(granule_data)) @
                          (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                          (GRANULES_BASE)) /
                          (ST_GRANULE_SIZE)) +
                          ((8 / (ST_GRANULE_SIZE))))).[e_refcount] :<
                        ((((sh.(granules)) @
                          ((((((((sh.(granule_data)) @
                            (((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) -
                            (GRANULES_BASE)) /
                            (ST_GRANULE_SIZE)) +
                            ((8 / (ST_GRANULE_SIZE))))).(e_refcount)) +
                          ((- 1)))))).[slots] :<
                    ((sh.(slots)) # SLOT_REC == (((((GRANULES_BASE + ((16 * ((v_rec_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE)))))
              )))))
        else (
          (Some (
            5  ,
            ((st.[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                  (((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
              (sh.[granules] :<
                ((sh.(granules)) #
                  ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                  (((sh.(granules)) @ ((16 * ((v_rec_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None))))
          )))
      | (Some cid) => None
      end))
  else (Some (1, st)).

Definition smc_granule_delegate_spec (v_addr: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_addr & (4095)) =? (0))
  then (
    if ((v_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
      rely ((((((st.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) = (0)));
      when sh == ((Some (st.(share))));
      match ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock))) with
      | None =>
        rely (
          ((((((st.(share)).(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) -
            ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)))) =
            (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        (Some (
          0  ,
          ((st.[log] :<
            ((EVT
              CPU_ID
              (REL
                ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)).[e_state] :< 1))) ::
              (((EVT CPU_ID (ACQ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
            ((((sh.[gpt] :< ((sh.(gpt)) # (v_addr / (GRANULE_SIZE)) == true)).[granule_data] :<
              ((sh.(granule_data)) #
                (((sh.(slots)) # SLOT_DELEGATED == (((((GRANULES_BASE + ((16 * ((v_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_DELEGATED) ==
                (((((sh.(granule_data)) @
                  (((sh.(slots)) # SLOT_DELEGATED == (((((GRANULES_BASE + ((16 * ((v_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_DELEGATED)).[g_norm] :<
                  zero_granule_data_normal).[g_rd] :<
                  empty_rd).[g_rec] :<
                  empty_rec))).[granules] :<
              ((sh.(granules)) #
                ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                ((((sh.(granules)) @ ((16 * ((v_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1))).[slots] :<
              ((sh.(slots)) # SLOT_DELEGATED == (((((GRANULES_BASE + ((16 * ((v_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE)))))
        ))
      | (Some cid) => None
      end))
  else (Some (1, st)).

Definition smc_rtt_map_unprotected_spec (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (v_s2tte: Z) (st: RData) : (option (Z * RData)) :=
  if (
    (((Z.lxor
      ((((- 1) & (281474976710655)) & (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |' (988))
      (- 1)) &
      (v_s2tte)) =?
      (0)))
  then (
    if ((v_s2tte & (28)) =? (16))
    then (Some (1, st))
    else (
      if ((v_s2tte & (768)) =? (256))
      then (Some (1, st))
      else (
        if ((v_rd_addr & (4095)) =? (0))
        then (
          if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
          then (Some (1, st))
          else (
            rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
            rely (((((((st.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) - (2)) = (0)));
            when st1 == ((Some st));
            match (((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock))) with
            | None =>
              rely (
                ((((((st.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) -
                  (((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)))) =
                  (0)));
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              if (((v_ulevel + ((- 4))) - ((- 2))) <? (0))
              then (
                when cid == (
                    (((((st1.(share)).(granules)) #
                      ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                      ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some (
                  1  ,
                  (((st1.[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                        ((((st1.(share)).(granules)) #
                          ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                          ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))))) ::
                      (((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
                    ((((st1.(share)).(granules)) #
                      ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                      ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) #
                      ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                      (((((st1.(share)).(granules)) #
                        ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                        ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :<
                        None))).[share].[slots] :<
                    (((st1.(share)).(slots)) #
                      SLOT_RD ==
                      (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                )))
              else (
                if (
                  (((1 <<
                    (((((((st1.(share)).(granule_data)) @
                      ((((st1.(share)).(slots)) #
                        SLOT_RD ==
                        (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) -
                    (v_map_addr)) >?
                    (0)))
                then (
                  if (
                    ((((v_map_addr & (281474976710655)) & (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                      (v_map_addr)) =?
                      (0)))
                  then (
                    rely (
                      (((((((((st1.(share)).(granule_data)) @
                        ((((st1.(share)).(slots)) #
                          SLOT_RD ==
                          (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) >
                        (0)) /\
                        (((((((((st1.(share)).(granule_data)) @
                          ((((st1.(share)).(slots)) #
                            SLOT_RD ==
                            (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                          (GRANULES_BASE)) >=
                          (0)))) /\
                        (((((((((st1.(share)).(granule_data)) @
                          ((((st1.(share)).(slots)) #
                            SLOT_RD ==
                            (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                          ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) <
                          (0)))));
                    if (
                      ((((1 <<
                        (((((((st1.(share)).(granule_data)) @
                          ((((st1.(share)).(slots)) #
                            SLOT_RD ==
                            (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >>
                        (1)) -
                        (v_map_addr)) >?
                        (0)))
                    then (
                      when cid == (
                          (((((st1.(share)).(granules)) #
                            ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                            ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                      (Some (
                        1  ,
                        (((st1.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                              ((((st1.(share)).(granules)) #
                                ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                                ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))))) ::
                            (((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
                          ((((st1.(share)).(granules)) #
                            ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                            ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) #
                            ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                            (((((st1.(share)).(granules)) #
                              ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                              ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :<
                              None))).[share].[slots] :<
                          (((st1.(share)).(slots)) #
                            SLOT_RD ==
                            (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                      )))
                    else (
                      rely (
                        (((((((st1.(share)).(granules)) #
                          ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                          ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @
                          ((((((((st1.(share)).(granule_data)) @
                            ((((st1.(share)).(slots)) #
                              SLOT_RD ==
                              (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                            (GRANULES_BASE)) /
                            (ST_GRANULE_SIZE))).(e_state)) -
                          (6)) =
                          (0)));
                      rely (
                        (((((((((st1.(share)).(granule_data)) @
                          ((((st1.(share)).(slots)) #
                            SLOT_RD ==
                            (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                          (GRANULES_BASE)) mod
                          (ST_GRANULE_SIZE)) =
                          (0)));
                      when st1_0 == (
                          (Some ((((st1.[log] :< ((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))).[share].[granules] :<
                            (((st1.(share)).(granules)) #
                              ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                              ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))).[share].[slots] :<
                            (((st1.(share)).(slots)) #
                              SLOT_RD ==
                              (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE)))).[stack].[stack_s2_ctx] :<
                            (((((st1.(share)).(granule_data)) @
                              ((((st1.(share)).(slots)) #
                                SLOT_RD ==
                                (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)))));
                      match (
                        ((((st1_0.(share)).(granules)) @
                          ((((((((st1.(share)).(granule_data)) @
                            ((((st1.(share)).(slots)) #
                              SLOT_RD ==
                              (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                            (GRANULES_BASE)) /
                            (ST_GRANULE_SIZE))).(e_lock))
                      ) with
                      | None =>
                        rely (
                          (((((((st1.(share)).(granules)) #
                            ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                            ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @
                            ((((((((st1.(share)).(granule_data)) @
                              ((((st1.(share)).(slots)) #
                                SLOT_RD ==
                                (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                              (GRANULES_BASE)) /
                              (ST_GRANULE_SIZE))).(e_state)) -
                            (((((st1_0.(share)).(granules)) @
                              ((((((((st1.(share)).(granule_data)) @
                                ((((st1.(share)).(slots)) #
                                  SLOT_RD ==
                                  (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                (GRANULES_BASE)) /
                                (ST_GRANULE_SIZE))).(e_state)))) =
                            (0)));
                        when cid == (
                            (((((st1_0.(share)).(granules)) #
                              ((((((((st1.(share)).(granule_data)) @
                                ((((st1.(share)).(slots)) #
                                  SLOT_RD ==
                                  (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                (GRANULES_BASE)) /
                                (ST_GRANULE_SIZE)) ==
                              ((((st1_0.(share)).(granules)) @
                                ((((((((st1.(share)).(granule_data)) @
                                  ((((st1.(share)).(slots)) #
                                    SLOT_RD ==
                                    (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                  (GRANULES_BASE)) /
                                  (ST_GRANULE_SIZE))).[e_lock] :<
                                (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                        when st_15 == (
                            (rtt_walk_lock_unlock_spec
                              (mkPtr
                                "granules"
                                (((((((st1.(share)).(granule_data)) @
                                  ((((st1.(share)).(slots)) #
                                    SLOT_RD ==
                                    (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                  (GRANULES_BASE)))
                              ((((((st1.(share)).(granule_data)) @
                                ((((st1.(share)).(slots)) #
                                  SLOT_RD ==
                                  (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                              ((((((st1.(share)).(granule_data)) @
                                ((((st1.(share)).(slots)) #
                                  SLOT_RD ==
                                  (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                              v_map_addr
                              v_ulevel
                              (mkPtr "stack_wi" 0)
                              ((st1_0.[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                                    ((((st1_0.(share)).(granules)) #
                                      ((((((((st1.(share)).(granule_data)) @
                                        ((((st1.(share)).(slots)) #
                                          SLOT_RD ==
                                          (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                        (GRANULES_BASE)) /
                                        (ST_GRANULE_SIZE)) ==
                                      ((((st1_0.(share)).(granules)) @
                                        ((((((((st1.(share)).(granule_data)) @
                                          ((((st1.(share)).(slots)) #
                                            SLOT_RD ==
                                            (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                          (GRANULES_BASE)) /
                                          (ST_GRANULE_SIZE))).[e_lock] :<
                                        (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))))) ::
                                  (((EVT
                                    CPU_ID
                                    (ACQ
                                      ((((((((st1.(share)).(granule_data)) @
                                        ((((st1.(share)).(slots)) #
                                          SLOT_RD ==
                                          (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                        (GRANULES_BASE)) /
                                        (ST_GRANULE_SIZE)))) ::
                                    ((st1_0.(log))))))).[share].[granules] :<
                                ((((st1_0.(share)).(granules)) #
                                  ((((((((st1.(share)).(granule_data)) @
                                    ((((st1.(share)).(slots)) #
                                      SLOT_RD ==
                                      (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                    (GRANULES_BASE)) /
                                    (ST_GRANULE_SIZE)) ==
                                  ((((st1_0.(share)).(granules)) @
                                    ((((((((st1.(share)).(granule_data)) @
                                      ((((st1.(share)).(slots)) #
                                        SLOT_RD ==
                                        (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                      (GRANULES_BASE)) /
                                      (ST_GRANULE_SIZE))).[e_lock] :<
                                    (Some CPU_ID))) #
                                  ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                                  (((((st1_0.(share)).(granules)) #
                                    ((((((((st1.(share)).(granule_data)) @
                                      ((((st1.(share)).(slots)) #
                                        SLOT_RD ==
                                        (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                      (GRANULES_BASE)) /
                                      (ST_GRANULE_SIZE)) ==
                                    ((((st1_0.(share)).(granules)) @
                                      ((((((((st1.(share)).(granule_data)) @
                                        ((((st1.(share)).(slots)) #
                                          SLOT_RD ==
                                          (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                        (GRANULES_BASE)) /
                                        (ST_GRANULE_SIZE))).[e_lock] :<
                                      (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :<
                                    None)))));
                        if (((((st_15.(stack)).(stack_wi)).(e_last_level)) - (v_ulevel)) =? (0))
                        then (
                          rely (
                            ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                              ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
                          rely (((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                          when cid_0 == (
                              ((((st_15.(share)).(granules)) @
                                ((((st_15.(share)).(slots)) #
                                  SLOT_RTT ==
                                  (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(e_lock)));
                          if (
                            (((((((st_15.(share)).(granule_data)) @
                              ((((st_15.(share)).(slots)) #
                                SLOT_RTT ==
                                (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                              (3)) =?
                              (0)))
                          then (
                            if (
                              (((((((st_15.(share)).(granule_data)) @
                                ((((st_15.(share)).(slots)) #
                                  SLOT_RTT ==
                                  (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                                (60)) =?
                                (0)))
                            then (
                              if (v_ulevel =? (3))
                              then (
                                rely ((("granules" = ("granules")) /\ ((((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                when cid_2 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                if ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
                                then None
                                else (
                                  if (
                                    ((((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                                      (((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =?
                                        (0)))))
                                  then (
                                    when cid_3 == (
                                        (((((st_15.(share)).(granules)) #
                                          ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                          ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                            (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                                    (Some (
                                      0  ,
                                      ((((st_15.[log] :<
                                        ((EVT
                                          CPU_ID
                                          (REL
                                            (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                            ((((st_15.(share)).(granules)) #
                                              ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                              ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                                (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                          (((EVT
                                            CPU_ID
                                            (REC_REF
                                              ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                                              (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) ::
                                            ((st_15.(log))))))).[share].[granule_data] :<
                                        (((st_15.(share)).(granule_data)) #
                                          ((((st_15.(share)).(slots)) #
                                            SLOT_RTT ==
                                            (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT) ==
                                          ((((st_15.(share)).(granule_data)) @
                                            ((((st_15.(share)).(slots)) #
                                              SLOT_RTT ==
                                              (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).[g_norm] :<
                                            (((((st_15.(share)).(granule_data)) @
                                              ((((st_15.(share)).(slots)) #
                                                SLOT_RTT ==
                                                (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) #
                                              (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index)))))) ==
                                              (v_s2tte |' (54043195528446979)))))).[share].[granules] :<
                                        ((((st_15.(share)).(granules)) #
                                          ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                          ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                            (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) #
                                          (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                          (((((st_15.(share)).(granules)) #
                                            ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                            ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                              (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                                            None))).[share].[slots] :<
                                        (((st_15.(share)).(slots)) #
                                          SLOT_RTT ==
                                          (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                                    )))
                                  else (
                                    when cid_3 == (
                                        (((((st_15.(share)).(granules)) #
                                          ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                          ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                            (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                                    (Some (
                                      0  ,
                                      ((((st_15.[log] :<
                                        ((EVT
                                          CPU_ID
                                          (REL
                                            (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                            ((((st_15.(share)).(granules)) #
                                              ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                              ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                                (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                          ((st_15.(log))))).[share].[granule_data] :<
                                        (((st_15.(share)).(granule_data)) #
                                          ((((st_15.(share)).(slots)) #
                                            SLOT_RTT ==
                                            (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT) ==
                                          ((((st_15.(share)).(granule_data)) @
                                            ((((st_15.(share)).(slots)) #
                                              SLOT_RTT ==
                                              (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).[g_norm] :<
                                            (((((st_15.(share)).(granule_data)) @
                                              ((((st_15.(share)).(slots)) #
                                                SLOT_RTT ==
                                                (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) #
                                              (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index)))))) ==
                                              (v_s2tte |' (54043195528446979)))))).[share].[granules] :<
                                        ((((st_15.(share)).(granules)) #
                                          ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                          ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                            (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) #
                                          (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                          (((((st_15.(share)).(granules)) #
                                            ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                            ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                              (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                                            None))).[share].[slots] :<
                                        (((st_15.(share)).(slots)) #
                                          SLOT_RTT ==
                                          (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                                    )))))
                              else (
                                rely ((("granules" = ("granules")) /\ ((((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                when cid_2 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                if ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
                                then None
                                else (
                                  if (
                                    ((((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                                      (((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =?
                                        (0)))))
                                  then (
                                    when cid_3 == (
                                        (((((st_15.(share)).(granules)) #
                                          ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                          ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                            (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                                    (Some (
                                      0  ,
                                      ((((st_15.[log] :<
                                        ((EVT
                                          CPU_ID
                                          (REL
                                            (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                            ((((st_15.(share)).(granules)) #
                                              ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                              ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                                (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                          (((EVT
                                            CPU_ID
                                            (REC_REF
                                              ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                                              (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) ::
                                            ((st_15.(log))))))).[share].[granule_data] :<
                                        (((st_15.(share)).(granule_data)) #
                                          ((((st_15.(share)).(slots)) #
                                            SLOT_RTT ==
                                            (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT) ==
                                          ((((st_15.(share)).(granule_data)) @
                                            ((((st_15.(share)).(slots)) #
                                              SLOT_RTT ==
                                              (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).[g_norm] :<
                                            (((((st_15.(share)).(granule_data)) @
                                              ((((st_15.(share)).(slots)) #
                                                SLOT_RTT ==
                                                (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) #
                                              (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index)))))) ==
                                              (v_s2tte |' (54043195528446977)))))).[share].[granules] :<
                                        ((((st_15.(share)).(granules)) #
                                          ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                          ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                            (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) #
                                          (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                          (((((st_15.(share)).(granules)) #
                                            ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                            ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                              (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                                            None))).[share].[slots] :<
                                        (((st_15.(share)).(slots)) #
                                          SLOT_RTT ==
                                          (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                                    )))
                                  else (
                                    when cid_3 == (
                                        (((((st_15.(share)).(granules)) #
                                          ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                          ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                            (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                                    (Some (
                                      0  ,
                                      ((((st_15.[log] :<
                                        ((EVT
                                          CPU_ID
                                          (REL
                                            (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                            ((((st_15.(share)).(granules)) #
                                              ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                              ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                                (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                          ((st_15.(log))))).[share].[granule_data] :<
                                        (((st_15.(share)).(granule_data)) #
                                          ((((st_15.(share)).(slots)) #
                                            SLOT_RTT ==
                                            (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT) ==
                                          ((((st_15.(share)).(granule_data)) @
                                            ((((st_15.(share)).(slots)) #
                                              SLOT_RTT ==
                                              (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).[g_norm] :<
                                            (((((st_15.(share)).(granule_data)) @
                                              ((((st_15.(share)).(slots)) #
                                                SLOT_RTT ==
                                                (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) #
                                              (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index)))))) ==
                                              (v_s2tte |' (54043195528446977)))))).[share].[granules] :<
                                        ((((st_15.(share)).(granules)) #
                                          ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                          ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                            (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) #
                                          (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                          (((((st_15.(share)).(granules)) #
                                            ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                            ((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                              (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                                            None))).[share].[slots] :<
                                        (((st_15.(share)).(slots)) #
                                          SLOT_RTT ==
                                          (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                                    ))))))
                            else (
                              when cid_1 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                              (Some (
                                (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                (((st_15.[log] :<
                                  ((EVT
                                    CPU_ID
                                    (REL
                                      (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                      (((st_15.(share)).(granules)) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                    ((st_15.(log))))).[share].[granules] :<
                                  (((st_15.(share)).(granules)) #
                                    (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                    ((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                                  (((st_15.(share)).(slots)) #
                                    SLOT_RTT ==
                                    (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                              ))))
                          else (
                            when cid_1 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                            (Some (
                              (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                              (((st_15.[log] :<
                                ((EVT
                                  CPU_ID
                                  (REL
                                    (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                    (((st_15.(share)).(granules)) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                  ((st_15.(log))))).[share].[granules] :<
                                (((st_15.(share)).(granules)) #
                                  (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                  ((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                                (((st_15.(share)).(slots)) #
                                  SLOT_RTT ==
                                  (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                            ))))
                        else (
                          rely (
                            ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                              ((((((st_15.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
                          when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                          (Some (
                            ((((((((st_15.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) >> (24)) & (4294967040)) |'
                              (((((((st_15.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) & (4294967295))))  ,
                            ((st_15.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                  (((st_15.(share)).(granules)) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                ((st_15.(log))))).[share].[granules] :<
                              (((st_15.(share)).(granules)) #
                                (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                ((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
                          )))
                      | (Some cid) => None
                      end))
                  else (
                    when cid == (
                        (((((st1.(share)).(granules)) #
                          ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                          ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                    (Some (
                      1  ,
                      (((st1.[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                            ((((st1.(share)).(granules)) #
                              ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                              ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))))) ::
                          (((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
                        ((((st1.(share)).(granules)) #
                          ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                          ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) #
                          ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                          (((((st1.(share)).(granules)) #
                            ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                            ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :<
                            None))).[share].[slots] :<
                        (((st1.(share)).(slots)) #
                          SLOT_RD ==
                          (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                    ))))
                else (
                  when cid == (
                      (((((st1.(share)).(granules)) #
                        ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                        ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    1  ,
                    (((st1.[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                          ((((st1.(share)).(granules)) #
                            ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                            ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))))) ::
                        (((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
                      ((((st1.(share)).(granules)) #
                        ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                        ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) #
                        ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                        (((((st1.(share)).(granules)) #
                          ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                          ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :<
                          None))).[share].[slots] :<
                      (((st1.(share)).(slots)) #
                        SLOT_RD ==
                        (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                  ))))
            | (Some cid) => None
            end))
        else (Some (1, st)))))
  else (Some (1, st)).

