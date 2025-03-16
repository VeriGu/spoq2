Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

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

  Definition granule_from_idx_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    rely ((((v_0 - (NR_GRANULES)) < (0)) /\ ((v_0 >= (0)))));
    (Some ((mkPtr "granules" (16 * (v_0))), st)).

  Definition granule_map_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))) /\ ((v_1 >= (0)))) /\ ((v_1 <= (24)))));
    if (((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) >? (8388592))
    then (
      rely (
        (((((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (549755813888)) - (MEM0_PHYS)) >= (0)) /\
          (((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (549755813888)) - ((MEM0_PHYS + (MEM0_SIZE)))) < (0)))) /\
          (((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (549755813888)) & (549755813888)) = (0)))) \/
          (((((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (549755813888)) - (MEM1_PHYS)) >= (0)) /\
            (((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (549755813888)) - ((MEM1_PHYS + (MEM1_SIZE)))) < (0)))) /\
            (((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (549755813888)) & (549755813888)) = (1)))))));
      rely (
        ((((int_to_ptr (((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (549755813888)) + (18446743457381744640))).(pbase)) = ("granule_data")) /\
          ((((int_to_ptr (((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (549755813888)) + (18446743457381744640))).(poffset)) >= (0)))));
      (Some ((int_to_ptr (((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (549755813888)) + (18446743457381744640))), st)))
    else (
      rely (
        (((((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (2147483648)) - (MEM0_PHYS)) >= (0)) /\
          (((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (2147483648)) - ((MEM0_PHYS + (MEM0_SIZE)))) < (0)))) /\
          (((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (2147483648)) & (549755813888)) = (0)))) \/
          (((((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (2147483648)) - (MEM1_PHYS)) >= (0)) /\
            (((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (2147483648)) - ((MEM1_PHYS + (MEM1_SIZE)))) < (0)))) /\
            (((((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (2147483648)) & (549755813888)) = (1)))))));
      rely (
        ((((int_to_ptr (((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (2147483648)) + (18446744004990074880))).(pbase)) = ("granule_data")) /\
          ((((int_to_ptr (((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (2147483648)) + (18446744004990074880))).(poffset)) >= (0)))));
      (Some ((int_to_ptr (((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (2147483648)) + (18446744004990074880))), st))).

  Definition granule_get_state_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    (Some ((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (4)) / (16))).(e_state_s_granule)), st)).

End Layer2_Spec.

#[global] Hint Unfold addr_to_idx_spec: spec.
#[global] Hint Unfold granule_from_idx_spec: spec.
#[global] Hint Unfold granule_map_spec: spec.
#[global] Hint Unfold granule_get_state_spec: spec.
