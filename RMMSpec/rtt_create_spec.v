Definition smc_rtt_create_6 (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_26: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_g_tbl.(pbase)) = ("stack_g0")));
  rely (((v_g_tbl.(poffset)) = (0)));
  when ret == ((s2tte_get_ripas_spec' v_call15));
  when ret_0 == ((s2tte_create_unassigned_spec' ret));
  match ((s2tt_init_unassigned_loop0 (z_to_nat 256) false ret_0 0 v_call16 st_26)) with
  | (Some (__return__, v_call_0, v_index_0, v_s2tt_0, st_1)) =>
    rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
    rely (
      ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
    rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_1.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
    when cid == (((((st_1.(share)).(granules)) @ ((18446744073688449016 + ((((st_1.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st_1.(share)).(granules)) @ ((18446744073688449016 + ((((st_1.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
    then None
    else (
      rely (
        (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
      rely ((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_g0)) mod (16)) = (0)))));
      rely (((v_call16.(poffset)) = (0)));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      rely (((v_call14.(poffset)) = (0)));
      (Some (
        0  ,
        (((lens 344 st_1).[share].[granule_data] :<
          (((st_1.(share)).(granule_data)) #
            (((st_1.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call14.(poffset)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                (v_rtt_addr |' (3)))))).[share].[slots] :<
          ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
      )))
  | None => None
  end.

Definition smc_rtt_create_5 (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_27: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_g_tbl.(pbase)) = ("stack_g0")));
  rely (((v_g_tbl.(poffset)) = (0)));
  match ((s2tt_init_destroyed_loop0 (z_to_nat 256) false 0 v_call16 st_27)) with
  | (Some (__return__, v_index_0, v_s2tt_0, st_1)) =>
    rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
    rely (
      ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
    rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_1.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
    when cid == (((((st_1.(share)).(granules)) @ ((18446744073688449016 + ((((st_1.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st_1.(share)).(granules)) @ ((18446744073688449016 + ((((st_1.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
    then None
    else (
      rely (
        (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
      rely ((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_g0)) mod (16)) = (0)))));
      rely (((v_call16.(poffset)) = (0)));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      rely (((v_call14.(poffset)) = (0)));
      (Some (
        0  ,
        (((lens 351 st_1).[share].[granule_data] :<
          (((st_1.(share)).(granule_data)) #
            (((st_1.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call14.(poffset)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                (v_rtt_addr |' (3)))))).[share].[slots] :<
          ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
      )))
  | None => None
  end.

Definition smc_rtt_create_4 (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_28: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_g_tbl.(pbase)) = ("stack_g0")));
  rely (((v_g_tbl.(poffset)) = (0)));
  match (
    (s2tt_init_assigned_empty_loop700
      (z_to_nat 512)
      false
      (1 << ((39 + (((- 9) * (v_ulevel))))))
      0
      v_ulevel
      ((v_call15 & (281474976710655)) & (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295))))))
      v_call16
      st_28)
  ) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
    rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
    rely (
      (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + (((st_1.(stack)).(stack_g0)))) mod (ST_GRANULE_SIZE)) = (8)))));
    when cid == (((((st_1.(share)).(granules)) @ ((18446744073688449016 + (((st_1.(stack)).(stack_g0)))) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st_1.(share)).(granules)) @ ((18446744073688449016 + (((st_1.(stack)).(stack_g0)))) / (ST_GRANULE_SIZE))).(e_refcount)) + (512)) <? (0))
    then None
    else (
      rely ((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_g0)) mod (16)) = (0)))));
      rely (((v_call16.(poffset)) = (0)));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      rely (((v_call14.(poffset)) = (0)));
      rely (
        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
      (Some (
        0  ,
        (((lens 358 st_1).[share].[granule_data] :<
          (((st_1.(share)).(granule_data)) #
            (((st_1.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call14.(poffset)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                (v_rtt_addr |' (3)))))).[share].[slots] :<
          ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
      )))
  | None => None
  end.

Definition smc_rtt_create_3 (v_wi: Ptr) (v_map_addr: Z) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_s2_ctx: Ptr) (v_g_tbl: Ptr) (v_rtt_addr: Z) (v_ulevel: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_g_tbl.(pbase)) = ("stack_g0")));
  rely (((v_g_tbl.(poffset)) = (0)));
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  when cid == (((((st_29.(share)).(granules)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  match (
    (s2tt_init_valid_loop719
      (z_to_nat 512)
      false
      (1 << ((39 + (((- 9) * (v_ulevel))))))
      0
      v_ulevel
      ((v_call15 & (281474976710655)) & (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295))))))
      v_call16
      (st_29.[share].[granule_data] :<
        (((st_29.(share)).(granule_data)) #
          (((st_29.(share)).(slots)) @ SLOT_RTT) ==
          ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
              ((v_call14.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
              0)))))
  ) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
    rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
    rely (
      (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + (((st_1.(stack)).(stack_g0)))) mod (ST_GRANULE_SIZE)) = (8)))));
    when cid_0 == (((((st_1.(share)).(granules)) @ ((18446744073688449016 + (((st_1.(stack)).(stack_g0)))) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st_1.(share)).(granules)) @ ((18446744073688449016 + (((st_1.(stack)).(stack_g0)))) / (ST_GRANULE_SIZE))).(e_refcount)) + (512)) <? (0))
    then None
    else (
      rely ((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_g0)) mod (16)) = (0)))));
      rely (((v_call16.(poffset)) = (0)));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      rely (((v_call14.(poffset)) = (0)));
      rely (
        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
      rely ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)));
      rely (
        (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
      rely ((((((st_1.(stack)).(stack_g0)) - (STACK_VIRT)) < (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))));
      (Some (
        0  ,
        (((lens 365 st_1).[share].[granule_data] :<
          (((st_1.(share)).(granule_data)) #
            (((st_1.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call14.(poffset)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                (v_rtt_addr |' (3)))))).[share].[slots] :<
          ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
      )))
  | None => None
  end.

Definition smc_rtt_create_2 (v_map_addr: Z) (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_s2_ctx: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_30: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_g_tbl.(pbase)) = ("stack_g0")));
  rely (((v_g_tbl.(poffset)) = (0)));
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  when cid == (((((st_30.(share)).(granules)) @ (((st_30.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  match (
    (s2tt_init_valid_ns_loop738
      (z_to_nat 512)
      false
      (1 << ((39 + (((- 9) * (v_ulevel))))))
      0
      v_ulevel
      ((v_call15 & (281474976710655)) & (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295))))))
      v_call16
      (st_30.[share].[granule_data] :<
        (((st_30.(share)).(granule_data)) #
          (((st_30.(share)).(slots)) @ SLOT_RTT) ==
          ((((st_30.(share)).(granule_data)) @ (((st_30.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st_30.(share)).(granule_data)) @ (((st_30.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
              ((v_call14.(poffset)) + ((8 * ((((st_30.(stack)).(stack_wi)).(e_index)))))) ==
              0)))))
  ) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
    rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
    rely (
      (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
    rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + (((st_1.(stack)).(stack_g0)))) mod (ST_GRANULE_SIZE)) = (8)))));
    when cid_0 == (((((st_1.(share)).(granules)) @ ((18446744073688449016 + (((st_1.(stack)).(stack_g0)))) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st_1.(share)).(granules)) @ ((18446744073688449016 + (((st_1.(stack)).(stack_g0)))) / (ST_GRANULE_SIZE))).(e_refcount)) + (512)) <? (0))
    then None
    else (
      rely ((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_g0)) mod (16)) = (0)))));
      rely (((v_call16.(poffset)) = (0)));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      rely (((v_call14.(poffset)) = (0)));
      rely (
        ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
          ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
      rely (((((st_1.(stack)).(stack_wi)).(e_g_llt)) > (0)));
      rely ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (MAX_ERR)) < (0)));
      rely ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
      rely (
        (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
      rely ((((((st_1.(stack)).(stack_g0)) - (STACK_VIRT)) < (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))));
      (Some (
        0  ,
        (((lens 372 st_1).[share].[granule_data] :<
          (((st_1.(share)).(granule_data)) #
            (((st_1.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call14.(poffset)) + ((8 * ((((st_1.(stack)).(stack_wi)).(e_index)))))) ==
                (v_rtt_addr |' (3)))))).[share].[slots] :<
          ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
      )))
  | None => None
  end.

Definition smc_rtt_create_1 (v_ulevel: Z) (v_call14: Ptr) (v_call16: Ptr) (v_wi: Ptr) (v_g_tbl: Ptr) (st_0: RData) (st_31: RData) : (option (Z * RData)) :=
  rely (((v_g_tbl.(pbase)) = ("stack_g0")));
  rely (((v_g_tbl.(poffset)) = (0)));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_call16.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((v_call14.(poffset)) = (0)));
  rely (
    ((((((st_31.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_31.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
      ((((((st_31.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
  when cid == (((((st_31.(share)).(granules)) @ (((((st_31.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (
    (((((st_31.(stack)).(stack_g0)) > (0)) /\ (((((st_31.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_31.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
  (Some (
    ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
    ((lens 375 st_31).[share].[slots] :< ((((st_31.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
  )).

Definition smc_rtt_create_0 (v_g_tbl: Ptr) (v_rtt_addr: Z) (v_ulevel: Z) (v_wi: Ptr) (v_call14: Ptr) (v_call16: Ptr) (st_0: RData) (st_31: RData) : (option (Z * RData)) :=
  rely (((v_g_tbl.(pbase)) = ("stack_g0")));
  rely (((v_g_tbl.(poffset)) = (0)));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (
    (((((st_31.(stack)).(stack_g0)) > (0)) /\ (((((st_31.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_31.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
  rely ((("granules" = ("granules")) /\ (((((st_31.(stack)).(stack_g0)) mod (16)) = (0)))));
  when cid == (((((st_31.(share)).(granules)) @ (1152921504605528063 + ((((st_31.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock)));
  rely (((v_call16.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((v_call14.(poffset)) = (0)));
  rely (
    ((((((st_31.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_31.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
      ((((((st_31.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
  (Some (
    0  ,
    (((lens 381 st_31).[share].[granule_data] :<
      (((st_31.(share)).(granule_data)) #
        (((st_31.(share)).(slots)) @ SLOT_RTT) ==
        ((((st_31.(share)).(granule_data)) @ (((st_31.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
          (((((st_31.(share)).(granule_data)) @ (((st_31.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
            ((v_call14.(poffset)) + ((8 * ((((st_31.(stack)).(stack_wi)).(e_index)))))) ==
            (v_rtt_addr |' (3)))))).[share].[slots] :<
      ((((st_31.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
  )).

Definition smc_rtt_create_spec (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
  when v_call, st_5 == ((find_lock_two_granules_spec v_rtt_addr 1 (mkPtr "stack_g0" 0) v_rd_addr 2 (mkPtr "stack_g1" 0) st));
  if v_call
  then (
    rely (
      (((((st_5.(stack)).(stack_g1)) > (0)) /\ (((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_5.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (((((st_5.(stack)).(stack_g1)) mod (16)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when ret, st' == (
        (validate_rtt_structure_cmds_spec'
          v_map_addr
          v_ulevel
          (mkPtr "slot_rd" 0)
          (st_5.[share].[slots] :< (((st_5.(share)).(slots)) # SLOT_RD == ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
    if ret
    then (
      rely (
        (((((((((st_5.(share)).(granule_data)) @ ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) > (0)) /\
          (((((((((st_5.(share)).(granule_data)) @ ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))) /\
          (((((((((st_5.(share)).(granule_data)) @ ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (18446744073705226240)) <
            (0)))));
      rely (
        ((((((st_5.(share)).(granules)) @
          ((((((((st_5.(share)).(granule_data)) @ ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) /
            (ST_GRANULE_SIZE))).(e_state)) -
          (6)) =
          (0)));
      rely (((((((((st_5.(share)).(granule_data)) @ ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
      when sh == (
          ((st_5.(repl))
            ((st_5.(oracle)) (st_5.(log)))
            ((st_5.(share)).[slots] :< ((((st_5.(share)).(slots)) # SLOT_RD == ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) # SLOT_RD == (- 1)))));
      when st_18 == (
          (rtt_walk_lock_unlock_spec
            (mkPtr
              "granules"
              (((((((st_5.(share)).(granule_data)) @ ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
            ((((((st_5.(share)).(granule_data)) @ ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
            ((((((st_5.(share)).(granule_data)) @ ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
            v_map_addr
            (v_ulevel + ((- 1)))
            (mkPtr "stack_wi" 0)
            (((lens 386 st_5).[share].[slots] :< ((((st_5.(share)).(slots)) # SLOT_RD == ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) # SLOT_RD == (- 1))).[stack].[stack_s2_ctx] :<
              (((((st_5.(share)).(granule_data)) @ ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)))));
      if (((((st_18.(stack)).(stack_wi)).(e_last_level)) - ((v_ulevel + ((- 1))))) =? (0))
      then (
        rely (
          ((((((st_18.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
            ((((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
        rely ((((((st_18.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
        when cid == (((((st_18.(share)).(granules)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
        rely (
          (((((st_18.(stack)).(stack_g0)) > (0)) /\ (((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
            (((((st_18.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
        rely (((((st_18.(stack)).(stack_g0)) mod (16)) = (0)));
        when ret_0 == (
            (s2tte_has_hipas_spec'
              (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index)))))
              0));
        if ret_0
        then (
          (smc_rtt_create_6
            (mkPtr "stack_wi" 0)
            (mkPtr "slot_rtt" 0)
            (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index)))))
            (mkPtr "slot_delegated" 0)
            v_ulevel
            (mkPtr "stack_g0" 0)
            v_rtt_addr
            st
            (st_18.[share].[slots] :<
              ((((st_18.(share)).(slots)) # SLOT_RTT == (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                SLOT_DELEGATED ==
                ((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))))
        else (
          when ret_1 == (
              (s2tte_has_hipas_spec'
                (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index)))))
                8));
          if ret_1
          then (
            (smc_rtt_create_5
              (mkPtr "stack_wi" 0)
              (mkPtr "slot_rtt" 0)
              (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index)))))
              (mkPtr "slot_delegated" 0)
              v_ulevel
              (mkPtr "stack_g0" 0)
              v_rtt_addr
              st
              (st_18.[share].[slots] :<
                ((((st_18.(share)).(slots)) # SLOT_RTT == (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                  SLOT_DELEGATED ==
                  ((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))))
          else (
            when ret_2 == (
                (s2tte_has_hipas_spec'
                  (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index)))))
                  4));
            if ret_2
            then (
              (smc_rtt_create_4
                (mkPtr "stack_wi" 0)
                (mkPtr "slot_rtt" 0)
                (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index)))))
                (mkPtr "slot_delegated" 0)
                v_ulevel
                (mkPtr "stack_g0" 0)
                v_rtt_addr
                st
                (st_18.[share].[slots] :<
                  ((((st_18.(share)).(slots)) # SLOT_RTT == (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                    SLOT_DELEGATED ==
                    ((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))))
            else (
              when ret_3 == (
                  (s2tte_check_spec'
                    (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index)))))
                    (v_ulevel + ((- 1)))
                    0));
              if ret_3
              then (
                (smc_rtt_create_3
                  (mkPtr "stack_wi" 0)
                  v_map_addr
                  (mkPtr "slot_rtt" 0)
                  (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index)))))
                  (mkPtr "slot_delegated" 0)
                  (mkPtr "stack_s2_ctx" 0)
                  (mkPtr "stack_g0" 0)
                  v_rtt_addr
                  v_ulevel
                  st
                  (st_18.[share].[slots] :<
                    ((((st_18.(share)).(slots)) # SLOT_RTT == (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                      SLOT_DELEGATED ==
                      ((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))))
              else (
                when ret_4 == (
                    (s2tte_check_spec'
                      (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index)))))
                      (v_ulevel + ((- 1)))
                      36028797018963968));
                if ret_4
                then (
                  (smc_rtt_create_2
                    v_map_addr
                    (mkPtr "stack_wi" 0)
                    (mkPtr "slot_rtt" 0)
                    (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index)))))
                    (mkPtr "slot_delegated" 0)
                    v_ulevel
                    (mkPtr "stack_g0" 0)
                    (mkPtr "stack_s2_ctx" 0)
                    v_rtt_addr
                    st
                    (st_18.[share].[slots] :<
                      ((((st_18.(share)).(slots)) # SLOT_RTT == (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                        SLOT_DELEGATED ==
                        ((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))))
                else (
                  if (
                    (((v_ulevel + ((- 1))) <? (3)) &&
                      ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(stack_wi)).(e_index))))) &
                        (3)) =?
                        (3)))))
                  then (
                    (smc_rtt_create_1
                      v_ulevel
                      (mkPtr "slot_rtt" 0)
                      (mkPtr "slot_delegated" 0)
                      (mkPtr "stack_wi" 0)
                      (mkPtr "stack_g0" 0)
                      st
                      (st_18.[share].[slots] :<
                        ((((st_18.(share)).(slots)) # SLOT_RTT == (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                          SLOT_DELEGATED ==
                          ((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))))
                  else (
                    (smc_rtt_create_0
                      (mkPtr "stack_g0" 0)
                      v_rtt_addr
                      v_ulevel
                      (mkPtr "stack_wi" 0)
                      (mkPtr "slot_rtt" 0)
                      (mkPtr "slot_delegated" 0)
                      st
                      (st_18.[share].[slots] :<
                        ((((st_18.(share)).(slots)) # SLOT_RTT == (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                          SLOT_DELEGATED ==
                          ((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))))))))))))
      else (
        rely (
          ((((((st_18.(stack)).(stack_wi)).(e_g_llt)) > (0)) /\ ((((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
            ((((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (18446744073705226240)) < (0)))));
        when cid == (((((st_18.(share)).(granules)) @ (((((st_18.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
        rely (
          (((((st_18.(stack)).(stack_g0)) > (0)) /\ (((((st_18.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
            (((((st_18.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
        (Some (
          ((((((((st_18.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) >> (24)) & (4294967040)) |'
            (((((((st_18.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) & (4294967295))))  ,
          (lens 387 st_18)
        ))))
    else (
      when cid == (((((st_5.(share)).(granules)) @ ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
      rely (
        (((((st_5.(stack)).(stack_g0)) > (0)) /\ (((((st_5.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_5.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
      (Some (1, ((lens 390 st_5).[share].[slots] :< ((((st_5.(share)).(slots)) # SLOT_RD == ((((st_5.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))) # SLOT_RD == (- 1)))))))
  else (Some (1, st_5)).
