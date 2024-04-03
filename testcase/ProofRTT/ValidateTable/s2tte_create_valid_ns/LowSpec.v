Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateTable_s2tte_create_valid_ns_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_create_valid_ns_spec_low (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    let v_cmp := (v_level =? (3)) in
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_cmp
        then (
          let v_or := (v_s2tte |' (54043195528446979)) in
          let v_retval_0 := v_or in
          (Some (v_retval_0, st)))
        else (
          let v_or1 := (v_s2tte |' (54043195528446977)) in
          let v_retval_0 := v_or1 in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End ValidateTable_s2tte_create_valid_ns_LowSpec.

#[global] Hint Unfold s2tte_create_valid_ns_spec_low: spec.
