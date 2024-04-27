Definition data_create_1 (v_data_addr: Z) (v_wi: Ptr) (v_call14: Ptr) (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (st_0: RData) (st_20: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("data_create_stack")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("data_create_stack")));
  rely (((v_g_data.(pbase)) = ("data_create_stack")));
  when cid == (((((st_20.(share)).(granules)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  rely (
    ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
  if (
    if (
      ((((((st_20.(share)).(granules)) @ ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
        (GRANULE_STATE_RD)) =?
        (0)))
    then true
    else (
      match (((((st_20.(share)).(granules)) @ ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
      | (Some cid_0) => true
      | None => false
      end))
  then (
    when cid_0 == (((((st_20.(share)).(granules)) @ ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
    if (
      ((((((st_20.(share)).(granules)) @ ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) + (1)) <?
        (0)))
    then None
    else (
      if (
        ((((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
          (((((((st_20.(share)).(granules)) @ ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
            (GRANULE_STATE_REC)) =?
            (0)))))
      then (
        rely (((v_call14.(poffset)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (
          (((((((lens 10601 st_20).(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 10601 st_20).(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely (((v_call1_0.(poffset)) = (0)));
        rely (
          (((((((lens 10605 st_20).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 10605 st_20).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely (
          (((((((lens 10608 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 10608 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((((((lens 10608 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
        if (
          match ((((((lens 10608 st_20).(share)).(granules)) @ (((((((lens 10608 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
          | (Some cid_1) => true
          | None => false
          end)
        then (
          (Some (
            0  ,
            (((lens 10797 st_20).[share].[granule_data] :<
              (((st_20.(share)).(granule_data)) #
                (((st_20.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call14.(poffset)) + ((8 * ((((st_20.(stack)).(data_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                    (v_data_addr |' (4)))))).[share].[slots] :<
              ((((st_20.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
          )))
        else None)
      else (
        rely (((v_call14.(poffset)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (
          (((((((lens 10602 st_20).(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 10602 st_20).(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely (((v_call1_0.(poffset)) = (0)));
        rely (
          (((((((lens 10806 st_20).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 10806 st_20).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely (
          (((((((lens 10809 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 10809 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((((((lens 10809 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
        if (
          match ((((((lens 10809 st_20).(share)).(granules)) @ (((((((lens 10809 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
          | (Some cid_1) => true
          | None => false
          end)
        then (
          (Some (
            0  ,
            (((lens 10998 st_20).[share].[granule_data] :<
              (((st_20.(share)).(granule_data)) #
                (((st_20.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call14.(poffset)) + ((8 * ((((st_20.(stack)).(data_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                    (v_data_addr |' (4)))))).[share].[slots] :<
              ((((st_20.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
          )))
        else None)))
  else None.

Definition data_create_2 (v_data_addr: Z) (v_wi: Ptr) (v_call14: Ptr) (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (st_0: RData) (st_20: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("data_create_stack")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("data_create_stack")));
  rely (((v_g_data.(pbase)) = ("data_create_stack")));
  when cid == (((((st_20.(share)).(granules)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  rely (
    ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
  if (
    if (
      ((((((st_20.(share)).(granules)) @ ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
        (GRANULE_STATE_RD)) =?
        (0)))
    then true
    else (
      match (((((st_20.(share)).(granules)) @ ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
      | (Some cid_0) => true
      | None => false
      end))
  then (
    when cid_0 == (((((st_20.(share)).(granules)) @ ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
    if (
      ((((((st_20.(share)).(granules)) @ ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) + (1)) <?
        (0)))
    then None
    else (
      if (
        ((((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
          (((((((st_20.(share)).(granules)) @ ((((((st_20.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
            (GRANULE_STATE_REC)) =?
            (0)))))
      then (
        rely (((v_call14.(poffset)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (
          (((((((lens 10999 st_20).(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 10999 st_20).(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely (((v_call1_0.(poffset)) = (0)));
        rely (
          (((((((lens 11003 st_20).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 11003 st_20).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely (
          (((((((lens 11006 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 11006 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((((((lens 11006 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
        if (
          match ((((((lens 11006 st_20).(share)).(granules)) @ (((((((lens 11006 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
          | (Some cid_1) => true
          | None => false
          end)
        then (
          (Some (
            0  ,
            (((lens 11195 st_20).[share].[granule_data] :<
              (((st_20.(share)).(granule_data)) #
                (((st_20.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call14.(poffset)) + ((8 * ((((st_20.(stack)).(data_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                    (v_data_addr |' (2011)))))).[share].[slots] :<
              ((((st_20.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
          )))
        else None)
      else (
        rely (((v_call14.(poffset)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (
          (((((((lens 11000 st_20).(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 11000 st_20).(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely (((v_call1_0.(poffset)) = (0)));
        rely (
          (((((((lens 11204 st_20).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 11204 st_20).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely (
          (((((((lens 11207 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 11207 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((((((lens 11207 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
        if (
          match ((((((lens 11207 st_20).(share)).(granules)) @ (((((((lens 11207 st_20).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
          | (Some cid_1) => true
          | None => false
          end)
        then (
          (Some (
            0  ,
            (((lens 11396 st_20).[share].[granule_data] :<
              (((st_20.(share)).(granule_data)) #
                (((st_20.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call14.(poffset)) + ((8 * ((((st_20.(stack)).(data_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                    (v_data_addr |' (2011)))))).[share].[slots] :<
              ((((st_20.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
          )))
        else None)))
  else None.

Definition data_create_3 (v_call14: Ptr) (v_wi: Ptr) (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (st_0: RData) (st_19: RData) : (option (Z * RData)) :=
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("data_create_stack")));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("data_create_stack")));
  rely (((v_g_data.(pbase)) = ("data_create_stack")));
  rely (((v_call14.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    ((((((st_19.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_19.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_19.(share)).(granules)) @ (((((st_19.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call1_0.(poffset)) = (0)));
  rely (
    (((((((lens 11397 st_19).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 11397 st_19).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely (
    (((((((lens 11399 st_19).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 11399 st_19).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((((((lens 11399 st_19).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match ((((((lens 11399 st_19).(share)).(granules)) @ (((((((lens 11399 st_19).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
    | (Some cid_0) => true
    | None => false
    end)
  then (
    (Some (
      (((((3 << (32)) + (4)) >> (24)) & (4294967040)) |' ((((3 << (32)) + (4)) & (4294967295))))  ,
      ((lens 11539 st_19).[share].[slots] :< ((((st_19.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
    )))
  else None.

Definition data_create_4 (v_4: Z) (v_wi: Ptr) (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (st_0: RData) (st_14: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("data_create_stack")));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("data_create_stack")));
  rely (((v_g_data.(pbase)) = ("data_create_stack")));
  rely (
    ((((((st_14.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_14.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(data_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call1_0.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    (((((((lens 1131 st_14).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 1131 st_14).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely (
    (((((((lens 11547 st_14).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 11547 st_14).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((((((lens 11547 st_14).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match ((((((lens 11547 st_14).(share)).(granules)) @ (((((((lens 11547 st_14).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
    | (Some cid_0) => true
    | None => false
    end)
  then (
    (Some (
      (((((v_4 << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_4 << (32)) + (4)) & (4294967295))))  ,
      ((lens 11687 st_14).[share].[slots] :< (((st_14.(share)).(slots)) # SLOT_RD == (- 1)))
    )))
  else None.

Definition data_create_5 (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (v_call3: Z) (st_0: RData) (st_7: RData) : (option (Z * RData)) :=
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("data_create_stack")));
  rely (((v_g_data.(pbase)) = ("data_create_stack")));
  rely (((v_call1_0.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    ((((((st_7.(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_7.(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_7.(share)).(granules)) @ (((((st_7.(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (
    (((((((lens 11694 st_7).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 11694 st_7).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((((((lens 11694 st_7).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match ((((((lens 11694 st_7).(share)).(granules)) @ (((((((lens 11694 st_7).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
    | (Some cid_0) => true
    | None => false
    end)
  then (Some (v_call3, ((lens 11834 st_7).[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RD == (- 1)))))
  else None.

Definition data_create_6 (v_call24: Ptr) (v_call14: Ptr) (v_wi: Ptr) (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (st_0: RData) (st_23: RData) : (option (Z * RData)) :=
  rely (((v_call24.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("data_create_stack")));
  rely (((v_g_data.(pbase)) = ("data_create_stack")));
  when cid == (((((st_23.(share)).(granules)) @ (((st_23.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
  rely (((v_call24.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((v_call14.(poffset)) = (0)));
  rely (
    ((((((st_23.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_23.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid_0 == (((((st_23.(share)).(granules)) @ (((((st_23.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call1_0.(poffset)) = (0)));
  rely (
    (((((((lens 11836 st_23).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 11836 st_23).(stack)).(data_create_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely (
    (((((((lens 11839 st_23).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 11839 st_23).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((((((lens 11839 st_23).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match ((((((lens 11839 st_23).(share)).(granules)) @ (((((((lens 11839 st_23).(stack)).(data_create_stack)) @ (v_g_data.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
    | (Some cid_1) => true
    | None => false
    end)
  then (
    (Some (
      1  ,
      (((lens 12028 st_23).[share].[granule_data] :<
        (((st_23.(share)).(granule_data)) #
          (((st_23.(share)).(slots)) @ SLOT_DELEGATED) ==
          ((((st_23.(share)).(granule_data)) @ (((st_23.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :< zero_granule_data_normal))).[share].[slots] :<
        (((((st_23.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
    )))
  else None.

Definition data_create_spec (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_g_src: Ptr) (v_flags: Z) (st: RData) : (option (Z * RData)) :=
  rely ((((v_g_src.(pbase)) = ("granules")) \/ (((v_g_src.(pbase)) = ("null")))));
  match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 12173 st))) with
  | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
    rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
    if __return__
    then (
      if __retval__
      then (
        rely (
          (((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
        rely ((((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        if (((v_g_src.(pbase)) =s ("null")) && (((v_g_src.(poffset)) =? (0))))
        then (
          rely (
            ((((((lens 5901 st_3).(share)).(granules)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)) =
              ((Some CPU_ID))));
          if (
            ((((1 <<
              (((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >>
              (1)) -
              (v_map_addr)) >?
              (0)))
          then (
            if ((((v_map_addr & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))) - (v_map_addr)) =? (0))
            then (
              rely (
                (((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                  (STACK_VIRT)) <
                  (0)) /\
                  (((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                    (GRANULES_BASE)) >=
                    (0)))));
              rely (
                ((((((st_3.(share)).(granules)) @
                  ((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                    (GRANULES_BASE)) mod
                    (ST_GRANULE_SIZE))).(e_state)) -
                  (6)) =
                  (0)));
              rely (
                (("granules" = ("granules")) /\
                  ((((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                    (GRANULES_BASE)) mod
                    (ST_GRANULE_SIZE)) =
                    (0)))));
              when sh == (
                  (((lens 5901 st_3).(repl))
                    (((lens 5901 st_3).(oracle)) ((lens 5901 st_3).(log)))
                    (((lens 5901 st_3).(share)).[slots] :<
                      (((st_3.(share)).(slots)) #
                        SLOT_RD ==
                        ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))));
              when st_13 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr
                      "granules"
                      (((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                        (GRANULES_BASE)))
                    ((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                    ((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                    v_map_addr
                    3
                    (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                    ((lens 12175 st_3).[share].[slots] :<
                      (((st_3.(share)).(slots)) #
                        SLOT_RD ==
                        ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))));
              if ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (16))) =? (3))
              then (
                rely (
                  ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
                    ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
                rely (((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                when cid == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
                if (
                  (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                    (3)) =?
                    (0)))
                then (
                  if (
                    (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                      (60)) =?
                      (0)))
                  then (
                    if (
                      (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                        (64)) =?
                        (0)))
                    then (
                      (data_create_1
                        v_data_addr
                        (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                        (mkPtr "slot_rtt" 0)
                        (mkPtr "slot_rd" 0)
                        (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                        (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                        (lens 12047 st)
                        (st_13.[share].[slots] :<
                          (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))))
                    else (
                      (data_create_2
                        v_data_addr
                        (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                        (mkPtr "slot_rtt" 0)
                        (mkPtr "slot_rd" 0)
                        (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                        (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                        (lens 12047 st)
                        (st_13.[share].[slots] :<
                          (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                  else (
                    (data_create_3
                      (mkPtr "slot_rtt" 0)
                      (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                      (mkPtr "slot_rd" 0)
                      (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                      (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                      (lens 12047 st)
                      (st_13.[share].[slots] :<
                        (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                else (
                  (data_create_3
                    (mkPtr "slot_rtt" 0)
                    (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                    (mkPtr "slot_rd" 0)
                    (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                    (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                    (lens 12047 st)
                    (st_13.[share].[slots] :<
                      (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
              else (
                (data_create_4
                  (((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (16)))
                  (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                  (mkPtr "slot_rd" 0)
                  (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                  (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                  (lens 12047 st)
                  st_13)))
            else (
              (data_create_5
                (mkPtr "slot_rd" 0)
                (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                1
                (lens 12047 st)
                ((lens 5901 st_3).[share].[slots] :<
                  (((st_3.(share)).(slots)) #
                    SLOT_RD ==
                    ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
          else (
            (data_create_5
              (mkPtr "slot_rd" 0)
              (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
              (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
              1
              (lens 12047 st)
              ((lens 5901 st_3).[share].[slots] :<
                (((st_3.(share)).(slots)) #
                  SLOT_RD ==
                  ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
        else (
          when cid == ((((((lens 5901 st_3).(share)).(granules)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
          if (
            ((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_rd_state)) =?
              (0)))
          then (
            rely (((Some cid) = ((Some CPU_ID))));
            if (
              ((((1 <<
                (((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >>
                (1)) -
                (v_map_addr)) >?
                (0)))
            then (
              if ((((v_map_addr & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))) - (v_map_addr)) =? (0))
              then (
                rely (
                  (((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                    (STACK_VIRT)) <
                    (0)) /\
                    (((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                      (GRANULES_BASE)) >=
                      (0)))));
                rely (
                  ((((((st_3.(share)).(granules)) @
                    ((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                      (GRANULES_BASE)) mod
                      (ST_GRANULE_SIZE))).(e_state)) -
                    (6)) =
                    (0)));
                rely (
                  (("granules" = ("granules")) /\
                    ((((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                      (GRANULES_BASE)) mod
                      (ST_GRANULE_SIZE)) =
                      (0)))));
                when sh == (
                    (((lens 5901 st_3).(repl))
                      (((lens 5901 st_3).(oracle)) ((lens 5901 st_3).(log)))
                      (((lens 5901 st_3).(share)).[slots] :<
                        (((st_3.(share)).(slots)) #
                          SLOT_RD ==
                          ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))));
                when st_13 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr
                        "granules"
                        (((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                          (GRANULES_BASE)))
                      ((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                      ((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                      v_map_addr
                      3
                      (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                      ((lens 12177 st_3).[share].[slots] :<
                        (((st_3.(share)).(slots)) #
                          SLOT_RD ==
                          ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))));
                if ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (16))) =? (3))
                then (
                  rely (
                    ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
                      ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
                  rely (((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                  when cid_0 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
                  if (
                    (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                      (3)) =?
                      (0)))
                  then (
                    if (
                      (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                        (60)) =?
                        (0)))
                    then (
                      if (
                        (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                          (64)) =?
                          (0)))
                      then (
                        rely (
                          ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
                            ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
                        rely (((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                        rely ((((v_g_src.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
                        rely (((v_g_src.(pbase)) = ("granules")));
                        rely ((((18446744073709420544 + ((0 & (4095)))) >? (0)) = (true)));
                        rely (((((18446744073709420544 + ((0 & (4095)))) - (MAX_ERR)) >=? (0)) = (false)));
                        rely ((((0 & (4095)) >=? (0)) = (true)));
                        rely (((((0 & (4095)) / (GRANULE_SIZE)) =? (0)) = (true)));
                        when v_call5, st_1 == (
                            (memcpy_ns_read_spec_state_oracle
                              (mkPtr "slot_delegated" 0)
                              (mkPtr "slot_ns" (0 & (4095)))
                              4096
                              (st_13.[share].[slots] :<
                                (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_DELEGATED ==
                                  (((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_NS ==
                                  ((v_g_src.(poffset)) >> (4))))));
                        rely ((v_call5 = (true)));
                        (data_create_1
                          v_data_addr
                          (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                          (mkPtr "slot_rtt" 0)
                          (mkPtr "slot_rd" 0)
                          (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                          (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                          (lens 12047 st)
                          (st_1.[share].[slots] :< ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1)))))
                      else (
                        rely (
                          ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
                            ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
                        rely (((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                        rely ((((v_g_src.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
                        rely (((v_g_src.(pbase)) = ("granules")));
                        rely ((((18446744073709420544 + ((0 & (4095)))) >? (0)) = (true)));
                        rely (((((18446744073709420544 + ((0 & (4095)))) - (MAX_ERR)) >=? (0)) = (false)));
                        rely ((((0 & (4095)) >=? (0)) = (true)));
                        rely (((((0 & (4095)) / (GRANULE_SIZE)) =? (0)) = (true)));
                        when v_call5, st_1 == (
                            (memcpy_ns_read_spec_state_oracle
                              (mkPtr "slot_delegated" 0)
                              (mkPtr "slot_ns" (0 & (4095)))
                              4096
                              (st_13.[share].[slots] :<
                                (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_DELEGATED ==
                                  (((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_NS ==
                                  ((v_g_src.(poffset)) >> (4))))));
                        rely ((v_call5 = (true)));
                        (data_create_2
                          v_data_addr
                          (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                          (mkPtr "slot_rtt" 0)
                          (mkPtr "slot_rd" 0)
                          (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                          (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                          (lens 12047 st)
                          (st_1.[share].[slots] :< ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1))))))
                    else (
                      (data_create_3
                        (mkPtr "slot_rtt" 0)
                        (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                        (mkPtr "slot_rd" 0)
                        (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                        (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                        (lens 12047 st)
                        (st_13.[share].[slots] :<
                          (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                  else (
                    (data_create_3
                      (mkPtr "slot_rtt" 0)
                      (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                      (mkPtr "slot_rd" 0)
                      (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                      (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                      (lens 12047 st)
                      (st_13.[share].[slots] :<
                        (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                else (
                  (data_create_4
                    (((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (16)))
                    (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                    (mkPtr "slot_rd" 0)
                    (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                    (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                    (lens 12047 st)
                    st_13)))
              else (
                (data_create_5
                  (mkPtr "slot_rd" 0)
                  (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                  (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                  1
                  (lens 12047 st)
                  ((lens 5901 st_3).[share].[slots] :<
                    (((st_3.(share)).(slots)) #
                      SLOT_RD ==
                      ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
            else (
              (data_create_5
                (mkPtr "slot_rd" 0)
                (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                1
                (lens 12047 st)
                ((lens 5901 st_3).[share].[slots] :<
                  (((st_3.(share)).(slots)) #
                    SLOT_RD ==
                    ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
          else (
            (data_create_5
              (mkPtr "slot_rd" 0)
              (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
              (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
              2
              (lens 12047 st)
              ((lens 5901 st_3).[share].[slots] :<
                (((st_3.(share)).(slots)) #
                  SLOT_RD ==
                  ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))))))
      else (Some (1, (lens 12242 st_3))))
    else (
      if (v_i_144 >? (0))
      then (
        rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
        rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
        when cid == (
            ((((st_3.(share)).(granules)) @
              (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
        (Some (1, (lens 12338 st_3))))
      else (Some (1, (lens 12434 st_3))))
  | None => None
  end.

