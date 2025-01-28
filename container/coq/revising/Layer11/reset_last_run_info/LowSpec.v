Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_reset_last_run_info_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition reset_last_run_info_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((store_RData 8 (ptr_offset v_0 952) 0 st));
    (Some st_0).

End Layer11_reset_last_run_info_LowSpec.

#[global] Hint Unfold reset_last_run_info_spec_low: spec.
