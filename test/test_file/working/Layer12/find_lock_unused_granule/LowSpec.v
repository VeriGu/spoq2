Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.
Require Import Layer11.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_find_lock_unused_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_unused_granule_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_3, st == ((find_lock_granule_spec v_0 v_1 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    let v__not := (ptr_eqb v_3 (mkPtr "null" 0)) in
    when v__0, st == (
        let v__0 := (mkPtr "#" 0) in
        if v__not
        then (
          when v_5, st == ((status_ptr_spec 1 st));
          let v_6 := v_5 in
          let v__0 := v_6 in
          (Some (v__0, st)))
        else (
          when v_8, st == ((granule_refcount_read_acquire_spec v_3 st));
          let v__not7 := (v_8 =? (0)) in
          when v__0, st == (
              let v__0 := (mkPtr "#" 0) in
              if v__not7
              then (
                let v__0 := v_3 in
                (Some (v__0, st)))
              else (
                when st == ((granule_unlock_spec v_3 st));
                when v_10, st == ((status_ptr_spec 4 st));
                let v_11 := v_10 in
                let v__0 := v_11 in
                (Some (v__0, st))));
          (Some (v__0, st))));
    let __return__ := true in
    let __retval__ := v__0 in
    (Some (__retval__, st)).

End Layer12_find_lock_unused_granule_LowSpec.

#[global] Hint Unfold find_lock_unused_granule_spec_low: spec.
