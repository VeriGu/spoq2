Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer4_s2tte_create_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_create_ripas_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    let v_2 := (v_0 =? (0)) in
    when v__0, st == (
        let v__0 := 0 in
        if v_2
        then (
          let v__0 := 0 in
          (Some (v__0, st)))
        else (
          let v__0 := 64 in
          (Some (v__0, st))));
    let __return__ := true in
    let __retval__ := v__0 in
    (Some (__retval__, st)).

End Layer4_s2tte_create_ripas_LowSpec.

#[global] Hint Unfold s2tte_create_ripas_spec_low: spec.
