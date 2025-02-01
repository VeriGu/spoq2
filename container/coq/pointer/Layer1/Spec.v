Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer1_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_addr_spec_abs (v_0: Ptr) (st: RData) : (option (abs_PA_t * RData)) :=
    (Some ((mkabs_PA_t (v_0.(poffset))), st)).

  Definition buffer_map_spec_abs (v_0: Z) (v_1: abs_PA_t) (v_2: bool) (st: RData) : (option (Ptr * RData)) :=
    (Some ((mkPtr "granule_data" (v_1.(meta_granule_offset))), st)).

  Definition granule_addr_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    if (((ptr_to_int v_0) - ((ptr_to_int (mkPtr "granules" 0)))) >? (8388592))
    then (Some (((((ptr_to_int v_0) - ((ptr_to_int (mkPtr "granules" 0)))) * (256)) + (549755813888)), st))
    else (Some (((((ptr_to_int v_0) - ((ptr_to_int (mkPtr "granules" 0)))) * (256)) + (2147483648)), st)).

  Definition buffer_map_spec (v_0: Z) (v_1: Z) (v_2: bool) (st: RData) : (option (Ptr * RData)) :=
    if ((v_1 & (549755813888)) =? (0))
    then (Some ((int_to_ptr (v_1 + (18446744004990074880))), st))
    else (Some ((int_to_ptr (v_1 + (18446743457381744640))), st)).

End Layer1_Spec.

#[global] Hint Unfold granule_addr_spec_abs: spec.
#[global] Hint Unfold buffer_map_spec_abs: spec.
#[global] Hint Unfold granule_addr_spec: spec.
#[global] Hint Unfold buffer_map_spec: spec.
