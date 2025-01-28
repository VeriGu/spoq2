Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer3.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_vmid_free_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition vmid_free_spec_low (v_0: Z) (st: RData) : (option RData) :=
    when st_0 == ((spinlock_acquire_spec (mkPtr "vmid_lock" 0) st));
    when st_1 == ((bitmap_clear_spec (ptr_offset (mkPtr "vmids" 0) 0) v_0 st_0));
    when st_2 == ((spinlock_release_spec (mkPtr "vmid_lock" 0) st_1));
    (Some st_2).

End Layer12_vmid_free_LowSpec.

#[global] Hint Unfold vmid_free_spec_low: spec.
