Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_access_mask_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition access_mask_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (((v_0 >> (22)) & (3)) =? (3))
    then (Some ((- 1), st))
    else (
      if (((v_0 >> (22)) & (3)) =? (0))
      then (Some (255, st))
      else (
        if (((v_0 >> (22)) & (3)) =? (1))
        then (Some (65535, st))
        else (
          if (((v_0 >> (22)) & (3)) =? (2))
          then (Some (4294967295, st))
          else (Some (0, st))))).

End Layer7_access_mask_LowSpec.

#[global] Hint Unfold access_mask_spec_low: spec.
