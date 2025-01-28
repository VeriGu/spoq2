Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_invalidate_page_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition invalidate_page_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((stage2_tlbi_ipa_spec v_0 v_1 4096 st));
    (Some st_0).

End Layer11_invalidate_page_LowSpec.

#[global] Hint Unfold invalidate_page_spec_low: spec.
