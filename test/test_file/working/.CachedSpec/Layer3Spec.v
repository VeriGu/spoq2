Definition spinlock_release_spec (lock: Ptr) (st: RData) : (option RData) :=
  if ((lock.(pbase)) =s ("granules"))
  then (
    when cid == (((((((st.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).(e_lock)).(e_val)));
    (Some (st.[share].[globals].[g_granules] :<
      ((((st.(share)).(globals)).(g_granules)) #
        ((lock.(poffset)) / (4096)) ==
        (((((st.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).[e_lock].[e_val] :< None)))))
  else (
    if ((lock.(pbase)) =s ("vmid_lock"))
    then (
      when st1 == ((query_oracle st));
      rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
      if ((lock.(poffset)) =? (0))
      then (
        when cid == (((((st.(share)).(globals)).(g_vmid_lock)).(e_val)));
        (Some st1))
      else None)
    else None).

Definition spinlock_acquire_spec (lock: Ptr) (st: RData) : (option RData) :=
  if ((lock.(pbase)) =s ("granules"))
  then (
    when st1 == ((query_oracle st));
    rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
    match (((((((st1.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).(e_lock)).(e_val))) with
    | None =>
      rely (
        (((((((st.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).(e_state_s_granule)) -
          ((((((st1.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).(e_state_s_granule)))) =
          (0)));
      (Some (st1.[share].[globals].[g_granules] :<
        ((((st1.(share)).(globals)).(g_granules)) #
          ((lock.(poffset)) / (4096)) ==
          (((((st1.(share)).(globals)).(g_granules)) @ ((lock.(poffset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID)))))
    | (Some cid) => None
    end)
  else (
    if ((lock.(pbase)) =s ("vmid_lock"))
    then (
      when st1 == ((query_oracle st));
      rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
      if ((lock.(poffset)) =? (0))
      then (
        match (((((st.(share)).(globals)).(g_vmid_lock)).(e_val))) with
        | None => (Some st1)
        | (Some cid) => None
        end)
      else (Some st1))
    else None).

Definition granule_try_lock_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
  if ((v_0.(pbase)) =s ("granules"))
  then (
    when st1 == ((query_oracle st));
    rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
    match (((((((st1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_lock)).(e_val))) with
    | None =>
      rely (
        (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)) -
          ((((((st1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)))) =
          (0)));
      rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
      if (((((((st1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)) - (v_1)) =? (0))
      then (
        (Some (
          true  ,
          (st1.[share].[globals].[g_granules] :<
            ((((st1.(share)).(globals)).(g_granules)) #
              ((v_0.(poffset)) / (4096)) ==
              (((((st1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))
        )))
      else (
        (Some (
          false  ,
          (st1.[share].[globals].[g_granules] :<
            ((((st1.(share)).(globals)).(g_granules)) #
              ((v_0.(poffset)) / (4096)) ==
              (((((st1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).[e_lock].[e_val] :< None)))
        )))
    | (Some cid) => None
    end)
  else None.

Definition granule_try_lock_spec' (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
  rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
  if (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)) - (v_1)) =? (0))
  then (Some (true, st))
  else (Some (false, st)).

