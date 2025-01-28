Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s1tte_create_valid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s1tte_create_valid_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if (v_1 =? (3))
    then (Some ((v_0 |' (1795)), st))
    else (Some ((v_0 |' (1793)), st)).

End Layer6_s1tte_create_valid_LowSpec.

#[global] Hint Unfold s1tte_create_valid_spec_low: spec.
