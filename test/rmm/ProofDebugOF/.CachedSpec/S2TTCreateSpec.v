Definition map_unmap_ns_3 (v_wi: Ptr) (st_16: RData) : (option (bool * Ptr * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (
    ((((((st_16.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
      ((((((st_16.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
  rely (((((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  when cid == (
      ((((st_16.(share)).(granules)) @
        ((((st_16.(share)).(slots)) #
          SLOT_RTT ==
          (((((GRANULES_BASE + (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(e_lock)));
  match (
    if (
      (((((((st_16.(share)).(granule_data)) @
        ((((st_16.(share)).(slots)) #
          SLOT_RTT ==
          (((((GRANULES_BASE + (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_16.(stack)).(stack_wi)).(e_index))))))) &
        (3)) =?
        (0)))
    then (
      match (
        if (
          (((((((st_16.(share)).(granule_data)) @
            ((((st_16.(share)).(slots)) #
              SLOT_RTT ==
              (((((GRANULES_BASE + (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_16.(stack)).(stack_wi)).(e_index))))))) &
            (60)) =?
            (0)))
        then (
          (Some (
            true  ,
            true  ,
            (st_16.[share].[slots] :<
              (((st_16.(share)).(slots)) #
                SLOT_RTT ==
                (((((GRANULES_BASE + (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
          )))
        else (
          (Some (
            false  ,
            false  ,
            (st_16.[share].[slots] :<
              (((st_16.(share)).(slots)) #
                SLOT_RTT ==
                (((((GRANULES_BASE + (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
          )))
      ) with
      | (Some (__return___0, __retval___0, st_1)) =>
        if __return___0
        then (Some (true, __retval___0, st_1))
        else (Some (false, __retval___0, st_1))
      | None => None
      end)
    else (
      (Some (
        false  ,
        false  ,
        (st_16.[share].[slots] :<
          (((st_16.(share)).(slots)) #
            SLOT_RTT ==
            (((((GRANULES_BASE + (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
      )))
  ) with
  | (Some (__return__, __retval__, st_1)) =>
    if __return__
    then (Some (__retval__, (mkPtr "slot_rtt" ((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE))), st_1))
    else (Some (false, (mkPtr "slot_rtt" ((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE))), st_1))
  | None => None
  end.

Definition map_unmap_ns_2 (v_s2_ctx: Ptr) (v_call1_0: Ptr) (v_2_tmp: Z) (v_call: Ptr) (v_call6_1: Z) (v_call7_1: Z) (v_map_addr: Z) (v_level: Z) (v_wi: Ptr) (st_9: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_call1_0.(poffset)) = (0)));
  rely ((((v_2_tmp - (STACK_VIRT)) < (0)) /\ (((v_2_tmp - (GRANULES_BASE)) >= (0)))));
  rely (((v_call.(pbase)) = ("granules")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((((((st_9.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) - (6)) = (0)));
  rely ((((v_2_tmp - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
  when st1 == ((query_oracle (st_9.[stack].[stack_s2_ctx] :< (((((st_9.(share)).(granule_data)) @ (((st_9.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)))));
  match (((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    rely (
      ((((((st_9.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
        (((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)))) =
        (0)));
    when cid == (
        (((((st1.(share)).(granules)) #
          ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
          ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
    when st_15 == (
        (rtt_walk_lock_unlock_spec
          (mkPtr "granules" (v_2_tmp - (GRANULES_BASE)))
          v_call6_1
          v_call7_1
          v_map_addr
          v_level
          v_wi
          ((st1.[log] :<
            ((EVT
              CPU_ID
              (REL
                ((v_call.(poffset)) / (ST_GRANULE_SIZE))
                ((((st1.(share)).(granules)) #
                  ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                  ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))))) ::
              (((EVT CPU_ID (ACQ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
            ((((st1.(share)).(granules)) #
              ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) #
              ((v_call.(poffset)) / (ST_GRANULE_SIZE)) ==
              (((((st1.(share)).(granules)) #
                ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :<
                None)))));
    (Some ((((st_15.(stack)).(stack_wi)).(e_last_level)), st_15))
  | (Some cid) => None
  end.

Definition map_unmap_ns_4 (v_host_s2tte: Z) (v_level: Z) (v_wi: Ptr) (v_call18: Ptr) (st_0: RData) (st_21: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call18.(pbase)) = ("slot_rtt")));
  if (v_level =? (3))
  then (
    when cid == (((((st_21.(share)).(granules)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
    rely (
      ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
    rely ((true /\ ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    when cid_0 == (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
    then None
    else (
      if (
        ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
          (((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =?
            (0)))))
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        (Some (
          0  ,
          (((st_21.[log] :<
            ((EVT
              CPU_ID
              (REL
                (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                  (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
              (((EVT
                CPU_ID
                (REC_REF
                  ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                  (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) ::
                ((st_21.(log))))))).[share].[granule_data] :<
            (((st_21.(share)).(granule_data)) #
              (((st_21.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                  (v_host_s2tte |' (54043195528446979)))))).[share].[granules] :<
            (((st_21.(share)).(granules)) #
              ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
              (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
        )))
      else (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        (Some (
          0  ,
          (((st_21.[log] :<
            ((EVT
              CPU_ID
              (REL
                (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                  (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
              ((st_21.(log))))).[share].[granule_data] :<
            (((st_21.(share)).(granule_data)) #
              (((st_21.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                  (v_host_s2tte |' (54043195528446979)))))).[share].[granules] :<
            (((st_21.(share)).(granules)) #
              ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
              (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
        )))))
  else (
    when cid == (((((st_21.(share)).(granules)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
    rely (
      ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
    rely ((true /\ ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    when cid_0 == (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
    then None
    else (
      if (
        ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
          (((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =?
            (0)))))
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        (Some (
          0  ,
          (((st_21.[log] :<
            ((EVT
              CPU_ID
              (REL
                (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                  (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
              (((EVT
                CPU_ID
                (REC_REF
                  ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                  (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) ::
                ((st_21.(log))))))).[share].[granule_data] :<
            (((st_21.(share)).(granule_data)) #
              (((st_21.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                  (v_host_s2tte |' (54043195528446977)))))).[share].[granules] :<
            (((st_21.(share)).(granules)) #
              ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
              (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
        )))
      else (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        (Some (
          0  ,
          (((st_21.[log] :<
            ((EVT
              CPU_ID
              (REL
                (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                  (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
              ((st_21.(log))))).[share].[granule_data] :<
            (((st_21.(share)).(granule_data)) #
              (((st_21.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                  (v_host_s2tte |' (54043195528446977)))))).[share].[granules] :<
            (((st_21.(share)).(granules)) #
              ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
              (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
        ))))).

Definition map_unmap_ns_5 (v_level: Z) (v_call18: Ptr) (v_wi: Ptr) (st_0: RData) (st_21: RData) : (option (Z * RData)) :=
  rely (((v_call18.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
      ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
  when cid == (((((st_21.(share)).(granules)) @ (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  (Some (
    (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
    ((st_21.[log] :<
      ((EVT
        CPU_ID
        (REL
          (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
          (((st_21.(share)).(granules)) @ (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
        ((st_21.(log))))).[share].[granules] :<
      (((st_21.(share)).(granules)) #
        (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
        ((((st_21.(share)).(granules)) @ (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
  )).

Definition map_unmap_ns_6 (v_4: Z) (v_wi: Ptr) (st_0: RData) (st_16: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (
    ((((((st_16.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
      ((((((st_16.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
  when cid == (((((st_16.(share)).(granules)) @ (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  (Some (
    (((((v_4 << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_4 << (32)) + (4)) & (4294967295))))  ,
    ((st_16.[log] :<
      ((EVT
        CPU_ID
        (REL
          (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
          (((st_16.(share)).(granules)) @ (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
        ((st_16.(log))))).[share].[granules] :<
      (((st_16.(share)).(granules)) #
        (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
        ((((st_16.(share)).(granules)) @ (((((st_16.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
  )).

Definition map_unmap_ns_1 (v_call1_0: Ptr) (v_map_addr: Z) (v_call: Ptr) (v_s2_ctx: Ptr) (v_2_tmp: Z) (v_level: Z) (v_host_s2tte: Z) (v_call6_1: Z) (v_call7_1: Z) (v_wi: Ptr) (st_0: RData) (st_8: RData) : (option (Z * RData)) :=
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_call.(pbase)) = ("granules")));
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely ((((v_2_tmp - (STACK_VIRT)) < (0)) /\ (((v_2_tmp - (GRANULES_BASE)) >= (0)))));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely ((((((st_8.(share)).(granules)) @ (((st_8.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))));
  rely (((v_call1_0.(poffset)) = (0)));
  if ((((1 << (((((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_map_addr)) >? (0))
  then (
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when cid == (((((st_8.(share)).(granules)) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
    (Some (
      1  ,
      ((st_8.[log] :<
        ((EVT CPU_ID (REL ((v_call.(poffset)) / (ST_GRANULE_SIZE)) (((st_8.(share)).(granules)) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))))) :: ((st_8.(log))))).[share].[granules] :<
        (((st_8.(share)).(granules)) #
          ((v_call.(poffset)) / (ST_GRANULE_SIZE)) ==
          ((((st_8.(share)).(granules)) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
    )))
  else (
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((((((st_8.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) - (6)) = (0)));
    rely ((((v_2_tmp - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
    when st1 == ((query_oracle (st_8.[stack].[stack_s2_ctx] :< (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)))));
    match (((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | None =>
      rely (
        ((((((st_8.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
          (((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)))) =
          (0)));
      when cid == (
          (((((st1.(share)).(granules)) #
            ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
            ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
      when st_15 == (
          (rtt_walk_lock_unlock_spec
            (mkPtr "granules" (v_2_tmp - (GRANULES_BASE)))
            v_call6_1
            v_call7_1
            v_map_addr
            v_level
            v_wi
            ((st1.[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((v_call.(poffset)) / (ST_GRANULE_SIZE))
                  ((((st1.(share)).(granules)) #
                    ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))))) ::
                (((EVT CPU_ID (ACQ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
              ((((st1.(share)).(granules)) #
                ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) #
                ((v_call.(poffset)) / (ST_GRANULE_SIZE)) ==
                (((((st1.(share)).(granules)) #
                  ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                  ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  None)))));
      if (((((st_15.(stack)).(stack_wi)).(e_last_level)) - (v_level)) =? (0))
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
        match (
          match (
            if (
              (((((((st_15.(share)).(granule_data)) @
                ((((st_15.(share)).(slots)) #
                  SLOT_RTT ==
                  (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                (3)) =?
                (0)))
            then (
              match (
                if (
                  (((((((st_15.(share)).(granule_data)) @
                    ((((st_15.(share)).(slots)) #
                      SLOT_RTT ==
                      (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                    (60)) =?
                    (0)))
                then (
                  (Some (
                    true  ,
                    true  ,
                    (st_15.[share].[slots] :<
                      (((st_15.(share)).(slots)) #
                        SLOT_RTT ==
                        (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                  )))
                else (
                  (Some (
                    false  ,
                    false  ,
                    (st_15.[share].[slots] :<
                      (((st_15.(share)).(slots)) #
                        SLOT_RTT ==
                        (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                  )))
              ) with
              | (Some (__return___0, __retval___0, st_1)) =>
                if __return___0
                then (Some (true, __retval___0, st_1))
                else (Some (false, __retval___0, st_1))
              | None => None
              end)
            else (
              (Some (
                false  ,
                false  ,
                (st_15.[share].[slots] :<
                  (((st_15.(share)).(slots)) #
                    SLOT_RTT ==
                    (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
              )))
          ) with
          | (Some (__return__, __retval__, st_1)) =>
            if __return__
            then (Some (__retval__, (mkPtr "slot_rtt" ((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE))), st_1))
            else (Some (false, (mkPtr "slot_rtt" ((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE))), st_1))
          | None => None
          end
        ) with
        | (Some (v_call23, v_call18, st_21)) =>
          if v_call23
          then (
            if (v_level =? (3))
            then (
              when cid_1 == (((((st_21.(share)).(granules)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
              rely (
                ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                  ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
              rely ((true /\ ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
              when cid_2 == (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
              if ((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
              then None
              else (
                if (
                  ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                    (((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =?
                      (0)))))
                then (
                  (Some (
                    0  ,
                    (((st_21.[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                          ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                            (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
                        (((EVT
                          CPU_ID
                          (REC_REF
                            ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                            (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) ::
                          ((st_21.(log))))))).[share].[granule_data] :<
                      (((st_21.(share)).(granule_data)) #
                        (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                        ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                          (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                            ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                            (v_host_s2tte |' (54043195528446979)))))).[share].[granules] :<
                      (((st_21.(share)).(granules)) #
                        ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                          (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
                  )))
                else (
                  (Some (
                    0  ,
                    (((st_21.[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                          ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                            (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
                        ((st_21.(log))))).[share].[granule_data] :<
                      (((st_21.(share)).(granule_data)) #
                        (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                        ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                          (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                            ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                            (v_host_s2tte |' (54043195528446979)))))).[share].[granules] :<
                      (((st_21.(share)).(granules)) #
                        ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                          (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
                  )))))
            else (
              when cid_1 == (((((st_21.(share)).(granules)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
              rely (
                ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                  ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
              rely ((true /\ ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
              when cid_2 == (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
              if ((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
              then None
              else (
                if (
                  ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                    (((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =?
                      (0)))))
                then (
                  (Some (
                    0  ,
                    (((st_21.[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                          ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                            (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
                        (((EVT
                          CPU_ID
                          (REC_REF
                            ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                            (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) ::
                          ((st_21.(log))))))).[share].[granule_data] :<
                      (((st_21.(share)).(granule_data)) #
                        (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                        ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                          (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                            ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                            (v_host_s2tte |' (54043195528446977)))))).[share].[granules] :<
                      (((st_21.(share)).(granules)) #
                        ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                          (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
                  )))
                else (
                  (Some (
                    0  ,
                    (((st_21.[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                          ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                            (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
                        ((st_21.(log))))).[share].[granule_data] :<
                      (((st_21.(share)).(granule_data)) #
                        (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                        ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                          (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                            ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                            (v_host_s2tte |' (54043195528446977)))))).[share].[granules] :<
                      (((st_21.(share)).(granules)) #
                        ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                          (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
                  ))))))
          else (
            rely (((v_call18.(pbase)) = ("slot_rtt")));
            rely (
              ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
            when cid_1 == (((((st_21.(share)).(granules)) @ (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (Some (
              (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
              ((st_21.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                    (((st_21.(share)).(granules)) @ (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                  ((st_21.(log))))).[share].[granules] :<
                (((st_21.(share)).(granules)) #
                  (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                  ((((st_21.(share)).(granules)) @ (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
            )))
        | None => None
        end)
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
    end).

Definition map_unmap_ns_7 (v_call1_0: Ptr) (v_map_addr: Z) (v_call: Ptr) (v_s2_ctx: Ptr) (v_2_tmp: Z) (v_level: Z) (v_host_s2tte: Z) (v_call6_1: Z) (v_call7_1: Z) (v_wi: Ptr) (st_0: RData) (st_8: RData) : (option (Z * RData)) :=
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_call.(pbase)) = ("granules")));
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely ((((v_2_tmp - (STACK_VIRT)) < (0)) /\ (((v_2_tmp - (GRANULES_BASE)) >= (0)))));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call1_0.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((((((st_8.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) - (6)) = (0)));
  rely ((((v_2_tmp - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
  when st1 == ((query_oracle (st_8.[stack].[stack_s2_ctx] :< (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)))));
  match (((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    rely (
      ((((((st_8.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
        (((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)))) =
        (0)));
    when cid == (
        (((((st1.(share)).(granules)) #
          ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
          ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
    when st_15 == (
        (rtt_walk_lock_unlock_spec
          (mkPtr "granules" (v_2_tmp - (GRANULES_BASE)))
          v_call6_1
          v_call7_1
          v_map_addr
          v_level
          v_wi
          ((st1.[log] :<
            ((EVT
              CPU_ID
              (REL
                ((v_call.(poffset)) / (ST_GRANULE_SIZE))
                ((((st1.(share)).(granules)) #
                  ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                  ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))))) ::
              (((EVT CPU_ID (ACQ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
            ((((st1.(share)).(granules)) #
              ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) #
              ((v_call.(poffset)) / (ST_GRANULE_SIZE)) ==
              (((((st1.(share)).(granules)) #
                ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                ((((st1.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :<
                None)))));
    if (((((st_15.(stack)).(stack_wi)).(e_last_level)) - (v_level)) =? (0))
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
      match (
        if (
          ((((((((st_15.(share)).(granule_data)) @
            ((((st_15.(share)).(slots)) #
              SLOT_RTT ==
              (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
            (36028797018963968)) -
            (36028797018963968)) =?
            (0)))
        then (
          match (
            if (
              ((v_level =? (3)) &&
                ((((((((st_15.(share)).(granule_data)) @
                  ((((st_15.(share)).(slots)) #
                    SLOT_RTT ==
                    (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                  (3)) =?
                  (3)))))
            then (
              (Some (
                false  ,
                false  ,
                (st_15.[share].[slots] :<
                  (((st_15.(share)).(slots)) #
                    SLOT_RTT ==
                    (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
              )))
            else (
              match (
                if (
                  ((v_level =? (2)) &&
                    ((((((((st_15.(share)).(granule_data)) @
                      ((((st_15.(share)).(slots)) #
                        SLOT_RTT ==
                        (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                      (3)) =?
                      (1)))))
                then (
                  (Some (
                    false  ,
                    false  ,
                    (st_15.[share].[slots] :<
                      (((st_15.(share)).(slots)) #
                        SLOT_RTT ==
                        (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                  )))
                else (
                  (Some (
                    true  ,
                    false  ,
                    (st_15.[share].[slots] :<
                      (((st_15.(share)).(slots)) #
                        SLOT_RTT ==
                        (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                  )))
              ) with
              | (Some (return___1, retval___1, st_1)) =>
                if return___1
                then (Some (true, retval___1, st_1))
                else (Some (false, retval___1, st_1))
              | None => None
              end)
          ) with
          | (Some (__return___0, __retval___0, st_1)) =>
            if __return___0
            then (Some (true, __retval___0, st_1))
            else (Some (true, true, st_1))
          | None => None
          end)
        else (
          (Some (
            true  ,
            false  ,
            (st_15.[share].[slots] :<
              (((st_15.(share)).(slots)) #
                SLOT_RTT ==
                (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
          )))
      ) with
      | (Some (__return__, __retval__, st_1)) =>
        if __return__
        then (
          if __retval__
          then (
            when cid_1 == (((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
            rely (
              ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
            rely ((true /\ ((((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
            when cid_2 == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
            if ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
            then None
            else (
              if (
                ((((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                  (((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =? (0)))))
              then (
                if (v_level =? (3))
                then (
                  when cid_3 == (
                      (((((st_1.(share)).(granules)) #
                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    0  ,
                    (((st_1.[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                          ((((st_1.(share)).(granules)) #
                            ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                            ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                              (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        (((EVT
                          CPU_ID
                          (REC_REF
                            ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                            (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) ::
                          ((st_1.(log))))))).[share].[granule_data] :<
                      (((st_1.(share)).(granule_data)) #
                        (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                        ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                          (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                            (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                            0)))).[share].[granules] :<
                      ((((st_1.(share)).(granules)) #
                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) #
                        (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        (((((st_1.(share)).(granules)) #
                          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                          ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                            (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                          None)))
                  )))
                else (
                  when cid_3 == (
                      (((((st_1.(share)).(granules)) #
                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    0  ,
                    (((st_1.[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                          ((((st_1.(share)).(granules)) #
                            ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                            ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                              (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        (((EVT
                          CPU_ID
                          (REC_REF
                            ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                            (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) ::
                          ((st_1.(log))))))).[share].[granule_data] :<
                      (((st_1.(share)).(granule_data)) #
                        (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                        ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                          (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                            (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                            0)))).[share].[granules] :<
                      ((((st_1.(share)).(granules)) #
                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) #
                        (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        (((((st_1.(share)).(granules)) #
                          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                          ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                            (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                          None)))
                  ))))
              else (
                if (v_level =? (3))
                then (
                  when cid_3 == (
                      (((((st_1.(share)).(granules)) #
                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    0  ,
                    (((st_1.[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                          ((((st_1.(share)).(granules)) #
                            ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                            ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                              (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_1.(log))))).[share].[granule_data] :<
                      (((st_1.(share)).(granule_data)) #
                        (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                        ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                          (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                            (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                            0)))).[share].[granules] :<
                      ((((st_1.(share)).(granules)) #
                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) #
                        (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        (((((st_1.(share)).(granules)) #
                          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                          ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                            (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                          None)))
                  )))
                else (
                  when cid_3 == (
                      (((((st_1.(share)).(granules)) #
                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    0  ,
                    (((st_1.[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                          ((((st_1.(share)).(granules)) #
                            ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                            ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                              (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_1.(log))))).[share].[granule_data] :<
                      (((st_1.(share)).(granule_data)) #
                        (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                        ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                          (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                            (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                            0)))).[share].[granules] :<
                      ((((st_1.(share)).(granules)) #
                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) #
                        (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        (((((st_1.(share)).(granules)) #
                          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                          ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                            (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                          None)))
                  ))))))
          else (
            rely (
              ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
            when cid_1 == (((((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (Some (
              (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
              ((st_1.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                    (((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                  ((st_1.(log))))).[share].[granules] :<
                (((st_1.(share)).(granules)) #
                  (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                  ((((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
            ))))
        else None
      | None => None
      end)
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
  end.

Definition map_unmap_ns_spec (v_rd_addr: Z) (v_map_addr: Z) (v_level: Z) (v_host_s2tte: Z) (v_op: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
    if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
      rely (((((((st.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) - (2)) = (0)));
      when st1 == ((query_oracle st));
      match (((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock))) with
      | None =>
        rely (
          ((((((st.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)) -
            (((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_state)))) =
            (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        if (((v_level + ((- 4))) - ((- 2))) <? (0))
        then (
          (Some (
            1  ,
            (((st1.[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                  ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
              (((st1.(share)).(granules)) #
                ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
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
              ((((v_map_addr & (281474976710655)) & (((- 1) << (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) - (v_map_addr)) =?
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
              if (v_op =? (0))
              then (
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
                  (Some (
                    1  ,
                    (((st1.[log] :<
                      ((EVT
                        CPU_ID
                        (REL
                          ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                          ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                        (((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
                      (((st1.(share)).(granules)) #
                        ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                        ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
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
                      (query_oracle
                        ((((st1.[log] :< ((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))).[share].[granules] :<
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
                      ((((((st1.(share)).(granules)) @
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
                    when cid == (((((st1_0.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
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
                          v_level
                          (mkPtr "stack_wi" 0)
                          ((st1_0.[log] :<
                            ((EVT
                              CPU_ID
                              (REL ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) (((st1_0.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))))) ::
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
                              ((((st1_0.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None)))));
                    if (((((st_15.(stack)).(stack_wi)).(e_last_level)) - (v_level)) =? (0))
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
                      match (
                        match (
                          if (
                            (((((((st_15.(share)).(granule_data)) @
                              ((((st_15.(share)).(slots)) #
                                SLOT_RTT ==
                                (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                              (3)) =?
                              (0)))
                          then (
                            match (
                              if (
                                (((((((st_15.(share)).(granule_data)) @
                                  ((((st_15.(share)).(slots)) #
                                    SLOT_RTT ==
                                    (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                                  (60)) =?
                                  (0)))
                              then (
                                (Some (
                                  true  ,
                                  true  ,
                                  (st_15.[share].[slots] :<
                                    (((st_15.(share)).(slots)) #
                                      SLOT_RTT ==
                                      (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                                )))
                              else (
                                (Some (
                                  false  ,
                                  false  ,
                                  (st_15.[share].[slots] :<
                                    (((st_15.(share)).(slots)) #
                                      SLOT_RTT ==
                                      (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                                )))
                            ) with
                            | (Some (__return___0, __retval___0, st_1)) =>
                              if __return___0
                              then (Some (true, __retval___0, st_1))
                              else (Some (false, __retval___0, st_1))
                            | None => None
                            end)
                          else (
                            (Some (
                              false  ,
                              false  ,
                              (st_15.[share].[slots] :<
                                (((st_15.(share)).(slots)) #
                                  SLOT_RTT ==
                                  (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                            )))
                        ) with
                        | (Some (__return__, __retval__, st_1)) =>
                          if __return__
                          then (Some (__retval__, (mkPtr "slot_rtt" ((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE))), st_1))
                          else (Some (false, (mkPtr "slot_rtt" ((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE))), st_1))
                        | None => None
                        end
                      ) with
                      | (Some (v_call23, v_call18, st_21)) =>
                        if v_call23
                        then (
                          if (v_level =? (3))
                          then (
                            when cid_1 == (((((st_21.(share)).(granules)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
                            rely (
                              ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                                ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
                            rely ((true /\ ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                            when cid_2 == (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                            if ((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
                            then None
                            else (
                              if (
                                ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                                  (((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =?
                                    (0)))))
                              then (
                                (Some (
                                  0  ,
                                  (((st_21.[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                        ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                          (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REC_REF
                                          ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                                          (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) ::
                                        ((st_21.(log))))))).[share].[granule_data] :<
                                    (((st_21.(share)).(granule_data)) #
                                      (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                                          (v_host_s2tte |' (54043195528446979)))))).[share].[granules] :<
                                    (((st_21.(share)).(granules)) #
                                      ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                      (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                                        (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
                                )))
                              else (
                                (Some (
                                  0  ,
                                  (((st_21.[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                        ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                          (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
                                      ((st_21.(log))))).[share].[granule_data] :<
                                    (((st_21.(share)).(granule_data)) #
                                      (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                                          (v_host_s2tte |' (54043195528446979)))))).[share].[granules] :<
                                    (((st_21.(share)).(granules)) #
                                      ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                      (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                                        (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
                                )))))
                          else (
                            when cid_1 == (((((st_21.(share)).(granules)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
                            rely (
                              ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                                ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
                            rely ((true /\ ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                            when cid_2 == (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                            if ((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
                            then None
                            else (
                              if (
                                ((((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                                  (((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =?
                                    (0)))))
                              then (
                                (Some (
                                  0  ,
                                  (((st_21.[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                        ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                          (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REC_REF
                                          ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                                          (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))) ::
                                        ((st_21.(log))))))).[share].[granule_data] :<
                                    (((st_21.(share)).(granule_data)) #
                                      (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                                          (v_host_s2tte |' (54043195528446977)))))).[share].[granules] :<
                                    (((st_21.(share)).(granules)) #
                                      ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                      (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                                        (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
                                )))
                              else (
                                (Some (
                                  0  ,
                                  (((st_21.[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                        ((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                          (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1))))) ::
                                      ((st_21.(log))))).[share].[granule_data] :<
                                    (((st_21.(share)).(granule_data)) #
                                      (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(stack_wi)).(e_index)))))) ==
                                          (v_host_s2tte |' (54043195528446977)))))).[share].[granules] :<
                                    (((st_21.(share)).(granules)) #
                                      ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                      (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                                        (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)))))
                                ))))))
                        else (
                          rely (((v_call18.(pbase)) = ("slot_rtt")));
                          rely (
                            ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                              ((((((st_21.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
                          when cid_1 == (((((st_21.(share)).(granules)) @ (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                          (Some (
                            (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
                            ((st_21.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                  (((st_21.(share)).(granules)) @ (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                ((st_21.(log))))).[share].[granules] :<
                              (((st_21.(share)).(granules)) #
                                (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                ((((st_21.(share)).(granules)) @ (((((st_21.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
                          )))
                      | None => None
                      end)
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
                    (query_oracle
                      ((((st1.[log] :< ((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))).[share].[granules] :<
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
                    ((((((st1.(share)).(granules)) @
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
                  when cid == (((((st1_0.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
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
                        v_level
                        (mkPtr "stack_wi" 0)
                        ((st1_0.[log] :<
                          ((EVT
                            CPU_ID
                            (REL ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) (((st1_0.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))))) ::
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
                            ((((st1_0.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None)))));
                  if (((((st_15.(stack)).(stack_wi)).(e_last_level)) - (v_level)) =? (0))
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
                    match (
                      if (
                        ((((((((st_15.(share)).(granule_data)) @
                          ((((st_15.(share)).(slots)) #
                            SLOT_RTT ==
                            (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                          (36028797018963968)) -
                          (36028797018963968)) =?
                          (0)))
                      then (
                        match (
                          if (
                            ((v_level =? (3)) &&
                              ((((((((st_15.(share)).(granule_data)) @
                                ((((st_15.(share)).(slots)) #
                                  SLOT_RTT ==
                                  (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                                (3)) =?
                                (3)))))
                          then (
                            (Some (
                              false  ,
                              false  ,
                              (st_15.[share].[slots] :<
                                (((st_15.(share)).(slots)) #
                                  SLOT_RTT ==
                                  (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                            )))
                          else (
                            match (
                              if (
                                ((v_level =? (2)) &&
                                  ((((((((st_15.(share)).(granule_data)) @
                                    ((((st_15.(share)).(slots)) #
                                      SLOT_RTT ==
                                      (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_15.(stack)).(stack_wi)).(e_index))))))) &
                                    (3)) =?
                                    (1)))))
                              then (
                                (Some (
                                  false  ,
                                  false  ,
                                  (st_15.[share].[slots] :<
                                    (((st_15.(share)).(slots)) #
                                      SLOT_RTT ==
                                      (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                                )))
                              else (
                                (Some (
                                  true  ,
                                  false  ,
                                  (st_15.[share].[slots] :<
                                    (((st_15.(share)).(slots)) #
                                      SLOT_RTT ==
                                      (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                                )))
                            ) with
                            | (Some (return___1, retval___1, st_1)) =>
                              if return___1
                              then (Some (true, retval___1, st_1))
                              else (Some (false, retval___1, st_1))
                            | None => None
                            end)
                        ) with
                        | (Some (__return___0, __retval___0, st_1)) =>
                          if __return___0
                          then (Some (true, __retval___0, st_1))
                          else (Some (true, true, st_1))
                        | None => None
                        end)
                      else (
                        (Some (
                          true  ,
                          false  ,
                          (st_15.[share].[slots] :<
                            (((st_15.(share)).(slots)) #
                              SLOT_RTT ==
                              (((((GRANULES_BASE + (((((st_15.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
                        )))
                    ) with
                    | (Some (__return__, __retval__, st_1)) =>
                      if __return__
                      then (
                        if __retval__
                        then (
                          when cid_1 == (((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
                          rely (
                            ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                              ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
                          rely ((true /\ ((((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                          when cid_2 == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                          if ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                          then None
                          else (
                            if (
                              ((((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                                (((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =? (0)))))
                            then (
                              if (v_level =? (3))
                              then (
                                (Some (
                                  0  ,
                                  (((st_1.[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1)))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REC_REF
                                          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) ::
                                        ((st_1.(log))))))).[share].[granule_data] :<
                                    (((st_1.(share)).(granule_data)) #
                                      (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                                          0)))).[share].[granules] :<
                                    (((st_1.(share)).(granules)) #
                                      ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                      (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                                        (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))))
                                )))
                              else (
                                when cid_3 == (
                                    (((((st_1.(share)).(granules)) #
                                      ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                      ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                        (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                                (Some (
                                  0  ,
                                  (((st_1.[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                        ((((st_1.(share)).(granules)) #
                                          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                          ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                            (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                      (((EVT
                                        CPU_ID
                                        (REC_REF
                                          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))
                                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) ::
                                        ((st_1.(log))))))).[share].[granule_data] :<
                                    (((st_1.(share)).(granule_data)) #
                                      (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                                          0)))).[share].[granules] :<
                                    ((((st_1.(share)).(granules)) #
                                      ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                      ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                        (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) #
                                      (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                      (((((st_1.(share)).(granules)) #
                                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                                        None)))
                                ))))
                            else (
                              if (v_level =? (3))
                              then (
                                (Some (
                                  0  ,
                                  (((st_1.[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1)))))) ::
                                      ((st_1.(log))))).[share].[granule_data] :<
                                    (((st_1.(share)).(granule_data)) #
                                      (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                                          0)))).[share].[granules] :<
                                    (((st_1.(share)).(granules)) #
                                      ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                      (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_refcount] :<
                                        (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))))
                                )))
                              else (
                                when cid_3 == (
                                    (((((st_1.(share)).(granules)) #
                                      ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                      ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                        (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                                (Some (
                                  0  ,
                                  (((st_1.[log] :<
                                    ((EVT
                                      CPU_ID
                                      (REL
                                        (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                        ((((st_1.(share)).(granules)) #
                                          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                          ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                            (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                      ((st_1.(log))))).[share].[granule_data] :<
                                    (((st_1.(share)).(granule_data)) #
                                      (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                                          0)))).[share].[granules] :<
                                    ((((st_1.(share)).(granules)) #
                                      ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                      ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                        (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) #
                                      (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                      (((((st_1.(share)).(granules)) #
                                        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) ==
                                        ((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
                                          (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                                        None)))
                                ))))))
                        else (
                          rely (
                            ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                              ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - ((GRANULES_BASE + ((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)))))) < (0)))));
                          when cid_1 == (((((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                          (Some (
                            (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
                            ((st_1.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))
                                  (((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                                ((st_1.(log))))).[share].[granules] :<
                              (((st_1.(share)).(granules)) #
                                (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                                ((((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
                          ))))
                      else None
                    | None => None
                    end)
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
              (Some (
                1  ,
                (((st1.[log] :<
                  ((EVT
                    CPU_ID
                    (REL
                      ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                      ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                    (((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
                  (((st1.(share)).(granules)) #
                    ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                    ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                  (((st1.(share)).(slots)) #
                    SLOT_RD ==
                    (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
              ))))
          else (
            (Some (
              1  ,
              (((st1.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))
                    ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)))) :: ((st1.(log))))))).[share].[granules] :<
                (((st1.(share)).(granules)) #
                  ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE)) ==
                  ((((st1.(share)).(granules)) @ ((16 * ((v_rd_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                (((st1.(share)).(slots)) #
                  SLOT_RD ==
                  (((((GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE)))))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
            ))))
      | (Some cid) => None
      end))
  else (Some (1, st)).

