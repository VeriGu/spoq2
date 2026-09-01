Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_s2tte_is_table_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_table_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    let v_3 := (v_0 & (3)) in
    let v_4 := (v_1 <? (3)) in
    let v_5 := (v_3 =? (3)) in
    let v_or_cond := (v_4 && (v_5)) in
    let __return__ := true in
    let __retval__ := v_or_cond in
    (Some (__retval__, st)).

End Layer5_s2tte_is_table_LowSpec.

#[global] Hint Unfold s2tte_is_table_spec_low: spec.
