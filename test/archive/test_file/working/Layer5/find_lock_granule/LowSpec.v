Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer3.Spec.
Require Import Layer4.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_find_lock_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_granule_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0 >= (MEM0_PHYS)) /\ ((v_0 < ((MEM0_PHYS + (MEM0_SIZE)))))) \/ (((v_0 >= (MEM1_PHYS)) /\ ((v_0 < ((MEM1_PHYS + (MEM1_SIZE)))))))) /\ (((v_0 & (4095)) = (0)))));
    when v_3, st == ((find_granule_spec v_0 st));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    let v__not := (ptr_eqb v_3 (mkPtr "null" 0)) in
    when v__0, st == (
        let v__0 := (mkPtr "#" 0) in
        if v__not
        then (
          let v__0 := (mkPtr "null" 0) in
          (Some (v__0, st)))
        else (
          when v_6, st == ((granule_try_lock_spec v_3 v_1 st));
          when v__0, st == (
              let v__0 := (mkPtr "#" 0) in
              if v_6
              then (
                let v__0 := v_3 in
                (Some (v__0, st)))
              else (
                let v__0 := (mkPtr "null" 0) in
                (Some (v__0, st))));
          (Some (v__0, st))));
    let __return__ := true in
    let __retval__ := v__0 in
    (Some (__retval__, st)).

End Layer5_find_lock_granule_LowSpec.

#[global] Hint Unfold find_lock_granule_spec_low: spec.
