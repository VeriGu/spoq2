Definition smc_rtt_destroy_1 (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (v_call36: Ptr) (v_call31: Ptr) (st_0: RData) (st_24: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call16.(pbase)) = ("slot_rtt")));
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely (((v_call36.(pbase)) = ("slot_rtt2")));
  rely (((v_call31.(pbase)) = ("granules")));
  rely (((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_24.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
  if (
    if ((((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then true
    else (
      match (((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end))
  then (
    when cid == (((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
    if ((((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
    then None
    else (
      rely ((((v_call31.(pbase)) = ("granules")) /\ ((((v_call31.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
      if (
        match ((((((lens 8 st_24).(share)).(granules)) @ (((v_call31.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid_0) => true
        | None => false
        end)
      then (
        rely (((v_call36.(poffset)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (((v_call16.(poffset)) = (0)));
        (Some (
          0  ,
          (((lens 80 st_24).[share].[granule_data] :<
            ((((st_24.(share)).(granule_data)) #
              (((st_24.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call16.(poffset)) + ((8 * ((((st_24.(stack)).(stack_wi)).(e_index)))))) ==
                  0))) #
              (((st_24.(share)).(slots)) @ SLOT_RTT2) ==
              (((((st_24.(share)).(granule_data)) #
                (((st_24.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call16.(poffset)) + ((8 * ((((st_24.(stack)).(stack_wi)).(e_index)))))) ==
                    0))) @ (((st_24.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                zero_granule_data_normal))).[share].[slots] :<
            ((((st_24.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
        )))
      else None))
  else None.

Definition smc_rtt_destroy_2 (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (v_call36: Ptr) (v_call31: Ptr) (st_0: RData) (st_24: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call16.(pbase)) = ("slot_rtt")));
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely (((v_call36.(pbase)) = ("slot_rtt2")));
  rely (((v_call31.(pbase)) = ("granules")));
  rely (((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_24.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_24.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
  if (
    if ((((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then true
    else (
      match (((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end))
  then (
    when cid == (((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
    if ((((((st_24.(share)).(granules)) @ (1152921504605528063 + (((((st_24.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + ((- 1))) <? (0))
    then None
    else (
      rely ((((v_call31.(pbase)) = ("granules")) /\ ((((v_call31.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
      if (
        match ((((((lens 8 st_24).(share)).(granules)) @ (((v_call31.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid_0) => true
        | None => false
        end)
      then (
        rely (((v_call36.(poffset)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (((v_call16.(poffset)) = (0)));
        (Some (
          0  ,
          (((lens 88 st_24).[share].[granule_data] :<
            ((((st_24.(share)).(granule_data)) #
              (((st_24.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call16.(poffset)) + ((8 * ((((st_24.(stack)).(stack_wi)).(e_index)))))) ==
                  8))) #
              (((st_24.(share)).(slots)) @ SLOT_RTT2) ==
              (((((st_24.(share)).(granule_data)) #
                (((st_24.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call16.(poffset)) + ((8 * ((((st_24.(stack)).(stack_wi)).(e_index)))))) ==
                    8))) @ (((st_24.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                zero_granule_data_normal))).[share].[slots] :<
            ((((st_24.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
        )))
      else None))
  else None.

Definition smc_rtt_destroy_3 (v_call17: Z) (v_ulevel: Z) (v_rtt_addr: Z) (v_call9: bool) (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (st_0: RData) (st_20: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call16.(pbase)) = ("slot_rtt")));
  if ((((v_call17 & (281474976710655)) & (((- 1) << (12)))) - (v_rtt_addr)) =? (0))
  then (
    if ((v_rtt_addr & (4095)) =? (0))
    then (
      if ((v_rtt_addr / (GRANULE_SIZE)) >? (1048575))
      then None
      else (
        rely ((((0 - ((v_rtt_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rtt_addr / (GRANULE_SIZE)) < (1048576)))));
        rely (((((((st_20.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_state)) - (6)) =? (0)));
        when sh == (((st_20.(repl)) ((st_20.(oracle)) (st_20.(log))) (st_20.(share))));
        if (
          match ((((((lens 9 st_20).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end)
        then (
          if (
            match ((((((lens 11 st_20).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock))) with
            | (Some cid) => true
            | None => false
            end)
          then (
            if ((((((lens 11 st_20).(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_refcount)) =? (0))
            then (
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              if v_call9
              then (
                (smc_rtt_destroy_2
                  v_wi
                  v_call16
                  v_map_addr
                  v_s2_ctx
                  (mkPtr "slot_rtt2" 0)
                  (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                  st_0
                  ((lens 11 st_20).[share].[slots] :< (((st_20.(share)).(slots)) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))))))
              else (
                (smc_rtt_destroy_1
                  v_wi
                  v_call16
                  v_map_addr
                  v_s2_ctx
                  (mkPtr "slot_rtt2" 0)
                  (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                  st_0
                  ((lens 11 st_20).[share].[slots] :< (((st_20.(share)).(slots)) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE)))))))
            else (
              rely (((v_call16.(poffset)) = (0)));
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              rely (((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
              (Some (5, ((lens 91 st_20).[share].[slots] :< (((st_20.(share)).(slots)) # SLOT_RTT == (- 1)))))))
          else None)
        else None))
    else None)
  else (
    rely (((v_call16.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
    when cid == (((((st_20.(share)).(granules)) @ (((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    (Some (1, ((lens 92 st_20).[share].[slots] :< (((st_20.(share)).(slots)) # SLOT_RTT == (- 1)))))).

Definition smc_rtt_destroy_spec (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
    if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
      rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) =? (0)));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      if (
        match ((((((lens 9 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end)
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when cid == ((((((lens 11 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)));
        if (
          ((v_ulevel >? (3)) ||
            ((((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) + (1)) - (v_ulevel)) >? (0)))))
        then (Some (1, ((lens 94 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))
        else (
          rely (((Some cid) = ((Some CPU_ID))));
          if (((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
          then (
            if ((((v_map_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_ulevel)))) & (4294967295)))))) - (v_map_addr)) =? (0))
            then (
              rely (
                (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
                  (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              rely (
                ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
                  (6)) =?
                  (0)));
              rely (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
              when sh_0 == (
                  (((lens 11 st).(repl))
                    (((lens 11 st).(oracle)) ((lens 11 st).(log)))
                    (((lens 11 st).(share)).[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))));
              if (
                match ((((((lens 98 st).(share)).(granules)) @ (1152921504605528063 + ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
                | (Some cid_0) => true
                | None => false
                end)
              then (
                when st_14 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                      ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                      ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                      v_map_addr
                      (v_ulevel + ((- 1)))
                      (mkPtr "stack_wi" 0)
                      (((lens 103 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))).[stack].[stack_s2_ctx] :<
                        (((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)))));
                if (((((st_14.(stack)).(stack_wi)).(e_last_level)) - ((v_ulevel + ((- 1))))) =? (0))
                then (
                  rely (((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                  rely ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
                  when cid_0 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
                  if (
                    (((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index))))) &
                      (3)) =?
                      (3)))
                  then (
                    (smc_rtt_destroy_3
                      (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(stack_wi)).(e_index)))))
                      v_ulevel
                      v_rtt_addr
                      ((((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_map_addr)) >? (0))
                      (mkPtr "stack_wi" 0)
                      (mkPtr "slot_rtt" 0)
                      v_map_addr
                      (mkPtr "stack_s2_ctx" 0)
                      st
                      (st_14.[share].[slots] :< (((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))))
                  else (
                    when cid_1 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                    (Some (
                      ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
                      ((lens 104 st_14).[share].[slots] :<
                        ((((st_14.(share)).(slots)) # SLOT_RTT == (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
                    ))))
                else (
                  rely (((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                  when cid_0 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    ((((((((st_14.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) >> (24)) & (4294967040)) |'
                      (((((((st_14.(stack)).(stack_wi)).(e_last_level)) << (32)) + (4)) & (4294967295))))  ,
                    (lens 2 st_14)
                  ))))
              else None)
            else (Some (1, ((lens 106 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
          else (Some (1, ((lens 108 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))))
      else None))
  else (Some (1, st)).

