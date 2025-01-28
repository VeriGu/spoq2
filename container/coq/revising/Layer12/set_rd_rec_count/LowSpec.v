Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_set_rd_rec_count_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition set_rd_rec_count_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((__sca_write64_release_spec (ptr_offset v_0 8) v_1 st));
    (Some st_0).

End Layer12_set_rd_rec_count_LowSpec.

#[global] Hint Unfold set_rd_rec_count_spec_low: spec.
