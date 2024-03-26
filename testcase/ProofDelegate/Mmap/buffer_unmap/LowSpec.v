Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Mmap_buffer_unmap_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition buffer_unmap_spec_low (v_buf: Ptr) (st: RData) : (option RData) :=
    when st == ((buffer_unmap_internal_spec v_buf st));
    let __return__ := true in
    (Some st).

End Mmap_buffer_unmap_LowSpec.

#[global] Hint Unfold buffer_unmap_spec_low: spec.
