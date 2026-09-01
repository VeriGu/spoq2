Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer1_granule_addr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_addr_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    let v_2 := (ptr_to_int v_0) in
    let v_3 := (v_2 - ((ptr_to_int (mkPtr "granules" 0)))) in
    let v_4 := (v_3 >? (8388592)) in
    when v__0, st == (
        let v__0 := 0 in
        if v_4
        then (
          let v_6 := (v_3 * (256)) in
          let v_7 := (v_6 + (549755813888)) in
          let v__0 := v_7 in
          (Some (v__0, st)))
        else (
          let v_9 := (v_3 * (256)) in
          let v_10 := (v_9 + (2147483648)) in
          let v__0 := v_10 in
          (Some (v__0, st))));
    let __return__ := true in
    let __retval__ := v__0 in
    (Some (__retval__, st)).

End Layer1_granule_addr_LowSpec.

#[global] Hint Unfold granule_addr_spec_low: spec.
