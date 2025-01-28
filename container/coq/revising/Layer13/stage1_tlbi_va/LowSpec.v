Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_stage1_tlbi_va_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition stage1_tlbi_va_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((iasm_261_spec (((v_0 >> (12)) & (17592186044415)) + ((v_1 << (48)))) st));
    when st_1 == ((iasm_10_spec st_0));
    when st_2 == ((iasm_12_isb_spec st_1));
    (Some st_2).

End Layer13_stage1_tlbi_va_LowSpec.

#[global] Hint Unfold stage1_tlbi_va_spec_low: spec.
