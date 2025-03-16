Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2_addr_to_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_to_idx_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    rely ((((v_0 >= (MEM0_PHYS)) /\ ((v_0 < ((MEM0_PHYS + (MEM0_SIZE)))))) \/ (((v_0 >= (MEM1_PHYS)) /\ ((v_0 < ((MEM1_PHYS + (MEM1_SIZE)))))))));
    let v_2 := (v_0 >? (551903297535)) in
    when v__0, st == (
        let v__0 := 0 in
        if v_2
        then (
          let v_4 := (v_0 + (18446743521806254080)) in
          let v_5 := (v_4 >> (12)) in
          let v_6 := (v_5 + (524288)) in
          let v__0 := v_6 in
          (Some (v__0, st)))
        else (
          let v_8 := (v_0 + (18446744071562067968)) in
          let v_9 := (v_8 >> (12)) in
          let v__0 := v_9 in
          (Some (v__0, st))));
    let __return__ := true in
    let __retval__ := v__0 in
    (Some (__retval__, st)).

End Layer2_addr_to_idx_LowSpec.

#[global] Hint Unfold addr_to_idx_spec_low: spec.
