Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s2tte_pa_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_pa_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_4, st == ((s2tte_is_table_spec v_0 v_1 st));
    when v__0, st == (
        let v__0 := 0 in
        if v_4
        then (
          when v_6, st == ((addr_level_mask_spec v_0 3 st));
          let v__0 := v_6 in
          (Some (v__0, st)))
        else (
          when v_8, st == ((addr_level_mask_spec v_0 v_1 st));
          let v__0 := v_8 in
          (Some (v__0, st))));
    let __return__ := true in
    let __retval__ := v__0 in
    (Some (__retval__, st)).

End Layer6_s2tte_pa_LowSpec.

#[global] Hint Unfold s2tte_pa_spec_low: spec.
