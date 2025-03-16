Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import MmapInternal.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Mmap_granule_map_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_map_spec_low (v_g: Ptr) (v_slot: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st_0 == ((granule_addr_spec v_g st));
    when v_call1, st_1 == ((buffer_map_internal_spec v_slot v_call st_0));
    (Some (v_call1, st_1)).

End Mmap_granule_map_LowSpec.

#[global] Hint Unfold granule_map_spec_low: spec.
