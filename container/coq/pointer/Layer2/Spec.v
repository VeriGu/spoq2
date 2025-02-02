Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter abs_tte_read : Ptr -> (RData -> abs_PTE_t).

Section Layer2_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition __tte_read_spec (ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    None.

  Definition abs__tte_read_spec (ptr: Ptr) (st: RData) : (option (abs_PTE_t * RData)) :=
    (Some ((abs_tte_read ptr st), st)).

  Definition addr_to_idx_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 >=? (MEM1_PHYS))
    then (
      let mem1_id := ((v_0 + ((- MEM1_PHYS))) >> ((12 + (524288)))) in
      (Some ((mem1_id * (16)), st)))
    else (
      let mem0_id := ((v_0 + ((- MEM0_PHYS))) >> (12)) in
      (Some ((mem0_id * (16)), st))).

  Definition addr_level_mask_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 & (281474976710655)) & (((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))))), st)).

  Definition granule_from_idx_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    rely ((((v_0 - (NR_GRANULES)) < (0)) /\ ((v_0 >= (0)))));
    (Some ((mkPtr "granules" (16 * (v_0))), st)).

  Definition granule_map_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some ((mkPtr "granule_data" (v_0.(poffset))), st)).

  Definition granule_get_state_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_3, st_0 == ((load_RData 4 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (4))) st));
    (Some (v_3, st_0)).

End Layer2_Spec.

#[global] Hint Unfold __tte_read_spec: spec.
#[global] Hint Unfold abs__tte_read_spec: spec.
#[global] Hint Unfold addr_to_idx_spec: spec.
#[global] Hint Unfold addr_level_mask_spec: spec.
#[global] Hint Unfold granule_from_idx_spec: spec.
#[global] Hint Unfold granule_map_spec: spec.
#[global] Hint Unfold granule_get_state_spec: spec.
