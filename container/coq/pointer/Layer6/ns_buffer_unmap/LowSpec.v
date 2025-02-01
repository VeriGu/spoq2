Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_ns_buffer_unmap_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ns_buffer_unmap_spec_low (v_0: Z) (st: RData) : (option RData) :=
    (Some st).

End Layer6_ns_buffer_unmap_LowSpec.

#[global] Hint Unfold ns_buffer_unmap_spec_low: spec.
