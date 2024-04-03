Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleLock_granule_lock_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_lock_spec_low (v_g: Ptr) (v_expected_state: Z) (st: RData) : (option RData) :=
    when v_call, st == ((granule_lock_on_state_match_spec v_g v_expected_state st));
    let __return__ := true in
    (Some st).

End GranuleLock_granule_lock_LowSpec.

#[global] Hint Unfold granule_lock_spec_low: spec.
