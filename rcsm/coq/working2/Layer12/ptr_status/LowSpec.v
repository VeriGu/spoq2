Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_ptr_status_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ptr_status_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some ((0 - ((ptr_to_int v_0))), st)).

End Layer12_ptr_status_LowSpec.

#[global] Hint Unfold ptr_status_spec_low: spec.
