Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer3_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition spinlock_release_spec (lock: Ptr) (st: RData) : (option RData) :=
    if ((lock.(pbase)) =s ("granules"))
    then (
      let ofs := (lock.(poffset)) in
      let gidx_l := (ofs / (16)) in
      let g := ((((st.(share)).(globals)).(g_granules)) @ gidx_l) in
      when cid == (((g.(e_lock)).(e_val)));
      let e := (EVT CPU_ID (REL gidx_l g)) in
      let new_granules := ((((st.(share)).(globals)).(g_granules)) # gidx_l == (g.[e_lock].[e_val] :< None)) in
      let new_st := (st.[share].[globals].[g_granules] :< new_granules) in
      (Some ((new_st.[log] :< (e :: ((new_st.(log))))).[halt] :< false)))
    else (
      if ((lock.(pbase)) =s ("vmid_lock"))
      then (
        when st1 == ((query_oracle st));
        when cid == ((load_s_spinlock_t 8 (lock.(poffset)) (((st.(share)).(globals)).(g_vmid_lock))));
        let e := (EVT CPU_ID (REL vmid_lock_idx vmid_lock_g)) in
        let new_st := (st1.[share].[globals].[g_vmid_lock].[e_val] :< None) in
        (Some ((new_st.[log] :< (e :: ((new_st.(log))))).[halt] :< false)))
      else None).

  Definition spinlock_acquire_spec (lock: Ptr) (st: RData) : (option RData) :=
    if ((lock.(pbase)) =s ("granules"))
    then (
      let ofs := (lock.(poffset)) in
      let gidx_l := (ofs / (16)) in
      when st1 == ((query_oracle st));
      let g := ((((st1.(share)).(globals)).(g_granules)) @ gidx_l) in
      match (((g.(e_lock)).(e_val))) with
      | None =>
        let e := (EVT CPU_ID (ACQ gidx_l)) in
        let new_granules := ((((st1.(share)).(globals)).(g_granules)) # gidx_l == (g.[e_lock].[e_val] :< (Some CPU_ID))) in
        let new_st := (st1.[share].[globals].[g_granules] :< new_granules) in
        rely (((((((st.(share)).(globals)).(g_granules)) @ gidx_l).(e_state_s_granule)) = ((g.(e_state_s_granule)))));
        (Some ((new_st.[log] :< (e :: ((new_st.(log))))).[halt] :< false))
      | (Some cid) => None
      end)
    else (
      if ((lock.(pbase)) =s ("vmid_lock"))
      then (
        when st1 == ((query_oracle st));
        match ((load_s_spinlock_t 8 (lock.(poffset)) (((st.(share)).(globals)).(g_vmid_lock)))) with
        | None =>
          let e := (EVT CPU_ID (ACQ vmid_lock_idx)) in
          let new_st := (st1.[share].[globals].[g_vmid_lock].[e_val] :< (Some CPU_ID)) in
          (Some ((new_st.[log] :< (e :: ((new_st.(log))))).[halt] :< false))
        | (Some cid) => None
        end)
      else None).

  Definition granule_try_lock_spec' (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    if (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) - (v_1)) =? (0))
    then (Some (true, st))
    else (Some (false, st)).

  Definition granule_try_lock_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_0.(pbase)) =s ("granules"))
    then (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      rely (
        (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) -
          (((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)))) =
          (0)));
      rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
      if ((((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) - (v_1)) =? (0))
      then (
        (Some (
          true  ,
          ((((lens 2 st).[halt] :< false).[log] :< ((EVT CPU_ID (ACQ ((v_0.(poffset)) / (16)))) :: (((lens 2 st).(log))))).[share].[globals].[g_granules] :<
            (((((lens 2 st).(share)).(globals)).(g_granules)) #
              ((v_0.(poffset)) / (16)) ==
              ((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))
        )))
      else (
        (Some (
          false  ,
          ((((lens 2 st).[halt] :< false).[log] :<
            ((EVT CPU_ID (REL ((v_0.(poffset)) / (16)) ((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ ((v_0.(poffset)) / (16)))) :: (((lens 2 st).(log))))))).[share].[globals].[g_granules] :<
            (((((lens 2 st).(share)).(globals)).(g_granules)) #
              ((v_0.(poffset)) / (16)) ==
              ((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).[e_lock].[e_val] :< None)))
        ))))
    else None.

End Layer3_Spec.

#[global] Hint Unfold spinlock_release_spec: spec.
#[global] Hint Unfold spinlock_acquire_spec: spec.
#[global] Hint Unfold granule_try_lock_spec': spec.
#[global] Hint Unfold granule_try_lock_spec: spec.
