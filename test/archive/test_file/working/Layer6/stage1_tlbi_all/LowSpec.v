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
    when st == ((iasm_258_spec st));
    when st == ((iasm_10_spec st));
    when st == ((iasm_12_isb_spec st));
    let __return__ := true in
    (Some st).

End Layer6_stage1_tlbi_all_LowSpec.

#[global] Hint Unfold stage1_tlbi_all_spec_low: spec.
