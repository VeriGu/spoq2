Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_make_return_code_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition make_return_code_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    let v__sroa_2_0_insert_ext := v_1 in
    let v__sroa_2_0_insert_shift := (v__sroa_2_0_insert_ext << (32)) in
    let v__sroa_0_0_insert_ext := v_0 in
    let v__sroa_0_0_insert_insert := (v__sroa_2_0_insert_shift + (v__sroa_0_0_insert_ext)) in
    let __return__ := true in
    let __retval__ := v__sroa_0_0_insert_insert in
    (Some (__retval__, st)).

End Layer5_make_return_code_LowSpec.

#[global] Hint Unfold make_return_code_spec_low: spec.
