Definition smc_rtt_fold_1 (v_call1_0: Ptr) (v_s2_ctx: Ptr) (v_call: Ptr) (v_map_addr: Z) (v_ulevel: Z) (v_wi: Ptr) (st_6: RData) : (option (Z * RData)) :=
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_call1_0.(poffset)) = (0)));
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely (((v_call.(pbase)) = ("granules")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  when cid == (((((st_6.(share)).(granules)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(e_lock)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    (((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
      (((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
  rely (
    ((((((st_6.(share)).(granules)) @ ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
      (6)) =?
      (0)));
  rely (((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
  when sh == (((st_6.(repl)) ((st_6.(oracle)) (st_6.(log))) ((st_6.(share)).[slots] :< (((st_6.(share)).(slots)) # SLOT_RD == (- 1)))));
  if (
    match (
      (((((lens 88 st_6).(share)).(granules)) @
        (1152921504605528063 + ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))
    ) with
    | (Some cid_0) => true
    | None => false
    end)
  then (
    when st_15 == (
        (rtt_walk_lock_unlock_spec
          (mkPtr "granules" (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
          ((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
          ((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
          v_map_addr
          (v_ulevel + ((- 1)))
          v_wi
          (((lens 92 st_6).[share].[slots] :< (((st_6.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[stack_s2_ctx] :<
            (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)))));
    (Some ((((st_15.(stack)).(stack_wi)).(e_last_level)), st_15)))
  else None.

Definition smc_rtt_fold_2 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_call44: Z) (v_call33: Ptr) (st_0: RData) (st_33: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_call33.(pbase)) = ("granules")));
  when cid == (((((st_33.(share)).(granules)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  when cid_0 == (((((st_33.(share)).(granules)) @ (((st_33.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
  rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match (((((st_33.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid_1) => true
    | None => false
    end)
  then (
    when cid_1 == (((((st_33.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call34.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((v_call15.(poffset)) = (0)));
    rely (((((((st_33.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_33.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
    (Some (
      0  ,
      (((lens 99 st_33).[share].[granule_data] :<
        ((((st_33.(share)).(granule_data)) #
          (((st_33.(share)).(slots)) @ SLOT_RTT) ==
          ((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
              ((v_call15.(poffset)) + ((8 * ((((st_33.(stack)).(stack_wi)).(e_index)))))) ==
              v_call44))) #
          (((st_33.(share)).(slots)) @ SLOT_RTT2) ==
          (((((st_33.(share)).(granule_data)) #
            (((st_33.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call15.(poffset)) + ((8 * ((((st_33.(stack)).(stack_wi)).(e_index)))))) ==
                v_call44))) @ (((st_33.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
            zero_granule_data_normal))).[share].[slots] :<
        ((((st_33.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
    )))
  else None.

Definition smc_rtt_fold_3 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_call44: Z) (v_call33: Ptr) (st_0: RData) (st_34: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_call33.(pbase)) = ("granules")));
  when cid == (((((st_34.(share)).(granules)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  when cid_0 == (((((st_34.(share)).(granules)) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
  rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match (((((st_34.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid_1) => true
    | None => false
    end)
  then (
    when cid_1 == (((((st_34.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call34.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((v_call15.(poffset)) = (0)));
    rely (((((((st_34.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_34.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
    (Some (
      0  ,
      (((lens 106 st_34).[share].[granule_data] :<
        ((((st_34.(share)).(granule_data)) #
          (((st_34.(share)).(slots)) @ SLOT_RTT) ==
          ((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
              ((v_call15.(poffset)) + ((8 * ((((st_34.(stack)).(stack_wi)).(e_index)))))) ==
              v_call44))) #
          (((st_34.(share)).(slots)) @ SLOT_RTT2) ==
          (((((st_34.(share)).(granule_data)) #
            (((st_34.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call15.(poffset)) + ((8 * ((((st_34.(stack)).(stack_wi)).(e_index)))))) ==
                v_call44))) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
            zero_granule_data_normal))).[share].[slots] :<
        ((((st_34.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
    )))
  else None.

Definition smc_rtt_fold_4 (v_ripas: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call44: Z) (v_ulevel: Z) (st_28: RData) : (option (bool * RData)) :=
  rely (((v_ripas.(pbase)) = ("stack_ripas")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  if (((st_28.(stack)).(stack_ripas)) =? (0))
  then (
    if ((v_wi.(poffset)) =? (0))
    then (
      rely (((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
      if (
        if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
        then true
        else (
          match (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end))
      then (
        when cid == (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
        if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
        then None
        else (
          (Some (
            false  ,
            ((lens 17 st_28).[share].[granule_data] :<
              (((st_28.(share)).(granule_data)) #
                (((st_28.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call15.(poffset)) + ((8 * ((((st_28.(stack)).(stack_wi)).(e_index)))))) ==
                    0))))
          ))))
      else None)
    else (
      if ((v_wi.(poffset)) =? (8))
      then (
        rely (((((((st_28.(stack)).(stack_wi)).(e_index)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_index)) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_index)))) mod (ST_GRANULE_SIZE)) = (8)))));
        if (
          if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
          then true
          else (
            match (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_lock))) with
            | (Some cid) => true
            | None => false
            end))
        then (
          when cid == (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_lock)));
          if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
          then None
          else (
            (Some (
              false  ,
              ((lens 17 st_28).[share].[granule_data] :<
                (((st_28.(share)).(granule_data)) #
                  (((st_28.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call15.(poffset)) + ((8 * ((((st_28.(stack)).(stack_wi)).(e_last_level)))))) ==
                      0))))
            ))))
        else None)
      else (
        if ((v_wi.(poffset)) =? (16))
        then (
          rely (((((((st_28.(stack)).(stack_wi)).(e_last_level)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_last_level)) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_last_level)))) mod (ST_GRANULE_SIZE)) = (8)))));
          None)
        else None)))
  else (
    if ((v_wi.(poffset)) =? (0))
    then (
      rely (((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
      if (
        if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
        then true
        else (
          match (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end))
      then (
        when cid == (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
        if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
        then None
        else (
          (Some (
            false  ,
            ((lens 17 st_28).[share].[granule_data] :<
              (((st_28.(share)).(granule_data)) #
                (((st_28.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call15.(poffset)) + ((8 * ((((st_28.(stack)).(stack_wi)).(e_index)))))) ==
                    0))))
          ))))
      else None)
    else (
      if ((v_wi.(poffset)) =? (8))
      then (
        rely (((((((st_28.(stack)).(stack_wi)).(e_index)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_index)) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_index)))) mod (ST_GRANULE_SIZE)) = (8)))));
        if (
          if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
          then true
          else (
            match (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_lock))) with
            | (Some cid) => true
            | None => false
            end))
        then (
          when cid == (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_lock)));
          if ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_index)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
          then None
          else (
            (Some (
              false  ,
              ((lens 17 st_28).[share].[granule_data] :<
                (((st_28.(share)).(granule_data)) #
                  (((st_28.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call15.(poffset)) + ((8 * ((((st_28.(stack)).(stack_wi)).(e_last_level)))))) ==
                      0))))
            ))))
        else None)
      else (
        if ((v_wi.(poffset)) =? (16))
        then (
          rely (((((((st_28.(stack)).(stack_wi)).(e_last_level)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_last_level)) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_28.(stack)).(stack_wi)).(e_last_level)))) mod (ST_GRANULE_SIZE)) = (8)))));
          if (
            if (
              ((((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_last_level)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =?
                (0)))
            then true
            else (
              match (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_last_level)) / (ST_GRANULE_SIZE))))).(e_lock))) with
              | (Some cid) => true
              | None => false
              end))
          then (
            when cid == (((((st_28.(share)).(granules)) @ (1152921504605528063 + (((((st_28.(stack)).(stack_wi)).(e_last_level)) / (ST_GRANULE_SIZE))))).(e_lock)));
            None)
          else None)
        else None))).

Definition smc_rtt_fold_5 (v_call34: Ptr) (v_call33: Ptr) (v_call15: Ptr) (v_wi: Ptr) (st_0: RData) (st_28: RData) : (option (Z * RData)) :=
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_call33.(pbase)) = ("granules")));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call34.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  when cid == (((((st_28.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call15.(poffset)) = (0)));
  rely (((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_28.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  (Some (5, ((lens 109 st_28).[share].[slots] :< ((((st_28.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))))).

Definition smc_rtt_fold_6 (v_call34: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_ulevel: Z) (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call33: Ptr) (v_ripas: Ptr) (st_0: RData) (st_26: RData) : (option (Z * RData)) :=
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_call33.(pbase)) = ("granules")));
  rely (((v_ripas.(pbase)) = ("stack_ripas")));
  when cid == (((((st_26.(share)).(granules)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
  if (((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (0))
  then (
    if ((((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (60)) - (8)) =? (0))
    then (
      match ((__table_is_uniform_block_loop777 (z_to_nat 511) false true 1 false 0 (mkPtr "null" 0) v_call34 (mkPtr "s2tte_is_destroyed" 0) st_26)) with
      | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_1, v_s2tte_is_x_0, st_3)) =>
        rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
        rely (((v_s2tte_is_x_0.(poffset)) = (0)));
        rely (((v_table_1.(pbase)) = ("slot_rtt2")));
        rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
        if v_retval_1
        then (
          rely (((((((st_3.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_3.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_3.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
          if (
            if ((((((st_3.(share)).(granules)) @ ((18446744073688449016 + ((((st_3.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
            then true
            else (
              match (((((st_3.(share)).(granules)) @ ((18446744073688449016 + ((((st_3.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
              | (Some cid_0) => true
              | None => false
              end))
          then (
            when cid_0 == (((((st_3.(share)).(granules)) @ ((18446744073688449016 + ((((st_3.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
            if ((((((st_3.(share)).(granules)) @ ((18446744073688449016 + ((((st_3.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
            then None
            else (
              (smc_rtt_fold_3
                v_s2_ctx
                v_map_addr
                v_wi
                v_call15
                v_call34
                8
                v_call33
                st_0
                ((lens 17 st_3).[share].[granule_data] :<
                  (((st_3.(share)).(granule_data)) #
                    (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                    ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                      (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                        ((v_call15.(poffset)) + ((8 * ((((st_3.(stack)).(stack_wi)).(e_index)))))) ==
                        0)))))))
          else None)
        else (
          when cid_0 == (((((st_3.(share)).(granules)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
          if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (0))
          then (
            if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (60)) =? (0))
            then (
              if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (64)) =? (0))
              then (
                match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 0 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_3)) with
                | (Some (__break___0, v_cmp_not_1, v_indvars_iv_1, v_retval_2, v_ripas_2, v_ripas_ptr_1, v_table_2, v_s2tte_is_x_1, st_4)) =>
                  rely (((v_ripas_ptr_1.(pbase)) = ("smc_rtt_fold_stack")));
                  rely (((v_s2tte_is_x_1.(poffset)) = (0)));
                  rely (((v_table_2.(pbase)) = ("slot_rtt2")));
                  rely ((((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_destroyed")))));
                  if v_retval_2
                  then (
                    if (((st_4.(stack)).(stack_ripas)) =? (0))
                    then (
                      rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        when cid_1 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                        then None
                        else (
                          (smc_rtt_fold_3
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            0
                            v_call33
                            st_0
                            ((lens 17 st_4).[share].[granule_data] :<
                              (((st_4.(share)).(granule_data)) #
                                (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                                    0)))))))
                      else None)
                    else (
                      rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        when cid_1 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                        then None
                        else (
                          (smc_rtt_fold_3
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            64
                            v_call33
                            st_0
                            ((lens 17 st_4).[share].[granule_data] :<
                              (((st_4.(share)).(granule_data)) #
                                (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                                    0)))))))
                      else None))
                  else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_4)
                | None => None
                end)
              else (
                match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 1 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_3)) with
                | (Some (__break___0, v_cmp_not_1, v_indvars_iv_1, v_retval_2, v_ripas_2, v_ripas_ptr_1, v_table_2, v_s2tte_is_x_1, st_4)) =>
                  rely (((v_ripas_ptr_1.(pbase)) = ("smc_rtt_fold_stack")));
                  rely (((v_s2tte_is_x_1.(poffset)) = (0)));
                  rely (((v_table_2.(pbase)) = ("slot_rtt2")));
                  rely ((((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_destroyed")))));
                  if v_retval_2
                  then (
                    if (((st_4.(stack)).(stack_ripas)) =? (0))
                    then (
                      rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        when cid_1 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                        then None
                        else (
                          (smc_rtt_fold_3
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            0
                            v_call33
                            st_0
                            ((lens 17 st_4).[share].[granule_data] :<
                              (((st_4.(share)).(granule_data)) #
                                (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                                    0)))))))
                      else None)
                    else (
                      rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                      rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        when cid_1 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                        if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                        then None
                        else (
                          (smc_rtt_fold_3
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            64
                            v_call33
                            st_0
                            ((lens 17 st_4).[share].[granule_data] :<
                              (((st_4.(share)).(granule_data)) #
                                (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                                    0)))))))
                      else None))
                  else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_4)
                | None => None
                end))
            else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_3))
          else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_3))
      | None => None
      end)
    else (
      if (((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (60)) =? (0))
      then (
        if (((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (64)) =? (0))
        then (
          match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 0 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_26)) with
          | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_1, v_s2tte_is_x_0, st_4)) =>
            rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
            rely (((v_s2tte_is_x_0.(poffset)) = (0)));
            rely (((v_table_1.(pbase)) = ("slot_rtt2")));
            rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
            if v_retval_1
            then (
              if (((st_4.(stack)).(stack_ripas)) =? (0))
              then (
                rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                if (
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                  then true
                  else (
                    match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end))
                then (
                  when cid_0 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                  then None
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      0
                      v_call33
                      st_0
                      ((lens 17 st_4).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))
                else None)
              else (
                rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                if (
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                  then true
                  else (
                    match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end))
                then (
                  when cid_0 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                  then None
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      64
                      v_call33
                      st_0
                      ((lens 17 st_4).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))
                else None))
            else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_4)
          | None => None
          end)
        else (
          match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 1 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_26)) with
          | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_1, v_s2tte_is_x_0, st_4)) =>
            rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
            rely (((v_s2tte_is_x_0.(poffset)) = (0)));
            rely (((v_table_1.(pbase)) = ("slot_rtt2")));
            rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
            if v_retval_1
            then (
              if (((st_4.(stack)).(stack_ripas)) =? (0))
              then (
                rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                if (
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                  then true
                  else (
                    match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end))
                then (
                  when cid_0 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                  then None
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      0
                      v_call33
                      st_0
                      ((lens 17 st_4).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))
                else None)
              else (
                rely (((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_4.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
                if (
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                  then true
                  else (
                    match (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end))
                then (
                  when cid_0 == (((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_lock)));
                  if ((((((st_4.(share)).(granules)) @ ((18446744073688449016 + ((((st_4.(stack)).(stack_wi)).(e_g_llt)))) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
                  then None
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      64
                      v_call33
                      st_0
                      ((lens 17 st_4).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_4.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))
                else None))
            else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_4)
          | None => None
          end))
      else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_26)))
  else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_26).

Definition smc_rtt_fold_7 (v_ulevel: Z) (v_call60: Z) (v_call33: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_s2_ctx: Ptr) (v_map_addr: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) :=
  rely (((v_call33.(pbase)) = ("granules")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
  if (
    if ((((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then true
    else (
      match (((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end))
  then (
    when cid == (((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
    then None
    else (
      if (((v_call60 |' (4)) & (36028797018963968)) =? (0))
      then (
        if (((v_ulevel + ((- 1))) =? (3)) && ((((v_call60 |' (4)) & (3)) =? (3))))
        then (
          (smc_rtt_fold_2
            v_s2_ctx
            v_map_addr
            v_wi
            v_call15
            v_call34
            (v_call60 |' (4))
            v_call33
            st_0
            ((lens 8 st_29).[share].[granule_data] :<
              (((st_29.(share)).(granule_data)) #
                (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                    0))))))
        else (
          if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (4)) & (3)) =? (1))))
          then (
            (smc_rtt_fold_2
              v_s2_ctx
              v_map_addr
              v_wi
              v_call15
              v_call34
              (v_call60 |' (4))
              v_call33
              st_0
              ((lens 8 st_29).[share].[granule_data] :<
                (((st_29.(share)).(granule_data)) #
                  (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                      0))))))
          else (
            (smc_rtt_fold_3
              v_s2_ctx
              v_map_addr
              v_wi
              v_call15
              v_call34
              (v_call60 |' (4))
              v_call33
              st_0
              ((lens 8 st_29).[share].[granule_data] :<
                (((st_29.(share)).(granule_data)) #
                  (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                      0))))))))
      else (
        if ((((v_call60 |' (4)) & (36028797018963968)) - (36028797018963968)) =? (0))
        then (
          if (((v_ulevel + ((- 1))) =? (3)) && ((((v_call60 |' (4)) & (3)) =? (3))))
          then (
            (smc_rtt_fold_2
              v_s2_ctx
              v_map_addr
              v_wi
              v_call15
              v_call34
              (v_call60 |' (4))
              v_call33
              st_0
              ((lens 8 st_29).[share].[granule_data] :<
                (((st_29.(share)).(granule_data)) #
                  (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                      0))))))
          else (
            if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (4)) & (3)) =? (1))))
            then (
              (smc_rtt_fold_2
                v_s2_ctx
                v_map_addr
                v_wi
                v_call15
                v_call34
                (v_call60 |' (4))
                v_call33
                st_0
                ((lens 8 st_29).[share].[granule_data] :<
                  (((st_29.(share)).(granule_data)) #
                    (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                    ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                      (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                        ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                        0))))))
            else (
              (smc_rtt_fold_3
                v_s2_ctx
                v_map_addr
                v_wi
                v_call15
                v_call34
                (v_call60 |' (4))
                v_call33
                st_0
                ((lens 8 st_29).[share].[granule_data] :<
                  (((st_29.(share)).(granule_data)) #
                    (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                    ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                      (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                        ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                        0))))))))
        else (
          (smc_rtt_fold_3
            v_s2_ctx
            v_map_addr
            v_wi
            v_call15
            v_call34
            (v_call60 |' (4))
            v_call33
            st_0
            ((lens 8 st_29).[share].[granule_data] :<
              (((st_29.(share)).(granule_data)) #
                (((st_29.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call15.(poffset)) + ((8 * ((((st_29.(stack)).(stack_wi)).(e_index)))))) ==
                    0)))))))))
  else None.

Definition smc_rtt_fold_8 (v_call34: Ptr) (v_ulevel: Z) (v_call60: Z) (v_call33: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_s2_ctx: Ptr) (v_map_addr: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) :=
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_call33.(pbase)) = ("granules")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  when cid == (((((st_29.(share)).(granules)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
  if (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) =? (0))
  then (
    if ((v_ulevel =? (3)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (3))))
    then (
      if (
        (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
          (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
          (281474976710655)) &
          (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
          ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
            (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
          (0)))
      then (
        match (
          (__table_maps_block_loop840
            (z_to_nat 511)
            false
            (1 << ((39 + (((- 9) * (v_ulevel))))))
            (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
              (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
            1
            v_ulevel
            false
            v_call34
            (mkPtr "s2tte_is_valid" 0)
            st_29)
        ) with
        | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) =>
          rely (((v_s2tte_is_x_0.(poffset)) = (0)));
          rely (((v_table_1.(pbase)) = ("slot_rtt22")));
          rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
          if v_retval_2
          then (
            rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
            if (
              if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
              then true
              else (
                match (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                | (Some cid_0) => true
                | None => false
                end))
            then (
              when cid_0 == (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
              if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
              then None
              else (
                if (((v_call60 |' (2009)) & (36028797018963968)) =? (0))
                then (
                  if (((v_call60 |' (2009)) & (3)) =? (1))
                  then (
                    (smc_rtt_fold_2
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      (v_call60 |' (2009))
                      v_call33
                      st_0
                      ((lens 8 st_5).[share].[granule_data] :<
                        (((st_5.(share)).(granule_data)) #
                          (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                              0))))))
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      (v_call60 |' (2009))
                      v_call33
                      st_0
                      ((lens 8 st_5).[share].[granule_data] :<
                        (((st_5.(share)).(granule_data)) #
                          (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))
                else (
                  if ((((v_call60 |' (2009)) & (36028797018963968)) - (36028797018963968)) =? (0))
                  then (
                    if (((v_call60 |' (2009)) & (3)) =? (1))
                    then (
                      (smc_rtt_fold_2
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (2009))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0))))))
                    else (
                      (smc_rtt_fold_3
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (2009))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0)))))))
                  else (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      (v_call60 |' (2009))
                      v_call33
                      st_0
                      ((lens 8 st_5).[share].[granule_data] :<
                        (((st_5.(share)).(granule_data)) #
                          (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                              0)))))))))
            else None)
          else (
            when cid_0 == (((((st_5.(share)).(granules)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
            if (
              ((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) - (36028797018963968)) =?
                (0)))
            then (
              if (((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (3))
              then (
                if (
                  (((((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                    (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
                    (281474976710655)) &
                    (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
                    ((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                      (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
                    (0)))
                then (
                  match (
                    (__table_maps_block_loop840
                      (z_to_nat 511)
                      false
                      (1 << ((39 + (((- 9) * (v_ulevel))))))
                      (((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                        (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                      1
                      v_ulevel
                      false
                      v_call34
                      (mkPtr "s2tte_is_valid_ns" 0)
                      st_5)
                  ) with
                  | (Some (__break___0, v_call_1, v_call3_1, v_i_17, v_level_2, v_retval_3, v_table_2, v_s2tte_is_x_1, st_6)) =>
                    rely (((v_s2tte_is_x_1.(poffset)) = (0)));
                    rely (((v_table_2.(pbase)) = ("slot_rtt22")));
                    rely (((((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_valid_ns")))));
                    if v_retval_3
                    then (
                      rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        when cid_1 == (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                        if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
                        then None
                        else (
                          if (((v_call60 |' (54043195528446977)) & (36028797018963968)) =? (0))
                          then (
                            if (((v_call60 |' (54043195528446977)) & (3)) =? (1))
                            then (
                              (smc_rtt_fold_2
                                v_s2_ctx
                                v_map_addr
                                v_wi
                                v_call15
                                v_call34
                                (v_call60 |' (54043195528446977))
                                v_call33
                                st_0
                                ((lens 8 st_6).[share].[granule_data] :<
                                  (((st_6.(share)).(granule_data)) #
                                    (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                    ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                      (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                        ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                        0))))))
                            else (
                              (smc_rtt_fold_3
                                v_s2_ctx
                                v_map_addr
                                v_wi
                                v_call15
                                v_call34
                                (v_call60 |' (54043195528446977))
                                v_call33
                                st_0
                                ((lens 8 st_6).[share].[granule_data] :<
                                  (((st_6.(share)).(granule_data)) #
                                    (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                    ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                      (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                        ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                        0)))))))
                          else (
                            if ((((v_call60 |' (54043195528446977)) & (36028797018963968)) - (36028797018963968)) =? (0))
                            then (
                              if (((v_call60 |' (54043195528446977)) & (3)) =? (1))
                              then (
                                (smc_rtt_fold_2
                                  v_s2_ctx
                                  v_map_addr
                                  v_wi
                                  v_call15
                                  v_call34
                                  (v_call60 |' (54043195528446977))
                                  v_call33
                                  st_0
                                  ((lens 8 st_6).[share].[granule_data] :<
                                    (((st_6.(share)).(granule_data)) #
                                      (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                          0))))))
                              else (
                                (smc_rtt_fold_3
                                  v_s2_ctx
                                  v_map_addr
                                  v_wi
                                  v_call15
                                  v_call34
                                  (v_call60 |' (54043195528446977))
                                  v_call33
                                  st_0
                                  ((lens 8 st_6).[share].[granule_data] :<
                                    (((st_6.(share)).(granule_data)) #
                                      (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                          0)))))))
                            else (
                              (smc_rtt_fold_3
                                v_s2_ctx
                                v_map_addr
                                v_wi
                                v_call15
                                v_call34
                                (v_call60 |' (54043195528446977))
                                v_call33
                                st_0
                                ((lens 8 st_6).[share].[granule_data] :<
                                  (((st_6.(share)).(granule_data)) #
                                    (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                    ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                      (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                        ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                        0)))))))))
                      else None)
                    else (
                      when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_6));
                      (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))
                  | None => None
                  end)
                else (
                  when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                  (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
              else (
                when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
            else (
              when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
              (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
        | None => None
        end)
      else (
        when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
        (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
    else (
      if ((v_ulevel =? (2)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (1))))
      then (
        if (
          (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
            (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
            (281474976710655)) &
            (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
            ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
              (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
            (0)))
        then (
          match (
            (__table_maps_block_loop840
              (z_to_nat 511)
              false
              (1 << ((39 + (((- 9) * (v_ulevel))))))
              (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
              1
              v_ulevel
              false
              v_call34
              (mkPtr "s2tte_is_valid" 0)
              st_29)
          ) with
          | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) =>
            rely (((v_s2tte_is_x_0.(poffset)) = (0)));
            rely (((v_table_1.(pbase)) = ("slot_rtt22")));
            rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
            if v_retval_2
            then (
              rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
              if (
                if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                then true
                else (
                  match (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                  | (Some cid_0) => true
                  | None => false
                  end))
              then (
                when cid_0 == (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
                then None
                else (
                  if (((v_call60 |' (2009)) & (36028797018963968)) =? (0))
                  then (
                    (smc_rtt_fold_3
                      v_s2_ctx
                      v_map_addr
                      v_wi
                      v_call15
                      v_call34
                      (v_call60 |' (2009))
                      v_call33
                      st_0
                      ((lens 8 st_5).[share].[granule_data] :<
                        (((st_5.(share)).(granule_data)) #
                          (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                          ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                            (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                              ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                              0))))))
                  else (
                    if ((((v_call60 |' (2009)) & (36028797018963968)) - (36028797018963968)) =? (0))
                    then (
                      if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (2009)) & (3)) =? (1))))
                      then (
                        (smc_rtt_fold_2
                          v_s2_ctx
                          v_map_addr
                          v_wi
                          v_call15
                          v_call34
                          (v_call60 |' (2009))
                          v_call33
                          st_0
                          ((lens 8 st_5).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                  0))))))
                      else (
                        (smc_rtt_fold_3
                          v_s2_ctx
                          v_map_addr
                          v_wi
                          v_call15
                          v_call34
                          (v_call60 |' (2009))
                          v_call33
                          st_0
                          ((lens 8 st_5).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                  0)))))))
                    else (
                      (smc_rtt_fold_3
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (2009))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0)))))))))
              else None)
            else (
              when cid_0 == (((((st_5.(share)).(granules)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
              if (
                ((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) - (36028797018963968)) =?
                  (0)))
              then (
                if (((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (1))
                then (
                  if (
                    (((((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                      (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
                      (281474976710655)) &
                      (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
                      ((((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                        (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
                      (0)))
                  then (
                    match (
                      (__table_maps_block_loop840
                        (z_to_nat 511)
                        false
                        (1 << ((39 + (((- 9) * (v_ulevel))))))
                        (((((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                          (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                        1
                        v_ulevel
                        false
                        v_call34
                        (mkPtr "s2tte_is_valid_ns" 0)
                        st_5)
                    ) with
                    | (Some (__break___0, v_call_1, v_call3_1, v_i_17, v_level_2, v_retval_3, v_table_2, v_s2tte_is_x_1, st_6)) =>
                      rely (((v_s2tte_is_x_1.(poffset)) = (0)));
                      rely (((v_table_2.(pbase)) = ("slot_rtt22")));
                      rely (((((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_1.(pbase)) = ("s2tte_is_valid_ns")))));
                      if v_retval_3
                      then (
                        rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                        if (
                          if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                          then true
                          else (
                            match (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                            | (Some cid_1) => true
                            | None => false
                            end))
                        then (
                          when cid_1 == (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                          if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
                          then None
                          else (
                            if (((v_call60 |' (54043195528446977)) & (36028797018963968)) =? (0))
                            then (
                              (smc_rtt_fold_3
                                v_s2_ctx
                                v_map_addr
                                v_wi
                                v_call15
                                v_call34
                                (v_call60 |' (54043195528446977))
                                v_call33
                                st_0
                                ((lens 8 st_6).[share].[granule_data] :<
                                  (((st_6.(share)).(granule_data)) #
                                    (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                    ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                      (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                        ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                        0))))))
                            else (
                              if ((((v_call60 |' (54043195528446977)) & (36028797018963968)) - (36028797018963968)) =? (0))
                              then (
                                if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (54043195528446977)) & (3)) =? (1))))
                                then (
                                  (smc_rtt_fold_2
                                    v_s2_ctx
                                    v_map_addr
                                    v_wi
                                    v_call15
                                    v_call34
                                    (v_call60 |' (54043195528446977))
                                    v_call33
                                    st_0
                                    ((lens 8 st_6).[share].[granule_data] :<
                                      (((st_6.(share)).(granule_data)) #
                                        (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                        ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                          (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                            ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                            0))))))
                                else (
                                  (smc_rtt_fold_3
                                    v_s2_ctx
                                    v_map_addr
                                    v_wi
                                    v_call15
                                    v_call34
                                    (v_call60 |' (54043195528446977))
                                    v_call33
                                    st_0
                                    ((lens 8 st_6).[share].[granule_data] :<
                                      (((st_6.(share)).(granule_data)) #
                                        (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                        ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                          (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                            ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                            0)))))))
                              else (
                                (smc_rtt_fold_3
                                  v_s2_ctx
                                  v_map_addr
                                  v_wi
                                  v_call15
                                  v_call34
                                  (v_call60 |' (54043195528446977))
                                  v_call33
                                  st_0
                                  ((lens 8 st_6).[share].[granule_data] :<
                                    (((st_6.(share)).(granule_data)) #
                                      (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          ((v_call15.(poffset)) + ((8 * ((((st_6.(stack)).(stack_wi)).(e_index)))))) ==
                                          0)))))))))
                        else None)
                      else (
                        when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_6));
                        (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))
                    | None => None
                    end)
                  else (
                    when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                    (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
                else (
                  when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                  (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
              else (
                when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
          | None => None
          end)
        else (
          when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
          (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
      else (
        when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
        (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))))
  else (
    if (
      ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) - (36028797018963968)) =?
        (0)))
    then (
      if ((v_ulevel =? (3)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (3))))
      then (
        if (
          (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
            (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
            (281474976710655)) &
            (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
            ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
              (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
            (0)))
        then (
          match (
            (__table_maps_block_loop840
              (z_to_nat 511)
              false
              (1 << ((39 + (((- 9) * (v_ulevel))))))
              (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
              1
              v_ulevel
              false
              v_call34
              (mkPtr "s2tte_is_valid_ns" 0)
              st_29)
          ) with
          | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) =>
            rely (((v_s2tte_is_x_0.(poffset)) = (0)));
            rely (((v_table_1.(pbase)) = ("slot_rtt22")));
            rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
            if v_retval_2
            then (
              rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
              if (
                if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                then true
                else (
                  match (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                  | (Some cid_0) => true
                  | None => false
                  end))
              then (
                when cid_0 == (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
                then None
                else (
                  if (((v_call60 |' (54043195528446977)) & (36028797018963968)) =? (0))
                  then (
                    if (((v_call60 |' (54043195528446977)) & (3)) =? (1))
                    then (
                      (smc_rtt_fold_2
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (54043195528446977))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0))))))
                    else (
                      (smc_rtt_fold_3
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (54043195528446977))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0)))))))
                  else (
                    if ((((v_call60 |' (54043195528446977)) & (36028797018963968)) - (36028797018963968)) =? (0))
                    then (
                      if (((v_call60 |' (54043195528446977)) & (3)) =? (1))
                      then (
                        (smc_rtt_fold_2
                          v_s2_ctx
                          v_map_addr
                          v_wi
                          v_call15
                          v_call34
                          (v_call60 |' (54043195528446977))
                          v_call33
                          st_0
                          ((lens 8 st_5).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                  0))))))
                      else (
                        (smc_rtt_fold_3
                          v_s2_ctx
                          v_map_addr
                          v_wi
                          v_call15
                          v_call34
                          (v_call60 |' (54043195528446977))
                          v_call33
                          st_0
                          ((lens 8 st_5).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                  0)))))))
                    else (
                      (smc_rtt_fold_3
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (54043195528446977))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0)))))))))
              else None)
            else (
              when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
              (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))
          | None => None
          end)
        else (
          when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
          (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
      else (
        if ((v_ulevel =? (2)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (1))))
        then (
          if (
            (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
              (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
              (281474976710655)) &
              (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
              ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
              (0)))
          then (
            match (
              (__table_maps_block_loop840
                (z_to_nat 511)
                false
                (1 << ((39 + (((- 9) * (v_ulevel))))))
                (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) &
                  (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                1
                v_ulevel
                false
                v_call34
                (mkPtr "s2tte_is_valid_ns" 0)
                st_29)
            ) with
            | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) =>
              rely (((v_s2tte_is_x_0.(poffset)) = (0)));
              rely (((v_table_1.(pbase)) = ("slot_rtt22")));
              rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
              if v_retval_2
              then (
                rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                if (
                  if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                  then true
                  else (
                    match (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                    | (Some cid_0) => true
                    | None => false
                    end))
                then (
                  when cid_0 == (((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                  if ((((((st_5.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
                  then None
                  else (
                    if (((v_call60 |' (54043195528446977)) & (36028797018963968)) =? (0))
                    then (
                      (smc_rtt_fold_3
                        v_s2_ctx
                        v_map_addr
                        v_wi
                        v_call15
                        v_call34
                        (v_call60 |' (54043195528446977))
                        v_call33
                        st_0
                        ((lens 8 st_5).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                0))))))
                    else (
                      if ((((v_call60 |' (54043195528446977)) & (36028797018963968)) - (36028797018963968)) =? (0))
                      then (
                        if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (54043195528446977)) & (3)) =? (1))))
                        then (
                          (smc_rtt_fold_2
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            (v_call60 |' (54043195528446977))
                            v_call33
                            st_0
                            ((lens 8 st_5).[share].[granule_data] :<
                              (((st_5.(share)).(granule_data)) #
                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                    0))))))
                        else (
                          (smc_rtt_fold_3
                            v_s2_ctx
                            v_map_addr
                            v_wi
                            v_call15
                            v_call34
                            (v_call60 |' (54043195528446977))
                            v_call33
                            st_0
                            ((lens 8 st_5).[share].[granule_data] :<
                              (((st_5.(share)).(granule_data)) #
                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                    ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                    0)))))))
                      else (
                        (smc_rtt_fold_3
                          v_s2_ctx
                          v_map_addr
                          v_wi
                          v_call15
                          v_call34
                          (v_call60 |' (54043195528446977))
                          v_call33
                          st_0
                          ((lens 8 st_5).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call15.(poffset)) + ((8 * ((((st_5.(stack)).(stack_wi)).(e_index)))))) ==
                                  0)))))))))
                else None)
              else (
                when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_5));
                (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))
            | None => None
            end)
          else (
            when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
            (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39))))
        else (
          when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
          (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))))
    else (
      when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_29));
      (Some ((((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295)))), st_39)))).

Definition smc_rtt_fold_spec (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
    if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
      rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) =? (0)));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      if (
        match ((((((lens 42 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end)
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when cid == ((((((lens 44 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)));
        if (
          ((v_ulevel >? (3)) ||
            ((((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) + (1)) - (v_ulevel)) >? (0)))))
        then (Some (1, ((lens 111 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))
        else (
          rely (((Some cid) = ((Some CPU_ID))));
          if (((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
          then (
            if ((((v_map_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) - (v_map_addr)) =? (0))
            then (
              when v_4, st_16 == (
                  (smc_rtt_fold_1
                    (mkPtr "slot_rd" 0)
                    (mkPtr "bad_stack" 0)
                    (mkPtr "granules" (16 * ((v_rd_addr / (GRANULE_SIZE)))))
                    v_map_addr
                    v_ulevel
                    (mkPtr "bad_stack" 0)
                    ((lens 44 st).[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))))));
              if ((v_4 - ((v_ulevel + ((- 1))))) =? (0))
              then (
                rely ((((DEFAULT_STACK_VAL - (STACK_VIRT)) < (0)) /\ (((DEFAULT_STACK_VAL - (GRANULES_BASE)) >= (0)))));
                rely (((DEFAULT_STACK_VAL mod (16)) = (0)));
                when cid_0 == (((((st_16.(share)).(granules)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))).(e_lock)));
                if (((((((st_16.(share)).(granule_data)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * (DEFAULT_STACK_VAL))) & (3)) =? (3))
                then (
                  if (
                    (((((((((st_16.(share)).(granule_data)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * (DEFAULT_STACK_VAL))) & (281474976710655)) &
                      (((- 1) << (12)))) -
                      (v_rtt_addr)) =?
                      (0)))
                  then (
                    rely ((((v_rtt_addr & (4095)) =? (0)) = (true)));
                    rely ((((v_rtt_addr / (GRANULE_SIZE)) >? (1048575)) = (false)));
                    rely ((((0 - ((v_rtt_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rtt_addr / (GRANULE_SIZE)) < (1048576)))));
                    rely (((((((st_16.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_state)) - (6)) =? (0)));
                    when sh_0 == (
                        ((st_16.(repl))
                          ((st_16.(oracle)) (st_16.(log)))
                          ((st_16.(share)).[slots] :< (((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))))));
                    if (
                      match ((((((lens 112 st_16).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock))) with
                      | (Some cid_1) => true
                      | None => false
                      end)
                    then (
                      if (
                        match ((((((lens 113 st_16).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock))) with
                        | (Some cid_1) => true
                        | None => false
                        end)
                      then (
                        if ((((((lens 113 st_16).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_refcount)) =? (0))
                        then (
                          (smc_rtt_fold_6
                            (mkPtr "slot_rtt2" 0)
                            (mkPtr "bad_stack" 0)
                            (mkPtr "slot_rtt" 0)
                            v_ulevel
                            (mkPtr "bad_stack" 0)
                            v_map_addr
                            (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                            (mkPtr "bad_stack" 0)
                            st
                            ((lens 113 st_16).[share].[slots] :<
                              ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))))))
                        else (
                          if ((((((lens 113 st_16).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_refcount)) =? (512))
                          then (
                            if (v_ulevel <? (3))
                            then (
                              (Some (
                                5  ,
                                ((lens 117 st_16).[share].[slots] :<
                                  ((((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))) # SLOT_RTT2 == (- 1)) #
                                    SLOT_RTT ==
                                    (- 1)))
                              )))
                            else (
                              if (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (3)) =? (0))
                              then (
                                if ((((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (60)) - (4)) =? (0))
                                then (
                                  if (
                                    (((((((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                      (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) &
                                      (281474976710655)) &
                                      (((- 1) << ((((- 38654705616) + ((38654705655 * (v_ulevel)))) & (4294967295)))))) -
                                      ((((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                        (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))))) =?
                                      (0)))
                                  then (
                                    match (
                                      (__table_maps_block_loop840
                                        (z_to_nat 511)
                                        false
                                        (1 << ((39 + (((- 9) * (v_ulevel))))))
                                        (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                          (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                        1
                                        v_ulevel
                                        false
                                        (mkPtr "slot_rtt2" 0)
                                        (mkPtr "s2tte_is_assigned" 0)
                                        ((lens 113 st_16).[share].[slots] :<
                                          ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE)))))
                                    ) with
                                    | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) =>
                                      rely (((v_s2tte_is_x_0.(poffset)) = (0)));
                                      rely (((v_table_1.(pbase)) = ("slot_rtt22")));
                                      rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
                                      if v_retval_2
                                      then (
                                        (smc_rtt_fold_7
                                          v_ulevel
                                          (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                            (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                          (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                                          (mkPtr "bad_stack" 0)
                                          (mkPtr "slot_rtt" 0)
                                          (mkPtr "slot_rtt2" 0)
                                          (mkPtr "bad_stack" 0)
                                          v_map_addr
                                          st
                                          st_5))
                                      else (
                                        (smc_rtt_fold_8
                                          (mkPtr "slot_rtt2" 0)
                                          v_ulevel
                                          (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                            (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                          (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                                          (mkPtr "bad_stack" 0)
                                          (mkPtr "slot_rtt" 0)
                                          (mkPtr "slot_rtt2" 0)
                                          (mkPtr "bad_stack" 0)
                                          v_map_addr
                                          st
                                          st_5))
                                    | None => None
                                    end)
                                  else (
                                    (smc_rtt_fold_8
                                      (mkPtr "slot_rtt2" 0)
                                      v_ulevel
                                      (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                        (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                      (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                                      (mkPtr "bad_stack" 0)
                                      (mkPtr "slot_rtt" 0)
                                      (mkPtr "slot_rtt2" 0)
                                      (mkPtr "bad_stack" 0)
                                      v_map_addr
                                      st
                                      ((lens 113 st_16).[share].[slots] :<
                                        ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE)))))))
                                else (
                                  (smc_rtt_fold_8
                                    (mkPtr "slot_rtt2" 0)
                                    v_ulevel
                                    (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                      (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                    (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                                    (mkPtr "bad_stack" 0)
                                    (mkPtr "slot_rtt" 0)
                                    (mkPtr "slot_rtt2" 0)
                                    (mkPtr "bad_stack" 0)
                                    v_map_addr
                                    st
                                    ((lens 113 st_16).[share].[slots] :<
                                      ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE)))))))
                              else (
                                (smc_rtt_fold_8
                                  (mkPtr "slot_rtt2" 0)
                                  v_ulevel
                                  (((((((st_16.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                    (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295))))))
                                  (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                                  (mkPtr "bad_stack" 0)
                                  (mkPtr "slot_rtt" 0)
                                  (mkPtr "slot_rtt2" 0)
                                  (mkPtr "bad_stack" 0)
                                  v_map_addr
                                  st
                                  ((lens 113 st_16).[share].[slots] :<
                                    ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))))))))
                          else (
                            (smc_rtt_fold_5
                              (mkPtr "slot_rtt2" 0)
                              (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                              (mkPtr "slot_rtt" 0)
                              (mkPtr "bad_stack" 0)
                              st
                              ((lens 113 st_16).[share].[slots] :<
                                ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))))))))
                      else None)
                    else None)
                  else (
                    when cid_1 == (((((st_16.(share)).(granules)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                    (Some (
                      ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
                      ((lens 118 st_16).[share].[slots] :< ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                    ))))
                else (
                  when cid_1 == (((((st_16.(share)).(granules)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
                    ((lens 119 st_16).[share].[slots] :< ((((st_16.(share)).(slots)) # SLOT_RTT == ((DEFAULT_STACK_VAL - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                  ))))
              else (
                rely ((((DEFAULT_STACK_VAL - (STACK_VIRT)) < (0)) /\ (((DEFAULT_STACK_VAL - (GRANULES_BASE)) >= (0)))));
                when cid_0 == (((((st_16.(share)).(granules)) @ ((DEFAULT_STACK_VAL - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some ((((((v_4 << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_4 << (32)) + (4)) & (4294967295)))), (lens 47 st_16)))))
            else (Some (1, ((lens 121 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
          else (Some (1, ((lens 123 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))))
      else None))
  else (Some (1, st)).

