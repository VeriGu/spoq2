Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import LockGranules.Spec.
Require Import TableWalk.Spec.
Require Import Bottom.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ExceptionOps_Spec.

  Context `{int_ptr: IntPtrCast}.

Definition data_create_1 (v_data_addr: Z) (v_wi: Ptr) (v_call14: Ptr) (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (st_0: RData) (st_20: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("stack_g1")));
  rely (((v_g_data.(pbase)) = ("stack_g0")));
  when cid == (((((st_20.(share)).(granules)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  rely (((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_20.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
  if (
    if ((((((st_20.(share)).(granules)) @ (1152921504605528063 + (((((st_20.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then true
    else (
      match (((((st_20.(share)).(granules)) @ (1152921504605528063 + (((((st_20.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
      | (Some cid_0) => true
      | None => false
      end))
  then (
    when cid_0 == (((((st_20.(share)).(granules)) @ (1152921504605528063 + (((((st_20.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
    if ((((((st_20.(share)).(granules)) @ (1152921504605528063 + (((((st_20.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + (1)) <? (0))
    then None
    else (
      rely (((v_call14.(poffset)) = (0)));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      rely (((v_call1_0.(poffset)) = (0)));
      rely (
        (((((st_20.(stack)).(stack_g1)) > (0)) /\ (((((st_20.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_20.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
      rely (
        (((((st_20.(stack)).(stack_g0)) > (0)) /\ (((((st_20.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_20.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
      rely ((("granules" = ("granules")) /\ (((((st_20.(stack)).(stack_g0)) mod (16)) = (0)))));
      if (
        match ((((((lens 48 st_20).(share)).(granules)) @ (1152921504605528063 + ((((st_20.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock))) with
        | (Some cid_1) => true
        | None => false
        end)
      then (
        (Some (
          0  ,
          (((lens 51 st_20).[share].[granule_data] :<
            (((st_20.(share)).(granule_data)) #
              (((st_20.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call14.(poffset)) + ((8 * ((((st_20.(stack)).(stack_wi)).(e_index)))))) ==
                  (v_data_addr |' (4)))))).[share].[slots] :<
            ((((st_20.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
        )))
      else None))
  else None.

Definition data_create_2 (v_data_addr: Z) (v_wi: Ptr) (v_call14: Ptr) (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (st_0: RData) (st_20: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("stack_g1")));
  rely (((v_g_data.(pbase)) = ("stack_g0")));
  when cid == (((((st_20.(share)).(granules)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  rely (((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_20.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((18446744073688449016 + ((((st_20.(stack)).(stack_wi)).(e_g_llt)))) mod (ST_GRANULE_SIZE)) = (8)))));
  if (
    if ((((((st_20.(share)).(granules)) @ (1152921504605528063 + (((((st_20.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
    then true
    else (
      match (((((st_20.(share)).(granules)) @ (1152921504605528063 + (((((st_20.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock))) with
      | (Some cid_0) => true
      | None => false
      end))
  then (
    when cid_0 == (((((st_20.(share)).(granules)) @ (1152921504605528063 + (((((st_20.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_lock)));
    if ((((((st_20.(share)).(granules)) @ (1152921504605528063 + (((((st_20.(stack)).(stack_wi)).(e_g_llt)) / (ST_GRANULE_SIZE))))).(e_refcount)) + (1)) <? (0))
    then None
    else (
      rely (((v_call14.(poffset)) = (0)));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      rely (((v_call1_0.(poffset)) = (0)));
      rely (
        (((((st_20.(stack)).(stack_g1)) > (0)) /\ (((((st_20.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_20.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
      rely (
        (((((st_20.(stack)).(stack_g0)) > (0)) /\ (((((st_20.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
          (((((st_20.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
      rely ((("granules" = ("granules")) /\ (((((st_20.(stack)).(stack_g0)) mod (16)) = (0)))));
      if (
        match ((((((lens 58 st_20).(share)).(granules)) @ (1152921504605528063 + ((((st_20.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock))) with
        | (Some cid_1) => true
        | None => false
        end)
      then (
        (Some (
          0  ,
          (((lens 61 st_20).[share].[granule_data] :<
            (((st_20.(share)).(granule_data)) #
              (((st_20.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_20.(share)).(granule_data)) @ (((st_20.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call14.(poffset)) + ((8 * ((((st_20.(stack)).(stack_wi)).(e_index)))))) ==
                  (v_data_addr |' (2011)))))).[share].[slots] :<
            ((((st_20.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
        )))
      else None))
  else None.

Definition data_create_3 (v_call14: Ptr) (v_wi: Ptr) (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (st_0: RData) (st_19: RData) : (option (Z * RData)) :=
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("stack_g1")));
  rely (((v_g_data.(pbase)) = ("stack_g0")));
  rely (((v_call14.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((((((st_19.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_19.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_19.(share)).(granules)) @ (((((st_19.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call1_0.(poffset)) = (0)));
  rely (
    (((((st_19.(stack)).(stack_g1)) > (0)) /\ (((((st_19.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_19.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
  rely (
    (((((st_19.(stack)).(stack_g0)) > (0)) /\ (((((st_19.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_19.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
  rely ((("granules" = ("granules")) /\ (((((st_19.(stack)).(stack_g0)) mod (16)) = (0)))));
  if (
    match ((((((lens 64 st_19).(share)).(granules)) @ (1152921504605528063 + ((((st_19.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock))) with
    | (Some cid_0) => true
    | None => false
    end)
  then (Some (772, ((lens 66 st_19).[share].[slots] :< ((((st_19.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))))
  else None.

Definition data_create_4 (v_4: Z) (v_wi: Ptr) (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (st_0: RData) (st_14: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("stack_g1")));
  rely (((v_g_data.(pbase)) = ("stack_g0")));
  rely (((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call1_0.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    (((((st_14.(stack)).(stack_g1)) > (0)) /\ (((((st_14.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_14.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
  rely (
    (((((st_14.(stack)).(stack_g0)) > (0)) /\ (((((st_14.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_14.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
  rely ((("granules" = ("granules")) /\ (((((st_14.(stack)).(stack_g0)) mod (16)) = (0)))));
  if (
    match ((((((lens 68 st_14).(share)).(granules)) @ (1152921504605528063 + ((((st_14.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock))) with
    | (Some cid_0) => true
    | None => false
    end)
  then (
    (Some (
      (((((v_4 << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_4 << (32)) + (4)) & (4294967295))))  ,
      ((lens 70 st_14).[share].[slots] :< (((st_14.(share)).(slots)) # SLOT_RD == (- 1)))
    )))
  else None.

Definition data_create_5 (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (v_call3: Z) (st_0: RData) (st_7: RData) : (option (Z * RData)) :=
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("stack_g1")));
  rely (((v_g_data.(pbase)) = ("stack_g0")));
  rely (((v_call1_0.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    (((((st_7.(stack)).(stack_g1)) > (0)) /\ (((((st_7.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_7.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
  when cid == (((((st_7.(share)).(granules)) @ ((((st_7.(stack)).(stack_g1)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (
    (((((st_7.(stack)).(stack_g0)) > (0)) /\ (((((st_7.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_7.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
  rely ((("granules" = ("granules")) /\ (((((st_7.(stack)).(stack_g0)) mod (16)) = (0)))));
  if (
    match ((((((lens 71 st_7).(share)).(granules)) @ (1152921504605528063 + ((((st_7.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock))) with
    | (Some cid_0) => true
    | None => false
    end)
  then (Some (v_call3, ((lens 73 st_7).[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RD == (- 1)))))
  else None.

Definition data_create_6 (v_call24: Ptr) (v_call14: Ptr) (v_wi: Ptr) (v_call1_0: Ptr) (v_g_rd: Ptr) (v_g_data: Ptr) (st_0: RData) (st_23: RData) : (option (Z * RData)) :=
  rely (((v_call24.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_g_rd.(pbase)) = ("stack_g1")));
  rely (((v_g_data.(pbase)) = ("stack_g0")));
  when cid == (((((st_23.(share)).(granules)) @ (((st_23.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
  rely (((v_call24.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((v_call14.(poffset)) = (0)));
  rely (((((((st_23.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_23.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
  when cid_0 == (((((st_23.(share)).(granules)) @ (((((st_23.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call1_0.(poffset)) = (0)));
  rely (
    (((((st_23.(stack)).(stack_g1)) > (0)) /\ (((((st_23.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_23.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
  rely (
    (((((st_23.(stack)).(stack_g0)) > (0)) /\ (((((st_23.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
      (((((st_23.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
  rely ((("granules" = ("granules")) /\ (((((st_23.(stack)).(stack_g0)) mod (16)) = (0)))));
  if (
    match ((((((lens 78 st_23).(share)).(granules)) @ (1152921504605528063 + ((((st_23.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock))) with
    | (Some cid_1) => true
    | None => false
    end)
  then (
    (Some (
      1  ,
      (((lens 81 st_23).[share].[granule_data] :<
        (((st_23.(share)).(granule_data)) #
          (((st_23.(share)).(slots)) @ SLOT_DELEGATED) ==
          ((((st_23.(share)).(granule_data)) @ (((st_23.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :< zero_granule_data_normal))).[share].[slots] :<
        (((((st_23.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
    )))
  else None.

Definition data_create_spec (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_g_src: Ptr) (v_flags: Z) (st: RData) : (option (Z * RData)) :=
  rely ((((v_g_src.(pbase)) = ("granules")) \/ (((v_g_src.(pbase)) = ("null")))));
  when v_call, st_4 == ((find_lock_two_granules_spec v_data_addr 1 (mkPtr "stack_g0" 0) v_rd_addr 2 (mkPtr "stack_g1" 0) st));
  if v_call
  then (
    rely (
      (((((st_4.(stack)).(stack_g1)) > (0)) /\ (((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
        (((((st_4.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
    rely (((((st_4.(stack)).(stack_g1)) mod (16)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    if (((v_g_src.(pbase)) =s ("null")) && (((v_g_src.(poffset)) =? (0))))
    then (
      rely ((((((st_4.(share)).(granules)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(e_lock)) = ((Some CPU_ID))));
      when cid == (((((st_4.(share)).(granules)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(e_lock)));
      if (
        ((((1 << (((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) -
          (v_map_addr)) >?
          (0)))
      then (
        if ((((v_map_addr & (281474976710655)) & (((- 1) << (12)))) - (v_map_addr)) =? (0))
        then (
          rely (
            (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
              (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
          rely (
            ((((((st_4.(share)).(granules)) @
              ((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) /
                (ST_GRANULE_SIZE))).(e_state)) -
              (6)) =
              (0)));
          rely (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
          when sh == (
              ((st_4.(repl))
                ((st_4.(oracle)) (st_4.(log)))
                ((st_4.(share)).[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
          if (
            match (
              (((((lens 82 st_4).(share)).(granules)) @
                (1152921504605528063 +
                  ((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))
            ) with
            | (Some cid_0) => true
            | None => false
            end)
          then (
            when st_13 == (
                (rtt_walk_lock_unlock_spec
                  (mkPtr
                    "granules"
                    (((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                  ((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                  ((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                  v_map_addr
                  3
                  (mkPtr "stack_wi" 0)
                  ((lens 83 st_4).[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
            if ((((st_13.(stack)).(stack_wi)).(e_last_level)) =? (3))
            then (
              rely (((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
              rely ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
              when cid_0 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
              if (
                (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                  (3)) =?
                  (0)))
              then (
                if (
                  (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                    (60)) =?
                    (0)))
                then (
                  if (
                    (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                      (64)) =?
                      (0)))
                  then (
                    (data_create_1
                      v_data_addr
                      (mkPtr "stack_wi" 0)
                      (mkPtr "slot_rtt" 0)
                      (mkPtr "slot_rd" 0)
                      (mkPtr "stack_g1" 0)
                      (mkPtr "stack_g0" 0)
                      st
                      (st_13.[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))))))
                  else (
                    (data_create_2
                      v_data_addr
                      (mkPtr "stack_wi" 0)
                      (mkPtr "slot_rtt" 0)
                      (mkPtr "slot_rd" 0)
                      (mkPtr "stack_g1" 0)
                      (mkPtr "stack_g0" 0)
                      st
                      (st_13.[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))))))
                else (
                  (data_create_3
                    (mkPtr "slot_rtt" 0)
                    (mkPtr "stack_wi" 0)
                    (mkPtr "slot_rd" 0)
                    (mkPtr "stack_g1" 0)
                    (mkPtr "stack_g0" 0)
                    st
                    (st_13.[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))))))
              else (
                (data_create_3
                  (mkPtr "slot_rtt" 0)
                  (mkPtr "stack_wi" 0)
                  (mkPtr "slot_rd" 0)
                  (mkPtr "stack_g1" 0)
                  (mkPtr "stack_g0" 0)
                  st
                  (st_13.[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))))))
            else (data_create_4 (((st_13.(stack)).(stack_wi)).(e_last_level)) (mkPtr "stack_wi" 0) (mkPtr "slot_rd" 0) (mkPtr "stack_g1" 0) (mkPtr "stack_g0" 0) st st_13))
          else None)
        else (
          (data_create_5
            (mkPtr "slot_rd" 0)
            (mkPtr "stack_g1" 0)
            (mkPtr "stack_g0" 0)
            1
            st
            (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4)))))))
      else (
        (data_create_5
          (mkPtr "slot_rd" 0)
          (mkPtr "stack_g1" 0)
          (mkPtr "stack_g0" 0)
          1
          st
          (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4)))))))
    else (
      when cid == (((((st_4.(share)).(granules)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(e_lock)));
      if ((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_rd_state)) =? (0))
      then (
        rely (((Some cid) = ((Some CPU_ID))));
        if (
          ((((1 << (((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) -
            (v_map_addr)) >?
            (0)))
        then (
          if ((((v_map_addr & (281474976710655)) & (((- 1) << (12)))) - (v_map_addr)) =? (0))
          then (
            rely (
              (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
                (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
            rely (
              ((((((st_4.(share)).(granules)) @
                ((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) /
                  (ST_GRANULE_SIZE))).(e_state)) -
                (6)) =
                (0)));
            rely (((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) mod (16)) = (0)));
            when sh == (
                ((st_4.(repl))
                  ((st_4.(oracle)) (st_4.(log)))
                  ((st_4.(share)).[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
            if (
              match (
                (((((lens 84 st_4).(share)).(granules)) @
                  (1152921504605528063 +
                    ((((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) / (ST_GRANULE_SIZE))))).(e_lock))
              ) with
              | (Some cid_0) => true
              | None => false
              end)
            then (
              when st_13 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr
                      "granules"
                      (((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                    ((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                    ((((((st_4.(share)).(granule_data)) @ ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                    v_map_addr
                    3
                    (mkPtr "stack_wi" 0)
                    ((lens 85 st_4).[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))));
              if ((((st_13.(stack)).(stack_wi)).(e_last_level)) =? (3))
              then (
                rely (((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                rely ((((((st_13.(stack)).(stack_wi)).(e_g_llt)) mod (16)) = (0)));
                when cid_0 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(e_lock)));
                if (
                  (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                    (3)) =?
                    (0)))
                then (
                  if (
                    (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                      (60)) =?
                      (0)))
                  then (
                    if (
                      (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(stack_wi)).(e_index))))) &
                        (64)) =?
                        (0)))
                    then (
                      rely (
                        (((((st_13.(stack)).(stack_g0)) > (0)) /\ (((((st_13.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
                          (((((st_13.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
                      rely (((((st_13.(stack)).(stack_g0)) mod (16)) = (0)));
                      rely ((((v_g_src.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
                      rely (((v_g_src.(pbase)) = ("granules")));
                      when v_call5, st_1 == (
                          (memcpy_ns_read_spec_state_oracle
                            (mkPtr "slot_delegated" 0)
                            (mkPtr "slot_ns" 0)
                            4096
                            (st_13.[share].[slots] :<
                              (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                                SLOT_DELEGATED ==
                                ((((st_13.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))) #
                                SLOT_NS ==
                                ((v_g_src.(poffset)) >> (4))))));
                      if v_call5
                      then (
                        (data_create_1
                          v_data_addr
                          (mkPtr "stack_wi" 0)
                          (mkPtr "slot_rtt" 0)
                          (mkPtr "slot_rd" 0)
                          (mkPtr "stack_g1" 0)
                          (mkPtr "stack_g0" 0)
                          st
                          (st_1.[share].[slots] :< ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1)))))
                      else (
                        when cid_1 == (((((st_1.(share)).(granules)) @ ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED)).(e_lock)));
                        rely (((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                        when cid_2 == (((((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                        rely (
                          (((((st_1.(stack)).(stack_g1)) > (0)) /\ (((((st_1.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
                            (((((st_1.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
                        rely (
                          (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
                            (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
                        rely ((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_g0)) mod (16)) = (0)))));
                        if (
                          match ((((((lens 86 st_1).(share)).(granules)) @ (1152921504605528063 + ((((st_1.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock))) with
                          | (Some cid_3) => true
                          | None => false
                          end)
                        then (
                          (Some (
                            1  ,
                            (((lens 87 st_1).[share].[granule_data] :<
                              (((st_1.(share)).(granule_data)) #
                                ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED) ==
                                ((((st_1.(share)).(granule_data)) @ ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED)).[g_norm] :< zero_granule_data_normal))).[share].[slots] :<
                              ((((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
                          )))
                        else None))
                    else (
                      rely (
                        (((((st_13.(stack)).(stack_g0)) > (0)) /\ (((((st_13.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
                          (((((st_13.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
                      rely (((((st_13.(stack)).(stack_g0)) mod (16)) = (0)));
                      rely ((((v_g_src.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
                      rely (((v_g_src.(pbase)) = ("granules")));
                      when v_call5, st_1 == (
                          (memcpy_ns_read_spec_state_oracle
                            (mkPtr "slot_delegated" 0)
                            (mkPtr "slot_ns" 0)
                            4096
                            (st_13.[share].[slots] :<
                              (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4))) #
                                SLOT_DELEGATED ==
                                ((((st_13.(stack)).(stack_g0)) - (GRANULES_BASE)) >> (4))) #
                                SLOT_NS ==
                                ((v_g_src.(poffset)) >> (4))))));
                      if v_call5
                      then (
                        (data_create_2
                          v_data_addr
                          (mkPtr "stack_wi" 0)
                          (mkPtr "slot_rtt" 0)
                          (mkPtr "slot_rd" 0)
                          (mkPtr "stack_g1" 0)
                          (mkPtr "stack_g0" 0)
                          st
                          (st_1.[share].[slots] :< ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1)))))
                      else (
                        when cid_1 == (((((st_1.(share)).(granules)) @ ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED)).(e_lock)));
                        rely (((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
                        when cid_2 == (((((st_1.(share)).(granules)) @ (((((st_1.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                        rely (
                          (((((st_1.(stack)).(stack_g1)) > (0)) /\ (((((st_1.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
                            (((((st_1.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
                        rely (
                          (((((st_1.(stack)).(stack_g0)) > (0)) /\ (((((st_1.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
                            (((((st_1.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
                        rely ((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_g0)) mod (16)) = (0)))));
                        if (
                          match ((((((lens 88 st_1).(share)).(granules)) @ (1152921504605528063 + ((((st_1.(stack)).(stack_g0)) / (ST_GRANULE_SIZE))))).(e_lock))) with
                          | (Some cid_3) => true
                          | None => false
                          end)
                        then (
                          (Some (
                            1  ,
                            (((lens 89 st_1).[share].[granule_data] :<
                              (((st_1.(share)).(granule_data)) #
                                ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED) ==
                                ((((st_1.(share)).(granule_data)) @ ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) @ SLOT_DELEGATED)).[g_norm] :< zero_granule_data_normal))).[share].[slots] :<
                              ((((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)))
                          )))
                        else None)))
                  else (
                    (data_create_3
                      (mkPtr "slot_rtt" 0)
                      (mkPtr "stack_wi" 0)
                      (mkPtr "slot_rd" 0)
                      (mkPtr "stack_g1" 0)
                      (mkPtr "stack_g0" 0)
                      st
                      (st_13.[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))))))
                else (
                  (data_create_3
                    (mkPtr "slot_rtt" 0)
                    (mkPtr "stack_wi" 0)
                    (mkPtr "slot_rd" 0)
                    (mkPtr "stack_g1" 0)
                    (mkPtr "stack_g0" 0)
                    st
                    (st_13.[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >> (4)))))))
              else (data_create_4 (((st_13.(stack)).(stack_wi)).(e_last_level)) (mkPtr "stack_wi" 0) (mkPtr "slot_rd" 0) (mkPtr "stack_g1" 0) (mkPtr "stack_g0" 0) st st_13))
            else None)
          else (
            (data_create_5
              (mkPtr "slot_rd" 0)
              (mkPtr "stack_g1" 0)
              (mkPtr "stack_g0" 0)
              1
              st
              (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4)))))))
        else (
          (data_create_5
            (mkPtr "slot_rd" 0)
            (mkPtr "stack_g1" 0)
            (mkPtr "stack_g0" 0)
            1
            st
            (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4)))))))
      else (
        (data_create_5
          (mkPtr "slot_rd" 0)
          (mkPtr "stack_g1" 0)
          (mkPtr "stack_g0" 0)
          2
          st
          (st_4.[share].[slots] :< (((st_4.(share)).(slots)) # SLOT_RD == ((((st_4.(stack)).(stack_g1)) - (GRANULES_BASE)) >> (4))))))))
  else (Some (1, st_4)).

End ExceptionOps_Spec.

Opaque data_create_1.
Opaque data_create_2.
Opaque data_create_3.
Opaque data_create_4.
Opaque data_create_5.
#[global] Hint Unfold data_create_6: spec.
#[global] Hint Unfold data_create_spec: spec.
