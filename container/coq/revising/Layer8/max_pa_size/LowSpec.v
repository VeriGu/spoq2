Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_max_pa_size_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition max_pa_size_spec_low (st: RData) : (option (Z * RData)) :=
    when v_1, st_0 == ((iasm_74_spec st));
    if ((v_1 & (15)) =? (6))
    then (Some (48, st_0))
    else (
      if ((v_1 & (15)) =? (0))
      then (Some (32, st_0))
      else (
        if ((v_1 & (15)) =? (1))
        then (Some (36, st_0))
        else (
          if ((v_1 & (15)) =? (2))
          then (Some (40, st_0))
          else (
            if ((v_1 & (15)) =? (3))
            then (Some (42, st_0))
            else (
              if ((v_1 & (15)) =? (4))
              then (Some (44, st_0))
              else (
                if ((v_1 & (15)) =? (5))
                then (Some (48, st_0))
                else (Some (0, st_0)))))))).

End Layer8_max_pa_size_LowSpec.

#[global] Hint Unfold max_pa_size_spec_low: spec.
