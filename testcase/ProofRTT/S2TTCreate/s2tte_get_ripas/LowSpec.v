Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTCreate_s2tte_get_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_get_ripas_spec_low (v_s2tte: Z) (st: RData) : (option (Z * RData)) :=
    let v_and := (v_s2tte & (64)) in
    let v_cmp3 := (v_and =? (0)) in
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_cmp3
        then (
          let v_retval_0 := 0 in
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := 1 in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End S2TTCreate_s2tte_get_ripas_LowSpec.

#[global] Hint Unfold s2tte_get_ripas_spec_low: spec.
