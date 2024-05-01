Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleLock_granule_unlock_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_unlock_spec_low (v_g: Ptr) (st: RData) : (option RData) :=
    let v_lock := (ptr_offset v_g ((16 * (0)) + ((0 + (0))))) in
    when st == ((spinlock_release_spec v_lock st));
    let __return__ := true in
    (Some st).

End GranuleLock_granule_unlock_LowSpec.

#[global] Hint Unfold granule_unlock_spec_low: spec.
