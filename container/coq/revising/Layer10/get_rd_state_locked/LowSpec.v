Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_get_rd_state_locked_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_rd_state_locked_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((__sca_read64_spec (ptr_offset v_0 0) st));
    (Some (v_3, st_0)).

End Layer10_get_rd_state_locked_LowSpec.

#[global] Hint Unfold get_rd_state_locked_spec_low: spec.
