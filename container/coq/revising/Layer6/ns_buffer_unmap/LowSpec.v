Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_ns_buffer_unmap_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ns_buffer_unmap_spec_low (v_0: Z) (st: RData) : (option RData) :=
    when v_2, st_0 == ((slot_to_va_spec v_0 st));
    (Some st_0).

End Layer6_ns_buffer_unmap_LowSpec.

#[global] Hint Unfold ns_buffer_unmap_spec_low: spec.
