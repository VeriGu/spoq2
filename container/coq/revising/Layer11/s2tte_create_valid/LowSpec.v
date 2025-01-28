Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_s2tte_create_valid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_create_valid_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if (v_1 =? (3))
    then (Some ((v_0 |' (2047)), st))
    else (Some ((v_0 |' (2045)), st)).

End Layer11_s2tte_create_valid_LowSpec.

#[global] Hint Unfold s2tte_create_valid_spec_low: spec.
