Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_status_ptr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition status_ptr_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some ((int_to_ptr (0 - (v_0))), st)).

End Layer11_status_ptr_LowSpec.

#[global] Hint Unfold status_ptr_spec_low: spec.
