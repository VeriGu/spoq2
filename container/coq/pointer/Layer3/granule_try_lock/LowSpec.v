Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer3_granule_try_lock_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_try_lock_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when st_0 == ((spinlock_acquire_spec (ptr_offset v_0 0) st));
    if (((((((st_0.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) - (v_1)) =? (0))
    then (Some (true, st_0))
    else (
      when st_2 == ((spinlock_release_spec (ptr_offset v_0 0) st_0));
      (Some (false, st_2))).

End Layer3_granule_try_lock_LowSpec.

#[global] Hint Unfold granule_try_lock_spec_low: spec.
