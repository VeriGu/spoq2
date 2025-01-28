Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_stage1_tlbi_all_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition stage1_tlbi_all_spec_low (st: RData) : (option RData) :=
    when st_0 == ((iasm_258_spec st));
    when st_1 == ((iasm_10_spec st_0));
    when st_2 == ((iasm_12_isb_spec st_1));
    (Some st_2).

End Layer6_stage1_tlbi_all_LowSpec.

#[global] Hint Unfold stage1_tlbi_all_spec_low: spec.
