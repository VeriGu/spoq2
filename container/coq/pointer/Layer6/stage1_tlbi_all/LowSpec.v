Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_stage1_tlbi_all_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition stage1_tlbi_all_spec_low (st: RData) : (option RData) :=
    (Some st).

End Layer6_stage1_tlbi_all_LowSpec.

#[global] Hint Unfold stage1_tlbi_all_spec_low: spec.
