Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Mmap.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MemRW_granule_memzero_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_memzero_spec_low (v_g: Ptr) (v_slot: Z) (st: RData) : (option RData) :=
    when v_call, st == ((granule_map_spec v_g v_slot st));
    when v_call1, st == ((memset_spec v_call 0 4096 st));
    when st == ((buffer_unmap_spec v_call st));
    let __return__ := true in
    (Some st).

End MemRW_granule_memzero_LowSpec.

#[global] Hint Unfold granule_memzero_spec_low: spec.
