Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_clear_tte_ns_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition clear_tte_ns_spec_low (v_0: Z) (st: RData) : (option RData) :=
    if ((v_0 & (549755813888)) =? (0))
    then (
      when v_8, st_1 == ((get_tte_spec (v_0 + (18446744004990074880)) st));
      when v_9, st_2 == ((__tte_read_spec v_8 st_1));
      when st_3 == ((__tte_write_spec v_8 (v_9 & ((- 33))) st_2));
      when st_4 == ((iasm_8_spec st_3));
      when st_5 == ((iasm_9_spec ((v_0 + (18446744004990074880)) >> (12)) st_4));
      when st_6 == ((iasm_10_spec st_5));
      when st_7 == ((iasm_12_isb_spec st_6));
      when st_8 == ((iasm_12_spec st_7));
      (Some st_8))
    else (
      when v_8, st_1 == ((get_tte_spec (v_0 + (18446743457381744640)) st));
      when v_9, st_2 == ((__tte_read_spec v_8 st_1));
      when st_3 == ((__tte_write_spec v_8 (v_9 & ((- 33))) st_2));
      when st_4 == ((iasm_8_spec st_3));
      when st_5 == ((iasm_9_spec ((v_0 + (18446743457381744640)) >> (12)) st_4));
      when st_6 == ((iasm_10_spec st_5));
      when st_7 == ((iasm_12_isb_spec st_6));
      when st_8 == ((iasm_12_spec st_7));
      (Some st_8)).

End Layer8_clear_tte_ns_LowSpec.

#[global] Hint Unfold clear_tte_ns_spec_low: spec.
