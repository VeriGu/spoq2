Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section InvalidatePages_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition invalidate_page_spec (v_s2_ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition invalidate_pages_in_block_spec (v_s2_ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition invalidate_block_spec (v_s2_ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
    (Some st).

End InvalidatePages_Spec.

#[global] Hint Unfold invalidate_page_spec: spec.
#[global] Hint Unfold invalidate_pages_in_block_spec: spec.
#[global] Hint Unfold invalidate_block_spec: spec.
