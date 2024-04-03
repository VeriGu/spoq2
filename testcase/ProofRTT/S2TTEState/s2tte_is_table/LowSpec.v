Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_s2tte_is_table_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_table_spec_low (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    let v_and := (v_s2tte & (3)) in
    let v_cmp := (v_level <? (3)) in
    let v_cmp1 := (v_and =? (3)) in
    let v_or_cond := (v_cmp && (v_cmp1)) in
    let __return__ := true in
    let __retval__ := v_or_cond in
    (Some (__retval__, st)).

End S2TTEState_s2tte_is_table_LowSpec.

#[global] Hint Unfold s2tte_is_table_spec_low: spec.
