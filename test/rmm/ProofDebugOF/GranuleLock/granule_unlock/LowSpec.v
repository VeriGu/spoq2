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
    when st_0 == ((spinlock_release_spec (ptr_offset v_g 0) st));
    (Some st_0).

End GranuleLock_granule_unlock_LowSpec.

#[global] Hint Unfold granule_unlock_spec_low: spec.
