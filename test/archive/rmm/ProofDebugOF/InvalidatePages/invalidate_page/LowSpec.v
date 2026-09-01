Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section InvalidatePages_invalidate_page_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition invalidate_page_spec_low (v_s2_ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
    when st_0 == ((stage2_tlbi_ipa_spec v_s2_ctx v_addr 4096 st));
    (Some st_0).

End InvalidatePages_invalidate_page_LowSpec.

#[global] Hint Unfold invalidate_page_spec_low: spec.
