Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2_Spec.

  Context `{int_ptr: IntPtrCast}.

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
    (Some ((ptr_offset (mkPtr "granules" 0) (16 * (v_0))), st)).

  Definition granule_map_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))) /\ ((v_1 >= (0)))) /\ ((v_1 <= (24)))));
    when v_3, st_0 == ((granule_addr_spec v_0 st));
    when v_4, st_1 == ((buffer_map_spec v_1 v_3 false st_0));
    (Some (v_4, st_1)).

  Definition granule_get_state_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_3, st_0 == ((load_RData 4 (ptr_offset v_0 4) st));
    (Some (v_3, st_0)).

  Definition __tte_read_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when v_2, st_0 == ((__sca_read64_spec v_0 st));
    (Some (v_2, st_0)).

End Layer2_Spec.

#[global] Hint Unfold addr_to_idx_spec: spec.
#[global] Hint Unfold addr_level_mask_spec: spec.
#[global] Hint Unfold granule_from_idx_spec: spec.
#[global] Hint Unfold granule_map_spec: spec.
#[global] Hint Unfold granule_get_state_spec: spec.
Opaque __tte_read_spec.
