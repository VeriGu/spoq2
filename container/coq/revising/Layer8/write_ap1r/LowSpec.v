Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_write_ap1r_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition write_ap1r_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option RData) :=
    if (v_0 =? (0))
    then (
      when st_0 == ((iasm_285_spec v_1 st));
      (Some st_0))
    else (
      if (v_0 =? (3))
      then (
        when st_0 == ((iasm_286_spec v_1 st));
        (Some st_0))
      else (
        if (v_0 =? (2))
        then (
          when st_0 == ((iasm_287_spec v_1 st));
          (Some st_0))
        else (
          if (v_0 =? (1))
          then (
            when st_0 == ((iasm_288_spec v_1 st));
            (Some st_0))
          else (Some st)))).

End Layer8_write_ap1r_LowSpec.

#[global] Hint Unfold write_ap1r_spec_low: spec.
