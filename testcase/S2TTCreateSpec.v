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
    (Some (1, (lens 6375 (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RD == (- 1)))))))
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
            (lens 6424 (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RD == (- 1))))));
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
                  | (Some cid_1) => true
                  | None => false
                  end))
              then (
                when cid_1 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
                if (
                  ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
                    (1)) <?
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
                        6425
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
                          6425
                          (st_15.[share].[granule_data] :<
                            (((st_15.(share)).(granule_data)) #
                              (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                              ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                  (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                  (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                          (GRANULES_BASE)) >=
                          (0)))));
                    if (
                      (((((lens
                        6425
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) >?
                        (0)))
                    then (
                      if (
                        ((((((lens
                          6425
                          (st_15.[share].[granule_data] :<
                            (((st_15.(share)).(granule_data)) #
                              (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                              ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                  (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                  (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                          (MAX_ERR)) >=?
                          (0)))
                      then None
                      else (
                        if (
                          ((((((lens
                            6425
                            (st_15.[share].[granule_data] :<
                              (((st_15.(share)).(granule_data)) #
                                (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                  (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                    (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                    (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                            (SLOT_VIRT)) >=
                            (0)))
                        then None
                        else (
                          if (
                            ((((((lens
                              6425
                              (st_15.[share].[granule_data] :<
                                (((st_15.(share)).(granule_data)) #
                                  (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                  ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                    (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                      (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                      (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                              (STACK_VIRT)) >=
                              (0)))
                          then None
                          else (
                            if (
                              ((((((lens
                                6425
                                (st_15.[share].[granule_data] :<
                                  (((st_15.(share)).(granule_data)) #
                                    (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                    ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                      (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                        (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                        (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                                (GRANULES_BASE)) >=
                                (0)))
                            then (
                              (Some (
                                0  ,
                                (((lens
                                  6430
                                  (st_15.[share].[granule_data] :<
                                    (((st_15.(share)).(granule_data)) #
                                      (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                      ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                        (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                          (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                          (v_host_s2tte |' (54043195528446979))))))).[share].[slots] :<
                                  ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))).[stack].[map_unmap_ns_stack] :<
                                  ((st_0.(stack)).(map_unmap_ns_stack)))
                              )))
                            else None))))
                    else None)
                  else (
                    rely (
                      (((((((lens
                        6426
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
                          6426
                          (st_15.[share].[granule_data] :<
                            (((st_15.(share)).(granule_data)) #
                              (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                              ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                  (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                  (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                          (GRANULES_BASE)) >=
                          (0)))));
                    if (
                      (((((lens
                        6426
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) >?
                        (0)))
                    then (
                      if (
                        ((((((lens
                          6426
                          (st_15.[share].[granule_data] :<
                            (((st_15.(share)).(granule_data)) #
                              (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                              ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                  (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                  (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                          (MAX_ERR)) >=?
                          (0)))
                      then None
                      else (
                        if (
                          ((((((lens
                            6426
                            (st_15.[share].[granule_data] :<
                              (((st_15.(share)).(granule_data)) #
                                (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                  (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                    (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                    (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                            (SLOT_VIRT)) >=
                            (0)))
                        then None
                        else (
                          if (
                            ((((((lens
                              6426
                              (st_15.[share].[granule_data] :<
                                (((st_15.(share)).(granule_data)) #
                                  (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                  ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                    (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                      (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                      (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                              (STACK_VIRT)) >=
                              (0)))
                          then None
                          else (
                            if (
                              ((((((lens
                                6426
                                (st_15.[share].[granule_data] :<
                                  (((st_15.(share)).(granule_data)) #
                                    (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                    ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                      (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                        (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                        (v_host_s2tte |' (54043195528446979))))))).(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) -
                                (GRANULES_BASE)) >=
                                (0)))
                            then (
                              (Some (
                                0  ,
                                (((lens
                                  6434
                                  (st_15.[share].[granule_data] :<
                                    (((st_15.(share)).(granule_data)) #
                                      (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                                      ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                        (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                          (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                          (v_host_s2tte |' (54043195528446979))))))).[share].[slots] :<
                                  ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))).[stack].[map_unmap_ns_stack] :<
                                  ((st_0.(stack)).(map_unmap_ns_stack)))
                              )))
                            else None))))
                    else None)))
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
                  | (Some cid_1) => true
                  | None => false
                  end))
              then (
                when cid_1 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
                if (
                  ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
                    (1)) <?
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
                        6435
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
                          6435
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
                      (((lens
                        6438
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                (v_host_s2tte |' (54043195528446977))))))).[share].[slots] :<
                        ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))).[stack].[map_unmap_ns_stack] :<
                        ((st_0.(stack)).(map_unmap_ns_stack)))
                    )))
                  else (
                    rely (
                      (((((((lens
                        6436
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
                          6436
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
                      (((lens
                        6440
                        (st_15.[share].[granule_data] :<
                          (((st_15.(share)).(granule_data)) #
                            (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4)) ==
                            ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                              (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                (v_host_s2tte |' (54043195528446977))))))).[share].[slots] :<
                        ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))).[stack].[map_unmap_ns_stack] :<
                        ((st_0.(stack)).(map_unmap_ns_stack)))
                    )))))
              else None))
          else (
            when cid_1 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (Some (
              (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
              (lens
                6489
                (st_15.[share].[slots] :<
                  ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1))))
            ))))
        else (
          when cid_1 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (
            (((((v_level << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_level << (32)) + (4)) & (4294967295))))  ,
            (lens
              6585
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
          (lens 6681 st_15)
        )))
    | (Some cid_0) => None
    end).
