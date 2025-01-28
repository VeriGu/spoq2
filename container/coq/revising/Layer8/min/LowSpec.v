Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_min_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition min_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 - (v_1)) <? (0))
    then (
      if ((v_0 - (v_2)) <? (0))
      then (Some (v_0, st))
      else (Some (v_2, st)))
    else (
      if ((v_1 - (v_2)) <? (0))
      then (Some (v_1, st))
      else (Some (v_2, st))).

End Layer8_min_LowSpec.

#[global] Hint Unfold min_spec_low: spec.
