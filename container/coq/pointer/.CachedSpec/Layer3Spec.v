Definition addr_to_granule_spec_abs (v_0: abs_PA_t) (st: RData) : (option (Ptr * RData)) :=
  (Some ((mkPtr "granules" (v_0.(meta_granule_offset))), st)).

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
    (Some (new_st.[log] :< (e :: ((new_st.(log)))))))
  else (
    if ((lock.(pbase)) =s ("vmid_lock"))
    then (
      when st1 == ((query_oracle st));
      when cid == ((load_s_spinlock_t 8 (lock.(poffset)) (((st.(share)).(globals)).(g_vmid_lock))));
      let e := (EVT CPU_ID (REL vmid_lock_idx vmid_lock_g)) in
      let new_st := (st1.[share].[globals].[g_vmid_lock].[e_val] :< None) in
      (Some (new_st.[log] :< (e :: ((new_st.(log)))))))
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
      (Some (new_st.[log] :< (e :: ((new_st.(log))))))
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
        (Some (new_st.[log] :< (e :: ((new_st.(log))))))
      | (Some cid) => None
      end)
    else None).

Definition block_granule_try_lock_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
  if (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) - (v_1)) =? (0))
  then (Some (true, st))
  else (Some (false, st)).

Definition __table_get_entry_spec_abs (v_0: Ptr) (v_1: Z) (st: RData) : (option (abs_PTE_t * RData)) :=
  when v_3, st_0 == ((granule_map_spec v_0 6 st));
  when v_6, st_1 == ((abs__tte_read_spec (ptr_offset v_3 (8 * (v_1))) st_0));
  (Some (v_6, st_1)).

Definition entry_is_table_spec_abs (v_0: abs_PTE_t) (st: RData) : (option (bool * RData)) :=
  (Some (((v_0.(meta_desc_type)) =? (3)), st)).

Definition table_entry_to_phys_spec_abs (v_0: abs_PTE_t) (st: RData) : (option (abs_PA_t * RData)) :=
  (Some ((v_0.(meta_PA)), st)).

Definition table_entry_to_phys_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_0 & (281474976710655)) & (((- 1) << (12)))), st)).

Definition addr_to_granule_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
  None.

Definition __table_get_entry_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
  None.

Definition entry_is_table_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_0 & (3)) =? (3)), st)).

Definition granule_try_lock_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
  when st_0 == ((spinlock_acquire_spec (mkPtr (v_0.(pbase)) (v_0.(poffset))) st));
  if (((((((st_0.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) - (v_1)) =? (0))
  then (Some (true, st_0))
  else (
    when st_2 == ((spinlock_release_spec (mkPtr (v_0.(pbase)) (v_0.(poffset))) st_0));
    (Some (false, st_2))).

