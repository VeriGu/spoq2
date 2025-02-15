Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.

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
      (Some (new_st.[log] :< (e :: ((new_st.(log)))))))
    else Some (st).

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
    else Some (st).

  Definition granule_try_lock_spec' (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    if (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) - (v_1)) =? (0))
    then (Some (true, st))
    else (Some (false, st)).

  Definition table_entry_to_phys_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((addr_level_mask_spec v_0 3 st));
    (Some (v_2, st_0)).

  Definition addr_to_granule_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))));
    when v_2, st_0 == ((addr_to_idx_spec v_0 st));
    when v_4, st_1 == ((granule_from_idx_spec (v_2 & (4294967295)) st_0));
    (Some (v_4, st_1)).

  Definition __table_get_entry_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((granule_map_spec v_0 6 st));
    when v_6, st_1 == ((__tte_read_spec (ptr_offset v_3 (8 * (v_1))) st_0));
    (Some (v_6, st_1)).

  Definition entry_is_table_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (3)) =? (3)), st)).

  Definition granule_try_lock_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when st_0 == ((spinlock_acquire_spec (ptr_offset v_0 0) st));
    when v_4, st_1 == ((granule_get_state_spec v_0 st_0));
    if ((v_4 - (v_1)) =? (0))
    then (Some (true, st_1))
    else (
      when st_2 == ((spinlock_release_spec (ptr_offset v_0 0) st_1));
      (Some (false, st_2))).

End Layer3_Spec.

#[global] Hint Unfold spinlock_release_spec: spec.
#[global] Hint Unfold spinlock_acquire_spec: spec.
#[global] Hint Unfold granule_try_lock_spec': spec.
#[global] Hint Unfold table_entry_to_phys_spec: spec.
#[global] Hint Unfold addr_to_granule_spec: spec.
#[global] Hint Unfold __table_get_entry_spec: spec.
#[global] Hint Unfold entry_is_table_spec: spec.
#[global] Hint Unfold granule_try_lock_spec: spec.
