Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.
Require Import Layer3.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_vmid_reserve_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition vmid_reserve_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    when v_2, st_0 == ((load_RData 4 (mkPtr "vmid_count" 0) st));
    if ((v_2 - (v_0)) >? (0))
    then (
      when st_1 == ((spinlock_acquire_spec (mkPtr "vmid_lock" 0) st_0));
      when v_5, st_2 == ((bitmap_test_and_set_spec (ptr_offset (mkPtr "vmids" 0) 0) v_0 st_1));
      when st_3 == ((spinlock_release_spec (mkPtr "vmid_lock" 0) st_2));
      (Some (true, st_3)))
    else (Some (false, st_0)).

End Layer11_vmid_reserve_LowSpec.

#[global] Hint Unfold vmid_reserve_spec_low: spec.
