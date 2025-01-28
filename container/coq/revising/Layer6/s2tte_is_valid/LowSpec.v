Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s2tte_is_valid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_valid_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_0 & (36028797018963968)) =? (0))
    then (
      if ((v_1 =? (3)) && (((v_0 & (3)) =? (3))))
      then (Some (true, st))
      else (
        if ((v_1 <>? (3)) && (((v_0 & (3)) =? (1))))
        then (Some (true, st))
        else (Some (false, st))))
    else (Some (false, st)).

End Layer6_s2tte_is_valid_LowSpec.

#[global] Hint Unfold s2tte_is_valid_spec_low: spec.
