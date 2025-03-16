Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer1_buffer_map_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition buffer_map_spec_low (v_0: Z) (v_1: Z) (v_2: bool) (st: RData) : (option (Ptr * RData)) :=
    rely (
      ((((v_1 >= (MEM0_PHYS)) /\ ((v_1 < ((MEM0_PHYS + (MEM0_SIZE)))))) /\ (((v_1 & (549755813888)) = (0)))) \/
        ((((v_1 >= (MEM1_PHYS)) /\ ((v_1 < ((MEM1_PHYS + (MEM1_SIZE)))))) /\ (((v_1 & (549755813888)) = (1)))))));
    let v_4 := (v_1 & (549755813888)) in
    let v__not := (v_4 =? (0)) in
    when v__0_in, st == (
        let v__0_in := 0 in
        if v__not
        then (
          let v_8 := (v_1 + (18446744004990074880)) in
          let v__0_in := v_8 in
          (Some (v__0_in, st)))
        else (
          let v_6 := (v_1 + (18446743457381744640)) in
          let v__0_in := v_6 in
          (Some (v__0_in, st))));
    let v__0 := (int_to_ptr v__0_in) in
    let __return__ := true in
    let __retval__ := v__0 in
    (Some (__retval__, st)).

End Layer1_buffer_map_LowSpec.

#[global] Hint Unfold buffer_map_spec_low: spec.
