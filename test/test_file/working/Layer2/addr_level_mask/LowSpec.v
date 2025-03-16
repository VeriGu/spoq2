Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2_addr_level_mask_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_level_mask_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    let v_3 := (3 - (v_1)) in
    let v_4 := (v_3 * (9)) in
    let v_5 := (v_4 + (12)) in
    let v_6 := (v_5 & (4294967295)) in
    let v_7 := ((- 1) << (v_6)) in
    let v_8 := (v_0 & (281474976710655)) in
    let v_9 := (v_8 & (v_7)) in
    let __return__ := true in
    let __retval__ := v_9 in
    (Some (__retval__, st)).

End Layer2_addr_level_mask_LowSpec.

#[global] Hint Unfold addr_level_mask_spec_low: spec.
