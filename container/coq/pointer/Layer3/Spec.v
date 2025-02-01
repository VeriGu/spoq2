Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer3_Spec.

  Context `{int_ptr: IntPtrCast}.

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
    when st_0 == (
        if ((v_0.(pbase)) =s ("granules"))
        then (
          match (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_lock)).(e_val))) with
          | None =>
            rely (
              (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) -
                ((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)))) =
                (0)));
            (Some ((st.[log] :< ((EVT CPU_ID (ACQ ((v_0.(poffset)) / (16)))) :: ((st.(log))))).[share].[globals].[g_granules] :<
              ((((st.(share)).(globals)).(g_granules)) #
                ((v_0.(poffset)) / (16)) ==
                (((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))
          | (Some cid) => None
          end)
        else (
          if ((v_0.(pbase)) =s ("vmid_lock"))
          then (
            match (
              if ((v_0.(poffset)) =? (0))
              then ((((st.(share)).(globals)).(g_vmid_lock)).(e_val))
              else None
            ) with
            | None => (Some ((st.[log] :< ((EVT CPU_ID (ACQ vmid_lock_idx)) :: ((st.(log))))).[share].[globals].[g_vmid_lock].[e_val] :< (Some CPU_ID)))
            | (Some cid) => None
            end)
          else None));
    if (((((((st_0.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) - (v_1)) =? (0))
    then (Some (true, st_0))
    else (
      when st_2 == (
          if ((v_0.(pbase)) =s ("granules"))
          then (
            when cid == (((((((st_0.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_lock)).(e_val)));
            (Some ((st_0.[log] :< ((EVT CPU_ID (REL ((v_0.(poffset)) / (16)) ((((st_0.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))))) :: ((st_0.(log))))).[share].[globals].[g_granules] :<
              ((((st_0.(share)).(globals)).(g_granules)) #
                ((v_0.(poffset)) / (16)) ==
                (((((st_0.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).[e_lock].[e_val] :< None)))))
          else (
            if ((v_0.(pbase)) =s ("vmid_lock"))
            then (
              when cid == (
                  if ((v_0.(poffset)) =? (0))
                  then ((((st_0.(share)).(globals)).(g_vmid_lock)).(e_val))
                  else None);
              (Some ((st_0.[log] :< ((EVT CPU_ID (REL vmid_lock_idx vmid_lock_g)) :: ((st_0.(log))))).[share].[globals].[g_vmid_lock].[e_val] :< None)))
            else None));
      (Some (false, st_2))).

End Layer3_Spec.

#[global] Hint Unfold addr_to_granule_spec_abs: spec.
#[global] Hint Unfold spinlock_release_spec: spec.
#[global] Hint Unfold spinlock_acquire_spec: spec.
#[global] Hint Unfold block_granule_try_lock_spec: spec.
#[global] Hint Unfold __table_get_entry_spec_abs: spec.
#[global] Hint Unfold entry_is_table_spec_abs: spec.
#[global] Hint Unfold table_entry_to_phys_spec_abs: spec.
#[global] Hint Unfold table_entry_to_phys_spec: spec.
#[global] Hint Unfold addr_to_granule_spec: spec.
#[global] Hint Unfold __table_get_entry_spec: spec.
#[global] Hint Unfold entry_is_table_spec: spec.
Opaque granule_try_lock_spec.
