Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_access_len_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition access_len_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((esr_sas_spec v_0 st));
    if (v_2 =? (3))
    then (Some (8, st_0))
    else (
      if (v_2 =? (0))
      then (Some (1, st_0))
      else (
        if (v_2 =? (1))
        then (Some (2, st_0))
        else (
          if (v_2 =? (2))
          then (Some (4, st_0))
          else (Some (0, st_0))))).

End Layer8_access_len_LowSpec.

#[global] Hint Unfold access_len_spec_low: spec.
