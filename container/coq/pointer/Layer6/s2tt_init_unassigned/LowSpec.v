Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s2tt_init_unassigned_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tt_init_unassigned_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    (Some st).

End Layer6_s2tt_init_unassigned_LowSpec.

#[global] Hint Unfold s2tt_init_unassigned_spec_low: spec.
