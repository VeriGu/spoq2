Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import MmapInternal.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Mmap_buffer_unmap_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition buffer_unmap_spec_low (v_buf: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((buffer_unmap_internal_spec v_buf st));
    (Some st_0).

End Mmap_buffer_unmap_LowSpec.

#[global] Hint Unfold buffer_unmap_spec_low: spec.
