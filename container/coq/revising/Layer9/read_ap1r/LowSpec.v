Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_read_ap1r_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition read_ap1r_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 =? (0))
    then (
      when v_9, st_0 == ((iasm_102_spec st));
      (Some (v_9, st_0)))
    else (
      if (v_0 =? (3))
      then (
        when v_3, st_0 == ((iasm_103_spec st));
        (Some (v_3, st_0)))
      else (
        if (v_0 =? (2))
        then (
          when v_5, st_0 == ((iasm_104_spec st));
          (Some (v_5, st_0)))
        else (
          if (v_0 =? (1))
          then (
            when v_7, st_0 == ((iasm_105_spec st));
            (Some (v_7, st_0)))
          else (Some (0, st))))).

End Layer9_read_ap1r_LowSpec.

#[global] Hint Unfold read_ap1r_spec_low: spec.
