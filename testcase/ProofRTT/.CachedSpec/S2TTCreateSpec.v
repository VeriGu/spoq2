Definition map_unmap_ns_1 (v_call1_0: Ptr) (v_map_addr: Z) (v_call: Ptr) (v_s2_ctx: Ptr) (v_2_tmp: Z) (v_level: Z) (v_host_s2tte: Z) (v_call6_1: Z) (v_call7_1: Z) (v_wi: Ptr) (st_0: RData) (st_8: RData) : (option (Z * RData)) :=
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_call.(pbase)) = ("granules")));
  rely (((v_s2_ctx.(pbase)) = ("map_unmap_ns_stack")));
  rely ((((v_2_tmp - (STACK_VIRT)) < (0)) /\ (((v_2_tmp - (GRANULES_BASE)) >= (0)))));
  rely (((v_wi.(pbase)) = ("map_unmap_ns_stack")));
  rely ((((((st_8.(share)).(granules)) @ (((st_8.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))));
  rely (((v_call1_0.(poffset)) = (0)));
  when cid == (((((st_8.(share)).(granules)) @ (((st_8.(share)).(slots)) @ SLOT_RD)).(e_lock)));
  if ((((1 << (((((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_map_addr)) >? (0))
  then (
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when cid_0 == (((((st_8.(share)).(granules)) @ ((v_call.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
    (Some (1, (lens 6776 (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RD == (- 1)))))))
  else (
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((((((st_8.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) mod (ST_GRANULE_SIZE))).(e_state)) - (6)) = (0)));
    rely ((("granules" = ("granules")) /\ ((((v_2_tmp - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
    when sh == (((st_8.(repl)) ((st_8.(oracle)) (st_8.(log))) ((st_8.(share)).[slots] :< (((st_8.(share)).(slots)) # SLOT_RD == (- 1)))));
    match (((((st_8.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | None =>
      when st_15 == (
          (rtt_walk_lock_unlock_spec
            (mkPtr "granules" (v_2_tmp - (GRANULES_BASE)))
            v_call6_1
            v_call7_1
            v_map_addr
            v_level
            v_wi
            (lens 6328 (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RD == (- 1))))));
      if (((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (16))) - (v_level)) =? (0))
      then (
        rely (
          ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
            ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely (((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
        when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(e_lock)));
        if (
          (((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8)))))) &
            (3)) =?
            (0)))
        then (
          if (
            (((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8)))))) &
              (60)) =?
              (0)))
          then (
            if (v_level =? (3))
            then (
              rely ((("granules" = ("granules")) /\ ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
              if (
                if (
                  ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                    (GRANULE_STATE_RD)) =?
                    (0)))
                then true
                else (
                  match (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
                  | (Some cid_2) => true
                  | None => false
                  end))
              then (
                when cid_2 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
                if (
                  ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
                    (1)) <?
                    (0)))
                then None
                else (
                  rely (
                    (((((((lens
                      6824
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                      (STACK_VIRT)) <
                      (0)) /\
                      (((((((lens
                        6825
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                        (GRANULES_BASE)) >=
                        (0)))));
                  (Some (
                    0  ,
                    ((lens
                      6826
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              (v_host_s2tte |' (54043195528446979))))))).[share].[slots] :<
                      ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                  ))))
              else None)
            else (
              rely ((("granules" = ("granules")) /\ ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
              if (
                if (
                  ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                    (GRANULE_STATE_RD)) =?
                    (0)))
                then true
                else (
                  match (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
                  | (Some cid_2) => true
                  | None => false
                  end))
              then (
                when cid_2 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
                if (
                  ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
                    (1)) <?
                    (0)))
                then None
                else (
                  rely (
                    (((((((lens
                      6827
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              (v_host_s2tte |' (54043195528446977))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                      (STACK_VIRT)) <
                      (0)) /\
                      (((((((lens
                        6828
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                (v_host_s2tte |' (54043195528446977))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                        (GRANULES_BASE)) >=
                        (0)))));
                  (Some (
                    0  ,
                    ((lens
                      6829
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              (v_host_s2tte |' (54043195528446977))))))).[share].[slots] :<
                      ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                  ))))
              else None))
          else (
            when cid_1 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (Some (
              (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
              (lens
                6631
                (st_15.[share].[slots] :<
                  ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))))
            ))))
        else (
          when cid_1 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (
            (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
            (lens
              6631
              (st_15.[share].[slots] :<
                ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))))
          ))))
      else (
        rely (
          ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
            ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
        when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
        (Some (
          ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (16))) << (32)) + (4)) >> (24)) & (4294967040)) |'
            (((((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (16))) << (32)) + (4)) & (4294967295))))  ,
          (lens 6727 st_15)
        )))
    | (Some cid_0) => None
    end).

Definition map_unmap_ns_7 (v_call1_0: Ptr) (v_map_addr: Z) (v_call: Ptr) (v_s2_ctx: Ptr) (v_2_tmp: Z) (v_level: Z) (v_host_s2tte: Z) (v_call6_1: Z) (v_call7_1: Z) (v_wi: Ptr) (st_0: RData) (st_8: RData) : (option (Z * RData)) :=
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_call.(pbase)) = ("granules")));
  rely (((v_s2_ctx.(pbase)) = ("map_unmap_ns_stack")));
  rely ((((v_2_tmp - (STACK_VIRT)) < (0)) /\ (((v_2_tmp - (GRANULES_BASE)) >= (0)))));
  rely (((v_wi.(pbase)) = ("map_unmap_ns_stack")));
  rely (((v_call1_0.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((((((st_8.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) mod (ST_GRANULE_SIZE))).(e_state)) - (6)) = (0)));
  rely ((("granules" = ("granules")) /\ ((((v_2_tmp - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
  when sh == (((st_8.(repl)) ((st_8.(oracle)) (st_8.(log))) ((st_8.(share)).[slots] :< (((st_8.(share)).(slots)) # SLOT_RD == (- 1)))));
  match (((((st_8.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    when st_15 == (
        (rtt_walk_lock_unlock_spec
          (mkPtr "granules" (v_2_tmp - (GRANULES_BASE)))
          v_call6_1
          v_call7_1
          v_map_addr
          v_level
          v_wi
          (lens 6328 (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RD == (- 1))))));
    if (((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (16))) - (v_level)) =? (0))
    then (
      rely (
        ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
          ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
      rely (((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
      when cid == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(e_lock)));
      if (
        ((((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8)))))) &
          (36028797018963968)) -
          (36028797018963968)) =?
          (0)))
      then (
        if (
          ((v_level =? (3)) &&
            ((((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8)))))) &
              (3)) =?
              (3)))))
        then (
          rely ((("granules" = ("granules")) /\ ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
          if (
            if (
              ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                (GRANULE_STATE_RD)) =?
                (0)))
            then true
            else (
              match (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
              | (Some cid_0) => true
              | None => false
              end))
          then (
            when cid_0 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
            if (
              ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
                ((- 1))) <?
                (0)))
            then None
            else (
              if (
                ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                  (((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                    (GRANULE_STATE_REC)) =?
                    (0)))))
              then (
                rely (
                  (((((((lens
                    6830
                    (st_15.[share].[granule_data] :<
                      (((st_15.(share)).(granule_data)) #
                        (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                        ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                          (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                            (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                            0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                    (STACK_VIRT)) <
                    (0)) /\
                    (((((((lens
                      6830
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                      (GRANULES_BASE)) >=
                      (0)))));
                if (
                  (((((lens
                    6830
                    (st_15.[share].[granule_data] :<
                      (((st_15.(share)).(granule_data)) #
                        (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                        ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                          (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                            (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                            0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) >?
                    (0)))
                then (
                  if (
                    ((((((lens
                      6830
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                      (STACK_VIRT)) >=?
                      (0)))
                  then None
                  else (
                    (Some (
                      0  ,
                      (((lens
                        6835
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                0))))).[share].[slots] :<
                        ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))).[stack].[map_unmap_ns_stack] :<
                        ((st_0.(stack)).(map_unmap_ns_stack)))
                    ))))
                else None)
              else (
                rely (
                  (((((((lens
                    6831
                    (st_15.[share].[granule_data] :<
                      (((st_15.(share)).(granule_data)) #
                        (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                        ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                          (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                            (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                            0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                    (STACK_VIRT)) <
                    (0)) /\
                    (((((((lens
                      6831
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                      (GRANULES_BASE)) >=
                      (0)))));
                if (
                  (((((lens
                    6831
                    (st_15.[share].[granule_data] :<
                      (((st_15.(share)).(granule_data)) #
                        (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                        ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                          (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                            (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                            0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) >?
                    (0)))
                then (
                  if (
                    ((((((lens
                      6831
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                      (MAX_ERR)) >=?
                      (0)))
                  then None
                  else (
                    if (
                      ((((((lens
                        6831
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                        (SLOT_VIRT)) >=?
                        (0)))
                    then None
                    else (
                      if (
                        ((((((lens
                          6831
                          (st_15.[share].[granule_data] :<
                            (((st_15.(share)).(granule_data)) #
                              (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                              ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                  (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                  0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                          (STACK_VIRT)) >=?
                          (0)))
                      then None
                      else (
                        if (
                          ((((((lens
                            6831
                            (st_15.[share].[granule_data] :<
                              (((st_15.(share)).(granule_data)) #
                                (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                  (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                    (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                    0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                            (GRANULES_BASE)) >=?
                            (0)))
                        then (
                          (Some (
                            0  ,
                            (((lens
                              6839
                              (st_15.[share].[granule_data] :<
                                (((st_15.(share)).(granule_data)) #
                                  (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                  ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                    (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                      (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                      0))))).[share].[slots] :<
                              ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))).[stack].[map_unmap_ns_stack] :<
                              ((st_0.(stack)).(map_unmap_ns_stack)))
                          )))
                        else None))))
                else None)))
          else None)
        else (
          if (
            ((v_level =? (2)) &&
              ((((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8)))))) &
                (3)) =?
                (1)))))
          then (
            rely ((("granules" = ("granules")) /\ ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
            if (
              if (
                ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                  (GRANULE_STATE_RD)) =?
                  (0)))
              then true
              else (
                match (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
                | (Some cid_0) => true
                | None => false
                end))
            then (
              when cid_0 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
              if (
                ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
                  ((- 1))) <?
                  (0)))
              then None
              else (
                if (
                  ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                    (((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                      (GRANULE_STATE_REC)) =?
                      (0)))))
                then (
                  rely (
                    (((((((lens
                      6840
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                      (STACK_VIRT)) <
                      (0)) /\
                      (((((((lens
                        6840
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                        (GRANULES_BASE)) >=
                        (0)))));
                  if (
                    (((((lens
                      6840
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) >?
                      (0)))
                  then (
                    if (
                      ((((((lens
                        6840
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                        (MAX_ERR)) >=?
                        (0)))
                    then None
                    else (
                      if (
                        ((((((lens
                          6840
                          (st_15.[share].[granule_data] :<
                            (((st_15.(share)).(granule_data)) #
                              (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                              ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                  (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                  0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                          (SLOT_VIRT)) >=?
                          (0)))
                      then None
                      else (
                        if (
                          ((((((lens
                            6840
                            (st_15.[share].[granule_data] :<
                              (((st_15.(share)).(granule_data)) #
                                (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                  (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                    (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                    0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                            (STACK_VIRT)) >=?
                            (0)))
                        then None
                        else (
                          (Some (
                            0  ,
                            (((lens
                              6845
                              (st_15.[share].[granule_data] :<
                                (((st_15.(share)).(granule_data)) #
                                  (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                  ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                    (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                      (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                      0))))).[share].[slots] :<
                              ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))).[stack].[map_unmap_ns_stack] :<
                              ((st_0.(stack)).(map_unmap_ns_stack)))
                          ))))))
                  else None)
                else (
                  rely (
                    (((((((lens
                      6841
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                      (STACK_VIRT)) <
                      (0)) /\
                      (((((((lens
                        6841
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                        (GRANULES_BASE)) >=
                        (0)))));
                  if (
                    (((((lens
                      6841
                      (st_15.[share].[granule_data] :<
                        (((st_15.(share)).(granule_data)) #
                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                              0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) >?
                      (0)))
                  then (
                    if (
                      ((((((lens
                        6841
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                        (MAX_ERR)) >=?
                        (0)))
                    then None
                    else (
                      if (
                        ((((((lens
                          6841
                          (st_15.[share].[granule_data] :<
                            (((st_15.(share)).(granule_data)) #
                              (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                              ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                  (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                  0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                          (SLOT_VIRT)) >=?
                          (0)))
                      then None
                      else (
                        if (
                          ((((((lens
                            6841
                            (st_15.[share].[granule_data] :<
                              (((st_15.(share)).(granule_data)) #
                                (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                  (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                    (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                    0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                            (STACK_VIRT)) >=?
                            (0)))
                        then None
                        else (
                          if (
                            ((((((lens
                              6841
                              (st_15.[share].[granule_data] :<
                                (((st_15.(share)).(granule_data)) #
                                  (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                  ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                    (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                      (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                      0))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                              (GRANULES_BASE)) >=?
                              (0)))
                          then (
                            (Some (
                              0  ,
                              (((lens
                                6849
                                (st_15.[share].[granule_data] :<
                                  (((st_15.(share)).(granule_data)) #
                                    (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                    ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                      (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                        (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                        0))))).[share].[slots] :<
                                ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))).[stack].[map_unmap_ns_stack] :<
                                ((st_0.(stack)).(map_unmap_ns_stack)))
                            )))
                          else None))))
                  else None)))
            else None)
          else (
            when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (Some (
              (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
              (lens
                6898
                (st_15.[share].[slots] :<
                  ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))))
            )))))
      else (
        when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
        (Some (
          (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
          (lens
            6994
            (st_15.[share].[slots] :<
              ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))))
        ))))
    else (
      rely (
        ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
          ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
      when cid == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
      (Some (
        ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (16))) << (32)) + (4)) >> (24)) & (4294967040)) |'
          (((((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (16))) << (32)) + (4)) & (4294967295))))  ,
        (lens 7090 st_15)
      )))
  | (Some cid) => None
  end.

Definition map_unmap_ns_spec (v_rd_addr: Z) (v_map_addr: Z) (v_level: Z) (v_host_s2tte: Z) (v_op: Z) (st: RData) : (option (Z * RData)) :=
  when st_0 == ((new_frame "map_unmap_ns" st));
  when v_wi, st_1 == ((alloc_stack "map_unmap_ns" 24 8 st_0));
  when v_s2_ctx, st_2 == ((alloc_stack "map_unmap_ns" 32 8 st_1));
  when v_call, st_3 == ((find_lock_granule_spec v_rd_addr 2 st_2));
  if (ptr_eqb v_call (mkPtr "null" 0))
  then (
    when st_5 == ((free_stack "map_unmap_ns" st_0 st_3));
    (Some (1, st_5)))
  else (
    when v_call1_0, st_4 == ((granule_map_spec v_call 2 st_3));
    when v_call2, st_5 == ((validate_rtt_map_cmds_spec v_map_addr v_level v_call1_0 st_4));
    if v_call2
    then (
      when v_2_tmp, st_6 == ((load_RData 8 (ptr_offset v_call1_0 32) st_5));
      rely (((v_2_tmp < (STACK_VIRT)) /\ ((v_2_tmp >= (GRANULES_BASE)))));
      when v_call6_1, st_7 == ((realm_rtt_starting_level_spec v_call1_0 st_6));
      when v_call7_1, st_8 == ((realm_ipa_bits_spec v_call1_0 st_7));
      if (v_op =? (0))
      then (
        when v_call9, st_9 == ((addr_in_par_spec v_call1_0 v_map_addr st_8));
        if v_call9
        then (
          when st_10 == ((buffer_unmap_spec v_call1_0 st_9));
          when st_11 == ((granule_unlock_spec v_call st_10));
          when st_13 == ((free_stack "map_unmap_ns" st_0 st_11));
          (Some (1, st_13)))
        else (
          when st_11 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1_0 16) 32 false st_9));
          when st_12 == ((buffer_unmap_spec v_call1_0 st_11));
          when st_13 == ((granule_lock_spec (int_to_ptr v_2_tmp) 6 st_12));
          when st_14 == ((granule_unlock_spec v_call st_13));
          when st_15 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_2_tmp) v_call6_1 v_call7_1 v_map_addr v_level v_wi st_14));
          when v_4, st_16 == ((load_RData 8 (ptr_offset v_wi 16) st_15));
          if ((v_4 - (v_level)) =? (0))
          then (
            when v_5_tmp, st_17 == ((load_RData 8 (ptr_offset v_wi 0) st_16));
            rely (((v_5_tmp < (STACK_VIRT)) /\ ((v_5_tmp >= (GRANULES_BASE)))));
            when v_call18, st_18 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_17));
            when v_7, st_19 == ((load_RData 8 (ptr_offset v_wi 8) st_18));
            when v_call19, st_20 == ((__tte_read_spec (ptr_offset v_call18 (8 * (v_7))) st_19));
            when v_call23, st_21 == ((s2tte_is_unassigned_spec v_call19 st_20));
            if v_call23
            then (
              when v_call28, st_22 == ((s2tte_create_valid_ns_spec v_host_s2tte v_level st_21));
              when v_8, st_23 == ((load_RData 8 (ptr_offset v_wi 8) st_22));
              when st_24 == ((__tte_write_spec (ptr_offset v_call18 (8 * (v_8))) v_call28 st_23));
              when v_9_tmp, st_25 == ((load_RData 8 (ptr_offset v_wi 0) st_24));
              rely (((v_9_tmp < (STACK_VIRT)) /\ ((v_9_tmp >= (GRANULES_BASE)))));
              when st_26 == ((__granule_get_spec (int_to_ptr v_9_tmp) st_25));
              when st_28 == ((buffer_unmap_spec v_call18 st_26));
              when v_12_tmp, st_29 == ((load_RData 8 (ptr_offset v_wi 0) st_28));
              rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
              when st_30 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_29));
              when st_31 == ((free_stack "map_unmap_ns" st_0 st_30));
              (Some (0, st_31)))
            else (
              when v_call26, st_22 == ((pack_return_code_spec 4 v_level st_21));
              when st_23 == ((buffer_unmap_spec v_call18 st_22));
              when v_12_tmp, st_24 == ((load_RData 8 (ptr_offset v_wi 0) st_23));
              rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
              when st_25 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_24));
              when st_27 == ((free_stack "map_unmap_ns" st_0 st_25));
              (Some (v_call26, st_27))))
          else (
            when v_call16, st_17 == ((pack_return_code_spec 4 v_4 st_16));
            when v_12_tmp, st_18 == ((load_RData 8 (ptr_offset v_wi 0) st_17));
            rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE)))));
            when st_19 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_18));
            when st_20 == ((free_stack "map_unmap_ns" st_0 st_19));
            (Some (v_call16, st_20)))))
      else (
        when st_10 == ((llvm_memcpy_p0i8_p0i8_i64_spec v_s2_ctx (ptr_offset v_call1_0 16) 32 false st_8));
        when st_11 == ((buffer_unmap_spec v_call1_0 st_10));
        when st_12 == ((granule_lock_spec (int_to_ptr v_2_tmp) 6 st_11));
        when st_13 == ((granule_unlock_spec v_call st_12));
        when st_14 == ((rtt_walk_lock_unlock_spec (int_to_ptr v_2_tmp) v_call6_1 v_call7_1 v_map_addr v_level v_wi st_13));
        when v_4, st_15 == ((load_RData 8 (ptr_offset v_wi 16) st_14));
        if ((v_4 - (v_level)) =? (0))
        then (
          when v_5_tmp, st_16 == ((load_RData 8 (ptr_offset v_wi 0) st_15));
          rely (((v_5_tmp < (STACK_VIRT)) /\ ((v_5_tmp >= (GRANULES_BASE)))));
          when v_call18, st_17 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_16));
          when v_7, st_18 == ((load_RData 8 (ptr_offset v_wi 8) st_17));
          when v_call19, st_19 == ((__tte_read_spec (ptr_offset v_call18 (8 * (v_7))) st_18));
          when v_call35, st_20 == ((s2tte_is_valid_ns_spec v_call19 v_level st_19));
          if v_call35
          then (
            when v_10, st_21 == ((load_RData 8 (ptr_offset v_wi 8) st_20));
            when st_22 == ((__tte_write_spec (ptr_offset v_call18 (8 * (v_10))) 0 st_21));
            when v_11_tmp, st_23 == ((load_RData 8 (ptr_offset v_wi 0) st_22));
            when st_24 == ((__granule_put_spec (int_to_ptr v_11_tmp) st_23));
            if (v_level =? (3))
            then (
              when st_25 == ((invalidate_page_spec v_s2_ctx v_map_addr st_24));
              when st_27 == ((buffer_unmap_spec v_call18 st_25));
              when v_12_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_27));
              when st_29 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_28));
              when st_30 == ((free_stack "map_unmap_ns" st_0 st_29));
              (Some (0, st_30)))
            else (
              when st_25 == ((invalidate_block_spec v_s2_ctx v_map_addr st_24));
              when st_27 == ((buffer_unmap_spec v_call18 st_25));
              when v_12_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_27));
              when st_29 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_28));
              when st_30 == ((free_stack "map_unmap_ns" st_0 st_29));
              (Some (0, st_30))))
          else (
            when v_call38, st_21 == ((pack_return_code_spec 4 v_level st_20));
            when st_22 == ((buffer_unmap_spec v_call18 st_21));
            when v_12_tmp, st_23 == ((load_RData 8 (ptr_offset v_wi 0) st_22));
            when st_24 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_23));
            when st_26 == ((free_stack "map_unmap_ns" st_0 st_24));
            (Some (v_call38, st_26))))
        else (
          when v_call16, st_16 == ((pack_return_code_spec 4 v_4 st_15));
          when v_12_tmp, st_17 == ((load_RData 8 (ptr_offset v_wi 0) st_16));
          when st_18 == ((granule_unlock_spec (int_to_ptr v_12_tmp) st_17));
          when st_19 == ((free_stack "map_unmap_ns" st_0 st_18));
          (Some (v_call16, st_19)))))
    else (
      when st_6 == ((buffer_unmap_spec v_call1_0 st_5));
      when st_7 == ((granule_unlock_spec v_call st_6));
      when st_9 == ((free_stack "map_unmap_ns" st_0 st_7));
      (Some (1, st_9)))).

Definition map_unmap_ns_2 (v_s2_ctx: Ptr) (v_call1_0: Ptr) (v_2_tmp: Z) (v_call: Ptr) (v_call6_1: Z) (v_call7_1: Z) (v_map_addr: Z) (v_level: Z) (v_wi: Ptr) (st_9: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("map_unmap_ns_stack")));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely ((((v_2_tmp - (STACK_VIRT)) < (0)) /\ (((v_2_tmp - (GRANULES_BASE)) >= (0)))));
  rely (((v_call.(pbase)) = ("granules")));
  rely (((v_wi.(pbase)) = ("map_unmap_ns_stack")));
  rely (((v_call1_0.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((((((st_9.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) mod (ST_GRANULE_SIZE))).(e_state)) - (6)) = (0)));
  rely ((("granules" = ("granules")) /\ ((((v_2_tmp - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
  when sh == (((st_9.(repl)) ((st_9.(oracle)) (st_9.(log))) ((st_9.(share)).[slots] :< (((st_9.(share)).(slots)) # SLOT_RD == (- 1)))));
  match (((((st_9.(share)).(granules)) @ ((v_2_tmp - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    when st_15 == (
        (rtt_walk_lock_unlock_spec
          (mkPtr "granules" (v_2_tmp - (GRANULES_BASE)))
          v_call6_1
          v_call7_1
          v_map_addr
          v_level
          v_wi
          (lens 6328 (st_9.[share].[slots] :< (((st_9.(share)).(slots)) # SLOT_RD == (- 1))))));
    (Some ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (16))), st_15))
  | (Some cid) => None
  end.

Definition map_unmap_ns_3 (v_wi: Ptr) (st_16: RData) : (option (bool * Ptr * RData)) :=
  rely (((v_wi.(pbase)) = ("map_unmap_ns_stack")));
  rely (
    ((((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely (((((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  when cid == (((((st_16.(share)).(granules)) @ (((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(e_lock)));
  if (
    (((((((st_16.(share)).(granule_data)) @ (((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_16.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8)))))) &
      (3)) =?
      (0)))
  then (
    if (
      (((((((st_16.(share)).(granule_data)) @ (((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_16.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8)))))) &
        (60)) =?
        (0)))
    then (
      (Some (
        true  ,
        (mkPtr "slot_rtt" 0)  ,
        (st_16.[share].[slots] :< (((st_16.(share)).(slots)) # SLOT_RTT == (((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))))
      )))
    else (
      (Some (
        false  ,
        (mkPtr "slot_rtt" 0)  ,
        (st_16.[share].[slots] :< (((st_16.(share)).(slots)) # SLOT_RTT == (((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))))
      ))))
  else (
    (Some (
      false  ,
      (mkPtr "slot_rtt" 0)  ,
      (st_16.[share].[slots] :< (((st_16.(share)).(slots)) # SLOT_RTT == (((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))))
    ))).

Definition map_unmap_ns_4 (v_host_s2tte: Z) (v_level: Z) (v_wi: Ptr) (v_call18: Ptr) (st_0: RData) (st_21: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("map_unmap_ns_stack")));
  rely (((v_call18.(pbase)) = ("slot_rtt")));
  if (v_level =? (3))
  then (
    when cid == (((((st_21.(share)).(granules)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
    rely (
      ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely ((("granules" = ("granules")) /\ ((((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    if (
      if (
        ((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
          (GRANULE_STATE_RD)) =?
          (0)))
      then true
      else (
        match (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
        | (Some cid_0) => true
        | None => false
        end))
    then (
      when cid_0 == (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
      if (
        ((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
          (1)) <?
          (0)))
      then None
      else (
        rely (((v_call18.(poffset)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (
          (((((((lens
            170
            (st_21.[share].[granule_data] :<
              (((st_21.(share)).(granule_data)) #
                (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                    (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
            (STACK_VIRT)) <
            (0)) /\
            (((((((lens
              170
              (st_21.[share].[granule_data] :<
                (((st_21.(share)).(granule_data)) #
                  (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                      (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
              (GRANULES_BASE)) >=
              (0)))));
        (Some (
          0  ,
          ((lens
            6436
            (st_21.[share].[granule_data] :<
              (((st_21.(share)).(granule_data)) #
                (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                    (v_host_s2tte |' (54043195528446979))))))).[share].[slots] :<
            (((st_21.(share)).(slots)) # SLOT_RTT == (- 1)))
        ))))
    else None)
  else (
    when cid == (((((st_21.(share)).(granules)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
    rely (
      ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely ((("granules" = ("granules")) /\ ((((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    if (
      if (
        ((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
          (GRANULE_STATE_RD)) =?
          (0)))
      then true
      else (
        match (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
        | (Some cid_0) => true
        | None => false
        end))
    then (
      when cid_0 == (((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
      if (
        ((((((st_21.(share)).(granules)) @ ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
          (1)) <?
          (0)))
      then None
      else (
        rely (((v_call18.(poffset)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (
          (((((((lens
            170
            (st_21.[share].[granule_data] :<
              (((st_21.(share)).(granule_data)) #
                (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                    (v_host_s2tte |' (54043195528446977))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
            (STACK_VIRT)) <
            (0)) /\
            (((((((lens
              170
              (st_21.[share].[granule_data] :<
                (((st_21.(share)).(granule_data)) #
                  (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                      (v_host_s2tte |' (54043195528446977))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
              (GRANULES_BASE)) >=
              (0)))));
        (Some (
          0  ,
          ((lens
            6582
            (st_21.[share].[granule_data] :<
              (((st_21.(share)).(granule_data)) #
                (((st_21.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_21.(share)).(granule_data)) @ (((st_21.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call18.(poffset)) + ((8 * ((((st_21.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                    (v_host_s2tte |' (54043195528446977))))))).[share].[slots] :<
            (((st_21.(share)).(slots)) # SLOT_RTT == (- 1)))
        ))))
    else None).

Definition map_unmap_ns_5 (v_level: Z) (v_call18: Ptr) (v_wi: Ptr) (st_0: RData) (st_21: RData) : (option (Z * RData)) :=
  rely (((v_call18.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("map_unmap_ns_stack")));
  rely (((v_call18.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_21.(share)).(granules)) @ (((((st_21.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  (Some (
    (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
    (lens 6631 (st_21.[share].[slots] :< (((st_21.(share)).(slots)) # SLOT_RTT == (- 1))))
  )).

Definition map_unmap_ns_6 (v_4: Z) (v_wi: Ptr) (st_0: RData) (st_16: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("map_unmap_ns_stack")));
  rely (
    ((((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_16.(share)).(granules)) @ (((((st_16.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  (Some ((((((v_4 << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_4 << (32)) + (4)) & (4294967295)))), (lens 6727 st_16))).

Definition s2tte_get_ripas_spec (v_s2tte: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_s2tte & (64)) =? (0))
  then (Some (0, st))
  else (Some (1, st)).

Definition s2tte_create_table_spec (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((v_pa |' (3)), st)).

Definition s2tte_create_valid_spec (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  if (v_level =? (3))
  then (Some ((v_pa |' (2011)), st))
  else (Some ((v_pa |' (2009)), st)).

