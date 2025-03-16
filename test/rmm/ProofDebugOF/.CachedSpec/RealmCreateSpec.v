Definition free_sl_rtts_loop193_rank (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
  0.

Definition total_root_rtt_refcount_loop348_rank (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_refcount_08: Z) (v_wide_trip_count: Z) : Z :=
  0.

Fixpoint total_root_rtt_refcount_loop348 (_N_: nat) (__break__: bool) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_refcount_08: Z) (v_refcount_0_lcssa: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st))
  | (S _N__0) =>
    match ((total_root_rtt_refcount_loop348 _N__0 __break__ v_g_rtt v_indvars_iv v_refcount_08 v_refcount_0_lcssa v_wide_trip_count st)) with
    | (Some (__break___0, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0)) =>
      if __break___0
      then (Some (true, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0))
      else (
        rely (((((((st_0.(share)).(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).(e_state)) - (6)) = (0)));
        rely (((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) mod (ST_GRANULE_SIZE)) = (0)));
        rely (((v_g_rtt_0.(pbase)) = ("granules")));
        when sh == ((Some (st_0.(share))));
        match ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).(e_lock))) with
        | None =>
          rely (
            ((((((st_0.(share)).(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).(e_state)) -
              ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).(e_state)))) =
              (0)));
          if ((((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (8)))) mod (ST_GRANULE_SIZE)) =? (8))
          then (
            if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
            then (
              (Some (
                false  ,
                v_g_rtt_0  ,
                (v_indvars_iv_0 + (1))  ,
                ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).(e_refcount)) + (v_refcount_9))  ,
                v_refcount_0_lcssa_0  ,
                v_wide_trip_count_0  ,
                ((st_0.[log] :<
                  ((EVT
                    CPU_ID
                    (REL
                      (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))
                      (((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                    (((EVT CPU_ID (ACQ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE)))) :: ((((st_0.(oracle)) (st_0.(log))) ++ ((st_0.(log))))))))).[share] :<
                  (sh.[granules] :<
                    ((sh.(granules)) #
                      (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).[e_lock] :< None))))
              )))
            else (
              (Some (
                true  ,
                v_g_rtt_0  ,
                v_indvars_iv_0  ,
                v_refcount_9  ,
                ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).(e_refcount)) + (v_refcount_9))  ,
                v_wide_trip_count_0  ,
                ((st_0.[log] :<
                  ((EVT
                    CPU_ID
                    (REL
                      (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))
                      (((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                    (((EVT CPU_ID (ACQ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE)))) :: ((((st_0.(oracle)) (st_0.(log))) ++ ((st_0.(log))))))))).[share] :<
                  (sh.[granules] :<
                    ((sh.(granules)) #
                      (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).[e_lock] :< None))))
              ))))
          else None
        | (Some cid) => None
        end)
    | None => None
    end
  end.

Fixpoint free_sl_rtts_loop193 (_N_: nat) (__break__: bool) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_g_rtt, v_indvars_iv, v_wide_trip_count, st))
  | (S _N__0) =>
    match ((free_sl_rtts_loop193 _N__0 __break__ v_g_rtt v_indvars_iv v_wide_trip_count st)) with
    | (Some (__break___0, v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
      if __break___0
      then (Some (true, v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0))
      else (
        rely (((((((st_0.(share)).(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).(e_state)) - (6)) = (0)));
        rely (((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) mod (ST_GRANULE_SIZE)) = (0)));
        rely (((v_g_rtt_0.(pbase)) = ("granules")));
        when sh == ((Some (st_0.(share))));
        match ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).(e_lock))) with
        | None =>
          rely (
            ((((((st_0.(share)).(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).(e_state)) -
              ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).(e_state)))) =
              (0)));
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (
            (Some (
              false  ,
              v_g_rtt_0  ,
              (v_indvars_iv_0 + (1))  ,
              v_wide_trip_count_0  ,
              ((st_0.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))
                    ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)).[e_state] :< 1))) ::
                  (((EVT CPU_ID (ACQ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE)))) :: ((((st_0.(oracle)) (st_0.(log))) ++ ((st_0.(log))))))))).[share] :<
                (((sh.[granule_data] :<
                  ((sh.(granule_data)) #
                    (((sh.(slots)) #
                      SLOT_RTT ==
                      (((((GRANULES_BASE + (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT) ==
                    (((((sh.(granule_data)) @
                      (((sh.(slots)) #
                        SLOT_RTT ==
                        (((((GRANULES_BASE + (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).[g_norm] :<
                      zero_granule_data_normal).[g_rd] :<
                      empty_rd).[g_rec] :<
                      empty_rec))).[granules] :<
                  ((sh.(granules)) #
                    (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE)) ==
                    ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1))).[slots] :<
                  ((sh.(slots)) #
                    SLOT_RTT ==
                    (((((GRANULES_BASE + (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE)))))
            )))
          else (
            (Some (
              true  ,
              v_g_rtt_0  ,
              v_indvars_iv_0  ,
              v_wide_trip_count_0  ,
              ((st_0.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))
                    ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)).[e_state] :< 1))) ::
                  (((EVT CPU_ID (ACQ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE)))) :: ((((st_0.(oracle)) (st_0.(log))) ++ ((st_0.(log))))))))).[share] :<
                (((sh.[granule_data] :<
                  ((sh.(granule_data)) #
                    (((sh.(slots)) #
                      SLOT_RTT ==
                      (((((GRANULES_BASE + (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT) ==
                    (((((sh.(granule_data)) @
                      (((sh.(slots)) #
                        SLOT_RTT ==
                        (((((GRANULES_BASE + (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).[g_norm] :<
                      zero_granule_data_normal).[g_rd] :<
                      empty_rd).[g_rec] :<
                      empty_rec))).[granules] :<
                  ((sh.(granules)) #
                    (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE)) ==
                    ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< 1))).[slots] :<
                  ((sh.(slots)) #
                    SLOT_RTT ==
                    (((((GRANULES_BASE + (((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE)))))
            )))
        | (Some cid) => None
        end)
    | None => None
    end
  end.

Definition vmid_free_spec (v_vmid: Z) (st: RData) : (option RData) :=
  rely ((((0 - ((v_vmid >> (6)))) <= (0)) /\ (((v_vmid >> (6)) < (1024)))));
  (Some (st.[share].[gv_vmids] :<
    (((st.(share)).(gv_vmids)) # ((8 * ((v_vmid >> (6)))) / (8)) == (Z.clearbit (((st.(share)).(gv_vmids)) @ ((8 * ((v_vmid >> (6)))) / (8))) (v_vmid & (63)))))).

Definition free_sl_rtts_spec (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option RData) :=
  if ((0 - (v_num_rtts)) <? (0))
  then (
    match ((free_sl_rtts_loop193 (z_to_nat 0) false v_g_rtt 0 v_num_rtts st)) with
    | (Some (__break__, v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some st_0)
    | None => None
    end)
  else (Some st).

Definition total_root_rtt_refcount_spec (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option (Z * RData)) :=
  if ((0 - (v_num_rtts)) <? (0))
  then (
    match ((total_root_rtt_refcount_loop348 (z_to_nat 0) false v_g_rtt 0 0 0 v_num_rtts st)) with
    | (Some (__break__, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0)) => (Some (v_refcount_0_lcssa_0, st_0))
    | None => None
    end)
  else (Some (0, st)).

