Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12___granule_refcount_dec_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __granule_refcount_dec_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((atomic_add_64_spec (ptr_offset v_0 8) 18446744073709551104 st));
    (Some st_0).

End Layer12___granule_refcount_dec_LowSpec.

#[global] Hint Unfold __granule_refcount_dec_spec_low: spec.
