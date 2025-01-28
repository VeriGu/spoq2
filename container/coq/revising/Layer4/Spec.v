Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer4_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition atomic_add_64_spec (loc: Ptr) (val: Z) (st: RData) : (option RData) :=
    when v, st == ((load_RData 64 loc st));
    when st == ((store_RData 64 loc (v + (val)) st));
    (Some st).

  Definition cpuid_spec (st: RData) : (option (Z * RData)) :=
    (Some (CPU_ID, st)).

  Definition find_granule_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    if (v_0 >=? (MEM1_PHYS))
    then (
      let mem1_id := ((v_0 + ((- MEM1_PHYS))) >> ((12 + (524288)))) in
      (Some ((mkPtr "granules" (mem1_id * (16))), st)))
    else (
      let mem0_id := ((v_0 + ((- MEM0_PHYS))) >> (12)) in
      (Some ((mkPtr "granules" (mem0_id * (16))), st))).

  Definition __find_next_level_idx_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_3, st_0 == ((__table_get_entry_spec v_0 v_1 st));
    when v_4, st_1 == ((entry_is_table_spec v_3 st_0));
    if v_4
    then (
      when v_7, st_2 == ((table_entry_to_phys_spec v_3 st_1));
      when v_8, st_3 == ((addr_to_granule_spec v_7 st_2));
      (Some (v_8, st_3)))
    else (Some ((mkPtr "null" 0), st_1)).

  Definition s2_addr_to_idx_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 >> (((39 + (((- 9) * (v_1)))) & (4294967295)))) & (511)), st)).

  Definition granule_lock_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when v_3, st_0 == ((granule_try_lock_spec v_0 v_1 st));
    (Some st_0).


  Definition s2tte_create_ripas_spec' (v_0: Z) : (option Z) :=
    if (v_0 =? (0))
    then (Some 0)
    else (Some 64).
  Definition s2tte_create_ripas_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_create_ripas_spec' v_0));
    (Some (ret, st)).
  (* Definition s2tte_create_ripas_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 =? (0))
    then (Some (0, st))
    else (Some (64, st)). *)

End Layer4_Spec.

#[global] Hint Unfold atomic_add_64_spec: spec.
#[global] Hint Unfold cpuid_spec: spec.
#[global] Hint Unfold find_granule_spec: spec.
#[global] Hint Unfold __find_next_level_idx_spec: spec.
#[global] Hint Unfold s2_addr_to_idx_spec: spec.
#[global] Hint Unfold granule_lock_spec: spec.
#[global] Hint Unfold s2tte_create_ripas_spec: spec.
