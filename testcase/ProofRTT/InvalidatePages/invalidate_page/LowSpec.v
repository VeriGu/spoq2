Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section InvalidatePages_invalidate_page_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition invalidate_page_spec_low (v_s2_ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
    when st == ((stage2_tlbi_ipa_spec v_s2_ctx v_addr 4096 st));
    let __return__ := true in
    (Some st).

End InvalidatePages_invalidate_page_LowSpec.

#[global] Hint Unfold invalidate_page_spec_low: spec.
